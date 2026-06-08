-- Metric views for domain: transaction | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_property_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for property sale transactions — covers transaction volume, pricing performance, financing mix, and capital efficiency metrics used by investment committees and executive leadership."
  source: "`real_estate_ecm`.`transaction`.`property_sale`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the property sale transaction (e.g. Active, Closed, Cancelled) — used to filter pipeline vs. closed book."
    - name: "transaction_type"
      expr: financing_type
      comment: "Financing type associated with the sale (e.g. Conventional, Cash, FHA) — key segmentation for buyer profile analysis."
    - name: "closing_month"
      expr: DATE_TRUNC('MONTH', closing_date)
      comment: "Month in which the sale closed — enables time-series trending of closed transaction volume and revenue."
    - name: "closing_year"
      expr: YEAR(closing_date)
      comment: "Fiscal year of closing — supports annual performance benchmarking and YoY comparisons."
    - name: "deed_type"
      expr: deed_type
      comment: "Type of deed used in the transfer (e.g. Warranty, Quitclaim) — relevant for title risk and compliance segmentation."
    - name: "contingency_type"
      expr: contingency_type
      comment: "Type of contingency on the sale (e.g. Financing, Inspection, Sale-of-Home) — used to assess deal risk and fall-through rates."
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Indicates whether the transaction is structured as a 1031 tax-deferred exchange — critical for tax strategy reporting."
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', contract_date)
      comment: "Month the purchase contract was executed — used to measure pipeline build and contract-to-close lag."
  measures:
    - name: "total_closed_transactions"
      expr: COUNT(DISTINCT property_sale_id)
      comment: "Total number of distinct closed property sale transactions — primary volume KPI for the sales pipeline."
    - name: "total_gross_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total gross purchase price across all transactions — top-line revenue indicator for the transaction portfolio."
    - name: "total_net_sale_price"
      expr: SUM(CAST(net_sale_price AS DOUBLE))
      comment: "Total net sale price after seller concessions — reflects actual realized revenue net of buyer credits."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per transaction — used to track market pricing trends and portfolio mix shifts."
    - name: "avg_price_per_sqft"
      expr: AVG(CAST(price_psf AS DOUBLE))
      comment: "Average sale price per square foot — key real estate efficiency metric for cross-property and market comparisons."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate at time of sale — core investment return metric used by acquisition and disposition teams."
    - name: "total_earnest_money"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money deposits held across transactions — indicates buyer commitment depth and pipeline quality."
    - name: "total_transfer_tax"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer taxes paid across all closed transactions — material cost line for disposition planning and net proceeds modeling."
    - name: "total_seller_concessions"
      expr: SUM(CAST(seller_concessions_amount AS DOUBLE))
      comment: "Total seller concessions granted — measures negotiation leakage from gross to net sale price."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across financed transactions — key credit risk and leverage indicator for the portfolio."
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total debt financing originated across all transactions — measures leverage deployed in the transaction portfolio."
    - name: "avg_noi_at_sale"
      expr: AVG(CAST(noi_at_sale AS DOUBLE))
      comment: "Average net operating income at time of sale — used to validate cap rate calculations and assess income quality of disposed assets."
    - name: "concession_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(seller_concessions_amount AS DOUBLE)) / NULLIF(SUM(CAST(purchase_price AS DOUBLE)), 0), 2)
      comment: "Seller concessions as a percentage of total purchase price — measures negotiation efficiency and pricing discipline."
    - name: "exchange_1031_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN is_1031_exchange = TRUE THEN property_sale_id END)
      comment: "Number of transactions structured as 1031 exchanges — tracks tax-deferral strategy utilization across the portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_closing_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial settlement KPIs derived from closing statements — covers gross proceeds, commission economics, net seller proceeds, financing costs, and closing fee efficiency for transaction management and finance teams."
  source: "`real_estate_ecm`.`transaction`.`closing_statement`"
  dimensions:
    - name: "closing_status"
      expr: closing_status
      comment: "Status of the closing statement (e.g. Pending, Finalized, Voided) — used to filter settled vs. in-progress closings."
    - name: "statement_type"
      expr: statement_type
      comment: "Type of closing statement (e.g. Buyer, Seller, Combined) — enables party-specific financial analysis."
    - name: "closing_month"
      expr: DATE_TRUNC('MONTH', closing_date)
      comment: "Month of closing — supports time-series analysis of settlement volumes and financial flows."
    - name: "closing_year"
      expr: YEAR(closing_date)
      comment: "Year of closing — enables annual aggregation of settlement financials."
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Flags closing statements associated with 1031 tax-deferred exchanges — used for tax strategy reporting."
    - name: "is_reo_transaction"
      expr: is_reo_transaction
      comment: "Flags Real Estate Owned (bank-owned/foreclosure) transactions — used to segment distressed vs. market-rate closings."
    - name: "title_company_name"
      expr: title_company_name
      comment: "Name of the title company handling the closing — used to evaluate title partner performance and concentration."
    - name: "disbursement_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month of disbursement — used to reconcile cash flow timing against closing dates."
  measures:
    - name: "total_gross_sale_price"
      expr: SUM(CAST(gross_sale_price AS DOUBLE))
      comment: "Total gross sale price across all closing statements — top-line transaction revenue before deductions."
    - name: "total_net_proceeds_to_seller"
      expr: SUM(CAST(net_proceeds_to_seller AS DOUBLE))
      comment: "Total net proceeds distributed to sellers — the primary bottom-line metric for seller financial outcomes."
    - name: "total_cash_to_close"
      expr: SUM(CAST(cash_to_close AS DOUBLE))
      comment: "Total cash required to close across all transactions — measures buyer liquidity demand and financing gap."
    - name: "total_commission_amount"
      expr: SUM(CAST(total_commission_amount AS DOUBLE))
      comment: "Total brokerage commissions paid at closing — key cost line for transaction economics and brokerage revenue tracking."
    - name: "total_buyer_broker_commission"
      expr: SUM(CAST(buyer_broker_commission AS DOUBLE))
      comment: "Total buyer-side broker commissions — used to analyze buyer representation cost trends post-NAR settlement changes."
    - name: "total_listing_broker_commission"
      expr: SUM(CAST(listing_broker_commission AS DOUBLE))
      comment: "Total listing-side broker commissions — measures seller-side brokerage cost across the portfolio."
    - name: "avg_cap_rate_at_closing"
      expr: AVG(CAST(cap_rate_at_closing AS DOUBLE))
      comment: "Average capitalization rate at closing — validates investment return assumptions against actual transaction pricing."
    - name: "total_loan_payoff_amount"
      expr: SUM(CAST(loan_payoff_amount AS DOUBLE))
      comment: "Total debt paid off at closing — measures deleveraging activity and encumbrance clearance across the portfolio."
    - name: "total_transfer_tax"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer taxes paid at closing — material transaction cost for disposition planning and net proceeds modeling."
    - name: "total_title_insurance_premium"
      expr: SUM(CAST(title_insurance_premium AS DOUBLE))
      comment: "Total title insurance premiums paid — tracks title risk cost across the transaction portfolio."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio at closing — key leverage and credit risk indicator for financed transactions."
    - name: "commission_as_pct_of_gross_price"
      expr: ROUND(100.0 * SUM(CAST(total_commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sale_price AS DOUBLE)), 0), 2)
      comment: "Total commission as a percentage of gross sale price — measures brokerage cost efficiency and negotiation outcomes."
    - name: "net_proceeds_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_proceeds_to_seller AS DOUBLE)) / NULLIF(SUM(CAST(gross_sale_price AS DOUBLE)), 0), 2)
      comment: "Net proceeds to seller as a percentage of gross sale price — measures how much of the gross price sellers actually retain after all closing costs."
    - name: "total_earnest_money_deposit"
      expr: SUM(CAST(earnest_money_deposit AS DOUBLE))
      comment: "Total earnest money deposits recorded on closing statements — tracks buyer commitment capital held in escrow."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer pipeline and conversion KPIs — tracks offer volume, pricing aggressiveness, contingency risk, and competitive dynamics to support acquisition strategy and brokerage performance management."
  source: "`real_estate_ecm`.`transaction`.`offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (e.g. Submitted, Accepted, Rejected, Countered, Withdrawn) — primary dimension for pipeline funnel analysis."
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing proposed in the offer (e.g. Conventional, Cash, FHA, VA) — used to assess buyer quality and deal certainty."
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month the offer was submitted — enables time-series analysis of offer volume and market activity."
    - name: "offer_year"
      expr: YEAR(offer_date)
      comment: "Year the offer was submitted — supports annual pipeline and conversion benchmarking."
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Flags offers structured as 1031 exchanges — used to track tax-motivated buyer activity."
    - name: "escalation_clause_flag"
      expr: escalation_clause_flag
      comment: "Indicates whether the offer includes an escalation clause — signals competitive market conditions and buyer aggressiveness."
    - name: "appraisal_contingency_flag"
      expr: appraisal_contingency_flag
      comment: "Indicates whether the offer includes an appraisal contingency — used to assess deal risk and likelihood of price renegotiation."
    - name: "sale_contingency_flag"
      expr: sale_contingency_flag
      comment: "Indicates whether the offer is contingent on the buyer selling their existing home — key risk factor for deal certainty."
  measures:
    - name: "total_offers_submitted"
      expr: COUNT(DISTINCT offer_id)
      comment: "Total number of distinct offers submitted — primary volume metric for acquisition pipeline activity."
    - name: "total_accepted_offers"
      expr: COUNT(DISTINCT CASE WHEN offer_status = 'Accepted' THEN offer_id END)
      comment: "Number of offers that were accepted — measures conversion success at the offer stage."
    - name: "offer_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN offer_status = 'Accepted' THEN offer_id END) / NULLIF(COUNT(DISTINCT offer_id), 0), 2)
      comment: "Percentage of submitted offers that were accepted — key conversion rate KPI for acquisition efficiency."
    - name: "avg_offer_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average offer price submitted — tracks pricing aggressiveness and market demand trends over time."
    - name: "avg_offer_price_per_sqft"
      expr: AVG(CAST(price_psf AS DOUBLE))
      comment: "Average offer price per square foot — enables cross-property pricing comparison and market benchmarking."
    - name: "total_earnest_money_offered"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money committed across all offers — measures buyer commitment capital and deal seriousness."
    - name: "avg_earnest_money_per_offer"
      expr: AVG(CAST(earnest_money_amount AS DOUBLE))
      comment: "Average earnest money per offer — used to assess buyer commitment levels and negotiate deal terms."
    - name: "avg_seller_concessions_requested"
      expr: AVG(CAST(seller_concessions_amount AS DOUBLE))
      comment: "Average seller concessions requested per offer — measures buyer negotiation pressure and market softness."
    - name: "total_seller_concessions_requested"
      expr: SUM(CAST(seller_concessions_amount AS DOUBLE))
      comment: "Total seller concessions requested across all offers — tracks aggregate negotiation leakage in the pipeline."
    - name: "avg_pre_approval_amount"
      expr: AVG(CAST(pre_approval_amount AS DOUBLE))
      comment: "Average buyer pre-approval amount — indicates buyer purchasing power and financing headroom relative to offer prices."
    - name: "competitive_offer_count"
      expr: COUNT(DISTINCT CASE WHEN competing_offer_flag = TRUE THEN offer_id END)
      comment: "Number of offers submitted in competitive multi-offer situations — measures market competitiveness and demand intensity."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across offers — tracks buyer leverage levels and associated financing risk."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_financing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt financing KPIs for real estate transactions — covers loan volume, leverage ratios, debt service coverage, interest rate exposure, and financing cost efficiency for capital markets and investment management teams."
  source: "`real_estate_ecm`.`transaction`.`financing`"
  dimensions:
    - name: "financing_status"
      expr: financing_status
      comment: "Current status of the financing (e.g. Committed, Funded, Matured, Defaulted) — primary dimension for debt portfolio health monitoring."
    - name: "loan_type"
      expr: loan_type
      comment: "Type of loan (e.g. Permanent, Bridge, Construction, Mezzanine) — key segmentation for debt strategy and risk analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Interest rate type (Fixed vs. Floating) — critical for interest rate risk exposure analysis."
    - name: "lien_position"
      expr: lien_position
      comment: "Lien position of the loan (e.g. First, Second, Mezzanine) — used to assess credit seniority and recovery risk."
    - name: "recourse_type"
      expr: recourse_type
      comment: "Recourse structure of the loan (Full, Partial, Non-Recourse) — key risk dimension for lender and borrower exposure analysis."
    - name: "origination_year"
      expr: YEAR(origination_date)
      comment: "Year the loan was originated — used for vintage analysis and maturity wall planning."
    - name: "maturity_month"
      expr: DATE_TRUNC('MONTH', maturity_date)
      comment: "Month the loan matures — critical for refinancing pipeline planning and maturity wall management."
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the financing (e.g. Acquisition, Refinance, Construction) — used to segment debt by strategic use of proceeds."
    - name: "amortization_type"
      expr: amortization_type
      comment: "Amortization structure (e.g. Interest Only, Fully Amortizing, Partial IO) — used to model cash flow and debt paydown profiles."
  measures:
    - name: "total_loan_originations"
      expr: COUNT(DISTINCT financing_id)
      comment: "Total number of distinct financing arrangements originated — measures debt activity volume across the portfolio."
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total principal loan amount originated — primary measure of debt capital deployed across the portfolio."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding loan balance — measures current debt exposure and leverage across the portfolio."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across all financing arrangements — tracks cost of debt and interest rate exposure."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio — primary leverage metric used by lenders and investment committees to assess credit risk."
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average debt service coverage ratio — key underwriting metric indicating whether property income sufficiently covers debt obligations."
    - name: "avg_loan_to_cost_ratio"
      expr: AVG(CAST(loan_to_cost_ratio AS DOUBLE))
      comment: "Average loan-to-cost ratio — used for construction and value-add financing to assess lender advance rates relative to total project cost."
    - name: "total_annual_debt_service"
      expr: SUM(CAST(annual_debt_service AS DOUBLE))
      comment: "Total annual debt service obligations across the portfolio — critical for cash flow planning and liquidity stress testing."
    - name: "total_origination_fees"
      expr: SUM(CAST(origination_fee_amount AS DOUBLE))
      comment: "Total origination fees paid across all financings — measures transaction cost of debt capital."
    - name: "avg_origination_fee_pct"
      expr: AVG(CAST(origination_fee_pct AS DOUBLE))
      comment: "Average origination fee as a percentage of loan amount — benchmarks lender fee competitiveness across the debt portfolio."
    - name: "total_escrow_reserve_amount"
      expr: SUM(CAST(escrow_reserve_amount AS DOUBLE))
      comment: "Total escrow reserves required by lenders — measures capital set aside for taxes, insurance, and capex reserves."
    - name: "floating_rate_loan_count"
      expr: COUNT(DISTINCT CASE WHEN rate_type = 'Floating' THEN financing_id END)
      comment: "Number of floating-rate loans in the portfolio — used to quantify interest rate risk exposure requiring hedging."
    - name: "avg_rate_spread"
      expr: AVG(CAST(rate_spread AS DOUBLE))
      comment: "Average spread over the index rate for floating-rate loans — measures credit premium and lender pricing trends."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_escrow_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escrow account management KPIs — tracks escrow balances, earnest money flows, disbursement activity, and reconciliation health for transaction operations and treasury management."
  source: "`real_estate_ecm`.`transaction`.`escrow_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the escrow account (e.g. Open, Closed, Pending Release) — primary dimension for escrow portfolio health monitoring."
    - name: "account_type"
      expr: account_type
      comment: "Type of escrow account (e.g. Sales, 1031 Exchange, Impound) — used to segment escrow activity by purpose."
    - name: "earnest_money_status"
      expr: earnest_money_status
      comment: "Status of earnest money within the escrow (e.g. Received, Forfeited, Returned, Applied) — tracks earnest money disposition outcomes."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the escrow account — used to identify accounts requiring remediation or audit attention."
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Flags escrow accounts associated with 1031 exchanges — used for tax-deferred exchange compliance monitoring."
    - name: "opening_month"
      expr: DATE_TRUNC('MONTH', opening_date)
      comment: "Month the escrow account was opened — used to track escrow pipeline build over time."
    - name: "expected_closing_month"
      expr: DATE_TRUNC('MONTH', expected_closing_date)
      comment: "Expected closing month — used for forward-looking cash flow and disbursement planning."
    - name: "escrow_holder_name"
      expr: escrow_holder_name
      comment: "Name of the escrow holder/company — used to evaluate escrow partner concentration and performance."
  measures:
    - name: "total_escrow_accounts"
      expr: COUNT(DISTINCT escrow_account_id)
      comment: "Total number of active escrow accounts — measures escrow pipeline volume and operational workload."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance held across all escrow accounts — measures total capital under escrow management."
    - name: "total_earnest_money_held"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money deposits held in escrow — measures buyer commitment capital at risk in the pipeline."
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Total net proceeds held in escrow pending disbursement — measures seller proceeds awaiting release."
    - name: "total_disbursements"
      expr: SUM(CAST(total_disbursements AS DOUBLE))
      comment: "Total disbursements made from escrow accounts — measures cash outflow activity and settlement throughput."
    - name: "total_deposits"
      expr: SUM(CAST(total_deposits AS DOUBLE))
      comment: "Total deposits received into escrow accounts — measures cash inflow and funding activity."
    - name: "total_impound_tax_amount"
      expr: SUM(CAST(impound_tax_amount AS DOUBLE))
      comment: "Total property tax impound amounts held in escrow — tracks tax reserve adequacy across the portfolio."
    - name: "total_impound_insurance_amount"
      expr: SUM(CAST(impound_insurance_amount AS DOUBLE))
      comment: "Total insurance impound amounts held in escrow — tracks insurance reserve adequacy across the portfolio."
    - name: "avg_purchase_price_in_escrow"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price of properties with open escrow accounts — indicates average deal size in the active pipeline."
    - name: "net_escrow_position"
      expr: SUM(CAST(total_deposits AS DOUBLE) - CAST(total_disbursements AS DOUBLE))
      comment: "Net escrow position (deposits minus disbursements) — measures undisbursed capital and escrow settlement completeness."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_escrow_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escrow disbursement KPIs — tracks payment flows, commission economics, withholding compliance, and disbursement efficiency for transaction settlement and financial operations teams."
  source: "`real_estate_ecm`.`transaction`.`escrow_disbursement`"
  dimensions:
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement (e.g. Pending, Completed, Voided, Returned) — primary dimension for payment operations monitoring."
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement (e.g. Commission, Loan Payoff, Net Proceeds, Transfer Tax) — used to analyze payment flow composition."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee receiving the disbursement (e.g. Broker, Lender, Seller, Government) — used to segment payment flows by recipient category."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. Wire, Check, ACH) — used to assess payment efficiency and operational risk."
    - name: "disbursement_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month of disbursement — enables time-series analysis of settlement cash flows."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status of the disbursement — used to identify unauthorized or pending-approval payments requiring action."
    - name: "is_1031_exchange_proceeds"
      expr: is_1031_exchange_proceeds
      comment: "Flags disbursements representing 1031 exchange proceeds — critical for tax compliance and QI fund tracking."
    - name: "is_post_closing"
      expr: is_post_closing
      comment: "Indicates whether the disbursement occurred after closing — used to track post-closing adjustments and holdback releases."
  measures:
    - name: "total_disbursements"
      expr: COUNT(DISTINCT escrow_disbursement_id)
      comment: "Total number of distinct escrow disbursements processed — measures settlement transaction volume and operational throughput."
    - name: "total_disbursement_amount"
      expr: SUM(CAST(disbursement_amount AS DOUBLE))
      comment: "Total gross disbursement amount — measures total capital distributed through escrow settlement."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursement amount after withholdings — measures actual cash distributed to payees."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total amounts withheld from disbursements (e.g. FIRPTA, state withholding) — critical for tax compliance monitoring."
    - name: "total_commission_disbursed"
      expr: SUM(CAST(CASE WHEN disbursement_type = 'Commission' THEN disbursement_amount ELSE 0 END AS DOUBLE))
      comment: "Total commission amounts disbursed through escrow — measures brokerage compensation paid at settlement."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate applied to disbursements — tracks brokerage fee trends and negotiation outcomes."
    - name: "withholding_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(withholding_amount AS DOUBLE)) / NULLIF(SUM(CAST(disbursement_amount AS DOUBLE)), 0), 2)
      comment: "Withholding as a percentage of gross disbursement — measures tax withholding burden and compliance exposure."
    - name: "voided_disbursement_count"
      expr: COUNT(DISTINCT CASE WHEN disbursement_status = 'Voided' THEN escrow_disbursement_id END)
      comment: "Number of voided disbursements — tracks payment error rates and operational quality in the settlement process."
    - name: "avg_disbursement_amount"
      expr: AVG(CAST(disbursement_amount AS DOUBLE))
      comment: "Average disbursement amount per transaction — used to benchmark settlement size and detect anomalies."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_exchange_1031`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "1031 tax-deferred exchange KPIs — tracks deferred gain realization, exchange compliance, replacement property economics, and IRS deadline adherence for tax strategy and investment management teams."
  source: "`real_estate_ecm`.`transaction`.`exchange_1031`"
  dimensions:
    - name: "exchange_status"
      expr: exchange_status
      comment: "Current status of the 1031 exchange (e.g. Initiated, Identified, Completed, Failed) — primary dimension for exchange pipeline monitoring."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of 1031 exchange (e.g. Delayed, Reverse, Improvement, Simultaneous) — used to segment exchange complexity and risk."
    - name: "irs_compliance_status"
      expr: irs_compliance_status
      comment: "IRS compliance status of the exchange — critical for tax risk monitoring and regulatory reporting."
    - name: "identification_rule"
      expr: identification_rule
      comment: "Identification rule used (e.g. 3-Property, 200% Rule, 95% Rule) — used to assess replacement property identification strategy."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year in which the exchange is reported — used for annual tax planning and deferred gain tracking."
    - name: "form_8824_filed"
      expr: form_8824_filed
      comment: "Indicates whether IRS Form 8824 has been filed — tracks tax filing compliance for completed exchanges."
    - name: "like_kind_confirmed"
      expr: like_kind_confirmed
      comment: "Indicates whether like-kind property qualification has been confirmed — critical compliance checkpoint for exchange validity."
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the exchange was initiated — used for vintage analysis and deferred gain aging."
  measures:
    - name: "total_exchanges"
      expr: COUNT(DISTINCT exchange_1031_id)
      comment: "Total number of 1031 exchanges initiated — measures tax-deferral strategy utilization across the portfolio."
    - name: "total_deferred_gain"
      expr: SUM(CAST(deferred_gain AS DOUBLE))
      comment: "Total capital gains deferred through 1031 exchanges — primary tax benefit metric for investment and tax strategy teams."
    - name: "total_realized_gain"
      expr: SUM(CAST(realized_gain AS DOUBLE))
      comment: "Total realized gain across all exchanges — measures gross economic gain before deferral treatment."
    - name: "total_recognized_gain"
      expr: SUM(CAST(recognized_gain AS DOUBLE))
      comment: "Total recognized (taxable) gain — measures the portion of gain not successfully deferred, representing tax liability."
    - name: "total_boot_amount"
      expr: SUM(CAST(boot_amount AS DOUBLE))
      comment: "Total boot received across exchanges — measures taxable proceeds that could not be sheltered within the exchange structure."
    - name: "total_relinquished_sale_price"
      expr: SUM(CAST(relinquished_sale_price AS DOUBLE))
      comment: "Total sale price of relinquished properties — measures the capital base being recycled through 1031 exchanges."
    - name: "total_replacement_purchase_price"
      expr: SUM(CAST(replacement_purchase_price AS DOUBLE))
      comment: "Total purchase price of replacement properties — measures capital redeployment through exchange acquisitions."
    - name: "avg_deferred_gain_per_exchange"
      expr: AVG(CAST(deferred_gain AS DOUBLE))
      comment: "Average deferred gain per exchange — benchmarks tax efficiency of individual exchange transactions."
    - name: "deferral_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_gain AS DOUBLE)) / NULLIF(SUM(CAST(realized_gain AS DOUBLE)), 0), 2)
      comment: "Deferred gain as a percentage of realized gain — measures how effectively exchanges are sheltering capital gains from taxation."
    - name: "total_selling_expenses"
      expr: SUM(CAST(selling_expenses AS DOUBLE))
      comment: "Total selling expenses across relinquished properties — measures transaction costs that reduce the adjusted basis and deferred gain."
    - name: "completed_exchange_count"
      expr: COUNT(DISTINCT CASE WHEN exchange_status = 'Completed' THEN exchange_1031_id END)
      comment: "Number of successfully completed 1031 exchanges — measures execution success rate of the tax deferral strategy."
    - name: "avg_qi_fund_balance"
      expr: AVG(CAST(qi_fund_balance AS DOUBLE))
      comment: "Average qualified intermediary fund balance — tracks exchange proceeds held by QIs pending replacement property acquisition."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_purchase_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase agreement pipeline KPIs — tracks contract volume, pricing, contingency risk, deal velocity, and agreement lifecycle health for transaction management and acquisition teams."
  source: "`real_estate_ecm`.`transaction`.`purchase_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the purchase agreement (e.g. Executed, Pending, Terminated, Closed) — primary dimension for contract pipeline monitoring."
    - name: "contingency_status"
      expr: contingency_status
      comment: "Status of contingencies on the agreement (e.g. Active, Removed, Waived) — used to assess deal risk and closing probability."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the purchase agreement became effective — used for annual contract volume and pipeline analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the purchase agreement became effective — enables time-series pipeline trending."
    - name: "is_1031_exchange"
      expr: is_1031_exchange
      comment: "Flags agreements structured as 1031 exchanges — used to track tax-motivated transaction activity."
    - name: "financing_contingency_flag"
      expr: financing_contingency_flag
      comment: "Indicates whether the agreement includes a financing contingency — key risk factor for deal certainty and fall-through probability."
    - name: "inspection_contingency_flag"
      expr: inspection_contingency_flag
      comment: "Indicates whether the agreement includes an inspection contingency — used to assess physical due diligence risk."
    - name: "appraisal_contingency_flag"
      expr: appraisal_contingency_flag
      comment: "Indicates whether the agreement includes an appraisal contingency — used to assess valuation gap risk."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for agreement termination — used to analyze deal fall-through causes and improve pipeline quality."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT purchase_agreement_id)
      comment: "Total number of purchase agreements executed — primary volume metric for the acquisition pipeline."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_price AS DOUBLE))
      comment: "Total contract price across all purchase agreements — measures aggregate deal value in the pipeline."
    - name: "avg_contract_price"
      expr: AVG(CAST(contract_price AS DOUBLE))
      comment: "Average contract price per agreement — tracks deal size trends and portfolio mix over time."
    - name: "avg_price_per_sqft"
      expr: AVG(CAST(price_psf AS DOUBLE))
      comment: "Average contract price per square foot — enables cross-property pricing comparison and market benchmarking."
    - name: "total_earnest_money_committed"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money committed across all agreements — measures buyer commitment capital at risk in the pipeline."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payment amounts across agreements — measures equity capital committed by buyers in the pipeline."
    - name: "total_seller_concessions"
      expr: SUM(CAST(seller_concessions_amount AS DOUBLE))
      comment: "Total seller concessions granted in purchase agreements — measures negotiation leakage from contract price."
    - name: "terminated_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Terminated' THEN purchase_agreement_id END)
      comment: "Number of terminated purchase agreements — measures deal fall-through volume and pipeline attrition."
    - name: "termination_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN agreement_status = 'Terminated' THEN purchase_agreement_id END) / NULLIF(COUNT(DISTINCT purchase_agreement_id), 0), 2)
      comment: "Percentage of purchase agreements that were terminated — key deal quality and pipeline reliability metric."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across purchase agreements — tracks buyer leverage and associated financing risk."
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total loan amounts across purchase agreements — measures debt financing volume in the acquisition pipeline."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_deed_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deed transfer and title recording KPIs — tracks transfer volume, consideration amounts, tax obligations, foreclosure activity, and recording compliance for title operations and legal teams."
  source: "`real_estate_ecm`.`transaction`.`deed_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the deed transfer (e.g. Recorded, Pending, Rejected) — primary dimension for recording pipeline monitoring."
    - name: "deed_type"
      expr: deed_type
      comment: "Type of deed (e.g. Warranty, Quitclaim, Special Warranty, Trustee) — used to assess title quality and risk."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g. Sale, Gift, Foreclosure, Inheritance) — used to segment transfer activity by economic motivation."
    - name: "recording_month"
      expr: DATE_TRUNC('MONTH', recording_date)
      comment: "Month the deed was recorded — enables time-series analysis of recording volume and market activity."
    - name: "recording_year"
      expr: YEAR(recording_date)
      comment: "Year the deed was recorded — supports annual transfer volume benchmarking."
    - name: "arms_length_flag"
      expr: arms_length_flag
      comment: "Indicates whether the transfer was an arms-length transaction — used to filter comparable sales for valuation analysis."
    - name: "foreclosure_flag"
      expr: foreclosure_flag
      comment: "Indicates whether the transfer resulted from foreclosure — used to track distressed asset activity in the market."
    - name: "exchange_1031_flag"
      expr: exchange_1031_flag
      comment: "Indicates whether the transfer is part of a 1031 exchange — used for tax compliance and exchange tracking."
    - name: "vesting_type"
      expr: vesting_type
      comment: "Vesting type of the grantee (e.g. Joint Tenancy, Tenancy in Common, LLC) — used to analyze ownership structure trends."
    - name: "state_code"
      expr: state_code
      comment: "State in which the deed was recorded — enables geographic analysis of transfer activity and tax obligations."
  measures:
    - name: "total_deed_transfers"
      expr: COUNT(DISTINCT deed_transfer_id)
      comment: "Total number of deed transfers recorded — primary volume metric for title recording activity."
    - name: "total_consideration_amount"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total consideration (purchase price) across all deed transfers — measures aggregate transaction value recorded in public records."
    - name: "avg_consideration_amount"
      expr: AVG(CAST(consideration_amount AS DOUBLE))
      comment: "Average consideration amount per deed transfer — tracks market pricing trends from recorded transaction data."
    - name: "avg_price_per_sqft"
      expr: AVG(CAST(price_per_sqf AS DOUBLE))
      comment: "Average recorded sale price per square foot — key market comparables metric derived from public deed records."
    - name: "total_transfer_tax"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer taxes paid across all deed transfers — measures tax obligation and government revenue from property transactions."
    - name: "total_recording_fees"
      expr: SUM(CAST(recording_fee_amount AS DOUBLE))
      comment: "Total recording fees paid — measures administrative cost of deed recordation across the portfolio."
    - name: "total_mortgage_amount"
      expr: SUM(CAST(mortgage_amount AS DOUBLE))
      comment: "Total mortgage amounts recorded on deed transfers — measures debt financing associated with recorded property transfers."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio on recorded transfers — tracks leverage levels in the recorded transaction market."
    - name: "foreclosure_transfer_count"
      expr: COUNT(DISTINCT CASE WHEN foreclosure_flag = TRUE THEN deed_transfer_id END)
      comment: "Number of deed transfers resulting from foreclosure — measures distressed asset activity and market stress indicators."
    - name: "arms_length_transfer_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN arms_length_flag = TRUE THEN deed_transfer_id END) / NULLIF(COUNT(DISTINCT deed_transfer_id), 0), 2)
      comment: "Percentage of deed transfers that are arms-length transactions — measures data quality for comparable sales analysis."
    - name: "total_earnest_money_recorded"
      expr: SUM(CAST(earnest_money_amount AS DOUBLE))
      comment: "Total earnest money amounts recorded on deed transfers — tracks buyer commitment capital across recorded transactions."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_due_diligence_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Due diligence pipeline and risk KPIs — tracks item completion rates, cost estimates, remediation requirements, and risk ratings to support investment committee decisions and deal underwriting."
  source: "`real_estate_ecm`.`transaction`.`due_diligence_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current status of the due diligence item (e.g. Open, Completed, Waived, Escalated) — primary dimension for DD pipeline monitoring."
    - name: "item_type"
      expr: item_type
      comment: "Type of due diligence item (e.g. Environmental, Legal, Financial, Physical) — used to segment DD workload by discipline."
    - name: "item_category"
      expr: item_category
      comment: "Category of the due diligence item — provides finer-grained segmentation within item types for workload and risk analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the due diligence finding (e.g. Low, Medium, High, Critical) — primary risk dimension for investment committee reporting."
    - name: "go_no_go_recommendation"
      expr: go_no_go_recommendation
      comment: "Go/No-Go recommendation from the due diligence finding — used to track deal-blocking issues and investment committee outcomes."
    - name: "remediation_required"
      expr: remediation_required
      comment: "Indicates whether remediation is required for the finding — used to quantify remediation workload and cost exposure."
    - name: "price_adjustment_recommended"
      expr: price_adjustment_recommended
      comment: "Indicates whether a price adjustment is recommended based on the finding — used to track negotiation leverage from DD findings."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the due diligence item is due — used for workload planning and deadline management."
    - name: "investment_committee_flag"
      expr: investment_committee_flag
      comment: "Flags items requiring investment committee review — used to prioritize escalation and governance workflows."
  measures:
    - name: "total_due_diligence_items"
      expr: COUNT(DISTINCT due_diligence_item_id)
      comment: "Total number of due diligence items across all deals — measures DD workload volume and pipeline complexity."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of due diligence items — measures projected DD expenditure for budget planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for due diligence items — measures realized DD spend for cost control and vendor management."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated remediation cost across all findings — measures potential capital exposure from DD-identified issues."
    - name: "total_recommended_price_adjustment"
      expr: SUM(CAST(recommended_price_adjustment AS DOUBLE))
      comment: "Total recommended price adjustments from DD findings — measures aggregate negotiation leverage identified through due diligence."
    - name: "avg_recommended_price_adjustment"
      expr: AVG(CAST(recommended_price_adjustment AS DOUBLE))
      comment: "Average recommended price adjustment per DD item — benchmarks the materiality of individual findings."
    - name: "high_risk_item_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN due_diligence_item_id END)
      comment: "Number of high or critical risk due diligence items — key metric for investment committee risk reporting and deal go/no-go decisions."
    - name: "remediation_required_count"
      expr: COUNT(DISTINCT CASE WHEN remediation_required = TRUE THEN due_diligence_item_id END)
      comment: "Number of items requiring remediation — measures the scope of corrective action needed to close transactions."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost overrun (actual minus estimated) across DD items — measures budget accuracy and vendor cost control."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN item_status = 'Completed' THEN due_diligence_item_id END) / NULLIF(COUNT(DISTINCT due_diligence_item_id), 0), 2)
      comment: "Percentage of due diligence items completed — measures DD process velocity and deal readiness for closing."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`transaction_title_search`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Title search and insurance KPIs — tracks title defect exposure, lien risk, coverage adequacy, and search completion rates for title operations and transaction risk management."
  source: "`real_estate_ecm`.`transaction`.`title_search`"
  dimensions:
    - name: "search_status"
      expr: search_status
      comment: "Current status of the title search (e.g. Ordered, In Progress, Completed, Cleared) — primary dimension for title pipeline monitoring."
    - name: "search_type"
      expr: search_type
      comment: "Type of title search (e.g. Full, Update, Bring-Down) — used to segment search activity by scope and purpose."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of title insurance policy (e.g. Owner, Lender, Both) — used to analyze coverage type distribution."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the title search became effective — enables time-series analysis of title activity."
    - name: "environmental_lien_flag"
      expr: environmental_lien_flag
      comment: "Indicates whether an environmental lien was found — used to flag high-risk properties requiring environmental remediation."
    - name: "hoa_lien_flag"
      expr: hoa_lien_flag
      comment: "Indicates whether an HOA lien was found — used to track HOA encumbrance risk in the title pipeline."
    - name: "survey_required"
      expr: survey_required
      comment: "Indicates whether a survey is required — used to track survey workload and associated closing delays."
    - name: "vesting_type"
      expr: vesting_type
      comment: "Vesting type on the title (e.g. Joint Tenancy, LLC, Trust) — used to analyze ownership structure trends."
  measures:
    - name: "total_title_searches"
      expr: COUNT(DISTINCT title_search_id)
      comment: "Total number of title searches ordered — measures title operations volume and pipeline activity."
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total title insurance coverage amount — measures aggregate insured value and risk exposure in the title portfolio."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average title insurance coverage per search — benchmarks coverage adequacy relative to property values."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total title insurance premiums — measures title insurance cost across the transaction portfolio."
    - name: "total_tax_lien_exposure"
      expr: SUM(CAST(tax_lien_amount AS DOUBLE))
      comment: "Total tax lien amounts identified in title searches — measures aggregate tax encumbrance risk requiring clearance."
    - name: "total_judgment_lien_exposure"
      expr: SUM(CAST(judgment_lien_amount AS DOUBLE))
      comment: "Total judgment lien amounts identified — measures legal encumbrance risk that must be resolved before closing."
    - name: "total_mechanics_lien_exposure"
      expr: SUM(CAST(mechanics_lien_amount AS DOUBLE))
      comment: "Total mechanics lien amounts identified — measures contractor/subcontractor encumbrance risk in the title pipeline."
    - name: "total_existing_mortgage_amount"
      expr: SUM(CAST(existing_mortgage_amount AS DOUBLE))
      comment: "Total existing mortgage amounts identified in title searches — measures debt encumbrance requiring payoff at closing."
    - name: "properties_with_environmental_liens"
      expr: COUNT(DISTINCT CASE WHEN environmental_lien_flag = TRUE THEN title_search_id END)
      comment: "Number of title searches with environmental liens — tracks environmental risk exposure requiring remediation before closing."
    - name: "avg_premium_to_coverage_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(premium_amount AS DOUBLE)) / NULLIF(SUM(CAST(coverage_amount AS DOUBLE)), 0), 2)
      comment: "Title insurance premium as a percentage of coverage amount — measures title insurance cost efficiency and rate benchmarking."
    - name: "total_lien_exposure"
      expr: SUM(CAST(tax_lien_amount AS DOUBLE) + CAST(judgment_lien_amount AS DOUBLE) + CAST(mechanics_lien_amount AS DOUBLE))
      comment: "Total combined lien exposure (tax + judgment + mechanics) identified in title searches — measures aggregate encumbrance risk requiring clearance before closing."
$$;