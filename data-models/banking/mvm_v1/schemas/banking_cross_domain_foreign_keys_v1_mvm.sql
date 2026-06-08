-- Cross-Domain Foreign Keys for Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:59
-- Total cross-domain FK constraints: 2002
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: account, asset, channel, collateral, compliance, customer, fraud, investment, ledger, loan, payment, reference, risk, security, trade, treasury, wealth

-- ========= account --> channel (12 constraint(s)) =========
-- Requires: account schema, channel schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= account --> collateral (3 constraint(s)) =========
-- Requires: account schema, collateral schema
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);

-- ========= account --> compliance (7 constraint(s)) =========
-- Requires: account schema, compliance schema
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);

-- ========= account --> customer (8 constraint(s)) =========
-- Requires: account schema, customer schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= account --> fraud (4 constraint(s)) =========
-- Requires: account schema, fraud schema
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);

-- ========= account --> ledger (19 constraint(s)) =========
-- Requires: account schema, ledger schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);

-- ========= account --> loan (7 constraint(s)) =========
-- Requires: account schema, loan schema
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_disbursement_id` FOREIGN KEY (`disbursement_id`) REFERENCES `banking_ecm`.`loan`.`disbursement`(`disbursement_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_drawdown_id` FOREIGN KEY (`drawdown_id`) REFERENCES `banking_ecm`.`loan`.`drawdown`(`drawdown_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_repayment_id` FOREIGN KEY (`repayment_id`) REFERENCES `banking_ecm`.`loan`.`repayment`(`repayment_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_credit_application_id` FOREIGN KEY (`credit_application_id`) REFERENCES `banking_ecm`.`loan`.`credit_application`(`credit_application_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);

-- ========= account --> payment (6 constraint(s)) =========
-- Requires: account schema, payment schema
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_fx_transaction_id` FOREIGN KEY (`fx_transaction_id`) REFERENCES `banking_ecm`.`payment`.`fx_transaction`(`fx_transaction_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_payment_channel_id` FOREIGN KEY (`payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_payment_channel_id` FOREIGN KEY (`payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);

-- ========= account --> reference (22 constraint(s)) =========
-- Requires: account schema, reference schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_benchmark_rate_fixing_id` FOREIGN KEY (`benchmark_rate_fixing_id`) REFERENCES `banking_ecm`.`reference`.`benchmark_rate_fixing`(`benchmark_rate_fixing_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= account --> risk (4 constraint(s)) =========
-- Requires: account schema, risk schema
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);

