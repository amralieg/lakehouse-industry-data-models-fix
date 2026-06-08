-- Cross-Domain Foreign Keys for Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:30
-- Total cross-domain FK constraints: 2270
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: account, asset, audit, channel, collateral, compliance, customer, fraud, hr, investment, ledger, loan, payment, reference, risk, security, trade, treasury, wealth

-- ========= account --> asset (3 constraint(s)) =========
-- Requires: account schema, asset schema
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= account --> channel (15 constraint(s)) =========
-- Requires: account schema, channel schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ADD CONSTRAINT `fk_account_dormancy_review_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`document` ADD CONSTRAINT `fk_account_document_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ADD CONSTRAINT `fk_account_channel_enrollment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ADD CONSTRAINT `fk_account_rm_account_assignment_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);

-- ========= account --> collateral (7 constraint(s)) =========
-- Requires: account schema, collateral schema
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ADD CONSTRAINT `fk_account_account_collateral_pledge_asset_collateral_asset_id` FOREIGN KEY (`asset_collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ADD CONSTRAINT `fk_account_account_collateral_pledge_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ADD CONSTRAINT `fk_account_account_collateral_pledge_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ADD CONSTRAINT `fk_account_account_pledge_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);

-- ========= account --> compliance (5 constraint(s)) =========
-- Requires: account schema, compliance schema
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ADD CONSTRAINT `fk_account_dormancy_review_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`account`.`document` ADD CONSTRAINT `fk_account_document_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);

-- ========= account --> customer (8 constraint(s)) =========
-- Requires: account schema, customer schema
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ADD CONSTRAINT `fk_account_beneficiary_designation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= account --> fraud (2 constraint(s)) =========
-- Requires: account schema, fraud schema
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);

-- ========= account --> hr (20 constraint(s)) =========
-- Requires: account schema, hr schema
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_holder_last_modified_by_user_employee_id` FOREIGN KEY (`holder_last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_hold_last_modified_user_employee_id` FOREIGN KEY (`hold_last_modified_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ADD CONSTRAINT `fk_account_dormancy_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`document` ADD CONSTRAINT `fk_account_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`document` ADD CONSTRAINT `fk_account_document_document_employee_id` FOREIGN KEY (`document_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`document` ADD CONSTRAINT `fk_account_document_document_verifying_officer_employee_id` FOREIGN KEY (`document_verifying_officer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ADD CONSTRAINT `fk_account_beneficiary_designation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ADD CONSTRAINT `fk_account_channel_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= account --> investment (1 constraint(s)) =========
-- Requires: account schema, investment schema
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ADD CONSTRAINT `fk_account_custody_mandate_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);

-- ========= account --> ledger (14 constraint(s)) =========
-- Requires: account schema, ledger schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ADD CONSTRAINT `fk_account_dormancy_review_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);

-- ========= account --> loan (1 constraint(s)) =========
-- Requires: account schema, loan schema
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_loan_fee_schedule_id` FOREIGN KEY (`loan_fee_schedule_id`) REFERENCES `banking_ecm`.`loan`.`loan_fee_schedule`(`loan_fee_schedule_id`);

-- ========= account --> payment (2 constraint(s)) =========
-- Requires: account schema, payment schema
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);

-- ========= account --> reference (21 constraint(s)) =========
-- Requires: account schema, reference schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`account`.`account_product` ADD CONSTRAINT `fk_account_account_product_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ADD CONSTRAINT `fk_account_dormancy_review_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ADD CONSTRAINT `fk_account_beneficiary_designation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ADD CONSTRAINT `fk_account_rate_tier_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`type` ADD CONSTRAINT `fk_account_type_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);

-- ========= account --> security (2 constraint(s)) =========
-- Requires: account schema, security schema
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`account`.`account_position` ADD CONSTRAINT `fk_account_account_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= account --> trade (1 constraint(s)) =========
-- Requires: account schema, trade schema
ALTER TABLE `banking_ecm`.`account`.`account_position` ADD CONSTRAINT `fk_account_account_position_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);

-- ========= account --> wealth (4 constraint(s)) =========
-- Requires: account schema, wealth schema
ALTER TABLE `banking_ecm`.`account`.`account_position` ADD CONSTRAINT `fk_account_account_position_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ADD CONSTRAINT `fk_account_account_portfolio_holding_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ADD CONSTRAINT `fk_account_account_portfolio_holding_wealth_portfolio_holding_id` FOREIGN KEY (`wealth_portfolio_holding_id`) REFERENCES `banking_ecm`.`wealth`.`wealth_portfolio_holding`(`wealth_portfolio_holding_id`);
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ADD CONSTRAINT `fk_account_account_portfolio_holding_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);

