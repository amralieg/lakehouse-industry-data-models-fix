-- Metric views for domain: transaction | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_property_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core property sale transaction metrics including pricing, financing, and deal performance KPIs"
  source: "`real_estate_ecm`.`transaction`.`property_sale`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the property sale transaction"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing used for the transaction"
    - name: "deed_type"
      expr: deed_type
      comment: "Type of deed used in the property transfer"
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Flag indicating whether transaction is a 1031 tax-deferred exchange"
    - name: "contingency_type"
      expr: contingency_type
      comment: "Type of contingency applied to the transaction"
    - name: "closing_year"
      expr: YEAR(closing_date)
      comment: "Year when the transaction closed"
    - name: "closing_quarter"
      expr: CONCAT('Q', QUARTER(closing_date), '-', YEAR(closing_date))
      comment: "Quarter and year when the transaction closed"
    - name: "closing_month"
      expr: DATE_TRUNC('MONTH', closing_date)
      comment: "Month when the transaction closed"
    - name: "contract_year"
      expr: YEAR(contract_date)
      comment: "Year when the contract was signed"
  measures:
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total gross purchase price across all transactions"
    - name: "total_net_sale_price"
      expr: SUM(CAST(net_sale_price AS DOUBLE))
      comment: "Total net sale price after adjustments and concessions"
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per transaction"
    - name: "avg_price_per_sqft"
      expr: AVG(CAST(price_psf AS DOUBLE))
      comment: "Average price per square foot across transactions"
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total financing amount across all transactions"
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across financed transactions"
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate at time of sale"
    - name: "total_earnest_money"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money deposits across transactions"
    - name: "total_seller_concessions"
      expr: SUM(CAST(seller_concessions_amount AS DOUBLE))
      comment: "Total seller concessions granted across transactions"
    - name: "total_transfer_tax"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer tax paid across transactions"
    - name: "transaction_count"
      expr: COUNT(property_sale_id)
      comment: "Total number of property sale transactions"
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(closing_date, contract_date))
      comment: "Average number of days from contract to closing"
    - name: "exchange_1031_count"
      expr: SUM(CASE WHEN is_1031_exchange = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions structured as 1031 exchanges"
    - name: "exchange_1031_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_1031_exchange = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(property_sale_id), 0), 2)
      comment: "Percentage of transactions that are 1031 exchanges"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_closing_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closing statement financial metrics including sale proceeds, commissions, and settlement costs"
  source: "`real_estate_ecm`.`transaction`.`closing_statement`"
  dimensions:
    - name: "closing_status"
      expr: closing_status
      comment: "Status of the closing statement"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of closing statement"
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Flag indicating 1031 exchange transaction"
    - name: "is_reo_transaction"
      expr: is_reo_transaction
      comment: "Flag indicating real estate owned (REO) transaction"
    - name: "closing_year"
      expr: YEAR(closing_date)
      comment: "Year of closing"
    - name: "closing_quarter"
      expr: CONCAT('Q', QUARTER(closing_date), '-', YEAR(closing_date))
      comment: "Quarter and year of closing"
    - name: "closing_month"
      expr: DATE_TRUNC('MONTH', closing_date)
      comment: "Month of closing"
  measures:
    - name: "total_gross_sale_price"
      expr: SUM(CAST(gross_sale_price AS DOUBLE))
      comment: "Total gross sale price before adjustments"
    - name: "total_net_proceeds_to_seller"
      expr: SUM(CAST(net_proceeds_to_seller AS DOUBLE))
      comment: "Total net proceeds distributed to sellers after all costs"
    - name: "total_commission_amount"
      expr: SUM(CAST(total_commission_amount AS DOUBLE))
      comment: "Total brokerage commissions paid"
    - name: "avg_commission_rate"
      expr: ROUND(100.0 * AVG(CAST(total_commission_amount AS DOUBLE) / NULLIF(CAST(gross_sale_price AS DOUBLE), 0)), 2)
      comment: "Average commission rate as percentage of gross sale price"
    - name: "total_loan_payoff"
      expr: SUM(CAST(loan_payoff_amount AS DOUBLE))
      comment: "Total loan payoff amounts across closings"
    - name: "total_new_loan_amount"
      expr: SUM(CAST(new_loan_amount AS DOUBLE))
      comment: "Total new financing originated at closing"
    - name: "total_earnest_money"
      expr: SUM(CAST(earnest_money_deposit AS DOUBLE))
      comment: "Total earnest money deposits applied at closing"
    - name: "total_buyer_credits"
      expr: SUM(CAST(buyer_credit_amount AS DOUBLE))
      comment: "Total credits issued to buyers"
    - name: "total_seller_credits"
      expr: SUM(CAST(seller_credit_amount AS DOUBLE))
      comment: "Total credits issued to sellers"
    - name: "total_title_insurance_premium"
      expr: SUM(CAST(title_insurance_premium AS DOUBLE))
      comment: "Total title insurance premiums paid"
    - name: "total_transfer_tax"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer taxes paid"
    - name: "total_settlement_fees"
      expr: SUM(CAST(settlement_fee_amount AS DOUBLE))
      comment: "Total settlement and escrow fees"
    - name: "total_recording_fees"
      expr: SUM(CAST(recording_fee_amount AS DOUBLE))
      comment: "Total recording fees paid to jurisdictions"
    - name: "avg_cash_to_close"
      expr: AVG(CAST(cash_to_close AS DOUBLE))
      comment: "Average cash required from buyer at closing"
    - name: "closing_count"
      expr: COUNT(closing_statement_id)
      comment: "Total number of closing statements"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer activity and conversion metrics including pricing dynamics and contingency analysis"
  source: "`real_estate_ecm`.`transaction`.`offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing proposed in offer"
    - name: "escalation_clause_flag"
      expr: escalation_clause_flag
      comment: "Whether offer includes escalation clause"
    - name: "appraisal_contingency_flag"
      expr: appraisal_contingency_flag
      comment: "Whether offer includes appraisal contingency"
    - name: "sale_contingency_flag"
      expr: sale_contingency_flag
      comment: "Whether offer is contingent on sale of another property"
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Whether offer is for 1031 exchange transaction"
    - name: "competing_offer_flag"
      expr: competing_offer_flag
      comment: "Whether offer is in competition with other offers"
    - name: "offer_year"
      expr: YEAR(offer_date)
      comment: "Year offer was submitted"
    - name: "offer_quarter"
      expr: CONCAT('Q', QUARTER(offer_date), '-', YEAR(offer_date))
      comment: "Quarter and year offer was submitted"
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month offer was submitted"
  measures:
    - name: "total_offer_value"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Total value of all offers submitted"
    - name: "avg_offer_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average offer price"
    - name: "avg_price_per_sqft"
      expr: AVG(CAST(price_psf AS DOUBLE))
      comment: "Average offer price per square foot"
    - name: "total_earnest_money"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money deposits offered"
    - name: "avg_earnest_money_rate"
      expr: ROUND(100.0 * AVG(CAST(earnest_money_amount AS DOUBLE) / NULLIF(CAST(price AS DOUBLE), 0)), 2)
      comment: "Average earnest money as percentage of offer price"
    - name: "total_seller_concessions"
      expr: SUM(CAST(seller_concessions_amount AS DOUBLE))
      comment: "Total seller concessions requested in offers"
    - name: "avg_financing_contingency"
      expr: AVG(CAST(financing_contingency_amount AS DOUBLE))
      comment: "Average financing contingency amount"
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio in offers"
    - name: "avg_escalation_ceiling"
      expr: AVG(CAST(escalation_ceiling_price AS DOUBLE))
      comment: "Average escalation ceiling price for offers with escalation clauses"
    - name: "offer_count"
      expr: COUNT(offer_id)
      comment: "Total number of offers submitted"
    - name: "accepted_offer_count"
      expr: SUM(CASE WHEN offer_status = 'Accepted' THEN 1 ELSE 0 END)
      comment: "Number of offers accepted"
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offer_status = 'Accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(offer_id), 0), 2)
      comment: "Percentage of offers that are accepted"
    - name: "competing_offer_count"
      expr: SUM(CASE WHEN competing_offer_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of offers in competitive situations"
    - name: "avg_due_diligence_days"
      expr: AVG(CAST(due_diligence_period_days AS INT))
      comment: "Average due diligence period requested in days"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_financing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loan origination and debt financing metrics including leverage, rates, and debt service coverage"
  source: "`real_estate_ecm`.`transaction`.`financing`"
  dimensions:
    - name: "financing_status"
      expr: financing_status
      comment: "Current status of the financing"
    - name: "loan_type"
      expr: loan_type
      comment: "Type of loan product"
    - name: "rate_type"
      expr: rate_type
      comment: "Interest rate type (fixed, variable, etc.)"
    - name: "lien_position"
      expr: lien_position
      comment: "Lien position of the loan"
    - name: "recourse_type"
      expr: recourse_type
      comment: "Recourse type (full recourse, non-recourse, etc.)"
    - name: "amortization_type"
      expr: amortization_type
      comment: "Type of amortization schedule"
    - name: "is_assumption"
      expr: is_assumption
      comment: "Whether loan is an assumption of existing debt"
    - name: "pmi_required"
      expr: pmi_required
      comment: "Whether private mortgage insurance is required"
    - name: "origination_year"
      expr: YEAR(origination_date)
      comment: "Year loan was originated"
    - name: "origination_quarter"
      expr: CONCAT('Q', QUARTER(origination_date), '-', YEAR(origination_date))
      comment: "Quarter and year of loan origination"
    - name: "maturity_year"
      expr: YEAR(maturity_date)
      comment: "Year loan matures"
  measures:
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total loan amount originated"
    - name: "avg_loan_amount"
      expr: AVG(CAST(loan_amount AS DOUBLE))
      comment: "Average loan amount per financing"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding loan balance across all loans"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across loans"
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio"
    - name: "avg_loan_to_cost_ratio"
      expr: AVG(CAST(loan_to_cost_ratio AS DOUBLE))
      comment: "Average loan-to-cost ratio for development/construction loans"
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average debt service coverage ratio"
    - name: "total_annual_debt_service"
      expr: SUM(CAST(annual_debt_service AS DOUBLE))
      comment: "Total annual debt service across all loans"
    - name: "total_origination_fees"
      expr: SUM(CAST(origination_fee_amount AS DOUBLE))
      comment: "Total origination fees collected"
    - name: "avg_origination_fee_pct"
      expr: AVG(CAST(origination_fee_pct AS DOUBLE))
      comment: "Average origination fee as percentage of loan amount"
    - name: "avg_rate_spread"
      expr: AVG(CAST(rate_spread AS DOUBLE))
      comment: "Average spread over index rate for variable rate loans"
    - name: "total_escrow_reserves"
      expr: SUM(CAST(escrow_reserve_amount AS DOUBLE))
      comment: "Total escrow reserves required"
    - name: "loan_count"
      expr: COUNT(financing_id)
      comment: "Total number of loans originated"
    - name: "avg_loan_term_months"
      expr: AVG(CAST(loan_term_months AS INT))
      comment: "Average loan term in months"
    - name: "avg_amortization_months"
      expr: AVG(CAST(amortization_period_months AS INT))
      comment: "Average amortization period in months"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_reo_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real estate owned (REO) disposition performance metrics including loss severity and recovery rates"
  source: "`real_estate_ecm`.`transaction`.`reo_disposition`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the REO disposition"
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method used to dispose of the REO property"
    - name: "condition_rating"
      expr: condition_rating
      comment: "Property condition rating at time of REO acquisition"
    - name: "environmental_issue_flag"
      expr: environmental_issue_flag
      comment: "Whether property has environmental issues"
    - name: "title_cleared"
      expr: title_cleared
      comment: "Whether title has been cleared for sale"
    - name: "hoa_flag"
      expr: hoa_flag
      comment: "Whether property is subject to HOA"
    - name: "foreclosure_year"
      expr: YEAR(foreclosure_date)
      comment: "Year property was foreclosed"
    - name: "reo_acquisition_year"
      expr: YEAR(reo_acquisition_date)
      comment: "Year property was acquired as REO"
    - name: "closing_year"
      expr: YEAR(closing_date)
      comment: "Year REO property was sold"
  measures:
    - name: "total_final_sale_price"
      expr: SUM(CAST(final_sale_price AS DOUBLE))
      comment: "Total sale proceeds from REO dispositions"
    - name: "avg_final_sale_price"
      expr: AVG(CAST(final_sale_price AS DOUBLE))
      comment: "Average sale price per REO disposition"
    - name: "total_outstanding_loan_balance"
      expr: SUM(CAST(outstanding_loan_balance AS DOUBLE))
      comment: "Total outstanding loan balance at time of foreclosure"
    - name: "total_loss_severity"
      expr: SUM(CAST(loss_severity_amount AS DOUBLE))
      comment: "Total loss amount across all REO dispositions"
    - name: "avg_loss_severity_pct"
      expr: AVG(CAST(loss_severity_pct AS DOUBLE))
      comment: "Average loss severity as percentage of outstanding balance"
    - name: "total_net_recovery"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery amount after all costs"
    - name: "avg_recovery_rate"
      expr: ROUND(100.0 * AVG(CAST(net_recovery_amount AS DOUBLE) / NULLIF(CAST(outstanding_loan_balance AS DOUBLE), 0)), 2)
      comment: "Average recovery rate as percentage of outstanding loan balance"
    - name: "total_carrying_costs"
      expr: SUM(CAST(carrying_costs AS DOUBLE))
      comment: "Total carrying costs during REO holding period"
    - name: "total_disposition_costs"
      expr: SUM(CAST(disposition_costs AS DOUBLE))
      comment: "Total costs to dispose of REO properties"
    - name: "total_repair_costs"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair costs incurred"
    - name: "avg_as_is_value"
      expr: AVG(CAST(as_is_appraised_value AS DOUBLE))
      comment: "Average as-is appraised value at REO acquisition"
    - name: "avg_days_on_market"
      expr: AVG(CAST(days_on_market AS INT))
      comment: "Average days on market for REO properties"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average initial list price"
    - name: "avg_price_reduction_count"
      expr: AVG(CAST(price_reduction_count AS INT))
      comment: "Average number of price reductions per property"
    - name: "reo_disposition_count"
      expr: COUNT(reo_disposition_id)
      comment: "Total number of REO dispositions"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_auction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Auction performance metrics including bidding activity, reserve achievement, and sale conversion"
  source: "`real_estate_ecm`.`transaction`.`auction`"
  dimensions:
    - name: "auction_status"
      expr: auction_status
      comment: "Current status of the auction"
    - name: "auction_type"
      expr: auction_type
      comment: "Type of auction (absolute, reserve, etc.)"
    - name: "auction_venue_type"
      expr: auction_venue_type
      comment: "Venue type (online, live, hybrid)"
    - name: "reserve_met_flag"
      expr: reserve_met_flag
      comment: "Whether reserve price was met"
    - name: "sale_confirmed_flag"
      expr: sale_confirmed_flag
      comment: "Whether sale was confirmed after auction"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year auction was scheduled"
    - name: "scheduled_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_date), '-', YEAR(scheduled_date))
      comment: "Quarter and year auction was scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month auction was scheduled"
  measures:
    - name: "total_winning_bid_amount"
      expr: SUM(CAST(winning_bid_amount AS DOUBLE))
      comment: "Total winning bid amounts across all auctions"
    - name: "avg_winning_bid_amount"
      expr: AVG(CAST(winning_bid_amount AS DOUBLE))
      comment: "Average winning bid amount per auction"
    - name: "total_reserve_price"
      expr: SUM(CAST(reserve_price_amount AS DOUBLE))
      comment: "Total reserve prices set across auctions"
    - name: "avg_reserve_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(winning_bid_amount AS DOUBLE) / NULLIF(CAST(reserve_price_amount AS DOUBLE), 0)), 2)
      comment: "Average winning bid as percentage of reserve price"
    - name: "avg_starting_bid"
      expr: AVG(CAST(starting_bid_amount AS DOUBLE))
      comment: "Average starting bid amount"
    - name: "avg_bid_increment"
      expr: AVG(CAST(bid_increment_amount AS DOUBLE))
      comment: "Average bid increment amount"
    - name: "avg_buyers_premium_pct"
      expr: AVG(CAST(buyers_premium_percentage AS DOUBLE))
      comment: "Average buyer's premium percentage"
    - name: "total_deposit_required"
      expr: SUM(CAST(deposit_required_amount AS DOUBLE))
      comment: "Total deposits required across auctions"
    - name: "avg_registered_bidders"
      expr: AVG(CAST(registered_bidders_count AS INT))
      comment: "Average number of registered bidders per auction"
    - name: "avg_total_bids"
      expr: AVG(CAST(total_bids_received AS INT))
      comment: "Average number of bids received per auction"
    - name: "auction_count"
      expr: COUNT(auction_id)
      comment: "Total number of auctions held"
    - name: "reserve_met_count"
      expr: SUM(CASE WHEN reserve_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of auctions where reserve was met"
    - name: "reserve_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reserve_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(auction_id), 0), 2)
      comment: "Percentage of auctions where reserve was met"
    - name: "sale_confirmed_count"
      expr: SUM(CASE WHEN sale_confirmed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of auctions resulting in confirmed sales"
    - name: "sale_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sale_confirmed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(auction_id), 0), 2)
      comment: "Percentage of auctions resulting in confirmed sales"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_escrow_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escrow account management metrics including balances, deposits, disbursements, and reconciliation status"
  source: "`real_estate_ecm`.`transaction`.`escrow_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the escrow account"
    - name: "account_type"
      expr: account_type
      comment: "Type of escrow account"
    - name: "earnest_money_status"
      expr: earnest_money_status
      comment: "Status of earnest money deposit"
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Whether account is for 1031 exchange"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the account"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year escrow account was opened"
    - name: "opening_quarter"
      expr: CONCAT('Q', QUARTER(opening_date), '-', YEAR(opening_date))
      comment: "Quarter and year account was opened"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all escrow accounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per escrow account"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balances"
    - name: "total_deposits"
      expr: SUM(CAST(total_deposits AS DOUBLE))
      comment: "Total deposits into escrow accounts"
    - name: "total_disbursements"
      expr: SUM(CAST(total_disbursements AS DOUBLE))
      comment: "Total disbursements from escrow accounts"
    - name: "total_earnest_money"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money held in escrow"
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase prices for transactions in escrow"
    - name: "total_loan_payoff"
      expr: SUM(CAST(loan_payoff_amount AS DOUBLE))
      comment: "Total loan payoff amounts held in escrow"
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Total net proceeds to be distributed from escrow"
    - name: "total_commission"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commissions held in escrow for disbursement"
    - name: "total_title_fees"
      expr: SUM(CAST(title_fee_amount AS DOUBLE))
      comment: "Total title fees held in escrow"
    - name: "total_transfer_tax"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer taxes held in escrow"
    - name: "total_impound_tax"
      expr: SUM(CAST(impound_tax_amount AS DOUBLE))
      comment: "Total property tax impounds"
    - name: "total_impound_insurance"
      expr: SUM(CAST(impound_insurance_amount AS DOUBLE))
      comment: "Total insurance impounds"
    - name: "escrow_account_count"
      expr: COUNT(escrow_account_id)
      comment: "Total number of escrow accounts"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_exchange_1031`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "1031 tax-deferred exchange metrics including gain deferral, boot analysis, and IRS compliance tracking"
  source: "`real_estate_ecm`.`transaction`.`exchange_1031`"
  dimensions:
    - name: "exchange_status"
      expr: exchange_status
      comment: "Current status of the 1031 exchange"
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of 1031 exchange (simultaneous, delayed, reverse, etc.)"
    - name: "identification_rule"
      expr: identification_rule
      comment: "Identification rule used (3-property, 200%, 95%)"
    - name: "boot_type"
      expr: boot_type
      comment: "Type of boot received (cash, mortgage relief, etc.)"
    - name: "like_kind_confirmed"
      expr: like_kind_confirmed
      comment: "Whether like-kind property requirement is confirmed"
    - name: "form_8824_filed"
      expr: form_8824_filed
      comment: "Whether IRS Form 8824 has been filed"
    - name: "irs_compliance_status"
      expr: irs_compliance_status
      comment: "IRS compliance status of the exchange"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year exchange was initiated"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the exchange"
  measures:
    - name: "total_relinquished_sale_price"
      expr: SUM(CAST(relinquished_sale_price AS DOUBLE))
      comment: "Total sale price of relinquished properties"
    - name: "avg_relinquished_sale_price"
      expr: AVG(CAST(relinquished_sale_price AS DOUBLE))
      comment: "Average sale price of relinquished properties"
    - name: "total_replacement_purchase_price"
      expr: SUM(CAST(replacement_purchase_price AS DOUBLE))
      comment: "Total purchase price of replacement properties"
    - name: "avg_replacement_purchase_price"
      expr: AVG(CAST(replacement_purchase_price AS DOUBLE))
      comment: "Average purchase price of replacement properties"
    - name: "total_deferred_gain"
      expr: SUM(CAST(deferred_gain AS DOUBLE))
      comment: "Total capital gain deferred through 1031 exchanges"
    - name: "total_recognized_gain"
      expr: SUM(CAST(recognized_gain AS DOUBLE))
      comment: "Total gain recognized (not deferred) due to boot or other factors"
    - name: "total_realized_gain"
      expr: SUM(CAST(realized_gain AS DOUBLE))
      comment: "Total realized gain on relinquished properties"
    - name: "avg_gain_deferral_rate"
      expr: ROUND(100.0 * AVG(CAST(deferred_gain AS DOUBLE) / NULLIF(CAST(realized_gain AS DOUBLE), 0)), 2)
      comment: "Average percentage of realized gain that is deferred"
    - name: "total_boot_amount"
      expr: SUM(CAST(boot_amount AS DOUBLE))
      comment: "Total boot received across exchanges"
    - name: "total_relinquished_adjusted_basis"
      expr: SUM(CAST(relinquished_adjusted_basis AS DOUBLE))
      comment: "Total adjusted basis of relinquished properties"
    - name: "total_replacement_basis"
      expr: SUM(CAST(replacement_basis AS DOUBLE))
      comment: "Total basis in replacement properties"
    - name: "total_relinquished_mortgage"
      expr: SUM(CAST(relinquished_mortgage_balance AS DOUBLE))
      comment: "Total mortgage balance on relinquished properties"
    - name: "total_replacement_mortgage"
      expr: SUM(CAST(replacement_mortgage_balance AS DOUBLE))
      comment: "Total mortgage on replacement properties"
    - name: "total_selling_expenses"
      expr: SUM(CAST(selling_expenses AS DOUBLE))
      comment: "Total selling expenses for relinquished properties"
    - name: "avg_qi_fund_balance"
      expr: AVG(CAST(qi_fund_balance AS DOUBLE))
      comment: "Average qualified intermediary fund balance"
    - name: "exchange_count"
      expr: COUNT(exchange_1031_id)
      comment: "Total number of 1031 exchanges"
    - name: "avg_replacement_property_count"
      expr: AVG(CAST(replacement_property_count AS INT))
      comment: "Average number of replacement properties per exchange"
$$;