-- ========= account --> security (5 constraint(s)) =========
-- Requires: account schema, security schema
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ADD CONSTRAINT `fk_account_deposit_account_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);

-- ========= account --> trade (1 constraint(s)) =========
-- Requires: account schema, trade schema
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);

-- ========= account --> treasury (2 constraint(s)) =========
-- Requires: account schema, treasury schema
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);

-- ========= account --> wealth (2 constraint(s)) =========
-- Requires: account schema, wealth schema
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= asset --> account (3 constraint(s)) =========
-- Requires: asset schema, account schema
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);

-- ========= asset --> channel (8 constraint(s)) =========
-- Requires: asset schema, channel schema
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);

-- ========= asset --> customer (10 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_fund_party_id` FOREIGN KEY (`fund_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_fund_transfer_agent_party_id` FOREIGN KEY (`fund_transfer_agent_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= asset --> ledger (17 constraint(s)) =========
-- Requires: asset schema, ledger schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ADD CONSTRAINT `fk_asset_unit_register_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);

-- ========= asset --> payment (1 constraint(s)) =========
-- Requires: asset schema, payment schema
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= asset --> reference (32 constraint(s)) =========
-- Requires: asset schema, reference schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ADD CONSTRAINT `fk_asset_unit_register_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);

-- ========= asset --> risk (7 constraint(s)) =========
-- Requires: asset schema, risk schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);

-- ========= asset --> security (32 constraint(s)) =========
-- Requires: asset schema, security schema
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_derivative_id` FOREIGN KEY (`derivative_id`) REFERENCES `banking_ecm`.`security`.`derivative`(`derivative_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_equity_id` FOREIGN KEY (`equity_id`) REFERENCES `banking_ecm`.`security`.`equity`(`equity_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_fixed_income_id` FOREIGN KEY (`fixed_income_id`) REFERENCES `banking_ecm`.`security`.`fixed_income`(`fixed_income_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_classification_id` FOREIGN KEY (`classification_id`) REFERENCES `banking_ecm`.`security`.`classification`(`classification_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);

-- ========= asset --> trade (2 constraint(s)) =========
-- Requires: asset schema, trade schema
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);

-- ========= asset --> treasury (1 constraint(s)) =========
-- Requires: asset schema, treasury schema
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_debt_issuance_id` FOREIGN KEY (`debt_issuance_id`) REFERENCES `banking_ecm`.`treasury`.`debt_issuance`(`debt_issuance_id`);

-- ========= asset --> wealth (2 constraint(s)) =========
-- Requires: asset schema, wealth schema
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= channel --> account (2 constraint(s)) =========
-- Requires: channel schema, account schema
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= channel --> customer (3 constraint(s)) =========
-- Requires: channel schema, customer schema
ALTER TABLE `banking_ecm`.`channel`.`session` ADD CONSTRAINT `fk_channel_session_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= channel --> fraud (1 constraint(s)) =========
-- Requires: channel schema, fraud schema
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `banking_ecm`.`fraud`.`chargeback`(`chargeback_id`);

-- ========= channel --> ledger (9 constraint(s)) =========
-- Requires: channel schema, ledger schema
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= channel --> payment (2 constraint(s)) =========
-- Requires: channel schema, payment schema
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_card_id` FOREIGN KEY (`card_id`) REFERENCES `banking_ecm`.`payment`.`card`(`card_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= channel --> reference (17 constraint(s)) =========
-- Requires: channel schema, reference schema
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`session` ADD CONSTRAINT `fk_channel_session_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= channel --> security (1 constraint(s)) =========
-- Requires: channel schema, security schema
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);

-- ========= collateral --> account (6 constraint(s)) =========
-- Requires: collateral schema, account schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= collateral --> asset (7 constraint(s)) =========
-- Requires: collateral schema, asset schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_fund_holding_id` FOREIGN KEY (`fund_holding_id`) REFERENCES `banking_ecm`.`asset`.`fund_holding`(`fund_holding_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= collateral --> channel (3 constraint(s)) =========
-- Requires: collateral schema, channel schema
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);

-- ========= collateral --> compliance (11 constraint(s)) =========
-- Requires: collateral schema, compliance schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= collateral --> customer (13 constraint(s)) =========
-- Requires: collateral schema, customer schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_risk_rating_id` FOREIGN KEY (`risk_rating_id`) REFERENCES `banking_ecm`.`customer`.`risk_rating`(`risk_rating_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_tertiary_collateral_pledge_secured_party_id` FOREIGN KEY (`tertiary_collateral_pledge_secured_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_tertiary_pledge_custodian_party_id` FOREIGN KEY (`tertiary_pledge_custodian_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= collateral --> ledger (15 constraint(s)) =========
-- Requires: collateral schema, ledger schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= collateral --> reference (36 constraint(s)) =========
-- Requires: collateral schema, reference schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ADD CONSTRAINT `fk_collateral_haircut_schedule_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);

-- ========= collateral --> risk (5 constraint(s)) =========
-- Requires: collateral schema, risk schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);

-- ========= collateral --> security (8 constraint(s)) =========
-- Requires: collateral schema, security schema
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_classification_id` FOREIGN KEY (`classification_id`) REFERENCES `banking_ecm`.`security`.`classification`(`classification_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= collateral --> trade (1 constraint(s)) =========
-- Requires: collateral schema, trade schema
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);

-- ========= compliance --> account (4 constraint(s)) =========
-- Requires: compliance schema, account schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= compliance --> asset (11 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= compliance --> channel (12 constraint(s)) =========
-- Requires: compliance schema, channel schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_exam` ADD CONSTRAINT `fk_compliance_regulatory_exam_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= compliance --> customer (7 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= compliance --> ledger (4 constraint(s)) =========
-- Requires: compliance schema, ledger schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> payment (1 constraint(s)) =========
-- Requires: compliance schema, payment schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= compliance --> reference (18 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_alert` ADD CONSTRAINT `fk_compliance_aml_alert_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`aml_case` ADD CONSTRAINT `fk_compliance_aml_case_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`compliance`.`kyc_review` ADD CONSTRAINT `fk_compliance_kyc_review_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_screening_event` ADD CONSTRAINT `fk_compliance_sanctions_screening_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_exam` ADD CONSTRAINT `fk_compliance_regulatory_exam_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`ctr_filing` ADD CONSTRAINT `fk_compliance_ctr_filing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`compliance`.`monitoring_rule` ADD CONSTRAINT `fk_compliance_monitoring_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_list_entry` ADD CONSTRAINT `fk_compliance_sanctions_list_entry_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`compliance`.`sanctions_list_entry` ADD CONSTRAINT `fk_compliance_sanctions_list_entry_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= customer --> channel (6 constraint(s)) =========
-- Requires: customer schema, channel schema
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ADD CONSTRAINT `fk_customer_individual_profile_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_document` ADD CONSTRAINT `fk_customer_party_document_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);

-- ========= customer --> compliance (2 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);

-- ========= customer --> investment (1 constraint(s)) =========
-- Requires: customer schema, investment schema
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);

-- ========= customer --> ledger (10 constraint(s)) =========
-- Requires: customer schema, ledger schema
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_segment_assignment` ADD CONSTRAINT `fk_customer_party_segment_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= customer --> reference (20 constraint(s)) =========
-- Requires: customer schema, reference schema
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`customer`.`party` ADD CONSTRAINT `fk_customer_party_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`customer`.`individual_profile` ADD CONSTRAINT `fk_customer_individual_profile_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_address` ADD CONSTRAINT `fk_customer_party_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_contact` ADD CONSTRAINT `fk_customer_party_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_document` ADD CONSTRAINT `fk_customer_party_document_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`customer`.`onboarding_case` ADD CONSTRAINT `fk_customer_onboarding_case_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`customer`.`kyc_review_event` ADD CONSTRAINT `fk_customer_kyc_review_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`customer`.`party_relationship` ADD CONSTRAINT `fk_customer_party_relationship_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= customer --> security (4 constraint(s)) =========
-- Requires: customer schema, security schema
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`customer`.`corporate_profile` ADD CONSTRAINT `fk_customer_corporate_profile_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`customer`.`risk_rating` ADD CONSTRAINT `fk_customer_risk_rating_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);

-- ========= customer --> treasury (1 constraint(s)) =========
-- Requires: customer schema, treasury schema
ALTER TABLE `banking_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);

-- ========= fraud --> account (13 constraint(s)) =========
-- Requires: fraud schema, account schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_claim_provisional_credit_account_deposit_account_id` FOREIGN KEY (`claim_provisional_credit_account_deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= fraud --> asset (34 constraint(s)) =========
-- Requires: fraud schema, asset schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_fund_transaction_id` FOREIGN KEY (`fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);

-- ========= fraud --> channel (23 constraint(s)) =========
-- Requires: fraud schema, channel schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);

-- ========= fraud --> collateral (7 constraint(s)) =========
-- Requires: fraud schema, collateral schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);

-- ========= fraud --> compliance (2 constraint(s)) =========
-- Requires: fraud schema, compliance schema
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= fraud --> customer (10 constraint(s)) =========
-- Requires: fraud schema, customer schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `banking_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= fraud --> investment (8 constraint(s)) =========
-- Requires: fraud schema, investment schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_deal_participant_id` FOREIGN KEY (`deal_participant_id`) REFERENCES `banking_ecm`.`investment`.`deal_participant`(`deal_participant_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_investor_order_id` FOREIGN KEY (`investor_order_id`) REFERENCES `banking_ecm`.`investment`.`investor_order`(`investor_order_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);

-- ========= fraud --> ledger (7 constraint(s)) =========
-- Requires: fraud schema, ledger schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= fraud --> payment (3 constraint(s)) =========
-- Requires: fraud schema, payment schema
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_card_transaction_id` FOREIGN KEY (`card_transaction_id`) REFERENCES `banking_ecm`.`payment`.`card_transaction`(`card_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= fraud --> reference (28 constraint(s)) =========
-- Requires: fraud schema, reference schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);

-- ========= fraud --> risk (5 constraint(s)) =========
-- Requires: fraud schema, risk schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `banking_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_operational_risk_event_id` FOREIGN KEY (`operational_risk_event_id`) REFERENCES `banking_ecm`.`risk`.`operational_risk_event`(`operational_risk_event_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);

-- ========= fraud --> security (12 constraint(s)) =========
-- Requires: fraud schema, security schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_derivative_id` FOREIGN KEY (`derivative_id`) REFERENCES `banking_ecm`.`security`.`derivative`(`derivative_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_derivative_id` FOREIGN KEY (`derivative_id`) REFERENCES `banking_ecm`.`security`.`derivative`(`derivative_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_derivative_id` FOREIGN KEY (`derivative_id`) REFERENCES `banking_ecm`.`security`.`derivative`(`derivative_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);

-- ========= fraud --> trade (9 constraint(s)) =========
-- Requires: fraud schema, trade schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);

-- ========= fraud --> treasury (6 constraint(s)) =========
-- Requires: fraud schema, treasury schema
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_debt_issuance_id` FOREIGN KEY (`debt_issuance_id`) REFERENCES `banking_ecm`.`treasury`.`debt_issuance`(`debt_issuance_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_repo_transaction_id` FOREIGN KEY (`repo_transaction_id`) REFERENCES `banking_ecm`.`treasury`.`repo_transaction`(`repo_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_interbank_placement_id` FOREIGN KEY (`interbank_placement_id`) REFERENCES `banking_ecm`.`treasury`.`interbank_placement`(`interbank_placement_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_repo_transaction_id` FOREIGN KEY (`repo_transaction_id`) REFERENCES `banking_ecm`.`treasury`.`repo_transaction`(`repo_transaction_id`);

-- ========= fraud --> wealth (20 constraint(s)) =========
-- Requires: fraud schema, wealth schema
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`incident` ADD CONSTRAINT `fk_fraud_incident_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_portfolio_transaction_id` FOREIGN KEY (`portfolio_transaction_id`) REFERENCES `banking_ecm`.`wealth`.`portfolio_transaction`(`portfolio_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_portfolio_transaction_id` FOREIGN KEY (`portfolio_transaction_id`) REFERENCES `banking_ecm`.`wealth`.`portfolio_transaction`(`portfolio_transaction_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);

-- ========= investment --> account (1 constraint(s)) =========
-- Requires: investment schema, account schema
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= investment --> asset (7 constraint(s)) =========
-- Requires: investment schema, asset schema
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= investment --> channel (13 constraint(s)) =========
-- Requires: investment schema, channel schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= investment --> collateral (6 constraint(s)) =========
-- Requires: investment schema, collateral schema
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);

-- ========= investment --> compliance (10 constraint(s)) =========
-- Requires: investment schema, compliance schema
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= investment --> customer (14 constraint(s)) =========
-- Requires: investment schema, customer schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_corporate_profile_id` FOREIGN KEY (`corporate_profile_id`) REFERENCES `banking_ecm`.`customer`.`corporate_profile`(`corporate_profile_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `banking_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= investment --> ledger (42 constraint(s)) =========
-- Requires: investment schema, ledger schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);

-- ========= investment --> reference (42 constraint(s)) =========
-- Requires: investment schema, reference schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);

-- ========= investment --> risk (15 constraint(s)) =========
-- Requires: investment schema, risk schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ADD CONSTRAINT `fk_investment_investment_mandate_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);

-- ========= investment --> security (12 constraint(s)) =========
-- Requires: investment schema, security schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`investor_order` ADD CONSTRAINT `fk_investment_investor_order_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= investment --> treasury (16 constraint(s)) =========
-- Requires: investment schema, treasury schema
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_interest_rate_risk_position_id` FOREIGN KEY (`interest_rate_risk_position_id`) REFERENCES `banking_ecm`.`treasury`.`interest_rate_risk_position`(`interest_rate_risk_position_id`);

-- ========= investment --> wealth (8 constraint(s)) =========
-- Requires: investment schema, wealth schema
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `banking_ecm`.`wealth`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication` ADD CONSTRAINT `fk_investment_syndication_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ADD CONSTRAINT `fk_investment_coverage_assignment_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= ledger --> channel (2 constraint(s)) =========
-- Requires: ledger schema, channel schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= ledger --> compliance (1 constraint(s)) =========
-- Requires: ledger schema, compliance schema
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= ledger --> payment (1 constraint(s)) =========
-- Requires: ledger schema, payment schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= ledger --> reference (22 constraint(s)) =========
-- Requires: ledger schema, reference schema
ALTER TABLE `banking_ecm`.`ledger`.`chart_of_accounts` ADD CONSTRAINT `fk_ledger_chart_of_accounts_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`gl_account` ADD CONSTRAINT `fk_ledger_gl_account_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`ledger`.`accounting_period` ADD CONSTRAINT `fk_ledger_accounting_period_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`cost_center` ADD CONSTRAINT `fk_ledger_cost_center_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`legal_entity` ADD CONSTRAINT `fk_ledger_legal_entity_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`ledger`.`intercompany_transaction` ADD CONSTRAINT `fk_ledger_intercompany_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`ledger`.`profit_center` ADD CONSTRAINT `fk_ledger_profit_center_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= ledger --> security (3 constraint(s)) =========
-- Requires: ledger schema, security schema
ALTER TABLE `banking_ecm`.`ledger`.`journal_entry_line` ADD CONSTRAINT `fk_ledger_journal_entry_line_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`ledger`.`subledger` ADD CONSTRAINT `fk_ledger_subledger_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`ledger`.`trial_balance` ADD CONSTRAINT `fk_ledger_trial_balance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= loan --> account (3 constraint(s)) =========
-- Requires: loan schema, account schema
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= loan --> asset (9 constraint(s)) =========
-- Requires: loan schema, asset schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= loan --> channel (14 constraint(s)) =========
-- Requires: loan schema, channel schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= loan --> collateral (16 constraint(s)) =========
-- Requires: loan schema, collateral schema
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);

-- ========= loan --> compliance (21 constraint(s)) =========
-- Requires: loan schema, compliance schema
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_aml_alert_id` FOREIGN KEY (`aml_alert_id`) REFERENCES `banking_ecm`.`compliance`.`aml_alert`(`aml_alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_aml_alert_id` FOREIGN KEY (`aml_alert_id`) REFERENCES `banking_ecm`.`compliance`.`aml_alert`(`aml_alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);

-- ========= loan --> customer (15 constraint(s)) =========
-- Requires: loan schema, customer schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_facility_party_id` FOREIGN KEY (`facility_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_tertiary_documentary_case_of_need_party_id` FOREIGN KEY (`tertiary_documentary_case_of_need_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_guarantee_party_id` FOREIGN KEY (`guarantee_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= loan --> fraud (11 constraint(s)) =========
-- Requires: loan schema, fraud schema
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);

-- ========= loan --> investment (5 constraint(s)) =========
-- Requires: loan schema, investment schema
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_tranche_id` FOREIGN KEY (`tranche_id`) REFERENCES `banking_ecm`.`investment`.`tranche`(`tranche_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);

-- ========= loan --> ledger (16 constraint(s)) =========
-- Requires: loan schema, ledger schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ADD CONSTRAINT `fk_loan_amortization_schedule_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= loan --> payment (11 constraint(s)) =========
-- Requires: loan schema, payment schema
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_payment_mandate_id` FOREIGN KEY (`payment_mandate_id`) REFERENCES `banking_ecm`.`payment`.`payment_mandate`(`payment_mandate_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_fx_transaction_id` FOREIGN KEY (`fx_transaction_id`) REFERENCES `banking_ecm`.`payment`.`fx_transaction`(`fx_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `banking_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_fx_transaction_id` FOREIGN KEY (`fx_transaction_id`) REFERENCES `banking_ecm`.`payment`.`fx_transaction`(`fx_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `banking_ecm`.`payment`.`beneficiary`(`beneficiary_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_fx_transaction_id` FOREIGN KEY (`fx_transaction_id`) REFERENCES `banking_ecm`.`payment`.`fx_transaction`(`fx_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);

-- ========= loan --> reference (46 constraint(s)) =========
-- Requires: loan schema, reference schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ADD CONSTRAINT `fk_loan_amortization_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ADD CONSTRAINT `fk_loan_amortization_schedule_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);

-- ========= loan --> risk (13 constraint(s)) =========
-- Requires: loan schema, risk schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `banking_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);

-- ========= loan --> security (11 constraint(s)) =========
-- Requires: loan schema, security schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);

-- ========= loan --> trade (6 constraint(s)) =========
-- Requires: loan schema, trade schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);

-- ========= loan --> treasury (9 constraint(s)) =========
-- Requires: loan schema, treasury schema
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);

-- ========= loan --> wealth (19 constraint(s)) =========
-- Requires: loan schema, wealth schema
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility` ADD CONSTRAINT `fk_loan_facility_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ADD CONSTRAINT `fk_loan_credit_application_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);

-- ========= payment --> account (6 constraint(s)) =========
-- Requires: payment schema, account schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_instruction_deposit_account_id` FOREIGN KEY (`instruction_deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= payment --> asset (1 constraint(s)) =========
-- Requires: payment schema, asset schema
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= payment --> channel (15 constraint(s)) =========
-- Requires: payment schema, channel schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= payment --> collateral (10 constraint(s)) =========
-- Requires: payment schema, collateral schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_margin_call_id` FOREIGN KEY (`margin_call_id`) REFERENCES `banking_ecm`.`collateral`.`margin_call`(`margin_call_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_collateral_position_id` FOREIGN KEY (`collateral_position_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_position`(`collateral_position_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_margin_call_id` FOREIGN KEY (`margin_call_id`) REFERENCES `banking_ecm`.`collateral`.`margin_call`(`margin_call_id`);

-- ========= payment --> compliance (7 constraint(s)) =========
-- Requires: payment schema, compliance schema
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_ctr_filing_id` FOREIGN KEY (`ctr_filing_id`) REFERENCES `banking_ecm`.`compliance`.`ctr_filing`(`ctr_filing_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);

-- ========= payment --> customer (11 constraint(s)) =========
-- Requires: payment schema, customer schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `banking_ecm`.`customer`.`account_holder`(`account_holder_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= payment --> fraud (2 constraint(s)) =========
-- Requires: payment schema, fraud schema
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `banking_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);

-- ========= payment --> investment (20 constraint(s)) =========
-- Requires: payment schema, investment schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_investor_order_id` FOREIGN KEY (`investor_order_id`) REFERENCES `banking_ecm`.`investment`.`investor_order`(`investor_order_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_tranche_id` FOREIGN KEY (`tranche_id`) REFERENCES `banking_ecm`.`investment`.`tranche`(`tranche_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_deal_participant_id` FOREIGN KEY (`deal_participant_id`) REFERENCES `banking_ecm`.`investment`.`deal_participant`(`deal_participant_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_tranche_id` FOREIGN KEY (`tranche_id`) REFERENCES `banking_ecm`.`investment`.`tranche`(`tranche_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);

-- ========= payment --> ledger (35 constraint(s)) =========
-- Requires: payment schema, ledger schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= payment --> reference (54 constraint(s)) =========
-- Requires: payment schema, reference schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`beneficiary` ADD CONSTRAINT `fk_payment_beneficiary_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_mandate` ADD CONSTRAINT `fk_payment_payment_mandate_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`card_transaction` ADD CONSTRAINT `fk_payment_card_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`sanction_screening` ADD CONSTRAINT `fk_payment_sanction_screening_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_benchmark_rate_fixing_id` FOREIGN KEY (`benchmark_rate_fixing_id`) REFERENCES `banking_ecm`.`reference`.`benchmark_rate_fixing`(`benchmark_rate_fixing_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_channel` ADD CONSTRAINT `fk_payment_payment_channel_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`card` ADD CONSTRAINT `fk_payment_card_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`payment`.`merchant` ADD CONSTRAINT `fk_payment_merchant_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= payment --> risk (5 constraint(s)) =========
-- Requires: payment schema, risk schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`payment`.`correspondent_bank` ADD CONSTRAINT `fk_payment_correspondent_bank_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);

-- ========= payment --> security (10 constraint(s)) =========
-- Requires: payment schema, security schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= payment --> trade (10 constraint(s)) =========
-- Requires: payment schema, trade schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_clearing_house_id` FOREIGN KEY (`clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);

-- ========= payment --> treasury (13 constraint(s)) =========
-- Requires: payment schema, treasury schema
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`payment`.`instruction` ADD CONSTRAINT `fk_payment_instruction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`status_event` ADD CONSTRAINT `fk_payment_status_event_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`return` ADD CONSTRAINT `fk_payment_return_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`clearing_record` ADD CONSTRAINT `fk_payment_clearing_record_repo_transaction_id` FOREIGN KEY (`repo_transaction_id`) REFERENCES `banking_ecm`.`treasury`.`repo_transaction`(`repo_transaction_id`);
ALTER TABLE `banking_ecm`.`payment`.`routing` ADD CONSTRAINT `fk_payment_routing_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_reconciliation_vostro_account_nostro_account_id` FOREIGN KEY (`reconciliation_vostro_account_nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);

-- ========= payment --> wealth (3 constraint(s)) =========
-- Requires: payment schema, wealth schema
ALTER TABLE `banking_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`payment`.`fx_transaction` ADD CONSTRAINT `fk_payment_fx_transaction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);

-- ========= risk --> account (2 constraint(s)) =========
-- Requires: risk schema, account schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= risk --> asset (5 constraint(s)) =========
-- Requires: risk schema, asset schema
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `banking_ecm`.`asset`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= risk --> channel (6 constraint(s)) =========
-- Requires: risk schema, channel schema
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= risk --> collateral (9 constraint(s)) =========
-- Requires: risk schema, collateral schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);

-- ========= risk --> compliance (8 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= risk --> customer (7 constraint(s)) =========
-- Requires: risk schema, customer schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `banking_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= risk --> ledger (23 constraint(s)) =========
-- Requires: risk schema, ledger schema
ALTER TABLE `banking_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ADD CONSTRAINT `fk_risk_stress_scenario_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= risk --> loan (2 constraint(s)) =========
-- Requires: risk schema, loan schema
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);

-- ========= risk --> payment (2 constraint(s)) =========
-- Requires: risk schema, payment schema
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_status_event_id` FOREIGN KEY (`status_event_id`) REFERENCES `banking_ecm`.`payment`.`status_event`(`status_event_id`);

-- ========= risk --> reference (28 constraint(s)) =========
-- Requires: risk schema, reference schema
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ADD CONSTRAINT `fk_risk_stress_scenario_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= risk --> security (1 constraint(s)) =========
-- Requires: risk schema, security schema
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= risk --> trade (6 constraint(s)) =========
-- Requires: risk schema, trade schema
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);

-- ========= risk --> treasury (8 constraint(s)) =========
-- Requires: risk schema, treasury schema
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_interbank_placement_id` FOREIGN KEY (`interbank_placement_id`) REFERENCES `banking_ecm`.`treasury`.`interbank_placement`(`interbank_placement_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_liquidity_ratio_id` FOREIGN KEY (`liquidity_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_ratio`(`liquidity_ratio_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_capital_ratio_id` FOREIGN KEY (`capital_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`capital_ratio`(`capital_ratio_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);

-- ========= security --> collateral (1 constraint(s)) =========
-- Requires: security schema, collateral schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);

-- ========= security --> compliance (5 constraint(s)) =========
-- Requires: security schema, compliance schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`security`.`classification` ADD CONSTRAINT `fk_security_classification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= security --> customer (2 constraint(s)) =========
-- Requires: security schema, customer schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= security --> ledger (4 constraint(s)) =========
-- Requires: security schema, ledger schema
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`security`.`classification` ADD CONSTRAINT `fk_security_classification_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `banking_ecm`.`ledger`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= security --> loan (1 constraint(s)) =========
-- Requires: security schema, loan schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);

-- ========= security --> reference (30 constraint(s)) =========
-- Requires: security schema, reference schema
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_industry_code_id` FOREIGN KEY (`industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`identifier` ADD CONSTRAINT `fk_security_identifier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`benchmark` ADD CONSTRAINT `fk_security_benchmark_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`benchmark` ADD CONSTRAINT `fk_security_benchmark_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);

-- ========= security --> risk (6 constraint(s)) =========
-- Requires: security schema, risk schema
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_credit_exposure_id` FOREIGN KEY (`credit_exposure_id`) REFERENCES `banking_ecm`.`risk`.`credit_exposure`(`credit_exposure_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`security`.`benchmark` ADD CONSTRAINT `fk_security_benchmark_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);

-- ========= security --> trade (1 constraint(s)) =========
-- Requires: security schema, trade schema
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);

-- ========= trade --> account (3 constraint(s)) =========
-- Requires: trade schema, account schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= trade --> asset (11 constraint(s)) =========
-- Requires: trade schema, asset schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_fund_holding_id` FOREIGN KEY (`fund_holding_id`) REFERENCES `banking_ecm`.`asset`.`fund_holding`(`fund_holding_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);

-- ========= trade --> channel (4 constraint(s)) =========
-- Requires: trade schema, channel schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);

-- ========= trade --> collateral (19 constraint(s)) =========
-- Requires: trade schema, collateral schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);

-- ========= trade --> compliance (22 constraint(s)) =========
-- Requires: trade schema, compliance schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_aml_case_id` FOREIGN KEY (`aml_case_id`) REFERENCES `banking_ecm`.`compliance`.`aml_case`(`aml_case_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= trade --> customer (15 constraint(s)) =========
-- Requires: trade schema, customer schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_party_id` FOREIGN KEY (`allocation_party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_risk_rating_id` FOREIGN KEY (`risk_rating_id`) REFERENCES `banking_ecm`.`customer`.`risk_rating`(`risk_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= trade --> investment (20 constraint(s)) =========
-- Requires: trade schema, investment schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_transaction_structure_id` FOREIGN KEY (`transaction_structure_id`) REFERENCES `banking_ecm`.`investment`.`transaction_structure`(`transaction_structure_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_investment_valuation_id` FOREIGN KEY (`investment_valuation_id`) REFERENCES `banking_ecm`.`investment`.`investment_valuation`(`investment_valuation_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_investment_valuation_id` FOREIGN KEY (`investment_valuation_id`) REFERENCES `banking_ecm`.`investment`.`investment_valuation`(`investment_valuation_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_transaction_structure_id` FOREIGN KEY (`transaction_structure_id`) REFERENCES `banking_ecm`.`investment`.`transaction_structure`(`transaction_structure_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_syndication_id` FOREIGN KEY (`syndication_id`) REFERENCES `banking_ecm`.`investment`.`syndication`(`syndication_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_tranche_id` FOREIGN KEY (`tranche_id`) REFERENCES `banking_ecm`.`investment`.`tranche`(`tranche_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_transaction_structure_id` FOREIGN KEY (`transaction_structure_id`) REFERENCES `banking_ecm`.`investment`.`transaction_structure`(`transaction_structure_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `banking_ecm`.`investment`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_underwriting_id` FOREIGN KEY (`underwriting_id`) REFERENCES `banking_ecm`.`investment`.`underwriting`(`underwriting_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);

-- ========= trade --> ledger (30 constraint(s)) =========
-- Requires: trade schema, ledger schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_subledger_id` FOREIGN KEY (`subledger_id`) REFERENCES `banking_ecm`.`ledger`.`subledger`(`subledger_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= trade --> reference (48 constraint(s)) =========
-- Requires: trade schema, reference schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_benchmark_rate_fixing_id` FOREIGN KEY (`benchmark_rate_fixing_id`) REFERENCES `banking_ecm`.`reference`.`benchmark_rate_fixing`(`benchmark_rate_fixing_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_exchange_rate_id` FOREIGN KEY (`exchange_rate_id`) REFERENCES `banking_ecm`.`reference`.`exchange_rate`(`exchange_rate_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);

-- ========= trade --> risk (13 constraint(s)) =========
-- Requires: trade schema, risk schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);

-- ========= trade --> security (17 constraint(s)) =========
-- Requires: trade schema, security schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `banking_ecm`.`security`.`listing`(`listing_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= trade --> treasury (11 constraint(s)) =========
-- Requires: trade schema, treasury schema
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_interest_rate_risk_position_id` FOREIGN KEY (`interest_rate_risk_position_id`) REFERENCES `banking_ecm`.`treasury`.`interest_rate_risk_position`(`interest_rate_risk_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);

-- ========= trade --> wealth (8 constraint(s)) =========
-- Requires: trade schema, wealth schema
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);

-- ========= treasury --> account (2 constraint(s)) =========
-- Requires: treasury schema, account schema
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_interest_rate_id` FOREIGN KEY (`interest_rate_id`) REFERENCES `banking_ecm`.`account`.`interest_rate`(`interest_rate_id`);

-- ========= treasury --> asset (6 constraint(s)) =========
-- Requires: treasury schema, asset schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= treasury --> channel (1 constraint(s)) =========
-- Requires: treasury schema, channel schema
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);

-- ========= treasury --> collateral (12 constraint(s)) =========
-- Requires: treasury schema, collateral schema
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `banking_ecm`.`collateral`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);

-- ========= treasury --> compliance (15 constraint(s)) =========
-- Requires: treasury schema, compliance schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);

