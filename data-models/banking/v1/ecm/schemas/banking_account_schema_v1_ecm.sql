-- Schema for Domain: account | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`account` COMMENT 'Authoritative registry of all deposit and transactional accounts including DDA, savings, money market, certificates of deposit, and custodial accounts. Manages account lifecycle, balance tracking, interest accrual parameters, IBAN/BIC assignment, account-level limits, and statement generation. Core system of record aligned with Temenos T24 / FIS Profile.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`account`.`deposit_account` (
    `deposit_account_id` BIGINT COMMENT 'Unique system identifier for the deposit account. Primary key.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Every deposit account has a branch of record for regulatory reporting (FDIC call reports), customer service routing, and branch performance attribution. Core banking operational requirement. Removes d',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for the account denomination (e.g., USD, EUR, GBP).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Every deposit account must map to a GL account for balance sheet reporting, regulatory call reports (FFIEC 031/041), and financial statement preparation. This is the fundamental subledger-to-GL link i',
    `account_number` STRING COMMENT 'Externally visible account number assigned to the deposit account. Used for customer-facing transactions and statements.. Valid values are `^[0-9]{10,16}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the deposit account. Frozen indicates regulatory or legal hold; dormant indicates no customer-initiated activity within the dormancy period.. Valid values are `active|dormant|closed|frozen|restricted|pending_opening`',
    `account_type` STRING COMMENT 'Classification of the deposit account product type. DDA = Demand Deposit Account (checking), NOW = Negotiable Order of Withdrawal.. Valid values are `DDA|savings|money_market|NOW|certificate_of_deposit|custodial`',
    `aml_risk_rating` STRING COMMENT 'AML risk classification assigned to the account based on customer profile, transaction patterns, and geographic factors.. Valid values are `low|medium|high|prohibited`',
    `amount_escheated` DECIMAL(18,2) COMMENT 'Total amount remitted to the state as unclaimed property. Null if not yet escheated.',
    `atm_withdrawal_limit` DECIMAL(18,2) COMMENT 'Maximum amount that can be withdrawn via ATM in a single transaction or calendar day.',
    `available_balance` DECIMAL(18,2) COMMENT 'Available balance for withdrawal or transfer, accounting for holds, pending transactions, and overdraft limits.',
    `bic` STRING COMMENT 'Bank Identifier Code (also known as SWIFT code) identifying the financial institution holding the account.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `closing_date` DATE COMMENT 'Date the deposit account was officially closed. Null for active accounts.',
    `compounding_frequency` STRING COMMENT 'Frequency at which accrued interest is capitalized and added to the principal balance.. Valid values are `daily|monthly|quarterly|annually|none`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the deposit account record was first created in the core banking system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the account is reportable under OECD Common Reporting Standard for automatic exchange of financial account information.',
    `current_balance` DECIMAL(18,2) COMMENT 'Current ledger balance of the deposit account, reflecting all posted transactions.',
    `daily_transfer_limit` DECIMAL(18,2) COMMENT 'Maximum amount that can be transferred out of the account in a single calendar day.',
    `daily_withdrawal_limit` DECIMAL(18,2) COMMENT 'Maximum amount that can be withdrawn from the account in a single calendar day across all channels.',
    `dormancy_classification_date` DATE COMMENT 'Date the account was classified as dormant due to lack of customer-initiated activity for the defined dormancy period.',
    `dormancy_period_months` STRING COMMENT 'Number of months of inactivity required before the account is classified as dormant, per state or regulatory requirements.',
    `escheatment_filing_date` DATE COMMENT 'Date the account balance was reported and remitted to the state as unclaimed property. Null if not yet escheated.',
    `escheatment_jurisdiction` STRING COMMENT 'Two-letter US state code or jurisdiction to which unclaimed funds must be escheated.. Valid values are `^[A-Z]{2}$`',
    `fatca_status` STRING COMMENT 'FATCA compliance status for foreign account tax reporting requirements.. Valid values are `compliant|non_compliant|exempt|not_applicable`',
    `fdic_coverage_category` STRING COMMENT 'FDIC insurance coverage category determining the insurance limit applicable to this account. [ENUM-REF-CANDIDATE: single|joint|revocable_trust|irrevocable_trust|employee_benefit|corporation|government — 7 candidates stripped; promote to reference product]',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether the account is covered by FDIC deposit insurance.',
    `iban` STRING COMMENT 'International Bank Account Number for cross-border payment identification and routing.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_accrual_method` STRING COMMENT 'Method by which interest is calculated and accrued on the account balance.. Valid values are `daily|monthly|quarterly|simple|compound`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Current annual interest rate applied to the account balance, expressed as a decimal (e.g., 0.02500 for 2.5%).',
    `kyc_verification_date` DATE COMMENT 'Date the most recent KYC verification was completed for this account.',
    `kyc_verification_status` STRING COMMENT 'Status of KYC verification and customer due diligence for AML compliance.. Valid values are `verified|pending|failed|expired`',
    `last_activity_date` DATE COMMENT 'Date of the most recent customer-initiated transaction or activity on the account. Used for dormancy tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the deposit account record was last updated.',
    `last_statement_date` DATE COMMENT 'Date of the most recent account statement generated for this account.',
    `opening_date` DATE COMMENT 'Date the deposit account was officially opened and became active for transactions.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum approved overdraft amount for the account. Zero or null indicates no overdraft facility.',
    `overdraft_opt_in_status` STRING COMMENT 'Customer election status for overdraft coverage on ATM and one-time debit card transactions, as required by Regulation E.. Valid values are `opted_in|opted_out|not_applicable`',
    `overdraft_protection_source` STRING COMMENT 'Source of funds for overdraft protection, if configured. Indicates the linked account or credit facility used to cover overdrafts.. Valid values are `none|linked_savings|line_of_credit|credit_card`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the deposit account. [ENUM-REF-CANDIDATE: individual|joint|corporate|trust|estate|custodial|government — 7 candidates stripped; promote to reference product]',
    `product_code` STRING COMMENT 'Internal product code linking this account to the banks deposit product catalog and pricing schedule.. Valid values are `^[A-Z0-9]{4,12}$`',
    `regulatory_classification` STRING COMMENT 'Federal Reserve regulatory classification for reserve requirement and reporting purposes.. Valid values are `transaction_account|savings_deposit|time_deposit`',
    `statement_cycle` STRING COMMENT 'Frequency at which account statements are generated and delivered to the account holder.. Valid values are `monthly|quarterly|annually|on_demand`',
    `tax_reporting_status` STRING COMMENT 'Tax reporting classification for IRS Form 1099-INT reporting and FATCA compliance.. Valid values are `US_person|foreign_person|exempt|pending`',
    CONSTRAINT pk_deposit_account PRIMARY KEY(`deposit_account_id`)
) COMMENT 'Authoritative master record for all deposit and transactional accounts including DDA (Demand Deposit Accounts), savings, money market, and NOW accounts. Captures account number, IBAN, BIC, currency, branch/sort code, opening date, account status (active, dormant, closed, frozen), ownership type, and product reference. Includes embedded child record sets for: (1) overdraft facility configuration — approved limit, linked protection source, transfer fee, opt-in/opt-out status per Reg E, utilization tracking; (2) account-level operational limits — daily withdrawal, transfer, ATM, wire, ACH debit limits with approval authority and override flags; (3) dormancy and escheatment tracking — last activity date, dormancy classification date, dormancy period, state escheatment threshold, outreach log, escheatment filing date, amount escheated, jurisdiction; (4) document registry — signature cards, account agreements, beneficial ownership certifications, W-9/W-8BEN, POA, court orders with version, status, and storage reference; (5) immutable status transition history — previous/new status, effective datetime, reason code, initiating channel, authorizing officer. Interest accrual method, compounding frequency, statement cycle, and regulatory classification round out the record. Core system-of-record entity aligned with Temenos T24 ACCOUNT.ARRANGEMENT / FIS Profile deposit module.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`certificate_of_deposit` (
    `certificate_of_deposit_id` BIGINT COMMENT 'Unique system identifier for the certificate of deposit instrument. Primary key for the CD master record.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the bank employee responsible for managing the customer relationship and CD product. Used for sales attribution and client servicing.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the CD denomination (e.g., USD, EUR, GBP). Multi-currency CDs supported for institutional clients.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the parent deposit account under which this CD is registered. Links to the authoritative account registry.',
    `employee_id` BIGINT COMMENT 'System user ID or employee ID of the person who last modified this CD record. Supports audit trail and accountability requirements.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: CDs are time deposits requiring GL mapping for balance sheet classification, interest expense accrual, and regulatory capital calculations. Essential for financial reporting and FDIC insurance trackin',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: CDs are debt securities with ISINs/CUSIPs traded in secondary markets. Banks must link CD accounts to security master for mark-to-market valuation, regulatory capital calculations (HQLA classification',
    `party_id` BIGINT COMMENT 'Reference to the customer (retail or institutional) who owns this certificate of deposit.',
    `rate_benchmark_id` BIGINT COMMENT 'Reference rate index for variable-rate CDs. SOFR: Secured Overnight Financing Rate; FED_FUNDS: Federal Funds Rate; LIBOR: legacy London Interbank Offered Rate; PRIME: bank prime rate; TREASURY: U.S. Treasury yield. Null for fixed-rate CDs.',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'Cumulative interest earned from issue date to current date, calculated per the day count convention and compounding frequency. Updated daily or per compounding schedule.',
    `apy` DECIMAL(18,2) COMMENT 'Effective annual rate of return accounting for compounding effects. Disclosed to customers per Regulation DD Truth in Savings requirements. Expressed as decimal (e.g., 0.0330 for 3.30%).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the CD automatically rolls over into a new term at maturity if no customer instruction is received. True: auto-renew enabled; False: manual renewal required.',
    `branch_code` STRING COMMENT 'Identifier of the bank branch where the CD was originated. Used for internal reporting, profitability analysis, and regulatory branch-level disclosures.',
    `call_date` DATE COMMENT 'Earliest date on which the issuing bank may exercise the call option to redeem the CD. Null for non-callable CDs.',
    `call_premium_amount` DECIMAL(18,2) COMMENT 'Additional amount paid to the CD holder if the bank exercises the call option, compensating for early redemption. Null for non-callable CDs.',
    `callable_flag` BOOLEAN COMMENT 'Indicates whether the issuing bank has the right to redeem the CD before maturity. True: callable CD with issuer redemption option; False: non-callable, customer holds to maturity.',
    `cd_number` STRING COMMENT 'Externally visible certificate number assigned to this CD instrument. Used for customer statements, regulatory reporting, and inter-bank communication.',
    `cd_status` STRING COMMENT 'Current lifecycle state of the CD instrument. Active: accruing interest; Matured: reached term end; Redeemed: early withdrawal executed; Rolled-over: renewed into new term; Closed: final settlement completed.. Valid values are `active|matured|redeemed|rolled_over|closed`',
    `cd_type` STRING COMMENT 'Classification of the CD product structure. Traditional: standard fixed-rate; Jumbo: high-value institutional; Brokered: issued through intermediary; Callable: issuer redemption option; Bump-up: rate adjustment option; Variable-rate: floating coupon.. Valid values are `traditional|jumbo|brokered|callable|bump_up|variable_rate`',
    `compounding_frequency` STRING COMMENT 'Frequency at which accrued interest is capitalized and added to principal for subsequent interest calculations. At_maturity: simple interest paid at term end.. Valid values are `daily|monthly|quarterly|semi_annually|annually|at_maturity`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CD record was first created in the system. Audit trail for record origination.',
    `day_count_convention` STRING COMMENT 'Method for calculating the fraction of a year for interest accrual. ACT/360: actual days over 360-day year; ACT/365: actual days over 365-day year; ACT/ACT: actual days over actual year; 30/360: assumes 30-day months.. Valid values are `ACT_360|ACT_365|ACT_ACT|30_360`',
    `early_withdrawal_penalty_flag` BOOLEAN COMMENT 'Indicates whether a penalty applies if the CD is redeemed before maturity. True: penalty schedule in effect; False: penalty-free early withdrawal permitted (rare, typically for death/disability exceptions).',
    `face_value_amount` DECIMAL(18,2) COMMENT 'Principal amount deposited at CD origination. This is the base amount on which interest accrues over the term.',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether the CD is covered by FDIC deposit insurance up to the statutory limit ($250,000 per depositor per institution). True: FDIC insured; False: uninsured or exceeds coverage limit.',
    `grace_period_days` STRING COMMENT 'Number of days after maturity during which the customer may withdraw funds or change renewal instructions without penalty. Typical range: 7-10 days.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate (APR) applied to the face value for interest accrual. Fixed for traditional CDs; variable for floating-rate CDs. Expressed as decimal (e.g., 0.0325 for 3.25%).',
    `issue_date` DATE COMMENT 'Date on which the CD was issued and the deposit was accepted. Marks the start of the interest accrual period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to this CD record. Audit trail for change tracking and data lineage.',
    `maturity_date` DATE COMMENT 'Date on which the CD term ends and principal plus accrued interest becomes payable to the holder. Calculated from issue date plus term in days.',
    `maturity_value_amount` DECIMAL(18,2) COMMENT 'Total amount payable at maturity, including principal and all accrued interest. Calculated at issue and updated if rate changes (variable-rate CDs).',
    `negotiable_flag` BOOLEAN COMMENT 'Indicates whether the CD is a negotiable instrument that can be traded in secondary markets. True: negotiable CD with CUSIP/ISIN; False: non-negotiable retail CD held to maturity.',
    `penalty_calculation_method` STRING COMMENT 'Method used to compute the early withdrawal penalty amount. Simple_interest: penalty based on simple interest; Compound_interest: penalty includes compounding; Flat_fee: fixed dollar amount; Percentage_of_principal: percentage of face value.. Valid values are `simple_interest|compound_interest|flat_fee|percentage_of_principal`',
    `penalty_months_interest` STRING COMMENT 'Number of months of interest forfeited as penalty for early withdrawal. Common values: 3, 6, 12 months. Null if no penalty applies.',
    `rate_spread_bps` STRING COMMENT 'Margin added to the benchmark rate for variable-rate CDs, expressed in basis points (1 BPS = 0.01%). Example: SOFR + 50 BPS. Null for fixed-rate CDs.',
    `rate_type` STRING COMMENT 'Classification of the interest rate structure. Fixed: rate locked at issue; Variable: rate tied to benchmark (SOFR, Fed Funds); Step-up: rate increases at predefined intervals.. Valid values are `fixed|variable|step_up`',
    `regulatory_reserve_classification` STRING COMMENT 'Federal Reserve classification for reserve requirement purposes. Time_deposit: CDs with original maturity > 7 days (typically exempt from reserve requirements under Regulation D). Savings_deposit: CDs with < 7 days. Transaction_account: rare for CDs.. Valid values are `transaction_account|savings_deposit|time_deposit`',
    `renewal_instruction` STRING COMMENT 'Customer directive for funds disposition at maturity. Principal_only: renew principal, disburse interest; Principal_plus_interest: renew both; Transfer_to_dda: move to demand deposit account; Hold_for_instruction: await customer decision.. Valid values are `principal_only|principal_plus_interest|transfer_to_dda|hold_for_instruction`',
    `renewal_term_days` STRING COMMENT 'Term length in days for the new CD if auto-renewal is executed. May differ from original term. Null if auto-renewal is disabled.',
    `source_system_code` STRING COMMENT 'Identifier of the originating core banking system or platform that created this CD record. Supports multi-system environments and data lineage tracking.',
    `term_days` STRING COMMENT 'Total number of calendar days from issue to maturity. Common terms: 30, 60, 90, 180, 365, 730 days. Drives interest calculation and regulatory reserve classification.',
    CONSTRAINT pk_certificate_of_deposit PRIMARY KEY(`certificate_of_deposit_id`)
) COMMENT 'Master record for time-deposit instruments (CDs) issued to retail and institutional clients. Tracks face value, maturity date, term in days, fixed or variable interest rate, compounding basis (ACT/360, ACT/365), early withdrawal penalty schedule, auto-renewal flag, rollover instructions, CUSIP/ISIN if negotiable, and regulatory reserve classification. Distinct lifecycle from demand deposits — governed by Reg D and Reg Q constraints.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`custodial_account` (
    `custodial_account_id` BIGINT COMMENT 'Unique identifier for the custodial account. Primary key for this entity.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Custodial accounts require proper KYC/AML on beneficiaries for regulatory compliance (BSA/AML, fiduciary reporting). Links beneficiary to party master for identity verification, sanctions screening, a',
    `branch_id` BIGINT COMMENT 'Identifier of the bank branch or trust office where the custodial account is domiciled and administered.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the trust officer or relationship manager responsible for managing the custodial account and serving as primary contact for beneficiaries.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the base currency for account valuation and reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Custodial accounts require GL mapping for fiduciary accounting, trust department financial reporting, fee revenue recognition, and regulatory compliance (OCC trust regulations). Current_balance must r',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Custodial accounts (529 plans, UGMA/UTMA, trust accounts) are paired with investor accounts for securities/fund holdings. Custodial_account tracks fiduciary relationship and cash; investor_account tra',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the bank entity or trust department acting as custodian and fiduciary for this account.',
    `loan_fee_schedule_id` BIGINT COMMENT 'Identifier of the fee schedule governing custodial and fiduciary fees charged to this account, including management fees, transaction fees, and administrative charges.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Custodial accounts require linked deposit accounts for trade settlement, custody fee debits, corporate action cash proceeds, and securities lending collateral. Core operational requirement for custody',
    `account_name` STRING COMMENT 'Legal name or title of the custodial account as it appears on statements and regulatory filings.',
    `account_number` STRING COMMENT 'Externally-visible unique account number assigned to the custodial account. May conform to IBAN format for international accounts or internal bank numbering scheme.. Valid values are `^[A-Z0-9]{10,34}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the custodial account. Active accounts are operational; dormant accounts have no recent activity; suspended accounts have temporary restrictions; closed accounts are terminated; pending approval accounts await regulatory or internal approval; restricted accounts have limited transaction capabilities due to legal or compliance holds.. Valid values are `active|dormant|suspended|closed|pending_approval|restricted`',
    `aml_risk_rating` STRING COMMENT 'Risk rating assigned to the custodial account for anti-money laundering monitoring purposes. Low-risk accounts have minimal AML concerns; medium-risk require standard monitoring; high-risk require enhanced due diligence; prohibited accounts are blocked from transactions.. Valid values are `low|medium|high|prohibited`',
    `annual_management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee rate charged for custodial and fiduciary services, expressed as a percentage of assets under management (e.g., 0.0100 for 1.00% annual fee).',
    `cash_balance` DECIMAL(18,2) COMMENT 'Current cash balance held in the custodial account, excluding securities and other non-cash assets.',
    `closing_date` DATE COMMENT 'Date when the custodial account was closed or terminated. Null for active accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the custodial account record was first created in the system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the custodial account is reportable under the OECD Common Reporting Standard for automatic exchange of financial account information between tax authorities.',
    `current_balance` DECIMAL(18,2) COMMENT 'Current total balance of all assets held in the custodial account, expressed in the account base currency. Includes cash, securities at market value, and other assets.',
    `distribution_frequency` STRING COMMENT 'Scheduled frequency for distributions from the custodial account. Monthly, quarterly, and annual distributions follow regular schedules; on-demand distributions occur at beneficiary request; event-triggered distributions occur upon specific conditions; none indicates no regular distributions.. Valid values are `monthly|quarterly|annually|on_demand|event_triggered|none`',
    `distribution_instruction` STRING COMMENT 'Instructions governing distributions from the custodial account to beneficiaries, including frequency, amount, conditions, and triggering events as specified in the governing instrument.',
    `fatca_status` STRING COMMENT 'Compliance status of the custodial account with FATCA reporting requirements. Compliant accounts have completed required reporting; non-compliant accounts have outstanding FATCA obligations; exempt accounts are not subject to FATCA; not applicable for domestic-only accounts.. Valid values are `compliant|non_compliant|exempt|not_applicable`',
    `fiduciary_relationship_type` STRING COMMENT 'Classification of the fiduciary relationship governing the custodial account. Trust accounts hold assets under trust agreement; escrow accounts hold funds pending transaction completion; IOLTA (Interest on Lawyers Trust Accounts) hold client funds for attorneys; guardian accounts hold assets for minors or incapacitated persons; conservator accounts manage financial affairs under court order; executor accounts manage estate assets.. Valid values are `trust|escrow|iolta|guardian|conservator|executor`',
    `governing_instrument_date` DATE COMMENT 'Effective date of the governing legal instrument (trust agreement, court order, escrow agreement) that establishes the fiduciary relationship.',
    `governing_instrument_reference` STRING COMMENT 'Reference number or identifier of the legal document governing the custodial relationship, such as trust agreement number, court order number, escrow agreement reference, or will reference.',
    `grantor_name` STRING COMMENT 'Full legal name of the grantor, settlor, or person who established the custodial account and transferred assets into fiduciary custody.',
    `interest_accrual_method` STRING COMMENT 'Method used to calculate and accrue interest on the custodial account cash balance. Daily accrual calculates interest each day; monthly and quarterly accrue at period end; simple interest does not compound; compound interest includes interest-on-interest.. Valid values are `daily|monthly|quarterly|simple|compound`',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether the cash portion of the custodial account earns interest. IOLTA accounts typically earn interest for charitable purposes; other custodial accounts may or may not be interest-bearing.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the cash balance of the custodial account, expressed as a decimal (e.g., 0.0250 for 2.50%). Null for non-interest-bearing accounts.',
    `investment_restriction_description` STRING COMMENT 'Detailed description of any investment restrictions, limitations, or guidelines applicable to the custodial account assets, such as prohibited asset classes, concentration limits, or risk parameters.',
    `investment_restriction_flag` BOOLEAN COMMENT 'Indicates whether the custodial account is subject to investment restrictions defined in the governing instrument or by applicable law (e.g., prudent investor rule, prohibited investments).',
    `jurisdiction_state` STRING COMMENT 'Two-letter US state code indicating the legal jurisdiction governing the custodial account, particularly relevant for state trust law and probate matters.. Valid values are `^[A-Z]{2}$`',
    `kyc_review_date` DATE COMMENT 'Date when the most recent KYC review was completed for this custodial account.',
    `kyc_status` STRING COMMENT 'Status of Know Your Customer due diligence for the custodial account, including verification of beneficiary and grantor identities. Verified accounts have completed KYC; pending accounts are under review; expired accounts require re-verification; failed accounts did not pass KYC checks.. Valid values are `verified|pending|expired|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the custodial account record was last updated or modified.',
    `last_statement_date` DATE COMMENT 'Date when the most recent account statement was generated and issued.',
    `last_valuation_date` DATE COMMENT 'Date when the custodial account assets were last valued and marked-to-market for reporting purposes.',
    `next_statement_date` DATE COMMENT 'Scheduled date for the next account statement generation.',
    `opening_date` DATE COMMENT 'Date when the custodial account was officially opened and became operational.',
    `regulatory_regime` STRING COMMENT 'Primary regulatory framework governing the custodial account. OCC federal regulations apply to national bank trust departments; state trust law applies to state-chartered institutions; ERISA governs employee benefit plan accounts; Uniform Trust Code applies in adopting states; probate court governs estate and guardianship accounts.. Valid values are `occ_federal|state_trust_law|erisa|uniform_trust_code|probate_court`',
    `securities_market_value` DECIMAL(18,2) COMMENT 'Current market value of all securities held in the custodial account, marked-to-market as of the last valuation date.',
    `statement_frequency` STRING COMMENT 'Frequency at which account statements are generated and delivered to beneficiaries or account holders.. Valid values are `monthly|quarterly|annually`',
    CONSTRAINT pk_custodial_account PRIMARY KEY(`custodial_account_id`)
) COMMENT 'Master record for custodial and fiduciary accounts held on behalf of third parties including trust accounts, escrow accounts, IOLTA accounts, and minor/guardian accounts. Captures beneficiary details, fiduciary relationship type, governing instrument reference, custodian entity, investment restrictions, distribution instructions, and applicable regulatory regime (OCC trust regulations, state fiduciary law). Distinct from standard deposit accounts due to fiduciary obligations and separate legal ownership.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the account holder association record. Primary key.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Account holders pledge their deposit accounts or account-held assets as collateral for credit facilities. Banks track which account holder executed the pledge for legal enforceability, signature autho',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit, certificate of deposit (CD), or custodial account to which this holder relationship applies. Links to the account domain.',
    `employee_id` BIGINT COMMENT 'The system user ID or employee ID of the person who created this account holder record. Audit trail field for accountability and compliance.',
    `holder_last_modified_by_user_employee_id` BIGINT COMMENT 'The system user ID or employee ID of the person who last modified this account holder record. Audit trail field for accountability and compliance.',
    `party_id` BIGINT COMMENT 'Reference to the individual or legal entity (from customer domain) who holds rights or interests in the account. Links to the customer master.',
    `aml_risk_rating` STRING COMMENT 'The Anti-Money Laundering (AML) risk rating assigned to this account holder based on customer profile, transaction patterns, geographic risk, and other factors. Determines monitoring intensity and reporting requirements.. Valid values are `low|medium|high|prohibited`',
    `aml_risk_rating_date` DATE COMMENT 'The date on which the current AML risk rating was assigned or last reviewed. Used to track compliance with periodic risk assessment requirements.',
    `beneficiary_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of account proceeds allocated to this beneficiary upon the death of the account owner. Must sum to 100.00 across all beneficiaries of the same account. Null for non-beneficiary roles.',
    `beneficiary_designation_date` DATE COMMENT 'The date on which the beneficiary designation was made by the account owner. Null if this holder is not a beneficiary.',
    `beneficiary_relationship` STRING COMMENT 'The relationship of the beneficiary to the account owner. Used for estate planning, probate processing, and FDIC insurance coverage calculation. None if this holder is not a beneficiary. [ENUM-REF-CANDIDATE: spouse|child|parent|sibling|other_relative|friend|organization|none — 8 candidates stripped; promote to reference product]',
    `beneficiary_revocation_date` DATE COMMENT 'The date on which the beneficiary designation was revoked by the account owner. Null if the beneficiary designation is still active or was never revoked.',
    `beneficiary_type` STRING COMMENT 'The type of beneficiary designation for payable-on-death (POD) or transfer-on-death (TOD) roles. Individual for natural persons; trust for revocable or irrevocable trusts; estate for estate of deceased; charity for non-profit organizations. None if this holder is not a beneficiary.. Valid values are `individual|trust|estate|charity|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this account holder record was first created in the system. Audit trail field for record creation tracking.',
    `designation_date` DATE COMMENT 'The date on which the customer was formally designated or added to the account in this role. May differ from effective_date if there is a lag between designation and activation.',
    `effective_date` DATE COMMENT 'The date on which this account holder relationship became active and the customer gained the specified rights and authorities. Corresponds to account opening date for original owners or designation date for added holders.',
    `expiry_date` DATE COMMENT 'The date on which this account holder relationship ends or is scheduled to end. Null for open-ended relationships. Populated when a holder is removed, a power of attorney expires, or a custodial arrangement terminates.',
    `fdic_insurance_category` STRING COMMENT 'The FDIC insurance ownership category applicable to this account holder relationship. Determines insurance coverage limits and aggregation rules. Single for individual ownership; joint for joint ownership; revocable_trust for living trusts; irrevocable_trust for irrevocable trusts; employee_benefit for retirement accounts; corporation for business entities; government for public funds. [ENUM-REF-CANDIDATE: single|joint|revocable_trust|irrevocable_trust|employee_benefit|corporation|government — 7 candidates stripped; promote to reference product]',
    `kyc_next_review_date` DATE COMMENT 'The date on which the next periodic KYC review is due for this account holder. Determined by risk rating and regulatory requirements.',
    `kyc_verification_date` DATE COMMENT 'The date on which KYC verification was completed for this account holder. Used to track compliance with periodic re-verification requirements.',
    `kyc_verification_status` STRING COMMENT 'The status of Know Your Customer (KYC) verification for this account holder. Verified indicates successful identity verification; pending indicates verification in progress; failed indicates verification could not be completed; expired indicates verification needs renewal.. Valid values are `verified|pending|failed|expired`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this account holder record was last updated. Audit trail field for change tracking.',
    `notification_preference` STRING COMMENT 'The preferred communication channel for account notifications and alerts for this holder. Email for electronic mail; SMS for text messages; phone for voice calls; mail for postal mail; none if notifications are suppressed.. Valid values are `email|sms|phone|mail|none`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership interest held by this customer in the account. Applicable for joint accounts where ownership is divided. Must sum to 100.00 across all owners of the same account. Null for non-ownership roles (authorized signer, power of attorney).',
    `ownership_role` STRING COMMENT 'The role or capacity in which the customer holds rights to the account. Determines access rights, signing authority, and legal standing. Primary owner has full control; joint owner shares ownership; authorized signer can transact but does not own; power of attorney acts on behalf of owner; trustee manages for beneficiaries; custodian holds for minors or incapacitated persons.. Valid values are `primary_owner|joint_owner|authorized_signer|power_of_attorney|trustee|custodian`',
    `pep_status` BOOLEAN COMMENT 'Indicates whether this account holder is identified as a Politically Exposed Person (PEP) - an individual who holds or has held a prominent public position. True if PEP; False if not. PEP status triggers enhanced due diligence requirements.',
    `relationship_status` STRING COMMENT 'The current lifecycle status of this account holder relationship. Active indicates the relationship is in effect and the holder has the specified rights; inactive indicates temporary suspension; suspended indicates regulatory or compliance hold; terminated indicates the relationship has ended.. Valid values are `active|inactive|suspended|terminated`',
    `revocation_date` DATE COMMENT 'The date on which the account holder designation was revoked or terminated by the account owner or by operation of law. Null if the relationship is still active or was never revoked.',
    `sanctions_screening_date` DATE COMMENT 'The date on which the most recent sanctions screening was performed for this account holder. Screening is typically performed at onboarding and periodically thereafter.',
    `sanctions_screening_status` STRING COMMENT 'The result of sanctions screening against OFAC, UN, EU, and other sanctions lists. Clear indicates no match; match indicates potential match requiring review; pending_review indicates screening in progress; blocked indicates confirmed match and account restrictions applied.. Valid values are `clear|match|pending_review|blocked`',
    `signing_authority_level` STRING COMMENT 'The level of transaction authority granted to this holder. Full authority allows all transactions without limits; limited authority is subject to transaction amount thresholds or approval requirements; none indicates no transactional rights (e.g., beneficiary-only role).. Valid values are `full|limited|none`',
    `signing_authority_limit_amount` DECIMAL(18,2) COMMENT 'The maximum transaction amount (in account currency) that this holder can authorize without additional approval. Applicable when signing_authority_level is limited. Null for full or none authority levels.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this account holder record originated. Examples include Temenos T24, FIS Profile, or manual entry. Used for data lineage and reconciliation.',
    `source_system_record_reference` STRING COMMENT 'The unique identifier of this account holder record in the source system. Used for traceability and reconciliation back to the operational system of record.',
    `statement_delivery_preference` STRING COMMENT 'The account holders preference for receiving account statements. Electronic for online/email delivery; paper for postal mail; both for dual delivery; none if statements are suppressed (e.g., for non-primary holders).. Valid values are `electronic|paper|both|none`',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or file path to supporting legal documentation for this holder relationship. Examples include power of attorney documents, trust agreements, custodial orders, beneficiary designation forms, or court orders.',
    `tax_id_number` STRING COMMENT 'The tax identification number (TIN) for this account holder. Social Security Number (SSN) for US individuals; Employer Identification Number (EIN) for US entities; foreign tax ID for non-US persons. Used for tax reporting and compliance.',
    `tax_id_type` STRING COMMENT 'The type of tax identification number provided. SSN for Social Security Number; EIN for Employer Identification Number; ITIN for Individual Taxpayer Identification Number; foreign_tin for non-US tax ID; none if not provided or not applicable.. Valid values are `ssn|ein|itin|foreign_tin|none`',
    `tax_reporting_status` STRING COMMENT 'The tax reporting status for interest and other income attributable to this account holder. Reportable indicates 1099-INT reporting required; exempt indicates tax-exempt entity; foreign indicates FATCA or CRS reporting required; pending indicates status determination in progress.. Valid values are `reportable|exempt|foreign|pending`',
    `termination_reason` STRING COMMENT 'The reason for termination of this account holder relationship. Examples include account closure, holder removal by owner, death of holder, expiration of power of attorney, or regulatory action. Null if relationship is still active.',
    `w9_w8_form_received_date` DATE COMMENT 'The date on which the IRS Form W-9 (for US persons) or Form W-8 (for foreign persons) was received from this account holder. Required for tax reporting compliance.',
    CONSTRAINT pk_holder PRIMARY KEY(`holder_id`)
) COMMENT 'Association entity linking customers (individuals or legal entities from the customer domain) to deposit, CD, and custodial accounts with role-based ownership, beneficiary, and fiduciary semantics. Captures ownership role (primary owner, joint owner, authorized signer, power of attorney, trustee), ownership percentage for joint accounts, signing authority level, effective date, expiry date, and designation/revocation dates. Includes embedded beneficiary designation records for payable-on-death (POD) and transfer-on-death (TOD) roles: beneficiary type (individual, trust, estate, charity), allocation percentage, designation date, revocation date, and supporting documentation reference. Beneficiary roles are legally distinct from ownership roles — beneficiaries have no access rights during the account holders lifetime but receive proceeds upon death, governed by state law and FDIC insurance rules. Enables multi-party account ownership modeling required for KYC, AML, estate processing, FDIC insurance coverage calculation across ownership categories, and probate/succession workflows. Single source of truth for all account-to-person associations including both ownership and beneficiary designations.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`balance` (
    `balance_id` BIGINT COMMENT 'Unique identifier for the account balance snapshot record. Primary key for the account balance data product.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Account balances are period-end snapshots required for regulatory call reports, balance sheet preparation, and financial close. This links operational balances to the fiscal calendar for reporting.',
    `currency_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code in which the account balance is denominated (e.g., USD, EUR, GBP, JPY).',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit or transactional account for which this balance snapshot is recorded. Links to the authoritative account registry.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The cumulative interest earned but not yet credited to the account as of the balance date. Calculated based on the interest rate, balance tier, and accrual method defined in the account terms.',
    `available_balance` DECIMAL(18,2) COMMENT 'The balance available for withdrawal or use by the account holder. Calculated as ledger balance minus holds, pending debits, and uncollected funds, plus any available overdraft or credit line.',
    `available_overdraft` DECIMAL(18,2) COMMENT 'The remaining overdraft capacity available to the account holder, calculated as overdraft limit minus current overdraft balance utilized.',
    `average_daily_balance` DECIMAL(18,2) COMMENT 'The average ledger balance for the statement period or month-to-date, calculated by summing daily balances and dividing by the number of days. Used for interest calculation and Net Interest Margin (NIM) analysis.',
    `balance_date` DATE COMMENT 'The business date for which this balance snapshot is recorded. Represents the end-of-day position for the specified date.',
    `balance_status` STRING COMMENT 'The operational status of the account balance. Active indicates normal operations; frozen indicates temporary suspension; dormant indicates no activity for an extended period; closed indicates account closure; restricted indicates limited transaction capability.. Valid values are `active|frozen|dormant|closed|restricted`',
    `collateral_pledged_amount` DECIMAL(18,2) COMMENT 'The portion of the account balance that has been pledged as collateral for loans, letters of credit, or other obligations, reducing the available balance for withdrawal.',
    `collected_balance` DECIMAL(18,2) COMMENT 'The portion of the ledger balance that has cleared and is available for reserve requirement calculation. Excludes float and uncollected funds from deposited checks or transfers still in clearing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this balance snapshot record was first created in the data lakehouse silver layer. Used for data lineage and audit trail purposes.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score (0-100) representing the completeness, accuracy, and consistency of the balance record based on automated data quality rules. Used for data governance and issue identification.',
    `days_in_period` STRING COMMENT 'The number of calendar days in the current statement period, used as the denominator for average daily balance calculation.',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Boolean indicator that is true if the account balance is eligible for escheatment to the state due to dormancy or abandonment under applicable unclaimed property laws.',
    `fdic_insured_amount` DECIMAL(18,2) COMMENT 'The portion of the account balance that is covered by FDIC deposit insurance, up to the standard maximum deposit insurance amount per depositor, per insured bank, for each account ownership category.',
    `float_balance` DECIMAL(18,2) COMMENT 'The amount of funds in transit or pending collection, representing deposits that have been credited to the ledger balance but have not yet cleared through the payment system.',
    `hold_balance` DECIMAL(18,2) COMMENT 'The total amount of funds subject to holds, restrictions, or encumbrances that reduce the available balance. Includes administrative holds, legal holds, and collateral pledges.',
    `interest_bearing_balance` DECIMAL(18,2) COMMENT 'The portion of the account balance that is eligible for interest accrual based on the account type and interest calculation method. May differ from ledger balance due to minimum balance requirements or tiered rate structures.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent customer-initiated transaction on the account. Used to determine dormancy status and escheatment eligibility.',
    `ledger_balance` DECIMAL(18,2) COMMENT 'The book balance of the account including all posted transactions as of the balance date. Represents the official accounting balance before adjustments for holds, floats, or uncollected funds.',
    `maximum_balance` DECIMAL(18,2) COMMENT 'The highest ledger balance recorded during the statement period or month-to-date. Used for FDIC insurance limit monitoring and liquidity analysis.',
    `minimum_balance` DECIMAL(18,2) COMMENT 'The lowest ledger balance recorded during the statement period or month-to-date. Used to determine minimum balance threshold breach and fee assessment.',
    `minimum_balance_threshold_breach_flag` BOOLEAN COMMENT 'Boolean indicator that is true if the account balance fell below the contractual minimum balance threshold during the period, triggering potential fee assessment or service charge.',
    `overdraft_balance` DECIMAL(18,2) COMMENT 'The amount by which the account is overdrawn if the ledger balance is negative. Zero if the account has a positive balance. Used for overdraft fee calculation and credit risk monitoring.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'The maximum negative balance allowed for the account under the overdraft protection program or line of credit. Zero if no overdraft facility is available.',
    `pending_credits` DECIMAL(18,2) COMMENT 'The total amount of incoming transactions that have been authorized but not yet posted to the ledger balance. Includes pending deposits, transfers, and reversals.',
    `pending_debits` DECIMAL(18,2) COMMENT 'The total amount of outgoing transactions that have been authorized but not yet posted to the ledger balance. Includes pending withdrawals, payments, and fees.',
    `reconciliation_status` STRING COMMENT 'The status of the balance reconciliation process between the core banking system and the general ledger. Reconciled indicates successful matching; pending indicates awaiting reconciliation; exception indicates discrepancy requiring investigation; override indicates manual adjustment applied.. Valid values are `reconciled|pending|exception|override`',
    `reserve_requirement_balance` DECIMAL(18,2) COMMENT 'The portion of the account balance subject to Federal Reserve reserve requirements under Regulation D. Used for Asset-Liability Management (ALM) and reserve calculation.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The exact date and time when this balance snapshot was captured from the core banking system, typically during the end-of-day batch processing cycle.',
    `source_system` STRING COMMENT 'The core banking system from which this balance snapshot was extracted. Identifies the system of record for data lineage and reconciliation purposes.. Valid values are `T24|FIS_PROFILE|FINACLE|OTHER`',
    `statement_cycle_end_date` DATE COMMENT 'The last date of the current statement period for which average daily balance and other period-based metrics are calculated.',
    `statement_cycle_start_date` DATE COMMENT 'The first date of the current statement period for which average daily balance and other period-based metrics are calculated.',
    `uninsured_amount` DECIMAL(18,2) COMMENT 'The portion of the account balance that exceeds FDIC insurance limits and is therefore at risk in the event of bank failure. Used for depositor risk disclosure and liquidity stress testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this balance snapshot record was last modified in the data lakehouse silver layer. Used for change tracking and audit trail purposes.',
    CONSTRAINT pk_balance PRIMARY KEY(`balance_id`)
) COMMENT 'Daily snapshot of account balance positions including ledger balance, available balance, collected balance, float balance, and hold balance. Tracks as-of date, currency, overdraft utilization, minimum balance threshold breach flag, average daily balance for the statement period, and interest-bearing balance. Used for NIM calculation, reserve requirement compliance (Reg D), and FDIC insurance limit monitoring. Sourced from Temenos T24 end-of-day balance file.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_transaction` (
    `account_transaction_id` BIGINT COMMENT 'Unique identifier for the account transaction record. Primary key for the account transaction entity.',
    `batch_id` BIGINT COMMENT 'Identifier of the processing batch in which this transaction was posted. Used for operational reconciliation and batch error resolution.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Every transaction occurs through a specific channel for fraud detection, AML monitoring (CTR/SAR reporting), channel analytics, and customer behavior analysis. Essential for BSA/AML compliance and ope',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Internal transfers between customer accounts require counterparty identification for AML transaction monitoring, related-party transaction detection, and regulatory reporting (CTR, SAR). When counterp',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the transaction amount is denominated.',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the deposit or transactional account to which this transaction was posted. Links to the authoritative account registry.',
    `employee_id` BIGINT COMMENT 'Identifier of the teller or customer service representative who processed the transaction at a branch. Null for automated or self-service transactions.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Account transactions generating fees, interest adjustments, or corrections create journal entries for GL posting. This link supports subledger-to-GL reconciliation, audit trails, and financial close p',
    `reversed_transaction_account_transaction_id` BIGINT COMMENT 'Reference to the original account transaction ID that this transaction reverses. Null if this is not a reversal transaction.',
    `ach_trace_number` STRING COMMENT '15-digit trace number assigned to ACH transactions for tracking and reconciliation purposes. Null for non-ACH transactions.',
    `aml_alert_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this transaction triggered an AML alert requiring investigation. True if alert generated, False otherwise.',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the AML transaction monitoring system indicating the likelihood of money laundering or suspicious activity. Higher scores trigger enhanced review.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the transaction in the accounts base currency. Positive for credits, negative for debits per accounting convention.',
    `balance_after_transaction` DECIMAL(18,2) COMMENT 'The running account balance immediately after this transaction was posted. Used for statement generation and overdraft detection.',
    `branch_code` STRING COMMENT 'The code of the branch or business unit where the transaction was initiated or processed. Used for profitability analysis and operational reporting.',
    `card_authorization_code` STRING COMMENT 'Authorization code returned by the card network for approved card transactions. Null for non-card transactions.',
    `counterparty_account_number` STRING COMMENT 'The account number of the counterparty (originator or beneficiary) involved in the transaction. May be an internal account, external IBAN, or card number depending on transaction type.',
    `counterparty_bank_bic` STRING COMMENT 'The SWIFT BIC (Bank Identifier Code) of the counterpartys financial institution for wire transfers and cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first created in the core banking system. Used for audit trail and data lineage tracking.',
    `ctr_reportable_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this transaction meets the threshold for Currency Transaction Report filing with FinCEN (typically cash transactions over $10,000).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied for currency conversion if the transaction involved foreign exchange. Null for single-currency transactions.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The amount of any fee charged in association with this transaction (e.g., overdraft fee, wire transfer fee, ATM surcharge). Zero if no fee applies.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this transaction posts for financial accounting and regulatory reporting purposes.',
    `hold_amount` DECIMAL(18,2) COMMENT 'The amount of funds placed on hold or reserved as a result of this transaction (e.g., check hold, card authorization hold). Null if no hold applies.',
    `hold_release_date` DATE COMMENT 'The date on which any hold placed by this transaction will be released and funds will become available. Null if no hold applies.',
    `interest_amount` DECIMAL(18,2) COMMENT 'The amount of interest credited or debited as part of this transaction. Applicable for interest accrual postings on deposit accounts. Zero if not an interest transaction.',
    `merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 code classifying the type of merchant or service provider for card transactions. Used for spend analytics and rewards program eligibility.. Valid values are `^[0-9]{4}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified or updated. Used for change tracking and audit purposes.',
    `narrative` STRING COMMENT 'Free-text description or memo field providing additional context about the transaction purpose, merchant name, or customer-entered notes. Appears on account statements.',
    `original_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount in the original currency before conversion to the account base currency. Null if no conversion occurred.',
    `original_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the original transaction currency before conversion to the account base currency. Null if no conversion occurred.. Valid values are `^[A-Z]{3}$`',
    `payment_system_reference` STRING COMMENT 'Unique identifier assigned by the originating payment system or network (ACH trace number, wire IMAD/OMAD, SWIFT UETR, card authorization code). Used for end-to-end traceability and dispute resolution.',
    `posting_date` DATE COMMENT 'The date on which the transaction was actually posted to the account ledger in the core banking system. Used for GL reconciliation and regulatory reporting cutoff.',
    `posting_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the transaction was committed to the account ledger, including time zone. Critical for intraday liquidity monitoring and real-time balance calculations.',
    `reference_number` STRING COMMENT 'Externally visible unique reference number assigned to this transaction for customer inquiries, statement reconciliation, and audit trail purposes.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this transaction is a reversal of a previously posted transaction. True if reversal, False otherwise.',
    `settlement_date` DATE COMMENT 'The date on which the transaction settled through the payment system or clearing house. May differ from posting date for multi-day clearing cycles.',
    `transaction_date` DATE COMMENT 'The business date on which the transaction was initiated or authorized by the customer or originating system. This is the date visible to the customer on statements.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the transaction indicating whether it is pending settlement, successfully posted to the ledger, reversed, failed, or cancelled.. Valid values are `pending|posted|reversed|failed|cancelled`',
    `type_code` STRING COMMENT 'Classification of the transaction indicating whether it is a debit, credit, fee charge, interest accrual, adjustment, or reversal posting.. Valid values are `debit|credit|fee|interest|adjustment|reversal`',
    `value_date` DATE COMMENT 'The date on which funds become available or are debited for interest calculation purposes. May differ from transaction date due to clearing cycles or holds.',
    `wire_imad` STRING COMMENT 'Input Message Accountability Data assigned to incoming wire transfers by the Federal Reserve or CHIPS. Null for non-wire transactions.',
    `wire_omad` STRING COMMENT 'Output Message Accountability Data assigned to outgoing wire transfers by the Federal Reserve or CHIPS. Null for non-wire transactions.',
    CONSTRAINT pk_account_transaction PRIMARY KEY(`account_transaction_id`)
) COMMENT 'Granular record of every debit and credit posting to a deposit account. Captures transaction date, value date, posting date, transaction type code, channel (branch, ATM, ACH, wire, card, online), amount, currency, running balance after posting, reference number, counterparty account, narrative/memo, reversal flag, and originating payment system reference. Primary audit trail for account activity; feeds statement generation, AML transaction monitoring, and GL subledger reconciliation.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`statement` (
    `statement_id` BIGINT COMMENT 'Unique identifier for the account statement record. Primary key for the account statement entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Account statements are generated for specific accounting periods and must align with fiscal calendar for regulatory reporting (call reports), financial close, and period-end balance verification.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the statement balances and amounts are denominated (e.g., USD, EUR, GBP).',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Statement delivery channel tracking is required for regulatory proof of delivery (Reg E, Reg DD), customer preference management, and cost optimization. Links to channel for delivery method analytics ',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account for which this statement was generated. Links to the core account master record in the Core Banking System (Temenos T24 / FIS Profile).',
    `annual_percentage_yield` DECIMAL(18,2) COMMENT 'The annualized rate of return on the account, expressed as a percentage, reflecting the effect of compounding interest. Disclosed per Regulation DD requirements.',
    `archival_date` DATE COMMENT 'The date when the statement was moved to archival storage or purged, if applicable. Used for compliance with record retention policies.',
    `archival_status` STRING COMMENT 'Indicates the current archival state of the statement record. Active statements are readily accessible; archived statements are moved to long-term storage; purged statements have been deleted per retention policy.. Valid values are `active|archived|purged`',
    `average_daily_balance` DECIMAL(18,2) COMMENT 'The average of the accounts daily ending balances throughout the statement period. Used for interest calculation and minimum balance requirements.',
    `bic` STRING COMMENT 'The Bank Identifier Code (also known as SWIFT code) for the financial institution holding the account. Used for international wire transfers and SWIFT messaging.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `closing_balance` DECIMAL(18,2) COMMENT 'The account balance at the end of the statement period (as of statement_period_end_date). Represents the final ledger balance after all transactions in this cycle.',
    `cycle_code` STRING COMMENT 'Internal code representing the statement cycle configuration (e.g., monthly on the 1st, quarterly on the 15th). Used for batch processing and scheduling.',
    `delivery_status` STRING COMMENT 'Current status of the statement delivery process. Tracks whether the statement has been successfully delivered to the customer and, for electronic statements, whether it has been accessed.. Valid values are `pending|delivered|failed|bounced|viewed|downloaded`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the statement was successfully delivered or made available to the account holder through the specified delivery channel.',
    `escheatment_warning_flag` BOOLEAN COMMENT 'Indicates whether this statement includes a warning that the account is approaching dormancy and may be subject to escheatment (transfer to state unclaimed property). Required in certain jurisdictions.',
    `fees_charged` DECIMAL(18,2) COMMENT 'The total fees and service charges assessed against the account during the statement period, including maintenance fees, overdraft fees, and transaction fees.',
    `format` STRING COMMENT 'The file format or medium in which the statement is generated and delivered. PDF is standard for electronic statements; paper indicates physical print.. Valid values are `pdf|html|csv|xml|paper`',
    `generated_by_system` STRING COMMENT 'The name or identifier of the core banking system or statement generation platform that produced this statement (e.g., Temenos T24, FIS Profile).',
    `generated_timestamp` TIMESTAMP COMMENT 'The date and time when the statement record was generated by the core banking system. Represents the system event time for audit and reconciliation.',
    `iban` STRING COMMENT 'The International Bank Account Number for the account, if applicable. Used for international transactions and regulatory reporting in jurisdictions that require IBAN.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `interest_earned` DECIMAL(18,2) COMMENT 'The total interest accrued and credited to the account during the statement period. Calculated based on the accounts interest rate and daily balance.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The nominal annual interest rate applied to the account during the statement period, expressed as a percentage. May be tiered based on balance.',
    `language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the statement is generated (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `maximum_balance` DECIMAL(18,2) COMMENT 'The highest account balance recorded during the statement period. Provides insight into peak liquidity and deposit patterns.',
    `minimum_balance` DECIMAL(18,2) COMMENT 'The lowest account balance recorded during the statement period. Used to determine compliance with minimum balance requirements and fee waivers.',
    `notice_of_change_flag` BOOLEAN COMMENT 'Indicates whether this statement includes a notice of change to account terms, fees, or interest rates. Required for regulatory compliance and customer notification.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The account balance at the beginning of the statement period (as of statement_period_start_date). Represents the starting ledger balance before any transactions in this cycle.',
    `overdraft_count` STRING COMMENT 'The number of times the account balance went negative (overdraft) during the statement period. Used for fee assessment and risk monitoring.',
    `overdraft_fees` DECIMAL(18,2) COMMENT 'The total overdraft and non-sufficient funds (NSF) fees charged during the statement period. Subset of total fees_charged, broken out for regulatory disclosure.',
    `period_end_date` DATE COMMENT 'The last date of the statement cycle period. Represents the end of the transaction window covered by this statement.',
    `period_start_date` DATE COMMENT 'The first date of the statement cycle period. Represents the beginning of the transaction window covered by this statement.',
    `reg_dd_disclosure_flag` BOOLEAN COMMENT 'Indicates whether Regulation DD disclosures (Truth in Savings Act - interest rates, fees, terms) are included on this statement. Required for deposit accounts.',
    `reg_e_disclosure_flag` BOOLEAN COMMENT 'Indicates whether Regulation E disclosures (electronic fund transfer rights and liabilities) are included on this statement. Required for accounts with EFT activity.',
    `statement_date` DATE COMMENT 'The official date on which the statement was generated and made available to the account holder. This is the date printed on the statement document.',
    `statement_number` STRING COMMENT 'Externally visible unique statement number assigned by the core banking system for customer reference and audit purposes. Typically follows a sequential or date-based numbering scheme.',
    `statement_type` STRING COMMENT 'Classification of the statement based on its frequency or purpose. Monthly and quarterly are standard cycles; interim may be generated on demand; final indicates account closure.. Valid values are `monthly|quarterly|annual|interim|final|ad_hoc`',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether statement generation was suppressed for this cycle due to customer preference, account inactivity, or regulatory exemption.',
    `suppression_reason` STRING COMMENT 'The reason why statement generation was suppressed, if suppression_flag is true. Provides audit trail for non-delivery.. Valid values are `customer_request|no_activity|dormant_account|closed_account|regulatory_exemption`',
    `total_credits` DECIMAL(18,2) COMMENT 'The sum of all credit transactions (deposits, interest credits, reversals) posted to the account during the statement period.',
    `total_debits` DECIMAL(18,2) COMMENT 'The sum of all debit transactions (withdrawals, fees, charges, payments) posted to the account during the statement period.',
    `transaction_count` STRING COMMENT 'The total number of transactions (both credits and debits) posted to the account during the statement period. Used for summary reporting and fee calculation.',
    `viewed_timestamp` TIMESTAMP COMMENT 'The date and time when the account holder first accessed or viewed the electronic statement. Null for paper statements or if not yet viewed.',
    CONSTRAINT pk_statement PRIMARY KEY(`statement_id`)
) COMMENT 'Periodic account statement record representing a formally generated statement cycle for a deposit account. Captures statement period start and end dates, statement date, opening balance, closing balance, total credits, total debits, interest earned, fees charged, statement delivery channel (paper, e-statement, secure message), delivery status, and regulatory disclosure flags (Reg E, Reg DD). Distinct from individual transactions — represents the aggregated billing document sent to the account holder.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`interest_accrual` (
    `interest_accrual_id` BIGINT COMMENT 'Unique identifier for the daily interest accrual record. Primary key for the account interest accrual entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Interest accruals are calculated and posted by accounting period for month-end close, interest expense reporting, and tax reporting (1099-INT). Essential for period-based financial reporting.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the account and all monetary amounts in this accrual record (e.g., USD, EUR, GBP). All amounts are denominated in this currency.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account for which interest is being accrued. Links to the core account master registry.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Interest accruals on deposit accounts generate journal entries (DR Interest Expense, CR Interest Payable) during month-end close. This is the standard accounting process linking subledger accruals to ',
    `party_id` BIGINT COMMENT 'Reference to the customer who owns the account. Used for customer-level interest income reporting, tax reporting, and regulatory disclosures.',
    `accrual_basis_code` STRING COMMENT 'Day count convention used to calculate interest accrual. Determines how days are counted in the numerator and denominator of the interest calculation formula. ACT/360 is common for money market accounts, ACT/365 for savings, 30/360 for certain time deposits.. Valid values are `ACT/360|ACT/365|30/360|ACT/ACT|30/365`',
    `accrual_date` DATE COMMENT 'The business date on which this interest accrual calculation was performed. Represents the principal business event timestamp for this daily accrual record.',
    `accrual_method` STRING COMMENT 'The mathematical method used to calculate interest accrual. Simple interest is calculated on principal only; compound interest includes previously accrued interest in the calculation base; continuous uses exponential compounding.. Valid values are `simple|compound|continuous`',
    `accrual_reversal_reason` STRING COMMENT 'Code or description explaining why this accrual was reversed, if applicable. Common reasons include account closure, rate correction, system error, or NPL (Non-Performing Loan) classification requiring accrual suspension.',
    `accrual_status` STRING COMMENT 'Current lifecycle status of this accrual record. Calculated indicates daily accrual computed but not yet posted; posted indicates interest has been capitalized to account; reversed indicates accrual was backed out; suspended indicates accrual is on hold (e.g., for NPL accounts).. Valid values are `calculated|posted|reversed|suspended|pending_review`',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'The interest amount accrued for this specific accrual date, calculated as (principal_balance × applicable_interest_rate × days) / day_count_basis. This is the daily interest increment.',
    `applicable_interest_rate` DECIMAL(18,2) COMMENT 'The annualized interest rate applied to calculate this accrual, expressed as a decimal (e.g., 0.025000000 for 2.5% per annum). May reflect tiered rate, promotional rate, or base rate depending on account balance and product terms.',
    `branch_code` STRING COMMENT 'The branch or business unit code responsible for this account and its interest accrual. Used for profitability analysis, FTP (Funds Transfer Pricing), and management reporting.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The system timestamp when this interest accrual calculation was performed. Used for audit trail and to distinguish between batch calculation runs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accrual record was first created in the system. Represents the record audit trail creation point.',
    `cumulative_accrued_interest` DECIMAL(18,2) COMMENT 'The total interest accrued from the last interest posting date through the current accrual date. Represents the running total of unpaid accrued interest for the current interest period.',
    `days_in_period` STRING COMMENT 'The number of days used in the numerator of the interest calculation for this accrual date. Typically 1 for daily accrual, but may vary based on accrual basis and calendar adjustments.',
    `interest_income_gl_account` STRING COMMENT 'The general ledger account code to which this interest expense (from the banks perspective) is posted. Used for financial accounting and NII (Net Interest Income) reporting.',
    `interest_payable_gl_account` STRING COMMENT 'The general ledger account code for the accrued interest payable liability. Represents the contra-account for the interest expense accrual until interest is posted to the customer account.',
    `interest_posting_frequency` STRING COMMENT 'The frequency at which accrued interest is capitalized and posted to the account balance. Defines the cadence of interest payment or compounding per the account product terms. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi-annually|annually|at_maturity — 7 candidates stripped; promote to reference product]',
    `interest_rate_tier_code` STRING COMMENT 'Code identifying the balance tier or rate band applied for this accrual. Used when accounts have tiered interest structures where different balance ranges earn different rates.',
    `last_interest_payment_date` DATE COMMENT 'The most recent date on which interest was posted or paid to the account. Marks the beginning of the current accrual period.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this accrual record was last updated. Used for audit trail and change tracking.',
    `net_interest_amount` DECIMAL(18,2) COMMENT 'The net interest amount after withholding tax deduction, calculated as accrued_interest_amount minus withholding_tax_amount. Represents the interest amount that will be credited to the customer.',
    `next_interest_payment_date` DATE COMMENT 'The scheduled date on which the cumulative accrued interest will be posted to the account or paid to the customer. Used for interest payment planning and customer disclosure.',
    `posted_timestamp` TIMESTAMP COMMENT 'The system timestamp when the accrued interest was posted to the customer account or general ledger. Null if accrual status is calculated or pending_review.',
    `principal_balance` DECIMAL(18,2) COMMENT 'The account balance amount on which interest is calculated for this accrual date. Represents the principal subject to interest computation, typically the end-of-day ledger balance.',
    `product_code` STRING COMMENT 'The deposit product code or account type code for the account earning this interest. Used to segment interest expense by product line for NII analysis and product profitability.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this accrual must be included in regulatory capital or liquidity reporting (e.g., Basel III LCR, NSFR calculations). True if regulatory reporting is required, False otherwise.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that generated this accrual record (e.g., T24, FIS_PROFILE, CUSTOM_ACCRUAL_ENGINE). Used for data lineage and reconciliation in multi-system environments.',
    `tax_reporting_flag` BOOLEAN COMMENT 'Indicates whether this interest accrual must be included in tax reporting (e.g., 1099-INT for US customers, FATCA/CRS reporting for foreign accounts). True if tax reporting is required, False otherwise.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount withheld from the accrued interest for this accrual date, calculated as accrued_interest_amount × withholding_tax_rate. Represents the portion of interest income remitted to tax authorities.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The tax rate applied to withhold tax on interest income for applicable accounts, expressed as a decimal (e.g., 0.300000 for 30%). Applies to accounts subject to FATCA, CRS, or domestic tax withholding requirements.',
    `year_basis_days` STRING COMMENT 'The number of days used in the denominator of the interest calculation (e.g., 360, 365, or actual days in year). Determined by the accrual_basis_code and used to annualize the interest rate.',
    CONSTRAINT pk_interest_accrual PRIMARY KEY(`interest_accrual_id`)
) COMMENT 'Daily interest accrual record for interest-bearing deposit accounts. Tracks accrual date, accrual basis (ACT/360, ACT/365, 30/360), applicable interest rate tier, accrued interest amount, cumulative accrued interest for the period, interest posting frequency, next interest payment date, and withholding tax amount for applicable accounts (FATCA/CRS). Supports NII (Net Interest Income) reporting, ALCO analytics, and regulatory interest disclosure under Reg DD.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_fee` (
    `account_fee_id` BIGINT COMMENT 'Unique identifier for the account fee record. Primary key for the account fee entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fee assessments are tied to accounting periods for revenue recognition, financial reporting, and regulatory compliance. This supports period-based revenue accounting and financial close processes.',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Fee assessment errors (unauthorized fees, incorrect disclosures, Reg E violations) constitute compliance breaches requiring tracking for regulatory reporting, restitution programs, consent order compl',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the fee amount. Typically matches the accounts base currency.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account against which this fee was assessed. Links to the core banking account master.',
    `case_id` BIGINT COMMENT 'Reference to the customer dispute case or complaint ticket associated with this fee, if applicable. Used for tracking dispute resolution.',
    `employee_id` BIGINT COMMENT 'Employee identifier or system identifier of the person or automated process that authorized the fee waiver. Used for accountability and audit trail.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Fee assessments generate journal entries for revenue recognition (DR Fee Receivable/Account, CR Fee Revenue). This links the fee subledger to GL for financial reporting and revenue accounting.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fee waiver requests are processed through specific channels for audit trails, customer service quality monitoring, and fraud prevention. Required for compliance reviews and dispute resolution. No exis',
    `assessed_amount` DECIMAL(18,2) COMMENT 'The gross amount of the fee assessed against the account before any waivers or adjustments, denominated in the accounts base currency (typically USD for US operations).',
    `assessment_date` DATE COMMENT 'The business date on which the fee was assessed and posted to the account. This is the effective date for accounting and regulatory reporting purposes.',
    `assessment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the fee was assessed and recorded in the core banking system. Used for audit trail and transaction sequencing.',
    `billing_cycle` STRING COMMENT 'The billing cycle or statement period during which the fee was assessed. Typically formatted as YYYYMM or a cycle sequence number.',
    `branch_code` STRING COMMENT 'The branch or service center code where the account is domiciled or where the fee-triggering transaction occurred. Used for profitability analysis and branch performance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this fee record was first created in the data warehouse. Used for data lineage and audit trail.',
    `customer_notification_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer was notified of this fee assessment through statement, email, SMS, or other communication channel.',
    `disclosure_statement_text` STRING COMMENT 'The standardized disclosure text that must be provided to the customer for this fee type, as required by CFPB Regulation DD or other applicable regulations.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer has disputed this fee charge. True if a dispute case has been opened, False otherwise.',
    `fee_description` STRING COMMENT 'Detailed textual description of the fee assessed, including the reason and context for the charge. Used for customer statement generation and dispute resolution.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the fee income is posted. Used for financial accounting and revenue recognition.',
    `line_of_business` STRING COMMENT 'The business segment or line of business to which this fee is attributed. RETAIL=Retail Banking, COMMERCIAL=Commercial Banking, WEALTH=Wealth Management, PRIVATE=Private Banking.. Valid values are `RETAIL|COMMERCIAL|WEALTH|PRIVATE`',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'The net fee amount charged to the account after waivers and adjustments (assessed_amount minus waived_amount). This is the amount that impacts the account balance and fee income.',
    `notification_channel` STRING COMMENT 'The communication channel through which the customer was notified of the fee. STATEMENT=Account Statement, EMAIL=Email Notification, SMS=Text Message, MOBILE=Mobile App Push Notification, BRANCH=In-Branch Notification.. Valid values are `STATEMENT|EMAIL|SMS|MOBILE|BRANCH`',
    `product_code` STRING COMMENT 'The product code or account type code of the deposit account against which the fee was assessed. Used for product profitability analysis.',
    `regulatory_disclosure_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fee type requires specific regulatory disclosure to the customer under CFPB Regulation DD or other consumer protection regulations.',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which the fee revenue is recognized in the general ledger. May differ from assessment_date due to revenue recognition policies.',
    `reversal_date` DATE COMMENT 'The business date on which the fee was reversed and credited back to the account. Null if no reversal has occurred.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fee has been fully reversed. True if the entire net_fee_amount has been credited back to the account.',
    `reversal_reason_code` STRING COMMENT 'Standardized code indicating the reason for fee reversal. ERROR=System or Processing Error, DISPUTE=Customer Dispute Resolution, GOODWILL=Customer Service Goodwill, REGULATORY=Regulatory Compliance Requirement, FRAUD=Fraudulent Activity. Null if no reversal occurred.. Valid values are `ERROR|DISPUTE|GOODWILL|REGULATORY|FRAUD`',
    `source_system_code` STRING COMMENT 'Identifier of the source operational system from which this fee record originated (e.g., T24, FIS_PROFILE). Used for data lineage and reconciliation.',
    `transaction_reference_number` STRING COMMENT 'The unique transaction identifier from the core banking system that triggered the fee assessment (e.g., the overdraft transaction ID, wire transfer ID, or ATM transaction ID). Used for reconciliation and dispute resolution.',
    `type_code` STRING COMMENT 'Classification code identifying the type of fee assessed. MAINT=Monthly Maintenance Fee, OD=Overdraft Fee, NSF=Non-Sufficient Funds Fee, WIRE=Wire Transfer Fee, ATM=Automated Teller Machine (ATM) Surcharge Fee, CLOSE=Early Account Closure Fee, DORM=Dormancy/Inactivity Fee. [ENUM-REF-CANDIDATE: MAINT|OD|NSF|WIRE|ATM|CLOSE|DORM — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The system timestamp when this fee record was last modified in the data warehouse. Used for change tracking and audit trail.',
    `waived_amount` DECIMAL(18,2) COMMENT 'The portion of the assessed fee that was waived or reversed, denominated in the accounts base currency. Zero if no waiver was applied.',
    `waiver_flag` BOOLEAN COMMENT 'Boolean indicator of whether any portion of the fee was waived. True if waived_amount is greater than zero, False otherwise.',
    `waiver_reason_code` STRING COMMENT 'Standardized code indicating the reason for fee waiver. CUST_REQ=Customer Request/Goodwill, SVC_FAIL=Service Failure, PROMO=Promotional Waiver, REL_MGMT=Relationship Management, REG_COMP=Regulatory Compliance, ERROR=System or Processing Error. Null if no waiver applied.. Valid values are `CUST_REQ|SVC_FAIL|PROMO|REL_MGMT|REG_COMP|ERROR`',
    `waiver_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the fee waiver decision. Used for audit and customer service documentation.',
    `waiver_timestamp` TIMESTAMP COMMENT 'The date and time when the fee waiver was authorized and processed. Null if no waiver was applied.',
    CONSTRAINT pk_account_fee PRIMARY KEY(`account_fee_id`)
) COMMENT 'Record of fees assessed against deposit accounts including monthly maintenance fees, overdraft fees (NSF), wire transfer fees, ATM surcharge fees, early account closure fees, and dormancy fees. Captures fee type, assessed amount, waiver flag, waiver reason, waiver authority, assessment date, billing cycle, and regulatory disclosure requirement. Supports fee income reporting, CFPB compliance monitoring, and customer profitability analysis.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the account hold record. Primary key.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the hold amount. Must match the account base currency in most cases, but may differ for foreign exchange holds or multi-currency accounts.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account on which the hold is placed. Links to the core banking system account master.',
    `employee_id` BIGINT COMMENT 'System user ID or employee identifier of the individual who placed the hold. Null for automated system-generated holds. Used for audit and accountability.',
    `hold_last_modified_user_employee_id` BIGINT COMMENT 'System user ID or employee identifier of the individual who last modified the hold record. Null for automated system updates. Used for audit and accountability.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Legal and regulatory holds are placed through specific channels for compliance audit trails, dispute resolution, and fraud investigation documentation. Required for regulatory examinations and litigat',
    `actual_release_date` DATE COMMENT 'The business date on which the hold was actually released or cancelled. Null for active holds. May differ from expected release date if manually released early or extended.',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold was released, including timezone offset. Used for audit and compliance reporting.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of funds restricted by this hold, denominated in the account currency. This amount is unavailable for withdrawal or payment processing.',
    `beneficiary_name` STRING COMMENT 'The name of the party entitled to receive the held funds, if applicable. Used for garnishments (e.g., creditor name), levies (e.g., IRS), or child support orders. Null for holds without a designated beneficiary.',
    `beneficiary_reference` STRING COMMENT 'External reference number or account identifier for the beneficiary, such as a creditor account number or tax identification number. Null if not applicable.',
    `check_amount` DECIMAL(18,2) COMMENT 'The face value of the check that triggered the hold, if applicable. May differ from hold_amount if only a portion of the check is held. Null for non-check holds.',
    `check_serial_number` STRING COMMENT 'The serial number of the deposited check that triggered the hold, if applicable. Used for Reg CC check holds and exception case tracking. Null for non-check holds.',
    `court_case_number` STRING COMMENT 'The docket or case number from the court order authorizing the hold, if applicable. Used for garnishments, levies, and legal holds. Null for non-legal holds.',
    `court_jurisdiction` STRING COMMENT 'The name of the court or legal jurisdiction that issued the order, if applicable. Examples: Superior Court of California, County of Los Angeles, U.S. District Court, Southern District of New York. Null for non-legal holds.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether the account holder has been notified of the hold placement, as required by Reg CC for check holds and consumer protection regulations for other hold types.',
    `dispute_date` DATE COMMENT 'The date on which the customer filed a dispute regarding this hold. Null if no dispute has been filed.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed the hold. True if a formal dispute or complaint has been filed; false otherwise. Triggers compliance review workflow.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the dispute was resolved. Null if the dispute is still open or no dispute was filed.',
    `expected_release_date` DATE COMMENT 'The anticipated business date on which the hold will be automatically released, based on regulatory timelines (e.g., Reg CC hold periods) or court order expiration. Nullable for indefinite holds.',
    `expiration_action` STRING COMMENT 'The action to be taken when the hold reaches its expected release date. Auto-release holds are lifted automatically; manual review holds require operations approval; extend holds are renewed for another period; escalate holds trigger compliance or legal review.. Valid values are `auto_release|manual_review|extend|escalate`',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold. Active holds reduce available balance; released holds have been lifted; expired holds passed their release date; cancelled holds were removed before maturity; partial release indicates a portion of the hold amount has been freed.. Valid values are `active|released|expired|cancelled|partial_release`',
    `hold_type` STRING COMMENT 'Classification of the hold based on its origin and purpose. Check holds are governed by Reg CC; legal holds include garnishments, levies, and court orders; fraud holds are placed by compliance or fraud teams; administrative holds are internal operational restrictions. [ENUM-REF-CANDIDATE: check_hold|legal_hold|administrative_hold|garnishment|levy|fraud_hold|regulatory_hold|collateral_hold — 8 candidates stripped; promote to reference product]',
    `internal_notes` STRING COMMENT 'Free-text field for internal operational notes, case management updates, and audit trail commentary. Not visible to customers. Used by operations, compliance, and legal teams for case tracking.',
    `is_current_record` BOOLEAN COMMENT 'Indicates whether this is the current active version of the hold record. True for the latest version; false for historical versions. Used for SCD Type 2 queries.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this hold record was last updated in the source system or lakehouse. Used for incremental data processing and audit trails.',
    `notification_date` DATE COMMENT 'The date on which the customer notification was sent or delivered. Null if no notification has been sent. Used for regulatory compliance tracking.',
    `notification_method` STRING COMMENT 'The channel through which the customer was notified of the hold. Null if no notification has been sent. [ENUM-REF-CANDIDATE: mail|email|sms|phone|in_person|online_banking|mobile_app — 7 candidates stripped; promote to reference product]',
    `partial_release_allowed` BOOLEAN COMMENT 'Indicates whether the hold can be partially released before full maturity. True for holds that support incremental release (e.g., large check holds under Reg CC); false for all-or-nothing holds (e.g., fraud holds, court orders).',
    `placement_date` DATE COMMENT 'The business date on which the hold was placed on the account. This is the effective date from which the funds became unavailable.',
    `placement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold was created in the system, including timezone offset. Used for audit trails and sequence resolution.',
    `placing_authority` STRING COMMENT 'The organizational unit or external entity that initiated the hold. Court orders and external agencies (e.g., IRS, child support enforcement) are captured separately from internal departments. [ENUM-REF-CANDIDATE: branch|legal_department|compliance|court_order|fraud_team|operations|automated_system|external_agency — 8 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Numeric priority ranking for this hold when multiple holds exist on the same account. Lower numbers indicate higher priority. Used to determine order of fund allocation when account balance is insufficient to cover all holds. Legal holds typically have higher priority than administrative holds.',
    `reason_code` STRING COMMENT 'Standardized internal code representing the specific reason for the hold. Maps to regulatory categories (e.g., Reg CC exception holds) and internal operational codes.',
    `reason_narrative` STRING COMMENT 'Free-text description providing additional context for the hold. May include check number, court case number, fraud case ID, or other supporting details for operational and customer service use.',
    `record_effective_date` DATE COMMENT 'The business date from which this version of the hold record is effective. Used for slowly changing dimension (SCD) Type 2 historization in the lakehouse.',
    `record_end_date` DATE COMMENT 'The business date on which this version of the hold record ceased to be effective. Null for the current active version. Used for slowly changing dimension (SCD) Type 2 historization.',
    `reference_number` STRING COMMENT 'Externally visible unique reference number for the hold, used for customer inquiries and audit trails.',
    `regulatory_basis` STRING COMMENT 'The primary regulatory or legal framework under which the hold is placed. Reg CC governs check holds; BSA/AML/OFAC govern compliance holds; court orders and tax levies are legal holds. None indicates an internal administrative hold. [ENUM-REF-CANDIDATE: reg_cc|bsa|aml|ofac|court_order|garnishment_order|tax_levy|none — 8 candidates stripped; promote to reference product]',
    `released_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of funds that have been released from this hold through partial releases. Zero for holds that have not been partially released. Equals hold_amount when the hold is fully released.',
    `remaining_hold_amount` DECIMAL(18,2) COMMENT 'The current amount still held after any partial releases. Calculated as hold_amount minus released_amount. Used for real-time available balance calculation.',
    `source_system` STRING COMMENT 'The name or identifier of the upstream system that originated this hold record. Examples: Temenos T24, FIS Profile, Fraud Detection System, Legal Case Management. Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this hold record in the source system. Used for traceability and reconciliation with upstream operational systems.',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Record of funds holds and restrictions placed on deposit account balances. Captures hold type (check hold, legal hold, administrative hold, garnishment, levy, fraud hold), hold amount, hold currency, placement date, expected release date, actual release date, placing authority (branch, legal, compliance, court order), hold reason narrative, and regulatory basis (Reg CC for check holds). Critical for available balance calculation and legal/compliance workflows.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`overdraft_facility` (
    `overdraft_facility_id` BIGINT COMMENT 'Unique identifier for the overdraft facility arrangement. Primary key for the overdraft facility record.',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Overdraft facilities are often secured by collateral (CDs, securities, cash deposits) to mitigate credit risk. Banks track collateral securing overdraft lines for LTV monitoring, margin calls, regulat',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the overdraft facility limit and fees (e.g., USD, EUR, GBP).',
    `employee_id` BIGINT COMMENT 'Reference to the bank officer who approved the overdraft facility setup or most recent limit increase. Used for audit and accountability.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account (DDA, savings, money market) to which this overdraft facility is attached.',
    `approval_date` DATE COMMENT 'Date the overdraft facility was approved by the bank. Used for audit trail and compliance reporting.',
    `approved_limit_amount` DECIMAL(18,2) COMMENT 'Maximum overdraft amount approved by the bank for this facility. Represents the ceiling for negative balance coverage.',
    `auto_repayment_enabled` BOOLEAN COMMENT 'Indicates whether automatic repayment of overdraft balance is enabled. True if incoming deposits automatically reduce the overdraft balance. False if manual repayment is required.',
    `cancellation_date` DATE COMMENT 'Date the overdraft facility was cancelled and ceased to be available. Null if facility is not cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason the overdraft facility was cancelled: customer request, account closure, adverse credit review, regulatory requirement, fraud detection, or other. Null if facility is not cancelled.. Valid values are `customer_request|account_closure|credit_review|regulatory|fraud|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the overdraft facility record was first created in the system. Used for audit trail and data lineage.',
    `current_utilization_amount` DECIMAL(18,2) COMMENT 'Current outstanding overdraft balance being utilized by the customer. Represents the negative balance covered by the facility. Zero if account is not overdrawn.',
    `daily_fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total overdraft fees that can be charged in a single day. Used to limit customer exposure to excessive fees. Null if no daily cap applies.',
    `effective_date` DATE COMMENT 'Date the overdraft facility becomes active and available for use. Marks the start of the facility lifecycle.',
    `expiry_date` DATE COMMENT 'Date the overdraft facility expires and is no longer available for use. Null for open-ended facilities with no predetermined end date.',
    `facility_number` STRING COMMENT 'Externally visible business identifier for the overdraft facility, used in customer communications and statements.. Valid values are `^ODF[0-9]{10}$`',
    `facility_type` STRING COMMENT 'Classification of the overdraft protection arrangement: standard (bank covers overdraft with fee), premium (enhanced coverage), linked to savings account, linked to line of credit, or linked to credit card.. Valid values are `standard|premium|linked_savings|linked_credit_line|linked_credit_card`',
    `grace_period_days` STRING COMMENT 'Number of days the customer has to repay the overdraft balance before fees or interest are applied. Zero if no grace period applies.',
    `interest_calculation_method` STRING COMMENT 'Method used to calculate interest on the overdraft balance: daily balance, average daily balance, simple interest, compound interest, or none if no interest applies.. Valid values are `daily_balance|average_daily_balance|simple|compound|none`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate (APR) applied to the outstanding overdraft balance. Expressed as a decimal (e.g., 0.1850 for 18.50%). Zero if no interest is charged.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the overdraft facility record was last updated. Used for audit trail and change tracking.',
    `last_usage_date` DATE COMMENT 'Most recent date the overdraft facility was used (account balance went negative). Null if facility has never been used.',
    `lifetime_usage_count` STRING COMMENT 'Total number of times the overdraft facility has been used (account went into negative balance) since facility inception. Used for customer behavior analysis.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum amount that must be transferred from the linked protection source to cover an overdraft. Used to avoid multiple small transfers. Zero if no minimum applies.',
    `monthly_fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total overdraft fees that can be charged in a calendar month. Used to limit customer exposure to excessive fees. Null if no monthly cap applies.',
    `notification_preference` STRING COMMENT 'Customer preferred channel for receiving overdraft usage notifications: email, SMS text message, mobile app push notification, postal mail, or none.. Valid values are `email|sms|push|mail|none`',
    `opt_in_date` DATE COMMENT 'Date the customer provided opt-in consent for overdraft coverage per Regulation E. Null if customer has not opted in or opt-in is not applicable.',
    `opt_in_status` STRING COMMENT 'Customer opt-in status for overdraft coverage on ATM and one-time debit card transactions per Federal Reserve Regulation E. Opted in indicates customer consented. Opted out indicates customer declined. Pending indicates awaiting customer decision. Not applicable for non-Reg E overdraft types.. Valid values are `opted_in|opted_out|pending|not_applicable`',
    `opt_out_date` DATE COMMENT 'Date the customer revoked opt-in consent and opted out of overdraft coverage. Null if customer has not opted out.',
    `overdraft_facility_status` STRING COMMENT 'Current lifecycle state of the overdraft facility. Active indicates the facility is operational and available for use. Suspended indicates temporary hold. Cancelled indicates customer or bank terminated the arrangement. Expired indicates the facility reached its end date. Pending activation indicates awaiting customer opt-in or bank approval.. Valid values are `active|suspended|cancelled|expired|pending_activation`',
    `overdraft_fee_amount` DECIMAL(18,2) COMMENT 'Standard fee charged per overdraft occurrence when the account balance goes negative and bank coverage is used. Zero if no overdraft fee applies.',
    `protection_source_type` STRING COMMENT 'Identifies the source of funds used to cover overdrafts: bank coverage (bank absorbs with fee), linked savings account, linked line of credit, linked credit card, or none (no protection).. Valid values are `bank_coverage|savings_account|line_of_credit|credit_card|none`',
    `review_date` DATE COMMENT 'Next scheduled date for bank review of the overdraft facility terms, limit, and customer eligibility. Used for periodic reassessment.',
    `risk_rating` STRING COMMENT 'Bank internal risk assessment of the overdraft facility based on customer credit profile, usage patterns, and repayment history. Used for credit risk management and limit adjustments.. Valid values are `low|medium|high|very_high`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this overdraft facility record: T24 (Temenos T24), FIS_PROFILE (FIS Profile), MANUAL (manual entry), MIGRATION (data migration).. Valid values are `T24|FIS_PROFILE|MANUAL|MIGRATION`',
    `transfer_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged per overdraft transfer event when funds are moved from the linked protection source to cover a negative balance. Zero if no per-transfer fee applies.',
    `transfer_increment_amount` DECIMAL(18,2) COMMENT 'Fixed increment amount for transfers from linked protection source (e.g., transfers occur in multiples of 50.00). Null if transfers match exact overdraft amount.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the approved limit currently utilized, calculated as (current_utilization_amount / approved_limit_amount) * 100. Used for credit risk monitoring.',
    CONSTRAINT pk_overdraft_facility PRIMARY KEY(`overdraft_facility_id`)
) COMMENT 'Master record defining the overdraft protection arrangement attached to a deposit account. Captures approved overdraft limit, linked protection source (savings account, line of credit, credit card), transfer fee per use, interest rate on overdraft balance, opt-in/opt-out status per Reg E, effective date, expiry date, and utilization tracking. Distinct from the loan domains revolving credit — this is the deposit-side overdraft configuration owned by the account domain.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_limit` (
    `account_limit_id` BIGINT COMMENT 'Unique identifier for the account limit record. Primary key for the account limit entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Account limits (withdrawal, transfer, overdraft) require approval by authorized credit/operational risk officers per BSA/AML and Reg CC compliance. Existing approved_by text field should be replaced w',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the limit amount is denominated (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit or transactional account to which this limit applies. Links to the account master registry.',
    `aml_threshold_flag` BOOLEAN COMMENT 'Indicates whether this limit is configured to support Anti-Money Laundering (AML) monitoring and Currency Transaction Report (CTR) thresholds. True if AML-related, False otherwise.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary threshold or minimum balance requirement for this limit. Expressed in the currency specified in the currency_code field.',
    `approval_authority` STRING COMMENT 'The role, department, or individual authorized to approve this limit configuration. May reference a user ID, role code, or department name.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this limit was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `breach_action_code` STRING COMMENT 'Action to be taken when a transaction would breach this limit. Values: BLOCK (reject transaction), WARN (alert but allow), ALLOW_WITH_FEE (permit with penalty charge), ESCALATE (require manual approval).. Valid values are `BLOCK|WARN|ALLOW_WITH_FEE|ESCALATE`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this limit record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_requested_flag` BOOLEAN COMMENT 'Indicates whether this limit was requested by the customer (e.g., self-imposed spending limit) rather than being bank-mandated. True if customer-initiated, False if bank-imposed.',
    `effective_date` DATE COMMENT 'The date from which this account limit becomes active and enforceable. Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'The date on which this account limit ceases to be active. Nullable for limits with no predetermined end date. Format: yyyy-MM-dd.',
    `fraud_prevention_flag` BOOLEAN COMMENT 'Indicates whether this limit is primarily configured for fraud prevention purposes. True if the limit is part of fraud controls, False otherwise.',
    `last_reset_timestamp` TIMESTAMP COMMENT 'Date and time when the utilization counters were last reset. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_utilization_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent transaction that utilized this limit. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `limit_description` STRING COMMENT 'Free-text description providing additional context or business rationale for this limit configuration.',
    `limit_status` STRING COMMENT 'Current lifecycle status of the account limit. Values: ACTIVE (limit is currently enforced), SUSPENDED (temporarily not enforced), EXPIRED (past expiry date), PENDING (awaiting approval or activation), CANCELLED (permanently deactivated).. Valid values are `ACTIVE|SUSPENDED|EXPIRED|PENDING|CANCELLED`',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this limit record. May be a user ID, employee number, or system identifier.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this limit record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_channel` STRING COMMENT 'Preferred communication channel for limit-related notifications. Values: EMAIL (email notification), SMS (text message), MOBILE_APP (push notification), PHONE (voice call), NONE (no notification).. Valid values are `EMAIL|SMS|MOBILE_APP|PHONE|NONE`',
    `notification_threshold_amount` DECIMAL(18,2) COMMENT 'The utilization amount at which the customer or bank should be notified (e.g., alert when 80% of limit is reached). Nullable if no notification threshold is configured.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this limit can be overridden by authorized personnel during transaction processing. True if override is permitted, False otherwise.',
    `override_reason` STRING COMMENT 'Business justification or reason code for allowing limit overrides. Populated when override_flag is True.',
    `regulatory_mandate_code` STRING COMMENT 'Code identifying the regulatory requirement or consumer protection rule that mandates this limit (e.g., Regulation E for electronic fund transfers, Regulation D for savings account withdrawals).',
    `reset_frequency_code` STRING COMMENT 'Frequency at which the utilization counters are reset to zero. Values: DAILY (reset at start of each day), WEEKLY (reset weekly), MONTHLY (reset monthly), QUARTERLY (reset quarterly), ANNUAL (reset annually), NONE (no automatic reset).. Valid values are `DAILY|WEEKLY|MONTHLY|QUARTERLY|ANNUAL|NONE`',
    `risk_category` STRING COMMENT 'Risk classification of the account or customer for which this limit is configured. Used to determine appropriate limit thresholds. Values: LOW (minimal risk), MEDIUM (moderate risk), HIGH (elevated risk), CRITICAL (highest risk requiring strictest controls).. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `source_system_code` STRING COMMENT 'Identifier of the operational system from which this limit record originated (e.g., T24, FIS_PROFILE, ONLINE_BANKING).',
    `type_code` STRING COMMENT 'Classification of the operational limit governing transaction behavior. Values: DAILY_WITHDRAWAL (daily withdrawal limit), DAILY_TRANSFER (daily transfer limit), ATM_CASH (ATM cash limit), WIRE_TRANSFER (wire transfer limit), ACH_DEBIT (Automated Clearing House debit limit), MIN_BALANCE (minimum balance requirement).. Valid values are `DAILY_WITHDRAWAL|DAILY_TRANSFER|ATM_CASH|WIRE_TRANSFER|ACH_DEBIT|MIN_BALANCE`',
    `utilization_amount` DECIMAL(18,2) COMMENT 'Current cumulative amount utilized against this limit within the applicable time period (e.g., daily, monthly). Reset frequency depends on limit type.',
    `utilization_count` STRING COMMENT 'Number of transactions that have been applied against this limit within the current period. Used for frequency-based limits.',
    `version_number` STRING COMMENT 'Version number of this limit record, incremented with each modification. Used for optimistic locking and audit trail.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this limit record. May be a user ID, employee number, or system identifier.',
    CONSTRAINT pk_account_limit PRIMARY KEY(`account_limit_id`)
) COMMENT 'Configurable account-level operational limits governing transaction behavior. Captures limit type (daily withdrawal limit, daily transfer limit, ATM cash limit, wire transfer limit, ACH debit limit, minimum balance requirement), limit amount, currency, effective date, expiry date, approval authority, and override flag. Supports risk controls, fraud prevention, and regulatory compliance for consumer protection.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique identifier for each account status transition record. Primary key for the immutable audit log of account lifecycle events.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Status changes (active, dormant, closed) are tracked by accounting period for audit trails, regulatory reporting, and understanding account lifecycle metrics within fiscal periods for management repor',
    `batch_id` BIGINT COMMENT 'Identifier of the batch process that created this status history record, if applicable. Null for real-time transactions. Used for batch reconciliation and operational monitoring.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account that experienced the status transition. Links to the authoritative account registry in the core banking system.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the bank officer who authorized or approved the status change. Required for audit trail and segregation of duties compliance. May be system-generated for automated transitions.',
    `aml_review_required_flag` BOOLEAN COMMENT 'Indicates whether this status transition triggers mandatory AML review procedures (e.g., dormant to active reactivation, sudden closure after large deposits). True if AML review is required, False otherwise.',
    `authorizing_officer_name` STRING COMMENT 'Full name of the bank officer who authorized the status change. Provides human-readable audit trail for regulatory examination.',
    `balance_at_transition` DECIMAL(18,2) COMMENT 'The account balance at the moment of status transition. Critical for FDIC insurance claim processing, escheatment reporting, and write-off calculations. Expressed in the account currency.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context provided by the authorizing officer or system process. Supplements structured fields with case-specific details.',
    `compliance_hold_flag` BOOLEAN COMMENT 'Indicates whether the status change was driven by a compliance or regulatory hold (e.g., OFAC match, court order, regulatory investigation). True if compliance-driven, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was created in the system. Distinct from effective_timestamp, which represents the business event time. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the balance at transition. Ensures accurate multi-currency reporting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the account holder was notified of the status change via the registered communication channels. True if notification was sent, False otherwise. Required for consumer protection compliance.',
    `dormancy_period_days` STRING COMMENT 'Number of days the account remained inactive before transitioning to dormant status. Populated only for transitions to dormant status. Used for escheatment timeline calculations and regulatory dormancy reporting.',
    `effective_timestamp` TIMESTAMP COMMENT 'The precise date and time when the new status became effective for the account. This is the business event timestamp, distinct from the record creation timestamp. Critical for regulatory timeline reconstruction and FDIC insurance claim processing.',
    `hold_authority` STRING COMMENT 'Name of the regulatory authority or legal entity that mandated the hold or status change (e.g., OFAC, FBI, court name, state regulator). Populated only when compliance_hold_flag is True.',
    `hold_reference_number` STRING COMMENT 'Official reference number or case identifier from the regulatory authority or court that issued the hold. Populated only when compliance_hold_flag is True.',
    `initiating_channel` STRING COMMENT 'The channel or interface through which the status change was initiated. Distinguishes customer-initiated changes from system-automated or regulatory-driven transitions. [ENUM-REF-CANDIDATE: branch|online_banking|mobile_app|call_center|atm|back_office|system_automated|regulatory_authority|third_party — 9 candidates stripped; promote to reference product]',
    `last_transaction_date` DATE COMMENT 'The date of the most recent customer-initiated transaction before the status change. Used to calculate dormancy periods and support escheatment compliance. Null for newly opened accounts.',
    `new_status` STRING COMMENT 'The account lifecycle status after this transition was applied. Captures the to-state in the status change event. Required for regulatory examination and AML dormancy monitoring. [ENUM-REF-CANDIDATE: pending_activation|active|dormant|inactive|frozen|blocked|closed|written_off|reactivated — 9 candidates stripped; promote to reference product]',
    `notification_method` STRING COMMENT 'The communication method used to notify the customer of the status change. Captures the channel through which disclosure was delivered. [ENUM-REF-CANDIDATE: email|sms|postal_mail|secure_message|phone_call|in_person|none — 7 candidates stripped; promote to reference product]',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when customer notification was sent regarding the status change. Null if no notification was sent or required.',
    `previous_status` STRING COMMENT 'The account lifecycle status immediately before this transition occurred. Captures the from-state in the status change event. [ENUM-REF-CANDIDATE: pending_activation|active|dormant|inactive|frozen|blocked|closed|written_off — 8 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating the business or regulatory reason that triggered the status transition. Used for root cause analysis, compliance reporting, and operational metrics. [ENUM-REF-CANDIDATE: customer_request|regulatory_hold|aml_alert|fraud_suspicion|inactivity|insufficient_funds|court_order|death_notification|account_closure_request|reactivation_request|system_migration|compliance_review — 12 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative providing additional context and details about the reason for the status change. Supplements the reason code with case-specific information.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this status transition must be included in regulatory reports (e.g., dormancy reports to banking authorities, FDIC insurance claim filings, AML suspicious activity monitoring). True if reportable, False otherwise.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this status transition was subsequently reversed or corrected by a later entry. True if reversed, False if the transition stands. Used for audit trail integrity and error correction tracking.',
    `reversal_reference_code` BIGINT COMMENT 'Reference to the account_status_history_id of the reversing entry if this transition was reversed. Null if not reversed. Maintains bidirectional audit trail for corrections.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation that justifies the status change (e.g., court order number, customer request ticket, AML case ID, death certificate reference). Critical for regulatory examination and dispute resolution.',
    `system_source` STRING COMMENT 'Identifier of the source system or application that recorded the status transition (e.g., Temenos T24, FIS Profile, batch job name, API service). Used for data lineage and troubleshooting.',
    `created_by` STRING COMMENT 'User ID or system process that created this status history record. May differ from authorizing_officer_id for system-automated transitions. Used for audit trail and access control review.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Immutable audit log of all account lifecycle status transitions for deposit accounts. Captures previous status, new status, effective date and time, reason code, initiating channel, authorizing officer, and supporting documentation reference. Status transitions include: pending activation → active → dormant → reactivated → closed → written off. Required for regulatory examination, AML dormancy monitoring, and FDIC insurance claim processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`interest_rate` (
    `interest_rate_id` BIGINT COMMENT 'Unique identifier for the account interest rate configuration record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Interest rate changes become effective within specific accounting periods for accurate interest calculations, financial reporting, and net interest margin analysis. This supports period-based rate cha',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Interest rate changes and exceptions require documented approval by ALCO members, pricing committee, or relationship managers per pricing governance and margin management policies. Real business proce',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account to which this interest rate configuration applies.',
    `rate_benchmark_id` BIGINT COMMENT 'The market benchmark index to which variable rates are tied. SOFR (Secured Overnight Financing Rate), FED_FUNDS (Federal Funds Rate), PRIME (Prime Rate), LIBOR (London Interbank Offered Rate - legacy), TREASURY (US Treasury Rate), or NONE for fixed rates.',
    `superseded_by_rate_interest_rate_id` BIGINT COMMENT 'Reference to the account_interest_rate_id that supersedes this rate configuration. Used to maintain rate change history and audit trail.',
    `accrual_method` STRING COMMENT 'The day-count convention used for interest accrual calculation. Actual/360 (actual days over 360-day year), Actual/365 (actual days over 365-day year), or 30/360 (assumes 30-day months).. Valid values are `actual_360|actual_365|30_360`',
    `base_rate` DECIMAL(18,2) COMMENT 'The base annual interest rate expressed as a decimal (e.g., 0.025000 for 2.5%). For fixed rates, this is the final rate. For variable rates, this is the starting point before spread adjustment.',
    `compounding_frequency` STRING COMMENT 'The frequency at which interest is compounded and added to the principal balance. Daily compounding is most common for deposit accounts.. Valid values are `daily|monthly|quarterly|annually|continuous`',
    `created_by_user` STRING COMMENT 'The user ID or system identifier of the person or process that created this interest rate configuration record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this interest rate configuration record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'The date from which this interest rate configuration becomes active and begins accruing interest on applicable accounts.',
    `expiry_date` DATE COMMENT 'The date on which this interest rate configuration expires and is no longer applicable. Null indicates an open-ended rate configuration.',
    `ftp_rate` DECIMAL(18,2) COMMENT 'The internal Funds Transfer Pricing rate used to allocate funding costs or credits between business lines. Expressed as a decimal. Used for management accounting and profitability attribution.',
    `interest_payment_frequency` STRING COMMENT 'The frequency at which accrued interest is credited to the customers account or paid out. Most deposit accounts credit interest monthly.. Valid values are `monthly|quarterly|semi_annually|annually|at_maturity`',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether this is a promotional interest rate offered as part of a marketing campaign or customer acquisition strategy. True if promotional, False if standard rate.',
    `is_tax_advantaged` BOOLEAN COMMENT 'Indicates whether this rate applies to a tax-advantaged account type (e.g., IRA, HSA, 529 plan) where interest may be tax-deferred or tax-exempt. True if tax-advantaged, False otherwise.',
    `maximum_balance_cap` DECIMAL(18,2) COMMENT 'The maximum account balance on which interest is paid at this rate. Balances exceeding this cap may earn a different rate or no additional interest.',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'The minimum account balance required to earn the stated interest rate. Balances below this threshold may earn a lower rate or no interest.',
    `nim_contribution_bps` STRING COMMENT 'The estimated contribution of this rate configuration to the banks Net Interest Margin (NIM), expressed in basis points. Used for profitability analysis and ALCO reporting.',
    `product_code` STRING COMMENT 'The deposit product code (e.g., DDA, SAV, MMA, CD) to which this rate structure applies. Used for product-level rate configuration.. Valid values are `^[A-Z0-9]{3,12}$`',
    `promotional_expiry_date` DATE COMMENT 'The date on which the promotional rate expires and reverts to the standard rate. Only applicable when is_promotional is True.',
    `rate_approval_authority` STRING COMMENT 'The governance body or role that approved this interest rate configuration. ALCO (Asset-Liability Committee), TREASURY, PRODUCT_MANAGEMENT, BRANCH_MANAGER, or EXECUTIVE_COMMITTEE.. Valid values are `ALCO|TREASURY|PRODUCT_MANAGEMENT|BRANCH_MANAGER|EXECUTIVE_COMMITTEE`',
    `rate_approval_date` DATE COMMENT 'The date on which this interest rate configuration was formally approved by the designated approval authority.',
    `rate_ceiling` DECIMAL(18,2) COMMENT 'The maximum interest rate that can be applied regardless of benchmark index movements. Caps the banks interest expense exposure. Expressed as a decimal.',
    `rate_change_frequency` STRING COMMENT 'The frequency at which variable interest rates are reviewed and potentially adjusted based on benchmark index movements. Fixed rates use at_maturity or as_needed. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|at_maturity|as_needed — 7 candidates stripped; promote to reference product]',
    `rate_change_reason` STRING COMMENT 'Business justification or reason for this rate configuration or rate change. Examples: Benchmark index adjustment, Competitive positioning, Promotional campaign Q4 2024, ALCO directive.',
    `rate_floor` DECIMAL(18,2) COMMENT 'The minimum interest rate that can be applied regardless of benchmark index movements. Protects the bank from negative or excessively low rates. Expressed as a decimal.',
    `rate_status` STRING COMMENT 'The current lifecycle status of this interest rate configuration. Active (currently in effect), Pending (approved but not yet effective), Expired (past expiry date), Superseded (replaced by newer rate), or Suspended (temporarily inactive).. Valid values are `active|pending|expired|superseded|suspended`',
    `rate_type` STRING COMMENT 'Classification of the interest rate structure: fixed (constant rate), variable (indexed to benchmark), tiered (rate varies by balance threshold), or promotional (temporary marketing rate).. Valid values are `fixed|variable|tiered|promotional`',
    `regulatory_disclosure_text` STRING COMMENT 'The standardized disclosure text required by Regulation DD for customer communication regarding this interest rate, including APY calculation methodology and any conditions or limitations.',
    `relationship_bonus_bps` STRING COMMENT 'Additional basis points added to the base rate for customers meeting relationship pricing criteria. For example, 25 BPS = 0.25% rate bonus.',
    `relationship_pricing_eligible` BOOLEAN COMMENT 'Indicates whether this rate is eligible for relationship pricing adjustments based on the customers total Assets Under Management (AUM) or product holdings with the bank. True if eligible, False otherwise.',
    `source_system` STRING COMMENT 'The name of the operational system from which this interest rate configuration originated (e.g., Temenos T24, FIS Profile, Treasury Management System). Used for data lineage and reconciliation.',
    `spread_bps` STRING COMMENT 'The spread over the benchmark index expressed in basis points (BPS). One basis point equals 0.01%. For example, 50 BPS = 0.50%. Applied to variable rates only.',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'The percentage of interest income subject to tax withholding, expressed as a decimal (e.g., 0.2400 for 24%). Applicable for certain account types and jurisdictions.',
    `tier_apr` DECIMAL(18,2) COMMENT 'The Annual Percentage Rate for this balance tier, expressed as a decimal (e.g., 0.024693 for 2.4693% APR). APR is the simple interest rate before compounding effects.',
    `tier_apy` DECIMAL(18,2) COMMENT 'The Annual Percentage Yield for this balance tier, expressed as a decimal (e.g., 0.025000 for 2.5% APY). APY reflects the effect of compounding and is the rate disclosed to customers per Regulation DD.',
    `tier_maximum_balance` DECIMAL(18,2) COMMENT 'The maximum balance threshold for this rate tier. Balances above this amount move to the next tier. Null for the highest tier indicating no upper limit.',
    `tier_minimum_balance` DECIMAL(18,2) COMMENT 'The minimum balance threshold for this rate tier. Balances at or above this amount and below the tier maximum earn this tiers rate. Part of tiered rate structure.',
    `tier_sequence_number` STRING COMMENT 'The ordinal position of this rate tier within a tiered rate structure. Tier 1 is the lowest balance tier, incrementing for higher balance tiers. Null for non-tiered rates.',
    `updated_by_user` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this interest rate configuration record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this interest rate configuration record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_interest_rate PRIMARY KEY(`interest_rate_id`)
) COMMENT 'Effective interest rate configuration and complete tiered rate structure applied to deposit accounts and products. Captures base rate type (fixed, variable, tiered), benchmark index (SOFR, Fed Funds, Prime), spread over benchmark in BPS, effective date, expiry date, promotional rate flag, and promotional expiry date. Includes embedded tier-level detail: tier sequence number, minimum and maximum balance thresholds, annual percentage yield (APY), annual percentage rate (APR), and product applicability per tier. Tiered structures enable the bank to offer higher rates for larger balances on savings and money market accounts. Single source of truth for ALL rate configuration including tiered breakpoints — no separate rate tier reference table exists. Supports NIM reporting, ALCO rate sensitivity analysis, Reg DD APY disclosure requirements, and product pricing governance.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_product` (
    `account_product_id` BIGINT COMMENT 'Unique identifier for the account product. Primary key for the account product catalog.',
    `reporting_code_id` BIGINT COMMENT 'FFIEC Call Report schedule and line item code for regulatory reporting. Maps to specific lines in FFIEC 031/041 Consolidated Reports of Condition and Income.',
    `account_type_code` STRING COMMENT 'Granular account type classification code used for operational processing and system routing within the core banking platform.. Valid values are `^[A-Z0-9]{2,6}$`',
    `ach_transfer_allowed` BOOLEAN COMMENT 'Indicates whether ACH transfers (both incoming and outgoing) are permitted for accounts under this product. True = ACH allowed, False = ACH restricted.',
    `age_restriction_maximum` STRING COMMENT 'Maximum age limit for opening an account under this product (e.g., student accounts). Null if no maximum age restriction applies.',
    `age_restriction_minimum` STRING COMMENT 'Minimum age requirement for primary account holder to open an account under this product. Null if no age restriction applies.',
    `aml_risk_rating` STRING COMMENT 'Inherent AML risk rating assigned to this product category based on regulatory risk assessment and product characteristics.. Valid values are `low|medium|high`',
    `bic_code` STRING COMMENT 'Bank Identifier Code (also known as SWIFT code) associated with this product for international wire transfers and SWIFT messaging. Format: 8 or 11 alphanumeric characters.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `check_writing_allowed` BOOLEAN COMMENT 'Indicates whether check writing privileges are permitted for accounts under this product. True = checks allowed, False = no check writing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was first created in the system.',
    `crs_reportable` BOOLEAN COMMENT 'Indicates whether accounts under this product are subject to OECD Common Reporting Standard for automatic exchange of financial account information. True = CRS reportable, False = exempt.',
    `debit_card_eligible` BOOLEAN COMMENT 'Indicates whether accounts under this product are eligible for debit card issuance. True = debit card can be issued, False = not eligible.',
    `discontinuation_date` DATE COMMENT 'Date on which this product was discontinued and closed to new accounts. Null if product is still active or pending.',
    `effective_date` DATE COMMENT 'Date on which this product became or will become available for new account openings.',
    `eligible_customer_segments` STRING COMMENT 'Comma-separated list of customer segments eligible to open accounts under this product (e.g., retail, small_business, corporate, private_banking, student, senior). [ENUM-REF-CANDIDATE: retail|small_business|corporate|private_banking|institutional|government|non_profit|student|senior — promote to reference product]',
    `fatca_reportable` BOOLEAN COMMENT 'Indicates whether accounts under this product are subject to FATCA reporting requirements for US tax purposes. True = FATCA reportable, False = exempt.',
    `fdic_insurance_category` STRING COMMENT 'FDIC deposit insurance classification determining coverage limits and aggregation rules for deposit insurance calculations. [ENUM-REF-CANDIDATE: single|joint|retirement|trust|business|government|uninsured — 7 candidates stripped; promote to reference product]',
    `fee_schedule_reference` STRING COMMENT 'Reference code linking to the fee schedule document or system record that defines all fees applicable to this product (monthly maintenance, overdraft, transaction fees, etc.).. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `gl_mapping_code` STRING COMMENT 'General ledger account code to which balances and transactions for this product are posted in the financial accounting system.. Valid values are `^[0-9]{4,10}$`',
    `iban_assignment_required` BOOLEAN COMMENT 'Indicates whether accounts under this product must be assigned an IBAN for international payment processing. True = IBAN required, False = not required.',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether the account product accrues interest on deposited balances. True = interest-bearing, False = non-interest-bearing.',
    `interest_calculation_method` STRING COMMENT 'Method used to calculate interest accrual on account balances. Daily balance = interest on end-of-day balance, average daily balance = interest on average balance over period, minimum balance = interest on lowest balance in period, tiered = different rates for different balance tiers.. Valid values are `daily_balance|average_daily_balance|minimum_balance|tiered|not_applicable`',
    `interest_compounding_frequency` STRING COMMENT 'Frequency at which accrued interest is capitalized and added to the principal balance for subsequent interest calculations.. Valid values are `daily|monthly|quarterly|annually|maturity|not_applicable`',
    `interest_rate_schedule_reference` STRING COMMENT 'Reference code linking to the interest rate schedule that defines current and historical interest rates for this product, including tiered rate structures.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `kyc_tier_required` STRING COMMENT 'Level of KYC due diligence required to open an account under this product, aligned with AML and customer identification program requirements.. Valid values are `basic|standard|enhanced|simplified`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the account product. Active = available for new accounts, discontinued = no longer offered but existing accounts remain, grandfathered = closed to new customers but existing accounts retain terms, pending_approval = awaiting regulatory or internal approval, suspended = temporarily unavailable.. Valid values are `active|discontinued|grandfathered|pending_approval|suspended`',
    `maximum_balance_limit` DECIMAL(18,2) COMMENT 'Maximum balance allowed in accounts under this product, typically for regulatory or insurance reasons. Null if no maximum limit applies.',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'Minimum balance that must be maintained to avoid fees or account closure, in the banks functional currency. Null if no minimum balance requirement applies.',
    `minimum_opening_deposit` DECIMAL(18,2) COMMENT 'Minimum initial deposit amount required to open an account under this product, in the banks functional currency (typically USD).',
    `mobile_banking_enabled` BOOLEAN COMMENT 'Indicates whether accounts under this product have access to mobile banking applications. True = mobile banking available, False = not available.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was last modified.',
    `online_banking_enabled` BOOLEAN COMMENT 'Indicates whether accounts under this product have access to online banking services. True = online banking available, False = not available.',
    `overdraft_protection_available` BOOLEAN COMMENT 'Indicates whether overdraft protection services are available for accounts under this product. True = overdraft protection can be enabled, False = not available.',
    `product_category` STRING COMMENT 'High-level classification of the account product type. DDA = Demand Deposit Account (checking), savings = savings account, money_market = money market account, certificate_of_deposit = time deposit, custodial = custodial/trust account.. Valid values are `DDA|savings|money_market|certificate_of_deposit|custodial|other`',
    `product_code` STRING COMMENT 'Unique alphanumeric code identifying the account product in the core banking system. Used for product identification in Temenos T24 / FIS Profile.. Valid values are `^[A-Z0-9]{6,12}$`',
    `product_description` STRING COMMENT 'Detailed description of the account product features, benefits, and intended use case for internal reference and customer communication.',
    `product_name` STRING COMMENT 'Full business name of the account product as marketed to customers and displayed in customer-facing channels.',
    `regulatory_classification` STRING COMMENT 'Federal Reserve Regulation D classification determining reserve requirements and transaction limitations. Reg D savings accounts are subject to six-transaction monthly limits; transaction accounts include DDA and NOW accounts.. Valid values are `reg_d_savings|transaction_account|time_deposit|custodial|exempt`',
    `reserve_requirement_applicable` BOOLEAN COMMENT 'Indicates whether deposits in this product are subject to Federal Reserve reserve requirements under Regulation D. True = subject to reserve requirements, False = exempt.',
    `reserve_requirement_ratio` DECIMAL(18,2) COMMENT 'Percentage of deposits that must be held in reserve with the Federal Reserve, expressed as a decimal (e.g., 0.1000 = 10%). Null if reserve requirements do not apply.',
    `statement_frequency` STRING COMMENT 'Frequency at which account statements are generated and delivered to customers for accounts under this product.. Valid values are `monthly|quarterly|annually|on_demand|electronic_only`',
    `wire_transfer_allowed` BOOLEAN COMMENT 'Indicates whether domestic and international wire transfers are permitted for accounts under this product. True = wire transfers allowed, False = not permitted.',
    CONSTRAINT pk_account_product PRIMARY KEY(`account_product_id`)
) COMMENT 'Catalog of deposit account product types, classifications, and complete regulatory taxonomy offered by the bank. Defines the terms, features, eligibility criteria, and compliance attributes for each product variant. Captures product code, product name, product category (DDA, savings, MMA, CD, custodial), account type code and classification, regulatory classification (Reg D savings, transaction account, time deposit, custodial), FDIC insurance category, GL mapping code, interest-bearing flag, reserve requirement applicability, Call Report category (FFIEC 031/041), minimum opening deposit, minimum balance requirement, fee schedule reference, interest rate schedule reference, eligible customer segments, and product lifecycle status (active, discontinued, grandfathered). Single source of truth for both account type taxonomy and product template — no separate account type reference table exists. Individual account instances are created from this catalog. Supports product governance, regulatory reporting, and analytics platform classification.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order. Primary key for the standing order entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Standing order setup/modification requires maker-checker dual control per operational risk and fraud prevention frameworks (SOX control for payment instructions). Existing approved_by text field shoul',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Recurring payments to internal beneficiaries (customer-to-customer) require beneficiary validation, AML screening, and pre-population of beneficiary details from party master. Enables detection of pay',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for the transfer amount. Defines the currency in which the standing order is denominated.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account from which the standing order will debit funds. Links to the source account in the core banking system.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Standing orders require beneficiary sanctions screening at setup and ongoing monitoring per OFAC regulations. Links payment instruction to screening results for payment blocking, regulatory reporting,',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Standing order setup channel is tracked for fraud prevention, customer authentication verification, and service quality monitoring. Required for dispute resolution and regulatory compliance audits. Re',
    `aml_screening_status` STRING COMMENT 'Result of AML and sanctions screening for the standing order beneficiary and transaction pattern. Flagged or blocked orders require compliance review before execution.. Valid values are `cleared|pending|flagged|blocked`',
    `aml_screening_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent AML and sanctions screening for this standing order. Screening is typically performed at setup and periodically thereafter.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the standing order setup or modification required managerial or compliance approval due to amount thresholds, risk profile, or regulatory requirements. True if approval was required.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the standing order was approved by the designated authority. Null if no approval was required.',
    `beneficiary_account_number` STRING COMMENT 'Account number of the beneficiary receiving the funds. May be internal account number, IBAN, or domestic account format depending on payment channel.',
    `beneficiary_bank_code` STRING COMMENT 'Bank Identifier Code (BIC) or SWIFT code of the beneficiary financial institution. Required for international transfers and interbank payments.',
    `beneficiary_bank_name` STRING COMMENT 'Name of the financial institution where the beneficiary account is held. Used for payment routing and customer reference.',
    `branch_code` STRING COMMENT 'Code of the bank branch where the standing order was established or is administratively managed. Used for operational reporting and branch performance tracking.',
    `business_day_adjustment` STRING COMMENT 'Rule for adjusting execution date when scheduled date falls on a non-business day. Following moves to next business day; preceding moves to prior business day; modified following moves forward unless crossing month boundary.. Valid values are `following|preceding|modified_following|no_adjustment`',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for standing order cancellation. Used for operational reporting and customer service.. Valid values are `customer_request|account_closure|insufficient_funds|fraud_prevention|regulatory_hold|system_error`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the standing order was cancelled. Null for active or suspended orders.',
    `charge_bearer` STRING COMMENT 'Party responsible for payment of transaction charges and fees. Debtor bears all charges; creditor receives net amount; shared splits charges between parties.. Valid values are `debtor|creditor|shared`',
    `customer_notification_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted to receive notifications (email, SMS, push) before each standing order execution. True if notifications are enabled.',
    `end_date` DATE COMMENT 'Date on which the standing order expires and ceases execution. Nullable for open-ended standing orders with no predetermined termination.',
    `execution_count` STRING COMMENT 'Cumulative number of successful executions of the standing order since inception. Incremented after each successful payment.',
    `execution_day` STRING COMMENT 'Day of the period on which the standing order should execute. For monthly frequency, represents day of month (1-31); for weekly, day of week (1-7). Adjusted for non-business days per bank policy.',
    `failed_execution_count` STRING COMMENT 'Cumulative number of failed execution attempts due to insufficient funds, account restrictions, or system errors. Used for risk monitoring and customer notification.',
    `frequency_code` STRING COMMENT 'Recurrence pattern for the standing order execution. Defines how often the payment instruction is executed. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|semiannual|annual — 7 candidates stripped; promote to reference product]',
    `instruction_reference` STRING COMMENT 'Externally visible unique reference number assigned to the standing order instruction by the customer or bank. Used for customer inquiries and statement reconciliation.',
    `instruction_status` STRING COMMENT 'Current lifecycle status of the standing order instruction. Active orders execute on schedule; suspended orders are temporarily halted; cancelled orders are terminated; pending activation orders await start date; expired orders have passed their end date.. Valid values are `active|suspended|cancelled|pending_activation|expired`',
    `last_execution_date` DATE COMMENT 'Date of the most recent successful execution of the standing order. Null if the standing order has never executed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the standing order parameters. Updated whenever amount, frequency, beneficiary, or other instruction details change.',
    `next_execution_date` DATE COMMENT 'Next calendar date on which the standing order is scheduled to execute. Updated after each successful execution or when schedule is modified.',
    `notification_channel` STRING COMMENT 'Preferred communication channel for sending execution notifications to the customer. None if customer has disabled notifications.. Valid values are `email|sms|push_notification|none`',
    `payment_channel` STRING COMMENT 'Payment rail or clearing channel through which the standing order executes. Determines routing, settlement speed, and applicable fees.. Valid values are `ach|internal_transfer|swift|rtgs|sepa|faster_payments`',
    `payment_reference` STRING COMMENT 'Free-text reference or remittance information included with each payment execution. Appears on beneficiary statement for payment identification and reconciliation.',
    `priority_code` STRING COMMENT 'Execution priority level for the standing order. High and urgent priorities may incur premium fees but ensure faster processing.. Valid values are `normal|high|urgent`',
    `product_code` STRING COMMENT 'Bank product or service code associated with the standing order. Links to product catalog for fee schedules and service level agreements.',
    `setup_timestamp` TIMESTAMP COMMENT 'Date and time when the standing order instruction was originally created in the system. Immutable audit field.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record that originated this standing order record. Typically the core banking system (e.g., Temenos T24, FIS Profile) or payment hub.',
    `start_date` DATE COMMENT 'Date on which the standing order becomes active and eligible for first execution. Standing order will not execute before this date.',
    `transfer_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount to be transferred with each execution of the standing order. Amount remains constant unless modified by customer instruction.',
    `version_number` STRING COMMENT 'Version counter incremented with each modification to the standing order. Used for optimistic locking and audit trail reconstruction.',
    CONSTRAINT pk_standing_order PRIMARY KEY(`standing_order_id`)
) COMMENT 'Recurring payment instruction established by an account holder to make regular fixed-amount transfers from a deposit account. Captures beneficiary account details, transfer amount, currency, frequency (weekly, monthly, quarterly), start date, end date, next execution date, payment reference, execution channel (ACH, internal transfer, SWIFT), and status (active, suspended, cancelled). Distinct from one-time payment instructions — represents a persistent, repeating mandate.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`direct_debit_mandate` (
    `direct_debit_mandate_id` BIGINT COMMENT 'Unique identifier for the direct debit mandate authorization record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: NACHA and Reg E require tracking the channel through which direct debit mandates are authorized for dispute resolution and compliance audits. Essential for unauthorized debit claim investigations. Rem',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the authorized debit amount.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account from which debits are authorized to be drawn.',
    `case_id` BIGINT COMMENT 'Reference to the dispute case if the account holder has contested debits under this mandate.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Systematic Investment Plans (SIPs) use direct debit mandates to automate recurring fund subscriptions from deposit accounts. Links mandate to target investor account for automated subscription process',
    `party_id` BIGINT COMMENT 'The NACHA company identification number assigned to the third-party originator authorized to initiate debits.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Direct debit mandates require OFAC screening of originators/creditors at setup and periodic refresh per sanctions compliance requirements. Links mandate to screening results for blocking decisions, re',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Direct debit mandate authorization requires banker verification of customer identity and authorization per CIP/BSA requirements and fraud prevention. Real business process: mandate verification workfl',
    `aml_review_date` DATE COMMENT 'Date of the most recent AML review conducted for this mandate.',
    `aml_review_required_flag` BOOLEAN COMMENT 'Indicates whether this mandate requires AML review due to risk factors or transaction patterns.',
    `aml_risk_score` STRING COMMENT 'Numeric risk score assigned by AML screening systems for this mandate.',
    `authorization_date` DATE COMMENT 'Date on which the account holder authorized the direct debit mandate.',
    `authorization_method` STRING COMMENT 'Method by which the authorization was obtained from the account holder.. Valid values are `written|electronic|verbal|digital_signature`',
    `authorization_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the mandate authorization was captured in the system.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'Maximum amount authorized per debit transaction. Null for variable amount mandates.',
    `collection_count` STRING COMMENT 'Total number of debit collections executed under this mandate to date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was first created in the system.',
    `creditor_identifier` STRING COMMENT 'ISO 13616 compliant creditor identifier used in SEPA direct debit schemes to uniquely identify the creditor.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{3}[A-Z0-9]{1,28}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the account holder has filed a Regulation E dispute or unauthorized debit claim against this mandate.',
    `effective_date` DATE COMMENT 'Date from which the mandate becomes active and debits may be initiated.',
    `expiry_date` DATE COMMENT 'Date on which the mandate expires and no further debits are authorized. Null for open-ended mandates.',
    `first_collection_date` DATE COMMENT 'Date of the first debit collection under this mandate.',
    `frequency_code` STRING COMMENT 'Expected frequency at which debits will be initiated under this mandate. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annual|on_demand — 7 candidates stripped; promote to reference product]',
    `last_collection_date` DATE COMMENT 'Date of the most recent debit collection executed under this mandate.',
    `mandate_reference_number` STRING COMMENT 'Unique external reference number assigned to this mandate for identification in ACH and SEPA transactions.. Valid values are `^[A-Z0-9]{6,35}$`',
    `mandate_status` STRING COMMENT 'Current lifecycle status of the direct debit mandate.. Valid values are `active|suspended|revoked|expired|pending`',
    `mandate_type` STRING COMMENT 'Classification of the mandate indicating whether it authorizes recurring debits, a single one-off debit, or variable amount debits.. Valid values are `recurring|one_off|variable`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was last modified.',
    `notification_preference` STRING COMMENT 'Account holder preference for receiving notifications prior to debit execution.. Valid values are `email|sms|mail|none`',
    `originator_name` STRING COMMENT 'Legal name of the company or entity authorized to originate ACH debit entries against the account.',
    `pre_notification_days` STRING COMMENT 'Number of days advance notice required before each debit is executed.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this mandate requires inclusion in regulatory reporting submissions.',
    `return_count` STRING COMMENT 'Total number of ACH returns received for debits initiated under this mandate.',
    `revocation_channel` STRING COMMENT 'Channel through which the customer revoked the mandate.. Valid values are `branch|online_banking|mobile_app|phone|mail|in_person`',
    `revocation_date` DATE COMMENT 'Date on which the account holder revoked the direct debit authorization.',
    `revocation_reason_code` STRING COMMENT 'Coded reason for mandate revocation.. Valid values are `customer_request|account_closure|fraud_suspected|unauthorized|service_terminated|other`',
    `sec_code` STRING COMMENT 'NACHA Standard Entry Class code indicating the type of ACH transaction authorized (PPD=Prearranged Payment and Deposit, CCD=Corporate Credit or Debit, WEB=Internet-Initiated, TEL=Telephone-Initiated). [ENUM-REF-CANDIDATE: PPD|CCD|WEB|TEL|POP|ARC|BOC|RCK — 8 candidates stripped; promote to reference product]',
    `signature_document_reference` STRING COMMENT 'Reference identifier to the stored authorization document or signature image.',
    `signature_on_file_flag` BOOLEAN COMMENT 'Indicates whether a physical or digital signature authorizing the mandate is retained on file.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system of record for this mandate (e.g., T24, FIS Profile, Payment Hub).',
    CONSTRAINT pk_direct_debit_mandate PRIMARY KEY(`direct_debit_mandate_id`)
) COMMENT 'Authorization record permitting a third-party originator to initiate ACH debit entries against a deposit account. Captures mandate reference number, originator company ID, originator name, authorized debit amount (fixed or variable), authorization date, authorization channel, revocation date, and NACHA SEC code (PPD, CCD, WEB, TEL). Supports Reg E dispute resolution, ACH return processing, and unauthorized debit claim management.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`dormancy_review` (
    `dormancy_review_id` BIGINT COMMENT 'Unique identifier for the dormancy review record. Primary key for the dormancy review operational tracking entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Dormancy reviews are conducted within specific accounting periods for escheatment compliance, regulatory reporting timelines, and tracking dormancy progression through fiscal periods for state reporti',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Dormant accounts with suspicious reactivation patterns (large deposits, rapid withdrawals, geographic anomalies) escalate to AML investigations. Links dormancy review findings to resulting cases for s',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the account balance and escheatment amounts.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account undergoing dormancy review. Links to the deposit account master record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: State escheatment laws require documented outreach attempts through specific channels before remitting dormant account funds to state authorities. Required for compliance with unclaimed property regul',
    `employee_id` BIGINT COMMENT 'Employee identifier of the compliance officer assigned to manage this dormancy review case.',
    `account_balance_at_review` DECIMAL(18,2) COMMENT 'Current balance of the deposit account at the time the dormancy review was initiated. Used to determine materiality and escheatment amount.',
    `amount_escheated` DECIMAL(18,2) COMMENT 'Total amount remitted to the state unclaimed property office. Null if escheatment not completed.',
    `closure_reason_code` STRING COMMENT 'Code indicating the reason for closing the dormancy review case. Null if review still open.. Valid values are `reactivated|escheated|account_closed|customer_deceased|transferred`',
    `customer_response_channel` STRING COMMENT 'Channel through which the customer responded to dormancy notification. Null if no response received.. Valid values are `phone|email|branch|mail|online_banking|mobile_app`',
    `customer_response_date` DATE COMMENT 'Date when the customer responded to dormancy outreach. Null if no response received.',
    `customer_response_flag` BOOLEAN COMMENT 'Indicates whether the customer responded to any outreach attempt. True if customer responded, False if no response received.',
    `dormancy_classification_date` DATE COMMENT 'Date when the account was formally classified as dormant based on inactivity threshold criteria.',
    `dormancy_period_days` STRING COMMENT 'Number of days elapsed since last customer-initiated activity. Calculated as the difference between current date and last customer activity date.',
    `due_diligence_completion_date` DATE COMMENT 'Date when all required due diligence efforts to locate and contact the customer were completed prior to escheatment.',
    `escheatment_filing_date` DATE COMMENT 'Date when the unclaimed property report was filed with the state jurisdiction. Null if escheatment not yet filed.',
    `escheatment_reference_number` STRING COMMENT 'Reference number assigned by the state unclaimed property office for the escheatment filing. Null if not yet escheated.',
    `escheatment_required_flag` BOOLEAN COMMENT 'Indicates whether the account balance must be escheated to the state based on dormancy period exceeding state threshold and lack of customer response.',
    `first_outreach_date` DATE COMMENT 'Date of the first outreach attempt to notify the customer of dormancy status and request account reactivation.',
    `last_customer_activity_date` DATE COMMENT 'Date of the most recent customer-initiated transaction or contact on the account. Used to determine dormancy period calculation start date.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent outreach attempt to contact the customer regarding the dormant account.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this dormancy review record. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text field for compliance officers to document case-specific details, customer interactions, special circumstances, or resolution notes.',
    `outreach_attempt_count` STRING COMMENT 'Total number of outreach attempts made to contact the customer regarding the dormant account. Includes letters, emails, phone calls, and other communication methods.',
    `outreach_method_log` STRING COMMENT 'Comma-separated log of outreach methods used in chronological order. Examples: mail, email, phone, certified_mail, sms.',
    `reactivation_date` DATE COMMENT 'Date when the dormant account was reactivated to active status following customer engagement. Null if not reactivated.',
    `reactivation_flag` BOOLEAN COMMENT 'Indicates whether the account was successfully reactivated following customer response. True if reactivated, False otherwise.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this dormancy case requires inclusion in regulatory reports to OCC or state banking authorities.',
    `review_closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the dormancy review was closed, either due to account reactivation, escheatment completion, or other resolution. Null if review still open.',
    `review_initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the dormancy review record was created and the review workflow was initiated.',
    `review_priority_level` STRING COMMENT 'Priority classification for the dormancy review based on account balance, customer relationship value, and time to escheatment deadline.. Valid values are `low|medium|high|critical`',
    `review_reference_number` STRING COMMENT 'Externally visible unique reference number for the dormancy review case. Format: DR-XXXXXXXXXX.. Valid values are `^DR-[0-9]{10}$`',
    `review_status` STRING COMMENT 'Current status of the dormancy review workflow. Tracks progression from initiation through customer outreach to final disposition. [ENUM-REF-CANDIDATE: initiated|outreach_in_progress|customer_responded|no_response|escalated|escheated|closed — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this dormancy review record. Typically the core banking system or compliance management platform.',
    `state_escheatment_threshold_days` STRING COMMENT 'Number of days of inactivity required before escheatment is mandated under the applicable state jurisdiction. Varies by state, typically ranging from 3 to 5 years.',
    `state_jurisdiction_code` STRING COMMENT 'Two-letter US state code identifying the jurisdiction governing escheatment for this account. Determines applicable dormancy threshold and reporting requirements.. Valid values are `^[A-Z]{2}$`',
    CONSTRAINT pk_dormancy_review PRIMARY KEY(`dormancy_review_id`)
) COMMENT 'Operational record tracking the dormancy assessment and escheatment workflow for inactive deposit accounts. Captures last customer-initiated activity date, dormancy classification date, dormancy period in days, state escheatment threshold (varies by state), outreach attempt log, customer response flag, escheatment filing date, amount escheated, and state jurisdiction. Required for compliance with state unclaimed property laws and OCC dormancy guidelines.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`document` (
    `document_id` BIGINT COMMENT 'Unique identifier for the account document record. Primary key.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: AML investigations require access to account opening documents, KYC documentation, and transaction supporting documents as evidence. Links case files to evidentiary documents for investigator review, ',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account to which this document is associated. Links to the deposit_account product.',
    `employee_id` BIGINT COMMENT 'Identifier of the AML compliance officer who reviewed this document.',
    `document_employee_id` BIGINT COMMENT 'Identifier of the bank officer or employee who verified the document authenticity and completeness.',
    `document_verifying_officer_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: KYC/CDD document submission channel is tracked for regulatory compliance (CIP requirements), customer service quality monitoring, and fraud prevention. Required for BSA/AML examinations and customer a',
    `aml_review_date` DATE COMMENT 'Date when the Anti-Money Laundering (AML) review of this document was completed.',
    `aml_review_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document requires review by the Anti-Money Laundering (AML) compliance team.',
    `cdd_verification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document is part of the Customer Due Diligence (CDD) verification process.',
    `comments` STRING COMMENT 'Free-text comments or notes added by officers or system users regarding the document, its verification, or any special handling instructions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer was notified about the document upload, verification, or status change.',
    `destruction_authorized_by` STRING COMMENT 'Name or identifier of the officer who authorized the document destruction.',
    `destruction_date` DATE COMMENT 'Date when the document was destroyed or permanently deleted from the system after retention period expiry.',
    `document_description` STRING COMMENT 'Detailed description of the document content, purpose, or context for business users and auditors.',
    `document_name` STRING COMMENT 'Human-readable name or title of the document as provided during upload or generation.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document. Values include pending (awaiting review), verified (authenticity confirmed), approved (accepted for account purposes), rejected (not accepted), expired (validity period lapsed), and archived (retained for historical purposes).. Valid values are `pending|verified|approved|rejected|expired|archived`',
    `effective_date` DATE COMMENT 'Date from which the document becomes legally or operationally effective for the account.',
    `expiry_date` DATE COMMENT 'Date when the document validity expires and renewal or replacement is required. Nullable for documents without expiration.',
    `file_format` STRING COMMENT 'Format of the stored document file. Common formats include PDF, JPEG, PNG, TIFF, DOCX, and XML.. Valid values are `pdf|jpeg|png|tiff|docx|xml`',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes, used for storage management and validation purposes.',
    `hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the document content, used to ensure integrity and detect tampering.',
    `issuing_authority` STRING COMMENT 'Name of the external authority, government agency, or institution that issued the document (e.g., IRS for tax forms, court for court orders).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the document was issued.. Valid values are `^[A-Z]{3}$`',
    `kyc_verification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document is part of the Know Your Customer (KYC) verification process.',
    `notification_channel` STRING COMMENT 'Channel through which the customer was notified about the document. Values include email, SMS, postal mail, online portal, mobile app, and phone.. Valid values are `email|sms|mail|portal|mobile_app|phone`',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer notification was sent regarding this document.',
    `reference_number` STRING COMMENT 'Business-assigned unique reference number for the document, used for tracking and retrieval purposes.',
    `regulatory_mandate_code` STRING COMMENT 'Code identifying the specific regulatory requirement or mandate that necessitates this document (e.g., BSA, FATCA, CRS, KYC, CDD).',
    `rejection_reason_code` STRING COMMENT 'Code indicating the reason for document rejection if the document status is rejected.',
    `rejection_reason_description` STRING COMMENT 'Detailed description of the reason for document rejection, providing context for business users and customers.',
    `retention_expiry_date` DATE COMMENT 'Date when the document retention period expires and the document becomes eligible for destruction or archival.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory or internal policy requirements before eligible for destruction.',
    `source_system_code` STRING COMMENT 'Code identifying the source system or channel from which the document was received (e.g., core banking system, online portal, branch system, mobile app).',
    `storage_reference_uri` STRING COMMENT 'Uniform Resource Identifier (URI) or path reference to the physical or digital storage location of the document in the document management system or cloud storage.',
    `type_code` STRING COMMENT 'Classification code indicating the type of document. Examples include signature card, account agreement, beneficial ownership certification (FinCEN Form 314), W-9 tax form, W-8BEN tax form, power of attorney, court order, death certificate, Know Your Customer (KYC) document, Customer Due Diligence (CDD) document, identity verification, and address proof. [ENUM-REF-CANDIDATE: signature_card|account_agreement|beneficial_ownership_cert|w9_tax_form|w8ben_tax_form|power_of_attorney|court_order|death_certificate|kyc_document|cdd_document|identity_verification|address_proof — 12 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was last updated or modified in the system.',
    `upload_date` DATE COMMENT 'Date when the document was uploaded or received into the system.',
    `upload_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document was uploaded or received into the system, including time zone information.',
    `verification_date` DATE COMMENT 'Date when the document was verified for authenticity and completeness by an authorized officer.',
    `verification_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document verification was completed, including time zone information.',
    `version` STRING COMMENT 'Version identifier for the document, used to track revisions and updates over time.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Registry of documents associated with deposit account opening, maintenance, and closure. Captures document type (signature card, account agreement, beneficial ownership certification, W-9/W-8BEN tax form, power of attorney, court order, death certificate), document version, upload date, expiry date, document status (pending, verified, expired), storage reference URI, and verifying officer. Supports KYC/CDD documentation requirements and regulatory examination readiness.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`sweep` (
    `sweep_id` BIGINT COMMENT 'Unique identifier for the account sweep arrangement record. Primary key.',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Sweep arrangements move excess cash into collateralized investment vehicles (repos, money market funds backed by securities). Banks track which collateral assets back sweep investments for liquidity r',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this sweep arrangement.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account or investment vehicle to which funds are swept. The target account in the sweep arrangement. Nullable for external investment vehicles tracked separately.',
    `employee_id` BIGINT COMMENT 'Identifier of the bank officer who approved the sweep arrangement setup. Used for audit trail and authorization verification.',
    `fund_id` BIGINT COMMENT 'External reference identifier for the investment vehicle (e.g., fund CUSIP, brokerage account number). Nullable for internal sweeps.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Investment sweep arrangement setup channel is tracked for suitability review compliance, customer service attribution, and regulatory documentation. Required for SEC/FINRA examinations of investment p',
    `sweep_deposit_account_id` BIGINT COMMENT 'Reference to the deposit account from which funds are swept. The originating account in the sweep arrangement.',
    `aml_review_required_flag` BOOLEAN COMMENT 'Indicates whether sweep executions require AML transaction monitoring review due to customer risk rating or arrangement characteristics.',
    `aml_risk_rating` STRING COMMENT 'AML risk classification of the sweep arrangement based on customer profile, transaction patterns, and jurisdictional factors.. Valid values are `low|medium|high|prohibited`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether each sweep execution requires manual approval before processing. Used for high-value or sensitive arrangements.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the sweep arrangement was approved by authorized officer.',
    `arrangement_number` STRING COMMENT 'Business identifier for the sweep arrangement, used for customer communication and operational reference.',
    `auto_replenishment_enabled` BOOLEAN COMMENT 'Indicates whether automatic replenishment from destination to source is enabled when source account falls below target balance. Applicable for two-way sweep arrangements.',
    `branch_code` STRING COMMENT 'Code of the branch or business unit that originated the sweep arrangement. Used for operational accountability and performance tracking.',
    `business_day_convention` STRING COMMENT 'Rule for adjusting sweep execution dates that fall on non-business days. Following moves to next business day; preceding moves to prior business day; modified following moves forward unless it crosses month boundary.. Valid values are `following|preceding|modified_following|end_of_month`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sweep arrangement record was first created in the system.',
    `customer_notification_enabled` BOOLEAN COMMENT 'Indicates whether customer receives notifications for each sweep execution.',
    `direction` STRING COMMENT 'Directionality of the sweep arrangement. One-way sweeps only move funds from source to destination; two-way or bidirectional sweeps can return funds to source when destination balance exceeds thresholds.. Valid values are `one_way|two_way|bidirectional`',
    `effective_date` DATE COMMENT 'Date when the sweep arrangement becomes active and eligible for execution.',
    `frequency` STRING COMMENT 'Frequency at which the sweep arrangement is evaluated and executed. Daily sweeps occur once per business day; end-of-day sweeps execute after final posting; intraday sweeps may execute multiple times; on-demand sweeps are manually triggered.. Valid values are `daily|weekly|monthly|end_of_day|intraday|on_demand`',
    `ftp_rate_code` STRING COMMENT 'Reference to the FTP rate curve or code used for internal profitability allocation of swept funds. Used for management accounting and ALCO reporting.',
    `gl_account_code` STRING COMMENT 'General ledger account code for booking sweep-related fees or interest adjustments.',
    `holiday_calendar_code` STRING COMMENT 'Reference to the holiday calendar used to determine business days for sweep execution scheduling (e.g., US Federal Reserve, TARGET2, local jurisdiction).',
    `investment_vehicle_type` STRING COMMENT 'Type of external investment vehicle for investment sweep arrangements. None indicates internal account-to-account sweep.. Valid values are `money_market_fund|mutual_fund|brokerage_account|treasury_account|external_investment|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sweep arrangement record was last updated.',
    `last_sweep_amount` DECIMAL(18,2) COMMENT 'Amount transferred in the most recent sweep execution. Used for operational reporting and pattern analysis.',
    `last_sweep_execution_date` DATE COMMENT 'Date of the most recent successful sweep execution. Used for operational monitoring and next-execution scheduling.',
    `lifetime_sweep_count` STRING COMMENT 'Total number of sweep executions since arrangement inception. Used for usage analytics and fee calculation.',
    `lifetime_sweep_total_amount` DECIMAL(18,2) COMMENT 'Cumulative total amount swept since arrangement inception. Used for customer reporting and funds transfer pricing (FTP) analytics.',
    `line_of_business` STRING COMMENT 'Business unit or line of business responsible for the sweep arrangement. Used for management reporting and profitability analysis.. Valid values are `retail_banking|commercial_banking|corporate_treasury|wealth_management|private_banking`',
    `maximum_sweep_amount` DECIMAL(18,2) COMMENT 'Maximum amount that can be transferred in a single sweep execution. Used for risk management and liquidity control. Nullable for unlimited sweeps.',
    `minimum_sweep_amount` DECIMAL(18,2) COMMENT 'Minimum amount that must be transferred for a sweep to execute. Prevents small, uneconomical transfers.',
    `next_scheduled_sweep_date` DATE COMMENT 'Date when the next sweep execution is scheduled to occur, based on frequency and business calendar.',
    `notification_channel` STRING COMMENT 'Preferred channel for customer notifications about sweep executions.. Valid values are `email|sms|mobile_app|statement_only|none`',
    `priority_rank` STRING COMMENT 'Execution priority when multiple sweep arrangements exist on the same source account. Lower numbers execute first. Used for cash concentration hierarchies.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether sweep transactions must be included in regulatory reports such as liquidity coverage ratio (LCR) or net stable funding ratio (NSFR) calculations.',
    `replenishment_threshold_amount` DECIMAL(18,2) COMMENT 'Source account balance threshold below which auto-replenishment is triggered. Applicable when auto_replenishment_enabled is true.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system that originated this sweep arrangement record (e.g., Temenos T24, FIS Profile, treasury management system).',
    `sweep_status` STRING COMMENT 'Current operational status of the sweep arrangement. Active arrangements execute per schedule; suspended arrangements are temporarily halted; terminated arrangements are closed; pending activation awaits approval; under review indicates compliance or risk review in progress.. Valid values are `active|suspended|terminated|pending_activation|under_review`',
    `sweep_type` STRING COMMENT 'Classification of the sweep arrangement. Zero-balance sweep transfers all excess funds; target-balance sweep maintains a specified balance; threshold sweep triggers when balance exceeds a limit; investment sweep moves funds to money market or investment vehicle; hybrid combines multiple rules.. Valid values are `zero_balance|target_balance|threshold|investment_sweep|hybrid`',
    `target_balance_amount` DECIMAL(18,2) COMMENT 'Desired balance to maintain in the source account after sweep execution. Applicable for target-balance sweep types. Nullable for zero-balance sweeps.',
    `termination_date` DATE COMMENT 'Date when the sweep arrangement is terminated or expires. Nullable for open-ended arrangements.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Minimum balance threshold that triggers a sweep execution. When source account balance exceeds this amount, sweep is initiated. Nullable for zero-balance sweep types.',
    CONSTRAINT pk_sweep PRIMARY KEY(`sweep_id`)
) COMMENT 'Configuration and execution record for automated sweep arrangements between deposit accounts or to external investment vehicles. Captures sweep type (zero-balance sweep, target-balance sweep, investment sweep to money market fund), source account reference, destination account or investment vehicle reference, sweep threshold amount, target balance, sweep frequency (daily, weekly, end-of-day), last sweep date, last sweep amount, and sweep status (active, suspended, terminated). Used for corporate treasury cash concentration, retail excess balance optimization, and liquidity management. Supports daily cash management operations, ALCO liquidity reporting, and funds transfer pricing (FTP) analytics.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`beneficiary_designation` (
    `beneficiary_designation_id` BIGINT COMMENT 'Unique identifier for the beneficiary designation record. Primary key for the beneficiary designation entity.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Estate planning and beneficiary designation require proper KYC when beneficiary is an existing customer. Links to party master for identity verification, tax reporting (estate/inheritance), and remove',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Beneficiary allocations may specify currency for international estates and cross-border wealth transfer. Supports multi-currency trust administration and estate settlement. New attribute needed as no ',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account on which this beneficiary designation is established. Links to the deposit account that will transfer proceeds to the beneficiary upon account holder death.',
    `employee_id` BIGINT COMMENT 'User identifier of the bank employee or system user who created this beneficiary designation record. Required for audit trail and accountability.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of account proceeds allocated to this beneficiary upon account holder death. Must sum to 100.00 across all active beneficiaries on the same account. Expressed as a decimal value between 0.00 and 100.00.',
    `aml_screening_date` DATE COMMENT 'Date on which the beneficiary was screened against AML sanctions lists. Required for regulatory compliance and audit trail.',
    `aml_screening_status` STRING COMMENT 'Result of AML sanctions screening for the beneficiary against OFAC and other watchlists. Cleared status is required before distribution can occur.. Valid values are `cleared|flagged|pending|not_screened`',
    `beneficiary_address_line1` STRING COMMENT 'Primary street address line for the beneficiary. Required for mailing distribution checks and legal notices upon account holder death.',
    `beneficiary_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Optional field for additional address detail.',
    `beneficiary_city` STRING COMMENT 'City or municipality of the beneficiary address. Required for legal notices and distribution processing.',
    `beneficiary_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the beneficiary address. Determines cross-border reporting requirements and distribution processing rules.. Valid values are `^[A-Z]{3}$`',
    `beneficiary_date_of_birth` DATE COMMENT 'Date of birth of the beneficiary if the beneficiary is an individual. Used for identity verification and to determine if special handling is required for minor beneficiaries.',
    `beneficiary_email_address` STRING COMMENT 'Email address for the beneficiary. Used for electronic communication regarding designation status and distribution processing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `beneficiary_phone_number` STRING COMMENT 'Primary contact phone number for the beneficiary. Used to notify beneficiary of account holder death and coordinate distribution.',
    `beneficiary_postal_code` STRING COMMENT 'Postal or ZIP code of the beneficiary address. Required for mailing and address validation.',
    `beneficiary_priority` STRING COMMENT 'Priority tier of the beneficiary designation. Primary beneficiaries receive proceeds first; contingent beneficiaries receive proceeds only if all primary beneficiaries predecease the account holder.. Valid values are `primary|contingent|tertiary`',
    `beneficiary_state_province` STRING COMMENT 'State, province, or region of the beneficiary address. Determines applicable state probate law and escheatment jurisdiction.',
    `beneficiary_type` STRING COMMENT 'Classification of the beneficiary entity type. Determines legal treatment, documentation requirements, and distribution rules under state law and FDIC insurance regulations.. Valid values are `individual|trust|estate|charity|organization|minor`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this beneficiary designation record was first created in the core banking system. Required for audit trail and regulatory compliance.',
    `designation_date` DATE COMMENT 'Date on which the beneficiary designation became legally effective. Establishes the temporal priority of competing designations and determines which designation controls in case of dispute.',
    `designation_number` STRING COMMENT 'Externally-known unique business identifier for this beneficiary designation. Used for customer communication and legal documentation reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `designation_status` STRING COMMENT 'Current lifecycle status of the beneficiary designation. Active designations are legally binding; revoked or superseded designations have no legal effect.. Valid values are `active|revoked|superseded|pending|expired`',
    `fdic_insurance_category` STRING COMMENT 'FDIC insurance ownership category applicable to this beneficiary designation. Determines insurance coverage limits and aggregation rules. Common categories include revocable trust accounts and payable-on-death accounts.',
    `kyc_verification_date` DATE COMMENT 'Date on which the beneficiary identity was successfully verified. Required for audit trail and regulatory compliance.',
    `kyc_verification_status` STRING COMMENT 'Status of identity verification for the beneficiary under KYC and AML regulations. Verified status is required before distribution can occur.. Valid values are `verified|pending|failed|not_required`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this beneficiary designation record was last modified. Tracks the most recent change for audit and compliance purposes.',
    `minor_custodian_name` STRING COMMENT 'Full legal name of the custodian designated to manage proceeds on behalf of a minor beneficiary under the Uniform Transfers to Minors Act (UTMA). Required when beneficiary is under age of majority.',
    `notarization_date` DATE COMMENT 'Date on which the beneficiary designation form was notarized. Required when notarization_required_flag is true.',
    `notarization_required_flag` BOOLEAN COMMENT 'Indicates whether state law or bank policy requires notarization of the beneficiary designation form. Varies by jurisdiction and account type.',
    `per_stirpes_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary designation includes per stirpes distribution. If true and the beneficiary predeceases the account holder, the beneficiarys share passes to their descendants rather than to other named beneficiaries.',
    `relationship_to_account_holder` STRING COMMENT 'Nature of the personal or business relationship between the beneficiary and the account holder. Used for compliance review and fraud detection. [ENUM-REF-CANDIDATE: spouse|child|parent|sibling|other_relative|friend|business_partner|unrelated — 8 candidates stripped; promote to reference product]',
    `revocation_date` DATE COMMENT 'Date on which the beneficiary designation was revoked by the account holder. Nullable for active designations. Once revoked, the designation has no legal effect.',
    `revocation_reason` STRING COMMENT 'Free-text explanation for why the beneficiary designation was revoked. Common reasons include divorce, death of beneficiary, change in estate planning strategy, or account holder request.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this beneficiary designation record. Common values include T24 for Temenos core banking, FIS_PROFILE for FIS systems, MANUAL for branch-entered designations, and ONLINE_BANKING for customer self-service.. Valid values are `T24|FIS_PROFILE|MANUAL|ONLINE_BANKING`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to the signed beneficiary designation form, trust instrument, or other legal documentation supporting this designation. Required for audit and legal compliance.',
    `trust_date` DATE COMMENT 'Date on which the trust was legally established. Used to verify trust validity and identify the correct trust instrument when multiple trusts exist with similar names.',
    `trust_name` STRING COMMENT 'Full legal name of the trust if the beneficiary type is trust. Must match the trust instrument exactly for legal distribution.',
    `trustee_name` STRING COMMENT 'Full legal name of the trustee authorized to receive and manage proceeds on behalf of the trust. Required for trust beneficiary designations.',
    `witness_count` STRING COMMENT 'Number of witnesses who signed the beneficiary designation form. Some jurisdictions require one or more witnesses for legal validity.',
    CONSTRAINT pk_beneficiary_designation PRIMARY KEY(`beneficiary_designation_id`)
) COMMENT 'Record of payable-on-death (POD) and transfer-on-death (TOD) beneficiary designations on deposit accounts. Captures beneficiary name, relationship to account holder, beneficiary type (individual, trust, estate, charity), allocation percentage, designation date, revocation date, and supporting documentation reference. Legally distinct from account holder associations — beneficiaries have no access rights during the account holders lifetime but receive proceeds upon death, governed by state law and FDIC insurance rules.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`rate_tier` (
    `rate_tier_id` BIGINT COMMENT 'Unique identifier for the rate tier record. Primary key.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the balance thresholds and rate calculations (e.g., USD, EUR, GBP).',
    `annual_percentage_rate` DECIMAL(18,2) COMMENT 'The nominal annual interest rate for this tier, expressed as a decimal (e.g., 0.02500 for 2.5%). Used for interest accrual calculations.',
    `annual_percentage_yield` DECIMAL(18,2) COMMENT 'The effective annual rate of return taking into account compounding, expressed as a decimal (e.g., 0.02531 for 2.531% APY). Required for Regulation DD disclosure.',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee that approved this rate tier (e.g., Asset-Liability Committee, Chief Financial Officer, Treasury Department).',
    `approval_date` DATE COMMENT 'Date on which this rate tier was formally approved by the designated authority. Format: yyyy-MM-dd.',
    `compounding_frequency` STRING COMMENT 'Frequency at which interest is compounded for APY calculation: daily, monthly, quarterly, annually, or continuous compounding.. Valid values are `daily|monthly|quarterly|annually|continuous`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate tier record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_segment` STRING COMMENT 'Target customer segment for which this rate tier is available. Enables segment-specific pricing strategies (e.g., preferential rates for private banking clients or employees). [ENUM-REF-CANDIDATE: retail|private_banking|business|institutional|employee|student|senior — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this rate tier becomes active and applicable to qualifying accounts. Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'Date on which this rate tier ceases to be active. NULL indicates the tier is currently active with no planned expiration. Format: yyyy-MM-dd.',
    `fdic_insurance_applicable_flag` BOOLEAN COMMENT 'Indicates whether deposits in accounts using this rate tier are eligible for FDIC insurance coverage (True for most deposit products, False for certain investment or sweep accounts).',
    `ftp_rate` DECIMAL(18,2) COMMENT 'Internal transfer pricing rate assigned to deposits in this tier for profitability allocation and performance measurement. Represents the cost or benefit of funds to the business unit.',
    `geographic_restriction` STRING COMMENT 'Geographic limitation for rate tier availability, specified as comma-separated list of state/province codes or country codes. NULL indicates no geographic restriction.',
    `interest_calculation_method` STRING COMMENT 'Method used to calculate interest for this tier: daily balance (interest on end-of-day balance), average daily balance (interest on average balance over period), minimum balance (interest on lowest balance in period), or collected balance (interest on available funds only).. Valid values are `daily_balance|average_daily_balance|minimum_balance|collected_balance`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this rate tier record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate tier record was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maximum_balance_threshold` DECIMAL(18,2) COMMENT 'The maximum account balance for which this tiers interest rate applies. Inclusive upper bound of the tier range. NULL indicates no upper limit for the highest tier.',
    `minimum_balance_threshold` DECIMAL(18,2) COMMENT 'The minimum account balance required to qualify for this tiers interest rate. Inclusive lower bound of the tier range.',
    `minimum_opening_deposit` DECIMAL(18,2) COMMENT 'Minimum initial deposit required to open an account eligible for this rate tier. May differ from the ongoing minimum balance threshold.',
    `nim_impact_basis_points` STRING COMMENT 'Estimated impact of this rate tier on the banks Net Interest Margin, expressed in basis points. Used for profitability analysis and Asset-Liability Management (ALM). Negative values indicate margin compression.',
    `product_code` STRING COMMENT 'Code identifying the deposit product to which this rate tier applies (e.g., savings account, money market account, certificate of deposit). Links to the banks product catalog.. Valid values are `^[A-Z0-9]{3,10}$`',
    `product_name` STRING COMMENT 'Human-readable name of the deposit product associated with this rate tier.',
    `promotional_description` STRING COMMENT 'Marketing description of the promotional rate offer, including any special terms or conditions. NULL for non-promotional tiers.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this rate tier is part of a promotional offering (True) or standard product pricing (False). Promotional rates typically have limited duration.',
    `rate_change_frequency` STRING COMMENT 'Indicates how often the rate for this tier may change: fixed (rate guaranteed for term), variable with daily/monthly/quarterly review, or index-linked (tied to external benchmark such as SOFR or Fed Funds rate).. Valid values are `fixed|variable_daily|variable_monthly|variable_quarterly|index_linked`',
    `rate_index_code` STRING COMMENT 'Code identifying the external rate index to which this tier is linked (e.g., SOFR, EFFR, LIBOR). NULL for fixed or non-indexed rates.',
    `rate_margin_basis_points` STRING COMMENT 'Margin in basis points added to or subtracted from the rate index to determine the tiers APR. One basis point equals 0.01%. NULL for non-indexed rates.',
    `rate_tier_status` STRING COMMENT 'Current lifecycle status of the rate tier: active (currently in use), inactive (temporarily disabled), pending (scheduled for future activation), expired (past expiry date), or superseded (replaced by newer tier structure).. Valid values are `active|inactive|pending|expired|superseded`',
    `regulatory_disclosure_text` STRING COMMENT 'Standardized disclosure language required by Regulation DD for Truth in Savings compliance. Includes APY, minimum balance requirements, and any limitations or fees that may reduce earnings.',
    `relationship_criteria_description` STRING COMMENT 'Detailed description of the relationship requirements needed to qualify for this rate tier (e.g., maintain $25,000 combined balance across all accounts, or set up recurring direct deposit of $1,000+). NULL if relationship_pricing_flag is False.',
    `relationship_pricing_flag` BOOLEAN COMMENT 'Indicates whether this rate tier requires the customer to maintain additional qualifying relationships with the bank (True), such as direct deposit, minimum combined balances, or linked loan products. False for standalone pricing.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this rate tier data originated (e.g., T24, FIS_PROFILE, RATE_MGMT_SYS).',
    `tier_sequence_number` STRING COMMENT 'Sequential ordering of the tier within the rate structure. Lower numbers represent lower balance tiers. Used to determine tier precedence when calculating interest.',
    `version_number` STRING COMMENT 'Version number of this rate tier record, incremented with each modification. Supports change tracking and audit trail requirements.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this rate tier record.',
    CONSTRAINT pk_rate_tier PRIMARY KEY(`rate_tier_id`)
) COMMENT 'Reference table defining the tiered interest rate structure for deposit products. Captures tier sequence number, minimum balance threshold, maximum balance threshold, annual percentage yield (APY), annual percentage rate (APR), effective date, expiry date, product applicability, and regulatory APY disclosure format per Reg DD. Enables the bank to offer higher rates for larger balances on savings and money market accounts. Shared across multiple account products.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`type` (
    `type_id` BIGINT COMMENT 'Unique identifier for the account type. Primary key for the account type reference table.',
    `reporting_code_id` BIGINT COMMENT 'Specific line item reference within the Call Report schedule where balances for this account type are aggregated and reported (e.g., Schedule RC-E, Line 1 for noninterest-bearing deposits).',
    `account_type_code` STRING COMMENT 'Short alphanumeric code representing the account type (e.g., DDA, SAV, MMA, CD, CUST). Used as a business key across core banking systems and regulatory reporting platforms.. Valid values are `^[A-Z0-9]{2,10}$`',
    `account_type_description` STRING COMMENT 'Detailed business description of the account type, including its purpose, features, and typical use cases. Provides context for product management, compliance, and customer service teams.',
    `account_type_name` STRING COMMENT 'Full descriptive name of the account type (e.g., Demand Deposit Account, Savings Account, Money Market Account, Certificate of Deposit, Custodial Account). Human-readable label used in customer-facing applications and internal reporting.',
    `ach_transfer_allowed_flag` BOOLEAN COMMENT 'Indicates whether ACH debits and credits are permitted for this account type. Determines eligibility for direct deposit, bill payment, and electronic funds transfer services.',
    `aml_risk_rating` STRING COMMENT 'Inherent money laundering and terrorist financing risk level associated with this account type. Determines transaction monitoring thresholds, enhanced due diligence requirements, and Suspicious Activity Report (SAR) filing protocols.. Valid values are `low|medium|high|prohibited`',
    `atm_access_flag` BOOLEAN COMMENT 'Indicates whether accounts of this type support ATM withdrawals and balance inquiries. Affects card issuance and channel access controls.',
    `call_report_schedule` STRING COMMENT 'FFIEC Call Report schedule code (e.g., RC-E for deposit liabilities) where this account type must be reported. Ensures accurate quarterly regulatory filings to the Federal Reserve, FDIC, and OCC.. Valid values are `^RC-[A-Z]{1,3}$`',
    `check_writing_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers can write checks against this account type. Determines check order eligibility and payment processing rules.',
    `cip_exemption_flag` BOOLEAN COMMENT 'Indicates whether this account type qualifies for an exemption from standard Customer Identification Program requirements under USA PATRIOT Act Section 326. Typically false for most retail and commercial accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account type record was first created in the system. Audit trail for data lineage and compliance.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether this account type is subject to OECD Common Reporting Standard automatic exchange of financial account information. Applies to accounts held by tax residents of participating jurisdictions.',
    `customer_segment` STRING COMMENT 'Target customer segment for this account type. Supports marketing strategy, pricing decisions, and customer relationship management (CRM) analytics.. Valid values are `consumer|small_business|middle_market|corporate|institutional|government`',
    `debit_card_eligible_flag` BOOLEAN COMMENT 'Indicates whether a debit card can be issued and linked to this account type. Determines card product offerings and payment channel availability.',
    `discontinuation_date` DATE COMMENT 'Date on which this account type was discontinued and closed to new business. Null for active account types. Used in product sunset analysis and legacy system migration planning.',
    `effective_date` DATE COMMENT 'Date on which this account type became available for new account openings. Supports product launch tracking and historical analysis.',
    `escheatment_period_years` STRING COMMENT 'Number of years of account dormancy after which funds must be escheated (transferred) to the state unclaimed property authority. Varies by state jurisdiction and account type.',
    `fatca_reportable_flag` BOOLEAN COMMENT 'Indicates whether this account type is subject to FATCA reporting requirements for U.S. persons holding foreign financial accounts or foreign entities with U.S. ownership. Affects IRS Form 8938 and FBAR filing obligations.',
    `fdic_insurance_category` STRING COMMENT 'FDIC insurance ownership category that determines coverage limits and aggregation rules. Critical for deposit insurance calculations and customer disclosures. [ENUM-REF-CANDIDATE: single_account|joint_account|revocable_trust|irrevocable_trust|employee_benefit_plan|corporation_partnership|government_account|uninsured — 8 candidates stripped; promote to reference product]',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether deposits in this account type are eligible for FDIC insurance coverage. True for most deposit accounts; false for non-deposit products or uninsured investment accounts.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which balances and transactions for this account type are posted. Links deposit operations to financial accounting and enables balance sheet reporting.. Valid values are `^[0-9]{4,10}$`',
    `gl_liability_category` STRING COMMENT 'Balance sheet liability classification for this account type. Used in financial statement preparation, liquidity reporting, and Asset-Liability Management (ALM) analysis.. Valid values are `demand_deposits|savings_deposits|time_deposits|brokered_deposits|other_liabilities`',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether this account type accrues interest on deposited balances. True for savings, money market, and time deposit accounts; false for non-interest-bearing checking accounts.',
    `kyc_verification_required_flag` BOOLEAN COMMENT 'Indicates whether enhanced Know Your Customer due diligence is required at account opening for this account type. Affects onboarding workflows and compliance checks.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this account type record. Supports change tracking and audit requirements.',
    `liquidity_coverage_ratio_category` STRING COMMENT 'Basel III Liquidity Coverage Ratio classification that determines the assumed outflow rate for this account type during a 30-day stress scenario. Critical for liquidity risk management and regulatory compliance.. Valid values are `stable_retail|less_stable_retail|operational|non_operational|other`',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'Minimum balance that must be maintained to avoid monthly service fees or account closure. Used in fee assessment logic and customer notifications.',
    `minimum_opening_balance` DECIMAL(18,2) COMMENT 'Minimum initial deposit required to open an account of this type. Enforced during account origination and disclosed in product terms and conditions.',
    `monthly_service_fee` DECIMAL(18,2) COMMENT 'Standard monthly maintenance fee charged for this account type if balance or activity requirements are not met. Subject to fee waiver rules and regulatory disclosure requirements.',
    `nsfr_category` STRING COMMENT 'Basel III Net Stable Funding Ratio classification that determines the required stable funding factor for this account type. Used in long-term liquidity planning and regulatory capital calculations.. Valid values are `stable_funding|less_stable_funding|other_liabilities`',
    `online_banking_enabled_flag` BOOLEAN COMMENT 'Indicates whether this account type is accessible through online banking and mobile banking channels. Affects digital channel entitlements and customer self-service capabilities.',
    `overdraft_allowed_flag` BOOLEAN COMMENT 'Indicates whether overdraft protection or overdraft privilege is available for this account type. Determines eligibility for overdraft facilities and fee structures.',
    `product_line` STRING COMMENT 'Business line or division that offers this account type. Enables product profitability analysis, customer segmentation, and line-of-business reporting.. Valid values are `retail_banking|commercial_banking|private_banking|wealth_management|institutional`',
    `regulatory_classification` STRING COMMENT 'Regulatory category of the account type as defined by Federal Reserve Regulation D and FDIC guidelines. Determines reserve requirements, transaction limits, and reporting obligations.. Valid values are `transaction_account|savings_account|time_deposit|custodial_account|other`',
    `reserve_requirement_applicable_flag` BOOLEAN COMMENT 'Indicates whether this account type is subject to Federal Reserve reserve requirements under Regulation D. Affects bank liquidity management and Asset-Liability Committee (ALCO) calculations.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this account type definition originated (e.g., T24, FIS_PROFILE, INTERNAL_PRODUCT_CATALOG). Enables data lineage tracking and reconciliation across platforms.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `statement_frequency` STRING COMMENT 'Standard frequency at which account statements are generated and delivered for this account type. Affects statement generation batch jobs and customer communication schedules.. Valid values are `monthly|quarterly|annual|on_demand`',
    `tax_reporting_form` STRING COMMENT 'IRS form code used for tax reporting of interest income or other taxable events for this account type (e.g., 1099-INT for interest income, 1099-MISC for other income). Drives year-end tax document generation.',
    `transaction_limit_applicable_flag` BOOLEAN COMMENT 'Indicates whether this account type is subject to monthly transaction limits under Regulation D (historically 6 withdrawals/transfers per statement cycle for savings accounts). Determines system controls and customer notifications.',
    `type_status` STRING COMMENT 'Current lifecycle status of this account type in the product catalog. Active types are available for new account openings; deprecated types are closed to new business but support existing accounts.. Valid values are `active|inactive|deprecated|pending_approval`',
    `wire_transfer_allowed_flag` BOOLEAN COMMENT 'Indicates whether domestic and international wire transfers can be initiated from this account type. Affects payment hub routing and Anti-Money Laundering (AML) screening requirements.',
    CONSTRAINT pk_type PRIMARY KEY(`type_id`)
) COMMENT 'Reference classification of deposit account types recognized by the bank and regulatory bodies. Captures account type code, account type name, regulatory classification (Reg D savings, transaction account, time deposit, custodial), FDIC insurance category, GL mapping code, interest-bearing flag, reserve requirement applicability, and reporting category for Call Report (FFIEC 031/041). Provides standardized taxonomy used across T24, regulatory reporting, and analytics platforms.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_position` (
    `account_position_id` BIGINT COMMENT 'Primary key for account_position',
    `custodial_account_id` BIGINT COMMENT 'Foreign key linking to the custodial account that holds this position',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument held in this position',
    `tax_lot_id` BIGINT COMMENT 'Identifier for the specific tax lot within the position. Multiple lots may exist for the same account-instrument combination with different acquisition dates and cost bases.',
    `trade_position_id` BIGINT COMMENT 'Unique identifier for this custodial account position. Primary key.',
    `acquisition_date` DATE COMMENT 'Date when this position or tax lot was acquired by the custodial account. Used for holding period calculations and tax reporting.',
    `cost_basis` DECIMAL(18,2) COMMENT 'Total cost basis of the position in the accounts base currency. Used for gain/loss calculations and tax reporting (Form 1099-B).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this position record was created.',
    `income_earned_ytd` DECIMAL(18,2) COMMENT 'Total income (dividends, interest, distributions) earned from this position in the current calendar year. Used for tax reporting (Form 1099-DIV, 1099-INT).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this position record was last modified.',
    `last_valuation_date` DATE COMMENT 'Date when this position was last marked-to-market and valued. Typically aligns with the accounts last valuation date but may differ for illiquid securities.',
    `market_value` DECIMAL(18,2) COMMENT 'Current market value of the position calculated as quantity multiplied by current market price. Updated with each valuation cycle.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active positions are held and valued. Closed positions have zero quantity. Pending settlement positions await trade settlement. Restricted or pledged positions have encumbrances.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares of the instrument held in this position. Supports fractional shares for certain asset types.',
    `restriction_code` STRING COMMENT 'Code indicating any investment restrictions applicable to this specific position based on the governing instrument or fiduciary guidelines. May restrict sale, pledge, or transfer.',
    `tax_lot_method` STRING COMMENT 'Method used to determine which tax lots are relieved when shares are sold. FIFO (First In First Out), LIFO (Last In First Out), Specific Identification, Average Cost, or HIFO (Highest In First Out).',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Unrealized gain or loss on the position calculated as market value minus cost basis. Used for performance reporting and fiduciary compliance.',
    CONSTRAINT pk_account_position PRIMARY KEY(`account_position_id`)
) COMMENT 'This association product represents the holding relationship between a custodial account and a financial instrument. It captures the position-level details required for fiduciary reporting, tax compliance (1099-B), performance measurement, and corporate action entitlements. Each record links one custodial account to one instrument with attributes that exist only in the context of this holding relationship, including quantity held, cost basis, acquisition details, and tax lot information.. Existence Justification: Custodial accounts hold portfolios consisting of multiple financial instruments simultaneously, and each instrument is held across many different custodial accounts. Banks actively manage these positions as operational business entities, tracking quantity, cost basis, acquisition dates, tax lots, and unrealized gains for each account-instrument combination. Position data is essential for fiduciary reporting, tax compliance (1099-B), performance measurement, and corporate action processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_collateral_pledge` (
    `account_collateral_pledge_id` BIGINT COMMENT 'Primary key for account_collateral_pledge',
    `asset_collateral_asset_id` BIGINT COMMENT 'Foreign key linking to the collateral asset that is pledged to secure the deposit account or related obligation',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key to the collateral asset pledged in this arrangement',
    `collateral_pledge_id` BIGINT COMMENT 'Unique system identifier for this specific pledge arrangement. Primary key.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to the deposit account that is secured by or associated with the pledged collateral asset',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'Ratio of collateral value to the secured obligation amount for this pledge. Monitored for covenant compliance and margin call triggers. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this pledge record was created',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the collateral asset market value for this specific pledge arrangement. May differ from the asset-level haircut based on pledge-specific terms. Identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this pledge record was last modified',
    `lien_priority` STRING COMMENT 'Priority ranking of this specific pledge relative to other liens on the same collateral asset (first, second, third, subordinate, pari passu). Identified in detection phase relationship data.',
    `pledge_agreement_reference` STRING COMMENT 'Reference to the legal agreement or document governing this pledge arrangement',
    `pledge_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the collateral value pledged in this specific arrangement. Identified in detection phase relationship data.',
    `pledge_date` DATE COMMENT 'Date on which the collateral asset was pledged to secure the deposit account or related obligation. Identified in detection phase relationship data.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of this pledge arrangement (active, released, substituted, defaulted, under_review)',
    `release_date` DATE COMMENT 'Date on which the collateral asset was released from this pledge arrangement. Null for active pledges. Identified in detection phase relationship data.',
    CONSTRAINT pk_account_collateral_pledge PRIMARY KEY(`account_collateral_pledge_id`)
) COMMENT 'This association product represents the pledge or lien relationship between a deposit account and a collateral asset. It captures the specific terms under which a collateral asset secures a deposit account or related credit obligation. Each record links one deposit account to one collateral asset with pledge-specific attributes including pledge amount, lien priority, haircut percentage, coverage ratio, and lifecycle dates that exist only in the context of this specific pledge arrangement.. Existence Justification: In banking operations, a single deposit account can be pledged as collateral for multiple credit facilities or obligations (e.g., a large CD securing both a mortgage and a business line of credit), and a single collateral asset can secure multiple deposit accounts or related obligations across different customers or product lines. Banks actively manage pledge arrangements as operational business entities, tracking pledge-specific data including pledge amount, lien priority, haircut percentage, coverage ratio, and lifecycle dates for each distinct pledge relationship.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_portfolio_holding` (
    `account_portfolio_holding_id` BIGINT COMMENT 'Primary key for account_portfolio_holding',
    `certificate_of_deposit_id` BIGINT COMMENT 'Foreign key linking to the certificate of deposit held in this portfolio position',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio that holds this CD position',
    `wealth_portfolio_holding_id` BIGINT COMMENT 'Unique system identifier for this portfolio holding record. Primary key.',
    `tax_lot_id` BIGINT COMMENT 'Unique identifier for the tax lot associated with this holding, used for tax-efficient portfolio management, capital gains tracking, and tax loss harvesting strategies. Links to tax lot accounting system.',
    `acquisition_date` DATE COMMENT 'Date when this CD was acquired and added to the portfolio, which may differ from the CD issue_date if purchased in secondary market or transferred from another portfolio.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total portfolio AUM represented by this CD holding, used for asset allocation monitoring and rebalancing decisions. Expressed as decimal (e.g., 0.0350 for 3.50%).',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original acquisition cost of this CD position in the portfolio base currency, used for performance calculation, tax reporting, and gain/loss determination. May differ from face_value_amount if acquired at premium or discount.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was created in the portfolio management system.',
    `disposition_date` DATE COMMENT 'Date when this holding was sold, matured, or transferred out of the portfolio. Null for active holdings.',
    `holding_classification` STRING COMMENT 'Portfolio management classification of this CD holding within the investment strategy. Core: long-term strategic allocation; Satellite: tactical positioning; Cash_equivalent: liquidity management component.',
    `holding_status` STRING COMMENT 'Current lifecycle status of this holding within the portfolio. Active: currently held; Pending_sale: marked for liquidation; Sold: position closed; Matured: CD reached maturity; Transferred_out: moved to another portfolio.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Realized gain or loss amount upon disposition of this holding, calculated as proceeds minus cost basis. Used for performance attribution and tax reporting. Null for active holdings.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was last modified.',
    CONSTRAINT pk_account_portfolio_holding PRIMARY KEY(`account_portfolio_holding_id`)
) COMMENT 'This association product represents the holding relationship between a certificate of deposit and a managed portfolio. It captures the investment position details including allocation percentage, acquisition cost basis, tax lot tracking, and holding classification. Each record links one certificate of deposit to one managed portfolio with attributes that exist only in the context of this investment holding relationship.. Existence Justification: In wealth management operations, a single certificate of deposit can be held across multiple managed portfolios simultaneously (e.g., family office allocating the same institutional CD across multiple family member portfolios, or a single large CD position split across multiple client portfolios for diversification). Conversely, a managed portfolio holds multiple CDs as part of its fixed-income allocation strategy, often implementing CD laddering with different maturities. The holding relationship itself carries critical portfolio management data including cost basis, allocation percentage, tax lot tracking, and holding classification that belongs to neither the CD nor the portfolio alone.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`custody_mandate` (
    `custody_mandate_id` BIGINT COMMENT 'Unique identifier for this custody mandate arrangement. Primary key.',
    `custodial_account_id` BIGINT COMMENT 'Foreign key linking to the custodial account providing custody services for this mandate',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to the investment banking mandate being supported by this custody arrangement',
    `arrangement_end_date` DATE COMMENT 'Date when this custody arrangement was terminated or the mandate was completed. Null for active arrangements.',
    `arrangement_start_date` DATE COMMENT 'Date when this custodial account was designated to support this mandate and custody services commenced.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of this custody mandate arrangement.',
    `asset_types_held` STRING COMMENT 'Comma-separated list or structured description of asset types held in this custodial account for this specific mandate (e.g., Equity Securities, Fixed Income, Cash Collateral, Derivatives). Asset segregation by mandate is critical for regulatory compliance and client reporting.',
    `authorized_signatories` STRING COMMENT 'List of individuals authorized to give instructions on this custody arrangement for this specific mandate (may be a subset of general account signatories).',
    `custody_role` STRING COMMENT 'The specific custodial role this account plays in supporting the mandate. Defines the nature of custody services provided (e.g., Primary Custodian for all deal assets, Escrow Agent for IPO proceeds, Collateral Agent for secured lending).',
    `fee_basis` STRING COMMENT 'The basis on which custody fees are calculated for this specific mandate arrangement. May differ from the custodial accounts standard fee schedule based on negotiated mandate terms.',
    `reporting_obligation` STRING COMMENT 'Description of specific reporting obligations tied to this custody arrangement, including report types, frequency, recipients, and regulatory requirements (e.g., Daily position reports to deal team and client CFO; quarterly regulatory filings under SEC Rule 17f-5).',
    `segregation_requirement` STRING COMMENT 'Level of asset segregation required for this mandate, driven by regulatory requirements, client preferences, or deal structure.',
    `valuation_frequency` STRING COMMENT 'Frequency at which assets held under this custody arrangement must be valued and marked-to-market for mandate reporting purposes. May differ from the custodial accounts standard valuation cycle based on mandate requirements.',
    CONSTRAINT pk_custody_mandate PRIMARY KEY(`custody_mandate_id`)
) COMMENT 'This association product represents the custody arrangement between a custodial account and an investment banking mandate. It captures the specific custodial services, asset segregation, and reporting obligations that exist when a custodial account is designated to support a specific mandate engagement. Each record links one custodial account to one mandate with attributes that define the custody relationship terms.. Existence Justification: In investment banking operations, a single custodial account can support multiple concurrent mandates (e.g., a multi-client custody platform or a trust account serving multiple deal structures), and a complex mandate (especially for structured products, IPOs with lock-up arrangements, or multi-tranche financings) can require multiple custodial accounts segregated by asset class, jurisdiction, or regulatory regime. The custody arrangement itself is an operational business entity with specific terms: custody role, asset types held, valuation frequency, reporting obligations, and fee arrangements that are negotiated per mandate and managed actively by custody operations teams.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_pledge` (
    `account_pledge_id` BIGINT COMMENT 'Primary key for account_pledge',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to the pledge agreement being secured by this accounts assets',
    `custodial_account_id` BIGINT COMMENT 'Foreign key linking to the custodial account providing assets for this pledge',
    `account_contribution_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total pledge amount that is contributed by this specific custodial account. Used when multiple accounts collectively secure a single pledge (consolidated collateral pool scenario).',
    `account_pledge_status` STRING COMMENT 'Current status of this specific account-pledge assignment: active (currently pledged), released (returned to account), substituted (replaced with other collateral), partial_release (some quantity released), defaulted (pledge enforced).',
    `effective_date` DATE COMMENT 'The date from which this specific accounts assets became pledged under this pledge agreement. Tracks when this account-pledge relationship became active.',
    `pledged_quantity` DECIMAL(18,2) COMMENT 'The quantity or number of units from this custodial account that are pledged under this specific pledge agreement. For securities, this is the number of shares or bonds; for cash, this is the monetary amount.',
    `release_conditions` STRING COMMENT 'Specific conditions under which the assets from this custodial account can be released from this pledge. May vary by account due to different governing instruments or beneficiary restrictions.',
    `release_date` DATE COMMENT 'The date on which the assets from this custodial account were released from this pledge agreement. Null for active pledges.',
    `substitution_date` DATE COMMENT 'The date on which collateral from this account was substituted with alternative collateral within this pledge. Null if no substitution has occurred.',
    `substitution_rights` STRING COMMENT 'Describes the rights and restrictions for substituting collateral from this specific custodial account within this pledge. May be constrained by the accounts governing instrument or investment restrictions.',
    `valuation_at_pledge` DECIMAL(18,2) COMMENT 'The market value of the pledged assets from this account at the time of pledge inception. Used for historical LTV tracking and collateral coverage calculations specific to this account-pledge combination.',
    CONSTRAINT pk_account_pledge PRIMARY KEY(`account_pledge_id`)
) COMMENT 'This association product represents the operational assignment of a specific custodial accounts assets to a specific pledge agreement. It captures the per-account-per-pledge collateral allocation details that exist only in the context of this relationship. Each record links one custodial account to one pledge with attributes tracking the quantity pledged from that account, valuation at pledge time, substitution rights specific to that account-pledge combination, and release conditions.. Existence Justification: In banking operations, a single custodial account can hold multiple types of securities and cash that may be pledged under different pledge agreements to secure various credit exposures, derivatives, or repo transactions. Conversely, a single pledge agreement can be secured by assets drawn from multiple custodial accounts, particularly in consolidated collateral pool arrangements where the bank aggregates assets across accounts to meet collateral requirements. The bank actively manages per-account-per-pledge data including the specific quantity pledged from each account, valuation at pledge time, substitution rights constrained by each accounts governing instrument, and release triggers.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`channel_enrollment` (
    `channel_enrollment_id` BIGINT COMMENT 'Unique system identifier for the account-channel enrollment record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the banking channel in which the account is enrolled',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to the deposit account enrolled in the channel',
    `employee_id` BIGINT COMMENT 'Identifier of the user (customer or bank staff) who initiated the enrollment. Used for audit trail and fraud investigation.',
    `authentication_method` STRING COMMENT 'Specific authentication method configured for this account-channel combination (e.g., biometric, hardware_token, sms_otp, app_push). May differ from channel default based on customer preference or risk profile.',
    `channel_enrollment_status` STRING COMMENT 'Current lifecycle status of the account-channel enrollment. Active = channel is available for use; Suspended = temporarily disabled (e.g., fraud alert); Inactive = customer deactivated; Pending_activation = awaiting verification; Revoked = permanently disabled by bank.',
    `deactivation_date` DATE COMMENT 'Date when the enrollment was deactivated, suspended, or revoked. Null for active enrollments. Used for audit trail and reactivation workflows.',
    `deactivation_reason` STRING COMMENT 'Reason code or description for enrollment deactivation (e.g., customer_request, fraud_alert, account_closure, security_breach). Null for active enrollments.',
    `enrollment_channel` STRING COMMENT 'Channel through which the enrollment was initiated (e.g., branch, mobile_app, web_banking, contact_center). Used to track enrollment source and self-service adoption.',
    `enrollment_date` DATE COMMENT 'Date when the account was enrolled or activated for use through this specific channel. Captured during channel onboarding or self-service activation.',
    `last_usage_date` DATE COMMENT 'Date of the most recent transaction or interaction with this account through this specific channel. Used for dormancy detection, fraud pattern analysis (sudden channel usage after long inactivity), and channel engagement metrics.',
    `preferred_flag` BOOLEAN COMMENT 'Indicates whether this is the customers preferred channel for interacting with this specific account. Used for routing notifications, optimizing customer experience, and channel recommendation engines.',
    `transaction_limit_override` DECIMAL(18,2) COMMENT 'Account-specific transaction limit override for this channel, if different from the channels default limit. Null indicates channel default applies. Used for high-value customers or risk-based controls.',
    `usage_count` STRING COMMENT 'Cumulative count of transactions or interactions performed on this account through this channel since enrollment. Used for channel adoption analytics and customer behavior profiling.',
    CONSTRAINT pk_channel_enrollment PRIMARY KEY(`channel_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between deposit accounts and banking channels. It captures which channels a customer has activated for each account, tracking enrollment lifecycle, usage patterns, and channel preferences. Each record links one deposit account to one channel with enrollment status, dates, usage metrics, and preference indicators used for channel analytics, fraud detection (unusual channel usage patterns), and customer experience optimization.. Existence Justification: In banking operations, customers actively enroll individual deposit accounts in multiple channels (mobile app, web banking, ATM network, branch access) to enable multi-channel access, and each channel serves thousands of accounts. Banks manage these enrollments as operational records with lifecycle status (active, suspended, revoked), track usage patterns per account-channel pair for fraud detection (e.g., sudden ATM usage after months of mobile-only activity), and maintain channel preferences and authentication methods specific to each account-channel combination.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`rm_account_assignment` (
    `rm_account_assignment_id` BIGINT COMMENT 'Unique system identifier for this relationship manager account assignment record. Primary key.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key linking to the relationship manager assigned to serve the account',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to the deposit account being served by the relationship manager',
    `assignment_date` DATE COMMENT 'Date the relationship manager was assigned to serve this deposit account. Used for coverage continuity tracking, performance period attribution, and handoff analysis. Explicitly identified in detection reasoning.',
    `assignment_end_date` DATE COMMENT 'Date the relationship managers assignment to this account ended or is scheduled to end. Null for active assignments. Used for portfolio transfer tracking, succession planning, and historical coverage analysis.',
    `assignment_reason` STRING COMMENT 'Business reason or trigger for this RM account assignment. Examples: new_account_opening, portfolio_transfer, rm_departure, client_request, geographic_realignment, product_specialization, escalation. Used for assignment pattern analysis and coverage optimization.',
    `assignment_type` STRING COMMENT 'Classification of the relationship managers role in serving this account. Primary = main point of contact and accountability; Secondary = backup or co-coverage; Specialist = product-specific or technical coverage (e.g., treasury management, FX); Coverage = geographic or portfolio coverage without primary responsibility. Determines escalation paths and performance attribution rules.',
    `aum_at_assignment` DECIMAL(18,2) COMMENT 'Assets under management (account balance) at the time of assignment. Provides baseline for measuring account growth under this RMs coverage. Used for performance attribution and portfolio composition analysis.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of coverage responsibility allocated to this relationship manager for this account, expressed as a decimal (e.g., 100.00 for sole coverage, 50.00 for split coverage). Used in matrix coverage models where multiple RMs share responsibility. Sum of coverage_percentage across all active assignments for an account may equal 100% or exceed it in overlapping coverage models. Explicitly identified in detection reasoning.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was created. Used for audit trail and data lineage.',
    `handoff_notes` STRING COMMENT 'Free-text notes documenting context for this assignment, particularly for portfolio transfers or reassignments. May include client preferences, service history, relationship nuances, or special handling instructions. Used for coverage continuity and knowledge transfer.',
    `lob_context` STRING COMMENT 'Line of business context for this specific assignment, which may differ from the RMs primary LOB assignment if the RM provides cross-LOB coverage. Examples: commercial_banking, wealth_management, private_banking, treasury_services. Used for LOB-specific performance reporting and coverage analysis.',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue attributed to this relationship manager from this account assignment, measured in the banks reporting currency. Calculated based on fees, interest income, cross-sell revenue, and attribution rules (may be split across multiple RMs based on coverage_percentage or assignment_type). Used for RM performance evaluation, compensation calculation, and portfolio profitability analysis. Explicitly identified in detection reasoning.',
    `rm_account_assignment_status` STRING COMMENT 'Current status of this RM account assignment. Active = currently serving; Inactive = assignment ended; Pending = scheduled future assignment; Suspended = temporarily paused (e.g., RM on leave). Determines whether this assignment is included in active portfolio counts and service routing.',
    `service_model` STRING COMMENT 'Service delivery model applied to this RM-account assignment. Dedicated = RM provides personalized service; Shared = RM is part of a team serving the account; Pooled = account served by RM pool without dedicated assignment; Virtual = remote or digital-first service model. Determines service level expectations and client communication protocols. Explicitly identified in detection reasoning.',
    `updated_by` STRING COMMENT 'User ID or system identifier that last updated this assignment record. Used for audit trail and change tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was last updated. Used for audit trail and change tracking.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this assignment record. Used for audit trail and accountability.',
    CONSTRAINT pk_rm_account_assignment PRIMARY KEY(`rm_account_assignment_id`)
) COMMENT 'This association product represents the Assignment between deposit_account and relationship_manager. It captures the operational coverage model where relationship managers are assigned to serve specific deposit accounts with defined roles, coverage responsibilities, and revenue attribution. Each record links one deposit_account to one relationship_manager with attributes that exist only in the context of this assignment relationship, including assignment type (primary, secondary, specialist), coverage percentage, service model, revenue attribution, and assignment lifecycle dates. This is the account-level RM assignment, distinct from party-level client assignments.. Existence Justification: In banking operations, high-value deposit accounts are routinely served by multiple relationship managers simultaneously with different roles (primary RM, secondary RM, product specialists for treasury/FX services, geographic coverage RMs). Each RM manages a portfolio of multiple accounts. Banks actively manage these assignments as operational records, tracking assignment type, coverage percentage, service model, and revenue attribution per RM-account pair for performance management, succession planning, portfolio transfers, and client service coordination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ADD CONSTRAINT `fk_account_certificate_of_deposit_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ADD CONSTRAINT `fk_account_custodial_account_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_reversed_transaction_account_transaction_id` FOREIGN KEY (`reversed_transaction_account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_superseded_by_rate_interest_rate_id` FOREIGN KEY (`superseded_by_rate_interest_rate_id`) REFERENCES `banking_ecm`.`account`.`interest_rate`(`interest_rate_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ADD CONSTRAINT `fk_account_dormancy_review_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`document` ADD CONSTRAINT `fk_account_document_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`sweep` ADD CONSTRAINT `fk_account_sweep_sweep_deposit_account_id` FOREIGN KEY (`sweep_deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ADD CONSTRAINT `fk_account_beneficiary_designation_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_position` ADD CONSTRAINT `fk_account_account_position_custodial_account_id` FOREIGN KEY (`custodial_account_id`) REFERENCES `banking_ecm`.`account`.`custodial_account`(`custodial_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ADD CONSTRAINT `fk_account_account_collateral_pledge_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ADD CONSTRAINT `fk_account_account_portfolio_holding_certificate_of_deposit_id` FOREIGN KEY (`certificate_of_deposit_id`) REFERENCES `banking_ecm`.`account`.`certificate_of_deposit`(`certificate_of_deposit_id`);
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ADD CONSTRAINT `fk_account_custody_mandate_custodial_account_id` FOREIGN KEY (`custodial_account_id`) REFERENCES `banking_ecm`.`account`.`custodial_account`(`custodial_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ADD CONSTRAINT `fk_account_account_pledge_custodial_account_id` FOREIGN KEY (`custodial_account_id`) REFERENCES `banking_ecm`.`account`.`custodial_account`(`custodial_account_id`);
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ADD CONSTRAINT `fk_account_channel_enrollment_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ADD CONSTRAINT `fk_account_rm_account_assignment_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`account` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`account` SET TAGS ('dbx_domain' = 'account');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,16}$');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|dormant|closed|frozen|restricted|pending_opening');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'DDA|savings|money_market|NOW|certificate_of_deposit|custodial');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `amount_escheated` SET TAGS ('dbx_business_glossary_term' = 'Amount Escheated');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `atm_withdrawal_limit` SET TAGS ('dbx_business_glossary_term' = 'ATM Withdrawal Limit');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compounding Frequency');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|none');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `daily_transfer_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transfer Limit');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `daily_withdrawal_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Withdrawal Limit');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `dormancy_classification_date` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Classification Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `dormancy_period_months` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Period (Months)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `escheatment_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Filing Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `escheatment_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Jurisdiction');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `escheatment_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|not_applicable');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `fdic_coverage_category` SET TAGS ('dbx_business_glossary_term' = 'FDIC Coverage Category');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `fdic_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'FDIC Insured Flag');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|simple|compound');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `overdraft_opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Opt-In Status');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `overdraft_opt_in_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|not_applicable');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `overdraft_protection_source` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Protection Source');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `overdraft_protection_source` SET TAGS ('dbx_value_regex' = 'none|linked_savings|line_of_credit|credit_card');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'transaction_account|savings_deposit|time_deposit');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `statement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `statement_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Status');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_value_regex' = 'US_person|foreign_person|exempt|pending');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `certificate_of_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Deposit (CD) Identifier');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Code');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `apy` SET TAGS ('dbx_business_glossary_term' = 'Annual Percentage Yield (APY)');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `call_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Call Premium Amount');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Flag');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `cd_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Deposit (CD) Number');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `cd_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Deposit (CD) Status');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `cd_status` SET TAGS ('dbx_value_regex' = 'active|matured|redeemed|rolled_over|closed');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `cd_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Deposit (CD) Type');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `cd_type` SET TAGS ('dbx_value_regex' = 'traditional|jumbo|brokered|callable|bump_up|variable_rate');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compounding Frequency');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|semi_annually|annually|at_maturity');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'ACT_360|ACT_365|ACT_ACT|30_360');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `early_withdrawal_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Withdrawal Penalty Flag');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `face_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Value Amount');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `fdic_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insured Flag');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period in Days');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `maturity_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Maturity Value Amount');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `negotiable_flag` SET TAGS ('dbx_business_glossary_term' = 'Negotiable Flag');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'simple_interest|compound_interest|flat_fee|percentage_of_principal');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `penalty_months_interest` SET TAGS ('dbx_business_glossary_term' = 'Penalty in Months of Interest');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `rate_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|step_up');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `regulatory_reserve_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reserve Classification');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `regulatory_reserve_classification` SET TAGS ('dbx_value_regex' = 'transaction_account|savings_deposit|time_deposit');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `renewal_instruction` SET TAGS ('dbx_business_glossary_term' = 'Renewal Instruction');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `renewal_instruction` SET TAGS ('dbx_value_regex' = 'principal_only|principal_plus_interest|transfer_to_dda|hold_for_instruction');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `renewal_term_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term in Days');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`certificate_of_deposit` ALTER COLUMN `term_days` SET TAGS ('dbx_business_glossary_term' = 'Term in Days');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `custodial_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodial Account ID');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch ID');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Entity ID');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `loan_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,34}$');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|dormant|suspended|closed|pending_approval|restricted');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `annual_management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Management Fee Rate');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `cash_balance` SET TAGS ('dbx_business_glossary_term' = 'Cash Balance');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand|event_triggered|none');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `distribution_instruction` SET TAGS ('dbx_business_glossary_term' = 'Distribution Instruction');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|not_applicable');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `fiduciary_relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Fiduciary Relationship Type');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `fiduciary_relationship_type` SET TAGS ('dbx_value_regex' = 'trust|escrow|iolta|guardian|conservator|executor');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `governing_instrument_date` SET TAGS ('dbx_business_glossary_term' = 'Governing Instrument Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `governing_instrument_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Instrument Reference');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|simple|compound');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `investment_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Investment Restriction Description');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `investment_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Investment Restriction Flag');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `kyc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|expired|failed');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `next_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Statement Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Regime');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_value_regex' = 'occ_federal|state_trust_law|erisa|uniform_trust_code|probate_court');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `securities_market_value` SET TAGS ('dbx_business_glossary_term' = 'Securities Market Value');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `banking_ecm`.`account`.`custodial_account` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `banking_ecm`.`account`.`holder` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`holder` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `holder_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `holder_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `holder_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `aml_risk_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `beneficiary_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Allocation Percentage');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `beneficiary_designation_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `beneficiary_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Revocation Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'individual|trust|estate|charity|none');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `designation_date` SET TAGS ('dbx_business_glossary_term' = 'Designation Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `fdic_insurance_category` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insurance Category');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|none');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `ownership_role` SET TAGS ('dbx_business_glossary_term' = 'Ownership Role');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `ownership_role` SET TAGS ('dbx_value_regex' = 'primary_owner|joint_owner|authorized_signer|power_of_attorney|trustee|custodian');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending_review|blocked');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `signing_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Level');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `signing_authority_level` SET TAGS ('dbx_value_regex' = 'full|limited|none');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `signing_authority_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Limit Amount');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `statement_delivery_preference` SET TAGS ('dbx_business_glossary_term' = 'Statement Delivery Preference');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `statement_delivery_preference` SET TAGS ('dbx_value_regex' = 'electronic|paper|both|none');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Type');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_value_regex' = 'ssn|ein|itin|foreign_tin|none');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Status');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_value_regex' = 'reportable|exempt|foreign|pending');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `w9_w8_form_received_date` SET TAGS ('dbx_business_glossary_term' = 'W-9 or W-8 Form Received Date');
ALTER TABLE `banking_ecm`.`account`.`balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`balance` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `balance_id` SET TAGS ('dbx_business_glossary_term' = 'Account Balance Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `available_overdraft` SET TAGS ('dbx_business_glossary_term' = 'Available Overdraft');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `average_daily_balance` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Balance (ADB)');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `balance_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|frozen|dormant|closed|restricted');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `collateral_pledged_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledged Amount');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `collected_balance` SET TAGS ('dbx_business_glossary_term' = 'Collected Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Days in Period');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `fdic_insured_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insured Amount');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `float_balance` SET TAGS ('dbx_business_glossary_term' = 'Float Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `hold_balance` SET TAGS ('dbx_business_glossary_term' = 'Hold Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `interest_bearing_balance` SET TAGS ('dbx_business_glossary_term' = 'Interest-Bearing Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `ledger_balance` SET TAGS ('dbx_business_glossary_term' = 'Ledger Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `maximum_balance` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `minimum_balance` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `minimum_balance_threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Threshold Breach Flag');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `overdraft_balance` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `pending_credits` SET TAGS ('dbx_business_glossary_term' = 'Pending Credits');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `pending_debits` SET TAGS ('dbx_business_glossary_term' = 'Pending Debits');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|exception|override');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `reserve_requirement_balance` SET TAGS ('dbx_business_glossary_term' = 'Reserve Requirement Balance');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Snapshot Timestamp');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'T24|FIS_PROFILE|FINACLE|OTHER');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `statement_cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle End Date');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `statement_cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle Start Date');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `uninsured_amount` SET TAGS ('dbx_business_glossary_term' = 'Uninsured Amount');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Teller ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `reversed_transaction_account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `aml_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Alert Flag');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `balance_after_transaction` SET TAGS ('dbx_business_glossary_term' = 'Balance After Transaction');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `card_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Card Authorization Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `counterparty_bank_bic` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bank Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `counterparty_bank_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `ctr_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Currency Transaction Report (CTR) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Transaction Narrative');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `original_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `payment_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment System Reference');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|failed|cancelled');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = 'debit|credit|fee|interest|adjustment|reversal');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `wire_imad` SET TAGS ('dbx_business_glossary_term' = 'Wire Input Message Accountability Data (IMAD)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `wire_omad` SET TAGS ('dbx_business_glossary_term' = 'Wire Output Message Accountability Data (OMAD)');
ALTER TABLE `banking_ecm`.`account`.`statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`statement` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Account Statement Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `annual_percentage_yield` SET TAGS ('dbx_business_glossary_term' = 'Annual Percentage Yield (APY)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `archival_date` SET TAGS ('dbx_business_glossary_term' = 'Archival Date');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `archival_status` SET TAGS ('dbx_business_glossary_term' = 'Archival Status');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `archival_status` SET TAGS ('dbx_value_regex' = 'active|archived|purged');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `average_daily_balance` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Balance (ADB)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle Code');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|failed|bounced|viewed|downloaded');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `escheatment_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Warning Flag');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `fees_charged` SET TAGS ('dbx_business_glossary_term' = 'Fees Charged');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Statement Format');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'pdf|html|csv|xml|paper');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `generated_by_system` SET TAGS ('dbx_business_glossary_term' = 'Generated By System');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `interest_earned` SET TAGS ('dbx_business_glossary_term' = 'Interest Earned');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Statement Language');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `maximum_balance` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `minimum_balance` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `notice_of_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Notice of Change Flag');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `overdraft_count` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Count');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `overdraft_fees` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Fees');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `reg_dd_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulation DD (Reg DD) Disclosure Flag');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `reg_e_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulation E (Reg E) Disclosure Flag');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|interim|final|ad_hoc');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'customer_request|no_activity|dormant_account|closed_account|regulatory_exemption');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `total_debits` SET TAGS ('dbx_business_glossary_term' = 'Total Debits');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `viewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Viewed Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Account Interest Accrual Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Basis Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_basis_code` SET TAGS ('dbx_value_regex' = 'ACT/360|ACT/365|30/360|ACT/ACT|30/365');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Date');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'simple|compound|continuous');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Reason Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Status');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'calculated|posted|reversed|suspended|pending_review');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `applicable_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Applicable Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `cumulative_accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Days in Accrual Period');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_income_gl_account` SET TAGS ('dbx_business_glossary_term' = 'Interest Income General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_payable_gl_account` SET TAGS ('dbx_business_glossary_term' = 'Interest Payable General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_posting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Posting Frequency');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_rate_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Tier Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `last_interest_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interest Payment Date');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `net_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `next_interest_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Interest Payment Date');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interest Posted Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `principal_balance` SET TAGS ('dbx_business_glossary_term' = 'Principal Balance Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Deposit Product Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `tax_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Required Flag');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `year_basis_days` SET TAGS ('dbx_business_glossary_term' = 'Year Basis Days');
ALTER TABLE `banking_ecm`.`account`.`account_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`account_fee` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `account_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Fee Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authority Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `assessed_amount` SET TAGS ('dbx_business_glossary_term' = 'Assessed Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Assessment Date');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fee Assessment Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `customer_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `disclosure_statement_text` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Statement Text');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Dispute Flag');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'RETAIL|COMMERCIAL|WEALTH|PRIVATE');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'STATEMENT|EMAIL|SMS|MOBILE|BRANCH');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Account Product Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `regulatory_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Required Flag');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Date');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Reversal Flag');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'ERROR|DISPUTE|GOODWILL|REGULATORY|FRAUD');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Type Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `waived_amount` SET TAGS ('dbx_business_glossary_term' = 'Waived Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Flag');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_value_regex' = 'CUST_REQ|SVC_FAIL|PROMO|REL_MGMT|REG_COMP|ERROR');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `waiver_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason Description');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `waiver_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authorization Timestamp');
ALTER TABLE `banking_ecm`.`account`.`hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`hold` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Currency Code');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placing User Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_last_modified_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified User Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_last_modified_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_last_modified_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Placing Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `beneficiary_reference` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Reference Number');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `check_amount` SET TAGS ('dbx_business_glossary_term' = 'Check Amount');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `check_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Check Serial Number');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `court_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Court Jurisdiction');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `expiration_action` SET TAGS ('dbx_business_glossary_term' = 'Expiration Action');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `expiration_action` SET TAGS ('dbx_value_regex' = 'auto_release|manual_review|extend|escalate');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|cancelled|partial_release');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `is_current_record` SET TAGS ('dbx_business_glossary_term' = 'Is Current Record Flag');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `partial_release_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Release Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `placement_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `placing_authority` SET TAGS ('dbx_business_glossary_term' = 'Placing Authority');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `reason_narrative` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Narrative');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `record_end_date` SET TAGS ('dbx_business_glossary_term' = 'Record End Date');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Reference Number');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `released_amount` SET TAGS ('dbx_business_glossary_term' = 'Released Amount');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `remaining_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Hold Amount');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` SET TAGS ('dbx_subdomain' = 'product_pricing');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `overdraft_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Officer Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `approved_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Overdraft Limit Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `auto_repayment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Repayment Enabled Flag');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|account_closure|credit_review|regulatory|fraud|other');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `current_utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Utilization Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `daily_fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Fee Cap Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_number` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Number');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_number` SET TAGS ('dbx_value_regex' = '^ODF[0-9]{10}$');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Type');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'standard|premium|linked_savings|linked_credit_line|linked_credit_card');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'daily_balance|average_daily_balance|simple|compound|none');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `lifetime_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Usage Count');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `monthly_fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Fee Cap Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Notification Preference');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|mail|none');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Regulation E (Reg E) Opt-In Status');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|pending|not_applicable');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `overdraft_facility_status` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Status');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `overdraft_facility_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending_activation');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `overdraft_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `protection_source_type` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Protection Source Type');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `protection_source_type` SET TAGS ('dbx_value_regex' = 'bank_coverage|savings_account|line_of_credit|credit_card|none');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'T24|FIS_PROFILE|MANUAL|MIGRATION');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Transfer Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `transfer_increment_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Increment Amount');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `banking_ecm`.`account`.`account_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`account_limit` SET TAGS ('dbx_subdomain' = 'product_pricing');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `account_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Account Limit Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `aml_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Threshold Flag');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Amount');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `breach_action_code` SET TAGS ('dbx_business_glossary_term' = 'Breach Action Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `breach_action_code` SET TAGS ('dbx_value_regex' = 'BLOCK|WARN|ALLOW_WITH_FEE|ESCALATE');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `customer_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Flag');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `fraud_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Prevention Flag');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `last_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reset Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `last_utilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Utilization Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `limit_description` SET TAGS ('dbx_business_glossary_term' = 'Limit Description');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Limit Status');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUSPENDED|EXPIRED|PENDING|CANCELLED');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'EMAIL|SMS|MOBILE_APP|PHONE|NONE');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `notification_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold Amount');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `regulatory_mandate_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `reset_frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Reset Frequency Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `reset_frequency_code` SET TAGS ('dbx_value_regex' = 'DAILY|WEEKLY|MONTHLY|QUARTERLY|ANNUAL|NONE');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Limit Type Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = 'DAILY_WITHDRAWAL|DAILY_TRANSFER|ATM_CASH|WIRE_TRANSFER|ACH_DEBIT|MIN_BALANCE');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilization Amount');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `utilization_count` SET TAGS ('dbx_business_glossary_term' = 'Utilization Count');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`account`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`status_history` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Account Status History ID');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Officer ID');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `aml_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Required Flag');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Officer Name');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `balance_at_transition` SET TAGS ('dbx_business_glossary_term' = 'Account Balance at Transition');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Status Change Comments');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `dormancy_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Period Days');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Timestamp');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `hold_authority` SET TAGS ('dbx_business_glossary_term' = 'Hold Authority');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Reference Number');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `initiating_channel` SET TAGS ('dbx_business_glossary_term' = 'Initiating Channel');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Account Status');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reversal Flag');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `reversal_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reference ID');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` SET TAGS ('dbx_subdomain' = 'product_pricing');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Account Interest Rate ID');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `superseded_by_rate_interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Interest Rate');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compounding Frequency');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|continuous');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `ftp_rate` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `interest_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Payment Frequency');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `interest_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|at_maturity');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rate Flag');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `is_tax_advantaged` SET TAGS ('dbx_business_glossary_term' = 'Tax Advantaged Account Flag');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `maximum_balance_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Cap');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `minimum_balance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Requirement');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `nim_contribution_bps` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Margin (NIM) Contribution in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `promotional_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Authority');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_approval_authority` SET TAGS ('dbx_value_regex' = 'ALCO|TREASURY|PRODUCT_MANAGEMENT|BRANCH_MANAGER|EXECUTIVE_COMMITTEE');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Date');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Ceiling');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_change_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Frequency');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Reason');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_floor` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Floor');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Configuration Status');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|suspended');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|tiered|promotional');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `regulatory_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Text');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `relationship_bonus_bps` SET TAGS ('dbx_business_glossary_term' = 'Relationship Bonus in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `relationship_pricing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Relationship Pricing Eligible Flag');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `tier_apr` SET TAGS ('dbx_business_glossary_term' = 'Tier Annual Percentage Rate (APR)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `tier_apy` SET TAGS ('dbx_business_glossary_term' = 'Tier Annual Percentage Yield (APY)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `tier_maximum_balance` SET TAGS ('dbx_business_glossary_term' = 'Tier Maximum Balance');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `tier_minimum_balance` SET TAGS ('dbx_business_glossary_term' = 'Tier Minimum Balance');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `tier_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Sequence Number');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`account_product` SET TAGS ('dbx_subdomain' = 'product_pricing');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `account_product_id` SET TAGS ('dbx_business_glossary_term' = 'Account Product Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Call Report Category Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `account_type_code` SET TAGS ('dbx_business_glossary_term' = 'Account Type Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `account_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `ach_transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Transfer Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `age_restriction_maximum` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Maximum');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Minimum');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC) / SWIFT Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `check_writing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Check Writing Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `crs_reportable` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `debit_card_eligible` SET TAGS ('dbx_business_glossary_term' = 'Debit Card Eligible Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `debit_card_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `debit_card_eligible` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `eligible_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Eligible Customer Segments');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `fatca_reportable` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `fdic_insurance_category` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insurance Category');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Reference Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `gl_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Mapping Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `gl_mapping_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `iban_assignment_required` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN) Assignment Required Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `iban_assignment_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `iban_assignment_required` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'daily_balance|average_daily_balance|minimum_balance|tiered|not_applicable');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Compounding Frequency');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_compounding_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|maturity|not_applicable');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Schedule Reference Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `interest_rate_schedule_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `kyc_tier_required` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Tier Required');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `kyc_tier_required` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|simplified');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|grandfathered|pending_approval|suspended');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `maximum_balance_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Limit');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `minimum_balance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Requirement');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `minimum_opening_deposit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Opening Deposit Amount');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `mobile_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mobile Banking Enabled Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `mobile_banking_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `mobile_banking_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `online_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Banking Enabled Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `overdraft_protection_available` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Protection Available Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'DDA|savings|money_market|certificate_of_deposit|custodial|other');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'reg_d_savings|transaction_account|time_deposit|custodial|exempt');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `reserve_requirement_applicable` SET TAGS ('dbx_business_glossary_term' = 'Reserve Requirement Applicable Flag');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `reserve_requirement_ratio` SET TAGS ('dbx_business_glossary_term' = 'Reserve Requirement Ratio');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand|electronic_only');
ALTER TABLE `banking_ecm`.`account`.`account_product` ALTER COLUMN `wire_transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`standing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`standing_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Identifier');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Setup Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|blocked');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `aml_screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Timestamp');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `beneficiary_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `beneficiary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bank Name');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `business_day_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Business Day Adjustment Convention');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `business_day_adjustment` SET TAGS ('dbx_value_regex' = 'following|preceding|modified_following|no_adjustment');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'customer_request|account_closure|insufficient_funds|fraud_prevention|regulatory_hold|system_error');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_business_glossary_term' = 'Charge Bearer Party');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_value_regex' = 'debtor|creditor|shared');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `customer_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Total Execution Count');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `execution_day` SET TAGS ('dbx_business_glossary_term' = 'Execution Day of Period');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `failed_execution_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Execution Count');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Instruction Reference Number');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Instruction Status');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `instruction_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|pending_activation|expired');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `next_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Execution Date');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|none');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'ach|internal_transfer|swift|rtgs|sepa|faster_payments');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Text');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'normal|high|urgent');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `setup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Setup Timestamp');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Amount');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `direct_debit_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Debit Mandate Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Company Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `aml_review_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `aml_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Required Flag');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Method');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `authorization_method` SET TAGS ('dbx_value_regex' = 'written|electronic|verbal|digital_signature');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Debit Amount');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `collection_count` SET TAGS ('dbx_business_glossary_term' = 'Collection Count');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `creditor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Creditor Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `creditor_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{3}[A-Z0-9]{1,28}$');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `first_collection_date` SET TAGS ('dbx_business_glossary_term' = 'First Collection Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Debit Frequency Code');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `last_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `mandate_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Mandate Reference Number');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `mandate_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,35}$');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_business_glossary_term' = 'Mandate Status');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_value_regex' = 'recurring|one_off|variable');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|mail|none');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `originator_name` SET TAGS ('dbx_business_glossary_term' = 'Originator Name');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `pre_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Pre-Notification Days');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `return_count` SET TAGS ('dbx_business_glossary_term' = 'ACH Return Count');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `revocation_channel` SET TAGS ('dbx_business_glossary_term' = 'Revocation Channel');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `revocation_channel` SET TAGS ('dbx_value_regex' = 'branch|online_banking|mobile_app|phone|mail|in_person');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `revocation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason Code');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `revocation_reason_code` SET TAGS ('dbx_value_regex' = 'customer_request|account_closure|fraud_suspected|unauthorized|service_terminated|other');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `sec_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Entry Class (SEC) Code');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `signature_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Document Reference');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `signature_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature on File Flag');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `dormancy_review_id` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Review ID');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Outreach Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Compliance Officer ID');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `account_balance_at_review` SET TAGS ('dbx_business_glossary_term' = 'Account Balance at Review Initiation');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `amount_escheated` SET TAGS ('dbx_business_glossary_term' = 'Amount Escheated to State');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `closure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Review Closure Reason Code');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `closure_reason_code` SET TAGS ('dbx_value_regex' = 'reactivated|escheated|account_closed|customer_deceased|transferred');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `customer_response_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Channel');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `customer_response_channel` SET TAGS ('dbx_value_regex' = 'phone|email|branch|mail|online_banking|mobile_app');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `customer_response_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `customer_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Flag');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `dormancy_classification_date` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Classification Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `dormancy_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Period in Days');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `escheatment_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Filing Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `escheatment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'State Escheatment Reference Number');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `escheatment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Required Flag');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `first_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'First Customer Outreach Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `last_customer_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Customer-Initiated Activity Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `last_outreach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Customer Outreach Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `outreach_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Outreach Attempt Count');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `outreach_method_log` SET TAGS ('dbx_business_glossary_term' = 'Outreach Method Log');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Reactivation Date');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `reactivation_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Reactivation Flag');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Closed Timestamp');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Initiated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Review Priority Level');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Review Reference Number');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_reference_number` SET TAGS ('dbx_value_regex' = '^DR-[0-9]{10}$');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Review Status');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `state_escheatment_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'State Escheatment Threshold in Days');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `state_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction Code');
ALTER TABLE `banking_ecm`.`account`.`dormancy_review` ALTER COLUMN `state_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `banking_ecm`.`account`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`document` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Account Document Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Reviewer Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verifying Officer Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_verifying_officer_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Upload Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `aml_review_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `aml_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Required Flag');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `cdd_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Due Diligence (CDD) Verification Flag');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `destruction_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorized By');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `destruction_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'pending|verified|approved|rejected|expired|archived');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|jpeg|png|tiff|docx|xml');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `kyc_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Flag');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mail|portal|mobile_app|phone');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `regulatory_mandate_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Code');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `storage_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Reference Uniform Resource Identifier (URI)');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `storage_reference_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `upload_date` SET TAGS ('dbx_business_glossary_term' = 'Upload Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `banking_ecm`.`account`.`document` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `banking_ecm`.`account`.`sweep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`sweep` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `sweep_id` SET TAGS ('dbx_business_glossary_term' = 'Account Sweep Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Officer Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Identifier');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Setup Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `sweep_deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `aml_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Required Flag');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Sweep Arrangement Number');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `auto_replenishment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Replenishment Enabled Flag');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|preceding|modified_following|end_of_month');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `customer_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Enabled Flag');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Sweep Direction');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'one_way|two_way|bidirectional');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Sweep Frequency');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|end_of_day|intraday|on_demand');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `ftp_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate Code');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `holiday_calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Code');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `investment_vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Type');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `investment_vehicle_type` SET TAGS ('dbx_value_regex' = 'money_market_fund|mutual_fund|brokerage_account|treasury_account|external_investment|none');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `last_sweep_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Sweep Amount');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `last_sweep_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sweep Execution Date');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `lifetime_sweep_count` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Sweep Count');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `lifetime_sweep_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Sweep Total Amount');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'retail_banking|commercial_banking|corporate_treasury|wealth_management|private_banking');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `maximum_sweep_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Sweep Amount');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `minimum_sweep_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Sweep Amount');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `next_scheduled_sweep_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sweep Date');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|mobile_app|statement_only|none');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Sweep Priority Rank');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `replenishment_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Threshold Amount');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `sweep_status` SET TAGS ('dbx_business_glossary_term' = 'Sweep Status');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `sweep_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_activation|under_review');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `sweep_type` SET TAGS ('dbx_business_glossary_term' = 'Sweep Type');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `sweep_type` SET TAGS ('dbx_value_regex' = 'zero_balance|target_balance|threshold|investment_sweep|hybrid');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `target_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Balance Amount');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`account`.`sweep` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Sweep Threshold Amount');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_designation_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 1');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 2');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_city` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary City');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Country Code');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Date of Birth');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Email Address');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Phone Number');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Postal Code');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_priority` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Priority Level');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_priority` SET TAGS ('dbx_value_regex' = 'primary|contingent|tertiary');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_state_province` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary State or Province');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'individual|trust|estate|charity|organization|minor');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `designation_date` SET TAGS ('dbx_business_glossary_term' = 'Designation Effective Date');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `designation_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Number');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `designation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `designation_status` SET TAGS ('dbx_business_glossary_term' = 'Designation Status');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `designation_status` SET TAGS ('dbx_value_regex' = 'active|revoked|superseded|pending|expired');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `fdic_insurance_category` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insurance Category');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `minor_custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Minor Custodian Name');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `minor_custodian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `minor_custodian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `notarization_date` SET TAGS ('dbx_business_glossary_term' = 'Notarization Date');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `notarization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarization Required Flag');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `per_stirpes_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Stirpes Distribution Flag');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `relationship_to_account_holder` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Account Holder');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'T24|FIS_PROFILE|MANUAL|ONLINE_BANKING');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `trust_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Establishment Date');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `trust_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Name');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `trustee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `trustee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`account`.`beneficiary_designation` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` SET TAGS ('dbx_subdomain' = 'product_pricing');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `annual_percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Percentage Rate (APR)');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `annual_percentage_yield` SET TAGS ('dbx_business_glossary_term' = 'Annual Percentage Yield (APY)');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compounding Frequency');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|continuous');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `fdic_insurance_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insurance Applicable Flag');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `ftp_rate` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'daily_balance|average_daily_balance|minimum_balance|collected_balance');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `maximum_balance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Threshold');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `minimum_balance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Threshold');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `minimum_opening_deposit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Opening Deposit');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `nim_impact_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Margin (NIM) Impact Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `promotional_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Description');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_change_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Frequency');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_change_frequency` SET TAGS ('dbx_value_regex' = 'fixed|variable_daily|variable_monthly|variable_quarterly|index_linked');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_index_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Index Code');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_margin_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Rate Margin Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Status');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `regulatory_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Text');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `relationship_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Criteria Description');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `relationship_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Pricing Flag');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `tier_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Sequence Number');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`account`.`rate_tier` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`account`.`type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`account`.`type` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Account Type Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Call Report Line Item Reference');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `account_type_code` SET TAGS ('dbx_business_glossary_term' = 'Account Type Code');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `account_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `account_type_description` SET TAGS ('dbx_business_glossary_term' = 'Account Type Description');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `account_type_name` SET TAGS ('dbx_business_glossary_term' = 'Account Type Name');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `ach_transfer_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Transfer Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `atm_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Access Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `call_report_schedule` SET TAGS ('dbx_business_glossary_term' = 'Call Report Schedule Code');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `call_report_schedule` SET TAGS ('dbx_value_regex' = '^RC-[A-Z]{1,3}$');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `check_writing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Check Writing Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `cip_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Identification Program (CIP) Exemption Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|middle_market|corporate|institutional|government');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `debit_card_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Debit Card Eligible Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `debit_card_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `debit_card_eligible_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `escheatment_period_years` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Period in Years');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `fatca_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `fdic_insurance_category` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insurance Category');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `fdic_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insured Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `gl_liability_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Liability Category');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `gl_liability_category` SET TAGS ('dbx_value_regex' = 'demand_deposits|savings_deposits|time_deposits|brokered_deposits|other_liabilities');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `kyc_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Required Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `liquidity_coverage_ratio_category` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Category');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `liquidity_coverage_ratio_category` SET TAGS ('dbx_value_regex' = 'stable_retail|less_stable_retail|operational|non_operational|other');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `minimum_balance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Requirement Amount');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `minimum_opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Minimum Opening Balance Amount');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `monthly_service_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Service Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `nsfr_category` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Category');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `nsfr_category` SET TAGS ('dbx_value_regex' = 'stable_funding|less_stable_funding|other_liabilities');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Banking Enabled Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `overdraft_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'retail_banking|commercial_banking|private_banking|wealth_management|institutional');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'transaction_account|savings_account|time_deposit|custodial_account|other');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `reserve_requirement_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserve Requirement Applicable Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|on_demand');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `tax_reporting_form` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Form Code');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `transaction_limit_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Applicable Flag');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `type_status` SET TAGS ('dbx_business_glossary_term' = 'Account Type Status');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `banking_ecm`.`account`.`type` ALTER COLUMN `wire_transfer_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Allowed Flag');
ALTER TABLE `banking_ecm`.`account`.`account_position` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`account_position` SET TAGS ('dbx_subdomain' = 'account_master');
ALTER TABLE `banking_ecm`.`account`.`account_position` SET TAGS ('dbx_association_edges' = 'account.custodial_account,security.instrument');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `account_position_id` SET TAGS ('dbx_business_glossary_term' = 'account_position Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `custodial_account_id` SET TAGS ('dbx_business_glossary_term' = 'Position - Custodial Account Id');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Position - Instrument Id');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Creation Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `income_earned_ytd` SET TAGS ('dbx_business_glossary_term' = 'Income Earned Year-to-Date');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Position Quantity');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Restriction Code');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Relief Method');
ALTER TABLE `banking_ecm`.`account`.`account_position` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain/Loss');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` SET TAGS ('dbx_association_edges' = 'account.deposit_account,collateral.collateral_asset');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `account_collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'account_collateral_pledge Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `asset_collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge - Collateral Asset Id');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge - Deposit Account Id');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `lien_priority` SET TAGS ('dbx_business_glossary_term' = 'Lien Priority');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `pledge_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Reference');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `pledge_amount` SET TAGS ('dbx_business_glossary_term' = 'Pledge Amount');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Date');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `banking_ecm`.`account`.`account_collateral_pledge` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` SET TAGS ('dbx_association_edges' = 'account.certificate_of_deposit,wealth.managed_portfolio');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `account_portfolio_holding_id` SET TAGS ('dbx_business_glossary_term' = 'account_portfolio_holding Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `certificate_of_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Holding - Certificate Of Deposit Id');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Holding - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `wealth_portfolio_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Holding Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `holding_classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Classification');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Status');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain/Loss');
ALTER TABLE `banking_ecm`.`account`.`account_portfolio_holding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` SET TAGS ('dbx_association_edges' = 'account.custodial_account,investment.mandate');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `custody_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Mandate Identifier');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `custodial_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Mandate - Custodial Account Id');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Mandate - Mandate Id');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `arrangement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement End Date');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `arrangement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Start Date');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `asset_types_held` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Classification');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatories');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `custody_role` SET TAGS ('dbx_business_glossary_term' = 'Custody Role Type');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Basis');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation Description');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Asset Segregation Requirement');
ALTER TABLE `banking_ecm`.`account`.`custody_mandate` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` SET TAGS ('dbx_association_edges' = 'account.custodial_account,collateral.pledge');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `account_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'account_pledge Identifier');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Account Pledge - Pledge Id');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `custodial_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Pledge - Custodial Account Id');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `account_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Account Contribution Percentage');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `account_pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Account Pledge Status');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Effective Date');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `pledged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pledged Quantity');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `substitution_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Date');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `substitution_rights` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rights');
ALTER TABLE `banking_ecm`.`account`.`account_pledge` ALTER COLUMN `valuation_at_pledge` SET TAGS ('dbx_business_glossary_term' = 'Valuation at Pledge');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` SET TAGS ('dbx_association_edges' = 'account.deposit_account,channel.channel');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `channel_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Channel Enrollment ID');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Account Channel Enrollment - Banking Channel Id');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Channel Enrollment - Deposit Account Id');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolled By User ID');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `channel_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Channel Flag');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `transaction_limit_override` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Override');
ALTER TABLE `banking_ecm`.`account`.`channel_enrollment` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` SET TAGS ('dbx_association_edges' = 'account.deposit_account,channel.relationship_manager');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `rm_account_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'RM Account Assignment Identifier');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Rm Account Assignment - Channel Relationship Manager Id');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Rm Account Assignment - Deposit Account Id');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `aum_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'AUM at Assignment');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `handoff_notes` SET TAGS ('dbx_business_glossary_term' = 'Handoff Notes');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `lob_context` SET TAGS ('dbx_business_glossary_term' = 'Line of Business Context');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attributed');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `rm_account_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `service_model` SET TAGS ('dbx_business_glossary_term' = 'Service Model');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updater');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `banking_ecm`.`account`.`rm_account_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
