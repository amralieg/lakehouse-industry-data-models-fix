-- Cross-Domain Foreign Keys for Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:37
-- Total cross-domain FK constraints: 1342
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: cardholder, compliance, dispute, fraud, fx, gateway, interchange, ledger, merchant, network, partner, product, reference, risk, settlement, terminal, transaction, workforce

-- ========= cardholder --> dispute (2 constraint(s)) =========
-- Requires: cardholder schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`contact_event` ADD CONSTRAINT `fk_cardholder_contact_event_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`contact_event` ADD CONSTRAINT `fk_cardholder_contact_event_dispute_dispute_case_id` FOREIGN KEY (`dispute_dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= cardholder --> fraud (4 constraint(s)) =========
-- Requires: cardholder schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_watchlist_id` FOREIGN KEY (`watchlist_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`watchlist`(`watchlist_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ADD CONSTRAINT `fk_cardholder_device_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);

-- ========= cardholder --> fx (2 constraint(s)) =========
-- Requires: cardholder schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_rate_margin_config_id` FOREIGN KEY (`rate_margin_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_margin_config`(`rate_margin_config_id`);

-- ========= cardholder --> ledger (3 constraint(s)) =========
-- Requires: cardholder schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`corporate_cardholder` ADD CONSTRAINT `fk_cardholder_corporate_cardholder_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= cardholder --> merchant (2 constraint(s)) =========
-- Requires: cardholder schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ADD CONSTRAINT `fk_cardholder_cardholder_kyc_verification_document_id` FOREIGN KEY (`document_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`document`(`document_id`);

-- ========= cardholder --> network (2 constraint(s)) =========
-- Requires: cardholder schema, network schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= cardholder --> partner (5 constraint(s)) =========
-- Requires: cardholder schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ADD CONSTRAINT `fk_cardholder_account_holder_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ADD CONSTRAINT `fk_cardholder_consent_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ADD CONSTRAINT `fk_cardholder_linked_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= cardholder --> product (3 constraint(s)) =========
-- Requires: cardholder schema, product schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`program_enrollment` ADD CONSTRAINT `fk_cardholder_program_enrollment_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);

-- ========= cardholder --> reference (10 constraint(s)) =========
-- Requires: cardholder schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ADD CONSTRAINT `fk_cardholder_account_holder_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ADD CONSTRAINT `fk_cardholder_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ADD CONSTRAINT `fk_cardholder_cardholder_kyc_verification_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ADD CONSTRAINT `fk_cardholder_consent_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`contact_event` ADD CONSTRAINT `fk_cardholder_contact_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ADD CONSTRAINT `fk_cardholder_linked_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);

-- ========= cardholder --> risk (2 constraint(s)) =========
-- Requires: cardholder schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ADD CONSTRAINT `fk_cardholder_segment_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ADD CONSTRAINT `fk_cardholder_segment_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);

-- ========= cardholder --> settlement (1 constraint(s)) =========
-- Requires: cardholder schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);

-- ========= cardholder --> terminal (2 constraint(s)) =========
-- Requires: cardholder schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ADD CONSTRAINT `fk_cardholder_payment_credential_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);