-- ========= treasury --> customer (4 constraint(s)) =========
-- Requires: treasury schema, customer schema
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_onboarding_case_id` FOREIGN KEY (`onboarding_case_id`) REFERENCES `banking_ecm`.`customer`.`onboarding_case`(`onboarding_case_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `banking_ecm`.`customer`.`segment`(`segment_id`);

-- ========= treasury --> ledger (39 constraint(s)) =========
-- Requires: treasury schema, ledger schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= treasury --> payment (4 constraint(s)) =========
-- Requires: treasury schema, payment schema
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `banking_ecm`.`payment`.`correspondent_bank`(`correspondent_bank_id`);

-- ========= treasury --> reference (38 constraint(s)) =========
-- Requires: treasury schema, reference schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ADD CONSTRAINT `fk_treasury_nostro_account_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);

-- ========= treasury --> risk (10 constraint(s)) =========
-- Requires: treasury schema, risk schema
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ADD CONSTRAINT `fk_treasury_capital_plan_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ADD CONSTRAINT `fk_treasury_cash_flow_forecast_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);

-- ========= treasury --> security (11 constraint(s)) =========
-- Requires: treasury schema, security schema
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);

-- ========= treasury --> trade (7 constraint(s)) =========
-- Requires: treasury schema, trade schema
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ADD CONSTRAINT `fk_treasury_interbank_placement_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_clearing_house_id` FOREIGN KEY (`clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ADD CONSTRAINT `fk_treasury_repo_position_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ADD CONSTRAINT `fk_treasury_interest_rate_risk_position_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);

