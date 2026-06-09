-- Schema for Domain: account | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`account` COMMENT 'Authoritative registry of all deposit and transactional accounts including DDA, savings, money market, certificates of deposit, and custodial accounts. Manages account lifecycle, balance tracking, interest accrual parameters, IBAN/BIC assignment, account-level limits, and statement generation. Core system of record aligned with Temenos T24 / FIS Profile.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`account`.`deposit_account` (
    `deposit_account_id` BIGINT COMMENT 'Unique system identifier for the deposit account. Primary key.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Every deposit account has a branch of record for regulatory reporting (FDIC call reports), customer service routing, and branch performance attribution. Core banking operational requirement. Removes d',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Deposit accounts are assigned to cost centers for FTP (funds transfer pricing) and management accounting. Banking profitability reporting, branch P&L, and Basel business line reporting all require cos',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for the account denomination (e.g., USD, EUR, GBP).',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Unclaimed property escheatment laws are jurisdiction-specific; banks must file dormant account funds with the correct state/jurisdiction authority. The escheatment_jurisdiction plain-text column is a ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Every deposit account must map to a GL account for balance sheet reporting, regulatory call reports (FFIEC 031/041), and financial statement preparation. This is the fundamental subledger-to-GL link i',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: The BIC on a deposit account identifies the booking institution/branch for SWIFT messaging, correspondent banking setup, and SEPA payment routing. The plain bic column is a denormalized string; a FK t',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Negotiable certificates of deposit (CDs) and structured deposits are registered securities with ISINs/CUSIPs. Banking operations require this link for secondary market trading of CDs, ISIN-based settl',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Deposit accounts must be assigned to a legal entity for FDIC insurance reporting, CRS/FATCA regulatory reporting, consolidated financial statements, and resolution planning (living wills). Regulators ',
    `onboarding_case_id` BIGINT COMMENT 'Foreign key linking to customer.onboarding_case. Business justification: Account opening audit trail and regulatory onboarding compliance: banks must trace every deposit account back to the onboarding case that originated it for SLA reporting, complaint handling, and regul',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Every deposit account is classified under a product type (checking, savings, CD, money market) governing fee schedules, CECL portfolio segments, regulatory reporting categories, and KYC requirement le',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Deposit accounts are attributed to profit centers for P&L reporting, RAROC calculation, and segment reporting (IFRS 8). Banking management reporting requires profit center assignment at account level ',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Each deposit account is a source record in the deposit subledger. Banking core accounting architecture requires deposit accounts to reference their subledger for subledger-to-GL reconciliation, regula',
    `account_number` STRING COMMENT 'Externally visible account number assigned to the deposit account. Used for customer-facing transactions and statements.. Valid values are `^[0-9]{10,16}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the deposit account. Frozen indicates regulatory or legal hold; dormant indicates no customer-initiated activity within the dormancy period.. Valid values are `active|dormant|closed|frozen|restricted|pending_opening`',
    `account_type` STRING COMMENT 'Classification of the deposit account product type. DDA = Demand Deposit Account (checking), NOW = Negotiable Order of Withdrawal.. Valid values are `DDA|savings|money_market|NOW|certificate_of_deposit|custodial`',
    `aml_risk_rating` STRING COMMENT 'AML risk classification assigned to the account based on customer profile, transaction patterns, and geographic factors.. Valid values are `low|medium|high|prohibited`',
    `amount_escheated` DECIMAL(18,2) COMMENT 'Total amount remitted to the state as unclaimed property. Null if not yet escheated.',
    `atm_withdrawal_limit` DECIMAL(18,2) COMMENT 'Maximum amount that can be withdrawn via ATM in a single transaction or calendar day.',
    `available_balance` DECIMAL(18,2) COMMENT 'Available balance for withdrawal or transfer, accounting for holds, pending transactions, and overdraft limits.',
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
    `fatca_status` STRING COMMENT 'FATCA compliance status for foreign account tax reporting requirements.. Valid values are `compliant|non_compliant|exempt|not_applicable`',
    `fdic_coverage_category` STRING COMMENT 'FDIC insurance coverage category determining the insurance limit applicable to this account. [ENUM-REF-CANDIDATE: single|joint|revocable_trust|irrevocable_trust|employee_benefit|corporation|government — 7 candidates stripped; promote to reference product]',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether the account is covered by FDIC deposit insurance.',
    `iban` STRING COMMENT 'International Bank Account Number for cross-border payment identification and routing.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `interest_accrual_method` STRING COMMENT 'Method by which interest is calculated and accrued on the account balance.. Valid values are `daily|monthly|quarterly|simple|compound`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Current annual interest rate applied to the account balance, expressed as a decimal (e.g., 0.02500 for 2.5%).',
    `last_activity_date` DATE COMMENT 'Date of the most recent customer-initiated transaction or activity on the account. Used for dormancy tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the deposit account record was last updated.',
    `last_statement_date` DATE COMMENT 'Date of the most recent account statement generated for this account.',
    `opening_date` DATE COMMENT 'Date the deposit account was officially opened and became active for transactions.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'Maximum approved overdraft amount for the account. Zero or null indicates no overdraft facility.',
    `overdraft_opt_in_status` STRING COMMENT 'Customer election status for overdraft coverage on ATM and one-time debit card transactions, as required by Regulation E.. Valid values are `opted_in|opted_out|not_applicable`',
    `overdraft_protection_source` STRING COMMENT 'Source of funds for overdraft protection, if configured. Indicates the linked account or credit facility used to cover overdrafts.. Valid values are `none|linked_savings|line_of_credit|credit_card`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the deposit account. [ENUM-REF-CANDIDATE: individual|joint|corporate|trust|estate|custodial|government — 7 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'Federal Reserve regulatory classification for reserve requirement and reporting purposes.. Valid values are `transaction_account|savings_deposit|time_deposit`',
    `statement_cycle` STRING COMMENT 'Frequency at which account statements are generated and delivered to the account holder.. Valid values are `monthly|quarterly|annually|on_demand`',
    `tax_reporting_status` STRING COMMENT 'Tax reporting classification for IRS Form 1099-INT reporting and FATCA compliance.. Valid values are `US_person|foreign_person|exempt|pending`',
    CONSTRAINT pk_deposit_account PRIMARY KEY(`deposit_account_id`)
) COMMENT 'Authoritative master record for all deposit and transactional accounts including DDA (Demand Deposit Accounts), savings, money market, and NOW accounts. Captures account number, IBAN, BIC, currency, branch/sort code, opening date, account status (active, dormant, closed, frozen), ownership type, and product reference. Includes embedded child record sets for: (1) overdraft facility configuration — approved limit, linked protection source, transfer fee, opt-in/opt-out status per Reg E, utilization tracking; (2) account-level operational limits — daily withdrawal, transfer, ATM, wire, ACH debit limits with approval authority and override flags; (3) dormancy and escheatment tracking — last activity date, dormancy classification date, dormancy period, state escheatment threshold, outreach log, escheatment filing date, amount escheated, jurisdiction; (4) document registry — signature cards, account agreements, beneficial ownership certifications, W-9/W-8BEN, POA, court orders with version, status, and storage reference; (5) immutable status transition history — previous/new status, effective datetime, reason code, initiating channel, authorizing officer. Interest accrual method, compounding frequency, statement cycle, and regulatory classification round out the record. Core system-of-record entity aligned with Temenos T24 ACCOUNT.ARRANGEMENT / FIS Profile deposit module.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the account holder association record. Primary key.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit onboarding and account opening require linking each account holder to their counterparty credit rating for overdraft approval, credit limit setting, and IFRS9 PD assignment. A banking credit an',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit, certificate of deposit (CD), or custodial account to which this holder relationship applies. Links to the account domain.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Account holders undergo KYC reviews; the holder records kyc_verification_date, kyc_verification_status, and kyc_next_review_date are denormalized from the kyc_review record. Linking holder to the gov',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: KYC/AML regulations require documenting the channel through which a holder relationship (ownership, beneficiary designation) was established. CDD rules mandate recording how customer identity was veri',
    `party_id` BIGINT COMMENT 'Reference to the individual or legal entity (from customer domain) who holds rights or interests in the account. Links to the customer master.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: CRS (OECD Common Reporting Standard) and FATCA require banks to identify and report account holders by their country of tax residence. This FK is a direct regulatory mandate — without it, automated CR',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Daily subledger-to-GL reconciliation is a core banking control: the deposit subledger balance must tie to the GL account balance. Regulators (OCC, Fed) require documented reconciliation. This direct F',
    `statement_id` BIGINT COMMENT 'Foreign key linking to account.statement. Business justification: Daily balance snapshots are associated with a specific statement cycle. Adding balance.statement_id → statement.statement_id links each balance record to the statement period it belongs to, normalizin',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Balance snapshots are the source records for the deposit subledger. Banking subledger reconciliation processes require direct linkage between balance records and their subledger to support period-end ',
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
    `uninsured_amount` DECIMAL(18,2) COMMENT 'The portion of the account balance that exceeds FDIC insurance limits and is therefore at risk in the event of bank failure. Used for depositor risk disclosure and liquidity stress testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this balance snapshot record was last modified in the data lakehouse silver layer. Used for change tracking and audit trail purposes.',
    CONSTRAINT pk_balance PRIMARY KEY(`balance_id`)
) COMMENT 'Daily snapshot of account balance positions including ledger balance, available balance, collected balance, float balance, and hold balance. Tracks as-of date, currency, overdraft utilization, minimum balance threshold breach flag, average daily balance for the statement period, and interest-bearing balance. Used for NIM calculation, reserve requirement compliance (Reg D), and FDIC insurance limit monitoring. Sourced from Temenos T24 end-of-day balance file.';

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`account_transaction` (
    `account_transaction_id` BIGINT COMMENT 'Unique identifier for the account transaction record. Primary key for the account transaction entity.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Every transaction occurs through a specific channel for fraud detection, AML monitoring (CTR/SAR reporting), channel analytics, and customer behavior analysis. Essential for BSA/AML compliance and ope',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Corporate actions (dividends, mergers, rights issues) generate cash credits/debits in deposit accounts. Operations teams require this link for corporate action cash settlement reconciliation, client e',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Wire transfers and cross-border payments require counterparty bank BIC validation against the SWIFT BIC directory for routing, correspondent banking identification, and AML screening. The counterparty',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Internal transfers between customer accounts require counterparty identification for AML transaction monitoring, related-party transaction detection, and regulatory reporting (CTR, SAR). When counterp',
    `ctr_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.ctr_filing. Business justification: BSA/CTR compliance requires linking specific cash transactions over $10,000 to the CTR filing submitted to FinCEN. The ctr_reportable_flag on account_transaction signals this relationship. Compliance ',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the transaction amount is denominated.',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the deposit or transactional account to which this transaction was posted. Links to the authoritative account registry.',
    `disbursement_id` BIGINT COMMENT 'Foreign key linking to loan.disbursement. Business justification: Loan disbursements settle as credit transactions on the destination deposit account. Payment operations must link the account credit posting to the specific disbursement record for settlement confirma',
    `drawdown_id` BIGINT COMMENT 'Foreign key linking to loan.drawdown. Business justification: A loan drawdown credits the borrowers deposit account, generating an account_transaction. Operations and treasury teams reconcile the credit posting to the specific drawdown event for funding confirm',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Multi-currency transactions require traceability to the specific exchange rate record used for audit, regulatory reporting, and GL revaluation. The plain exchange_rate column is a denormalized rate va',
    `fx_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.fx_transaction. Business justification: Cross-currency account postings originate from FX transactions. FX P&L reporting, regulatory FX transaction reporting, and reconciliation of cross-currency entries require linking the account posting ',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.instruction. Business justification: Payment instruction execution (wire, ACH, SWIFT) generates the account debit/credit posting. Reconciliation, SWIFT gpi audit trails, and AML transaction monitoring require joining account postings to ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities settlement generates cash-leg account transactions (bond purchase debits, coupon credits, dividend payments). Banking operations require linking the cash account transaction to the security',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Cross-border wire payments and SWIFT transactions recorded in account_transaction are settled through a specific nostro account. Operations and reconciliation teams must link each international transa',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Digital fraud investigation and Reg E dispute resolution require linking a transaction to the authenticated session that initiated it (device fingerprint, IP, auth level). AML transaction monitoring u',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Account posting and payment network execution are two sides of the same event. Reg E error resolution, operations reconciliation, and settlement reporting require directly joining the account ledger e',
    `repayment_id` BIGINT COMMENT 'Foreign key linking to loan.repayment. Business justification: Loan repayments generate debit transactions on the borrowers deposit account. Payment operations and reconciliation teams must match each account debit to the specific loan repayment record for excep',
    `reversed_transaction_account_transaction_id` BIGINT COMMENT 'Reference to the original account transaction ID that this transaction reverses. Null if this is not a reversal transaction.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Wire transfers and ACH transactions are screened against OFAC/sanctions lists at execution. The specific sanctions screening event for a transaction must be traceable for regulatory examination and bl',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.settlement_instruction. Business justification: An account debit/credit transaction is the cash leg of a trade settlement instruction. Linking account_transaction to settlement_instruction enables CSDR settlement reconciliation, fail reporting, and',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to account.standing_order. Business justification: Recurring payment executions driven by standing orders generate account_transaction records. Linking account_transaction.standing_order_id → standing_order.standing_order_id allows tracing each transa',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Account transactions are the source documents feeding the deposit subledger. Banking subledger architecture requires transactions to reference their subledger for transaction-level reconciliation, aud',
    `ach_trace_number` STRING COMMENT '15-digit trace number assigned to ACH transactions for tracking and reconciliation purposes. Null for non-ACH transactions.',
    `aml_alert_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this transaction triggered an AML alert requiring investigation. True if alert generated, False otherwise.',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the AML transaction monitoring system indicating the likelihood of money laundering or suspicious activity. Higher scores trigger enhanced review.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the transaction in the accounts base currency. Positive for credits, negative for debits per accounting convention.',
    `balance_after_transaction` DECIMAL(18,2) COMMENT 'The running account balance immediately after this transaction was posted. Used for statement generation and overdraft detection.',
    `branch_code` STRING COMMENT 'The code of the branch or business unit where the transaction was initiated or processed. Used for profitability analysis and operational reporting.',
    `card_authorization_code` STRING COMMENT 'Authorization code returned by the card network for approved card transactions. Null for non-card transactions.',
    `counterparty_account_number` STRING COMMENT 'The account number of the counterparty (originator or beneficiary) involved in the transaction. May be an internal account, external IBAN, or card number depending on transaction type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first created in the core banking system. Used for audit trail and data lineage tracking.',
    `ctr_reportable_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this transaction meets the threshold for Currency Transaction Report filing with FinCEN (typically cash transactions over $10,000).',
    `fee_amount` DECIMAL(18,2) COMMENT 'The amount of any fee charged in association with this transaction (e.g., overdraft fee, wire transfer fee, ATM surcharge). Zero if no fee applies.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this transaction posts for financial accounting and regulatory reporting purposes.',
    `hold_amount` DECIMAL(18,2) COMMENT 'The amount of funds placed on hold or reserved as a result of this transaction (e.g., check hold, card authorization hold). Null if no hold applies.',
    `hold_release_date` DATE COMMENT 'The date on which any hold placed by this transaction will be released and funds will become available. Null if no hold applies.',
    `interest_amount` DECIMAL(18,2) COMMENT 'The amount of interest credited or debited as part of this transaction. Applicable for interest accrual postings on deposit accounts. Zero if not an interest transaction.',
    `merchant_category_code` STRING COMMENT 'Four-digit ISO 18245 code classifying the type of merchant or service provider for card transactions. Used for spend analytics and rewards program eligibility.. Valid values are `^[0-9]{4}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified or updated. Used for change tracking and audit purposes.',
    `narrative` STRING COMMENT 'Free-text description or memo field providing additional context about the transaction purpose, merchant name, or customer-entered notes. Appears on account statements.',
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
    `interest_rate_id` BIGINT COMMENT 'Foreign key linking to account.interest_rate. Business justification: A periodic account statement captures the interest rate in effect during the statement cycle. Adding interest_rate_id FK links the statement to the authoritative interest_rate record, normalizing the ',
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
    `benchmark_rate_fixing_id` BIGINT COMMENT 'Foreign key linking to reference.benchmark_rate_fixing. Business justification: Variable-rate deposit accruals (SOFR-linked, post-IBOR transition) must trace the specific daily benchmark fixing used in each calculation for audit, IBOR transition compliance (ISDA protocols), and r',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the account and all monetary amounts in this accrual record (e.g., USD, EUR, GBP). All amounts are denominated in this currency.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account for which interest is being accrued. Links to the core account master registry.',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Interest accrual calculations for deposit accounts require the applicable FTP rate to compute NIM contribution and transfer pricing charges. ALCO and finance teams use the accrual-level FTP rate refer',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: IFRS/GAAP interest income recognition requires direct mapping of accruals to the income GL account. Banking accrual accounting and regulatory income reporting (FINREP, Call Report) depend on this GL a',
    `interest_rate_id` BIGINT COMMENT 'Foreign key linking to account.interest_rate. Business justification: Each daily interest accrual record is computed using a specific interest rate configuration defined in interest_rate. Adding interest_rate_id FK normalizes the denormalized applicable_interest_rate an',
    `party_id` BIGINT COMMENT 'Reference to the customer who owns the account. Used for customer-level interest income reporting, tax reporting, and regulatory disclosures.',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Interest accruals feed the interest income/expense subledger. Banking month-end close requires accrual-to-subledger reconciliation to validate that all accrued interest is captured in the subledger be',
    `accrual_basis_code` STRING COMMENT 'Day count convention used to calculate interest accrual. Determines how days are counted in the numerator and denominator of the interest calculation formula. ACT/360 is common for money market accounts, ACT/365 for savings, 30/360 for certain time deposits.. Valid values are `ACT/360|ACT/365|30/360|ACT/ACT|30/365`',
    `accrual_date` DATE COMMENT 'The business date on which this interest accrual calculation was performed. Represents the principal business event timestamp for this daily accrual record.',
    `accrual_method` STRING COMMENT 'The mathematical method used to calculate interest accrual. Simple interest is calculated on principal only; compound interest includes previously accrued interest in the calculation base; continuous uses exponential compounding.. Valid values are `simple|compound|continuous`',
    `accrual_reversal_reason` STRING COMMENT 'Code or description explaining why this accrual was reversed, if applicable. Common reasons include account closure, rate correction, system error, or NPL (Non-Performing Loan) classification requiring accrual suspension.',
    `accrual_status` STRING COMMENT 'Current lifecycle status of this accrual record. Calculated indicates daily accrual computed but not yet posted; posted indicates interest has been capitalized to account; reversed indicates accrual was backed out; suspended indicates accrual is on hold (e.g., for NPL accounts).. Valid values are `calculated|posted|reversed|suspended|pending_review`',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'The interest amount accrued for this specific accrual date, calculated as (principal_balance × applicable_interest_rate × days) / day_count_basis. This is the daily interest increment.',
    `branch_code` STRING COMMENT 'The branch or business unit code responsible for this account and its interest accrual. Used for profitability analysis, FTP (Funds Transfer Pricing), and management reporting.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The system timestamp when this interest accrual calculation was performed. Used for audit trail and to distinguish between batch calculation runs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accrual record was first created in the system. Represents the record audit trail creation point.',
    `cumulative_accrued_interest` DECIMAL(18,2) COMMENT 'The total interest accrued from the last interest posting date through the current accrual date. Represents the running total of unpaid accrued interest for the current interest period.',
    `days_in_period` STRING COMMENT 'The number of days used in the numerator of the interest calculation for this accrual date. Typically 1 for daily accrual, but may vary based on accrual basis and calendar adjustments.',
    `interest_payable_gl_account` STRING COMMENT 'The general ledger account code for the accrued interest payable liability. Represents the contra-account for the interest expense accrual until interest is posted to the customer account.',
    `interest_posting_frequency` STRING COMMENT 'The frequency at which accrued interest is capitalized and posted to the account balance. Defines the cadence of interest payment or compounding per the account product terms. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi-annually|annually|at_maturity — 7 candidates stripped; promote to reference product]',
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
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Fees assessed against deposit accounts (overdraft fees, NSF fees, etc.) are typically triggered by or directly associated with a specific account_transaction. Adding account_transaction_id FK links th',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fee assessments are tied to accounting periods for revenue recognition, financial reporting, and regulatory compliance. This supports period-based revenue accounting and financial close processes.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the fee amount. Typically matches the accounts base currency.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account against which this fee was assessed. Links to the core banking account master.',
    `case_id` BIGINT COMMENT 'Reference to the customer dispute case or complaint ticket associated with this fee, if applicable. Used for tracking dispute resolution.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Fee assessments generate journal entries for revenue recognition (DR Fee Receivable/Account, CR Fee Revenue). This links the fee subledger to GL for financial reporting and revenue accounting.',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Fee income feeds the fee revenue subledger. Banking revenue recognition (ASC 606) and period-end close require fee records to be traceable to their subledger for completeness testing, revenue reconcil',
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
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Funds holds are frequently placed in response to a specific account transaction (e.g., a check deposit triggers a Regulation CC hold, a wire receipt triggers a compliance hold). Linking hold.account_t',
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: Account holds are frequently placed automatically or manually in response to a fraud alert (e.g., card compromise, suspicious transaction). Reg E compliance and fraud operations audit trails require t',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the hold amount. Must match the account base currency in most cases, but may differ for foreign exchange holds or multi-currency accounts.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account on which the hold is placed. Links to the core banking system account master.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Legal and investigative holds are placed on accounts as a direct result of an active fraud case (e.g., court-ordered freeze, investigative hold). Fraud case management and legal hold tracking require ',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.instruction. Business justification: Large-value or cross-border payment instructions trigger compliance and settlement holds on deposit accounts pending OFAC screening or settlement confirmation. Hold management workflows and sanctions ',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: When a borrower defaults or breaches covenants, the bank places a hold on their deposit account linked to the defaulted loan account. Collections and workout teams require this link to manage set-off ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Legal and regulatory holds are placed through specific channels for compliance audit trails, dispute resolution, and fraud investigation documentation. Required for regulatory examinations and litigat',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Pledge-driven account holds: when a deposit account is pledged as collateral, a hold is placed on the account for the pledged amount. The hold record must reference the collateral_pledge to enforce th',
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
    `credit_application_id` BIGINT COMMENT 'Foreign key linking to loan.credit_application. Business justification: Every overdraft facility is approved through a credit underwriting process. Linking overdraft_facility to its originating credit_application supports audit trails, regulatory reporting (BCBS 239 data ',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Each approved overdraft facility is a committed credit exposure requiring Basel III credit conversion factor treatment and IFRS9 EAD measurement. Risk teams must directly reference the credit_exposure',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the overdraft facility limit and fees (e.g., USD, EUR, GBP).',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Overdraft facilities are governed by approved credit facility agreements. Credit risk and regulatory capital teams (Basel III) must trace overdraft exposure back to the originating credit facility for',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Overdraft facilities carry a separate GL account for the committed credit line (distinct from the deposit account GL) required for off-balance-sheet commitment reporting, Basel III credit conversion f',
    `interest_rate_id` BIGINT COMMENT 'Foreign key linking to account.interest_rate. Business justification: Overdraft facilities carry an associated interest rate charged on utilized overdraft balances. Adding overdraft_facility.interest_rate_id → interest_rate.interest_rate_id links the facility to the aut',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fair lending and channel profitability reporting require knowing which channel originated an overdraft facility. Regulators (CFPB, OCC) analyze whether overdraft opt-in rates differ by channel. Produc',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Credit risk and Basel regulatory capital: overdraft facilities are credit exposures requiring direct obligor (party) identification for single-counterparty exposure limits, credit risk reporting, and ',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account (DDA, savings, money market) to which this overdraft facility is attached.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Overdraft facilities are distinct credit products with specific Basel RWA treatment, CECL portfolio segment classification, and fee schedule types defined in product_type. Regulatory capital reporting',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Overdraft facility approved_limit_amount must not exceed the governing risk limit. Credit governance requires each facility to reference its authorizing risk limit for breach monitoring, limit utiliza',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Secured overdraft facilities: an overdraft line secured by a formal pledge agreement requires the facility to reference the specific collateral_pledge (legal instrument), distinct from the collateral_',
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
    `facility_type` STRING COMMENT 'Classification of the overdraft protection arrangement: standard (bank covers overdraft with fee), premium (enhanced coverage), linked to savings account, linked to line of credit, or linked to credit card.. Valid values are `standard|premium|linked_savings|linked_credit_line|linked_credit_card`',
    `grace_period_days` STRING COMMENT 'Number of days the customer has to repay the overdraft balance before fees or interest are applied. Zero if no grace period applies.',
    `interest_calculation_method` STRING COMMENT 'Method used to calculate interest on the overdraft balance: daily balance, average daily balance, simple interest, compound interest, or none if no interest applies.. Valid values are `daily_balance|average_daily_balance|simple|compound|none`',
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
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the limit amount is denominated (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit or transactional account to which this limit applies. Links to the account master registry.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Account limits (transaction limits, withdrawal limits) are often mandated by specific regulatory obligations (e.g., CFPB rules, BSA thresholds). The account_limit.regulatory_mandate_code is a denormal',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Operational account limits (daily withdrawal, transfer caps) are cascaded from risk appetite framework risk limits. Linking account_limit to its governing risk_limit enables limit hierarchy traceabili',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud investigation and audit trails require knowing which channel set or last modified an account limit (ATM withdrawal cap, transfer limit). When a limit override precedes a fraud event, investigato',
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
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Account status changes (freeze, restriction, closure) are frequently triggered by AML investigations. The status_history has aml_review_required_flag and compliance_hold_flag indicating this relations',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account that experienced the status transition. Links to the authoritative account registry in the core banking system.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: Account status changes (freeze, block, restriction) are frequently triggered by fraud cases. Audit trails, regulatory examinations, and fraud operations reviews require linking each status transition ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: BSA/AML and internal audit require tracing which channel initiated an account status change (freeze, dormancy, closure). Regulators expect this audit trail for suspicious activity investigations. ini',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: AML/compliance audit trail: account status changes (freeze, restriction, dormancy) triggered by KYC findings must be traceable to the specific KYC record that caused the action. Regulators and examine',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Account status changes triggered by OFAC/sanctions matches (e.g., account blocked, funds frozen) must reference the specific sanctions screening event for regulatory reporting and OFAC examination. Co',
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
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Floating-rate deposit pricing and FTP calculations require linking deposit interest rates to the full security-domain benchmark entity (SOFR, EURIBOR). The existing rate_benchmark_id targets a referen',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account to which this interest rate configuration applies.',
    `rate_benchmark_id` BIGINT COMMENT 'The market benchmark index to which variable rates are tied. SOFR (Secured Overnight Financing Rate), FED_FUNDS (Federal Funds Rate), PRIME (Prime Rate), LIBOR (London Interbank Offered Rate - legacy), TREASURY (US Treasury Rate), or NONE for fixed rates.',
    `superseded_by_rate_interest_rate_id` BIGINT COMMENT 'Reference to the account_interest_rate_id that supersedes this rate configuration. Used to maintain rate change history and audit trail.',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Deposit interest rates and FTP rates are derived from yield curves for ALM, transfer pricing, and IRRBB regulatory capital calculations. A banking domain expert expects interest_rate.yield_curve_id → ',
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

CREATE OR REPLACE TABLE `banking_ecm`.`account`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order. Primary key for the standing order entity.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Recurring payment instructions (standing orders) reference a beneficiary bank that must be validated against the SWIFT BIC directory for SEPA, SWIFT, and domestic payment routing. The beneficiary_bank',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Recurring payments to internal beneficiaries (customer-to-customer) require beneficiary validation, AML screening, and pre-population of beneficiary details from party master. Enables detection of pay',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for the transfer amount. Defines the currency in which the standing order is denominated.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit account from which the standing order will debit funds. Links to the source account in the core banking system.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Standing orders with business_day_adjustment logic require a specific holiday calendar to determine valid execution dates. The calendar governs next_execution_date calculation for SEPA and domestic pa',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Regular savings and investment plans use standing orders to transfer funds into a managed portfolios cash account. Wealth operations require this link to track which portfolio a standing order funds,',
    `payment_channel_id` BIGINT COMMENT 'Foreign key linking to payment.payment_channel. Business justification: Standing orders execute via specific payment channels (BACS, SEPA, ACH). Channel-specific routing, SLA management, cutoff time enforcement, and fee calculation for recurring payments require a proper ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Standing order setup channel is tracked for fraud prevention, customer authentication verification, and service quality monitoring. Required for dispute resolution and regulatory compliance audits. Re',
    `aml_screening_status` STRING COMMENT 'Result of AML and sanctions screening for the standing order beneficiary and transaction pattern. Flagged or blocked orders require compliance review before execution.. Valid values are `cleared|pending|flagged|blocked`',
    `aml_screening_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent AML and sanctions screening for this standing order. Screening is typically performed at setup and periodically thereafter.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the standing order setup or modification required managerial or compliance approval due to amount thresholds, risk profile, or regulatory requirements. True if approval was required.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the standing order was approved by the designated authority. Null if no approval was required.',
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
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Direct debit mandates are the primary mechanism for automatic loan repayment collection (SEPA Direct Debit, ACH). Collections teams must identify which loan account a mandate services for mandate mana',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Regular investment contribution plans use direct debit mandates to fund managed portfolios. Wealth operations must identify which portfolio a mandate funds for contribution processing, AML screening, ',
    `party_id` BIGINT COMMENT 'The NACHA company identification number assigned to the third-party originator authorized to initiate debits.',
    `payment_channel_id` BIGINT COMMENT 'Foreign key linking to payment.payment_channel. Business justification: Direct debit mandates are scheme-specific (SEPA Core, BACS, NACHA ACH). Regulatory compliance (SEPA mandate rules, NACHA operating rules), routing, return window enforcement, and fee calculation requi',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Direct debit mandates require OFAC screening of originators/creditors at setup and periodic refresh per sanctions compliance requirements. Links mandate to screening results for blocking decisions, re',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`account`.`holder` ADD CONSTRAINT `fk_account_holder_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`balance` ADD CONSTRAINT `fk_account_balance_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `banking_ecm`.`account`.`statement`(`statement_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_reversed_transaction_account_transaction_id` FOREIGN KEY (`reversed_transaction_account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ADD CONSTRAINT `fk_account_account_transaction_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `banking_ecm`.`account`.`standing_order`(`standing_order_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`statement` ADD CONSTRAINT `fk_account_statement_interest_rate_id` FOREIGN KEY (`interest_rate_id`) REFERENCES `banking_ecm`.`account`.`interest_rate`(`interest_rate_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ADD CONSTRAINT `fk_account_interest_accrual_interest_rate_id` FOREIGN KEY (`interest_rate_id`) REFERENCES `banking_ecm`.`account`.`interest_rate`(`interest_rate_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`account`.`account_fee` ADD CONSTRAINT `fk_account_account_fee_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_account_transaction_id` FOREIGN KEY (`account_transaction_id`) REFERENCES `banking_ecm`.`account`.`account_transaction`(`account_transaction_id`);
ALTER TABLE `banking_ecm`.`account`.`hold` ADD CONSTRAINT `fk_account_hold_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_interest_rate_id` FOREIGN KEY (`interest_rate_id`) REFERENCES `banking_ecm`.`account`.`interest_rate`(`interest_rate_id`);
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ADD CONSTRAINT `fk_account_overdraft_facility_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`account_limit` ADD CONSTRAINT `fk_account_account_limit_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`status_history` ADD CONSTRAINT `fk_account_status_history_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ADD CONSTRAINT `fk_account_interest_rate_superseded_by_rate_interest_rate_id` FOREIGN KEY (`superseded_by_rate_interest_rate_id`) REFERENCES `banking_ecm`.`account`.`interest_rate`(`interest_rate_id`);
ALTER TABLE `banking_ecm`.`account`.`standing_order` ADD CONSTRAINT `fk_account_standing_order_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ADD CONSTRAINT `fk_account_direct_debit_mandate_deposit_account_id` FOREIGN KEY (`deposit_account_id`) REFERENCES `banking_ecm`.`account`.`deposit_account`(`deposit_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`account` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`account` SET TAGS ('dbx_domain' = 'account');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Institution Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'transaction_account|savings_deposit|time_deposit');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `statement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `statement_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Status');
ALTER TABLE `banking_ecm`.`account`.`deposit_account` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_value_regex' = 'US_person|foreign_person|exempt|pending');
ALTER TABLE `banking_ecm`.`account`.`holder` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`account`.`holder` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`account`.`holder` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Country Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `uninsured_amount` SET TAGS ('dbx_business_glossary_term' = 'Uninsured Amount');
ALTER TABLE `banking_ecm`.`account`.`balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `ctr_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ctr Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `drawdown_id` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `fx_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `repayment_id` SET TAGS ('dbx_business_glossary_term' = 'Repayment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `reversed_transaction_account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `aml_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Alert Flag');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `balance_after_transaction` SET TAGS ('dbx_business_glossary_term' = 'Balance After Transaction');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `card_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Card Authorization Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `ctr_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Currency Transaction Report (CTR) Reportable Flag');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`account`.`account_transaction` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Transaction Narrative');
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
ALTER TABLE `banking_ecm`.`account`.`statement` ALTER COLUMN `interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `benchmark_rate_fixing_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Fixing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Income Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Basis Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_basis_code` SET TAGS ('dbx_value_regex' = 'ACT/360|ACT/365|30/360|ACT/ACT|30/365');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Date');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'simple|compound|continuous');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Reason Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Status');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'calculated|posted|reversed|suspended|pending_review');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `cumulative_accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Days in Accrual Period');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_payable_gl_account` SET TAGS ('dbx_business_glossary_term' = 'Interest Payable General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`account`.`interest_accrual` ALTER COLUMN `interest_posting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Posting Frequency');
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
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_fee` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Currency Code');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Placing Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`hold` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `overdraft_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `credit_application_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Securing Collateral Pledge Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Facility Type');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'standard|premium|linked_savings|linked_credit_line|linked_credit_card');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `banking_ecm`.`account`.`overdraft_facility` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'daily_balance|average_daily_balance|simple|compound|none');
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
ALTER TABLE `banking_ecm`.`account`.`account_limit` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `account_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Account Limit Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`account_limit` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Setting Channel Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`status_history` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`interest_rate` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Account Interest Rate ID');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `superseded_by_rate_interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `banking_ecm`.`account`.`interest_rate` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`account`.`standing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`account`.`standing_order` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Identifier');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Setup Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|blocked');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `aml_screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Timestamp');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`account`.`standing_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
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
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `direct_debit_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Debit Mandate Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Originator Company Identifier');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`account`.`direct_debit_mandate` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
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