-- ========= cardholder --> transaction (1 constraint(s)) =========
-- Requires: cardholder schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= cardholder --> workforce (6 constraint(s)) =========
-- Requires: cardholder schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ADD CONSTRAINT `fk_cardholder_kyc_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ADD CONSTRAINT `fk_cardholder_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`contact_event` ADD CONSTRAINT `fk_cardholder_contact_event_agent_employee_id` FOREIGN KEY (`agent_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`contact_event` ADD CONSTRAINT `fk_cardholder_contact_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> cardholder (5 constraint(s)) =========
-- Requires: compliance schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ADD CONSTRAINT `fk_compliance_gdpr_data_subject_request_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_consent_id` FOREIGN KEY (`consent_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`consent`(`consent_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ADD CONSTRAINT `fk_compliance_sca_exemption_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ADD CONSTRAINT `fk_compliance_sca_exemption_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);

-- ========= compliance --> gateway (3 constraint(s)) =========
-- Requires: compliance schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ADD CONSTRAINT `fk_compliance_compliance_aml_screening_result_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);

-- ========= compliance --> ledger (4 constraint(s)) =========
-- Requires: compliance schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ADD CONSTRAINT `fk_compliance_str_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> merchant (5 constraint(s)) =========
-- Requires: compliance schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ADD CONSTRAINT `fk_compliance_pci_dss_audit_document_id` FOREIGN KEY (`document_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`document`(`document_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ADD CONSTRAINT `fk_compliance_sca_exemption_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_document_id` FOREIGN KEY (`document_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`document`(`document_id`);

-- ========= compliance --> partner (3 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ADD CONSTRAINT `fk_compliance_compliance_aml_screening_result_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= compliance --> product (5 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ADD CONSTRAINT `fk_compliance_str_filing_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= compliance --> reference (18 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ADD CONSTRAINT `fk_compliance_compliance_aml_screening_result_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ADD CONSTRAINT `fk_compliance_str_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ADD CONSTRAINT `fk_compliance_str_filing_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_kyc_document_type_id` FOREIGN KEY (`kyc_document_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`kyc_document_type`(`kyc_document_type_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ADD CONSTRAINT `fk_compliance_ctf_control_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ADD CONSTRAINT `fk_compliance_psd2_incident_report_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ADD CONSTRAINT `fk_compliance_watchlist_entry_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);

-- ========= compliance --> risk (1 constraint(s)) =========
-- Requires: compliance schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_risk_case_id` FOREIGN KEY (`risk_case_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_case`(`risk_case_id`);

-- ========= compliance --> settlement (1 constraint(s)) =========
-- Requires: compliance schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);

-- ========= compliance --> terminal (9 constraint(s)) =========
-- Requires: compliance schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ADD CONSTRAINT `fk_compliance_compliance_aml_screening_result_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ADD CONSTRAINT `fk_compliance_pci_dss_audit_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ADD CONSTRAINT `fk_compliance_psd2_incident_report_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ADD CONSTRAINT `fk_compliance_psd2_incident_report_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ADD CONSTRAINT `fk_compliance_case_transaction_link_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);

-- ========= compliance --> transaction (3 constraint(s)) =========
-- Requires: compliance schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ADD CONSTRAINT `fk_compliance_sca_exemption_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= compliance --> workforce (26 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ADD CONSTRAINT `fk_compliance_compliance_aml_screening_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_filing_officer_employee_id` FOREIGN KEY (`filing_officer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ADD CONSTRAINT `fk_compliance_gdpr_data_subject_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ADD CONSTRAINT `fk_compliance_gdpr_data_subject_request_requestor_employee_id` FOREIGN KEY (`requestor_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_assigned_officer_employee_id` FOREIGN KEY (`assigned_officer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ADD CONSTRAINT `fk_compliance_psd2_incident_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ADD CONSTRAINT `fk_compliance_sca_exemption_compliance_officer_employee_id` FOREIGN KEY (`compliance_officer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ADD CONSTRAINT `fk_compliance_sca_exemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_compliance_officer_employee_id` FOREIGN KEY (`compliance_officer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_primary_training_employee_id` FOREIGN KEY (`primary_training_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_compliance_officer_employee_id` FOREIGN KEY (`compliance_officer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_primary_remediation_employee_id` FOREIGN KEY (`primary_remediation_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= dispute --> cardholder (3 constraint(s)) =========
-- Requires: dispute schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);

-- ========= dispute --> compliance (3 constraint(s)) =========
-- Requires: dispute schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_compliance_aml_screening_result_id` FOREIGN KEY (`compliance_aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result`(`compliance_aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_compliance_kyc_verification_id` FOREIGN KEY (`compliance_kyc_verification_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification`(`compliance_kyc_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= dispute --> fx (5 constraint(s)) =========
-- Requires: dispute schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= dispute --> gateway (3 constraint(s)) =========
-- Requires: dispute schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);

-- ========= dispute --> ledger (4 constraint(s)) =========
-- Requires: dispute schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= dispute --> merchant (11 constraint(s)) =========
-- Requires: dispute schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_compliance_case` ADD CONSTRAINT `fk_dispute_dispute_compliance_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_notification` ADD CONSTRAINT `fk_dispute_dispute_notification_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= dispute --> network (16 constraint(s)) =========
-- Requires: dispute schema, network schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_lifecycle_event` ADD CONSTRAINT `fk_dispute_dispute_lifecycle_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`rule_config` ADD CONSTRAINT `fk_dispute_rule_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_compliance_case` ADD CONSTRAINT `fk_dispute_dispute_compliance_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_notification` ADD CONSTRAINT `fk_dispute_dispute_notification_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);

-- ========= dispute --> partner (5 constraint(s)) =========
-- Requires: dispute schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= dispute --> product (5 constraint(s)) =========
-- Requires: dispute schema, product schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= dispute --> reference (21 constraint(s)) =========
-- Requires: dispute schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_chargeback_reason_code_id` FOREIGN KEY (`chargeback_reason_code_id`) REFERENCES `payments_fintech_ecm`.`reference`.`chargeback_reason_code`(`chargeback_reason_code_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_chargeback_reason_code_id` FOREIGN KEY (`chargeback_reason_code_id`) REFERENCES `payments_fintech_ecm`.`reference`.`chargeback_reason_code`(`chargeback_reason_code_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_lifecycle_event` ADD CONSTRAINT `fk_dispute_dispute_lifecycle_event_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_lifecycle_event` ADD CONSTRAINT `fk_dispute_dispute_lifecycle_event_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`rule_config` ADD CONSTRAINT `fk_dispute_rule_config_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_compliance_case` ADD CONSTRAINT `fk_dispute_dispute_compliance_case_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_notification` ADD CONSTRAINT `fk_dispute_dispute_notification_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);

-- ========= dispute --> settlement (1 constraint(s)) =========
-- Requires: dispute schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);

-- ========= dispute --> terminal (6 constraint(s)) =========
-- Requires: dispute schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);

-- ========= dispute --> transaction (12 constraint(s)) =========
-- Requires: dispute schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_lifecycle_event` ADD CONSTRAINT `fk_dispute_dispute_lifecycle_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= dispute --> workforce (16 constraint(s)) =========
-- Requires: dispute schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_assigned_analyst_employee_id` FOREIGN KEY (`assigned_analyst_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_assigned_analyst_employee_id` FOREIGN KEY (`assigned_analyst_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_analyst_employee_id` FOREIGN KEY (`analyst_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_lifecycle_event` ADD CONSTRAINT `fk_dispute_dispute_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_assigned_analyst_employee_id` FOREIGN KEY (`assigned_analyst_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_compliance_case` ADD CONSTRAINT `fk_dispute_dispute_compliance_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_assigned_agent_employee_id` FOREIGN KEY (`assigned_agent_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= fraud --> cardholder (13 constraint(s)) =========
-- Requires: fraud schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_related_cardholder_profile_id` FOREIGN KEY (`related_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ADD CONSTRAINT `fk_fraud_audit_trail_authentication_session_id` FOREIGN KEY (`authentication_session_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`authentication_session`(`authentication_session_id`);

-- ========= fraud --> compliance (6 constraint(s)) =========
-- Requires: fraud schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_regulatory_report_regulatory_filing_id` FOREIGN KEY (`regulatory_report_regulatory_filing_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_compliance_aml_screening_result_id` FOREIGN KEY (`compliance_aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result`(`compliance_aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ADD CONSTRAINT `fk_fraud_watchlist_watchlist_entry_id` FOREIGN KEY (`watchlist_entry_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`watchlist_entry`(`watchlist_entry_id`);

-- ========= fraud --> dispute (6 constraint(s)) =========
-- Requires: fraud schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_notification_template_id` FOREIGN KEY (`notification_template_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`notification_template`(`notification_template_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ADD CONSTRAINT `fk_fraud_fraud_notification_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= fraud --> fx (8 constraint(s)) =========
-- Requires: fraud schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_rate_margin_config_id` FOREIGN KEY (`rate_margin_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_margin_config`(`rate_margin_config_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ADD CONSTRAINT `fk_fraud_rule_test_rate_snapshot_id` FOREIGN KEY (`rate_snapshot_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_snapshot`(`rate_snapshot_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ADD CONSTRAINT `fk_fraud_case_payment_link_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);

-- ========= fraud --> gateway (7 constraint(s)) =========
-- Requires: fraud schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_gateway3ds_authentication_id` FOREIGN KEY (`gateway3ds_authentication_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication`(`gateway3ds_authentication_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ADD CONSTRAINT `fk_fraud_audit_trail_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);

-- ========= fraud --> interchange (2 constraint(s)) =========
-- Requires: fraud schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_billing_id` FOREIGN KEY (`billing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`billing`(`billing_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`qualification`(`qualification_id`);

-- ========= fraud --> ledger (4 constraint(s)) =========
-- Requires: fraud schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ADD CONSTRAINT `fk_fraud_loss_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= fraud --> merchant (6 constraint(s)) =========
-- Requires: fraud schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= fraud --> network (3 constraint(s)) =========
-- Requires: fraud schema, network schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= fraud --> partner (5 constraint(s)) =========
-- Requires: fraud schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ADD CONSTRAINT `fk_fraud_fraud_notification_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= fraud --> product (7 constraint(s)) =========
-- Requires: fraud schema, product schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ADD CONSTRAINT `fk_fraud_fraud_notification_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= fraud --> reference (12 constraint(s)) =========
-- Requires: fraud schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_wallet_scheme_id` FOREIGN KEY (`wallet_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`wallet_scheme`(`wallet_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ADD CONSTRAINT `fk_fraud_device_fingerprint_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ADD CONSTRAINT `fk_fraud_case_status_history_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);

-- ========= fraud --> risk (3 constraint(s)) =========
-- Requires: fraud schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);

-- ========= fraud --> terminal (7 constraint(s)) =========
-- Requires: fraud schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);

-- ========= fraud --> transaction (11 constraint(s)) =========
-- Requires: fraud schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_tertiary_auth_acs_transaction_id` FOREIGN KEY (`tertiary_auth_acs_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_evidence_transaction_id` FOREIGN KEY (`evidence_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= fraud --> workforce (20 constraint(s)) =========
-- Requires: fraud schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_assigned_investigator_employee_id` FOREIGN KEY (`assigned_investigator_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_assigned_user_employee_id` FOREIGN KEY (`assigned_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_primary_fraud_employee_id` FOREIGN KEY (`primary_fraud_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_tertiary_fraud_updated_by_user_employee_id` FOREIGN KEY (`tertiary_fraud_updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_primary_fraud_employee_id` FOREIGN KEY (`primary_fraud_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_investigation_assigned_investigator_employee_id` FOREIGN KEY (`investigation_assigned_investigator_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_investigation_employee_id` FOREIGN KEY (`investigation_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ADD CONSTRAINT `fk_fraud_rule_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ADD CONSTRAINT `fk_fraud_audit_trail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= fx --> cardholder (9 constraint(s)) =========
-- Requires: fx schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_reconciliation` ADD CONSTRAINT `fk_fx_fx_reconciliation_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_reconciliation` ADD CONSTRAINT `fk_fx_fx_reconciliation_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`psd2_fx_disclosure` ADD CONSTRAINT `fk_fx_psd2_fx_disclosure_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`psd2_fx_disclosure` ADD CONSTRAINT `fk_fx_psd2_fx_disclosure_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);

-- ========= fx --> compliance (3 constraint(s)) =========
-- Requires: fx schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ADD CONSTRAINT `fk_fx_fx_fee_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`regulatory_reporting_req` ADD CONSTRAINT `fk_fx_regulatory_reporting_req_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= fx --> gateway (2 constraint(s)) =========
-- Requires: fx schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ADD CONSTRAINT `fk_fx_rate_feed_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);

-- ========= fx --> merchant (5 constraint(s)) =========
-- Requires: fx schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_reconciliation` ADD CONSTRAINT `fk_fx_fx_reconciliation_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`psd2_fx_disclosure` ADD CONSTRAINT `fk_fx_psd2_fx_disclosure_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair_enrollment` ADD CONSTRAINT `fk_fx_currency_pair_enrollment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= fx --> network (2 constraint(s)) =========
-- Requires: fx schema, network schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= fx --> product (6 constraint(s)) =========
-- Requires: fx schema, product schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ADD CONSTRAINT `fk_fx_exposure_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ADD CONSTRAINT `fk_fx_exposure_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `payments_fintech_ecm`.`product`.`limit`(`limit_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`regulatory_reporting_req` ADD CONSTRAINT `fk_fx_regulatory_reporting_req_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= fx --> reference (17 constraint(s)) =========
-- Requires: fx schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate` ADD CONSTRAINT `fk_fx_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ADD CONSTRAINT `fk_fx_currency_pair_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`correspondent_bank` ADD CONSTRAINT `fk_fx_correspondent_bank_swift_bic_id` FOREIGN KEY (`swift_bic_id`) REFERENCES `payments_fintech_ecm`.`reference`.`swift_bic`(`swift_bic_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ADD CONSTRAINT `fk_fx_nostro_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`swift_message` ADD CONSTRAINT `fk_fx_swift_message_swift_bic_id` FOREIGN KEY (`swift_bic_id`) REFERENCES `payments_fintech_ecm`.`reference`.`swift_bic`(`swift_bic_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`iban_routing` ADD CONSTRAINT `fk_fx_iban_routing_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`iban_routing` ADD CONSTRAINT `fk_fx_iban_routing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ADD CONSTRAINT `fk_fx_beneficiary_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ADD CONSTRAINT `fk_fx_beneficiary_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`liquidity_position` ADD CONSTRAINT `fk_fx_liquidity_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`swift_gpi_tracker` ADD CONSTRAINT `fk_fx_swift_gpi_tracker_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`psd2_fx_disclosure` ADD CONSTRAINT `fk_fx_psd2_fx_disclosure_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);

-- ========= fx --> settlement (3 constraint(s)) =========
-- Requires: fx schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);

-- ========= fx --> terminal (2 constraint(s)) =========
-- Requires: fx schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);

-- ========= fx --> transaction (8 constraint(s)) =========
-- Requires: fx schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`conversion_audit` ADD CONSTRAINT `fk_fx_conversion_audit_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`swift_message` ADD CONSTRAINT `fk_fx_swift_message_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`sanctions_screening_result` ADD CONSTRAINT `fk_fx_sanctions_screening_result_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`sanctions_screening_result` ADD CONSTRAINT `fk_fx_sanctions_screening_result_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_fee` ADD CONSTRAINT `fk_fx_cross_border_fee_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_reconciliation` ADD CONSTRAINT `fk_fx_fx_reconciliation_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);

-- ========= fx --> workforce (12 constraint(s)) =========
-- Requires: fx schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_feed` ADD CONSTRAINT `fk_fx_rate_feed_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`currency_pair` ADD CONSTRAINT `fk_fx_currency_pair_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ADD CONSTRAINT `fk_fx_exposure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ADD CONSTRAINT `fk_fx_rate_margin_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ADD CONSTRAINT `fk_fx_rate_margin_config_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ADD CONSTRAINT `fk_fx_rate_margin_config_primary_rate_employee_id` FOREIGN KEY (`primary_rate_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`sanctions_screening_result` ADD CONSTRAINT `fk_fx_sanctions_screening_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`regulatory_reporting_req` ADD CONSTRAINT `fk_fx_regulatory_reporting_req_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`regulatory_reporting_req` ADD CONSTRAINT `fk_fx_regulatory_reporting_req_internal_owner_user_employee_id` FOREIGN KEY (`internal_owner_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_reconciliation` ADD CONSTRAINT `fk_fx_fx_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`liquidity_position` ADD CONSTRAINT `fk_fx_liquidity_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= gateway --> cardholder (6 constraint(s)) =========
-- Requires: gateway schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ADD CONSTRAINT `fk_gateway_gateway3ds_authentication_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ADD CONSTRAINT `fk_gateway_gateway3ds_authentication_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ADD CONSTRAINT `fk_gateway_tokenization_request_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ADD CONSTRAINT `fk_gateway_tokenization_request_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);

-- ========= gateway --> fraud (1 constraint(s)) =========
-- Requires: gateway schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);

-- ========= gateway --> fx (3 constraint(s)) =========
-- Requires: gateway schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= gateway --> interchange (1 constraint(s)) =========
-- Requires: gateway schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);

-- ========= gateway --> ledger (2 constraint(s)) =========
-- Requires: gateway schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= gateway --> merchant (11 constraint(s)) =========
-- Requires: gateway schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_application_id` FOREIGN KEY (`application_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`application`(`application_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ADD CONSTRAINT `fk_gateway_gateway3ds_authentication_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ADD CONSTRAINT `fk_gateway_tokenization_request_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= gateway --> network (3 constraint(s)) =========
-- Requires: gateway schema, network schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_network_scheme_id` FOREIGN KEY (`network_scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= gateway --> partner (8 constraint(s)) =========
-- Requires: gateway schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ADD CONSTRAINT `fk_gateway_rate_limit_policy_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ADD CONSTRAINT `fk_gateway_event_log_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= gateway --> product (4 constraint(s)) =========
-- Requires: gateway schema, product schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= gateway --> reference (12 constraint(s)) =========
-- Requires: gateway schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ADD CONSTRAINT `fk_gateway_region_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);

-- ========= gateway --> terminal (8 constraint(s)) =========
-- Requires: gateway schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_contactless_profile_id` FOREIGN KEY (`contactless_profile_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`contactless_profile`(`contactless_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_wallet_transaction_id` FOREIGN KEY (`wallet_transaction_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_transaction`(`wallet_transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ADD CONSTRAINT `fk_gateway_tokenization_request_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);

-- ========= gateway --> transaction (2 constraint(s)) =========
-- Requires: gateway schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ADD CONSTRAINT `fk_gateway_gateway3ds_authentication_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= gateway --> workforce (6 constraint(s)) =========
-- Requires: gateway schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ADD CONSTRAINT `fk_gateway_rate_limit_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ADD CONSTRAINT `fk_gateway_event_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= interchange --> compliance (4 constraint(s)) =========
-- Requires: interchange schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ADD CONSTRAINT `fk_interchange_rate_history_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ADD CONSTRAINT `fk_interchange_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);

-- ========= interchange --> dispute (4 constraint(s)) =========
-- Requires: interchange schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= interchange --> fx (6 constraint(s)) =========
-- Requires: interchange schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ADD CONSTRAINT `fk_interchange_rate_history_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program_fee_schedule_assignment` ADD CONSTRAINT `fk_interchange_program_fee_schedule_assignment_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);

-- ========= interchange --> ledger (10 constraint(s)) =========
-- Requires: interchange schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);

-- ========= interchange --> merchant (11 constraint(s)) =========
-- Requires: interchange schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ADD CONSTRAINT `fk_interchange_acquiring_portfolio_pricing_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`portfolio`(`portfolio_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ADD CONSTRAINT `fk_interchange_payfac_sub_merchant_pricing_payment_facilitator_id` FOREIGN KEY (`payment_facilitator_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`payment_facilitator`(`payment_facilitator_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ADD CONSTRAINT `fk_interchange_payfac_sub_merchant_pricing_sub_merchant_id` FOREIGN KEY (`sub_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`sub_merchant`(`sub_merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`portfolio`(`portfolio_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= interchange --> network (8 constraint(s)) =========
-- Requires: interchange schema, network schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ADD CONSTRAINT `fk_interchange_irf_rate_category_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`rate_history` ADD CONSTRAINT `fk_interchange_rate_history_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ADD CONSTRAINT `fk_interchange_mcc_interchange_map_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ADD CONSTRAINT `fk_interchange_acquiring_portfolio_pricing_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= interchange --> partner (7 constraint(s)) =========
-- Requires: interchange schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= interchange --> reference (18 constraint(s)) =========
-- Requires: interchange schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ADD CONSTRAINT `fk_interchange_scheme_fee_table_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_financial_institution_id` FOREIGN KEY (`financial_institution_id`) REFERENCES `payments_fintech_ecm`.`reference`.`financial_institution`(`financial_institution_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mcc_interchange_map` ADD CONSTRAINT `fk_interchange_mcc_interchange_map_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`issuer_interchange_income` ADD CONSTRAINT `fk_interchange_issuer_interchange_income_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `payments_fintech_ecm`.`reference`.`issuer`(`issuer_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `payments_fintech_ecm`.`reference`.`issuer`(`issuer_id`);

-- ========= interchange --> risk (3 constraint(s)) =========
-- Requires: interchange schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_risk_case_id` FOREIGN KEY (`risk_case_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_case`(`risk_case_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`acquiring_portfolio_pricing` ADD CONSTRAINT `fk_interchange_acquiring_portfolio_pricing_appetite_framework_id` FOREIGN KEY (`appetite_framework_id`) REFERENCES `payments_fintech_ecm`.`risk`.`appetite_framework`(`appetite_framework_id`);

-- ========= interchange --> settlement (8 constraint(s)) =========
-- Requires: interchange schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`revenue_recognition_entry` ADD CONSTRAINT `fk_interchange_revenue_recognition_entry_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_issuing_bank_id` FOREIGN KEY (`issuing_bank_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`issuing_bank`(`issuing_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_issuing_bank_id` FOREIGN KEY (`issuing_bank_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`issuing_bank`(`issuing_bank_id`);

-- ========= interchange --> transaction (3 constraint(s)) =========
-- Requires: interchange schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_dispute` ADD CONSTRAINT `fk_interchange_interchange_dispute_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= interchange --> workforce (19 constraint(s)) =========
-- Requires: interchange schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_primary_mdr_employee_id` FOREIGN KEY (`primary_mdr_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_tertiary_mdr_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_mdr_last_modified_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice_line` ADD CONSTRAINT `fk_interchange_scheme_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`interchange_reconciliation` ADD CONSTRAINT `fk_interchange_interchange_reconciliation_primary_interchange_employee_id` FOREIGN KEY (`primary_interchange_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ADD CONSTRAINT `fk_interchange_payfac_sub_merchant_pricing_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`payfac_sub_merchant_pricing` ADD CONSTRAINT `fk_interchange_payfac_sub_merchant_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ADD CONSTRAINT `fk_interchange_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= ledger --> cardholder (4 constraint(s)) =========
-- Requires: ledger schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accrual_entry` ADD CONSTRAINT `fk_ledger_accrual_entry_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`segment`(`segment_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ADD CONSTRAINT `fk_ledger_audit_trail_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);

-- ========= ledger --> fraud (1 constraint(s)) =========
-- Requires: ledger schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_audit_trail_id` FOREIGN KEY (`audit_trail_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`audit_trail`(`audit_trail_id`);

-- ========= ledger --> fx (2 constraint(s)) =========
-- Requires: ledger schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= ledger --> gateway (1 constraint(s)) =========
-- Requires: ledger schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ADD CONSTRAINT `fk_ledger_audit_trail_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);

-- ========= ledger --> merchant (2 constraint(s)) =========
-- Requires: ledger schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= ledger --> partner (1 constraint(s)) =========
-- Requires: ledger schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= ledger --> product (1 constraint(s)) =========
-- Requires: ledger schema, product schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ADD CONSTRAINT `fk_ledger_revenue_line_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);

-- ========= ledger --> reference (23 constraint(s)) =========
-- Requires: ledger schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`gl_balance` ADD CONSTRAINT `fk_ledger_gl_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`ledger_config` ADD CONSTRAINT `fk_ledger_ledger_config_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fixed_asset` ADD CONSTRAINT `fk_ledger_fixed_asset_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`depreciation_schedule` ADD CONSTRAINT `fk_ledger_depreciation_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`fx_revaluation` ADD CONSTRAINT `fk_ledger_fx_revaluation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_entry` ADD CONSTRAINT `fk_ledger_consolidation_entry_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`consolidation_group` ADD CONSTRAINT `fk_ledger_consolidation_group_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_line` ADD CONSTRAINT `fk_ledger_revenue_line_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);

-- ========= ledger --> settlement (1 constraint(s)) =========
-- Requires: ledger schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);

-- ========= ledger --> terminal (2 constraint(s)) =========
-- Requires: ledger schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);

-- ========= ledger --> transaction (6 constraint(s)) =========
-- Requires: ledger schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ADD CONSTRAINT `fk_ledger_audit_trail_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= ledger --> workforce (19 constraint(s)) =========
-- Requires: ledger schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_approver_id` FOREIGN KEY (`approver_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_primary_revenue_employee_id` FOREIGN KEY (`primary_revenue_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ADD CONSTRAINT `fk_ledger_period_close_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`period_close_task` ADD CONSTRAINT `fk_ledger_period_close_task_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`budget` ADD CONSTRAINT `fk_ledger_budget_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`financial_statement` ADD CONSTRAINT `fk_ledger_financial_statement_primary_financial_employee_id` FOREIGN KEY (`primary_financial_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`audit_trail` ADD CONSTRAINT `fk_ledger_audit_trail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` ADD CONSTRAINT `fk_ledger_contract_contract_manager_employee_id` FOREIGN KEY (`contract_manager_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`contract` ADD CONSTRAINT `fk_ledger_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= merchant --> cardholder (1 constraint(s)) =========
-- Requires: merchant schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);

-- ========= merchant --> compliance (5 constraint(s)) =========
-- Requires: merchant schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ADD CONSTRAINT `fk_merchant_kyb_verification_compliance_kyc_verification_id` FOREIGN KEY (`compliance_kyc_verification_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification`(`compliance_kyc_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_control_id` FOREIGN KEY (`control_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_control_id` FOREIGN KEY (`control_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`note` ADD CONSTRAINT `fk_merchant_note_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);

-- ========= merchant --> dispute (1 constraint(s)) =========
-- Requires: merchant schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`note` ADD CONSTRAINT `fk_merchant_note_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= merchant --> gateway (2 constraint(s)) =========
-- Requires: merchant schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);

-- ========= merchant --> interchange (3 constraint(s)) =========
-- Requires: merchant schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);

-- ========= merchant --> ledger (3 constraint(s)) =========
-- Requires: merchant schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= merchant --> network (1 constraint(s)) =========
-- Requires: merchant schema, network schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);

-- ========= merchant --> partner (3 constraint(s)) =========
-- Requires: merchant schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= merchant --> reference (14 constraint(s)) =========
-- Requires: merchant schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_location` ADD CONSTRAINT `fk_merchant_merchant_location_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_location` ADD CONSTRAINT `fk_merchant_merchant_location_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ADD CONSTRAINT `fk_merchant_merchant_pricing_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`status_history` ADD CONSTRAINT `fk_merchant_status_history_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_risk_profile` ADD CONSTRAINT `fk_merchant_merchant_risk_profile_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`chargeback_threshold` ADD CONSTRAINT `fk_merchant_chargeback_threshold_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`boarding_event` ADD CONSTRAINT `fk_merchant_boarding_event_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`scheme_registration` ADD CONSTRAINT `fk_merchant_scheme_registration_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`scheme_registration` ADD CONSTRAINT `fk_merchant_scheme_registration_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);

-- ========= merchant --> risk (4 constraint(s)) =========
-- Requires: merchant schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_risk_profile` ADD CONSTRAINT `fk_merchant_merchant_risk_profile_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_rule_override` ADD CONSTRAINT `fk_merchant_risk_rule_override_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);

-- ========= merchant --> settlement (2 constraint(s)) =========
-- Requires: merchant schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`portfolio` ADD CONSTRAINT `fk_merchant_portfolio_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);

-- ========= merchant --> terminal (1 constraint(s)) =========
-- Requires: merchant schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`terminal_assignment` ADD CONSTRAINT `fk_merchant_terminal_assignment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);

-- ========= merchant --> transaction (5 constraint(s)) =========
-- Requires: merchant schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`status_history` ADD CONSTRAINT `fk_merchant_status_history_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`status_history` ADD CONSTRAINT `fk_merchant_status_history_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`note` ADD CONSTRAINT `fk_merchant_note_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`note` ADD CONSTRAINT `fk_merchant_note_note_transaction_id` FOREIGN KEY (`note_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`boarding_event` ADD CONSTRAINT `fk_merchant_boarding_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= merchant --> workforce (17 constraint(s)) =========
-- Requires: merchant schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_assigned_underwriter_employee_id` FOREIGN KEY (`assigned_underwriter_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ADD CONSTRAINT `fk_merchant_kyb_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ADD CONSTRAINT `fk_merchant_kyb_verification_reviewer_user_employee_id` FOREIGN KEY (`reviewer_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_primary_mcc_employee_id` FOREIGN KEY (`primary_mcc_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_tertiary_mcc_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_mcc_last_modified_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`status_history` ADD CONSTRAINT `fk_merchant_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`status_history` ADD CONSTRAINT `fk_merchant_status_history_initiating_actor_employee_id` FOREIGN KEY (`initiating_actor_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_risk_profile` ADD CONSTRAINT `fk_merchant_merchant_risk_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_risk_profile` ADD CONSTRAINT `fk_merchant_merchant_risk_profile_risk_review_user_employee_id` FOREIGN KEY (`risk_review_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`note` ADD CONSTRAINT `fk_merchant_note_author_employee_id` FOREIGN KEY (`author_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`note` ADD CONSTRAINT `fk_merchant_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`boarding_event` ADD CONSTRAINT `fk_merchant_boarding_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= network --> compliance (4 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_compliance_aml_screening_result_id` FOREIGN KEY (`compliance_aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result`(`compliance_aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ADD CONSTRAINT `fk_network_scheme_obligation_mapping_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= network --> fraud (1 constraint(s)) =========
-- Requires: network schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);

-- ========= network --> fx (3 constraint(s)) =========
-- Requires: network schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ADD CONSTRAINT `fk_network_cutover_regulatory_reporting_req_id` FOREIGN KEY (`regulatory_reporting_req_id`) REFERENCES `payments_fintech_ecm`.`fx`.`regulatory_reporting_req`(`regulatory_reporting_req_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ADD CONSTRAINT `fk_network_dcc_pricing_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= network --> gateway (4 constraint(s)) =========
-- Requires: network schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_tls_certificate_id` FOREIGN KEY (`tls_certificate_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`tls_certificate`(`tls_certificate_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);

-- ========= network --> ledger (4 constraint(s)) =========
-- Requires: network schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ADD CONSTRAINT `fk_network_connectivity_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ADD CONSTRAINT `fk_network_scheme_compliance_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= network --> merchant (1 constraint(s)) =========
-- Requires: network schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ADD CONSTRAINT `fk_network_scheme_compliance_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`document`(`document_id`);

-- ========= network --> partner (3 constraint(s)) =========
-- Requires: network schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ADD CONSTRAINT `fk_network_cutover_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= network --> reference (9 constraint(s)) =========
-- Requires: network schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ADD CONSTRAINT `fk_network_scheme_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_timezone_id` FOREIGN KEY (`timezone_id`) REFERENCES `payments_fintech_ecm`.`reference`.`timezone`(`timezone_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ADD CONSTRAINT `fk_network_scheme_parameter_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ADD CONSTRAINT `fk_network_scheme_parameter_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ADD CONSTRAINT `fk_network_emv_parameter_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ADD CONSTRAINT `fk_network_regulatory_coverage_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);

-- ========= network --> terminal (2 constraint(s)) =========
-- Requires: network schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ADD CONSTRAINT `fk_network_scheme_certification_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);

-- ========= network --> transaction (2 constraint(s)) =========
-- Requires: network schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= network --> workforce (6 constraint(s)) =========
-- Requires: network schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ADD CONSTRAINT `fk_network_connectivity_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ADD CONSTRAINT `fk_network_failover_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ADD CONSTRAINT `fk_network_cutover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= partner --> cardholder (1 constraint(s)) =========
-- Requires: partner schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ADD CONSTRAINT `fk_partner_referral_record_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);

-- ========= partner --> fx (5 constraint(s)) =========
-- Requires: partner schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ADD CONSTRAINT `fk_partner_partner_fee_schedule_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ADD CONSTRAINT `fk_partner_sub_merchant_registration_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= partner --> ledger (8 constraint(s)) =========
-- Requires: partner schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ADD CONSTRAINT `fk_partner_partner_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= partner --> merchant (1 constraint(s)) =========
-- Requires: partner schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ADD CONSTRAINT `fk_partner_referral_record_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= partner --> network (3 constraint(s)) =========
-- Requires: partner schema, network schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ADD CONSTRAINT `fk_partner_partner_fee_schedule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ADD CONSTRAINT `fk_partner_sub_merchant_registration_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= partner --> reference (9 constraint(s)) =========
-- Requires: partner schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ADD CONSTRAINT `fk_partner_partner_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ADD CONSTRAINT `fk_partner_partner_type_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ADD CONSTRAINT `fk_partner_partner_type_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ADD CONSTRAINT `fk_partner_rail_onboarding_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);

-- ========= partner --> workforce (17 constraint(s)) =========
-- Requires: partner schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ADD CONSTRAINT `fk_partner_onboarding_application_assigned_analyst_employee_id` FOREIGN KEY (`assigned_analyst_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ADD CONSTRAINT `fk_partner_onboarding_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ADD CONSTRAINT `fk_partner_partner_api_credential_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ADD CONSTRAINT `fk_partner_partner_api_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ADD CONSTRAINT `fk_partner_referral_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ADD CONSTRAINT `fk_partner_referral_record_primary_referral_employee_id` FOREIGN KEY (`primary_referral_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ADD CONSTRAINT `fk_partner_referral_record_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ADD CONSTRAINT `fk_partner_partner_event_actor_employee_id` FOREIGN KEY (`actor_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ADD CONSTRAINT `fk_partner_partner_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ADD CONSTRAINT `fk_partner_volume_commitment_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ADD CONSTRAINT `fk_partner_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ADD CONSTRAINT `fk_partner_partner_fee_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ADD CONSTRAINT `fk_partner_performance_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ADD CONSTRAINT `fk_partner_manager_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> cardholder (2 constraint(s)) =========
-- Requires: product schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer_redemption` ADD CONSTRAINT `fk_product_promotional_offer_redemption_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer_redemption` ADD CONSTRAINT `fk_product_promotional_offer_redemption_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);

-- ========= product --> compliance (3 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ADD CONSTRAINT `fk_product_feature_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= product --> gateway (3 constraint(s)) =========
-- Requires: product schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);

-- ========= product --> interchange (5 constraint(s)) =========
-- Requires: product schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`scheme_product_mapping` ADD CONSTRAINT `fk_product_scheme_product_mapping_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);

-- ========= product --> ledger (8 constraint(s)) =========
-- Requires: product schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer` ADD CONSTRAINT `fk_product_promotional_offer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`scheme_product_mapping` ADD CONSTRAINT `fk_product_scheme_product_mapping_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= product --> merchant (3 constraint(s)) =========
-- Requires: product schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`pricing_plan_assignment` ADD CONSTRAINT `fk_product_pricing_plan_assignment_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer_redemption` ADD CONSTRAINT `fk_product_promotional_offer_redemption_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= product --> network (4 constraint(s)) =========
-- Requires: product schema, network schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`scheme_product_mapping` ADD CONSTRAINT `fk_product_scheme_product_mapping_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= product --> partner (8 constraint(s)) =========
-- Requires: product schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer` ADD CONSTRAINT `fk_product_promotional_offer_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= product --> reference (24 constraint(s)) =========
-- Requires: product schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_settlement_cycle_id` FOREIGN KEY (`settlement_cycle_id`) REFERENCES `payments_fintech_ecm`.`reference`.`settlement_cycle`(`settlement_cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ADD CONSTRAINT `fk_product_fee_schedule_line_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer` ADD CONSTRAINT `fk_product_promotional_offer_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ADD CONSTRAINT `fk_product_version_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ADD CONSTRAINT `fk_product_rate_tier_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ADD CONSTRAINT `fk_product_feature_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`geography` ADD CONSTRAINT `fk_product_geography_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_channel` ADD CONSTRAINT `fk_product_product_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`pricing_plan_assignment` ADD CONSTRAINT `fk_product_pricing_plan_assignment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer_redemption` ADD CONSTRAINT `fk_product_promotional_offer_redemption_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ADD CONSTRAINT `fk_product_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`scheme_product_mapping` ADD CONSTRAINT `fk_product_scheme_product_mapping_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`scheme_product_mapping` ADD CONSTRAINT `fk_product_scheme_product_mapping_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);

-- ========= product --> terminal (1 constraint(s)) =========
-- Requires: product schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`product`.`terminal_authorization` ADD CONSTRAINT `fk_product_terminal_authorization_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);

-- ========= product --> transaction (1 constraint(s)) =========
-- Requires: product schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer_redemption` ADD CONSTRAINT `fk_product_promotional_offer_redemption_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= product --> workforce (8 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`promotional_offer` ADD CONSTRAINT `fk_product_promotional_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ADD CONSTRAINT `fk_product_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reference --> merchant (1 constraint(s)) =========
-- Requires: reference schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`reference`.`qr_code` ADD CONSTRAINT `fk_reference_qr_code_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= reference --> network (1 constraint(s)) =========
-- Requires: reference schema, network schema
ALTER TABLE `payments_fintech_ecm`.`reference`.`scheme_message` ADD CONSTRAINT `fk_reference_scheme_message_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= reference --> partner (1 constraint(s)) =========
-- Requires: reference schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`reference`.`issuer_wallet_config` ADD CONSTRAINT `fk_reference_issuer_wallet_config_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= risk --> cardholder (7 constraint(s)) =========
-- Requires: risk schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);

-- ========= risk --> compliance (4 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_compliance_kyc_verification_id` FOREIGN KEY (`compliance_kyc_verification_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification`(`compliance_kyc_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ADD CONSTRAINT `fk_risk_risk_model_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);

-- ========= risk --> dispute (3 constraint(s)) =========
-- Requires: risk schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_rule_config_id` FOREIGN KEY (`rule_config_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`rule_config`(`rule_config_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= risk --> fraud (2 constraint(s)) =========
-- Requires: risk schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);

-- ========= risk --> fx (6 constraint(s)) =========
-- Requires: risk schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_exposure_id` FOREIGN KEY (`exposure_id`) REFERENCES `payments_fintech_ecm`.`fx`.`exposure`(`exposure_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ADD CONSTRAINT `fk_risk_counterparty_risk_limit_forward_contract_id` FOREIGN KEY (`forward_contract_id`) REFERENCES `payments_fintech_ecm`.`fx`.`forward_contract`(`forward_contract_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ADD CONSTRAINT `fk_risk_model_currency_pair_assignment_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= risk --> gateway (4 constraint(s)) =========
-- Requires: risk schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ADD CONSTRAINT `fk_risk_risk_model_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);

-- ========= risk --> ledger (4 constraint(s)) =========
-- Requires: risk schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= risk --> merchant (4 constraint(s)) =========
-- Requires: risk schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= risk --> network (4 constraint(s)) =========
-- Requires: risk schema, network schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ADD CONSTRAINT `fk_risk_underwriting_policy_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_network_routing_rule_id` FOREIGN KEY (`network_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_routing_rule`(`network_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `payments_fintech_ecm`.`network`.`message_log`(`message_log_id`);

-- ========= risk --> partner (5 constraint(s)) =========
-- Requires: risk schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= risk --> product (7 constraint(s)) =========
-- Requires: risk schema, product schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ADD CONSTRAINT `fk_risk_rule_assignment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= risk --> reference (14 constraint(s)) =========
-- Requires: risk schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ADD CONSTRAINT `fk_risk_indicator_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ADD CONSTRAINT `fk_risk_counterparty_risk_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);

-- ========= risk --> terminal (5 constraint(s)) =========
-- Requires: risk schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);

-- ========= risk --> transaction (4 constraint(s)) =========
-- Requires: risk schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= risk --> workforce (21 constraint(s)) =========
-- Requires: risk schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ADD CONSTRAINT `fk_risk_appetite_framework_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_underwriter_employee_id` FOREIGN KEY (`underwriter_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_assessor_employee_id` FOREIGN KEY (`assessor_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_last_updated_by_employee_id` FOREIGN KEY (`last_updated_by_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_primary_risk_employee_id` FOREIGN KEY (`primary_risk_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_tertiary_risk_last_updated_by_employee_id` FOREIGN KEY (`tertiary_risk_last_updated_by_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_requestor_employee_id` FOREIGN KEY (`requestor_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ADD CONSTRAINT `fk_risk_indicator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ADD CONSTRAINT `fk_risk_indicator_owner_user_employee_id` FOREIGN KEY (`owner_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_action_owner_employee_id` FOREIGN KEY (`action_owner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ADD CONSTRAINT `fk_risk_counterparty_risk_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= settlement --> compliance (2 constraint(s)) =========
-- Requires: settlement schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_compliance_aml_screening_result_id` FOREIGN KEY (`compliance_aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result`(`compliance_aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);

-- ========= settlement --> dispute (3 constraint(s)) =========
-- Requires: settlement schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= settlement --> fraud (2 constraint(s)) =========
-- Requires: settlement schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);

-- ========= settlement --> fx (6 constraint(s)) =========
-- Requires: settlement schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ADD CONSTRAINT `fk_settlement_nostro_reconciliation_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= settlement --> gateway (4 constraint(s)) =========
-- Requires: settlement schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_event_log_id` FOREIGN KEY (`event_log_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`event_log`(`event_log_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);

-- ========= settlement --> ledger (8 constraint(s)) =========
-- Requires: settlement schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_ledger_config_id` FOREIGN KEY (`ledger_config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`ledger_config`(`ledger_config_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_account_reconciliation_id` FOREIGN KEY (`account_reconciliation_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`account_reconciliation`(`account_reconciliation_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= settlement --> merchant (8 constraint(s)) =========
-- Requires: settlement schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_merchant_settlement_account_id` FOREIGN KEY (`merchant_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_settlement_account`(`merchant_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ADD CONSTRAINT `fk_settlement_settlement_reserve_account_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ADD CONSTRAINT `fk_settlement_reserve_movement_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ADD CONSTRAINT `fk_settlement_reserve_movement_merchant_reserve_account_id` FOREIGN KEY (`merchant_reserve_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_reserve_account`(`merchant_reserve_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= settlement --> network (1 constraint(s)) =========
-- Requires: settlement schema, network schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_scheme_membership_id` FOREIGN KEY (`scheme_membership_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_membership`(`scheme_membership_id`);

-- ========= settlement --> partner (10 constraint(s)) =========
-- Requires: settlement schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ADD CONSTRAINT `fk_settlement_settlement_reserve_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= settlement --> product (5 constraint(s)) =========
-- Requires: settlement schema, product schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= settlement --> reference (23 constraint(s)) =========
-- Requires: settlement schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_payment_rail_id` FOREIGN KEY (`payment_rail_id`) REFERENCES `payments_fintech_ecm`.`reference`.`payment_rail`(`payment_rail_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_reserve_account` ADD CONSTRAINT `fk_settlement_settlement_reserve_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ADD CONSTRAINT `fk_settlement_reserve_movement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ADD CONSTRAINT `fk_settlement_file_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ADD CONSTRAINT `fk_settlement_applied_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ADD CONSTRAINT `fk_settlement_nostro_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);

-- ========= settlement --> risk (5 constraint(s)) =========
-- Requires: settlement schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_appetite_framework_id` FOREIGN KEY (`appetite_framework_id`) REFERENCES `payments_fintech_ecm`.`risk`.`appetite_framework`(`appetite_framework_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_exposure_limit_id` FOREIGN KEY (`exposure_limit_id`) REFERENCES `payments_fintech_ecm`.`risk`.`exposure_limit`(`exposure_limit_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);

-- ========= settlement --> transaction (14 constraint(s)) =========
-- Requires: settlement schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_clearing_submission_id` FOREIGN KEY (`clearing_submission_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`clearing_submission`(`clearing_submission_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_movement` ADD CONSTRAINT `fk_settlement_reserve_movement_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`interchange_settlement` ADD CONSTRAINT `fk_settlement_interchange_settlement_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`scheme_fee_settlement` ADD CONSTRAINT `fk_settlement_scheme_fee_settlement_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`file` ADD CONSTRAINT `fk_settlement_file_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`applied_rate` ADD CONSTRAINT `fk_settlement_applied_rate_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`nostro_reconciliation` ADD CONSTRAINT `fk_settlement_nostro_reconciliation_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);

-- ========= settlement --> workforce (3 constraint(s)) =========
-- Requires: settlement schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_resolved_by_user_employee_id` FOREIGN KEY (`resolved_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= terminal --> cardholder (19 constraint(s)) =========
-- Requires: terminal schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ADD CONSTRAINT `fk_terminal_card_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ADD CONSTRAINT `fk_terminal_card_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ADD CONSTRAINT `fk_terminal_token_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ADD CONSTRAINT `fk_terminal_token_fpan_holder_cardholder_profile_id` FOREIGN KEY (`fpan_holder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ADD CONSTRAINT `fk_terminal_upi_linked_account_id` FOREIGN KEY (`linked_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`linked_account`(`linked_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ADD CONSTRAINT `fk_terminal_upi_linked_linked_account_id` FOREIGN KEY (`linked_linked_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`linked_account`(`linked_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ADD CONSTRAINT `fk_terminal_card_replacement_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_replacement` ADD CONSTRAINT `fk_terminal_card_replacement_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ADD CONSTRAINT `fk_terminal_instrument_verification_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ADD CONSTRAINT `fk_terminal_instrument_verification_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_linked_account_id` FOREIGN KEY (`linked_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`linked_account`(`linked_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ADD CONSTRAINT `fk_terminal_wallet_enrollment_cardholder_cardholder_profile_id` FOREIGN KEY (`cardholder_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ADD CONSTRAINT `fk_terminal_wallet_enrollment_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_enrollment` ADD CONSTRAINT `fk_terminal_wallet_enrollment_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);

-- ========= terminal --> fx (4 constraint(s)) =========
-- Requires: terminal schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_dcc_config_id` FOREIGN KEY (`dcc_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`dcc_config`(`dcc_config_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ADD CONSTRAINT `fk_terminal_p2p_transfer_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= terminal --> gateway (2 constraint(s)) =========
-- Requires: terminal schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);

-- ========= terminal --> interchange (3 constraint(s)) =========
-- Requires: terminal schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);

-- ========= terminal --> ledger (8 constraint(s)) =========
-- Requires: terminal schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_ledger_config_id` FOREIGN KEY (`ledger_config_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`ledger_config`(`ledger_config_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ADD CONSTRAINT `fk_terminal_terminal_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= terminal --> merchant (21 constraint(s)) =========
-- Requires: terminal schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ADD CONSTRAINT `fk_terminal_instrument_verification_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ADD CONSTRAINT `fk_terminal_deployment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tid_provisioning` ADD CONSTRAINT `fk_terminal_tid_provisioning_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`inventory` ADD CONSTRAINT `fk_terminal_inventory_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ADD CONSTRAINT `fk_terminal_assignment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`assignment` ADD CONSTRAINT `fk_terminal_assignment_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ADD CONSTRAINT `fk_terminal_tamper_event_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ADD CONSTRAINT `fk_terminal_terminal_batch_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ADD CONSTRAINT `fk_terminal_terminal_alert_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2pe_scope` ADD CONSTRAINT `fk_terminal_p2pe_scope_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ADD CONSTRAINT `fk_terminal_downtime_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`nfc_tap_event` ADD CONSTRAINT `fk_terminal_nfc_tap_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= terminal --> network (6 constraint(s)) =========
-- Requires: terminal schema, network schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ADD CONSTRAINT `fk_terminal_token_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`connectivity` ADD CONSTRAINT `fk_terminal_connectivity_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_network_routing_rule_id` FOREIGN KEY (`network_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_routing_rule`(`network_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);

-- ========= terminal --> partner (17 constraint(s)) =========
-- Requires: terminal schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ADD CONSTRAINT `fk_terminal_wallet_bin_range_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ADD CONSTRAINT `fk_terminal_wallet_bin_range_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ADD CONSTRAINT `fk_terminal_upi_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi` ADD CONSTRAINT `fk_terminal_upi_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_config` ADD CONSTRAINT `fk_terminal_terminal_config_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software` ADD CONSTRAINT `fk_terminal_software_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ADD CONSTRAINT `fk_terminal_wallet_token_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_token` ADD CONSTRAINT `fk_terminal_wallet_token_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ADD CONSTRAINT `fk_terminal_token_requestor_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_requestor` ADD CONSTRAINT `fk_terminal_token_requestor_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ADD CONSTRAINT `fk_terminal_upi_registration_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`upi_registration` ADD CONSTRAINT `fk_terminal_upi_registration_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token_pan_mapping` ADD CONSTRAINT `fk_terminal_token_pan_mapping_partner_profile_id` FOREIGN KEY (`partner_profile_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_profile`(`partner_profile_id`);

-- ========= terminal --> product (5 constraint(s)) =========
-- Requires: terminal schema, product schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card` ADD CONSTRAINT `fk_terminal_card_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`token` ADD CONSTRAINT `fk_terminal_token_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`card_personalization` ADD CONSTRAINT `fk_terminal_card_personalization_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= terminal --> reference (22 constraint(s)) =========
-- Requires: terminal schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`payment_instrument` ADD CONSTRAINT `fk_terminal_payment_instrument_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ADD CONSTRAINT `fk_terminal_wallet_bin_range_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_bin_range` ADD CONSTRAINT `fk_terminal_wallet_bin_range_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`pos_terminal` ADD CONSTRAINT `fk_terminal_pos_terminal_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ADD CONSTRAINT `fk_terminal_deployment_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ADD CONSTRAINT `fk_terminal_deployment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ADD CONSTRAINT `fk_terminal_terminal_batch_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_fee_schedule` ADD CONSTRAINT `fk_terminal_terminal_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ADD CONSTRAINT `fk_terminal_surcharge_config_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`surcharge_config` ADD CONSTRAINT `fk_terminal_surcharge_config_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_authorization_response_code_id` FOREIGN KEY (`authorization_response_code_id`) REFERENCES `payments_fintech_ecm`.`reference`.`authorization_response_code`(`authorization_response_code_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `payments_fintech_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_balance` ADD CONSTRAINT `fk_terminal_wallet_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_limit` ADD CONSTRAINT `fk_terminal_wallet_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_consent` ADD CONSTRAINT `fk_terminal_wallet_consent_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);

-- ========= terminal --> risk (1 constraint(s)) =========
-- Requires: terminal schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);

-- ========= terminal --> settlement (7 constraint(s)) =========
-- Requires: terminal schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_batch` ADD CONSTRAINT `fk_terminal_terminal_batch_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ADD CONSTRAINT `fk_terminal_balance_movement_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`balance_movement` ADD CONSTRAINT `fk_terminal_balance_movement_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);

-- ========= terminal --> transaction (5 constraint(s)) =========
-- Requires: terminal schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`instrument_verification` ADD CONSTRAINT `fk_terminal_instrument_verification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`p2p_transfer` ADD CONSTRAINT `fk_terminal_p2p_transfer_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`loyalty_transaction` ADD CONSTRAINT `fk_terminal_loyalty_transaction_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);

-- ========= terminal --> workforce (18 constraint(s)) =========
-- Requires: terminal schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ADD CONSTRAINT `fk_terminal_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`deployment` ADD CONSTRAINT `fk_terminal_deployment_installation_technician_employee_id` FOREIGN KEY (`installation_technician_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ADD CONSTRAINT `fk_terminal_software_update_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`software_update` ADD CONSTRAINT `fk_terminal_software_update_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ADD CONSTRAINT `fk_terminal_key_injection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`key_injection` ADD CONSTRAINT `fk_terminal_key_injection_technician_employee_id` FOREIGN KEY (`technician_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`status_event` ADD CONSTRAINT `fk_terminal_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ADD CONSTRAINT `fk_terminal_tamper_event_analyst_employee_id` FOREIGN KEY (`analyst_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`tamper_event` ADD CONSTRAINT `fk_terminal_tamper_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`maintenance` ADD CONSTRAINT `fk_terminal_maintenance_technician_employee_id` FOREIGN KEY (`technician_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_reconciliation` ADD CONSTRAINT `fk_terminal_terminal_reconciliation_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`terminal_alert` ADD CONSTRAINT `fk_terminal_terminal_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`downtime` ADD CONSTRAINT `fk_terminal_downtime_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`digital_wallet` ADD CONSTRAINT `fk_terminal_digital_wallet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_transaction` ADD CONSTRAINT `fk_terminal_wallet_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`terminal`.`wallet_funding_source` ADD CONSTRAINT `fk_terminal_wallet_funding_source_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= transaction --> cardholder (25 constraint(s)) =========
-- Requires: transaction schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ADD CONSTRAINT `fk_transaction_instrument_issuance_address_id` FOREIGN KEY (`address_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`address`(`address_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ADD CONSTRAINT `fk_transaction_batch_item_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);

-- ========= transaction --> compliance (2 constraint(s)) =========
-- Requires: transaction schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_compliance_aml_screening_result_id` FOREIGN KEY (`compliance_aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result`(`compliance_aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= transaction --> dispute (1 constraint(s)) =========
-- Requires: transaction schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);

-- ========= transaction --> fx (3 constraint(s)) =========
-- Requires: transaction schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ADD CONSTRAINT `fk_transaction_swift_payment_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `payments_fintech_ecm`.`fx`.`beneficiary`(`beneficiary_id`);

-- ========= transaction --> gateway (7 constraint(s)) =========
-- Requires: transaction schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_tokenization_request_id` FOREIGN KEY (`tokenization_request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`tokenization_request`(`tokenization_request_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_tokenization_request_id` FOREIGN KEY (`tokenization_request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`tokenization_request`(`tokenization_request_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_gateway_routing_rule_id` FOREIGN KEY (`gateway_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_routing_rule`(`gateway_routing_rule_id`);

-- ========= transaction --> ledger (5 constraint(s)) =========
-- Requires: transaction schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`instrument_issuance` ADD CONSTRAINT `fk_transaction_instrument_issuance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= transaction --> merchant (20 constraint(s)) =========
-- Requires: transaction schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_merchant_location_id` FOREIGN KEY (`merchant_location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_location`(`merchant_location_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_sub_merchant_id` FOREIGN KEY (`sub_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`sub_merchant`(`sub_merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ADD CONSTRAINT `fk_transaction_batch_item_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_reconciliation` ADD CONSTRAINT `fk_transaction_transaction_reconciliation_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ADD CONSTRAINT `fk_transaction_iso_message_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`threeds_authentication` ADD CONSTRAINT `fk_transaction_threeds_authentication_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ADD CONSTRAINT `fk_transaction_tokenized_txn_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= transaction --> network (7 constraint(s)) =========
-- Requires: transaction schema, network schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_network_scheme_id` FOREIGN KEY (`network_scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ADD CONSTRAINT `fk_transaction_iso_message_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ADD CONSTRAINT `fk_transaction_iso_message_network_scheme_id` FOREIGN KEY (`network_scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ADD CONSTRAINT `fk_transaction_iso_message_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= transaction --> partner (4 constraint(s)) =========
-- Requires: transaction schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= transaction --> product (6 constraint(s)) =========
-- Requires: transaction schema, product schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_a2a_product_id` FOREIGN KEY (`a2a_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`a2a_product`(`a2a_product_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_p2p_product_id` FOREIGN KEY (`p2p_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`p2p_product`(`p2p_product_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_virtual_account_product_id` FOREIGN KEY (`virtual_account_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`virtual_account_product`(`virtual_account_product_id`);

-- ========= transaction --> reference (8 constraint(s)) =========
-- Requires: transaction schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_authorization_response_code_id` FOREIGN KEY (`authorization_response_code_id`) REFERENCES `payments_fintech_ecm`.`reference`.`authorization_response_code`(`authorization_response_code_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_card_scheme_id` FOREIGN KEY (`card_scheme_id`) REFERENCES `payments_fintech_ecm`.`reference`.`card_scheme`(`card_scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_decline_code_id` FOREIGN KEY (`decline_code_id`) REFERENCES `payments_fintech_ecm`.`reference`.`decline_code`(`decline_code_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_mcc_id` FOREIGN KEY (`mcc_id`) REFERENCES `payments_fintech_ecm`.`reference`.`mcc`(`mcc_id`);

-- ========= transaction --> risk (4 constraint(s)) =========
-- Requires: transaction schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `payments_fintech_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);

-- ========= transaction --> settlement (8 constraint(s)) =========
-- Requires: transaction schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`swift_payment` ADD CONSTRAINT `fk_transaction_swift_payment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);

-- ========= transaction --> terminal (17 constraint(s)) =========
-- Requires: transaction schema, terminal schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_digital_wallet_id` FOREIGN KEY (`digital_wallet_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`digital_wallet`(`digital_wallet_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`batch_item` ADD CONSTRAINT `fk_transaction_batch_item_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_token_id` FOREIGN KEY (`token_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token`(`token_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`iso_message` ADD CONSTRAINT `fk_transaction_iso_message_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ADD CONSTRAINT `fk_transaction_tokenized_txn_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`tokenized_txn` ADD CONSTRAINT `fk_transaction_tokenized_txn_token_requestor_id` FOREIGN KEY (`token_requestor_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`token_requestor`(`token_requestor_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`rtp_payment` ADD CONSTRAINT `fk_transaction_rtp_payment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_wallet_device_id` FOREIGN KEY (`wallet_device_id`) REFERENCES `payments_fintech_ecm`.`terminal`.`wallet_device`(`wallet_device_id`);

-- ========= transaction --> workforce (4 constraint(s)) =========
-- Requires: transaction schema, workforce schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ADD CONSTRAINT `fk_transaction_reconciliation_exception_assigned_resolver_employee_id` FOREIGN KEY (`assigned_resolver_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation_exception` ADD CONSTRAINT `fk_transaction_reconciliation_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`stp_record` ADD CONSTRAINT `fk_transaction_stp_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> ledger (9 constraint(s)) =========
-- Requires: workforce schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ADD CONSTRAINT `fk_workforce_headcount_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ADD CONSTRAINT `fk_workforce_workforce_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ADD CONSTRAINT `fk_workforce_workforce_location_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ADD CONSTRAINT `fk_workforce_equity_grant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= workforce --> partner (1 constraint(s)) =========
-- Requires: workforce schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= workforce --> reference (8 constraint(s)) =========
-- Requires: workforce schema, reference schema
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `payments_fintech_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_regulatory_jurisdiction_id` FOREIGN KEY (`regulatory_jurisdiction_id`) REFERENCES `payments_fintech_ecm`.`reference`.`regulatory_jurisdiction`(`regulatory_jurisdiction_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ADD CONSTRAINT `fk_workforce_workforce_location_country_id` FOREIGN KEY (`country_id`) REFERENCES `payments_fintech_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ADD CONSTRAINT `fk_workforce_workforce_location_timezone_id` FOREIGN KEY (`timezone_id`) REFERENCES `payments_fintech_ecm`.`reference`.`timezone`(`timezone_id`);