-- ========= wealth --> account (8 constraint(s)) =========
-- Requires: wealth schema, account schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `banking_ecm`.`account`.`statement`(`statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= wealth --> asset (21 constraint(s)) =========
-- Requires: wealth schema, asset schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `banking_ecm`.`asset`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);

-- ========= wealth --> channel (19 constraint(s)) =========
-- Requires: wealth schema, channel schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);

-- ========= wealth --> collateral (7 constraint(s)) =========
-- Requires: wealth schema, collateral schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `banking_ecm`.`collateral`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);

-- ========= wealth --> compliance (15 constraint(s)) =========
-- Requires: wealth schema, compliance schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_kyc_review_id` FOREIGN KEY (`kyc_review_id`) REFERENCES `banking_ecm`.`compliance`.`kyc_review`(`kyc_review_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_monitoring_rule_id` FOREIGN KEY (`monitoring_rule_id`) REFERENCES `banking_ecm`.`compliance`.`monitoring_rule`(`monitoring_rule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `banking_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `banking_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_regulatory_exam_id` FOREIGN KEY (`regulatory_exam_id`) REFERENCES `banking_ecm`.`compliance`.`regulatory_exam`(`regulatory_exam_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_sanctions_screening_event_id` FOREIGN KEY (`sanctions_screening_event_id`) REFERENCES `banking_ecm`.`compliance`.`sanctions_screening_event`(`sanctions_screening_event_id`);

-- ========= wealth --> customer (15 constraint(s)) =========
-- Requires: wealth schema, customer schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_risk_rating_id` FOREIGN KEY (`risk_rating_id`) REFERENCES `banking_ecm`.`customer`.`risk_rating`(`risk_rating_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_kyc_record_id` FOREIGN KEY (`kyc_record_id`) REFERENCES `banking_ecm`.`customer`.`kyc_record`(`kyc_record_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_individual_profile_id` FOREIGN KEY (`individual_profile_id`) REFERENCES `banking_ecm`.`customer`.`individual_profile`(`individual_profile_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_party_id` FOREIGN KEY (`party_id`) REFERENCES `banking_ecm`.`customer`.`party`(`party_id`);

-- ========= wealth --> investment (2 constraint(s)) =========
-- Requires: wealth schema, investment schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);

-- ========= wealth --> ledger (21 constraint(s)) =========
-- Requires: wealth schema, ledger schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `banking_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `banking_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `banking_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `banking_ecm`.`ledger`.`profit_center`(`profit_center_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `banking_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `banking_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= wealth --> payment (3 constraint(s)) =========
-- Requires: wealth schema, payment schema
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `banking_ecm`.`payment`.`instruction`(`instruction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_payment_mandate_id` FOREIGN KEY (`payment_mandate_id`) REFERENCES `banking_ecm`.`payment`.`payment_mandate`(`payment_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_payment_channel_id` FOREIGN KEY (`payment_channel_id`) REFERENCES `banking_ecm`.`payment`.`payment_channel`(`payment_channel_id`);

-- ========= wealth --> reference (26 constraint(s)) =========
-- Requires: wealth schema, reference schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `banking_ecm`.`reference`.`product_type`(`product_type_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_bic_directory_id` FOREIGN KEY (`bic_directory_id`) REFERENCES `banking_ecm`.`reference`.`bic_directory`(`bic_directory_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);

-- ========= wealth --> risk (22 constraint(s)) =========
-- Requires: wealth schema, risk schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_market_risk_position_id` FOREIGN KEY (`market_risk_position_id`) REFERENCES `banking_ecm`.`risk`.`market_risk_position`(`market_risk_position_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);

-- ========= wealth --> security (17 constraint(s)) =========
-- Requires: wealth schema, security schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_credit_rating_id` FOREIGN KEY (`credit_rating_id`) REFERENCES `banking_ecm`.`security`.`credit_rating`(`credit_rating_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_corporate_action_id` FOREIGN KEY (`corporate_action_id`) REFERENCES `banking_ecm`.`security`.`corporate_action`(`corporate_action_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_price_id` FOREIGN KEY (`price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= wealth --> trade (7 constraint(s)) =========
-- Requires: wealth schema, trade schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);

-- ========= wealth --> treasury (5 constraint(s)) =========
-- Requires: wealth schema, treasury schema
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `banking_ecm`.`treasury`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);

