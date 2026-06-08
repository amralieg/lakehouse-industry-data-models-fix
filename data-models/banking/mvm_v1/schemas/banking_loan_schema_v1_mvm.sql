-- Schema for Domain: loan | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`loan` COMMENT 'End-to-end management of commercial lending, consumer loans, mortgages, revolving credit facilities, syndicated loans, and trade finance operations including letters of credit, documentary collections, bank guarantees, supply chain finance, export/import financing, and bill of lading management. Owns credit origination, underwriting, loan booking, covenant tracking, amortization, trade finance lifecycle, UCP 600/URDG 758 compliance, and all lending-related regulatory reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique surrogate identifier for the credit facility record in the lakehouse. Primary key for the facility master entity, referenced by all transactional and monitoring products in the loan domain.',
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: In private banking, credit facilities (lombard lines, overdrafts) are components of the overall client mandate. Relationship managers and compliance teams need to link the facility to the mandate for ',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Lombard lending structures a credit facility directly against a managed portfolio as primary collateral. Facility-level credit limits, LTV monitoring, and margin call triggers require a direct FK from',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: Corporate and institutional credit facilities are frequently governed alongside ISDA Master Agreements. Cross-default provisions, netting rights, and credit risk aggregation (Basel III SA-CCR) require',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Facility approval, pricing, and ongoing credit monitoring require current counterparty credit ratings. Internal_risk_rating is denormalized from the rating entity; pd/lgd/ead are rating outputs that s',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Facilities booked in countries require country risk ratings, sovereign ratings, regulatory frameworks (Basel implementation status), AML risk ratings, and sanctions flags for credit decisioning, provi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Facilities denominated in specific currencies require currency metadata (settlement lag, rounding, convertibility) for disbursement, accrual, revaluation, and regulatory reporting (Basel liquidity rat',
    `party_id` BIGINT COMMENT 'FK to customer.party.party_id — MUST-HAVE: Cannot query loan facilities by borrower without this link. Fundamental for credit portfolio management, regulatory reporting (CCAR/DFAST), and customer 360 views.',
    `facility_party_id` BIGINT COMMENT 'Reference to the primary borrowing entity (customer or counterparty) obligated under this credit facility. Used for KYC/AML linkage, credit exposure aggregation, and regulatory reporting.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund finance / NAV lending: credit facilities extended to investment funds require direct fund reference for NAV-based borrowing base calculations, LTV covenant monitoring, and regulatory capital repo',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Facilities require GL account assignment for balance sheet classification, interest accrual posting, and subledger-to-GL reconciliation. Core accounting requirement for loan portfolio management and f',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Facilities extended to borrowers in industries require industry classification (NAICS, SIC, GICS) for concentration risk limits, regulatory reporting (Basel Pillar 3 industry breakdowns), credit polic',
    `investment_policy_statement_id` BIGINT COMMENT 'Foreign key linking to wealth.investment_policy_statement. Business justification: An IPS for a managed portfolio client explicitly governs permissible leverage and borrowing limits. Credit facilities must reference the IPS to validate that the facility is within IPS-permitted lever',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Facilities must record governing legal jurisdiction for loan documentation enforceability, netting agreement validity (Basel III credit risk mitigation), and regulatory capital treatment. A credit law',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Every credit facility must be booked to a legal entity for Basel III RWA reporting, IFRS 9 staging, and consolidated financial statements. Banking domain experts expect facility-to-legal-entity attrib',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Facilities are originated at specific branches, required for branch P&L attribution, CRA (Community Reinvestment Act) geographic reporting, and regulatory exam scoping. The existing `originating_branc',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Facilities are originated through specific channels (branch, digital, RM). Critical for channel performance reporting, origination analytics, regulatory source-of-business tracking, and channel ROI me',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Facility classification by product type drives RWA approach selection, IFRS 9 portfolio segmentation, fee schedule application, and regulatory capital reporting. facility_type is a plain-text denormal',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Facilities are attributed to profit centers for RAROC calculation, revenue allocation, and IFRS 8 segment reporting. Profit center attribution on the facility drives management accounting, business li',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Facilities priced off benchmark rates require benchmark metadata (day count convention, compounding convention, fallback rate) for interest accrual, repricing, fallback provisions (IBOR transition), a',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: CCAR/DFAST stress testing requires applying specific regulatory scenarios to facility portfolios for capital adequacy assessment. Facilities must track which stress scenarios theyve been tested under',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Structured credit facilities and margin lending products require suitability validation at origination per MiFID II and FINRA rules. The facility-level suitability assessment governs product eligibili',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Leveraged loan trading and CLO warehousing: loan facilities held-for-sale or originated for syndication are assigned to a trading book for FRTB market risk capital, fair value accounting (IFRS 9), and',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities-backed credit facilities (margin lending, portfolio-based lines) require tracking the underlying security collateral. Core private banking and wealth management product. Supports collateral',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: IFRS 13 fair value measurement and FTP allocation require each loan facility to reference the yield curve used for discounting. ALM and treasury teams assign yield curves to facilities for valuation r',
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
    `first_drawdown_date` DATE COMMENT 'Date of the first utilization or drawdown under the facility. Marks the transition from commitment to active exposure and is used for interest accrual commencement and IFRS 9 initial recognition of financial asset.',
    `ifrs9_stage` STRING COMMENT 'IFRS 9 impairment staging classification: Stage 1 (performing, 12-month ECL), Stage 2 (significant increase in credit risk, lifetime ECL), Stage 3 (credit-impaired, lifetime ECL). Drives ECL provisioning and income recognition methodology.. Valid values are `stage_1|stage_2|stage_3`',
    `interest_rate_basis` STRING COMMENT 'Reference rate benchmark underpinning the facilitys floating interest rate (e.g., SOFR — Secured Overnight Financing Rate, EURIBOR). Reflects LIBOR transition requirements per ARRC/ISDA fallback protocols. Fixed-rate facilities carry fixed designation. [ENUM-REF-CANDIDATE: SOFR|LIBOR|EURIBOR|SONIA|fixed|prime|CDOR — 7 candidates stripped; promote to reference product]',
    `interest_rate_spread_bps` DECIMAL(18,2) COMMENT 'Credit spread above the reference rate benchmark expressed in BPS (Basis Points), representing the banks risk-adjusted margin on the facility. Key input for NIM (Net Interest Margin) and NII (Net Interest Income) reporting and FTP (Funds Transfer Pricing).',
    `loan_purpose_code` STRING COMMENT 'Standardized code classifying the intended use of proceeds for the credit facility (e.g., working capital, capital expenditure, acquisition finance, real estate purchase). Required for HMDA, CRA, and Call Report regulatory filings. [ENUM-REF-CANDIDATE: working_capital|capex|acquisition|real_estate|trade_finance|refinancing|general_corporate|consumer_personal — promote to reference product]',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the outstanding drawn amount to the appraised value of pledged collateral, expressed as a decimal (e.g., 0.75 = 75% LTV). Key underwriting metric for mortgage and secured commercial lending; used in LGD estimation and collateral adequacy monitoring.',
    `maturity_date` DATE COMMENT 'Contractual date on which the facility expires and all outstanding principal and accrued interest become due. Used for liquidity gap analysis, NSFR (Net Stable Funding Ratio) bucketing, and ALM (Asset-Liability Management) cash flow projections.',
    `npl_flag` BOOLEAN COMMENT 'Indicates whether the facility is classified as a Non-Performing Loan (NPL) per regulatory definition (typically 90+ days past due or unlikely-to-pay). Triggers specific provisioning, income recognition suspension, and regulatory NPL ratio reporting.',
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
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Real-time fraud screening during credit underwriting: fraud detection rules fire alerts on credit applications (e.g., velocity checks, identity mismatch). Underwriters review alert disposition before ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Credit applications are submitted through specific channels (branch, digital, mobile). Channel-level application volume, approval rate, and conversion reporting is a core origination analytics and reg',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Credit underwriting requires borrower country-of-domicile for AML risk rating, FATCA/CRS jurisdiction determination, and cross-border regulatory reporting. A credit analyst always records this on the ',
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: Credit applications from wealth management clients are evaluated against the client mandate (risk profile, investment objectives, permissible leverage). Underwriting decisions and credit committee app',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Credit applications offering securities as collateral (bonds, equities, portfolios) require instrument identification for underwriting, valuation, and eligibility assessment. Standard input for securi',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: High-net-worth credit applications reference managed portfolios for collateral evaluation and income verification. Underwriting process pulls portfolio statements to assess liquid net worth, verify in',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit underwriting decisions depend on applicants credit rating. Credit_rating is denormalized rating code; pd/lgd/ead estimates should be sourced from the rating entity for consistency with risk fr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Applications request funding in currencies requiring currency metadata (convertibility, restrictions, settlement lag) for feasibility assessment, pricing (FX risk premium), and approval workflow. Reus',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Acquisition finance origination: a credit application is submitted to fund a specific M&A deal. Credit committee approval, underwriting decisions, and pipeline reporting require the credit application',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund finance underwriting: credit applications for NAV loans and subscription credit facilities must reference the target fund to assess AUM, NAV, mandate constraints, and investor base during credit ',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Credit underwriting requires borrower industry classification for sector concentration limits, Basel III sector-specific RWA, and underwriting policy compliance. Industry code on the application drive',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.investment_mandate. Business justification: Acquisition finance origination: when a bank receives an investment mandate to arrange financing for an M&A transaction, the resulting credit application is submitted under that mandate. Revenue attri',
    `investment_policy_statement_id` BIGINT COMMENT 'Foreign key linking to wealth.investment_policy_statement. Business justification: Credit applications for wealth clients must be validated against the IPS to confirm borrowing is consistent with stated investment objectives and leverage constraints. Underwriters and compliance team',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Private banking underwriting: credit applications for ultra-high-net-worth clients reference their investment accounts (fund holdings) as part of creditworthiness assessment. Underwriters evaluate the',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: Credit underwriting requires confirmed KYC status at application time. credit_application.kyc_completed is a plain boolean — a direct FK to customer.kyc_record captures which specific KYC record (AML ',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Credit applications require KYC verification before approval to satisfy CIP/CDD requirements. Application processing triggers or references KYC reviews to verify applicant identity and assess AML risk',
    `onboarding_case_id` BIGINT COMMENT 'Foreign key linking to customer.onboarding_case. Business justification: Credit applications are initiated within onboarding cases (onboarding_case.product_applied_for confirms this). Linking credit_application to onboarding_case enables end-to-end origination pipeline rep',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Credit applications submitted at a specific branch are tracked for CRA geographic reporting, branch performance attribution, and relationship manager assignment. This is distinct from the channel-type',
    `party_id` BIGINT COMMENT 'Reference to the primary applicant (customer or corporate entity) submitting the credit application.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Credit applications are submitted for a specific loan product type driving underwriting criteria, regulatory capital treatment (Basel III asset class), and fee schedules. facility_type is a plain-text',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Credit applications specify the requested interest rate basis (SOFR, EURIBOR, fixed) which drives term sheet generation, pricing approval, and IBOR transition compliance tracking. No rate_benchmark FK',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: OFAC/sanctions screening of the applicant and counterparties is a mandatory BSA/AML step before credit approval. The credit_application has aml_screening_status (denormalized) but no FK to the screeni',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: CCAR/DFAST and ICAAP regulatory requirements mandate stress-tested underwriting. Credit applications reference the stress scenario used to assess borrower DSCR and LTV under adverse conditions. A cred',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Private banking credit underwriting references existing suitability assessments to verify client financial profile, risk tolerance, net worth, and debt service capacity. Regulatory requirement for res',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Trust entities are common borrowers in private banking (trustee-directed loans, trust-owned property financing). Credit applications submitted on behalf of a trust require direct linkage to the trust ',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Applicants reported annual revenue from the most recent financial statements, used for debt service coverage and creditworthiness assessment.',
    `application_number` STRING COMMENT 'Externally-visible unique business identifier for the credit application, used in customer communications and regulatory reporting.. Valid values are `^[A-Z]{2,4}[0-9]{8,12}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the credit application in the underwriting workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|pending_documents|approved|declined|withdrawn|referred — 8 candidates stripped; promote to reference product]',
    `application_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the credit application was formally submitted by the applicant or on behalf of the applicant.',
    `application_type` STRING COMMENT 'Classification of the credit application based on the nature of the request: new facility, renewal of existing, refinancing, modification of terms, credit line increase, or debt restructuring.. Valid values are `new|renewal|refinance|modification|increase|restructure`',
    `approved_amount` DECIMAL(18,2) COMMENT 'Principal amount of credit approved by underwriting, which may differ from the requested amount. Nullable for declined or pending applications.',
    `approved_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate approved for the credit facility, expressed as a decimal (e.g., 0.0575 for 5.75%). Nullable for declined or pending applications.',
    `approved_term_months` STRING COMMENT 'Duration of the approved credit facility in months, which may differ from the requested term. Nullable for declined or pending applications.',
    `conditions_precedent` STRING COMMENT 'List of conditions that must be satisfied before loan disbursement, such as additional documentation, insurance requirements, or legal opinions. Nullable for declined applications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this credit application record was first created in the system.',
    `credit_committee_approval_date` DATE COMMENT 'Date when the credit committee formally approved the application, if committee approval was required. Nullable for applications within analyst authority or declined applications.',
    `credit_score` STRING COMMENT 'Numeric credit score assigned by the credit scoring model (e.g., FICO, internal proprietary model) at the time of application submission.',
    `decline_reason` STRING COMMENT 'Detailed explanation for declined applications, including specific credit policy violations, insufficient collateral, adverse credit history, or regulatory restrictions. Nullable for approved applications.',
    `dscr` DECIMAL(18,2) COMMENT 'Debt Service Coverage Ratio calculated as net operating income divided by total debt service obligations, indicating the applicants ability to service debt.',
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
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: A loan account for a private banking client is serviced within the context of the client mandate. Relationship profitability reporting, mandate compliance monitoring, and holistic client exposure dash',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Loan accounts secured by securities portfolios (margin loans, securities-backed lines) require tracking the primary collateral instrument. Supports ongoing collateral monitoring, margin maintenance, a',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Lombard loans and margin loans are directly collateralized by specific managed portfolios. Daily operations require portfolio valuation monitoring, margin call calculations, collateral revaluation for',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Loan accounts require country of booking for regulatory reporting (call reports, Basel RWA geographic breakdown), FATCA/CRS reporting, and country concentration risk limits. No country FK exists on lo',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Loan accounts denominated in currencies require currency metadata (minor unit, rounding method, day count convention) for interest accrual, GL revaluation, payment processing, and financial reporting ',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Core banking operational link: loan repayments are debited from deposit accounts, collateral sweeps transfer funds between loan and deposit accounts, and regulatory liquidity reporting (LCR/NSFR) requ',
    `facility_id` BIGINT COMMENT 'Reference to the parent loan facility or origination record from which this account was booked.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund finance servicing: active NAV loan accounts require direct fund reference for ongoing LTV monitoring, IFRS 9 stage classification, ECL provisioning, and regulatory reporting. Portfolio managers a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Each loan account must map to a GL account for principal balance tracking, interest accrual, and subledger reconciliation. Fundamental requirement for loan accounting and trial balance preparation.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Payment due date calculation, rate reset dates, and accrual period boundaries require the applicable holiday calendar for the loans currency/jurisdiction. This is a fundamental operational requiremen',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: The loan account is the primary credit relationship record. KYC reviews govern the ongoing customer relationship and are referenced during annual loan reviews, regulatory classification, and BSA/AML c',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Loan accounts must be attributed to a legal entity for call reports, COREP, FINREP, and consolidated balance sheet reporting. Banking domain experts expect this link for entity-level loan book exposur',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Loan accounts are serviced and originated at specific branches, required for branch-level portfolio reporting, CRA compliance, and regulatory exam scoping. The existing `originating_branch_code` plain',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Loan accounts track origination channel for portfolio segmentation by acquisition channel, lifetime value analysis, channel attribution reporting, and regulatory reporting on loan origination sources ',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who is the primary obligor on this loan account.',
    `payment_mandate_id` BIGINT COMMENT 'Foreign key linking to payment.payment_mandate. Business justification: Loan accounts have direct debit mandates authorizing automated repayment collection. Banks link loan_account to payment_mandate for scheduled payment execution, mandate cancellation on payoff, and SEP',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Loan accounts must be classified by product type for CECL portfolio segmentation, IFRS 9 staging, Basel III RWA approach selection, and regulatory capital reporting. loan_type is a plain-text denormal',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Loan accounts track the live benchmark rate for daily interest accrual, rate reset calculations, and IBOR transition monitoring. benchmark_rate is a plain-text denormalization; a proper FK to rate_ben',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Securities-backed and margin loan accounts require ongoing suitability validation per MiFID II and FINRA Rule 4210. The loan account must reference the suitability assessment to support regulatory exa',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Loans classified as held-for-sale or at fair value through P&L (IFRS 9 / ASC 820) are assigned to a trading book. FRTB boundary management, fair value P&L attribution, and regulatory capital reporting',
    `account_number` STRING COMMENT 'Externally visible account number used for customer communication, statements, and payment processing. Unique within the institution.. Valid values are `^[A-Z0-9]{10,20}$`',
    `account_status` STRING COMMENT 'Current operational status of the loan account. Reflects payment performance and lifecycle stage.. Valid values are `active|delinquent|npl|charged_off|closed|suspended`',
    `accrued_fees` DECIMAL(18,2) COMMENT 'Fees accrued but not yet paid, including late fees, servicing fees, and other charges.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Interest accrued but not yet paid on the loan account. Calculated based on day-count convention and current interest rate.',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Amortization schedule installments map to accounting periods for interest accrual recognition under IFRS 9/CECL. Linking to accounting_period enables period-close validation of scheduled vs. actual in',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Amortization schedules track payments in currencies requiring currency metadata (rounding, minor unit) for payment amount calculation, settlement instructions, and accounting (revenue recognition). Re',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Amortization schedule generation adjusts payment due dates and accrual period boundaries per business day convention using the applicable holiday calendar. due_date and accrual_start/end_date on amort',
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
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: At drawdown, LTV must be confirmed against current collateral valuation before funding. loan_to_value_ratio on drawdown is a denormalized snapshot of the valuation-derived ratio. Linking to the auth',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Drawdown disbursements require destination country for AML/sanctions screening, cross-border payment regulatory reporting (SWIFT gpi, FinCEN), and FATCA/CRS obligations. No country FK exists on drawdo',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Drawdowns execute in currencies requiring currency metadata (settlement lag, convertibility, restrictions) for disbursement timing, SWIFT message formatting, nostro/vostro account selection, and regul',
    `facility_id` BIGINT COMMENT 'Reference to the committed credit facility or loan agreement against which this drawdown is made. Links to the parent facility contract.',
    `fx_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.fx_transaction. Business justification: Cross-currency drawdowns require an FX transaction to convert disbursed funds. Banks link drawdown to fx_transaction for FX exposure reporting, hedge accounting under IFRS 9, and multi-currency loan p',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Drawdown settlement_date and value_date must be adjusted for market holidays per the applicable holiday calendar and business day convention. This is a standard treasury operations requirement for any',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: A drawdown event against a facility creates or updates a loan_account position. Linking drawdown directly to loan_account (in addition to facility) enables direct reconciliation of disbursed amounts a',
    `party_id` BIGINT COMMENT 'Reference to the borrower entity executing this drawdown. May be a corporate, government, or individual borrower depending on facility type.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Pre-drawdown conditions precedent checklist requires confirming the collateral pledge is legally perfected before funds are disbursed. The pledge (legal perfection record) is distinct from the asset. ',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Drawdowns priced at benchmark rates require benchmark metadata (publication time, tenor convention, fallback rate) for interest calculation, rate fixing (observation date determination), and regulator',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every drawdown disbursement requires OFAC/sanctions screening of the beneficiary before funds are released. The drawdown has aml_screening_status (denormalized) but no FK to the screening event record',
    `syndication_id` BIGINT COMMENT 'Foreign key linking to investment.investment_syndication. Business justification: Syndicated loan agent banking: each drawdown must reference the syndication structure to calculate pro-rata lender funding obligations, notify syndicate members, and generate SWIFT funding notices. Ag',
    `tranche_id` BIGINT COMMENT 'Foreign key linking to investment.tranche. Business justification: Syndicated loan operations: each drawdown is executed against a specific tranche (senior, mezzanine, etc.) that defines the applicable rate, seniority, and terms. Agent bank systems and loan accountin',
    `amount` DECIMAL(18,2) COMMENT 'The principal amount drawn down by the borrower in this transaction, denominated in the drawdown currency. This amount reduces available facility headroom.',
    `approval_date` DATE COMMENT 'The date on which the drawdown request was approved by the credit officer or automated system. Required for audit trail and regulatory reporting.',
    `available_commitment_amount` DECIMAL(18,2) COMMENT 'The remaining undrawn commitment amount available under the facility after this drawdown. Calculated as facility limit minus total outstanding drawdowns.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The reference benchmark rate used for floating-rate drawdowns: SOFR (Secured Overnight Financing Rate), LIBOR (legacy), EURIBOR, SONIA, ESTR, PRIME, or BASE rate.',
    `beneficiary_account_number` STRING COMMENT 'The borrowers account number or IBAN to which the drawdown funds were credited. May be an internal DDA or an external account at another institution.',
    `commitment_utilization_pct` DECIMAL(18,2) COMMENT 'The percentage of the total facility commitment utilized after this drawdown, calculated as (total outstanding + this drawdown) / facility limit * 100. Used for covenant monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this drawdown record was first created in the system. Used for audit trail and data lineage tracking.',
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
    `amortization_schedule_id` BIGINT COMMENT 'Foreign key linking to loan.amortization_schedule. Business justification: Each repayment transaction satisfies a specific scheduled installment in the amortization_schedule. Linking repayment to amortization_schedule_id enables payment-to-schedule matching, delinquency trac',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Loan repayments are received through specific channels (branch teller, online banking, ATM, mobile). Channel-level repayment tracking supports operational reconciliation, fraud monitoring, and SLA rep',
    `ctr_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.ctr_filing. Business justification: Large cash repayments exceeding $10,000 trigger CTR filings under BSA regulations. Banks must link CTR filings to specific repayment transactions that triggered the reporting requirement for audit tra',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Repayments received in currencies require currency metadata (rounding, minor unit) for payment application (principal/interest allocation), GL posting, reconciliation, and financial reporting. Reuses ',
    `drawdown_id` BIGINT COMMENT 'Foreign key linking to loan.drawdown. Business justification: For revolving credit facilities and term loans with multiple drawdowns, a repayment can be applied against a specific drawdown tranche. Linking repayment to drawdown_id enables drawdown-level payoff t',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Core loan servicing process: every loan repayment (principal, interest, fees) is executed via a payment instruction through the banks payment rails. Regulatory reporting (FFIEC 031/041) requires trac',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account against which this repayment is applied. Links to the loan master data product.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Cross-border loan repayments received from foreign counterparties settle through nostro accounts. Treasury reconciles repayment receipts against nostro account entries for cash management and reconcil',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Loan repayments are executed as payment transactions. Banks link repayment to payment_transaction for delinquency monitoring, payment reconciliation, and regulatory reporting (e.g., CRR Article 178 de',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Loan repayments from third-party sources require OFAC/sanctions screening of the remitting party. This is a mandatory BSA compliance step, particularly for international repayments and wire transfers,',
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
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the repayment transaction was processed by the payment system. Used for audit trail and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this repayment record was last modified. Audit field for tracking changes and ensuring data integrity.',
    `value_date` DATE COMMENT 'The effective date from which the repayment amount is considered for interest calculation purposes. May differ from payment_date due to settlement timing.',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Amount of fees or penalties waived by the bank as part of this repayment transaction. Used for customer relationship management and regulatory reporting.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving fees or penalties, if applicable. Includes reasons such as customer goodwill, hardship, or error correction. Null if no waiver applied.',
    CONSTRAINT pk_repayment PRIMARY KEY(`repayment_id`)
) COMMENT 'Records each principal and interest repayment transaction against a loan account, including payment date, payment amount, principal component, interest component, fee component, penalty interest (if any), payment method (ACH, wire, RTGS), payment source account, outstanding balance post-payment, and whether the payment was on-time, early, or late. Feeds NPL classification and delinquency tracking.';

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`covenant` (
    `covenant_id` BIGINT COMMENT 'Unique identifier for the covenant record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Covenant testing is performed on a periodic schedule aligned to accounting periods (quarterly, semi-annual). Linking covenant to accounting_period enables period-close covenant compliance reporting, a',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: Covenant breaches trigger formal risk assessments (RCSA escalation, credit risk control review). The covenant record must reference the resulting risk assessment for breach consequence tracking, regul',
    `facility_id` BIGINT COMMENT 'Reference to the credit facility or loan agreement to which this covenant is attached.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund finance covenant testing: NAV maintenance covenants, diversification tests, and borrowing base covenants on fund finance facilities are tested directly against fund data. Covenant monitoring syst',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Covenants are primarily attached to facilities (existing FK), but financial covenants (DSCR, leverage ratio) are tested against the specific loan_accounts performance metrics. Adding loan_account_id ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Loan covenants frequently implement or reference specific regulatory compliance obligations (e.g., maintaining capital ratios per Basel, regulatory reporting covenants). Linking covenant to obligation',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Loan covenants frequently include collateral maintenance requirements (minimum coverage ratios, permitted liens, negative pledge clauses) tied to specific pledge agreements. Covenant monitoring system',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: ECL provisions are calculated and reported per accounting period under IFRS 9. The accounting_period_id is essential for period-close provision reporting, FINREP/COREP regulatory submissions, provisio',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: ECL provision calculations under IFRS9/CECL require current collateral valuations to estimate LGD and recovery amounts. Finance teams must link each provision calculation to the specific valuation use',
    `credit_review_id` BIGINT COMMENT 'Foreign key linking to loan.credit_review. Business justification: ECL stage classifications and provision amounts are frequently updated following credit reviews. Linking loan_ecl_provision to the credit_review_id that triggered the stage migration or provision upda',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: ECL provisions calculated in currencies require currency metadata (rounding, minor unit) for consolidation (group reporting currency translation), regulatory reporting (IFRS 9 disclosures), and GL pos',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: ECL provisions are calculated at the loan_account level (existing FK), but portfolio-level provisioning and regulatory reporting (IFRS 9 Stage reporting) require facility-level aggregation. Adding fac',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: IFRS 9 ECL for fund finance: ECL provisioning on NAV loans requires direct fund reference to assess NAV trends, fund liquidity, and stress-scenario impacts on collateral value. Auditors and regulators',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan for which this ECL provision is calculated.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: IFRS 9 ECL calculations require forward-looking macroeconomic scenarios for probability-weighted provisioning. Macroeconomic_scenario is a denormalized scenario name that should reference the full str',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: IFRS 9 requires ECL provisions to incorporate multiple economic scenarios from specific stress test runs (base/upside/downside weighting). Auditors and regulators require traceability from ECL provisi',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: ECL provisions for loans held in trading books must be attributed to the correct trading book for FRTB regulatory capital allocation and banking-book/trading-book boundary reporting. Regulators requir',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: IFRS 9 ECL calculation requires discounting lifetime expected credit losses using the effective interest rate derived from a specific yield curve. Regulators (PRA, ECB) require disclosure of the curve',
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

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`modification` (
    `modification_id` BIGINT COMMENT 'Primary key for modification',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: TDR modifications affect credit loss projections used in capital stress scenarios under DFAST/CCAR frameworks. Essential for forward-looking capital planning and stress testing.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Modifications requested/processed via channels. Essential for forbearance program tracking, channel servicing quality measurement, regulatory reporting on modification channels (CFPB, OCC requirements',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Loan modification/restructuring process (TDR/forbearance) requires updated collateral valuation to determine new LTV, CECL stage, and capital treatment. collateral_adjustment_flag on modification si',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Loan modifications (especially TDRs) trigger credit rating reassessment per credit policy. The modification should reference the post-modification rating to track credit deterioration and support CECL',
    `credit_review_id` BIGINT COMMENT 'Foreign key linking to loan.credit_review. Business justification: Loan modifications (especially TDRs and forbearance agreements) are typically triggered by or follow a credit review. Linking modification to the credit_review_id that recommended or authorized the mo',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Loan modifications with fee amounts in currencies require currency metadata (rounding, minor unit) for fee calculation, GL posting, and regulatory reporting (TDR reporting, CECL modification tracking)',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Loan modifications (restructurings, amendments) can be applied at the facility level — changing committed amounts, maturity dates, or covenants on the master facility record. modification already has ',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Loan modification fraud: fraudulent modification requests (employee fraud, unauthorized rate changes, forged borrower consent) are a named fraud typology. Fraud cases are opened against specific modif',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Loan modifications generate journal entries for TDR classification, modification gain/loss recognition, and principal forgiveness accounting. Required for GAAP/IFRS compliance and regulatory TDR repor',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan facility being modified. Links to the core loan master record.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Loan modifications (forbearance, restructuring, TDR) often require collateral pledge amendments—lien releases, substitutions, or coverage ratio waivers. Workout teams track which pledge was modified a',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Loan modifications frequently change the rate benchmark (e.g., LIBOR-to-SOFR transition, forbearance restructuring). modified_interest_rate on modification requires a benchmark reference for IBOR tran',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Collateral is pledged at the facility level (master credit agreement) as well as the loan_account level. collateral_link already has loan_account_id, but facility_id is needed for cross-collateralizat',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Wealth management collateral: fund units held in investor accounts serve as loan collateral. Banks pledge the investors fund positions (tracked via investor_account) against credit facilities. This l',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan facility that is secured by the pledged collateral. Links to the loan master record in the loan domain.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Managed portfolios are pledged as collateral for credit facilities. Collateral perfection process requires linking investment accounts, daily mark-to-market valuation for LTV monitoring, haircut appli',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: The collateral_link table associates loan accounts with collateral; it must reference the legal pledge instrument (perfection, lien position) not just the underlying asset. perfection_status, lien_',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Collateral_link already has collateral_asset_id (physical/real assets). Securities pledged as collateral require separate instrument reference for market-based valuation, haircut application, and marg',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Trust accounts holding securities or real estate are pledged as collateral for loans. The collateral_link must reference the trust account to support lien perfection, collateral valuation, and regulat',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the collateral asset value allocated to this specific loan facility. Used when a single collateral asset secures multiple loans. Sum of allocation percentages across all links for a collateral asset should equal 1.0000 (100%).',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'The ratio of current collateral value to outstanding loan balance. Inverse of LTV. Expressed as a decimal (e.g., 1.2500 represents 125% coverage). Values above 1.0 indicate over-collateralization.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this collateral link record was first created in the system. Audit trail for data lineage and compliance.',
    `cross_collateralization_flag` BOOLEAN COMMENT 'Indicates whether this collateral secures multiple loan facilities under a cross-collateralization agreement. True means the collateral is pledged to secure more than one loan obligation.',
    `cross_default_flag` BOOLEAN COMMENT 'Indicates whether a default on this loan triggers default provisions on other loans secured by the same collateral. True means cross-default provisions are in effect.',
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
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Loan write-offs can be directly linked to AML investigations — loans written off due to suspected fraud, money laundering, or proceeds of crime reference the underlying AML case. This link supports SA',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Write-off process requires the collateral valuation at time of charge-off to calculate net loss after collateral recovery proceeds. collateral_liquidation_proceeds and collateral_liquidation_flag ',
    `credit_review_id` BIGINT COMMENT 'Foreign key linking to loan.credit_review. Business justification: Write-off decisions are typically preceded by and documented in a credit review. Linking write_off to the credit_review_id that recommended the charge-off provides a complete audit trail from review t',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Write-offs recorded in currencies require currency metadata (rounding, minor unit) for GL posting (charge-off journal entries), regulatory reporting (call report Schedule RI-B), and recovery tracking.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Fraud-driven write-off tracking: write-offs resulting from confirmed fraud events must be linked to the originating fraud case for Basel operational risk loss event reporting, CCAR stress testing, and',
    `journal_entry_id` BIGINT COMMENT 'Reference to the GL journal entry that recorded the write-off transaction, enabling reconciliation between loan system and financial accounting.',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account that was written off.',
    `loan_ecl_provision_id` BIGINT COMMENT 'Foreign key linking to loan.loan_ecl_provision. Business justification: When a loan is written off, the associated ECL provision is released. Linking write_off to the specific loan_ecl_provision_id being released enables accurate IFRS 9/CECL accounting entries, provision ',
    `modification_id` BIGINT COMMENT 'Foreign key linking to loan.modification. Business justification: A write-off often follows a failed loan modification or restructuring attempt. Linking write_off to the modification_id of the last attempted restructuring enables workout analysis, loss given default',
    `party_id` BIGINT COMMENT 'Reference to the borrower whose loan was written off.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Write-offs track which collateral pledge was exhausted or liquidated. Collections teams need pledge reference for recovery pursuit strategy, collateral liquidation proceeds allocation, and LGD calcula',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Credit reviews are conducted on a periodic schedule aligned to accounting periods. Linking to accounting_period supports period-close credit quality reporting, IFRS 9 stage migration tracking by perio',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: Credit reviews produce rwa_amount and stage_classification outcomes that directly feed capital planning projections. Treasurys capital plan incorporates RWA forecasts from credit reviews for projecte',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Ongoing credit monitoring: when loans are collateralized by fund holdings, periodic credit reviews assess the investor_accounts current NAV, concentration risk, and liquidity. This link supports coll',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Periodic credit reviews (annual review process) require the current collateral valuation to assess LTV, coverage ratio, and IFRS9 stage classification. collateral_coverage_ratio and collateral_reva',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit reviews explicitly produce updated counterparty ratings. The review should reference the resulting rating record; updated_internal_rating/pd/lgd are denormalized outputs that should be stored i',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Credit reviews are conducted at the facility level (annual reviews of the credit facility) as well as the loan_account level. credit_review already has loan_account_id, but facility_id is needed for f',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund finance credit reviews: periodic credit reviews of fund finance facilities require direct fund reference to assess NAV coverage ratio, fund performance, mandate compliance, and investor concentra',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Credit reviews assess industry-specific risk and sector outlook as a core component of the review. industry_outlook is a plain-text denormalization of industry_code; linking to industry_code enables s',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Credit reviews of corporate borrowers who are public bond issuers reference the security.issuer profile for public market intelligence, rating agency assessments, and capital markets standing. Relatio',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Annual credit reviews are coordinated with KYC refresh cycles. Banks require that the KYC review is current before completing a credit review. This link supports the annual review process, regulatory ',
    `loan_account_id` BIGINT COMMENT 'Identifier of the loan facility being reviewed. Links this credit review to the specific loan or credit facility under assessment.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Annual credit reviews for lombard and securities-backed loans require direct assessment of the pledged managed portfolios current value, composition, and risk profile. The credit_review must referenc',
    `party_id` BIGINT COMMENT 'Identifier of the borrower whose credit is being reviewed. References the customer or corporate entity that holds the loan facility.',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Annual credit reviews incorporate external instrument/issuer ratings from security.credit_rating for SICR assessment under IFRS 9 and Basel IRB validation. credit_review has counterparty_rating_id→ris',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Annual credit reviews for corporate borrowers under ICAAP/SREP explicitly incorporate stress test results to assess borrower resilience. Credit officers reference the latest stress test run when deter',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Credit reviews for trust borrowers require assessment of the trust accounts assets, distribution obligations, and fiduciary constraints. Linking credit_review to trust_account enables annual review r',
    `collateral_revaluation_flag` BOOLEAN COMMENT 'Indicates whether collateral supporting the facility was revalued as part of this credit review. True if revaluation was performed; false if existing valuations were deemed current.',
    `covenant_compliance_summary` STRING COMMENT 'Summary assessment of the borrowers compliance with financial and non-financial covenants. Compliant indicates all covenants met; minor_breach indicates technical violations with no material impact; material_breach indicates significant covenant violations; waived indicates breaches that have been formally waived by the lender; not_applicable indicates no covenants in place.. Valid values are `compliant|minor_breach|material_breach|waived|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit review record was first created in the system. Supports audit trail and data lineage tracking.',
    `credit_committee_date` DATE COMMENT 'The date on which the credit committee formally reviewed and approved the credit review findings. Represents the official sign-off timestamp for governance and audit purposes.',
    `credit_committee_decision` STRING COMMENT 'Final decision rendered by the credit committee on the review findings and recommended action. Approved indicates acceptance of recommendations; approved_with_conditions indicates acceptance subject to specific requirements; rejected indicates committee disagreement; deferred indicates decision postponed; referred indicates escalation to higher authority.. Valid values are `approved|approved_with_conditions|rejected|deferred|referred`',
    `ecl_amount` DECIMAL(18,2) COMMENT 'The Expected Credit Loss (ECL) provision amount calculated for this facility based on the updated PD, LGD, and EAD estimates from this credit review. Represents the present value of expected credit losses over the relevant time horizon.',
    `financial_performance_assessment` STRING COMMENT 'Qualitative assessment of the borrowers financial performance since the last review. Considers revenue trends, profitability, cash flow generation, leverage ratios, and liquidity position.. Valid values are `strong|satisfactory|adequate|weak|poor`',
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
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: LCs are a primary vehicle for trade-based money laundering (TBML). When an LC triggers an AML investigation, the case must be linked to the instrument. This supports FinCEN SAR filing, regulatory exam',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Letter of credit issuance requires credit assessment of beneficiary (especially for standby LCs). Beneficiary default risk affects LC utilization probability and regulatory capital requirements under ',
    `beneficiary_id` BIGINT COMMENT 'Reference to the party in whose favor the Letter of Credit is issued, typically the exporter or seller.',
    `capital_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_ratio. Business justification: Letters of credit are off-balance-sheet contingent liabilities with RWA implications under Basel III credit conversion factors. Capital ratio calculations must include LC exposures. Treasury links LC ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Letters of credit issued in currencies require currency metadata (convertibility, settlement lag, restrictions) for drawing processing, settlement instructions, compliance (UCP 600 currency rules), an',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: LCs specify expiry place (country) requiring country business day conventions, holiday calendars, and regulatory rules (UCP 600 Article 3) for expiry date calculation and presentation deadline determi',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Letters of Credit are typically issued under a trade finance credit facility. Linking lc to facility_id enables utilization tracking against the facilitys committed amount, facility-level exposure re',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: LC documentary fraud: fraudulent letters of credit (forged documents, phantom shipments, collusion between buyer and seller) are a major trade finance fraud typology. Fraud cases are opened at the LC ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Letters of credit create contingent liability GL entries (off-balance-sheet commitments). The LC needs a direct GL account reference for the contingent liability account used in balance sheet reportin',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: LC presentation period, expiry date, and latest shipment date calculations require holiday calendar for business day adjustments per UCP 600 Article 29. This is a mandatory trade finance operational r',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Letters of credit issued through channels (branch trade desk, digital platform, RM). Required for trade finance channel analytics, documentary credit origination tracking, and trade services performan',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Trade finance KYC is a mandatory compliance requirement — LC applicants and beneficiaries must have current KYC reviews before issuance. Regulators specifically examine trade finance KYC compliance; t',
    `party_id` BIGINT COMMENT 'Reference to the party (customer) who requested the issuance of the Letter of Credit, typically the importer or buyer.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Cash-secured and collateral-backed letters of credit require a formal pledge record. Trade finance operations track the specific collateral pledge securing the LC contingent liability. Risk-weighted a',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Letters of credit require OFAC sanctions screening of beneficiaries, applicants, advising banks, and underlying trade parties at issuance and amendment. Each LC transaction triggers screening events f',
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
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: LC drawing/presentation transactions trigger fraud alerts (discrepancy manipulation, forged documents, duplicate presentations). Linking drawing to alert enables real-time fraud prevention, document e',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: LC drawings can trigger AML alerts based on transaction monitoring rules (unusual drawing patterns, high-risk beneficiaries, sanctioned ports). Linking the drawing to the alert supports TBML detection',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: LC drawings are presented and processed through specific channels (branch, SWIFT, digital trade portal), which may differ from the LC issuance channel. Channel-level drawing processing tracking is req',
    `correspondent_bank_id` BIGINT COMMENT 'Identifier of the nominated bank that negotiated the drawing. Applicable when transaction_type is drawing and negotiation_flag is true.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: LC drawings execute in currencies requiring currency metadata (settlement lag, rounding) for payment processing, nostro/vostro account selection, SWIFT message formatting (MT 700/710), and regulatory ',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: LC drawing fraud investigation: fraudulent presentations under LCs (forged documents, discrepancy concealment, collusion) trigger fraud cases at the drawing level. Distinct from fraud_alert_id already',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: LC drawings/payments create journal entries for contingent liability recognition, honor/dishonor accounting, and reimbursement settlement. Required for trade finance accounting and off-balance-sheet t',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: LC drawing payment_due_date and presentation period calculations require holiday calendar for business day adjustments per UCP 600 Article 29. payment_due_date on lc_drawing is a calendar-adjusted dat',
    `lc_id` BIGINT COMMENT 'Reference to the parent Letter of Credit against which this transaction (drawing or amendment) is recorded.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: LC drawings and document presentations require sanctions screening before honor decisions. Banks screen documents, parties, vessels, and ports against sanctions lists as compliance checkpoint before p',
    `amended_field_name` STRING COMMENT 'Name of the LC field being amended (e.g., lc_amount, expiry_date, document_requirements). Applicable when transaction_type is amendment.',
    `amendment_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the amendment complies with UCP 600 and internal bank policies. Applicable when transaction_type is amendment.',
    `amendment_request_date` DATE COMMENT 'Date on which the amendment was formally requested by the applicant or issuing bank. Applicable when transaction_type is amendment.',
    `amendment_type` STRING COMMENT 'Classification of the amendment action when transaction_type is amendment. Specifies the nature of the change being requested.. Valid values are `amount_increase|amount_decrease|expiry_extension|condition_change|document_modification|beneficiary_change`',
    `available_balance_after_transaction` DECIMAL(18,2) COMMENT 'Remaining available balance on the LC after this drawing or amendment is processed.',
    `beneficiary_acceptance_date` DATE COMMENT 'Date on which the beneficiary formally accepted or rejected the amendment. Applicable when transaction_type is amendment.',
    `beneficiary_acceptance_status` STRING COMMENT 'Status indicating whether the beneficiary has accepted, rejected, or not yet responded to the amendment per UCP 600 Article 10. Applicable when transaction_type is amendment.. Valid values are `accepted|rejected|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LC drawing or amendment record was first created in the system.',
    `discrepancy_code` STRING COMMENT 'Standardized code classifying the type of discrepancy (e.g., late presentation, missing document, inconsistent data). Applicable when transaction_type is drawing.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies found in the presented documents, following ISBP 745 standards. Applicable when transaction_type is drawing and discrepancy_flag is true.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicator of whether discrepancies were identified in the presented documents per ISBP 745 examination standards. Applicable when transaction_type is drawing.',
    `document_set_reference` STRING COMMENT 'Reference identifier for the set of documents presented with the drawing (e.g., bill of lading, commercial invoice, certificate of origin). Applicable when transaction_type is drawing.',
    `drawing_amount` DECIMAL(18,2) COMMENT 'Monetary value of the drawing being claimed by the beneficiary. Applicable when transaction_type is drawing.',
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
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Real-time fraud alert on documentary collections: fraud detection rules fire alerts on collection transactions (e.g., sanctions hits, document anomalies, counterparty risk flags). Distinct from fraud_',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: Documentary collections are a known TBML vector. Transaction monitoring rules fire AML alerts on suspicious collections (over/under-invoicing, unusual goods, high-risk counterparties). This FK links t',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Documentary collections are processed through specific channels (branch, SWIFT network, digital trade platform). Channel-level trade finance operational reporting, SLA monitoring, and fraud screening ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Documentary collections require country of the drawee/collecting bank for AML risk rating, OFAC/sanctions screening, and trade finance regulatory reporting under URC 522. No country FK exists on docum',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Documentary collections denominated in currencies require currency metadata (settlement lag, convertibility) for payment processing, settlement instructions (SWIFT MT 400/410), and regulatory reportin',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Documentary collections are processed under trade finance facilities. Linking documentary_collection to facility_id enables facility-level trade finance exposure tracking, utilization reporting, and r',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Documentary collection fraud (forged documents, non-existent goods, drawer/drawee collusion) is investigated via fraud cases. Linking collection to case supports dishonor decisions, recovery efforts, ',
    `fx_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.fx_transaction. Business justification: Documentary collections settled in foreign currencies require FX transactions. Banks link documentary_collection to fx_transaction for trade finance FX reporting and settlement reconciliation. The doc',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Documentary collection maturity_date and payment_date calculations require holiday calendar for business day adjustments per URC 522. No holiday_calendar FK exists on documentary_collection; this is a',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Documentary collection settlement: when drawee honors documents, payment is executed via payment instruction (D/P or D/A terms). Operational requirement for collection proceeds tracking, SWIFT MT400/M',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Documentary collections settle through nostro accounts for trade settlement, payment processing, and nostro reconciliation. Standard trade finance operations link collections to settlement nostro acco',
    `party_id` BIGINT COMMENT 'Identifier of the drawer (exporter/seller) who is the principal in the collection and who instructs the remitting bank to collect payment from the drawee.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Documentary collections require sanctions screening of drawer, drawee, and underlying trade parties before document release or payment. Trade finance compliance requirement under OFAC regulations for ',
    `tertiary_documentary_case_of_need_party_id` BIGINT COMMENT 'Identifier of the case-of-need party (referee in case of need) who may be contacted for instructions if the drawee refuses payment or acceptance. Optional field per URC 522.',
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
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Bank guarantees require beneficiary country for AML risk rating, OFAC/sanctions screening, and regulatory reporting of cross-border contingent liabilities. Role-prefixed to distinguish from issuing ba',
    `beneficiary_id` BIGINT COMMENT 'Reference to the party in whose favor the bank guarantee is issued. The party entitled to make a claim under the guarantee.',
    `capital_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_ratio. Business justification: Bank guarantees carry explicit RWA (rwa_amount on bank_guarantee) as contingent liabilities under Basel III. Capital ratio calculations must include guarantee exposures. Treasury links guarantee issua',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Bank guarantee ECL provisioning and RWA calculation require the current collateral valuation. ecl_provision_amount, rwa_amount, and risk_weight_percent on bank_guarantee depend on collateral val',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Bank guarantees issued in currencies require currency metadata (rounding, minor unit) for claims processing, payment execution, GL posting (contingent liability valuation), and regulatory reporting (o',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Bank guarantees are deal instruments (bid bonds in M&A auctions, performance bonds in project finance, advance payment guarantees in structured deals). Investment banking structures deal; guarantee de',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Bank guarantees are issued against approved credit facilities (either generic facility or trade_facility). This FK links to the parent facility that provides the credit line. Business justification: G',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Bank guarantee fraud (fraudulent claims, forged guarantees, beneficiary collusion) requires investigation. Fraud cases link to the guarantee for claim rejection, law enforcement referral, and recovery',
    `fx_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.fx_transaction. Business justification: Cross-currency bank guarantee claims require FX conversion when claim currency differs from guarantee currency. Banks link bank_guarantee to fx_transaction for FX P&L on guarantee claims and regulator',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Bank guarantee issuance and claim payments generate journal entries for contingent liability recognition and claim settlement. Required for guarantee accounting and off-balance-sheet exposure tracking',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Bank guarantees issued via channels. Essential for contingent liability tracking by channel, trade services performance analytics, and channel capacity planning for guarantee issuance in trade finance',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Bank guarantee governing law jurisdiction is required for URDG 758 compliance assessment, enforceability opinions, and regulatory capital treatment of contingent liabilities. governing_law is a plain-',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Bank guarantee applicants require current KYC review before issuance — this is a mandatory BSA/AML compliance step. Regulators examine trade finance KYC compliance including guarantees. This FK suppor',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Bank guarantees are off-balance-sheet commitments impacting liquidity planning under stress scenarios, contingency funding plans, and NSFR calculation. Essential for comprehensive liquidity risk manag',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: A bank guarantee can be issued in support of a specific loan account (e.g., a guarantee backing a specific drawn tranche). bank_guarantee already has facility_id for facility-level guarantees, but loa',
    `party_id` BIGINT COMMENT 'Reference to the party (customer) requesting the issuance of the bank guarantee. The principal obligor on whose behalf the guarantee is issued.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Secured bank guarantees reference a collateral pledge as the backing instrument. collateral_required_flag and collateral_coverage_ratio on bank_guarantee confirm this dependency. The pledge record',
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
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Trade documents trigger fraud alerts (forged bills of lading, altered invoices, phantom shipments). Linking document to alert enables document examination workflow, discrepancy identification, and pre',
    `bank_guarantee_id` BIGINT COMMENT 'Foreign key linking to loan.bank_guarantee. Business justification: Trade documents (demand notices, supporting evidence) are submitted as part of bank guarantee claims. trade_document currently links to loan.guarantee (third-party loan guarantees) but NOT to bank_gua',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade documents (invoices, bills of exchange) denominated in currencies require currency metadata (rounding, minor unit) for document examination (UCP 600 compliance), valuation, and discrepancy asses',
    `documentary_collection_id` BIGINT COMMENT 'Reference to the documentary collection transaction associated with this document. Links to collections under URC 522.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Documentary fraud investigation: forged or altered trade documents (bills of lading, invoices, certificates of origin) are the primary vector for trade finance fraud. Fraud cases are opened against sp',
    `guarantee_id` BIGINT COMMENT 'Reference to the bank guarantee associated with this document. Links to guarantee transactions requiring documentary support.',
    `lc_drawing_id` BIGINT COMMENT 'Foreign key linking to loan.lc_drawing. Business justification: Trade documents are presented as part of an LC drawing (presentation of bill of lading, invoice, certificate of origin, etc.). trade_document already has lc_id for the master LC, but lc_drawing_id is ',
    `lc_id` BIGINT COMMENT 'Reference to the letter of credit associated with this document. Links to the LC transaction for which this document is presented.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Trade documents (bills of lading, invoices, certificates of origin) are screened for sanctions compliance — dual-use goods, sanctioned ports, sanctioned counterparties. OFAC and BIS require document-l',
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

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`guarantee` (
    `guarantee_id` BIGINT COMMENT 'Unique identifier for the loan guarantee record. Primary key for the guarantee entity.',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: Parent company guarantees and credit support annexes (CSA) under ISDA agreements are documented as guarantees supporting derivatives obligations. Linking guarantee to counterparty_agreement enables cr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Guarantees with coverage in currencies require currency metadata (rounding, minor unit) for enforceability assessment, call processing, capital relief calculation (RWA reduction), and regulatory repor',
    `facility_id` BIGINT COMMENT 'Reference to the credit facility that this guarantee supports. Used when guarantee covers a revolving or multi-draw facility rather than a single loan.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Guarantees create contingent liability or credit risk mitigation entries in the GL. The guarantee needs a GL account reference for the guarantee liability/fee income account, supporting off-balance-sh',
    `party_id` BIGINT COMMENT 'FK to customer.party',
    `guarantee_party_id` BIGINT COMMENT 'Reference to the party providing the guarantee. May be an individual, corporation, or government entity.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Guarantee credit risk mitigation depends on guarantor creditworthiness. Regulatory capital relief calculations require guarantor ratings. Guarantor_credit_rating/internal_rating/pd/lgd are denormalize',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Guarantors must have current KYC reviews before a guarantee is accepted as credit risk mitigation. Role-prefixed guarantor_ because guarantee has two party roles (guarantee_party_id and guarantee_gu',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Guarantors must be screened against OFAC/sanctions lists before a guarantee is accepted. Role-prefixed guarantor_ to distinguish from the primary obligor screening. This is a mandatory BSA complianc',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Guarantee enforceability depends on governing law jurisdiction — enforceability_opinion_date and enforceability_status require jurisdiction context for legal opinion validity and Basel III credit risk',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account that this guarantee secures. Links the guarantee to the underlying credit exposure.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Blocked investment accounts and cash collateral portfolios serve as guarantee instruments for credit facilities. Guarantee enforceability assessment requires portfolio valuation, collateral coverage r',
    `parent_guarantee_id` BIGINT COMMENT 'Self-referencing FK on guarantee (parent_guarantee_id)',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Trust accounts frequently provide guarantees for related-party borrowings (e.g., trustee guaranteeing a beneficiarys loan). The guarantee must reference the trust account for enforceability assessmen',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Guarantees collateralized by securities (e.g., standby LCs backed by bond portfolios, cash-collateralized guarantees held in money market funds) require instrument tracking for collateral adequacy mon',
    `amendment_count` STRING COMMENT 'Number of amendments made to the original guarantee agreement. Tracks the modification history and may affect enforceability assessment.',
    `call_amount` DECIMAL(18,2) COMMENT 'Monetary amount demanded from the guarantor upon calling the guarantee. May be less than the full coverage amount depending on the outstanding loan balance and guarantee terms.',
    `call_date` DATE COMMENT 'Date on which the bank formally demanded payment from the guarantor due to borrower default. Triggers the guarantors obligation to perform.',
    `capital_relief_amount` DECIMAL(18,2) COMMENT 'Reduction in Risk-Weighted Assets (RWA) achieved through the guarantee. Calculated based on the difference between the borrowers and guarantors risk weights.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount that the guarantor is obligated to pay under the guarantee. Used to calculate Loss Given Default (LGD) and regulatory capital relief.',
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
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Loan disbursements are executed through specific channels (wire transfer, branch, digital). Channel-level disbursement reporting is required for operational SLA monitoring, fraud detection, and regula',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Disbursements execute in currencies requiring currency metadata (settlement lag, rounding, convertibility) for payment instruction formatting (SWIFT), nostro/vostro account selection, settlement timin',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Loan proceeds disbursement process: funds are credited to borrowers deposit account. Existing destination_account_number is denormalized; FK enables automated disbursement processing, regulatory repo',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Disbursement destination country is required for cross-border payment regulatory reporting (FinCEN, SWIFT gpi), AML screening, and FATCA/CRS obligations. destination_bank_bic implies a country but is ',
    `drawdown_id` BIGINT COMMENT 'Reference to the facility drawdown event that triggered this disbursement. Nullable for non-facility loans.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the journal entry created in the general ledger for this disbursement.',
    `instruction_id` BIGINT COMMENT 'Unique identifier for the payment instruction sent to the payment processing system.',
    `loan_account_id` BIGINT COMMENT 'Reference to the loan account for which funds are being disbursed.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Loan disbursements settle through nostro accounts for payment execution, nostro reconciliation, and cash management. Standard banking operations link disbursements to specific nostro accounts for sett',
    `reversal_disbursement_id` BIGINT COMMENT 'Self-referencing FK on disbursement (reversal_disbursement_id)',
    `amount` DECIMAL(18,2) COMMENT 'Principal amount of funds disbursed to the borrower in this transaction.',
    `approval_authority_level` STRING COMMENT 'Level of authority required for disbursement approval (e.g., branch manager, credit committee, senior management).',
    `approval_date` DATE COMMENT 'Date when the disbursement request was approved by the authorized authority.',
    `comments` STRING COMMENT 'Free-text field for additional notes, instructions, or remarks related to the disbursement.',
    `conditions_precedent_checklist` STRING COMMENT 'Comma-separated list or description of specific conditions precedent that were verified before disbursement.',
    `conditions_precedent_satisfied_flag` BOOLEAN COMMENT 'Indicates whether all conditions precedent required for disbursement have been satisfied (e.g., documentation, collateral perfection, insurance).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the disbursement record was first created in the database.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`loan`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the loan pricing record. Primary key for the pricing entity.',
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: Private banking loan pricing is relationship-driven and governed by the client mandate (AUM-based discounts, relationship tiers). The pricing record must reference the client mandate to apply mandate-',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Risk-based pricing (RAROC) depends on LGD, which is directly driven by collateral coverage and valuation. lgd_at_pricing and raroc_at_pricing on pricing are computed from collateral valuation inpu',
    `facility_id` BIGINT COMMENT 'Reference to the loan facility to which this pricing structure applies.',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Loan pricing uses FTP rates as cost-of-funds input for margin calculation, profitability analysis, and pricing decisions. Essential for funds transfer pricing and product profitability management.',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Pricing records capture the interest rate structure for a loan. While pricing is linked to facility (existing FK), individual loan accounts under a facility may have different pricing (e.g., different',
    `previous_loan_pricing_id` BIGINT COMMENT 'Self-referencing FK on pricing (previous_loan_pricing_id)',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Pricing tiers, spread schedules, and RAROC targets are defined per product type. pricing_type and pricing_tier are plain-text fields on pricing; linking to product_type enables standardized pricing po',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Loan pricing references benchmark rates (SOFR, EURIBOR, SONIA) requiring benchmark metadata (administrator, fallback rate, observation shift, lookback period) for rate resets, fallback provisions (IBO',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Floating-rate loan pricing desks reference security benchmarks (SOFR, EURIBOR indices) for base rate determination and MiFID/FRTB reporting. pricing already has rate_benchmark_id→reference.rate_benchm',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Loan pricing for leveraged loans and loans held-for-sale must reference the trading book to support FRTB market risk capital calculations, fair value pricing models, and internal transfer pricing. A b',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Loan pricing models use yield curves to derive base rates, compute present values for RAROC, and set FTP charges. This is a named treasury/ALM process distinct from the benchmark reference. Role-prefi',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ADD CONSTRAINT `fk_loan_loan_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ADD CONSTRAINT `fk_loan_amortization_schedule_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ADD CONSTRAINT `fk_loan_drawdown_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_amortization_schedule_id` FOREIGN KEY (`amortization_schedule_id`) REFERENCES `banking_ecm`.`loan`.`amortization_schedule`(`amortization_schedule_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_drawdown_id` FOREIGN KEY (`drawdown_id`) REFERENCES `banking_ecm`.`loan`.`drawdown`(`drawdown_id`);
ALTER TABLE `banking_ecm`.`loan`.`repayment` ADD CONSTRAINT `fk_loan_repayment_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`covenant` ADD CONSTRAINT `fk_loan_covenant_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_credit_review_id` FOREIGN KEY (`credit_review_id`) REFERENCES `banking_ecm`.`loan`.`credit_review`(`credit_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ADD CONSTRAINT `fk_loan_loan_ecl_provision_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_credit_review_id` FOREIGN KEY (`credit_review_id`) REFERENCES `banking_ecm`.`loan`.`credit_review`(`credit_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`modification` ADD CONSTRAINT `fk_loan_modification_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ADD CONSTRAINT `fk_loan_collateral_link_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_credit_review_id` FOREIGN KEY (`credit_review_id`) REFERENCES `banking_ecm`.`loan`.`credit_review`(`credit_review_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_loan_ecl_provision_id` FOREIGN KEY (`loan_ecl_provision_id`) REFERENCES `banking_ecm`.`loan`.`loan_ecl_provision`(`loan_ecl_provision_id`);
ALTER TABLE `banking_ecm`.`loan`.`write_off` ADD CONSTRAINT `fk_loan_write_off_modification_id` FOREIGN KEY (`modification_id`) REFERENCES `banking_ecm`.`loan`.`modification`(`modification_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ADD CONSTRAINT `fk_loan_credit_review_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc` ADD CONSTRAINT `fk_loan_lc_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ADD CONSTRAINT `fk_loan_lc_drawing_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ADD CONSTRAINT `fk_loan_documentary_collection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ADD CONSTRAINT `fk_loan_bank_guarantee_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_bank_guarantee_id` FOREIGN KEY (`bank_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`bank_guarantee`(`bank_guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_documentary_collection_id` FOREIGN KEY (`documentary_collection_id`) REFERENCES `banking_ecm`.`loan`.`documentary_collection`(`documentary_collection_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_guarantee_id` FOREIGN KEY (`guarantee_id`) REFERENCES `banking_ecm`.`loan`.`guarantee`(`guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_lc_drawing_id` FOREIGN KEY (`lc_drawing_id`) REFERENCES `banking_ecm`.`loan`.`lc_drawing`(`lc_drawing_id`);
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ADD CONSTRAINT `fk_loan_trade_document_lc_id` FOREIGN KEY (`lc_id`) REFERENCES `banking_ecm`.`loan`.`lc`(`lc_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ADD CONSTRAINT `fk_loan_guarantee_parent_guarantee_id` FOREIGN KEY (`parent_guarantee_id`) REFERENCES `banking_ecm`.`loan`.`guarantee`(`guarantee_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_drawdown_id` FOREIGN KEY (`drawdown_id`) REFERENCES `banking_ecm`.`loan`.`drawdown`(`drawdown_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ADD CONSTRAINT `fk_loan_disbursement_reversal_disbursement_id` FOREIGN KEY (`reversal_disbursement_id`) REFERENCES `banking_ecm`.`loan`.`disbursement`(`disbursement_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `banking_ecm`.`loan`.`facility`(`facility_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_loan_account_id` FOREIGN KEY (`loan_account_id`) REFERENCES `banking_ecm`.`loan`.`loan_account`(`loan_account_id`);
ALTER TABLE `banking_ecm`.`loan`.`pricing` ADD CONSTRAINT `fk_loan_pricing_previous_loan_pricing_id` FOREIGN KEY (`previous_loan_pricing_id`) REFERENCES `banking_ecm`.`loan`.`pricing`(`pricing_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`loan` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`loan` SET TAGS ('dbx_domain' = 'loan');
ALTER TABLE `banking_ecm`.`loan`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`facility` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `facility_party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower ID');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `first_drawdown_date` SET TAGS ('dbx_business_glossary_term' = 'First Drawdown Date');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Credit Impairment Stage');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `interest_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Basis');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `interest_rate_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Spread (BPS — Basis Points)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `loan_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Loan Purpose Code');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`loan`.`facility` ALTER COLUMN `npl_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Flag');
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
ALTER TABLE `banking_ecm`.`loan`.`credit_application` SET TAGS ('dbx_subdomain' = 'credit_origination');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `credit_application_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Application ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Application Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Number');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Type');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new|renewal|refinance|modification|increase|restructure');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Amount');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `approved_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Approved Interest Rate');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `approved_term_months` SET TAGS ('dbx_business_glossary_term' = 'Approved Loan Term in Months');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `conditions_precedent` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `credit_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Committee Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `banking_ecm`.`loan`.`credit_application` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
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
ALTER TABLE `banking_ecm`.`loan`.`loan_account` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `payment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Number');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Status');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|delinquent|npl|charged_off|closed|suspended');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `accrued_fees` SET TAGS ('dbx_business_glossary_term' = 'Accrued Fees');
ALTER TABLE `banking_ecm`.`loan`.`loan_account` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
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
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `amortization_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Amortization Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`amortization_schedule` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`drawdown` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `drawdown_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `fx_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Syndication Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `tranche_id` SET TAGS ('dbx_business_glossary_term' = 'Tranche Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Amount');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `available_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Commitment Amount');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `commitment_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Commitment Utilization Percentage (PCT)');
ALTER TABLE `banking_ecm`.`loan`.`drawdown` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
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
ALTER TABLE `banking_ecm`.`loan`.`repayment` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `repayment_id` SET TAGS ('dbx_business_glossary_term' = 'Repayment Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `amortization_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Amortization Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Repayment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `ctr_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ctr Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `drawdown_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Waiver Amount');
ALTER TABLE `banking_ecm`.`loan`.`repayment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`loan`.`covenant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`covenant` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `covenant_id` SET TAGS ('dbx_business_glossary_term' = 'Covenant Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`covenant` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `loan_ecl_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Expected Credit Loss (ECL) Provision ID');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`loan_ecl_provision` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`modification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`loan`.`modification` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `modification_id` SET TAGS ('dbx_business_glossary_term' = 'Modification Identifier');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Modification Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`modification` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `collateral_link_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Link Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Collateral Allocation Percentage');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `cross_collateralization_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Collateralization Flag');
ALTER TABLE `banking_ecm`.`loan`.`collateral_link` ALTER COLUMN `cross_default_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Flag');
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
ALTER TABLE `banking_ecm`.`loan`.`write_off` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Journal Entry Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `loan_ecl_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Ecl Provision Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `modification_id` SET TAGS ('dbx_business_glossary_term' = 'Modification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Identifier');
ALTER TABLE `banking_ecm`.`loan`.`write_off` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`credit_review` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower ID');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Security Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`credit_review` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `capital_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Expiry Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Issuance Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiating Bank ID');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) ID');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amended_field_name` SET TAGS ('dbx_business_glossary_term' = 'Amended Field Name');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Compliance Flag');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `banking_ecm`.`loan`.`lc_drawing` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'amount_increase|amount_decrease|expiry_extension|condition_change|document_modification|beneficiary_change');
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
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `fx_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Drawer Party Identifier');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`documentary_collection` ALTER COLUMN `tertiary_documentary_case_of_need_party_id` SET TAGS ('dbx_business_glossary_term' = 'Case of Need Party Identifier');
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
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `capital_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `fx_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Issuance Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`bank_guarantee` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `bank_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `documentary_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Documentary Collection Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `lc_drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Drawing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`trade_document` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`loan`.`guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` SET TAGS ('dbx_subdomain' = 'trade_finance');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `party_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `guarantee_party_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier (ID)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `parent_guarantee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Amendment Count');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `call_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Call Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Call Date');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `capital_relief_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Amount');
ALTER TABLE `banking_ecm`.`loan`.`guarantee` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Coverage Amount');
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
ALTER TABLE `banking_ecm`.`loan`.`disbursement` SET TAGS ('dbx_subdomain' = 'loan_servicing');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `drawdown_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Journal Entry ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `reversal_disbursement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `conditions_precedent_checklist` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent Checklist');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `conditions_precedent_satisfied_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent Satisfied Flag');
ALTER TABLE `banking_ecm`.`loan`.`disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
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
ALTER TABLE `banking_ecm`.`loan`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`loan`.`pricing` SET TAGS ('dbx_subdomain' = 'credit_origination');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing ID');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `previous_loan_pricing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Security Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`loan`.`pricing` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Yield Curve Id (Foreign Key)');
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
