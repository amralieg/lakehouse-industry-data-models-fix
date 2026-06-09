-- Schema for Domain: loan | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`loan` COMMENT 'End-to-end management of commercial lending, consumer loans, mortgages, revolving credit facilities, syndicated loans, and trade finance operations including letters of credit, documentary collections, bank guarantees, supply chain finance, export/import financing, and bill of lading management. Owns credit origination, underwriting, loan booking, covenant tracking, amortization, trade finance lifecycle, UCP 600/URDG 758 compliance, and all lending-related regulatory reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique surrogate identifier for the credit facility record in the lakehouse. Primary key for the facility master entity, referenced by all transactional and monitoring products in the loan domain.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Securities-based lending: credit facilities (margin loans, lines of credit) extended to high-net-worth clients are commonly collateralized by their fund investment holdings. The facility tracks which ',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Credit facilities (revolving lines, term loan commitments) are secured by master pledge agreements. Relationship managers track which pledge secures facility availability, required for commitment util',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Facility approval, pricing, and ongoing credit monitoring require current counterparty credit ratings. Internal_risk_rating is denormalized from the rating entity; pd/lgd/ead are rating outputs that s',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Facilities booked in countries require country risk ratings, sovereign ratings, regulatory frameworks (Basel implementation status), AML risk ratings, and sanctions flags for credit decisioning, provi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Facilities denominated in specific currencies require currency metadata (settlement lag, rounding, convertibility) for disbursement, accrual, revaluation, and regulatory reporting (Basel liquidity rat',
    `party_id` BIGINT COMMENT 'FK to customer.party.party_id — MUST-HAVE: Cannot query loan facilities by borrower without this link. Fundamental for credit portfolio management, regulatory reporting (CCAR/DFAST), and customer 360 views.',
    `facility_party_id` BIGINT COMMENT 'Reference to the primary borrowing entity (customer or counterparty) obligated under this credit facility. Used for KYC/AML linkage, credit exposure aggregation, and regulatory reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Facilities require GL account assignment for balance sheet classification, interest accrual posting, and subledger-to-GL reconciliation. Core accounting requirement for loan portfolio management and f',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Facilities extended to borrowers in industries require industry classification (NAICS, SIC, GICS) for concentration risk limits, regulatory reporting (Basel Pillar 3 industry breakdowns), credit polic',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Facilities are originated through specific channels (branch, digital, RM). Critical for channel performance reporting, origination analytics, regulatory source-of-business tracking, and channel ROI me',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Facilities priced off benchmark rates require benchmark metadata (day count convention, compounding convention, fallback rate) for interest accrual, repricing, fallback provisions (IBOR transition), a',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: CCAR/DFAST stress testing requires applying specific regulatory scenarios to facility portfolios for capital adequacy assessment. Facilities must track which stress scenarios theyve been tested under',
    `transfer_pricing_curve_id` BIGINT COMMENT 'Foreign key linking to treasury.transfer_pricing_curve. Business justification: Facilities require FTP curve assignment for monthly P&L attribution, RAROC calculation, and profitability measurement. Banking standard practice links facilities to transfer pricing curves for interna',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Trust accounts hold credit facilities as trust assets (mortgages on trust property, lines of credit for trust liquidity). Fiduciary lending requires tracking facility obligations at trust level for tr',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities-backed credit facilities (margin lending, portfolio-based lines) require tracking the underlying security collateral. Core private banking and wealth management product. Supports collateral',
    `agent_bank_flag` BOOLEAN COMMENT 'Indicates whether the bank acts as the administrative agent for this syndicated facility, responsible for coordinating drawdowns, payments, and covenant compliance on behalf of the lending syndicate.',
    `all_in_rate` DECIMAL(18,2) COMMENT 'Total effective interest rate applicable to the facility, combining the reference rate benchmark and the credit spread. Expressed as a decimal (e.g., 0.065 = 6.5%). Used for interest accrual, income recognition, and borrower billing.',
    `amortization_type` STRING COMMENT 'Repayment structure of the facility principal. Bullet requires full repayment at maturity; amortizing schedules periodic principal reductions; interest_only defers principal; balloon combines periodic payments with a large final payment; revolving allows repeated drawdown and repayment.. Valid values are `bullet|amortizing|interest_only|balloon|revolving`',
    `bank_hold_amount` DECIMAL(18,2) COMMENT 'The banks retained share of the facility commitment in a syndicated loan, representing the portion not sold down to participant lenders. Determines the banks net credit exposure and regulatory capital requirement for the facility.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total committed credit limit approved for the facility, representing the maximum exposure the bank has contractually agreed to extend. Used in RWA (Risk-Weighted Assets) calculation and EAD (Exposure at Default) estimation under Basel IRB/SA approaches.',
    `covenant_breach_flag` BOOLEAN COMMENT 'Indicates whether the borrower is currently in breach of one or more financial or non-financial covenants attached to the facility. A covenant breach may constitute an event of default or trigger accelerated repayment provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was first created in the lakehouse Silver layer. Provides audit trail for data lineage, SOX (Sarbanes-Oxley Act) compliance, and ETL (Extract Transform Load) reconciliation.',
    `days_past_due` STRING COMMENT 'Number of calendar days the facility is past its scheduled payment due date. Key delinquency metric used for NPL classification (90+ DPD threshold), IFRS 9 staging triggers, and CECL loss estimation.',
    `drawn_amount` DECIMAL(18,2) COMMENT 'Outstanding principal balance currently drawn and outstanding under the facility. Represents the banks actual on-balance-sheet credit exposure. Key input for ECL (Expected Credit Loss) provisioning under IFRS 9 and CECL.',
    `dscr` DECIMAL(18,2) COMMENT 'Ratio of the borrowers net operating income to total debt service obligations (principal and interest). A DSCR below 1.0 indicates insufficient cash flow to service debt. Core covenant metric for commercial real estate and leveraged lending.',
    `facility_name` STRING COMMENT 'Human-readable descriptive name of the credit facility as recorded in the Loan Origination System, typically reflecting the borrower name and facility type (e.g., Acme Corp — 5-Year Revolving Credit Facility).',
    `facility_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the credit facility by the Loan Origination System (e.g., Finastra Fusion Loan IQ). Used in borrower communications, regulatory filings, and inter-system reconciliation.',
    `facility_status` STRING COMMENT 'Current lifecycle state of the credit facility. Drives downstream processing, provisioning, and regulatory classification. defaulted triggers NPL (Non-Performing Loan) reporting; written_off indicates full credit loss recognition under CECL/IFRS 9.. Valid values are `active|matured|defaulted|written_off|cancelled|pending_approval`',
    `facility_type` STRING COMMENT 'Classification of the credit facility by product structure. Determines amortization schedule, drawdown mechanics, and regulatory capital treatment. [ENUM-REF-CANDIDATE: revolving_credit|term_loan|mortgage|consumer_loan|syndicated_loan|letter_of_credit|overdraft|trade_finance|guarantee|bridge_loan — promote to reference product]. Valid values are `revolving_credit|term_loan|mortgage|consumer_loan|syndicated_loan|letter_of_credit`',
    `first_drawdown_date` DATE COMMENT 'Date of the first utilization or drawdown under the facility. Marks the transition from commitment to active exposure and is used for interest accrual commencement and IFRS 9 initial recognition of financial asset.',
    `ifrs9_stage` STRING COMMENT 'IFRS 9 impairment staging classification: Stage 1 (performing, 12-month ECL), Stage 2 (significant increase in credit risk, lifetime ECL), Stage 3 (credit-impaired, lifetime ECL). Drives ECL provisioning and income recognition methodology.. Valid values are `stage_1|stage_2|stage_3`',
    `interest_rate_basis` STRING COMMENT 'Reference rate benchmark underpinning the facilitys floating interest rate (e.g., SOFR — Secured Overnight Financing Rate, EURIBOR). Reflects LIBOR transition requirements per ARRC/ISDA fallback protocols. Fixed-rate facilities carry fixed designation. [ENUM-REF-CANDIDATE: SOFR|LIBOR|EURIBOR|SONIA|fixed|prime|CDOR — 7 candidates stripped; promote to reference product]',
    `interest_rate_spread_bps` DECIMAL(18,2) COMMENT 'Credit spread above the reference rate benchmark expressed in BPS (Basis Points), representing the banks risk-adjusted margin on the facility. Key input for NIM (Net Interest Margin) and NII (Net Interest Income) reporting and FTP (Funds Transfer Pricing).',
    `loan_purpose_code` STRING COMMENT 'Standardized code classifying the intended use of proceeds for the credit facility (e.g., working capital, capital expenditure, acquisition finance, real estate purchase). Required for HMDA, CRA, and Call Report regulatory filings. [ENUM-REF-CANDIDATE: working_capital|capex|acquisition|real_estate|trade_finance|refinancing|general_corporate|consumer_personal — promote to reference product]',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the outstanding drawn amount to the appraised value of pledged collateral, expressed as a decimal (e.g., 0.75 = 75% LTV). Key underwriting metric for mortgage and secured commercial lending; used in LGD estimation and collateral adequacy monitoring.',
    `maturity_date` DATE COMMENT 'Contractual date on which the facility expires and all outstanding principal and accrued interest become due. Used for liquidity gap analysis, NSFR (Net Stable Funding Ratio) bucketing, and ALM (Asset-Liability Management) cash flow projections.',
    `npl_flag` BOOLEAN COMMENT 'Indicates whether the facility is classified as a Non-Performing Loan (NPL) per regulatory definition (typically 90+ days past due or unlikely-to-pay). Triggers specific provisioning, income recognition suspension, and regulatory NPL ratio reporting.',
    `originating_branch_code` STRING COMMENT 'Code identifying the bank branch or business unit that originated the credit facility. Used for geographic concentration analysis, CRA (Community Reinvestment Act) reporting, and LOB (Line of Business) profitability attribution.',
    `origination_date` DATE COMMENT 'Date on which the credit facility was formally originated and booked in the Loan Origination System. Marks the start of the facility lifecycle and is used for vintage analysis, seasoning calculations, and CECL/IFRS 9 staging.',
    `regulatory_segment` STRING COMMENT 'Basel III regulatory exposure class assigned to the facility for RWA (Risk-Weighted Assets) calculation under the Standardized Approach (SA) or Internal Ratings-Based (IRB) approach. Determines applicable risk weight and capital treatment.. Valid values are `retail|corporate|sovereign|financial_institution|SME|specialized_lending`',
    `repayment_frequency` STRING COMMENT 'Scheduled frequency of principal and/or interest repayment installments under the facility. Drives cash flow projection for ALM (Asset-Liability Management), liquidity gap analysis, and NSFR (Net Stable Funding Ratio) bucketing.. Valid values are `monthly|quarterly|semi_annual|annual|bullet`',
    `review_date` DATE COMMENT 'Scheduled date for the next annual or periodic credit review of the facility. Triggers credit underwriting reassessment, covenant compliance review, and internal risk rating refresh.',
    `syndicated_flag` BOOLEAN COMMENT 'Indicates whether the facility is part of a syndicated loan arrangement involving multiple lender participants. Syndicated facilities require agent bank coordination, participation tracking, and specific regulatory reporting under OCC Shared National Credit (SNC) program.',
    `undrawn_amount` DECIMAL(18,2) COMMENT 'Available but unutilized portion of the committed facility (committed_amount minus drawn_amount). Attracts a credit conversion factor (CCF) for off-balance-sheet RWA calculation under Basel III standardized and IRB approaches.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the facility record in the lakehouse Silver layer. Used for incremental ETL (Extract Transform Load) processing, change data capture, and audit trail maintenance.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for every credit facility extended by the bank, covering commercial loans, revolving credit lines, term loans, mortgages, consumer loans, and syndicated loan tranches. Captures facility type, committed and drawn amounts, undrawn availability, currency, interest rate basis and spread, maturity date, origination date, internal risk rating, LTV ratio, DSCR, syndication flag, agent bank indicator, and facility status (active, matured, defaulted, written-off). Hub entity for the loan domain — all transactional and monitoring products reference facility. Primary system-of-record entity aligned with Finastra Fusion Loan IQ facility master.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`credit_application` (
    `credit_application_id` BIGINT COMMENT 'Unique identifier for the credit application record. Primary key for the credit application entity.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or loan officer responsible for the customer relationship and application origination.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Credit applications offering securities as collateral (bonds, equities, portfolios) require instrument identification for underwriting, valuation, and eligibility assessment. Standard input for securi',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: High-net-worth credit applications reference managed portfolios for collateral evaluation and income verification. Underwriting process pulls portfolio statements to assess liquid net worth, verify in',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit underwriting decisions depend on applicants credit rating. Credit_rating is denormalized rating code; pd/lgd/ead estimates should be sourced from the rating entity for consistency with risk fr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Applications request funding in currencies requiring currency metadata (convertibility, restrictions, settlement lag) for feasibility assessment, pricing (FX risk premium), and approval workflow. Reus',
    `employee_id` BIGINT COMMENT 'Reference to the credit analyst or underwriter assigned to review and assess this credit application.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Private banking underwriting: credit applications for ultra-high-net-worth clients reference their investment accounts (fund holdings) as part of creditworthiness assessment. Underwriters evaluate the',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Credit applications require KYC verification before approval to satisfy CIP/CDD requirements. Application processing triggers or references KYC reviews to verify applicant identity and assess AML risk',
    `party_id` BIGINT COMMENT 'Reference to the primary applicant (customer or corporate entity) submitting the credit application.',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Private banking credit underwriting references existing suitability assessments to verify client financial profile, risk tolerance, net worth, and debt service capacity. Regulatory requirement for res',
    `aml_screening_status` STRING COMMENT 'Status of Anti-Money Laundering screening for the applicant: pending, cleared, flagged for suspicious activity, or under compliance review.. Valid values are `pending|cleared|flagged|under_review`',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Applicants reported annual revenue from the most recent financial statements, used for debt service coverage and creditworthiness assessment.',
    `application_channel` STRING COMMENT 'Channel through which the credit application was submitted: branch, online portal, mobile app, phone, broker, or direct sales team.. Valid values are `branch|online|mobile|phone|broker|direct_sales`',
    `application_number` STRING COMMENT 'Externally-visible unique business identifier for the credit application, used in customer communications and regulatory reporting.. Valid values are `^[A-Z]{2,4}[0-9]{8,12}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the credit application in the underwriting workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|pending_documents|approved|declined|withdrawn|referred — 8 candidates stripped; promote to reference product]',
    `application_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the credit application was formally submitted by the applicant or on behalf of the applicant.',
    `application_type` STRING COMMENT 'Classification of the credit application based on the nature of the request: new facility, renewal of existing, refinancing, modification of terms, credit line increase, or debt restructuring.. Valid values are `new|renewal|refinance|modification|increase|restructure`',
    `approved_amount` DECIMAL(18,2) COMMENT 'Principal amount of credit approved by underwriting, which may differ from the requested amount. Nullable for declined or pending applications.',
    `approved_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate approved for the credit facility, expressed as a decimal (e.g., 0.0575 for 5.75%). Nullable for declined or pending applications.',
    `approved_term_months` STRING COMMENT 'Duration of the approved credit facility in months, which may differ from the requested term. Nullable for declined or pending applications.',
    `collateral_offered` STRING COMMENT 'Indicates whether the application includes collateral: fully secured, unsecured, or partially secured.. Valid values are `secured|unsecured|partially_secured`',
    `collateral_type` STRING COMMENT 'Description of the primary collateral type offered, such as real estate, equipment, inventory, receivables, securities, or cash deposits. Nullable for unsecured applications.',
    `collateral_value` DECIMAL(18,2) COMMENT 'Estimated market value of the collateral offered, as declared by the applicant or assessed during initial review. Nullable for unsecured applications.',
    `conditions_precedent` STRING COMMENT 'List of conditions that must be satisfied before loan disbursement, such as additional documentation, insurance requirements, or legal opinions. Nullable for declined applications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this credit application record was first created in the system.',
    `credit_committee_approval_date` DATE COMMENT 'Date when the credit committee formally approved the application, if committee approval was required. Nullable for applications within analyst authority or declined applications.',
    `credit_score` STRING COMMENT 'Numeric credit score assigned by the credit scoring model (e.g., FICO, internal proprietary model) at the time of application submission.',
    `decline_reason` STRING COMMENT 'Detailed explanation for declined applications, including specific credit policy violations, insufficient collateral, adverse credit history, or regulatory restrictions. Nullable for approved applications.',
    `dscr` DECIMAL(18,2) COMMENT 'Debt Service Coverage Ratio calculated as net operating income divided by total debt service obligations, indicating the applicants ability to service debt.',
    `facility_type` STRING COMMENT 'Type of credit facility being requested: term loan, revolving credit line, mortgage, overdraft, letter of credit, trade finance instrument, or syndicated loan. [ENUM-REF-CANDIDATE: term_loan|revolving_credit|mortgage|overdraft|letter_of_credit|trade_finance|syndicated_loan — 7 candidates stripped; promote to reference product]',
    `financial_statement_date` DATE COMMENT 'Date of the most recent financial statements submitted by the applicant as part of the credit application package.',
    `kyc_completed` BOOLEAN COMMENT 'Indicates whether Know Your Customer due diligence has been completed for the applicant, required for regulatory compliance.',
    `loan_purpose` STRING COMMENT 'Detailed description of the intended use of borrowed funds, such as working capital, capital expenditure, acquisition, real estate purchase, debt consolidation, or trade finance.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-Value ratio calculated as requested amount divided by collateral value, expressed as a percentage. Key metric for secured lending risk assessment.',
    `pipeline_stage` STRING COMMENT 'Current stage of the application in the credit origination pipeline, used for funnel analytics and conversion tracking. [ENUM-REF-CANDIDATE: prospect|application|underwriting|approval|documentation|closing|funded|declined — 8 candidates stripped; promote to reference product]',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this application must be included in regulatory reporting such as HMDA, CRA, or other jurisdiction-specific credit origination reports.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Principal amount of credit requested by the applicant in the application currency.',
    `requested_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested credit amount.. Valid values are `^[A-Z]{3}$`',
    `requested_term_months` STRING COMMENT 'Duration of the requested credit facility expressed in months. Nullable for revolving facilities without fixed maturity.',
    `total_assets` DECIMAL(18,2) COMMENT 'Applicants total assets as reported in the most recent financial statements, used for balance sheet strength assessment.',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Applicants total liabilities as reported in the most recent financial statements, used for leverage ratio calculation.',
    `underwriting_decision` STRING COMMENT 'Final underwriting decision rendered by the credit analyst or credit committee: approved, declined, referred to senior committee, conditional approval pending additional requirements, or withdrawn by applicant.. Valid values are `approved|declined|referred|conditional_approval|withdrawn`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this credit application record was last modified.',
    CONSTRAINT pk_credit_application PRIMARY KEY(`credit_application_id`)
) COMMENT 'End-to-end credit origination and underwriting record for all loan types. Captures applicant reference, requested facility amount and type, purpose of borrowing, collateral offered, financial statement submission dates, credit analyst assigned, credit scoring model output, underwriting decision (approved, declined, referred, withdrawn), approved terms and conditions, conditions precedent checklist, credit committee approval timestamps, and pipeline stage tracking. Supports regulatory reporting (HMDA, CRA) and origination funnel analytics.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`loan_account` (
    `loan_account_id` BIGINT COMMENT 'Unique identifier for the loan account. Primary key for this entity.',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: Loan accounts trigger AML alerts for structuring, unusual activity patterns, high-risk geography, or sanctions concerns. Transaction monitoring systems monitor loan accounts alongside deposit accounts',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: When AML alerts escalate, cases are opened with loan accounts as subject accounts. Investigations track which loan accounts are under review for SAR filing decisions and regulatory examination documen',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Loan accounts secured by securities portfolios (margin loans, securities-backed lines) require tracking the primary collateral instrument. Supports ongoing collateral monitoring, margin maintenance, a',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Lombard loans and margin loans are directly collateralized by specific managed portfolios. Daily operations require portfolio valuation monitoring, margin call calculations, collateral revaluation for',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Loan accounts are secured by specific pledge agreements in retail/commercial banking. Credit officers need to track which pledge secures each loan for collateral coverage monitoring, regulatory capita',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Ongoing credit monitoring, regulatory capital calculations, and ECL provisioning require current counterparty ratings. Pd_rate and lgd_rate are denormalized rating parameters that should be sourced fr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Loan accounts denominated in currencies require currency metadata (minor unit, rounding method, day count convention) for interest accrual, GL revaluation, payment processing, and financial reporting ',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Core banking operational link: loan repayments are debited from deposit accounts, collateral sweeps transfer funds between loan and deposit accounts, and regulatory liquidity reporting (LCR/NSFR) requ',
    `facility_id` BIGINT COMMENT 'Reference to the parent loan facility or origination record from which this account was booked.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Each loan account must map to a GL account for principal balance tracking, interest accrual, and subledger reconciliation. Fundamental requirement for loan accounting and trial balance preparation.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Loan accounts track origination channel for portfolio segmentation by acquisition channel, lifetime value analysis, channel attribution reporting, and regulatory reporting on loan origination sources ',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who is the primary obligor on this loan account.',
    `transfer_pricing_curve_id` BIGINT COMMENT 'Foreign key linking to treasury.transfer_pricing_curve. Business justification: Loan accounts need FTP curve linkage for net interest margin calculation, product profitability analysis, and monthly management reporting. Essential for funds transfer pricing and margin attribution ',
    `account_number` STRING COMMENT 'Externally visible account number used for customer communication, statements, and payment processing. Unique within the institution.. Valid values are `^[A-Z0-9]{10,20}$`',
    `account_status` STRING COMMENT 'Current operational status of the loan account. Reflects payment performance and lifecycle stage.. Valid values are `active|delinquent|npl|charged_off|closed|suspended`',
    `accrued_fees` DECIMAL(18,2) COMMENT 'Fees accrued but not yet paid, including late fees, servicing fees, and other charges.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Interest accrued but not yet paid on the loan account. Calculated based on day-count convention and current interest rate.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'Reference rate used for floating rate loans. SOFR has replaced LIBOR as the primary benchmark for USD loans.',
    `charge_off_amount` DECIMAL(18,2) COMMENT 'Total amount charged off including principal, interest, and fees. Used for loss reporting and recovery tracking.',
    `charge_off_date` DATE COMMENT 'Date when the loan was charged off as a loss. Triggers removal from performing assets and loss recognition.',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'Ratio of collateral value to outstanding loan balance. Used for LTV (Loan-to-Value) monitoring and loss mitigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loan account record was first created in the system.',
    `cure_date` DATE COMMENT 'Date when a previously delinquent or non-performing loan returned to current status. Used for NPL lifecycle tracking.',
    `current_interest_rate` DECIMAL(18,2) COMMENT 'Current annual interest rate applied to the loan account, expressed as a decimal (e.g., 0.05250 for 5.25%).',
    `day_count_convention` STRING COMMENT 'Method used to calculate interest accrual. Determines how days are counted in interest period calculations.. Valid values are `actual_360|actual_365|30_360|actual_actual`',
    `days_past_due` STRING COMMENT 'Number of days the loan payment is overdue. Calculated from the most recent missed payment due date.',
    `delinquency_bucket` STRING COMMENT 'Days past due classification bucket. Used for aging analysis, collection prioritization, and regulatory reporting.. Valid values are `current|dpd_1_30|dpd_31_60|dpd_61_90|dpd_91_plus`',
    `ecl_provision_amount` DECIMAL(18,2) COMMENT 'Current provision amount for expected credit losses under CECL or IFRS 9. Updated quarterly based on credit risk models.',
    `first_payment_date` DATE COMMENT 'Date when the first scheduled payment was or will be due. Used for amortization schedule calculations.',
    `forbearance_end_date` DATE COMMENT 'Scheduled date when forbearance or modification period ends. Null if not under forbearance.',
    `forbearance_flag` BOOLEAN COMMENT 'Indicates whether the loan is under forbearance or modification due to borrower hardship. Impacts regulatory reporting.',
    `forbearance_start_date` DATE COMMENT 'Date when forbearance or modification period began. Null if not under forbearance.',
    `interest_rate_type` STRING COMMENT 'Classification of interest rate structure. Determines whether rate is fixed for loan term or adjusts based on benchmark.. Valid values are `fixed|variable|floating`',
    `loan_type` STRING COMMENT 'Classification of the loan product type. Determines amortization rules, covenant requirements, and regulatory treatment.. Valid values are `term_loan|revolving_credit|mortgage|syndicated_loan|trade_finance|letter_of_credit`',
    `maturity_date` DATE COMMENT 'Final date when all outstanding principal and interest must be repaid. Defines the loan term end.',
    `next_payment_due_date` DATE COMMENT 'Date when the next scheduled payment is due. Used for delinquency tracking and collection workflows.',
    `npl_classification` STRING COMMENT 'Regulatory classification of credit quality for non-performing loans. Drives provisioning requirements under CECL and IFRS 9.. Valid values are `performing|substandard|doubtful|loss`',
    `npl_classification_date` DATE COMMENT 'Date when the loan was first classified as non-performing. Triggers regulatory reporting and provisioning requirements.',
    `npl_trigger_event` STRING COMMENT 'Event that caused the loan to be classified as non-performing. Used for root cause analysis and loss mitigation.. Valid values are `dpd_90_plus|bankruptcy|default|covenant_breach|charge_off`',
    `original_loan_amount` DECIMAL(18,2) COMMENT 'Principal amount disbursed at loan origination. Used for LTV (Loan-to-Value) and amortization calculations.',
    `origination_date` DATE COMMENT 'Date when the loan was originally booked and funds were disbursed to the borrower.',
    `outstanding_principal_balance` DECIMAL(18,2) COMMENT 'Current principal amount outstanding on the loan account. Excludes accrued interest and fees.',
    `payment_frequency` STRING COMMENT 'Scheduled frequency of principal and interest payments. Bullet indicates single payment at maturity.. Valid values are `monthly|quarterly|semi_annual|annual|bullet`',
    `rate_reset_date` DATE COMMENT 'Next scheduled date when the interest rate will be recalculated for floating rate loans.',
    `rate_spread_bps` STRING COMMENT 'Credit spread added to the benchmark rate, expressed in basis points. Used for floating rate loan pricing.',
    `regulatory_classification_basis` STRING COMMENT 'Regulatory framework used for loan classification and provisioning. Determines reporting requirements.. Valid values are `occ|basel_iii|ifrs_9|cecl`',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'Basel III risk weight applied to this loan for RWA (Risk-Weighted Assets) calculation. Drives capital requirements.',
    `total_exposure` DECIMAL(18,2) COMMENT 'Total amount owed by the borrower including principal, accrued interest, and fees. Used for EAD (Exposure at Default) calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this loan account record was last modified. Used for change tracking and data lineage.',
    `watch_list_date` DATE COMMENT 'Date when the loan was added to the credit watch list. Null if not on watch list.',
    `watch_list_flag` BOOLEAN COMMENT 'Indicates whether the loan is on the credit watch list for heightened monitoring due to early warning signals.',
    CONSTRAINT pk_loan_account PRIMARY KEY(`loan_account_id`)
) COMMENT 'Operational loan account record representing the active borrower position for a booked facility. Tracks outstanding principal balance, accrued interest, fees payable, payment schedule, day-count convention, current interest rate, rate reset date, loan status (current, delinquent, NPL, charged-off), delinquency bucket (DPD), NPL classification (substandard, doubtful, loss), classification trigger events, regulatory classification basis (OCC, Basel), watch-list flag, cure dates, and interest accrual calculations. Distinct from the account domains deposit accounts; this is the SSOT for loan balance positions, credit quality classification, and NPL lifecycle management including regulatory NPL reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`amortization_schedule` (
    `amortization_schedule_id` BIGINT COMMENT 'Unique identifier for each amortization schedule entry. Primary key for the amortization schedule product.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Amortization schedules track payments in currencies requiring currency metadata (rounding, minor unit) for payment amount calculation, settlement instructions, and accounting (revenue recognition). Re',
    `loan_account_id` BIGINT COMMENT 'Reference to the parent loan facility for which this amortization schedule was generated. Links each schedule entry to its originating loan contract.',
    `accrual_days` STRING COMMENT 'Number of days in the interest accrual period for this installment. Calculated based on the day count convention specified in the loan agreement (e.g., 30/360, Actual/365, Actual/Actual).',
    `accrual_end_date` DATE COMMENT 'End date of the interest accrual period for this installment. Typically the due date of this payment. Used to calculate the number of days for interest accrual.',
    `accrual_start_date` DATE COMMENT 'Start date of the interest accrual period for this installment. Typically the day after the previous payment due date or the loan disbursement date for the first installment.',
    `actual_interest_amount` DECIMAL(18,2) COMMENT 'Actual interest amount applied from the received payment. May differ from scheduled interest due to payment timing, rate changes, or payment allocation rules.',
    `actual_payment_amount` DECIMAL(18,2) COMMENT 'Actual total amount received for this installment. May differ from scheduled amount due to partial payments, prepayments, or payment shortfalls. Null if no payment has been received.',
    `actual_payment_date` DATE COMMENT 'Actual date on which the payment was received and applied to the loan. Null if payment has not yet been received. Used to calculate days past due and assess payment performance.',
    `actual_principal_amount` DECIMAL(18,2) COMMENT 'Actual principal reduction amount applied from the received payment. May differ from scheduled principal due to payment allocation rules, prepayments, or shortfalls.',
    `amortization_type` STRING COMMENT 'Type of amortization method used for this schedule. Level payment maintains constant total payments; level principal maintains constant principal payments; bullet has principal due at maturity; balloon has a large final payment; custom follows a non-standard pattern.. Valid values are `level payment|level principal|bullet|balloon|custom`',
    `beginning_balance` DECIMAL(18,2) COMMENT 'Outstanding principal balance at the start of this payment period, before the current installment is applied. Represents the loan balance carried forward from the previous period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amortization schedule entry was first created in the system. Represents the audit trail for schedule generation.',
    `day_count_convention` STRING COMMENT 'Method used to calculate the number of days in the accrual period and the year basis for interest calculations. Standard conventions include 30/360, Actual/365, Actual/360, and Actual/Actual.. Valid values are `30/360|Actual/365|Actual/360|Actual/Actual|30E/360`',
    `days_past_due` STRING COMMENT 'Number of days this payment is overdue, calculated as the difference between current date (or actual payment date) and the due date. Zero or null if payment is current or paid on time. Critical metric for delinquency tracking and credit risk assessment.',
    `due_date` DATE COMMENT 'Scheduled date on which this installment payment is contractually due. Used for payment processing, delinquency tracking, and cash flow forecasting.',
    `ending_balance` DECIMAL(18,2) COMMENT 'Outstanding principal balance remaining after this scheduled payment is applied. Calculated as beginning balance minus scheduled principal amount. Becomes the beginning balance for the next period.',
    `installment_number` STRING COMMENT 'Sequential number of this payment installment within the loans repayment schedule. Starts at 1 for the first payment and increments for each subsequent scheduled payment.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate in effect for this payment period, expressed as a decimal. May vary across installments for variable-rate loans or after rate resets. Used to calculate the scheduled interest amount.',
    `is_final_payment` BOOLEAN COMMENT 'Indicates whether this is the final scheduled payment for the loan. True for the last installment that brings the ending balance to zero. Used to identify loan maturity and schedule completion.',
    `is_restructured` BOOLEAN COMMENT 'Indicates whether this installment is part of a restructured payment schedule. True if the loan has been modified after origination due to borrower hardship, forbearance, or other restructuring events. Critical for regulatory reporting and credit risk classification.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late payment fee assessed for this installment if payment was received after the due date. Calculated according to the loan agreements late fee provisions. Null if payment was on time or no late fee was assessed.',
    `payment_frequency` STRING COMMENT 'Frequency at which payments are scheduled for this loan. Determines the interval between installments and affects the amortization calculation.. Valid values are `monthly|quarterly|semi-annual|annual|bi-weekly|weekly`',
    `payment_method` STRING COMMENT 'Method by which the actual payment was received for this installment. Includes ACH (Automated Clearing House), wire transfer, check, cash, card payment, or internal account transfer. Null if payment has not been received.. Valid values are `ACH|wire|check|cash|card|internal transfer`',
    `payment_status` STRING COMMENT 'Current status of this scheduled installment payment. Tracks whether the payment is still scheduled, has been paid in full, partially paid, is overdue, has been waived, or has been deferred to a future date.. Valid values are `scheduled|paid|partial|overdue|waived|deferred`',
    `prepayment_amount` DECIMAL(18,2) COMMENT 'Additional principal amount paid beyond the scheduled principal for this installment. Represents voluntary prepayments that reduce the outstanding balance faster than scheduled. Null if no prepayment occurred.',
    `restructure_date` DATE COMMENT 'Date on which the loan restructuring became effective, if applicable. Null for non-restructured installments. Used to track troubled debt restructuring (TDR) events and assess credit quality.',
    `schedule_generation_date` DATE COMMENT 'Date on which this version of the amortization schedule was generated or regenerated. Updated whenever the schedule is recalculated due to loan modifications or rate changes.',
    `schedule_version` STRING COMMENT 'Version number of this amortization schedule. Increments each time the schedule is regenerated due to loan modifications, restructuring, rate resets, or payment plan changes. Version 1 is the original schedule at loan origination.',
    `scheduled_fee_amount` DECIMAL(18,2) COMMENT 'Any contractually scheduled fees or charges included in this installment, such as servicing fees, insurance premiums, or other recurring charges.',
    `scheduled_interest_amount` DECIMAL(18,2) COMMENT 'Contractually scheduled interest charge for this payment period. Calculated based on the beginning balance, interest rate, and accrual period. Represents the cost of borrowing for this period.',
    `scheduled_principal_amount` DECIMAL(18,2) COMMENT 'Contractually scheduled principal reduction amount for this installment. This portion of the payment reduces the outstanding loan balance.',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'Total amount due for this installment, calculated as the sum of scheduled principal, interest, and fees. This is the amount the borrower is contractually obligated to pay on the due date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this amortization schedule entry was last modified. Updated whenever payment status changes, actual payment information is recorded, or schedule adjustments are made.',
    `waived_amount` DECIMAL(18,2) COMMENT 'Total amount of scheduled payment that was waived or forgiven for this installment. May include waived principal, interest, or fees due to loan modifications, hardship programs, or settlement agreements.',
    CONSTRAINT pk_amortization_schedule PRIMARY KEY(`amortization_schedule_id`)
) COMMENT 'Contractual repayment schedule for each loan facility, detailing every scheduled installment with its due date, beginning principal balance, scheduled principal payment, scheduled interest payment, total payment amount, remaining balance after payment, and actual payment status. Supports interest accrual calculations, cash flow forecasting, and ALM/treasury liquidity projections. Generated at origination and regenerated on restructuring or rate resets.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`drawdown` (
    `drawdown_id` BIGINT COMMENT 'Unique identifier for the drawdown event. Primary key for the drawdown transaction record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Drawdowns executed through specific channels. Required for liquidity management by channel, operational risk monitoring, channel capacity planning, and intraday funding analytics in corporate/trade fi',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral package or security instrument pledged against this drawdown, if applicable. Used for secured lending and Loss Given Default (LGD) calculation.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Drawdowns execute in currencies requiring currency metadata (settlement lag, convertibility, restrictions) for disbursement timing, SWIFT message formatting, nostro/vostro account selection, and regul',
    `employee_id` BIGINT COMMENT 'The user ID or employee identifier of the credit officer or system user who approved this drawdown. Used for segregation of duties and audit compliance.',
    `facility_id` BIGINT COMMENT 'Reference to the committed credit facility or loan agreement against which this drawdown is made. Links to the parent facility contract.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Drawdowns create journal entries for loan disbursement, commitment utilization, and fee recognition. Core accounting requirement for revolving facilities and term loan funding.',
    `party_id` BIGINT COMMENT 'Reference to the borrower entity executing this drawdown. May be a corporate, government, or individual borrower depending on facility type.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Drawdowns priced at benchmark rates require benchmark metadata (publication time, tenor convention, fallback rate) for interest calculation, rate fixing (observation date determination), and regulator',
    `aml_screening_status` STRING COMMENT 'Status of AML and sanctions screening for this drawdown transaction: pending (awaiting review), cleared (passed), flagged (potential match), or escalated (under investigation).. Valid values are `pending|cleared|flagged|escalated`',
    `amount` DECIMAL(18,2) COMMENT 'The principal amount drawn down by the borrower in this transaction, denominated in the drawdown currency. This amount reduces available facility headroom.',
    `approval_date` DATE COMMENT 'The date on which the drawdown request was approved by the credit officer or automated system. Required for audit trail and regulatory reporting.',
    `available_commitment_amount` DECIMAL(18,2) COMMENT 'The remaining undrawn commitment amount available under the facility after this drawdown. Calculated as facility limit minus total outstanding drawdowns.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The reference benchmark rate used for floating-rate drawdowns: SOFR (Secured Overnight Financing Rate), LIBOR (legacy), EURIBOR, SONIA, ESTR, PRIME, or BASE rate.',
    `beneficiary_account_number` STRING COMMENT 'The borrowers account number or IBAN to which the drawdown funds were credited. May be an internal DDA or an external account at another institution.',
    `commitment_utilization_pct` DECIMAL(18,2) COMMENT 'The percentage of the total facility commitment utilized after this drawdown, calculated as (total outstanding + this drawdown) / facility limit * 100. Used for covenant monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this drawdown record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the drawdown amount (e.g., USD, EUR, GBP). Multi-currency facilities may allow drawdowns in different currencies.. Valid values are `^[A-Z]{3}$`',
    `disbursement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the drawdown funds were released from the funding account. Critical for interest accrual calculation and operational reporting.',
    `drawdown_date` DATE COMMENT 'The business date on which the borrower requested or executed the drawdown. This is the transaction date for accounting and interest accrual purposes.',
    `drawdown_status` STRING COMMENT 'Current lifecycle status of the drawdown transaction: pending (awaiting approval), approved (authorized), disbursed (funds sent), settled (funds received), failed (payment failed), cancelled (voided), or reversed (unwound). [ENUM-REF-CANDIDATE: pending|approved|disbursed|settled|failed|cancelled|reversed — 7 candidates stripped; promote to reference product]',
    `drawdown_type` STRING COMMENT 'Classification of the drawdown event: scheduled (pre-agreed), unscheduled (ad-hoc), revolving (under revolving facility), term (under term loan), swing_line (short-term bridge), or overdraft (emergency).. Valid values are `scheduled|unscheduled|revolving|term|swing_line|overdraft`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any upfront or transaction fee charged to the borrower for this drawdown event. May include commitment fees, utilization fees, or processing fees.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee amount. May differ from drawdown currency in multi-currency facilities.. Valid values are `^[A-Z]{3}$`',
    `funding_account_number` STRING COMMENT 'The internal general ledger or nostro account number from which the drawdown funds were disbursed. Used for reconciliation and funds transfer pricing (FTP).',
    `gl_posting_date` DATE COMMENT 'The accounting date on which this drawdown transaction was posted to the general ledger. Used for financial reporting and period-end close processes.',
    `interest_period_days` STRING COMMENT 'The number of days in the interest period for this drawdown (e.g., 30, 90, 180). Determines the frequency of interest rate resets for floating-rate drawdowns.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The all-in interest rate applicable to this drawdown at the time of execution, expressed as a decimal (e.g., 0.0525 for 5.25%). For floating rates, this is the initial rate.',
    `interest_rate_type` STRING COMMENT 'Type of interest rate applicable to this drawdown: fixed (locked rate), floating (benchmark + spread), variable (adjustable), or zero (non-interest bearing).. Valid values are `fixed|floating|variable|zero`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this drawdown record was last updated. Tracks changes to status, amounts, or other mutable fields for audit purposes.',
    `loan_to_value_ratio` DECIMAL(18,2) COMMENT 'The ratio of the total outstanding loan amount (including this drawdown) to the appraised value of the collateral, expressed as a percentage. Key covenant metric for secured facilities.',
    `maturity_date` DATE COMMENT 'The date on which this drawdown principal is due for repayment. For revolving facilities, this may be the next scheduled repayment date or facility maturity.',
    `payment_method` STRING COMMENT 'The payment rail or mechanism used to disburse the drawdown funds: wire transfer, ACH (Automated Clearing House), RTGS (Real-Time Gross Settlement), SWIFT, internal book transfer, or check.. Valid values are `wire|ACH|RTGS|SWIFT|internal_transfer|check`',
    `purpose` STRING COMMENT 'Business purpose or use of funds for this drawdown as declared by the borrower. May be required for covenant compliance, regulatory reporting, or trade finance documentation.',
    `reference_number` STRING COMMENT 'Externally visible unique reference number for this drawdown event, used in customer communications, SWIFT messages, and settlement instructions.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this drawdown must be included in regulatory reports such as CCAR, DFAST, or Basel III capital adequacy filings. True if reportable, false otherwise.',
    `repayment_type` STRING COMMENT 'The repayment structure for this drawdown: bullet (single payment at maturity), amortizing (scheduled installments), revolving (flexible repayment and re-draw), or on_demand (callable).. Valid values are `bullet|amortizing|revolving|on_demand`',
    `risk_weight_pct` DECIMAL(18,2) COMMENT 'The Basel III risk weight percentage applied to this drawdown exposure for Risk-Weighted Assets (RWA) calculation. Varies by borrower credit rating and collateral.',
    `settlement_date` DATE COMMENT 'The date on which the drawdown funds were actually transferred to the borrowers account. Reflects T+0, T+1, or T+2 settlement depending on payment rail.',
    `settlement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the drawdown funds were confirmed as received in the beneficiary account. Used for reconciliation and SLA tracking.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The credit spread over the benchmark rate, expressed in basis points (e.g., 150.00 for 1.50%). This spread reflects the borrowers credit risk premium.',
    `swift_message_reference` STRING COMMENT 'The SWIFT MT103 or MT202 message reference number for cross-border or interbank drawdown settlements. Used for payment tracking and reconciliation.',
    `syndication_flag` BOOLEAN COMMENT 'Indicates whether this drawdown is part of a syndicated loan facility with multiple lender participants. True if syndicated, false if bilateral.',
    `trade_finance_reference` STRING COMMENT 'Reference to the underlying trade finance instrument if this drawdown is linked to a letter of credit, documentary collection, or bill of lading. Used for UCP 600 compliance.',
    `value_date` DATE COMMENT 'The effective date on which funds are made available to the borrower and interest accrual begins. May differ from drawdown_date due to settlement cycles.',
    CONSTRAINT pk_drawdown PRIMARY KEY(`drawdown_id`)
) COMMENT 'Records each individual drawdown (disbursement) event against a committed credit facility, capturing drawdown date, drawdown amount, currency, applicable interest rate at drawdown, drawdown purpose, funding account, value date, and settlement reference. For revolving facilities, tracks multiple drawdowns and repayments over the facility lifecycle. Key transactional event in Loan IQs drawdown module.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`repayment` (
    `repayment_id` BIGINT COMMENT 'Unique identifier for the loan repayment transaction. Primary key for the repayment data product.',
    `ctr_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.ctr_filing. Business justification: Large cash repayments exceeding $10,000 trigger CTR filings under BSA regulations. Banks must link CTR filings to specific repayment transactions that triggered the reporting requirement for audit tra',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Repayments received in currencies require currency metadata (rounding, minor unit) for payment application (principal/interest allocation), GL posting, reconciliation, and financial reporting. Reuses ',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Repayment transactions are monitored for fraud (unauthorized payments, account takeover, mule account activity). Linking repayment to alert supports investigation, customer reimbursement decisions, an',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Repayments generate journal entries for cash receipt, principal reduction, interest income recognition, and fee collection. Required for daily accounting posting and revenue recognition compliance.',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Core loan servicing process: every loan repayment (principal, interest, fees) is executed via a payment instruction through the banks payment rails. Regulatory reporting (FFIEC 031/041) requires trac',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account against which this repayment is applied. Links to the loan master data product.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Direct operational requirement: loan repayments are debited from specific customer deposit accounts. Existing source_account_number is denormalized string; proper FK enables automated ACH/direct debit',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the repayment transaction was approved for processing. Null for automated payments that do not require manual approval.',
    `approved_by` STRING COMMENT 'Identifier of the employee or system user who approved the repayment transaction, particularly for manual or exception-based payments. Used for audit and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this repayment record was first created in the system. Audit field for data lineage and compliance.',
    `days_past_due` STRING COMMENT 'Number of days between the scheduled_payment_date and the actual payment_date. Positive values indicate late payment; negative values indicate early payment. Zero indicates on-time payment.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign Exchange (FX) rate applied if the repayment currency differs from the loan currency. Null if no currency conversion occurred.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Portion of the payment allocated to fees such as servicing fees, processing fees, or prepayment fees. Excludes penalty interest.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Portion of the payment allocated to accrued interest charges on the loan. Contributes to Net Interest Income (NII) calculation.',
    `notes` STRING COMMENT 'Free-text field for additional comments or context about the repayment transaction. Used for customer service, dispute resolution, and audit purposes.',
    `outstanding_balance_after_payment` DECIMAL(18,2) COMMENT 'Remaining principal balance on the loan immediately after this repayment is applied. Critical for Exposure at Default (EAD) and credit risk calculations.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount received in this repayment transaction, including principal, interest, fees, and penalties. Gross payment amount before allocation.',
    `payment_channel` STRING COMMENT 'The customer-facing channel through which the repayment was initiated. Distinct from payment_method; tracks the interface used by the customer.. Valid values are `Branch|Online Banking|Mobile App|ATM|Phone Banking|Mail`',
    `payment_date` DATE COMMENT 'The date on which the repayment was received and applied to the loan account. This is the business event date for the repayment transaction.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used to make the repayment. Includes Automated Clearing House (ACH), wire transfer, Real-Time Gross Settlement (RTGS), check, cash, or direct debit.. Valid values are `ACH|Wire|RTGS|Check|Cash|Direct Debit`',
    `payment_processor_code` STRING COMMENT 'Identifier of the payment processing system or hub that handled this transaction. References systems such as ACI Worldwide or Volante payment platforms.',
    `payment_reference_number` STRING COMMENT 'External payment reference number or transaction identifier provided by the payment system or customer. Used for reconciliation and customer inquiries.',
    `payment_status` STRING COMMENT 'Current processing status of the repayment transaction. Tracks lifecycle from receipt through application to the loan account.. Valid values are `Received|Applied|Reversed|Failed|Pending`',
    `payment_timeliness` STRING COMMENT 'Classification of whether the payment was received on-time, early, or late relative to the scheduled_payment_date. Critical for Non-Performing Loan (NPL) classification and delinquency tracking.. Valid values are `On-Time|Early|Late`',
    `payment_type` STRING COMMENT 'Classification of the repayment transaction type. Scheduled indicates a regular installment; prepayment indicates early principal reduction; partial indicates less than scheduled amount; balloon indicates large lump-sum; final indicates loan payoff.. Valid values are `Scheduled|Prepayment|Partial|Balloon|Final`',
    `penalty_interest_amount` DECIMAL(18,2) COMMENT 'Portion of the payment allocated to penalty interest charges for late payment or covenant breach. Tracked separately for regulatory reporting.',
    `posting_date` DATE COMMENT 'The date on which the repayment was posted to the General Ledger (GL) for accounting purposes. May differ from payment_date due to batch processing.',
    `prepayment_flag` BOOLEAN COMMENT 'Indicates whether this repayment includes a prepayment component (principal paid ahead of schedule). True if prepayment occurred; false otherwise.',
    `principal_amount` DECIMAL(18,2) COMMENT 'Portion of the payment allocated to reduce the outstanding principal balance of the loan. Core component for amortization tracking.',
    `reversal_date` DATE COMMENT 'The date on which the repayment transaction was reversed, if applicable. Null if the transaction has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this repayment transaction has been reversed due to insufficient funds, dispute, or error. True if reversed; false otherwise.',
    `reversal_reason` STRING COMMENT 'Explanation for why the repayment was reversed, if applicable. Includes reasons such as insufficient funds, customer dispute, or processing error. Null if not reversed.',
    `scheduled_payment_date` DATE COMMENT 'The originally scheduled due date for this repayment installment per the loan amortization schedule. Used to determine if payment is on-time, early, or late.',
    `source_bank_bic` STRING COMMENT 'Bank Identifier Code (BIC) or SWIFT code of the financial institution from which the payment originated. Required for cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the repayment transaction was processed by the payment system. Used for audit trail and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this repayment record was last modified. Audit field for tracking changes and ensuring data integrity.',
    `value_date` DATE COMMENT 'The effective date from which the repayment amount is considered for interest calculation purposes. May differ from payment_date due to settlement timing.',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Amount of fees or penalties waived by the bank as part of this repayment transaction. Used for customer relationship management and regulatory reporting.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving fees or penalties, if applicable. Includes reasons such as customer goodwill, hardship, or error correction. Null if no waiver applied.',
    CONSTRAINT pk_repayment PRIMARY KEY(`repayment_id`)
) COMMENT 'Records each principal and interest repayment transaction against a loan account, including payment date, payment amount, principal component, interest component, fee component, penalty interest (if any), payment method (ACH, wire, RTGS), payment source account, outstanding balance post-payment, and whether the payment was on-time, early, or late. Feeds NPL classification and delinquency tracking.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`covenant` (
    `covenant_id` BIGINT COMMENT 'Unique identifier for the covenant record. Primary key.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Loan covenants frequently include collateral maintenance requirements (minimum coverage ratios, permitted liens, negative pledge clauses) tied to specific pledge agreements. Covenant monitoring system',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Covenant breaches may constitute compliance breaches when they violate regulatory lending limits, concentration rules, or safety-and-soundness standards. Links credit covenant monitoring to regulatory',
    `facility_id` BIGINT COMMENT 'Reference to the credit facility or loan agreement to which this covenant is attached.',
    `covenant_package_id` BIGINT COMMENT 'Identifier linking this covenant to a standard covenant package or template used across multiple facilities, enabling consistent covenant management and benchmarking.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Covenants mandated by regulatory frameworks (Basel III leverage ratio, IFRS 9 SPPI test) require taxonomy linkage for compliance reporting, audit trail, and regulatory examination. Reuses regulatory_f',
    `amendment_count` STRING COMMENT 'Number of times this covenant has been amended since origination, tracking the history of modifications to covenant terms.',
    `breach_consequence` STRING COMMENT 'Description of the consequences if the covenant is breached, such as event of default, increased interest rate, mandatory prepayment, or requirement for additional collateral.',
    `covenant_category` STRING COMMENT 'Detailed sub-classification of the covenant within its type, such as leverage ratio, interest coverage, debt service coverage, capital expenditure limit, dividend restriction, or asset sale restriction.',
    `covenant_description` STRING COMMENT 'Detailed textual description of the covenant terms, conditions, and requirements as documented in the credit agreement.',
    `covenant_name` STRING COMMENT 'Human-readable name or title of the covenant as stated in the credit agreement documentation.',
    `covenant_status` STRING COMMENT 'Current lifecycle status of the covenant indicating whether it is actively monitored, temporarily suspended, waived, terminated, in breach, or breach has been cured.. Valid values are `active|suspended|waived|terminated|breached|cured`',
    `covenant_type` STRING COMMENT 'Classification of the covenant based on its nature: financial (ratio-based), affirmative (actions required), negative (restrictions), reporting (disclosure obligations), or information (notification requirements).. Valid values are `financial|affirmative|negative|reporting|information`',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this covenant record, supporting audit trail requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this covenant record was first created in the system, supporting audit trail and data lineage requirements.',
    `cross_default_flag` BOOLEAN COMMENT 'Indicates whether a breach of this covenant triggers cross-default provisions in other credit facilities or debt instruments of the borrower.',
    `cure_mechanism` STRING COMMENT 'Description of the permitted cure mechanism, such as equity contribution, asset sale proceeds application, or other remediation methods allowed under the credit agreement.',
    `cure_provision_flag` BOOLEAN COMMENT 'Indicates whether the credit agreement includes a cure provision allowing the borrower to remedy a covenant breach through equity injection or other specified actions.',
    `data_classification` STRING COMMENT 'Classification level of this covenant record based on sensitivity, typically confidential due to commercial lending terms and borrower financial information.. Valid values are `restricted|confidential|internal|public`',
    `effective_date` DATE COMMENT 'Date from which the covenant becomes binding and compliance testing begins.',
    `expiration_date` DATE COMMENT 'Date on which the covenant obligation terminates, typically aligned with facility maturity or earlier if specified. Null for covenants that remain in effect for the life of the facility.',
    `financial_statement_source` STRING COMMENT 'Type of financial statements required for covenant testing, such as audited annual statements, unaudited quarterly statements, management-certified financials, or regulatory filings.. Valid values are `audited|unaudited|management_certified|regulatory_filing`',
    `grace_period_days` STRING COMMENT 'Number of days allowed after a covenant breach before it constitutes an event of default, providing the borrower time to cure the breach.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this covenant. Null if the covenant has never been amended.',
    `materiality_classification` STRING COMMENT 'Risk-based classification of the covenants importance to credit risk management, with critical covenants triggering immediate escalation upon breach.. Valid values are `critical|high|medium|low`',
    `measurement_basis` STRING COMMENT 'Accounting or calculation methodology used to measure covenant compliance, including definitions of terms like EBITDA, net debt, or tangible net worth as specified in the credit agreement.',
    `measurement_frequency` STRING COMMENT 'Frequency at which covenant compliance must be tested and reported, such as quarterly for financial covenants or event-driven for negative covenants.. Valid values are `monthly|quarterly|semi_annually|annually|on_demand|event_driven`',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this covenant record, supporting audit trail requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this covenant record was last modified, tracking changes for audit and compliance purposes.',
    `reference_number` STRING COMMENT 'External business identifier for the covenant, typically referenced in loan documentation and credit agreements.',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework or requirement that mandates this covenant, such as Basel III, CCAR, DFAST, or CECL. Null for commercial covenants.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this covenant is mandated by regulatory requirements such as Basel III capital adequacy, Dodd-Frank Act stress testing (DFAST), or Comprehensive Capital Analysis and Review (CCAR) rather than being a commercial lending term.',
    `reporting_deadline_days` STRING COMMENT 'Number of days after the measurement period end by which the borrower must report covenant compliance results to the lender, typically 30-45 days for quarterly financial covenants.',
    `responsible_party` STRING COMMENT 'Entity responsible for maintaining compliance with this covenant, which may be the borrower, a guarantor, parent company, or specific subsidiary.. Valid values are `borrower|guarantor|parent_company|subsidiary`',
    `source_system` STRING COMMENT 'Name of the operational system from which this covenant record originated, such as Finastra Fusion Loan IQ or other loan origination and covenant tracking systems.',
    `source_system_code` STRING COMMENT 'Unique identifier for this covenant in the source operational system, enabling traceability and reconciliation between lakehouse and source systems.',
    `testing_level` STRING COMMENT 'Organizational level at which covenant compliance is measured, such as consolidated group, standalone borrower, guarantor group, or restricted subsidiary group.. Valid values are `consolidated|standalone|guarantor_group|restricted_group`',
    `threshold_operator` STRING COMMENT 'Comparison operator that defines the compliance condition relative to the threshold value (e.g., must not exceed, must be greater than, must maintain at least). [ENUM-REF-CANDIDATE: greater_than|less_than|equal_to|greater_or_equal|less_or_equal|between|not_exceed — 7 candidates stripped; promote to reference product]',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value, such as ratio (x), percentage (%), currency amount (USD), or basis points (BPS).',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold or limit that defines compliance for financial covenants, such as maximum leverage ratio of 3.5x or minimum interest coverage of 2.0x.',
    `waiver_effective_date` DATE COMMENT 'Date from which the covenant waiver becomes effective. Null if no waiver has been granted.',
    `waiver_expiration_date` DATE COMMENT 'Date on which the covenant waiver expires and normal compliance obligations resume. Null for permanent waivers or if no waiver has been granted.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver has been granted by the lender(s) for this covenant, temporarily or permanently relieving the borrower from compliance obligations.',
    CONSTRAINT pk_covenant PRIMARY KEY(`covenant_id`)
) COMMENT 'Master record of all financial and non-financial covenants attached to credit facilities, including complete periodic compliance test history. Captures covenant type (financial ratio, reporting, affirmative, negative), threshold value or condition, measurement frequency, grace period, waiver flag, and for each test period: test date, actual measured value, compliance status (pass, breach, waiver granted), breach severity, remediation deadline, and analyst notes. Provides complete covenant lifecycle from definition through ongoing monitoring with full audit trail for regulatory examination and credit review.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`loan_ecl_provision` (
    `loan_ecl_provision_id` BIGINT COMMENT 'Unique identifier for the expected credit loss provision record.',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: ECL provisions directly impact projected capital ratios in forward-looking capital plans under CCAR/ICAAP frameworks. Essential for stress testing and capital adequacy planning.',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: ECL provision calculations under IFRS9/CECL require current collateral valuations to estimate LGD and recovery amounts. Finance teams must link each provision calculation to the specific valuation use',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: ECL provisions calculated in currencies require currency metadata (rounding, minor unit) for consolidation (group reporting currency translation), regulatory reporting (IFRS 9 disclosures), and GL pos',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: ECL provision movements generate journal entries for credit loss expense and allowance adjustments. Mandatory for IFRS 9/CECL compliance and regulatory reporting (CCAR, stress testing).',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan for which this ECL provision is calculated.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: IFRS 9 ECL calculations require forward-looking macroeconomic scenarios for probability-weighted provisioning. Macroeconomic_scenario is a denormalized scenario name that should reference the full str',
    `accounting_framework` STRING COMMENT 'The accounting standard under which this provision is calculated (IFRS 9, CECL/ASC 326, or Local GAAP).. Valid values are `IFRS 9|CECL|Local GAAP`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this provision calculation was approved for financial reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the credit risk officer or committee that approved this provision calculation.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when this ECL provision calculation was performed.',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'The ratio of collateral value to exposure at default (collateral_value / EAD), expressed as a decimal.',
    `collateral_value` DECIMAL(18,2) COMMENT 'The current fair value of collateral securing the loan, used in LGD calculation.',
    `comments` STRING COMMENT 'Free-text field for additional notes, assumptions, or qualitative factors considered in the provision calculation.',
    `credit_impaired_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the loan is credit-impaired (Stage 3 under IFRS 9 or NPL status).',
    `cumulative_provision_amount` DECIMAL(18,2) COMMENT 'The total accumulated provision balance for this loan as of the reporting date.',
    `days_past_due` STRING COMMENT 'The number of days the loan payment is overdue at the reporting date, a key input for stage classification.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The effective interest rate used to discount expected credit losses to present value, typically the loans original effective interest rate.',
    `ead` DECIMAL(18,2) COMMENT 'The total value of the loan exposure at the time of default, including drawn and undrawn committed amounts.',
    `ecl_model_code` STRING COMMENT 'Identifier of the ECL calculation model or methodology used (e.g., PD/LGD/EAD model, vintage analysis, roll-rate model).',
    `forbearance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the loan is under forbearance or modification due to borrower financial difficulty.',
    `lgd` DECIMAL(18,2) COMMENT 'The estimated percentage of exposure that will be lost if the borrower defaults, expressed as a decimal (e.g., 0.45 = 45%).',
    `model_version` STRING COMMENT 'The version identifier of the ECL model used for this calculation, supporting model governance and audit trails.',
    `override_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the provision amount was manually overridden by credit risk management.',
    `override_reason` STRING COMMENT 'Explanation for any manual override of the model-calculated provision amount.',
    `pd` DECIMAL(18,2) COMMENT 'The probability that the borrower will default over the relevant time horizon (12-month or lifetime), expressed as a decimal (e.g., 0.025 = 2.5%).',
    `previous_stage_classification` STRING COMMENT 'The credit risk stage classification in the prior reporting period, used to track stage migrations.. Valid values are `Stage 1|Stage 2|Stage 3|12-Month ECL|Lifetime ECL|Credit-Impaired`',
    `provision_amount` DECIMAL(18,2) COMMENT 'The calculated expected credit loss provision amount for this loan at the reporting date.',
    `provision_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the provision amount.. Valid values are `^[A-Z]{3}$`',
    `provision_movement_amount` DECIMAL(18,2) COMMENT 'The net change in provision amount for this period (positive for increases, negative for releases).',
    `provision_movement_type` STRING COMMENT 'The type of movement in the provision balance: New (initial provision), Increase (additional provision), Decrease (partial release), Release (full release), Write-Off (charge-off against provision), Transfer (stage migration).. Valid values are `New|Increase|Decrease|Release|Write-Off|Transfer`',
    `provision_number` STRING COMMENT 'Business identifier for the provision record, used for external reporting and audit trails.',
    `recovery_rate` DECIMAL(18,2) COMMENT 'The expected recovery rate in the event of default, expressed as a decimal (1 - LGD).',
    `regulatory_reporting_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this provision record is included in regulatory capital and stress testing reports (Basel III, CCAR, DFAST).',
    `reporting_period_date` DATE COMMENT 'The financial reporting period end date for which this ECL provision is calculated (e.g., quarter-end, year-end).',
    `scenario_weight` DECIMAL(18,2) COMMENT 'The probability weight assigned to this macroeconomic scenario in the weighted-average ECL calculation, expressed as a decimal (e.g., 0.60 = 60%).',
    `significant_increase_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether there has been a significant increase in credit risk since initial recognition (triggers Stage 2 under IFRS 9).',
    `stage_classification` STRING COMMENT 'Credit risk staging under IFRS 9 (Stage 1, 2, 3) or CECL classification (12-Month ECL, Lifetime ECL, Credit-Impaired). Stage 1: performing loans with no significant increase in credit risk. Stage 2: significant increase in credit risk since origination. Stage 3: credit-impaired/non-performing.. Valid values are `Stage 1|Stage 2|Stage 3|12-Month ECL|Lifetime ECL|Credit-Impaired`',
    `stage_migration_date` DATE COMMENT 'The date when the loan migrated to the current stage classification, if applicable.',
    `time_to_default_months` STRING COMMENT 'The estimated time horizon in months over which the default probability is measured (12 for Stage 1, lifetime for Stage 2/3).',
    CONSTRAINT pk_loan_ecl_provision PRIMARY KEY(`loan_ecl_provision_id`)
) COMMENT 'Expected Credit Loss (ECL) impairment provisioning records under CECL (ASC 326) and IFRS 9 frameworks. Captures staging classification (Stage 1, 2, 3 under IFRS 9 or lifetime/12-month under CECL), provision amount, ECL model used, PD, LGD, EAD inputs, discount rate, forward-looking macroeconomic overlays, provision movement (new, release, increase), and reporting period. SSOT for loan loss reserve calculations.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`loan_syndication` (
    `loan_syndication_id` BIGINT COMMENT 'Unique identifier for the syndicated loan arrangement. Primary key for the loan syndication entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Syndications structured in currencies require currency metadata (convertibility, settlement lag) for lender allocation, commitment tracking, settlement instructions, and regulatory reporting (large ex',
    `employee_id` BIGINT COMMENT 'System user identifier of the person or service account that last modified this syndication record. Supports audit trail and accountability for data changes.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Syndicated loans require KYC on all participant lenders for AML purposes, especially when participants are foreign banks. Agent banks must verify participant identities and assess AML risk before synd',
    `loan_account_id` BIGINT COMMENT 'Reference to the underlying loan facility that is being syndicated. Links to the master loan record in the core banking system.',
    `party_id` BIGINT COMMENT 'Reference to the financial institution serving as lead arranger responsible for structuring the syndication, marketing to potential lenders, and coordinating the syndicate formation.',
    `allocation_methodology` STRING COMMENT 'Method used by lead arrangers to allocate participations when syndication is oversubscribed. First come first served honors commitment timing; relationship based favors key bank relationships; pro rata scale reduces all commitments proportionally; tiered priority uses commitment size tiers.. Valid values are `first_come_first_served|relationship_based|pro_rata_scale|tiered_priority`',
    `arranger_fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid to lead arranger(s) for structuring and syndicating the loan. Separate from upfront fees paid to all lenders. Confidential commercial term.',
    `borrower_consent_required_flag` BOOLEAN COMMENT 'Indicates whether borrower consent is required for lender assignments or participations. True means borrower has approval rights over syndicate composition changes; false allows free transferability subject only to credit criteria.',
    `close_date` DATE COMMENT 'Date when the syndication process was completed, all lender commitments finalized, and participation allocations confirmed. After this date, the syndicate structure is locked unless secondary market transfers occur.',
    `commitment_deadline_date` DATE COMMENT 'Final date by which prospective lenders must submit binding commitments to participate in the syndication. After this date, allocations are finalized and late commitments are not accepted.',
    `confidentiality_tier` STRING COMMENT 'Level of confidentiality assigned to syndication information. Public allows broad distribution; private restricts to committed lenders; highly confidential limits to lead arrangers and named parties only.. Valid values are `public|private|highly_confidential`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this syndication record was first created in the loan origination or syndication management system. Used for audit trail and data lineage tracking.',
    `documentation_type` STRING COMMENT 'Standard documentation framework used for the syndication. LMA (Loan Market Association) standard for European markets; LSTA (Loan Syndications and Trading Association) standard for US markets; custom for bespoke terms; bilateral form adapted for syndication.. Valid values are `lma_standard|lsta_standard|custom|bilateral_form`',
    `final_pricing_spread_bps` STRING COMMENT 'Final agreed pricing spread over the reference rate in basis points at syndication close. May differ from original spread if market flex was exercised. Represents the actual pricing achieved in the market.',
    `flex_exercised_flag` BOOLEAN COMMENT 'Indicates whether the lead arrangers exercised market flex provisions to modify loan terms during syndication. True indicates terms were adjusted from initial launch parameters to achieve full placement.',
    `green_loan_flag` BOOLEAN COMMENT 'Indicates whether the syndicated loan qualifies as a green loan under Loan Market Association Green Loan Principles, with proceeds dedicated to environmentally beneficial projects and subject to sustainability reporting requirements.',
    `launch_date` DATE COMMENT 'Date when the syndication was formally launched to the market and potential lenders were invited to participate. Marks the beginning of the marketing period.',
    `lender_meeting_date` DATE COMMENT 'Date of the formal lender presentation or bank meeting where the borrower and lead arrangers presented the credit opportunity to prospective syndicate participants. Key milestone in the marketing process.',
    `mandate_date` DATE COMMENT 'Date when the borrower formally awarded the syndication mandate to the lead arranger(s). Marks the official start of the syndication process.',
    `market_flex_provision` STRING COMMENT 'Type of flexibility granted to lead arrangers to adjust loan terms if market conditions require changes to achieve successful syndication. Pricing flex allows rate adjustments; structure flex allows covenant or maturity changes; full flex allows both; none means terms are locked.. Valid values are `none|pricing_flex|structure_flex|full_flex`',
    `minimum_hold_amount` DECIMAL(18,2) COMMENT 'Minimum commitment amount that the lead arranger has contractually agreed to retain. Demonstrates skin in the game and alignment with syndicate lenders.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this syndication record was last updated. Tracks the most recent change to any field in the record for audit and change management purposes.',
    `number_of_lenders` STRING COMMENT 'Total count of financial institutions participating in the syndicate as lenders. Includes lead arrangers, co-arrangers, and participating lenders at all commitment tiers.',
    `original_pricing_spread_bps` STRING COMMENT 'Initial pricing spread over the reference rate (SOFR, LIBOR, etc.) in basis points at syndication launch. Used to track pricing flex if terms were adjusted during marketing.',
    `oversubscription_amount` DECIMAL(18,2) COMMENT 'Total amount of lender commitments received in excess of the target syndicated amount. Null if syndication was not oversubscribed. Used to calculate allocation scaling factors.',
    `oversubscription_flag` BOOLEAN COMMENT 'Indicates whether the syndication received commitments exceeding the target amount, requiring allocation scaling. True indicates strong market demand and potential for improved pricing terms.',
    `pro_rata_sharing_flag` BOOLEAN COMMENT 'Indicates whether all syndicate lenders share pro rata in payments, collateral, and recoveries based on their commitment percentages. True enforces equal treatment; false allows priority structures.',
    `purpose` STRING COMMENT 'Business rationale for syndicating the loan. Common purposes include risk distribution, regulatory capital relief, relationship capacity management, fee generation, or market-making activity.',
    `record_source_system` STRING COMMENT 'Name of the operational system that originated this syndication record (e.g., Finastra Fusion Loan IQ, Murex, custom syndication platform). Used for data lineage and reconciliation across enterprise systems.',
    `reference_number` STRING COMMENT 'External business identifier for the syndication arrangement used in communications with participating lenders and regulatory reporting.. Valid values are `^SYN-[A-Z0-9]{8,12}$`',
    `regulatory_hold_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount that the lead arranger is permitted to retain on its own balance sheet under regulatory large exposure limits. Drives minimum syndication distribution requirements.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this syndication requires specific regulatory reporting to supervisory authorities under large exposure rules, concentration risk frameworks, or syndicated lending disclosure requirements.',
    `sustainability_linked_flag` BOOLEAN COMMENT 'Indicates whether the loan includes sustainability-linked pricing mechanisms where the interest margin adjusts based on the borrowers achievement of predefined Environmental, Social, and Governance (ESG) performance targets.',
    `syndication_status` STRING COMMENT 'Current lifecycle stage of the syndication process. Mandate awarded indicates lead arranger selected; structuring involves term sheet development; marketing is active lender solicitation; allocation is commitment distribution; closed is final participation confirmed; cancelled indicates syndication abandoned.. Valid values are `mandate_awarded|structuring|marketing|allocation|closed|cancelled`',
    `syndication_type` STRING COMMENT 'Classification of the syndication structure. Club deal involves a small group of relationship lenders; broadly syndicated involves wider institutional distribution; best efforts means no underwriting commitment; underwritten means lead arrangers guarantee full placement; sub-participation involves risk transfer without borrower notification.. Valid values are `club_deal|broadly_syndicated|best_efforts|underwritten|sub_participation`',
    `total_syndicated_amount` DECIMAL(18,2) COMMENT 'Total facility amount being syndicated across all participating lenders. Represents the aggregate commitment that will be distributed among syndicate members.',
    `transfer_restriction_type` STRING COMMENT 'Classification of restrictions on secondary market transfers of syndicate participations. Freely transferable allows unrestricted assignment; consent required needs borrower or agent approval; restricted list limits transfers to approved institutions; prohibited blocks all transfers.. Valid values are `freely_transferable|consent_required|restricted_list|prohibited`',
    `upfront_fee_bps` STRING COMMENT 'One-time upfront fee paid to syndicate lenders at closing, expressed in basis points of their commitment amount. Compensates lenders for underwriting and structuring work.',
    `voting_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage of syndicate lender commitments required to approve material amendments or waivers to the loan agreement. Typically 50%, 66.67%, or 100% depending on the action type.',
    CONSTRAINT pk_loan_syndication PRIMARY KEY(`loan_syndication_id`)
) COMMENT 'Master record for syndicated loan arrangements, capturing the syndication structure including lead arranger, agent bank, total syndicated amount, syndication close date, number of lenders, syndication type (club deal, broadly syndicated), market flex terms, and regulatory hold limits. Links to individual lender participations via the participation entity. Supports Investment Banking syndicated lending advisory.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`lender_participation` (
    `lender_participation_id` BIGINT COMMENT 'Unique identifier for the lender participation record in the syndicated loan facility.',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Syndication participations create credit exposures requiring regulatory capital measurement and credit risk monitoring. Ead/lgd/pd/ecl/rwa are denormalized exposure metrics that should be sourced from',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Lender participations denominated in currencies require currency metadata (rounding, minor unit) for commitment tracking, risk weighting (RWA calculation), ECL provisioning, and regulatory reporting (',
    `loan_syndication_id` BIGINT COMMENT 'Reference to the parent syndicated loan facility in which this lender participates.',
    `party_id` BIGINT COMMENT 'Reference to the financial institution participating as a lender in the syndicated facility.',
    `syndication_allocation_id` BIGINT COMMENT 'Foreign key linking to investment.syndication_allocation. Business justification: Lender participations in loan syndications correspond to investment banking syndication allocations—parallel views of same economic participation. Investment banking allocates; lending books. Essentia',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'Interest income accrued but not yet paid on the lenders funded participation balance, calculated from last payment date to current date.',
    `assignment_date` DATE COMMENT 'Date on which the lenders participation was assigned, transferred, or novated from another lender or originated in primary syndication.',
    `collateral_allocation_percentage` DECIMAL(18,2) COMMENT 'Lenders pro-rata share of collateral securing the syndicated facility, expressed as decimal (e.g., 0.1250 for 12.50%), used for recovery calculations in default scenarios.',
    `comments` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual information related to the lender participation that does not fit structured fields.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Total committed capital amount that the lender has agreed to provide to the syndicated facility, representing the maximum exposure.',
    `commitment_fee_rate` DECIMAL(18,2) COMMENT 'Annual fee rate charged on the unfunded commitment portion, expressed as decimal percentage (e.g., 0.0050 for 0.50% or 50 basis points).',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the lenders identity and participation details are confidential and not disclosed to the borrower. True if confidential, false if disclosed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the lender participation record was first created in the loan origination system.',
    `effective_date` DATE COMMENT 'Date from which the lenders participation becomes legally binding and operational, marking the start of commitment period.',
    `funded_amount` DECIMAL(18,2) COMMENT 'Actual amount of capital that the lender has disbursed or drawn down from their commitment to date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the lender participation record was most recently updated, capturing any changes to commitment, funding, or status.',
    `last_payment_date` DATE COMMENT 'Date of the most recent principal or interest payment received by the lender on this participation.',
    `maturity_date` DATE COMMENT 'Date on which the lenders participation commitment expires and all outstanding funded amounts must be repaid.',
    `modified_by_user` STRING COMMENT 'User identifier or name of the system user who last modified the participation record, supporting audit and compliance requirements.',
    `next_payment_due_date` DATE COMMENT 'Date on which the next scheduled principal or interest payment is due to the lender.',
    `participation_fee_amount` DECIMAL(18,2) COMMENT 'Upfront or recurring fee paid to the lender for participating in the syndicated facility, separate from interest income.',
    `participation_role` STRING COMMENT 'Functional role of the lender in the syndicate structure: lead arranger (organizes syndicate), bookrunner (manages allocation), agent (administrative duties), co-agent (supporting agent), participant (passive lender), or underwriter (guarantees placement).. Valid values are `lead_arranger|bookrunner|agent|co_agent|participant|underwriter`',
    `participation_status` STRING COMMENT 'Current lifecycle status of the lender participation: active (operational), pending (awaiting settlement), settled (funds transferred), terminated (participation ended), defaulted (borrower default), or transferred (sold to another lender).. Valid values are `active|pending|settled|terminated|defaulted|transferred`',
    `participation_type` STRING COMMENT 'Classification of the lenders participation structure: primary syndication member, sub-participation (unfunded risk transfer), assignment (funded transfer with borrower consent), novation (full replacement), risk participation (credit risk transfer only), or funded participation (capital commitment).. Valid values are `primary|sub_participation|assignment|novation|risk_participation|funded_participation`',
    `pro_rata_share_percentage` DECIMAL(18,2) COMMENT 'Lenders proportional ownership percentage of the total syndicated facility, used for fee distribution and payment allocation calculations. Expressed as decimal (e.g., 0.1250 for 12.50%).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this participation must be included in regulatory capital and liquidity reporting (e.g., CCAR, DFAST, Basel III). True if reportable, false if exempt.',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'Basel III risk weighting applied to the participation exposure for regulatory capital calculation purposes, expressed as percentage (e.g., 100.00 for 100%).',
    `settlement_date` DATE COMMENT 'Date on which the cash settlement for the participation was completed and funds were transferred between parties.',
    `settlement_status` STRING COMMENT 'Current state of cash settlement for the participation: pending (awaiting funds transfer), settled (funds received), failed (settlement unsuccessful), reversed (settlement unwound), or reconciled (confirmed and matched).. Valid values are `pending|settled|failed|reversed|reconciled`',
    `stage_classification` STRING COMMENT 'IFRS 9 impairment stage classification: stage_1 (performing, 12-month ECL), stage_2 (significant increase in credit risk, lifetime ECL), or stage_3 (credit-impaired, lifetime ECL with interest suspension).. Valid values are `stage_1|stage_2|stage_3`',
    `syndication_tier` STRING COMMENT 'Seniority tier of the lenders participation in the capital structure: senior (first lien priority), mezzanine (second lien), subordinated (unsecured), or junior (lowest priority).. Valid values are `senior|mezzanine|subordinated|junior`',
    `transfer_premium_discount` DECIMAL(18,2) COMMENT 'Difference between transfer price and par value of the participation, representing premium (positive) or discount (negative) paid in secondary market transaction.',
    `transfer_price` DECIMAL(18,2) COMMENT 'Purchase price paid by the lender when acquiring the participation through secondary market assignment or sub-participation, may differ from par value.',
    `unfunded_commitment` DECIMAL(18,2) COMMENT 'Remaining undrawn portion of the lenders commitment, calculated as commitment_amount minus funded_amount, representing contingent exposure.',
    `voting_rights_flag` BOOLEAN COMMENT 'Indicates whether the lender retains voting rights on material amendments, waivers, and consents under the credit agreement. True if voting rights are held, false if waived or transferred.',
    CONSTRAINT pk_lender_participation PRIMARY KEY(`lender_participation_id`)
) COMMENT 'Records each lenders participation share in a syndicated loan facility, capturing lender institution, commitment amount, funded amount, unfunded commitment, pro-rata share percentage, participation type (primary, sub-participation), assignment date, and settlement status. Enables agent bank position management and lender fee distribution calculations in Loan IQs agency module.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`loan_fee_schedule` (
    `loan_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fee schedule record. Primary key for the fee schedule entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee schedules accrued in currencies require currency metadata (rounding, minor unit) for billing, revenue recognition (IFRS 15), GL posting, and financial reporting (fee income by currency). Reuses cu',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee schedules require GL account assignment for accrual, billing, and revenue recognition per fee type. Essential for fee income accounting and revenue recognition (ASC 606/IFRS 15).',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Fee billing and collection process: commitment fees, facility fees, and other loan-related charges are collected via payment instructions (direct debit, wire transfer). Required for revenue recognitio',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan facility or credit agreement to which this fee schedule applies. Links fee schedule to the underlying loan product.',
    `accrual_end_date` DATE COMMENT 'Date on which fee accrual ceases. For term loans, typically the maturity date; for revolving facilities, the commitment termination date; for one-time fees, same as accrual start date. Null for open-ended fee schedules.',
    `accrual_frequency` STRING COMMENT 'Periodicity at which the fee accrues and is recognized for revenue purposes. One-time fees are charged once at a specific event; recurring fees accrue at the specified interval throughout the loan lifecycle.. Valid values are `one_time|daily|monthly|quarterly|semi_annually|annually`',
    `accrual_start_date` DATE COMMENT 'Date on which fee accrual begins. For origination fees, typically the loan booking date; for commitment fees, the facility effective date; for recurring fees, the first day of the accrual period.',
    `amendment_sequence_number` STRING COMMENT 'Sequential counter tracking the number of amendments made to this fee schedule. Starts at zero for the original fee schedule; incremented by one for each amendment. Supports audit trail and version control for fee schedule changes.',
    `applicability_condition` STRING COMMENT 'Business rule or contractual condition that must be satisfied for the fee to apply. Examples: Undrawn balance exceeds $1M, Payment overdue by more than 30 days, Amendment requires lender consent. Free-text field capturing the conditional logic from the loan agreement.',
    `approval_authority` STRING COMMENT 'Role, committee, or individual who approved this fee schedule. Examples: Chief Credit Officer, Loan Committee, Relationship Manager. Supports governance and audit trail for fee schedule establishment and amendments.',
    `approval_date` DATE COMMENT 'Date on which this fee schedule was approved by the designated approval authority. Used for audit trail and to ensure fee schedules are properly authorized before activation.',
    `billing_frequency` STRING COMMENT 'Periodicity at which the fee is invoiced to the borrower. May differ from accrual frequency; for example, a fee may accrue daily but be billed quarterly. On-demand billing applies to event-driven fees such as amendments or prepayments.. Valid values are `one_time|monthly|quarterly|semi_annually|annually|on_demand`',
    `calculation_basis` STRING COMMENT 'Method used to compute the fee amount. Flat amount is a fixed dollar value; percentage of facility applies to the total committed amount; percentage of undrawn applies only to the unused portion of a revolving facility; percentage of outstanding applies to the current loan balance; tiered uses different rates for different balance ranges.. Valid values are `flat_amount|percentage_of_facility|percentage_of_undrawn|percentage_of_outstanding|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was first created in the system. Immutable audit field capturing the initial record creation event.',
    `days_past_due` STRING COMMENT 'Number of calendar days the fee payment is overdue, calculated as current date minus payment due date. Zero or null when payment status is current or paid in full. Used to trigger late payment charges and delinquency reporting.',
    `effective_date` DATE COMMENT 'Date on which this fee schedule becomes active and binding per the loan agreement. For origination fees, typically the loan closing date; for amendment fees, the amendment effective date; for commitment fees, the facility effective date.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount of the fee when calculation basis is flat amount. Null when calculation basis is percentage-based. Represents the contractual fee value in the loan currency.',
    `fee_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied when calculation basis is percentage-based. Expressed as a decimal (e.g., 0.015000 represents 1.5% or 150 basis points). Null when calculation basis is flat amount.',
    `fee_schedule_code` STRING COMMENT 'Business identifier for the fee schedule. Externally-known unique code used for operational reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `fee_status` STRING COMMENT 'Current lifecycle state of the fee schedule. Active fees are currently accruing and billable; inactive fees are defined but not currently applicable; suspended fees are temporarily paused; waived fees have been forgiven by credit decision; cancelled fees are permanently terminated.. Valid values are `active|inactive|suspended|waived|cancelled`',
    `fee_type` STRING COMMENT 'Classification of the fee based on its business purpose. Origination fees are charged at loan inception; commitment fees apply to undrawn portions of facilities; agency fees compensate the administrative agent in syndicated loans; amendment fees apply when loan terms are modified; prepayment penalties discourage early repayment; late payment charges penalize overdue payments.. Valid values are `origination|commitment|agency|amendment|prepayment_penalty|late_payment`',
    `is_active` BOOLEAN COMMENT 'Boolean indicator of whether this fee schedule is currently active and applicable. True indicates the fee schedule is in effect; false indicates it has been terminated, superseded, or is otherwise inactive. Used for filtering active fee schedules in operational queries.',
    `last_accrual_date` DATE COMMENT 'Most recent date on which fee accrual was calculated and recorded. Used to track the current position in the accrual cycle and prevent duplicate accruals. Updated by the nightly accrual batch process.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this fee schedule. Null if no amendments have been made. Used to track the currency of fee terms and to support audit and compliance reviews.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was most recently updated. Updated automatically on every record modification. Supports change tracking and audit trail.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to overdue fee amounts to calculate late payment charges. Expressed as a decimal. Null if no late payment penalty applies to this fee type. Typically specified in the loan agreement default provisions.',
    `next_billing_date` DATE COMMENT 'Scheduled date for the next fee invoice to be generated and sent to the borrower. Updated after each billing cycle. Null for one-time fees that have already been billed or for inactive fee schedules.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or exceptions related to this fee schedule. Examples: Fee waived for first 90 days as relationship incentive, Custom calculation per side letter dated 2024-01-15, Subject to annual review per credit committee resolution.',
    `outstanding_receivable_amount` DECIMAL(18,2) COMMENT 'Current unpaid fee balance (total billed amount minus total paid amount). Represents the borrowers outstanding fee obligation. Monitored for credit risk and collections purposes.',
    `payment_due_date` DATE COMMENT 'Date by which the most recent fee invoice must be paid to avoid late payment charges. Typically set as a number of days after the billing date per the loan agreement payment terms.',
    `payment_status` STRING COMMENT 'Current state of fee payment obligation. Current indicates payment is not yet due or was paid on time; overdue indicates payment is past due date; partially paid indicates partial payment received; paid in full indicates full payment received; waived indicates fee was forgiven.. Valid values are `current|overdue|partially_paid|paid_in_full|waived`',
    `regulatory_reporting_category` STRING COMMENT 'Classification of the fee for regulatory reporting purposes. Determines how the fee is reported in Call Reports (FFIEC 031/041), FR Y-9C, and other regulatory filings. Interest income includes fees that are part of the effective interest rate; non-interest income includes transactional fees; fee income is a subset of non-interest income specific to loan-related fees.. Valid values are `interest_income|non_interest_income|fee_income|other_operating_income`',
    `revenue_recognition_method` STRING COMMENT 'Accounting treatment for recognizing fee income. Immediate recognition books the full fee at billing; straight-line amortizes evenly over the loan term; effective interest method aligns with interest income recognition per CECL/IFRS 9; proportional allocates based on loan utilization or time elapsed.. Valid values are `immediate|straight_line|effective_interest|proportional`',
    `source_system_code` STRING COMMENT 'Identifier of the operational system from which this fee schedule record originated. Examples: LOAN_IQ for Finastra Fusion Loan IQ, T24 for Temenos T24, CUSTOM_LOS for proprietary loan origination system. Supports data lineage and reconciliation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `syndication_allocation_method` STRING COMMENT 'Method for distributing fee revenue among syndicate members in syndicated loan facilities. Pro rata allocates based on each lenders participation percentage; lead arranger only assigns the full fee to the lead; agent only assigns to the administrative agent; custom follows a specific allocation schedule defined in the syndication agreement.. Valid values are `pro_rata|lead_arranger_only|agent_only|custom`',
    `tax_treatment_code` STRING COMMENT 'Tax classification of the fee for income tax and withholding purposes. Taxable fees are subject to standard income tax; tax exempt fees are excluded from taxable income; withholding required indicates cross-border fees subject to withholding tax per tax treaty; VAT applicable indicates fees subject to value-added tax in applicable jurisdictions.. Valid values are `taxable|tax_exempt|withholding_required|vat_applicable`',
    `termination_date` DATE COMMENT 'Date on which this fee schedule ceases to be active. For term loans, typically the maturity date; for revolving facilities, the commitment termination date; for one-time fees, the date the fee was billed. Null for open-ended fee schedules that remain active until loan payoff.',
    `total_accrued_amount` DECIMAL(18,2) COMMENT 'Cumulative fee amount accrued to date but not yet billed. Represents the unbilled revenue recognized on the balance sheet. Reset to zero after each billing cycle when accrued amounts are transferred to billed amounts.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Cumulative fee amount invoiced to the borrower since fee schedule inception. Includes both paid and unpaid invoices. Used for revenue reporting and reconciliation with accounts receivable.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative fee amount received from the borrower since fee schedule inception. Used to calculate outstanding receivables (total billed minus total paid) and to track payment compliance.',
    `waiver_authority` STRING COMMENT 'Role or committee authorized to waive or reduce this fee. Examples: Chief Credit Officer, Loan Committee, Relationship Manager up to $5,000. Supports governance and audit trail for fee waivers.',
    CONSTRAINT pk_loan_fee_schedule PRIMARY KEY(`loan_fee_schedule_id`)
) COMMENT 'Master definition and transactional accrual ledger for all loan-related fees including origination fees, commitment fees, agency fees, amendment fees, prepayment penalties, and late payment charges. Captures fee type, calculation basis (flat, percentage of facility, percentage of undrawn), rate or amount, accrual frequency, applicability conditions, and for each accrual period: accrual date, accrued amount, billed amount, billing date, payment status, and GL posting reference. Supports revenue recognition for loan fee income and NIM reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`modification` (
    `modification_id` BIGINT COMMENT 'Primary key for modification',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Loan modifications (forbearance, restructuring, TDR) require documented approval authority for OCC/FDIC regulatory compliance and CECL audit trail. approving_authority field exists but is text/level, ',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: TDR modifications affect credit loss projections used in capital stress scenarios under DFAST/CCAR frameworks. Essential for forward-looking capital planning and stress testing.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Modifications requested/processed via channels. Essential for forbearance program tracking, channel servicing quality measurement, regulatory reporting on modification channels (CFPB, OCC requirements',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Loan modifications (forbearance, restructuring, TDR) often require collateral pledge amendments—lien releases, substitutions, or coverage ratio waivers. Workout teams track which pledge was modified a',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Loan modifications (especially TDRs) trigger credit rating reassessment per credit policy. The modification should reference the post-modification rating to track credit deterioration and support CECL',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Loan modifications with fee amounts in currencies require currency metadata (rounding, minor unit) for fee calculation, GL posting, and regulatory reporting (TDR reporting, CECL modification tracking)',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Loan modifications generate journal entries for TDR classification, modification gain/loss recognition, and principal forgiveness accounting. Required for GAAP/IFRS compliance and regulatory TDR repor',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan facility being modified. Links to the core loan master record.',
    `approval_date` DATE COMMENT 'The date the modification was formally approved by the designated authority.',
    `approving_authority` STRING COMMENT 'The name or title of the credit authority (individual, committee, or board) that approved this modification.',
    `approving_authority_level` STRING COMMENT 'The hierarchical level of the approving authority. Indicates the escalation tier required for this modification based on risk and materiality.. Valid values are `branch_manager|regional_credit_officer|chief_credit_officer|credit_committee|board_of_directors`',
    `cecl_stage_after` STRING COMMENT 'The CECL impairment stage classification of the loan after the modification is applied. Used to track stage migration resulting from the modification.. Valid values are `stage_1|stage_2|stage_3`',
    `cecl_stage_before` STRING COMMENT 'The CECL impairment stage classification of the loan immediately prior to the modification (Stage 1: performing, Stage 2: underperforming, Stage 3: credit-impaired).. Valid values are `stage_1|stage_2|stage_3`',
    `collateral_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this modification involved changes to collateral requirements, pledges, or Loan-to-Value (LTV) ratios. True if collateral terms were adjusted.',
    `covenant_waiver_flag` BOOLEAN COMMENT 'Indicates whether this modification includes a waiver of one or more financial or operational covenants. True if covenants were waived.',
    `created_by_user` STRING COMMENT 'The user ID or name of the individual who created this modification record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this modification record was first created in the system. Audit trail for data lineage.',
    `execution_date` DATE COMMENT 'The date the modification agreement was executed and legally binding documentation was completed.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The fee charged to the borrower for processing and executing the modification. Zero if no fee was assessed.',
    `fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the modification fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `forbearance_end_date` DATE COMMENT 'The date on which the forbearance period ends and normal payment obligations resume. Null if not a forbearance modification.',
    `gain_loss_amount` DECIMAL(18,2) COMMENT 'The accounting gain or loss recognized as a result of the modification, calculated as the difference between the present value of the original and modified cash flows. Positive for gain, negative for loss.',
    `internal_notes` STRING COMMENT 'Confidential internal notes and commentary regarding the modification decision, borrower negotiations, and risk considerations. Not shared externally.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this modification must be reported to regulatory authorities (e.g., OCC, Fed, FDIC) under applicable reporting frameworks.',
    `is_tdr` BOOLEAN COMMENT 'Indicates whether this modification qualifies as a Troubled Debt Restructuring under CECL and regulatory guidance. True if the borrower is experiencing financial difficulty and the lender granted a concession.',
    `legal_documentation_reference` STRING COMMENT 'Reference number or identifier for the legal amendment agreement or forbearance letter executed for this modification.',
    `modification_date` DATE COMMENT 'The date on which the modification terms become effective and binding. This is the principal business event timestamp for the modification.',
    `modification_number` STRING COMMENT 'Business-facing unique reference number assigned to this modification for tracking and reporting purposes.',
    `modification_status` STRING COMMENT 'Current lifecycle state of the modification request. Tracks the approval and execution workflow.. Valid values are `draft|pending_approval|approved|executed|rejected|cancelled`',
    `modification_type` STRING COMMENT 'Classification of the modification action taken. Determines the nature of the amendment to the original loan terms.. Valid values are `maturity_extension|rate_reduction|principal_forgiveness|payment_deferral|forbearance|covenant_waiver`',
    `modified_interest_rate` DECIMAL(18,2) COMMENT 'The new interest rate applicable to the loan after this modification, expressed as a decimal. Null if rate was not changed.',
    `modified_maturity_date` DATE COMMENT 'The new maturity date of the loan after this modification is applied. Null if maturity was not changed.',
    `modified_principal_amount` DECIMAL(18,2) COMMENT 'The principal balance after applying any forgiveness, capitalization, or other principal adjustments. Null if principal was not changed.',
    `npl_status_after` STRING COMMENT 'The credit quality classification of the loan after modification. Tracks whether the modification successfully cured the NPL status.. Valid values are `performing|non_performing|substandard|doubtful|loss`',
    `npl_status_before` STRING COMMENT 'The credit quality classification of the loan prior to modification. Used to assess whether the modification is part of NPL workout management.. Valid values are `performing|non_performing|substandard|doubtful|loss`',
    `original_interest_rate` DECIMAL(18,2) COMMENT 'The interest rate applicable to the loan prior to this modification, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `original_maturity_date` DATE COMMENT 'The maturity date of the loan prior to this modification. Retained for historical comparison and regulatory reporting.',
    `original_principal_amount` DECIMAL(18,2) COMMENT 'The outstanding principal balance of the loan at the time of modification request.',
    `payment_deferral_months` STRING COMMENT 'The number of months for which scheduled payments are deferred. Zero if no deferral was granted.',
    `principal_forgiveness_amount` DECIMAL(18,2) COMMENT 'The amount of principal forgiven or written down as part of this modification. Zero if no forgiveness occurred.',
    `rationale` STRING COMMENT 'Free-text explanation of the business and credit rationale for granting the modification. Includes borrower circumstances, lender strategy, and expected outcomes.',
    `request_date` DATE COMMENT 'The date the borrower or lender initiated the modification request.',
    `updated_by_user` STRING COMMENT 'The user ID or name of the individual who last updated this modification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this modification record was last updated. Audit trail for data lineage and change tracking.',
    CONSTRAINT pk_modification PRIMARY KEY(`modification_id`)
) COMMENT 'Records all material amendments and restructurings to existing loan facilities, including modification type (maturity extension, rate reduction, principal forgiveness, payment deferral, forbearance), modification date, original terms, modified terms, TDR (Troubled Debt Restructuring) classification flag, regulatory reporting flag, approving authority, and modification rationale. Supports NPL workout management and CECL staging reassessment.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`collateral_link` (
    `collateral_link_id` BIGINT COMMENT 'Unique identifier for the collateral link record. Primary key for the association between a loan facility and pledged collateral asset.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset pledged to secure the loan. Links to the collateral master record in the collateral domain.',
    `hqla_inventory_id` BIGINT COMMENT 'Foreign key linking to treasury.hqla_inventory. Business justification: Eligible loan collateral (government securities, high-grade bonds) may qualify as HQLA for LCR calculation and liquidity buffer management. Critical for liquidity coverage ratio compliance and liquidi',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Wealth management collateral: fund units held in investor accounts serve as loan collateral. Banks pledge the investors fund positions (tracked via investor_account) against credit facilities. This l',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan facility that is secured by the pledged collateral. Links to the loan master record in the loan domain.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Managed portfolios are pledged as collateral for credit facilities. Collateral perfection process requires linking investment accounts, daily mark-to-market valuation for LTV monitoring, haircut appli',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Collateral_link already has collateral_asset_id (physical/real assets). Securities pledged as collateral require separate instrument reference for market-based valuation, haircut application, and marg',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the collateral asset value allocated to this specific loan facility. Used when a single collateral asset secures multiple loans. Sum of allocation percentages across all links for a collateral asset should equal 1.0000 (100%).',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'The ratio of current collateral value to outstanding loan balance. Inverse of LTV. Expressed as a decimal (e.g., 1.2500 represents 125% coverage). Values above 1.0 indicate over-collateralization.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this collateral link record was first created in the system. Audit trail for data lineage and compliance.',
    `cross_collateralization_flag` BOOLEAN COMMENT 'Indicates whether this collateral secures multiple loan facilities under a cross-collateralization agreement. True means the collateral is pledged to secure more than one loan obligation.',
    `cross_default_flag` BOOLEAN COMMENT 'Indicates whether a default on this loan triggers default provisions on other loans secured by the same collateral. True means cross-default provisions are in effect.',
    `current_collateral_value_amount` DECIMAL(18,2) COMMENT 'The most recent market or appraised value of the pledged collateral. Updated periodically based on revaluation frequency requirements and market conditions.',
    `current_ltv_ratio` DECIMAL(18,2) COMMENT 'The current ratio of the outstanding loan balance to the current collateral value. Expressed as a decimal. Monitored for covenant compliance and risk management. Rising LTV indicates deteriorating collateral coverage.',
    `current_value_as_of_date` DATE COMMENT 'The date on which the current collateral value was determined. Indicates the valuation date for the most recent appraisal or market assessment.',
    `eligible_collateral_value_amount` DECIMAL(18,2) COMMENT 'The collateral value after applying regulatory haircuts and eligibility criteria. Used for Risk-Weighted Assets (RWA) calculation and regulatory capital reporting under Basel III.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The discount applied to the collateral value for risk management and regulatory capital purposes. Expressed as a decimal (e.g., 0.2000 represents 20% haircut). Reflects potential loss in value during liquidation.',
    `insurance_expiration_date` DATE COMMENT 'The date on which the collateral insurance policy expires. Monitored to ensure continuous coverage and covenant compliance.',
    `insurance_policy_number` STRING COMMENT 'The policy number for the insurance coverage on the pledged collateral. Used to verify insurance compliance and file claims in the event of loss or damage.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the loan agreement requires the borrower to maintain insurance coverage on the pledged collateral. True means insurance is mandatory to protect the lenders security interest.',
    `last_revaluation_date` DATE COMMENT 'The date of the most recent collateral revaluation. Used to monitor compliance with revaluation frequency requirements and identify stale valuations.',
    `lender_loss_payee_flag` BOOLEAN COMMENT 'Indicates whether the lender is named as loss payee on the collateral insurance policy. True means insurance proceeds will be paid to the lender to protect the security interest.',
    `lien_position` STRING COMMENT 'Priority ranking of the lien on the collateral asset. Determines the order of claim in the event of default and liquidation. First lien has highest priority, subordinate has lowest.. Valid values are `first|second|third|subordinate|pari_passu`',
    `link_effective_date` DATE COMMENT 'The date on which the collateral was pledged to secure the loan. Marks the beginning of the collateral relationship and the start of lien priority.',
    `link_reference_number` STRING COMMENT 'Business-facing reference number for the collateral link relationship. Used in loan documentation and collateral agreements.',
    `link_status` STRING COMMENT 'Current lifecycle status of the collateral link relationship. Active indicates the collateral is currently securing the loan. Released indicates the lien has been discharged. Impaired indicates collateral value has deteriorated significantly.. Valid values are `active|released|substituted|impaired|foreclosed`',
    `link_termination_date` DATE COMMENT 'The date on which the collateral lien was released or the collateral relationship ended. Occurs upon loan payoff, collateral substitution, or lien release.',
    `ltv_ratio_at_origination` DECIMAL(18,2) COMMENT 'The ratio of the loan amount to the pledged collateral value at the time of loan origination. Expressed as a decimal (e.g., 0.8000 represents 80%). Key credit risk metric used in underwriting decisions.',
    `margin_call_status` STRING COMMENT 'Current status of any margin call on this collateral link. None indicates no margin call. Issued indicates a margin call has been sent to the borrower. Cured indicates the borrower has satisfied the margin call.. Valid values are `none|pending|issued|cured|defaulted`',
    `margin_call_threshold_percentage` DECIMAL(18,2) COMMENT 'The Loan-to-Value (LTV) ratio threshold that triggers a margin call requiring the borrower to pledge additional collateral or pay down the loan. Expressed as a decimal (e.g., 0.8500 represents 85% LTV threshold).',
    `next_revaluation_date` DATE COMMENT 'The date on which the next collateral revaluation is scheduled or required. Used for operational planning and compliance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or exceptions related to the collateral link relationship. Used for documentation and operational context.',
    `perfection_date` DATE COMMENT 'The date on which the security interest was perfected through proper filing or registration. Establishes priority over competing claims.',
    `perfection_jurisdiction` STRING COMMENT 'Three-letter ISO country code indicating the jurisdiction where the security interest was perfected. Determines applicable legal framework and enforcement procedures.. Valid values are `^[A-Z]{3}$`',
    `perfection_method` STRING COMMENT 'The legal mechanism used to perfect the security interest. UCC filing for personal property, mortgage registration for real estate, control agreements for securities, possession for physical assets.. Valid values are `ucc_filing|mortgage_registration|title_notation|control_agreement|possession`',
    `perfection_status` STRING COMMENT 'Legal status of the security interest in the collateral. Perfected indicates the lien has been properly filed and recorded (e.g., UCC-1 filing, mortgage registration). Unperfected liens may not be enforceable against third parties.. Valid values are `perfected|pending|unperfected|lapsed`',
    `pledged_value_amount` DECIMAL(18,2) COMMENT 'The monetary value of the collateral pledged at the time of loan origination. Represents the initial collateral valuation used for underwriting and Loan-to-Value (LTV) calculation.',
    `pledged_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the pledged value amount. Indicates the currency in which the collateral was valued at origination.. Valid values are `^[A-Z]{3}$`',
    `revaluation_frequency` STRING COMMENT 'The required frequency for revaluing the pledged collateral. Determined by loan agreement terms, collateral type, and regulatory requirements. Event-driven revaluations occur upon material changes.. Valid values are `monthly|quarterly|semi_annually|annually|event_driven`',
    `source_system_code` STRING COMMENT 'Identifier for the operational system that originated this collateral link record. Typically the Loan Origination System or Core Banking System collateral module.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the loan agreement permits the borrower to substitute alternative collateral for the currently pledged asset. True means substitution is permitted subject to lender approval.',
    `ucc_expiration_date` DATE COMMENT 'The date on which the UCC-1 financing statement expires. Typically five years from filing date. Requires continuation statement to maintain perfection beyond expiration.',
    `ucc_filing_number` STRING COMMENT 'The official filing number assigned by the Secretary of State or other filing office for the UCC-1 financing statement. Used to search and verify the perfected security interest.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this collateral link record was last modified. Audit trail for change tracking and data quality monitoring.',
    CONSTRAINT pk_collateral_link PRIMARY KEY(`collateral_link_id`)
) COMMENT 'Association entity linking loan facilities to pledged collateral assets managed in the collateral domain. Records lien position (first, second, subordinate), pledged value at origination, current collateral value, LTV ratio at origination and current, collateral coverage ratio, perfection status (UCC filing, mortgage registration), and cross-collateralization flags. This entity owns the loan-side relationship data only; the collateral master record and valuation history remain in the collateral domain.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the write-off event. Primary key for the write-off record.',
    `capital_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_ratio. Business justification: Charge-offs reduce RWA and impact capital ratios in the recognition period. Critical for quarterly capital ratio calculation and regulatory reporting under Basel III.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Write-offs track which collateral pledge was exhausted or liquidated. Collections teams need pledge reference for recovery pursuit strategy, collateral liquidation proceeds allocation, and LGD calcula',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Write-offs recorded in currencies require currency metadata (rounding, minor unit) for GL posting (charge-off journal entries), regulatory reporting (call report Schedule RI-B), and recovery tracking.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the GL journal entry that recorded the write-off transaction, enabling reconciliation between loan system and financial accounting.',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account that was written off.',
    `loss_recovery_id` BIGINT COMMENT 'Foreign key linking to fraud.loss_recovery. Business justification: Write-offs due to fraud are tracked for recovery efforts (insurance claims, legal action, chargeback). Linking write-off to loss_recovery enables net loss calculation, CCAR reporting, and tracking of ',
    `party_id` BIGINT COMMENT 'Reference to the borrower whose loan was written off.',
    `employee_id` BIGINT COMMENT 'The system user ID or employee ID of the individual who approved the write-off, for audit trail purposes.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Write-offs are scrutinized during regulatory exams for asset quality assessment, loss recognition timeliness, ALLL adequacy, and charge-off policy compliance. Examiners review write-off populations to',
    `approval_authority` STRING COMMENT 'The governance body or individual who approved the write-off: credit committee, chief credit officer, board of directors, or delegated authority per credit policy.. Valid values are `credit_committee|chief_credit_officer|board_of_directors|delegated_authority`',
    `approval_date` DATE COMMENT 'The date on which the write-off was formally approved by the designated authority.',
    `call_report_schedule` STRING COMMENT 'The specific Call Report schedule and line item where this write-off is reported (e.g., Schedule RI-B Part II, Line 6a).',
    `charge_off_reason_code` STRING COMMENT 'The primary reason for the charge-off: bankruptcy filing, borrower deceased, fraud, deemed uncollectable, statute of limitations expired, or other.. Valid values are `bankruptcy|deceased|fraud|uncollectable|statute_of_limitations|other`',
    `charge_off_reason_description` STRING COMMENT 'Free-text narrative providing additional context and details about the reason for the charge-off.',
    `collateral_liquidation_flag` BOOLEAN COMMENT 'Indicates whether collateral was liquidated prior to or as part of the write-off process (True) or not (False).',
    `collateral_liquidation_proceeds` DECIMAL(18,2) COMMENT 'The net proceeds received from liquidation of collateral prior to write-off, applied to reduce the write-off amount.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this write-off record was first created in the system.',
    `cumulative_recovery_to_date` DECIMAL(18,2) COMMENT 'The total amount recovered from all sources (borrower payments, collateral liquidation, guarantor calls, debt sales) since the write-off date, updated with each recovery event.',
    `days_past_due_at_write_off` STRING COMMENT 'The number of days the loan was past due at the time of write-off, used for delinquency analysis and LGD modeling.',
    `debt_sale_date` DATE COMMENT 'The date on which the charged-off debt was sold to a third-party debt buyer, if applicable.',
    `debt_sale_flag` BOOLEAN COMMENT 'Indicates whether the charged-off debt was sold to a third-party debt buyer (True) or retained for internal collection (False).',
    `debt_sale_proceeds` DECIMAL(18,2) COMMENT 'The amount received from the sale of the charged-off debt to a third-party buyer, recorded as a recovery.',
    `ead_at_default` DECIMAL(18,2) COMMENT 'The total exposure at the time of default, used as the denominator in LGD calculation. Typically equals the total outstanding balance at default.',
    `ecl_reserve_released_amount` DECIMAL(18,2) COMMENT 'The amount of ECL (Expected Credit Loss) or ALLL (Allowance for Loan and Lease Losses) reserve released upon write-off, reducing the reserve balance.',
    `fees_written_off_amount` DECIMAL(18,2) COMMENT 'The unpaid fees (late fees, penalty fees, servicing fees) that were charged off at the time of write-off.',
    `gl_posting_date` DATE COMMENT 'The date the write-off transaction was posted to the general ledger, which may differ from the write-off date due to batch processing.',
    `guarantor_call_flag` BOOLEAN COMMENT 'Indicates whether a guarantor was called upon for payment prior to or as part of the write-off process (True) or not (False).',
    `guarantor_recovery_amount` DECIMAL(18,2) COMMENT 'The amount recovered from guarantor(s) prior to write-off, applied to reduce the write-off amount.',
    `interest_written_off_amount` DECIMAL(18,2) COMMENT 'The accrued but unpaid interest that was charged off at the time of write-off.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this write-off record was last updated, capturing any changes to recovery amounts, status, or other fields.',
    `lgd_rate` DECIMAL(18,2) COMMENT 'The calculated Loss Given Default rate for this write-off: net loss after recovery divided by exposure at default (EAD). Expressed as a decimal (e.g., 0.4500 for 45%).',
    `net_charge_off_amount` DECIMAL(18,2) COMMENT 'The net loss recognized after applying reserve release: total write-off amount minus ECL reserve released. This is the P&L impact of the charge-off.',
    `net_loss_after_recovery` DECIMAL(18,2) COMMENT 'The net loss remaining after all recoveries: total write-off amount minus cumulative recovery to date. Used for final LGD calculation.',
    `npl_classification_date` DATE COMMENT 'The date the loan was first classified as non-performing (NPL), typically 90+ days past due, prior to write-off.',
    `principal_written_off_amount` DECIMAL(18,2) COMMENT 'The outstanding principal balance of the loan that was charged off at the time of write-off.',
    `recovery_pursuit_status` STRING COMMENT 'Current status of post-charge-off recovery efforts: active pursuit, suspended, closed with no recovery, closed with partial recovery, or closed with full recovery.. Valid values are `active_pursuit|suspended|closed_no_recovery|closed_partial_recovery|closed_full_recovery`',
    `regulatory_classification_at_write_off` STRING COMMENT 'The regulatory asset classification of the loan at the time of write-off per OCC/FDIC guidelines: substandard, doubtful, or loss.. Valid values are `substandard|doubtful|loss`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this write-off must be included in regulatory net charge-off reporting to OCC, FDIC, or Federal Reserve (True) or is excluded (False).',
    `total_write_off_amount` DECIMAL(18,2) COMMENT 'The total amount written off, including principal, interest, and fees. Sum of all written-off components.',
    `write_off_date` DATE COMMENT 'The date on which the loan balance was formally written off and removed from performing assets.',
    `write_off_number` STRING COMMENT 'Externally visible business identifier for the write-off transaction, used for audit trails and regulatory reporting.. Valid values are `^WO-[0-9]{8,12}$`',
    `write_off_status` STRING COMMENT 'Current lifecycle status of the write-off record: pending approval, approved by credit committee, posted to general ledger, reversed due to error or recovery, or closed after final settlement.. Valid values are `pending_approval|approved|posted|reversed|closed`',
    `write_off_type` STRING COMMENT 'Classification of the write-off event: full charge-off (entire balance), partial charge-off (portion of balance), technical write-off (accounting treatment without legal discharge), or regulatory write-off (mandated by regulator).. Valid values are `full_charge_off|partial_charge_off|technical_write_off|regulatory_write_off`',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Records formal write-off, charge-off, and all subsequent post-charge-off recovery events for uncollectable loan balances. Captures write-off date, written-off principal, accrued interest and fees, write-off approval authority, regulatory classification at write-off, and for each recovery event: recovery date, amount, source (borrower payment, collateral liquidation, guarantor call, debt sale), recovery channel, cumulative recovery to date, net loss after recovery, and GL posting references. Supports CECL reserve release accounting, LGD (Loss Given Default) model calibration, and regulatory net charge-off reporting to OCC/FDIC.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`credit_review` (
    `credit_review_id` BIGINT COMMENT 'Unique identifier for the credit review record. Primary key for the credit review entity.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the relationship manager responsible for the borrower relationship. The RM provides business context and client intelligence to support the credit review.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Ongoing credit monitoring: when loans are collateralized by fund holdings, periodic credit reviews assess the investor_accounts current NAV, concentration risk, and liquidity. This link supports coll',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit reviews explicitly produce updated counterparty ratings. The review should reference the resulting rating record; updated_internal_rating/pd/lgd are denormalized outputs that should be stored i',
    `employee_id` BIGINT COMMENT 'Identifier of the credit analyst who conducted the review and prepared the credit assessment memorandum.',
    `loan_account_id` BIGINT COMMENT 'Identifier of the loan facility being reviewed. Links this credit review to the specific loan or credit facility under assessment.',
    `party_id` BIGINT COMMENT 'Identifier of the borrower whose credit is being reviewed. References the customer or corporate entity that holds the loan facility.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Credit reviews are examined by regulators to assess credit risk management effectiveness, internal rating accuracy, portfolio monitoring quality, and early warning system performance. Direct scope of ',
    `review_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_review. Business justification: Credit reviews trigger and reference collateral reviews for secured exposures. Credit officers assess whether collateral coverage remains adequate, triggering margin calls or facility reductions. Busi',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'The ratio of collateral value to outstanding exposure, expressed as a decimal (e.g., 1.25 for 125% coverage). Measures the degree of credit protection provided by pledged collateral.',
    `collateral_revaluation_flag` BOOLEAN COMMENT 'Indicates whether collateral supporting the facility was revalued as part of this credit review. True if revaluation was performed; false if existing valuations were deemed current.',
    `covenant_compliance_summary` STRING COMMENT 'Summary assessment of the borrowers compliance with financial and non-financial covenants. Compliant indicates all covenants met; minor_breach indicates technical violations with no material impact; material_breach indicates significant covenant violations; waived indicates breaches that have been formally waived by the lender; not_applicable indicates no covenants in place.. Valid values are `compliant|minor_breach|material_breach|waived|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit review record was first created in the system. Supports audit trail and data lineage tracking.',
    `credit_committee_date` DATE COMMENT 'The date on which the credit committee formally reviewed and approved the credit review findings. Represents the official sign-off timestamp for governance and audit purposes.',
    `credit_committee_decision` STRING COMMENT 'Final decision rendered by the credit committee on the review findings and recommended action. Approved indicates acceptance of recommendations; approved_with_conditions indicates acceptance subject to specific requirements; rejected indicates committee disagreement; deferred indicates decision postponed; referred indicates escalation to higher authority.. Valid values are `approved|approved_with_conditions|rejected|deferred|referred`',
    `ecl_amount` DECIMAL(18,2) COMMENT 'The Expected Credit Loss (ECL) provision amount calculated for this facility based on the updated PD, LGD, and EAD estimates from this credit review. Represents the present value of expected credit losses over the relevant time horizon.',
    `financial_performance_assessment` STRING COMMENT 'Qualitative assessment of the borrowers financial performance since the last review. Considers revenue trends, profitability, cash flow generation, leverage ratios, and liquidity position.. Valid values are `strong|satisfactory|adequate|weak|poor`',
    `industry_outlook` STRING COMMENT 'Assessment of the borrowers industry sector outlook and its impact on credit risk. Positive indicates favorable industry trends; stable indicates steady conditions; cautious indicates emerging headwinds; negative indicates sector deterioration; distressed indicates severe industry stress.. Valid values are `positive|stable|cautious|negative|distressed`',
    `next_review_due_date` DATE COMMENT 'The scheduled date for the next periodic credit review. Typically set based on risk rating, with higher-risk credits requiring more frequent review.',
    `npl_flag` BOOLEAN COMMENT 'Indicates whether the loan is classified as non-performing based on this credit review. True if the loan is 90+ days past due or otherwise impaired; false if performing.',
    `previous_internal_rating` STRING COMMENT 'The internal risk rating assigned to the borrower prior to this credit review. Used to track rating migration and credit quality trends.',
    `previous_lgd` DECIMAL(18,2) COMMENT 'The Loss Given Default (LGD) estimate assigned to the facility prior to this review, expressed as a decimal (e.g., 0.45 for 45%). LGD represents the expected loss severity in the event of default, net of collateral recovery.',
    `previous_pd` DECIMAL(18,2) COMMENT 'The Probability of Default (PD) estimate assigned to the borrower prior to this review, expressed as a decimal (e.g., 0.025 for 2.5%). PD represents the likelihood of default over a one-year horizon under the IRB approach.',
    `recommended_action` STRING COMMENT 'Credit analysts recommended action based on review findings. Maintain indicates no change to risk rating or exposure; upgrade indicates improved credit quality; downgrade indicates deterioration; watchlist indicates heightened monitoring required; exit indicates recommendation to reduce or terminate exposure; restructure indicates need for amended terms.. Valid values are `maintain|upgrade|downgrade|watchlist|exit|restructure`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the loan asset based on credit quality, aligned with supervisory standards. Pass indicates performing asset; special_mention indicates potential weakness; substandard indicates well-defined weakness; doubtful indicates collection in full is questionable; loss indicates uncollectible.. Valid values are `pass|special_mention|substandard|doubtful|loss`',
    `review_comments` STRING COMMENT 'Free-text field capturing key observations, concerns, mitigating factors, and qualitative insights from the credit review. Provides narrative context to support the quantitative assessment and rating decision.',
    `review_date` DATE COMMENT 'The date on which the credit review was formally conducted and documented. This is the principal business event timestamp for the review lifecycle.',
    `review_status` STRING COMMENT 'Current lifecycle state of the credit review. Draft indicates work in progress; submitted means forwarded to credit committee; under_review indicates active assessment; approved means credit committee sign-off received; rejected means review findings require remediation; deferred means decision postponed pending additional information.. Valid values are `draft|submitted|under_review|approved|rejected|deferred`',
    `review_type` STRING COMMENT 'Classification of the credit review based on its trigger and purpose. Annual reviews are scheduled periodic assessments; interim reviews occur mid-cycle; triggered reviews are event-driven (covenant breach, rating downgrade); special reviews are ad-hoc deep dives; renewal reviews support facility extension decisions; watchlist reviews monitor deteriorating credits.. Valid values are `annual|interim|triggered|special|renewal|watchlist`',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The Risk-Weighted Assets (RWA) amount calculated for this facility based on the updated risk parameters from this credit review. Used for regulatory capital adequacy calculations under Basel III.',
    `stage_classification` STRING COMMENT 'IFRS 9 impairment stage classification assigned as a result of this credit review. Stage 1 indicates no significant increase in credit risk (12-month ECL); Stage 2 indicates significant increase in credit risk (lifetime ECL); Stage 3 indicates credit-impaired (lifetime ECL with interest revenue on net carrying amount).. Valid values are `stage_1|stage_2|stage_3`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit review record was last modified. Supports audit trail and change tracking for regulatory compliance.',
    CONSTRAINT pk_credit_review PRIMARY KEY(`credit_review_id`)
) COMMENT 'Annual and periodic credit review records for active loan facilities, capturing review date, review type (annual, interim, triggered), credit analyst, relationship manager, updated internal risk rating, updated PD/LGD estimates, financial performance assessment, covenant compliance summary, collateral revaluation flag, recommended action (maintain, upgrade, downgrade, watchlist, exit), and credit committee sign-off date. Supports ongoing portfolio credit quality management.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`lc` (
    `lc_id` BIGINT COMMENT 'Unique identifier for the Letter of Credit record. Primary key.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Letter of credit issuance requires credit assessment of beneficiary (especially for standby LCs). Beneficiary default risk affects LC utilization probability and regulatory capital requirements under ',
    `beneficiary_id` BIGINT COMMENT 'Reference to the party in whose favor the Letter of Credit is issued, typically the exporter or seller.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Letters of credit issued in currencies require currency metadata (convertibility, settlement lag, restrictions) for drawing processing, settlement instructions, compliance (UCP 600 currency rules), an',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Letters of credit support deal execution (acquisition escrow LCs, performance guarantees in M&A, bid bonds in privatization deals). Investment banking negotiates deal terms; trade finance issues instr',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: LCs specify expiry place (country) requiring country business day conventions, holiday calendars, and regulatory rules (UCP 600 Article 3) for expiry date calculation and presentation deadline determi',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Letters of credit issued through channels (branch trade desk, digital platform, RM). Required for trade finance channel analytics, documentary credit origination tracking, and trade services performan',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: LC issuance requires documented officer approval for UCP 600 compliance, internal controls, and credit risk management. No existing employee link on lc table. Business process: credit decision documen',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Letter of credit issuances create contingent liquidity obligations tracked in liquidity stress scenarios, contingency funding plans, and NSFR calculations under Basel III liquidity framework.',
    `party_id` BIGINT COMMENT 'Reference to the party (customer) who requested the issuance of the Letter of Credit, typically the importer or buyer.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Letters of credit require OFAC sanctions screening of beneficiaries, applicants, advising banks, and underlying trade parties at issuance and amendment. Each LC transaction triggers screening events f',
    `trade_facility_id` BIGINT COMMENT 'Foreign key linking to loan.trade_facility. Business justification: Letters of Credit are issued against approved trade finance credit facilities. Currently lc has no link to trade_facility. Business reality: Banks issue LCs only when the applicant has an approved tra',
    `advising_bank_bic` STRING COMMENT 'SWIFT BIC code of the bank that advises the Letter of Credit to the beneficiary without adding its own undertaking.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `amendment_count` STRING COMMENT 'Total number of amendments issued to modify the terms and conditions of the Letter of Credit since original issuance.',
    `aml_screening_status` STRING COMMENT 'Result of sanctions and anti-money laundering screening for the applicant, beneficiary, and transaction. Cleared: no issues. Flagged: potential match requiring review. Under Review: investigation in progress.. Valid values are `pending|cleared|flagged|under_review`',
    `amount` DECIMAL(18,2) COMMENT 'Maximum monetary value available under the Letter of Credit. This is the credit limit that can be drawn by the beneficiary upon complying presentation.',
    `applicable_rules` STRING COMMENT 'ICC rules governing this Letter of Credit. UCP 600: Uniform Customs and Practice for Documentary Credits. eUCP: electronic presentation supplement. ISP98: International Standby Practices. URDG 758: Uniform Rules for Demand Guarantees.. Valid values are `UCP_600|eUCP|ISP98|UCP_500|URDG_758`',
    `available_amount` DECIMAL(18,2) COMMENT 'Current remaining credit amount available for drawing under the Letter of Credit after accounting for any utilizations, amendments, or expirations.',
    `confirming_bank_bic` STRING COMMENT 'SWIFT BIC code of the bank that adds its confirmation to the Letter of Credit, thereby undertaking to honor complying presentations in addition to the issuing bank.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this Letter of Credit record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date on which the Letter of Credit expires and after which no presentations will be honored. Must specify both date and place of expiry per UCP 600.',
    `expiry_place` STRING COMMENT 'Geographic location (city and country) where the Letter of Credit expires and documents must be presented. Typically the counters of the nominated bank or issuing bank.',
    `goods_description` STRING COMMENT 'Detailed description of the merchandise or services covered by the Letter of Credit. Must match the description in commercial invoices and other documents.',
    `hs_code` STRING COMMENT 'International standardized system of names and numbers for classifying traded products, used for customs and tariff purposes.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'ICC Incoterms rule defining the division of costs, risks, and responsibilities between buyer and seller in the international sale of goods. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date on which the Letter of Credit was issued by the issuing bank. This is the effective start date of the LC undertaking.',
    `issuing_bank_bic` STRING COMMENT 'SWIFT BIC code of the bank that issued the Letter of Credit. 8 or 11 character ISO 9362 identifier.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the Letter of Credit terms.',
    `latest_shipment_date` DATE COMMENT 'Last date by which shipment of goods must occur as stipulated in the Letter of Credit terms. Critical for compliance with transport document requirements.',
    `lc_number` STRING COMMENT 'Externally-known unique reference number assigned to the Letter of Credit by the issuing bank. This is the business identifier used in SWIFT messages and trade documentation.',
    `lc_status` STRING COMMENT 'Current lifecycle status of the Letter of Credit. Draft: being prepared. Issued: sent to advising bank. Advised: communicated to beneficiary. Confirmed: confirmed by another bank. Amended: modified after issuance. Utilized: drawings made. Expired: validity period ended. Cancelled: terminated before expiry. [ENUM-REF-CANDIDATE: draft|issued|advised|confirmed|amended|utilized|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `lc_type` STRING COMMENT 'Classification of the Letter of Credit based on payment terms and transferability. Sight: payable on presentation. Usance: payable at a future date. Deferred Payment: payment deferred without draft. Acceptance: draft accepted for future payment. Standby: guarantee instrument. Transferable: can be transferred to secondary beneficiary.. Valid values are `sight|usance|deferred_payment|acceptance|standby|transferable`',
    `partial_shipment_allowed` BOOLEAN COMMENT 'Indicates whether the beneficiary is permitted to ship goods in multiple installments. True if partial shipments are allowed, False if prohibited.',
    `port_of_discharge` STRING COMMENT 'Name and country of the port or place where goods are unloaded from the vessel or transport mode at the destination.',
    `port_of_loading` STRING COMMENT 'Name and country of the port or place where goods are loaded onto the vessel or transport mode for shipment to the destination.',
    `presentation_period_days` STRING COMMENT 'Number of days after shipment date within which documents must be presented to the nominated bank. Defaults to 21 days per UCP 600 Article 14(c) if not specified.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of goods specified in the Letter of Credit, expressed in the unit of measure appropriate for the commodity.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this Letter of Credit transaction must be reported to regulatory authorities for trade finance monitoring, capital adequacy, or sanctions compliance purposes.',
    `reimbursement_bank_bic` STRING COMMENT 'SWIFT BIC code of the bank authorized to reimburse the nominated or confirming bank upon receipt of complying documents.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `reimbursement_instructions` STRING COMMENT 'Detailed instructions specifying how the nominated or confirming bank should claim reimbursement from the issuing or reimbursing bank, including account details and SWIFT message requirements.',
    `revolving_flag` BOOLEAN COMMENT 'Indicates whether this is a revolving Letter of Credit that automatically reinstates its value after each drawing, allowing multiple shipments under a single LC.',
    `revolving_frequency` STRING COMMENT 'For revolving LCs, the period at which the credit amount reinstates. Applicable only when revolving_flag is True.. Valid values are `monthly|quarterly|semi_annual|annual|per_shipment`',
    `special_conditions` STRING COMMENT 'Additional terms, conditions, or documentary requirements specific to this Letter of Credit beyond standard UCP 600 provisions. May include inspection certificates, insurance requirements, or specific document clauses.',
    `subtype` STRING COMMENT 'Additional classification for specialized LC structures. Revolving: automatically renews. Back-to-back: issued against another LC. Red/Green clause: allows advance payment to beneficiary.. Valid values are `revolving|back_to_back|red_clause|green_clause|standard`',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Permitted variance (plus or minus) in the LC amount and quantity, typically 10% unless otherwise specified. Allows for minor discrepancies in commercial invoices.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has the right to transfer all or part of the Letter of Credit to one or more second beneficiaries. Must be explicitly stated as transferable.',
    `transhipment_allowed` BOOLEAN COMMENT 'Indicates whether goods may be transferred from one vessel to another during transit. True if transhipment is permitted, False if prohibited.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the quantity is expressed (e.g., metric tons, pieces, liters, barrels, containers).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this Letter of Credit record was last modified, including amendments, status changes, or utilization updates.',
    `utilized_amount` DECIMAL(18,2) COMMENT 'Cumulative amount that has been drawn or claimed against the Letter of Credit through complying presentations and payments.',
    CONSTRAINT pk_lc PRIMARY KEY(`lc_id`)
) COMMENT 'Master record for Letters of Credit (Documentary Credits) issued, advised, or confirmed by the bank under ICC Uniform Customs and Practice rules (UCP 600, eUCP). Captures LC type (sight, usance, deferred payment, acceptance, standby, transferable, revolving, back-to-back, red/green clause), applicant and beneficiary references, issuing and confirming bank identifiers (BIC/SWIFT), LC amount and currency (ISO 4217), expiry date and place of expiry, tolerance percentage, partial shipment and transhipment permissions, applicable Incoterm, ports of loading and discharge, latest shipment date, presentation period (default 21 days per UCP 600 Art. 14c), special conditions, reimbursement instructions, and current lifecycle status (draft, issued, advised, confirmed, amended, partially utilized, fully utilized, expired, cancelled). Serves as the central reference entity for all LC-related amendments, drawings, document examinations, and settlements.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`lc_drawing` (
    `lc_drawing_id` BIGINT COMMENT 'Unique identifier for the LC drawing or amendment transaction record.',
    `correspondent_bank_id` BIGINT COMMENT 'Identifier of the nominated bank that negotiated the drawing. Applicable when transaction_type is drawing and negotiation_flag is true.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: LC drawings execute in currencies requiring currency metadata (settlement lag, rounding) for payment processing, nostro/vostro account selection, SWIFT message formatting (MT 700/710), and regulatory ',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: LC drawing/presentation transactions trigger fraud alerts (discrepancy manipulation, forged documents, duplicate presentations). Linking drawing to alert enables real-time fraud prevention, document e',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: LC drawings/payments create journal entries for contingent liability recognition, honor/dishonor accounting, and reimbursement settlement. Required for trade finance accounting and off-balance-sheet t',
    `lc_id` BIGINT COMMENT 'Reference to the parent Letter of Credit against which this transaction (drawing or amendment) is recorded.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this transaction record.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: LC drawings and document presentations require sanctions screening before honor decisions. Banks screen documents, parties, vessels, and ports against sanctions lists as compliance checkpoint before p',
    `amended_field_name` STRING COMMENT 'Name of the LC field being amended (e.g., lc_amount, expiry_date, document_requirements). Applicable when transaction_type is amendment.',
    `amendment_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the amendment complies with UCP 600 and internal bank policies. Applicable when transaction_type is amendment.',
    `amendment_request_date` DATE COMMENT 'Date on which the amendment was formally requested by the applicant or issuing bank. Applicable when transaction_type is amendment.',
    `amendment_type` STRING COMMENT 'Classification of the amendment action when transaction_type is amendment. Specifies the nature of the change being requested.. Valid values are `amount_increase|amount_decrease|expiry_extension|condition_change|document_modification|beneficiary_change`',
    `aml_screening_status` STRING COMMENT 'Status of AML screening for this transaction to detect suspicious activity or sanctions violations.. Valid values are `pending|cleared|flagged|under_review`',
    `available_balance_after_transaction` DECIMAL(18,2) COMMENT 'Remaining available balance on the LC after this drawing or amendment is processed.',
    `beneficiary_acceptance_date` DATE COMMENT 'Date on which the beneficiary formally accepted or rejected the amendment. Applicable when transaction_type is amendment.',
    `beneficiary_acceptance_status` STRING COMMENT 'Status indicating whether the beneficiary has accepted, rejected, or not yet responded to the amendment per UCP 600 Article 10. Applicable when transaction_type is amendment.. Valid values are `accepted|rejected|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LC drawing or amendment record was first created in the system.',
    `discrepancy_code` STRING COMMENT 'Standardized code classifying the type of discrepancy (e.g., late presentation, missing document, inconsistent data). Applicable when transaction_type is drawing.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies found in the presented documents, following ISBP 745 standards. Applicable when transaction_type is drawing and discrepancy_flag is true.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicator of whether discrepancies were identified in the presented documents per ISBP 745 examination standards. Applicable when transaction_type is drawing.',
    `document_set_reference` STRING COMMENT 'Reference identifier for the set of documents presented with the drawing (e.g., bill of lading, commercial invoice, certificate of origin). Applicable when transaction_type is drawing.',
    `drawing_amount` DECIMAL(18,2) COMMENT 'Monetary value of the drawing being claimed by the beneficiary. Applicable when transaction_type is drawing.',
    `drawing_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the drawing amount. Applicable when transaction_type is drawing.. Valid values are `^[A-Z]{3}$`',
    `honour_decision` STRING COMMENT 'Decision by the issuing or nominated bank to honour or dishonour the drawing based on document examination. Applicable when transaction_type is drawing.. Valid values are `honoured|dishonoured|deferred|pending`',
    `honour_decision_date` DATE COMMENT 'Date on which the honour or dishonour decision was made by the bank. Applicable when transaction_type is drawing.',
    `issuing_bank_approval_date` DATE COMMENT 'Date on which the issuing bank approved and issued the amendment. Applicable when transaction_type is amendment.',
    `negotiation_flag` BOOLEAN COMMENT 'Indicator of whether the drawing was negotiated by a nominated bank before presentation to the issuing bank. Applicable when transaction_type is drawing.',
    `new_value` DECIMAL(18,2) COMMENT 'Updated value of the amended field after the amendment. Stored as string to accommodate various data types. Applicable when transaction_type is amendment.',
    `partial_drawing_flag` BOOLEAN COMMENT 'Indicator of whether this drawing represents a partial utilization of the LC available balance. Applicable when transaction_type is drawing.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the beneficiary following honour of the drawing. Applicable when transaction_type is drawing.',
    `presentation_date` DATE COMMENT 'Date on which the beneficiary presented documents to the nominated or issuing bank for drawing under the LC. Applicable when transaction_type is drawing.',
    `prior_value` DECIMAL(18,2) COMMENT 'Original value of the amended field before the amendment. Stored as string to accommodate various data types. Applicable when transaction_type is amendment.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicator of whether this transaction requires regulatory reporting to authorities (e.g., large value transfers, cross-border transactions).',
    `sequence_number` STRING COMMENT 'Sequential numbering of amendments or drawings against the parent LC, enabling chronological tracking of all transactional activity.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Actual amount paid to the beneficiary, which may differ from drawing_amount if discounts or fees were applied. Applicable when transaction_type is drawing.',
    `settlement_date` DATE COMMENT 'Actual date on which payment was settled to the beneficiary. Applicable when transaction_type is drawing.',
    `settlement_status` STRING COMMENT 'Status of the payment settlement to the beneficiary. Applicable when transaction_type is drawing.. Valid values are `pending|settled|partially_settled|failed|reversed`',
    `swift_message_reference` STRING COMMENT 'Unique SWIFT message reference number for inter-bank communication of this transaction.',
    `swift_message_type` STRING COMMENT 'SWIFT message type used to communicate this transaction (MT707 for amendments, MT750 for advising drawings).. Valid values are `MT700|MT707|MT710|MT720|MT750|MT760`',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number for this drawing or amendment transaction, used for SWIFT messaging and inter-bank communication.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the drawing or amendment transaction.. Valid values are `pending|approved|rejected|accepted|settled|cancelled`',
    `transaction_type` STRING COMMENT 'Discriminator indicating whether this record represents an amendment to the LC terms or a drawing/presentation against the LC.. Valid values are `amendment|drawing`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this LC drawing or amendment record was last modified.',
    `waiver_request_date` DATE COMMENT 'Date on which the issuing bank requested the applicant to waive identified discrepancies. Applicable when transaction_type is drawing.',
    `waiver_response_date` DATE COMMENT 'Date on which the applicant responded to the waiver request. Applicable when transaction_type is drawing.',
    `waiver_status` STRING COMMENT 'Status indicating whether the applicant has been asked to waive discrepancies and their response. Applicable when transaction_type is drawing and discrepancy_flag is true.. Valid values are `not_applicable|requested|granted|denied|pending`',
    CONSTRAINT pk_lc_drawing PRIMARY KEY(`lc_drawing_id`)
) COMMENT 'Unified transactional record capturing all lifecycle activity against a Letter of Credit, including amendments and drawings/presentations. For amendments: records amendment sequence number, amendment type (amount increase/decrease, expiry extension, condition change, document requirement modification), amended field name and prior/new values, amendment request date, issuing bank approval date, beneficiary acceptance status (accepted/rejected/pending per UCP 600 Art. 10), and amendment compliance flag. For drawings: captures drawing sequence number, presentation date, drawing amount and currency, document set reference, discrepancy flags and descriptions (per ISBP 745 standards), waiver status, honour/negotiation decision, payment due date, and settlement status. Discriminated by transaction_type (amendment/drawing). Tracks partial and full drawings against the LC available balance and maintains full amendment audit trail. Serves as the single source of truth for all LC transactional activity in compliance with UCP 600 and ICC regulatory requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`documentary_collection` (
    `documentary_collection_id` BIGINT COMMENT 'Unique identifier for the documentary collection transaction. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Documentary collections denominated in currencies require currency metadata (settlement lag, convertibility) for payment processing, settlement instructions (SWIFT MT 400/410), and regulatory reportin',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Documentary collection fraud (forged documents, non-existent goods, drawer/drawee collusion) is investigated via fraud cases. Linking collection to case supports dishonor decisions, recovery efforts, ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Documentary collections require handling officer attribution for operational accountability, dispute resolution, and URC 522 compliance. Business process: document examination, payment processing, dis',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Documentary collection settlement: when drawee honors documents, payment is executed via payment instruction (D/P or D/A terms). Operational requirement for collection proceeds tracking, SWIFT MT400/M',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Documentary collections settle through nostro accounts for trade settlement, payment processing, and nostro reconciliation. Standard trade finance operations link collections to settlement nostro acco',
    `party_id` BIGINT COMMENT 'Identifier of the drawer (exporter/seller) who is the principal in the collection and who instructs the remitting bank to collect payment from the drawee.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Documentary collections require sanctions screening of drawer, drawee, and underlying trade parties before document release or payment. Trade finance compliance requirement under OFAC regulations for ',
    `tertiary_documentary_case_of_need_party_id` BIGINT COMMENT 'Identifier of the case-of-need party (referee in case of need) who may be contacted for instructions if the drawee refuses payment or acceptance. Optional field per URC 522.',
    `trade_facility_id` BIGINT COMMENT 'Foreign key linking to loan.trade_facility. Business justification: Documentary collections are processed under trade finance facilities. The collection amount may draw against the facility limit (especially for D/A - documents against acceptance). Business justificat',
    `aml_screening_status` STRING COMMENT 'Status of Anti-Money Laundering screening for this collection transaction. Ensures compliance with Bank Secrecy Act (BSA) and AML regulations.. Valid values are `pending|cleared|flagged|escalated`',
    `case_of_need_instructions` STRING COMMENT 'Specific instructions to be followed if the drawee dishonours the collection, including contact details and authority of the case-of-need party.',
    `charges_allocation` STRING COMMENT 'Party responsible for paying collection charges: drawer (exporter), drawee (importer), or shared between both parties.. Valid values are `drawer|drawee|shared`',
    `charges_amount` DECIMAL(18,2) COMMENT 'Total bank charges and fees associated with the collection. May be for account of drawer, drawee, or split per collection instructions.',
    `charges_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the charges amount.. Valid values are `^[A-Z]{3}$`',
    `collecting_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the collecting bank (presenting bank) that presents documents to the drawee. 8 or 11 character ISO 9362 format.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `collection_amount` DECIMAL(18,2) COMMENT 'Principal amount to be collected from the drawee. Represents the invoice value or bill amount.',
    `collection_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the collection amount.. Valid values are `^[A-Z]{3}$`',
    `collection_date` DATE COMMENT 'Date when the documentary collection was initiated and lodged with the remitting bank. Principal business event timestamp for this transaction.',
    `collection_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this documentary collection by the remitting bank. Used for tracking and correspondence under URC 522.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the documentary collection: lodged (received by remitting bank), presented (documents presented to drawee), accepted (drawee accepted documents), paid (payment received), dishonoured (drawee refused), returned (documents returned to drawer), cancelled (collection cancelled). [ENUM-REF-CANDIDATE: lodged|presented|accepted|paid|dishonoured|returned|cancelled — 7 candidates stripped; promote to reference product]',
    `collection_type` STRING COMMENT 'Type of documentary collection: Documents Against Payment (D/P), Documents Against Acceptance (D/A), or Clean Collection (financial documents only without commercial documents).. Valid values are `documents_against_payment|documents_against_acceptance|clean_collection`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this documentary collection record was first created in the system.',
    `delivery_instructions` STRING COMMENT 'Instructions for when the collecting bank should release documents to the drawee: against payment (D/P), against acceptance (D/A), or without payment (exceptional cases).. Valid values are `deliver_against_payment|deliver_against_acceptance|deliver_without_payment`',
    `dishonour_reason` STRING COMMENT 'Reason provided by the drawee or collecting bank for non-payment or non-acceptance of the collection (e.g., discrepancies in documents, insufficient funds, goods not as described). Populated only if collection status is dishonoured.',
    `document_set_description` STRING COMMENT 'Detailed description of the commercial and financial documents included in the collection (e.g., bill of exchange, commercial invoice, bill of lading, insurance certificate, certificate of origin, packing list).',
    `drawee_name` STRING COMMENT 'Full legal name of the drawee (importer/buyer) to whom the documents are to be presented.',
    `drawer_name` STRING COMMENT 'Full legal name of the drawer (exporter/seller) as it appears on the collection documents.',
    `goods_description` STRING COMMENT 'Description of the goods or services covered by this documentary collection, as stated in the commercial invoice.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Accrued interest amount charged on delayed payment. Calculated based on interest rate and days overdue.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate (percentage) to be charged on the collection amount if payment is delayed beyond maturity date. Applicable for usance collections.',
    `maturity_date` DATE COMMENT 'Date when payment becomes due for documents against acceptance (D/A) collections. Represents the tenor or usance period. Null for sight collections (D/P).',
    `number_of_documents` STRING COMMENT 'Total count of individual documents included in the collection package.',
    `partial_payment_allowed_flag` BOOLEAN COMMENT 'Indicates whether the drawer permits the collecting bank to accept partial payment from the drawee. True if partial payment is allowed, false otherwise.',
    `payment_date` DATE COMMENT 'Date when payment was received from the drawee. Null if collection is not yet paid or was dishonoured.',
    `presentation_date` DATE COMMENT 'Date when the collecting bank presented the documents to the drawee for payment or acceptance.',
    `protest_instructions` STRING COMMENT 'Instructions from the drawer regarding whether to protest non-payment or non-acceptance. Protest is a formal notarial act evidencing dishonour.. Valid values are `protest|do_not_protest`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this collection requires regulatory reporting to authorities (e.g., large transaction reporting, cross-border reporting). True if reporting is required.',
    `remitting_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the remitting bank that received the collection instruction from the drawer. 8 or 11 character ISO 9362 format.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `return_date` DATE COMMENT 'Date when the documents were returned to the remitting bank or drawer following dishonour or cancellation.',
    `shipment_date` DATE COMMENT 'Date of shipment of goods as evidenced by the transport document (bill of lading, airway bill, etc.). Relevant for calculating tenor in shipment-date-based collections.',
    `swift_message_reference` STRING COMMENT 'Unique SWIFT message reference number (field 20) for the collection instruction message.',
    `swift_message_type` STRING COMMENT 'SWIFT message type used for this collection: MT400 (collection order), MT410 (acknowledgement), MT412 (advice of acceptance), MT416 (advice of payment), MT420 (tracer), MT422 (advice of fate).. Valid values are `MT400|MT410|MT412|MT416|MT420|MT422`',
    `tenor_basis` STRING COMMENT 'Basis from which the tenor period is calculated: sight (immediate payment), date of acceptance, date of bill, or date of shipment.. Valid values are `sight|date_of_acceptance|date_of_bill|date_of_shipment`',
    `tenor_days` STRING COMMENT 'Number of days from presentation or acceptance until payment is due. Applicable for usance/time collections (D/A). Zero or null for sight collections (D/P).',
    `underlying_trade_reference` STRING COMMENT 'Reference number of the underlying trade transaction, purchase order, or sales contract that this documentary collection supports.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this documentary collection record was last modified.',
    CONSTRAINT pk_documentary_collection PRIMARY KEY(`documentary_collection_id`)
) COMMENT 'Master record for Documentary Collections (D/P and D/A) processed under URC 522 rules. Captures collection type (documents against payment, documents against acceptance), remitting bank and collecting bank BIC/SWIFT codes, drawer and drawee identities, collection amount and currency, tenor, document set description, protest instructions, case-of-need details, and current status (lodged, presented, paid, accepted, dishonoured, returned). Supports both import and export collection workflows.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`bank_guarantee` (
    `bank_guarantee_id` BIGINT COMMENT 'Unique identifier for the bank guarantee record. Primary key for the bank guarantee entity.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Bank guarantee issuance requires beneficiary credit assessment to evaluate claim probability. Beneficiary creditworthiness affects guarantee pricing, ECL provisioning, and regulatory capital calculati',
    `beneficiary_id` BIGINT COMMENT 'Reference to the party in whose favor the bank guarantee is issued. The party entitled to make a claim under the guarantee.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Bank guarantees issued in currencies require currency metadata (rounding, minor unit) for claims processing, payment execution, GL posting (contingent liability valuation), and regulatory reporting (o',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Bank guarantees are deal instruments (bid bonds in M&A auctions, performance bonds in project finance, advance payment guarantees in structured deals). Investment banking structures deal; guarantee de',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Bank guarantees are issued against approved credit facilities (either generic facility or trade_facility). This FK links to the parent facility that provides the credit line. Business justification: G',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Bank guarantee fraud (fraudulent claims, forged guarantees, beneficiary collusion) requires investigation. Fraud cases link to the guarantee for claim rejection, law enforcement referral, and recovery',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Bank guarantee issuance and claim payments generate journal entries for contingent liability recognition and claim settlement. Required for guarantee accounting and off-balance-sheet exposure tracking',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Bank guarantees issued via channels. Essential for contingent liability tracking by channel, trade services performance analytics, and channel capacity planning for guarantee issuance in trade finance',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Bank guarantee issuance requires documented officer approval for URDG 758 compliance, credit risk management, and regulatory capital reporting. Business process: credit approval documentation, claim a',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Bank guarantees are off-balance-sheet commitments impacting liquidity planning under stress scenarios, contingency funding plans, and NSFR calculation. Essential for comprehensive liquidity risk manag',
    `party_id` BIGINT COMMENT 'Reference to the party (customer) requesting the issuance of the bank guarantee. The principal obligor on whose behalf the guarantee is issued.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Bank guarantees require sanctions screening of applicant, beneficiary, counter-guaranteeing banks, and underlying contract parties before issuance. OFAC compliance checkpoint for contingent liability ',
    `auto_extension_flag` BOOLEAN COMMENT 'Indicates whether the guarantee contains an automatic extension clause. True if the guarantee automatically extends unless the issuing bank provides notice of non-renewal.',
    `claim_documents_received` STRING COMMENT 'Description of documents submitted with the claim (e.g., Demand letter, Beneficiary certificate, Invoice copies). Null if no claim has been made.',
    `claim_period_days` STRING COMMENT 'Number of days after expiry date during which claims may still be presented, if specified in the guarantee terms. Null if no extended claim period applies.',
    `claim_receipt_date` DATE COMMENT 'Date on which a claim demand was received from the beneficiary. Null if no claim has been made.',
    `claim_sequence_number` STRING COMMENT 'Sequential number of the claim against this guarantee. Null if no claim has been made. Increments with each new claim (supports multiple claims against a single guarantee).',
    `claimant_identity` STRING COMMENT 'Name and identification details of the party presenting the claim. Typically the beneficiary or an authorized representative. Null if no claim has been made.',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Amount claimed by the beneficiary in the current or most recent claim. Null if no claim has been made.',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'Ratio of collateral value to guarantee amount, expressed as a percentage. Null if no collateral is required.',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether the applicant is required to provide collateral to secure the banks exposure under the guarantee. True if collateral is required.',
    `commission_rate_bps` STRING COMMENT 'Annual commission rate charged on the outstanding guarantee amount, expressed in basis points (1 bps = 0.01%).',
    `counter_guaranteeing_bank_bic` STRING COMMENT 'SWIFT BIC of the bank providing a counter-guarantee (guarantee backing another guarantee). Applicable only for counter-guarantee arrangements. Null if not a counter-guarantee.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank guarantee record was first created in the system.',
    `demand_indicator` STRING COMMENT 'Indicates whether the guarantee is payable on first demand (on-demand) or requires proof of default or other conditions (conditional).. Valid values are `on_demand|conditional`',
    `ecl_provision_amount` DECIMAL(18,2) COMMENT 'Expected credit loss provision amount calculated for this guarantee under IFRS 9 or CECL accounting standards.',
    `effective_date` DATE COMMENT 'Date from which the bank guarantee becomes effective and enforceable. The guarantee is in force from this date.',
    `expiry_date` DATE COMMENT 'Date on which the bank guarantee expires and ceases to be enforceable. Claims must be received on or before this date unless extended.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and law governing the interpretation and enforcement of the bank guarantee (e.g., English Law, New York Law, URDG 758).',
    `guarantee_amount` DECIMAL(18,2) COMMENT 'Face value amount of the bank guarantee. The maximum amount that can be claimed by the beneficiary under the guarantee terms.',
    `guarantee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the guarantee amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `guarantee_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the bank guarantee or standby letter of credit. Used for identification in correspondence and SWIFT messaging.',
    `guarantee_status` STRING COMMENT 'Current lifecycle status of the bank guarantee: draft (being prepared), issued (sent to beneficiary), active (in force), extended (maturity extended), reduced (amount reduced), claimed (demand received), expired (past expiry date), cancelled (terminated before expiry), or released (obligations fulfilled). [ENUM-REF-CANDIDATE: draft|issued|active|extended|reduced|claimed|expired|cancelled|released — 9 candidates stripped; promote to reference product]',
    `guarantee_type` STRING COMMENT 'Classification of the guarantee instrument: bid bond (tender guarantee), performance bond, advance payment guarantee, retention money guarantee, financial guarantee, standby letter of credit (LC), or counter-guarantee. [ENUM-REF-CANDIDATE: bid_bond|performance_bond|advance_payment_guarantee|retention_money_guarantee|financial_guarantee|standby_lc|counter_guarantee — 7 candidates stripped; promote to reference product]',
    `ifrs9_stage` STRING COMMENT 'IFRS 9 impairment stage classification: stage_1 (performing, 12-month ECL), stage_2 (significant increase in credit risk, lifetime ECL), or stage_3 (credit-impaired, lifetime ECL).. Valid values are `stage_1|stage_2|stage_3`',
    `issuance_date` DATE COMMENT 'Date on which the bank guarantee was formally issued by the issuing bank.',
    `issuance_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the issuing bank for issuing the guarantee. Typically a percentage of the guarantee amount.',
    `issuance_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the issuance fee is denominated.. Valid values are `^[A-Z]{3}$`',
    `issuing_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the bank issuing the guarantee. 8 or 11 character ISO 9362 code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank guarantee record was last updated in the system.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Actual amount paid to the beneficiary in settlement of the claim. May differ from claimed amount if partial payment was made. Null if claim was rejected or not yet paid.',
    `payment_date` DATE COMMENT 'Date on which payment was made to the beneficiary in settlement of the claim. Null if claim was rejected or not yet paid.',
    `payment_decision` STRING COMMENT 'Banks decision on the claim: honour (pay the claim), reject (refuse payment with reasons), or extend_or_pay (offer extension in lieu of payment). Null if decision not yet made.. Valid values are `honour|reject|extend_or_pay`',
    `reduction_schedule` STRING COMMENT 'Description of the schedule by which the guarantee amount reduces over time (e.g., Reduce by 10% quarterly, Reduce to 50% after 6 months). Null if no reduction schedule applies.',
    `rejection_notification_date` DATE COMMENT 'Date on which the beneficiary was notified of the claim rejection. Must be within the timeline specified in URDG 758. Null if claim was honoured or not yet decided.',
    `rejection_reason` STRING COMMENT 'Detailed reason for rejecting the claim, citing specific discrepancies or non-compliance with guarantee terms. Null if claim was honoured or not yet decided.',
    `residual_guarantee_balance` DECIMAL(18,2) COMMENT 'Remaining guarantee amount available after claim payment or reduction. Equals original guarantee amount minus cumulative payments and reductions.',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to the guarantee exposure for regulatory capital calculation under Basel III framework.',
    `rwa_amount` DECIMAL(18,2) COMMENT 'Risk-weighted asset amount calculated for this guarantee exposure, used for regulatory capital adequacy calculations.',
    `swift_message_reference` STRING COMMENT 'SWIFT message reference number for the MT760 (issue of guarantee) or MT767 (guarantee amendment) message. Used for tracking and reconciliation.',
    `underlying_contract_reference` STRING COMMENT 'Reference number or description of the underlying commercial contract or transaction that the guarantee secures (e.g., construction contract, supply agreement).',
    `urdg_compliance_assessment` STRING COMMENT 'Assessment result of whether the claim complies with URDG 758 Article 20 requirements (complying presentation). Null if no claim has been made.. Valid values are `compliant|non_compliant|under_review`',
    CONSTRAINT pk_bank_guarantee PRIMARY KEY(`bank_guarantee_id`)
) COMMENT 'Master record for Bank Guarantees and Standby Letters of Credit issued or received, with integrated claim lifecycle management. Captures guarantee type (bid bond, performance bond, advance payment guarantee, retention money guarantee, financial guarantee, standby LC, counter-guarantee), applicant and beneficiary references, issuing and counter-guaranteeing bank details (BIC/SWIFT), guarantee amount and currency, effective and expiry dates, claim period, governing law, auto-extension clause, reduction schedule, demand indicator (on-demand vs conditional), and current status (draft, issued, extended, reduced, claimed, expired, cancelled). For claims against the guarantee: records claim sequence number, claim receipt date, claimed amount, claimant identity, claim documents received, URDG 758 Article 20 compliance assessment result, payment decision (honour/reject with extend-or-pay handling), rejection reason and notification timeline, payment date, and residual guarantee balance post-claim. Serves as the single source of truth for the full guarantee and claim lifecycle from issuance through expiry or claim settlement, governed by URDG 758 and ISP98.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`trade_document` (
    `trade_document_id` BIGINT COMMENT 'Unique identifier for the trade finance document record. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade documents (invoices, bills of exchange) denominated in currencies require currency metadata (rounding, minor unit) for document examination (UCP 600 compliance), valuation, and discrepancy asses',
    `documentary_collection_id` BIGINT COMMENT 'Reference to the documentary collection transaction associated with this document. Links to collections under URC 522.',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Trade documents trigger fraud alerts (forged bills of lading, altered invoices, phantom shipments). Linking document to alert enables document examination workflow, discrepancy identification, and pre',
    `guarantee_id` BIGINT COMMENT 'Reference to the bank guarantee associated with this document. Links to guarantee transactions requiring documentary support.',
    `lc_id` BIGINT COMMENT 'Reference to the letter of credit associated with this document. Links to the LC transaction for which this document is presented.',
    `employee_id` BIGINT COMMENT 'Identifier of the bank officer or trade finance specialist who examined the document for compliance. Used for accountability and audit trail.',
    `aml_screening_status` STRING COMMENT 'Status of AML and sanctions screening for parties and entities named in the document. Ensures compliance with OFAC, EU sanctions, and financial crime regulations.. Valid values are `pending|cleared|flagged|under_review`',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or instructions related to the document examination, handling, or disposition.',
    `compliant_flag` BOOLEAN COMMENT 'Indicates whether the document is compliant with the terms and conditions of the LC or guarantee. True if no discrepancies exist, false if discrepancies are present.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the trade document record was first created in the system. Used for audit trail and data lineage tracking.',
    `discrepancy_code` STRING COMMENT 'Standardized code identifying the type of discrepancy found during document examination. Used for categorization and reporting of non-compliant presentations.',
    `discrepancy_description` STRING COMMENT 'Detailed narrative description of any discrepancies identified during document examination. Must clearly state the nature of non-compliance with LC terms or UCP 600 requirements.',
    `document_amount` DECIMAL(18,2) COMMENT 'Monetary amount stated on the document. Applicable to commercial invoices, drafts, bills of exchange, and insurance certificates. Must not exceed LC amount.',
    `document_format` STRING COMMENT 'Format in which the document is presented. Identifies whether physical paper or specific electronic format under eUCP. [ENUM-REF-CANDIDATE: paper|pdf|xml|edi|bolero|essdocs|other_electronic — 7 candidates stripped; promote to reference product]',
    `document_hash` STRING COMMENT 'Cryptographic hash of the document content for integrity verification. Used to detect tampering or alteration of electronic documents.',
    `document_reference_number` STRING COMMENT 'Unique external reference number assigned to the trade document by the issuer or presenting party. Used for tracking and reconciliation across parties.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document in the examination and acceptance workflow. Tracks progression from receipt through compliance review to final disposition. [ENUM-REF-CANDIDATE: received|under_examination|compliant|discrepant|waived|rejected|accepted|returned — 8 candidates stripped; promote to reference product]',
    `document_type` STRING COMMENT 'Classification of the trade finance document. Identifies the nature and purpose of the document within the trade transaction. [ENUM-REF-CANDIDATE: bill_of_lading|commercial_invoice|packing_list|certificate_of_origin|insurance_certificate|inspection_certificate|bill_of_exchange|draft|beneficiary_certificate|weight_certificate|quality_certificate|phytosanitary_certificate|customs_declaration|airway_bill|warehouse_receipt — promote to reference product]',
    `electronic_document_flag` BOOLEAN COMMENT 'Indicates whether the document is presented in electronic form under eUCP rules. True for electronic presentation, false for paper documents.',
    `examination_date` DATE COMMENT 'Date on which the document examination was completed by the bank. Must occur within five banking days of presentation per UCP 600 Article 14(b).',
    `expiry_date` DATE COMMENT 'Expiration or validity date of the document if applicable. Relevant for certificates, insurance policies, and time-sensitive documents.',
    `issue_date` DATE COMMENT 'Date on which the trade document was issued by the originating party. Critical for determining compliance with LC presentation deadlines and shipment date requirements.',
    `issuer_identifier` STRING COMMENT 'Unique identifier or registration number of the issuing party. May include business registration number, carrier code, or agency license number.',
    `issuer_name` STRING COMMENT 'Name of the party or institution that issued the trade document. May be a carrier, inspection agency, chamber of commerce, insurance company, or beneficiary.',
    `number_of_originals` STRING COMMENT 'Count of original documents presented when multiple originals are issued. Common for bills of lading issued in sets of three originals.',
    `original_flag` BOOLEAN COMMENT 'Indicates whether the document is an original as required by LC terms. True if original, false if copy. Critical for documents like bills of lading where originals are required.',
    `page_count` STRING COMMENT 'Total number of pages in the document. Used for completeness verification and audit trail purposes.',
    `presentation_date` DATE COMMENT 'Date on which the complete set of documents was presented to the nominated or issuing bank. Used to verify compliance with LC expiry and presentation deadlines.',
    `received_date` DATE COMMENT 'Date on which the document was received by the examining bank or presenting party. Marks the start of the examination period under UCP 600 Article 14.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this document is subject to regulatory reporting requirements such as trade finance exposure reporting or sanctions screening.',
    `rejection_reason` STRING COMMENT 'Detailed explanation for rejection of the document or refusal of the presentation. Must cite specific LC terms or UCP 600 articles that are not satisfied.',
    `shipment_date` DATE COMMENT 'Date of shipment as evidenced by the transport document. Critical for compliance with latest shipment date specified in the LC.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system from which the trade document record originated. Supports data lineage and reconciliation across trade finance platforms.',
    `storage_location` STRING COMMENT 'Physical or electronic storage location reference for the document. May be vault location, document management system path, or cloud storage URI.',
    `storage_reference_code` STRING COMMENT 'Unique identifier or key used to retrieve the document from the storage system. Links to document management or imaging system.',
    `swift_message_reference` STRING COMMENT 'Reference number of the SWIFT message (MT700, MT710, MT720, MT734, MT754) associated with the document presentation or discrepancy notification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the trade document record. Tracks modifications throughout the document lifecycle.',
    `waiver_date` DATE COMMENT 'Date on which the applicant granted waiver of discrepancies and authorized the bank to proceed with payment or acceptance.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the applicant has waived identified discrepancies and authorized payment despite non-compliance. True if waiver obtained, false otherwise.',
    CONSTRAINT pk_trade_document PRIMARY KEY(`trade_document_id`)
) COMMENT 'Repository of all trade finance documents associated with LC drawings, documentary collections, and guarantees. Captures document type (bill of lading, commercial invoice, packing list, certificate of origin, insurance certificate, inspection certificate, bill of exchange, draft), document reference number, issuer, issue date, document status (received, examined, compliant, discrepant, waived, rejected), discrepancy codes, and storage reference. Supports UCP 600 Article 14 document examination and eUCP electronic document workflows.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'Unique identifier for the bill of lading record. Primary key.',
    `documentary_collection_id` BIGINT COMMENT 'Foreign key linking to loan.documentary_collection. Business justification: Bills of Lading are also used in Documentary Collections (D/P and D/A) under URC 522. The B/L is a key document in the collection set. One B/L belongs to one documentary collection (1:N from documenta',
    `forfaiting_id` BIGINT COMMENT 'Foreign key linking to loan.forfaiting. Business justification: Bills of Lading can be part of the underlying documentation for forfaiting transactions where the bank purchases trade receivables. The B/L evidences the shipment of goods underlying the receivable. O',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Bills of lading with freight charges in currencies require currency metadata (rounding, minor unit) for freight cost calculation, document examination (LC compliance), and accounting (trade finance co',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: Bill of Lading is a primary transport document in Letter of Credit transactions under UCP 600. B/Ls are presented as part of the documentary requirements for LC drawings. The trade_finance_transaction',
    `trade_finance_transaction_id` BIGINT COMMENT 'Reference to the parent trade finance transaction (letter of credit, documentary collection, or bank guarantee) that this bill of lading supports.',
    `bl_number` STRING COMMENT 'Unique externally-known bill of lading reference number issued by the carrier. Primary business identifier for the transport document.',
    `bl_status` STRING COMMENT 'Current lifecycle status of the bill of lading in the trade finance workflow.. Valid values are `draft|issued|endorsed|surrendered|released|cancelled`',
    `bl_type` STRING COMMENT 'Classification of the bill of lading document type. Determines negotiability and title transfer characteristics. [ENUM-REF-CANDIDATE: straight|order|bearer|sea_waybill|multimodal|house|master|charter_party — 8 candidates stripped; promote to reference product]',
    `carrier_name` STRING COMMENT 'Full legal name of the shipping carrier or freight forwarder issuing the bill of lading.',
    `carrier_scac_code` STRING COMMENT 'Four-letter unique identifier assigned to transportation companies by the National Motor Freight Traffic Association (NMFTA).. Valid values are `^[A-Z]{4}$`',
    `clauses_remarks` STRING COMMENT 'Any clauses, notations, or remarks added by the carrier regarding the condition of goods, packaging, or special handling instructions.',
    `clean_bl_flag` BOOLEAN COMMENT 'Indicates whether the bill of lading is clean (no clauses noting defects or damage to goods or packaging). True = clean, False = claused/foul.',
    `collateral_flag` BOOLEAN COMMENT 'Indicates whether this bill of lading is pledged as collateral for a trade finance facility. True = pledged as collateral.',
    `collateral_value_amount` DECIMAL(18,2) COMMENT 'Assessed value of the goods represented by this bill of lading for collateral management purposes.',
    `collateral_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the collateral value amount.. Valid values are `^[A-Z]{3}$`',
    `consignee_address` STRING COMMENT 'Complete address of the consignee including street, city, state/province, postal code, and country.',
    `consignee_name` STRING COMMENT 'Full legal name of the party to whom the goods are consigned (importer/receiver). For order B/Ls, may be To Order or To Order of [Bank Name].',
    `container_numbers` STRING COMMENT 'Comma-separated list of container identification numbers (ISO 6346 format) used for this shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bill of lading record was first created in the system.',
    `endorsement_chain` STRING COMMENT 'Chronological record of all endorsements made on the bill of lading for order B/Ls. Critical for tracking title transfer and collateral perfection.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Total freight charges for the shipment.',
    `freight_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for freight charges.. Valid values are `^[A-Z]{3}$`',
    `freight_terms` STRING COMMENT 'Payment terms for freight charges. Prepaid means shipper pays; collect means consignee pays at destination.. Valid values are `prepaid|collect|prepaid_and_collect`',
    `goods_description` STRING COMMENT 'Detailed description of the goods being shipped including commodity type, quantity, and specifications. Must match letter of credit terms.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the shipment including packaging and containers.',
    `hs_code` STRING COMMENT 'International standardized system of names and numbers to classify traded products for customs and tariff purposes.. Valid values are `^[0-9]{6,10}$`',
    `issue_date` DATE COMMENT 'Date when the bill of lading document was officially issued by the carrier.',
    `notify_party_address` STRING COMMENT 'Complete address of the notify party including street, city, state/province, postal code, and country.',
    `notify_party_name` STRING COMMENT 'Full legal name of the party to be notified upon arrival of goods at destination port. Often the importer or customs broker.',
    `number_of_packages` STRING COMMENT 'Total count of packages, cartons, pallets, or other shipping units in the shipment.',
    `on_board_date` DATE COMMENT 'Date when goods were loaded on board the vessel. Critical for letter of credit compliance and title transfer timing.',
    `original_bl_count` STRING COMMENT 'Number of original signed bill of lading copies issued. Typically 3 originals are issued; surrender of one original releases the goods.',
    `package_type` STRING COMMENT 'Type of packaging used for the goods (e.g., cartons, pallets, drums, containers, bags).',
    `place_of_delivery` STRING COMMENT 'Final destination location where the carrier delivers the goods to the consignee. Relevant for multimodal transport.',
    `place_of_receipt` STRING COMMENT 'Location where the carrier takes custody of the goods from the shipper. Relevant for multimodal transport.',
    `port_of_discharge_code` STRING COMMENT 'Five-letter UN/LOCODE identifying the port where goods are unloaded from the vessel.. Valid values are `^[A-Z]{5}$`',
    `port_of_discharge_name` STRING COMMENT 'Full name of the port where goods are unloaded from the vessel.',
    `port_of_loading_code` STRING COMMENT 'Five-letter UN/LOCODE identifying the port where goods are loaded onto the vessel.. Valid values are `^[A-Z]{5}$`',
    `port_of_loading_name` STRING COMMENT 'Full name of the port where goods are loaded onto the vessel.',
    `shipper_address` STRING COMMENT 'Complete address of the shipper including street, city, state/province, postal code, and country.',
    `shipper_name` STRING COMMENT 'Full legal name of the party shipping the goods (exporter/consignor). The party from whom the goods originate.',
    `surrendered_date` DATE COMMENT 'Date when the original bill of lading was surrendered to the carrier for release of goods.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bill of lading record was last modified in the system.',
    `vessel_name` STRING COMMENT 'Name of the ocean vessel, aircraft, or other transport vehicle carrying the goods.',
    `volume` DECIMAL(18,2) COMMENT 'Total volume or cubic measurement of the shipment.',
    `volume_unit` STRING COMMENT 'Unit of measurement for volume (cubic meters, cubic feet, or liters).. Valid values are `cbm|cbf|liters`',
    `voyage_number` STRING COMMENT 'Unique identifier for the specific voyage or flight number of the transport vehicle.',
    `weight_unit` STRING COMMENT 'Unit of measurement for the gross weight (kilograms, pounds, metric tons, or tons).. Valid values are `kg|lbs|mt|tons`',
    CONSTRAINT pk_bill_of_lading PRIMARY KEY(`bill_of_lading_id`)
) COMMENT 'Specialized master record for Bills of Lading (B/L) as the primary transport document in trade finance transactions. Captures B/L type (straight, order, bearer, sea waybill, multimodal), shipper, consignee and notify party, vessel name and voyage number, port of loading and discharge, on-board date, freight terms (prepaid/collect), goods description, container numbers, gross weight and volume, original B/L count, and endorsement chain. Critical for title transfer and collateral management in trade finance.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`supply_chain_program` (
    `supply_chain_program_id` BIGINT COMMENT 'Unique identifier for the supply chain finance program. Primary key.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Supply chain finance program approval and credit limits depend on anchor buyer creditworthiness. Internal_risk_rating/pd/lgd/ead are denormalized rating outputs that should be sourced from counterpart',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the bank relationship manager responsible for managing the anchor buyer relationship and overseeing the supply chain finance program.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Supply chain finance programs denominated in currencies require currency metadata (rounding, settlement lag) for discount calculation, early payment processing, supplier onboarding (currency eligibili',
    `employee_id` BIGINT COMMENT 'Identifier of the credit analyst responsible for credit risk assessment and monitoring of the supply chain finance program.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Supply chain finance fraud (invoice fraud, duplicate financing, fictitious suppliers) is investigated at the program level. Fraud cases link to the program for supplier suspension, anchor buyer notifi',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Supply chain finance programs require dedicated funding sources tracked in treasury funding plans for annual funding strategy, wholesale funding allocation, and cost of funds optimization.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified the supply chain finance program record. Used for audit trail and change tracking.',
    `party_id` BIGINT COMMENT 'Identifier of the anchor buyer (corporate customer) who establishes the program and whose payables are financed. The anchor buyer is the creditworthy entity whose payment obligation underpins the program.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Supply chain finance programs require ongoing sanctions screening of anchor buyers and enrolled suppliers. Program-level compliance monitoring ensures all participants remain off sanctions lists throu',
    `trade_facility_id` BIGINT COMMENT 'Foreign key linking to loan.trade_facility. Business justification: Supply chain finance programs operate under approved trade finance facilities. The program has approved_credit_limit but no link to the underlying facility structure. Business justification: SCF progr',
    `approved_credit_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate financing amount approved for the supply chain finance program across all suppliers and invoices. Represents the banks total exposure limit to the program.',
    `auto_approval_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum invoice amount that can be automatically approved for financing without manual credit review. Invoices exceeding this threshold require additional approval.',
    `available_credit_amount` DECIMAL(18,2) COMMENT 'Remaining financing capacity available under the program, calculated as approved_credit_limit minus current_utilization_amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supply chain finance program record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `current_utilization_amount` DECIMAL(18,2) COMMENT 'Total outstanding financing amount currently drawn under the supply chain finance program across all active invoices. Updated in real-time as invoices are financed and settled.',
    `dilution_reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of invoice value withheld as a reserve to cover potential dilution events such as returns, disputes, discounts, or credits that reduce the collectible amount. Expressed as a percentage (e.g., 5.00 for 5%).',
    `discount_rate_basis` STRING COMMENT 'Methodology for calculating the discount rate applied to early payment financing. SOFR (Secured Overnight Financing Rate) spread, EURIBOR (Euro Interbank Offered Rate) spread, LIBOR (London Interbank Offered Rate) spread for legacy programs, or fixed rate option.. Valid values are `sofr_spread|euribor_spread|libor_spread|fixed_rate`',
    `discount_rate_spread_bps` DECIMAL(18,2) COMMENT 'Spread in basis points (BPS) added to the benchmark rate (SOFR, EURIBOR, LIBOR) to determine the total discount rate charged for early payment financing. One basis point equals 0.01%.',
    `ecl_provision_amount` DECIMAL(18,2) COMMENT 'Accounting provision amount set aside for expected credit losses on the supply chain finance program under IFRS 9 or CECL accounting standards. Calculated as PD × LGD × EAD.',
    `eligible_supplier_criteria` STRING COMMENT 'Business rules and requirements that suppliers must meet to participate in the supply chain finance program, including credit rating thresholds, geographic restrictions, industry classifications, and compliance requirements.',
    `fixed_discount_rate` DECIMAL(18,2) COMMENT 'Fixed annual percentage rate applied when discount_rate_basis is set to fixed_rate. Expressed as a decimal (e.g., 0.0350 for 3.50%).',
    `gl_account_code` STRING COMMENT 'General ledger account code to which supply chain finance program transactions and balances are posted for financial accounting and reporting purposes.',
    `ifrs9_stage_classification` STRING COMMENT 'IFRS 9 impairment stage classification. Stage 1: performing with 12-month ECL; Stage 2: significant increase in credit risk with lifetime ECL; Stage 3: credit-impaired with lifetime ECL.. Valid values are `stage_1|stage_2|stage_3`',
    `last_credit_review_date` DATE COMMENT 'Date of the most recent credit review conducted for the supply chain finance program, including assessment of anchor buyer creditworthiness and program risk parameters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supply chain finance program record was most recently updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maximum_tenor_days` STRING COMMENT 'Maximum number of days between invoice financing date and maturity date that the program will accept. Defines the upper bound of the eligible financing period.',
    `minimum_tenor_days` STRING COMMENT 'Minimum number of days between invoice financing date and maturity date that the program will accept. Defines the lower bound of the eligible financing period.',
    `next_credit_review_date` DATE COMMENT 'Scheduled date for the next periodic credit review of the supply chain finance program. Review frequency is determined by internal risk rating and regulatory requirements.',
    `program_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the supply chain finance program operates and invoices are denominated.. Valid values are `^[A-Z]{3}$`',
    `program_documentation_reference` STRING COMMENT 'Reference identifier or location of the legal documentation governing the supply chain finance program, including master agreements, terms and conditions, and operational procedures.',
    `program_end_date` DATE COMMENT 'Scheduled or actual termination date of the supply chain finance program. Null for open-ended programs without a defined end date.',
    `program_name` STRING COMMENT 'Business name or title of the supply chain finance program, typically reflecting the anchor buyer or program purpose.',
    `program_reference_number` STRING COMMENT 'Externally-known unique business identifier for the supply chain finance program, used in communications with anchor buyers and suppliers.',
    `program_start_date` DATE COMMENT 'Effective date when the supply chain finance program became operational and began accepting invoice submissions for financing.',
    `program_status` STRING COMMENT 'Current lifecycle status of the supply chain finance program. Active programs accept new transactions; suspended programs are temporarily halted; closed programs are terminated; pending activation programs are in setup phase.. Valid values are `active|suspended|closed|pending_activation`',
    `program_type` STRING COMMENT 'Classification of the supply chain finance program structure. Payables finance/reverse factoring allows suppliers to receive early payment on approved invoices; receivables discounting enables suppliers to sell receivables at a discount; dynamic discounting offers flexible early payment terms; inventory finance provides funding against inventory; distributor finance supports distributor working capital needs.. Valid values are `payables_finance|reverse_factoring|receivables_discounting|dynamic_discounting|inventory_finance|distributor_finance`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this supply chain finance program requires inclusion in regulatory capital and liquidity reporting (Basel III, CCAR, DFAST). True if reportable, false otherwise.',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to program exposure for Risk-Weighted Assets (RWA) calculation under Basel III capital adequacy framework. Reflects the credit risk of the anchor buyer.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which the supply chain finance program data originated (e.g., Loan Origination System, Trade Finance Platform).',
    `supplier_onboarding_status` STRING COMMENT 'Current state of supplier enrollment into the program. Open programs accept new supplier applications; restricted programs require anchor buyer pre-approval; closed programs do not accept new suppliers.. Valid values are `open|restricted|closed`',
    `total_suppliers_enrolled` STRING COMMENT 'Count of unique suppliers currently enrolled and active in the supply chain finance program.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of approved credit limit currently utilized, calculated as (current_utilization_amount / approved_credit_limit) * 100. Key metric for program monitoring and risk management.',
    CONSTRAINT pk_supply_chain_program PRIMARY KEY(`supply_chain_program_id`)
) COMMENT 'Master record for Supply Chain Finance (SCF) programs established between the bank, anchor buyers, and their supplier networks. Captures program type (payables finance/reverse factoring, receivables discounting, dynamic discounting, inventory finance, distributor finance), program name, anchor buyer identity, approved credit limit, program currency, discount rate basis (SOFR/EURIBOR spread, fixed rate option), tenor range, eligible supplier criteria and onboarding status, program start and end dates, auto-approval threshold, dilution reserve percentage, and program status (active, suspended, closed). Individual invoice-level activity (submission, approval, financing, early payment, settlement, dispute) is tracked via trade_utilization with SCF product-type discriminator, enabling real-time program utilization monitoring. Governed by GSCFF (Global Supply Chain Finance Forum) standard definitions and ICC Standard Definitions for Techniques of Supply Chain Finance.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`trade_facility` (
    `trade_facility_id` BIGINT COMMENT 'Unique identifier for the trade finance facility record. Primary key for the trade facility master.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager responsible for managing the client relationship and this trade finance facility.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Trade finance for UHNW clients: trade facilities (letters of credit, bank guarantees) for high-net-worth individuals and family offices are often secured against their investment portfolios. The trade',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Trade facility approval and limit setting require counterparty credit ratings. Internal_risk_rating/pd/lgd/ead are denormalized rating parameters that should be sourced from counterparty_rating for co',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Trade facilities exposed to country risk require country risk ratings, sovereign ratings, sanctions flags, and regulatory frameworks for credit decisioning, pricing (country risk premium), provisionin',
    `covenant_package_id` BIGINT COMMENT 'Reference to the set of financial and operational covenants applicable to this trade finance facility.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade facilities with limits in currencies require currency metadata (convertibility, restrictions) for utilization tracking, sublimit monitoring, and regulatory reporting (trade finance credit limits',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Trade finance facilities need funding allocation from treasury wholesale funding strategy for funding plan execution, diversification management, and cost optimization.',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Trade facilities extended to industries require industry classification (NAICS, SIC) for concentration risk limits, credit policy thresholds, and regulatory reporting (Basel Pillar 3 industry breakdow',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Trade facilities require KYC reviews for facility approval and periodic refresh, especially for cross-border trade finance exposures. Enhanced due diligence needed for trade finance given sanctions ri',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Trade facilities originated through channels. Required for trade finance origination analytics, relationship manager channel attribution, and trade services distribution strategy in corporate/commerci',
    `party_id` BIGINT COMMENT 'Reference to the corporate or institutional client to whom the trade finance facility is extended.',
    `aml_screening_status` STRING COMMENT 'Current status of AML and sanctions screening for the facility and borrower. Values: pending (screening in progress), cleared (no issues identified), flagged (potential match requiring review), under_review (manual review in progress).. Valid values are `pending|cleared|flagged|under_review`',
    `approved_limit_amount` DECIMAL(18,2) COMMENT 'Total credit limit amount approved for the trade finance facility, representing the maximum exposure the bank will accept.',
    `available_amount` DECIMAL(18,2) COMMENT 'Remaining available headroom under the facility, calculated as approved limit minus utilized amount minus any reserved amounts.',
    `collateral_reference` STRING COMMENT 'Reference identifier linking to the collateral record(s) pledged to secure this facility.',
    `collateral_type` STRING COMMENT 'Primary type of collateral or security backing the trade finance facility. Values include unsecured, cash collateral, inventory, receivables, standby letter of credit, corporate guarantee, personal guarantee, real estate, securities. [ENUM-REF-CANDIDATE: unsecured|cash_collateral|inventory|receivables|standby_lc|corporate_guarantee|personal_guarantee|real_estate|securities — 9 candidates stripped; promote to reference product]',
    `country_of_risk` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country risk exposure for this facility, typically the borrowers domicile or primary operating country.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade facility record was first created in the system.',
    `eca_insurance_cover_percent` DECIMAL(18,2) COMMENT 'Percentage of facility exposure covered by ECA insurance or guarantee, typically ranging from 85% to 95% for political and commercial risk.',
    `eca_reference_number` STRING COMMENT 'Reference number for Export Credit Agency insurance or guarantee backing this facility, if applicable to ECA-backed facilities.',
    `ecl_amount` DECIMAL(18,2) COMMENT 'Expected credit loss provision amount calculated under IFRS 9 or CECL accounting standards for this facility.',
    `facility_number` STRING COMMENT 'Business-facing unique reference number for the trade finance facility, used in client communications and documentation.',
    `facility_status` STRING COMMENT 'Current lifecycle status of the trade finance facility. Values: proposed (under credit review), approved (credit approved but not yet active), active (available for utilization), suspended (temporarily unavailable), expired (past maturity date), cancelled (terminated before maturity).. Valid values are `proposed|approved|active|suspended|expired|cancelled`',
    `facility_tenor_months` STRING COMMENT 'Duration of the facility commitment period expressed in months from origination to maturity.',
    `facility_type` STRING COMMENT 'Classification of the trade finance facility product. Values: lc_issuance (Letter of Credit issuance line), guarantee_line (bank guarantee line), pre_shipment_finance (pre-export financing), post_shipment_finance (post-export financing), import_loan (import financing line), trust_receipt (trust receipt line), scf_buyer_limit (Supply Chain Finance buyer limit), forfaiting_line (forfaiting facility), eca_backed (Export Credit Agency backed facility), upas_line (Usance Payable at Sight line). [ENUM-REF-CANDIDATE: lc_issuance|guarantee_line|pre_shipment_finance|post_shipment_finance|import_loan|trust_receipt|scf_buyer_limit|forfaiting_line|eca_backed|upas_line — 10 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'General ledger account code used for booking and tracking the financial impact of this trade finance facility.',
    `ifrs9_stage` STRING COMMENT 'IFRS 9 impairment stage classification. Values: stage_1 (performing, 12-month ECL), stage_2 (significant increase in credit risk, lifetime ECL), stage_3 (credit-impaired, lifetime ECL).. Valid values are `stage_1|stage_2|stage_3`',
    `kyc_review_date` DATE COMMENT 'Date of the most recent KYC review and refresh for the borrower associated with this facility.',
    `limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved facility limit.. Valid values are `^[A-Z]{3}$`',
    `margin_requirement_percent` DECIMAL(18,2) COMMENT 'Percentage of cash margin or security deposit required from the client as a percentage of each utilization under the facility.',
    `maturity_date` DATE COMMENT 'Scheduled expiration date of the trade finance facility commitment, after which no new utilizations are permitted unless renewed.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or operational notes related to the trade finance facility.',
    `originating_branch_code` STRING COMMENT 'Code identifying the bank branch or business unit that originated and manages this trade finance facility.',
    `origination_date` DATE COMMENT 'Date when the trade finance facility was first established and became effective.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this facility is subject to regulatory reporting requirements (e.g., Basel III, CCAR, DFAST, country-specific trade finance reporting).',
    `renewal_date` DATE COMMENT 'Date when the facility was last renewed or extended, if applicable.',
    `review_date` DATE COMMENT 'Next scheduled date for periodic credit review and renewal assessment of the trade finance facility.',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to the facility exposure for regulatory capital calculation under Basel III standardized or IRB approach.',
    `rwa_amount` DECIMAL(18,2) COMMENT 'Risk-weighted asset amount calculated for regulatory capital purposes under Basel III framework.',
    `sublimit_financing_amount` DECIMAL(18,2) COMMENT 'Sublimit allocation within the facility specifically for trade financing products (pre-shipment, post-shipment, import loans), if applicable.',
    `sublimit_guarantee_amount` DECIMAL(18,2) COMMENT 'Sublimit allocation within the facility specifically for bank guarantee issuances, if applicable.',
    `sublimit_lc_amount` DECIMAL(18,2) COMMENT 'Sublimit allocation within the facility specifically for Letter of Credit issuances, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade facility record was last modified.',
    `utilized_amount` DECIMAL(18,2) COMMENT 'Current outstanding utilization amount against the facility limit, representing the sum of all active trade finance instruments drawn under this facility.',
    CONSTRAINT pk_trade_facility PRIMARY KEY(`trade_facility_id`)
) COMMENT 'Master record for approved trade finance credit facilities and sub-limits extended to corporate and institutional clients. Captures facility type (LC issuance line, guarantee line, pre-shipment finance, post-shipment finance, import loan line, trust receipt line, SCF buyer limit, forfaiting line, ECA-backed facility, UPAS line), approved limit amount and currency, sublimit allocations by product type, facility tenor, collateral references, margin/security requirements, utilization amount, available headroom, covenants, review/renewal date, ECA reference and insurance cover details (for export credit facilities), and facility status (proposed, approved, active, suspended, expired, cancelled). Serves as the single credit control master for all trade finance product utilizations against approved limits, supporting Basel III EAD calculation and regulatory capital reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`trade_utilization` (
    `trade_utilization_id` BIGINT COMMENT 'Unique identifier for the trade utilization transaction. Primary key for this entity.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to collateral pledged or assigned to secure this trade utilization, if applicable.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade utilizations in currencies require currency metadata (settlement lag, rounding) for settlement processing, facility headroom calculation, and regulatory reporting (trade finance utilization by c',
    `employee_id` BIGINT COMMENT 'Reference to the user or credit officer who approved this trade utilization transaction.',
    `facility_id` BIGINT COMMENT 'Reference to the parent trade finance facility against which this utilization is drawn.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Trade facility utilizations create journal entries for drawdown, discount/interest accrual, and SCF early payment accounting. Required for supply chain finance and trade facility accounting.',
    `party_id` BIGINT COMMENT 'Reference to the borrower or counterparty utilizing the trade finance facility.',
    `trade_facility_id` BIGINT COMMENT 'Foreign key linking to loan.trade_facility. Business justification: trade_utilization represents drawdowns against trade finance facilities. While it has facility_id pointing to the generic facility parent, it needs trade_facility_id to link to the trade-specific faci',
    `aml_screening_status` STRING COMMENT 'Status of Anti-Money Laundering screening for this trade utilization transaction to ensure compliance with AML regulations and sanctions lists.. Valid values are `pending|cleared|flagged|under_review`',
    `approval_date` DATE COMMENT 'The date on which this trade utilization was approved by the appropriate credit authority or automated system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade utilization record was first created in the system for audit trail purposes.',
    `days_past_due` STRING COMMENT 'The number of days this trade utilization is past its scheduled repayment or maturity date, used for delinquency tracking and NPL classification.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate applied to this utilization, particularly relevant for SCF receivables discounting and forfaiting transactions, expressed as a decimal (e.g., 0.0350 for 3.50%).',
    `ead_amount` DECIMAL(18,2) COMMENT 'The calculated Exposure at Default amount for this trade utilization used for Basel III capital adequacy calculations.',
    `ecl_provision_amount` DECIMAL(18,2) COMMENT 'The Expected Credit Loss provision amount calculated for this trade utilization under IFRS 9 or CECL accounting standards.',
    `facility_headroom_after_utilization` DECIMAL(18,2) COMMENT 'The remaining available commitment amount on the parent facility after this utilization is applied, used for real-time exposure tracking.',
    `ifrs9_stage` STRING COMMENT 'The IFRS 9 stage classification for this trade utilization: Stage 1 (performing, 12-month ECL), Stage 2 (significant increase in credit risk, lifetime ECL), or Stage 3 (credit-impaired, lifetime ECL).. Valid values are `stage_1|stage_2|stage_3`',
    `instrument_reference` STRING COMMENT 'Reference to the underlying trade finance instrument such as LC number, guarantee number, or SCF invoice reference that this utilization is associated with.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The interest rate applicable to this trade utilization for trade loans and other interest-bearing instruments, expressed as a decimal (e.g., 0.0425 for 4.25%).',
    `maturity_date` DATE COMMENT 'The date on which this trade utilization is scheduled to mature and be repaid or settled.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or operational notes related to this trade utilization transaction.',
    `npl_flag` BOOLEAN COMMENT 'Boolean indicator of whether this trade utilization is classified as a Non-Performing Loan under regulatory definitions (typically 90+ days past due).',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'The current outstanding principal balance of this trade utilization after accounting for any repayments or settlements.',
    `product_type` STRING COMMENT 'The specific trade finance product type utilized in this transaction: letter of credit (LC), bank guarantee, trade loan, supply chain finance (SCF) payables finance, SCF receivables discounting, or forfaiting.. Valid values are `letter_of_credit|bank_guarantee|trade_loan|scf_payables_finance|scf_receivables_discounting|forfaiting`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this trade utilization requires inclusion in regulatory reports such as Basel III, CCAR, or DFAST submissions.',
    `repayment_status` STRING COMMENT 'Current repayment status of this trade utilization indicating whether it is outstanding, partially repaid, fully repaid, defaulted, written off, or restructured.. Valid values are `outstanding|partially_repaid|fully_repaid|defaulted|written_off|restructured`',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'The risk weight percentage applied to this trade utilization for Risk-Weighted Assets (RWA) calculation under Basel III, expressed as a percentage (e.g., 75.00 for 75%).',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The calculated Risk-Weighted Assets amount for this trade utilization used for regulatory capital calculations.',
    `scf_approved_amount` DECIMAL(18,2) COMMENT 'For SCF transactions, the amount approved for financing which may be less than the invoice amount due to credit limits or haircuts.',
    `scf_early_payment_date` DATE COMMENT 'For SCF transactions, the date on which early payment was made to the supplier under the SCF program.',
    `scf_invoice_amount` DECIMAL(18,2) COMMENT 'For SCF transactions, the total face value amount of the invoice being financed.',
    `scf_invoice_reference` STRING COMMENT 'For SCF transactions, the reference number of the underlying invoice being financed or discounted.',
    `settlement_status` STRING COMMENT 'Settlement status of the trade utilization transaction indicating whether funds have been disbursed and obligations settled.. Valid values are `pending|settled|partially_settled|cancelled|expired`',
    `swift_message_reference` STRING COMMENT 'Reference to the SWIFT message (e.g., MT700 for LC, MT760 for guarantee) associated with this trade utilization for cross-border transactions.',
    `tenor_days` STRING COMMENT 'The tenor or term of this trade utilization expressed in days from utilization date to maturity date.',
    `ucp_600_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this letter of credit utilization complies with UCP 600 rules for documentary credits.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade utilization record was last modified in the system for audit trail purposes.',
    `urdg_758_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this bank guarantee utilization complies with URDG 758 rules for demand guarantees.',
    `utilization_amount` DECIMAL(18,2) COMMENT 'The principal amount drawn or utilized against the trade finance facility in this transaction.',
    `utilization_date` DATE COMMENT 'The business date on which the trade finance facility was utilized or drawn down.',
    `utilization_reference_number` STRING COMMENT 'Externally-known unique reference number for this trade utilization transaction, used for operational tracking and customer communication.',
    `value_date` DATE COMMENT 'The effective date for interest accrual and accounting purposes, may differ from utilization date for settlement timing.',
    CONSTRAINT pk_trade_utilization PRIMARY KEY(`trade_utilization_id`)
) COMMENT 'Transactional record capturing each drawdown, utilization, or financing event against a trade finance facility, including SCF invoice-level activity. Records utilization date, product type utilized (LC, guarantee, trade loan, SCF payables finance, SCF receivables discounting, forfaiting), transaction reference, underlying instrument reference (LC number, guarantee number, SCF invoice reference), utilization amount and currency, discount rate applied (for SCF), tenor, maturity date, outstanding balance, repayment status, and facility headroom post-utilization. For SCF: captures invoice-level detail including supplier identity, invoice amount, approved amount, early payment date, and settlement status. Provides real-time facility exposure tracking for credit risk management, Basel III EAD calculation, and SCF program utilization monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`forfaiting` (
    `forfaiting_id` BIGINT COMMENT 'Unique identifier for the forfaiting transaction record. Primary key.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the relationship manager responsible for the exporter client relationship and forfaiting transaction.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Forfaiting transactions denominated in currencies require currency metadata (convertibility, settlement lag) for pricing (discount rate calculation), settlement, and regulatory reporting (cross-border',
    `party_id` BIGINT COMMENT 'Identifier of the bank or financial institution providing the aval (guarantee) on the underlying instrument, if applicable.',
    `forfaiting_guarantor_party_id` BIGINT COMMENT 'Identifier of any third-party guarantor providing credit enhancement for the underlying trade receivable.',
    `forfaiting_importer_party_id` BIGINT COMMENT 'Identifier of the importer who is the ultimate obligor on the underlying trade instrument.',
    `forfaiting_party_id` BIGINT COMMENT 'Identifier of the exporter selling the trade receivables to the bank on a without-recourse basis.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Forfaiting fraud (forged instruments, non-existent underlying transactions, guarantor fraud) requires investigation. Fraud cases link to the forfaiting transaction for recourse decisions, secondary ma',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Forfaiting transactions require journal entries for asset derecognition, gain/loss on sale, and secondary market transfers. Required for trade finance asset sale accounting and derecognition complianc',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Forfaiting credit decisions require importer credit rating assessment. Without-recourse forfaiting transfers credit risk, requiring formal rating. Pd/lgd/ead are denormalized rating parameters that sh',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Forfaiting exposed to importer country risk requires country risk ratings, sovereign ratings, sanctions flags for pricing (country risk premium), credit decisioning (aval provider assessment), and reg',
    `investment_portfolio_id` BIGINT COMMENT 'Foreign key linking to treasury.investment_portfolio. Business justification: Forfaiting transactions (purchased trade receivables) are held in treasury investment portfolios for investment portfolio management, yield optimization, and liquidity management.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Forfaiting transactions require sanctions screening of exporter, importer, guarantor, aval provider, and country risk due to cross-border nature and without-recourse structure. Critical compliance che',
    `trade_facility_id` BIGINT COMMENT 'Foreign key linking to loan.trade_facility. Business justification: Forfaiting transactions (bank purchases medium-to-long-term trade receivables) are executed under approved trade finance facilities. The forfaiting.face_value_amount consumes facility capacity. Busine',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Forfaiting transactions require trader attribution for P&L allocation, trading book risk limits, front-office controls, and compensation calculation. relationship_manager_id targets channel domain. Bu',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Forfaiting transactions executed via channels. Essential for secondary market channel tracking, trade finance distribution analytics, and channel profitability measurement in trade finance operations.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Forfaiting transactions where underlying receivables are securitized (e.g., asset-backed commercial paper, receivables-backed notes) require instrument reference for secondary market pricing, risk tra',
    `booking_entity_code` STRING COMMENT 'The legal entity or branch code where the forfaiting transaction is booked for accounting and regulatory reporting purposes.',
    `country_risk_classification` STRING COMMENT 'The country risk rating or classification for the importers country, used in pricing and risk assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forfaiting transaction record was first created in the system.',
    `discount_basis` STRING COMMENT 'The basis for calculating the discount rate (fixed rate, LIBOR plus spread, SOFR plus spread, or EURIBOR plus spread).. Valid values are `fixed_rate|libor_plus_spread|sofr_plus_spread|euribor_plus_spread`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The annual discount rate applied to calculate the purchase price from the face value, reflecting credit risk, country risk, and time value of money.',
    `ecl_amount` DECIMAL(18,2) COMMENT 'The Expected Credit Loss provision amount calculated for the forfaiting asset under IFRS 9 or CECL accounting standards.',
    `exporter_country_code` STRING COMMENT 'Three-letter ISO 3166 country code for the exporters domicile.. Valid values are `^[A-Z]{3}$`',
    `face_value_amount` DECIMAL(18,2) COMMENT 'The nominal or face value amount of the underlying trade receivable being forfaited.',
    `face_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the face value of the underlying instrument.. Valid values are `^[A-Z]{3}$`',
    `guarantee_type` STRING COMMENT 'Type of guarantee or credit enhancement supporting the forfaiting transaction.. Valid values are `bank_guarantee|sovereign_guarantee|export_credit_agency|corporate_guarantee|none`',
    `ifrs9_stage_classification` STRING COMMENT 'The IFRS 9 impairment stage classification (Stage 1: performing, Stage 2: significant increase in credit risk, Stage 3: credit-impaired).. Valid values are `stage_1|stage_2|stage_3`',
    `maturity_date` DATE COMMENT 'The final maturity date of the underlying trade instrument when the face value becomes due from the importer or obligor.',
    `origination_date` DATE COMMENT 'The date on which the forfaiting transaction was originated and the receivable was purchased from the exporter.',
    `payment_terms` STRING COMMENT 'Description of the payment terms and schedule for the underlying trade receivable.',
    `purchase_price_amount` DECIMAL(18,2) COMMENT 'The discounted amount paid by the bank to the exporter for purchasing the trade receivable without recourse.',
    `purchase_price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase price paid to the exporter.. Valid values are `^[A-Z]{3}$`',
    `regulatory_capital_treatment` STRING COMMENT 'Classification of the forfaiting asset for regulatory capital purposes (banking book or trading book).. Valid values are `banking_book|trading_book`',
    `risk_participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of risk retained by the bank if the forfaiting transaction involves risk sharing or syndication.',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'The risk weight percentage applied to the forfaiting exposure for Risk-Weighted Assets (RWA) calculation under Basel III.',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The calculated Risk-Weighted Assets amount for the forfaiting exposure used in capital adequacy calculations.',
    `secondary_market_sale_flag` BOOLEAN COMMENT 'Indicates whether the forfaiting asset has been sold in the secondary market to another forfaiter or investor.',
    `secondary_sale_date` DATE COMMENT 'The date on which the forfaiting asset was sold to another party in the secondary market, if applicable.',
    `secondary_sale_price_amount` DECIMAL(18,2) COMMENT 'The price at which the forfaiting asset was sold in the secondary market.',
    `settlement_date` DATE COMMENT 'The date on which the purchase price was paid to the exporter and the underlying instrument was transferred to the bank.',
    `spread_bps` STRING COMMENT 'The credit spread in basis points added to the benchmark rate to determine the discount rate.',
    `tenor_days` STRING COMMENT 'The number of days from origination to maturity of the underlying trade instrument.',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number for the forfaiting transaction used in correspondence and settlement.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the forfaiting transaction from initial approval through settlement and maturity or secondary sale. [ENUM-REF-CANDIDATE: pending|approved|executed|settled|matured|defaulted|sold — 7 candidates stripped; promote to reference product]',
    `transaction_type` STRING COMMENT 'Classification of the forfaiting transaction as either primary origination (direct purchase from exporter) or secondary market purchase (from another forfaiter).. Valid values are `primary_origination|secondary_market_purchase`',
    `underlying_instrument_reference` STRING COMMENT 'Reference number or identifier of the underlying trade instrument (LC number, promissory note number, bill of exchange number).',
    `underlying_instrument_type` STRING COMMENT 'Type of trade finance instrument being forfaited (promissory note, bill of exchange, deferred payment letter of credit, usance draft, or aval).. Valid values are `promissory_note|bill_of_exchange|deferred_payment_lc|usance_draft|aval`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this forfaiting transaction record was last modified.',
    `without_recourse_flag` BOOLEAN COMMENT 'Confirms that the forfaiting transaction is without recourse to the exporter, meaning the bank assumes all credit and political risk.',
    CONSTRAINT pk_forfaiting PRIMARY KEY(`forfaiting_id`)
) COMMENT 'Master record for forfaiting transactions where the bank purchases medium-to-long-term trade receivables (promissory notes, bills of exchange, deferred payment LCs) from exporters on a without-recourse basis. Captures underlying trade instrument type, face value and currency, discount rate, aval or guarantee details, country risk classification, purchase price, maturity schedule, secondary market sale flag, and transaction status. Supports both primary origination and secondary market forfaiting.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`trade_settlement` (
    `trade_settlement_id` BIGINT COMMENT 'Unique identifier for the trade settlement transaction. Primary key for the trade settlement record.',
    `bank_guarantee_id` BIGINT COMMENT 'Foreign key linking to loan.bank_guarantee. Business justification: When settling a bank guarantee (claim payment, fee collection, commission settlement), this FK links to the specific guarantee record. Business justification: Enables guarantee settlement tracking, cl',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade settlements execute in currencies requiring currency metadata (settlement lag, rounding, convertibility) for nostro/vostro account selection, SWIFT message formatting, and regulatory reporting (',
    `documentary_collection_id` BIGINT COMMENT 'Foreign key linking to loan.documentary_collection. Business justification: When settling a documentary collection (payment to drawer, charge collection, correspondent bank fees), this FK links to the specific collection record. Business justification: Enables collection sett',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who approved this settlement transaction. Null if no approval was required or if approval is pending.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Trade finance settlements generate journal entries for fee income, FX gains/losses, and principal movements. Required for trade finance revenue recognition and nostro/vostro reconciliation.',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Trade finance settlements (LC payments, guarantee claims, collection proceeds) execute through payment instructions. Operational necessity for SWIFT messaging, nostro/vostro reconciliation, and regula',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: trade_settlement captures financial settlement of trade finance obligations. When settling an LC (payment to beneficiary, reimbursement between banks, fee collection), this FK links to the specific LC',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Trade finance settlements execute via nostro accounts for payment processing, reconciliation, and cash management. Essential operational link for trade finance settlement and nostro account management',
    `aml_screening_status` STRING COMMENT 'Status of anti-money laundering screening for this settlement transaction. Not required indicates transaction below screening threshold, pending indicates screening in progress, cleared indicates no issues found, flagged indicates potential match requiring review, under review indicates analyst investigation in progress, and escalated indicates referral to compliance officer or law enforcement.. Valid values are `not_required|pending|cleared|flagged|under_review|escalated`',
    `applicant_account_number` STRING COMMENT 'The account number from which settlement funds are debited or to which charges are posted.',
    `applicant_name` STRING COMMENT 'The name of the party on whose behalf the trade finance instrument was issued and who is ultimately responsible for settlement. For letter of credit this is the importer or buyer, for bank guarantee this is the principal.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this settlement requires supervisory or credit approval before execution, typically for large amounts, waivers, or exception processing.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the settlement transaction was approved. Null if no approval was required or if approval is pending.',
    `beneficiary_account_number` STRING COMMENT 'The account number to which settlement funds are credited. May be an International Bank Account Number (IBAN) for international settlements or domestic account number.',
    `beneficiary_bank_bic` STRING COMMENT 'The SWIFT Bank Identifier Code of the beneficiarys bank where the settlement funds are to be credited.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `beneficiary_name` STRING COMMENT 'The name of the party receiving the settlement funds. For letter of credit settlements this is typically the exporter or seller, for guarantee claim payments this is the beneficiary of the guarantee.',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period for recurring fees such as commitment fees or per diem charges. Null for one-time charges.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period for recurring fees such as commitment fees or per diem charges. Null for one-time charges.',
    `charge_basis` STRING COMMENT 'Method by which the fee or commission is calculated. Flat indicates a fixed amount regardless of transaction size, percentage indicates a rate applied to the principal amount, per diem indicates a daily charge, tiered indicates different rates for different amount bands, minimum indicates a floor charge, maximum indicates a ceiling charge, and sliding scale indicates a progressive rate structure. [ENUM-REF-CANDIDATE: flat|percentage|per_diem|tiered|minimum|maximum|sliding_scale — 7 candidates stripped; promote to reference product]',
    `charge_rate` DECIMAL(18,2) COMMENT 'The percentage rate or basis points applied when charge basis is percentage or per diem. Expressed as a decimal (e.g., 0.015 for 1.5% or 150 basis points).',
    `charge_type` STRING COMMENT 'Specific type of fee or commission being charged for trade finance services. Issuance commission covers letter of credit or guarantee issuance, advising fee covers notification services, confirmation fee covers payment undertaking by confirming bank, amendment fee covers modification charges, discrepancy fee covers document examination when discrepancies are found, acceptance commission covers acceptance of time drafts, negotiation fee covers document negotiation services, guarantee commission covers bank guarantee issuance, handling charge covers administrative processing, SWIFT charge covers messaging costs, courier fee covers physical document delivery, document examination fee covers compliance review, reimbursement fee covers correspondent bank payment processing, transfer fee covers beneficiary change charges, cancellation fee covers early termination, extension fee covers maturity date extension, utilization fee covers facility drawdown, commitment fee covers undrawn facility availability, arrangement fee covers facility structuring, and agency fee covers agent bank services in syndicated trade finance. [ENUM-REF-CANDIDATE: issuance_commission|advising_fee|confirmation_fee|amendment_fee|discrepancy_fee|acceptance_commission|negotiation_fee|guarantee_commission|handling_charge|swift_charge|courier_fee|document_examination_fee|reimbursement_fee|transfer_fee|cancellation_fee|extension_fee|utilization_fee|commitment_fee|arrangement_fee|agency_fee — 20 candidates stripped; promote to reference product]',
    `correspondent_bank_bic` STRING COMMENT 'The SWIFT Bank Identifier Code of the correspondent bank through which the settlement is routed. Eight or eleven character code conforming to ISO 9362 standard.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `cost_center_code` STRING COMMENT 'The organizational cost center responsible for this settlement transaction, used for management accounting and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was first created in the system.',
    `fx_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied for cross-currency settlements, expressed as units of settlement currency per unit of original currency. Null if settlement and original currencies are the same.',
    `fx_rate_date` DATE COMMENT 'The date on which the foreign exchange rate was determined or fixed for this settlement. Null if no currency conversion occurred.',
    `nostro_vostro_account_number` STRING COMMENT 'The correspondent banking account number used for settlement. Nostro refers to the banks account held at a correspondent bank, vostro refers to a correspondent banks account held at this bank.',
    `notes` STRING COMMENT 'Free-text field for recording additional information, special instructions, or operational comments related to this settlement transaction.',
    `original_amount` DECIMAL(18,2) COMMENT 'The monetary amount in the original currency before foreign exchange conversion. Null if no currency conversion occurred.',
    `original_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the original trade finance obligation before any foreign exchange conversion. Null if no currency conversion occurred.. Valid values are `^[A-Z]{3}$`',
    `payment_direction` STRING COMMENT 'Indicates whether the settlement represents funds flowing into the bank (inbound) or out of the bank (outbound) from the banks perspective.. Valid values are `inbound|outbound`',
    `profit_center_code` STRING COMMENT 'The organizational profit center to which revenue from this settlement is attributed for performance measurement and reporting.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this settlement transaction must be included in regulatory reports such as Currency Transaction Reports (CTR), Suspicious Activity Reports (SAR), or cross-border payment reporting under Bank Secrecy Act (BSA) or Foreign Account Tax Compliance Act (FATCA).',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which the fee or commission revenue is recognized in the general ledger, following revenue recognition principles under IFRS 15 or ASC 606.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The monetary amount being settled in the settlement currency. This is the gross amount before any deductions or adjustments.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the settlement is denominated and executed.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'The date on which the settlement transaction is executed and recorded in the banks books. This is the accounting date for the settlement.',
    `settlement_line_type` STRING COMMENT 'Classification of the settlement line indicating the nature of the financial obligation being settled. Principal represents the core trade finance amount, fee covers service charges, commission covers intermediary compensation, reimbursement covers correspondent bank payments, interest covers financing charges, penalty covers late payment charges, discount covers early payment discounts, advance covers upfront payments, repayment covers loan principal returns, claim payment covers guarantee claim settlements, and forfaiting proceeds cover discounted receivable purchases. [ENUM-REF-CANDIDATE: principal|fee|commission|reimbursement|interest|penalty|discount|advance|repayment|claim_payment|forfaiting_proceeds — 11 candidates stripped; promote to reference product]',
    `settlement_method` STRING COMMENT 'The mechanism or payment system used to execute the settlement. Real-Time Gross Settlement (RTGS) for immediate large-value transfers, SWIFT for international messaging and settlement, Automated Clearing House (ACH) for batch processing, book transfer for internal account movements, check for paper-based settlement, draft for negotiable instruments, wire transfer for electronic funds transfer, correspondent banking for cross-border settlements through intermediary banks, TARGET2 for European Central Bank settlements, Clearing House Automated Payment System (CHAPS) for UK sterling settlements, and Fedwire for US Federal Reserve settlements. [ENUM-REF-CANDIDATE: RTGS|SWIFT|ACH|book_transfer|check|draft|wire_transfer|correspondent_banking|TARGET2|CHAPS|Fedwire — 11 candidates stripped; promote to reference product]',
    `settlement_reference_number` STRING COMMENT 'Externally visible unique reference number for this settlement transaction, used for reconciliation and customer communication.',
    `settlement_status` STRING COMMENT 'Current processing status of the settlement transaction. Pending indicates awaiting initiation, initiated indicates instruction sent, in transit indicates payment in correspondent banking chain, processed indicates funds debited/credited, completed indicates settlement finalized, failed indicates unsuccessful execution, rejected indicates validation failure, cancelled indicates user-initiated cancellation, reversed indicates reversal of completed settlement, reconciled indicates matched with bank statement, and under investigation indicates exception handling in progress. [ENUM-REF-CANDIDATE: pending|initiated|in_transit|processed|completed|failed|rejected|cancelled|reversed|reconciled|under_investigation — 11 candidates stripped; promote to reference product]',
    `settlement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the settlement transaction was executed and recorded in the system.',
    `swift_message_reference` STRING COMMENT 'The unique SWIFT message reference number (field 20 in SWIFT messages) that identifies the payment instruction or confirmation message associated with this settlement.',
    `swift_message_type` STRING COMMENT 'The SWIFT message type used for settlement instruction or confirmation. MT103 for customer credit transfers, MT202 for bank-to-bank transfers, MT700 for letter of credit issuance, MT710 for advising of a third bank letter of credit, MT720 for transfer of a letter of credit, MT760 for guarantee issuance, MT799 for free format message, MT999 for proprietary message. [ENUM-REF-CANDIDATE: MT103|MT202|MT700|MT710|MT720|MT760|MT799|MT999 — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was last modified in the system.',
    `value_date` DATE COMMENT 'The date on which funds become available to the beneficiary or are debited from the payer account. May differ from settlement date due to processing time or forward-dated instructions.',
    `waived_amount` DECIMAL(18,2) COMMENT 'The monetary amount of fees or charges that have been waived. Null or zero if no waiver was granted.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether any portion of the fee or charge has been waived by the bank as a commercial concession or relationship management decision.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving fees or charges, such as relationship pricing, service recovery, competitive match, or promotional offer.',
    CONSTRAINT pk_trade_settlement PRIMARY KEY(`trade_settlement_id`)
) COMMENT 'Transactional record capturing the financial settlement of trade finance obligations including all associated fees, commissions, and charges. Covers LC honour/negotiation payments, collection proceeds, guarantee claim payments, trade loan disbursements/repayments, SCF early payments, and forfaiting purchase price settlements. Records settlement line type (principal, fee, commission, reimbursement), charge type (issuance commission, advising fee, confirmation fee, amendment fee, discrepancy fee, acceptance commission, negotiation fee, guarantee commission, handling charge), charge basis (flat, percentage, per diem), settlement date, value date, settlement amount and currency, FX rate applied for cross-currency settlements, nostro/vostro account used, correspondent bank BIC, SWIFT message reference (MT202/MT103), settlement method (RTGS, SWIFT, book transfer), waiver flag, revenue recognition date, billing period, collection status, and settlement status (pending, processed, failed, reconciled). Serves as the single financial record for both settlement execution and fee/charge management. Links to the payment domain for actual fund movement execution.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`compliance_check` (
    `compliance_check_id` BIGINT COMMENT 'Primary key for compliance_check',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: UCP/URDG compliance checks that identify material discrepancies may escalate to AML cases when discrepancies suggest fraud, sanctions evasion, or documentary manipulation. Links trade finance complian',
    `document_presentation_id` BIGINT COMMENT 'Reference to the specific document presentation event that triggered this compliance examination.',
    `documentary_collection_id` BIGINT COMMENT 'Foreign key linking to loan.documentary_collection. Business justification: URC 522 compliance examination is performed on document presentations under Documentary Collections. The compliance_check product records examination results for collections as well as LCs. One compli',
    `employee_id` BIGINT COMMENT 'Identifier of the trade finance operations officer or compliance specialist who performed the examination.',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: UCP 600 compliance examination is performed on document presentations under Letters of Credit. The compliance_check product records the examination results, discrepancies, and waiver decisions. The tr',
    `trade_finance_transaction_id` BIGINT COMMENT 'Reference to the underlying trade finance transaction (letter of credit, guarantee, collection) being examined for compliance.',
    `advising_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the advising or confirming bank that is examining the documents on behalf of the issuing bank.',
    `applicant_name` STRING COMMENT 'Name of the applicant (importer or buyer) who requested the issuance of the letter of credit or guarantee.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this compliance check to the broader audit trail for regulatory examination and internal quality assurance purposes.',
    `beneficiary_name` STRING COMMENT 'Name of the beneficiary (exporter or service provider) presenting the documents for payment or acceptance under the trade finance instrument.',
    `compliance_result` STRING COMMENT 'Overall outcome of the compliance examination: compliant (documents conform to terms and conditions), discrepant (one or more discrepancies identified), conditional (compliant subject to issuer waiver), pending_review (examination incomplete), waived (discrepancies waived by applicant or issuing bank).. Valid values are `compliant|discrepant|conditional|pending_review|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this compliance check record was first created in the trade finance system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total amount of the underlying letter of credit, guarantee, or collection being examined for compliance.',
    `credit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the underlying trade finance instrument (e.g., USD, EUR, GBP, JPY).',
    `discrepancy_codes` STRING COMMENT 'Comma-separated list of standardized discrepancy codes identified during examination (e.g., D01 for late presentation, D02 for document inconsistency, D03 for missing document, D04 for expired credit). Codes align with ICC ISBP 745 and internal trade finance standards.',
    `discrepancy_count` STRING COMMENT 'Total number of discrepancies identified during the examination. Zero indicates compliant presentation.',
    `discrepancy_descriptions` STRING COMMENT 'Detailed narrative descriptions of each discrepancy identified, providing business context for the compliance failure. Multiple discrepancies are separated by semicolons.',
    `document_count` STRING COMMENT 'Total number of individual documents included in the presentation being examined.',
    `document_type` STRING COMMENT 'Type of trade finance document being examined (e.g., commercial invoice, bill of lading, insurance certificate, certificate of origin, packing list, inspection certificate). Multiple document types may be examined in a single presentation.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this compliance check was escalated to senior management, legal counsel, or compliance committee due to complexity, materiality, or regulatory sensitivity.',
    `escalation_reason` STRING COMMENT 'Explanation of why the compliance check was escalated, including references to specific discrepancies, legal concerns, or regulatory requirements.',
    `examination_completion_date` DATE COMMENT 'Date on which the compliance examination was finalized and the result communicated to the presenting bank or beneficiary.',
    `examination_date` DATE COMMENT 'The calendar date on which the compliance examination was performed.',
    `examination_status` STRING COMMENT 'Current workflow status of the compliance examination: in_progress (examination underway), completed (examination finalized), suspended (temporarily halted pending additional information), cancelled (examination voided), escalated (referred to senior compliance officer or legal).. Valid values are `in_progress|completed|suspended|cancelled|escalated`',
    `examination_timestamp` TIMESTAMP COMMENT 'Precise date and time when the compliance examination was initiated, used for turnaround time calculation against the 5-banking-day UCP 600 standard.',
    `examination_turnaround_banking_days` DECIMAL(18,2) COMMENT 'Total elapsed time in banking days from document presentation receipt to examination completion. UCP 600 Article 14(b) mandates a maximum of 5 banking days for examination.',
    `examination_turnaround_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from document presentation receipt to examination completion, measured against the UCP 600 5-banking-day standard (maximum 120 banking hours).',
    `examiner_name` STRING COMMENT 'Full name of the examiner who conducted the compliance check, for audit trail and accountability purposes.',
    `examiner_notes` STRING COMMENT 'Free-text notes and observations recorded by the examiner during the compliance check, providing additional context for audit and quality review.',
    `issuing_bank_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the issuing bank that opened the letter of credit or issued the guarantee being examined.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this compliance check record was last updated, supporting audit trail and data lineage requirements.',
    `presentation_receipt_date` DATE COMMENT 'Date on which the document presentation was received by the examining bank, marking the start of the 5-banking-day examination period.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for this compliance examination, used for audit trails and regulatory reporting.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this compliance check must be included in regulatory reporting to supervisory authorities (e.g., Federal Reserve, OCC, EBA) or ICC compliance audits.',
    `rule_set_framework` STRING COMMENT 'The International Chamber of Commerce (ICC) rule set framework applied for this examination (UCP 600 for documentary credits, eUCP v2.0 for electronic presentation, ISBP 745 for standard banking practice, URDG 758 for demand guarantees, URC 522 for collections, ISP98 for standby letters of credit, URR 725 for bank-to-bank reimbursements).. Valid values are `UCP 600|eUCP 2.0|URDG 758|URC 522|ISBP 745|ISP98|URR 725`',
    `rule_set_version` STRING COMMENT 'Specific version identifier of the ICC rule set applied (e.g., UCP 600 2007 Revision, eUCP Version 2.0, URDG 758 2010 Revision), ensuring compliance examination is performed against the correct regulatory version.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the examination was completed within the UCP 600 5-banking-day service level agreement. True if turnaround is within SLA, false if exceeded.',
    `waiver_approval_date` DATE COMMENT 'Date on which the waiver was approved or rejected by the applicant or issuing bank.',
    `waiver_approval_status` STRING COMMENT 'Current status of the waiver request: pending (awaiting response), approved (applicant/issuer accepted discrepancies), rejected (applicant/issuer refused waiver), expired (no response within allowed timeframe), not_applicable (no waiver requested).. Valid values are `pending|approved|rejected|expired|not_applicable`',
    `waiver_request_date` DATE COMMENT 'Date on which the waiver request was sent to the applicant or issuing bank for discrepancy acceptance.',
    `waiver_request_flag` BOOLEAN COMMENT 'Indicates whether a waiver request was submitted to the applicant or issuing bank to accept the discrepant presentation despite identified discrepancies.',
    CONSTRAINT pk_compliance_check PRIMARY KEY(`compliance_check_id`)
) COMMENT 'Operational record of UCP 600 / URDG 758 / URC 522 compliance examination results for each document presentation or transaction event. Captures examination date, examiner identifier, rule set version applied (UCP 600, eUCP v2.0, ISBP 745, URDG 758, URC 522), compliance result (compliant, discrepant), list of discrepancy codes and descriptions, waiver request flag, waiver approval status, and examination turnaround time against the 5-banking-day UCP 600 standard. Supports regulatory audit and ICC compliance reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`sanctions_screening` (
    `sanctions_screening_id` BIGINT COMMENT 'Primary key for sanctions_screening',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Trade finance sanctions screening hits escalate to AML cases for investigation, disposition, and SAR filing decisions. Links sanctions screening events to case management workflow for regulatory repor',
    `bank_guarantee_id` BIGINT COMMENT 'Foreign key linking to loan.bank_guarantee. Business justification: Sanctions screening is performed on Bank Guarantee transactions to screen beneficiaries and applicants against sanctions lists. One screening record belongs to one guarantee (1:N from bank_guarantee t',
    `documentary_collection_id` BIGINT COMMENT 'Foreign key linking to loan.documentary_collection. Business justification: Sanctions screening is also performed on Documentary Collections to ensure parties (drawer, drawee) are not on sanctions lists. One screening record belongs to one documentary collection (1:N from doc',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance analyst assigned to review the sanctions screening alert.',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: Sanctions screening (OFAC, UN, EU, HMT) is performed on all Letter of Credit transactions to ensure compliance with trade finance regulations. The trade_finance_transaction_id column is generic/polymo',
    `trade_finance_transaction_id` BIGINT COMMENT 'Reference to the underlying trade finance transaction (letter of credit, documentary collection, bank guarantee, or other trade finance instrument) that was screened.',
    `analyst_review_status` STRING COMMENT 'Current status of the analyst review process for potential or confirmed matches. Tracks the workflow state of the screening alert.. Valid values are `pending_review|under_review|reviewed|escalated|closed`',
    `blocked_funds_amount` DECIMAL(18,2) COMMENT 'Monetary value of funds or assets blocked as a result of the sanctions screening. Populated only when a transaction is blocked.',
    `blocked_funds_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the blocked funds amount.. Valid values are `^[A-Z]{3}$`',
    `comments` STRING COMMENT 'Free-text field for compliance analysts to document additional observations, analysis, or context related to the sanctions screening event.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening record was first created in the system. Used for audit trail and data lineage.',
    `disposition` STRING COMMENT 'Final decision made by the compliance analyst regarding the sanctions screening alert. Determines whether the transaction is allowed to proceed, blocked, or escalated for further review.. Valid values are `cleared|blocked|escalated|rejected|approved_with_conditions`',
    `disposition_reason` STRING COMMENT 'Detailed explanation of the rationale behind the disposition decision, including supporting evidence and analysis performed by the compliance analyst.',
    `escalation_level` STRING COMMENT 'Level to which the sanctions screening alert was escalated for decision-making. Reflects the severity and complexity of the potential sanctions violation.. Valid values are `none|compliance_manager|mlro|senior_management|legal|board`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening alert was escalated to a higher authority for review and decision.',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether the screening alert was determined to be a false positive after analyst review. Used for system tuning and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening record was last updated. Tracks changes throughout the review and disposition lifecycle.',
    `match_result` STRING COMMENT 'Outcome of the sanctions screening indicating whether the entity was cleared, flagged as a potential match, or confirmed as a match against sanctions lists.. Valid values are `clear|potential_match|confirmed_match|false_positive`',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the confidence level of the match between the screened entity and a sanctions list entry. Higher scores indicate stronger matches.',
    `matched_list_entry` STRING COMMENT 'Name or identifier of the sanctions list entry that matched the screened entity. Populated only when a potential or confirmed match is identified.',
    `matched_list_source` STRING COMMENT 'Source of the sanctions list that produced the match. Identifies the governing body or jurisdiction of the matched entry.. Valid values are `OFAC_SDN|UN_CONSOLIDATED|EU_SANCTIONS|HMT_SANCTIONS|INTERPOL|NATIONAL_LIST`',
    `ofac_notification_date` DATE COMMENT 'Date when OFAC was notified of the sanctions screening event. Required for blocked transactions and confirmed matches.',
    `ofac_notification_flag` BOOLEAN COMMENT 'Indicates whether OFAC was directly notified of a confirmed sanctions match or blocked transaction as required by OFAC regulations.',
    `override_authorized_by` BIGINT COMMENT 'Identifier of the senior compliance officer or authorized user who approved the override decision.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether the screening result or disposition was manually overridden by an authorized user. Requires strong justification and audit trail.',
    `override_reason` STRING COMMENT 'Detailed explanation of why the screening result or disposition was overridden, including supporting documentation and authorization.',
    `override_timestamp` TIMESTAMP COMMENT 'Date and time when the override was authorized and applied.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this sanctions screening event requires regulatory reporting such as filing a Suspicious Activity Report (SAR) or notifying OFAC.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the analyst completed the review and made a disposition decision.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Date and time when the analyst began reviewing the sanctions screening alert.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the sanctions screening event based on match score, entity type, jurisdiction, and other risk factors.. Valid values are `low|medium|high|critical`',
    `sar_filing_date` DATE COMMENT 'Date when the Suspicious Activity Report was filed with FinCEN. Critical for regulatory compliance tracking.',
    `sar_filing_reference` STRING COMMENT 'Reference number of the Suspicious Activity Report filed with FinCEN as a result of this sanctions screening event. Populated only when a SAR is filed.',
    `screened_entity_identifier` STRING COMMENT 'Unique identifier for the screened entity such as IMO number for vessels, tax ID for companies, or passport number for individuals.',
    `screened_entity_name` STRING COMMENT 'Name or identifier of the entity that was screened against sanctions lists. May be a company name, vessel name, individual name, or geographic location.',
    `screened_entity_type` STRING COMMENT 'Type of entity subjected to sanctions screening in the trade finance transaction. Identifies whether the screening was performed on a counterparty, vessel, goods, geographic location, or financial institution. [ENUM-REF-CANDIDATE: counterparty|vessel|goods|country|beneficiary|applicant|issuing_bank|advising_bank|confirming_bank|port_of_loading|port_of_discharge — 11 candidates stripped; promote to reference product]',
    `screening_algorithm_version` STRING COMMENT 'Version of the screening algorithm or matching logic used by the sanctions screening system. Important for audit and quality assurance.',
    `screening_list_applied` STRING COMMENT 'Comma-separated list of sanctions lists applied during screening. May include OFAC SDN, UN Security Council, EU Sanctions, HMT Sanctions, and other jurisdictional lists.',
    `screening_list_version` STRING COMMENT 'Version or effective date of the sanctions lists used during screening. Critical for audit trail and demonstrating use of current lists.',
    `screening_reference_number` STRING COMMENT 'Business identifier for the sanctions screening event, used for audit trail and regulatory reporting.',
    `screening_system_code` STRING COMMENT 'Identifier of the sanctions screening system or platform used to perform the screening (e.g., NICE Actimize, Oracle Financial Crime, World-Check).',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening was performed. Critical for regulatory compliance and audit trail.',
    `transaction_blocked_flag` BOOLEAN COMMENT 'Indicates whether the trade finance transaction was blocked as a result of the sanctions screening. Blocked transactions must be reported to OFAC.',
    CONSTRAINT pk_sanctions_screening PRIMARY KEY(`sanctions_screening_id`)
) COMMENT 'Operational record of OFAC, UN, EU, and HMT sanctions screening results performed on trade finance transactions, counterparties, vessels, and goods. Captures screening date and time, screened entity type (counterparty, vessel, goods, country), screening list(s) applied, match result (clear, potential match, confirmed match), match score, analyst review status, disposition (cleared, blocked, escalated), and regulatory reporting obligation flag. Mandatory for BSA/AML compliance and OFAC regulatory requirements on trade finance.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`trade_event` (
    `trade_event_id` BIGINT COMMENT 'Unique identifier for the trade finance event record. Primary key for the trade event log.',
    `bank_guarantee_id` BIGINT COMMENT 'Foreign key linking to loan.bank_guarantee. Business justification: When trade_event relates to a bank guarantee (issuance, claim, payment, expiry), this FK links to the specific guarantee record. Business justification: Enables guarantee lifecycle tracking, claim eve',
    `created_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or automated process that created this event record in the trade finance system.',
    `documentary_collection_id` BIGINT COMMENT 'Foreign key linking to loan.documentary_collection. Business justification: When trade_event relates to a documentary collection (presentation, acceptance, payment, dishonor), this FK links to the specific collection record. Business justification: Enables collection lifecycl',
    `employee_id` BIGINT COMMENT 'Reference to the bank officer or examiner who reviewed and processed the trade finance documents or event, where applicable for examination and compliance events.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or automated process that last modified this event record in the trade finance system.',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: trade_event tracks lifecycle events and SWIFT messages for trade finance instruments. When the event relates to an LC (issuance, amendment, drawing, expiry), this FK links to the specific LC record. B',
    `linked_event_trade_event_id` BIGINT COMMENT 'Reference to a related or parent trade finance event, enabling event chain tracking for amendments, waivers, and multi-step processes.',
    `instrument_id` BIGINT COMMENT 'Reference to the underlying trade finance instrument (letter of credit, guarantee, collection, supply chain finance, forfaiting) that this event pertains to.',
    `party_id` BIGINT COMMENT 'Reference to the party (bank, customer, beneficiary, correspondent) that initiated or triggered this trade finance event.',
    `acknowledgement_status` STRING COMMENT 'The status of the SWIFT message acknowledgement, indicating whether the message was successfully received and acknowledged by the counterparty.. Valid values are `pending|acknowledged|rejected|failed|timeout`',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'The date and time when the SWIFT message acknowledgement was received from the counterparty institution.',
    `aml_screening_status` STRING COMMENT 'The status of anti-money laundering and sanctions screening for this trade finance event, ensuring compliance with financial crime prevention requirements.. Valid values are `pending|cleared|flagged|under_review|escalated`',
    `amount` DECIMAL(18,2) COMMENT 'The monetary amount associated with this trade finance event, such as payment amount, claim amount, or amendment value. Null for non-monetary events.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether this event requires additional compliance review by the banks trade finance compliance team before processing can continue.',
    `created_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this event record was first created in the trade finance system. Distinct from the business event timestamp.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the amount associated with this event. Null for non-monetary events.. Valid values are `^[A-Z]{3}$`',
    `data_classification` STRING COMMENT 'The data classification level assigned to this trade finance event record, governing access controls and information security handling requirements.. Valid values are `restricted|confidential|internal|public`',
    `discrepancy_details` STRING COMMENT 'Detailed description of any discrepancies identified during document examination, including specific document defects and non-compliance with credit terms.',
    `document_reference_numbers` STRING COMMENT 'Comma-separated list of document reference numbers associated with this event, such as bill of lading numbers, invoice numbers, or certificate numbers presented or examined.',
    `event_description` STRING COMMENT 'Detailed narrative description of the trade finance event, capturing business context, actions taken, and any relevant operational notes.',
    `event_reference_number` STRING COMMENT 'Business-assigned unique reference number for this trade finance event, used for operational tracking and audit trail purposes.',
    `event_sequence_number` STRING COMMENT 'Sequential numbering of events within the lifecycle of a single trade finance instrument, providing chronological ordering for audit trail reconstruction.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the trade finance event occurred in the business process. This is the business event time, distinct from system audit timestamps.',
    `event_type` STRING COMMENT 'Classification of the trade finance lifecycle event. Defines the nature of the business action or milestone recorded in this event. [ENUM-REF-CANDIDATE: issuance|advising|confirmation|amendment|presentation|examination|acceptance|honour|negotiation|payment|discrepancy|waiver|expiry|cancellation|claim|extension|reduction|transfer — 18 candidates stripped; promote to reference product]',
    `examination_result` STRING COMMENT 'The outcome of the document examination process for presentation events, indicating whether documents comply with letter of credit terms or contain discrepancies.. Valid values are `compliant|discrepant|waived|pending_review`',
    `external_reference` STRING COMMENT 'External reference number or identifier provided by the counterparty or customer, used for cross-referencing with external systems and correspondence.',
    `internal_notes` STRING COMMENT 'Confidential internal notes and comments recorded by bank staff regarding this trade finance event, for operational context and decision rationale.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this event record was last updated or modified in the trade finance system.',
    `message_direction` STRING COMMENT 'Indicates whether the SWIFT message associated with this event was received by the bank (inbound) or sent by the bank (outbound).. Valid values are `inbound|outbound`',
    `new_status` STRING COMMENT 'The status of the trade finance instrument after this event was processed. Captures the resulting state following the event action. [ENUM-REF-CANDIDATE: draft|issued|advised|confirmed|amended|presented|under_examination|accepted|honoured|paid|discrepant|expired|cancelled|closed — 14 candidates stripped; promote to reference product]',
    `prior_status` STRING COMMENT 'The status of the trade finance instrument immediately before this event occurred. Provides state transition context for audit and reconciliation. [ENUM-REF-CANDIDATE: draft|issued|advised|confirmed|amended|presented|under_examination|accepted|honoured|paid|discrepant|expired|cancelled|closed — 14 candidates stripped; promote to reference product]',
    `processing_channel` STRING COMMENT 'The communication channel or platform through which this trade finance event was processed and communicated between parties.. Valid values are `swift|telex|courier|electronic_platform|manual|correspondent_network`',
    `receiver_bic` STRING COMMENT 'The Bank Identifier Code of the financial institution that received the SWIFT message associated with this event. 8 or 11 character ISO 9362 format.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this trade finance event requires regulatory reporting to supervisory authorities or central banks under trade finance monitoring requirements.',
    `sender_bic` STRING COMMENT 'The Bank Identifier Code of the financial institution that sent the SWIFT message associated with this event. 8 or 11 character ISO 9362 format.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `source_system_code` STRING COMMENT 'Identifier of the source system or platform that originated this trade finance event record, supporting data lineage and reconciliation across multiple trade finance platforms.',
    `swift_message_reference` STRING COMMENT 'The unique SWIFT message reference number (field 20) that identifies the specific message transmission associated with this trade finance event.',
    `swift_message_type` STRING COMMENT 'The SWIFT message type code associated with this trade finance event, identifying the specific message format used for interbank communication. [ENUM-REF-CANDIDATE: MT700|MT707|MT710|MT720|MT730|MT740|MT750|MT752|MT754|MT756|MT760|MT767|MT768|MT400|MT410|MT412|MT416|MT420|MT422|MT430 — 20 candidates stripped; promote to reference product]',
    `transmission_timestamp` TIMESTAMP COMMENT 'The date and time when the SWIFT message was transmitted through the SWIFT network. Distinct from the business event timestamp.',
    `triggering_party_role` STRING COMMENT 'The functional role of the party that triggered this event within the trade finance transaction lifecycle. [ENUM-REF-CANDIDATE: issuing_bank|advising_bank|confirming_bank|applicant|beneficiary|nominated_bank|reimbursing_bank|presenting_bank|examiner — 9 candidates stripped; promote to reference product]',
    `value_date` DATE COMMENT 'The effective date for financial settlement or value transfer associated with this event, particularly relevant for payment and honour events.',
    CONSTRAINT pk_trade_event PRIMARY KEY(`trade_event_id`)
) COMMENT 'Chronological event and messaging log capturing all significant lifecycle events and associated SWIFT communications across trade finance instruments (LCs, guarantees, collections, SCF, forfaiting). Records event type (issuance, advising, confirmation, amendment, presentation, examination, acceptance, honour, negotiation, payment, discrepancy, waiver, expiry, cancellation, claim, extension, reduction, transfer), event timestamp, triggering party, event description, prior and new status, SWIFT message type (MT700/707/710/720/730/740/750/752/754/756/760/767/768/400/410/412/416/420/422/430), sender and receiver BIC, message reference, message direction (inbound/outbound), transmission timestamp, acknowledgement status, processing channel, and examiner identifier where applicable. Provides the single unified audit trail required for regulatory examination, dispute resolution, and SWIFT messaging reconciliation.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`guarantee` (
    `guarantee_id` BIGINT COMMENT 'Unique identifier for the loan guarantee record. Primary key for the guarantee entity.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the bank employee responsible for managing the relationship with the guarantor. Used for accountability and performance tracking.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Guarantees with coverage in currencies require currency metadata (rounding, minor unit) for enforceability assessment, call processing, capital relief calculation (RWA reduction), and regulatory repor',
    `facility_id` BIGINT COMMENT 'Reference to the credit facility that this guarantee supports. Used when guarantee covers a revolving or multi-draw facility rather than a single loan.',
    `party_id` BIGINT COMMENT 'FK to customer.party',
    `guarantee_party_id` BIGINT COMMENT 'Reference to the party providing the guarantee. May be an individual, corporation, or government entity.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Guarantee credit risk mitigation depends on guarantor creditworthiness. Regulatory capital relief calculations require guarantor ratings. Guarantor_credit_rating/internal_rating/pd/lgd are denormalize',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account that this guarantee secures. Links the guarantee to the underlying credit exposure.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Blocked investment accounts and cash collateral portfolios serve as guarantee instruments for credit facilities. Guarantee enforceability assessment requires portfolio valuation, collateral coverage r',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Guarantees collateralized by securities (e.g., standby LCs backed by bond portfolios, cash-collateralized guarantees held in money market funds) require instrument tracking for collateral adequacy mon',
    `parent_guarantee_id` BIGINT COMMENT 'Self-referencing FK on guarantee (parent_guarantee_id)',
    `amendment_count` STRING COMMENT 'Number of amendments made to the original guarantee agreement. Tracks the modification history and may affect enforceability assessment.',
    `call_amount` DECIMAL(18,2) COMMENT 'Monetary amount demanded from the guarantor upon calling the guarantee. May be less than the full coverage amount depending on the outstanding loan balance and guarantee terms.',
    `call_date` DATE COMMENT 'Date on which the bank formally demanded payment from the guarantor due to borrower default. Triggers the guarantors obligation to perform.',
    `capital_relief_amount` DECIMAL(18,2) COMMENT 'Reduction in Risk-Weighted Assets (RWA) achieved through the guarantee. Calculated based on the difference between the borrowers and guarantors risk weights.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount that the guarantor is obligated to pay under the guarantee. Used to calculate Loss Given Default (LGD) and regulatory capital relief.',
    `coverage_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the guarantee coverage amount. Required for foreign exchange risk assessment and cross-border guarantee valuation.. Valid values are `^[A-Z]{3}$`',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the loan exposure covered by the guarantee. Used to calculate partial credit risk mitigation for regulatory capital and Expected Credit Loss (ECL) purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantee record was first created in the system. Used for audit trail and data lineage purposes.',
    `cross_default_clause_flag` BOOLEAN COMMENT 'Indicates whether the guarantee includes a cross-default provision that triggers the guarantee if the borrower defaults on other obligations. Strengthens credit risk mitigation.',
    `data_classification` STRING COMMENT 'Sensitivity classification of the guarantee record. Determines access controls, encryption requirements, and data handling procedures.. Valid values are `restricted|confidential|internal|public`',
    `documentation_type` STRING COMMENT 'Legal form of the guarantee documentation. Determines the legal framework, enforceability standards, and regulatory capital treatment.. Valid values are `standalone|master_agreement|letter_of_credit|bank_guarantee|insurance_policy|parent_guarantee`',
    `ecl_adjustment_amount` DECIMAL(18,2) COMMENT 'Reduction in Expected Credit Loss provision due to the guarantee. Calculated based on the guarantors creditworthiness and coverage amount under IFRS 9 or CECL.',
    `effective_date` DATE COMMENT 'Date on which the guarantee becomes legally binding and enforceable. Determines when credit risk mitigation can be recognized for regulatory capital purposes.',
    `enforceability_opinion_date` DATE COMMENT 'Date of the most recent legal opinion confirming the enforceability of the guarantee. Basel III requires periodic legal review of credit risk mitigation instruments.',
    `enforceability_status` STRING COMMENT 'Legal assessment of whether the guarantee can be enforced in the relevant jurisdiction. Only enforceable guarantees qualify for regulatory capital relief under Basel III.. Valid values are `enforceable|unenforceable|under_review|disputed|conditionally_enforceable`',
    `expiry_date` DATE COMMENT 'Date on which the guarantee obligation terminates. After this date, the guarantee no longer provides credit risk mitigation unless renewed or extended.',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the guarantee. Critical for enforceability assessment and regulatory capital treatment.',
    `guarantee_status` STRING COMMENT 'Current lifecycle state of the guarantee. Determines whether the guarantee provides credit risk mitigation for regulatory capital purposes.. Valid values are `active|expired|called|released|suspended|cancelled`',
    `guarantee_type` STRING COMMENT 'Legal structure of the guarantee obligation. Defines the extent and conditions of the guarantors liability.. Valid values are `full|partial|limited|unlimited|joint_and_several|conditional`',
    `guarantor_type` STRING COMMENT 'Classification of the guarantor entity. Determines credit risk treatment, regulatory capital calculation, and enforceability considerations. [ENUM-REF-CANDIDATE: personal|corporate|government|bank|insurance_company|parent_company|third_party — 7 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date on which the guarantee document was executed and issued. May differ from effective date if the guarantee has a future start date.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the guarantee terms. Triggers the need for updated legal enforceability review.',
    `legal_documentation_reference` STRING COMMENT 'Reference to the physical or electronic location of the executed guarantee document. Required for audit, regulatory examination, and enforceability verification.',
    `payment_received_amount` DECIMAL(18,2) COMMENT 'Actual monetary amount received from the guarantor. Used to calculate recovery rates and reduce net credit losses.',
    `payment_received_date` DATE COMMENT 'Date on which payment was received from the guarantor after the guarantee was called. Used to calculate recovery rates and actual Loss Given Default (LGD).',
    `reference_number` STRING COMMENT 'External business identifier for the guarantee. Used in legal documentation, correspondence, and regulatory reporting.',
    `regulatory_capital_relief_flag` BOOLEAN COMMENT 'Indicates whether the guarantee meets Basel III criteria for regulatory capital relief. Requires enforceability, guarantor creditworthiness, and proper documentation.',
    `rwa_after_guarantee` DECIMAL(18,2) COMMENT 'Risk-Weighted Assets of the loan exposure after applying the guarantee credit risk mitigation. Reflects the substitution of the guarantors risk weight.',
    `rwa_before_guarantee` DECIMAL(18,2) COMMENT 'Risk-Weighted Assets of the loan exposure before applying the guarantee credit risk mitigation. Used to calculate the capital relief benefit.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the guarantee terms permit the guarantor to be replaced with another party. Affects the permanence of credit risk mitigation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the guarantee record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    CONSTRAINT pk_guarantee PRIMARY KEY(`guarantee_id`)
) COMMENT 'Master record for loan guarantees provided by third parties (personal guarantees, corporate guarantees, government guarantees). Captures guarantor, guarantee type, coverage amount, expiry date, and enforceability status.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`disbursement` (
    `disbursement_id` BIGINT COMMENT 'Unique identifier for the loan disbursement event. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Disbursements execute in currencies requiring currency metadata (settlement lag, rounding, convertibility) for payment instruction formatting (SWIFT), nostro/vostro account selection, settlement timin',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Loan proceeds disbursement process: funds are credited to borrowers deposit account. Existing destination_account_number is denormalized; FK enables automated disbursement processing, regulatory repo',
    `drawdown_id` BIGINT COMMENT 'Reference to the facility drawdown event that triggered this disbursement. Nullable for non-facility loans.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or officer who authorized the disbursement.',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Disbursement transactions trigger fraud alerts (misdirected funds, account takeover, unauthorized disbursements). Linking disbursement to alert enables real-time fraud prevention, reversal decisions, ',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry created in the general ledger for this disbursement.',
    `instruction_id` BIGINT COMMENT 'Unique identifier for the payment instruction sent to the payment processing system.',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account for which funds are being disbursed.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Loan disbursements settle through nostro accounts for payment execution, nostro reconciliation, and cash management. Standard banking operations link disbursements to specific nostro accounts for sett',
    `reversal_disbursement_id` BIGINT COMMENT 'Self-referencing FK on disbursement (reversal_disbursement_id)',
    `aml_screening_status` STRING COMMENT 'Status of AML screening performed on the disbursement transaction to detect suspicious activity.. Valid values are `pending|cleared|flagged|escalated`',
    `amount` DECIMAL(18,2) COMMENT 'Principal amount of funds disbursed to the borrower in this transaction.',
    `approval_authority_level` STRING COMMENT 'Level of authority required for disbursement approval (e.g., branch manager, credit committee, senior management).',
    `approval_date` DATE COMMENT 'Date when the disbursement request was approved by the authorized authority.',
    `channel` STRING COMMENT 'Business channel through which the disbursement was initiated (e.g., branch, online banking, relationship manager).. Valid values are `branch|online|mobile|relationship_manager|automated`',
    `comments` STRING COMMENT 'Free-text field for additional notes, instructions, or remarks related to the disbursement.',
    `conditions_precedent_checklist` STRING COMMENT 'Comma-separated list or description of specific conditions precedent that were verified before disbursement.',
    `conditions_precedent_satisfied_flag` BOOLEAN COMMENT 'Indicates whether all conditions precedent required for disbursement have been satisfied (e.g., documentation, collateral perfection, insurance).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the disbursement record was first created in the database.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the disbursed amount.. Valid values are `^[A-Z]{3}$`',
    `destination_account_name` STRING COMMENT 'Name of the account holder for the destination account receiving funds.',
    `destination_bank_bic` STRING COMMENT 'SWIFT BIC code of the destination bank receiving the disbursement. Applicable for wire transfers and international payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `destination_bank_name` STRING COMMENT 'Name of the financial institution where the destination account is held.',
    `destination_routing_number` STRING COMMENT 'Routing or sort code for the destination bank. Used for domestic transfers (e.g., ABA routing number in US, sort code in UK).',
    `disbursement_date` DATE COMMENT 'Business date on which the disbursement was initiated or authorized.',
    `disbursement_method` STRING COMMENT 'Payment mechanism used to transfer funds to the borrower (e.g., wire transfer, ACH, RTGS, check).. Valid values are `wire_transfer|ach|rtgs|check|internal_transfer|swift`',
    `disbursement_status` STRING COMMENT 'Current lifecycle status of the disbursement transaction indicating processing state. [ENUM-REF-CANDIDATE: pending|approved|in_progress|completed|failed|cancelled|reversed — 7 candidates stripped; promote to reference product]',
    `disbursement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the disbursement transaction was executed in the system.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if the disbursement involved currency conversion. Nullable for same-currency transactions.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was determined for currency conversion.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged for processing this disbursement (e.g., wire transfer fees, processing fees).',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the disbursement fees.. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the disbursement transaction was posted.',
    `gl_posting_date` DATE COMMENT 'Accounting date when the disbursement transaction was posted to the general ledger.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Net amount received by the borrower after deducting fees and charges from the gross disbursement amount.',
    `partial_disbursement_flag` BOOLEAN COMMENT 'Indicates whether this disbursement represents a partial release of the total approved loan amount.',
    `purpose` STRING COMMENT 'Business purpose or intended use of the disbursed funds as declared by the borrower (e.g., working capital, equipment purchase, refinancing).',
    `reference_number` STRING COMMENT 'Externally visible unique reference number for this disbursement transaction, used for customer communication and reconciliation.',
    `regulatory_reporting_category` STRING COMMENT 'Classification of the disbursement for regulatory reporting purposes (e.g., CTR, SAR, FATCA, CRS).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this disbursement must be included in regulatory reports (e.g., large cash transactions, cross-border transfers).',
    `reversal_date` DATE COMMENT 'Date when the disbursement reversal was processed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this disbursement has been reversed due to error, fraud, or other reasons.',
    `reversal_reason` STRING COMMENT 'Explanation for why the disbursement was reversed. Populated only if reversal_flag is true.',
    `sequence_number` STRING COMMENT 'Sequential number indicating the order of this disbursement within a multi-tranche or construction loan facility.',
    `settlement_date` DATE COMMENT 'Date when the disbursement transaction was settled and funds were transferred to the destination account.',
    `swift_message_reference` STRING COMMENT 'Unique SWIFT message reference number for international wire transfers processed through the SWIFT network.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the disbursement record was last modified.',
    `value_date` DATE COMMENT 'Effective date when funds become available to the borrower for interest calculation and accounting purposes.',
    CONSTRAINT pk_disbursement PRIMARY KEY(`disbursement_id`)
) COMMENT 'Record of loan fund disbursement events capturing disbursement method, destination account, amount, currency, and disbursement conditions satisfied. Distinct from drawdown which is the facility-level event.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`insurance` (
    `insurance_id` BIGINT COMMENT 'Unique identifier for the insurance policy record associated with a loan facility. Primary key for the insurance product.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset covered by property or hazard insurance. Links insurance to specific pledged assets for collateral valuation and risk assessment.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Insurance policies with coverage in currencies require currency metadata (rounding, minor unit) for claims processing, premium calculation, collateral valuation (insurance-backed collateral), and regu',
    `facility_id` BIGINT COMMENT 'Reference to the credit facility when insurance is attached at the facility level rather than individual loan level. Used for revolving facilities and syndicated loans.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Force-placed insurance premiums and claim recoveries generate journal entries for expense recognition and recovery income. Required for collateral protection accounting and claim recovery tracking.',
    `party_id` BIGINT COMMENT 'Reference to the customer or party record for the insured individual or entity. Links insurance to customer master data for KYC and relationship management.',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account or facility to which this insurance policy is attached. Links insurance coverage to the underlying credit exposure.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Insurance policies held as loan collateral (e.g., life insurance policies with cash surrender value, annuities) may be securitized or represented as instruments. Supports collateral valuation and regu',
    `previous_loan_insurance_id` BIGINT COMMENT 'Self-referencing FK on insurance (previous_loan_insurance_id)',
    `beneficiary_name` STRING COMMENT 'Name of the party entitled to receive insurance proceeds. For loan-related insurance, typically the lending institution or a loss payee clause naming the lender.',
    `cancellation_date` DATE COMMENT 'Date on which the insurance policy was terminated prior to expiry. Cancellation may be initiated by insurer, policyholder, or lender and triggers coverage gap risk.',
    `cancellation_reason` STRING COMMENT 'Business reason for policy termination. Non-payment indicates premium default; loan payoff indicates coverage no longer needed; policy replaced indicates new coverage obtained; underwriting decline indicates carrier risk assessment change. [ENUM-REF-CANDIDATE: non_payment|borrower_request|loan_payoff|policy_replaced|underwriting_decline|fraud|material_misrepresentation|regulatory_requirement — 8 candidates stripped; promote to reference product]',
    `claim_count` STRING COMMENT 'Total number of claims filed against this insurance policy. High claim frequency may trigger premium increases or policy non-renewal and indicates elevated risk.',
    `compliance_status` STRING COMMENT 'Assessment of whether insurance coverage meets lender requirements and regulatory mandates. Non-compliant status triggers remediation actions including force-placement or loan covenant breach.. Valid values are `compliant|non_compliant|pending_verification|coverage_gap|insufficient_coverage|expired`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum benefit or face value of the insurance policy. Represents the total amount the insurer will pay in the event of a covered loss or claim.',
    `coverage_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the coverage amount. Ensures proper valuation when loan and insurance currencies differ.. Valid values are `^[A-Z]{3}$`',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of loss covered by the insurance policy after deductible. Typically 100% for full coverage; may be lower for co-insurance arrangements where insured retains partial risk.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this insurance policy record was first created in the data platform. Used for data lineage, audit trail, and regulatory compliance.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured must pay out-of-pocket before insurance coverage applies. Higher deductibles reduce premium cost but increase borrower exposure and potential recovery shortfall.',
    `effective_date` DATE COMMENT 'Date on which insurance coverage begins. Coverage is not in force prior to this date. Critical for determining whether claims are covered.',
    `expiry_date` DATE COMMENT 'Date on which insurance coverage terminates. Lender must ensure continuous coverage throughout loan term; expiry triggers renewal or replacement requirement.',
    `force_placed_date` DATE COMMENT 'Date on which lender-placed insurance coverage was initiated due to borrower failure to maintain required coverage. Used for cost allocation and regulatory reporting.',
    `force_placed_flag` BOOLEAN COMMENT 'Indicates whether insurance was obtained by the lender on behalf of the borrower due to lapse or non-compliance with insurance requirements. Force-placed insurance is typically more expensive and may be charged back to borrower.',
    `insurer_identifier` STRING COMMENT 'Standardized identifier for the insurance carrier such as NAIC company code or tax identification number. Enables regulatory reporting and carrier lookup.',
    `insurer_name` STRING COMMENT 'Legal name of the insurance company or carrier providing the coverage. Used for claims submission and carrier communication.',
    `issue_date` DATE COMMENT 'Date on which the insurance policy was originally issued by the carrier. May differ from effective date if policy is issued in advance of coverage start.',
    `last_claim_date` DATE COMMENT 'Date of the most recent claim filed against this policy. Used for risk assessment and underwriting review.',
    `loss_payee_clause` STRING COMMENT 'Legal provision designating the lender as recipient of insurance proceeds. Mortgagee clause provides strongest protection; ISAOA/ATIMA (its successors and/or assigns/as their interests may appear) provides flexible assignment rights.. Valid values are `first_loss_payee|mortgagee_clause|lender_loss_payee|standard_mortgagee|isaoa_atima`',
    `notes` STRING COMMENT 'Free-form text field for additional information, special conditions, underwriting notes, or operational comments related to the insurance policy. Used for exception handling and audit trail.',
    `policy_number` STRING COMMENT 'Externally-issued policy number assigned by the insurance carrier. Unique identifier used for claims processing and carrier communication.',
    `policy_status` STRING COMMENT 'Current lifecycle state of the insurance policy. Active policies provide coverage; lapsed policies have missed premium payments; cancelled policies have been terminated by insurer or policyholder. [ENUM-REF-CANDIDATE: active|pending|expired|cancelled|lapsed|suspended|in_force|terminated — 8 candidates stripped; promote to reference product]',
    `policy_type` STRING COMMENT 'Classification of insurance coverage. Mortgage insurance (PMI) protects lender against borrower default; credit life insurance pays loan balance upon borrower death; property insurance covers collateral damage; key-person insurance protects against loss of critical business personnel; collateral insurance covers pledged assets. [ENUM-REF-CANDIDATE: mortgage_insurance|credit_life_insurance|property_insurance|key_person_insurance|collateral_insurance|credit_default_insurance|title_insurance|flood_insurance|hazard_insurance|business_interruption_insurance — 10 candidates stripped; promote to reference product]',
    `premium_amount` DECIMAL(18,2) COMMENT 'Periodic payment amount required to maintain insurance coverage. May be paid by borrower, lender, or escrowed as part of loan payment.',
    `premium_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the premium amount. Typically matches loan currency but may differ for cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `premium_frequency` STRING COMMENT 'Billing cycle for insurance premium payments. Single premium indicates one-time upfront payment; other frequencies indicate recurring payments.. Valid values are `monthly|quarterly|semi_annually|annually|single_premium|bi_weekly`',
    `premium_payment_method` STRING COMMENT 'Mechanism by which insurance premiums are paid. Borrower-paid indicates direct payment by borrower; lender-paid indicates bank advances premium; escrowed indicates premium collected with loan payment; financed indicates premium added to loan balance.. Valid values are `borrower_paid|lender_paid|escrowed|financed|third_party_paid`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether insurance is mandated by regulatory or statutory requirements such as FHA mortgage insurance, flood insurance in FEMA zones, or state-mandated coverage. True for regulatory requirements; false for discretionary coverage.',
    `renewal_date` DATE COMMENT 'Next scheduled date for policy renewal. Used for tracking and alerting to ensure continuous coverage and avoid lapses that expose lender to uninsured risk.',
    `required_by_lender_flag` BOOLEAN COMMENT 'Indicates whether insurance is mandated by the lending institution as a condition of loan approval. True for required coverage; false for optional or borrower-elected coverage.',
    `total_claims_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount paid by insurer for all claims under this policy. Used for loss ratio analysis and policy performance assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this insurance policy record was most recently modified. Used for change tracking, data quality monitoring, and audit trail.',
    `verification_date` DATE COMMENT 'Date on which lender last verified that insurance coverage is active and compliant with loan requirements. Regulatory and internal policy requirements mandate periodic verification.',
    `verification_method` STRING COMMENT 'Mechanism used to confirm insurance coverage. Certificate of insurance is standard evidence; electronic verification uses carrier APIs; third-party tracking services provide continuous monitoring.. Valid values are `certificate_of_insurance|policy_declaration|carrier_confirmation|electronic_verification|third_party_tracking_service`',
    CONSTRAINT pk_insurance PRIMARY KEY(`insurance_id`)
) COMMENT 'Record of insurance policies associated with loan facilities including mortgage insurance (PMI), credit life insurance, property insurance, and key-person insurance. Captures policy number, insurer, coverage amount, premium, and expiry.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the loan pricing record. Primary key for the pricing entity.',
    `facility_id` BIGINT COMMENT 'Reference to the loan facility to which this pricing structure applies.',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Loan pricing uses FTP rates as cost-of-funds input for margin calculation, profitability analysis, and pricing decisions. Essential for funds transfer pricing and product profitability management.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this pricing structure.',
    `pricing_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this pricing record.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Loan pricing references benchmark rates (SOFR, EURIBOR, SONIA) requiring benchmark metadata (administrator, fallback rate, observation shift, lookback period) for rate resets, fallback provisions (IBO',
    `previous_loan_pricing_id` BIGINT COMMENT 'Self-referencing FK on pricing (previous_loan_pricing_id)',
    `all_in_rate` DECIMAL(18,2) COMMENT 'The total effective interest rate charged to the borrower, calculated as benchmark rate plus spread plus any additional margin components. Expressed as a decimal (e.g., 0.0575 for 5.75%).',
    `approval_authority` STRING COMMENT 'The role or level of authority that approved this pricing structure (e.g., Relationship Manager, Credit Committee, Executive Committee).',
    `approval_date` DATE COMMENT 'The date on which this pricing structure was formally approved.',
    `base_rate` DECIMAL(18,2) COMMENT 'The foundational interest rate expressed as a decimal (e.g., 0.0525 for 5.25%). For fixed-rate loans, this is the all-in rate. For floating-rate loans, this is the benchmark reference rate before spread is applied.',
    `benchmark_rate_code` STRING COMMENT 'Code identifying the reference benchmark rate for floating-rate loans (e.g., SOFR, LIBOR, Prime, EURIBOR, Fed Funds). Null for fixed-rate loans.',
    `cap_rate` DECIMAL(18,2) COMMENT 'The maximum interest rate that can be charged on the loan, providing borrower protection against rate increases. Expressed as a decimal. Null if no cap applies.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special conditions, or contextual information about the pricing arrangement.',
    `compounding_frequency` STRING COMMENT 'The frequency at which accrued interest is added to the principal balance for compound interest calculation. Simple indicates no compounding. [ENUM-REF-CANDIDATE: simple|daily|monthly|quarterly|semi_annually|annually|continuous — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `day_count_convention` STRING COMMENT 'The methodology used to calculate interest accrual based on the number of days in the period. Common conventions include Actual/360, Actual/365, 30/360, and Actual/Actual.. Valid values are `actual_360|actual_365|30_360|actual_actual`',
    `default_rate` DECIMAL(18,2) COMMENT 'The penalty interest rate applied when the borrower is in default or breach of loan covenants. Expressed as a decimal. Null if no default rate provision exists.',
    `default_spread_bps` STRING COMMENT 'Additional spread in basis points added to the standard rate upon default or covenant breach. Null if no default spread applies.',
    `effective_date` DATE COMMENT 'The date from which this pricing structure becomes active and applicable to the loan facility.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this pricing represents an exception to standard pricing policy (true) or follows standard guidelines (false).',
    `exception_reason` STRING COMMENT 'Business justification for pricing exception if the pricing_exception_flag is true. Null if no exception applies.',
    `expiration_date` DATE COMMENT 'The date on which this pricing structure ceases to be effective. Null for open-ended pricing arrangements.',
    `floor_rate` DECIMAL(18,2) COMMENT 'The minimum interest rate that can be charged on the loan, regardless of how low the benchmark rate falls. Expressed as a decimal. Null if no floor applies.',
    `ftp_rate` DECIMAL(18,2) COMMENT 'The internal funds transfer pricing rate used for profitability allocation between business units. Expressed as a decimal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lgd_at_pricing` DECIMAL(18,2) COMMENT 'The estimated loss given default (LGD) at the time of pricing, expressed as a decimal (e.g., 0.4500 for 45%). Used for expected loss calculation in pricing models.',
    `margin_rate` DECIMAL(18,2) COMMENT 'Additional margin or adjustment rate applied on top of the base rate and spread, often used for risk-based pricing adjustments. Expressed as a decimal.',
    `model_code` STRING COMMENT 'Code identifying the pricing model or methodology used to determine the rate structure (e.g., cost-plus, risk-based, relationship, competitive).',
    `next_repricing_date` DATE COMMENT 'The next scheduled date on which the interest rate will be recalculated or reset based on the repricing frequency.',
    `pd_at_pricing` DECIMAL(18,2) COMMENT 'The estimated probability of default (PD) for the borrower at the time of pricing, expressed as a decimal (e.g., 0.0250 for 2.50%). Used for risk-based pricing validation.',
    `prepayment_penalty_rate` DECIMAL(18,2) COMMENT 'The penalty rate or fee percentage charged when the borrower prepays the loan before maturity. Expressed as a decimal. Null if no prepayment penalty applies.',
    `pricing_status` STRING COMMENT 'Current lifecycle status of the pricing record: active (currently in effect), inactive (not in use), pending (approved but not yet effective), superseded (replaced by newer pricing), or expired (past expiration date).. Valid values are `active|inactive|pending|superseded|expired`',
    `pricing_tier` STRING COMMENT 'Classification tier for relationship-based or volume-based pricing (e.g., Tier 1, Tier 2, Premium, Standard). Used when pricing varies by customer segment or utilization level.',
    `pricing_type` STRING COMMENT 'Classification of the interest rate structure: fixed (constant rate), floating (variable rate tied to benchmark), hybrid (combination of fixed and floating periods), tiered (rate varies by balance or utilization), step-up (rate increases over time), or step-down (rate decreases over time).. Valid values are `fixed|floating|hybrid|tiered|step_up|step_down`',
    `raroc_at_pricing` DECIMAL(18,2) COMMENT 'The calculated risk-adjusted return on capital (RAROC) at the time of pricing, expressed as a decimal. Used to validate that pricing meets minimum return hurdles.',
    `rate_lock_expiration_date` DATE COMMENT 'The date on which a rate lock expires if the loan has not closed. Null if no rate lock is in effect.',
    `rate_lock_flag` BOOLEAN COMMENT 'Indicates whether the interest rate is locked (true) or subject to change before loan closing (false). Commonly used during loan origination period.',
    `rate_type` STRING COMMENT 'Primary rate classification indicating whether the interest rate is fixed, floating (variable), or hybrid (combination of both).. Valid values are `fixed|floating|hybrid`',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the pricing arrangement, used in documentation and customer communications.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this pricing record must be included in regulatory reporting submissions (true) or is exempt (false).',
    `relationship_discount_bps` STRING COMMENT 'Discount in basis points granted based on the overall banking relationship value. Null if no relationship discount applies.',
    `repricing_frequency` STRING COMMENT 'The frequency at which the interest rate is recalculated or reset for floating-rate loans. For fixed-rate loans, this is typically at_maturity. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annually|annually|at_maturity|on_demand — 8 candidates stripped; promote to reference product]',
    `risk_rating_at_pricing` STRING COMMENT 'The internal credit risk rating of the borrower or facility at the time this pricing was established. Used for risk-adjusted pricing analysis.',
    `spread_bps` STRING COMMENT 'The credit spread or margin added to the benchmark rate, expressed in basis points (1 basis point = 0.01%). For example, 250 BPS represents a 2.50% spread over the benchmark.',
    CONSTRAINT pk_pricing PRIMARY KEY(`pricing_id`)
) COMMENT 'Loan pricing and rate structure record capturing the interest rate terms, spread, margin, floor, cap, and repricing frequency for each facility. Tracks rate type (fixed, floating, hybrid) and benchmark reference.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` (
    `loan_collateral_pledge_id` BIGINT COMMENT 'Primary key for loan_collateral_pledge',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to the collateral asset being pledged to secure the facility',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the credit facility being secured by the pledged collateral asset',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the collateral assets total value allocated to secure this facility. Used when a single collateral asset secures multiple facilities (cross-collateralization). Sum of allocation percentages across all facilities for a given asset should not exceed 100% unless over-collateralization is permitted.',
    `collateral_type` STRING COMMENT 'Primary category of collateral pledged to secure the facility. Determines LGD estimation methodology, collateral haircut, and regulatory capital treatment under Basel III standardized and IRB approaches. [Moved from facility: The collateral_type attribute in the facility product is a simplification that assumes a facility is secured by a single collateral type. In reality, facilities are routinely secured by mixed collateral pools (e.g., real estate + securities + cash). This attribute should be removed from facility as it is derivable from the collateral_asset records linked via the pledge association. The facilitys collateral profile is the aggregation of all pledged assets, not a single type.]. Valid values are `real_estate|equipment|receivables|securities|cash|unsecured`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the pledge relationship record was created in the lakehouse.',
    `cross_collateralization_flag` BOOLEAN COMMENT 'Indicates whether this collateral asset secures multiple facilities under a cross-collateralization agreement. When true, the assets value is shared across multiple facilities and allocation_percentage determines the distribution.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the pledged_value_amount is denominated. Typically matches the facility currency but may differ for cross-currency collateral arrangements.',
    `last_valuation_date` DATE COMMENT 'Date on which the pledged collateral asset was last valued for purposes of this facilitys LTV calculation. Drives revaluation scheduling and covenant monitoring. Typically synchronized with collateral_asset.valuation_date but may differ if facility-specific appraisals are required.',
    `lien_position` STRING COMMENT 'Priority ranking of the banks security interest in this collateral asset for this specific facility. Determines recovery priority in default scenarios. Values: First, Second, Third, Junior, Pari Passu, Subordinated. Critical for loss given default (LGD) estimation and Basel III capital calculations.',
    `link_effective_date` DATE COMMENT 'Date on which the collateral asset was pledged to secure this facility and the pledge relationship became effective. Typically coincides with facility origination or subsequent collateral substitution events.',
    `link_termination_date` DATE COMMENT 'Date on which the pledge relationship was terminated and the collateral asset was released from securing this facility. Null for active pledges. Populated upon facility maturity, collateral substitution, or release events.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the facilitys outstanding drawn amount to the pledged value of this specific collateral asset. Calculated as facility.drawn_amount / pledged_value_amount. Monitored against covenant thresholds and triggers margin calls or additional collateral requirements when breached.',
    `margin_call_threshold_pct` DECIMAL(18,2) COMMENT 'LTV ratio threshold that triggers a margin call or requirement for additional collateral. When the calculated ltv_ratio exceeds this threshold, the borrower must pledge additional collateral or reduce the facility balance. Typically set in the credit agreement.',
    `perfection_date` DATE COMMENT 'Date on which the security interest was perfected through filing of UCC-1 financing statement, mortgage recording, control agreement execution, or other jurisdiction-specific mechanism. Establishes priority date for competing claims.',
    `perfection_status` STRING COMMENT 'Legal status of the banks security interest in the collateral asset for this facility. Indicates whether the lien has been properly filed and recorded to establish priority against other creditors. Values: Perfected, Pending, Unperfected, Lapsed, Under Review. Unperfected liens may not be recognized for regulatory capital relief.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of the pledge relationship. Values: Active (currently securing the facility), Released (collateral returned to borrower), Substituted (replaced with alternative collateral), Under Review (pending legal or valuation review), Disputed (subject to legal challenge or claim).',
    `pledged_value_amount` DECIMAL(18,2) COMMENT 'The monetary value of the collateral asset allocated to secure this specific facility, expressed in the facilitys currency. May be less than the total collateral value if the asset secures multiple facilities. This is the amount used for LTV and coverage ratio calculations for this facility-collateral pair.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the pledge relationship record was last updated in the lakehouse.',
    CONSTRAINT pk_loan_collateral_pledge PRIMARY KEY(`loan_collateral_pledge_id`)
) COMMENT 'This association product represents the pledge relationship between a credit facility and a collateral asset. It captures the legal and financial terms under which specific collateral assets secure specific credit facilities, including lien priority, allocation percentages, loan-to-value ratios, and perfection status. Each record links one facility to one collateral asset with attributes that exist only in the context of this secured lending relationship. This is the operational system of record for collateral allocation and security interest management across the banks secured lending portfolio.. Existence Justification: In banking secured lending operations, a single credit facility is routinely secured by multiple collateral assets (e.g., a commercial real estate portfolio loan secured by 5 properties, a revolving credit line secured by receivables + inventory + equipment). Conversely, a single high-value collateral asset frequently secures multiple facilities through cross-collateralization arrangements (e.g., a flagship commercial property securing both a term loan and a revolving line). The pledge relationship itself carries critical operational and regulatory data including lien position, allocation percentage, LTV ratio, perfection status, and effective dates that belong to neither the facility nor the asset alone.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`stress_projection` (
    `stress_projection_id` BIGINT COMMENT 'Unique surrogate identifier for this loan-scenario stress projection record. Primary key.',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to the loan account being stress tested',
    `stress_test_run_id` BIGINT COMMENT 'Reference to the specific stress testing run execution that produced this projection. Links to stress run metadata (run date, model version, approval status).',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to the stress scenario being applied',
    `calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when this stress projection was calculated. Used for audit trails and version control.',
    `model_version` STRING COMMENT 'Version identifier of the credit risk model used to calculate this stress projection. Required for model governance and regulatory audit trails.',
    `projection_date` DATE COMMENT 'The forward-looking date (quarter-end) for which this stress projection is calculated. Stress scenarios project multiple quarters into the future.',
    `stage_classification` STRING COMMENT 'IFRS 9 impairment stage classification for this loan under this stress scenario. Stage 1 = 12-month ECL, Stage 2 = lifetime ECL (significant increase in credit risk), Stage 3 = credit-impaired. Stress scenarios often trigger stage migrations.',
    `stressed_balance` DECIMAL(18,2) COMMENT 'Projected outstanding principal balance of the loan account under this stress scenario at the projection date. Reflects expected prepayments, defaults, and charge-offs under stress conditions.',
    `stressed_delinquency_bucket` STRING COMMENT 'Projected delinquency bucket (current, 30 DPD, 60 DPD, 90+ DPD) for this loan under this stress scenario at the projection date.',
    `stressed_ecl_provision` DECIMAL(18,2) COMMENT 'Expected Credit Loss (ECL) provision calculated for this loan under this stress scenario. Used for IFRS 9 stress testing and regulatory capital stress testing (CCAR/DFAST).',
    `stressed_lgd` DECIMAL(18,2) COMMENT 'Loss Given Default (LGD) for this loan under this stress scenario, expressed as a decimal. Reflects collateral value deterioration under stressed macroeconomic conditions (e.g., HPI shocks for mortgage collateral).',
    `stressed_npl_flag` BOOLEAN COMMENT 'Indicates whether this loan is projected to be classified as non-performing (NPL) under this stress scenario at the projection date.',
    `stressed_pd` DECIMAL(18,2) COMMENT 'Probability of Default (PD) for this loan under this stress scenario, expressed as a decimal. Calculated by applying scenario-specific PD multipliers and macroeconomic shocks to baseline PD models.',
    `stressed_rwa` DECIMAL(18,2) COMMENT 'Risk-Weighted Assets (RWA) calculated for this loan under this stress scenario. Used for regulatory capital adequacy stress testing (CCAR/DFAST).',
    CONSTRAINT pk_stress_projection PRIMARY KEY(`stress_projection_id`)
) COMMENT 'This association product represents the stress testing projection between loan_account and stress_scenario. It captures the forward-looking credit risk metrics for each loan under each regulatory and internal stress scenario, supporting CCAR, DFAST, ICAAP, and IFRS 9 ECL calculations. Each record links one loan_account to one stress_scenario with scenario-specific stressed metrics, stage migrations, and provision calculations that exist only in the context of this stress testing relationship.. Existence Justification: In regulatory stress testing operations (CCAR, DFAST, ICAAP, IFRS 9), each loan account is projected under multiple stress scenarios (baseline, adverse, severely adverse), and each stress scenario is applied to the entire loan portfolio. The business actively manages these stress projections as operational records, running quarterly stress tests that produce scenario-specific credit metrics (stressed PD, LGD, ECL provisions, stage migrations) for each loan-scenario combination. Risk teams query and report on these projections by scenario and by loan cohort.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`stress_test_result` (
    `stress_test_result_id` BIGINT COMMENT 'Unique identifier for this loan-scenario stress test result record. Primary key.',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to the loan account being stress tested',
    `stress_scenario_cfp_id` BIGINT COMMENT 'Foreign key linking to the stress scenario definition applied to this loan',
    `calculation_timestamp` TIMESTAMP COMMENT 'System timestamp when this stress test result was calculated. Used for audit trail and to identify the most recent stress test run.',
    `model_version` STRING COMMENT 'Version identifier of the credit risk model used to calculate stressed PD and LGD for this result. Required for model governance and regulatory validation.',
    `scenario_application_date` DATE COMMENT 'Date when this stress scenario was applied to this loan account for stress testing. Represents the as-of date for the stress calculation. Critical for time-series analysis of stress test results across quarters.',
    `scenario_impact_category` STRING COMMENT 'Categorical classification of the stress impact on this loan: minimal (ECL increase <10%), moderate (10-25%), severe (25-50%), critical (>50%). Used for risk reporting and identification of loans most vulnerable to stress scenarios.',
    `stressed_ecl_amount` DECIMAL(18,2) COMMENT 'Expected credit loss for this loan under this stress scenario, calculated as stressed_exposure_amount × stressed_pd × stressed_lgd. Aggregated across the loan portfolio to determine stressed allowance for credit losses and capital adequacy under CCAR/DFAST.',
    `stressed_exposure_amount` DECIMAL(18,2) COMMENT 'Projected exposure at default (EAD) for this loan under this stress scenario. Incorporates assumed drawdowns on committed facilities and accrued interest under stress. Used as the base for ECL calculation.',
    `stressed_lgd` DECIMAL(18,2) COMMENT 'Loss given default for this loan under this stress scenario, expressed as a decimal (e.g., 0.45 = 45%). Incorporates stressed collateral values using haircuts from the scenario definition. Key input to stressed ECL calculation.',
    `stressed_pd` DECIMAL(18,2) COMMENT 'Probability of default for this loan under this stress scenario, expressed as a decimal (e.g., 0.15 = 15%). Derived from credit risk models calibrated to stressed macroeconomic conditions. Key input to stressed ECL calculation.',
    CONSTRAINT pk_stress_test_result PRIMARY KEY(`stress_test_result_id`)
) COMMENT 'This association product represents the stress testing evaluation between loan_account and stress_scenario_cfp. It captures the projected credit quality deterioration and expected credit loss for each loan account under each regulatory and internal stress scenario. Each record links one loan account to one stress scenario with stressed credit metrics (PD, LGD, ECL) that exist only in the context of this specific scenario application. Required for CCAR/DFAST regulatory capital stress testing, CECL allowance stress projections, and liquidity stress testing (via stressed cash flow assumptions). Reviewed by Credit Risk and Treasury for capital adequacy assessment.. Existence Justification: In banking stress testing operations, each loan account is evaluated under multiple regulatory and internal stress scenarios (baseline, adverse, severely adverse) to project credit deterioration and capital adequacy. Each loan-scenario combination produces unique stressed credit metrics (PD, LGD, ECL) that belong to neither the loan nor the scenario alone. Credit Risk and Treasury teams actively manage and query these stress test results as a distinct operational dataset for CCAR/DFAST submissions and capital planning.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` (
    `facility_cfp_assumption_id` BIGINT COMMENT 'Unique surrogate identifier for this facility assumption record within the contingency funding plan. Primary key.',
    `contingency_funding_plan_id` BIGINT COMMENT 'Foreign key linking to the contingency funding plan document containing this facility assumption',
    `facility_id` BIGINT COMMENT 'Foreign key linking to the credit facility being modeled in the contingency funding plan stress scenario',
    `assumption_rationale` STRING COMMENT 'Business justification for the drawdown assumption rate applied to this facility in this stress scenario. Documents Treasury analyst reasoning based on facility type, borrower behavior, historical utilization patterns, and relationship strength.',
    `assumption_status` STRING COMMENT 'Current status of this facility assumption within the CFP. Active assumptions are used in current stress testing; superseded assumptions are retained for historical audit; excluded facilities are no longer modeled in the plan.',
    `contingent_exposure_amount` DECIMAL(18,2) COMMENT 'Incremental liquidity outflow expected from this facility under stress, calculated as stress utilization amount minus current drawn amount. Represents the additional funding need that must be covered by contingent liquidity sources.',
    `drawdown_assumption_rate` DECIMAL(18,2) COMMENT 'Assumed rate at which the undrawn portion of the facility will be drawn down under the stress scenario modeled in this CFP. Expressed as a decimal (e.g., 0.75 = 75% drawdown assumption). Varies by facility type, borrower relationship strength, and stress severity.',
    `last_review_date` DATE COMMENT 'Date on which this facility assumption was last reviewed and validated by Treasury during CFP update cycle. Supports regulatory requirement for annual CFP review.',
    `plan_inclusion_date` DATE COMMENT 'Date on which this facility was included in the contingency funding plan stress modeling. Tracks when the assumption was established and supports audit trail for CFP updates.',
    `scenario_type` STRING COMMENT 'Type of stress scenario for which this facility assumption applies within the CFP. Aligns with the stress_scenario_type of the parent contingency funding plan. Same facility may have different assumptions across multiple scenario types.',
    `stress_utilization_amount` DECIMAL(18,2) COMMENT 'Projected total outstanding amount for this facility under the stress scenario, calculated as current drawn amount plus (undrawn amount × drawdown assumption rate). Represents the contingent liquidity demand from this facility.',
    CONSTRAINT pk_facility_cfp_assumption PRIMARY KEY(`facility_cfp_assumption_id`)
) COMMENT 'This association product represents the stress scenario modeling assumptions between facility and contingency_funding_plan. It captures the projected drawdown behavior and contingent exposure of each credit facility under specific liquidity stress scenarios documented in the CFP. Each record links one facility to one contingency funding plan with scenario-specific assumptions that exist only in the context of this stress modeling relationship. Required for regulatory liquidity stress testing under Federal Reserve SR 10-6.. Existence Justification: In banking liquidity risk management, contingency funding plans model stress scenarios across the entire facility portfolio. Each facility is included in multiple CFP scenarios (baseline, moderate stress, severe stress) with different drawdown assumptions, and each CFP scenario includes hundreds or thousands of facilities with scenario-specific modeling parameters. Treasury analysts actively manage these assumptions during annual CFP reviews and update them when facility characteristics or stress methodologies change.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`trade_finance_transaction` (
    `trade_finance_transaction_id` BIGINT COMMENT 'Primary key for trade_finance_transaction',
    `correspondent_bank_id` BIGINT COMMENT 'Reference to the bank that advises the beneficiary of the issuance of the trade finance instrument without undertaking payment obligation.',
    `bank_guarantee_id` BIGINT COMMENT 'Foreign key linking to loan.bank_guarantee. Business justification: When trade_finance_transaction.instrument_type = GUARANTEE or BANK_GUARANTEE, this FK links to the specific guarantee record. Business justification: Enables unified trade instrument tracking whil',
    `beneficiary_id` BIGINT COMMENT 'Reference to the party (typically the exporter or seller) in whose favor the trade finance instrument is issued.',
    `confirming_bank_id` BIGINT COMMENT 'Reference to the bank that adds its confirmation to the trade finance instrument, thereby undertaking payment obligation in addition to the issuing bank.',
    `documentary_collection_id` BIGINT COMMENT 'Foreign key linking to loan.documentary_collection. Business justification: When trade_finance_transaction.instrument_type = COLLECTION or DOCUMENTARY_COLLECTION, this FK links to the specific collection record. Business justification: Enables unified trade instrument tra',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this trade finance transaction record.',
    `issuing_bank_id` BIGINT COMMENT 'Reference to the bank that issues the trade finance instrument on behalf of the applicant.',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: trade_finance_transaction is a master reference table for trade instruments with instrument_type field. When instrument_type = LC or LETTER_OF_CREDIT, this FK links to the specific LC record. Busi',
    `loan_account_id` BIGINT COMMENT 'Reference to the associated loan or credit facility that provides funding for this trade finance transaction.',
    `party_id` BIGINT COMMENT 'Reference to the party (typically the importer or buyer) who requests the issuance of the trade finance instrument.',
    `reimbursement_bank_id` BIGINT COMMENT 'Reference to the bank authorized to reimburse the claiming bank after compliant documents have been honored.',
    `reversal_trade_finance_transaction_id` BIGINT COMMENT 'Self-referencing FK on trade_finance_transaction (reversal_trade_finance_transaction_id)',
    `applicable_law` STRING COMMENT 'Jurisdiction and legal framework under which disputes related to this trade finance transaction will be resolved.',
    `available_by` STRING COMMENT 'Method by which the trade finance instrument is available for payment (sight payment, deferred payment, acceptance, negotiation, or mixed payment).',
    `charges_for_account_of` STRING COMMENT 'Indicates which party (applicant, beneficiary, or shared) is responsible for bearing the banking charges and fees associated with the trade finance transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this trade finance transaction record was first created in the system.',
    `discrepancies_noted` STRING COMMENT 'Detailed description of any discrepancies or non-compliance issues identified during the examination of presented documents.',
    `document_examination_status` STRING COMMENT 'Result of the banks examination of presented documents indicating whether they comply with the terms and conditions of the trade finance instrument.',
    `document_presentation_date` DATE COMMENT 'Actual date when the beneficiary or presenting bank submitted the required documents for examination under the trade finance instrument.',
    `documents_required` STRING COMMENT 'Comprehensive list of documents that must be presented to comply with the terms of the trade finance instrument (e.g., bill of lading, commercial invoice, packing list, certificate of origin).',
    `expiry_date` DATE COMMENT 'Date when the trade finance instrument expires and is no longer valid for presentation or negotiation.',
    `goods_description` STRING COMMENT 'Detailed description of the goods or services being financed under the trade finance transaction.',
    `governing_rules` STRING COMMENT 'International Chamber of Commerce (ICC) rules and uniform customs that govern the interpretation and application of this trade finance instrument.',
    `incoterms_code` STRING COMMENT 'Standard three-letter Incoterms code defining the responsibilities, costs, and risks between buyer and seller in the international transaction.',
    `instrument_type` STRING COMMENT 'Classification of the trade finance instrument being transacted (e.g., letter of credit, documentary collection, bank guarantee, standby LC, supply chain finance, trade loan).',
    `issue_date` DATE COMMENT 'Date when the trade finance instrument was officially issued by the issuing bank.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this trade finance transaction record was most recently updated or modified.',
    `latest_shipment_date` DATE COMMENT 'Last date by which shipment of goods must occur to comply with the terms of the trade finance instrument.',
    `partial_shipment_allowed` BOOLEAN COMMENT 'Indicates whether partial shipments of goods are permitted under the terms of the trade finance instrument.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Actual monetary amount paid to the beneficiary, which may differ from the transaction amount due to tolerances, discounts, or partial drawings.',
    `payment_date` DATE COMMENT 'Actual date when payment was made to the beneficiary under the trade finance instrument.',
    `payment_terms` STRING COMMENT 'Detailed description of the payment terms and conditions under which the trade finance instrument will be honored.',
    `port_of_discharge` STRING COMMENT 'Name and location of the port or place where goods are to be discharged or delivered under the trade finance transaction.',
    `port_of_loading` STRING COMMENT 'Name and location of the port or place where goods are to be loaded for shipment under the trade finance transaction.',
    `presentation_period_days` STRING COMMENT 'Maximum number of days after the date of shipment within which documents must be presented to the nominated bank for compliance checking.',
    `regulatory_reporting_code` STRING COMMENT 'Code used for regulatory reporting purposes to classify the trade finance transaction according to central bank or supervisory authority requirements.',
    `risk_participation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the transaction risk that has been participated out to other financial institutions for risk mitigation purposes.',
    `tenor_days` STRING COMMENT 'Number of days after sight or after a specified date when payment becomes due under deferred payment or acceptance terms.',
    `tolerance_percentage_negative` DECIMAL(18,2) COMMENT 'Percentage by which the transaction amount may be reduced, as permitted under the terms of the instrument (e.g., -5% tolerance).',
    `tolerance_percentage_positive` DECIMAL(18,2) COMMENT 'Percentage by which the transaction amount may be exceeded, as permitted under the terms of the instrument (e.g., +10% tolerance).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Principal monetary value of the trade finance transaction representing the maximum amount available under the instrument.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the trade finance transaction amount is denominated.',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this trade finance transaction for tracking and communication purposes.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the trade finance transaction indicating its position in the workflow from initiation through settlement or closure.',
    `transhipment_allowed` BOOLEAN COMMENT 'Indicates whether transhipment (transfer of goods from one vessel to another during transit) is permitted under the terms of the instrument.',
    CONSTRAINT pk_trade_finance_transaction PRIMARY KEY(`trade_finance_transaction_id`)
) COMMENT 'Master reference table for trade_finance_transaction. Referenced by trade_finance_transaction_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`document_presentation` (
    `document_presentation_id` BIGINT COMMENT 'Primary key for document_presentation',
    `advising_bank_party_id` BIGINT COMMENT 'Reference to the bank that advised the letter of credit to the beneficiary.',
    `approval_user_employee_id` BIGINT COMMENT 'Identifier of the authorized bank officer who approved the honor or refusal decision.',
    `beneficiary_id` BIGINT COMMENT 'Reference to the beneficiary of the letter of credit or documentary collection.',
    `documentary_collection_id` BIGINT COMMENT 'Reference to the documentary collection transaction if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the bank officer who performed the document examination.',
    `issuing_bank_party_id` BIGINT COMMENT 'Reference to the bank that issued the letter of credit.',
    `lc_id` BIGINT COMMENT 'Reference to the underlying letter of credit against which documents are presented.',
    `nominated_bank_party_id` BIGINT COMMENT 'Reference to the bank nominated to examine and/or honor the presentation.',
    `party_id` BIGINT COMMENT 'Reference to the applicant (buyer/importer) who requested the letter of credit.',
    `presenting_party_id` BIGINT COMMENT 'Reference to the party (beneficiary, negotiating bank, or other authorized presenter) submitting the documents.',
    `previous_document_presentation_id` BIGINT COMMENT 'Self-referencing FK on document_presentation (previous_document_presentation_id)',
    `bank_charges_amount` DECIMAL(18,2) COMMENT 'Total bank charges deducted from the presentation amount (examination fees, courier fees, SWIFT charges, etc.).',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total amount claimed by the beneficiary in this document presentation, as stated in the draft or invoice.',
    `compliance_determination` STRING COMMENT 'Banks determination of whether the presented documents comply with the letter of credit terms and conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this document presentation record was first created in the trade finance system.',
    `discrepancy_count` STRING COMMENT 'Number of discrepancies identified during document examination if presentation is non-compliant.',
    `discrepancy_notice_date` DATE COMMENT 'Date on which the bank issued notice of refusal citing discrepancies to the presenter.',
    `document_count` STRING COMMENT 'Total number of individual documents included in this presentation (invoices, bills of lading, certificates, etc.).',
    `examination_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the bank completed its examination and determined compliance or discrepancies.',
    `examination_deadline_date` DATE COMMENT 'Maximum date by which the bank must complete examination, typically 5 banking days from presentation date per UCP 600.',
    `examination_start_timestamp` TIMESTAMP COMMENT 'Date and time when the bank commenced examination of the presented documents.',
    `expiry_date` DATE COMMENT 'Latest date for presentation of documents as specified in the letter of credit terms.',
    `honor_date` DATE COMMENT 'Date on which the bank honored the presentation by making payment, accepting a draft, or incurring a deferred payment undertaking.',
    `invoice_date` DATE COMMENT 'Date of the commercial invoice presented as part of the document set.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this document presentation record was last updated.',
    `latest_shipment_date` DATE COMMENT 'Latest date for shipment of goods as specified in the letter of credit, used to verify transport document compliance.',
    `maturity_date` DATE COMMENT 'Date on which a deferred payment or accepted draft becomes due for payment.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid to the beneficiary, which may differ from claimed amount due to discrepancies, charges, or partial acceptance.',
    `payment_date` DATE COMMENT 'Actual date on which funds were disbursed to the beneficiary or negotiating bank.',
    `presentation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the amount claimed in this presentation.',
    `presentation_date` DATE COMMENT 'Date on which the documents were physically or electronically presented to the nominated bank or issuing bank.',
    `presentation_location` STRING COMMENT 'Physical or electronic location where documents were presented (bank branch, SWIFT address, electronic platform).',
    `presentation_method` STRING COMMENT 'Method by which documents were presented: physical delivery, electronic platform, SWIFT messaging, or other channel.',
    `presentation_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this document presentation by the presenting bank or beneficiary.',
    `presentation_status` STRING COMMENT 'Current lifecycle status of the document presentation in the examination and settlement workflow.',
    `presentation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the document presentation was received by the bank, critical for calculating examination periods.',
    `presentation_type` STRING COMMENT 'Classification of the presentation based on payment terms: sight payment, deferred payment, acceptance, or negotiation.',
    `reimbursement_claim_date` DATE COMMENT 'Date on which the reimbursement claim was submitted to the issuing or reimbursing bank.',
    `reimbursement_claim_sent_flag` BOOLEAN COMMENT 'Indicates whether the nominated bank has sent a reimbursement claim to the issuing bank or reimbursing bank.',
    `transport_document_date` DATE COMMENT 'Date of the transport document (bill of lading, airway bill, etc.) presented, critical for determining timely shipment.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the applicant agreed to waive the identified discrepancies and authorize payment.',
    `waiver_requested_flag` BOOLEAN COMMENT 'Indicates whether the bank has sought waiver of discrepancies from the applicant.',
    `waiver_response_date` DATE COMMENT 'Date on which the applicant responded to the waiver request, either accepting or refusing discrepancies.',
    CONSTRAINT pk_document_presentation PRIMARY KEY(`document_presentation_id`)
) COMMENT 'Master reference table for document_presentation. Referenced by document_presentation_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`covenant_package` (
    `covenant_package_id` BIGINT COMMENT 'Primary key for covenant_package',
    `predecessor_package_id` BIGINT COMMENT 'Reference to the previous version of this covenant package if this is a revised or updated version.',
    `parent_covenant_package_id` BIGINT COMMENT 'Self-referencing FK on covenant_package (parent_covenant_package_id)',
    `approval_date` DATE COMMENT 'Date on which the covenant package was formally approved by the appropriate credit authority for use in loan agreements.',
    `approved_by` STRING COMMENT 'Name or identifier of the credit authority or committee that approved this covenant package.',
    `borrower_segment` STRING COMMENT 'Target borrower segment for which this covenant package is designed, aligning with the banks credit risk appetite and portfolio strategy.',
    `breach_rate_percent` DECIMAL(18,2) COMMENT 'Historical percentage of loans using this package that have experienced covenant breaches, used for package effectiveness assessment.',
    `covenant_count` STRING COMMENT 'Total number of individual covenant clauses included in this package.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the covenant package record was first created in the system.',
    `cross_default_included_flag` BOOLEAN COMMENT 'Indicates whether the package includes cross-default provisions that trigger default if the borrower defaults on other obligations.',
    `cure_period_days` STRING COMMENT 'Standard number of days allowed for borrowers to cure covenant breaches before default provisions are triggered.',
    `covenant_package_description` STRING COMMENT 'Detailed business description of the covenant package including its intended use cases, target borrower profiles, and key covenant themes.',
    `effective_date` DATE COMMENT 'Date from which the covenant package becomes active and available for use in loan agreements.',
    `expiration_date` DATE COMMENT 'Date after which the covenant package is no longer available for new loan assignments. Nullable for packages with indefinite availability.',
    `financial_covenant_count` STRING COMMENT 'Number of financial covenants (e.g., debt-to-equity ratio, interest coverage ratio) included in the package.',
    `industry_sector` STRING COMMENT 'Primary industry sector or sectors for which this covenant package is tailored, using standard industry classification codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the covenant package record was most recently updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the covenant package for continued relevance and effectiveness.',
    `legal_template_reference` STRING COMMENT 'Reference identifier to the standard legal documentation template associated with this covenant package.',
    `material_adverse_change_included_flag` BOOLEAN COMMENT 'Indicates whether the package includes material adverse change clauses allowing lender action upon significant negative changes in borrower circumstances.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the covenant package record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the covenant package.',
    `operational_covenant_count` STRING COMMENT 'Number of operational or business conduct covenants included in the package.',
    `package_code` STRING COMMENT 'Externally-known unique business identifier for the covenant package used in loan documentation and regulatory reporting.',
    `package_name` STRING COMMENT 'Human-readable name of the covenant package describing its purpose or target borrower segment.',
    `package_type` STRING COMMENT 'Classification of the covenant package by its primary focus: financial covenants, operational restrictions, affirmative obligations, negative covenants, reporting requirements, or composite packages.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or jurisdiction governing the covenant requirements in this package (e.g., Basel III, Dodd-Frank, MiFID II).',
    `reporting_frequency` STRING COMMENT 'Standard frequency at which borrowers must report covenant compliance for packages assigned to their loan agreements.',
    `risk_rating` STRING COMMENT 'Overall risk profile associated with this covenant package based on the stringency and coverage of included covenants.',
    `covenant_package_status` STRING COMMENT 'Current lifecycle status of the covenant package indicating whether it is available for assignment to new loan agreements.',
    `syndication_eligible_flag` BOOLEAN COMMENT 'Indicates whether loans using this covenant package are eligible for syndication in the secondary loan market.',
    `testing_frequency` STRING COMMENT 'Frequency at which covenant compliance is formally tested and evaluated by the lender.',
    `usage_count` STRING COMMENT 'Total number of active loan agreements currently using this covenant package.',
    `version_number` STRING COMMENT 'Version identifier for the covenant package, incremented when material changes are made to package terms or covenant definitions.',
    `waiver_authority_level` STRING COMMENT 'Organizational level required to approve waivers or amendments to covenants within this package.',
    CONSTRAINT pk_covenant_package PRIMARY KEY(`covenant_package_id`)
) COMMENT 'Master reference table for covenant_package. Referenced by package_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ADD CONSTRAINT `fk_loan_amortization_schedule_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_covenant_package_id` FOREIGN KEY (`covenant_package_id`) REFERENCES `banking_ecm`.`loan`.`covenant_package`(`covenant_package_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ADD CONSTRAINT `fk_loan_loan_syndication_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ADD CONSTRAINT `fk_loan_lender_participation_loan_syndication_id` FOREIGN KEY (`loan_syndication_id`) REFERENCES `banking_ecm`.`loan`.`loan_syndication`(`loan_syndication_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ADD CONSTRAINT `fk_loan_loan_fee_schedule_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_trade_facility_id` FOREIGN KEY (`trade_facility_id`) REFERENCES `banking_ecm`.`loan`.`trade_facility`(`trade_facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_trade_facility_id` FOREIGN KEY (`trade_facility_id`) REFERENCES `banking_ecm`.`loan`.`trade_facility`(`trade_facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_guarantee_id` FOREIGN KEY (`guarantee_id`) REFERENCES `banking_ecm`.`loan`.`guarantee`(`guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ADD CONSTRAINT `fk_loan_bill_of_lading_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ADD CONSTRAINT `fk_loan_bill_of_lading_forfaiting_id` FOREIGN KEY (`forfaiting_id`) REFERENCES `banking_ecm`.`loan`.`forfaiting`(`forfaiting_id`);
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ADD CONSTRAINT `fk_loan_bill_of_lading_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ADD CONSTRAINT `fk_loan_bill_of_lading_trade_finance_transaction_id` FOREIGN KEY (`trade_finance_transaction_id`) REFERENCES `banking_ecm`.`loan`.`trade_finance_transaction`(`trade_finance_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ADD CONSTRAINT `fk_loan_supply_chain_program_trade_facility_id` FOREIGN KEY (`trade_facility_id`) REFERENCES `banking_ecm`.`loan`.`trade_facility`(`trade_facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ADD CONSTRAINT `fk_loan_trade_facility_covenant_package_id` FOREIGN KEY (`covenant_package_id`) REFERENCES `banking_ecm`.`loan`.`covenant_package`(`covenant_package_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ADD CONSTRAINT `fk_loan_trade_utilization_trade_facility_id` FOREIGN KEY (`trade_facility_id`) REFERENCES `banking_ecm`.`loan`.`trade_facility`(`trade_facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ADD CONSTRAINT `fk_loan_forfaiting_trade_facility_id` FOREIGN KEY (`trade_facility_id`) REFERENCES `banking_ecm`.`loan`.`trade_facility`(`trade_facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_bank_guarantee_id` FOREIGN KEY (`bank_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`bank_guarantee`(`bank_guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ADD CONSTRAINT `fk_loan_trade_settlement_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ADD CONSTRAINT `fk_loan_compliance_check_document_presentation_id` FOREIGN KEY (`document_presentation_id`) REFERENCES `banking_ecm`.`loan`.`document_presentation`(`document_presentation_id`);
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ADD CONSTRAINT `fk_loan_compliance_check_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ADD CONSTRAINT `fk_loan_compliance_check_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ADD CONSTRAINT `fk_loan_compliance_check_trade_finance_transaction_id` FOREIGN KEY (`trade_finance_transaction_id`) REFERENCES `banking_ecm`.`loan`.`trade_finance_transaction`(`trade_finance_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ADD CONSTRAINT `fk_loan_sanctions_screening_bank_guarantee_id` FOREIGN KEY (`bank_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`bank_guarantee`(`bank_guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ADD CONSTRAINT `fk_loan_sanctions_screening_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ADD CONSTRAINT `fk_loan_sanctions_screening_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ADD CONSTRAINT `fk_loan_sanctions_screening_trade_finance_transaction_id` FOREIGN KEY (`trade_finance_transaction_id`) REFERENCES `banking_ecm`.`loan`.`trade_finance_transaction`(`trade_finance_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_bank_guarantee_id` FOREIGN KEY (`bank_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`bank_guarantee`(`bank_guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ADD CONSTRAINT `fk_loan_trade_event_linked_event_trade_event_id` FOREIGN KEY (`linked_event_trade_event_id`) REFERENCES `banking_ecm`.`loan`.`trade_event`(`trade_event_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_parent_guarantee_id` FOREIGN KEY (`parent_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`guarantee`(`guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_drawdown_id` FOREIGN KEY (`drawdown_id`) REFERENCES `banking_ecm`.`loan`.`drawdown`(`drawdown_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_reversal_disbursement_id` FOREIGN KEY (`reversal_disbursement_id`) REFERENCES `banking_ecm`.`loan`.`disbursement`(`disbursement_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`insurance` ADD CONSTRAINT `fk_loan_insurance_previous_loan_insurance_id` FOREIGN KEY (`previous_loan_insurance_id`) REFERENCES `banking_ecm`.`loan`.`insurance`(`insurance_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_previous_loan_pricing_id` FOREIGN KEY (`previous_loan_pricing_id`) REFERENCES `banking_ecm`.`loan`.`pricing`(`pricing_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ADD CONSTRAINT `fk_loan_loan_collateral_pledge_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ADD CONSTRAINT `fk_loan_stress_projection_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ADD CONSTRAINT `fk_loan_stress_test_result_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ADD CONSTRAINT `fk_loan_facility_cfp_assumption_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_bank_guarantee_id` FOREIGN KEY (`bank_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`bank_guarantee`(`bank_guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ADD CONSTRAINT `fk_loan_trade_finance_transaction_reversal_trade_finance_transaction_id` FOREIGN KEY (`reversal_trade_finance_transaction_id`) REFERENCES `banking_ecm`.`loan`.`trade_finance_transaction`(`trade_finance_transaction_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ADD CONSTRAINT `fk_loan_document_presentation_previous_document_presentation_id` FOREIGN KEY (`previous_document_presentation_id`) REFERENCES `banking_ecm`.`loan`.`document_presentation`(`document_presentation_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` ADD CONSTRAINT `fk_loan_covenant_package_predecessor_package_id` FOREIGN KEY (`predecessor_package_id`) REFERENCES `banking_ecm`.`loan`.`covenant_package`(`covenant_package_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` ADD CONSTRAINT `fk_loan_covenant_package_parent_covenant_package_id` FOREIGN KEY (`parent_covenant_package_id`) REFERENCES `banking_ecm`.`loan`.`covenant_package`(`covenant_package_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`loan` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`loan` SET TAGS ('dbx_domain' = 'loan');
ALTER TABLE `banking_ecm`.`loan`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`facility` SET TAGS ('dbx_subdomain' = 'loan_origination');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower ID');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `transfer_pricing_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `agent_bank_flag` SET TAGS ('dbx_business_glossary_term' = 'Agent Bank Flag');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `all_in_rate` SET TAGS ('dbx_business_glossary_term' = 'All-In Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Amortization Type');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'bullet|amortizing|interest_only|balloon|revolving');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `bank_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Hold Amount');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `bank_hold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `bank_hold_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `committed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `covenant_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Covenant Breach Flag');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `drawn_amount` SET TAGS ('dbx_business_glossary_term' = 'Drawn Amount');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `drawn_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `drawn_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Number');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|matured|defaulted|written_off|cancelled|pending_approval');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'revolving_credit|term_loan|mortgage|consumer_loan|syndicated_loan|letter_of_credit');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `first_drawdown_date` SET TAGS ('dbx_business_glossary_term' = 'First Drawdown Date');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Credit Impairment Stage');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `interest_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Basis');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `interest_rate_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Spread (BPS — Basis Points)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `loan_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Loan Purpose Code');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `npl_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Flag');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `originating_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Code');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Origination Date');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `regulatory_segment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exposure Segment');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `regulatory_segment` SET TAGS ('dbx_value_regex' = 'retail|corporate|sovereign|financial_institution|SME|specialized_lending');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `repayment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Repayment Frequency');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `repayment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|bullet');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Review Date');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `syndicated_flag` SET TAGS ('dbx_business_glossary_term' = 'Syndicated Facility Flag');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `undrawn_amount` SET TAGS ('dbx_business_glossary_term' = 'Undrawn Amount');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `undrawn_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `undrawn_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` SET TAGS ('dbx_subdomain' = 'loan_origination');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `credit_application_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Application ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Channel');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_channel` SET TAGS ('dbx_value_regex' = 'branch|online|mobile|phone|broker|direct_sales');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Number');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Type');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new|renewal|refinance|modification|increase|restructure');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Amount');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `approved_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Approved Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `approved_term_months` SET TAGS ('dbx_business_glossary_term' = 'Approved Loan Term in Months');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `collateral_offered` SET TAGS ('dbx_business_glossary_term' = 'Collateral Offering Status');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `collateral_offered` SET TAGS ('dbx_value_regex' = 'secured|unsecured|partially_secured');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type Description');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Estimated Value');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `conditions_precedent` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `credit_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Committee Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `financial_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Submission Date');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `kyc_completed` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completed Flag');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `loan_purpose` SET TAGS ('dbx_business_glossary_term' = 'Loan Purpose');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Credit Amount');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `requested_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `requested_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `requested_term_months` SET TAGS ('dbx_business_glossary_term' = 'Requested Loan Term in Months');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `total_assets` SET TAGS ('dbx_business_glossary_term' = 'Total Assets');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `total_assets` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved|declined|referred|conditional_approval|withdrawn');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `transfer_pricing_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Number');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|delinquent|npl|charged_off|closed|suspended');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `accrued_fees` SET TAGS ('dbx_business_glossary_term' = 'Accrued Fees');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `charge_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge-Off Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `charge_off_date` SET TAGS ('dbx_business_glossary_term' = 'Charge-Off Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `cure_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `current_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Current Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360|actual_actual');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `delinquency_bucket` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Bucket (Days Past Due)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `delinquency_bucket` SET TAGS ('dbx_value_regex' = 'current|dpd_1_30|dpd_31_60|dpd_61_90|dpd_91_plus');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `ecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `forbearance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forbearance End Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `forbearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Forbearance Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `forbearance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forbearance Start Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|floating');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `loan_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `loan_type` SET TAGS ('dbx_value_regex' = 'term_loan|revolving_credit|mortgage|syndicated_loan|trade_finance|letter_of_credit');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `npl_classification` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Classification');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `npl_classification` SET TAGS ('dbx_value_regex' = 'performing|substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `npl_classification_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Classification Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `npl_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Trigger Event');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `npl_trigger_event` SET TAGS ('dbx_value_regex' = 'dpd_90_plus|bankruptcy|default|covenant_breach|charge_off');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `original_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Loan Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Origination Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `outstanding_principal_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal Balance');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|bullet');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `rate_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Reset Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `rate_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread (Basis Points)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `regulatory_classification_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Basis');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `regulatory_classification_basis` SET TAGS ('dbx_value_regex' = 'occ|basel_iii|ifrs_9|cecl');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `risk_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `total_exposure` SET TAGS ('dbx_business_glossary_term' = 'Total Exposure');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `watch_list_date` SET TAGS ('dbx_business_glossary_term' = 'Watch List Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `watch_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Watch List Flag');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `amortization_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Amortization Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `accrual_days` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Days');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `accrual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual End Date');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `accrual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Start Date');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `actual_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Interest Amount Applied');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `actual_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Amount Received');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `actual_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Principal Amount Applied');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Amortization Type');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'level payment|level principal|bullet|balloon|custom');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `beginning_balance` SET TAGS ('dbx_business_glossary_term' = 'Beginning Principal Balance');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = '30/360|Actual/365|Actual/360|Actual/Actual|30E/360');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `ending_balance` SET TAGS ('dbx_business_glossary_term' = 'Ending Principal Balance');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Sequence Number');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `is_final_payment` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Indicator');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `is_restructured` SET TAGS ('dbx_business_glossary_term' = 'Restructured Installment Flag');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|bi-weekly|weekly');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|cash|card|internal transfer');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|paid|partial|overdue|waived|deferred');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `prepayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Amount');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `restructure_date` SET TAGS ('dbx_business_glossary_term' = 'Restructure Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `schedule_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Generation Date');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `scheduled_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `scheduled_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Interest Payment Amount');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `scheduled_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Principal Payment Amount');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Payment Amount');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `waived_amount` SET TAGS ('dbx_business_glossary_term' = 'Waived Amount');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `drawdown_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|escalated');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Amount');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `available_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Commitment Amount');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `commitment_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Commitment Utilization Percentage (PCT)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Currency');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `disbursement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `drawdown_date` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Date');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `drawdown_status` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Status');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `drawdown_type` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Type');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `drawdown_type` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|revolving|term|swing_line|overdraft');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_business_glossary_term' = 'Funding Account Number');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `funding_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `interest_period_days` SET TAGS ('dbx_business_glossary_term' = 'Interest Period in Days');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|variable|zero');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `loan_to_value_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ACH|RTGS|SWIFT|internal_transfer|check');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Purpose');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `repayment_type` SET TAGS ('dbx_business_glossary_term' = 'Repayment Type');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `repayment_type` SET TAGS ('dbx_value_regex' = 'bullet|amortizing|revolving|on_demand');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `risk_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage (PCT)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `syndication_flag` SET TAGS ('dbx_business_glossary_term' = 'Syndication Flag');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `trade_finance_reference` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Reference');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`repayment` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `repayment_id` SET TAGS ('dbx_business_glossary_term' = 'Repayment Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `ctr_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ctr Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `outstanding_balance_after_payment` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance After Payment');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'Branch|Online Banking|Mobile App|ATM|Phone Banking|Mail');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire|RTGS|Check|Cash|Direct Debit');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_processor_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Received|Applied|Reversed|Failed|Pending');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_timeliness` SET TAGS ('dbx_business_glossary_term' = 'Payment Timeliness');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_timeliness` SET TAGS ('dbx_value_regex' = 'On-Time|Early|Late');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'Scheduled|Prepayment|Partial|Balloon|Final');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `penalty_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Interest Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `prepayment_flag` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Flag');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `source_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Source Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `source_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Waiver Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`loan`.`covenant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`covenant` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_id` SET TAGS ('dbx_business_glossary_term' = 'Covenant Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_package_id` SET TAGS ('dbx_business_glossary_term' = 'Covenant Package Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `breach_consequence` SET TAGS ('dbx_business_glossary_term' = 'Breach Consequence Description');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_category` SET TAGS ('dbx_business_glossary_term' = 'Covenant Category');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_description` SET TAGS ('dbx_business_glossary_term' = 'Covenant Description');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_name` SET TAGS ('dbx_business_glossary_term' = 'Covenant Name');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_status` SET TAGS ('dbx_business_glossary_term' = 'Covenant Status');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_status` SET TAGS ('dbx_value_regex' = 'active|suspended|waived|terminated|breached|cured');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_type` SET TAGS ('dbx_business_glossary_term' = 'Covenant Type');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_type` SET TAGS ('dbx_value_regex' = 'financial|affirmative|negative|reporting|information');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `cross_default_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Flag');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `cure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Cure Mechanism Description');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `cure_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Cure Provision Flag');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `financial_statement_source` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Source');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `financial_statement_source` SET TAGS ('dbx_value_regex' = 'audited|unaudited|management_certified|regulatory_filing');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `materiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Materiality Classification');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `materiality_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `measurement_basis` SET TAGS ('dbx_business_glossary_term' = 'Measurement Basis');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|on_demand|event_driven');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Covenant Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `reporting_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Days');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'borrower|guarantor|parent_company|subsidiary');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `testing_level` SET TAGS ('dbx_business_glossary_term' = 'Testing Level');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `testing_level` SET TAGS ('dbx_value_regex' = 'consolidated|standalone|guarantor_group|restricted_group');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Covenant Threshold Value');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `waiver_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `loan_ecl_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Expected Credit Loss (ECL) Provision ID');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `accounting_framework` SET TAGS ('dbx_business_glossary_term' = 'Accounting Framework');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `accounting_framework` SET TAGS ('dbx_value_regex' = 'IFRS 9|CECL|Local GAAP');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `credit_impaired_indicator` SET TAGS ('dbx_business_glossary_term' = 'Credit Impaired Indicator');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `cumulative_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Provision Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `ead` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `ecl_model_code` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Model Code');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `forbearance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Forbearance Indicator');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `lgd` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `override_indicator` SET TAGS ('dbx_business_glossary_term' = 'Override Indicator');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `pd` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `previous_stage_classification` SET TAGS ('dbx_business_glossary_term' = 'Previous Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `previous_stage_classification` SET TAGS ('dbx_value_regex' = 'Stage 1|Stage 2|Stage 3|12-Month ECL|Lifetime ECL|Credit-Impaired');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Provision Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_currency` SET TAGS ('dbx_business_glossary_term' = 'Provision Currency');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_movement_amount` SET TAGS ('dbx_business_glossary_term' = 'Provision Movement Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Provision Movement Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_movement_type` SET TAGS ('dbx_value_regex' = 'New|Increase|Decrease|Release|Write-Off|Transfer');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `provision_number` SET TAGS ('dbx_business_glossary_term' = 'Provision Number');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `recovery_rate` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `regulatory_reporting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `reporting_period_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `scenario_weight` SET TAGS ('dbx_business_glossary_term' = 'Scenario Weight');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `significant_increase_indicator` SET TAGS ('dbx_business_glossary_term' = 'Significant Increase in Credit Risk Indicator');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `stage_classification` SET TAGS ('dbx_business_glossary_term' = 'Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `stage_classification` SET TAGS ('dbx_value_regex' = 'Stage 1|Stage 2|Stage 3|12-Month ECL|Lifetime ECL|Credit-Impaired');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `stage_migration_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Migration Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `time_to_default_months` SET TAGS ('dbx_business_glossary_term' = 'Time to Default (Months)');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `loan_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Syndication Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Arranger Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `allocation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Allocation Methodology');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `allocation_methodology` SET TAGS ('dbx_value_regex' = 'first_come_first_served|relationship_based|pro_rata_scale|tiered_priority');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `arranger_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Arranger Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `arranger_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `borrower_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Borrower Consent Required Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Close Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `commitment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Deadline Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `confidentiality_tier` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Tier');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `confidentiality_tier` SET TAGS ('dbx_value_regex' = 'public|private|highly_confidential');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Documentation Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'lma_standard|lsta_standard|custom|bilateral_form');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `final_pricing_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Final Pricing Spread (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `flex_exercised_flag` SET TAGS ('dbx_business_glossary_term' = 'Flex Exercised Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `green_loan_flag` SET TAGS ('dbx_business_glossary_term' = 'Green Loan Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `lender_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Lender Meeting Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `mandate_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `market_flex_provision` SET TAGS ('dbx_business_glossary_term' = 'Market Flex Provision');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `market_flex_provision` SET TAGS ('dbx_value_regex' = 'none|pricing_flex|structure_flex|full_flex');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `minimum_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Hold Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `number_of_lenders` SET TAGS ('dbx_business_glossary_term' = 'Number of Lenders');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `original_pricing_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Original Pricing Spread (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `oversubscription_amount` SET TAGS ('dbx_business_glossary_term' = 'Oversubscription Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `oversubscription_flag` SET TAGS ('dbx_business_glossary_term' = 'Oversubscription Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `pro_rata_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Pro Rata Sharing Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Syndication Purpose');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Syndication Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^SYN-[A-Z0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `regulatory_hold_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Limit Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `sustainability_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Linked Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_value_regex' = 'mandate_awarded|structuring|marketing|allocation|closed|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `syndication_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `syndication_type` SET TAGS ('dbx_value_regex' = 'club_deal|broadly_syndicated|best_efforts|underwritten|sub_participation');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `total_syndicated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Syndicated Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `transfer_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `transfer_restriction_type` SET TAGS ('dbx_value_regex' = 'freely_transferable|consent_required|restricted_list|prohibited');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `upfront_fee_bps` SET TAGS ('dbx_business_glossary_term' = 'Upfront Fee (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`loan_syndication` ALTER COLUMN `voting_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Voting Threshold Percentage');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `lender_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Lender Participation Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `loan_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Syndicated Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Lender Institution Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `syndication_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `collateral_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Collateral Allocation Percentage');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `commitment_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Commitment Fee Rate');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Participation Flag');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Funded Amount');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Participation Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_role` SET TAGS ('dbx_value_regex' = 'lead_arranger|bookrunner|agent|co_agent|participant|underwriter');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|pending|settled|terminated|defaulted|transferred');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_value_regex' = 'primary|sub_participation|assignment|novation|risk_participation|funded_participation');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `pro_rata_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pro-Rata Share Percentage');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reversed|reconciled');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `stage_classification` SET TAGS ('dbx_business_glossary_term' = 'Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `stage_classification` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `syndication_tier` SET TAGS ('dbx_business_glossary_term' = 'Syndication Tier');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `syndication_tier` SET TAGS ('dbx_value_regex' = 'senior|mezzanine|subordinated|junior');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `transfer_premium_discount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Premium or Discount');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `transfer_premium_discount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `transfer_price` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `transfer_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `unfunded_commitment` SET TAGS ('dbx_business_glossary_term' = 'Unfunded Commitment');
ALTER TABLE `banking_ecm`.`loan`.`lender_participation` ALTER COLUMN `voting_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `loan_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `accrual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual End Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `accrual_frequency` SET TAGS ('dbx_business_glossary_term' = 'Accrual Frequency');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `accrual_frequency` SET TAGS ('dbx_value_regex' = 'one_time|daily|monthly|quarterly|semi_annually|annually');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `accrual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Start Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `amendment_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Sequence Number');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `applicability_condition` SET TAGS ('dbx_business_glossary_term' = 'Applicability Condition');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annually|annually|on_demand');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'flat_amount|percentage_of_facility|percentage_of_undrawn|percentage_of_outstanding|tiered');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|waived|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'origination|commitment|agency|amendment|prepayment_penalty|late_payment');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `last_accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accrual Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Notes');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `outstanding_receivable_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Receivable Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|partially_paid|paid_in_full|waived');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_value_regex' = 'interest_income|non_interest_income|fee_income|other_operating_income');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'immediate|straight_line|effective_interest|proportional');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `syndication_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Syndication Allocation Method');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `syndication_allocation_method` SET TAGS ('dbx_value_regex' = 'pro_rata|lead_arranger_only|agent_only|custom');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'taxable|tax_exempt|withholding_required|vat_applicable');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `total_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Accrued Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_fee_schedule` ALTER COLUMN `waiver_authority` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authority');
ALTER TABLE `banking_ecm`.`loan`.`modification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`modification` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_id` SET TAGS ('dbx_business_glossary_term' = 'Modification Identifier');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Modification Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `approving_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Level');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `approving_authority_level` SET TAGS ('dbx_value_regex' = 'branch_manager|regional_credit_officer|chief_credit_officer|credit_committee|board_of_directors');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `cecl_stage_after` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Loss (CECL) Stage After Modification');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `cecl_stage_after` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `cecl_stage_before` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Loss (CECL) Stage Before Modification');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `cecl_stage_before` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `collateral_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Adjustment Flag');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `covenant_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Covenant Waiver Flag');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Execution Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Modification Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Modification Fee Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `forbearance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forbearance End Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Modification Gain or Loss Amount');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `is_tdr` SET TAGS ('dbx_business_glossary_term' = 'Troubled Debt Restructuring (TDR) Flag');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `legal_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Documentation Reference');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_number` SET TAGS ('dbx_business_glossary_term' = 'Modification Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_status` SET TAGS ('dbx_business_glossary_term' = 'Modification Status');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|executed|rejected|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_type` SET TAGS ('dbx_value_regex' = 'maturity_extension|rate_reduction|principal_forgiveness|payment_deferral|forbearance|covenant_waiver');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modified_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Modified Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modified_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Modified Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modified_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Modified Principal Amount');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `npl_status_after` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Status After Modification');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `npl_status_after` SET TAGS ('dbx_value_regex' = 'performing|non_performing|substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `npl_status_before` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Status Before Modification');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `npl_status_before` SET TAGS ('dbx_value_regex' = 'performing|non_performing|substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `original_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `original_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Original Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `original_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Principal Amount');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `payment_deferral_months` SET TAGS ('dbx_business_glossary_term' = 'Payment Deferral Period (Months)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `principal_forgiveness_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Forgiveness Amount');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Modification Rationale');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Request Date');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `collateral_link_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `hqla_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Hqla Inventory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Collateral Allocation Percentage');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `cross_collateralization_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Collateralization Flag');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `cross_default_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Flag');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `current_collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Collateral Value Amount');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `current_ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Current Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `current_value_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Current Value As-Of Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `eligible_collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value Amount');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Collateral Haircut Percentage');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Insurance Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Collateral Insurance Policy Number');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Insurance Required Flag');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `last_revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collateral Revaluation Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `lender_loss_payee_flag` SET TAGS ('dbx_business_glossary_term' = 'Lender Loss Payee Flag');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `lien_position` SET TAGS ('dbx_business_glossary_term' = 'Lien Position');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `lien_position` SET TAGS ('dbx_value_regex' = 'first|second|third|subordinate|pari_passu');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `link_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `link_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Status');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|released|substituted|impaired|foreclosed');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `link_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Termination Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `ltv_ratio_at_origination` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio at Origination');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Status');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_value_regex' = 'none|pending|issued|cured|defaulted');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `margin_call_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Threshold Percentage');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `next_revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Collateral Revaluation Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Notes');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_date` SET TAGS ('dbx_business_glossary_term' = 'Lien Perfection Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Code');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_method` SET TAGS ('dbx_business_glossary_term' = 'Lien Perfection Method');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_method` SET TAGS ('dbx_value_regex' = 'ucc_filing|mortgage_registration|title_notation|control_agreement|possession');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_status` SET TAGS ('dbx_business_glossary_term' = 'Lien Perfection Status');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `perfection_status` SET TAGS ('dbx_value_regex' = 'perfected|pending|unperfected|lapsed');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `pledged_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Pledged Value Amount');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `pledged_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Pledged Value Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `pledged_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `revaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Collateral Revaluation Frequency');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `revaluation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|event_driven');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `ucc_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Uniform Commercial Code (UCC) Filing Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `ucc_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Uniform Commercial Code (UCC) Filing Number');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`write_off` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `capital_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Journal Entry Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `loss_recovery_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Recovery Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'credit_committee|chief_credit_officer|board_of_directors|delegated_authority');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `call_report_schedule` SET TAGS ('dbx_business_glossary_term' = 'Call Report Schedule Reference');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `charge_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Charge-Off Reason Code');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `charge_off_reason_code` SET TAGS ('dbx_value_regex' = 'bankruptcy|deceased|fraud|uncollectable|statute_of_limitations|other');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `charge_off_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Charge-Off Reason Description');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `collateral_liquidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Liquidation Flag');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `collateral_liquidation_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Collateral Liquidation Proceeds');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `cumulative_recovery_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Recovery to Date');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `days_past_due_at_write_off` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due at Write-Off');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `debt_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Debt Sale Date');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `debt_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Debt Sale Flag');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `debt_sale_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Debt Sale Proceeds');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `ead_at_default` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `ecl_reserve_released_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Reserve Released Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `fees_written_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Fees Written-Off Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `guarantor_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Call Flag');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `guarantor_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Recovery Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `interest_written_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Written-Off Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `lgd_rate` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Rate');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `net_charge_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge-Off Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `net_loss_after_recovery` SET TAGS ('dbx_business_glossary_term' = 'Net Loss After Recovery');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `npl_classification_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Classification Date');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `principal_written_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Written-Off Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `recovery_pursuit_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Pursuit Status');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `recovery_pursuit_status` SET TAGS ('dbx_value_regex' = 'active_pursuit|suspended|closed_no_recovery|closed_partial_recovery|closed_full_recovery');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `regulatory_classification_at_write_off` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification at Write-Off');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `regulatory_classification_at_write_off` SET TAGS ('dbx_value_regex' = 'substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `total_write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Write-Off Amount');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|posted|reversed|closed');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Type');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_value_regex' = 'full_charge_off|partial_charge_off|technical_write_off|regulatory_write_off');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `collateral_revaluation_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Revaluation Flag');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `covenant_compliance_summary` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Summary');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `covenant_compliance_summary` SET TAGS ('dbx_value_regex' = 'compliant|minor_breach|material_breach|waived|not_applicable');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `credit_committee_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Committee Sign-Off Date');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `credit_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Credit Committee Decision');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `credit_committee_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|deferred|referred');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `ecl_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `financial_performance_assessment` SET TAGS ('dbx_business_glossary_term' = 'Financial Performance Assessment');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `financial_performance_assessment` SET TAGS ('dbx_value_regex' = 'strong|satisfactory|adequate|weak|poor');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `industry_outlook` SET TAGS ('dbx_business_glossary_term' = 'Industry Outlook');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `industry_outlook` SET TAGS ('dbx_value_regex' = 'positive|stable|cautious|negative|distressed');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `npl_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Flag');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `previous_internal_rating` SET TAGS ('dbx_business_glossary_term' = 'Previous Internal Risk Rating');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `previous_lgd` SET TAGS ('dbx_business_glossary_term' = 'Previous Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `previous_pd` SET TAGS ('dbx_business_glossary_term' = 'Previous Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'maintain|upgrade|downgrade|watchlist|exit|restructure');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Classification');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'pass|special_mention|substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Comments');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Status');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|deferred');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Type');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|interim|triggered|special|renewal|watchlist');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `stage_classification` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `stage_classification` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lc` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`lc` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) ID');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Expiry Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Issuance Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Officer Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `trade_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `advising_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Advising Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `advising_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Amount');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `applicable_rules` SET TAGS ('dbx_business_glossary_term' = 'Applicable Rules');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `applicable_rules` SET TAGS ('dbx_value_regex' = 'UCP_600|eUCP|ISP98|UCP_500|URDG_758');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Amount');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `confirming_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Confirming Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `confirming_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `expiry_place` SET TAGS ('dbx_business_glossary_term' = 'Expiry Place');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `issuing_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `issuing_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `latest_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Shipment Date');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `lc_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `lc_status` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Status');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `lc_type` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Type');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `lc_type` SET TAGS ('dbx_value_regex' = 'sight|usance|deferred_payment|acceptance|standby|transferable');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `partial_shipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Allowed');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `port_of_discharge` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `presentation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Presentation Period Days');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `reimbursement_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `reimbursement_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `reimbursement_instructions` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Instructions');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `revolving_flag` SET TAGS ('dbx_business_glossary_term' = 'Revolving Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `revolving_frequency` SET TAGS ('dbx_business_glossary_term' = 'Revolving Frequency');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `revolving_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|per_shipment');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Subtype');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `subtype` SET TAGS ('dbx_value_regex' = 'revolving|back_to_back|red_clause|green_clause|standard');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `transhipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transhipment Allowed');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Amount');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `lc_drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Drawing ID');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiating Bank ID');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) ID');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amended_field_name` SET TAGS ('dbx_business_glossary_term' = 'Amended Field Name');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Compliance Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'amount_increase|amount_decrease|expiry_extension|condition_change|document_modification|beneficiary_change');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `available_balance_after_transaction` SET TAGS ('dbx_business_glossary_term' = 'Available Balance After Transaction');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `beneficiary_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Acceptance Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `beneficiary_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Acceptance Status');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `beneficiary_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `discrepancy_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Code');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `document_set_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Set Reference');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `drawing_amount` SET TAGS ('dbx_business_glossary_term' = 'Drawing Amount');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `drawing_currency` SET TAGS ('dbx_business_glossary_term' = 'Drawing Currency');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `drawing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `honour_decision` SET TAGS ('dbx_business_glossary_term' = 'Honour Decision');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `honour_decision` SET TAGS ('dbx_value_regex' = 'honoured|dishonoured|deferred|pending');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `honour_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Honour Decision Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `issuing_bank_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `negotiation_flag` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `partial_drawing_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Drawing Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `prior_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Value');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|partially_settled|failed|reversed');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_value_regex' = 'MT700|MT707|MT710|MT720|MT750|MT760');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|accepted|settled|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'amendment|drawing');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `waiver_request_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `waiver_response_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Response Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `waiver_status` SET TAGS ('dbx_value_regex' = 'not_applicable|requested|granted|denied|pending');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Identifier');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Officer Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Drawer Party Identifier');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `tertiary_documentary_case_of_need_party_id` SET TAGS ('dbx_business_glossary_term' = 'Case of Need Party Identifier');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `trade_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|escalated');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `case_of_need_instructions` SET TAGS ('dbx_business_glossary_term' = 'Case of Need Instructions');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `charges_allocation` SET TAGS ('dbx_business_glossary_term' = 'Charges Allocation');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `charges_allocation` SET TAGS ('dbx_value_regex' = 'drawer|drawee|shared');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Charges Amount');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `charges_currency` SET TAGS ('dbx_business_glossary_term' = 'Charges Currency');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `charges_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collecting_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Collecting Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collecting_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_amount` SET TAGS ('dbx_business_glossary_term' = 'Collection Amount');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_currency` SET TAGS ('dbx_business_glossary_term' = 'Collection Currency');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Collection Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_value_regex' = 'documents_against_payment|documents_against_acceptance|clean_collection');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_value_regex' = 'deliver_against_payment|deliver_against_acceptance|deliver_without_payment');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `dishonour_reason` SET TAGS ('dbx_business_glossary_term' = 'Dishonour Reason');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `document_set_description` SET TAGS ('dbx_business_glossary_term' = 'Document Set Description');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `drawee_name` SET TAGS ('dbx_business_glossary_term' = 'Drawee Name');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `drawer_name` SET TAGS ('dbx_business_glossary_term' = 'Drawer Name');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `number_of_documents` SET TAGS ('dbx_business_glossary_term' = 'Number of Documents');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `partial_payment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Allowed Flag');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `protest_instructions` SET TAGS ('dbx_business_glossary_term' = 'Protest Instructions');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `protest_instructions` SET TAGS ('dbx_value_regex' = 'protest|do_not_protest');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `remitting_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Remitting Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `remitting_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_value_regex' = 'MT400|MT410|MT412|MT416|MT420|MT422');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `tenor_basis` SET TAGS ('dbx_business_glossary_term' = 'Tenor Basis');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `tenor_basis` SET TAGS ('dbx_value_regex' = 'sight|date_of_acceptance|date_of_bill|date_of_shipment');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor Days');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `underlying_trade_reference` SET TAGS ('dbx_business_glossary_term' = 'Underlying Trade Reference');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `bank_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Issuance Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Officer Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `auto_extension_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Extension Flag');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `claim_documents_received` SET TAGS ('dbx_business_glossary_term' = 'Claim Documents Received');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `claim_period_days` SET TAGS ('dbx_business_glossary_term' = 'Claim Period Days');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `claim_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Receipt Date');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `claim_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Sequence Number');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `claimant_identity` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identity');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `commission_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `counter_guaranteeing_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Counter-Guaranteeing Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `counter_guaranteeing_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `demand_indicator` SET TAGS ('dbx_business_glossary_term' = 'Demand Indicator');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `demand_indicator` SET TAGS ('dbx_value_regex' = 'on_demand|conditional');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `ecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision Amount');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Amount');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `guarantee_currency` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Currency');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `guarantee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `guarantee_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Status');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 9 (IFRS 9) Stage');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `issuance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Issuance Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `issuance_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Issuance Fee Currency');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `issuance_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `issuing_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `issuing_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `payment_decision` SET TAGS ('dbx_business_glossary_term' = 'Payment Decision');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `payment_decision` SET TAGS ('dbx_value_regex' = 'honour|reject|extend_or_pay');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `reduction_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reduction Schedule');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `rejection_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Notification Date');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `residual_guarantee_balance` SET TAGS ('dbx_business_glossary_term' = 'Residual Guarantee Balance');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `risk_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percent');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `underlying_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Underlying Contract Reference');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `urdg_compliance_assessment` SET TAGS ('dbx_business_glossary_term' = 'Uniform Rules for Demand Guarantees (URDG) 758 Compliance Assessment');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `urdg_compliance_assessment` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Examiner User Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Document Comments');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Compliant Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `discrepancy_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `document_amount` SET TAGS ('dbx_business_glossary_term' = 'Document Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `document_hash` SET TAGS ('dbx_business_glossary_term' = 'Document Cryptographic Hash');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `electronic_document_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Document (eUCP) Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `examination_date` SET TAGS ('dbx_business_glossary_term' = 'Document Examination Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `issuer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Document Issuer Identifier');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `issuer_name` SET TAGS ('dbx_business_glossary_term' = 'Document Issuer Name');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `number_of_originals` SET TAGS ('dbx_business_glossary_term' = 'Number of Original Documents');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `original_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Document Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Document Presentation Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Document Rejection Reason');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `storage_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Reference Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'SWIFT (Society for Worldwide Interbank Financial Telecommunication) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Waiver Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Waiver Granted Flag');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) ID');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `forfaiting_id` SET TAGS ('dbx_business_glossary_term' = 'Forfaiting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `trade_finance_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Transaction ID');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `bl_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) Number');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `bl_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) Status');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `bl_status` SET TAGS ('dbx_value_regex' = 'draft|issued|endorsed|surrendered|released|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `bl_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) Type');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `clauses_remarks` SET TAGS ('dbx_business_glossary_term' = 'Clauses and Remarks');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `clean_bl_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Bill of Lading (B/L) Flag');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `collateral_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Flag');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value Amount');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `collateral_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `collateral_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value Currency');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `collateral_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `container_numbers` SET TAGS ('dbx_business_glossary_term' = 'Container Numbers');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `endorsement_chain` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Chain');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `endorsement_chain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `freight_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `freight_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `freight_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|prepaid_and_collect');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `goods_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) Issue Date');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `notify_party_address` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Address');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `notify_party_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `notify_party_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `on_board_date` SET TAGS ('dbx_business_glossary_term' = 'On Board Date');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `original_bl_count` SET TAGS ('dbx_business_glossary_term' = 'Original Bill of Lading (B/L) Count');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `place_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Place of Delivery');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `place_of_receipt` SET TAGS ('dbx_business_glossary_term' = 'Place of Receipt');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Code');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `port_of_discharge_name` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Code');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `port_of_loading_name` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `surrendered_date` SET TAGS ('dbx_business_glossary_term' = 'Surrendered Date');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'cbm|cbf|liters');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `banking_ecm`.`loan`.`bill_of_lading` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'kg|lbs|mt|tons');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `supply_chain_program_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Finance (SCF) Program Identifier');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Anchor Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Analyst Identifier');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Anchor Buyer Identifier');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `trade_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `approved_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `auto_approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Threshold Amount');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Amount');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `current_utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Utilization Amount');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `dilution_reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Dilution Reserve Percentage');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `discount_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Basis');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `discount_rate_basis` SET TAGS ('dbx_value_regex' = 'sofr_spread|euribor_spread|libor_spread|fixed_rate');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `discount_rate_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Spread (Basis Points)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `ecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision Amount');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `eligible_supplier_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Supplier Criteria');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `fixed_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Fixed Discount Rate');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `ifrs9_stage_classification` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `ifrs9_stage_classification` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `last_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `maximum_tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tenor (Days)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `minimum_tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tenor (Days)');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Currency');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Program Documentation Reference');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Program Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Finance (SCF) Program Type');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'payables_finance|reverse_factoring|receivables_discounting|dynamic_discounting|inventory_finance|distributor_finance');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `supplier_onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Status');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `supplier_onboarding_status` SET TAGS ('dbx_value_regex' = 'open|restricted|closed');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `total_suppliers_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Total Suppliers Enrolled');
ALTER TABLE `banking_ecm`.`loan`.`supply_chain_program` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `trade_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `covenant_package_id` SET TAGS ('dbx_business_glossary_term' = 'Covenant Package Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `approved_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Limit Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `collateral_reference` SET TAGS ('dbx_business_glossary_term' = 'Collateral Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `country_of_risk` SET TAGS ('dbx_business_glossary_term' = 'Country of Risk Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `country_of_risk` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `eca_insurance_cover_percent` SET TAGS ('dbx_business_glossary_term' = 'Export Credit Agency (ECA) Insurance Cover Percentage');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `eca_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Export Credit Agency (ECA) Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `ecl_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `facility_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'proposed|approved|active|suspended|expired|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `facility_tenor_months` SET TAGS ('dbx_business_glossary_term' = 'Facility Tenor in Months');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `kyc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Limit Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `margin_requirement_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Requirement Percentage');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Notes');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `originating_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Origination Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Renewal Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Review Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `risk_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `sublimit_financing_amount` SET TAGS ('dbx_business_glossary_term' = 'Sublimit Financing Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `sublimit_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Sublimit Guarantee Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `sublimit_lc_amount` SET TAGS ('dbx_business_glossary_term' = 'Sublimit Letter of Credit (LC) Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_facility` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `trade_utilization_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Utilization ID');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral ID');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower ID');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `trade_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `ead_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `ecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `facility_headroom_after_utilization` SET TAGS ('dbx_business_glossary_term' = 'Facility Headroom After Utilization');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `instrument_reference` SET TAGS ('dbx_business_glossary_term' = 'Underlying Instrument Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `npl_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Product Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'letter_of_credit|bank_guarantee|trade_loan|scf_payables_finance|scf_receivables_discounting|forfaiting');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `repayment_status` SET TAGS ('dbx_business_glossary_term' = 'Repayment Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `repayment_status` SET TAGS ('dbx_value_regex' = 'outstanding|partially_repaid|fully_repaid|defaulted|written_off|restructured');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `risk_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percent');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `scf_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Finance (SCF) Approved Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `scf_early_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Finance (SCF) Early Payment Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `scf_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Finance (SCF) Invoice Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `scf_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Finance (SCF) Invoice Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|partially_settled|cancelled|expired');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor Days');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `ucp_600_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Uniform Customs and Practice (UCP) 600 Compliance Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `urdg_758_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Uniform Rules for Demand Guarantees (URDG) 758 Compliance Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilization Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `utilization_date` SET TAGS ('dbx_business_glossary_term' = 'Utilization Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `utilization_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Utilization Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_utilization` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `forfaiting_id` SET TAGS ('dbx_business_glossary_term' = 'Forfaiting Transaction ID');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Face Value Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Aval Provider Institution ID');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `forfaiting_guarantor_party_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Party ID');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `forfaiting_importer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Party ID');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `forfaiting_party_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Party ID');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `investment_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `trade_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `booking_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity Code');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `country_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Country Risk Classification Code');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `discount_basis` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Basis');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `discount_basis` SET TAGS ('dbx_value_regex' = 'fixed_rate|libor_plus_spread|sofr_plus_spread|euribor_plus_spread');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `ecl_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `exporter_country_code` SET TAGS ('dbx_business_glossary_term' = 'Exporter Country Code');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `exporter_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `face_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Value Amount');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `face_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Face Value Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `face_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_value_regex' = 'bank_guarantee|sovereign_guarantee|export_credit_agency|corporate_guarantee|none');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `ifrs9_stage_classification` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `ifrs9_stage_classification` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Forfaiting Origination Date');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Description');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Amount');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `purchase_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `purchase_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment Classification');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_value_regex' = 'banking_book|trading_book');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `risk_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Participation Percentage');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `secondary_market_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Secondary Market Sale Flag');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `secondary_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Secondary Market Sale Date');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `secondary_sale_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Sale Price Amount');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor in Days');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Forfaiting Transaction Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Forfaiting Transaction Status');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Forfaiting Transaction Type');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'primary_origination|secondary_market_purchase');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `underlying_instrument_reference` SET TAGS ('dbx_business_glossary_term' = 'Underlying Instrument Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `underlying_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Underlying Trade Instrument Type');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `underlying_instrument_type` SET TAGS ('dbx_value_regex' = 'promissory_note|bill_of_exchange|deferred_payment_lc|usance_draft|aval');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`forfaiting` ALTER COLUMN `without_recourse_flag` SET TAGS ('dbx_business_glossary_term' = 'Without Recourse Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `trade_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Settlement Identifier');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `bank_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|flagged|under_review|escalated');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `applicant_account_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant Account Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `applicant_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `applicant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `beneficiary_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `beneficiary_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `charge_basis` SET TAGS ('dbx_business_glossary_term' = 'Charge Basis');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Charge Rate');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `correspondent_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `fx_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `nostro_vostro_account_number` SET TAGS ('dbx_business_glossary_term' = 'Nostro or Vostro Account Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `nostro_vostro_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `nostro_vostro_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `original_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_line_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Line Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `waived_amount` SET TAGS ('dbx_business_glossary_term' = 'Waived Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_settlement` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Identifier');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `document_presentation_id` SET TAGS ('dbx_business_glossary_term' = 'Document Presentation Identifier');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Examiner User Identifier');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `trade_finance_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Transaction Identifier');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `advising_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Advising Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `applicant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Result');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `compliance_result` SET TAGS ('dbx_value_regex' = 'compliant|discrepant|conditional|pending_review|waived');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `credit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `discrepancy_codes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Codes');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `discrepancy_count` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Count');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `discrepancy_descriptions` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Descriptions');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Completion Date');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Date');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_status` SET TAGS ('dbx_business_glossary_term' = 'Examination Status');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|suspended|cancelled|escalated');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Examination Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_turnaround_banking_days` SET TAGS ('dbx_business_glossary_term' = 'Examination Turnaround Banking Days');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examination_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Examination Turnaround Hours');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Examiner Name');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `examiner_notes` SET TAGS ('dbx_business_glossary_term' = 'Examiner Notes');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `issuing_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `presentation_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Receipt Date');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `rule_set_framework` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Framework');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `rule_set_framework` SET TAGS ('dbx_value_regex' = 'UCP 600|eUCP 2.0|URDG 758|URC 522|ISBP 745|ISP98|URR 725');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Version');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `waiver_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Status');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `waiver_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired|not_applicable');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `waiver_request_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Date');
ALTER TABLE `banking_ecm`.`loan`.`compliance_check` ALTER COLUMN `waiver_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Flag');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Identifier');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `bank_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `trade_finance_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Transaction ID');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `analyst_review_status` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Status');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `analyst_review_status` SET TAGS ('dbx_value_regex' = 'pending_review|under_review|reviewed|escalated|closed');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `blocked_funds_amount` SET TAGS ('dbx_business_glossary_term' = 'Blocked Funds Amount');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `blocked_funds_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `blocked_funds_currency` SET TAGS ('dbx_business_glossary_term' = 'Blocked Funds Currency');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `blocked_funds_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'cleared|blocked|escalated|rejected|approved_with_conditions');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|compliance_manager|mlro|senior_management|legal|board');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_business_glossary_term' = 'Match Result');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `match_result` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match|false_positive');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `matched_list_entry` SET TAGS ('dbx_business_glossary_term' = 'Matched List Entry');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `matched_list_entry` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `matched_list_source` SET TAGS ('dbx_business_glossary_term' = 'Matched List Source');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `matched_list_source` SET TAGS ('dbx_value_regex' = 'OFAC_SDN|UN_CONSOLIDATED|EU_SANCTIONS|HMT_SANCTIONS|INTERPOL|NATIONAL_LIST');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `ofac_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Notification Date');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `ofac_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Notification Flag');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `sar_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Reference');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `sar_filing_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screened_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Identifier');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screened_entity_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Name');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screened_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screening_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Screening Algorithm Version');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screening_list_applied` SET TAGS ('dbx_business_glossary_term' = 'Screening List Applied');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screening_list_version` SET TAGS ('dbx_business_glossary_term' = 'Screening List Version');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screening_system_code` SET TAGS ('dbx_business_glossary_term' = 'Screening System Code');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`sanctions_screening` ALTER COLUMN `transaction_blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Transaction Blocked Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `trade_event_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `bank_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Examiner Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `linked_event_trade_event_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|rejected|failed|timeout');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|under_review|escalated');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `discrepancy_details` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Details');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `document_reference_numbers` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Numbers');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `examination_result` SET TAGS ('dbx_business_glossary_term' = 'Examination Result');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `examination_result` SET TAGS ('dbx_value_regex' = 'compliant|discrepant|waived|pending_review');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `message_direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `message_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Status');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `processing_channel` SET TAGS ('dbx_value_regex' = 'swift|telex|courier|electronic_platform|manual|correspondent_network');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `receiver_bic` SET TAGS ('dbx_business_glossary_term' = 'Receiver Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `receiver_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `sender_bic` SET TAGS ('dbx_business_glossary_term' = 'Sender Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `sender_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `triggering_party_role` SET TAGS ('dbx_business_glossary_term' = 'Triggering Party Role');
ALTER TABLE `banking_ecm`.`loan`.`trade_event` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `party_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_party_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `parent_guarantee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Amendment Count');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `call_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Call Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Call Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `capital_relief_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Coverage Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Coverage Percentage');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `cross_default_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Clause Flag');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Documentation Type');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `documentation_type` SET TAGS ('dbx_value_regex' = 'standalone|master_agreement|letter_of_credit|bank_guarantee|insurance_policy|parent_guarantee');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `ecl_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Adjustment Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `enforceability_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Enforceability Legal Opinion Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `enforceability_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Enforceability Status');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `enforceability_status` SET TAGS ('dbx_value_regex' = 'enforceable|unenforceable|under_review|disputed|conditionally_enforceable');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Expiry Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Governing Law Jurisdiction');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Status');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_value_regex' = 'active|expired|called|released|suspended|cancelled');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_value_regex' = 'full|partial|limited|unlimited|joint_and_several|conditional');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Type');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Issue Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `legal_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Documentation Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `payment_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Payment Received Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Payment Received Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `regulatory_capital_relief_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Eligible Flag');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `rwa_after_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) After Guarantee');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `rwa_before_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Before Guarantee');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` SET TAGS ('dbx_subdomain' = 'credit_servicing');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `drawdown_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Journal Entry ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `reversal_disbursement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|escalated');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Channel');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'branch|online|mobile|relationship_manager|automated');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `conditions_precedent_checklist` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent Checklist');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `conditions_precedent_satisfied_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent Satisfied Flag');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_account_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Account Name');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_account_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Destination Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Bank Name');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Destination Routing Number');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `destination_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|rtgs|check|internal_transfer|swift');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `partial_disbursement_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Disbursement Flag');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Purpose');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Sequence Number');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`insurance` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Identifier');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party Identifier');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `previous_loan_insurance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Beneficiary Name');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Cancellation Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Cancellation Reason');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `claim_count` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Count');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Compliance Status');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|coverage_gap|insufficient_coverage|expired');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Percentage');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Deductible Amount');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `force_placed_date` SET TAGS ('dbx_business_glossary_term' = 'Force-Placed Insurance Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `force_placed_flag` SET TAGS ('dbx_business_glossary_term' = 'Force-Placed Insurance Flag');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `insurer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Identifier');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Issue Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Insurance Claim Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `loss_payee_clause` SET TAGS ('dbx_business_glossary_term' = 'Insurance Loss Payee Clause Type');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `loss_payee_clause` SET TAGS ('dbx_value_regex' = 'first_loss_payee|mortgagee_clause|lender_loss_payee|standard_mortgagee|isaoa_atima');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Notes');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Status');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Type');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Payment Frequency');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|single_premium|bi_weekly');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Payment Method');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `premium_payment_method` SET TAGS ('dbx_value_regex' = 'borrower_paid|lender_paid|escrowed|financed|third_party_paid');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory-Required Insurance Flag');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Renewal Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `required_by_lender_flag` SET TAGS ('dbx_business_glossary_term' = 'Lender-Required Insurance Flag');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `total_claims_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Insurance Claims Paid Amount');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Date');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Method');
ALTER TABLE `banking_ecm`.`loan`.`insurance` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'certificate_of_insurance|policy_declaration|carrier_confirmation|electronic_verification|third_party_tracking_service');
ALTER TABLE `banking_ecm`.`loan`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`pricing` SET TAGS ('dbx_subdomain' = 'loan_origination');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing ID');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `previous_loan_pricing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `all_in_rate` SET TAGS ('dbx_business_glossary_term' = 'All-In Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `benchmark_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Code');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compounding Frequency');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360|actual_actual');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `default_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `default_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Default Spread Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Exception Flag');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `floor_rate` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `ftp_rate` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `lgd_at_pricing` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) at Pricing');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `margin_rate` SET TAGS ('dbx_business_glossary_term' = 'Margin Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Code');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `next_repricing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Repricing Date');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pd_at_pricing` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) at Pricing');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `prepayment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Rate');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Status');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|expired');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Type');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|hybrid|tiered|step_up|step_down');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `raroc_at_pricing` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Return on Capital (RAROC) at Pricing');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `rate_lock_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Lock Expiration Date');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `rate_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Lock Flag');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|hybrid');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Reference Number');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `relationship_discount_bps` SET TAGS ('dbx_business_glossary_term' = 'Relationship Discount Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `repricing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Repricing Frequency');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `risk_rating_at_pricing` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating at Pricing');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` SET TAGS ('dbx_association_edges' = 'loan.facility,collateral.collateral_asset');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `loan_collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'loan_collateral_pledge Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge - Collateral Asset Id');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge - Facility Id');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'real_estate|equipment|receivables|securities|cash|unsecured');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `cross_collateralization_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Collateralization Flag');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `lien_position` SET TAGS ('dbx_business_glossary_term' = 'Lien Position');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `link_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Link Effective Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `link_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Link Termination Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `margin_call_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Threshold Percentage');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `perfection_date` SET TAGS ('dbx_business_glossary_term' = 'Perfection Date');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `perfection_status` SET TAGS ('dbx_business_glossary_term' = 'Perfection Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `pledged_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Pledged Value Amount');
ALTER TABLE `banking_ecm`.`loan`.`loan_collateral_pledge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` SET TAGS ('dbx_association_edges' = 'loan.loan_account,risk.stress_scenario');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stress_projection_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Stress Projection Identifier');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Stress Projection - Loan Account Id');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Run Identifier');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Stress Projection - Stress Scenario Id');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `projection_date` SET TAGS ('dbx_business_glossary_term' = 'Projection Date');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stage_classification` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Stage Classification');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_balance` SET TAGS ('dbx_business_glossary_term' = 'Stressed Outstanding Balance');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_delinquency_bucket` SET TAGS ('dbx_business_glossary_term' = 'Stressed Delinquency Bucket');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_ecl_provision` SET TAGS ('dbx_business_glossary_term' = 'Stressed Expected Credit Loss Provision');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_lgd` SET TAGS ('dbx_business_glossary_term' = 'Stressed Loss Given Default');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_npl_flag` SET TAGS ('dbx_business_glossary_term' = 'Stressed Non-Performing Loan Flag');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_pd` SET TAGS ('dbx_business_glossary_term' = 'Stressed Probability of Default');
ALTER TABLE `banking_ecm`.`loan`.`stress_projection` ALTER COLUMN `stressed_rwa` SET TAGS ('dbx_business_glossary_term' = 'Stressed Risk-Weighted Assets');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` SET TAGS ('dbx_association_edges' = 'loan.loan_account,treasury.stress_scenario_cfp');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `stress_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Stress Test Result ID');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Stress Test Result - Loan Account Id');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `stress_scenario_cfp_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Stress Test Result - Treasury Stress Scenario Id');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `scenario_application_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Application Date');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `scenario_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Scenario Impact Category');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `stressed_ecl_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Expected Credit Loss Amount');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `stressed_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Exposure Amount');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `stressed_lgd` SET TAGS ('dbx_business_glossary_term' = 'Stressed Loss Given Default');
ALTER TABLE `banking_ecm`.`loan`.`stress_test_result` ALTER COLUMN `stressed_pd` SET TAGS ('dbx_business_glossary_term' = 'Stressed Probability of Default');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` SET TAGS ('dbx_association_edges' = 'loan.facility,treasury.contingency_funding_plan');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `facility_cfp_assumption_id` SET TAGS ('dbx_business_glossary_term' = 'Facility CFP Assumption Identifier');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `contingency_funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Cfp Assumption - Contingency Funding Plan Id');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Cfp Assumption - Facility Id');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `assumption_rationale` SET TAGS ('dbx_business_glossary_term' = 'Assumption Rationale');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `assumption_status` SET TAGS ('dbx_business_glossary_term' = 'Assumption Status');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `contingent_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingent Exposure Amount');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `drawdown_assumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Assumption Rate');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `plan_inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Inclusion Date');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `banking_ecm`.`loan`.`facility_cfp_assumption` ALTER COLUMN `stress_utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Stress Utilization Amount');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ALTER COLUMN `trade_finance_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Transaction Identifier');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ALTER COLUMN `bank_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_finance_transaction` ALTER COLUMN `reversal_trade_finance_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ALTER COLUMN `document_presentation_id` SET TAGS ('dbx_business_glossary_term' = 'Document Presentation Identifier');
ALTER TABLE `banking_ecm`.`loan`.`document_presentation` ALTER COLUMN `previous_document_presentation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` ALTER COLUMN `covenant_package_id` SET TAGS ('dbx_business_glossary_term' = 'Covenant Package Identifier');
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` ALTER COLUMN `parent_covenant_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`covenant_package` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
