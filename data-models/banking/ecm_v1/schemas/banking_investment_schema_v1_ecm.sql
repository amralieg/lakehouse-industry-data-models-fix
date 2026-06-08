-- Schema for Domain: investment | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`investment` COMMENT 'Investment banking advisory services including M&A, IPO underwriting, DCF valuation, debt and equity capital markets origination, syndicated lending mandates, and corporate finance. Manages deal pipelines, pitch books, mandate agreements, transaction structures, fee arrangements, and tombstone records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`deal` (
    `deal_id` BIGINT COMMENT 'Unique surrogate identifier for the investment banking deal or transaction mandate. Primary key for the deal entity, referenced by all downstream investment domain entities including mandate, valuation, offering, syndication, tombstone, and fee arrangement.',
    `alco_meeting_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_meeting. Business justification: Significant investment banking deals requiring balance sheet commitment are reviewed and approved by ALCO. Business process: ALCO approval workflow for deals exceeding risk appetite thresholds for cap',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: Large deals impact projected RWA growth and capital consumption in forward capital planning. Business process: capital planning incorporates investment banking pipeline to forecast RWA growth and ensu',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: M&A and LBO deals routinely involve collateral assets as security for acquisition financing or as transaction consideration. Real process: secured financing structures in leveraged buyouts, asset-back',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Deals are attributed to cost centers (coverage teams, product groups) for P&L tracking, resource allocation, banker compensation, and management reporting. Core requirement for segment profitability a',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Deals require counterparty credit ratings for client risk assessment, credit approval workflows, pricing decisions, and regulatory capital allocation. Standard practice in investment banking to link d',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Investment banking deals require FTP rates for profitability analysis and internal pricing of capital allocated to transactions. Real business process: deal economics modeling calculates net revenue a',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Investment banking deals often create or restructure securities (M&A stock consideration, debt refinancing, equity carve-outs). Links deal to resulting instrument for outcome tracking, valuation valid',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Investment banking deals must be booked to specific legal entities for regulatory capital calculation, financial statement consolidation, and tax reporting. Core requirement for Basel III, IFRS 10 con',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Investment deals are originated through specific banking channels (branch, digital, RM). Deal capture systems track origination channel for revenue attribution, channel profitability analysis, and reg',
    `party_id` BIGINT COMMENT 'FK to customer.party.party_id — MUST-HAVE: Investment banking deals must link to the client party for relationship management, conflict checking, and revenue attribution.',
    `pipeline_stage_id` BIGINT COMMENT 'Foreign key linking to investment.pipeline_stage. Business justification: Deal has stage (STRING) attribute that references pipeline stages. Adding FK to pipeline_stage allows retrieval of full stage metadata (stage_name, probability_weighting_pct, average_duration_days, et',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory examiners review deal files during BSA/AML, Reg W, capital markets exams. Deal documentation is primary evidence source. Examiners trace deals to verify compliance with securities laws and ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Investment banking deals require stress testing under CCAR/DFAST regulatory scenarios to assess capital impact, deal viability under adverse conditions, and regulatory approval requirements. Essential',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Industry classification drives sector concentration limits, credit portfolio segmentation, CECL modeling, and league table rankings. Target_industry_sector is denormalized industry name.',
    `employee_id` BIGINT COMMENT 'Identifier of the senior banker or managing director designated as the execution team lead for the deal. May differ from the coverage banker; responsible for day-to-day deal execution and client management during the transaction.',
    `actual_closing_date` DATE COMMENT 'The actual date on which the transaction legally closed and was completed. Populated upon deal closure; used for revenue recognition, tombstone generation, and post-deal performance analysis.',
    `announcement_date` DATE COMMENT 'The date on which the transaction was publicly announced to the market. Relevant for M&A and ECM transactions; triggers regulatory disclosure obligations and market impact analysis.',
    `complexity` STRING COMMENT 'Qualitative assessment of the deals structural and execution complexity, used for resource allocation, staffing decisions, and risk committee escalation thresholds. Assessed at origination and updated as deal structure evolves.. Valid values are `LOW|MEDIUM|HIGH|VERY_HIGH`',
    `confidentiality_level` STRING COMMENT 'Information barrier and confidentiality classification of the deal. STRICTLY_CONFIDENTIAL deals trigger Chinese Wall protocols, restricted list management, and information barrier controls to prevent insider trading.. Valid values are `PUBLIC|INTERNAL|CONFIDENTIAL|STRICTLY_CONFIDENTIAL`',
    `counterparty_name` STRING COMMENT 'Name of the counterparty in the transaction (e.g., target company in M&A buy-side, acquirer in sell-side, co-underwriter in ECM/DCM). Stored as a descriptive field for deal context; may not yet be a registered client in the CRM system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the deal record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record creation; used for data lineage, SOX compliance, and pipeline aging calculations.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the deal size, enterprise value, and fees are denominated (e.g., USD, EUR, GBP). Required for multi-currency pipeline reporting and FX conversion to reporting currency.. Valid values are `^[A-Z]{3}$`',
    `deal_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the deal at origination, used in pitch books, mandate letters, and client communications. Typically follows the investment banks internal deal numbering convention (e.g., IB-2024-00123).',
    `deal_description` STRING COMMENT 'Free-text narrative description of the deal structure, strategic rationale, and key transaction terms. Used in pitch books, deal committee memos, and tombstone records. Contains sensitive deal information subject to information barrier controls.',
    `deal_name` STRING COMMENT 'Human-readable name or working title of the deal, often referencing the target company or project codename (e.g., Project Falcon — Acquisition of XYZ Corp). Used in internal pipeline reporting and pitch book headers.',
    `deal_status` STRING COMMENT 'Current operational status of the deal record. ACTIVE indicates the deal is in progress; CLOSED_WON indicates successful completion; CLOSED_LOST or WITHDRAWN indicates the deal did not proceed. Used for pipeline management and revenue forecasting.. Valid values are `ACTIVE|ON_HOLD|CLOSED_WON|CLOSED_LOST|WITHDRAWN|TERMINATED`',
    `deal_type` STRING COMMENT 'Classification of the investment banking transaction by strategic category. Drives workflow, fee structure, and regulatory treatment. [ENUM-REF-CANDIDATE: M&A_BUY_SIDE|M&A_SELL_SIDE|ECM|DCM|LBO|RESTRUCTURING|SYNDICATED_LENDING|LEVERAGED_FINANCE|PROJECT_FINANCE|SPIN_OFF — promote to reference product]. Valid values are `M&A_BUY_SIDE|M&A_SELL_SIDE|ECM|DCM|LBO|RESTRUCTURING`',
    `expected_closing_date` DATE COMMENT 'Projected date on which the transaction is expected to close or complete. Used for pipeline probability weighting, revenue forecasting, and resource scheduling. Updated as deal progresses through execution stages.',
    `expected_fee_amount` DECIMAL(18,2) COMMENT 'The estimated total advisory or underwriting fee expected to be earned upon deal completion, expressed in the deal currency. Used for revenue pipeline forecasting, banker incentive compensation, and ALCO revenue planning.',
    `fee_rate_bps` DECIMAL(18,2) COMMENT 'The advisory or underwriting fee expressed as a rate in basis points (BPS) of the deal size or enterprise value. Standard investment banking fee metric; used for benchmarking against market comparables and mandate negotiation.',
    `is_cross_border` BOOLEAN COMMENT 'Flag indicating whether the transaction involves parties or assets in more than one country. Triggers additional regulatory review, FATCA/CRS reporting obligations, and cross-border M&A regulatory approval tracking.',
    `is_public_company` BOOLEAN COMMENT 'Flag indicating whether the target or issuer is a publicly listed company. Determines applicability of SEC disclosure requirements, public M&A rules (e.g., Williams Act), and public company audit standards.',
    `lob_code` STRING COMMENT 'Code identifying the investment banking line of business responsible for the deal (e.g., M&A Advisory, Equity Capital Markets, Debt Capital Markets, Leveraged Finance, Restructuring). Used for P&L attribution and management reporting.',
    `mandate_date` DATE COMMENT 'The date on which the client formally awarded the mandate to the bank, typically evidenced by a signed engagement letter or mandate agreement. Triggers formal deal execution resourcing and fee accrual commencement.',
    `origination_date` DATE COMMENT 'The date on which the deal opportunity was first identified and entered into the pipeline system. Marks the start of the deal lifecycle and is used for pipeline aging analysis and banker performance attribution.',
    `pipeline_probability_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0.00–100.00%) that the deal will successfully close, assigned by the coverage banker and reviewed by deal committee. Used to compute probability-weighted revenue in pipeline forecasting and ALCO reporting.',
    `pitch_date` DATE COMMENT 'The date on which the formal pitch or proposal was presented to the client. Marks the transition from origination to active pursuit; used for pipeline conversion rate analysis and banker activity tracking.',
    `pricing_date` DATE COMMENT 'The date on which the transaction was priced (applicable to ECM and DCM transactions). For IPOs and bond issuances, this is the date the final offer price or coupon is set; triggers T+1 or T+2 settlement obligations.',
    `rationale` STRING COMMENT 'Summary of the strategic rationale for the transaction from the clients perspective (e.g., market expansion, synergy realization, capital structure optimization). Used in deal committee presentations and regulatory filings.',
    `region_code` STRING COMMENT 'Geographic region responsible for the deal coverage and execution (Americas, EMEA, Asia-Pacific). Used for regional P&L attribution, pipeline reporting, and regulatory jurisdiction mapping.. Valid values are `AMER|EMEA|APAC`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Flag indicating whether the transaction requires regulatory approval (e.g., antitrust/HSR filing, CFIUS review, FCA approval, ECB notification). Triggers compliance workflow and deal timeline adjustment.',
    `restricted_list_flag` BOOLEAN COMMENT 'Indicates whether the deal has triggered placement of the target or issuer on the banks restricted trading list, preventing proprietary trading and research publication. Enforces information barrier compliance.',
    `size` DECIMAL(18,2) COMMENT 'The total transaction size or notional value of the deal (e.g., total equity raised for ECM, total debt issued for DCM, total consideration for M&A). Distinct from enterprise value; represents the actual capital markets transaction amount.',
    `source_system_deal_ref` STRING COMMENT 'The deal identifier as recorded in the originating system of record (e.g., Murex deal ID, Loan IQ deal number, or internal CRM opportunity ID). Enables lineage tracing and reconciliation between the lakehouse silver layer and operational systems.',
    `subtype` STRING COMMENT 'Further granular classification within the deal type. For ECM: IPO, Follow-On, Rights Issue, SPAC. For DCM: Investment Grade Bond, High Yield Bond, Convertible Note. For M&A: Strategic, Financial Sponsor. [ENUM-REF-CANDIDATE: IPO|FOLLOW_ON|RIGHTS_ISSUE|SPAC|IG_BOND|HY_BOND|CONVERTIBLE|STRATEGIC_MA|FINANCIAL_SPONSOR — promote to reference product]',
    `target_company_name` STRING COMMENT 'Legal name of the target company in M&A transactions, or the issuer name in ECM/DCM transactions. Used in tombstone records, regulatory filings, and deal marketing materials.',
    `target_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the target companys or issuers primary jurisdiction of incorporation. Used for cross-border deal classification, regulatory jurisdiction determination, and geographic pipeline reporting.. Valid values are `^[A-Z]{3}$`',
    `target_enterprise_value` DECIMAL(18,2) COMMENT 'The estimated total enterprise value of the target company or transaction, expressed in the deal currency. Used as the primary sizing metric for M&A transactions, LBO analysis, and DCF valuation benchmarking. Basis for fee calculation in many mandate structures.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to the deal record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture, audit trail maintenance, and detecting stale pipeline records.',
    CONSTRAINT pk_deal PRIMARY KEY(`deal_id`)
) COMMENT 'Core master entity representing an investment banking deal or transaction mandate. Captures the full lifecycle from origination through closing, including deal type (M&A buy-side/sell-side, ECM, DCM, LBO, restructuring), stage progression (origination, pitch, mandate, execution, pricing, closing, post-closing), deal size, target enterprise value, expected fee, mandate date, closing date, status, originating banker, pipeline probability, and key milestone dates. Serves as the primary anchor entity for all investment domain relationships — mandate, valuation, offering, syndication, tombstone, fee arrangement, regulatory filing, and deal participants all reference this entity.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`investment_mandate` (
    `investment_mandate_id` BIGINT COMMENT 'Unique surrogate identifier for the investment banking mandate record in the lakehouse silver layer. Primary key for this entity.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Mandates require counterparty ratings for client onboarding, KYC/AML compliance verification, engagement risk assessment, and credit authority determination. Essential for conflict checks and regulato',
    `employee_id` BIGINT COMMENT 'Reference to the lead investment banking coverage officer or relationship banker responsible for originating and managing this mandate.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Client mandates for advisory services are signed through specific channels. MiFID II and Dodd-Frank require tracking client engagement channel for suitability and best execution compliance. Mandate ma',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Governing law jurisdiction required for legal enforceability assessment, netting opinion validation, and dispute resolution framework per ISDA Master Agreement standards.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Mandates are executed by specific bank legal entities (signatory to engagement letter). Required for revenue recognition under ASC 606/IFRS 15, legal liability tracking, and regulatory reporting of ad',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Investment banking mandates for derivatives and structured products reference CSA/margin agreements governing collateral terms. Real process: ISDA master agreement negotiation, collateral schedule doc',
    `party_id` BIGINT COMMENT 'Reference to the corporate or institutional client that has engaged the bank under this mandate. Represents the counterparty granting the mandate.',
    `bank_signatory_name` STRING COMMENT 'Full name of the authorized bank representative who executed the mandate letter on behalf of the bank. Required for legal enforceability and audit trail.',
    `client_signatory_name` STRING COMMENT 'Full name of the authorized client representative who executed the mandate letter on behalf of the client entity. Required for legal enforceability and Know Your Customer (KYC) documentation.',
    `client_signatory_title` STRING COMMENT 'Job title or designation of the client signatory (e.g., Chief Financial Officer, Managing Director) confirming their authority to bind the client entity under the mandate.',
    `completion_date` DATE COMMENT 'Date on which the mandated transaction was successfully completed and closed (e.g., IPO pricing date, M&A closing date, bond settlement date). Triggers final fee recognition and tombstone eligibility.',
    `confidentiality_level` STRING COMMENT 'Information barrier and confidentiality classification of the mandate. wall_crossed indicates that specific individuals have been brought over the wall and are subject to information barrier restrictions under Market Abuse Regulation (MAR) and SEC insider trading rules.. Valid values are `public|internal|confidential|restricted|wall_crossed`',
    `conflict_check_status` STRING COMMENT 'Status of the banks internal conflict of interest review for this mandate. Mandates cannot be activated until conflicts are cleared or formally waived per Governance, Risk and Compliance (GRC) policy.. Valid values are `pending|cleared|conflict_identified|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements under SOX and SEC Rule 17a-4.',
    `deal_size_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated or target transaction size. Used for fee calculation, pipeline reporting, and capital markets analytics.. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractually agreed mechanism for resolving disputes arising under the mandate agreement (e.g., litigation in courts, arbitration under ICC/LCIA rules, mediation).. Valid values are `litigation|arbitration|mediation|expert_determination`',
    `effective_date` DATE COMMENT 'Date from which the mandate becomes binding and the bank is authorized to commence advisory or underwriting activities on behalf of the client.',
    `engagement_scope` STRING COMMENT 'Narrative description of the services the bank is mandated to provide, including advisory scope, underwriting obligations, distribution responsibilities, and any carve-outs or limitations agreed in the mandate letter.',
    `estimated_deal_size` DECIMAL(18,2) COMMENT 'Estimated gross transaction value or deal size as agreed at mandate signing. Used for pipeline valuation, fee estimation, and Discounted Cash Flow (DCF) modelling. Expressed in deal_size_currency.',
    `exclusivity_end_date` DATE COMMENT 'End date of the exclusivity period. After this date, the client may engage competing advisors unless the mandate is renewed or the exclusivity is extended.',
    `exclusivity_start_date` DATE COMMENT 'Start date of the exclusivity period during which the client is contractually restricted from engaging other advisors for the same transaction.',
    `expiry_date` DATE COMMENT 'Date on which the mandate agreement expires if the transaction has not been completed. Nullable for open-ended mandates. Distinct from the exclusivity end date.',
    `fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which mandate fees (retainer, success fee, minimum fee) are denominated and payable. May differ from deal_size_currency for cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `governing_law_state` STRING COMMENT 'State or province within the governing law jurisdiction (e.g., New York, England and Wales) where sub-national law applies. Relevant for US and federal jurisdictions.',
    `industry_sector_code` STRING COMMENT 'Four-digit Standard Industrial Classification (SIC) or Global Industry Classification Standard (GICS) code representing the clients primary industry sector. Used for sector-based pipeline analytics and coverage team assignment.. Valid values are `^[0-9]{4}$`',
    `investment_mandate_status` STRING COMMENT 'Current lifecycle state of the mandate agreement. Drives pipeline reporting, fee accrual eligibility, and deal team resource allocation. Valid states: draft (under negotiation), active (signed and in force), suspended (temporarily paused), terminated (cancelled before completion), completed (transaction closed), lapsed (exclusivity expired without execution).. Valid values are `draft|active|suspended|terminated|completed|lapsed`',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the mandate grants the bank exclusive advisory rights for the transaction, preventing the client from engaging competing advisors during the exclusivity period.',
    `kyc_status` STRING COMMENT 'Current Know Your Customer (KYC) and Anti-Money Laundering (AML) due diligence status for the client under this mandate. Mandates cannot proceed without approved KYC per Bank Secrecy Act (BSA) and FinCEN requirements.. Valid values are `pending|approved|expired|remediation_required`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the mandate record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Required for change data capture, audit trail, and regulatory record-keeping.',
    `league_table_eligible` BOOLEAN COMMENT 'Indicates whether this mandate and its associated transaction qualify for submission to investment banking league table rankings (e.g., Bloomberg, Dealogic, Thomson Reuters). Drives competitive positioning analytics.',
    `letter_date` DATE COMMENT 'Date on which the mandate letter was formally signed and executed by both the bank and the client. This is the principal business event date establishing the contractual engagement.',
    `lob_code` STRING COMMENT 'Code identifying the investment banking Line of Business (LOB) responsible for this mandate (e.g., IBD — Investment Banking Division, ECM — Equity Capital Markets, DCM — Debt Capital Markets, M&A, SYND — Syndicated Lending, CORP_FIN — Corporate Finance).. Valid values are `IBD|ECM|DCM|M_AND_A|SYND|CORP_FIN`',
    `mandate_type` STRING COMMENT 'Classification of the banks role under the mandate agreement. Determines fee entitlement, exclusivity rights, and regulatory disclosure obligations. [ENUM-REF-CANDIDATE: exclusive_advisor|co_advisor|bookrunner|co_manager|lead_manager|arranger — promote to reference product]. Valid values are `exclusive_advisor|co_advisor|bookrunner|co_manager|lead_manager|arranger`',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed fee payable to the bank regardless of final transaction size, providing a floor on advisory compensation. Expressed in deal_size_currency.',
    `pitch_book_reference` STRING COMMENT 'Document management system reference or identifier for the pitch book or information memorandum presented to the client prior to mandate award. Supports audit trail and deal origination tracking.',
    `reference` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the mandate, used in client correspondence, pitch books, and regulatory filings. Format: LOB-MND-YYYY-NNNNNNNN.. Valid values are `^[A-Z]{2,6}-MND-[0-9]{4}-[0-9]{4,8}$`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the mandated transaction requires regulatory approval (e.g., antitrust clearance, SEC registration, FCA approval) before completion. Triggers compliance workflow and timeline management.',
    `retainer_fee_amount` DECIMAL(18,2) COMMENT 'Fixed upfront or periodic retainer fee payable by the client to the bank upon mandate signing, independent of transaction completion. Expressed in deal_size_currency.',
    `success_fee_bps` DECIMAL(18,2) COMMENT 'Contingent success fee expressed in Basis Points (BPS) of the final transaction value, payable upon successful completion of the mandated transaction. Drives revenue recognition and Profit and Loss (PnL) attribution.',
    `tail_period_months` STRING COMMENT 'Number of months following mandate termination or expiry during which the bank retains the right to a success fee if the transaction is completed with a counterparty introduced during the mandate period.',
    `target_company_name` STRING COMMENT 'Name of the target company or issuer in the transaction (e.g., acquisition target in M&A, issuer in an IPO or bond offering). May be confidential prior to public announcement.',
    `termination_date` DATE COMMENT 'Date on which the mandate was formally terminated prior to transaction completion, if applicable. Populated only when status is terminated. Distinct from expiry_date (natural end) and completion_date (successful close).',
    `termination_rights` STRING COMMENT 'Description of the contractual termination rights available to either party, including notice periods, termination for convenience clauses, material adverse change (MAC) provisions, and tail fee obligations upon termination.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether the completed transaction is eligible for tombstone advertisement publication, subject to client consent and regulatory requirements. Tombstones are used for marketing and league table submissions.',
    `transaction_type` STRING COMMENT 'Category of the investment banking transaction covered by this mandate (e.g., Initial Public Offering (IPO), Mergers and Acquisitions (M&A) buy-side, Debt Capital Markets (DCM)). Drives workflow, fee structure, and regulatory treatment. [ENUM-REF-CANDIDATE: ipo|follow_on|m_and_a_buy_side|m_and_a_sell_side|debt_capital_markets|equity_capital_markets|syndicated_loan|restructuring — promote to reference product]',
    CONSTRAINT pk_investment_mandate PRIMARY KEY(`investment_mandate_id`)
) COMMENT 'Formal mandate agreement record capturing the engagement between the bank and a client for a specific investment banking transaction. Records mandate type (exclusive, co-advisor, bookrunner, co-manager), mandate letter date, engagement scope, exclusivity period, termination rights, governing law, and signatory details. Distinct from the deal entity — a mandate is the contractual authorization to execute a deal.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`transaction_structure` (
    `transaction_structure_id` BIGINT COMMENT 'Unique surrogate identifier for the investment banking transaction structure record. Primary key for this entity in the Silver Layer lakehouse.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Complex transaction structures (SPVs, offshore entities, layered ownership) are red flags in AML investigations. Compliance analysts examine structure to detect money laundering, sanctions evasion, or',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Transaction structures specify collateral packages securing debt tranches in LBOs, secured bond offerings, and asset-backed financings. Real process: credit agreement schedules listing pledged assets,',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or mandate to which this transaction structure belongs.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Transaction structures require a lead structuring banker for P&L attribution, revenue recognition, and regulatory accountability (MiFID II transaction reporting). Banking operations track which banker',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Transaction structures are audited for accounting treatment, regulatory compliance, capital adequacy impact, disclosure requirements, and valuation methodology. Auditors examine structure design for r',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Governing law jurisdiction determines transaction enforceability, tax treatment, and regulatory approval requirements for M&A and restructuring transactions.',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Target industry sector drives valuation multiple selection, comparable transaction analysis, and sector-specific regulatory approval requirements (e.g., banking, telecom, defense).',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: M&A structures use specific securities as consideration (acquirer stock, convertible bonds, earnout securities). Required for exchange ratio calculations, fairness opinions, SEC filing preparation (S-',
    `party_id` BIGINT COMMENT 'Reference to the primary client (issuer, acquirer, or target) for whom this transaction structure is being designed. Aligns with KYC-verified customer master.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Target country required for cross-border transaction analysis, foreign investment restrictions (CFIUS, FIRB), and country risk assessment in deal approval process.',
    `actual_close_date` DATE COMMENT 'Actual date on which the transaction closed and legal title or consideration was transferred. Null until the transaction is completed. Used for fee billing and tombstone records.',
    `advisory_fee_amount` DECIMAL(18,2) COMMENT 'Total investment banking advisory fee earned or expected for this transaction structure, including retainer, announcement fee, and success fee components. Used for revenue recognition and league table credit.',
    `announcement_date` DATE COMMENT 'Date on which the transaction was publicly announced to the market. Triggers regulatory disclosure obligations and market abuse monitoring windows.',
    `breakup_fee_amount` DECIMAL(18,2) COMMENT 'Termination or breakup fee payable by the target or acquirer if the transaction is terminated under specified conditions. Typically 1-4% of deal value; disclosed in merger agreement and proxy statement.',
    `cash_consideration_amount` DECIMAL(18,2) COMMENT 'Cash portion of the total consideration payable to target shareholders or security holders. Used in mixed-consideration deal structuring and tax analysis.',
    `confidentiality_agreement_date` DATE COMMENT 'Date on which the non-disclosure agreement (NDA) or confidentiality agreement was executed between the parties. Establishes the start of the restricted information-sharing period and wall-crossing obligations.',
    `consideration_type` STRING COMMENT 'Form of consideration offered in the transaction (e.g., cash, stock, mixed cash-and-stock, debt assumption, or earnout). Critical for M&A valuation, tax structuring, and shareholder approval requirements.. Valid values are `cash|stock|mixed|debt|earnout`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction structure record was first created in the system. Used for audit trail, data lineage, and SOX compliance.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the transaction involves parties or assets in more than one country. Triggers additional regulatory, tax, and FX structuring considerations including CFIUS review for US transactions.',
    `dcf_enterprise_value` DECIMAL(18,2) COMMENT 'Intrinsic enterprise value derived from the DCF valuation model underpinning the transaction structure. Represents the present value of projected free cash flows discounted at the WACC.',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Gross enterprise value or total deal consideration amount as agreed in the transaction structure. Represents the headline deal size used in pitch books, tombstones, and league table reporting.',
    `deal_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the deal value amount (e.g., USD, EUR, GBP). Required for FX conversion in cross-border M&A and multi-currency capital markets transactions.. Valid values are `^[A-Z]{3}$`',
    `debt_assumed_amount` DECIMAL(18,2) COMMENT 'Total net debt assumed or refinanced as part of the transaction structure. Used in the enterprise-to-equity value bridge and leverage ratio calculations.',
    `equity_value_amount` DECIMAL(18,2) COMMENT 'Equity value (market capitalisation or offer price times diluted shares) component of the transaction structure. Distinct from enterprise value; used in DCF valuation bridge and per-share consideration calculations.',
    `exchange_ratio` DECIMAL(18,2) COMMENT 'Number of acquirer shares offered per target share in a stock-for-stock or mixed-consideration transaction. Null for cash-only deals. Used in merger proxy statements and SEC Form S-4 filings.',
    `expected_close_date` DATE COMMENT 'Anticipated date on which the transaction is expected to close and consideration is transferred. Used for deal pipeline forecasting and fee recognition scheduling.',
    `fairness_opinion_required` BOOLEAN COMMENT 'Indicates whether the board of directors requires a fairness opinion from an independent financial advisor to support the transaction. Typically required for related-party transactions and large public M&A.',
    `financing_mix_debt_pct` DECIMAL(18,2) COMMENT 'Percentage of total transaction financing sourced from debt instruments (senior secured, mezzanine, high-yield bonds). Used in leverage ratio analysis and pro forma capital structure modelling.',
    `financing_mix_equity_pct` DECIMAL(18,2) COMMENT 'Percentage of total transaction financing sourced from equity (sponsor equity, management rollover, public equity issuance). Complements debt percentage to form the full financing mix.',
    `lead_arranger_role` STRING COMMENT 'Role of the bank in this transaction structure (e.g., sole bookrunner, joint bookrunner, lead-left, financial advisor). Determines league table credit allocation and fee entitlement.. Valid values are `sole_bookrunner|joint_bookrunner|lead_left|co_manager|financial_advisor|fairness_opinion_provider`',
    `leverage_ratio` DECIMAL(18,2) COMMENT 'Pro forma leverage ratio expressed as total debt divided by EBITDA at transaction close. Key credit metric used by rating agencies, lenders, and regulators to assess transaction risk. Aligns with Basel III leverage ratio monitoring.',
    `offer_premium_pct` DECIMAL(18,2) COMMENT 'Percentage premium offered over the targets unaffected share price (typically 30-day VWAP prior to announcement). Key M&A valuation metric used in fairness opinions and board presentations.',
    `pro_forma_cet1_ratio` DECIMAL(18,2) COMMENT 'Pro forma CET1 capital ratio post-transaction, reflecting the impact of the deal on the acquirers regulatory capital position. Required for bank M&A regulatory approval submissions to the Fed, OCC, and FDIC.',
    `regulatory_approval_bodies` STRING COMMENT 'Comma-separated list of regulatory bodies whose approval is required for this transaction (e.g., Fed, OCC, DOJ, EC). Drives compliance workflow and deal timeline planning.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the transaction structure requires regulatory approval (e.g., antitrust clearance, banking regulator approval, securities regulator review) before closing.',
    `shareholder_approval_required` BOOLEAN COMMENT 'Indicates whether the transaction requires shareholder or bondholder approval (e.g., merger vote, rights issue prospectus approval). Triggers proxy statement and SEC Schedule 14A filing obligations.',
    `stock_consideration_amount` DECIMAL(18,2) COMMENT 'Equity (stock) portion of the total consideration, valued at the exchange ratio applied to the acquirers share price. Used in share-for-share merger structuring and dilution analysis.',
    `structural_condition_type` STRING COMMENT 'Primary structural condition or protective mechanism embedded in the transaction agreement (e.g., MAC clause, financing condition, no-shop provision, breakup fee). [ENUM-REF-CANDIDATE: material_adverse_change|regulatory_condition|financing_condition|no_shop|go_shop|breakup_fee|other — promote to reference product]. Valid values are `material_adverse_change|regulatory_condition|financing_condition|no_shop|go_shop|breakup_fee`',
    `structure_name` STRING COMMENT 'Human-readable name or working title for the transaction structure (e.g., Project Falcon — Leveraged Buyout Structure). Treated as confidential pre-announcement deal information.',
    `structure_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this transaction structure, used in pitch books, mandate letters, and regulatory filings (e.g., IB-2024-ACQX001).. Valid values are `^[A-Z]{2,6}-[0-9]{4}-[A-Z0-9]{4,12}$`',
    `structure_status` STRING COMMENT 'Current lifecycle status of the transaction structure from initial drafting through execution or termination. Drives workflow routing and deal pipeline reporting.. Valid values are `draft|under_review|approved|executed|terminated|on_hold`',
    `structure_type` STRING COMMENT 'Classification of the investment banking transaction structure type. Drives applicable regulatory approvals, valuation methodology, and capital markets execution approach. [ENUM-REF-CANDIDATE: merger|acquisition|carve_out|spin_off|ipo|follow_on|rights_issue|bond_issuance|syndicated_loan|leveraged_buyout — promote to reference product]',
    `syndication_required` BOOLEAN COMMENT 'Indicates whether the financing component of this transaction requires syndication to a group of lenders or underwriters (e.g., syndicated loan, bond roadshow). Triggers syndicate desk involvement.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether this completed transaction qualifies for inclusion in the banks tombstone advertisement and league table submissions. Set to true upon successful close.',
    `transaction_date` DATE COMMENT 'The principal real-world date on which the transaction structure was formally agreed, signed, or announced. Used as the primary business event date for deal timeline tracking and regulatory reporting.',
    `underwriting_fee_amount` DECIMAL(18,2) COMMENT 'Gross underwriting spread or fee for capital markets transactions (IPO, follow-on, bond issuance). Expressed as a total dollar amount; gross spread percentage is derived analytically.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction structure record was most recently modified. Used for change data capture, audit trail, and Silver Layer incremental processing.',
    `wacc_rate` DECIMAL(18,2) COMMENT 'Weighted average cost of capital rate used as the discount rate in the DCF valuation model for this transaction structure. Expressed as a decimal (e.g., 0.0850 = 8.50%).',
    CONSTRAINT pk_transaction_structure PRIMARY KEY(`transaction_structure_id`)
) COMMENT 'Master entity defining the financial and legal structure of an investment banking transaction. Captures structure type (merger, acquisition, carve-out, spin-off, IPO, follow-on, rights issue, bond issuance, syndicated loan), consideration type (cash, stock, mixed), financing mix, leverage ratio, pro forma capital structure, regulatory approvals required, and structural conditions. Supports DCF valuation and deal execution planning.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`investment_valuation` (
    `investment_valuation_id` BIGINT COMMENT 'Unique surrogate identifier for each investment valuation or fairness opinion record in the investment banking advisory platform. Primary key for the investment_valuation data product.',
    `approval_committee_id` BIGINT COMMENT 'Reference to the internal investment committee or fairness opinion committee responsible for approving and signing off on this valuation. Supports governance and audit trail requirements.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Valuations incorporate counterparty credit risk for fairness opinions, material relationship disclosures, and independence assessments. Credit ratings inform discount rates, risk premiums, and opinion',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or transaction for which this valuation was performed. Links the valuation to the deal pipeline record.',
    `employee_id` BIGINT COMMENT 'Reference to the investment banking analyst or associate who prepared and owns the valuation model. Used for accountability, review workflow, and performance tracking.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Valuation methodologies and fairness opinions are frequent audit subjects for model validation, independence verification, assumption reasonableness, and regulatory compliance (especially for public f',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Industry sector drives beta selection, comparable company selection, and industry-specific valuation multiples (EV/EBITDA, P/E) for fairness opinions and pitch books.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Fairness opinions reference specific securities (target stock, comparable securities for trading multiples). Links valuation to instrument for audit trail of comparables selection, methodology documen',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Fairness opinions and valuations are issued by specific legal entities for regulatory compliance (SEC Rule 13e-3, Dodd-Frank), professional liability insurance, and audit trail. Required for regulator',
    `market_data_source_id` BIGINT COMMENT 'Foreign key linking to reference.market_data_source. Business justification: Market data source required for valuation audit trail, ASC 820 Level 2/3 fair value hierarchy documentation, and pricing governance per SEC/FCA valuation standards.',
    `party_id` BIGINT COMMENT 'Reference to the corporate or institutional client on whose behalf the valuation or fairness opinion was prepared. Supports fiduciary duty tracking and client relationship management.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Valuation methodologies and fairness opinions examined by SEC, FINRA for compliance with securities regulations, fiduciary duty standards, and disclosure adequacy. Examiners review valuation models, a',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Target country determines country risk premium in WACC calculation, sovereign credit rating impact, and regulatory approval timeline for valuation scenarios.',
    `transaction_structure_id` BIGINT COMMENT 'Foreign key linking to investment.transaction_structure. Business justification: Valuations and fairness opinions are performed to support specific transaction structures (e.g., DCF valuation for a proposed merger structure). While investment_valuation has deal_id, one deal can ha',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time at which the valuation or fairness opinion was formally approved by the designated investment committee or approval authority. Marks the transition from in_review to approved status and is a key compliance milestone.',
    `board_presentation_date` DATE COMMENT 'Date on which the valuation analysis or fairness opinion was formally presented to the clients board of directors. Required for fairness opinion compliance documentation and proxy statement disclosure. Distinct from the valuation date.',
    `conflict_check_status` STRING COMMENT 'Status of the investment banks internal conflict of interest review for this valuation engagement. FINRA Rule 5150 requires disclosure of material relationships between the advisor and the parties to the transaction. Cleared indicates no material conflicts; conflict_identified requires disclosure or recusal.. Valid values are `cleared|conflict_identified|waived|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this valuation record was first created in the investment banking platform. Used for audit trail, data lineage, and compliance record-keeping under SEC Rule 17a-4 and FINRA recordkeeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary valuation figures (enterprise value, equity value, implied multiples) are expressed. Typically USD for US transactions but may vary for cross-border M&A.. Valid values are `^[A-Z]{3}$`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time at which the valuation analysis or fairness opinion letter was formally delivered to the client or their board of directors. Marks the transition to delivered status and is referenced in the engagement letter and regulatory filings.',
    `enterprise_value_high` DECIMAL(18,2) COMMENT 'Upper bound of the enterprise value range derived from the valuation analysis, expressed in the deal currency. The EV range reflects sensitivity analysis across key assumptions such as WACC and terminal growth rate.',
    `enterprise_value_low` DECIMAL(18,2) COMMENT 'Lower bound of the enterprise value range derived from the valuation analysis, expressed in the deal currency. Enterprise Value represents the total value of the business including debt and excluding cash. Used for deal pricing and fairness opinion conclusions.',
    `equity_value_high` DECIMAL(18,2) COMMENT 'Upper bound of the implied equity value range, calculated by deducting net debt from the enterprise value high. Used in conjunction with shares outstanding to derive implied per-share value ranges for board presentations and proxy filings.',
    `equity_value_low` DECIMAL(18,2) COMMENT 'Lower bound of the implied equity value range, calculated by deducting net debt from the enterprise value low. Represents the value attributable to equity holders and is used to derive implied share price ranges for M&A and IPO pricing.',
    `ev_ebitda_multiple_high` DECIMAL(18,2) COMMENT 'Upper bound of the implied EV/EBITDA multiple derived from the valuation range. Together with the low multiple, defines the EV/EBITDA range used in board presentations, fairness opinion analyses, and investment committee materials.',
    `ev_ebitda_multiple_low` DECIMAL(18,2) COMMENT 'Lower bound of the implied EV/EBITDA multiple derived from the valuation range, calculated as enterprise value low divided by the target companys EBITDA. Used to benchmark the valuation against comparable company trading multiples and precedent transaction multiples.',
    `forecast_period_years` STRING COMMENT 'Number of years in the explicit cash flow forecast period used in the DCF or LBO model. Typically 5 to 10 years for investment banking valuations. Determines the horizon over which detailed financial projections are modeled before applying the terminal value.',
    `implied_share_price_high` DECIMAL(18,2) COMMENT 'Upper bound of the implied per-share equity value derived from the equity value high divided by fully diluted shares outstanding. Together with the low, defines the implied share price range disclosed in fairness opinion proxy materials.',
    `implied_share_price_low` DECIMAL(18,2) COMMENT 'Lower bound of the implied per-share equity value derived from the equity value low divided by fully diluted shares outstanding. Used in fairness opinion analyses to compare the implied price range against the proposed transaction consideration.',
    `is_fairness_opinion` BOOLEAN COMMENT 'Indicates whether this valuation record constitutes a formal fairness opinion (True) or an internal valuation analysis (False). Fairness opinions carry additional regulatory obligations under SEC Rule 14a-9 and FINRA Rule 5150, including board presentation and proxy disclosure requirements.',
    `ltm_ebitda` DECIMAL(18,2) COMMENT 'Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA) for the last twelve months (LTM) period used as the primary financial metric in the valuation analysis. Denominator for EV/EBITDA multiple calculations and key input to DCF normalization.',
    `material_relationship_disclosure` STRING COMMENT 'Narrative description of any material relationships between the investment bank and the parties to the transaction that must be disclosed in the fairness opinion letter or proxy statement, as required by FINRA Rule 5150. Includes prior advisory mandates, lending relationships, and equity holdings.',
    `methodology` STRING COMMENT 'Primary valuation methodology applied in this analysis. Common investment banking methodologies include Discounted Cash Flow (DCF), Leveraged Buyout (LBO), Comparable Company Analysis, Precedent Transaction Analysis, Sum-of-Parts (SOTP), Net Asset Value (NAV), Dividend Discount Model (DDM), and Asset-Based valuation. [ENUM-REF-CANDIDATE: DCF|LBO|comparable_company|precedent_transaction|sum_of_parts|NAV|dividend_discount|asset_based — promote to reference product]',
    `model_file_reference` STRING COMMENT 'Document management system reference or file path to the underlying financial model (Excel/Python workbook) supporting this valuation. Enables auditors and reviewers to trace the valuation conclusion back to the source model and assumptions.',
    `net_debt` DECIMAL(18,2) COMMENT 'Total financial debt less cash and cash equivalents of the target company as of the valuation date, used to bridge from enterprise value to equity value. A negative net debt (net cash) position increases equity value relative to enterprise value.',
    `opinion_conclusion` STRING COMMENT 'The formal conclusion of the fairness or solvency opinion as rendered by the investment bank. Applicable when is_fairness_opinion is True. The conclusion is disclosed in the proxy statement or offering document and is subject to SEC and FINRA scrutiny.. Valid values are `fair|not_fair|unable_to_opine|adequate|inadequate`',
    `opinion_type` STRING COMMENT 'Classification of the formal opinion rendered, applicable when is_fairness_opinion is True. Fairness opinions address whether consideration is fair from a financial point of view; solvency opinions address the targets ability to meet obligations post-transaction; valuation opinions provide a point estimate of value; adequacy opinions address whether consideration is adequate.. Valid values are `fairness|solvency|valuation|adequacy`',
    `pe_multiple_high` DECIMAL(18,2) COMMENT 'Upper bound of the implied Price-to-Earnings (P/E) multiple derived from the equity value range. Together with the low multiple, defines the P/E range used in fairness opinion analyses and investment committee presentations.',
    `pe_multiple_low` DECIMAL(18,2) COMMENT 'Lower bound of the implied Price-to-Earnings (P/E) multiple derived from the equity value range divided by the target companys net income. Used as a cross-check valuation metric, particularly relevant for IPO pricing and public M&A transactions.',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the valuation engagement, used in client deliverables, pitch books, and regulatory filings. Follows the format VAL-YYYY-NNNNNN.. Valid values are `^VAL-[0-9]{4}-[0-9]{6}$`',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier of the SEC, FINRA, or other regulatory filing (e.g., proxy statement, S-1, Form 8-K) in which this fairness opinion or valuation is disclosed. Enables traceability between the internal valuation record and public regulatory filings.',
    `secondary_methodology` STRING COMMENT 'Secondary or cross-check valuation methodology used to triangulate the primary valuation result. Investment banking practice typically employs multiple methodologies to establish a valuation range. [ENUM-REF-CANDIDATE: DCF|LBO|comparable_company|precedent_transaction|sum_of_parts|NAV|dividend_discount|asset_based — promote to reference product]',
    `shares_outstanding` DECIMAL(18,2) COMMENT 'Fully diluted shares outstanding of the target company as of the valuation date, including common shares, in-the-money options, warrants, and convertible securities on a treasury stock method basis. Used to derive implied per-share equity value.',
    `target_company_name` STRING COMMENT 'Legal name of the company being valued or the target of the M&A transaction. Captured directly on the valuation record for reporting and audit purposes, as the target may not be an existing client in the customer master.',
    `terminal_growth_rate` DECIMAL(18,2) COMMENT 'Perpetuity growth rate applied in the DCF terminal value calculation, expressed as a decimal (e.g., 0.025 for 2.5%). Represents the assumed long-term sustainable growth rate of the target companys free cash flows beyond the explicit forecast period.',
    `transaction_type` STRING COMMENT 'Classification of the investment banking transaction for which this valuation is being performed. Determines the applicable regulatory requirements, fee structures, and valuation standards. [ENUM-REF-CANDIDATE: MA_buyside|MA_sellside|IPO|secondary_offering|debt_issuance|leveraged_buyout|restructuring|spin_off — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to this valuation record. Used for change tracking, data lineage, and incremental ETL processing in the Databricks lakehouse silver layer.',
    `valuation_date` DATE COMMENT 'The as-of date on which the valuation analysis is anchored. All market data, financial projections, and comparable benchmarks are referenced as of this date. Critical for fairness opinion compliance and deal pricing.',
    `valuation_status` STRING COMMENT 'Current lifecycle state of the valuation record, tracking progression from initial draft through internal review, committee approval, client delivery, and potential supersession or withdrawal. [ENUM-REF-CANDIDATE: draft|in_review|approved|delivered|superseded|withdrawn — promote to reference product if additional states are required]. Valid values are `draft|in_review|approved|delivered|superseded|withdrawn`',
    `version_number` STRING COMMENT 'Sequential version number of the valuation model, incremented each time the analysis is materially revised (e.g., updated financial projections, revised WACC, new comparable set). Enables version control and audit trail for deal pricing decisions.',
    `wacc` DECIMAL(18,2) COMMENT 'Weighted Average Cost of Capital expressed as a decimal (e.g., 0.085 for 8.5%) used as the discount rate in DCF valuation. Reflects the blended cost of equity and debt financing, adjusted for the target companys capital structure and risk profile.',
    CONSTRAINT pk_investment_valuation PRIMARY KEY(`investment_valuation_id`)
) COMMENT 'Master record for financial valuations and fairness opinions performed in support of investment banking transactions. Captures valuation methodology (DCF, LBO, comparable company analysis, precedent transactions, sum-of-parts, NAV), valuation date, enterprise value range, equity value range, implied multiples (EV/EBITDA, P/E), discount rate (WACC), terminal growth rate, analyst, approval status, and — for fairness opinions — opinion type (fairness, solvency, valuation), opinion conclusion (fair, not fair, unable to opine), board presentation date, approval committee, and regulatory filing reference. Supports deal pricing, fiduciary duty compliance in public M&A, and investment committee approvals.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`fee_arrangement` (
    `fee_arrangement_id` BIGINT COMMENT 'Unique surrogate identifier for the fee arrangement record in the investment banking mandate fee management system. Primary key for this entity.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Fee structures examined in AML cases to detect potential bribery, kickbacks, or unusual payment patterns indicating illicit activity. Compliance reviews fee arrangements for FCPA violations, conflicts',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Fee revenue is attributed to cost centers for P&L reporting, banker compensation calculations, and management reporting. Replaces denormalized cost_center_code. Required for segment reporting under IF',
    `deal_id` BIGINT COMMENT 'Reference to the investment banking deal or transaction (e.g., M&A transaction, IPO, syndicated loan) associated with this fee arrangement.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Fee arrangements are audited for revenue recognition compliance, conflict of interest management, regulatory adherence, internal policy compliance, and appropriateness of fee structures relative to se',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Investment banking fees are posted to specific GL accounts for revenue recognition. Replaces denormalized gl_account_code with proper FK to enable drill-down from financial statements to deal-level fe',
    `investment_mandate_id` BIGINT COMMENT 'Reference to the investment banking mandate (M&A, IPO, DCF advisory, debt/equity capital markets) to which this fee arrangement belongs.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Fee revenue must be recognized in specific legal entitys financial statements for GAAP/IFRS compliance, tax reporting, and regulatory capital calculations. Essential for revenue_recognition_date post',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Investment banking fees for HNW individuals are sometimes paid from or tracked against wealth management portfolios. Real business process: fee billing coordination between investment banking and weal',
    `party_id` BIGINT COMMENT 'Reference to the corporate or institutional client (counterparty) for whom the investment banking services are being rendered under this fee arrangement.',
    `employee_id` BIGINT COMMENT 'Reference to the lead investment banker (Managing Director or Director) responsible for originating and managing the mandate. Used for banker compensation, league table credit, and performance attribution.',
    `approval_date` DATE COMMENT 'The date on which the fee arrangement received final internal approval. Part of the SOX-compliant audit trail for revenue recognition and mandate governance.',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the fee arrangement, reflecting sign-off by IB management, finance, and legal prior to client engagement. Required for SOX compliance and revenue recognition.. Valid values are `pending_approval|approved|rejected|escalated`',
    `arrangement_number` STRING COMMENT 'Externally-known unique alphanumeric reference code for the fee arrangement, used in client-facing engagement letters, mandate agreements, and finance reconciliation. Format: FA-{LOB}-{YEAR}-{SEQUENCE}.. Valid values are `^FA-[A-Z]{2,6}-[0-9]{4}-[0-9]{6}$`',
    `arrangement_status` STRING COMMENT 'Current lifecycle state of the fee arrangement. Draft: under negotiation; Active: binding and in effect; Suspended: temporarily paused; Terminated: cancelled before completion; Completed: all fees settled; Expired: lapsed without completion.. Valid values are `draft|active|suspended|terminated|completed|expired`',
    `bank_fee_share_pct` DECIMAL(18,2) COMMENT 'The percentage of the total fee retained by this bank after co-advisor fee sharing. Equals 100% minus co_advisor_fee_sharing_pct for simple two-party splits, or the banks specific allocation in multi-party syndicates.',
    `break_fee_amount` DECIMAL(18,2) COMMENT 'The contractual fee payable to the bank if the deal is terminated by the client before completion. Compensates the bank for work performed and opportunity cost.',
    `co_advisor_fee_sharing_pct` DECIMAL(18,2) COMMENT 'The percentage of the total fee to be shared with co-advisors or syndicate members on the mandate. Used for fee split calculations and revenue attribution in multi-bank advisory or underwriting syndicates.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fee arrangement record was first created in the system. Audit trail field for data lineage and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the fee arrangement is denominated (e.g., USD, EUR, GBP). Governs all monetary amounts on this record.. Valid values are `^[A-Z]{3}$`',
    `deal_value_basis` DECIMAL(18,2) COMMENT 'The transaction or deal value (e.g., enterprise value, equity value, issuance proceeds) used as the basis for computing percentage-based fees. Critical for success fee and underwriting spread calculations.',
    `dispute_description` STRING COMMENT 'Description of the fee dispute raised by the client, including the disputed amount and grounds for dispute. Populated when payment_status is disputed. Used for legal and collections management.',
    `effective_date` DATE COMMENT 'The date on which the fee arrangement becomes legally binding and operative, typically aligned with the mandate agreement execution date.',
    `engagement_letter_ref` STRING COMMENT 'The document reference number of the signed engagement letter or mandate agreement that governs this fee arrangement. Used for legal and compliance audit trail.',
    `expiry_date` DATE COMMENT 'The date on which the fee arrangement ceases to be operative. Nullable for open-ended arrangements. Tail fee provisions may extend beyond this date.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The gross base fee amount in the arrangement currency. For fixed-basis arrangements, this is the total contractual fee. For percentage-basis arrangements, this is the computed fee amount once the deal value is known. Used for P&L attribution and revenue recognition.',
    `fee_basis` STRING COMMENT 'The computational basis on which the fee is calculated. Fixed: flat dollar amount; Percentage: applied to transaction value or deal size; Tiered: percentage varies by deal size bracket; Blended: combination of fixed and percentage; Minimum Plus Percentage: floor amount plus variable component.. Valid values are `fixed|percentage|tiered|blended|minimum_plus_percentage`',
    `fee_rate_bps` DECIMAL(18,2) COMMENT 'The fee rate expressed in basis points (BPS) applied to the transaction or deal value for percentage-basis fee arrangements. One basis point equals 0.01%. Used in underwriting spread and advisory fee calculations.',
    `fee_type` STRING COMMENT 'Classification of the fee by its commercial nature within the investment banking mandate. Retainer: periodic engagement fee; Success Fee: contingent on deal close; Underwriting Spread: difference between issue price and proceeds; Advisory Fee: M&A or capital markets advisory; Break Fee: payable on deal termination; Tail Fee: post-termination success fee within tail period.. Valid values are `retainer|success_fee|underwriting_spread|advisory_fee|break_fee|tail_fee`',
    `fee_waiver_reason` STRING COMMENT 'Free-text description of the business reason for waiving or reducing the contractual fee, required for management approval and audit trail when payment_status is waived. Null when no waiver applies.',
    `invoice_number` STRING COMMENT 'The accounts receivable invoice number issued to the client for fees due under this arrangement. Links to the AR module in the General Ledger system (Oracle Financials / SAP S4HANA) for payment tracking.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'The total fee amount invoiced to the client under this arrangement. May differ from fee_amount due to adjustments, credits, or partial invoicing.',
    `lob_code` STRING COMMENT 'The Line of Business (LOB) code identifying the investment banking division responsible for this fee arrangement (e.g., M&A Advisory, ECM, DCM, Leveraged Finance, Syndicated Lending).',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'The contractual floor fee amount guaranteed to the bank regardless of deal size or outcome, applicable for tiered or minimum-plus-percentage fee basis arrangements.',
    `payment_due_date` DATE COMMENT 'The contractual date by which the client must remit payment for the invoiced fee. Used for AR aging, collections management, and overdue fee tracking.',
    `payment_received_date` DATE COMMENT 'The date on which the fee payment was actually received from the client. Used for cash reconciliation, days-sales-outstanding (DSO) calculation, and revenue recognition confirmation.',
    `payment_status` STRING COMMENT 'Current payment collection status for the fee arrangement. Pending: invoice issued, payment not yet due; Partially Paid: partial receipt; Paid: fully settled; Overdue: past due date; Waived: fee forgiven; Disputed: client has raised a dispute.. Valid values are `pending|partially_paid|paid|overdue|waived|disputed`',
    `received_amount` DECIMAL(18,2) COMMENT 'The total fee amount actually received from the client as of the most recent payment event. Used for cash reconciliation, outstanding receivables tracking, and revenue recognition confirmation.',
    `reconciliation_reference` STRING COMMENT 'The payment or wire transfer reference number used to match the received fee payment to the invoice in the GL/AR system. Supports finance reconciliation and audit trail requirements.',
    `retainer_amount` DECIMAL(18,2) COMMENT 'The periodic retainer fee amount payable by the client during the engagement period, typically monthly or quarterly. May be credited against the success fee upon deal close.',
    `retainer_creditable` BOOLEAN COMMENT 'Indicates whether retainer payments made during the engagement are creditable (offset) against the success fee upon deal completion. True = retainer amounts reduce the success fee payable.',
    `retainer_frequency` STRING COMMENT 'The frequency at which retainer fee payments are due from the client during the engagement period.. Valid values are `monthly|quarterly|semi_annual|annual|one_time`',
    `revenue_recognition_date` DATE COMMENT 'The date on which the fee revenue is recognized in the General Ledger per the applicable revenue recognition method (IFRS 15 / ASC 606). Critical for period-end financial close and P&L attribution.',
    `revenue_recognition_method` STRING COMMENT 'The accounting method applied to recognize revenue from this fee arrangement per IFRS 15 / ASC 606. Point in Time: recognized at deal close; Over Time: recognized ratably over engagement period; Milestone Based: recognized upon achievement of defined milestones; Contingent: deferred until contingency resolved.. Valid values are `point_in_time|over_time|milestone_based|contingent`',
    `tail_period_months` STRING COMMENT 'The number of months following termination or expiry of the mandate during which the bank retains the right to a success fee if the client completes a transaction with a party introduced by the bank.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether this fee arrangement is associated with a completed transaction eligible for tombstone publication (deal announcement). True = deal closed and fee earned; used for league table credit and marketing purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fee arrangement record was most recently modified. Audit trail field for change tracking, data lineage, and SOX compliance.',
    CONSTRAINT pk_fee_arrangement PRIMARY KEY(`fee_arrangement_id`)
) COMMENT 'Master entity capturing the fee structure, economics, and all payment events for investment banking mandates. Records fee type (retainer, success fee, underwriting spread, advisory fee, break fee, tail fee), fee basis (fixed, percentage, tiered), fee amount, payment milestones, fee sharing with co-advisors, revenue recognition schedule, and individual fee payment event details including event type (retainer payment, success fee trigger, closing fee, break fee), event date, invoiced amount, received amount, payment status, reconciliation reference, and revenue recognition date. Critical for IB revenue management, P&L attribution, banker compensation, and finance reconciliation.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`investment_syndication` (
    `investment_syndication_id` BIGINT COMMENT 'Unique surrogate identifier for the syndicated lending or capital markets syndication record. Primary key for the syndication master entity.',
    `alco_meeting_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_meeting. Business justification: Large syndication commitments requiring balance sheet capacity are escalated to ALCO for approval. Business process: ALCO governance over credit and liquidity risk from syndications ensures alignment ',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Syndicated loan participants screened for sanctions/AML risk. Large cash movements and cross-border syndications trigger transaction monitoring. Compliance reviews syndication structures for layering,',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: Syndication pipeline affects projected credit RWA and capital ratios. Business process: capital stress testing includes syndication exposures in baseline and adverse scenarios to assess capital adequa',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Syndicated loans are secured by collateral pledges documented in security agreements. Real process: secured credit facility documentation, lien perfection filings, intercreditor agreements in syndicat',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Syndication participants require credit ratings for underwriting decisions, allocation sizing, pricing determination, and regulatory capital calculation. Essential for credit approval and risk-adjuste',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or mandate under which this syndication is structured. Links syndication activity to the originating deal pipeline.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Syndication activities are audited for credit risk assessment, regulatory capital treatment, fee sharing compliance, documentation standards, and underwriting risk management. Critical for capital mar',
    `facility_id` BIGINT COMMENT 'Reference to the credit facility or loan facility being syndicated. Ties the syndication record to the underlying credit agreement in the loan origination system.',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Large syndications require dedicated funding plans to ensure the bank can honor underwriting commitments. Business process: treasury funding planning coordinates with capital markets to pre-arrange fu',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Governing law jurisdiction determines loan enforceability, netting opinion requirements, and intercreditor agreement framework for syndicated lending transactions.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Holiday calendar required for business day convention application, payment date calculation, and interest accrual period determination per ISDA definitions and LMA standards.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Institutional funds are major participants in syndicated loan and debt markets as lenders/investors. Real business process: syndication book-building, investor allocation management, and relationship ',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Syndicated facilities impact bank liquidity positions through commitment drawdowns and funding requirements. Business process: liquidity risk management tracks syndication exposures in LCR/NSFR regula',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Loan syndications are marketed through specific channels - institutional sales desks, digital loan platforms (LoanIQ, SyndTrak), RM networks. Syndicate desks track marketing channel for lender reach a',
    `party_id` BIGINT COMMENT 'Reference to the borrower or obligor entity for whom the syndicated facility is being arranged. Core party reference for the syndication transaction.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Reference rate benchmark required for IBOR transition (LIBOR→SOFR), interest accrual calculations, hedge accounting documentation, and LMA/LSTA loan documentation standards.',
    `actual_selldown_amount` DECIMAL(18,2) COMMENT 'The amount actually distributed to third-party lenders at close of syndication. May differ from target_selldown_amount due to market conditions, pricing flex, or investor demand shortfall.',
    `arrangement_fee_amount` DECIMAL(18,2) COMMENT 'The total arrangement fee earned by the bank for structuring and executing the syndication, expressed in deal currency. Recognized as fee income upon close per IFRS 15 / FASB ASC 606.',
    `asset_class` STRING COMMENT 'Broad asset class of the syndicated instrument: leveraged_loan, investment_grade, Collateralized Loan Obligation (CLO), Asset-Backed Security (ABS), Mortgage-Backed Security (MBS), or project_finance. Drives regulatory capital treatment and investor eligibility.. Valid values are `leveraged_loan|investment_grade|clo|abs|mbs|project_finance`',
    `bank_hold_amount` DECIMAL(18,2) COMMENT 'The portion of the total facility that the arranging bank intends to retain on its own balance sheet after syndication. Reflects the banks final hold position and drives RWA and capital consumption calculations.',
    `bookrunner_role` STRING COMMENT 'The banks role in the syndication as bookrunner or arranger: sole_bookrunner, joint_bookrunner, co_bookrunner, mandated_lead_arranger (MLA), or lead_arranger. Determines fee entitlement and decision-making authority in the syndicate.. Valid values are `sole_bookrunner|joint_bookrunner|co_bookrunner|mandated_lead_arranger|lead_arranger`',
    `close_date` DATE COMMENT 'The date on which the syndication was formally closed and the credit agreement was executed with the final lender group. Corresponds to the effective date of the facility.',
    `co_arranger_list` STRING COMMENT 'Comma-separated list of co-arranger bank names or BIC codes participating in the syndication alongside the bookrunner. Captures the arranger group composition for tombstone records, fee sharing, and regulatory reporting.',
    `commitment_deadline` DATE COMMENT 'The deadline by which prospective lenders must submit their commitments during the bookbuilding phase. Drives the syndication desks investor outreach timeline.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the syndication record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record origination and SOX compliance.',
    `credit_rating_moodys` STRING COMMENT 'The Moodys Investors Service credit rating assigned to the syndicated facility or borrower at the time of syndication (e.g., Ba1, B2, Caa1). Used alongside S&P rating for dual-rating requirements in leveraged loan markets.',
    `credit_rating_sp` STRING COMMENT 'The Standard & Poors credit rating assigned to the syndicated facility or the borrower at the time of syndication (e.g., BB+, B, CCC). Drives investor eligibility, pricing, and regulatory capital treatment.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the syndicated facility (e.g., USD, EUR, GBP). Governs all monetary amounts on this syndication record.. Valid values are `^[A-Z]{3}$`',
    `documentation_standard` STRING COMMENT 'The market documentation standard used for the syndicated loan agreement: LMA (Loan Market Association — EMEA), LSTA (Loan Syndication and Trading Association — US), APLMA (Asia Pacific), or bespoke. Governs transferability, voting thresholds, and secondary market conventions.. Valid values are `LMA|LSTA|APLMA|bespoke`',
    `esg_flag` BOOLEAN COMMENT 'Indicates whether the syndicated facility is structured as an ESG-linked loan or sustainability-linked loan (SLL), where pricing is tied to the borrowers ESG performance targets. Supports green finance reporting and investor ESG mandates.',
    `facility_type` STRING COMMENT 'The structural type of the syndicated credit facility: term_loan_a (amortizing, bank-held), term_loan_b (institutional, bullet), revolving_credit (RCF), bridge_loan (short-term acquisition financing), or delayed_draw (DDTL). Determines investor base and secondary market liquidity.. Valid values are `term_loan_a|term_loan_b|revolving_credit|bridge_loan|delayed_draw`',
    `flex_amount_bps` DECIMAL(18,2) COMMENT 'The magnitude of the pricing flex applied, expressed in basis points. Positive value indicates widening; negative value indicates tightening. Captures the delta between initial price talk and final pricing.',
    `launch_date` DATE COMMENT 'The date on which the syndication was formally launched to the market, i.e., when the information memorandum and term sheet were distributed to prospective lenders.',
    `league_table_credit` STRING COMMENT 'Determines how this syndication is credited in investment banking league tables: full_credit (sole bookrunner), pro_rata (shared among joint bookrunners), or no_credit (co-arranger only). Drives competitive ranking and business development reporting.. Valid values are `full_credit|pro_rata|no_credit`',
    `lender_count` STRING COMMENT 'The total number of lenders in the final syndicate at close. Indicates syndication breadth and diversification of the lender group; used in post-deal analytics and tombstone records.',
    `leveraged_loan_flag` BOOLEAN COMMENT 'Indicates whether the syndicated facility meets the OCC/Fed/FDIC definition of a leveraged loan (typically total debt/EBITDA > 4x or borrower rated below investment grade). Triggers enhanced regulatory scrutiny and reporting under interagency leveraged lending guidance.',
    `mandate_date` DATE COMMENT 'The date on which the borrower formally awarded the syndication mandate to the arranging bank(s). Marks the start of the syndication process and triggers fee accrual.',
    `oid_bps` DECIMAL(18,2) COMMENT 'The original issue discount expressed in basis points, representing the upfront discount to par at which the loan is issued to lenders. Common in leveraged loan syndications; impacts lender yield and borrower all-in cost.',
    `oversubscription_amount` DECIMAL(18,2) COMMENT 'The amount by which investor commitments exceeded the target syndication amount during bookbuilding. A positive value indicates strong market demand; used for pricing flex decisions and greenshoe allocation.',
    `pricing_date` DATE COMMENT 'The date on which final pricing (spread, OID, fees) was determined and communicated to lenders. Marks the transition from bookbuilding to allocation in the syndication lifecycle.',
    `pricing_flex_type` STRING COMMENT 'Indicates the direction of pricing flex applied during bookbuilding: tightened (spread reduced due to oversubscription), held (no change), flexed_wider (spread increased due to weak demand), oid_added, oid_increased, or structure_changed. Key indicator of market reception.. Valid values are `tightened|held|flexed_wider|oid_added|oid_increased|structure_changed`',
    `purpose_code` STRING COMMENT 'The stated purpose of the syndicated facility: acquisition_finance, leveraged_buyout (LBO), refinancing, general_corporate, capital_expenditure (capex), or working_capital. Used for regulatory classification, OCC leveraged lending identification, and portfolio analytics.. Valid values are `acquisition_finance|lbo|refinancing|general_corporate|capex|working_capital`',
    `reference` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the syndication transaction, used in deal communications, tombstones, and regulatory filings. Corresponds to the deal reference in Loan IQ.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The credit spread over the reference rate expressed in basis points (BPS) at which the syndicated facility is priced. Core pricing parameter for lender economics and secondary market trading.',
    `syndication_status` STRING COMMENT 'Current lifecycle state of the syndication process: mandate_awarded (bank selected as arranger), launched (syndication formally opened to market), bookbuilding (collecting lender commitments), priced (spread and terms finalized), closed (facility fully allocated), withdrawn (deal pulled from market), failed (insufficient demand). [ENUM-REF-CANDIDATE: mandate_awarded|launched|bookbuilding|priced|closed|withdrawn|failed|post_close — promote to reference product]',
    `syndication_type` STRING COMMENT 'Classification of the syndication structure: primary_syndication (initial distribution to lender group), secondary_sell_down (post-close transfer of hold), club_deal (small bilateral group), best_efforts (no underwriting commitment), underwritten (bank commits full amount). [ENUM-REF-CANDIDATE: primary_syndication|secondary_sell_down|club_deal|best_efforts|underwritten|participation — promote to reference product]. Valid values are `primary_syndication|secondary_sell_down|club_deal|best_efforts|underwritten`',
    `target_selldown_amount` DECIMAL(18,2) COMMENT 'The target amount the bank aims to distribute to third-party lenders through the syndication process. Equals total_facility_amount minus bank_hold_amount at deal inception; may be revised during bookbuilding.',
    `tenor_months` STRING COMMENT 'The contractual tenor of the syndicated facility expressed in months from the close date to final maturity. Key parameter for duration risk, regulatory capital, and investor suitability assessment.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether the bank has received borrower consent to publicize this transaction in a tombstone announcement. Required before any deal announcement in pitch books, league tables, or press releases.',
    `total_facility_amount` DECIMAL(18,2) COMMENT 'Gross size of the syndicated credit facility or capital markets transaction in the deal currency. Represents the full commitment amount before any sell-down or hold reduction.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the syndication record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change data capture (CDC) in the Databricks Silver layer ETL pipeline and audit compliance.',
    `upfront_fee_bps` DECIMAL(18,2) COMMENT 'The upfront participation fee paid to lenders expressed in basis points of their commitment. Incentivizes early commitment during bookbuilding and is a key component of lender all-in yield.',
    CONSTRAINT pk_investment_syndication PRIMARY KEY(`investment_syndication_id`)
) COMMENT 'Master entity for syndicated lending and capital markets syndication activities. Captures syndication type (primary syndication, secondary sell-down, club deal), total facility size, banks hold amount, target sell-down amount, syndication status, bookrunner role, co-arranger list, syndication launch date, and pricing flex. Supports loan syndication desk operations and CLO/ABS structuring activities.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`syndication_allocation` (
    `syndication_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each syndication allocation line-item record in the silver layer lakehouse. Primary key for this transactional line entity.',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or mandate record. Links the syndication allocation back to the originating M&A, DCF, or capital markets advisory deal in the deal pipeline.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Syndication participations create loan assets on balance sheet that must be posted to specific GL accounts for financial reporting and regulatory capital (RWA) calculation. Replaces denormalized gl_ac',
    `investment_syndication_id` BIGINT COMMENT 'Foreign key reference to the parent syndication deal or tranche header record. Links this allocation line to the overarching syndicated loan or bond facility from which it is derived.',
    `org_unit_id` BIGINT COMMENT 'Reference to the internal syndication desk or business unit responsible for managing this allocation. Used for PnL attribution, revenue allocation, and line-of-business (LOB) reporting.',
    `party_id` BIGINT COMMENT 'Reference to the investor or lender institution receiving this allocation. Identifies the counterparty bank, fund, or institutional investor participating in the syndicated facility.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Reference rate type links to rate_benchmark for participant-specific pricing, IBOR fallback provisions, and interest payment calculations per participation agreement.',
    `tranche_id` BIGINT COMMENT 'Reference to the specific tranche of the syndicated facility being allocated (e.g., Term Loan A, Term Loan B, Revolving Credit Facility). A syndication may have multiple tranches with separate allocation books.',
    `actual_settlement_date` DATE COMMENT 'The actual date on which settlement was completed for this allocation. May differ from the scheduled settlement date due to failed settlements, late funding, or operational delays. Used for settlement reconciliation and SLA monitoring.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The principal monetary amount of the syndicated loan or bond tranche allocated to this participant institution. Represents the participants share of the total facility commitment in the deal currency.',
    `allocation_date` DATE COMMENT 'The business date on which the syndication desk formally allocated this tranche amount to the participant institution. Marks the principal real-world event time for this allocation line-item.',
    `allocation_reference` STRING COMMENT 'Externally-known business identifier for this allocation line, as generated by the Loan IQ syndication module or the syndication desk. Used in participant confirmation notices, participation agreements, and settlement instructions.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle state of this syndication allocation line. Tracks progression from indicative interest through firm commitment, final allocation, settlement, and any post-close transfers or cancellations.. Valid values are `indicative|firm|allocated|settled|cancelled|transferred`',
    `allocation_type` STRING COMMENT 'Classifies whether this allocation is part of the primary syndication (initial distribution), a secondary sell-down (post-close transfer of risk), a formal loan transfer, or a sub-participation arrangement. Determines accounting treatment and regulatory capital impact.. Valid values are `primary|secondary_selldown|transfer|sub_participation`',
    `arrangement_fee_amount` DECIMAL(18,2) COMMENT 'The upfront arrangement or structuring fee allocated to this participant as part of the syndication economics. Paid by the borrower and distributed among arrangers and participants per the fee letter.',
    `booking_entity_code` STRING COMMENT 'The legal entity code of the banks booking entity that holds this allocation on its balance sheet. Critical for regulatory capital reporting, FATCA/CRS entity-level reporting, and intercompany reconciliation in multi-entity banking groups.. Valid values are `^[A-Z0-9]{3,10}$`',
    `commitment_date` DATE COMMENT 'The date on which the participant institution submitted its commitment (firm or soft) to participate in the syndication. Precedes the allocation date and is used to track the book-building timeline.',
    `commitment_type` STRING COMMENT 'Nature of the participants commitment to the allocation. Firm commitments are legally binding; soft commitments are indicative and subject to withdrawal; sub-underwrite and underwrite indicate risk-taking obligations; best_efforts indicates no guaranteed take-down.. Valid values are `firm|soft|sub-underwrite|underwrite|best_efforts`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this syndication allocation record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, data lineage, and SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD, EUR, GBP). Determines the settlement currency and FX conversion requirements for cross-border syndications.. Valid values are `^[A-Z]{3}$`',
    `ead_amount` DECIMAL(18,2) COMMENT 'The exposure at default (EAD) for this allocation, representing the expected outstanding balance at the time of default. Includes drawn amounts plus estimated undrawn commitments for revolving facilities. Core input to ECL and RWA calculations.',
    `effective_date` DATE COMMENT 'The date from which this allocation becomes legally binding and the participants obligations under the participation agreement commence. Aligns with the facility closing date or drawdown date.',
    `expiry_date` DATE COMMENT 'The date on which this allocation commitment expires if not settled or transferred. Applicable to revolving credit facilities and unfunded commitments where the participants obligation has a defined end date.',
    `fee_share_pct` DECIMAL(18,2) COMMENT 'The participants proportional share of total syndication fees expressed as a decimal percentage. Used to calculate the participants entitlement to arrangement, participation, and agency fees distributed from the fee pool.',
    `ftp_rate` DECIMAL(18,2) COMMENT 'The internal Funds Transfer Pricing (FTP) rate applied to this allocation for internal profitability measurement and ALCO reporting. Used by the Treasury function to allocate the cost of funds and liquidity premium to the originating business line.',
    `hold_amount` DECIMAL(18,2) COMMENT 'The final amount the participant intends to retain on its own balance sheet after any secondary sell-down. Represents the net retained exposure post-syndication and is used for RWA and capital adequacy calculations.',
    `instrument_type` STRING COMMENT 'The type of debt instrument being allocated to the participant. Determines the applicable documentation standard (LMA/LSTA), interest calculation convention, and regulatory capital treatment under Basel III.. Valid values are `term_loan|revolving_credit|bridge_loan|bond|mezzanine|delayed_draw`',
    `interest_spread_bps` DECIMAL(18,2) COMMENT 'The credit spread in basis points (BPS) over the reference rate (e.g., SOFR, EURIBOR) applicable to this participants allocation. Determines the participants interest income on the allocated commitment.',
    `is_agent_bank` BOOLEAN COMMENT 'Indicates whether the participant institution is also acting as the facility agent or security agent for the syndicated loan. The agent bank administers payments, waivers, and amendments on behalf of the lender group.',
    `is_lead_arranger` BOOLEAN COMMENT 'Indicates whether the participant institution is acting as lead arranger or bookrunner for this syndication. Lead arrangers have additional obligations including book-building, documentation, and agent responsibilities.',
    `lgd_pct` DECIMAL(18,2) COMMENT 'The loss given default (LGD) estimate for this allocation expressed as a decimal percentage of the exposure at default (EAD). Used in ECL provisioning under IFRS 9/CECL and regulatory capital calculations under the IRB approach.',
    `notes` STRING COMMENT 'Free-text field for syndication desk commentary, special conditions, or exceptions associated with this allocation. May include investor-specific terms, waiver notes, or documentation exceptions agreed during the book-building process.',
    `participant_role` STRING COMMENT 'Role of the participant institution in the syndication structure. Determines fee entitlement, voting rights, and reporting obligations. Lead arrangers and bookrunners typically receive higher arrangement fees.. Valid values are `lead_arranger|co_arranger|bookrunner|underwriter|participant|agent`',
    `participation_agreement_ref` STRING COMMENT 'Reference number or identifier of the executed participation agreement between the arranger and the participant institution governing the terms of this allocation. Used for legal documentation reconciliation.',
    `participation_fee_amount` DECIMAL(18,2) COMMENT 'Fee paid to the participant institution for joining the syndication, typically expressed as basis points (BPS) on the allocated commitment. Distinct from the arrangement fee paid to the lead arranger.',
    `participation_pct` DECIMAL(18,2) COMMENT 'The participant institutions pro-rata share of the total syndicated facility expressed as a decimal percentage (e.g., 0.125000 = 12.5%). Used to calculate pro-rata distributions of interest, fees, and principal repayments.',
    `pd_rating` DECIMAL(18,2) COMMENT 'The probability of default (PD) assigned to the participant or the underlying borrower for this allocation, expressed as a decimal (e.g., 0.005 = 0.5%). Used in ECL calculations under IFRS 9/CECL and IRB capital models.',
    `regulatory_capital_approach` STRING COMMENT 'The Basel III regulatory capital approach applied to this allocation for RWA calculation: Standardized Approach (SA), Foundation Internal Ratings-Based (IRB), or Advanced IRB. Determines the methodology used in CCAR/DFAST stress testing submissions.. Valid values are `SA|IRB_foundation|IRB_advanced`',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The risk-weighted asset (RWA) amount attributable to this allocation, calculated under the Basel III Standardized Approach (SA) or Internal Ratings-Based (IRB) approach. Used for capital adequacy reporting under CCAR/DFAST and CET1 ratio calculations.',
    `settlement_date` DATE COMMENT 'The date on which funds are expected to be transferred from the participant to the agent bank, completing the settlement of this allocation. Used for liquidity planning, RTGS scheduling, and reconciliation with the Payment Processing Hub.',
    `syndication_market` STRING COMMENT 'The market segment classification of the syndicated facility. Investment grade and leveraged loans have different documentation standards, pricing conventions, and regulatory capital treatments. Used for portfolio segmentation and regulatory reporting.. Valid values are `investment_grade|leveraged|project_finance|real_estate|trade_finance`',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether this allocation qualifies for inclusion in the deal tombstone record, which publicly commemorates the completed transaction. Tombstone eligibility is typically limited to lead arrangers, bookrunners, and significant participants above a minimum threshold.',
    `underwrite_amount` DECIMAL(18,2) COMMENT 'The amount of the facility that the participant has underwritten (i.e., committed to take onto its own balance sheet if the syndication is not fully subscribed). May differ from the final allocated amount after sell-down.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this syndication allocation record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), ETL processing, and audit trail maintenance.',
    CONSTRAINT pk_syndication_allocation PRIMARY KEY(`syndication_allocation_id`)
) COMMENT 'Transactional line-item record capturing the allocation of syndicated loan or bond tranches to individual investor or lender participants. Records participant institution, allocated amount, participation percentage, commitment type (firm, soft), allocation date, settlement date, participation agreement reference, and fee share. Child of syndication — enables the syndication desk to manage investor books, track commitments, finalize allocations for primary syndication and secondary sell-down, and reconcile with settlement systems.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`underwriting` (
    `underwriting_id` BIGINT COMMENT 'Primary key for underwriting',
    `alco_meeting_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_meeting. Business justification: Material underwriting commitments are reviewed by ALCO due to capital and liquidity implications. Business process: ALCO approval workflow for capital markets commitments ensures adequate capital and ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Institutional funds are cornerstone investors in underwritten equity and debt offerings, often receiving anchor allocations. Real business process: pre-marketing to anchor investors, allocation manage',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Underwriting commitments for municipal bonds, regional offerings, or private placements are booked through specific branch locations (regional/community banking underwriting desks). Required for branc',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Underwriting commitments are made for specific capital markets offerings. While both underwriting and offering reference deal_id, one deal can have multiple offerings (e.g., primary offering + greensh',
    `capital_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_ratio. Business justification: Underwriting commitments consume regulatory capital (RWA) and impact CET1 ratios. Business process: capital planning and CCAR stress testing include capital markets pipeline exposures in RWA projectio',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Underwritten securities (ABS, MBS, covered bonds) are backed by collateral pools that must be tracked for prospectus disclosure and investor reporting. Real process: asset-backed securities issuance, ',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Underwriting commitments require SEC filings (S-1, 424B prospectuses, 8-Ks). Direct regulatory filing obligation under Securities Act. Compliance tracks filing status, acknowledgments, and amendments ',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Underwriting commitments generate credit exposure to issuers requiring capital allocation, limit monitoring, and regulatory capital calculation. Links underwriting transactions to EAD and RWA for Base',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or transaction for which this underwriting commitment is being made. Links to the deal pipeline entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Underwriting commitments require a responsible banker for risk ownership, capital allocation approval, and P&L attribution. Regulatory capital frameworks (Basel III) and internal risk management requi',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Underwriting commitments are major audit subjects for risk exposure assessment, capital adequacy calculation, regulatory compliance (SEC registration), revenue recognition, and stabilization activity ',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Underwriting commitments may require pre-arranged funding capacity to ensure settlement capability. Business process: treasury coordinates with capital markets to ensure funding availability for under',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Underwriting commitments are for specific securities, not just issuers. Required for inventory risk management, stabilization trading, greenshoe exercise, settlement instructions, and fee calculation ',
    `issuer_id` BIGINT COMMENT 'Reference to the corporate or sovereign issuer (client) on whose behalf the bank is underwriting the securities offering.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Underwriting commitments create contingent liabilities that must be tracked by legal entity for regulatory capital (market risk, underwriting risk), financial statement disclosure (IAS 37), and legal ',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Underwriting commitments create contingent liquidity obligations tracked in liquidity stress scenarios. Business process: regulatory liquidity reporting (LCR/NSFR) includes underwriting exposures as p',
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Underwriting commitments create market risk positions (inventory risk, price risk, spread risk) requiring VaR calculation, hedging strategies, and trading desk risk limits. Essential for capital marke',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Security type classification drives FRTB book assignment, IFRS 9 classification, regulatory capital treatment, and Volcker Rule compliance for underwriting inventory.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Instrument identifier (ISIN/CUSIP) required for securities master data, trade confirmation matching, regulatory reporting (MiFID II, Dodd-Frank), and settlement instructions.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Underwriting practices reviewed in SEC, FINRA exams for compliance with securities laws, disclosure requirements, Reg M stabilization rules, and allocation fairness. Examiners trace underwriting commi',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Regulatory jurisdiction determines prospectus requirements (SEC S-1, EU Prospectus Regulation), underwriting agreement enforceability, and securities law compliance framework.',
    `agreement_date` DATE COMMENT 'The date on which the formal underwriting agreement between the bank (and co-underwriters) and the issuer was executed. This is the legally binding contract governing the terms of the underwriting commitment.',
    `bank_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the total offering size allocated to this bank as its underwriting commitment share within the syndicate. Determines the banks proportional fee entitlement and risk exposure.',
    `book_runner_flag` BOOLEAN COMMENT 'Indicates whether the bank is acting as a bookrunner (lead or joint) for this offering, responsible for managing the order book during the book-building process. True if the bank has bookrunner responsibilities; False for co-manager or selling group roles.',
    `commitment_date` DATE COMMENT 'The date on which the bank formally committed to underwrite the offering, typically coinciding with the signing of the mandate letter or underwriting agreement. Marks the start of the banks underwriting risk exposure period.',
    `commitment_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to this underwriting commitment, used in mandate letters, syndicate agreements, and regulatory filings. Format: LOB-UW-YYYY-NNNNNN.. Valid values are `^[A-Z]{2,4}-UW-[0-9]{4}-[0-9]{6}$`',
    `commitment_status` STRING COMMENT 'Current lifecycle state of the underwriting commitment. Mandated: bank has received the mandate; Active: commitment is live during the offering period; Priced: pricing has been set; Closed: transaction has settled; Withdrawn: issuer withdrew the offering; Terminated: commitment cancelled prior to pricing.. Valid values are `mandated|active|priced|closed|withdrawn|terminated`',
    `commitment_type` STRING COMMENT 'Classification of the underwriting commitment structure. Firm commitment means the bank purchases all securities and resells them; best efforts means the bank sells as much as possible without guaranteeing the full amount; standby is used in rights offerings; all-or-none requires full subscription or cancellation; mini-max sets a minimum threshold.. Valid values are `firm_commitment|best_efforts|standby|all_or_none|mini_max`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this underwriting commitment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, data lineage, and SOX (Sarbanes-Oxley Act) compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the underwritten amount and all fee fields on this commitment (e.g., USD, EUR, GBP, JPY). Required for multi-currency reporting and FX (Foreign Exchange) risk management.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date on which the SEC registration statement became effective, permitting the public sale of securities. For Rule 144A transactions, this is the date the offering memorandum was finalized.',
    `expected_fee_revenue` DECIMAL(18,2) COMMENT 'The banks expected gross fee revenue from this underwriting commitment, calculated as the banks allocated underwriting spread applied to its committed underwriting amount. Used for revenue forecasting, deal profitability analysis, and RAROC (Risk-Adjusted Return on Capital) calculations.',
    `fee_bps` DECIMAL(18,2) COMMENT 'The portion of the underwriting spread allocated as the underwriting fee, expressed in basis points. Compensates syndicate members for bearing the underwriting risk during the offering period.',
    `greenshoe_option_amount` DECIMAL(18,2) COMMENT 'The maximum additional amount (in base currency) that the underwriters may purchase from the issuer under the over-allotment (greenshoe) option, typically up to 15% of the base offering size. Exercised to stabilize the aftermarket price. Named after the Green Shoe Manufacturing Company, the first company to use this mechanism.',
    `greenshoe_option_flag` BOOLEAN COMMENT 'Indicates whether an over-allotment (greenshoe) option has been granted to the underwriters in this transaction. True if a greenshoe option exists; False if no over-allotment option is included.',
    `league_table_eligible_flag` BOOLEAN COMMENT 'Indicates whether this transaction qualifies for inclusion in investment banking league table rankings (e.g., Bloomberg, Dealogic, Thomson Reuters). Transactions may be excluded due to size thresholds, role limitations, or issuer type restrictions.',
    `lock_up_period_days` STRING COMMENT 'The number of days following the offering during which existing shareholders and insiders are contractually prohibited from selling their shares. Typically 90 or 180 days for IPOs. Relevant for aftermarket risk management and secondary trading restrictions.',
    `management_fee_bps` DECIMAL(18,2) COMMENT 'The portion of the underwriting spread allocated as the management fee, expressed in basis points. Compensates the lead manager(s) for structuring, due diligence, and transaction management responsibilities.',
    `mandate_letter_date` DATE COMMENT 'The date on which the issuer formally awarded the underwriting mandate to the bank via a signed mandate letter. Precedes the commitment date and marks the formal engagement of the bank as underwriter.',
    `offering_price` DECIMAL(18,2) COMMENT 'The final public offering price per unit (share or bond face value) at which securities are sold to investors. For equity, expressed as price per share; for debt, expressed as a percentage of par value. Determined at pricing date.',
    `offering_size` DECIMAL(18,2) COMMENT 'The total gross proceeds of the offering at the offering price, representing the full transaction size including any greenshoe option if exercised. Distinct from underwritten_amount which reflects only the banks committed portion.',
    `offering_type` STRING COMMENT 'Classification of the securities offering structure. IPO (Initial Public Offering) is the first public sale; follow-on is a subsequent equity offering; 144A is a private placement to qualified institutional buyers; Reg S covers offshore offerings. [ENUM-REF-CANDIDATE: ipo|follow_on|secondary|rights_offering|private_placement|144a|reg_s|block_trade — promote to reference product]',
    `pricing_date` DATE COMMENT 'The date on which the final offering price and size are determined through the book-building process. Marks the end of the primary underwriting risk period for firm commitment transactions as the spread is locked in.',
    `prospectus_type` STRING COMMENT 'The type of SEC registration statement or offering document filed for this transaction. S-1 is the standard IPO registration; S-3 is for seasoned issuers; F-1 is for foreign private issuers; 424B is the final prospectus; offering memorandum is used for 144A/Reg S private placements. [ENUM-REF-CANDIDATE: s1|f1|s3|s11|424b|offering_memorandum|prospectus_supplement|base_prospectus — promote to reference product]',
    `roadshow_start_date` DATE COMMENT 'The date on which the investor roadshow commenced for this offering. The roadshow is the marketing period during which management presents to institutional investors prior to pricing.',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The Risk-Weighted Assets (RWA) amount attributable to this underwriting commitment, calculated per Basel III standardized or internal ratings-based (IRB) approach. Drives capital charge allocation and CET1 (Common Equity Tier 1) consumption reporting.',
    `sec_file_number` STRING COMMENT 'The Securities and Exchange Commission (SEC) file number assigned to the registration statement for this offering (e.g., 333-XXXXXX for Securities Act registrations). Used for regulatory tracking and EDGAR cross-referencing.. Valid values are `^[0-9]{3}-[0-9]{5,6}$`',
    `selling_concession_bps` DECIMAL(18,2) COMMENT 'The portion of the underwriting spread allocated as the selling concession, expressed in basis points. Paid to dealers and selling group members for distributing securities to end investors.',
    `settlement_date` DATE COMMENT 'The date on which the securities are delivered to investors and proceeds are remitted to the issuer. Typically T+1 for US equity offerings and T+2 or T+3 for debt. Marks the completion of the underwriting commitment.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this underwriting commitment record originated (e.g., MUREX or CALYPSO for trading/deal capture, DEALOGIC for deal tracking, LOAN_IQ for syndicated lending mandates). Required for data lineage and ETL reconciliation.. Valid values are `MUREX|CALYPSO|DEALOGIC|MANUAL|BLOOMBERG|LOAN_IQ`',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier of this underwriting commitment in the originating operational system of record (e.g., Murex deal ID, Calypso transaction ID, Dealogic deal reference). Enables bi-directional traceability between the lakehouse silver layer and the source system.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The total underwriting spread expressed in basis points (BPS), representing the difference between the price paid to the issuer and the public offering price. This is the primary revenue metric for the underwriting commitment and is split among syndicate members per the fee allocation agreement.',
    `stabilization_flag` BOOLEAN COMMENT 'Indicates whether the bank is acting as stabilizing manager for this offering, authorized to conduct price stabilization transactions in the aftermarket to support the offering price. True if the bank has stabilization responsibilities.',
    `syndicate_role` STRING COMMENT 'The banks role within the underwriting syndicate. Lead bookrunner has primary responsibility for book building and allocation; joint bookrunner shares that responsibility; co-manager has a smaller participation; selling group members distribute but do not underwrite. Determines fee economics and regulatory obligations.. Valid values are `sole_bookrunner|lead_bookrunner|joint_bookrunner|co_manager|selling_group`',
    `tombstone_flag` BOOLEAN COMMENT 'Indicates whether a tombstone advertisement has been published for this completed transaction. Tombstones are formal announcements of completed capital markets transactions and serve as marketing credentials for the banks league table rankings.',
    `underwritten_amount` DECIMAL(18,2) COMMENT 'The gross principal amount (in base currency) that the bank has committed to underwrite for this transaction. For firm commitment deals, this represents the banks maximum financial exposure prior to distribution. Key input for RWA (Risk-Weighted Assets) and capital charge calculations under Basel III.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this underwriting commitment record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data lineage, and incremental ETL (Extract Transform Load) processing.',
    CONSTRAINT pk_underwriting PRIMARY KEY(`underwriting_id`)
) COMMENT 'Master entity representing the banks underwriting commitment for equity or debt capital markets transactions. Captures commitment type (firm commitment, best efforts, standby), underwritten amount, underwriting spread, over-allotment option (greenshoe), commitment date, pricing date, settlement date, and syndicate role (lead bookrunner, joint bookrunner, co-manager). Tracks the banks risk exposure during the underwriting period.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`investment_investor_order` (
    `investment_investor_order_id` BIGINT COMMENT 'Unique surrogate identifier for each investor order record in the bookbuilding order book. Primary key for the investor_order data product.',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: Large or unusual investor orders trigger transaction monitoring alerts (structuring, layering patterns, rapid turnover). AML surveillance systems flag orders exceeding thresholds or exhibiting suspici',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Investor orders in capital markets offerings placed through branch locations (retail IPO participation, regional institutional desks) require branch tracking for regulatory reporting (SEC Rule 15c2-8,',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Investor orders are placed during bookbuilding for a specific capital markets offering. While investor_order has deal_id, one deal can have multiple offerings. Orders must reference the specific offer',
    `coverage_assignment_id` BIGINT COMMENT 'Reference to the sales professional or relationship manager who solicited or managed this investor order on behalf of the bookrunner. Used for sales credit attribution, commission calculation, and investor relationship tracking.',
    `deal_id` BIGINT COMMENT 'Reference to the parent capital markets transaction (ECM or DCM deal) for which this investor order was submitted during the bookbuilding process.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Investor orders require a covering banker for relationship credit attribution, order dispute resolution, and regulatory best execution reporting (MiFID II). Capital markets operations track which bank',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Investor orders in offerings are for specific instruments. Required for order book management, allocation algorithms, settlement file generation, and post-IPO position reconciliation. Complements exis',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Investor geography required for Reg S/144A eligibility determination, geographic allocation analysis, and cross-border securities offering compliance.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the investment bank or syndicate member acting as bookrunner who received and recorded this investor order. In syndicated deals, multiple bookrunners may collect orders from different investor segments.',
    `party_id` BIGINT COMMENT 'Reference to the institutional or retail investor entity that submitted this order. Links to the investor master record for KYC and AML compliance purposes.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every investor order must be screened against OFAC/sanctions lists before allocation. Mandatory compliance control for capital markets offerings. Screening event records match status, disposition, and',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Capital markets investor orders settle cash through specific deposit accounts. Settlement operations require validated account linkage for payment processing, reconciliation, and regulatory reporting ',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the allocation received by the investor, calculated as allocation_size multiplied by allocation_price. Represents the investors financial commitment to the transaction. Used for settlement, fee calculation, and regulatory reporting.',
    `allocation_price` DECIMAL(18,2) COMMENT 'The final deal price per share or per unit at which the investors allocation was confirmed. Typically the IPO offer price or bond issue price. Used for settlement and P&L attribution.',
    `allocation_size` DECIMAL(18,2) COMMENT 'The number of shares or face value amount actually allocated to the investor following the bookrunners allocation decision at deal pricing. Zero if the order was not filled. Compared against order_size to determine fill ratio.',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date and time at which the allocation decision was communicated to the investor following deal pricing. Marks the transition from bookbuilding to allocation phase. Used for settlement timeline tracking (T+1, T+2).',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time at which the investor cancelled or withdrew the order from the book. Null if the order was not cancelled. Used for demand attrition analysis and bookbuilding audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investor order record was first captured and persisted in the order management system. Used for audit trail and data lineage purposes. May differ from order_timestamp if there is a processing lag.',
    `custodian_name` STRING COMMENT 'Name of the custodian bank or prime broker responsible for holding the allocated securities on behalf of the investor. Used for settlement instruction routing and corporate trust/custody services coordination.',
    `demand_multiple` DECIMAL(18,2) COMMENT 'Ratio of the investors order size to the investors expected or target allocation, indicating the degree of oversubscription at the individual investor level. Used by the bookrunner to assess investor conviction and calibrate allocation decisions.',
    `greenshoe_eligible` BOOLEAN COMMENT 'Indicates whether this investor order is eligible to be filled from the overallotment (greenshoe) option, allowing the bookrunner to allocate up to 15% additional shares beyond the base offering size to cover excess demand.',
    `investor_name` STRING COMMENT 'Legal name of the investor or institution placing the order. Used for order book management, allocation decisions, and regulatory reporting. May represent an institutional fund, asset manager, or individual investor.',
    `investor_tier` STRING COMMENT 'Classification of the investor by tier, which influences allocation priority and deal economics. anchor investors commit pre-IPO with lock-up; cornerstone investors receive guaranteed allocations; institutional covers qualified institutional buyers (QIBs); retail covers individual investors; strategic covers corporate or government investors with strategic interest.. Valid values are `anchor|cornerstone|institutional|retail|strategic`',
    `investor_type` STRING COMMENT 'Categorization of the investor by institutional type. Drives regulatory treatment, allocation policy, and suitability assessment. [ENUM-REF-CANDIDATE: asset_manager|hedge_fund|pension_fund|sovereign_wealth|insurance|bank|family_office|retail|corporate|endowment — promote to reference product]',
    `is_anchor_investor` BOOLEAN COMMENT 'Indicates whether this investor has been designated as an anchor investor for the transaction, committing to a pre-IPO allocation with a lock-up period. Anchor investors receive guaranteed allocations in exchange for early commitment and price support.',
    `is_covered_short` BOOLEAN COMMENT 'Indicates whether the investors order includes a covered short sale component, typically associated with the greenshoe/overallotment option exercise. Relevant for stabilization and price support analysis post-IPO.',
    `kyc_status` STRING COMMENT 'Current KYC/AML compliance status of the investor at the time of order submission. approved indicates KYC checks passed; pending indicates checks in progress; failed indicates KYC not satisfied (order cannot be filled); exempt indicates regulatory exemption applies. Mandatory for AML compliance under BSA and FATCA.. Valid values are `approved|pending|failed|exempt`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this investor order record, including status changes, order amendments, or allocation updates. Supports audit trail and change tracking requirements.',
    `lock_up_period_days` STRING COMMENT 'Number of calendar days the investor is contractually restricted from selling the allocated securities following the deal closing date. Applicable primarily to anchor and cornerstone investors. Zero or null if no lock-up applies.',
    `order_amendment_count` STRING COMMENT 'Number of times the investor has amended this order during the bookbuilding period (e.g., size increases, price limit changes). Tracks investor conviction and demand evolution. Used for bookbuilding analytics and investor behavior analysis.',
    `order_channel` STRING COMMENT 'The channel through which the investor submitted the order to the bookrunner. electronic covers order management system portals; voice covers telephone orders; email covers written email instructions; roadshow covers orders placed during investor roadshow meetings; bloomberg covers Bloomberg order management system submissions.. Valid values are `electronic|voice|email|roadshow|bloomberg`',
    `order_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the investor order is denominated (e.g., USD, EUR, GBP). Required for FX conversion and cross-border deal management.. Valid values are `^[A-Z]{3}$`',
    `order_date` DATE COMMENT 'Calendar date on which the investor submitted the order during the bookbuilding period. Used for day-level reporting and analysis of demand build-up over the bookbuilding timeline.',
    `order_notes` STRING COMMENT 'Free-text field capturing additional instructions, conditions, or commentary provided by the investor or the sales coverage team regarding this order. May include special allocation requests, investment rationale, or bookrunner observations.',
    `order_reference` STRING COMMENT 'Externally-known alphanumeric reference number assigned to this investor order, used for communication between the bookrunner and the investor during the bookbuilding process. Corresponds to the order ticket number in the Trading and Order Management System (e.g., Murex/Calypso).',
    `order_size` DECIMAL(18,2) COMMENT 'The total number of shares (for ECM) or face value amount (for DCM) that the investor has requested in this order. Represents the gross demand submitted by the investor before any allocation decision.',
    `order_status` STRING COMMENT 'Current lifecycle state of the investor order within the bookbuilding process. active indicates the order is live in the book; filled indicates full allocation received; partially_filled indicates partial allocation; cancelled indicates investor withdrew the order; expired indicates the order lapsed at book close.. Valid values are `active|filled|partially_filled|cancelled|expired`',
    `order_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone) at which the investor submitted the order to the bookrunner. This is the principal real-world business event timestamp for the order, critical for time-priority allocation and regulatory audit trail.',
    `order_type` STRING COMMENT 'Classification of the investor order by pricing instruction: strike (accept final IPO/deal price), limit (maximum price the investor will pay), step (tiered quantity at different price levels), capped (maximum size cap), uncapped (no size restriction). Drives bookrunner pricing and allocation logic.. Valid values are `strike|limit|step|capped|uncapped`',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the price limit is expressed. May differ from order_currency in cross-border transactions where the security is priced in a different currency than the order denomination.. Valid values are `^[A-Z]{3}$`',
    `price_limit` DECIMAL(18,2) COMMENT 'The maximum price per share or per unit that the investor is willing to pay for a limit order. Null for strike orders where the investor accepts the final deal price. Used by the bookrunner to determine price sensitivity and construct the demand curve.',
    `regulatory_category` STRING COMMENT 'Regulatory classification of the investor order under applicable securities law. qib = Qualified Institutional Buyer under SEC Rule 144A; reg_s = offshore investor under SEC Regulation S; retail = retail investor under applicable prospectus rules; employee = employee share plan participant; directed = directed share program recipient.. Valid values are `qib|reg_s|retail|employee|directed`',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this investor order was originated or captured. Supports data lineage and ETL audit trail in the Databricks Silver Layer. Typical sources include Murex, Calypso, iPreo (bookbuilding platform), Dealogic, Bloomberg OMS, or manual entry.. Valid values are `murex|calypso|ipreo|dealogic|bloomberg_oms|manual`',
    `step_price_1` DECIMAL(18,2) COMMENT 'First price level for a step order, representing the price at which the investor commits to the quantity specified in step_size_1. Applicable only for order_type = step. Null for non-step orders.',
    `step_price_2` DECIMAL(18,2) COMMENT 'Second price level for a step order, representing the price at which the investor commits to the quantity specified in step_size_2. Null for non-step orders or step orders with only one tier.',
    `step_size_1` DECIMAL(18,2) COMMENT 'Quantity (shares or face value) the investor will take at step_price_1 in a step order. Represents the first tier of a tiered demand schedule. Null for non-step orders.',
    `step_size_2` DECIMAL(18,2) COMMENT 'Quantity (shares or face value) the investor will take at step_price_2 in a step order. Represents the second tier of a tiered demand schedule. Null for non-step orders.',
    CONSTRAINT pk_investment_investor_order PRIMARY KEY(`investment_investor_order_id`)
) COMMENT 'Transactional record capturing individual investor orders received during the bookbuilding process for ECM and DCM transactions. Records investor name, order type (strike, limit, step), order size, price limit, order date and time, order status (active, filled, cancelled), allocation received, and investor tier classification. Enables bookrunner to manage the order book and determine final pricing and allocation.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`tombstone` (
    `tombstone_id` BIGINT COMMENT 'Unique surrogate identifier for the tombstone record representing a completed investment banking transaction commemorative record.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Tombstones for capital markets transactions should reference the specific offering. Not all tombstones are for offerings (M&A tombstones exist), so this FK is nullable. When tombstone commemorates a c',
    `deal_id` BIGINT COMMENT 'Reference to the parent deal or mandate record in the investment banking deal pipeline from which this tombstone was generated.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Local currency required for tombstone publication, league table credit calculation, and deal value reporting in both local and USD terms.',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Industry sector required for sector-specific league table rankings, industry expertise demonstration, and tombstone publication with sector classification.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Tombstones commemorate deals that create securities. Links tombstone to instrument for deal term verification (size, pricing) against instrument master data, league table dispute resolution, and marke',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.mandate. Business justification: Tombstones commemorate completed deals that had formal mandate agreements. tombstone.mandate_reference (STRING) should be replaced with FK to mandate.mandate_id to enable retrieval of full mandate det',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: League table credits and tombstone publications must be attributed to the specific legal entity that executed the transaction for regulatory reporting (MiFID II transaction reporting), marketing compl',
    `party_id` BIGINT COMMENT 'Reference to the primary client (issuer, acquirer, or borrower) for whom the investment banking transaction was executed.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Tombstone publication and client approval occurs through specific channels (email via digital, physical presentation at branch, RM delivery). Marketing and compliance teams track publication channel f',
    `accepted_credit_amount_usd` DECIMAL(18,2) COMMENT 'The USD credit amount formally accepted by the league table provider after review and any dispute resolution. May differ from the claimed credit_amount_usd if the provider applies a different methodology or partially accepts the submission.',
    `advisory_fee_usd` DECIMAL(18,2) COMMENT 'Total advisory or underwriting fee earned by the bank on the transaction, expressed in USD. Used for revenue recognition, profitability analysis, and fee benchmarking. Classified as confidential as it represents commercially sensitive deal economics.',
    `announcement_date` DATE COMMENT 'Date on which the investment banking transaction was publicly announced to the market, as reported to regulators and disclosed in press releases.',
    `bank_role` STRING COMMENT 'The role of the bank in the transaction as it appears on the tombstone and is used for league table credit assignment. Determines the credit methodology applied (e.g., full credit for Sole Advisor, pro-rata for Joint Bookrunner). [ENUM-REF-CANDIDATE: Sole Advisor|Joint Advisor|Lead Manager|Joint Bookrunner|Co-Manager|Arranger|Underwriter|Syndication Agent|Administrative Agent — promote to reference product]',
    `bookrunner_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the total deal allocated to this bank as bookrunner, expressed as a decimal (e.g., 33.3333 for one-third share). Used in bookrunner credit methodology to calculate the banks proportional league table credit amount.',
    `client_name` STRING COMMENT 'Legal name of the primary client (issuer, acquirer, target, or borrower) as it appears on the tombstone advertisement and in league table submissions.',
    `closing_date` DATE COMMENT 'Date on which the investment banking transaction was legally completed and all conditions precedent were satisfied. This is the primary business event date used for league table credit assignment and tombstone publication.',
    `co_advisor_names` STRING COMMENT 'Comma-separated list of co-advisors, co-managers, or joint bookrunners participating in the transaction alongside the bank. Used for competitive intelligence, league table credit sharing analysis, and tombstone advertisement content.',
    `coverage_banker_name` STRING COMMENT 'Full name of the senior investment banker or managing director responsible for the client relationship and transaction execution. Used for deal attribution, performance management, and pitch book preparation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tombstone record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record creation and data lineage tracking.',
    `credit_amount_usd` DECIMAL(18,2) COMMENT 'The USD dollar amount of league table credit claimed by the bank for this transaction submission. Calculated based on the credit methodology (e.g., full deal value for sole advisor, pro-rata share for joint bookrunners). This is the primary metric used to determine league table rankings.',
    `credit_methodology` STRING COMMENT 'The credit allocation methodology applied to calculate the banks league table credit amount. Full Credit = 100% of deal value; Pro-Rata = deal value divided equally among all bookrunners; Equal Credit = each bookrunner receives full deal value credit; Bookrunner Credit = credit based on bookrunner allocation percentage.. Valid values are `Full Credit|Pro-Rata|Equal Credit|Bookrunner Credit|Advisor Credit`',
    `deal_value_local` DECIMAL(18,2) COMMENT 'Total transaction value expressed in the original deal currency (local currency) before conversion to USD. Used for regional league table submissions and local market reporting.',
    `deal_value_usd` DECIMAL(18,2) COMMENT 'Total transaction value in US dollars as reported for league table credit purposes. For M&A, this is the enterprise value or equity value of the target. For ECM/DCM, this is the total proceeds raised. For syndicated loans, this is the total facility size. Used as the primary monetary measure for competitive positioning and market share analysis.',
    `dispute_reason` STRING COMMENT 'Narrative description of the reason for the league table credit dispute, including the basis of the challenge (e.g., incorrect role classification, deal value discrepancy, closing date eligibility, credit methodology disagreement).',
    `dispute_status` STRING COMMENT 'Status of any dispute raised against the league table credit submission. no_dispute = credit accepted without challenge; disputed = credit challenged by a competitor or the provider; under_review = provider is reviewing the dispute; resolved = dispute settled; rejected = credit claim rejected by provider.. Valid values are `no_dispute|disputed|under_review|resolved|rejected`',
    `fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the advisory fee was contractually agreed and invoiced (e.g., USD, EUR, GBP). May differ from deal_currency for cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `fx_rate_to_usd` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the deal value from local currency to USD at the time of closing, used for standardized league table credit calculations across currencies.',
    `is_cross_border` BOOLEAN COMMENT 'Indicates whether the transaction involves parties from different countries (True) or is a domestic transaction (False). Cross-border transactions may qualify for separate geographic league table categories and require additional regulatory disclosures.',
    `is_tombstone_client_approved` BOOLEAN COMMENT 'Indicates whether the client has formally approved the tombstone advertisement content and publication (True) or approval is still pending (False). Client approval is required before tombstone publication per standard investment banking practice and FINRA communications rules.',
    `league_table_product_category` STRING COMMENT 'Product category under which the transaction is submitted for league table credit. M&A = Mergers and Acquisitions advisory; ECM = Equity Capital Markets; DCM = Debt Capital Markets; Loans = Syndicated Lending. A single transaction may be submitted under multiple categories.. Valid values are `M&A|ECM|DCM|Loans|Restructuring|All Products`',
    `league_table_provider` STRING COMMENT 'Name of the league table data provider to which this credit submission is made. Each provider has distinct credit methodologies and product category definitions. Dealogic, Bloomberg, and Refinitiv (LSEG) are the primary providers used for investment banking competitive positioning.. Valid values are `Dealogic|Bloomberg|Refinitiv|Mergermarket|LSEG`',
    `lob_code` STRING COMMENT 'Internal code identifying the Line of Business (LOB) within investment banking that originated and executed the transaction (e.g., IBD-MA for M&A Advisory, IBD-ECM for Equity Capital Markets, IBD-DCM for Debt Capital Markets, IBD-LF for Leveraged Finance).',
    `number_of_co_advisors` STRING COMMENT 'Total count of co-advisors or joint bookrunners on the transaction. Used to determine pro-rata league table credit allocation methodology when credit is shared equally among all bookrunners.',
    `publication_date` DATE COMMENT 'Date on which the tombstone advertisement was formally published in marketing materials, pitch books, or public media. Used for deal track record management and marketing compliance.',
    `publication_status` STRING COMMENT 'Current publication lifecycle status of the tombstone advertisement. draft = tombstone content being prepared; approved = client and internal sign-off obtained; published = tombstone publicly released in marketing materials; suppressed = publication withheld at client request; archived = historical record retained for deal track record.. Valid values are `draft|approved|published|suppressed|archived`',
    `ranking_period` STRING COMMENT 'The calendar period for which the league table credit is claimed and ranked (e.g., Q1 2024, H1 2024, FY 2024, YTD 2024). Determines which league table publication the credit will appear in.',
    `ranking_period_end_date` DATE COMMENT 'End date of the league table ranking period for which this credit submission applies. The transaction closing date must fall within the ranking period start and end dates to be eligible for credit.',
    `ranking_period_start_date` DATE COMMENT 'Start date of the league table ranking period for which this credit submission applies. Used to determine eligibility of the transaction closing date within the ranking window.',
    `submission_date` DATE COMMENT 'Date on which the league table credit claim was submitted to the provider (Dealogic, Bloomberg, or Refinitiv) for inclusion in the ranking period.',
    `target_company_name` STRING COMMENT 'Legal name of the target company in M&A transactions, or the issuer in ECM/DCM transactions. Distinct from client_name which represents the banks primary client (e.g., the acquirer). Null for transactions where there is no distinct target entity.',
    `target_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the target companys or issuers country of incorporation or primary operations. Used for geographic league table submissions (e.g., EMEA M&A, Asia-Pacific ECM) and cross-border transaction analysis.. Valid values are `^[A-Z]{3}$`',
    `tombstone_description` STRING COMMENT 'Full narrative text of the tombstone advertisement as approved for publication, describing the transaction, the banks role, and the deal highlights. Used in pitch books, marketing materials, and deal track record databases.',
    `transaction_name` STRING COMMENT 'Official marketing name or title of the completed investment banking transaction as it appears on the tombstone advertisement (e.g., Acquisition of XYZ Corp by ABC Inc).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the tombstone record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data lineage, and audit compliance.',
    CONSTRAINT pk_tombstone PRIMARY KEY(`tombstone_id`)
) COMMENT 'Master record for deal tombstones — the official commemorative records of completed investment banking transactions — and all associated league table credit claims. Captures transaction name, deal type, deal value, closing date, client name, banks role, co-advisors, and for each league table submission: provider (Dealogic, Bloomberg, Refinitiv), product category (M&A, ECM, DCM, Loans), credit amount, credit methodology, submission date, accepted credit, ranking period, dispute status, and publication status. Used for league table submissions, competitive positioning analysis, market share tracking, marketing materials, and deal track record management.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`coverage_assignment` (
    `coverage_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each investment banking coverage assignment record in the Silver Layer lakehouse. Primary key for this entity.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key linking to channel.relationship_manager. Business justification: Coverage assignments in investment banking ARE relationship manager assignments - linking investment banker (employee) to client (party) for revenue attribution, client interaction tracking, and cross',
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: Coverage bankers in investment banking coordinate with wealth management mandates for the same client, ensuring holistic relationship management. Real business process: cross-LOB client coverage coord',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Coverage assignments require current counterparty ratings for relationship management, credit decision authority, and client tier classification. Essential for determining banker approval limits and e',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Geographic region required for regional coverage team structure, P&L attribution, and management reporting of client coverage by region.',
    `industry_code_id` BIGINT COMMENT 'Identifier of the industry sector classification (e.g., TMT, Healthcare, Energy, Financials, Industrials) under which this coverage assignment is organized. Links to the sector reference product.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Coverage bankers responsible for ensuring client KYC is current. Assignment triggers KYC review cycle based on client tier, risk rating, and regulatory requirements. Compliance tracks which coverage a',
    `party_id` BIGINT COMMENT 'Identifier of the corporate or institutional client entity being covered. Links to the client/counterparty master record used for KYC and CRM purposes.',
    `employee_id` BIGINT COMMENT 'Identifier of the investment banking coverage banker (relationship manager or sector specialist) assigned to the client. Links to the banker/employee master record.',
    `tertiary_coverage_approved_by_employee_id` BIGINT COMMENT 'Identifier of the senior officer (e.g., Head of Coverage, Group Head) who approved this coverage assignment. Supports governance, audit trail, and segregation of duties requirements under SOX.',
    `universe_id` BIGINT COMMENT 'Foreign key linking to audit.audit_universe. Business justification: Coverage assignments (banker-client relationships) are auditable entities for conflict management, KYC compliance, relationship governance, and coverage model effectiveness. Tracked in audit universe ',
    `aml_risk_rating` STRING COMMENT 'The Anti-Money Laundering (AML) risk rating assigned to the client entity for this coverage relationship. Determines the frequency and depth of enhanced due diligence (EDD) reviews required. Sourced from the AML/Financial Crime system.. Valid values are `low|medium|high|very_high`',
    `approval_date` DATE COMMENT 'The date on which the coverage assignment was formally approved by the designated approving officer. Part of the governance audit trail for IB coverage decisions.',
    `assignment_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the coverage assignment, used in pitch books, mandate letters, and CRM systems to uniquely reference this banker-client relationship.. Valid values are `^CVG-[A-Z0-9]{6,12}$`',
    `assignment_date` DATE COMMENT 'The business event date on which the coverage assignment decision was formally made and recorded, which may differ from the effective_from_date if there is a future-dated assignment.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the coverage assignment. Active indicates the banker is currently covering the client; transferred indicates ownership has moved to another banker; terminated indicates the relationship has ended.. Valid values are `active|inactive|pending|transferred|terminated`',
    `banker_title` STRING COMMENT 'The seniority title of the assigned coverage banker at the time of assignment (e.g., Analyst, Associate, Vice President, Director, Managing Director). Relevant for deal origination credit allocation and client relationship governance.. Valid values are `analyst|associate|vice_president|director|managing_director|partner`',
    `client_tier` STRING COMMENT 'Strategic tier classification of the client within the IB coverage model, reflecting the clients revenue potential and strategic importance to the bank (e.g., Tier 1 = top global corporates, Tier 3 = emerging/developing relationships).. Valid values are `tier_1|tier_2|tier_3|strategic|emerging`',
    `coverage_notes` STRING COMMENT 'Free-text notes recorded by the coverage banker or coverage manager regarding the client relationship, strategic priorities, or special circumstances of this assignment. Contains sensitive business development information.',
    `coverage_office` STRING COMMENT 'The physical office or booking center from which the coverage banker operates (e.g., New York, London, Hong Kong). Used for regulatory jurisdiction assignment and internal cost allocation.',
    `coverage_role` STRING COMMENT 'The functional role of the assigned banker in the client coverage model. Primary bankers own the overall relationship; secondary bankers provide support; sector and product specialists contribute domain expertise. [ENUM-REF-CANDIDATE: primary|secondary|sector_specialist|product_specialist|co_coverage|advisory — promote to reference product]. Valid values are `primary|secondary|sector_specialist|product_specialist|co_coverage`',
    `coverage_team_name` STRING COMMENT 'Name of the investment banking coverage team or group responsible for this assignment (e.g., Global TMT Coverage, Healthcare Investment Banking). Supports team-level performance reporting and deal pipeline management.',
    `effective_from_date` DATE COMMENT 'The date on which the coverage assignment became effective and the banker formally assumed responsibility for the client relationship. Used for revenue attribution and accountability tracking.',
    `effective_until_date` DATE COMMENT 'The date on which the coverage assignment is scheduled to end or was terminated. Null for open-ended assignments. Used for historical coverage analysis and transition planning.',
    `geography_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary country of the client entity for this coverage assignment. Used for regulatory jurisdiction mapping and cross-border compliance.. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this coverage assignment is currently active. Derived from assignment_status but maintained as an explicit field to support efficient filtering in analytics queries and reporting dashboards without requiring status string comparisons.',
    `is_lead_coverage` BOOLEAN COMMENT 'Flag indicating whether this banker is the designated lead coverage officer for the client relationship. Only one banker per client should have this flag set to True at any given time. Drives primary accountability and escalation routing.',
    `is_sector_specialist` BOOLEAN COMMENT 'Flag indicating whether the assigned banker is acting in a sector specialist capacity rather than a generalist relationship management role. Sector specialists provide deep industry expertise and are typically engaged on specific transaction types.',
    `kyc_expiry_date` DATE COMMENT 'The date on which the clients KYC documentation expires and must be renewed. Coverage bankers are alerted prior to this date to initiate KYC refresh. Supports AML compliance and regulatory reporting.',
    `kyc_status` STRING COMMENT 'Current Know Your Customer (KYC) compliance status for the client entity under this coverage assignment. Coverage bankers are responsible for ensuring KYC is current before engaging in transactions. Drives AML and regulatory compliance workflows.. Valid values are `approved|pending|expired|remediation_required|rejected`',
    `last_client_interaction_date` DATE COMMENT 'The most recent date on which the coverage banker had a documented interaction with the client (meeting, call, pitch presentation). Used for CRM activity monitoring and relationship health assessment.',
    `lob_name` STRING COMMENT 'The investment banking Line of Business (LOB) associated with this coverage assignment, indicating the primary product focus area (e.g., M&A Advisory, Equity Capital Markets (ECM), Debt Capital Markets (DCM), Leveraged Finance, Syndicated Lending). [ENUM-REF-CANDIDATE: M&A_advisory|ECM|DCM|leveraged_finance|syndicated_lending|restructuring|corporate_finance — promote to reference product]. Valid values are `M&A_advisory|ECM|DCM|leveraged_finance|syndicated_lending|restructuring`',
    `mandate_count` STRING COMMENT 'The number of active IB mandates (M&A, IPO, DCM, etc.) currently associated with this coverage assignment at the time of record. Provides a snapshot of deal pipeline depth for this banker-client relationship.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this coverage assignment, at which point the assignment may be renewed, transferred, or terminated. Supports coverage governance and banker accountability cycles.',
    `origination_credit_pct` DECIMAL(18,2) COMMENT 'The percentage of deal origination credit allocated to this banker for revenue attribution purposes. Multiple bankers may share credit across a single client relationship; percentages across all active assignments for a client should sum to 100. Used in RAROC and banker performance measurement.',
    `pitch_book_count` STRING COMMENT 'The number of pitch books or marketing presentations delivered to this client under this coverage assignment. Tracks business development activity intensity and supports pipeline conversion analysis.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage assignment record was first created in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage assignment record was last modified in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, SCD processing, and audit compliance.',
    `relationship_since_date` DATE COMMENT 'The date on which the bank first established a formal investment banking relationship with this client entity. Distinct from the coverage assignment effective date; reflects the longevity of the overall client relationship.',
    `revenue_attribution_pct` DECIMAL(18,2) COMMENT 'The percentage of total client-generated IB revenue attributed to this specific coverage assignment. Distinct from origination_credit_pct as it may reflect ongoing relationship management credit rather than deal origination credit alone.',
    `sector_name` STRING COMMENT 'Human-readable name of the industry sector under which this coverage assignment is classified (e.g., TMT, Healthcare, Energy, Financials, Industrials). Aligns with GICS sector taxonomy. [ENUM-REF-CANDIDATE: TMT|healthcare|energy|financials|industrials|consumer|real_estate|utilities|materials — promote to reference product]',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this coverage assignment record was sourced (e.g., CRM platform, IB deal management system). Supports data lineage and ETL reconciliation in the lakehouse.',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier of this coverage assignment in the originating operational system of record. Enables traceability from the Silver Layer back to the source system for audit and reconciliation.',
    `sub_sector_name` STRING COMMENT 'More granular sub-sector classification within the primary sector (e.g., within TMT: Software, Semiconductors, Media; within Healthcare: Pharma, MedTech, Biotech). Supports specialist banker routing and deal origination attribution.',
    `termination_date` DATE COMMENT 'The actual date on which the coverage assignment was terminated or transferred. Populated only when assignment_status is terminated or transferred. Distinct from effective_until_date which may be a planned end date.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the coverage assignment was terminated or transferred. Supports workforce planning, client retention analysis, and coverage continuity management.. Valid values are `banker_departure|client_request|restructure|transfer|mandate_end|other`',
    CONSTRAINT pk_coverage_assignment PRIMARY KEY(`coverage_assignment_id`)
) COMMENT 'Master entity tracking the assignment of investment banking coverage bankers to client relationships and industry sectors. Records coverage banker, client entity, sector (TMT, healthcare, energy, financials, industrials), geography, coverage role (primary, secondary, sector specialist), assignment dates, and deal origination attribution. Supports banker accountability, client relationship management, and revenue attribution for the IB division.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`deal_participant` (
    `deal_participant_id` BIGINT COMMENT 'Unique surrogate identifier for each deal participant record in the investment banking deal association entity. Primary key for the deal_participant table.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Deal participants require credit ratings for conflict checks, engagement decisions, syndicate formation, and fee arrangement structuring. Standard practice to assess participant creditworthiness befor',
    `deal_id` BIGINT COMMENT 'Reference to the investment banking deal (M&A, IPO, DCF, debt/equity capital markets, syndicated lending) to which this participant is associated.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Each deal participant requires KYC due diligence before engagement. Compliance tracks which participant record triggered or is associated with each KYC review cycle. Participant onboarding cannot proc',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: LEI code required for EMIR/Dodd-Frank trade reporting, counterparty due diligence, and legal entity identification in syndication and capital markets transactions.',
    `party_id` BIGINT COMMENT 'Reference to the institution or counterparty entity representing the participating organization (e.g., client, co-advisor, legal counsel, auditor, regulator).',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: All deal counterparties, advisors, and participants must be screened against OFAC/sanctions lists before engagement. Regulatory requirement pre-mandate execution. Screening event records match status,',
    `agreed_fee_amount` DECIMAL(18,2) COMMENT 'Contractually agreed fee amount payable to or by this participant for their role in the deal, expressed in the deal currency. For success fees, this represents the agreed percentage or fixed amount at deal close.',
    `bic_code` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the participating institution, used for SWIFT messaging, payment settlement, and cross-border transaction identification in investment banking deal communications.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `conflict_check_date` DATE COMMENT 'Date on which the conflict of interest screening was last performed or updated for this participant. Used to ensure checks are current and within required review cycles.',
    `conflict_check_notes` STRING COMMENT 'Free-text notes documenting the outcome of the conflict of interest review, including nature of any identified conflict, waiver rationale, or escalation details. Maintained for regulatory audit trail purposes.',
    `conflict_check_status` STRING COMMENT 'Status of the conflict of interest screening performed for this participant relative to the deal. Values: pending (check not yet initiated), cleared (no conflict found), conflict_identified (potential conflict detected), waived (conflict acknowledged and waived with appropriate approvals), escalated (referred to compliance committee).. Valid values are `pending|cleared|conflict_identified|waived|escalated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal participant record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record origination.',
    `deal_team_lead` BOOLEAN COMMENT 'Indicates whether this participant is designated as the lead institution or lead advisor for their role in the deal (e.g., lead left bookrunner, lead financial advisor). True = lead; False = co-participant or supporting role.',
    `engagement_end_date` DATE COMMENT 'Date on which the participants engagement in the deal formally concluded, either through deal close, withdrawal, termination, or completion of advisory mandate. Null if engagement is ongoing.',
    `engagement_letter_date` DATE COMMENT 'Date on which the formal engagement letter was signed between the bank and this participant, establishing the legal basis for the advisory or service relationship within the deal.',
    `engagement_start_date` DATE COMMENT 'Date on which the participant formally commenced engagement in the deal, typically aligned with the execution of a mandate letter, engagement letter, or non-disclosure agreement (NDA).',
    `fee_arrangement_type` STRING COMMENT 'Type of fee arrangement agreed with this participant: retainer (periodic fixed fee), success_fee (contingent on deal close), hourly (time-based billing), fixed (lump sum), or no_fee (pro bono or regulatory participant). Drives revenue recognition and deal economics.. Valid values are `retainer|success_fee|hourly|fixed|no_fee`',
    `fee_basis_points` DECIMAL(18,2) COMMENT 'Fee expressed in basis points (BPS) as a proportion of the total deal value, applicable for success fees and underwriting fees in capital markets transactions. One basis point equals 0.01%.',
    `fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the agreed fee amount is denominated (e.g., USD, EUR, GBP). Required for multi-currency deal fee tracking and FX (Foreign Exchange) conversion.. Valid values are `^[A-Z]{3}$`',
    `information_barrier_group` STRING COMMENT 'Identifier of the information barrier (Chinese Wall) group to which this participant has been assigned, controlling access to material non-public information (MNPI) about the deal. Used for insider trading prevention and regulatory compliance.',
    `institution_type` STRING COMMENT 'Classification of the type of institution participating in the deal: investment_bank, commercial_bank, law_firm, accounting_firm, regulator, private_equity, or hedge_fund. Supports deal team composition analysis and conflict screening. [ENUM-REF-CANDIDATE: investment_bank|commercial_bank|law_firm|accounting_firm|regulator|private_equity|hedge_fund — 7 candidates stripped; promote to reference product]',
    `jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary legal jurisdiction under which the participating institution is incorporated or regulated. Used for cross-border deal structuring and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `kyc_review_date` DATE COMMENT 'Date on which the most recent KYC (Know Your Customer) review was completed for this participant. Used to track review currency and trigger periodic refresh cycles per AML compliance requirements.',
    `kyc_status` STRING COMMENT 'Current KYC (Know Your Customer) due diligence status for the participating institution. Ensures AML (Anti-Money Laundering) and BSA (Bank Secrecy Act) compliance before the institution is permitted to participate in deal activities.. Valid values are `pending|approved|rejected|expired|under_review`',
    `league_table_credit` BOOLEAN COMMENT 'Indicates whether this participant is eligible to receive league table credit for this deal in industry rankings (e.g., Bloomberg, Dealogic, Thomson Reuters). True = eligible for credit; False = excluded from league table attribution.',
    `mandate_letter_ref` STRING COMMENT 'Reference number or identifier of the mandate letter or engagement letter governing this participants involvement in the deal. Links to the formal contractual document establishing scope, fees, and obligations.',
    `nda_executed` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) has been executed with this participant prior to sharing confidential deal information. True = NDA in place; False = NDA not yet executed.',
    `nda_execution_date` DATE COMMENT 'Date on which the Non-Disclosure Agreement (NDA) was formally executed between the bank and this deal participant. Null if NDA has not been executed.',
    `participant_category` STRING COMMENT 'High-level classification grouping participant roles into: principal (client, target, acquirer), advisor (financial advisor, legal counsel, auditor, co-advisor), regulatory (regulator, compliance body), or support (escrow agent, trustee, paying agent).. Valid values are `principal|advisor|regulatory|support`',
    `participant_ref_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to this participant engagement within the deal, used in mandate letters, pitch books, and tombstone records for cross-system identification.. Valid values are `^DP-[A-Z0-9]{6,20}$`',
    `participant_role` STRING COMMENT 'Functional role of the participant in the investment banking deal. Common roles include: client, target, acquirer, co-advisor, financial advisor, legal counsel, auditor, underwriter, syndicate member, regulator, escrow agent, trustee, fairness opinion provider. [ENUM-REF-CANDIDATE: client|target|acquirer|co_advisor|financial_advisor|legal_counsel|auditor|underwriter|syndicate_member|regulator|escrow_agent|trustee|fairness_opinion_provider — promote to reference product]',
    `participant_side` STRING COMMENT 'Indicates which side of the transaction the participant represents: buy_side (acquirer/investor), sell_side (target/issuer), neutral (independent advisor, auditor, fairness opinion), or regulatory (governing body). Critical for conflict of interest screening.. Valid values are `buy_side|sell_side|neutral|regulatory`',
    `participant_status` STRING COMMENT 'Current lifecycle status of the participants engagement in the deal: active (currently engaged), withdrawn (voluntarily exited), terminated (engagement ended by counterparty), completed (deal closed with participant fulfilling role), suspended (engagement paused pending resolution).. Valid values are `active|withdrawn|terminated|completed|suspended`',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact person at the participating institution. Used for deal communications, document distribution, and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the participating institution responsible for deal communications and execution. Captured for deal team management and correspondence tracking.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number of the primary contact person at the participating institution for deal-related communications.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether this participants involvement in the deal requires specific regulatory approval (e.g., antitrust clearance, CFIUS review, FCA approval). True = regulatory approval required; False = no specific approval required.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval for this participants deal involvement: not_required, pending (application submitted), approved (clearance received), rejected (approval denied), or conditional (approved with conditions).. Valid values are `not_required|pending|approved|rejected|conditional`',
    `syndicate_rank` STRING COMMENT 'Numeric ranking of this participant within the deal syndicate or advisory group, where 1 indicates the lead/senior position. Used for tombstone ordering, fee allocation, and league table credit attribution in capital markets transactions.',
    `tombstone_credit_line` STRING COMMENT 'The exact credit line text to be used for this participant in the deal tombstone advertisement, specifying the institution name and role as it should appear in the published announcement.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether this participants involvement should be included in the deal tombstone advertisement published upon deal completion. True = eligible for tombstone credit; False = excluded (e.g., confidential participants, regulatory bodies).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this deal participant record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data lineage, and audit compliance.',
    `wall_cross_date` DATE COMMENT 'Date on which this participant was formally wall-crossed — i.e., brought over the information barrier and made aware of material non-public information (MNPI) about the deal. Critical for insider trading compliance and information barrier management.',
    `withdrawal_reason` STRING COMMENT 'Reason for the participants withdrawal or termination from the deal, if applicable. Captures business rationale such as conflict of interest, regulatory objection, commercial disagreement, or deal collapse. Populated only when participant_status is withdrawn or terminated.',
    CONSTRAINT pk_deal_participant PRIMARY KEY(`deal_participant_id`)
) COMMENT 'Association entity capturing all parties involved in an investment banking deal — including the client, target company, acquirer, co-advisors, legal counsel, auditors, regulators, and other deal counterparties. Records participant role, institution name, engagement start date, engagement end date, and conflict check status. Enables deal team management and conflict of interest screening.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`offering` (
    `offering_id` BIGINT COMMENT 'Primary key for offering',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Capital markets offerings of secured or asset-backed securities reference underlying collateral pools in prospectus and ongoing disclosure. Real process: ABS/MBS offering documentation, collateral sch',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or mandate under which this offering is structured. Links to the deal pipeline record.',
    `debt_issuance_id` BIGINT COMMENT 'Foreign key linking to treasury.debt_issuance. Business justification: When the bank acts as issuer (not underwriter), capital markets offerings may be the banks own debt issuances for funding purposes. Business process: bank treasury issues debt through its own capital',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Banks own debt offerings are planned and tracked in treasury funding plans. Business process: annual funding plan execution includes capital markets issuances to meet funding targets and maturity pro',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Capital markets offerings create tradable securities. Links offering event to resulting instrument for pricing, settlement, prospectus validation, and post-IPO lifecycle management. Essential for regu',
    `issuer_id` BIGINT COMMENT 'Reference to the corporate or sovereign entity issuing the securities in this offering. Links to the counterparty/issuer master record.',
    `market_center_id` BIGINT COMMENT 'Foreign key linking to reference.market_center. Business justification: Exchange code links to market_center for listing venue identification, trading surveillance, best execution reporting (MiFID II), and market data distribution.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Capital markets offerings are distributed through channels - retail tranches via branches/digital, institutional via RM networks. Syndicate desks track primary distribution channel for allocation deci',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Offering type classification drives regulatory treatment, FRTB book assignment, and investor eligibility determination for capital markets offerings.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Instrument identifier (ISIN/CUSIP) required for securities master data, exchange listing, regulatory reporting, and post-trade settlement in capital markets offerings.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Capital markets offerings are stress-tested for market disruption scenarios affecting pricing, execution risk, and underwriting exposure. Required for risk committee approval and regulatory capital as',
    `bookrunner_name` STRING COMMENT 'Name of the lead bookrunner (global coordinator) investment bank responsible for managing the bookbuilding process, allocating securities to investors, and stabilizing the aftermarket. For syndicated offerings, this is the primary bookrunner.',
    `coupon_rate` DECIMAL(18,2) COMMENT 'Annual interest rate (coupon) expressed as a percentage of par value for debt offerings (investment grade bonds, high yield bonds, convertible bonds). Null for equity offerings. Key pricing term for DCM transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offering record was first captured in the investment banking deal management system. Used for audit trail, data lineage, and regulatory record-keeping under SOX and SEC requirements.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the debt offering by a Nationally Recognized Statistical Rating Organization (NRSRO) such as Moodys, S&P, or Fitch at time of issuance (e.g., AAA, Baa2, BB+). Null for unrated or equity offerings. [ENUM-REF-CANDIDATE: AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC|CC|C|D — promote to reference product]',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the offering is denominated and proceeds are raised (e.g., USD, EUR, GBP). Drives FX conversion for multi-currency reporting and treasury settlement.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the SEC or relevant regulator declared the registration statement effective, permitting the public offering to proceed. Marks the start of the binding offering period.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary regulatory jurisdiction governing this offering (e.g., USA for SEC-registered offerings, GBR for FCA-regulated offerings). Determines applicable securities law, prospectus requirements, and investor eligibility rules.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the offering record, supporting audit trail requirements and change management tracking across the deal lifecycle.',
    `lock_up_period_days` STRING COMMENT 'Number of calendar days following the offering closing during which existing shareholders and insiders are contractually restricted from selling their shares. Standard lock-up periods are typically 90 or 180 days for IPOs.',
    `market_segment` STRING COMMENT 'Identifies whether the offering belongs to Equity Capital Markets (ECM) or Debt Capital Markets (DCM), leveraged finance, or structured finance. Drives divisional P&L attribution and regulatory reporting classification.. Valid values are `ECM|DCM|leveraged_finance|structured_finance`',
    `maturity_date` DATE COMMENT 'Date on which the principal amount of a debt security is due for repayment to bondholders. Applicable to bond and note offerings (investment grade, high yield, convertible). Null for equity offerings.',
    `offer_price` DECIMAL(18,2) COMMENT 'Final price per share or per unit at which securities are offered to investors, set at pricing date. For debt offerings, expressed as a percentage of par value (e.g., 99.50). Central pricing fact for the ECM/DCM transaction.',
    `offering_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned by the investment banking division to uniquely identify this offering across deal management, regulatory filing, and syndication systems (e.g., ECM-2024-00123).. Valid values are `^[A-Z]{2,6}-[0-9]{4}-[0-9]{4,8}$`',
    `offering_status` STRING COMMENT 'Current lifecycle state of the capital markets offering, tracking progression from deal pipeline through regulatory filing, investor roadshow, pricing, and final closing or withdrawal. [ENUM-REF-CANDIDATE: pipeline|mandated|filed|roadshow|priced|closed|withdrawn|postponed — 8 candidates stripped; promote to reference product]',
    `overallotment_amount` DECIMAL(18,2) COMMENT 'Additional securities amount available under the overallotment (greenshoe) option, typically up to 15% of the base offering size. Exercisable by the stabilizing manager to cover excess demand and support post-listing price stability.',
    `price_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the indicative price range communicated to investors during the roadshow and bookbuilding process, prior to final pricing. Used in preliminary prospectus and investor marketing materials.',
    `price_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the indicative price range communicated to investors during the roadshow and bookbuilding process, prior to final pricing. Used in preliminary prospectus and investor marketing materials.',
    `pricing_date` DATE COMMENT 'The principal business event date on which the offering price was formally set and agreed between the issuer, underwriters, and investors. Represents the key transaction event timestamp for ECM/DCM deal records.',
    `rating_agency` STRING COMMENT 'Name of the Nationally Recognized Statistical Rating Organization (NRSRO) that assigned the credit rating to this debt offering. NR indicates the offering is not rated. Null for equity offerings.. Valid values are `Moodys|SP|Fitch|DBRS|Kroll|NR`',
    `reg_s_eligible_flag` BOOLEAN COMMENT 'Indicates whether the offering is eligible for distribution to non-US investors under SEC Regulation S (offshore transactions), enabling international tranche distribution without full SEC registration.',
    `regulatory_filing_date` DATE COMMENT 'Date on which the initial registration statement or prospectus was filed with the relevant securities regulator (SEC, FCA, ESMA, etc.). Triggers the regulatory review clock and quiet period obligations.',
    `regulatory_filing_type` STRING COMMENT 'Type of regulatory registration or prospectus filing submitted to the relevant securities regulator (e.g., SEC Form S-1 for US domestic IPO, F-1 for foreign private issuer, prospectus for EU/UK offerings). Drives compliance workflow and filing deadline tracking. [ENUM-REF-CANDIDATE: S-1|F-1|S-3|S-11|424B|prospectus|listing_particulars|none — 8 candidates stripped; promote to reference product]',
    `roadshow_end_date` DATE COMMENT 'Date on which the investor roadshow and bookbuilding process concluded, immediately preceding the pricing date. Used to measure roadshow duration and investor engagement analytics.',
    `roadshow_start_date` DATE COMMENT 'Date on which the investor roadshow and bookbuilding process commenced. Marks the beginning of formal investor marketing and demand generation for the offering.',
    `rule_144a_eligible_flag` BOOLEAN COMMENT 'Indicates whether the offering qualifies for resale to Qualified Institutional Buyers (QIBs) under SEC Rule 144A, enabling a private placement tranche alongside or instead of a registered public offering.',
    `settlement_date` DATE COMMENT 'Date on which securities are delivered to investors and proceeds are remitted to the issuer, typically T+1 or T+2 from pricing date per applicable exchange and regulatory settlement conventions.',
    `shares_offered` BIGINT COMMENT 'Total number of shares or units offered in the transaction (base offering, excluding overallotment). Applicable to equity offerings (IPO, follow-on, rights issue). For debt offerings, represents face value units.',
    `size_amount` DECIMAL(18,2) COMMENT 'Total gross proceeds targeted to be raised in the offering, expressed in the offering currency. Represents the base deal size before any overallotment (greenshoe) exercise. Core monetary fact for ECM/DCM transaction records.',
    `stabilization_flag` BOOLEAN COMMENT 'Indicates whether the stabilizing manager is authorized to conduct post-listing price stabilization activities (e.g., greenshoe exercise, open market purchases) to support the offering price in the secondary market.',
    `syndicate_size` STRING COMMENT 'Total number of investment banks participating in the underwriting syndicate for this offering, including bookrunners, co-managers, and selling group members. Indicates deal complexity and distribution breadth.',
    `tombstone_published_flag` BOOLEAN COMMENT 'Indicates whether the tombstone announcement (deal announcement advertisement) has been published following successful closing of the offering. Tombstones serve as the official public record of completed capital markets transactions.',
    `total_proceeds_amount` DECIMAL(18,2) COMMENT 'Actual total gross proceeds raised at closing, including any overallotment option exercised. Represents the final deal size and is the primary monetary outcome metric for the offering.',
    `underwriting_discount_bps` DECIMAL(18,2) COMMENT 'Gross underwriting spread expressed in basis points (BPS) as a percentage of total offering proceeds. Represents the total fee paid to the underwriting syndicate, covering management fee, underwriting fee, and selling concession.',
    `underwriting_fee_amount` DECIMAL(18,2) COMMENT 'Absolute monetary value of the gross underwriting fee payable to the underwriting syndicate, derived from the underwriting discount applied to total proceeds. Key revenue metric for investment banking P&L attribution.',
    `use_of_proceeds` STRING COMMENT 'Narrative description of how the issuer intends to deploy the capital raised from the offering (e.g., debt repayment, capital expenditure, working capital, acquisitions). Required disclosure in the prospectus under SEC Regulation S-K Item 504.',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Master entity for equity and debt capital markets offerings managed by the investment banking division. Captures offering type (IPO, follow-on, rights issue, convertible bond, investment grade bond, high yield bond, hybrid), issuer, offering size, pricing, currency, exchange listing, regulatory filing status (S-1, F-1, prospectus), settlement date, and ISIN/CUSIP assigned. The primary ECM/DCM transaction record.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` (
    `investment_regulatory_filing_id` BIGINT COMMENT 'Unique surrogate identifier for each regulatory filing record submitted in connection with an investment banking transaction. Serves as the primary key for this entity.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Regulatory filings (prospectus, S-1, etc.) are submitted for specific capital markets offerings. While investment_regulatory_filing has deal_id, one deal can have multiple offerings requiring separate',
    `deal_id` BIGINT COMMENT 'Reference to the investment banking deal or transaction (e.g., IPO, M&A, debt issuance) for which this regulatory filing was submitted.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee record of the lead investment banker or deal captain responsible for managing the regulatory filing process and coordinating with external counsel and the regulatory body.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Regulatory filings (SEC forms, exchange filings) are direct audit subjects for accuracy verification, completeness assessment, timeliness compliance, and disclosure adequacy. Auditors validate filing ',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: Regulatory filings (prospectuses, 13Ds, tender offer docs) are examined by SEC, FINRA; deficiencies become exam findings. Examiners cite specific filings in findings related to disclosure inadequacy, ',
    `issuer_id` BIGINT COMMENT 'Reference to the corporate or sovereign entity (issuer or acquirer) on whose behalf the regulatory filing is submitted.',
    `parent_filing_investment_regulatory_filing_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original filing record when this record represents an amendment or supplement. Null for original filings. Enables reconstruction of the full amendment chain for a given regulatory submission.',
    `regulatory_finding_id` BIGINT COMMENT 'Foreign key linking to audit.regulatory_finding. Business justification: Regulatory findings directly cite specific filings that were deficient, late, incomplete, or non-compliant with SEC, exchange, or other regulatory body requirements. Direct examination subject.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Regulatory taxonomy required for structured filing (XBRL), taxonomy version control, and data point mapping in SEC EDGAR and ESMA ESEF filings.',
    `amendment_number` STRING COMMENT 'Sequential integer indicating the amendment version of the filing (0 = original filing, 1 = first amendment /A-1, 2 = second amendment /A-2, etc.). Tracks the revision history of the filing in response to regulatory comments or material changes.',
    `approval_date` DATE COMMENT 'The date on which the regulatory body formally approved or declared effective the filing. Null if the filing has not yet been approved or was rejected/withdrawn.',
    `cik` STRING COMMENT 'The SEC Central Index Key assigned to the issuer in the EDGAR filing system. Uniquely identifies the filer in the SECs electronic disclosure database. Applicable to SEC filings only.. Valid values are `^[0-9]{1,10}$`',
    `confidentiality_treatment_flag` BOOLEAN COMMENT 'Indicates whether the bank or issuer has requested confidential treatment for certain portions of the filing under applicable securities law (True = confidential treatment requested). Common for trade secrets, pricing terms, and material contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this regulatory filing record was first created in the system. Provides the audit trail entry point for the records lifecycle in the data platform.',
    `cusip` STRING COMMENT 'The nine-character CUSIP identifier assigned to the US security associated with this filing. Used for US market identification and cross-referencing with DTCC and clearing systems.. Valid values are `^[A-Z0-9]{9}$`',
    `effective_date` DATE COMMENT 'The date on which the regulatory filing becomes effective and the associated transaction or disclosure is legally operative (e.g., the date an S-1 registration statement is declared effective by the SEC, enabling the IPO to proceed).',
    `expiry_date` DATE COMMENT 'The date on which the regulatory filing or its associated approval ceases to be valid (e.g., a prospectus approval valid for 12 months under EU Prospectus Regulation, or an HSR waiting period expiration date).',
    `fatca_applicable_flag` BOOLEAN COMMENT 'Indicates whether the filing or associated transaction has FATCA withholding and reporting implications (True = FATCA applicable). Relevant for cross-border securities offerings involving US persons or US-source income.',
    `filing_category` STRING COMMENT 'Broad category grouping the filing by its regulatory purpose. Used for portfolio-level compliance tracking and regulatory reporting dashboards across the investment banking division. [ENUM-REF-CANDIDATE: equity_capital_markets|debt_capital_markets|M&A|antitrust|periodic_disclosure|current_report|beneficial_ownership — 7 candidates stripped; promote to reference product]',
    `filing_date` DATE COMMENT 'The date on which the regulatory filing was formally submitted to the regulatory body. This is the principal business event date for the filing and is used for regulatory deadline tracking and compliance reporting.',
    `filing_fee_usd` DECIMAL(18,2) COMMENT 'The regulatory filing fee paid to the regulatory body in connection with this submission, expressed in US dollars. Calculated based on the offering size or transaction value per the applicable fee schedule (e.g., SEC Section 6(b) fee).',
    `filing_notes` STRING COMMENT 'Free-text field for internal notes, deal team commentary, or regulatory correspondence summaries related to this filing. Used by investment bankers and compliance officers to document key decisions, open items, and regulatory interactions.',
    `filing_reference_number` STRING COMMENT 'Externally assigned reference number or accession number issued by the regulatory body upon receipt of the filing (e.g., SEC EDGAR accession number, FCA submission reference). Serves as the primary business identifier for tracking the filing with the regulator.',
    `filing_status` STRING COMMENT 'Current lifecycle state of the regulatory filing. Tracks progression from internal drafting through regulatory review to final disposition (approved, rejected, or withdrawn).. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `filing_type` STRING COMMENT 'Classification of the regulatory filing form type submitted. Common types include SEC S-1 (domestic IPO registration), F-1 (foreign private issuer IPO), 8-K (current report), 20-F (annual report for foreign issuers), merger proxy (DEF 14A), HSR antitrust notification, FCA prospectus, and EU Prospectus Regulation filing. [ENUM-REF-CANDIDATE: S-1|F-1|8-K|20-F|DEF 14A|HSR|FCA Prospectus|EU Prospectus|424B|S-4|SC TO|13D|13G — promote to reference product]',
    `isin` STRING COMMENT 'The International Securities Identification Number assigned to the security being registered or disclosed in this filing. Provides a globally unique identifier for the security across regulatory and market data systems.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the legal jurisdiction under which the filing is made (e.g., USA for SEC filings, GBR for FCA filings, DEU for BaFin filings).. Valid values are `[A-Z]{3}`',
    `last_comment_response_date` DATE COMMENT 'The date on which the most recent response to a regulatory comment letter was submitted. Used to track the responsiveness of the issuer and legal counsel during the regulatory review process.',
    `legal_counsel_firm` STRING COMMENT 'Name of the external law firm engaged to prepare and submit the regulatory filing on behalf of the issuer or the bank. Confidential business relationship information used for conflict-of-interest checks and engagement tracking.',
    `lei` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier of the issuer or reporting entity associated with this filing. Mandatory for regulatory reporting under EMIR, MiFID II, and Dodd-Frank.. Valid values are `^[A-Z0-9]{18}[0-9]{2}$`',
    `listing_exchange` STRING COMMENT 'The securities exchange or trading venue on which the issuers securities are proposed to be listed or are already listed in connection with this filing (e.g., NYSE, NASDAQ, LSE, Euronext). Relevant for equity capital markets and listing-related filings.',
    `material_change_description` STRING COMMENT 'Narrative description of the material change(s) disclosed in this filing or amendment. Populated only when material_change_flag is True. Supports regulatory audit trails and investor communication records.',
    `material_change_flag` BOOLEAN COMMENT 'Indicates whether this filing or amendment contains a material change to previously disclosed information (True = material change present). Triggers enhanced review workflows and investor notification obligations under securities law.',
    `offering_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which the offering or transaction is denominated (e.g., USD, EUR, GBP). Required for multi-currency deal reporting and FX conversion in consolidated analytics.. Valid values are `[A-Z]{3}`',
    `offering_size_usd` DECIMAL(18,2) COMMENT 'The total gross proceeds of the capital markets transaction associated with this filing, expressed in US dollars. For M&A filings, represents the total deal value. Used for fee calculation, regulatory threshold checks (e.g., HSR filing thresholds), and deal league table reporting.',
    `prospectus_type` STRING COMMENT 'For equity and debt capital markets filings, specifies the type of prospectus document (e.g., base prospectus for shelf registration, preliminary prospectus (red herring), final prospectus, supplementary prospectus). Null for non-prospectus filings such as HSR or 8-K.. Valid values are `base_prospectus|final_prospectus|preliminary_prospectus|supplementary_prospectus|listing_particulars`',
    `regulatory_body` STRING COMMENT 'The regulatory authority or governing body to which the filing is submitted (e.g., SEC for US capital markets, FCA for UK listings, ESMA for EU prospectuses, FINRA for broker-dealer compliance). Determines applicable rules and review timelines. [ENUM-REF-CANDIDATE: SEC|FINRA|FCA|ESMA|EBA|CFTC|OCC|FDIC|PRA|other — 10 candidates stripped; promote to reference product]',
    `regulatory_review_deadline` DATE COMMENT 'The statutory or regulatory deadline by which the regulatory body must complete its review and issue a decision on the filing (e.g., SEC 30-day review period for S-1, HSR 30-day initial waiting period). Critical for deal timeline management.',
    `rejection_date` DATE COMMENT 'The date on which the regulatory body formally rejected the filing. Null if the filing was not rejected. Used for tracking regulatory outcomes and remediation timelines.',
    `sarbanes_oxley_applicable_flag` BOOLEAN COMMENT 'Indicates whether the filing is subject to Sarbanes-Oxley Act certification requirements (True = SOX applicable). Relevant for annual and quarterly reports filed by US public companies requiring CEO/CFO certifications under SOX Sections 302 and 906.',
    `sec_comment_letter_count` STRING COMMENT 'Number of comment letters received from the SEC Division of Corporation Finance during the review of this filing. A higher count indicates more extensive regulatory scrutiny and may signal deal execution risk.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone) at which the filing was electronically submitted to the regulatory body. Used for regulatory deadline compliance verification and audit trail purposes.',
    `tombstone_eligible_flag` BOOLEAN COMMENT 'Indicates whether the transaction associated with this filing qualifies for inclusion in the banks tombstone advertisement and deal league table records upon successful completion (True = eligible). Used for marketing and competitive positioning analytics.',
    `transaction_type` STRING COMMENT 'The category of investment banking transaction that triggered the regulatory filing requirement. Distinguishes between equity capital markets (IPO, follow-on), M&A advisory, debt capital markets, and other transaction types. [ENUM-REF-CANDIDATE: IPO|follow_on_offering|M&A|debt_issuance|rights_issue|tender_offer|spin_off|SPAC — 8 candidates stripped; promote to reference product]',
    `underwriter_role` STRING COMMENT 'The banks role in the transaction associated with this filing (e.g., sole bookrunner, joint bookrunner, co-manager, financial advisor). Determines the banks regulatory obligations and disclosure requirements in the filing.. Valid values are `sole_bookrunner|joint_bookrunner|co_manager|financial_advisor|placement_agent`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this regulatory filing record was most recently modified. Used for change data capture, incremental ETL processing, and audit trail maintenance in the Databricks Silver Layer.',
    CONSTRAINT pk_investment_regulatory_filing PRIMARY KEY(`investment_regulatory_filing_id`)
) COMMENT 'Master record for regulatory filings submitted in connection with investment banking transactions. Captures filing type (SEC S-1, F-1, 8-K, merger proxy, HSR antitrust, FCA prospectus, EU Prospectus Regulation), filing date, regulatory body, filing status (draft, submitted, approved, rejected), effective date, and material changes. Tracks compliance with SEC, FINRA, FCA, and other regulatory requirements for capital markets and M&A transactions.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`pitch_book` (
    `pitch_book_id` BIGINT COMMENT 'Unique identifier for the investment banking pitch book record. Primary key for this entity.',
    `coverage_assignment_id` BIGINT COMMENT 'Foreign key linking to investment.coverage_assignment. Business justification: Pitch books are created in the context of ongoing coverage banker-client relationships. While pitch_book has employee_id and party_id, linking to coverage_assignment.coverage_assignment_id provides th',
    `deal_id` BIGINT COMMENT 'Reference to the deal or transaction opportunity that this pitch book supports. Links to the deal pipeline record.',
    `employee_id` BIGINT COMMENT 'Reference to the relationship manager or coverage banker responsible for the client relationship and pitch coordination.',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Geographic region required for regional market analysis, comparable transaction selection, and regional expertise demonstration in pitch book content.',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Industry sector drives comparable company selection, valuation multiple benchmarking, and sector expertise demonstration in pitch book preparation.',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.mandate. Business justification: Pitch books can lead to mandates. When a pitch is successful and a mandate is awarded, the pitch_book should reference the resulting mandate. This FK will be NULL initially (pitch created before manda',
    `investment_proposal_id` BIGINT COMMENT 'Foreign key linking to wealth.investment_proposal. Business justification: Investment banking pitch books for HNW clients often inform or are informed by wealth management investment proposals. Real business process: coordinated client presentation across investment banking ',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Pitch books prepared only after KYC clearance. Confidential client information and deal-specific content require current due diligence. Compliance verifies KYC status before pitch book approval to pre',
    `party_id` BIGINT COMMENT 'Reference to the target client or prospect entity for whom this pitch book was prepared.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Pitch books are presented through specific channels (in-person branch meetings, digital platforms, video banking). Investment banking CRM systems track presentation channel for conversion analysis, ch',
    `previous_pitch_book_id` BIGINT COMMENT 'Self-referencing FK on pitch_book (previous_pitch_book_id)',
    `approval_date` DATE COMMENT 'The date on which the pitch book received final internal approval from compliance, legal, and senior management before client presentation.',
    `competitive_situation` STRING COMMENT 'Classification of the competitive dynamics for the mandate, indicating whether the bank is competing against other advisors and the selection process type.. Valid values are `Sole Advisor|Limited Competition|Competitive Bake-off|Beauty Contest`',
    `confidentiality_level` STRING COMMENT 'The information classification level assigned to the pitch book, governing access controls and distribution restrictions.. Valid values are `Public|Internal|Confidential|Highly Confidential|Restricted`',
    `conflict_check_date` DATE COMMENT 'The date on which the conflict of interest review was completed and clearance was granted or conflicts were identified.',
    `conflict_check_status` STRING COMMENT 'The status of the internal conflict of interest review process, ensuring the bank can ethically pursue the engagement.. Valid values are `Not Started|In Progress|Cleared|Conflict Identified|Waived`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary jurisdiction of the client or transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this pitch book record was first created in the investment banking system, supporting audit trail and data lineage.',
    `deal_size_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated deal size amount.',
    `document_version` STRING COMMENT 'Version identifier for the pitch book document, tracking iterations and revisions throughout the preparation and approval process.',
    `estimated_deal_size` DECIMAL(18,2) COMMENT 'The estimated transaction value or deal size presented in the pitch book, representing the potential scale of the engagement.',
    `estimated_fee_amount` DECIMAL(18,2) COMMENT 'The projected advisory or underwriting fee amount that the bank expects to earn if the mandate is won, used for pipeline revenue forecasting.',
    `expiry_date` DATE COMMENT 'The date after which the pitch book content, including financial data and market comparables, is considered stale and requires refresh.',
    `fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated fee amount.',
    `fee_rate_bps` DECIMAL(18,2) COMMENT 'The proposed fee rate expressed in basis points of the transaction value, representing the banks pricing for the engagement.',
    `file_path` STRING COMMENT 'The network or cloud storage location where the pitch book document file is stored for retrieval and archival purposes.',
    `lob_code` STRING COMMENT 'The internal line of business or product group code responsible for the pitch, used for revenue attribution and resource allocation.',
    `nda_execution_date` DATE COMMENT 'The date on which the non-disclosure agreement was executed by the client, enabling confidential information sharing.',
    `nda_required` BOOLEAN COMMENT 'Indicates whether a signed non-disclosure agreement is required before the pitch book can be shared with the client or third parties.',
    `outcome_date` DATE COMMENT 'The date on which the client communicated their decision regarding the mandate award, marking the conclusion of the pitch process.',
    `page_count` STRING COMMENT 'The total number of pages in the pitch book presentation, used for document management and production tracking.',
    `pitch_outcome` STRING COMMENT 'The final result of the pitch effort, indicating whether the bank successfully secured the advisory mandate or underwriting role.. Valid values are `Pending|Mandate Won|Mandate Lost|No Decision|Withdrawn`',
    `pitch_status` STRING COMMENT 'Current lifecycle status of the pitch book in the deal origination workflow, tracking progression from creation through outcome. [ENUM-REF-CANDIDATE: Draft|Under Review|Approved|Presented|Won|Lost|Withdrawn — 7 candidates stripped; promote to reference product]',
    `pitch_type` STRING COMMENT 'The category of investment banking service being pitched. Classifies the nature of the proposed engagement. [ENUM-REF-CANDIDATE: M&A Advisory|IPO Underwriting|Debt Capital Markets|Equity Capital Markets|Restructuring Advisory|Fairness Opinion|Valuation Services|Strategic Advisory|Leveraged Finance|Private Placement — promote to reference product]',
    `precedent_list` STRING COMMENT 'Comma-separated list or summary of key precedent transactions cited in the pitch book for valuation and market positioning analysis.',
    `precedent_transaction_count` STRING COMMENT 'The number of comparable precedent transactions referenced in the pitch book to demonstrate market context and valuation benchmarks.',
    `preparation_date` DATE COMMENT 'The date on which the pitch book preparation was completed and the document was finalized for internal approval or client delivery.',
    `presentation_date` DATE COMMENT 'The date on which the pitch book was formally presented to the client or prospect. Key milestone in the deal origination timeline.',
    `reference` STRING COMMENT 'Business identifier or document control number assigned to this pitch book for tracking and retrieval purposes.',
    `sub_sector` STRING COMMENT 'The granular sub-sector classification within the primary industry sector, enabling more precise precedent analysis and competitive positioning.',
    `target_client_name` STRING COMMENT 'The legal or trading name of the client organization being pitched. May differ from the client master record if pitching to a subsidiary or division.',
    `target_company_name` STRING COMMENT 'The name of the target company or counterparty in the proposed transaction, if applicable to the pitch scenario.',
    `title` STRING COMMENT 'The formal title or name of the pitch book presentation, typically reflecting the proposed transaction or advisory engagement.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether this pitch, if successful, would qualify for inclusion in the banks league table tombstone advertising and credentials.',
    `transaction_type` STRING COMMENT 'The specific type of transaction structure being proposed in the pitch book, providing granular classification of the deal mechanics. [ENUM-REF-CANDIDATE: Merger|Acquisition|Divestiture|IPO|Follow-on Offering|Debt Issuance|Syndicated Loan|Restructuring — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The system timestamp when this pitch book record was most recently modified, tracking the latest change for audit and synchronization purposes.',
    `valuation_methodology` STRING COMMENT 'The primary valuation approach or methodology presented in the pitch book to support transaction pricing and fairness analysis.. Valid values are `DCF|Comparable Companies|Precedent Transactions|LBO Analysis|Sum-of-the-Parts`',
    `win_probability_pct` DECIMAL(18,2) COMMENT 'The estimated probability of winning the mandate based on competitive positioning, client relationship strength, and market intelligence, expressed as a percentage.',
    CONSTRAINT pk_pitch_book PRIMARY KEY(`pitch_book_id`)
) COMMENT 'Investment banking pitch book and marketing material record. Captures pitch type, target client, industry sector, deal precedents referenced, and presentation date.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`league_table` (
    `league_table_id` BIGINT COMMENT 'Unique identifier for the league table ranking record. Primary key.',
    `deal_id` BIGINT COMMENT 'Reference to the investment banking deal that contributed to this league table ranking. Links to the specific transaction that generated credit for the bank.',
    `employee_id` BIGINT COMMENT 'Reference to the coverage banker or relationship manager who originated the transaction that contributed to this league table ranking. Used for origination credit and compensation purposes.',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Geography required for regional league table rankings, geographic market share analysis, and regional expertise demonstration in marketing materials.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: League table submissions reviewed for accuracy during regulatory exams (tombstone advertising, deal credit claims, market share representations). Examiners verify league table credits match actual dea',
    `previous_league_table_id` BIGINT COMMENT 'Self-referencing FK on league_table (previous_league_table_id)',
    `accepted_credit_amount` DECIMAL(18,2) COMMENT 'The final transaction value credit accepted and published by the league table provider after any disputes or adjustments. This is the official credit amount that counts toward the ranking.',
    `accepted_credit_currency` STRING COMMENT 'The currency in which the accepted credit amount is denominated, using ISO 4217 three-letter currency codes. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CHF|AUD|CAD|HKD|SGD — 10 candidates stripped; promote to reference product]',
    `announcement_date` DATE COMMENT 'The date on which the transaction was publicly announced. Used to determine the appropriate ranking period and for timeline tracking.',
    `bank_role` STRING COMMENT 'The specific role the bank played in the transaction that generated the league table credit. Roles vary by product type and include bookrunner, lead manager, financial advisor, lead arranger, and co-arranger positions. [ENUM-REF-CANDIDATE: Sole Bookrunner|Joint Bookrunner|Lead Manager|Co-Manager|Financial Advisor|Lead Arranger|Co-Arranger — 7 candidates stripped; promote to reference product]',
    `bookrunner_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the transaction value allocated to the bank as bookrunner or lead arranger. Used when credit methodology is pro rata or role-based.',
    `client_name` STRING COMMENT 'The name of the client or issuer for whom the bank provided investment banking services in the transaction. May be confidential depending on engagement terms.',
    `closing_date` DATE COMMENT 'The date on which the transaction was completed and closed. This is typically the date used for league table credit allocation.',
    `co_advisor_count` STRING COMMENT 'The total number of other financial institutions that shared advisory or underwriting roles on the transaction. Used to understand competitive intensity and credit sharing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this league table ranking record was first created in the system. Used for audit trail and data lineage purposes.',
    `credit_methodology` STRING COMMENT 'The methodology used by the ranking provider to allocate credit for transactions. Common methods include full credit (each participant gets full deal value), equal credit (deal value split equally), pro rata (credit based on participation percentage), or bookrunner-only credit.. Valid values are `Full Credit|Equal Credit|Pro Rata|Bookrunner Only|Lead Manager Only`',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether the transaction involved parties or assets from multiple countries. True for cross-border transactions, false for domestic transactions.',
    `deal_count` STRING COMMENT 'The total number of transactions or deals completed by the bank during the ranking period that contributed to the league table credit.',
    `deal_volume_amount` DECIMAL(18,2) COMMENT 'The total transaction value or volume of deals completed by the bank during the ranking period. Represents the aggregate dollar value of all transactions that contributed to the league table credit.',
    `deal_volume_currency` STRING COMMENT 'The currency in which the deal volume amount is denominated. Typically reported in major currencies using ISO 4217 three-letter currency codes. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CHF|AUD|CAD|HKD|SGD — 10 candidates stripped; promote to reference product]',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the reason for any dispute filed regarding the league table credit or ranking. May include issues such as incorrect role attribution, wrong deal value, missing credit, or methodology disagreement.',
    `dispute_resolution_date` DATE COMMENT 'The date on which any dispute regarding the league table credit or ranking was formally resolved by the ranking provider.',
    `dispute_status` STRING COMMENT 'Indicates whether the bank or another party has filed a dispute regarding the credit allocation or ranking, and the current status of that dispute resolution process.. Valid values are `No Dispute|Dispute Filed|Under Investigation|Resolved - Accepted|Resolved - Rejected`',
    `fee_revenue_amount` DECIMAL(18,2) COMMENT 'The total fee revenue earned by the bank from the transaction that contributed to this league table ranking. Confidential financial information used for internal performance measurement.',
    `fee_revenue_currency` STRING COMMENT 'The currency in which the fee revenue was earned and recorded, using ISO 4217 three-letter currency codes. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CHF|AUD|CAD|HKD|SGD — 10 candidates stripped; promote to reference product]',
    `industry_sector` STRING COMMENT 'The industry sector classification for which the league table ranking applies. Examples include Technology, Healthcare, Financial Services, Energy, Industrials, Consumer, Real Estate.',
    `lob_code` STRING COMMENT 'The internal line of business code that identifies which division or business unit within the investment bank is responsible for this league table credit. Used for internal performance tracking and revenue attribution.',
    `market_share_pct` DECIMAL(18,2) COMMENT 'The banks percentage share of the total market volume for the specified product, geography, and period. Calculated as the banks deal volume divided by total market volume.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding the league table ranking, credit allocation, or any special circumstances related to the transaction.',
    `previous_rank_position` STRING COMMENT 'The banks rank position in the previous comparable period. Used to track movement and trends in competitive positioning.',
    `product_category` STRING COMMENT 'The investment banking product line or service category for which the ranking applies. Examples include Mergers and Acquisitions (M&A) advisory, Equity Capital Markets (ECM), Debt Capital Markets (DCM), syndicated lending, leveraged finance, and high yield bonds.. Valid values are `M&A Advisory|Equity Capital Markets|Debt Capital Markets|Syndicated Loans|Leveraged Finance|High Yield Bonds`',
    `publication_date` DATE COMMENT 'The date on which the league table ranking was officially published by the ranking provider.',
    `rank_position` STRING COMMENT 'The numerical rank position of the bank in the league table for the specified product, geography, and period. Lower numbers indicate higher rankings (1 is the top position).',
    `ranking_period` STRING COMMENT 'The time period for which the league table ranking applies. Can be quarterly, semi-annual, annual, year-to-date, or month-to-date. [ENUM-REF-CANDIDATE: Q1|Q2|Q3|Q4|H1|H2|Annual|YTD|MTD — 9 candidates stripped; promote to reference product]',
    `ranking_period_end_date` DATE COMMENT 'The end date of the period covered by this league table ranking.',
    `ranking_period_start_date` DATE COMMENT 'The start date of the period covered by this league table ranking.',
    `ranking_source` STRING COMMENT 'The third-party provider or publication that publishes the league table ranking. Common sources include Bloomberg, Dealogic, Refinitiv, and other financial data providers.. Valid values are `Bloomberg|Dealogic|Refinitiv|Thomson Reuters|Mergermarket|PitchBook`',
    `ranking_status` STRING COMMENT 'The current status of the league table ranking record. Indicates whether the ranking is final and published, provisional pending verification, under review, subject to dispute, withdrawn, or corrected after initial publication.. Valid values are `Published|Provisional|Under Review|Disputed|Withdrawn|Corrected`',
    `submission_date` DATE COMMENT 'The date on which the bank submitted the transaction details to the league table provider for credit consideration.',
    `target_company_name` STRING COMMENT 'For M&A transactions, the name of the target company being acquired or merged. For capital markets transactions, may represent the issuer or borrower name.',
    `tombstone_eligible_flag` BOOLEAN COMMENT 'Indicates whether this league table ranking is based on a transaction that is eligible for tombstone publication and marketing use. True if the transaction meets tombstone criteria and client approval has been obtained.',
    `transaction_type` STRING COMMENT 'The specific type of investment banking transaction. Examples include IPO, follow-on offering, convertible bond, leveraged buyout, merger, acquisition, divestiture, syndicated loan, bridge financing, or debt refinancing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this league table ranking record was last modified. Used for audit trail and change tracking purposes.',
    `wallet_share_pct` DECIMAL(18,2) COMMENT 'The banks share of total fees or revenue generated in the market for the specified product and period. Represents the banks portion of the total fee pool.',
    CONSTRAINT pk_league_table PRIMARY KEY(`league_table_id`)
) COMMENT 'League table ranking and market share record tracking the banks position in investment banking league tables by product, geography, and time period. Captures ranking source, rank, deal volume, and market share.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`deal_document` (
    `deal_document_id` BIGINT COMMENT 'Unique identifier for the investment banking deal document record. Primary key for the deal document registry.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Deal documents include offering-specific documents (prospectus, offering memorandum, pricing supplement, etc.). While deal_document has deal_id, one deal can have multiple offerings, each with its own',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Many deal documents must be filed with regulators (material contracts in 8-Ks, exhibits to S-1s, fairness opinions in proxy statements). Compliance tracks which documents are filed, filing dates, and ',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or transaction that this document supports. Links to the deal master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Deal documents require an employee owner for version control, regulatory audit trails (SOX, SEC filings), and document retention compliance. Currently has denormalized author_name; proper FK enables a',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Governing law jurisdiction determines document enforceability, legal review requirements, and dispute resolution framework for investment banking transaction documents.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Deal documents (prospectuses, indentures, offering memoranda) describe specific securities. Required for document retrieval during instrument lifecycle events (amendments, calls, tenders) and regulato',
    `parent_document_deal_document_id` BIGINT COMMENT 'Reference to the parent or predecessor document that this document supersedes, amends, or relates to, establishing document lineage.',
    `pledge_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge_agreement. Business justification: Deal documentation packages include pledge agreements, security agreements, and collateral schedules as exhibits. Real process: closing binder assembly, legal opinion delivery, document retention for ',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Deal documents (engagement letters, fairness opinions, underwriting agreements) are primary exam evidence. Examiners review documents to verify compliance with securities laws, fiduciary duties, discl',
    `previous_deal_document_id` BIGINT COMMENT 'Self-referencing FK on deal_document (previous_deal_document_id)',
    `amendment_number` STRING COMMENT 'Sequential number indicating which amendment this document represents to the original agreement or document, starting from 1 for the first amendment.',
    `approval_date` DATE COMMENT 'Date on which the document received formal approval from the designated reviewer or approval authority.',
    `author_department` STRING COMMENT 'Department or line of business within the bank responsible for creating the document, such as Investment Banking, Legal, or Compliance.',
    `bank_signatory_name` STRING COMMENT 'Name of the individual authorized to sign the document on behalf of the bank, typically a senior banker or authorized officer.',
    `bank_signatory_title` STRING COMMENT 'Job title or role of the bank signatory, establishing their authority to bind the bank to the document terms.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity of the document and access restrictions required for handling and distribution.. Valid values are `public|internal|confidential|restricted|highly_restricted`',
    `counterparty_name` STRING COMMENT 'Name of the external party or client that is a signatory or subject of the document, representing the other side of the transaction.',
    `counterparty_signatory_name` STRING COMMENT 'Name of the individual authorized to sign the document on behalf of the counterparty or client entity.',
    `counterparty_signatory_title` STRING COMMENT 'Job title or role of the counterparty signatory, establishing their authority to bind the counterparty entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was first created in the document management system, capturing initial registration.',
    `destruction_eligible_date` DATE COMMENT 'Calculated date after which the document becomes eligible for destruction or disposal, based on retention period and regulatory requirements.',
    `document_category` STRING COMMENT 'High-level categorization of the document by transaction phase, indicating when in the deal lifecycle the document is relevant.. Valid values are `pre_mandate|mandate|execution|regulatory|closing|post_closing`',
    `document_description` STRING COMMENT 'Detailed narrative description of the document content, purpose, and key terms, providing context for users accessing the document registry.',
    `document_name` STRING COMMENT 'Human-readable name or title of the deal document, describing its purpose and content.',
    `document_reference_number` STRING COMMENT 'Business-assigned unique reference number or code for the document, used for external identification and filing purposes.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document, tracking its progression from draft through execution and archival. [ENUM-REF-CANDIDATE: draft|under_review|approved|executed|filed|archived|superseded|cancelled — 8 candidates stripped; promote to reference product]',
    `document_storage_location` STRING COMMENT 'Physical or digital location where the document is stored, including file path, repository name, or physical archive location.',
    `document_type` STRING COMMENT 'Classification of the document by its functional purpose within the investment banking transaction lifecycle. [ENUM-REF-CANDIDATE: engagement_letter|nda|information_memorandum|prospectus|offering_circular|pitch_book|fairness_opinion|valuation_report|term_sheet|mandate_letter|underwriting_agreement|syndication_agreement|closing_binder|tombstone|regulatory_filing|legal_opinion|comfort_letter|due_diligence_report — promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which the terms and conditions of the document become operative and binding on the parties.',
    `execution_date` DATE COMMENT 'Date on which the document was formally executed or signed by all required parties, establishing legal effectiveness.',
    `expiry_date` DATE COMMENT 'Date on which the document ceases to be effective or binding, marking the end of its operational period.',
    `file_format` STRING COMMENT 'Technical file format or extension of the stored document, indicating the application required to access and view the content. [ENUM-REF-CANDIDATE: pdf|docx|xlsx|pptx|html|xml|txt — 7 candidates stripped; promote to reference product]',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the document file in kilobytes, used for storage management and transmission planning.',
    `filing_date` DATE COMMENT 'Date on which the document was filed with regulatory authorities or other external bodies, if applicable.',
    `is_executed` BOOLEAN COMMENT 'Indicates whether the document has been formally executed by all required parties, making it legally binding.',
    `is_material_change` BOOLEAN COMMENT 'Indicates whether the document represents a material change to the deal terms that requires disclosure or regulatory notification.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the document, enabling search and categorization within the document management system.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was most recently modified, tracking the latest change to document metadata or status.',
    `league_table_eligible` BOOLEAN COMMENT 'Indicates whether the document and associated deal qualify for submission to league table ranking providers such as Bloomberg or Dealogic.',
    `legal_counsel_firm` STRING COMMENT 'Name of the external law firm or legal counsel that advised on or reviewed the document, if applicable.',
    `page_count` STRING COMMENT 'Total number of pages in the document, relevant for physical printing and review planning.',
    `regulatory_filing_reference` STRING COMMENT 'External reference number or identifier assigned by the regulatory body upon filing, such as SEC file number or EDGAR accession number.',
    `retention_classification` STRING COMMENT 'Document retention category determining the minimum period the document must be retained per regulatory and internal policy requirements.. Valid values are `permanent|long_term|standard|short_term`',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained from the effective or execution date, as mandated by regulatory requirements or internal policy.',
    `reviewer_name` STRING COMMENT 'Name of the individual responsible for reviewing and approving the document before execution or filing.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether the document and associated deal are eligible for inclusion in league table tombstone advertisements and marketing materials.',
    `version_number` STRING COMMENT 'Version identifier for the document, tracking iterations and revisions throughout the document lifecycle.',
    CONSTRAINT pk_deal_document PRIMARY KEY(`deal_document_id`)
) COMMENT 'Document registry for investment banking deals including engagement letters, NDAs, information memoranda, prospectuses, and closing binders. Captures document type, version, execution status, and retention classification.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`pipeline_stage` (
    `pipeline_stage_id` BIGINT COMMENT 'Unique identifier for the investment banking deal pipeline stage. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this pipeline stage definition in the system.',
    `primary_predecessor_stage_pipeline_stage_id` BIGINT COMMENT 'Reference to the pipeline stage that typically precedes this stage in the standard deal progression workflow.',
    `parent_pipeline_stage_id` BIGINT COMMENT 'Self-referencing FK on pipeline_stage (parent_pipeline_stage_id)',
    `aml_screening_required_flag` BOOLEAN COMMENT 'Indicates whether Anti-Money Laundering screening and sanctions checks must be performed at this stage.',
    `approval_committee_type` STRING COMMENT 'Type of committee responsible for approving deals at this stage, if approval is required.. Valid values are `credit_committee|risk_committee|capital_committee|executive_committee|none`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval from a committee or senior management is required before a deal can progress from this stage.',
    `average_duration_days` STRING COMMENT 'Typical number of days a deal remains in this stage based on historical data, used for timeline planning and bottleneck identification.',
    `client_notification_required_flag` BOOLEAN COMMENT 'Indicates whether formal notification to the client is required when a deal transitions to this stage.',
    `conflict_check_required_flag` BOOLEAN COMMENT 'Indicates whether a formal conflict of interest check must be completed before a deal can enter or progress through this stage.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pipeline stage record was first created in the system.',
    `deal_type_applicability` STRING COMMENT 'Comma-separated list of deal types for which this stage is relevant (e.g., IPO, M&A, Debt Issuance, Equity Offering).',
    `display_order` STRING COMMENT 'Numeric value controlling the presentation order of stages in user interfaces and reports, allowing for custom sorting independent of sequence number.',
    `effective_from_date` DATE COMMENT 'Date from which this pipeline stage definition became active and available for use in deal workflows.',
    `effective_until_date` DATE COMMENT 'Date until which this pipeline stage definition remains active; null indicates the stage is currently active with no planned end date.',
    `entry_criteria` STRING COMMENT 'Business conditions and requirements that must be met for a deal to enter this stage.',
    `exit_criteria` STRING COMMENT 'Business conditions and requirements that must be met for a deal to progress from this stage to the next.',
    `key_deliverables` STRING COMMENT 'Primary work products and documentation that must be completed during this stage (e.g., pitch book, valuation model, due diligence report).',
    `kyc_required_flag` BOOLEAN COMMENT 'Indicates whether Know Your Customer due diligence must be completed at this stage to comply with anti-money laundering regulations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this pipeline stage record was most recently modified in the system.',
    `lob_applicability` STRING COMMENT 'Comma-separated list of investment banking lines of business to which this stage applies (e.g., M&A, ECM, DCM, Syndicated Lending).',
    `minimum_approval_level` STRING COMMENT 'Minimum seniority level of approver required for deals at this stage, ensuring appropriate oversight based on deal complexity and risk.. Valid values are `managing_director|division_head|ceo|board|none`',
    `probability_weighting_pct` DECIMAL(18,2) COMMENT 'Statistical probability percentage that a deal in this stage will successfully close, used for pipeline revenue forecasting and weighted deal value calculations.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory filings or notifications are typically required when a deal reaches this stage.',
    `revenue_recognition_trigger_flag` BOOLEAN COMMENT 'Indicates whether reaching this stage triggers revenue recognition events under applicable accounting standards.',
    `rwa_calculation_required_flag` BOOLEAN COMMENT 'Indicates whether Risk-Weighted Assets must be calculated for deals at this stage for regulatory capital purposes.',
    `sequence_number` STRING COMMENT 'Ordinal position of this stage in the standard deal pipeline progression, used for sorting and workflow automation.',
    `stage_category` STRING COMMENT 'High-level categorization of the pipeline stage grouping similar stages together for strategic analysis and reporting.. Valid values are `pre_mandate|mandate|execution|post_closing`',
    `stage_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the pipeline stage for system integration and reporting purposes.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `stage_color_code` STRING COMMENT 'Hexadecimal color code used for visual representation of this stage in dashboards and pipeline visualizations.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `stage_description` STRING COMMENT 'Detailed description of the activities, milestones, and deliverables associated with this pipeline stage.',
    `stage_icon_reference` STRING COMMENT 'Reference identifier or path to the icon image used to represent this stage in user interfaces.',
    `stage_name` STRING COMMENT 'Human-readable name of the deal pipeline stage (e.g., Origination, Pitch, Mandate, Due Diligence, Execution, Closing).',
    `stage_status` STRING COMMENT 'Current operational status of the pipeline stage indicating whether it is actively used in deal workflows.. Valid values are `active|inactive|deprecated|archived`',
    `tombstone_eligible_flag` BOOLEAN COMMENT 'Indicates whether deals that reach this stage are eligible for tombstone publication and league table credit.',
    CONSTRAINT pk_pipeline_stage PRIMARY KEY(`pipeline_stage_id`)
) COMMENT 'Reference table defining the stages of the investment banking deal pipeline from origination through closing. Captures stage name, sequence, probability weighting, and required approvals.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`deal_participation` (
    `deal_participation_id` BIGINT COMMENT 'Unique surrogate identifier for the deal participation record. Primary key for the association.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to the investment banking deal in which the party is participating.',
    `party_id` BIGINT COMMENT 'Foreign key linking to the party participating in the deal. References the golden master record for the legal entity or natural person.',
    `agreed_fee_amount` DECIMAL(18,2) COMMENT 'The specific fee amount or percentage agreed for this partys participation. Currency matches deal_currency from the deal record.',
    `conflict_check_status` STRING COMMENT 'Result of the conflict of interest review for this partys participation in this deal. Critical for regulatory compliance and information barrier enforcement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was created.',
    `engagement_end_date` DATE COMMENT 'The date on which the partys participation in this deal concluded. Null for ongoing engagements.',
    `engagement_start_date` DATE COMMENT 'The date on which the party formally began participation in this deal. Used for timeline tracking and fee calculation.',
    `fee_arrangement_type` STRING COMMENT 'The fee structure agreed upon for this partys participation in this deal. Determines how compensation is calculated.',
    `nda_executed` BOOLEAN COMMENT 'Indicates whether a non-disclosure agreement has been executed with this party for this specific deal. Controls information sharing permissions.',
    `nda_execution_date` DATE COMMENT 'The date on which the NDA was signed for this deal participation. Null if nda_executed is false.',
    `participant_role` STRING COMMENT 'The functional role the party plays in this specific deal. Determines responsibilities, information access, and fee eligibility.',
    `participant_side` STRING COMMENT 'Which side of the transaction the party represents. Critical for conflict checking and information barrier management.',
    `participant_status` STRING COMMENT 'Current operational status of the partys participation in this deal. Tracks lifecycle from prospect through completion.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the deal this party is participating in, relevant for syndicated transactions. Used for risk allocation and fee distribution.',
    `syndicate_rank` STRING COMMENT 'The hierarchical position of this party within the deal syndicate (1=lead, 2=co-lead, etc.). Null for non-syndicate participants. Determines fee allocation and tombstone ordering.',
    `tombstone_eligible` BOOLEAN COMMENT 'Indicates whether this partys participation should be included in the deal tombstone (public announcement of participants). Reflects contractual and reputational considerations.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was last modified.',
    CONSTRAINT pk_deal_participation PRIMARY KEY(`deal_participation_id`)
) COMMENT 'This association product represents the participation relationship between parties and investment banking deals. It captures the role, engagement timeline, conflict status, fee arrangements, and syndicate positioning for each party involved in a deal. Each record links one party to one deal with attributes that exist only in the context of this specific engagement.. Existence Justification: Investment banking deals inherently involve multiple parties in various roles (client, target, advisors, lenders, underwriters, legal counsel), and each party participates in multiple deals over time. The business actively manages deal participation as a distinct operational entity, tracking role-specific data such as engagement dates, conflict status, NDA execution, fee arrangements, and syndicate positioning that cannot be stored on either party or deal alone.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`deal_broker_participation` (
    `deal_broker_participation_id` BIGINT COMMENT 'Unique surrogate identifier for the deal-broker participation record. Primary key for the association.',
    `broker_id` BIGINT COMMENT 'Foreign key linking to the broker participating in the deal syndicate',
    `deal_id` BIGINT COMMENT 'Foreign key linking to the investment banking deal',
    `broker_role` STRING COMMENT 'The specific role the broker plays in this deal syndicate. Bookrunner leads the transaction, lead managers have significant responsibility, co-managers participate in distribution, selling group members assist with placement. Drives fee allocation and tombstone positioning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this participation record was first created in the system, used for audit trail.',
    `economics_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the fee share amount is denominated. Typically matches deal currency but may differ for cross-border syndicates.',
    `engagement_date` DATE COMMENT 'The date on which this broker was formally engaged or added to the deal syndicate. May differ from deal mandate date if brokers join at different stages (e.g., selling group added closer to pricing).',
    `fee_share_amount` DECIMAL(18,2) COMMENT 'The absolute dollar amount of advisory or underwriting fees allocated to this broker for this specific deal. Calculated based on participation percentage, broker role, and negotiated fee splits.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the deal that this broker is responsible for distributing or underwriting. Used for risk allocation and fee calculation. Sum across all brokers for a deal typically equals 100%.',
    `participation_status` STRING COMMENT 'Current status of this brokers participation in the deal. Active during execution, completed at closing, withdrawn if broker exits syndicate, terminated if deal is cancelled.',
    `syndicate_rank` BIGINT COMMENT 'The ordinal ranking of this broker within the deal syndicate (1 = lead bookrunner, 2 = second position, etc.). Determines positioning on tombstone advertisements and league table credit.',
    `tombstone_credit_flag` BOOLEAN COMMENT 'Indicates whether this broker receives credit on the deal tombstone advertisement. Typically true for bookrunners and managers, may be false for passive selling group members depending on deal terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this participation record was last modified, used for audit trail and change tracking.',
    CONSTRAINT pk_deal_broker_participation PRIMARY KEY(`deal_broker_participation_id`)
) COMMENT 'This association product represents the participation relationship between brokers and investment banking deals. It captures the syndicate structure for each deal, recording which brokers participate in what capacity (bookrunner, co-manager, selling group member), their economic share, and their syndicate ranking. Each record links one broker to one deal with attributes that exist only in the context of this specific deal participation.. Existence Justification: Investment banking deals are executed through syndicates where multiple brokers participate in different capacities (bookrunner, lead manager, co-manager, selling group). Each broker participates in multiple deals over time. The syndicate structure is an operational business entity that investment bankers actively manage during deal execution, with specific data about each brokers role, economic participation, fee allocation, and tombstone positioning that cannot be stored on either the broker or deal entity alone.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`deal_team_member` (
    `deal_team_member_id` BIGINT COMMENT 'Unique surrogate identifier for the deal team member assignment record. Primary key for this association.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to the investment banking deal. Each team member assignment is associated with exactly one deal.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the deal team. References the bank employee who is performing a specific role on this deal.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees time allocated to this deal (0.00-100.00%). Used for resource capacity planning and utilization tracking. Explicitly identified in detection reasoning as relationship data.',
    `assignment_status` STRING COMMENT 'Current operational status of the team member assignment. ACTIVE indicates currently staffed, COMPLETED indicates deal closed with assignment fulfilled, REMOVED indicates employee was removed from team before deal completion.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the deal team member assignment record was created. Used for audit trail and data lineage.',
    `end_date` DATE COMMENT 'Date on which the employees assignment to the deal team ended. Null for active assignments. Used for historical team composition analysis. Explicitly identified in detection reasoning as relationship data.',
    `is_lead_banker` BOOLEAN COMMENT 'Flag indicating whether this employee is designated as the lead or primary banker for the deal. Typically one lead per deal, but may change during deal lifecycle. Explicitly identified in detection reasoning as relationship data.',
    `revenue_credit_pct` DECIMAL(18,2) COMMENT 'Percentage of deal revenue credited to this employee for compensation and performance evaluation purposes (0.00-100.00%). Sum across all team members may exceed 100% due to overlapping credit rules. Explicitly identified in detection reasoning as relationship data.',
    `role_type` STRING COMMENT 'The specific role or function the employee performs on this deal team. Determines responsibility scope, revenue credit eligibility, and approval authority. Explicitly identified in detection reasoning as relationship data.',
    `start_date` DATE COMMENT 'Date on which the employee was assigned to the deal team. Used for tracking team composition changes over the deal lifecycle. Explicitly identified in detection reasoning as relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the deal team member assignment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_deal_team_member PRIMARY KEY(`deal_team_member_id`)
) COMMENT 'This association product represents the assignment of investment banking professionals to deal teams. It captures the operational reality that deals require multiple bankers with different roles (originator, coverage, product specialist, structurer, analyst) and bankers work on multiple deals simultaneously. Each record links one deal to one employee with role-specific attributes including revenue credit allocation, time allocation percentage, role type, and assignment period. This is a core operational entity used for compensation planning, resource allocation, revenue attribution, and deal staffing management.. Existence Justification: Investment banking deals require multiple professionals in distinct roles (originator, coverage officer, product specialist, structurer, analysts) working simultaneously, and each banker works on multiple deals concurrently. The business actively manages deal team composition as a core operational process, tracking role-specific revenue attribution, time allocation percentages, and compensation credit for each banker-deal pairing. Deal teams are not derived from transactional data—they are explicitly staffed, managed, and modified throughout the deal lifecycle.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`approval_committee` (
    `approval_committee_id` BIGINT COMMENT 'Primary key for approval_committee',
    `parent_approval_committee_id` BIGINT COMMENT 'Self-referencing FK on approval_committee (parent_approval_committee_id)',
    `approval_authority_level` STRING COMMENT 'Hierarchical level of decision-making authority granted to this committee within the investment banking approval structure.',
    `approval_scope_description` STRING COMMENT 'Detailed description of the types of transactions, mandates, and decisions within the committees approval jurisdiction (e.g., M&A deals, IPO underwriting, debt issuance, fairness opinions).',
    `chairperson_name` STRING COMMENT 'Full name of the individual serving as chairperson of the approval committee.',
    `chairperson_title` STRING COMMENT 'Official job title of the committee chairperson within the organization.',
    `charter_document_reference` STRING COMMENT 'Reference identifier or location of the formal charter document that establishes the committees mandate, composition, and operating procedures.',
    `committee_code` STRING COMMENT 'Unique business identifier code for the approval committee used in external communications and mandate documentation.',
    `committee_name` STRING COMMENT 'Official name of the approval committee (e.g., Investment Committee, Credit Committee, Fairness Opinion Committee).',
    `committee_type` STRING COMMENT 'Classification of the committee based on its primary approval authority and decision-making scope within investment banking operations.',
    `conflict_of_interest_policy` STRING COMMENT 'Description of the conflict of interest policy governing committee member participation and recusal requirements.',
    `contact_email` STRING COMMENT 'Primary email address for submitting materials and inquiries to the approval committee.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this approval committee record was first created in the system.',
    `delegation_authority_flag` BOOLEAN COMMENT 'Indicates whether this committee has the authority to delegate approval decisions to sub-committees or individual officers.',
    `effective_date` DATE COMMENT 'Date when the approval committee was formally established and began its approval authority.',
    `escalation_committee_code` STRING COMMENT 'Code of the higher-level committee to which transactions exceeding this committees authority are escalated.',
    `geographic_jurisdiction` STRING COMMENT 'Geographic scope of the committees approval authority (e.g., Global, Americas, EMEA, APAC, specific country codes).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this approval committee record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date when the committees charter, composition, and authority were last reviewed and reaffirmed by senior management or the board.',
    `maximum_approval_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum transaction value that this committee is authorized to approve without escalation, expressed in the base currency.',
    `meeting_frequency` STRING COMMENT 'Standard frequency at which the committee convenes for approval reviews and decision-making sessions.',
    `member_count` STRING COMMENT 'Total number of active members currently serving on the approval committee.',
    `minimum_approval_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum transaction value that requires approval from this committee, expressed in the base currency.',
    `minutes_retention_period_years` STRING COMMENT 'Number of years that committee meeting minutes and approval records must be retained per regulatory and corporate policy requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the committees charter, composition, and authority.',
    `product_line_coverage` STRING COMMENT 'Investment banking product lines covered by this committees approval authority (e.g., M&A Advisory, Equity Capital Markets, Debt Capital Markets, Leveraged Finance).',
    `quorum_requirement` STRING COMMENT 'Minimum number of committee members required to be present for a valid approval decision.',
    `regulatory_oversight_flag` BOOLEAN COMMENT 'Indicates whether this committees decisions are subject to regulatory oversight or reporting requirements.',
    `secretary_name` STRING COMMENT 'Full name of the individual serving as secretary responsible for committee administration and record-keeping.',
    `approval_committee_status` STRING COMMENT 'Current operational status of the approval committee indicating whether it is actively reviewing and approving transactions.',
    `termination_date` DATE COMMENT 'Date when the approval committee was dissolved or its approval authority was terminated. Null for active committees.',
    `threshold_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approval threshold amounts.',
    `voting_threshold_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of affirmative votes required from present members to approve a transaction (e.g., 50.00 for simple majority, 66.67 for supermajority).',
    CONSTRAINT pk_approval_committee PRIMARY KEY(`approval_committee_id`)
) COMMENT 'Master reference table for approval_committee. Referenced by approval_committee_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`investment`.`tranche` (
    `tranche_id` BIGINT COMMENT 'Primary key for tranche',
    `deal_id` BIGINT COMMENT 'Reference to the parent investment banking deal or transaction that this tranche is part of.',
    `party_id` BIGINT COMMENT 'Reference to the financial institution acting as the lead arranger or bookrunner for the tranche.',
    `parent_tranche_id` BIGINT COMMENT 'Self-referencing FK on tranche (parent_tranche_id)',
    `amortization_schedule` STRING COMMENT 'Description or reference to the detailed amortization schedule for the tranche.',
    `amortization_type` STRING COMMENT 'The repayment structure of the tranche (e.g., bullet, amortizing, balloon).',
    `benchmark_rate` STRING COMMENT 'The reference benchmark rate used for floating rate tranches (e.g., SOFR, LIBOR, EURIBOR).',
    `call_date` DATE COMMENT 'The earliest date on which the issuer may exercise the call provision.',
    `call_provision_flag` BOOLEAN COMMENT 'Indicates whether the tranche includes a call provision allowing early redemption by the issuer.',
    `collateral_description` STRING COMMENT 'Description of the collateral securing the tranche, if applicable.',
    `commitment_fee_rate` DECIMAL(18,2) COMMENT 'The commitment fee rate charged on undrawn amounts, expressed as a decimal.',
    `committed_amount` DECIMAL(18,2) COMMENT 'The amount committed by lenders or underwriters for this tranche.',
    `covenant_package` STRING COMMENT 'Classification of the covenant structure attached to the tranche (e.g., covenant-lite, traditional).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tranche record was first created in the system.',
    `credit_rating` STRING COMMENT 'The credit rating assigned to the tranche by a rating agency (e.g., AAA, BB+).',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the tranche denomination.',
    `day_count_convention` STRING COMMENT 'The day count convention used for interest calculation (e.g., 30/360, ACT/360).',
    `effective_date` DATE COMMENT 'The date from which the tranche terms become effective and interest begins accruing.',
    `first_payment_date` DATE COMMENT 'The date of the first scheduled interest or principal payment.',
    `instrument_type` STRING COMMENT 'The financial instrument category that this tranche represents (e.g., loan, bond, note).',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applicable to the tranche, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `interest_rate_type` STRING COMMENT 'Indicates whether the interest rate is fixed, floating, or variable.',
    `maturity_date` DATE COMMENT 'The date on which the tranche principal is due for full repayment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tranche record was last modified.',
    `origination_date` DATE COMMENT 'The date on which the tranche was originated or issued.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'The current outstanding principal balance of the tranche.',
    `payment_frequency` STRING COMMENT 'The frequency at which interest or principal payments are made.',
    `prepayment_penalty_flag` BOOLEAN COMMENT 'Indicates whether a penalty applies for early prepayment of the tranche.',
    `prepayment_penalty_rate` DECIMAL(18,2) COMMENT 'The penalty rate applied to early prepayments, expressed as a decimal.',
    `principal_amount` DECIMAL(18,2) COMMENT 'The total principal or face value amount of the tranche at origination.',
    `rating_agency` STRING COMMENT 'The name of the credit rating agency that assigned the rating (e.g., Moodys, S&P, Fitch).',
    `rating_date` DATE COMMENT 'The date on which the credit rating was assigned or last updated.',
    `regulatory_capital_treatment` STRING COMMENT 'The regulatory capital classification of the tranche under Basel III or other applicable frameworks.',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'The risk weight percentage assigned to the tranche for regulatory capital calculation purposes.',
    `security_type` STRING COMMENT 'Indicates whether the tranche is secured by collateral or unsecured.',
    `seniority_level` STRING COMMENT 'Indicates the priority of the tranche in the repayment waterfall relative to other tranches.',
    `spread_bps` STRING COMMENT 'The credit spread over the benchmark rate, expressed in basis points.',
    `tranche_status` STRING COMMENT 'Current lifecycle status of the tranche.',
    `syndication_flag` BOOLEAN COMMENT 'Indicates whether the tranche is syndicated among multiple lenders or underwriters.',
    `tranche_code` STRING COMMENT 'Externally-known unique code or identifier for the tranche, used in deal documentation and regulatory filings.',
    `tranche_name` STRING COMMENT 'Human-readable name or label for the tranche, often indicating seniority or class (e.g., Senior Secured, Mezzanine, Class A).',
    `tranche_type` STRING COMMENT 'Classification of the tranche based on its position in the capital structure and risk profile.',
    `underwriting_fee_rate` DECIMAL(18,2) COMMENT 'The underwriting or arrangement fee rate charged for the tranche, expressed as a decimal percentage of principal.',
    `utilization_fee_rate` DECIMAL(18,2) COMMENT 'The utilization fee rate applied when drawn amounts exceed a specified threshold, expressed as a decimal.',
    CONSTRAINT pk_tranche PRIMARY KEY(`tranche_id`)
) COMMENT 'Master reference table for tranche. Referenced by tranche_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`investment`.`deal` ADD CONSTRAINT `fk_investment_deal_pipeline_stage_id` FOREIGN KEY (`pipeline_stage_id`) REFERENCES `banking_ecm`.`investment`.`pipeline_stage`(`pipeline_stage_id`);
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ADD CONSTRAINT `fk_investment_transaction_structure_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_approval_committee_id` FOREIGN KEY (`approval_committee_id`) REFERENCES `banking_ecm`.`investment`.`approval_committee`(`approval_committee_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ADD CONSTRAINT `fk_investment_investment_valuation_transaction_structure_id` FOREIGN KEY (`transaction_structure_id`) REFERENCES `banking_ecm`.`investment`.`transaction_structure`(`transaction_structure_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ADD CONSTRAINT `fk_investment_fee_arrangement_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ADD CONSTRAINT `fk_investment_investment_syndication_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_investment_syndication_id` FOREIGN KEY (`investment_syndication_id`) REFERENCES `banking_ecm`.`investment`.`investment_syndication`(`investment_syndication_id`);
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ADD CONSTRAINT `fk_investment_syndication_allocation_tranche_id` FOREIGN KEY (`tranche_id`) REFERENCES `banking_ecm`.`investment`.`tranche`(`tranche_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ADD CONSTRAINT `fk_investment_underwriting_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_coverage_assignment_id` FOREIGN KEY (`coverage_assignment_id`) REFERENCES `banking_ecm`.`investment`.`coverage_assignment`(`coverage_assignment_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ADD CONSTRAINT `fk_investment_investment_investor_order_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ADD CONSTRAINT `fk_investment_tombstone_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ADD CONSTRAINT `fk_investment_deal_participant_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ADD CONSTRAINT `fk_investment_investment_regulatory_filing_parent_filing_investment_regulatory_filing_id` FOREIGN KEY (`parent_filing_investment_regulatory_filing_id`) REFERENCES `banking_ecm`.`investment`.`investment_regulatory_filing`(`investment_regulatory_filing_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_coverage_assignment_id` FOREIGN KEY (`coverage_assignment_id`) REFERENCES `banking_ecm`.`investment`.`coverage_assignment`(`coverage_assignment_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_investment_mandate_id` FOREIGN KEY (`investment_mandate_id`) REFERENCES `banking_ecm`.`investment`.`investment_mandate`(`investment_mandate_id`);
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ADD CONSTRAINT `fk_investment_pitch_book_previous_pitch_book_id` FOREIGN KEY (`previous_pitch_book_id`) REFERENCES `banking_ecm`.`investment`.`pitch_book`(`pitch_book_id`);
ALTER TABLE `banking_ecm`.`investment`.`league_table` ADD CONSTRAINT `fk_investment_league_table_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`league_table` ADD CONSTRAINT `fk_investment_league_table_previous_league_table_id` FOREIGN KEY (`previous_league_table_id`) REFERENCES `banking_ecm`.`investment`.`league_table`(`league_table_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `banking_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_parent_document_deal_document_id` FOREIGN KEY (`parent_document_deal_document_id`) REFERENCES `banking_ecm`.`investment`.`deal_document`(`deal_document_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ADD CONSTRAINT `fk_investment_deal_document_previous_deal_document_id` FOREIGN KEY (`previous_deal_document_id`) REFERENCES `banking_ecm`.`investment`.`deal_document`(`deal_document_id`);
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ADD CONSTRAINT `fk_investment_pipeline_stage_primary_predecessor_stage_pipeline_stage_id` FOREIGN KEY (`primary_predecessor_stage_pipeline_stage_id`) REFERENCES `banking_ecm`.`investment`.`pipeline_stage`(`pipeline_stage_id`);
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ADD CONSTRAINT `fk_investment_pipeline_stage_parent_pipeline_stage_id` FOREIGN KEY (`parent_pipeline_stage_id`) REFERENCES `banking_ecm`.`investment`.`pipeline_stage`(`pipeline_stage_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ADD CONSTRAINT `fk_investment_deal_participation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ADD CONSTRAINT `fk_investment_deal_broker_participation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ADD CONSTRAINT `fk_investment_deal_team_member_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` ADD CONSTRAINT `fk_investment_approval_committee_parent_approval_committee_id` FOREIGN KEY (`parent_approval_committee_id`) REFERENCES `banking_ecm`.`investment`.`approval_committee`(`approval_committee_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `banking_ecm`.`investment`.`deal`(`deal_id`);
ALTER TABLE `banking_ecm`.`investment`.`tranche` ADD CONSTRAINT `fk_investment_tranche_parent_tranche_id` FOREIGN KEY (`parent_tranche_id`) REFERENCES `banking_ecm`.`investment`.`tranche`(`tranche_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`investment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`investment` SET TAGS ('dbx_domain' = 'investment');
ALTER TABLE `banking_ecm`.`investment`.`deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`deal` SET TAGS ('dbx_subdomain' = 'deal_origination');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `alco_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Meeting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `pipeline_stage_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Team Lead ID');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `actual_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closing Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Announcement Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `complexity` SET TAGS ('dbx_business_glossary_term' = 'Deal Complexity');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `complexity` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|VERY_HIGH');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Deal Confidentiality Level');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'PUBLIC|INTERNAL|CONFIDENTIAL|STRICTLY_CONFIDENTIAL');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Currency');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_business_glossary_term' = 'Deal Code');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_description` SET TAGS ('dbx_business_glossary_term' = 'Deal Description');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|ON_HOLD|CLOSED_WON|CLOSED_LOST|WITHDRAWN|TERMINATED');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'M&A_BUY_SIDE|M&A_SELL_SIDE|ECM|DCM|LBO|RESTRUCTURING');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `expected_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Closing Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `expected_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `expected_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `fee_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `fee_rate_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Deal Indicator');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `is_public_company` SET TAGS ('dbx_business_glossary_term' = 'Public Company Indicator');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `mandate_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Origination Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `pipeline_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Probability Percentage');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `pitch_date` SET TAGS ('dbx_business_glossary_term' = 'Pitch Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Deal Strategic Rationale');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'AMER|EMEA|APAC');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Indicator');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `restricted_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted List Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Deal Size');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `source_system_deal_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Deal Reference');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Deal Sub-Type');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `target_company_name` SET TAGS ('dbx_business_glossary_term' = 'Target Company Name');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `target_company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `target_country_code` SET TAGS ('dbx_business_glossary_term' = 'Target Country Code');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `target_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `target_enterprise_value` SET TAGS ('dbx_business_glossary_term' = 'Target Enterprise Value (EV)');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `target_enterprise_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Banker ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `bank_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Signatory Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `bank_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Completion Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Mandate Confidentiality Level');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|wall_crossed');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Check Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|conflict_identified|waived');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `deal_size_currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Size Currency (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `deal_size_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|expert_determination');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `engagement_scope` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Description');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `engagement_scope` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `estimated_deal_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Size');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `estimated_deal_size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period End Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `exclusivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Start Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_business_glossary_term' = 'Governing Law State or Province');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `industry_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Code (GICS/SIC)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `industry_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `investment_mandate_status` SET TAGS ('dbx_business_glossary_term' = 'Mandate Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `investment_mandate_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|completed|lapsed');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Indicator');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|approved|expired|remediation_required');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `league_table_eligible` SET TAGS ('dbx_business_glossary_term' = 'League Table Eligible Indicator');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `letter_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Letter Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `letter_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `lob_code` SET TAGS ('dbx_value_regex' = 'IBD|ECM|DCM|M_AND_A|SYND|CORP_FIN');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_value_regex' = 'exclusive_advisor|co_advisor|bookrunner|co_manager|lead_manager|arranger');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `pitch_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Pitch Book Reference');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Mandate Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-MND-[0-9]{4}-[0-9]{4,8}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Indicator');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `retainer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainer Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `retainer_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `success_fee_bps` SET TAGS ('dbx_business_glossary_term' = 'Success Fee Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `success_fee_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `tail_period_months` SET TAGS ('dbx_business_glossary_term' = 'Tail Period (Months)');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `target_company_name` SET TAGS ('dbx_business_glossary_term' = 'Target Company Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `target_company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Termination Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `termination_rights` SET TAGS ('dbx_business_glossary_term' = 'Termination Rights Description');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `termination_rights` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Indicator');
ALTER TABLE `banking_ecm`.`investment`.`investment_mandate` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `transaction_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure ID');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Industry Sector Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Target Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Transaction Close Date');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `advisory_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Advisory Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `advisory_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Announcement Date');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `breakup_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Breakup Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `breakup_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `cash_consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Consideration Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `cash_consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `confidentiality_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement (NDA) Date');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `consideration_type` SET TAGS ('dbx_business_glossary_term' = 'Consideration Type');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `consideration_type` SET TAGS ('dbx_value_regex' = 'cash|stock|mixed|debt|earnout');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Flag');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `dcf_enterprise_value` SET TAGS ('dbx_business_glossary_term' = 'Discounted Cash Flow (DCF) Enterprise Value');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `dcf_enterprise_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `deal_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Currency (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `deal_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `debt_assumed_amount` SET TAGS ('dbx_business_glossary_term' = 'Debt Assumed Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `debt_assumed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `equity_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Equity Value Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `equity_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `exchange_ratio` SET TAGS ('dbx_business_glossary_term' = 'Share Exchange Ratio');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Transaction Close Date');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `fairness_opinion_required` SET TAGS ('dbx_business_glossary_term' = 'Fairness Opinion Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `financing_mix_debt_pct` SET TAGS ('dbx_business_glossary_term' = 'Financing Mix Debt Percentage');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `financing_mix_equity_pct` SET TAGS ('dbx_business_glossary_term' = 'Financing Mix Equity Percentage');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `lead_arranger_role` SET TAGS ('dbx_business_glossary_term' = 'Lead Arranger Role');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `lead_arranger_role` SET TAGS ('dbx_value_regex' = 'sole_bookrunner|joint_bookrunner|lead_left|co_manager|financial_advisor|fairness_opinion_provider');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Transaction Leverage Ratio (Debt/EBITDA)');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `offer_premium_pct` SET TAGS ('dbx_business_glossary_term' = 'Offer Premium Percentage');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `pro_forma_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Pro Forma Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `regulatory_approval_bodies` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Bodies');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `shareholder_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Shareholder Approval Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `stock_consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Stock Consideration Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `stock_consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structural_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Structural Condition Type');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structural_condition_type` SET TAGS ('dbx_value_regex' = 'material_adverse_change|regulatory_condition|financing_condition|no_shop|go_shop|breakup_fee');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Name');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Reference Code');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4}-[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Status');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|executed|terminated|on_hold');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `structure_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Type');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `syndication_required` SET TAGS ('dbx_business_glossary_term' = 'Syndication Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `underwriting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `underwriting_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`transaction_structure` ALTER COLUMN `wacc_rate` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Cost of Capital (WACC) Rate');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `investment_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Valuation ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `approval_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Committee ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Analyst ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Industry Sector Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `market_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Market Data Source Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Target Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `transaction_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `board_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Board Presentation Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Check Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'cleared|conflict_identified|waived|pending');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `enterprise_value_high` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Value (EV) High');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `enterprise_value_high` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `enterprise_value_low` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Value (EV) Low');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `enterprise_value_low` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `equity_value_high` SET TAGS ('dbx_business_glossary_term' = 'Equity Value High');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `equity_value_high` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `equity_value_low` SET TAGS ('dbx_business_glossary_term' = 'Equity Value Low');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `equity_value_low` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `ev_ebitda_multiple_high` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Value to EBITDA (EV/EBITDA) Multiple High');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `ev_ebitda_multiple_high` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `ev_ebitda_multiple_low` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Value to EBITDA (EV/EBITDA) Multiple Low');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `ev_ebitda_multiple_low` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `forecast_period_years` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period (Years)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `implied_share_price_high` SET TAGS ('dbx_business_glossary_term' = 'Implied Share Price High');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `implied_share_price_high` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `implied_share_price_low` SET TAGS ('dbx_business_glossary_term' = 'Implied Share Price Low');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `implied_share_price_low` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `is_fairness_opinion` SET TAGS ('dbx_business_glossary_term' = 'Is Fairness Opinion Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `ltm_ebitda` SET TAGS ('dbx_business_glossary_term' = 'Last Twelve Months (LTM) EBITDA');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `ltm_ebitda` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `material_relationship_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Material Relationship Disclosure');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `material_relationship_disclosure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `model_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model File Reference');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `model_file_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `net_debt` SET TAGS ('dbx_business_glossary_term' = 'Net Debt');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `net_debt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `opinion_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Opinion Conclusion');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `opinion_conclusion` SET TAGS ('dbx_value_regex' = 'fair|not_fair|unable_to_opine|adequate|inadequate');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Opinion Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `opinion_type` SET TAGS ('dbx_value_regex' = 'fairness|solvency|valuation|adequacy');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `pe_multiple_high` SET TAGS ('dbx_business_glossary_term' = 'Price-to-Earnings (P/E) Multiple High');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `pe_multiple_high` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `pe_multiple_low` SET TAGS ('dbx_business_glossary_term' = 'Price-to-Earnings (P/E) Multiple Low');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `pe_multiple_low` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^VAL-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `secondary_methodology` SET TAGS ('dbx_business_glossary_term' = 'Secondary Valuation Methodology');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `shares_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Shares Outstanding');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `shares_outstanding` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `target_company_name` SET TAGS ('dbx_business_glossary_term' = 'Target Company Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `target_company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `terminal_growth_rate` SET TAGS ('dbx_business_glossary_term' = 'Terminal Growth Rate');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `terminal_growth_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|delivered|superseded|withdrawn');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `wacc` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Cost of Capital (WACC)');
ALTER TABLE `banking_ecm`.`investment`.`investment_valuation` ALTER COLUMN `wacc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement ID');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate ID');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Banker ID');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|escalated');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Number');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_value_regex' = '^FA-[A-Z]{2,6}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Status');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|completed|expired');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `bank_fee_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Bank Fee Share Percentage');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `bank_fee_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `break_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Break Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `break_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `co_advisor_fee_sharing_pct` SET TAGS ('dbx_business_glossary_term' = 'Co-Advisor Fee Sharing Percentage');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `co_advisor_fee_sharing_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `deal_value_basis` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Basis');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `deal_value_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Dispute Description');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `engagement_letter_ref` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter Reference');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `engagement_letter_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered|blended|minimum_plus_percentage');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_rate_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'retainer|success_fee|underwriting_spread|advisory_fee|break_fee|tail_fee');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|partially_paid|paid|overdue|waived|disputed');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `received_amount` SET TAGS ('dbx_business_glossary_term' = 'Received Amount');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `received_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainer Amount');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `retainer_creditable` SET TAGS ('dbx_business_glossary_term' = 'Retainer Creditable Flag');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `retainer_frequency` SET TAGS ('dbx_business_glossary_term' = 'Retainer Payment Frequency');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `retainer_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|one_time');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|milestone_based|contingent');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `tail_period_months` SET TAGS ('dbx_business_glossary_term' = 'Tail Period (Months)');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`fee_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `investment_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `alco_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Meeting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `actual_selldown_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Sell-Down Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `actual_selldown_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `arrangement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `arrangement_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'leveraged_loan|investment_grade|clo|abs|mbs|project_finance');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `bank_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Bank Hold Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `bank_hold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `bookrunner_role` SET TAGS ('dbx_business_glossary_term' = 'Bookrunner Role');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `bookrunner_role` SET TAGS ('dbx_value_regex' = 'sole_bookrunner|joint_bookrunner|co_bookrunner|mandated_lead_arranger|lead_arranger');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Close Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `co_arranger_list` SET TAGS ('dbx_business_glossary_term' = 'Co-Arranger List');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `commitment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Commitment Deadline Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `credit_rating_moodys` SET TAGS ('dbx_business_glossary_term' = 'Moodys Credit Rating');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_business_glossary_term' = 'S&P Credit Rating');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `documentation_standard` SET TAGS ('dbx_business_glossary_term' = 'Documentation Standard');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `documentation_standard` SET TAGS ('dbx_value_regex' = 'LMA|LSTA|APLMA|bespoke');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `esg_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG-Linked Facility Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'term_loan_a|term_loan_b|revolving_credit|bridge_loan|delayed_draw');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `flex_amount_bps` SET TAGS ('dbx_business_glossary_term' = 'Pricing Flex Amount (Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Launch Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `league_table_credit` SET TAGS ('dbx_business_glossary_term' = 'League Table Credit');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `league_table_credit` SET TAGS ('dbx_value_regex' = 'full_credit|pro_rata|no_credit');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `lender_count` SET TAGS ('dbx_business_glossary_term' = 'Lender Count');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `leveraged_loan_flag` SET TAGS ('dbx_business_glossary_term' = 'Leveraged Loan Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `mandate_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Award Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `oid_bps` SET TAGS ('dbx_business_glossary_term' = 'Original Issue Discount (OID) Basis Points');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `oversubscription_amount` SET TAGS ('dbx_business_glossary_term' = 'Oversubscription Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `oversubscription_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `pricing_flex_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Flex Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `pricing_flex_type` SET TAGS ('dbx_value_regex' = 'tightened|held|flexed_wider|oid_added|oid_increased|structure_changed');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Purpose Code');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `purpose_code` SET TAGS ('dbx_value_regex' = 'acquisition_finance|lbo|refinancing|general_corporate|capex|working_capital');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Syndication Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Credit Spread (Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `syndication_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `syndication_type` SET TAGS ('dbx_value_regex' = 'primary_syndication|secondary_sell_down|club_deal|best_efforts|underwritten');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `target_selldown_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Sell-Down Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `target_selldown_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `tenor_months` SET TAGS ('dbx_business_glossary_term' = 'Facility Tenor (Months)');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `total_facility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Facility Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `total_facility_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_syndication` ALTER COLUMN `upfront_fee_bps` SET TAGS ('dbx_business_glossary_term' = 'Upfront Fee (Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `syndication_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Allocation ID');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `investment_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication ID');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Desk ID');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Institution ID');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `tranche_id` SET TAGS ('dbx_business_glossary_term' = 'Tranche ID');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'indicative|firm|allocated|settled|cancelled|transferred');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'primary|secondary_selldown|transfer|sub_participation');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `arrangement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `arrangement_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `arrangement_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `booking_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity Code');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `booking_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'firm|soft|sub-underwrite|underwrite|best_efforts');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `ead_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `ead_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `ead_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `fee_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Fee Share Percentage');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `ftp_rate` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `hold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `hold_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'term_loan|revolving_credit|bridge_loan|bond|mezzanine|delayed_draw');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `interest_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Interest Spread Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `is_agent_bank` SET TAGS ('dbx_business_glossary_term' = 'Is Agent Bank Flag');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `is_lead_arranger` SET TAGS ('dbx_business_glossary_term' = 'Is Lead Arranger Flag');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `lgd_pct` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Percentage');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participant_role` SET TAGS ('dbx_business_glossary_term' = 'Participant Role');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participant_role` SET TAGS ('dbx_value_regex' = 'lead_arranger|co_arranger|bookrunner|underwriter|participant|agent');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participation_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Participation Agreement Reference');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Participation Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participation_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participation_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `pd_rating` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Rating');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `regulatory_capital_approach` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Approach');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `regulatory_capital_approach` SET TAGS ('dbx_value_regex' = 'SA|IRB_foundation|IRB_advanced');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `syndication_market` SET TAGS ('dbx_business_glossary_term' = 'Syndication Market Segment');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `syndication_market` SET TAGS ('dbx_value_regex' = 'investment_grade|leveraged|project_finance|real_estate|trade_finance');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `underwrite_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwrite Amount');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `underwrite_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `underwrite_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`syndication_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `underwriting_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Identifier');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `alco_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Meeting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Anchor Investor Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `capital_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer ID');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Agreement Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `bank_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Bank Allocation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `bank_allocation_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `book_runner_flag` SET TAGS ('dbx_business_glossary_term' = 'Book Runner Flag');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Commitment Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Commitment Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-UW-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Commitment Status');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'mandated|active|priced|closed|withdrawn|terminated');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Commitment Type');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'firm_commitment|best_efforts|standby|all_or_none|mini_max');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `expected_fee_revenue` SET TAGS ('dbx_business_glossary_term' = 'Expected Fee Revenue');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `expected_fee_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `fee_bps` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Fee (BPS — Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `fee_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `greenshoe_option_amount` SET TAGS ('dbx_business_glossary_term' = 'Greenshoe Over-Allotment Option Amount');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `greenshoe_option_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `greenshoe_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Greenshoe Over-Allotment Option Flag');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `league_table_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'League Table Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `lock_up_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period (Days)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `management_fee_bps` SET TAGS ('dbx_business_glossary_term' = 'Management Fee (BPS — Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `management_fee_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `mandate_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Letter Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `offering_price` SET TAGS ('dbx_business_glossary_term' = 'Offering Price');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `offering_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `offering_size` SET TAGS ('dbx_business_glossary_term' = 'Offering Size');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `offering_size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Offering Type');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `prospectus_type` SET TAGS ('dbx_business_glossary_term' = 'Prospectus / Registration Statement Type');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `roadshow_start_date` SET TAGS ('dbx_business_glossary_term' = 'Roadshow Start Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `sec_file_number` SET TAGS ('dbx_business_glossary_term' = 'SEC File Number');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `sec_file_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{5,6}$');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `selling_concession_bps` SET TAGS ('dbx_business_glossary_term' = 'Selling Concession (BPS — Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `selling_concession_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MUREX|CALYPSO|DEALOGIC|MANUAL|BLOOMBERG|LOAN_IQ');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Spread (BPS — Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `spread_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `stabilization_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Stabilization Flag');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `syndicate_role` SET TAGS ('dbx_business_glossary_term' = 'Syndicate Role');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `syndicate_role` SET TAGS ('dbx_value_regex' = 'sole_bookrunner|lead_bookrunner|joint_bookrunner|co_manager|selling_group');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `tombstone_flag` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Record Flag');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `underwritten_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Amount');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `underwritten_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `underwritten_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`underwriting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investment_investor_order_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Order ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `coverage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Coverage ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Geography Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Bookrunner ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `allocation_price` SET TAGS ('dbx_business_glossary_term' = 'Allocation Price');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `allocation_size` SET TAGS ('dbx_business_glossary_term' = 'Allocation Size');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `demand_multiple` SET TAGS ('dbx_business_glossary_term' = 'Demand Multiple');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `greenshoe_eligible` SET TAGS ('dbx_business_glossary_term' = 'Greenshoe Option Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investor_name` SET TAGS ('dbx_business_glossary_term' = 'Investor Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investor_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investor_tier` SET TAGS ('dbx_business_glossary_term' = 'Investor Tier Classification');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investor_tier` SET TAGS ('dbx_value_regex' = 'anchor|cornerstone|institutional|retail|strategic');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `investor_type` SET TAGS ('dbx_business_glossary_term' = 'Investor Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `is_anchor_investor` SET TAGS ('dbx_business_glossary_term' = 'Anchor Investor Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `is_covered_short` SET TAGS ('dbx_business_glossary_term' = 'Covered Short Sale Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'approved|pending|failed|exempt');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `lock_up_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period (Days)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Order Amendment Count');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Submission Channel');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'electronic|voice|email|roadshow|bloomberg');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_currency` SET TAGS ('dbx_business_glossary_term' = 'Order Currency (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_size` SET TAGS ('dbx_business_glossary_term' = 'Order Size');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'active|filled|partially_filled|cancelled|expired');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Submission Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'strike|limit|step|capped|uncapped');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `price_limit` SET TAGS ('dbx_business_glossary_term' = 'Price Limit');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Offering Category');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_value_regex' = 'qib|reg_s|retail|employee|directed');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'murex|calypso|ipreo|dealogic|bloomberg_oms|manual');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `step_price_1` SET TAGS ('dbx_business_glossary_term' = 'Step Order Price Level 1');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `step_price_2` SET TAGS ('dbx_business_glossary_term' = 'Step Order Price Level 2');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `step_size_1` SET TAGS ('dbx_business_glossary_term' = 'Step Order Size Level 1');
ALTER TABLE `banking_ecm`.`investment`.`investment_investor_order` ALTER COLUMN `step_size_2` SET TAGS ('dbx_business_glossary_term' = 'Step Order Size Level 2');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` SET TAGS ('dbx_subdomain' = 'market_reporting');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `tombstone_id` SET TAGS ('dbx_business_glossary_term' = 'Tombstone ID');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Local Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Industry Sector Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Publication Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `accepted_credit_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Accepted League Table Credit Amount (USD)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `accepted_credit_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `advisory_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Advisory Fee (USD)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `advisory_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `bank_role` SET TAGS ('dbx_business_glossary_term' = 'Bank Role');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `bookrunner_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Bookrunner Allocation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `client_name` SET TAGS ('dbx_business_glossary_term' = 'Client Name');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `client_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `co_advisor_names` SET TAGS ('dbx_business_glossary_term' = 'Co-Advisor Names');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `coverage_banker_name` SET TAGS ('dbx_business_glossary_term' = 'Coverage Banker Name');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `coverage_banker_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `credit_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'League Table Credit Amount (USD)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `credit_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `credit_methodology` SET TAGS ('dbx_business_glossary_term' = 'League Table Credit Methodology');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `credit_methodology` SET TAGS ('dbx_value_regex' = 'Full Credit|Pro-Rata|Equal Credit|Bookrunner Credit|Advisor Credit');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `deal_value_local` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Local Currency');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `deal_value_local` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `deal_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Deal Value (USD)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `deal_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'League Table Dispute Reason');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'League Table Dispute Status');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|disputed|under_review|resolved|rejected');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `fx_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate to USD');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Indicator');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `is_tombstone_client_approved` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Client Approval Indicator');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `league_table_product_category` SET TAGS ('dbx_business_glossary_term' = 'League Table Product Category');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `league_table_product_category` SET TAGS ('dbx_value_regex' = 'M&A|ECM|DCM|Loans|Restructuring|All Products');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `league_table_provider` SET TAGS ('dbx_business_glossary_term' = 'League Table Provider');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `league_table_provider` SET TAGS ('dbx_value_regex' = 'Dealogic|Bloomberg|Refinitiv|Mergermarket|LSEG');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `number_of_co_advisors` SET TAGS ('dbx_business_glossary_term' = 'Number of Co-Advisors');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Publication Date');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Publication Status');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|suppressed|archived');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `ranking_period` SET TAGS ('dbx_business_glossary_term' = 'League Table Ranking Period');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `ranking_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ranking Period End Date');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `ranking_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ranking Period Start Date');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'League Table Submission Date');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `target_company_name` SET TAGS ('dbx_business_glossary_term' = 'Target Company Name');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `target_company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `target_country` SET TAGS ('dbx_business_glossary_term' = 'Target Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `target_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `tombstone_description` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Description');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `transaction_name` SET TAGS ('dbx_business_glossary_term' = 'Transaction Name');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `transaction_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tombstone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` SET TAGS ('dbx_subdomain' = 'deal_origination');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment ID');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Relationship Manager Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geography Region Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector ID');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Entity ID');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Banker ID');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `tertiary_coverage_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Approval Officer ID');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `tertiary_coverage_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `tertiary_coverage_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Approval Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Code');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_value_regex' = '^CVG-[A-Z0-9]{6,12}$');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Status');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|transferred|terminated');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `banker_title` SET TAGS ('dbx_business_glossary_term' = 'Coverage Banker Title');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `banker_title` SET TAGS ('dbx_value_regex' = 'analyst|associate|vice_president|director|managing_director|partner');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `client_tier` SET TAGS ('dbx_business_glossary_term' = 'Client Tier Classification');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `client_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|emerging');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Notes');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_office` SET TAGS ('dbx_business_glossary_term' = 'Coverage Office Location');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_role` SET TAGS ('dbx_business_glossary_term' = 'Coverage Role');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_role` SET TAGS ('dbx_value_regex' = 'primary|secondary|sector_specialist|product_specialist|co_coverage');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `coverage_team_name` SET TAGS ('dbx_business_glossary_term' = 'Coverage Team Name');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective From Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Until Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `geography_country_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Geography Country Code');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `geography_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Coverage Assignment Indicator');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `is_lead_coverage` SET TAGS ('dbx_business_glossary_term' = 'Lead Coverage Indicator');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `is_sector_specialist` SET TAGS ('dbx_business_glossary_term' = 'Sector Specialist Indicator');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|remediation_required|rejected');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `last_client_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Client Interaction Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `lob_name` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Name');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `lob_name` SET TAGS ('dbx_value_regex' = 'M&A_advisory|ECM|DCM|leveraged_finance|syndicated_lending|restructuring');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `mandate_count` SET TAGS ('dbx_business_glossary_term' = 'Active Mandate Count');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Review Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `origination_credit_pct` SET TAGS ('dbx_business_glossary_term' = 'Deal Origination Credit Percentage');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `origination_credit_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `pitch_book_count` SET TAGS ('dbx_business_glossary_term' = 'Pitch Book Count');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `relationship_since_date` SET TAGS ('dbx_business_glossary_term' = 'Client Relationship Since Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `revenue_attribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attribution Percentage');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `revenue_attribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `sector_name` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Name');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `sub_sector_name` SET TAGS ('dbx_business_glossary_term' = 'Industry Sub-Sector Name');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Reason');
ALTER TABLE `banking_ecm`.`investment`.`coverage_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'banker_departure|client_request|restructure|transfer|mandate_end|other');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `deal_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant ID');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Institution ID');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Check Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `conflict_check_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Check Notes');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `conflict_check_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Check Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|conflict_identified|waived|escalated');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `deal_team_lead` SET TAGS ('dbx_business_glossary_term' = 'Deal Team Lead Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `engagement_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'retainer|success_fee|hourly|fixed|no_fee');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_basis_points` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `information_barrier_group` SET TAGS ('dbx_business_glossary_term' = 'Information Barrier Group');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `information_barrier_group` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `institution_type` SET TAGS ('dbx_business_glossary_term' = 'Institution Type');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Participant Jurisdiction');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `kyc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired|under_review');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `league_table_credit` SET TAGS ('dbx_business_glossary_term' = 'League Table Credit Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `mandate_letter_ref` SET TAGS ('dbx_business_glossary_term' = 'Mandate Letter Reference');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `mandate_letter_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `nda_executed` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Executed Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `nda_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Execution Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_category` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Category');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_category` SET TAGS ('dbx_value_regex' = 'principal|advisor|regulatory|support');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_ref_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_ref_number` SET TAGS ('dbx_value_regex' = '^DP-[A-Z0-9]{6,20}$');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_role` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Role');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_side` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Side');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|neutral|regulatory');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Participant Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `participant_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|terminated|completed|suspended');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `syndicate_rank` SET TAGS ('dbx_business_glossary_term' = 'Syndicate Rank');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `tombstone_credit_line` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Credit Line');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `wall_cross_date` SET TAGS ('dbx_business_glossary_term' = 'Wall Cross Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `wall_cross_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Participant Withdrawal Reason');
ALTER TABLE `banking_ecm`.`investment`.`deal_participant` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`offering` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `debt_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer ID');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `market_center_id` SET TAGS ('dbx_business_glossary_term' = 'Market Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `bookrunner_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Bookrunner Name');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `bookrunner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Currency Code (ISO 4217)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `lock_up_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period (Days)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Segment');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'ECM|DCM|leveraged_finance|structured_finance');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offer_price` SET TAGS ('dbx_business_glossary_term' = 'Offer Price');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offer_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offer_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offering_number` SET TAGS ('dbx_business_glossary_term' = 'Offering Number');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offering_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4}-[0-9]{4,8}$');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `offering_status` SET TAGS ('dbx_business_glossary_term' = 'Offering Status');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `overallotment_amount` SET TAGS ('dbx_business_glossary_term' = 'Overallotment (Greenshoe) Option Amount');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `overallotment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `overallotment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `price_range_high` SET TAGS ('dbx_business_glossary_term' = 'Indicative Price Range High');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `price_range_low` SET TAGS ('dbx_business_glossary_term' = 'Indicative Price Range Low');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `rating_agency` SET TAGS ('dbx_value_regex' = 'Moodys|SP|Fitch|DBRS|Kroll|NR');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `reg_s_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulation S Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `regulatory_filing_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Type');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `roadshow_end_date` SET TAGS ('dbx_business_glossary_term' = 'Roadshow End Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `roadshow_start_date` SET TAGS ('dbx_business_glossary_term' = 'Roadshow Start Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `rule_144a_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rule 144A Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `shares_offered` SET TAGS ('dbx_business_glossary_term' = 'Number of Shares Offered');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `size_amount` SET TAGS ('dbx_business_glossary_term' = 'Offering Size Amount');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `size_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `size_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `stabilization_flag` SET TAGS ('dbx_business_glossary_term' = 'Stabilization Activity Flag');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `syndicate_size` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Syndicate Size');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `tombstone_published_flag` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Published Flag');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `total_proceeds_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Proceeds Amount');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `total_proceeds_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `total_proceeds_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `underwriting_discount_bps` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Discount (Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `underwriting_discount_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `underwriting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `underwriting_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `underwriting_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`offering` ALTER COLUMN `use_of_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Use of Proceeds Description');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `investment_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Regulatory Filing ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Banker ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Entity ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `parent_filing_investment_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Filing ID');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `regulatory_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `cik` SET TAGS ('dbx_business_glossary_term' = 'Central Index Key (CIK)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `cik` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `confidentiality_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Treatment Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `confidentiality_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `confidentiality_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `fatca_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Applicable Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_business_glossary_term' = 'Filing Category');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee (USD)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `last_comment_response_date` SET TAGS ('dbx_business_glossary_term' = 'Last Comment Response Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `legal_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Firm Name');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `legal_counsel_firm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `lei` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}[0-9]{2}$');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `listing_exchange` SET TAGS ('dbx_business_glossary_term' = 'Listing Exchange');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `material_change_description` SET TAGS ('dbx_business_glossary_term' = 'Material Change Description');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `material_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Change Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `offering_currency` SET TAGS ('dbx_business_glossary_term' = 'Offering Currency');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `offering_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `offering_size_usd` SET TAGS ('dbx_business_glossary_term' = 'Offering Size (USD)');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `offering_size_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `prospectus_type` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `prospectus_type` SET TAGS ('dbx_value_regex' = 'base_prospectus|final_prospectus|preliminary_prospectus|supplementary_prospectus|listing_particulars');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `regulatory_review_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Deadline');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `sarbanes_oxley_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Applicable Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `sec_comment_letter_count` SET TAGS ('dbx_business_glossary_term' = 'SEC Comment Letter Count');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `tombstone_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `underwriter_role` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Role');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `underwriter_role` SET TAGS ('dbx_value_regex' = 'sole_bookrunner|joint_bookrunner|co_manager|financial_advisor|placement_agent');
ALTER TABLE `banking_ecm`.`investment`.`investment_regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` SET TAGS ('dbx_subdomain' = 'deal_origination');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `pitch_book_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Book ID');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `coverage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Banker ID');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geography Region Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `investment_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Related Investment Proposal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Presentation Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `previous_pitch_book_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_business_glossary_term' = 'Competitive Situation');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_value_regex' = 'Sole Advisor|Limited Competition|Competitive Bake-off|Beauty Contest');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Highly Confidential|Restricted');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Completion Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Cleared|Conflict Identified|Waived');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `deal_size_currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Size Currency Code');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `estimated_deal_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Size');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `estimated_deal_size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `fee_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate (Basis Points)');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `fee_rate_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `nda_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Execution Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `nda_required` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Decision Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `pitch_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pitch Outcome');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `pitch_outcome` SET TAGS ('dbx_value_regex' = 'Pending|Mandate Won|Mandate Lost|No Decision|Withdrawn');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `pitch_status` SET TAGS ('dbx_business_glossary_term' = 'Pitch Status');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `pitch_type` SET TAGS ('dbx_business_glossary_term' = 'Pitch Type');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `precedent_list` SET TAGS ('dbx_business_glossary_term' = 'Precedent Transaction List');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `precedent_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Precedent Transaction Count');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Pitch Book Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `sub_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sub-Sector');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `target_client_name` SET TAGS ('dbx_business_glossary_term' = 'Target Client Name');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `target_client_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `target_company_name` SET TAGS ('dbx_business_glossary_term' = 'Target Company Name');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `target_company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Pitch Book Title');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_value_regex' = 'DCF|Comparable Companies|Precedent Transactions|LBO Analysis|Sum-of-the-Parts');
ALTER TABLE `banking_ecm`.`investment`.`pitch_book` ALTER COLUMN `win_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `banking_ecm`.`investment`.`league_table` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`investment`.`league_table` SET TAGS ('dbx_subdomain' = 'market_reporting');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `league_table_id` SET TAGS ('dbx_business_glossary_term' = 'League Table ID');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Banker ID');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geography Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `previous_league_table_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `accepted_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Accepted Credit Amount');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `accepted_credit_currency` SET TAGS ('dbx_business_glossary_term' = 'Accepted Credit Currency');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Announcement Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `bank_role` SET TAGS ('dbx_business_glossary_term' = 'Bank Role in Transaction');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `bookrunner_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Bookrunner Allocation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `client_name` SET TAGS ('dbx_business_glossary_term' = 'Client Name');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `client_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Closing Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `co_advisor_count` SET TAGS ('dbx_business_glossary_term' = 'Co-Advisor Count');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `credit_methodology` SET TAGS ('dbx_business_glossary_term' = 'League Table Credit Methodology');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `credit_methodology` SET TAGS ('dbx_value_regex' = 'Full Credit|Equal Credit|Pro Rata|Bookrunner Only|Lead Manager Only');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transaction Flag');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `deal_count` SET TAGS ('dbx_business_glossary_term' = 'Deal Count');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `deal_volume_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Volume Amount');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `deal_volume_currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Volume Currency');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'League Table Dispute Reason');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'League Table Dispute Status');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'No Dispute|Dispute Filed|Under Investigation|Resolved - Accepted|Resolved - Rejected');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `fee_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Revenue Amount');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `fee_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `fee_revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Revenue Currency');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `market_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Percentage');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'League Table Notes');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `previous_rank_position` SET TAGS ('dbx_business_glossary_term' = 'Previous Rank Position');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Investment Banking Product Category');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'M&A Advisory|Equity Capital Markets|Debt Capital Markets|Syndicated Loans|Leveraged Finance|High Yield Bonds');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'League Table Publication Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `rank_position` SET TAGS ('dbx_business_glossary_term' = 'League Table Rank Position');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_period` SET TAGS ('dbx_business_glossary_term' = 'Ranking Period');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ranking Period End Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ranking Period Start Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_source` SET TAGS ('dbx_business_glossary_term' = 'League Table Ranking Source');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_source` SET TAGS ('dbx_value_regex' = 'Bloomberg|Dealogic|Refinitiv|Thomson Reuters|Mergermarket|PitchBook');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_status` SET TAGS ('dbx_business_glossary_term' = 'League Table Ranking Status');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `ranking_status` SET TAGS ('dbx_value_regex' = 'Published|Provisional|Under Review|Disputed|Withdrawn|Corrected');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'League Table Submission Date');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `target_company_name` SET TAGS ('dbx_business_glossary_term' = 'Target Company Name');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `target_company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `tombstone_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`league_table` ALTER COLUMN `wallet_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Wallet Share Percentage');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `deal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Document Identifier (ID)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier (ID)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `parent_document_deal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Document Identifier (ID)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `previous_deal_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `author_department` SET TAGS ('dbx_business_glossary_term' = 'Author Department');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `bank_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Signatory Name');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `bank_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Bank Signatory Title');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|highly_restricted');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Name');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `counterparty_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Title');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `destruction_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Eligible Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'pre_mandate|mandate|execution|regulatory|closing|post_closing');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size Kilobytes (KB)');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `is_executed` SET TAGS ('dbx_business_glossary_term' = 'Executed Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `is_material_change` SET TAGS ('dbx_business_glossary_term' = 'Material Change Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `league_table_eligible` SET TAGS ('dbx_business_glossary_term' = 'League Table Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `legal_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Firm');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `retention_classification` SET TAGS ('dbx_business_glossary_term' = 'Retention Classification');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `retention_classification` SET TAGS ('dbx_value_regex' = 'permanent|long_term|standard|short_term');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` SET TAGS ('dbx_subdomain' = 'deal_origination');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `pipeline_stage_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Identifier (ID)');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `primary_predecessor_stage_pipeline_stage_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Pipeline Stage Identifier (ID)');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `parent_pipeline_stage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `aml_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `approval_committee_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Committee Type');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `approval_committee_type` SET TAGS ('dbx_value_regex' = 'credit_committee|risk_committee|capital_committee|executive_committee|none');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `average_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Average Stage Duration in Days');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `client_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `conflict_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `deal_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Deal Type Applicability');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `entry_criteria` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Criteria');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `exit_criteria` SET TAGS ('dbx_business_glossary_term' = 'Stage Exit Criteria');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `key_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Key Stage Deliverables');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `kyc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `lob_applicability` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Applicability');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `minimum_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Approval Level');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `minimum_approval_level` SET TAGS ('dbx_value_regex' = 'managing_director|division_head|ceo|board|none');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `probability_weighting_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability Weighting Percentage (PCT)');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `revenue_recognition_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Trigger Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `rwa_calculation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Calculation Required Flag');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Stage Sequence Number');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_category` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Category');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_category` SET TAGS ('dbx_value_regex' = 'pre_mandate|mandate|execution|post_closing');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Code');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_color_code` SET TAGS ('dbx_business_glossary_term' = 'Stage Color Code');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_color_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_description` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Description');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_icon_reference` SET TAGS ('dbx_business_glossary_term' = 'Stage Icon Reference');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Name');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_status` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage Status');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `stage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|archived');
ALTER TABLE `banking_ecm`.`investment`.`pipeline_stage` ALTER COLUMN `tombstone_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` SET TAGS ('dbx_association_edges' = 'customer.party,investment.deal');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `deal_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Participation Identifier');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Participation - Deal Id');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Participation - Party Id');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Fee Amount');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `nda_executed` SET TAGS ('dbx_business_glossary_term' = 'NDA Executed Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `nda_execution_date` SET TAGS ('dbx_business_glossary_term' = 'NDA Execution Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `participant_role` SET TAGS ('dbx_business_glossary_term' = 'Participant Role');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `participant_side` SET TAGS ('dbx_business_glossary_term' = 'Participant Side');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `participant_status` SET TAGS ('dbx_business_glossary_term' = 'Participant Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `syndicate_rank` SET TAGS ('dbx_business_glossary_term' = 'Syndicate Rank');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `tombstone_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Eligible Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` SET TAGS ('dbx_association_edges' = 'trade.broker,investment.deal');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `deal_broker_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Broker Participation ID');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Broker Participation - Broker Id');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Broker Participation - Deal Id');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `broker_role` SET TAGS ('dbx_business_glossary_term' = 'Broker Role in Deal');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `economics_currency` SET TAGS ('dbx_business_glossary_term' = 'Economics Currency');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Engagement Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `fee_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Share Amount');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `syndicate_rank` SET TAGS ('dbx_business_glossary_term' = 'Syndicate Rank');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `tombstone_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Tombstone Credit Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_broker_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` SET TAGS ('dbx_subdomain' = 'deal_origination');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` SET TAGS ('dbx_association_edges' = 'investment.deal,hr.employee');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `deal_team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Team Member ID');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `deal_team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `deal_team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Team Member - Deal Id');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Team Member - Employee Id');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `is_lead_banker` SET TAGS ('dbx_business_glossary_term' = 'Is Lead Banker Flag');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `revenue_credit_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Credit Percentage');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`investment`.`deal_team_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` SET TAGS ('dbx_subdomain' = 'deal_origination');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` ALTER COLUMN `approval_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Committee Identifier');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` ALTER COLUMN `parent_approval_committee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`approval_committee` ALTER COLUMN `secretary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`investment`.`tranche` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`investment`.`tranche` SET TAGS ('dbx_subdomain' = 'transaction_execution');
ALTER TABLE `banking_ecm`.`investment`.`tranche` ALTER COLUMN `tranche_id` SET TAGS ('dbx_business_glossary_term' = 'Tranche Identifier');
ALTER TABLE `banking_ecm`.`investment`.`tranche` ALTER COLUMN `parent_tranche_id` SET TAGS ('dbx_self_ref_fk' = 'true');