-- ========= asset --> channel (4 constraint(s)) =========
-- Requires: asset schema, channel schema
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= asset --> customer (13 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_fund_party_id` FOREIGN KEY (`fund_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_fund_transfer_agent_party_id` FOREIGN KEY (`fund_transfer_agent_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ADD CONSTRAINT `fk_asset_fund_distribution_channel_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_transfer_agent_party_id` FOREIGN KEY (`transfer_agent_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= asset --> hr (13 constraint(s)) =========
-- Requires: asset schema, hr schema
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_tertiary_restriction_waiver_granted_by_employee_id` FOREIGN KEY (`tertiary_restriction_waiver_granted_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ADD CONSTRAINT `fk_asset_fund_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ADD CONSTRAINT `fk_asset_fund_administrator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ADD CONSTRAINT `fk_asset_fund_distribution_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ADD CONSTRAINT `fk_asset_fund_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ADD CONSTRAINT `fk_asset_fund_management_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= asset --> ledger (16 constraint(s)) =========
-- Requires: asset schema, ledger schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ADD CONSTRAINT `fk_asset_fund_regulatory_report_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ADD CONSTRAINT `fk_asset_fund_audit_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= asset --> payment (3 constraint(s)) =========
-- Requires: asset schema, payment schema
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);

-- ========= asset --> reference (43 constraint(s)) =========
-- Requires: asset schema, reference schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ADD CONSTRAINT `fk_asset_asset_unit_register_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ADD CONSTRAINT `fk_asset_fund_regulatory_report_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ADD CONSTRAINT `fk_asset_fund_administrator_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ADD CONSTRAINT `fk_asset_fund_administrator_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ADD CONSTRAINT `fk_asset_fund_administrator_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ADD CONSTRAINT `fk_asset_fund_benchmark_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ADD CONSTRAINT `fk_asset_fund_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ADD CONSTRAINT `fk_asset_fund_distribution_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ADD CONSTRAINT `fk_asset_fund_audit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);

-- ========= asset --> risk (10 constraint(s)) =========
-- Requires: asset schema, risk schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ADD CONSTRAINT `fk_asset_fund_regulatory_report_risk_report_id` FOREIGN KEY (`risk_report_id`) REFERENCES `banking_ecm`.`risk`.`risk_report`(`risk_report_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ADD CONSTRAINT `fk_asset_fund_risk_exposure_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);

-- ========= asset --> security (29 constraint(s)) =========
-- Requires: asset schema, security schema
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_derivative_id` FOREIGN KEY (`derivative_id`) REFERENCES `banking_ecm`.`security`.`derivative`(`derivative_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_equity_id` FOREIGN KEY (`equity_id`) REFERENCES `banking_ecm`.`security`.`equity`(`equity_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_fixed_income_id` FOREIGN KEY (`fixed_income_id`) REFERENCES `banking_ecm`.`security`.`fixed_income`(`fixed_income_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_structured_product_id` FOREIGN KEY (`structured_product_id`) REFERENCES `banking_ecm`.`security`.`structured_product`(`structured_product_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ADD CONSTRAINT `fk_asset_fund_regulatory_report_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ADD CONSTRAINT `fk_asset_fund_benchmark_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= asset --> trade (5 constraint(s)) =========
-- Requires: asset schema, trade schema
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);

-- ========= asset --> wealth (3 constraint(s)) =========
-- Requires: asset schema, wealth schema
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= audit --> account (10 constraint(s)) =========
-- Requires: audit schema, account schema
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_direct_debit_mandate_id` FOREIGN KEY (`direct_debit_mandate_id`) REFERENCES `banking_ecm`.`account`.`direct_debit_mandate`(`direct_debit_mandate_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_document_id` FOREIGN KEY (`document_id`) REFERENCES `banking_ecm`.`account`.`document`(`document_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `banking_ecm`.`account`.`standing_order`(`standing_order_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `banking_ecm`.`account`.`hold`(`hold_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);

-- ========= audit --> asset (13 constraint(s)) =========
-- Requires: audit schema, asset schema
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_administrator_id` FOREIGN KEY (`fund_administrator_id`) REFERENCES `banking_ecm`.`asset`.`fund_administrator`(`fund_administrator_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_audit_id` FOREIGN KEY (`fund_audit_id`) REFERENCES `banking_ecm`.`asset`.`fund_audit`(`fund_audit_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_lifecycle_event_id` FOREIGN KEY (`fund_lifecycle_event_id`) REFERENCES `banking_ecm`.`asset`.`fund_lifecycle_event`(`fund_lifecycle_event_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `banking_ecm`.`asset`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_fund_regulatory_report_id` FOREIGN KEY (`fund_regulatory_report_id`) REFERENCES `banking_ecm`.`asset`.`fund_regulatory_report`(`fund_regulatory_report_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_fund_expense_id` FOREIGN KEY (`fund_expense_id`) REFERENCES `banking_ecm`.`asset`.`fund_expense`(`fund_expense_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_fund_valuation_adjustment_id` FOREIGN KEY (`fund_valuation_adjustment_id`) REFERENCES `banking_ecm`.`asset`.`fund_valuation_adjustment`(`fund_valuation_adjustment_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_restriction_breach_id` FOREIGN KEY (`restriction_breach_id`) REFERENCES `banking_ecm`.`asset`.`restriction_breach`(`restriction_breach_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_fund_regulatory_report_id` FOREIGN KEY (`fund_regulatory_report_id`) REFERENCES `banking_ecm`.`asset`.`fund_regulatory_report`(`fund_regulatory_report_id`);

-- ========= audit --> compliance (12 constraint(s)) =========
-- Requires: audit schema, compliance schema
ALTER TABLE `banking_ecm`.`audit`.`plan` ADD CONSTRAINT `fk_audit_plan_regulatory_calendar_id` FOREIGN KEY (`regulatory_calendar_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_calendar`(`regulatory_calendar_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `banking_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`audit`.`program` ADD CONSTRAINT `fk_audit_program_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ADD CONSTRAINT `fk_audit_three_lines_assignment_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);

-- ========= audit --> customer (4 constraint(s)) =========
-- Requires: audit schema, customer schema
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= audit --> hr (34 constraint(s)) =========
-- Requires: audit schema, hr schema
ALTER TABLE `banking_ecm`.`audit`.`plan` ADD CONSTRAINT `fk_audit_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_engagement_employee_id` FOREIGN KEY (`engagement_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_engagement_manager_employee_id` FOREIGN KEY (`engagement_manager_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_engagement_updated_by_user_employee_id` FOREIGN KEY (`engagement_updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`program` ADD CONSTRAINT `fk_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`program` ADD CONSTRAINT `fk_audit_program_program_employee_id` FOREIGN KEY (`program_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`program` ADD CONSTRAINT `fk_audit_program_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_workpaper_employee_id` FOREIGN KEY (`workpaper_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_finding_employee_id` FOREIGN KEY (`finding_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ADD CONSTRAINT `fk_audit_recommendation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ADD CONSTRAINT `fk_audit_issue_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`resource` ADD CONSTRAINT `fk_audit_resource_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`resource` ADD CONSTRAINT `fk_audit_resource_resource_reporting_line_manager_employee_id` FOREIGN KEY (`resource_reporting_line_manager_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ADD CONSTRAINT `fk_audit_engagement_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ADD CONSTRAINT `fk_audit_engagement_assignment_primary_engagement_employee_id` FOREIGN KEY (`primary_engagement_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ADD CONSTRAINT `fk_audit_committee_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ADD CONSTRAINT `fk_audit_committee_report_committee_prepared_by_employee_id` FOREIGN KEY (`committee_prepared_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ADD CONSTRAINT `fk_audit_committee_report_primary_committee_employee_id` FOREIGN KEY (`primary_committee_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ADD CONSTRAINT `fk_audit_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ADD CONSTRAINT `fk_audit_risk_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_tertiary_issue_validated_by_employee_id` FOREIGN KEY (`tertiary_issue_validated_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ADD CONSTRAINT `fk_audit_audit_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ADD CONSTRAINT `fk_audit_cosourcing_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`notification` ADD CONSTRAINT `fk_audit_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`notification` ADD CONSTRAINT `fk_audit_notification_notification_sender_employee_id` FOREIGN KEY (`notification_sender_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`business_process` ADD CONSTRAINT `fk_audit_business_process_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`audit`.`business_process` ADD CONSTRAINT `fk_audit_business_process_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`audit`.`business_process` ADD CONSTRAINT `fk_audit_business_process_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= audit --> ledger (24 constraint(s)) =========
-- Requires: audit schema, ledger schema
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ADD CONSTRAINT `fk_audit_recommendation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ADD CONSTRAINT `fk_audit_audit_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ADD CONSTRAINT `fk_audit_committee_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ADD CONSTRAINT `fk_audit_three_lines_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ADD CONSTRAINT `fk_audit_three_lines_assignment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);

-- ========= audit --> loan (8 constraint(s)) =========
-- Requires: audit schema, loan schema
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);

-- ========= audit --> reference (25 constraint(s)) =========
-- Requires: audit schema, reference schema
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ADD CONSTRAINT `fk_audit_recommendation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);

-- ========= audit --> risk (12 constraint(s)) =========
-- Requires: audit schema, risk schema
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `banking_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `banking_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ADD CONSTRAINT `fk_audit_three_lines_assignment_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);

-- ========= audit --> security (20 constraint(s)) =========
-- Requires: audit schema, security schema
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);

-- ========= audit --> trade (8 constraint(s)) =========
-- Requires: audit schema, trade schema
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);

-- ========= audit --> treasury (15 constraint(s)) =========
-- Requires: audit schema, treasury schema
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_contingency_funding_plan_id` FOREIGN KEY (`contingency_funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`contingency_funding_plan`(`contingency_funding_plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_interest_rate_risk_position_id` FOREIGN KEY (`interest_rate_risk_position_id`) REFERENCES `banking_ecm`.`treasury`.`interest_rate_risk_position`(`interest_rate_risk_position_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_liquidity_ratio_id` FOREIGN KEY (`liquidity_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_ratio`(`liquidity_ratio_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_transfer_pricing_curve_id` FOREIGN KEY (`transfer_pricing_curve_id`) REFERENCES `banking_ecm`.`treasury`.`transfer_pricing_curve`(`transfer_pricing_curve_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_alm_hedge_id` FOREIGN KEY (`alm_hedge_id`) REFERENCES `banking_ecm`.`treasury`.`alm_hedge`(`alm_hedge_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_debt_issuance_id` FOREIGN KEY (`debt_issuance_id`) REFERENCES `banking_ecm`.`treasury`.`debt_issuance`(`debt_issuance_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_hqla_inventory_id` FOREIGN KEY (`hqla_inventory_id`) REFERENCES `banking_ecm`.`treasury`.`hqla_inventory`(`hqla_inventory_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_alco_resolution_id` FOREIGN KEY (`alco_resolution_id`) REFERENCES `banking_ecm`.`treasury`.`alco_resolution`(`alco_resolution_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_nostro_reconciliation_id` FOREIGN KEY (`nostro_reconciliation_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_reconciliation`(`nostro_reconciliation_id`);

-- ========= channel --> account (8 constraint(s)) =========
-- Requires: channel schema, account schema
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ADD CONSTRAINT `fk_channel_branch_appointment_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);

-- ========= channel --> audit (10 constraint(s)) =========
-- Requires: channel schema, audit schema
ALTER TABLE `banking_ecm`.`channel`.`session` ADD CONSTRAINT `fk_channel_session_continuous_monitoring_id` FOREIGN KEY (`continuous_monitoring_id`) REFERENCES `banking_ecm`.`audit`.`continuous_monitoring`(`continuous_monitoring_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey` ADD CONSTRAINT `fk_channel_journey_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ADD CONSTRAINT `fk_channel_channel_incident_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_workpaper_id` FOREIGN KEY (`workpaper_id`) REFERENCES `banking_ecm`.`audit`.`workpaper`(`workpaper_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_monitoring_exception_id` FOREIGN KEY (`monitoring_exception_id`) REFERENCES `banking_ecm`.`audit`.`monitoring_exception`(`monitoring_exception_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ADD CONSTRAINT `fk_channel_branch_audit_scope_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ADD CONSTRAINT `fk_channel_audit_scope_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);

-- ========= channel --> compliance (3 constraint(s)) =========
-- Requires: channel schema, compliance schema
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ADD CONSTRAINT `fk_channel_channel_product_disclosure_template_id` FOREIGN KEY (`disclosure_template_id`) REFERENCES `banking_ecm`.`compliance`.`disclosure_template`(`disclosure_template_id`);

-- ========= channel --> customer (13 constraint(s)) =========
-- Requires: channel schema, customer schema
ALTER TABLE `banking_ecm`.`channel`.`session` ADD CONSTRAINT `fk_channel_session_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ADD CONSTRAINT `fk_channel_rm_client_assignment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey` ADD CONSTRAINT `fk_channel_journey_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ADD CONSTRAINT `fk_channel_journey_instance_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ADD CONSTRAINT `fk_channel_branch_appointment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`preference` ADD CONSTRAINT `fk_channel_preference_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= channel --> fraud (1 constraint(s)) =========
-- Requires: channel schema, fraud schema
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ADD CONSTRAINT `fk_channel_rule_configuration_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);

-- ========= channel --> hr (21 constraint(s)) =========
-- Requires: channel schema, hr schema
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ADD CONSTRAINT `fk_channel_contact_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_interaction_employee_id` FOREIGN KEY (`interaction_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ADD CONSTRAINT `fk_channel_channel_relationship_manager_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ADD CONSTRAINT `fk_channel_rm_client_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ADD CONSTRAINT `fk_channel_channel_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ADD CONSTRAINT `fk_channel_branch_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ADD CONSTRAINT `fk_channel_channel_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`queue` ADD CONSTRAINT `fk_channel_queue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ADD CONSTRAINT `fk_channel_audit_scope_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ADD CONSTRAINT `fk_channel_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ADD CONSTRAINT `fk_channel_cost_allocation_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ADD CONSTRAINT `fk_channel_cost_allocation_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_approver_user_employee_id` FOREIGN KEY (`approver_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_delegated_from_user_employee_id` FOREIGN KEY (`delegated_from_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_template` ADD CONSTRAINT `fk_channel_journey_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= channel --> ledger (3 constraint(s)) =========
-- Requires: channel schema, ledger schema
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_issuer_institution_legal_entity_id` FOREIGN KEY (`issuer_institution_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ADD CONSTRAINT `fk_channel_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);

-- ========= channel --> payment (4 constraint(s)) =========
-- Requires: channel schema, payment schema
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_card_id` FOREIGN KEY (`card_id`) REFERENCES `banking_ecm`.`payment`.`card`(`card_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);

-- ========= channel --> reference (9 constraint(s)) =========
-- Requires: channel schema, reference schema
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ADD CONSTRAINT `fk_channel_contact_center_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ADD CONSTRAINT `fk_channel_channel_relationship_manager_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`api_application` ADD CONSTRAINT `fk_channel_api_application_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= channel --> risk (3 constraint(s)) =========
-- Requires: channel schema, risk schema
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ADD CONSTRAINT `fk_channel_channel_incident_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);

-- ========= channel --> security (4 constraint(s)) =========
-- Requires: channel schema, security schema
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ADD CONSTRAINT `fk_channel_channel_product_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= collateral --> asset (6 constraint(s)) =========
-- Requires: collateral schema, asset schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= collateral --> audit (14 constraint(s)) =========
-- Requires: collateral schema, audit schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ADD CONSTRAINT `fk_collateral_lien_filing_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ADD CONSTRAINT `fk_collateral_concentration_limit_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ADD CONSTRAINT `fk_collateral_insurance_policy_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);

-- ========= collateral --> compliance (18 constraint(s)) =========
-- Requires: collateral schema, compliance schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ADD CONSTRAINT `fk_collateral_collateral_margin_call_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ADD CONSTRAINT `fk_collateral_lien_filing_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ADD CONSTRAINT `fk_collateral_concentration_limit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= collateral --> customer (36 constraint(s)) =========
-- Requires: collateral schema, customer schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_collateral_pledge_obligor_party_id` FOREIGN KEY (`collateral_pledge_obligor_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_collateral_pledge_secured_party_id` FOREIGN KEY (`collateral_pledge_secured_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ADD CONSTRAINT `fk_collateral_collateral_margin_call_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_primary_margin_party_id` FOREIGN KEY (`primary_margin_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_primary_collateral_party_id` FOREIGN KEY (`primary_collateral_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_primary_substitution_party_id` FOREIGN KEY (`primary_substitution_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_primary_repo_party_id` FOREIGN KEY (`primary_repo_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_tertiary_pledge_custodian_party_id` FOREIGN KEY (`tertiary_pledge_custodian_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_primary_initial_custodian_party_id` FOREIGN KEY (`primary_initial_custodian_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_primary_variation_party_id` FOREIGN KEY (`primary_variation_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ADD CONSTRAINT `fk_collateral_lien_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_review_secured_party_id` FOREIGN KEY (`review_secured_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_primary_netting_custodian_party_id` FOREIGN KEY (`primary_netting_custodian_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_receiving_party_id` FOREIGN KEY (`receiving_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_sending_party_id` FOREIGN KEY (`sending_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_transfer_party_id` FOREIGN KEY (`transfer_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ADD CONSTRAINT `fk_collateral_insurance_policy_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`isda_master_agreement` ADD CONSTRAINT `fk_collateral_isda_master_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ADD CONSTRAINT `fk_collateral_csa_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= collateral --> hr (14 constraint(s)) =========
-- Requires: collateral schema, hr schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_substitution_employee_id` FOREIGN KEY (`substitution_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_substitution_updated_by_user_employee_id` FOREIGN KEY (`substitution_updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ADD CONSTRAINT `fk_collateral_lien_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_review_employee_id` FOREIGN KEY (`review_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_primary_collateral_employee_id` FOREIGN KEY (`primary_collateral_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= collateral --> ledger (15 constraint(s)) =========
-- Requires: collateral schema, ledger schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ADD CONSTRAINT `fk_collateral_collateral_margin_call_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_set_id` FOREIGN KEY (`set_id`) REFERENCES `banking_ecm`.`ledger`.`set`(`set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= collateral --> reference (42 constraint(s)) =========
-- Requires: collateral schema, reference schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_market_data_source_id` FOREIGN KEY (`market_data_source_id`) REFERENCES `banking_ecm`.`reference`.`market_data_source`(`market_data_source_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ADD CONSTRAINT `fk_collateral_collateral_margin_call_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_market_data_source_id` FOREIGN KEY (`market_data_source_id`) REFERENCES `banking_ecm`.`reference`.`market_data_source`(`market_data_source_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ADD CONSTRAINT `fk_collateral_concentration_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ADD CONSTRAINT `fk_collateral_concentration_limit_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= collateral --> risk (6 constraint(s)) =========
-- Requires: collateral schema, risk schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);

-- ========= collateral --> security (10 constraint(s)) =========
-- Requires: collateral schema, security schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ADD CONSTRAINT `fk_collateral_insurance_policy_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= collateral --> trade (5 constraint(s)) =========
-- Requires: collateral schema, trade schema
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);

-- ========= collateral --> treasury (2 constraint(s)) =========
-- Requires: collateral schema, treasury schema
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_repo_transaction_id` FOREIGN KEY (`repo_transaction_id`) REFERENCES `banking_ecm`.`treasury`.`repo_transaction`(`repo_transaction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ADD CONSTRAINT `fk_collateral_stress_valuation_stress_scenario_cfp_id` FOREIGN KEY (`stress_scenario_cfp_id`) REFERENCES `banking_ecm`.`treasury`.`stress_scenario_cfp`(`stress_scenario_cfp_id`);

-- ========= compliance --> account (4 constraint(s)) =========
-- Requires: compliance schema, account schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= compliance --> asset (10 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= compliance --> audit (3 constraint(s)) =========
-- Requires: compliance schema, audit schema
ALTER TABLE `banking_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `banking_ecm`.`audit`.`program`(`program_id`);
ALTER TABLE `banking_ecm`.`compliance`.`rule_validation` ADD CONSTRAINT `fk_compliance_rule_validation_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`compliance`.`coverage` ADD CONSTRAINT `fk_compliance_coverage_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);

-- ========= compliance --> channel (14 constraint(s)) =========
-- Requires: compliance schema, channel schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_exam` ADD CONSTRAINT `fk_compliance_regulatory_exam_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_sox_control` ADD CONSTRAINT `fk_compliance_compliance_sox_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= compliance --> customer (8 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_screened_party_id` FOREIGN KEY (`screened_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= compliance --> fraud (4 constraint(s)) =========
-- Requires: compliance schema, fraud schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);

-- ========= compliance --> hr (12 constraint(s)) =========
-- Requires: compliance schema, hr schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_primary_kyc_employee_id` FOREIGN KEY (`primary_kyc_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_sox_control` ADD CONSTRAINT `fk_compliance_compliance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`compliance`.`data_subject_request` ADD CONSTRAINT `fk_compliance_data_subject_request_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= compliance --> payment (1 constraint(s)) =========
-- Requires: compliance schema, payment schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= compliance --> reference (21 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_exam` ADD CONSTRAINT `fk_compliance_regulatory_exam_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_sox_control` ADD CONSTRAINT `fk_compliance_compliance_sox_control_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`training_record` ADD CONSTRAINT `fk_compliance_training_record_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_calendar` ADD CONSTRAINT `fk_compliance_regulatory_calendar_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_calendar` ADD CONSTRAINT `fk_compliance_regulatory_calendar_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);

-- ========= compliance --> treasury (6 constraint(s)) =========
-- Requires: compliance schema, treasury schema
ALTER TABLE `banking_ecm`.`compliance`.`exam_finding` ADD CONSTRAINT `fk_compliance_exam_finding_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_sox_control` ADD CONSTRAINT `fk_compliance_compliance_sox_control_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`compliance`.`compliance_sox_control` ADD CONSTRAINT `fk_compliance_compliance_sox_control_liquidity_ratio_id` FOREIGN KEY (`liquidity_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_ratio`(`liquidity_ratio_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`compliance`.`breach` ADD CONSTRAINT `fk_compliance_breach_liquidity_ratio_id` FOREIGN KEY (`liquidity_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_ratio`(`liquidity_ratio_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);

-- ========= customer --> account (3 constraint(s)) =========
-- Requires: customer schema, account schema
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ADD CONSTRAINT `fk_customer_account_holder_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= customer --> asset (2 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ADD CONSTRAINT `fk_customer_customer_unit_register_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_unit_register` ADD CONSTRAINT `fk_customer_customer_unit_register_asset_unit_register_id` FOREIGN KEY (`asset_unit_register_id`) REFERENCES `banking_ecm`.`asset`.`asset_unit_register`(`asset_unit_register_id`);

-- ========= customer --> channel (7 constraint(s)) =========
-- Requires: customer schema, channel schema
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ADD CONSTRAINT `fk_customer_party_relationship_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ADD CONSTRAINT `fk_customer_party_lifecycle_event_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);

-- ========= customer --> compliance (1 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `banking_ecm`.`compliance`.`data_subject_request`(`data_subject_request_id`);

-- ========= customer --> hr (31 constraint(s)) =========
-- Requires: customer schema, hr schema
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_document` ADD CONSTRAINT `fk_customer_party_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ADD CONSTRAINT `fk_customer_relationship_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ADD CONSTRAINT `fk_customer_relationship_hierarchy_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_primary_onboarding_assigned_analyst_employee_id` FOREIGN KEY (`primary_onboarding_assigned_analyst_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_tertiary_onboarding_last_modified_by_employee_id` FOREIGN KEY (`tertiary_onboarding_last_modified_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ADD CONSTRAINT `fk_customer_kyc_review_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ADD CONSTRAINT `fk_customer_kyc_review_event_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ADD CONSTRAINT `fk_customer_party_risk_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ADD CONSTRAINT `fk_customer_party_risk_rating_primary_party_rating_analyst_employee_id` FOREIGN KEY (`primary_party_rating_analyst_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ADD CONSTRAINT `fk_customer_customer_relationship_manager_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ADD CONSTRAINT `fk_customer_customer_relationship_manager_tertiary_customer_handover_to_rm_employee_id` FOREIGN KEY (`tertiary_customer_handover_to_rm_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ADD CONSTRAINT `fk_customer_party_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ADD CONSTRAINT `fk_customer_fatca_crs_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ADD CONSTRAINT `fk_customer_fatca_crs_classification_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_primary_risk_override_approved_by_employee_id` FOREIGN KEY (`primary_risk_override_approved_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_risk_analyst_employee_id` FOREIGN KEY (`risk_analyst_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_complaint_assigned_handler_employee_id` FOREIGN KEY (`complaint_assigned_handler_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ADD CONSTRAINT `fk_customer_tax_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`account_holder` ADD CONSTRAINT `fk_customer_account_holder_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ADD CONSTRAINT `fk_customer_limit_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= customer --> investment (2 constraint(s)) =========
-- Requires: customer schema, investment schema
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ADD CONSTRAINT `fk_customer_customer_investor_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_investor_order` ADD CONSTRAINT `fk_customer_customer_investor_order_investment_investor_order_id` FOREIGN KEY (`investment_investor_order_id`) REFERENCES `banking_ecm`.`investment`.`investment_investor_order`(`investment_investor_order_id`);

-- ========= customer --> ledger (9 constraint(s)) =========
-- Requires: customer schema, ledger schema
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ADD CONSTRAINT `fk_customer_kyc_review_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ADD CONSTRAINT `fk_customer_customer_relationship_manager_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ADD CONSTRAINT `fk_customer_fatca_crs_classification_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);

-- ========= customer --> reference (40 constraint(s)) =========
-- Requires: customer schema, reference schema
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ADD CONSTRAINT `fk_customer_individual_profile_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_beneficial_owner` ADD CONSTRAINT `fk_customer_customer_beneficial_owner_primary_customer_country_id` FOREIGN KEY (`primary_customer_country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_address` ADD CONSTRAINT `fk_customer_party_address_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_address` ADD CONSTRAINT `fk_customer_party_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ADD CONSTRAINT `fk_customer_party_contact_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ADD CONSTRAINT `fk_customer_party_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_document` ADD CONSTRAINT `fk_customer_party_document_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_document` ADD CONSTRAINT `fk_customer_party_document_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`relationship_hierarchy` ADD CONSTRAINT `fk_customer_relationship_hierarchy_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ADD CONSTRAINT `fk_customer_kyc_review_event_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ADD CONSTRAINT `fk_customer_party_relationship_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ADD CONSTRAINT `fk_customer_party_risk_rating_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`customer_relationship_manager` ADD CONSTRAINT `fk_customer_customer_relationship_manager_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ADD CONSTRAINT `fk_customer_party_lifecycle_event_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ADD CONSTRAINT `fk_customer_fatca_crs_classification_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`fatca_crs_classification` ADD CONSTRAINT `fk_customer_fatca_crs_classification_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_identifier` ADD CONSTRAINT `fk_customer_party_identifier_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`prospect` ADD CONSTRAINT `fk_customer_prospect_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ADD CONSTRAINT `fk_customer_tax_profile_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`tax_profile` ADD CONSTRAINT `fk_customer_tax_profile_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);

-- ========= customer --> risk (4 constraint(s)) =========
-- Requires: customer schema, risk schema
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`customer`.`limit_allocation` ADD CONSTRAINT `fk_customer_limit_allocation_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);

-- ========= customer --> security (2 constraint(s)) =========
-- Requires: customer schema, security schema
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_risk_rating` ADD CONSTRAINT `fk_customer_party_risk_rating_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);

-- ========= customer --> wealth (3 constraint(s)) =========
-- Requires: customer schema, wealth schema
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_lifecycle_event` ADD CONSTRAINT `fk_customer_party_lifecycle_event_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= fraud --> account (12 constraint(s)) =========
-- Requires: fraud schema, account schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_claim_provisional_credit_account_deposit_account_id` FOREIGN KEY (`claim_provisional_credit_account_deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);

-- ========= fraud --> asset (11 constraint(s)) =========
-- Requires: fraud schema, asset schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ADD CONSTRAINT `fk_fraud_subject_account_link_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);

-- ========= fraud --> audit (7 constraint(s)) =========
-- Requires: fraud schema, audit schema
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `banking_ecm`.`audit`.`regulatory_finding`(`regulatory_finding_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_continuous_monitoring_id` FOREIGN KEY (`continuous_monitoring_id`) REFERENCES `banking_ecm`.`audit`.`continuous_monitoring`(`continuous_monitoring_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_workpaper_id` FOREIGN KEY (`workpaper_id`) REFERENCES `banking_ecm`.`audit`.`workpaper`(`workpaper_id`);
ALTER TABLE `banking_ecm`.`fraud`.`typology` ADD CONSTRAINT `fk_fraud_typology_universe_id` FOREIGN KEY (`universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);

-- ========= fraud --> channel (26 constraint(s)) =========
-- Requires: fraud schema, channel schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_contact_center_id` FOREIGN KEY (`contact_center_id`) REFERENCES `banking_ecm`.`channel`.`contact_center`(`contact_center_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_journey_id` FOREIGN KEY (`journey_id`) REFERENCES `banking_ecm`.`channel`.`journey`(`journey_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_journey_id` FOREIGN KEY (`journey_id`) REFERENCES `banking_ecm`.`channel`.`journey`(`journey_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_contact_center_id` FOREIGN KEY (`contact_center_id`) REFERENCES `banking_ecm`.`channel`.`contact_center`(`contact_center_id`);
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ADD CONSTRAINT `fk_fraud_device_fingerprint_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);

-- ========= fraud --> customer (8 constraint(s)) =========
-- Requires: fraud schema, customer schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= fraud --> hr (26 constraint(s)) =========
-- Requires: fraud schema, hr schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_case_updated_by_user_employee_id` FOREIGN KEY (`case_updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_investigation_last_modified_by_employee_id` FOREIGN KEY (`investigation_last_modified_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_tertiary_sar_approved_by_user_employee_id` FOREIGN KEY (`tertiary_sar_approved_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_evidence_updated_by_user_employee_id` FOREIGN KEY (`evidence_updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ADD CONSTRAINT `fk_fraud_law_enforcement_referral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_tertiary_fraud_updated_by_user_employee_id` FOREIGN KEY (`tertiary_fraud_updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`typology` ADD CONSTRAINT `fk_fraud_typology_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ADD CONSTRAINT `fk_fraud_rule_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ADD CONSTRAINT `fk_fraud_subject_account_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ADD CONSTRAINT `fk_fraud_fraud_ring_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ADD CONSTRAINT `fk_fraud_fraud_ring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ADD CONSTRAINT `fk_fraud_fraud_ring_last_updated_by_user_employee_id` FOREIGN KEY (`last_updated_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= fraud --> ledger (4 constraint(s)) =========
-- Requires: fraud schema, ledger schema
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= fraud --> payment (3 constraint(s)) =========
-- Requires: fraud schema, payment schema
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_card_transaction_id` FOREIGN KEY (`card_transaction_id`) REFERENCES `banking_ecm`.`payment`.`card_transaction`(`card_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ADD CONSTRAINT `fk_fraud_merchant_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ADD CONSTRAINT `fk_fraud_merchant_payment_processor_id` FOREIGN KEY (`payment_processor_id`) REFERENCES `banking_ecm`.`payment`.`payment_processor`(`payment_processor_id`);

-- ========= fraud --> reference (22 constraint(s)) =========
-- Requires: fraud schema, reference schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ADD CONSTRAINT `fk_fraud_law_enforcement_referral_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ADD CONSTRAINT `fk_fraud_device_fingerprint_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`typology` ADD CONSTRAINT `fk_fraud_typology_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ADD CONSTRAINT `fk_fraud_rule_performance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= fraud --> risk (4 constraint(s)) =========
-- Requires: fraud schema, risk schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);

-- ========= fraud --> security (5 constraint(s)) =========
-- Requires: fraud schema, security schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= fraud --> treasury (1 constraint(s)) =========
-- Requires: fraud schema, treasury schema
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);

-- ========= fraud --> wealth (4 constraint(s)) =========
-- Requires: fraud schema, wealth schema
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= hr --> compliance (1 constraint(s)) =========
-- Requires: hr schema, compliance schema
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);

-- ========= hr --> ledger (3 constraint(s)) =========
-- Requires: hr schema, ledger schema
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ADD CONSTRAINT `fk_hr_payroll_record_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);

-- ========= hr --> reference (6 constraint(s)) =========
-- Requires: hr schema, reference schema
ALTER TABLE `banking_ecm`.`hr`.`employee` ADD CONSTRAINT `fk_hr_employee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ADD CONSTRAINT `fk_hr_benefit_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ADD CONSTRAINT `fk_hr_onboarding_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= hr --> security (1 constraint(s)) =========
-- Requires: hr schema, security schema
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ADD CONSTRAINT `fk_hr_compensation_event_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= investment --> account (1 constraint(s)) =========
-- Requires: investment schema, account schema
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= investment --> asset (2 constraint(s)) =========
-- Requires: investment schema, asset schema
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= investment --> audit (8 constraint(s)) =========
-- Requires: investment schema, audit schema
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_universe_id` FOREIGN KEY (`universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `banking_ecm`.`audit`.`regulatory_finding`(`regulatory_finding_id`);

-- ========= investment --> channel (9 constraint(s)) =========
-- Requires: investment schema, channel schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= investment --> collateral (7 constraint(s)) =========
-- Requires: investment schema, collateral schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);

-- ========= investment --> compliance (17 constraint(s)) =========
-- Requires: investment schema, compliance schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_aml_alert_id` FOREIGN KEY (`aml_alert_id`) REFERENCES `banking_ecm`.`compliance`.`aml_alert`(`aml_alert_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `banking_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`investment`.`league_table` ADD CONSTRAINT `fk_investment_league_table_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= investment --> customer (14 constraint(s)) =========
-- Requires: investment schema, customer schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ADD CONSTRAINT `fk_investment_deal_participation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= investment --> hr (16 constraint(s)) =========
-- Requires: investment schema, hr schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_tertiary_coverage_approved_by_employee_id` FOREIGN KEY (`tertiary_coverage_approved_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`league_table` ADD CONSTRAINT `fk_investment_league_table_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ADD CONSTRAINT `fk_investment_pipeline_stage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ADD CONSTRAINT `fk_investment_deal_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= investment --> ledger (11 constraint(s)) =========
-- Requires: investment schema, ledger schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= investment --> loan (1 constraint(s)) =========
-- Requires: investment schema, loan schema
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);

-- ========= investment --> reference (29 constraint(s)) =========
-- Requires: investment schema, reference schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_market_data_source_id` FOREIGN KEY (`market_data_source_id`) REFERENCES `banking_ecm`.`reference`.`market_data_source`(`market_data_source_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_market_center_id` FOREIGN KEY (`market_center_id`) REFERENCES `banking_ecm`.`reference`.`market_center`(`market_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`league_table` ADD CONSTRAINT `fk_investment_league_table_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= investment --> risk (10 constraint(s)) =========
-- Requires: investment schema, risk schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);

-- ========= investment --> security (11 constraint(s)) =========
-- Requires: investment schema, security schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= investment --> trade (1 constraint(s)) =========
-- Requires: investment schema, trade schema
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ADD CONSTRAINT `fk_investment_deal_broker_participation_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);

-- ========= investment --> treasury (13 constraint(s)) =========
-- Requires: investment schema, treasury schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_debt_issuance_id` FOREIGN KEY (`debt_issuance_id`) REFERENCES `banking_ecm`.`treasury`.`debt_issuance`(`debt_issuance_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);

-- ========= investment --> wealth (3 constraint(s)) =========
-- Requires: investment schema, wealth schema
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_investment_proposal_id` FOREIGN KEY (`investment_proposal_id`) REFERENCES `banking_ecm`.`wealth`.`investment_proposal`(`investment_proposal_id`);

-- ========= ledger --> audit (1 constraint(s)) =========
-- Requires: ledger schema, audit schema
ALTER TABLE `banking_ecm`.`ledger`.`account_testing_scope` ADD CONSTRAINT `fk_ledger_account_testing_scope_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);

-- ========= ledger --> channel (6 constraint(s)) =========
-- Requires: ledger schema, channel schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);

-- ========= ledger --> compliance (11 constraint(s)) =========
-- Requires: ledger schema, compliance schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_regulatory_calendar_id` FOREIGN KEY (`regulatory_calendar_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_calendar`(`regulatory_calendar_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ADD CONSTRAINT `fk_ledger_consolidation_run_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ADD CONSTRAINT `fk_ledger_ledger_sox_control_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= ledger --> hr (40 constraint(s)) =========
-- Requires: ledger schema, hr schema
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_primary_accounting_employee_id` FOREIGN KEY (`primary_accounting_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_quaternary_accounting_sox_certified_by_user_employee_id` FOREIGN KEY (`quaternary_accounting_sox_certified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_quinary_accounting_record_created_by_user_employee_id` FOREIGN KEY (`quinary_accounting_record_created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_tertiary_accounting_permanently_closed_by_user_employee_id` FOREIGN KEY (`tertiary_accounting_permanently_closed_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_tertiary_cost_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_cost_last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_subledger_employee_id` FOREIGN KEY (`subledger_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_primary_subledger_employee_id` FOREIGN KEY (`primary_subledger_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_tertiary_intercompany_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_intercompany_last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_primary_financial_employee_id` FOREIGN KEY (`primary_financial_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_quaternary_financial_task_approver_employee_id` FOREIGN KEY (`quaternary_financial_task_approver_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_quinary_financial_waiver_approved_by_employee_id` FOREIGN KEY (`quinary_financial_waiver_approved_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`financial_close_task` ADD CONSTRAINT `fk_ledger_financial_close_task_tertiary_financial_task_reviewer_employee_id` FOREIGN KEY (`tertiary_financial_task_reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ADD CONSTRAINT `fk_ledger_consolidation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ADD CONSTRAINT `fk_ledger_ledger_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ADD CONSTRAINT `fk_ledger_ledger_sox_control_quaternary_ledger_created_by_employee_id` FOREIGN KEY (`quaternary_ledger_created_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ADD CONSTRAINT `fk_ledger_ledger_sox_control_quinary_ledger_control_owner_employee_id` FOREIGN KEY (`quinary_ledger_control_owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_sox_control` ADD CONSTRAINT `fk_ledger_ledger_sox_control_tertiary_ledger_last_updated_by_employee_id` FOREIGN KEY (`tertiary_ledger_last_updated_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_primary_ledger_employee_id` FOREIGN KEY (`primary_ledger_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_tertiary_ledger_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ledger_last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_primary_tax_employee_id` FOREIGN KEY (`primary_tax_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_reviewer_user_employee_id` FOREIGN KEY (`reviewer_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ADD CONSTRAINT `fk_ledger_task_template_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ADD CONSTRAINT `fk_ledger_task_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`task_template` ADD CONSTRAINT `fk_ledger_task_template_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`ledger`.`recurring_template` ADD CONSTRAINT `fk_ledger_recurring_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= ledger --> payment (2 constraint(s)) =========
-- Requires: ledger schema, payment schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `banking_ecm`.`payment`.`batch`(`batch_id`);

-- ========= ledger --> reference (24 constraint(s)) =========
-- Requires: ledger schema, reference schema
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ADD CONSTRAINT `fk_ledger_chart_of_accounts_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ADD CONSTRAINT `fk_ledger_chart_of_accounts_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`ledger`.`set` ADD CONSTRAINT `fk_ledger_set_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger_reconciliation` ADD CONSTRAINT `fk_ledger_subledger_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_elimination` ADD CONSTRAINT `fk_ledger_intercompany_elimination_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`consolidation_run` ADD CONSTRAINT `fk_ledger_consolidation_run_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`ledger_budget` ADD CONSTRAINT `fk_ledger_ledger_budget_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);

-- ========= ledger --> security (4 constraint(s)) =========
-- Requires: ledger schema, security schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`ledger`.`tax_provision` ADD CONSTRAINT `fk_ledger_tax_provision_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= loan --> account (3 constraint(s)) =========
-- Requires: loan schema, account schema
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= loan --> asset (5 constraint(s)) =========
-- Requires: loan schema, asset schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);

-- ========= loan --> channel (14 constraint(s)) =========
-- Requires: loan schema, channel schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);

-- ========= loan --> collateral (12 constraint(s)) =========
-- Requires: loan schema, collateral schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_review_id` FOREIGN KEY (`review_id`) REFERENCES `banking_ecm`.`collateral`.`review`(`review_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ADD CONSTRAINT `fk_loan_loan_collateral_pledge_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);

-- ========= loan --> compliance (17 constraint(s)) =========
-- Requires: loan schema, compliance schema
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_aml_alert_id` FOREIGN KEY (`aml_alert_id`) REFERENCES `banking_ecm`.`compliance`.`aml_alert`(`aml_alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ADD CONSTRAINT `fk_loan_loan_syndication_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ADD CONSTRAINT `fk_loan_compliance_check_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ADD CONSTRAINT `fk_loan_sanctions_screening_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);

-- ========= loan --> customer (30 constraint(s)) =========
-- Requires: loan schema, customer schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_facility_party_id` FOREIGN KEY (`facility_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ADD CONSTRAINT `fk_loan_loan_syndication_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ADD CONSTRAINT `fk_loan_lender_participation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_tertiary_documentary_case_of_need_party_id` FOREIGN KEY (`tertiary_documentary_case_of_need_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_forfaiting_guarantor_party_id` FOREIGN KEY (`forfaiting_guarantor_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_forfaiting_importer_party_id` FOREIGN KEY (`forfaiting_importer_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_forfaiting_party_id` FOREIGN KEY (`forfaiting_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_guarantee_party_id` FOREIGN KEY (`guarantee_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_advising_bank_party_id` FOREIGN KEY (`advising_bank_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_issuing_bank_party_id` FOREIGN KEY (`issuing_bank_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_nominated_bank_party_id` FOREIGN KEY (`nominated_bank_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_presenting_party_id` FOREIGN KEY (`presenting_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= loan --> fraud (9 constraint(s)) =========
-- Requires: loan schema, fraud schema
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_loss_recovery_id` FOREIGN KEY (`loss_recovery_id`) REFERENCES `banking_ecm`.`fraud`.`loss_recovery`(`loss_recovery_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);

-- ========= loan --> hr (27 constraint(s)) =========
-- Requires: loan schema, hr schema
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ADD CONSTRAINT `fk_loan_loan_syndication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ADD CONSTRAINT `fk_loan_compliance_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ADD CONSTRAINT `fk_loan_sanctions_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_pricing_modified_by_user_employee_id` FOREIGN KEY (`pricing_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_approval_user_employee_id` FOREIGN KEY (`approval_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= loan --> investment (3 constraint(s)) =========
-- Requires: loan schema, investment schema
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ADD CONSTRAINT `fk_loan_lender_participation_syndication_allocation_id` FOREIGN KEY (`syndication_allocation_id`) REFERENCES `banking_ecm`.`investment`.`syndication_allocation`(`syndication_allocation_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);

-- ========= loan --> ledger (15 constraint(s)) =========
-- Requires: loan schema, ledger schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ADD CONSTRAINT `fk_loan_loan_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= loan --> payment (14 constraint(s)) =========
-- Requires: loan schema, payment schema
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ADD CONSTRAINT `fk_loan_loan_fee_schedule_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_confirming_bank_id` FOREIGN KEY (`confirming_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_issuing_bank_id` FOREIGN KEY (`issuing_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_reimbursement_bank_id` FOREIGN KEY (`reimbursement_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);

-- ========= loan --> reference (36 constraint(s)) =========
-- Requires: loan schema, reference schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ADD CONSTRAINT `fk_loan_amortization_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ADD CONSTRAINT `fk_loan_loan_syndication_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ADD CONSTRAINT `fk_loan_lender_participation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ADD CONSTRAINT `fk_loan_loan_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ADD CONSTRAINT `fk_loan_bill_of_lading_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);

-- ========= loan --> risk (16 constraint(s)) =========
-- Requires: loan schema, risk schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ADD CONSTRAINT `fk_loan_lender_participation_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ADD CONSTRAINT `fk_loan_stress_projection_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ADD CONSTRAINT `fk_loan_stress_projection_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);

-- ========= loan --> security (8 constraint(s)) =========
-- Requires: loan schema, security schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= loan --> treasury (17 constraint(s)) =========
-- Requires: loan schema, treasury schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_transfer_pricing_curve_id` FOREIGN KEY (`transfer_pricing_curve_id`) REFERENCES `banking_ecm`.`treasury`.`transfer_pricing_curve`(`transfer_pricing_curve_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_transfer_pricing_curve_id` FOREIGN KEY (`transfer_pricing_curve_id`) REFERENCES `banking_ecm`.`treasury`.`transfer_pricing_curve`(`transfer_pricing_curve_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_hqla_inventory_id` FOREIGN KEY (`hqla_inventory_id`) REFERENCES `banking_ecm`.`treasury`.`hqla_inventory`(`hqla_inventory_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_investment_portfolio_id` FOREIGN KEY (`investment_portfolio_id`) REFERENCES `banking_ecm`.`treasury`.`investment_portfolio`(`investment_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ADD CONSTRAINT `fk_loan_stress_test_result_stress_scenario_cfp_id` FOREIGN KEY (`stress_scenario_cfp_id`) REFERENCES `banking_ecm`.`treasury`.`stress_scenario_cfp`(`stress_scenario_cfp_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ADD CONSTRAINT `fk_loan_facility_cfp_assumption_contingency_funding_plan_id` FOREIGN KEY (`contingency_funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`contingency_funding_plan`(`contingency_funding_plan_id`);

-- ========= loan --> wealth (6 constraint(s)) =========
-- Requires: loan schema, wealth schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= payment --> account (9 constraint(s)) =========
-- Requires: payment schema, account schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_beneficiary_account_id` FOREIGN KEY (`beneficiary_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_creditor_account_id` FOREIGN KEY (`creditor_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_creditor_account_id` FOREIGN KEY (`creditor_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= payment --> audit (3 constraint(s)) =========
-- Requires: payment schema, audit schema
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);

-- ========= payment --> channel (7 constraint(s)) =========
-- Requires: payment schema, channel schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= payment --> collateral (2 constraint(s)) =========
-- Requires: payment schema, collateral schema
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);

-- ========= payment --> compliance (13 constraint(s)) =========
-- Requires: payment schema, compliance schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_aml_alert_id` FOREIGN KEY (`aml_alert_id`) REFERENCES `banking_ecm`.`compliance`.`aml_alert`(`aml_alert_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);

-- ========= payment --> customer (9 constraint(s)) =========
-- Requires: payment schema, customer schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= payment --> fraud (10 constraint(s)) =========
-- Requires: payment schema, fraud schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);

-- ========= payment --> hr (19 constraint(s)) =========
-- Requires: payment schema, hr schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_instruction_employee_id` FOREIGN KEY (`instruction_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_routing_employee_id` FOREIGN KEY (`routing_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_exception_resolved_by_user_employee_id` FOREIGN KEY (`exception_resolved_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_reconciliation_performed_by_user_employee_id` FOREIGN KEY (`reconciliation_performed_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= payment --> investment (13 constraint(s)) =========
-- Requires: payment schema, investment schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_investment_syndication_id` FOREIGN KEY (`investment_syndication_id`) REFERENCES `banking_ecm`.`investment`.`investment_syndication`(`investment_syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_investment_syndication_id` FOREIGN KEY (`investment_syndication_id`) REFERENCES `banking_ecm`.`investment`.`investment_syndication`(`investment_syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_deal_participant_id` FOREIGN KEY (`deal_participant_id`) REFERENCES `banking_ecm`.`investment`.`deal_participant`(`deal_participant_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `banking_ecm`.`investment`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);

-- ========= payment --> ledger (18 constraint(s)) =========
-- Requires: payment schema, ledger schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_receiving_institution_legal_entity_id` FOREIGN KEY (`receiving_institution_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= payment --> reference (39 constraint(s)) =========
-- Requires: payment schema, reference schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_reporting_code_id` FOREIGN KEY (`reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_currency_service` ADD CONSTRAINT `fk_payment_correspondent_currency_service_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= payment --> risk (2 constraint(s)) =========
-- Requires: payment schema, risk schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);

-- ========= payment --> security (9 constraint(s)) =========
-- Requires: payment schema, security schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`exception` ADD CONSTRAINT `fk_payment_exception_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= payment --> trade (6 constraint(s)) =========
-- Requires: payment schema, trade schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_fee` ADD CONSTRAINT `fk_payment_payment_fee_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);

-- ========= payment --> treasury (13 constraint(s)) =========
-- Requires: payment schema, treasury schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_vostro_account_id` FOREIGN KEY (`vostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_vostro_account_id` FOREIGN KEY (`vostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`swift_message` ADD CONSTRAINT `fk_payment_swift_message_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`batch` ADD CONSTRAINT `fk_payment_batch_vostro_account_id` FOREIGN KEY (`vostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_vostro_account_id` FOREIGN KEY (`vostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_vostro_account_id` FOREIGN KEY (`vostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);

-- ========= payment --> wealth (1 constraint(s)) =========
-- Requires: payment schema, wealth schema
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);

-- ========= reference --> security (1 constraint(s)) =========
-- Requires: reference schema, security schema
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ADD CONSTRAINT `fk_reference_instrument_identifier_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);

-- ========= risk --> account (6 constraint(s)) =========
-- Requires: risk schema, account schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= risk --> channel (6 constraint(s)) =========
-- Requires: risk schema, channel schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= risk --> collateral (5 constraint(s)) =========
-- Requires: risk schema, collateral schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);

-- ========= risk --> compliance (12 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ADD CONSTRAINT `fk_risk_irb_model_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_breach_id` FOREIGN KEY (`breach_id`) REFERENCES `banking_ecm`.`compliance`.`breach`(`breach_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `banking_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `banking_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `banking_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= risk --> customer (5 constraint(s)) =========
-- Requires: risk schema, customer schema
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= risk --> hr (18 constraint(s)) =========
-- Requires: risk schema, hr schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_primary_risk_employee_id` FOREIGN KEY (`primary_risk_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ADD CONSTRAINT `fk_risk_irb_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ADD CONSTRAINT `fk_risk_irb_model_primary_irb_employee_id` FOREIGN KEY (`primary_irb_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_primary_operational_event_owner_employee_id` FOREIGN KEY (`primary_operational_event_owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_assessment_assessor_employee_id` FOREIGN KEY (`assessment_assessor_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_assessment_employee_id` FOREIGN KEY (`assessment_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_primary_concentration_employee_id` FOREIGN KEY (`primary_concentration_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_tertiary_risk_reviewed_by_user_employee_id` FOREIGN KEY (`tertiary_risk_reviewed_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ADD CONSTRAINT `fk_risk_model_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= risk --> ledger (11 constraint(s)) =========
-- Requires: risk schema, ledger schema
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_reporting_unit_legal_entity_id` FOREIGN KEY (`reporting_unit_legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ADD CONSTRAINT `fk_risk_model_deployment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= risk --> loan (1 constraint(s)) =========
-- Requires: risk schema, loan schema
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);

-- ========= risk --> reference (17 constraint(s)) =========
-- Requires: risk schema, reference schema
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= risk --> security (1 constraint(s)) =========
-- Requires: risk schema, security schema
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= risk --> trade (1 constraint(s)) =========
-- Requires: risk schema, trade schema
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);

-- ========= risk --> treasury (8 constraint(s)) =========
-- Requires: risk schema, treasury schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_alco_resolution_id` FOREIGN KEY (`alco_resolution_id`) REFERENCES `banking_ecm`.`treasury`.`alco_resolution`(`alco_resolution_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_alm_hedge_id` FOREIGN KEY (`alm_hedge_id`) REFERENCES `banking_ecm`.`treasury`.`alm_hedge`(`alm_hedge_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_ftp_allocation_id` FOREIGN KEY (`ftp_allocation_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_allocation`(`ftp_allocation_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ADD CONSTRAINT `fk_risk_stress_scenario_stress_scenario_cfp_id` FOREIGN KEY (`stress_scenario_cfp_id`) REFERENCES `banking_ecm`.`treasury`.`stress_scenario_cfp`(`stress_scenario_cfp_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_alco_meeting_id` FOREIGN KEY (`alco_meeting_id`) REFERENCES `banking_ecm`.`treasury`.`alco_meeting`(`alco_meeting_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_liquidity_ratio_id` FOREIGN KEY (`liquidity_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_ratio`(`liquidity_ratio_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);

-- ========= security --> channel (1 constraint(s)) =========
-- Requires: security schema, channel schema
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ADD CONSTRAINT `fk_security_instrument_channel_availability_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= security --> collateral (3 constraint(s)) =========
-- Requires: security schema, collateral schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ADD CONSTRAINT `fk_security_instrument_eligibility_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `banking_ecm`.`collateral`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ADD CONSTRAINT `fk_security_instrument_haircut_applicability_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);

-- ========= security --> compliance (8 constraint(s)) =========
-- Requires: security schema, compliance schema
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_compliance_sox_control_id` FOREIGN KEY (`compliance_sox_control_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_sox_control`(`compliance_sox_control_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= security --> customer (2 constraint(s)) =========
-- Requires: security schema, customer schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= security --> hr (4 constraint(s)) =========
-- Requires: security schema, hr schema
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ADD CONSTRAINT `fk_security_security_watchlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ADD CONSTRAINT `fk_security_trading_restriction_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ADD CONSTRAINT `fk_security_trading_restriction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ADD CONSTRAINT `fk_security_trading_restriction_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= security --> ledger (1 constraint(s)) =========
-- Requires: security schema, ledger schema
ALTER TABLE `banking_ecm`.`security`.`security_holding` ADD CONSTRAINT `fk_security_security_holding_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= security --> loan (3 constraint(s)) =========
-- Requires: security schema, loan schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);

-- ========= security --> reference (27 constraint(s)) =========
-- Requires: security schema, reference schema
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_market_center_id` FOREIGN KEY (`market_center_id`) REFERENCES `banking_ecm`.`reference`.`market_center`(`market_center_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_market_data_source_id` FOREIGN KEY (`market_data_source_id`) REFERENCES `banking_ecm`.`reference`.`market_data_source`(`market_data_source_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`classification` ADD CONSTRAINT `fk_security_classification_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`security`.`identifier` ADD CONSTRAINT `fk_security_identifier_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_market_center_id` FOREIGN KEY (`market_center_id`) REFERENCES `banking_ecm`.`reference`.`market_center`(`market_center_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`benchmark` ADD CONSTRAINT `fk_security_benchmark_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ADD CONSTRAINT `fk_security_yield_curve_node_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ADD CONSTRAINT `fk_security_yield_curve_node_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ADD CONSTRAINT `fk_security_instrument_lifecycle_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ADD CONSTRAINT `fk_security_coupon_schedule_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ADD CONSTRAINT `fk_security_coupon_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ADD CONSTRAINT `fk_security_security_watchlist_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= security --> risk (13 constraint(s)) =========
-- Requires: security schema, risk schema
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`security`.`benchmark` ADD CONSTRAINT `fk_security_benchmark_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ADD CONSTRAINT `fk_security_yield_curve_node_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ADD CONSTRAINT `fk_security_instrument_lifecycle_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);

-- ========= security --> trade (1 constraint(s)) =========
-- Requires: security schema, trade schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);

-- ========= security --> treasury (1 constraint(s)) =========
-- Requires: security schema, treasury schema
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ADD CONSTRAINT `fk_security_liquidity_holding_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);

-- ========= trade --> account (1 constraint(s)) =========
-- Requires: trade schema, account schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= trade --> asset (7 constraint(s)) =========
-- Requires: trade schema, asset schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= trade --> audit (1 constraint(s)) =========
-- Requires: trade schema, audit schema
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);

-- ========= trade --> channel (5 constraint(s)) =========
-- Requires: trade schema, channel schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);

-- ========= trade --> collateral (7 constraint(s)) =========
-- Requires: trade schema, collateral schema
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_transfer_id` FOREIGN KEY (`transfer_id`) REFERENCES `banking_ecm`.`collateral`.`transfer`(`transfer_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_collateral_margin_call_id` FOREIGN KEY (`collateral_margin_call_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_margin_call`(`collateral_margin_call_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);

-- ========= trade --> compliance (7 constraint(s)) =========
-- Requires: trade schema, compliance schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= trade --> customer (16 constraint(s)) =========
-- Requires: trade schema, customer schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_amendment_party_id` FOREIGN KEY (`amendment_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_party_id` FOREIGN KEY (`allocation_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`isda_master_agreement` ADD CONSTRAINT `fk_trade_isda_master_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= trade --> hr (19 constraint(s)) =========
-- Requires: trade schema, hr schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_capture_employee_id` FOREIGN KEY (`capture_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_quaternary_trading_head_trader_employee_id` FOREIGN KEY (`quaternary_trading_head_trader_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_tertiary_trading_approved_by_user_employee_id` FOREIGN KEY (`tertiary_trading_approved_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_primary_trade_employee_id` FOREIGN KEY (`primary_trade_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` ADD CONSTRAINT `fk_trade_commission_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= trade --> investment (8 constraint(s)) =========
-- Requires: trade schema, investment schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `banking_ecm`.`investment`.`fee_arrangement`(`fee_arrangement_id`);

-- ========= trade --> ledger (19 constraint(s)) =========
-- Requires: trade schema, ledger schema
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= trade --> payment (1 constraint(s)) =========
-- Requires: trade schema, payment schema
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_swift_message_id` FOREIGN KEY (`swift_message_id`) REFERENCES `banking_ecm`.`payment`.`swift_message`(`swift_message_id`);

-- ========= trade --> reference (50 constraint(s)) =========
-- Requires: trade schema, reference schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_market_center_id` FOREIGN KEY (`market_center_id`) REFERENCES `banking_ecm`.`reference`.`market_center`(`market_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);

-- ========= trade --> risk (13 constraint(s)) =========
-- Requires: trade schema, risk schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_valuation_model_id` FOREIGN KEY (`valuation_model_id`) REFERENCES `banking_ecm`.`risk`.`valuation_model`(`valuation_model_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);

-- ========= trade --> security (9 constraint(s)) =========
-- Requires: trade schema, security schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= trade --> treasury (6 constraint(s)) =========
-- Requires: trade schema, treasury schema
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_balance_sheet_position_id` FOREIGN KEY (`balance_sheet_position_id`) REFERENCES `banking_ecm`.`treasury`.`balance_sheet_position`(`balance_sheet_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_balance_sheet_position_id` FOREIGN KEY (`balance_sheet_position_id`) REFERENCES `banking_ecm`.`treasury`.`balance_sheet_position`(`balance_sheet_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);

-- ========= trade --> wealth (3 constraint(s)) =========
-- Requires: trade schema, wealth schema
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= treasury --> account (5 constraint(s)) =========
-- Requires: treasury schema, account schema
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_certificate_of_deposit_id` FOREIGN KEY (`certificate_of_deposit_id`) REFERENCES `banking_ecm`.`account`.`certificate_of_deposit`(`certificate_of_deposit_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_custodial_account_id` FOREIGN KEY (`custodial_account_id`) REFERENCES `banking_ecm`.`account`.`custodial_account`(`custodial_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`balance_sheet_position` ADD CONSTRAINT `fk_treasury_balance_sheet_position_certificate_of_deposit_id` FOREIGN KEY (`certificate_of_deposit_id`) REFERENCES `banking_ecm`.`account`.`certificate_of_deposit`(`certificate_of_deposit_id`);
ALTER TABLE `banking_ecm`.`treasury`.`balance_sheet_position` ADD CONSTRAINT `fk_treasury_balance_sheet_position_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= treasury --> asset (6 constraint(s)) =========
-- Requires: treasury schema, asset schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`investment_portfolio` ADD CONSTRAINT `fk_treasury_investment_portfolio_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= treasury --> audit (1 constraint(s)) =========
-- Requires: treasury schema, audit schema
ALTER TABLE `banking_ecm`.`treasury`.`alco_meeting` ADD CONSTRAINT `fk_treasury_alco_meeting_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);

-- ========= treasury --> collateral (11 constraint(s)) =========
-- Requires: treasury schema, collateral schema
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_repo_agreement_id` FOREIGN KEY (`repo_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`repo_agreement`(`repo_agreement_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_repo_agreement_id` FOREIGN KEY (`repo_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`repo_agreement`(`repo_agreement_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_csa_agreement_id` FOREIGN KEY (`csa_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`csa_agreement`(`csa_agreement_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`treasury`.`contingency_funding_plan` ADD CONSTRAINT `fk_treasury_contingency_funding_plan_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`treasury`.`stress_scenario_cfp` ADD CONSTRAINT `fk_treasury_stress_scenario_cfp_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);

-- ========= treasury --> compliance (7 constraint(s)) =========
-- Requires: treasury schema, compliance schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alco_meeting` ADD CONSTRAINT `fk_treasury_alco_meeting_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alco_resolution` ADD CONSTRAINT `fk_treasury_alco_resolution_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `banking_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alco_resolution` ADD CONSTRAINT `fk_treasury_alco_resolution_exam_finding_id` FOREIGN KEY (`exam_finding_id`) REFERENCES `banking_ecm`.`compliance`.`exam_finding`(`exam_finding_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `banking_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `banking_ecm`.`treasury`.`contingency_funding_plan` ADD CONSTRAINT `fk_treasury_contingency_funding_plan_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `banking_ecm`.`compliance`.`consent_order`(`consent_order_id`);

-- ========= treasury --> customer (3 constraint(s)) =========
-- Requires: treasury schema, customer schema
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= treasury --> hr (16 constraint(s)) =========
-- Requires: treasury schema, hr schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_tertiary_ftp_approved_by_user_employee_id` FOREIGN KEY (`tertiary_ftp_approved_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alco_meeting` ADD CONSTRAINT `fk_treasury_alco_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_reconciliation` ADD CONSTRAINT `fk_treasury_nostro_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`contingency_funding_plan` ADD CONSTRAINT `fk_treasury_contingency_funding_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`investment_portfolio` ADD CONSTRAINT `fk_treasury_investment_portfolio_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`treasury`.`investment_portfolio` ADD CONSTRAINT `fk_treasury_investment_portfolio_primary_investment_employee_id` FOREIGN KEY (`primary_investment_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= treasury --> ledger (20 constraint(s)) =========
-- Requires: treasury schema, ledger schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alco_meeting` ADD CONSTRAINT `fk_treasury_alco_meeting_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`contingency_funding_plan` ADD CONSTRAINT `fk_treasury_contingency_funding_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`transfer_pricing_curve` ADD CONSTRAINT `fk_treasury_transfer_pricing_curve_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`stress_scenario_cfp` ADD CONSTRAINT `fk_treasury_stress_scenario_cfp_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`balance_sheet_position` ADD CONSTRAINT `fk_treasury_balance_sheet_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`investment_portfolio` ADD CONSTRAINT `fk_treasury_investment_portfolio_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= treasury --> payment (5 constraint(s)) =========
-- Requires: treasury schema, payment schema
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_reconciliation` ADD CONSTRAINT `fk_treasury_nostro_reconciliation_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);

-- ========= treasury --> reference (40 constraint(s)) =========
-- Requires: treasury schema, reference schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_reconciliation` ADD CONSTRAINT `fk_treasury_nostro_reconciliation_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_reconciliation` ADD CONSTRAINT `fk_treasury_nostro_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`contingency_funding_plan` ADD CONSTRAINT `fk_treasury_contingency_funding_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`transfer_pricing_curve` ADD CONSTRAINT `fk_treasury_transfer_pricing_curve_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`transfer_pricing_curve` ADD CONSTRAINT `fk_treasury_transfer_pricing_curve_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`balance_sheet_position` ADD CONSTRAINT `fk_treasury_balance_sheet_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`balance_sheet_position` ADD CONSTRAINT `fk_treasury_balance_sheet_position_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`treasury`.`investment_portfolio` ADD CONSTRAINT `fk_treasury_investment_portfolio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= treasury --> security (5 constraint(s)) =========
-- Requires: treasury schema, security schema
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`investment_portfolio` ADD CONSTRAINT `fk_treasury_investment_portfolio_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);

-- ========= treasury --> trade (1 constraint(s)) =========
-- Requires: treasury schema, trade schema
ALTER TABLE `banking_ecm`.`treasury`.`alm_hedge` ADD CONSTRAINT `fk_treasury_alm_hedge_isda_master_agreement_id` FOREIGN KEY (`isda_master_agreement_id`) REFERENCES `banking_ecm`.`trade`.`isda_master_agreement`(`isda_master_agreement_id`);

-- ========= wealth --> account (7 constraint(s)) =========
-- Requires: wealth schema, account schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ADD CONSTRAINT `fk_wealth_wealth_fee_schedule_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= wealth --> asset (11 constraint(s)) =========
-- Requires: wealth schema, asset schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ADD CONSTRAINT `fk_wealth_wealth_fee_schedule_fund_fee_schedule_id` FOREIGN KEY (`fund_fee_schedule_id`) REFERENCES `banking_ecm`.`asset`.`fund_fee_schedule`(`fund_fee_schedule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= wealth --> channel (20 constraint(s)) =========
-- Requires: wealth schema, channel schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ADD CONSTRAINT `fk_wealth_portfolio_servicing_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);

-- ========= wealth --> collateral (5 constraint(s)) =========
-- Requires: wealth schema, collateral schema
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ADD CONSTRAINT `fk_wealth_portfolio_pledge_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ADD CONSTRAINT `fk_wealth_holding_pledge_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);

-- ========= wealth --> compliance (7 constraint(s)) =========
-- Requires: wealth schema, compliance schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_aml_alert_id` FOREIGN KEY (`aml_alert_id`) REFERENCES `banking_ecm`.`compliance`.`aml_alert`(`aml_alert_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);

-- ========= wealth --> customer (16 constraint(s)) =========
-- Requires: wealth schema, customer schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ADD CONSTRAINT `fk_wealth_wealth_fee_schedule_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= wealth --> hr (25 constraint(s)) =========
-- Requires: wealth schema, hr schema
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_tertiary_rebalancing_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_rebalancing_last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ADD CONSTRAINT `fk_wealth_wealth_fee_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`composite` ADD CONSTRAINT `fk_wealth_composite_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`composite` ADD CONSTRAINT `fk_wealth_composite_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ADD CONSTRAINT `fk_wealth_portfolio_servicing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ADD CONSTRAINT `fk_wealth_portfolio_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ADD CONSTRAINT `fk_wealth_investment_committee_chair_employee_id` FOREIGN KEY (`chair_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ADD CONSTRAINT `fk_wealth_investment_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ADD CONSTRAINT `fk_wealth_investment_committee_secretary_employee_id` FOREIGN KEY (`secretary_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);

-- ========= wealth --> investment (5 constraint(s)) =========
-- Requires: wealth schema, investment schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);

-- ========= wealth --> ledger (7 constraint(s)) =========
-- Requires: wealth schema, ledger schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ADD CONSTRAINT `fk_wealth_wealth_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_prime_broker_entity_id` FOREIGN KEY (`prime_broker_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= wealth --> payment (2 constraint(s)) =========
-- Requires: wealth schema, payment schema
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);

-- ========= wealth --> reference (26 constraint(s)) =========
-- Requires: wealth schema, reference schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_code_list_id` FOREIGN KEY (`code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ADD CONSTRAINT `fk_wealth_portfolio_corporate_action_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`composite` ADD CONSTRAINT `fk_wealth_composite_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_instrument_identifier_id` FOREIGN KEY (`instrument_identifier_id`) REFERENCES `banking_ecm`.`reference`.`instrument_identifier`(`instrument_identifier_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= wealth --> risk (11 constraint(s)) =========
-- Requires: wealth schema, risk schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_liquidity_metric_id` FOREIGN KEY (`liquidity_metric_id`) REFERENCES `banking_ecm`.`risk`.`liquidity_metric`(`liquidity_metric_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ADD CONSTRAINT `fk_wealth_portfolio_stress_application_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ADD CONSTRAINT `fk_wealth_portfolio_stress_application_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);

-- ========= wealth --> security (15 constraint(s)) =========
-- Requires: wealth schema, security schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ADD CONSTRAINT `fk_wealth_portfolio_corporate_action_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ADD CONSTRAINT `fk_wealth_portfolio_corporate_action_new_security_instrument_id` FOREIGN KEY (`new_security_instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`composite` ADD CONSTRAINT `fk_wealth_composite_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ADD CONSTRAINT `fk_wealth_wealth_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= wealth --> trade (7 constraint(s)) =========
-- Requires: wealth schema, trade schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ADD CONSTRAINT `fk_wealth_portfolio_corporate_action_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ADD CONSTRAINT `fk_wealth_portfolio_broker_relationship_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);

-- ========= wealth --> treasury (4 constraint(s)) =========
-- Requires: wealth schema, treasury schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_investment_portfolio_id` FOREIGN KEY (`investment_portfolio_id`) REFERENCES `banking_ecm`.`treasury`.`investment_portfolio`(`investment_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_investment_portfolio_id` FOREIGN KEY (`investment_portfolio_id`) REFERENCES `banking_ecm`.`treasury`.`investment_portfolio`(`investment_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);

