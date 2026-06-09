-- Schema for Domain: investment | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`investment` COMMENT 'Manages real estate investment portfolios, fund structures, and investment performance. Captures investment vehicles (REITs, funds, partnerships, CMBS/RMBS), portfolio composition, AUM, investment strategies, IRR/NPV/ROI calculations, FFO/AFFO reporting, NAV/GAV calculations, and investment advisory relationships. Supports institutional and individual investor portfolio management with comprehensive performance analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique surrogate identifier for the real estate investment fund record. Primary key for the fund master registry.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Fund base currency drives NAV calculation, investor capital account statements, and multi-currency consolidation reporting. Role-prefixed to distinguish from other potential currency FKs on fund; norm',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Fund domicile country determines regulatory classification, tax treaty applicability, FATCA/CRS reporting obligations, and foreign investor withholding tax rates — all critical for fund administration',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Fund target geographies define investment mandate boundaries used in deal screening, geographic allocation reporting, and LP mandate compliance. Normalizing to geographic_hierarchy enables market-leve',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Funds are domiciled in specific jurisdictions governing SEC/AIFMD/local regulatory obligations. Fund compliance reporting, regulatory filings, and penalty risk management all require knowing the gover',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Every real estate fund is structured as a legal entity for REIT election, SEC reporting, consolidation, and tax filing. Fund administrators and controllers require this link to map fund-level reportin',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Fund investment policy statements define target property types (office, industrial, multifamily) for deal screening and mandate compliance reporting. A real estate fund manager expects this FK to enfo',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Fund regulatory classification (SEC-registered, AIFMD, ERISA) maps to a regulatory framework driving compliance reporting cadence, filing obligations, and penalty exposure. Fund administrators require',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Funds have direct regulatory obligations (SEC registration, AIFMD reporting, FATCA). Linking fund to its primary governing regulatory obligation is fundamental for compliance tracking, penalty risk ma',
    `parent_fund_id` BIGINT COMMENT 'Self-referencing FK on fund (parent_fund_id)',
    `actual_aum` DECIMAL(18,2) COMMENT 'Current total Assets Under Management (AUM) representing the fair market value of all assets held by the fund, expressed in the funds base currency. Sourced from MRI Software and Argus Enterprise valuations. Updated at each reporting period.',
    `auditor_name` STRING COMMENT 'Name of the independent external auditor engaged to audit the funds annual financial statements. Required for SEC-registered funds and institutional LP due diligence.',
    `called_capital` DECIMAL(18,2) COMMENT 'Cumulative capital drawn down from LP commitments to fund investments, fees, and expenses, expressed in the funds base currency. Used in DPI (Distributions to Paid-In) and TVPI (Total Value to Paid-In) multiple calculations.',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'GPs share of profits above the preferred return hurdle, expressed as a decimal (e.g., 0.2000 = 20%). Represents the performance-based compensation to the General Partner. Sourced from LPA terms in DocuSign CLM.',
    `concentration_limit` DECIMAL(18,2) COMMENT 'Maximum percentage of total fund GAV that may be invested in any single asset or property, expressed as a decimal (e.g., 0.20 = 20%). Enforces diversification requirements per the LPA investment mandate.',
    `distributed_capital` DECIMAL(18,2) COMMENT 'Cumulative capital returned to Limited Partners (LPs) through asset dispositions, refinancing proceeds, and income distributions, expressed in the funds base currency. Key input for DPI multiple and IRR calculations.',
    `esg_framework` STRING COMMENT 'Primary ESG reporting framework adopted by the fund (e.g., GRESB for real estate, UN PRI, TCFD). Null if esg_mandate is false. Drives sustainability data collection and disclosure requirements.. Valid values are `gresb|unpri|tcfd|sfdr|leed|breeam`',
    `esg_mandate` BOOLEAN COMMENT 'Indicates whether the fund operates under a formal Environmental, Social, and Governance (ESG) investment mandate requiring ESG screening, LEED/BREEAM certification targets, or sustainability reporting obligations.',
    `extension_options` STRING COMMENT 'Number of permissible one-year extension options available to the General Partner (GP) beyond the base fund term, as specified in the LPA. Supports fund lifecycle planning and investor communication.',
    `fee_basis` STRING COMMENT 'The capital base upon which the annual management fee rate is applied. Committed capital is common during the investment period; invested capital or NAV is common during the harvest period.. Valid values are `committed_capital|invested_capital|nav|gross_asset_value`',
    `fee_cap` DECIMAL(18,2) COMMENT 'Maximum absolute dollar amount of management fees that may be charged to the fund in any given year, expressed in the funds base currency. Null if no cap is specified in the LPA.',
    `fee_waiver_conditions` STRING COMMENT 'Narrative description of conditions under which management fees may be waived or reduced (e.g., GP co-investment, fund underperformance, LP negotiated side letter terms). Sourced from LPA and side letter agreements in DocuSign CLM.',
    `final_close_date` DATE COMMENT 'Date on which the fund completed its capital raising period and accepted its last investor commitment. Marks the end of the fundraising phase and the start of the investment period. Null for open-end funds.',
    `fund_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the fund across systems (e.g., MRI Software, Argus Enterprise, SAP S/4HANA). Used as the business key in cross-system reconciliation and regulatory filings.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `fund_name` STRING COMMENT 'Full legal name of the investment fund or vehicle as registered with the relevant regulatory authority (e.g., SEC, FINRA). Used in investor communications, regulatory filings, and reporting.',
    `fund_status` STRING COMMENT 'Current lifecycle state of the fund. Drives operational workflows, investor reporting obligations, and capital call eligibility. Fundraising indicates the fund is accepting commitments; fully_invested indicates deployment is complete; harvesting indicates asset disposition phase.. Valid values are `fundraising|active|fully_invested|harvesting|closed|liquidating`',
    `fund_type` STRING COMMENT 'Classification of the investment vehicle structure. Determines regulatory treatment, investor redemption rights, and accounting framework. [ENUM-REF-CANDIDATE: open_end|closed_end|reit|partnership|cmbs_trust|rmbs_trust|separate_account|co_investment — promote to reference product]. Valid values are `open_end|closed_end|reit|partnership|cmbs_trust|rmbs_trust`',
    `gav` DECIMAL(18,2) COMMENT 'Gross Asset Value (GAV) of the fund representing the total fair market value of all real estate assets before deducting fund-level debt and liabilities, expressed in the funds base currency. Used in leverage ratio and LTV calculations.',
    `gp_entity_name` STRING COMMENT 'Legal name of the General Partner entity responsible for managing the fund, making investment decisions, and fulfilling fiduciary obligations to Limited Partners (LPs). Sourced from MRI Software Investment Management module.',
    `inception_date` DATE COMMENT 'Date on which the fund was legally formed and commenced operations. Used as the start date for IRR, equity multiple, and since-inception performance calculations in Argus Enterprise.',
    `investment_period_end_date` DATE COMMENT 'Date on which the funds investment period expires and the GP is no longer permitted to make new investments or call capital for new acquisitions. After this date, capital calls are limited to follow-on investments and fund expenses.',
    `investment_strategy` STRING COMMENT 'Risk-return strategy classification of the fund per industry convention. Core strategies target stabilized assets with lower risk; opportunistic strategies target higher-risk, higher-return repositioning or development. Drives benchmark selection and performance attribution in Argus Enterprise and MRI Software.. Valid values are `core|core_plus|value_add|opportunistic|debt`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee charged by the GP to the fund, expressed as a decimal of the fee basis (e.g., 0.0150 = 1.50% of committed capital). Sourced from LPA terms and tracked in Yardi Voyager and MRI Software.',
    `max_deal_size` DECIMAL(18,2) COMMENT 'Maximum individual asset or transaction size (in base currency) that the fund is mandated to consider for investment. Prevents over-concentration in a single asset and ensures portfolio diversification per LPA guidelines.',
    `min_deal_size` DECIMAL(18,2) COMMENT 'Minimum individual asset or transaction size (in base currency) that the fund is mandated to consider for investment. Ensures portfolio concentration and operational efficiency thresholds are maintained.',
    `nav` DECIMAL(18,2) COMMENT 'Net Asset Value (NAV) of the fund as of the most recent valuation date, calculated as total assets minus total liabilities, expressed in the funds base currency. Primary metric for open-end fund unit pricing and investor redemption calculations.',
    `preferred_return_hurdle` DECIMAL(18,2) COMMENT 'Minimum annualized return rate (expressed as a decimal, e.g., 0.0800 = 8.00%) that must be distributed to Limited Partners (LPs) before the General Partner (GP) is entitled to receive carried interest. Also known as the hurdle rate or preferred return.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the fund produces and distributes financial and performance reports to Limited Partners (LPs). Drives reporting calendar in MRI Software and Argus Enterprise.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `target_aum` DECIMAL(18,2) COMMENT 'Target total Assets Under Management (AUM) the fund intends to reach at full deployment, expressed in the funds base currency. Used in fundraising materials, investor presentations, and portfolio planning in Argus Enterprise.',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Target equity multiple (TVPI — Total Value to Paid-In) the fund aims to return to investors, expressed as a ratio (e.g., 1.80 = 1.8x). Represents total distributions plus residual NAV divided by total called capital.',
    `target_irr` DECIMAL(18,2) COMMENT 'Target net Internal Rate of Return (IRR) expressed as a decimal (e.g., 0.1200 = 12.00%) that the fund aims to deliver to investors over its life. Used in fund marketing materials, LP reporting, and performance benchmarking in Argus Enterprise.',
    `target_leverage_max` DECIMAL(18,2) COMMENT 'Maximum Loan-to-Value (LTV) ratio permitted under the funds investment mandate, expressed as a decimal (e.g., 0.65 = 65%). Defines the upper bound of the funds leverage range. Exceeding this threshold may trigger LP notification requirements.',
    `target_leverage_min` DECIMAL(18,2) COMMENT 'Minimum Loan-to-Value (LTV) ratio permitted under the funds investment mandate, expressed as a decimal (e.g., 0.40 = 40%). Defines the lower bound of the funds leverage range for portfolio construction and risk management.',
    `term_years` STRING COMMENT 'Contractual life of the fund in years from inception to scheduled termination, as defined in the Limited Partnership Agreement (LPA) or fund prospectus. Null for open-end funds with no fixed term.',
    `termination_date` DATE COMMENT 'Scheduled or actual date on which the fund is dissolved and all assets are liquidated and distributed to investors. Null for open-end or perpetual-life funds. Drives WALT and WALE calculations for portfolio wind-down planning.',
    `total_commitments` DECIMAL(18,2) COMMENT 'Aggregate capital committed by all Limited Partners (LPs) to the fund as of the final close, expressed in the funds base currency. Represents the maximum capital available for investment and fee calculation basis.',
    `valuation_date` DATE COMMENT 'Date of the most recent formal appraisal or valuation of the funds portfolio used to calculate NAV and GAV. Typically quarterly for institutional funds. Sourced from Argus Enterprise valuation models.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Master registry of real estate investment funds, REITs, and pooled investment vehicles. Captures fund name, type (open-end, closed-end, REIT, partnership, CMBS/RMBS trust), domicile jurisdiction, base currency, target and actual AUM, inception date, fund status, investment strategy (core, core-plus, value-add, opportunistic), target return metrics (IRR, equity multiple), fee terms (management fee rate, carried interest, preferred return hurdle, fee basis, fee cap, fee waiver conditions), fund term and extension options, GP entity, regulatory classification, ESG mandate, and investment mandate parameters (target property types, geographies, leverage range, deal size range, concentration limits). SSOT for fund identity, strategy, terms, fee structures, and mandate parameters.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`portfolio` (
    `portfolio_id` BIGINT COMMENT 'Unique system-generated identifier for the investment portfolio. Primary key for the portfolio master record. Sourced from MRI Software and Argus Enterprise.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, closed-end fund, open-end fund, partnership, CMBS/RMBS) under which this portfolio is structured and managed.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Portfolio geographic focus defines investment mandate boundaries for geographic allocation reporting, deal screening, and LP mandate compliance monitoring against target market exposure.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Portfolios with geographic focus are subject to jurisdiction-specific compliance requirements (local property laws, ESG mandates, tax regimes). Portfolio compliance reporting and regulatory filing cal',
    `legal_entity_id` BIGINT COMMENT 'Reference to the consolidation legal entity responsible for financial reporting and regulatory filings for this portfolio. Aligns with SAP S/4HANA financial consolidation structure.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Portfolio investment strategy (core, value-add, opportunistic) maps to market_segment for INREV/NCREIF benchmark attribution, performance reporting by strategy, and LP mandate compliance verification.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Portfolio property type focus defines sector allocation mandate used in asset acquisition screening, benchmark selection (NCREIF sector indices), and investor reporting on sector concentration.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Portfolios face regulatory obligations tied to asset class and geography (ERISA, Dodd-Frank, local ESG mandates). Portfolio-level obligation tracking drives compliance calendars, responsible departmen',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Portfolio reporting currency drives financial consolidation, investor capital account statements, and multi-currency NAV reporting. Role-prefixed to clarify reporting context; normalizes the denormali',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: Portfolio ESG classification maps to a sustainability rating scheme (GRESB, LEED) for annual GRESB fund-level submission, ESG investor reporting, and green bond eligibility assessment.',
    `parent_portfolio_id` BIGINT COMMENT 'Self-referencing FK on portfolio (parent_portfolio_id)',
    `benchmark_index` STRING COMMENT 'The market index or peer benchmark against which portfolio performance (IRR, TWR, total return) is measured (e.g., NCREIF NPI, MSCI Real Estate Index, FTSE NAREIT All Equity REITs Index).',
    `called_capital` DECIMAL(18,2) COMMENT 'Total equity capital drawn down (called) from investors and deployed into portfolio assets as of the most recent reporting date. Used to calculate remaining uncalled capital and deployment pace.',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'General partners carried interest (promote) rate expressed as a decimal (e.g., 0.20 = 20%) representing the share of profits above the preferred return. Core economic term in fund waterfall and partnership agreements.',
    `committed_capital` DECIMAL(18,2) COMMENT 'Total equity capital formally committed by investors to the portfolio as of the most recent reporting date. Distinct from called/deployed capital. Tracks fundraising progress against target fund size.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the portfolio master record was first created in the system. Used for data lineage, audit trail, and record lifecycle management per SOX and GDPR requirements.',
    `distribution_frequency` STRING COMMENT 'Frequency at which income distributions (dividends, preferred returns) are made to investors from portfolio cash flows. Governs investor cash flow expectations and treasury planning.. Valid values are `monthly|quarterly|semi_annual|annual|at_exit`',
    `ffo_reporting_flag` BOOLEAN COMMENT 'Indicates whether this portfolio reports Funds From Operations (FFO) and Adjusted Funds From Operations (AFFO) per NAREIT standards. Applicable primarily to REIT-structured portfolios for SEC and investor reporting.',
    `inception_date` DATE COMMENT 'The official date on which the portfolio was established and began accepting capital commitments or acquiring assets. Used as the baseline for IRR, TWR, and performance period calculations.',
    `leverage_policy` STRING COMMENT 'Portfolio-level leverage policy classification governing the use of debt financing. Unleveraged = no debt; Low = LTV <30%; Moderate = LTV 30-60%; High = LTV >60%. Aligns with investment strategy and risk mandate.. Valid values are `unleveraged|low_leverage|moderate_leverage|high_leverage`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual asset management fee rate expressed as a decimal (e.g., 0.0100 = 1.00% of AUM or GAV) charged by the investment manager. Disclosed in fund offering documents and regulatory filings.',
    `open_end_flag` BOOLEAN COMMENT 'Indicates whether the portfolio is structured as an open-end fund allowing ongoing investor subscriptions and redemptions (True) versus a closed-end fund with a fixed capital raise and defined term (False).',
    `portfolio_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the portfolio used in investor reporting, Argus Enterprise, MRI Software, and regulatory filings. Unique across all portfolios.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `portfolio_name` STRING COMMENT 'Full human-readable name of the investment portfolio as used in investor communications, fund documents, and management reporting (e.g., Core Office Fund III, Diversified Income REIT Portfolio).',
    `portfolio_status` STRING COMMENT 'Current lifecycle state of the portfolio. Active = fully operational; Inactive = temporarily not deploying capital; Winding Down = in liquidation/disposition phase; Closed = fully liquidated; Pending Launch = pre-inception setup; Suspended = operations halted pending review.. Valid values are `active|inactive|winding_down|closed|pending_launch|suspended`',
    `portfolio_type` STRING COMMENT 'Investment strategy classification of the portfolio reflecting risk-return profile. Core = stabilized low-risk assets; Core Plus = modest value enhancement; Value Add = repositioning required; Opportunistic = highest risk/return; Diversified = multi-sector; Sector Specific = single property type focus; Debt = mortgage/CMBS/RMBS instruments. [ENUM-REF-CANDIDATE: core|core_plus|value_add|opportunistic|diversified|sector_specific|debt — promote to reference product]',
    `preferred_return_rate` DECIMAL(18,2) COMMENT 'Annualized preferred return rate (hurdle rate) expressed as a decimal (e.g., 0.0800 = 8.00%) that must be paid to limited partners before the general partner participates in carried interest. Core term in fund waterfall structures.',
    `source_system` STRING COMMENT 'Operational system of record from which this portfolio record was sourced. Supports data lineage tracking in the Databricks Silver Layer. Primary sources are MRI Software and Argus Enterprise.. Valid values are `mri_software|argus_enterprise|sap_s4hana|manual`',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicates whether this portfolio is subject to Sarbanes-Oxley Act (SOX) internal control requirements, applicable to publicly traded REITs and entities with SEC reporting obligations.',
    `target_aum` DECIMAL(18,2) COMMENT 'Target total Assets Under Management (AUM) for the portfolio representing the aggregate market value of all real estate assets managed on behalf of investors. Used for fee calculation and capacity planning.',
    `target_cap_rate` DECIMAL(18,2) COMMENT 'Target portfolio-level Capitalization Rate (CAP Rate) expressed as a decimal (e.g., 0.0550 = 5.50%) representing the expected NOI yield on asset value. Used for acquisition underwriting and portfolio valuation benchmarking.',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Target equity multiple (EM) representing the total expected return of invested capital as a ratio (e.g., 1.80x means $1.80 returned per $1.00 invested). Complements IRR as a return metric in investor presentations.',
    `target_fund_size` DECIMAL(18,2) COMMENT 'Total target equity capital raise for the portfolio/fund expressed in the reporting currency. Represents the maximum committed capital the fund intends to raise from investors. Used for capital deployment planning.',
    `target_gav` DECIMAL(18,2) COMMENT 'Target Gross Asset Value (GAV) representing the total undiscounted market value of all assets in the portfolio at full deployment, before deducting liabilities. Used for capital raising targets and AUM reporting.',
    `target_irr` DECIMAL(18,2) COMMENT 'Target annualized Internal Rate of Return (IRR) expressed as a decimal (e.g., 0.0850 = 8.50%) representing the expected return on invested equity over the portfolios life. Primary performance hurdle for investor commitments.',
    `target_ltv` DECIMAL(18,2) COMMENT 'Target portfolio-level Loan-to-Value Ratio (LTV) expressed as a decimal (e.g., 0.60 = 60%) representing the maximum leverage policy for the portfolio. Governs debt capacity and risk management guidelines.',
    `target_nav` DECIMAL(18,2) COMMENT 'Target Net Asset Value (NAV) representing the portfolios equity value after deducting all liabilities from GAV. Key metric for open-end fund unit pricing, investor redemptions, and performance reporting.',
    `target_noi` DECIMAL(18,2) COMMENT 'Target annual Net Operating Income (NOI) for the portfolio representing total revenue less operating expenses before debt service and capital expenditures. Core income metric for CAP rate valuation and DSCR analysis.',
    `target_occupancy_rate` DECIMAL(18,2) COMMENT 'Target portfolio-level physical occupancy rate expressed as a decimal (e.g., 0.95 = 95%) representing the proportion of Net Leasable Area (NLA) that is leased and occupied. Core operational KPI for income forecasting.',
    `target_wale` DECIMAL(18,2) COMMENT 'Target Weighted Average Lease Expiry (WALE) in years representing the income-weighted average time until lease expiry across all portfolio assets. Distinct from WALT as it measures time to expiry rather than total term.',
    `target_walt` DECIMAL(18,2) COMMENT 'Target Weighted Average Lease Term (WALT) in years representing the income-weighted average remaining lease duration across all portfolio assets. Key metric for income stability and refinancing risk assessment.',
    `termination_date` DATE COMMENT 'The scheduled or actual date on which the portfolio is fully wound down and closed. Null for open-ended portfolios. Used for fund lifecycle management and investor distribution planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the portfolio master record. Supports change tracking, data lineage, and audit compliance for investment management records.',
    `valuation_frequency` STRING COMMENT 'Frequency at which independent or internal valuations are conducted for portfolio assets to update NAV and GAV. Quarterly is standard for institutional funds; monthly for open-end funds with frequent redemptions.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `valuation_method` STRING COMMENT 'Primary valuation methodology applied to assets within this portfolio for NAV and GAV calculations. DCF = Discounted Cash Flow; Direct Capitalization = NOI/CAP Rate; Sales Comparison = comparable transactions; Cost Approach = replacement cost; NAV Based = for fund-of-funds.. Valid values are `dcf|direct_capitalization|sales_comparison|cost_approach|nav_based`',
    `vehicle_type` STRING COMMENT 'Legal and structural form of the investment vehicle housing this portfolio. Determines regulatory reporting obligations (SEC for REITs), tax treatment, and investor eligibility. [ENUM-REF-CANDIDATE: reit|open_end_fund|closed_end_fund|separate_account|partnership|joint_venture|cmbs|rmbs — promote to reference product]',
    CONSTRAINT pk_portfolio PRIMARY KEY(`portfolio_id`)
) COMMENT 'Master record for an investment portfolio — a named collection of real estate assets managed under a unified strategy. Captures portfolio name, portfolio type (core, diversified, sector-specific), associated fund, asset manager (AM), benchmark index, target GAV, target NAV, target NOI, geographic focus, property type focus, WALT target, WALE target, portfolio inception date, reporting currency, consolidation entity, and portfolio status. Serves as the SSOT for portfolio-level identity and strategy. Sourced from MRI Software and Argus Enterprise.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key for vehicle',
    `investment_vehicle_id` BIGINT COMMENT 'Unique surrogate identifier for the investment vehicle record in the lakehouse silver layer. Primary key for the investment.vehicle data product.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.program. Business justification: Investment vehicles (REITs, SPVs) operate under specific compliance programs (REIT qualification, SOX, AML). Vehicle-level compliance program assignment is required for regulatory reporting, audit sco',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Vehicle currency code drives NAV calculation, capital account statements, and investor distribution processing. Normalizing to currency_code reference ensures consistent FX rate application across veh',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Vehicle geographic focus defines investment mandate boundaries used in deal screening, geographic concentration reporting, and LP mandate compliance monitoring.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Vehicle jurisdiction of formation determines tax classification (blocker structure, treaty benefits), SEC filing requirements, and LP tax reporting obligations — essential for fund structuring and reg',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Investment vehicles are formed in specific jurisdictions (Delaware LLC, Cayman LP) with jurisdiction-specific regulatory requirements. Vehicle jurisdiction drives tax classification, REIT qualificatio',
    `fund_id` BIGINT COMMENT 'Identifier of the parent investment fund to which this vehicle belongs. Establishes the hierarchical relationship between the legal holding structure (vehicle) and the investment product offered to investors (fund). Null for standalone vehicles not associated with a fund.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: An investment vehicle (LLC, LP, JV) is typically structured to hold and manage a specific portfolio of assets. The vehicle is the legal entity wrapper around the portfolio. Linking vehicle to portfoli',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Vehicle asset class focus defines the property type mandate for REIT qualification testing, investment mandate compliance, and sector allocation reporting to LPs.',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: Vehicle ESG classification maps to sustainability rating scheme for GRESB vehicle-level submission, green bond framework compliance, and ESG-mandated LP reporting requirements.',
    `auditor_name` STRING COMMENT 'Name of the independent external auditor engaged to audit the investment vehicles financial statements (e.g., Deloitte & Touche LLP, Ernst & Young LLP). Required for investor reporting and regulatory compliance. Sourced from the vehicles audit engagement letter.',
    `called_capital_amount` DECIMAL(18,2) COMMENT 'Total capital that has been drawn down (called) from investors to fund investments and pay vehicle expenses, expressed in the vehicles base currency. Also referred to as contributed capital or paid-in capital. The difference between committed and called capital represents uncalled commitments.',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'Percentage of profits allocated to the General Partner (GP) as performance compensation after the preferred return hurdle has been met, expressed as a decimal percentage (e.g., 20.0000 = 20%). Also known as the carry or promote. A critical economic term in the LP Agreement governing the vehicle.',
    `committed_capital_amount` DECIMAL(18,2) COMMENT 'Total capital formally committed by all investors (LPs and GP) to the investment vehicle as of the most recent capital call or closing, expressed in the vehicles base currency. Represents legally binding commitments, not yet necessarily drawn capital. Key metric for AUM reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment vehicle record was first created in the lakehouse data platform. Represents the data ingestion audit trail timestamp, not the vehicles legal formation date. Used for data lineage, audit, and SOX compliance purposes.',
    `dissolution_date` DATE COMMENT 'Date on which the investment vehicle was legally dissolved and deregistered with the jurisdiction of formation. Null for active vehicles. Used to track the full lifecycle of the vehicle for historical reporting and audit purposes.',
    `final_closing_date` DATE COMMENT 'Date on which the investment vehicle completed its final capital raise and closed to new investors. Marks the end of the fundraising period and the start of the investment period clock. Null for open-ended vehicles or vehicles still in fundraising.',
    `formation_date` DATE COMMENT 'Date on which the investment vehicle was legally formed and its organizational documents (e.g., LP Agreement, LLC Operating Agreement) were executed and filed with the relevant jurisdiction. Used to calculate vehicle age and track regulatory filing deadlines.',
    `fund_administrator_name` STRING COMMENT 'Name of the third-party fund administrator responsible for maintaining the vehicles books and records, processing capital calls and distributions, and preparing investor statements (e.g., SS&C Technologies, Citco Fund Services). A key operational service provider for the vehicle.',
    `gp_entity_name` STRING COMMENT 'Legal name of the General Partner (GP) entity responsible for managing the investment vehicle, making investment decisions, and bearing unlimited liability. Applicable to LP and JV structures. Sourced from the vehicles organizational documents.',
    `gp_ownership_pct` DECIMAL(18,2) COMMENT 'Percentage ownership interest held by the General Partner (GP) in the investment vehicle, expressed as a decimal percentage (e.g., 1.0000 = 1%). Typically ranges from 0.01% to 5% in institutional real estate fund structures. Used for waterfall distribution calculations and financial consolidation under FASB ASC 810.',
    `investment_period_end_date` DATE COMMENT 'Date on which the vehicles investment period expires, after which the GP may no longer make new investments (only manage and dispose of existing assets). Typically 3-5 years from the final closing date for closed-end funds. A critical milestone tracked in MRI Software and Argus Enterprise.',
    `investment_strategy` STRING COMMENT 'Risk-return investment strategy classification of the vehicle as defined by the Urban Land Institute (ULI) and NCREIF frameworks. Drives expected return profiles, leverage targets, and asset selection criteria used in Argus Enterprise portfolio modeling. [ENUM-REF-CANDIDATE: core|core_plus|value_add|opportunistic|debt|distressed|diversified — 7 candidates stripped; promote to reference product]',
    `is_co_investment` BOOLEAN COMMENT 'Indicates whether this vehicle is a co-investment structure, where select investors participate alongside the main fund in a specific asset or transaction on a deal-by-deal basis, typically with reduced or no management fees and carried interest. Distinguishes co-investment vehicles from main fund vehicles.',
    `is_open_ended` BOOLEAN COMMENT 'Indicates whether the investment vehicle is open-ended (allowing ongoing subscriptions and redemptions, e.g., a core open-end fund) as opposed to closed-ended (fixed capital raise with a defined term). Drives NAV calculation frequency, liquidity management, and redemption queue reporting.',
    `is_reit_qualified` BOOLEAN COMMENT 'Indicates whether the investment vehicle has elected and qualifies for Real Estate Investment Trust (REIT) tax status under IRC Section 856. REIT-qualified vehicles must distribute at least 90% of taxable income and meet asset and income tests. Drives FFO/AFFO reporting requirements.',
    `lei_code` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier assigned to the investment vehicle by a Local Operating Unit (LOU). Required for regulatory reporting by publicly traded REITs and entities subject to SEC, CFTC, or EMIR reporting obligations.. Valid values are `^[A-Z0-9]{20}$`',
    `lp_ownership_pct` DECIMAL(18,2) COMMENT 'Aggregate percentage ownership interest held by all Limited Partners (LPs) in the investment vehicle, expressed as a decimal percentage (e.g., 99.0000 = 99%). Complements gp_ownership_pct; the sum of GP and LP ownership percentages must equal 100%. Used for distribution waterfall modeling.',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee charged by the General Partner or investment manager as a percentage of committed or invested capital, expressed as a decimal percentage (e.g., 1.5000 = 1.5%). Reduces net returns to Limited Partners and is a key term in the investment management agreement.',
    `nav_calculation_frequency` STRING COMMENT 'Frequency at which the Net Asset Value (NAV) of the investment vehicle is formally calculated and reported to investors. Open-ended vehicles typically calculate NAV quarterly or monthly; publicly traded REITs calculate daily. Drives valuation and reporting workflows in Argus Enterprise.. Valid values are `daily|monthly|quarterly|annually|on_demand`',
    `preferred_return_rate` DECIMAL(18,2) COMMENT 'Annual preferred return (hurdle rate) percentage promised to Limited Partners (LPs) before the General Partner (GP) participates in profits, expressed as a decimal percentage (e.g., 8.0000 = 8%). A key term in the investment vehicles waterfall distribution structure. Sourced from the LP Agreement.',
    `regulatory_filing_status` STRING COMMENT 'Current status of the investment vehicles regulatory filings with applicable authorities (e.g., SEC Form D for Regulation D exempt offerings, SEC Form S-11 for REIT registrations). exempt indicates the vehicle relies on a Regulation D or other exemption from full registration.. Valid values are `exempt|registered|filed|pending|lapsed`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the investment vehicles financial statements and investor reports are presented. May differ from currency_code (base currency) for multi-currency vehicles that report in a functional currency different from their investment currency.. Valid values are `^[A-Z]{3}$`',
    `sec_filing_number` STRING COMMENT 'SEC-assigned filing number for the investment vehicles regulatory filing (e.g., Form D accession number 0001234567-21-000001). Used to cross-reference SEC EDGAR filings for compliance and investor due diligence purposes. Null for vehicles not subject to SEC filing requirements.',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Target equity multiple (total value to paid-in capital ratio, TVPI) promised to investors, expressed as a multiplier (e.g., 1.8000 = 1.8x). Represents the total expected return of invested capital including distributions and residual value. Complements target_irr_rate as a performance objective.',
    `target_equity_raise_amount` DECIMAL(18,2) COMMENT 'Total equity capital the investment vehicle is targeting to raise from investors, expressed in the vehicles base currency. Used to track fundraising progress and determine when the vehicle reaches its hard cap. Sourced from the Private Placement Memorandum (PPM).',
    `target_irr_rate` DECIMAL(18,2) COMMENT 'Target net Internal Rate of Return (IRR) promised to investors in the vehicles offering documents, expressed as a decimal percentage (e.g., 12.0000 = 12%). Represents the annualized return objective after fees and carried interest. Used as the primary performance benchmark in Argus Enterprise modeling.',
    `target_leverage_ratio` DECIMAL(18,2) COMMENT 'Target Loan-to-Value (LTV) ratio for the investment vehicle, expressed as a decimal percentage (e.g., 60.0000 = 60% LTV). Defines the vehicles intended use of debt financing relative to asset values. A key risk parameter monitored by asset managers and lenders. Sourced from the vehicles investment guidelines.',
    `tax_classification` STRING COMMENT 'Federal income tax classification of the investment vehicle. Determines how income, gains, and losses flow through to investors. Pass-through entities (LPs, LLCs) allocate income directly to partners/members; REITs must distribute 90%+ of taxable income; C-Corps are subject to entity-level taxation.. Valid values are `pass_through|REIT|C_Corp|S_Corp|disregarded_entity`',
    `term_years` STRING COMMENT 'Contractual term of the investment vehicle in years as specified in the LP Agreement or organizational documents (e.g., 10 years for a typical closed-end real estate fund). Determines the expected investment horizon and wind-down timeline. Extensions may be permitted subject to LP consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment vehicle record was most recently updated in the lakehouse data platform. Used for incremental data processing, change data capture (CDC), and audit trail maintenance in the Databricks Silver Layer.',
    `vehicle_code` STRING COMMENT 'Short internal alphanumeric code used to identify the vehicle across operational systems such as MRI Software, Argus Enterprise, and Yardi Voyager GL. Serves as the business key for cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `vehicle_name` STRING COMMENT 'Full legal name of the investment vehicle as registered with the relevant jurisdiction (e.g., Apex Real Estate Fund II, LP, Meridian CRE Trust 2021-A). Used as the primary human-readable identifier across reporting and investor communications.',
    `vehicle_status` STRING COMMENT 'Current lifecycle status of the investment vehicle. active indicates the vehicle is operational and deploying or managing capital; winding_down indicates the vehicle is in the process of liquidating assets and returning capital to investors; closed indicates the vehicle has been fully wound down and dissolved.. Valid values are `active|closed|winding_down|pending_formation|suspended`',
    `vehicle_type` STRING COMMENT 'Legal structural classification of the investment vehicle. Determines governance, tax treatment, and regulatory obligations. [ENUM-REF-CANDIDATE: LLC|LP|JV|SMA|REIT|CMBS_Trust|RMBS_Trust|C_Corp|GP_Entity|Co_Investment|Partnership — promote to reference product]',
    `vintage_year` STRING COMMENT 'Calendar year in which the investment vehicle made its first investment or held its first capital closing. Used as the primary benchmark grouping for performance comparison against peer funds of the same vintage in Cambridge Associates, Preqin, and NCREIF benchmarks.',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Defines the legal and structural wrapper through which capital is deployed — including LLCs, LPs, joint ventures, co-investment structures, CMBS/RMBS trusts, and separately managed accounts (SMAs). Captures vehicle name, vehicle type, legal entity identifier (LEI), jurisdiction of formation, GP/LP split, ownership percentage, tax classification (pass-through, REIT, C-Corp), regulatory filing status, co-investment flag, and relationship to parent fund. Distinct from fund (the investment product offered to investors) — this is the legal holding structure through which fund capital flows.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`investor` (
    `investor_id` BIGINT COMMENT 'Unique surrogate identifier for the investor record in the real estate investment platform. Primary key for the investor entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Investor domicile country drives FATCA/CRS classification, AML risk rating, foreign ownership restriction checks, and withholding tax rate determination — all mandatory for KYC/AML compliance and tax ',
    `employee_id` BIGINT COMMENT 'Identifier of the internal relationship manager (Asset Manager or Investment Advisor) assigned to manage the investor relationship. Drives CRM activity tracking in Salesforce, reporting accountability, and investor communication routing.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Investors are domiciled in specific jurisdictions affecting tax treatment, AML requirements, and regulatory filings. Jurisdiction linkage is essential for FATCA/CRS classification, cross-border compli',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Investor investment strategy (core, value-add, opportunistic) maps to market_segment for fund-investor mandate matching, co-investment screening, and investor relations reporting on strategy alignment',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Investor preferred currency drives distribution payment processing, capital account statement generation, and FX conversion for multi-currency fund distributions. Role-prefixed to distinguish from oth',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Investors are subject to regulatory obligations (FATCA, CRS, AML/KYC). Linking investor to applicable regulatory obligations supports KYC/AML compliance workflows, investor onboarding, and ongoing reg',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Investor mandate specifies target property type for deal matching, co-investment eligibility screening, and fund-investor mandate alignment reporting used in investor relations and capital raising.',
    `accreditation_expiry_date` DATE COMMENT 'Date on which the investors accreditation verification expires. Accreditation must be re-verified periodically to maintain eligibility for private placement investments under SEC Regulation D. Drives compliance monitoring and investor eligibility gating.',
    `accreditation_status` STRING COMMENT 'Regulatory accreditation classification of the investor under SEC Regulation D. Accredited investors meet income or net worth thresholds permitting participation in private placements. Qualified purchaser status permits investment in 3(c)(7) funds. Critical for fund eligibility gating and regulatory compliance.. Valid values are `accredited|non_accredited|qualified_purchaser|pending_verification`',
    `aml_status` STRING COMMENT 'Current Anti-Money Laundering (AML) screening status for the investor. Cleared indicates the investor has passed sanctions screening and adverse media checks. Flagged indicates a potential match requiring enhanced due diligence. Mandatory for regulatory compliance under FinCEN and FATF guidelines.. Valid values are `cleared|flagged|under_review|pending`',
    `co_investment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the investor is eligible to participate in co-investment opportunities alongside the fund. Co-investment rights are typically granted to anchor investors and platinum-tier relationships. True enables the investor to receive co-investment deal flow notifications and participate in direct deal allocations.',
    `committed_capital_amount` DECIMAL(18,2) COMMENT 'Total capital amount formally committed by the investor to real estate funds or investment vehicles, expressed in the investors preferred currency. Represents the contractual obligation to fund capital calls up to this amount. Core metric for AUM (Assets Under Management) calculation and fund capacity management in MRI Software and Argus Enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investor record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Represents the audit trail creation event. Used for data lineage, compliance audit trails, and SOX financial controls reporting.',
    `crs_classification` STRING COMMENT 'OECD Common Reporting Standard (CRS) entity classification for automatic exchange of financial account information between tax authorities. Reportable Person indicates the investors account information must be reported to their country of tax residency. Drives annual CRS reporting obligations.. Valid values are `reportable_person|passive_nfe|active_nfe|financial_institution`',
    `distribution_bank_account_ref` STRING COMMENT 'Masked or tokenized reference to the investors designated bank account for distribution wire transfers and capital return payments. Full account details are stored in the secure payment vault; this field holds only the reference token. Used by Yardi Voyager AP module for distribution processing.',
    `distribution_preference` STRING COMMENT 'Investors preferred frequency and method for receiving investment distributions (income and return of capital). Quarterly is most common for real estate funds. Reinvest indicates the investor elects to reinvest distributions into additional fund units. Drives distribution waterfall processing in MRI Software and Yardi Voyager.. Valid values are `quarterly|monthly|semi_annual|annual|reinvest`',
    `esg_mandate_flag` BOOLEAN COMMENT 'Indicates whether the investor has a formal ESG (Environmental, Social, and Governance) investment mandate requiring portfolio companies and assets to meet defined sustainability criteria. True triggers ESG screening in deal sourcing and LEED/BREEAM certification requirements in asset selection.',
    `fatca_classification` STRING COMMENT 'FATCA (Foreign Account Tax Compliance Act) entity classification for the investor. Determines US withholding tax obligations and IRS reporting requirements. US Person classification triggers Form W-9 requirements. Foreign Financial Institution (FFI) classification requires GIIN registration. NFFE (Non-Financial Foreign Entity) requires beneficial ownership disclosure.. Valid values are `us_person|foreign_financial_institution|nffe|exempt_beneficial_owner|excepted_nffe`',
    `investment_horizon_years` STRING COMMENT 'Investors preferred investment hold period expressed in years. Drives fund structure matching (open-end vs. closed-end funds), asset disposition timing, and WALT (Weighted Average Lease Term) alignment in portfolio construction. Typical real estate investment horizons range from 3 to 10+ years.',
    `investor_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the investor upon onboarding. Used across MRI Software, Yardi Voyager, and Argus Enterprise to reference the investor in capital accounts, distribution statements, and fund reporting.. Valid values are `^INV-[A-Z0-9]{6,12}$`',
    `investor_status` STRING COMMENT 'Current lifecycle status of the investor record. Active indicates the investor is in good standing with capital deployed. Pending indicates onboarding in progress. Suspended indicates a hold due to KYC/AML review. Redeemed indicates full capital withdrawal. Closed indicates the investor relationship has been formally terminated.. Valid values are `active|pending|suspended|redeemed|closed`',
    `investor_tier` STRING COMMENT 'Relationship tier classification assigned to the investor based on committed capital, strategic importance, and relationship depth. Drives fee schedule application, co-investment priority access, reporting frequency, and relationship manager assignment. Platinum typically denotes anchor investors with largest AUM commitments.. Valid values are `platinum|gold|silver|standard`',
    `investor_type` STRING COMMENT 'Classification of the investor by entity category. Drives regulatory treatment, reporting obligations, and fee structures. Institutional includes insurance companies, banks, and asset managers. HNWI (High Net Worth Individual) denotes qualifying individuals. [ENUM-REF-CANDIDATE: institutional|hnwi|family_office|pension_fund|sovereign_wealth_fund|endowment|retail|reit|fund_of_funds — promote to reference product]. Valid values are `institutional|hnwi|family_office|pension_fund|sovereign_wealth_fund|endowment`',
    `kyc_expiry_date` DATE COMMENT 'Date on which the current Know Your Customer (KYC) documentation expires and renewal is required. Triggers automated alerts for re-verification workflows. Investors with expired KYC may be restricted from participating in new capital calls or fund subscriptions.',
    `kyc_status` STRING COMMENT 'Current status of the Know Your Customer (KYC) due diligence process for the investor. Approved indicates all identity verification and background checks have been completed satisfactorily. Expired indicates KYC documentation has lapsed and requires renewal. Drives onboarding gates and capital call eligibility.. Valid values are `approved|pending|under_review|rejected|expired`',
    `legal_name` STRING COMMENT 'Full legal name of the investor as registered with regulatory authorities. For institutional investors, this is the registered entity name; for individuals, the full legal name as on government-issued identification. Used for KYC/AML compliance, subscription agreements, and capital account statements.',
    `minimum_investment_amount` DECIMAL(18,2) COMMENT 'Minimum capital amount the investor is willing to deploy per investment vehicle or fund subscription. Used during fund structuring and deal allocation to ensure investment sizing meets investor thresholds. Expressed in the investors preferred currency.',
    `onboarding_date` DATE COMMENT 'Date on which the investor completed the onboarding process and was formally admitted as an investor in the platform. Marks the start of the investor relationship lifecycle. Used for WALT (Weighted Average Lease Term) equivalent calculations in investor tenure analytics and anniversary-based reporting.',
    `pep_flag` BOOLEAN COMMENT 'Indicates whether the investor or any beneficial owner is classified as a Politically Exposed Person (PEP) under AML regulations. PEP status requires enhanced due diligence (EDD) and senior management approval for onboarding. True indicates PEP status confirmed; False indicates no PEP association identified.',
    `primary_contact_email` STRING COMMENT 'Primary email address for investor communications including capital call notices, distribution notices, quarterly reports, and K-1 tax documents. Must be a valid, monitored email address per investor subscription agreement requirements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the investor organization. For individual investors, this is the investor themselves. For institutional investors, this is the designated relationship contact (e.g., portfolio manager, treasurer, or investment officer) responsible for fund communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the investors designated contact. Used for urgent communications, capital call confirmations, and relationship management outreach. Stored in E.164 international format.',
    `registered_address_city` STRING COMMENT 'City of the investors registered legal address. Used in conjunction with registered address fields for KYC verification, regulatory correspondence, and tax document delivery.',
    `registered_address_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the investors registered legal address country. Used for regulatory jurisdiction determination, sanctions screening, and tax treaty application.. Valid values are `^[A-Z]{3}$`',
    `registered_address_line1` STRING COMMENT 'First line of the investors registered legal address. Used for regulatory correspondence, K-1 mailing, subscription agreement execution, and AML/KYC address verification. For institutional investors, this is the registered office address.',
    `sanctions_screened_flag` BOOLEAN COMMENT 'Indicates whether the investor has been screened against applicable sanctions lists including OFAC SDN List, EU Consolidated Sanctions List, and UN Security Council Sanctions List. True indicates screening has been completed. Must be True before capital can be accepted from the investor.',
    `side_letter_flag` BOOLEAN COMMENT 'Indicates whether the investor has a side letter agreement with the fund manager granting special terms, rights, or concessions beyond the standard limited partnership agreement (LPA). Side letters may include MFN (Most Favored Nation) clauses, reduced management fees, enhanced reporting rights, or co-investment priority. True triggers side letter terms application in fee and distribution calculations.',
    `source_of_funds` STRING COMMENT 'Declared source of the investors capital being deployed into real estate investments. Required for AML compliance to verify the legitimacy of invested capital. [ENUM-REF-CANDIDATE: operating_income|asset_sale|inheritance|pension_fund|endowment_corpus|debt_financing|equity_raise|insurance_reserves|sovereign_allocation — promote to reference product]. Valid values are `operating_income|asset_sale|inheritance|pension_fund|endowment_corpus|debt_financing`',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Investors target equity multiple (total distributions divided by total invested capital) for real estate investments. A multiple of 2.0x means the investor expects to receive twice their invested capital over the investment hold period. Used in Argus Enterprise for investment screening and portfolio performance benchmarking.',
    `target_irr_max` DECIMAL(18,2) COMMENT 'Maximum acceptable Internal Rate of Return (IRR) threshold expressed as a decimal percentage. Defines the upper bound of the investors risk-return appetite. Investors with low IRR maximums typically prefer core or core-plus strategies. Used alongside target_irr_min to define the investors return corridor in Argus Enterprise.',
    `target_irr_min` DECIMAL(18,2) COMMENT 'Minimum acceptable Internal Rate of Return (IRR) threshold expressed as a decimal percentage (e.g., 0.0800 = 8.00%). Represents the investors stated return hurdle below which investment opportunities are not considered. Used in Argus Enterprise for deal screening and portfolio matching against investor mandates.',
    `tax_id_type` STRING COMMENT 'Classification of the tax identification number provided. EIN (Employer Identification Number) for US entities, SSN (Social Security Number) for US individuals, ITIN (Individual Taxpayer Identification Number) for non-resident individuals, Foreign TIN for non-US entities, GIIN (Global Intermediary Identification Number) for FATCA-registered entities.. Valid values are `ein|ssn|itin|foreign_tin|giin`',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the investor. For US entities, this is the EIN (Employer Identification Number) or SSN (Social Security Number). For non-US entities, the equivalent national tax registration number. Used for IRS Form K-1 issuance, FATCA reporting, and withholding tax calculations.',
    `tax_residency_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the investors country of tax residency, which may differ from domicile country. Used for CRS (Common Reporting Standard) automatic exchange of information and applicable withholding tax treaty determination.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the investor record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in the Databricks Silver Layer pipeline, audit trail maintenance, and detecting stale KYC/AML data.',
    CONSTRAINT pk_investor PRIMARY KEY(`investor_id`)
) COMMENT 'SSOT for institutional and individual investor identities participating in real estate funds and portfolios. Captures investor legal name, investor type (institutional, HNWI, family office, pension fund, sovereign wealth fund, endowment, retail), KYC/AML status, accreditation status, domicile country, tax identification, preferred currency, investor tier, relationship manager, onboarding date, and investor status. Distinct from the owner domain (which tracks property ownership) — this entity tracks capital contributors to investment vehicles.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`commitment` (
    `commitment_id` BIGINT COMMENT 'Primary key for commitment',
    `investor_id` BIGINT COMMENT 'Reference to the investor (institutional or individual) making this capital commitment. Serves as the PARTY_REFERENCE for this transaction.',
    `commitment_transferee_investor_id` BIGINT COMMENT 'Reference to the investor who received this commitment via secondary transfer. Populated only when commitment_status is transferred. Enables tracking of secondary market activity.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Commitment currency drives capital call calculations, FX conversion for multi-currency funds, uncalled capital reporting, and subscription agreement financial terms — essential for fund administration',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, CMBS/RMBS, closed-end fund) to which this capital commitment is made.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to investment.vehicle. Business justification: An investors capital commitment is made to a specific investment vehicle (LLC, LP, JV, etc.) — the legal wrapper through which capital is deployed. commitment.investment_vehicle_type is a denormalize',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Investor commitments are made to specific fund legal entities governing subscription agreement jurisdiction, tax treatment, and ERISA compliance. Real estate fund counsel requires this link for entity',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Commitment-level investment strategy (often specified in side letters) maps to market_segment for allocation reporting, waterfall tier determination, and LP-specific mandate compliance tracking.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: A commitment is made in response to an offering (the fundraising vehicle). This links the formal capital commitment to the specific fundraising round or offering that generated it. Business semantics:',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Investor commitments trigger regulatory obligations (subscription agreement compliance, ERISA, AML/KYC, FATCA). commitment.erisa_flag and aml_status indicate this relationship; linking to regulatory o',
    `amount` DECIMAL(18,2) COMMENT 'The gross total capital amount the investor has committed to the fund or investment vehicle, expressed in the commitment currency. Represents the investors maximum obligation under the subscription agreement. Part of the MONETARY_TRIPLET.',
    `aum_contribution_amount` DECIMAL(18,2) COMMENT 'The portion of this commitment that contributes to the funds reported Assets Under Management (AUM) figure, which may differ from the total commitment amount based on fund accounting policies and deployment stage.',
    `called_capital_amount` DECIMAL(18,2) COMMENT 'Total capital that has been called (drawn down) from the investor to date across all capital calls against this commitment. Represents cumulative funded capital. Part of the MONETARY_TRIPLET.',
    `capital_call_schedule_type` STRING COMMENT 'The methodology governing how and when capital calls are issued against this commitment. Determines cash flow planning for both the fund manager and the investor.. Valid values are `as_needed|scheduled|milestone_based|hybrid`',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'The carried interest (promote) percentage applicable to this commitment, expressed as a decimal (e.g., 0.2000 for 20%). Represents the fund managers share of profits above the preferred return.',
    `close_date` DATE COMMENT 'The fund closing date at which this commitment was accepted. Funds may have multiple closes (first close, second close, final close); this identifies which close the investor participated in.',
    `co_investment_flag` BOOLEAN COMMENT 'Indicates whether this commitment is a co-investment alongside the main fund vehicle (True) or a standard fund commitment (False). Co-investments typically carry different fee structures and governance rights.',
    `commitment_date` DATE COMMENT 'The date on which the investor formally committed capital to the fund, typically the date the subscription agreement or LOI was executed. Serves as the principal business event date (BUSINESS_EVENT_TIMESTAMP category).',
    `commitment_number` STRING COMMENT 'Externally-known business identifier for the commitment, used in investor correspondence, subscription documents, and capital call notices. Sourced from MRI Software Investment Management.. Valid values are `^CC-[A-Z0-9]{4,20}$`',
    `commitment_status` STRING COMMENT 'Current lifecycle state of the capital commitment from LOI through full deployment. Tracks progression: pending (LOI received), executed (subscription agreement signed), funded (capital fully called and received), defaulted (investor failed to meet capital call), cancelled (commitment withdrawn), transferred (commitment assigned to another investor). [ENUM-REF-CANDIDATE: pending|executed|funded|defaulted|cancelled|transferred — promote to reference product]. Valid values are `pending|executed|funded|defaulted|cancelled|transferred`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this capital commitment record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for data lineage and audit trail purposes.',
    `default_date` DATE COMMENT 'The date on which the investor defaulted on a capital call obligation. Populated only when commitment_status is defaulted. Triggers default remedies per the limited partnership agreement.',
    `distributed_capital_amount` DECIMAL(18,2) COMMENT 'Total capital returned to the investor through distributions (return of capital, realized gains, income distributions) against this commitment to date. Used in DPI (Distributions to Paid-In) calculations.',
    `erisa_flag` BOOLEAN COMMENT 'Indicates whether the investors assets are subject to ERISA (Employee Retirement Income Security Act) regulations. ERISA investors trigger plan asset rules and fiduciary obligations for the fund manager.',
    `first_call_date` DATE COMMENT 'The date of the first capital call issued against this commitment. Marks the beginning of the capital deployment phase and triggers the investment period clock.',
    `fund_term_end_date` DATE COMMENT 'The scheduled termination date of the fund, representing the EFFECTIVE_UNTIL for the commitments binding period. After this date, the fund is expected to be wound down and all capital returned.',
    `investment_period_end_date` DATE COMMENT 'The date on which the funds investment period expires, after which no new capital calls may be issued for new investments (only follow-on investments and fund expenses). Critical for uncalled capital management.',
    `loi_reference` STRING COMMENT 'Reference identifier for the Letter of Intent (LOI) that preceded the formal subscription agreement. Tracks the initial non-binding expression of interest in the commitment lifecycle.',
    `management_fee_basis` STRING COMMENT 'The basis on which the management fee is calculated for this commitment — committed capital (during investment period), invested capital (post-investment period), NAV (Net Asset Value), or GAV (Gross Asset Value).. Valid values are `committed_capital|invested_capital|nav|gross_asset_value`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'The annual management fee rate applicable to this commitment, expressed as a decimal (e.g., 0.0150 for 1.5%). Typically charged on committed or invested capital depending on fund terms.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, or investor-specific terms associated with this commitment that are not captured in structured fields.',
    `preferred_return_rate` DECIMAL(18,2) COMMENT 'The annual preferred return (hurdle rate) percentage applicable to this commitment, expressed as a decimal (e.g., 0.0800 for 8%). The fund manager earns carried interest only after this return threshold is met for the investor.',
    `recallable_distributions_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of distributions made to the investor that are subject to recall (clawback) for future capital calls, per the funds limited partnership agreement. Affects the effective uncalled capital balance.',
    `side_letter_flag` BOOLEAN COMMENT 'Indicates whether this commitment is accompanied by a side letter granting the investor special rights, terms, or concessions beyond the standard limited partnership agreement (e.g., MFN rights, fee discounts, reporting preferences).',
    `side_letter_reference` STRING COMMENT 'Document reference identifier for the executed side letter associated with this commitment. Populated only when side_letter_flag is True. Links to DocuSign CLM for document retrieval.',
    `source_system_code` STRING COMMENT 'The native record identifier assigned by MRI Software Investment Management for this commitment record. Used for data lineage, reconciliation, and audit trail back to the system of record.',
    `subscription_agreement_ref` STRING COMMENT 'Reference number or document identifier for the executed subscription agreement that formalizes the investors capital commitment. Links to the DocuSign CLM contract lifecycle management system.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the investor is a tax-exempt entity (e.g., pension fund, endowment, sovereign wealth fund) for purposes of UBTI (Unrelated Business Taxable Income) and withholding tax calculations on distributions.',
    `total_capital_calls_count` STRING COMMENT 'The total number of capital calls that have been issued against this commitment to date. Used for tracking deployment pace and investor notification history.',
    `transfer_date` DATE COMMENT 'The date on which this commitment was transferred to a new investor via secondary market transaction. Populated only when commitment_status is transferred.',
    `uncalled_capital_amount` DECIMAL(18,2) COMMENT 'Remaining capital not yet called from the investor, calculated as commitment_amount minus called_capital_amount. Represents the investors dry powder — capital committed but not yet deployed. Critical for fund liquidity and deployment planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this capital commitment record was last modified. Serves as the RECORD_AUDIT_UPDATED field for change tracking, data lineage, and Silver layer incremental processing.',
    CONSTRAINT pk_commitment PRIMARY KEY(`commitment_id`)
) COMMENT 'Records the formal capital commitment made by an investor to a fund or investment vehicle. Captures commitment amount, commitment currency, commitment date, commitment status (pending, executed, funded, defaulted), subscription agreement reference, capital call schedule, total called capital, uncalled capital (dry powder), total distributed capital, and co-investment flag. Tracks the lifecycle from LOI through full deployment. Sourced from MRI Software Investment Management.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`capital_call` (
    `capital_call_id` BIGINT COMMENT 'Unique system-generated identifier for each capital call notice record. Primary key for the capital_call data product.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Capital calls for asset acquisitions reference the appraisal supporting the acquisition price and LTV ratio presented to investors. Lender and LP notice requirements mandate citing the appraisal in th',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Capital call approval by a named employee is a regulated fund operations process: LP notices require authorized signatory identification for legal enforceability. Real estate fund controllers must doc',
    `asset_id` BIGINT COMMENT 'Reference to the specific property or asset being acquired or improved with the called capital, where applicable. Supports property-level capital deployment tracking and CAPEX reporting.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Capital call wire proceeds are received into specific fund bank accounts. Fund administrators track which bank account received each capital call for cash reconciliation and treasury management, repla',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to maintenance.capex_project. Business justification: Capital calls issued for capex purposes (call_purpose field) must be traceable to the specific maintenance capex project being funded. LP capital call notices require disclosure of how called capital ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Capital call proceeds must post to specific GL accounts (called capital, equity contributions). Fund accountants require COA mapping to generate accurate journal entries for each capital call event pe',
    `commitment_id` BIGINT COMMENT 'Reference to the investor commitment record from which this capital call draws. Links the call to the specific committed but uncalled capital obligation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capital call proceeds are coded to cost centers for GL posting and fund-level expense tracking. Fund accountants require this mapping to generate accurate journal entries and NOI reports when capital ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Capital call currency is required for wire instruction generation, FX conversion in multi-currency funds, and investor notice preparation — a core fund administration operational process.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, CMBS/RMBS) issuing this capital call. Supports fund-level cash management and LP capital account reconciliation.',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: A capital call may be issued to fund a specific investment deal. The capital_call table has call_purpose and investment_purpose_description fields indicating the call may be for a specific acquisition',
    `investor_id` BIGINT COMMENT 'Reference to the limited partner (LP) or investor entity to whom this capital call notice is issued. Supports investor-level capital account tracking.',
    `approval_date` DATE COMMENT 'Date on which the capital call notice was formally approved for issuance by authorized fund management. Supports SOX internal control audit trail.',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the capital call notice prior to issuance. Tracks whether the call has been reviewed and authorized by fund management per SOX internal controls.. Valid values are `pending|approved|rejected|withdrawn`',
    `call_amount` DECIMAL(18,2) COMMENT 'Gross dollar amount of capital being called from the investor in this notice. Represents the base monetary demand before any adjustments. Denominated in the funds base currency.',
    `call_date` DATE COMMENT 'The date on which the capital call notice was formally issued to the investor. Represents the principal business event date for the call. Used for LP capital account reconciliation and fund cash flow scheduling.',
    `call_number` STRING COMMENT 'Externally-known sequential identifier for the capital call notice, typically formatted as CC-YYYY-NNNN. Used in investor communications, wire transfer instructions, and LP capital account statements.. Valid values are `^CC-[0-9]{4}-[0-9]{4}$`',
    `call_percentage` DECIMAL(18,2) COMMENT 'The capital call amount expressed as a percentage of the investors total committed capital. Enables proportional analysis across LPs with different commitment sizes. Calculated as call_amount / total_commitment * 100.',
    `call_purpose` STRING COMMENT 'Business purpose for which the called capital will be deployed. Drives fund accounting allocation and investor reporting. [ENUM-REF-CANDIDATE: acquisition|capex|fees|reserves|debt_repayment|operating_expenses|recapitalization|distribution_recallable — promote to reference product if additional values required]. Valid values are `acquisition|capex|fees|reserves|debt_repayment|operating_expenses`',
    `call_sequence` STRING COMMENT 'Sequential ordinal number of this capital call within the funds overall capital call program (e.g., 1st call, 2nd call). Supports WALT/WALE-style weighted average analysis and fund deployment tracking.',
    `call_status` STRING COMMENT 'Current lifecycle state of the capital call notice. Tracks progression from issuance through funding or default. Supports fund cash management and LP default monitoring.. Valid values are `draft|issued|funded|partially_funded|defaulted|cancelled`',
    `call_type` STRING COMMENT 'Classification of the capital call by its structural nature. Distinguishes initial drawdowns from follow-on calls, recallable distributions, bridge financing calls, and supplemental calls. Supports fund accounting and investor reporting.. Valid values are `initial|follow_on|recallable|bridge|supplemental`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capital call record was first created in the system. Supports audit trail, data lineage, and SOX financial controls compliance.',
    `cumulative_called_amount` DECIMAL(18,2) COMMENT 'Total capital called from this investor across all capital calls to date including this call. Supports LP capital account balance tracking and uncalled capital calculation. Denominated in currency_code.',
    `default_date` DATE COMMENT 'The date on which the investor was formally declared in default for failure to fund this capital call. Null if not in default. Triggers LPA default penalty provisions and investor remediation processes.',
    `due_date` DATE COMMENT 'The date by which the investor must fund the called capital. Typically 10–15 business days from call_date per fund LPA terms. Drives default flag logic and wire transfer scheduling.',
    `funded_amount` DECIMAL(18,2) COMMENT 'Actual dollar amount received from the investor in response to this capital call. May be less than call_amount in partial funding scenarios. Used for LP capital account reconciliation and shortfall calculation.',
    `funded_date` DATE COMMENT 'The date on which the investors wire transfer or funding was received and confirmed. Null if not yet funded. Used for cash management reconciliation and default determination.',
    `interest_on_late_payment` DECIMAL(18,2) COMMENT 'Annual interest rate (as a percentage) charged on unfunded capital call amounts past the due date, per the funds LPA default provisions. Used to calculate default penalty amounts for LP capital account adjustments.',
    `investment_purpose_description` STRING COMMENT 'Narrative description of the specific investment or expenditure for which the called capital will be used (e.g., acquisition of 123 Main St, CAPEX for HVAC replacement). Included in investor notice for transparency.',
    `is_default` BOOLEAN COMMENT 'Indicates whether the investor has defaulted on this capital call by failing to fund by the due date. True triggers default penalty provisions per the funds Limited Partnership Agreement (LPA).',
    `is_recallable` BOOLEAN COMMENT 'Indicates whether the capital called in this notice is recallable (i.e., previously distributed capital being recalled for reinvestment per LPA terms). Affects LP capital account treatment and AFFO/FFO reporting.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, special instructions, or contextual information related to this capital call. May include investor-specific wiring instructions or fund manager annotations.',
    `notice_delivery_method` STRING COMMENT 'Channel through which the capital call notice was delivered to the investor. Supports investor communication compliance and audit trail per fund LPA requirements.. Valid values are `email|portal|mail|fax|docusign`',
    `notice_sent_date` DATE COMMENT 'The date on which the capital call notice was formally dispatched to the investor via the designated communication channel (email, DocuSign CLM, investor portal). Supports investor communication audit trail.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Dollar amount of penalty or interest charged to the investor for late or non-payment of this capital call, per LPA default provisions. Null if no default. Supports LP capital account reconciliation.',
    `shortfall_amount` DECIMAL(18,2) COMMENT 'Dollar amount by which the investors funded amount falls short of the called amount (call_amount minus funded_amount). Zero if fully funded. Drives default flag and remediation workflows.',
    `source_system_ref` STRING COMMENT 'Original record identifier from MRI Software Investment Management module for this capital call. Enables traceability back to the operational system of record for reconciliation and audit purposes.',
    `total_commitment_amount` DECIMAL(18,2) COMMENT 'The investors total committed capital to the fund at the time of this capital call. Provides context for call_percentage calculation and LP capital account reconciliation. Denominated in currency_code.',
    `uncalled_commitment_amount` DECIMAL(18,2) COMMENT 'Remaining committed but uncalled capital available from this investor after this call (total_commitment_amount minus cumulative_called_amount). Key metric for fund deployment planning and AUM reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capital call record was last modified. Supports change tracking, audit trail, and data lineage for the Databricks Silver Layer.',
    `wire_reference` STRING COMMENT 'Bank wire transfer reference number or confirmation code associated with the investors funding of this capital call. Used for treasury reconciliation and audit trail. Sourced from MRI Software or bank confirmation.',
    CONSTRAINT pk_capital_call PRIMARY KEY(`capital_call_id`)
) COMMENT 'Transactional record of each capital call notice issued to investors, requesting funded capital from committed but uncalled amounts. Captures call number, call date, call amount, call percentage of commitment, due date, purpose (acquisition, capex, fees, reserves), funding status, actual funded amount, shortfall amount, default flag, and wire transfer reference. Linked to commitment and fund. Supports LP capital account reconciliation and fund cash management. Sourced from MRI Software.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`investment_distribution` (
    `investment_distribution_id` BIGINT COMMENT 'Unique surrogate identifier for each capital or income distribution record within the investment domain. Serves as the primary key for the distribution data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Distribution approval by a named employee is required for LP payment authorization, waterfall calculation sign-off, and fund audit compliance. Real estate fund CFOs/controllers are named approvers on ',
    `bank_account_id` BIGINT COMMENT 'Reference to the investors designated bank account record to which the net distribution payment is remitted. Links to the bank account master for payment routing details.',
    `chart_of_accounts_id` BIGINT COMMENT 'Reference to the General Ledger (GL) account to which this distribution is posted in the funds accounting system. Supports financial consolidation in SAP S/4HANA and Yardi Voyager GL module.',
    `commitment_id` BIGINT COMMENT 'Foreign key linking to investment.commitment. Business justification: Distributions are calculated and paid based on an investors capital commitment — the ownership percentage, preferred return rate, and carried interest all derive from the commitment terms. Linking di',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Distribution currency drives withholding tax calculation, FX conversion for cross-border distributions, investor payment processing, and tax reporting (K-1 foreign tax credit) — essential for fund adm',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, CMBS/RMBS, private equity fund) from which this distribution is made. Links to the fund master record.',
    `investor_id` BIGINT COMMENT 'Reference to the investor (institutional or individual) receiving this distribution. Supports investor waterfall calculations and investor-level reporting.',
    `portfolio_asset_id` BIGINT COMMENT 'Reference to the specific investment or ownership interest (unit, share, partnership interest) held by the investor within the fund, from which this distribution is derived.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Distributions trigger regulatory filings (withholding tax filings, FATCA reporting, state tax filings). distribution.withholding_tax_amount and k1_issued fields indicate this relationship; linking to ',
    `waterfall_id` BIGINT COMMENT 'Foreign key linking to investment.waterfall. Business justification: Each distribution is computed according to the funds waterfall structure — the split between return of capital, preferred return, GP catch-up, and carried interest is entirely determined by the water',
    `affo_component_amount` DECIMAL(18,2) COMMENT 'The portion of the gross distribution attributable to Adjusted Funds From Operations (AFFO), which further adjusts FFO for recurring capital expenditures (CAPEX), straight-line rent adjustments, and tenant improvement (TI) amortization. Supports AFFO payout ratio analysis.',
    `amount_per_unit` DECIMAL(18,2) COMMENT 'The distribution amount expressed on a per-unit or per-share basis (gross distribution divided by total units/shares outstanding). Key metric for investor comparison, NAV calculations, and REIT dividend-per-share reporting.',
    `approval_date` DATE COMMENT 'The date on which the distribution was formally approved by the authorized fund manager or investment committee. Part of the SOX-compliant approval workflow and audit trail.',
    `capital_gain_amount` DECIMAL(18,2) COMMENT 'The portion of the gross distribution classified as long-term or short-term capital gain, arising from property dispositions or asset sales within the fund. Reported on IRS Form 1099-DIV Box 2a for investor tax purposes.',
    `carried_interest_amount` DECIMAL(18,2) COMMENT 'The portion of the distribution representing carried interest (promote) paid to the general partner or fund manager after the preferred return hurdle has been met. Subject to IRC Section 1061 three-year holding period rules.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this distribution record was first created in the data platform (Silver layer). Supports audit trail, data lineage, and SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `declaration_date` DATE COMMENT 'The date on which the fund manager or board formally declared this distribution. Required for REIT compliance reporting and investor disclosure under SEC regulations.',
    `distribution_date` DATE COMMENT 'The principal real-world business event date on which the distribution is made to investors. This is the payment date as declared by the fund, used for FFO/AFFO reporting, investor waterfall calculations, and tax reporting.',
    `distribution_number` STRING COMMENT 'Externally-known business identifier for this distribution event, typically assigned by the fund administrator or property management system (e.g., DIST-2024-Q3-0042). Used for investor statements, audit trails, and reconciliation with MRI Software and Yardi Voyager.',
    `distribution_status` STRING COMMENT 'Current lifecycle state of the distribution record. Tracks workflow from initial calculation through approval, payment, and any post-payment reversals or cancellations.. Valid values are `pending|approved|paid|cancelled|reversed`',
    `distribution_type` STRING COMMENT 'Classification of the distribution by its economic and tax character. Determines investor tax treatment and waterfall priority. Return of capital reduces cost basis; ordinary income and capital gain are taxable; preferred return and carried interest relate to fund waterfall mechanics. [ENUM-REF-CANDIDATE: return_of_capital|ordinary_income|capital_gain|preferred_return|carried_interest|qualified_dividend|non_qualified_dividend — promote to reference product]. Valid values are `return_of_capital|ordinary_income|capital_gain|preferred_return|carried_interest`',
    `ex_distribution_date` DATE COMMENT 'The date on or after which a new investor purchasing units/shares is no longer entitled to receive the declared distribution. Used in secondary market trading and investor entitlement calculations.',
    `ffo_component_amount` DECIMAL(18,2) COMMENT 'The portion of the gross distribution attributable to Funds From Operations (FFO) as defined by NAREIT. Supports FFO-based investor reporting and REIT performance benchmarking. FFO excludes depreciation and gains/losses on property sales.',
    `frequency` STRING COMMENT 'The scheduled cadence at which distributions are made from the fund to investors. Drives investor cash flow forecasting and WALT/WALE-aligned income modeling. Special distributions are one-time events outside the regular schedule.. Valid values are `monthly|quarterly|semi_annual|annual|special`',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross distribution amount payable to the investor before any withholding tax deductions. Expressed in the funds base currency. Core component of the monetary triplet for investor waterfall and FFO/AFFO reporting.',
    `k1_issued` BOOLEAN COMMENT 'Indicates whether an IRS Schedule K-1 (Partners Share of Income, Deductions, Credits) has been issued to the investor for this distribution period. Applicable to partnership and LLC fund structures. Supports tax compliance tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'The actual net amount paid to the investor after deducting withholding tax from the gross distribution amount (gross_amount minus withholding_tax_amount). This is the cash received by the investor.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or explanatory remarks about this distribution (e.g., reason for special distribution, adjustment rationale, investor-specific notes). Sourced from MRI Software and Yardi Voyager memo fields.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The investors percentage ownership interest in the fund or investment vehicle as of the record date, expressed as a decimal (e.g., 0.125000 = 12.5%). Used for waterfall allocation and pro-rata distribution calculations.',
    `payment_method` STRING COMMENT 'The method by which the net distribution amount is remitted to the investor. ACH and wire transfer are most common for institutional investors; DRIP (Dividend Reinvestment Plan) reinvests the distribution; offset applies the distribution against outstanding investor obligations.. Valid values are `ach|wire_transfer|check|drip|offset`',
    `payment_reference` STRING COMMENT 'The bank or payment system reference number (ACH trace number, wire confirmation number, check number) associated with the actual remittance of the net distribution to the investor. Used for payment reconciliation and audit.',
    `period_end_date` DATE COMMENT 'The end date of the income or performance period for which this distribution is being made. Together with period_start_date, defines the measurement window for FFO/AFFO and NOI attribution.',
    `period_start_date` DATE COMMENT 'The start date of the income or performance period for which this distribution is being made. Used to align distributions with the corresponding NOI, FFO, or AFFO reporting period.',
    `preferred_return_amount` DECIMAL(18,2) COMMENT 'The portion of the distribution representing the preferred return (hurdle rate) paid to limited partners or preferred equity investors before carried interest or promote is allocated to the general partner. Core component of waterfall calculations.',
    `record_date` DATE COMMENT 'The date on which an investor must be on record as a unit/shareholder to be eligible to receive this distribution. Critical for REIT dividend eligibility and investor entitlement calculations.',
    `reinvestment_elected` BOOLEAN COMMENT 'Indicates whether the investor has elected to reinvest this distribution through a Dividend Reinvestment Plan (DRIP) rather than receive cash. When True, the net distribution amount is used to purchase additional units/shares at the current NAV.',
    `reinvestment_price_per_unit` DECIMAL(18,2) COMMENT 'The NAV or price per unit at which the reinvested distribution was used to purchase additional units under the DRIP. Establishes the cost basis for the newly acquired units for tax purposes.',
    `reinvestment_units` DECIMAL(18,2) COMMENT 'The number of additional fund units or shares purchased through the DRIP reinvestment of this distribution. Populated only when reinvestment_elected is True. Used to update the investors unit holding balance.',
    `return_of_capital_amount` DECIMAL(18,2) COMMENT 'The portion of the gross distribution classified as return of capital (ROC), which is non-taxable but reduces the investors cost basis in the investment. Critical for investor tax reporting via IRS Form 1099-DIV Box 3.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this distribution record was sourced. Supports data lineage, reconciliation, and Silver layer provenance tracking in the Databricks Lakehouse.. Valid values are `mri_software|yardi_voyager`',
    `source_system_ref` STRING COMMENT 'The native primary key or record identifier of this distribution in the originating source system (MRI Software or Yardi Voyager). Enables bidirectional traceability between the Silver layer and the operational system of record.',
    `tax_year` STRING COMMENT 'The calendar or fiscal tax year to which this distribution is attributed for investor tax reporting purposes (e.g., IRS Form 1099-DIV, Schedule K-1 for partnerships). May differ from the distribution_date year for year-end distributions.',
    `units_held` DECIMAL(18,2) COMMENT 'The number of fund units, shares, or partnership interest units held by the investor as of the record date, used to calculate the investors pro-rata share of the total distribution.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this distribution record was last modified in the data platform (Silver layer). Tracks post-creation amendments such as reversals, corrections, or status changes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the gross distribution at source, as required by applicable tax regulations (e.g., FIRPTA for foreign investors, backup withholding). Reduces gross amount to arrive at net distribution.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The applicable withholding tax rate applied to this distribution, expressed as a decimal (e.g., 0.300000 = 30%). Rate varies by investor tax residency, treaty status, and distribution type (FIRPTA, backup withholding, treaty-reduced rates).',
    CONSTRAINT pk_investment_distribution PRIMARY KEY(`investment_distribution_id`)
) COMMENT 'Records capital and income distributions made from a fund or investment vehicle to investors. Captures distribution date, distribution type (return of capital, income, capital gain, preferred return, carried interest), gross distribution amount, withholding tax amount, net distribution amount, distribution per unit/share, distribution frequency, reinvestment election flag, and payment method. Supports FFO/AFFO reporting and investor waterfall calculations. Sourced from MRI Software and Yardi Voyager.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`portfolio_asset` (
    `portfolio_asset_id` BIGINT COMMENT 'Unique surrogate identifier for the portfolio asset record. Primary key for this association entity linking a property asset to an investment portfolio.',
    `asset_id` BIGINT COMMENT 'Cross-domain reference to the property master record in the property domain. Identifies the physical real estate asset being held within this portfolio. This entity captures the investment lens; the property domain holds the physical master record.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: Portfolio assets undergo compliance assessments (environmental, structural, ESG) affecting book value, hold strategy, and disposition decisions. Asset-level compliance assessment linkage is standard i',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: Portfolio assets are tracked for green certifications (LEED, BREEAM) directly affecting asset valuation, ESG reporting, and investor disclosures. portfolio_asset.leed_certification is a denormalized f',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Portfolio asset currency drives book value reporting, appraisal translation, and multi-currency NAV consolidation — required for IFRS/GAAP financial reporting and investor capital account statements.',
    `debt_instrument_id` BIGINT COMMENT 'Reference to the primary debt instrument (mortgage, construction loan, mezzanine facility) encumbering this asset. Links to the finance domain debt_instrument product for full loan terms, maturity, and covenant details.',
    `employee_id` BIGINT COMMENT 'Reference to the assigned Asset Manager (AM) responsible for overseeing this holdings performance, strategy execution, and reporting within the portfolio.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (SPV, LLC, partnership) that holds title to this property asset within the portfolio structure. Required for entity-level financial consolidation, tax reporting, and regulatory compliance.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Real estate asset managers must track which insurance policy covers each portfolio asset for lender covenant compliance, NAV reporting, and insurance renewal management. A domain expert would expect e',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which this asset belongs. Links the asset holding to its parent portfolio vehicle (REIT, fund, partnership, etc.).',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Portfolio asset class maps to property type for NCREIF sector allocation reporting, benchmark attribution, cap rate benchmarking, and investment mandate compliance monitoring at the asset level.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to insurance.risk_assessment. Business justification: Insurance risk assessments on held properties affect premium costs, coverage terms, and asset valuation inputs. Real estate investment managers track risk assessment results per portfolio asset for in',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: Portfolio asset ESG rating maps to sustainability rating scheme (LEED, BREEAM, ENERGY STAR) for GRESB asset-level scoring, green financing eligibility, and ESG investor disclosure reporting.',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: Property tax is a major operating expense directly impacting NOI and asset valuation. Portfolio asset management requires tracking the current tax assessment to model hold/sell decisions and budget pr',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total all-in cost to acquire the property asset, including purchase price, transaction costs, due diligence fees, and closing costs. Represents the initial cost basis for book value tracking, depreciation, and gain/loss calculations. Denominated in the portfolios functional currency.',
    `acquisition_date` DATE COMMENT 'Date on which the property asset was acquired and added to the investment portfolio. Used as the holding period start date for IRR calculations, depreciation schedules, and capital gains tax computations.',
    `acquisition_notes` STRING COMMENT 'Free-text notes capturing key details about the acquisition rationale, deal structure, special conditions, or investment thesis for this asset. Used by asset managers and investment committees for context and historical reference.',
    `actual_exit_date` DATE COMMENT 'Actual date on which the asset was disposed of or transferred out of the portfolio. Populated upon disposition completion. Used for realized IRR calculations, hold period reporting, and fund performance attribution.',
    `allocated_debt` DECIMAL(18,2) COMMENT 'Total debt financing allocated to this asset holding, including mortgage debt, mezzanine financing, and any other encumbrances. Used for LTV ratio monitoring, DSCR calculations, and portfolio leverage reporting.',
    `appraised_value` DECIMAL(18,2) COMMENT 'Most recent third-party or internal appraised market value of the property asset. Used for GAV/NAV calculations, LTV covenant monitoring, investor reporting, and REIT compliance. Should be updated at minimum annually per institutional standards.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the asset within the portfolio. Drives workflow routing for asset reviews, disposition approvals, and reporting inclusion. active = currently held and performing; under_review = strategic review in progress; disposition_pending = approved for sale; disposed = sold/transferred out; on_hold = temporarily suspended from active management.. Valid values are `active|under_review|disposition_pending|disposed|on_hold`',
    `capex_budget` DECIMAL(18,2) COMMENT 'Total approved Capital Expenditure (CAPEX) budget allocated to this asset for the current hold period, including planned improvements, repositioning costs, and major capital repairs. Used for value-add strategy tracking and return-on-investment analysis.',
    `capex_spent_to_date` DECIMAL(18,2) COMMENT 'Cumulative Capital Expenditure (CAPEX) actually spent on this asset from acquisition date through the most recent reporting period. Compared against capex_budget to monitor capital deployment progress and cost control.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country in which the property asset is located. Required for international portfolio reporting, foreign currency translation, and cross-border regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio asset record was first created in the data platform. Used for audit trail, data lineage, and record lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the portfolios books after accumulated depreciation and any impairment charges. Used for balance sheet reporting, NAV calculations, and GAAP/IFRS financial statements.',
    `disposition_price` DECIMAL(18,2) COMMENT 'Gross sale price received upon disposition of the asset from the portfolio. Populated when asset_status = disposed. Used for realized gain/loss calculation, IRR computation, and fund performance reporting.',
    `equity_invested` DECIMAL(18,2) COMMENT 'Total equity capital deployed into this asset by the portfolio, net of debt financing. Used as the denominator in equity multiple and ROI calculations, and for tracking capital deployment against fund commitments.',
    `geographic_market` STRING COMMENT 'Primary geographic market or submarket designation for this asset (e.g., Manhattan Midtown, Los Angeles CBD, Chicago OHare Submarket). Used for market-level portfolio concentration analysis, benchmarking, and CoStar market reporting.',
    `gla_sqft` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the property asset measured in square feet (SQF). Used for PSF rent analysis, portfolio size reporting, and benchmarking against market comparables. Sourced from the property domain master record.',
    `hold_strategy` STRING COMMENT 'Investment hold strategy assigned to this asset within the portfolio. Determines capital allocation priorities, return expectations, and exit planning. core_hold = long-term stabilized income; value_add = active repositioning for value creation; opportunistic = higher-risk/return transformation; disposition_target = approved for near-term sale; development = ground-up or major redevelopment.. Valid values are `core_hold|value_add|opportunistic|disposition_target|development`',
    `in_place_noi` DECIMAL(18,2) COMMENT 'Current annualized Net Operating Income (NOI) generated by the asset based on in-place leases and operating expenses. Used for CAP rate derivation, DSCR monitoring, and portfolio income reporting. Sourced from Yardi Voyager NOI statements.',
    `investment_risk_profile` STRING COMMENT 'Risk-return classification of this asset holding per institutional investment framework. Distinct from hold_strategy — this reflects the underwriting risk tier used for investor disclosure, fund mandate compliance, and performance benchmarking.. Valid values are `core|core_plus|value_add|opportunistic`',
    `is_encumbered` BOOLEAN COMMENT 'Indicates whether the asset is subject to debt financing, liens, or other encumbrances (True) or is unencumbered (False). Used for portfolio leverage analysis, lender reporting, and unencumbered asset pool tracking for REIT compliance.',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether this asset is held through a joint venture or co-investment structure (True) or is wholly owned by the portfolio (False). Drives proportional consolidation logic and joint venture reporting requirements.',
    `occupancy_rate` DECIMAL(18,2) COMMENT 'Current physical occupancy rate of the property asset expressed as a decimal (e.g., 0.9200 = 92.00%). Key operational KPI for income stability assessment, lender covenant compliance, and portfolio performance dashboards.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Portfolios percentage ownership interest in the property asset, expressed as a decimal (e.g., 0.7500 = 75.00%). Critical for proportional consolidation of NOI, GAV, debt, and equity in fund-level reporting. Supports joint venture and co-investment structures.',
    `source_system_ref` STRING COMMENT 'Identifier or reference code from the originating operational system of record (e.g., Argus Enterprise asset ID, MRI Software property code, Yardi Voyager property ID). Supports data lineage, reconciliation, and cross-system traceability.',
    `stabilized_noi` DECIMAL(18,2) COMMENT 'Projected stabilized Net Operating Income (NOI) upon completion of the assets business plan (lease-up, repositioning, or value-add program). Used in exit valuation modeling, IRR projections, and investment committee reporting.',
    `target_cap_rate` DECIMAL(18,2) COMMENT 'Underwritten target Capitalization Rate (CAP Rate) at acquisition, expressed as a decimal (e.g., 0.0550 = 5.50%). Represents the expected NOI yield on the asset value used in the investment thesis and exit pricing assumptions.',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Underwritten target equity multiple (total distributions + residual value divided by equity invested) for this asset at acquisition. Expressed as a ratio (e.g., 1.8500 = 1.85x). Used alongside target_irr for investment committee approval and performance tracking.',
    `target_exit_date` DATE COMMENT 'Planned or target date for disposition or exit of this asset from the portfolio. Used in hold period analysis, IRR projections, fund lifecycle planning, and WALT/WALE reporting. Nullable for open-ended core holds.',
    `target_irr` DECIMAL(18,2) COMMENT 'Underwritten target Internal Rate of Return (IRR) for this asset at the time of acquisition, expressed as a decimal (e.g., 0.1200 = 12.00%). Represents the return threshold used in investment committee approval and ongoing performance benchmarking.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Difference between the current appraised value (adjusted for ownership percentage) and the current book value, representing the mark-to-market unrealized gain or loss on this holding. Positive = unrealized gain; negative = unrealized loss. Key input for NAV reporting and investor performance statements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio asset record was most recently updated. Used for change detection, incremental data loads, and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_portfolio_asset PRIMARY KEY(`portfolio_asset_id`)
) COMMENT 'Association entity linking a property asset to an investment portfolio, capturing the investment-specific attributes of that holding. Records acquisition cost, acquisition date, current book value, appraised value, ownership percentage, hold strategy (core hold, value-add, disposition target), target exit date, allocated debt, equity invested, unrealized gain/loss, and asset manager assignment. Distinct from the property domain master record — this entity captures the investment lens on each asset within a portfolio context. Cross-references property_id from the property domain.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`fund_performance` (
    `fund_performance_id` BIGINT COMMENT 'Unique surrogate identifier for the fund performance record. Primary key for this period-level investment performance and valuation record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fund performance report internal approval by a named employee (Fund Controller, CFO) is required before LP distribution and regulatory filing. Real estate fund managers track the internal approver sep',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Fund performance reports are subject to external audit engagements (annual audits, GIPS compliance). fund_performance.auditor_signoff_status indicates this relationship; linking to audit_engagement su',
    `cap_rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to valuation.cap_rate_benchmark. Business justification: Fund performance reporting benchmarks the portfolio weighted-average cap rate against market surveys for LP reporting and INREV/NCREIF compliance. This is a standard fund-level performance attribution',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Fund performance reporting currency drives multi-currency NAV consolidation, benchmark comparison, and LP performance reporting — required for INREV/NCREIF compliant fund performance attribution.',
    `financial_period_close_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period_close. Business justification: Fund performance reports (IRR, NAV, DPI) are finalized only after the financial period close is signed off by the controller and CFO. Period close status gates publication of fund performance metrics ',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund (REIT, partnership, private equity fund, CMBS/RMBS vehicle) for which this performance record is captured.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Fund performance data drives regulatory filings (Form PF, AIFMD Annex IV, GRESB submissions). Linking performance records to regulatory filings is required for compliance tracking, filing deadline man',
    `nav_calculation_id` BIGINT COMMENT 'Foreign key linking to valuation.nav_calculation. Business justification: Fund performance reporting is directly derived from the formal NAV calculation. LP reporting, auditor sign-off, and INREV/NCREIF compliance require tracing fund-level NAV, GAV, and nav_per_unit back t',
    `waterfall_id` BIGINT COMMENT 'Foreign key linking to investment.waterfall. Business justification: Fund performance reporting — particularly FFO/AFFO, distribution per unit, and NAV calculations — is governed by the applicable waterfall structure. The waterfall determines how returns are allocated ',
    `affo` DECIMAL(18,2) COMMENT 'Adjusted Funds From Operations (AFFO) for the measurement period — FFO adjusted for recurring capital expenditures (CAPEX), straight-line rent adjustments, and other non-cash items. Considered a more accurate proxy for distributable cash flow than FFO.',
    `alpha` DECIMAL(18,2) COMMENT 'The funds excess return over the benchmark return for the measurement period (TWR minus benchmark_return). Positive alpha indicates outperformance; negative alpha indicates underperformance relative to the benchmark.',
    `auditor_name` STRING COMMENT 'Name of the external audit firm that reviewed or signed off on this performance period (e.g., Deloitte, PwC, KPMG, Ernst & Young). Required for SEC filings and investor transparency.',
    `auditor_signoff_status` STRING COMMENT 'The external auditors sign-off status for this performance period. not_required for interim periods; pending for annual periods awaiting audit; signed_off for unqualified audit opinion; qualified or adverse for modified opinions. Required for SOX and SEC compliance.. Valid values are `not_required|pending|signed_off|qualified|adverse`',
    `aum` DECIMAL(18,2) COMMENT 'Total Assets Under Management (AUM) for the fund as of the period end date. May differ from GAV when leverage is included or when AUM is defined per the funds limited partnership agreement. Used for management fee calculations and regulatory reporting.',
    `benchmark_name` STRING COMMENT 'The name of the benchmark index used for performance comparison (e.g., NCREIF ODCE, MSCI US REIT Index, FTSE NAREIT All Equity REITs). Provides context for interpreting benchmark_return and alpha.',
    `benchmark_return` DECIMAL(18,2) COMMENT 'The return of the designated benchmark index (e.g., NCREIF ODCE, MSCI Real Estate, S&P 500) for the same measurement period. Used to compute alpha and assess relative fund performance.',
    `cap_rate` DECIMAL(18,2) COMMENT 'The weighted average Capitalization Rate (CAP Rate) applied across the funds portfolio for the period — NOI divided by GAV. A key real estate valuation metric used in Argus Enterprise models and investor reporting.',
    `capex` DECIMAL(18,2) COMMENT 'Total Capital Expenditure (CAPEX) incurred by the funds portfolio during the measurement period, including Tenant Improvement (TI) allowances, building improvements, and major repairs that extend asset life.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund performance record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate or hurdle rate applied in the funds DCF (Discounted Cash Flow) valuation models for the period, expressed as a decimal. Used to compute NPV and to assess whether the fund is meeting its return threshold.',
    `distribution_per_unit` DECIMAL(18,2) COMMENT 'Cash distribution declared or paid per fund unit or share during the measurement period. Used for investor yield calculations, REIT dividend reporting, and AFFO payout ratio analysis.',
    `dpi` DECIMAL(18,2) COMMENT 'Distributions to Paid-In Capital (DPI) ratio — total cumulative distributions paid to investors divided by total paid-in capital. Measures the realized return component. A DPI of 1.0 means investors have received back their full invested capital in cash.',
    `equity_multiple` DECIMAL(18,2) COMMENT 'The ratio of total value (realized distributions plus unrealized NAV) to total invested capital, also known as Multiple on Invested Capital (MOIC). A value of 1.75 means investors have received or hold 1.75x their invested capital.',
    `ffo` DECIMAL(18,2) COMMENT 'Funds From Operations (FFO) for the measurement period — net income plus real estate depreciation and amortization, adjusted for gains/losses on property sales. The NAREIT-defined primary earnings metric for REITs, used in lieu of GAAP net income.',
    `gav` DECIMAL(18,2) COMMENT 'Gross Asset Value (GAV) of the fund as of the period end date — the sum of appraised market values of all properties and investments held by the fund, before deducting liabilities. Sourced from Argus Enterprise appraisal models.',
    `gross_irr` DECIMAL(18,2) COMMENT 'The annualized gross Internal Rate of Return (IRR) for the fund over the measurement period, before management fees and carried interest. Expressed as a decimal (e.g., 0.1250 = 12.50%). Core metric for ILPA and SEC reporting.',
    `leverage_ratio` DECIMAL(18,2) COMMENT 'The funds leverage ratio as of the period end date, typically expressed as total debt divided by GAV (Loan-to-Value / LTV). Monitors compliance with fund-level debt covenants and risk parameters.',
    `mwr` DECIMAL(18,2) COMMENT 'Money-Weighted Return (MWR) for the measurement period, reflecting the actual investor experience including the timing and magnitude of capital calls and distributions. Equivalent to the period IRR from the investors perspective.',
    `nav` DECIMAL(18,2) COMMENT 'Net Asset Value (NAV) of the fund as of the period end date — GAV minus total liabilities. The primary valuation basis for investor redemptions, unit pricing, and REIT reporting. Sourced from MRI Software and Argus Enterprise.',
    `nav_methodology` STRING COMMENT 'The methodology used to determine the NAV for this period. independent_appraisal uses third-party Appraisal Institute-certified appraisers; internal_valuation uses Argus Enterprise DCF models; broker_opinion uses Broker Price Opinion (BPO); automated_valuation uses AVM models; hybrid combines methods.. Valid values are `independent_appraisal|internal_valuation|broker_opinion|automated_valuation|hybrid`',
    `nav_per_unit` DECIMAL(18,2) COMMENT 'NAV divided by total units or shares outstanding as of the period end date. The per-unit pricing basis for investor subscriptions, redemptions, and REIT share pricing.',
    `net_irr` DECIMAL(18,2) COMMENT 'The annualized net Internal Rate of Return (IRR) for the fund over the measurement period, after deducting management fees, carried interest, and fund expenses. Primary investor-facing performance metric.',
    `noi` DECIMAL(18,2) COMMENT 'Net Operating Income (NOI) of the funds underlying real estate portfolio for the measurement period — total revenue minus operating expenses, before debt service, depreciation, and income taxes. Core metric for real estate valuation and CAP rate analysis.',
    `npv` DECIMAL(18,2) COMMENT 'Net Present Value (NPV) of the funds projected cash flows discounted at the funds hurdle rate or discount rate as of the period end date. Sourced from Argus Enterprise DCF models.',
    `opex` DECIMAL(18,2) COMMENT 'Total Operating Expenditure (OPEX) of the funds underlying portfolio for the measurement period, including property management fees, insurance, utilities, repairs, and Common Area Maintenance (CAM) costs.',
    `period_end_date` DATE COMMENT 'The last calendar date of the measurement period for which fund performance metrics are reported (e.g., 2024-03-31 for Q1 2024).',
    `period_start_date` DATE COMMENT 'The first calendar date of the measurement period for which fund performance metrics are reported (e.g., 2024-01-01 for Q1 2024).',
    `period_status` STRING COMMENT 'Lifecycle state of the performance record. open indicates the period is still accumulating data; closed indicates the period is finalized; audited indicates external auditor sign-off has been received; restated indicates a prior-period correction has been applied.. Valid values are `open|closed|audited|restated`',
    `period_type` STRING COMMENT 'Classification of the measurement period horizon. Drives how IRR, TWR, and benchmark comparisons are interpreted. [ENUM-REF-CANDIDATE: monthly|quarterly|annual|trailing_12|since_inception — promote to reference product if additional period types are required]. Valid values are `monthly|quarterly|annual|trailing_12|since_inception`',
    `premium_discount_to_nav` DECIMAL(18,2) COMMENT 'The percentage premium or discount at which the funds market price or transaction price trades relative to its NAV per unit. Positive values indicate a premium; negative values indicate a discount. Critical for publicly traded REITs and closed-end funds.',
    `rvpi` DECIMAL(18,2) COMMENT 'Residual Value to Paid-In Capital (RVPI) ratio — the current NAV of unrealized investments divided by total paid-in capital. Measures the unrealized return component. RVPI + DPI = TVPI.',
    `source_system_ref` STRING COMMENT 'The originating system record identifier from Argus Enterprise or MRI Software from which this performance record was sourced (e.g., Argus portfolio report ID or MRI period close reference). Supports data lineage and audit traceability.',
    `total_distributions` DECIMAL(18,2) COMMENT 'Total cash distributions paid to all fund investors during the measurement period. Feeds into DPI calculation and is a key component of ILPA cash flow reporting.',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Total outstanding liabilities of the fund as of the period end date, including mortgage debt, credit facilities, accrued fees, and other obligations. NAV = GAV minus total_liabilities.',
    `total_revenue` DECIMAL(18,2) COMMENT 'Total revenue generated by the funds underlying properties and investments during the measurement period, including Gross Rental Income (GRI), interest income, and other operating income. Sourced from MRI Software property accounting.',
    `tvpi` DECIMAL(18,2) COMMENT 'Total Value to Paid-In Capital (TVPI) ratio — the sum of DPI and RVPI. Represents the total value created per dollar of invested capital, combining both realized and unrealized returns.',
    `twr` DECIMAL(18,2) COMMENT 'Time-Weighted Return (TWR) for the measurement period, eliminating the distorting effects of external cash flows (capital calls and distributions). The GIPS-compliant return metric for comparing fund manager performance against benchmarks.',
    `units_outstanding` DECIMAL(18,2) COMMENT 'Total number of fund units or shares outstanding as of the period end date. Used to compute NAV per unit and to track dilution from new subscriptions or reduction from redemptions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund performance record was most recently modified in the data platform. Supports change tracking, restatement detection, and audit trail requirements.',
    `valuation_date` DATE COMMENT 'The specific date as of which the funds GAV and NAV were determined. May differ from period_end_date if appraisals are conducted on a lag (e.g., appraisal as of December 31 reported in February).',
    CONSTRAINT pk_fund_performance PRIMARY KEY(`fund_performance_id`)
) COMMENT 'Period-level investment performance and valuation record for a fund — the operational SSOT for how a fund performed and was valued in a given measurement period. Captures period dates, period type (quarterly, annual, trailing-12, since-inception), gross/net IRR, equity multiple (MOIC), NPV, DPI, RVPI, TVPI, TWR, MWR, benchmark return, alpha, GAV (sum of appraised values), NAV (GAV minus liabilities), NAV per unit/share, units outstanding, premium/discount to NAV, AUM, total revenue, NOI, FFO, AFFO, OPEX, CAPEX, leverage ratio, NAV calculation methodology, auditor sign-off status, and period status (open, closed, audited). Supports REIT reporting, investor redemption pricing, SEC filings, and ILPA reporting standards. Sourced from Argus Enterprise and MRI Software.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`asset_performance` (
    `asset_performance_id` BIGINT COMMENT 'Unique surrogate identifier for each asset performance record. Primary key for the asset_performance data product in the investment domain Silver layer.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Quarterly asset performance reporting requires the appraised value sourced from a specific appraisal engagement for total return and cap rate calculations. appraisal_date is denormalized from the refe',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset performance report approval by a named employee (asset manager, portfolio manager) is required for quarterly investor reporting and GIPS compliance in real estate. asset_performance has plain-te',
    `asset_id` BIGINT COMMENT 'Reference to the underlying real estate property asset being measured. Links to the property master record for physical and locational attributes.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: Asset performance records are reviewed during audit engagements (property-level audits, NOI verification, ESG audits). Linking asset performance to audit engagements supports audit scope tracking, fin',
    `cap_rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to valuation.cap_rate_benchmark. Business justification: Asset performance reporting benchmarks in-place cap rate against current market surveys to assess relative performance and identify hold/sell signals — a standard quarterly asset management reporting ',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: Insurance claims directly impact asset performance metrics — business interruption, loss of rents, and repair costs affect NOI and total return calculations. Asset performance reporting must reference',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Asset performance currency drives NOI, cap rate, and IRR calculations for multi-currency portfolios — required for NCREIF benchmark attribution and cross-border asset performance comparison.',
    `dcf_model_id` BIGINT COMMENT 'Foreign key linking to valuation.valuation_dcf_model. Business justification: Asset performance reporting references the DCF model version used for projected NOI growth, discount rate, and terminal value assumptions. dcf_model_version is a denormalized reference to the structur',
    `financial_period_close_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period_close. Business justification: Asset performance records are approved and locked in conjunction with the financial period close. Period close sign-off determines when asset performance data is considered final for investor reportin',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, CMBS) that holds this asset. Supports fund-level performance aggregation and investor reporting.',
    `fund_performance_id` BIGINT COMMENT 'Foreign key linking to investment.fund_performance. Business justification: Asset-level performance records roll up to fund-level performance for the same reporting period. Linking asset_performance to fund_performance enables period-level reconciliation — verifying that the ',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Asset performance investment strategy maps to market_segment for performance attribution by strategy (core vs. value-add), INREV benchmark comparison, and LP reporting on strategy-level returns.',
    `noi_statement_id` BIGINT COMMENT 'Foreign key linking to finance.noi_statement. Business justification: Asset-level performance metrics (cap rate, NOI, DSCR, occupancy) are sourced directly from finalized NOI statements. Real estate asset managers require this link to trace performance calculations back',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which this asset belongs. Enables roll-up of asset-level performance to portfolio and fund level.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Asset performance asset_class maps to property type for NCREIF sector benchmark attribution, sector-level performance reporting, and investment committee performance review by property type.',
    `appraised_value` DECIMAL(18,2) COMMENT 'Most recent third-party or internal appraised market value of the asset as of the performance period. Used for CAP rate calculation, LTV computation, and NAV/GAV reporting.',
    `approval_date` DATE COMMENT 'Date on which this asset performance record was formally approved and finalized by the authorized asset manager or investment officer.',
    `cap_rate` DECIMAL(18,2) COMMENT 'Capitalization rate for the asset during the period, calculated as NOI divided by current market value. Expressed as a decimal (e.g., 0.0550 = 5.50%). Primary valuation and benchmarking metric for income-producing real estate.',
    `capex` DECIMAL(18,2) COMMENT 'Capital expenditures incurred on the asset during the period including tenant improvements (TI), leasing commissions, and building capital improvements. Distinct from OPEX; impacts cash-on-cash return and levered IRR.',
    `cash_on_cash_return` DECIMAL(18,2) COMMENT 'Annual pre-tax cash flow divided by total equity invested in the asset. Expressed as a decimal. Measures the actual cash income earned on the equity invested, before considering appreciation or leverage effects.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset performance record was first created in the Silver layer data product. Supports audit trail and data lineage requirements.',
    `data_source_system` STRING COMMENT 'Operational system of record from which this performance record was sourced. Supports data lineage, reconciliation, and audit trail requirements. Primary sources are Argus Enterprise and Yardi Voyager.. Valid values are `argus_enterprise|yardi_voyager|mri_software|manual`',
    `discount_rate` DECIMAL(18,2) COMMENT 'Risk-adjusted discount rate applied in the DCF model to calculate NPV and present value of projected cash flows. Expressed as a decimal (e.g., 0.0750 = 7.50%). Reflects required rate of return for the investment strategy.',
    `dscr` DECIMAL(18,2) COMMENT 'Ratio of NOI to total debt service (principal and interest) for the period. A DSCR above 1.0 indicates the property generates sufficient income to cover debt obligations. Critical metric for lenders and CMBS compliance.',
    `egi` DECIMAL(18,2) COMMENT 'Actual gross income collected during the period after deducting vacancy and credit loss from PGI. EGI = PGI minus vacancy and credit loss. Core revenue metric for property-level performance.',
    `exit_cap_rate` DECIMAL(18,2) COMMENT 'Projected CAP rate applied to the terminal year NOI to calculate the assets residual/terminal value at the end of the hold period. Expressed as a decimal. Key assumption in DCF terminal value calculation.',
    `hold_period_years` STRING COMMENT 'Projected investment hold period in years as modeled in the DCF analysis. Determines the time horizon over which cash flows are projected and the terminal value is calculated.',
    `levered_irr` DECIMAL(18,2) COMMENT 'Internal Rate of Return calculated on the assets equity cash flows after accounting for debt financing. Expressed as a decimal. Reflects the return to equity investors after leverage effects.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of outstanding debt to current appraised or market value of the asset. Expressed as a decimal (e.g., 0.6500 = 65%). Key leverage metric for lenders, CMBS covenants, and portfolio risk management.',
    `nla_sqft` DECIMAL(18,2) COMMENT 'Net leasable area of the property in square feet as of the performance period. Used as the denominator for PSF metrics (OPEX PSF, revenue PSF) and occupancy calculations.',
    `noi` DECIMAL(18,2) COMMENT 'Net Operating Income for the period calculated as EGI minus operating expenses. Primary measure of a propertys income-generating ability before debt service and capital expenditures. SSOT metric for investment performance.',
    `npv` DECIMAL(18,2) COMMENT 'Net Present Value of the assets projected cash flows discounted at the models discount rate. Positive NPV indicates value creation above the required return threshold. Sourced from Argus Enterprise DCF model.',
    `occupancy_rate` DECIMAL(18,2) COMMENT 'Percentage of total leasable area that is occupied and generating income during the performance period. Expressed as a decimal (e.g., 0.9150 = 91.50%). Core leasing performance indicator.',
    `operating_expenses` DECIMAL(18,2) COMMENT 'Total property-level operating expenditures for the period including property management fees, insurance, taxes, utilities, repairs, and CAM costs. Excludes debt service and capital expenditures.',
    `opex_psf` DECIMAL(18,2) COMMENT 'Total operating expenses divided by the propertys net leasable area in square feet. Expressed as currency per square foot (PSF). Enables cross-property benchmarking of operating efficiency.',
    `performance_period_end_date` DATE COMMENT 'Last day of the reporting period for which this asset performance record is calculated. Together with performance_period_start_date defines the measurement window.',
    `performance_period_start_date` DATE COMMENT 'First day of the reporting period for which this asset performance record is calculated. Used to define the measurement window for NOI, EGI, occupancy, and other period-level metrics.',
    `performance_status` STRING COMMENT 'Current lifecycle state of this asset performance record. Draft indicates in-progress calculation; preliminary is unaudited; final is approved; restated reflects post-close corrections; archived is superseded.. Valid values are `draft|preliminary|final|restated|archived`',
    `period_type` STRING COMMENT 'Granularity of the performance measurement period. Determines whether the record represents a monthly, quarterly, annual, trailing 12-month, or year-to-date snapshot.. Valid values are `monthly|quarterly|annual|trailing_12_month|ytd`',
    `pgi` DECIMAL(18,2) COMMENT 'Total scheduled rental income assuming 100% occupancy at market or contracted rents for the period. Represents the theoretical maximum revenue before vacancy and credit loss deductions. Sourced from Yardi Voyager rent rolls.',
    `projected_noi_growth_rate` DECIMAL(18,2) COMMENT 'Annual NOI growth rate assumption applied in the DCF model for projecting future cash flows. Expressed as a decimal (e.g., 0.0300 = 3.00%). Reflects rent escalation, occupancy improvement, and expense management assumptions.',
    `revenue_psf` DECIMAL(18,2) COMMENT 'Effective gross income divided by the propertys net leasable area in square feet. Expressed as currency per square foot (PSF). Benchmarks revenue productivity across the portfolio.',
    `sensitivity_scenario` STRING COMMENT 'DCF sensitivity scenario label for this performance record. Base is the primary underwriting case; upside reflects optimistic assumptions; downside reflects conservative assumptions; stress reflects severe adverse conditions.. Valid values are `base|upside|downside|stress`',
    `terminal_value` DECIMAL(18,2) COMMENT 'Projected residual value of the asset at the end of the DCF hold period, calculated as terminal year NOI divided by exit CAP rate. Represents the expected sale proceeds at disposition.',
    `total_return` DECIMAL(18,2) COMMENT 'Total investment return for the period combining income return (NOI yield) and capital appreciation return. Expressed as a decimal. NCREIF-standard metric for benchmarking against property indices.',
    `unlevered_irr` DECIMAL(18,2) COMMENT 'Internal Rate of Return calculated on the assets cash flows before debt financing (unlevered/all-equity basis). Expressed as a decimal. Measures the intrinsic return of the asset independent of capital structure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset performance record was last modified. Tracks restatements, corrections, and updates to performance data throughout the record lifecycle.',
    `vacancy_credit_loss` DECIMAL(18,2) COMMENT 'Deduction from PGI representing income lost due to vacant units and uncollectable rents during the period. Used to derive EGI from PGI.',
    `vacancy_rate` DECIMAL(18,2) COMMENT 'Percentage of total leasable area that is unoccupied during the performance period. Expressed as a decimal (e.g., 0.0850 = 8.50%). Inverse of occupancy rate; key driver of EGI and NOI.',
    `wale` DATE COMMENT 'Weighted average date on which leases across the asset expire, weighted by rental income or NLA. Expressed as a date. Indicates the point in time when the portfolio faces significant re-leasing risk.',
    `walt` DECIMAL(18,2) COMMENT 'Weighted average remaining lease term across all occupied tenants, weighted by rental income or NLA. Expressed in years. Measures lease duration risk and income security of the asset.',
    CONSTRAINT pk_asset_performance PRIMARY KEY(`asset_performance_id`)
) COMMENT 'Period-level performance, valuation, and DCF modeling record for an individual portfolio asset. Captures actual results (NOI, EGI, PGI, vacancy rate, CAP rate, cash-on-cash return, unlevered/levered IRR, NPV, DSCR, LTV, total return, OPEX PSF, revenue PSF, occupancy rate, WALT, WALE) and DCF model parameters (model version, discount rate, hold period, projected NOI by year, projected growth rates, exit CAP rate, terminal value, sensitivity scenario). Enables asset-level attribution, scenario analysis, and roll-up to portfolio and fund performance. SSOT for investment-oriented asset analytics. Sourced from Argus Enterprise and Yardi Voyager.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`debt_facility` (
    `debt_facility_id` BIGINT COMMENT 'Unique system-generated identifier for the debt facility record. Primary key for the debt_facility data product.',
    `asset_id` BIGINT COMMENT 'Reference to the collateral property securing this debt facility. Null for portfolio-level or cross-collateralized facilities.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Debt facility interest expense and origination fees are coded to cost centers for property and fund-level NOI and P&L reporting. Real estate controllers require cost center coding on debt facilities f',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Debt facility currency drives covenant threshold calculations (LTV, DSCR), interest accrual, outstanding balance reporting, and lender compliance reporting — essential for debt management operations.',
    `debt_instrument_id` BIGINT COMMENT 'Foreign key linking to finance.debt_instrument. Business justification: An investment-domain debt facility maps to a finance-domain debt instrument for balance sheet recording, debt service scheduling, and covenant compliance monitoring. Real estate fund accountants requi',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, or fund entity) against which this debt facility is structured.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to investment.vehicle. Business justification: Debt facilities in real estate investment are typically structured at the investment vehicle level — the borrower on a mortgage or credit facility is the LLC or LP (the vehicle), not the fund itself. ',
    `lender_id` BIGINT COMMENT 'Reference to the lending institution or counterparty providing this debt facility (bank, insurance company, CMBS trust, mezzanine lender).',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Lenders require borrowers to maintain insurance on collateral as a loan covenant condition. Debt facility records must reference the required insurance policy for covenant compliance monitoring, servi',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio that this debt facility is associated with, supporting portfolio-level debt aggregation and reporting.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Debt facilities (CMBS, agency loans, public debt) require regulatory filings (Reg AB, SEC filings, FHFA reporting). Linking debt facilities to regulatory filings supports debt compliance monitoring, l',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Debt facilities are subject to regulatory obligations (banking regulations, CMBS disclosure requirements, Reg AB, Dodd-Frank). Linking facilities to regulatory obligations supports debt compliance mon',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Debt facility management is assigned to a specific employee (debt capital markets officer, asset manager) responsible for lender relationships, covenant monitoring, and refinancing decisions. Real est',
    `amortization_period_months` STRING COMMENT 'Number of months over which the loan principal is amortized for payment calculation purposes. May differ from the loan term for balloon structures (e.g., 30-year amortization on a 10-year term).',
    `amortization_type` STRING COMMENT 'Describes the principal repayment structure: interest-only (IO), fully amortizing over the loan term, partial amortization with balloon, or balloon payment at maturity.. Valid values are `interest_only|fully_amortizing|partial_amortization|balloon`',
    `collateral_description` STRING COMMENT 'Narrative description of the collateral securing this debt facility, including property type, address summary, and cross-collateralization details for portfolio loans.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Maximum principal amount committed by the lender under this facility. For revolving or construction facilities, this is the total available commitment, not the drawn balance.',
    `covenant_compliance_status` STRING COMMENT 'Current compliance status of all financial covenants on this facility. Drives lender notification workflows, waiver requests, and regulatory disclosures.. Valid values are `compliant|waiver|breach|cure_period`',
    `covenant_dscr_threshold` DECIMAL(18,2) COMMENT 'Minimum DSCR required under the loan covenant, expressed as a decimal (e.g., 1.20). Breach triggers lender notification, cash trap, or default provisions.',
    `covenant_ltv_threshold` DECIMAL(18,2) COMMENT 'Maximum LTV ratio permitted under the loan covenant, expressed as a decimal (e.g., 0.75 for 75%). Breach triggers lender notification and potential cure obligations.',
    `covenant_measurement_frequency` STRING COMMENT 'Frequency at which financial covenants (LTV, DSCR, occupancy) are tested and reported to the lender.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `covenant_occupancy_threshold` DECIMAL(18,2) COMMENT 'Minimum physical occupancy rate required under the loan covenant, expressed as a decimal (e.g., 0.85 for 85%). Measured against GLA or NLA depending on loan agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this debt facility record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `cure_period_days` STRING COMMENT 'Number of calendar days the borrower has to remedy a covenant breach before the lender may declare an event of default. Defined in the loan agreement.',
    `dscr` DECIMAL(18,2) COMMENT 'Ratio of Net Operating Income (NOI) to total annual debt service (principal and interest). Measures the propertys ability to cover debt obligations. Expressed as a decimal (e.g., 1.25). Key covenant and underwriting metric.',
    `extended_maturity_date` DATE COMMENT 'Maturity date after exercise of extension options, if applicable. Null if no extension has been exercised or no extension option exists.',
    `extension_options_count` STRING COMMENT 'Number of extension options available to the borrower to extend the maturity date, subject to conditions (e.g., no event of default, minimum DSCR). Common in bridge and construction loans.',
    `extension_period_months` STRING COMMENT 'Duration in months of each extension option. Multiplied by extension_options_count to determine maximum extended term.',
    `facility_name` STRING COMMENT 'Descriptive business name for the debt facility (e.g., One Market Plaza Senior Mortgage, Portfolio Bridge Facility 2024). Used for identification in reporting and dashboards.',
    `facility_number` STRING COMMENT 'Externally-known loan or facility reference number assigned by the lender or originating system. Used for lender correspondence, CMBS reporting, and covenant tracking.',
    `facility_status` STRING COMMENT 'Current lifecycle status of the debt facility. Drives covenant monitoring workflows, reporting inclusion, and asset management alerts.. Valid values are `active|closed|matured|defaulted|in_negotiation|pending_close`',
    `facility_type` STRING COMMENT 'Classification of the debt instrument by structure and purpose. [ENUM-REF-CANDIDATE: mortgage_loan|construction_loan|bridge_loan|mezzanine_debt|credit_facility|cmbs|rmbs — promote to reference product]',
    `interest_rate` DECIMAL(18,2) COMMENT 'All-in annual interest rate expressed as a decimal (e.g., 0.065 for 6.5%). For floating rate facilities, this is the current effective rate (spread plus index). Used in debt service and NOI analysis.',
    `interest_rate_type` STRING COMMENT 'Indicates whether the interest rate is fixed for the loan term, floating (variable based on a benchmark index), or hybrid (fixed converting to floating or vice versa).. Valid values are `fixed|floating|hybrid`',
    `io_period_months` STRING COMMENT 'Number of months from origination during which only interest payments are required, with no principal amortization. Common in bridge loans and construction facilities.',
    `is_cross_collateralized` BOOLEAN COMMENT 'Indicates whether this facility is secured by multiple properties under a cross-collateralization agreement. True for portfolio loans; False for single-asset facilities.',
    `is_cross_defaulted` BOOLEAN COMMENT 'Indicates whether a default on this facility triggers a default on other debt facilities under a cross-default provision. Critical for portfolio risk management.',
    `last_covenant_test_date` DATE COMMENT 'Date on which the most recent covenant compliance measurement was performed. Used to determine when the next test is due.',
    `lender_notification_required` BOOLEAN COMMENT 'Indicates whether the current covenant compliance status requires formal written notification to the lender per the loan agreement terms.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the outstanding loan balance to the appraised or market value of the collateral property at origination or last measurement. Key underwriting and covenant metric expressed as a decimal (e.g., 0.65 for 65% LTV).',
    `maturity_date` DATE COMMENT 'Contractual date on which the outstanding principal balance is due in full. Key input for WALT/WALE analysis and refinancing pipeline management.',
    `origination_date` DATE COMMENT 'Date on which the debt facility was originated or closed. Marks the start of the loan term and triggers amortization schedule calculations.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current drawn and outstanding principal balance on the debt facility as of the last reporting date. Used in LTV calculations, DSCR analysis, and balance sheet reporting.',
    `prepayment_lockout_end_date` DATE COMMENT 'Date after which prepayment is permitted (subject to applicable penalty). Null if no lockout period applies.',
    `prepayment_type` STRING COMMENT 'Type of prepayment restriction or penalty applicable to this facility: lockout (no prepayment allowed), yield maintenance, defeasance, step-down penalty, or none.. Valid values are `none|lockout|yield_maintenance|defeasance|step_down`',
    `rate_index` STRING COMMENT 'Benchmark interest rate index to which the floating rate spread is applied (e.g., SOFR, Prime Rate, Treasury). Null for fixed-rate facilities. [ENUM-REF-CANDIDATE: SOFR|LIBOR|Prime|EURIBOR|Treasury|SONIA|fixed — 7 candidates stripped; promote to reference product]',
    `rate_spread` DECIMAL(18,2) COMMENT 'Margin or spread above the benchmark index expressed as a decimal (e.g., 0.0200 for 200 basis points). Applicable to floating rate facilities only.',
    `recourse_type` STRING COMMENT 'Indicates whether the debt obligation is full recourse, non-recourse, or partial recourse to the borrower entity. Critical for risk assessment and balance sheet classification.. Valid values are `full_recourse|non_recourse|partial_recourse`',
    `seniority_tier` STRING COMMENT 'Capital stack position of this debt facility relative to other obligations on the same collateral. Determines priority of repayment in liquidation or refinancing scenarios.. Valid values are `senior|junior|mezzanine|subordinated|preferred_equity`',
    `servicer_name` STRING COMMENT 'Name of the loan servicer responsible for collecting payments, managing escrows, and administering the loan on behalf of the lender or CMBS trust.',
    `source_system_ref` STRING COMMENT 'Identifier of the originating system of record for this debt facility record (e.g., Yardi Voyager loan ID, MRI debt module reference). Supports data lineage and reconciliation.',
    `unfunded_commitment` DECIMAL(18,2) COMMENT 'Portion of the total commitment not yet drawn by the borrower. Relevant for construction loans, credit facilities, and revolving debt structures.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this debt facility record was last modified. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    CONSTRAINT pk_debt_facility PRIMARY KEY(`debt_facility_id`)
) COMMENT 'Master record for debt financing instruments secured against investment assets or portfolios — mortgage loans, construction loans, bridge loans, mezzanine debt, CMBS/RMBS, and credit facilities. Captures lender, facility type, principal amounts, interest rate terms, maturity, amortization, LTV, collateral references, recourse type, facility status, and full covenant details: covenant type (LTV, DSCR, occupancy, NOI, debt yield), threshold values, measurement frequency, last measured values, compliance status (compliant, waiver, breach), cure periods, and lender notification requirements. SSOT for investment-level debt instruments and covenant compliance monitoring.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`debt_covenant` (
    `debt_covenant_id` BIGINT COMMENT 'Unique system-generated identifier for each debt covenant record tracked across the real estate debt portfolio.',
    `asset_id` BIGINT COMMENT 'Reference to the specific property or collateral asset to which this covenant applies, where the covenant is asset-level rather than portfolio-level.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Covenant currency used in financial covenant threshold calculations (minimum NOI, maximum debt balance) and breach reporting to lenders — required for covenant compliance monitoring and cure period ma',
    `debt_facility_id` BIGINT COMMENT 'Foreign key linking to investment.debt_facility. Business justification: A debt covenant is a contractual obligation attached to a specific debt facility. debt_covenant already links to finance.debt_instrument (cross-domain), but the investment-domain debt record is debt_f',
    `debt_instrument_id` BIGINT COMMENT 'Reference to the parent debt instrument (loan, bond, credit facility, CMBS tranche) to which this covenant is attached. Links to the finance.debt_instrument product.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the borrowing legal entity (SPV, REIT, partnership, LLC) obligated under this covenant. Supports entity-level covenant compliance reporting.',
    `lender_id` BIGINT COMMENT 'Reference to the lender or lending institution that imposed this covenant. Used to group covenant compliance obligations by counterparty.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Debt covenants frequently mandate maintenance of specific insurance coverage (minimum insured value, required policy types, lender as additional insured). The covenant record must reference the monito',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Debt covenant compliance monitoring is assigned to a specific employee (asset manager, finance analyst) in real estate operations. Lender reporting packages require a named responsible party. Covenant',
    `breach_date` DATE COMMENT 'The date on which a covenant breach was first identified. Populated when compliance_status transitions to breach. Used to calculate cure deadlines and trigger lender notification workflows.',
    `calculation_methodology` STRING COMMENT 'Narrative description of the specific calculation methodology for the covenant metric as defined in the loan agreement, including any agreed adjustments, exclusions, or definitions (e.g., how NOI is defined for DSCR purposes, whether straight-line rent is included).',
    `compliance_status` STRING COMMENT 'Current compliance state of this covenant: compliant (threshold met), breach (threshold violated), waiver (lender has granted a formal waiver), cure_period (within contractual cure window), watch_list (approaching threshold), or not_tested (measurement not yet due).. Valid values are `compliant|breach|waiver|cure_period|watch_list|not_tested`',
    `covenant_description` STRING COMMENT 'Full narrative description of the covenant terms and conditions as extracted from the loan agreement, including any qualifications, exclusions, or special calculation methodologies.',
    `covenant_metric` STRING COMMENT 'The specific financial or operational metric being tested by this covenant, such as Loan-to-Value Ratio (LTV), Debt Service Coverage Ratio (DSCR), occupancy rate, Net Operating Income (NOI), debt yield, Interest Coverage Ratio (ICR), Funds From Operations (FFO), Adjusted Funds From Operations (AFFO), or Net Asset Value (NAV). [ENUM-REF-CANDIDATE: LTV|DSCR|occupancy_rate|NOI|debt_yield|ICR|FFO|AFFO|NAV|other — promote to reference product]',
    `covenant_name` STRING COMMENT 'Human-readable name or short description of the covenant as defined in the loan agreement (e.g., Minimum DSCR Test, Maximum LTV Covenant, Minimum Occupancy Requirement).',
    `covenant_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for this covenant as referenced in the loan agreement or credit facility documentation. Used for lender correspondence and audit trail.',
    `covenant_scope` STRING COMMENT 'Defines the level at which the covenant is tested: asset_level (single property), portfolio_level (pool of properties), entity_level (borrowing SPV or LLC), or fund_level (entire investment fund or REIT).. Valid values are `asset_level|portfolio_level|entity_level|fund_level`',
    `covenant_type` STRING COMMENT 'High-level classification of the covenant: financial (ratio-based tests), operational (occupancy, NOI), reporting (information delivery obligations), maintenance (ongoing compliance tests), or incurrence (triggered by specific actions). [ENUM-REF-CANDIDATE: financial|operational|reporting|maintenance|incurrence — promote to reference product if additional types emerge]. Valid values are `financial|operational|reporting|maintenance|incurrence`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this covenant record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail and data lineage requirements.',
    `cure_deadline_date` DATE COMMENT 'The specific calendar date by which a covenant breach must be remedied, calculated from the breach detection date plus the cure_period_days. Populated only when compliance_status is breach or cure_period.',
    `cure_period_days` STRING COMMENT 'Number of calendar days the borrower has to remedy a covenant breach before the lender may exercise remedies (e.g., acceleration, default). Defined in the loan agreement.',
    `effective_date` DATE COMMENT 'The date from which this covenant becomes binding and enforceable under the loan agreement. Marks the start of the compliance obligation period.',
    `expiry_date` DATE COMMENT 'The date on which this covenant obligation expires or is released, typically aligned with the loan maturity date or a contractual release event. Null for covenants with no defined end date.',
    `is_cross_default` BOOLEAN COMMENT 'Indicates whether a breach of this covenant triggers a cross-default event under other debt facilities of the same borrower or related entities. Critical for portfolio-level risk management.',
    `is_financial_covenant` BOOLEAN COMMENT 'Indicates whether this covenant is classified as a financial covenant under FASB ASC 470 or IFRS 9, which may require reclassification of the associated debt from long-term to current liabilities upon breach.',
    `last_measured_value` DECIMAL(18,2) COMMENT 'The most recently calculated or reported value of the covenant metric as of the last measurement date. Compared against threshold_value to determine compliance_status.',
    `last_measurement_date` DATE COMMENT 'The date on which the covenant metric was most recently calculated and tested against the threshold. Used to determine when the next measurement is due.',
    `lender_notification_days` STRING COMMENT 'Number of calendar days within which the borrower must notify the lender following a covenant breach, as specified in the loan agreement. Applicable only when lender_notification_required is True.',
    `lender_notification_required` BOOLEAN COMMENT 'Indicates whether the loan agreement requires the borrower to formally notify the lender upon a covenant breach or when the metric approaches the threshold. Drives automated notification workflows.',
    `measurement_frequency` STRING COMMENT 'How often the covenant metric must be calculated and reported to the lender: monthly, quarterly, semi-annual, annual, or on-demand (triggered by specific events such as a new acquisition or disposition).. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    `measurement_period_type` STRING COMMENT 'The look-back or calculation period used when computing the covenant metric: trailing 12 months (T12), trailing 3 months annualized, point-in-time (balance sheet date), or annualized from a shorter period.. Valid values are `trailing_12_months|trailing_3_months|point_in_time|annualized`',
    `next_measurement_date` DATE COMMENT 'The scheduled date for the next covenant measurement and compliance test. Derived from last_measurement_date and measurement_frequency but stored explicitly to support proactive monitoring workflows.',
    `notes` STRING COMMENT 'Free-text field for asset managers or compliance officers to record additional context, remediation actions taken, lender communications, or other qualitative information relevant to this covenant.',
    `notification_sent_date` DATE COMMENT 'The date on which the formal breach notification was dispatched to the lender. Used to evidence compliance with contractual notification obligations and support audit requirements.',
    `reporting_due_days` STRING COMMENT 'Number of days after the measurement period end date by which the compliance certificate or reporting package must be delivered to the lender. Applicable when reporting_package_required is True.',
    `reporting_package_required` BOOLEAN COMMENT 'Indicates whether the lender requires a formal compliance certificate or reporting package (e.g., rent roll, financial statements, occupancy report) to be submitted alongside each covenant measurement.',
    `source_system_name` STRING COMMENT 'Name of the operational system of record from which this covenant record was sourced: MRI Software, SAP S/4HANA, Yardi Voyager, Argus Enterprise, or Manual (for covenants entered directly into the lakehouse).. Valid values are `MRI_Software|SAP_S4HANA|Yardi_Voyager|Argus_Enterprise|Manual`',
    `source_system_ref` STRING COMMENT 'The unique identifier or record reference for this covenant in the originating source system (MRI Software or SAP S/4HANA). Supports data lineage, reconciliation, and audit traceability between the lakehouse and operational systems.',
    `threshold_direction` STRING COMMENT 'Indicates whether the covenant requires the metric to be at or above a minimum (e.g., minimum DSCR of 1.25x) or at or below a maximum (e.g., maximum LTV of 75%). Determines the breach logic for compliance monitoring.. Valid values are `minimum|maximum`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value: ratio (e.g., LTV expressed as 0.75), percentage (e.g., occupancy rate as 85%), currency (e.g., minimum NOI in USD), or times (e.g., DSCR expressed as 1.25x).. Valid values are `ratio|percentage|currency|times`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The contractually defined threshold or limit for the covenant metric. For ratio-based covenants (LTV, DSCR), this is expressed as a decimal (e.g., 0.75 for 75% LTV). For monetary covenants (minimum NOI), this is expressed in the applicable currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this covenant record was most recently modified, in ISO 8601 format with timezone offset. Used to detect stale records and support incremental data loading in the Databricks Silver layer.',
    `waiver_date` DATE COMMENT 'The date on which the lender formally granted a waiver for a covenant breach. Populated only when compliance_status is waiver.',
    `waiver_expiry_date` DATE COMMENT 'The date on which a lender-granted waiver expires. After this date, the covenant reverts to its standard compliance testing regime. Null if the waiver is permanent.',
    `watch_list_threshold_value` DECIMAL(18,2) COMMENT 'An internal early-warning threshold set by the asset management team, typically more conservative than the contractual threshold_value. When last_measured_value approaches this level, the covenant is flagged as watch_list to trigger proactive remediation.',
    CONSTRAINT pk_debt_covenant PRIMARY KEY(`debt_covenant_id`)
) COMMENT 'Tracks financial and operational covenants associated with debt facilities. Captures covenant type (LTV, DSCR, occupancy, NOI, debt yield), covenant threshold value, measurement frequency, last measured value, last measurement date, covenant status (compliant, waiver, breach), cure period, and lender notification requirement. Enables proactive covenant compliance monitoring across the debt portfolio. Sourced from MRI Software and SAP S/4HANA.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`investment_deal` (
    `investment_deal_id` BIGINT COMMENT 'Primary key for deal',
    `address_id` BIGINT COMMENT 'Foreign key linking to property.address. Business justification: Deal pipeline geographic reporting, submarket targeting, and market analysis require normalized address data. The existing property_address plain-text column is a denormalization of the canonical ad',
    `bpo_id` BIGINT COMMENT 'Foreign key linking to valuation.bpo. Business justification: Deal pipeline orders BPOs for preliminary value opinions before committing to full appraisal costs. Linking investment_deal to bpo supports deal screening and early-stage underwriting documentation in',
    `brokerage_broker_id` BIGINT COMMENT 'Foreign key linking to brokerage.broker. Business justification: Investment deal pipeline tracks which broker sourced or is representing the seller. Broker relationship attribution is a named operational process for deal sourcing analytics, commission negotiation, ',
    `cap_rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to valuation.cap_rate_benchmark. Business justification: Deal underwriting validates target cap rates against market cap rate benchmarks (CBRE, JLL, NCREIF surveys). IC approval requires citing the market benchmark supporting the going-in cap rate assumptio',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Acquisition deals require permits (building permits, zoning variances, environmental permits) as conditions of closing. IC memos and deal underwriting explicitly reference permit status; linking deals',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Deal currency used in underwriting model, IC memo capitalization table, and contracted price reporting — required for multi-currency deal pipeline management and cross-border acquisition analysis.',
    `dcf_model_id` BIGINT COMMENT 'Foreign key linking to valuation.valuation_dcf_model. Business justification: Deal underwriting is built on a DCF/Argus model. Linking investment_deal to valuation_dcf_model enables IC package traceability and audit of underwriting assumptions — a core deal pipeline governance ',
    `employee_id` BIGINT COMMENT 'Reference to the Asset Manager (AM) responsible for underwriting, managing due diligence, and shepherding this deal through the Investment Committee (IC) process.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, separate account) sponsoring this deal. Links to the fund master record.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Deal market and submarket map to geographic hierarchy for pipeline reporting by market, geographic concentration analysis, and fund mandate compliance screening against target geographies.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Land and development deal underwriting requires direct parcel identification for zoning analysis, FAR review, and IC approval before an asset record exists. A CRE investment professional expects the d',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: When an investment deal closes successfully, it results in the creation of a portfolio_asset record. Linking investment_deal to portfolio_asset tracks the full deal lifecycle from pipeline sourcing th',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio under which this deal is being evaluated or will be held upon closing.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Deal pipeline property type drives IC screening against fund mandate, sector allocation pipeline reporting, and deal sourcing strategy analysis — a core acquisition team operational process.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Deal acquisitions trigger regulatory obligations (environmental review, zoning approvals, CFIUS, antitrust filings). IC memos reference regulatory_approval_required; linking deals to specific regulato',
    `actual_close_date` DATE COMMENT 'Date the transaction actually closed and title/ownership transferred. Populated upon deal closure. Compared against projected_close_date to measure execution accuracy and pipeline forecasting quality.',
    `asking_price` DECIMAL(18,2) COMMENT 'Sellers listed or quoted price for the asset in the deal currency. Represents the gross consideration requested before negotiation. Used as the baseline for underwriting and bid strategy.',
    `contract_date` DATE COMMENT 'Date the Purchase and Sale Agreement (PSA) or equivalent binding contract was fully executed. Marks the transition to under_contract stage. Triggers due diligence period and deposit obligations.',
    `contracted_price` DECIMAL(18,2) COMMENT 'Agreed purchase/sale price as executed in the Purchase and Sale Agreement (PSA) or equivalent binding contract. Populated once the deal reaches under_contract stage. May differ from asking price and underwritten value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investment deal pipeline record was first created in the system. Audit trail field for data governance and SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dead_reason` STRING COMMENT 'Reason the deal was terminated or marked as dead. Populated only when deal_stage = dead. Enables pipeline loss analysis and sourcing strategy refinement. [ENUM-REF-CANDIDATE: pricing|due_diligence_failure|ic_rejection|financing|seller_withdrew|outbid|market_conditions|legal|other — promote to reference product]',
    `deal_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the deal across systems (e.g., Salesforce CRM, Argus Enterprise, MRI Software). Follows the format FUND-YEAR-SEQ (e.g., REIT-2024-0042).. Valid values are `^[A-Z]{2,6}-[0-9]{4}-[0-9]{4}$`',
    `deal_name` STRING COMMENT 'Human-readable name or working title assigned to the investment deal (e.g., Midtown Office Tower Acquisition, Riverside Industrial Portfolio). Used as the primary business identifier across deal pipeline communications and IC memos.',
    `deal_status` STRING COMMENT 'Operational status of the deal record, distinct from deal_stage. Indicates whether the deal is actively being pursued (active), paused (on_hold), IC-approved (approved), IC-rejected (rejected), withdrawn by counterparty (withdrawn), or fully closed (closed).. Valid values are `active|on_hold|approved|rejected|withdrawn|closed`',
    `deal_type` STRING COMMENT 'Classification of the investment deal by transaction structure. Acquisition = buying an asset; Disposition = selling; Recapitalization = restructuring equity/debt; JV Formation = joint venture creation; Refinancing = debt restructure; Development = ground-up or value-add development. [ENUM-REF-CANDIDATE: acquisition|disposition|recapitalization|jv_formation|refinancing|development|sale_leaseback|portfolio_trade — promote to reference product]. Valid values are `acquisition|disposition|recapitalization|jv_formation|refinancing|development`',
    `hold_period_years` DECIMAL(18,2) COMMENT 'Projected investment hold period in years as assumed in the underwriting model (e.g., 5.00, 7.50, 10.00). Drives IRR calculation and exit strategy planning in Argus Enterprise DCF models.',
    `ic_approving_members` STRING COMMENT 'Comma-separated list of IC member names or IDs who voted to approve the deal. Captured for governance audit trail and SOX compliance. Stored as a structured string; full member details reside in the workforce domain.',
    `ic_conditions_of_approval` STRING COMMENT 'Free-text description of any conditions, covenants, or requirements attached to the ICs conditional approval (e.g., Subject to satisfactory Phase I ESG environmental review, Requires lender commitment letter at ≤65% LTV). Null if unconditional approval or not yet decided.',
    `ic_decision` STRING COMMENT 'Formal decision rendered by the Investment Committee (IC): approved (unconditional go-ahead), rejected (deal declined), conditional_approval (approved subject to conditions), deferred (decision postponed pending additional information), withdrawn (deal pulled before IC vote).. Valid values are `approved|rejected|conditional_approval|deferred|withdrawn`',
    `ic_decision_date` DATE COMMENT 'Date the Investment Committee (IC) rendered its formal decision (approve, reject, or conditional approval) on the deal. Essential for IC governance audit trail and regulatory compliance.',
    `ic_key_risks` STRING COMMENT 'Free-text summary of key investment risks identified in the IC memo (e.g., lease rollover risk, market vacancy trends, environmental exposure, construction cost overruns). Supports IC governance documentation and post-investment risk monitoring.',
    `ic_recommendation` STRING COMMENT 'AM teams formal recommendation to the IC as stated in the IC memo: recommend (team supports proceeding), do_not_recommend (team advises against), conditional_recommend (team supports subject to conditions). Distinct from the ICs actual decision.. Valid values are `recommend|do_not_recommend|conditional_recommend`',
    `ic_submission_date` DATE COMMENT 'Date the IC memo was formally submitted to the Investment Committee (IC) for review. Marks the start of the IC governance process. Critical for IC audit trail and governance compliance.',
    `is_off_market` BOOLEAN COMMENT 'Indicates whether the deal was sourced through proprietary off-market channels (True) rather than publicly marketed processes such as MLS, broker campaigns, or auctions (False). Key metric for sourcing strategy and competitive advantage analytics.',
    `loi_date` DATE COMMENT 'Date the Letter of Intent (LOI) was submitted or executed with the counterparty. Marks the transition from initial sourcing to formal deal pursuit. Key milestone in the investment pipeline lifecycle.',
    `notes` STRING COMMENT 'General free-text notes and commentary on the deal, including negotiation context, counterparty background, market observations, or deal-specific considerations not captured in structured fields. Sourced from Salesforce CRM deal pipeline notes.',
    `projected_close_date` DATE COMMENT 'Anticipated closing date for the transaction as projected during underwriting or per the PSA. Used for capital deployment forecasting, fund cash flow planning, and pipeline reporting.',
    `source_system_ref` STRING COMMENT 'Identifier of the originating system record for this deal (e.g., Salesforce CRM Opportunity ID, MRI Software deal reference). Enables lineage tracing and reconciliation between the lakehouse Silver Layer and operational systems of record.',
    `sourced_date` DATE COMMENT 'Date the investment opportunity was first identified and entered into the deal pipeline. Represents the business event timestamp for deal origination. Used to measure pipeline velocity and sourcing lead times.',
    `stage` STRING COMMENT 'Current stage of the deal in the investment pipeline lifecycle: sourced (initial identification), loi (Letter of Intent submitted), due_diligence (active investigation), ic_review (Investment Committee review), under_contract (PSA executed), closed (transaction completed), dead (deal terminated). Drives pipeline reporting and IC governance audit trail. [ENUM-REF-CANDIDATE: sourced|loi|due_diligence|ic_review|under_contract|closed|dead — 7 candidates stripped; promote to reference product]',
    `target_cap_rate` DECIMAL(18,2) COMMENT 'Underwritten going-in Capitalization Rate (CAP Rate) expressed as a decimal (e.g., 0.0550 = 5.50%). Calculated as Net Operating Income (NOI) divided by purchase price. Key return metric for acquisition underwriting and IC memo.',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Underwritten equity multiple (total distributions / total equity invested) over the projected hold period. Complements IRR as a return metric in IC memos (e.g., 1.85x means $1.85 returned per $1.00 invested).',
    `target_irr` DECIMAL(18,2) COMMENT 'Underwritten levered Internal Rate of Return (IRR) expressed as a decimal (e.g., 0.1200 = 12.00%). Represents the projected annualized return on equity over the hold period. Primary return hurdle metric evaluated by the Investment Committee (IC).',
    `underwritten_debt_amount` DECIMAL(18,2) COMMENT 'Total debt financing assumed in the underwriting model for this deal. Represents the debt portion of the capital stack. Used to calculate Loan-to-Value Ratio (LTV) and Debt Service Coverage Ratio (DSCR) in IC analysis.',
    `underwritten_equity_amount` DECIMAL(18,2) COMMENT 'Total equity capital required for the deal as underwritten in the IC memo. Represents the equity portion of the capital stack (total deal cost minus debt). Drives capital call planning and fund commitment tracking.',
    `underwritten_ltv` DECIMAL(18,2) COMMENT 'Underwritten Loan-to-Value Ratio (LTV) expressed as a decimal (e.g., 0.6500 = 65%). Calculated as underwritten debt divided by underwritten value. Key leverage metric reviewed by the IC and lenders.',
    `underwritten_noi` DECIMAL(18,2) COMMENT 'Stabilized Net Operating Income (NOI) as projected in the underwriting model. Represents effective gross income minus operating expenses, excluding debt service and capital expenditures. Foundation of CAP rate and DCF valuation.',
    `underwritten_value` DECIMAL(18,2) COMMENT 'Internal valuation of the asset as determined by the Asset Managers (AM) underwriting model (typically a Discounted Cash Flow (DCF) or direct capitalization approach in Argus Enterprise). Represents the AMs view of intrinsic value, distinct from asking price.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this investment deal pipeline record was last modified. Supports change data capture (CDC) in the Databricks Lakehouse Silver Layer and audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_investment_deal PRIMARY KEY(`investment_deal_id`)
) COMMENT 'Tracks prospective investment opportunities from initial sourcing through IC approval and closing or rejection. Captures deal name, deal type (acquisition, disposition, recapitalization, JV formation), property type, market/submarket, asking price, underwritten value, target CAP rate, target IRR, deal stage (sourced, LOI, due diligence, IC review, under contract, closed, dead), deal source (broker, off-market, auction), assigned AM, LOI date, contract date, projected close date, IC memo details (recommendation, underwritten equity/debt, key risks, conditions of approval, IC decision, approving members, approval date), and deal status. SSOT for the investment pipeline and IC governance audit trail.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`ic_memo` (
    `ic_memo_id` BIGINT COMMENT 'Primary key for ic_memo',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Investment committee memos for acquisitions and dispositions must reference the third-party appraisal supporting the underwritten value. IC governance and lender requirements mandate this link as part',
    `asset_id` BIGINT COMMENT 'Reference to the subject property or asset under consideration in this IC memo. May be null for portfolio-level or fund-level capital events.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the investment deal or transaction for which this IC memo was prepared. Links the memo to the specific acquisition, disposition, or capital event under review.',
    `cap_rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to valuation.cap_rate_benchmark. Business justification: IC memos must cite the market cap rate benchmark supporting the underwritten_cap_rate assumption. IC governance requires referencing the specific survey/benchmark used — a standard investment committe',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: IC memos reference compliance assessments (environmental, ESG, ADA) as part of acquisition due diligence. The ic_memo.esg_assessment_summary field indicates this relationship exists; a proper FK suppo',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: IC memo currency used in capitalization table, underwritten IRR/NPV calculations, and requested equity/debt amounts — required for multi-currency IC approval process and deal economics presentation.',
    `dcf_model_id` BIGINT COMMENT 'Foreign key linking to valuation.valuation_dcf_model. Business justification: IC memos include the DCF/Argus model as primary supporting analysis for underwritten IRR and equity multiple. argus_model_reference is a denormalized text reference to the structured DCF model record.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle (REIT, partnership, CMBS/RMBS) associated with this IC memo. Identifies which funds capital is being deployed or returned.',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: An IC memo is the formal Investment Committee approval document for a specific investment deal in the pipeline. A deal can have multiple IC memos (initial submission, revised terms, final approval). i',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: IC memos specify the acquiring legal entity for structuring, tax classification, REIT qualification, and regulatory filing decisions. Real estate investment committees always identify the holding enti',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: IC memo investment strategy maps to market_segment for IC mandate compliance review, strategy-level return benchmarking, and investment committee approval framework application.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: IC memo preparation is a named investment process: the analyst/associate who authored the memo is tracked for deal accountability, performance reviews, and regulatory audit trails. ic_memo has plain-t',
    `proforma_id` BIGINT COMMENT 'Foreign key linking to development.proforma. Business justification: The proforma is the primary financial exhibit reviewed and approved by the investment committee. IC memos cite specific proforma versions for underwritten IRR, equity multiple, and cap rate. Every rea',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: IC memo asset class maps to property type for investment committee mandate compliance review, sector allocation approval, and IC decision tracking by property type sector.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IC memos include regulatory approval requirements as conditions of approval (ic_memo.regulatory_approval_required flag). Linking IC memos to specific regulatory obligations supports deal approval work',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to insurance.risk_assessment. Business justification: IC memos for real estate acquisitions include insurance risk assessment findings as a required due diligence section. The memo must reference the specific risk assessment report to document insurabili',
    `approving_members` STRING COMMENT 'Comma-separated list or narrative identifying the Investment Committee members who voted to approve or conditionally approve the memo. Supports governance audit trail and signatory accountability.',
    `conditions_of_approval` STRING COMMENT 'Narrative description of any conditions, stipulations, or requirements imposed by the IC as part of a conditional approval decision. Null if the decision was an unconditional approval or rejection.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this IC memo record was first created in the system. Supports audit trail and data lineage tracking.',
    `decision_date` DATE COMMENT 'The date on which the final IC decision was formally recorded and communicated. May differ from ic_meeting_date if the decision was deferred or required additional deliberation.',
    `dissenting_members` STRING COMMENT 'Comma-separated list or narrative identifying IC members who voted against the recommendation. Captures minority dissent for governance records and audit trail.',
    `docusign_envelope_reference` STRING COMMENT 'Reference identifier for the DocuSign CLM envelope associated with the executed IC memo and approval signatures. Enables traceability to the digital signature record.',
    `esg_assessment_summary` STRING COMMENT 'Narrative summary of the ESG assessment for the proposed investment, including LEED/BREEAM certification status, environmental risks, social impact considerations, and governance factors as presented to the IC.',
    `hold_period_years` DECIMAL(18,2) COMMENT 'The projected investment hold period in years as presented in the IC memo underwriting model. Used to contextualize IRR and equity multiple projections.',
    `ic_decision` STRING COMMENT 'The formal decision rendered by the Investment Committee following deliberation. Captures the committees actual vote outcome, which may differ from the deal teams recommendation.. Valid values are `approved|rejected|approved_with_conditions|deferred|tabled|no_quorum`',
    `ic_meeting_date` DATE COMMENT 'The date on which the Investment Committee convened to review and vote on this memo. Used for governance audit trails and regulatory reporting.',
    `is_final_approval` BOOLEAN COMMENT 'Indicates whether the IC decision represents a final, binding approval for the investment action. False if the decision is conditional, deferred, or pending further review.',
    `key_risks` STRING COMMENT 'Narrative description of the principal investment risks identified by the deal team and presented to the IC (e.g., lease rollover risk, market vacancy, construction cost overruns, interest rate exposure, environmental liability). Supports governance and audit trail.',
    `lp_approval_required` BOOLEAN COMMENT 'Indicates whether the proposed investment action requires approval from Limited Partners (LPs) in addition to the IC, per the funds Limited Partnership Agreement (LPA) or side letter provisions.',
    `memo_date` DATE COMMENT 'The date on which the IC memo was formally prepared and submitted for committee review. Represents the principal business event date for this document.',
    `memo_expiry_date` DATE COMMENT 'The date after which the IC approval is no longer valid and a new memo must be submitted. Reflects the time-limited nature of IC approvals, particularly for acquisitions subject to market changes.',
    `memo_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to this IC memo for tracking and audit purposes (e.g., IC-2024-00123). Used in correspondence, governance records, and regulatory filings.. Valid values are `^IC-[0-9]{4}-[0-9]{5}$`',
    `memo_status` STRING COMMENT 'Current lifecycle status of the IC memo within the governance workflow. Tracks progression from initial drafting through committee decision. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|approved_with_conditions|withdrawn — promote to reference product]',
    `memo_title` STRING COMMENT 'Descriptive title of the IC memo summarizing the investment action under review (e.g., Acquisition of 123 Main Street Office Tower — Series B Fund). Used for identification and reporting.',
    `memo_type` STRING COMMENT 'Classification of the investment action being reviewed by the IC. Distinguishes between acquisitions, dispositions, refinancings, recapitalizations, major capital expenditure approvals, development commitments, joint ventures, and fund formations. [ENUM-REF-CANDIDATE: acquisition|disposition|refinancing|recapitalization|capital_expenditure|development|joint_venture|fund_formation — promote to reference product]',
    `memo_version` STRING COMMENT 'Version identifier of the IC memo document (e.g., v1.0, v2.1). Tracks revisions submitted to the IC, particularly when memos are revised following initial deferral or conditional approval.. Valid values are `^v[0-9]+.[0-9]+$`',
    `recommendation_type` STRING COMMENT 'The formal recommendation made by the deal team or investment manager in the memo (approve, reject, approve with conditions, defer, or table). Distinct from the final IC decision, which reflects the committees actual vote.. Valid values are `approve|reject|approve_with_conditions|defer|table`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the proposed investment action requires external regulatory approval (e.g., SEC filing, HUD approval, environmental clearance, zoning entitlement) prior to execution.',
    `requested_debt_amount` DECIMAL(18,2) COMMENT 'The total debt financing requested or proposed in this IC memo, expressed in the funds base currency. Represents the leverage component of the proposed investments capital structure.',
    `requested_equity_amount` DECIMAL(18,2) COMMENT 'The total equity capital requested for approval in this IC memo, expressed in the funds base currency. Represents the equity component of the proposed investments capital structure.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the senior investment professional (e.g., Portfolio Manager, Asset Manager) who reviewed and endorsed the IC memo prior to committee submission.',
    `sensitivity_analysis_summary` STRING COMMENT 'Narrative or structured summary of the sensitivity analysis performed on key underwriting assumptions (e.g., exit cap rate, rent growth, vacancy). Supports IC deliberation on downside scenarios.',
    `total_capitalization` DECIMAL(18,2) COMMENT 'The total proposed investment capitalization (equity plus debt) as presented in the IC memo. Represents the gross deal size for the proposed transaction.',
    `underwritten_cap_rate` DECIMAL(18,2) COMMENT 'The going-in Capitalization Rate (CAP Rate) used in the underwriting model, expressed as a decimal (e.g., 0.0550 = 5.50%). Represents the ratio of Net Operating Income (NOI) to purchase price as presented to the IC.',
    `underwritten_equity_multiple` DECIMAL(18,2) COMMENT 'The projected equity multiple (total equity returned divided by equity invested) as underwritten by the deal team. Expressed as a factor (e.g., 1.85 = 1.85x). Complements IRR as a return metric in IC deliberations.',
    `underwritten_irr` DECIMAL(18,2) COMMENT 'The projected Internal Rate of Return (IRR) as underwritten by the deal team and presented in the IC memo. Expressed as a decimal (e.g., 0.1250 = 12.50%). Key return metric used by the IC to evaluate investment attractiveness.',
    `underwritten_noi` DECIMAL(18,2) COMMENT 'The stabilized Net Operating Income (NOI) as underwritten by the deal team and presented in the IC memo. Expressed in the funds base currency on an annual basis. Core income metric for real estate investment analysis.',
    `underwritten_npv` DECIMAL(18,2) COMMENT 'The Net Present Value (NPV) of the proposed investment as calculated in the underwriting model and presented in the IC memo. Expressed in the funds base currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this IC memo record was last modified in the system. Supports audit trail, change tracking, and data lineage.',
    `vote_count_abstain` STRING COMMENT 'Number of Investment Committee members who abstained from voting. Completes the full voting record for governance and audit purposes.',
    `vote_count_against` STRING COMMENT 'Number of Investment Committee members who voted against the recommendation. Used alongside vote_count_for to document the full voting record.',
    `vote_count_for` STRING COMMENT 'Number of Investment Committee members who voted in favor of the recommendation. Used to determine quorum and majority thresholds for governance reporting.',
    CONSTRAINT pk_ic_memo PRIMARY KEY(`ic_memo_id`)
) COMMENT 'Records Investment Committee (IC) approval memos and decisions for proposed investments, dispositions, and major capital events. Captures memo date, deal reference, recommendation type (approve, reject, approve with conditions), requested equity, requested debt, underwritten IRR, underwritten equity multiple, key risks identified, conditions of approval, IC meeting date, IC decision, approving members, and final approval status. Supports governance and audit trail for investment decisions.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`waterfall` (
    `waterfall_id` BIGINT COMMENT 'Primary key for waterfall',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Waterfall structure approval by a named senior employee (CFO, Managing Director) is required for LPA compliance and LP audit trails. Real estate fund GPs must document who authorized distribution wate',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Waterfall currency drives tier threshold calculations, preferred return accrual, and carried interest distribution modeling — required for accurate waterfall computation and LP/GP distribution reporti',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle to which this waterfall structure applies. Links to the fund master record.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to investment.vehicle. Business justification: Waterfall structures are defined in the Limited Partnership Agreement (LPA) of a specific investment vehicle, not just at the fund level. A fund may have multiple vehicles (parallel funds, co-investme',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Waterfall structures are legally bound to specific fund entities governing distribution calculations, LP reporting, and tax treatment. Real estate fund counsel and accountants always tie a waterfall s',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Waterfall structures must comply with regulatory obligations (ERISA distribution rules, tax regulations on carried interest, SEC disclosure requirements). Linking waterfall structures to regulatory ob',
    `amendment_number` STRING COMMENT 'The amendment sequence number of the Limited Partnership Agreement (LPA) from which this waterfall structure is derived. Zero indicates the original LPA; positive integers indicate subsequent amendments. Supports version tracking of waterfall terms.',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'The GPs share of profits (carried interest or carry) expressed as a decimal, applied after LPs have received their preferred return and the GP catch-up is satisfied. Industry standard is typically 0.20 (20%). A key economic term in the LPA.',
    `clawback_lookback_years` STRING COMMENT 'The number of years over which the GP clawback obligation is calculated. Defines the lookback window for assessing whether the GP has received excess carried interest relative to the funds overall performance. Null if has_clawback is False.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this waterfall structure record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `distribution_frequency` STRING COMMENT 'The frequency at which waterfall distributions are calculated and paid to LPs and the GP. Upon_realization is common for closed-end real estate funds where distributions occur at asset disposition.. Valid values are `monthly|quarterly|semi_annual|annual|upon_realization|at_fund_wind_down`',
    `effective_date` DATE COMMENT 'Date from which this waterfall structure becomes operative and governs cash flow distributions. Aligns with the fund closing date or amendment effective date as stated in the Limited Partnership Agreement (LPA).',
    `equity_multiple_hurdle` DECIMAL(18,2) COMMENT 'The minimum equity multiple (total distributions / invested capital) that LPs must achieve before the GP is entitled to carried interest. Used in equity-multiple-based waterfall structures as an alternative or supplement to IRR hurdles.',
    `expiry_date` DATE COMMENT 'Date on which this waterfall structure ceases to be operative, typically coinciding with fund termination or replacement by an amended structure. Null for open-ended structures.',
    `gp_catch_up_rate` DECIMAL(18,2) COMMENT 'The percentage of distributions allocated to the GP during the catch-up tier, expressed as a decimal, until the GP has received its proportionate share of total profits. For example, 1.0 represents a 100% GP catch-up. Zero indicates no catch-up provision.',
    `has_clawback` BOOLEAN COMMENT 'Indicates whether the waterfall structure includes a GP clawback provision (True), requiring the GP to return previously distributed carried interest if cumulative LP returns fall below the preferred return threshold at fund wind-down.',
    `irr_hurdle_rate` DECIMAL(18,2) COMMENT 'The minimum IRR threshold that must be achieved before the GP is entitled to carried interest, expressed as a decimal. Distinct from the preferred return rate — used in IRR-based waterfall structures common in value-add and opportunistic real estate funds.',
    `is_recycling_permitted` BOOLEAN COMMENT 'Indicates whether the fund permits recycling of returned capital (True), meaning distributions from early investments can be recalled for new investments before being counted toward the LP preferred return threshold. Affects waterfall calculation timing.',
    `lp_carried_interest_rate` DECIMAL(18,2) COMMENT 'The LPs share of residual profits after the GP carried interest is applied, expressed as a decimal. Typically the complement of carried_interest_rate (e.g., 0.80 when GP carry is 0.20). Stored explicitly to support multi-class LP structures.',
    `lpa_reference` STRING COMMENT 'The document reference number or section citation from the Limited Partnership Agreement (LPA) that governs this waterfall structure. Enables traceability from the data model back to the controlling legal document.',
    `management_fee_offset_rate` DECIMAL(18,2) COMMENT 'The percentage of management fees paid by portfolio companies or co-investors that offset the management fee charged to the fund, expressed as a decimal. For example, 0.80 means 80% of such fees reduce the LP management fee obligation.',
    `preferred_return_basis` STRING COMMENT 'Specifies how the preferred return accrues: cumulative (unpaid preferred return carries forward), non_cumulative (unpaid preferred return does not carry forward), or cumulative_compounded (unpaid preferred return compounds over time).. Valid values are `cumulative|non_cumulative|cumulative_compounded`',
    `preferred_return_rate` DECIMAL(18,2) COMMENT 'The annualized preferred return (hurdle rate) expressed as a decimal that Limited Partners (LPs) must receive before the General Partner (GP) is entitled to carried interest. For example, 0.08 represents an 8% preferred return. A core economic term in the Limited Partnership Agreement (LPA).',
    `return_of_capital_first` BOOLEAN COMMENT 'Indicates whether the waterfall requires full return of LP invested capital (and management fees/expenses) before any preferred return distributions are made. True is standard for most institutional fund structures.',
    `source_system_ref` STRING COMMENT 'The unique identifier of this waterfall structure record in the originating source system (MRI Software). Enables lineage tracing and reconciliation between the lakehouse silver layer and the operational system of record.',
    `structure_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this waterfall structure, as referenced in fund legal documents and MRI Software. Used for cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `structure_name` STRING COMMENT 'Human-readable name describing this waterfall distribution structure, typically derived from the fund legal agreement (e.g., Fund III American Waterfall — Class A).',
    `tier1_gp_split_rate` DECIMAL(18,2) COMMENT 'The GPs proportionate share of distributions within Tier 1, expressed as a decimal (e.g., 0.0 for 0% GP in a return-of-capital tier). Must sum to 1.0 with tier1_lp_split_rate.',
    `tier1_label` STRING COMMENT 'Descriptive label for the first distribution tier (e.g., Return of Capital, Preferred Return). Used in investor reporting and distribution notices.',
    `tier1_lp_split_rate` DECIMAL(18,2) COMMENT 'The LPs proportionate share of distributions within Tier 1, expressed as a decimal (e.g., 1.0 for 100% LP in a return-of-capital tier).',
    `tier1_threshold_amount` DECIMAL(18,2) COMMENT 'The cumulative distribution threshold amount (in fund currency) that must be reached before distributions cascade to Tier 2. For return-of-capital tiers, this equals total LP committed capital plus recallable amounts.',
    `tier2_gp_split_rate` DECIMAL(18,2) COMMENT 'The GPs proportionate share of distributions within Tier 2, expressed as a decimal. Must sum to 1.0 with tier2_lp_split_rate.',
    `tier2_label` STRING COMMENT 'Descriptive label for the second distribution tier (e.g., Preferred Return / Hurdle, Accrued Preferred Return). Used in investor reporting.',
    `tier2_lp_split_rate` DECIMAL(18,2) COMMENT 'The LPs proportionate share of distributions within Tier 2, expressed as a decimal.',
    `tier2_threshold_amount` DECIMAL(18,2) COMMENT 'The cumulative distribution threshold amount (in fund currency) that must be reached before distributions cascade to Tier 3. For preferred return tiers, this equals LP capital plus accrued preferred return.',
    `tier3_gp_split_rate` DECIMAL(18,2) COMMENT 'The GPs proportionate share of distributions within Tier 3, expressed as a decimal (e.g., 1.0 for 100% GP during a full catch-up tier). Must sum to 1.0 with tier3_lp_split_rate.',
    `tier3_label` STRING COMMENT 'Descriptive label for the third distribution tier (e.g., GP Catch-Up, Catch-Up Allocation). Used in investor reporting.',
    `tier3_lp_split_rate` DECIMAL(18,2) COMMENT 'The LPs proportionate share of distributions within Tier 3, expressed as a decimal (e.g., 0.0 for 0% LP during a full GP catch-up tier).',
    `tier3_threshold_amount` DECIMAL(18,2) COMMENT 'The cumulative distribution threshold amount (in fund currency) that must be reached before distributions cascade to Tier 4. For GP catch-up tiers, this equals the amount at which the GP has received its full proportionate share of profits.',
    `tier4_gp_split_rate` DECIMAL(18,2) COMMENT 'The GPs proportionate share of residual distributions within Tier 4 (the carried interest tier), expressed as a decimal (e.g., 0.20 for an 80/20 split). Must sum to 1.0 with tier4_lp_split_rate.',
    `tier4_label` STRING COMMENT 'Descriptive label for the fourth (residual) distribution tier (e.g., Residual Profit Split, Carried Interest Tier). Used in investor reporting.',
    `tier4_lp_split_rate` DECIMAL(18,2) COMMENT 'The LPs proportionate share of residual distributions within Tier 4 (the carried interest tier), expressed as a decimal (e.g., 0.80 for an 80/20 split).',
    `tier_count` STRING COMMENT 'Total number of distribution tiers defined in this waterfall structure (e.g., 4 tiers: return of capital, preferred return, GP catch-up, residual split). Drives validation of the waterfall_tier child records.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this waterfall structure record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, audit compliance, and incremental data loading in the Databricks lakehouse.',
    `waterfall_status` STRING COMMENT 'Current lifecycle state of this waterfall structure. Active indicates it governs current distributions; superseded indicates it has been replaced by a newer version; draft indicates it is under review; terminated indicates the fund has wound down.. Valid values are `active|superseded|draft|terminated|pending_approval`',
    `waterfall_type` STRING COMMENT 'Specifies whether the waterfall follows an American (deal-by-deal) or European (whole-fund) distribution model. American waterfalls allow GP carried interest after each deal; European waterfalls require full LP capital return before GP carry.. Valid values are `American|European`',
    CONSTRAINT pk_waterfall PRIMARY KEY(`waterfall_id`)
) COMMENT 'Defines the economic waterfall and profit-sharing structure for a fund or investment vehicle — the rules governing how cash flows are split between LP investors and the GP. Captures waterfall type (American, European), preferred return (hurdle rate), GP catch-up percentage, carried interest rate, clawback provision flag, distribution tiers (tier 1 through N), tier threshold amounts, LP split per tier, GP split per tier, and effective date. Sourced from fund legal documents and MRI Software.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`capital_account` (
    `capital_account_id` BIGINT COMMENT 'Primary key for capital_account',
    `commitment_id` BIGINT COMMENT 'Reference to the investors capital commitment agreement within the fund, linking this statement to the specific subscription or limited partnership agreement.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Capital account currency drives investor statement generation, K-1 tax reporting, and multi-currency NAV per unit calculations — a core fund administration and investor reporting process.',
    `financial_period_close_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period_close. Business justification: Investor capital account statements are issued only after the financial period close is completed and signed off. Period close status gates statement issuance for LP reporting, K-1 preparation, and au',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund (REIT, partnership, or private equity vehicle) to which this capital account statement belongs.',
    `investor_id` BIGINT COMMENT 'Reference to the limited partner or investor entity whose capital account position is summarized in this statement.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Capital account statements (K-1s, investor statements) are tied to regulatory filings (tax filings, SEC reports, FATCA/CRS). Linking capital accounts to regulatory filings supports investor tax report',
    `nav_calculation_id` BIGINT COMMENT 'Foreign key linking to valuation.nav_calculation. Business justification: Investor capital account statements report nav_per_unit sourced from the formal NAV calculation. LP quarterly statements and K-1 preparation require tracing the NAV per unit to the specific calculatio',
    `waterfall_id` BIGINT COMMENT 'Foreign key linking to investment.waterfall. Business justification: Investor capital account statements are calculated according to the applicable waterfall structure — the preferred return accrual, carried interest allocation, and profit splits all derive from the wa',
    `allocated_income_loss` DECIMAL(18,2) COMMENT 'Net income or loss allocated to this investors capital account during the period per the funds partnership agreement waterfall and allocation methodology. Positive values represent income allocation; negative values represent loss allocation.',
    `beginning_capital_balance` DECIMAL(18,2) COMMENT 'Investors capital account balance at the start of the statement period, equal to the ending balance of the immediately preceding period. Serves as the opening balance for the periods capital account roll-forward reconciliation.',
    `capital_contributions` DECIMAL(18,2) COMMENT 'Total capital contributed by the investor during the statement period in response to capital calls. Includes funded amounts from all capital calls settled within the period. Increases the capital account balance.',
    `capital_distributions` DECIMAL(18,2) COMMENT 'Total distributions returned to the investor during the statement period, including return of capital, realized gains, and income distributions. Decreases the capital account balance. Reported as a positive number representing cash out to the investor.',
    `carried_interest_allocated` DECIMAL(18,2) COMMENT 'Performance-based carried interest (carry) allocated to the general partner and charged against this investors capital account during the period, per the funds waterfall provisions. Typically triggered after the preferred return hurdle is met.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capital account statement record was first created in the data platform. Supports audit trail, data lineage, and SOX financial controls compliance.',
    `cumulative_contributions` DECIMAL(18,2) COMMENT 'Total capital contributed by the investor from fund inception through the end of the statement period. Used for IRR calculation, return-of-capital tracking, and ILPA transparency reporting.',
    `cumulative_distributions` DECIMAL(18,2) COMMENT 'Total distributions returned to the investor from fund inception through the end of the statement period. Used for DPI (Distributions to Paid-In) multiple calculation and ILPA transparency reporting.',
    `dpi` DECIMAL(18,2) COMMENT 'Distributions to Paid-In (DPI) multiple for this investor from inception through the statement period end date. Calculated as cumulative_distributions / cumulative_contributions. Measures the realized return multiple relative to invested capital.',
    `ending_capital_balance` DECIMAL(18,2) COMMENT 'Investors capital account balance at the close of the statement period. Calculated as: beginning_capital_balance + capital_contributions - capital_distributions + allocated_income_loss - management_fees_charged - carried_interest_allocated - other_fees_charged. This is the SSOT for the investors fund position at period end.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter number (1–4) within the fiscal year for this statement period. Supports quarterly LP reporting packages and quarterly performance attribution analysis.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which this statement period falls (e.g., 2024). Used for annual rollup reporting, tax K-1 preparation, and year-over-year performance comparison.',
    `inception_to_date_irr` DECIMAL(18,2) COMMENT 'Cumulative Internal Rate of Return (IRR) for this investors capital account from fund inception through the statement period end date, expressed as a decimal (e.g., 0.142500 = 14.25%). Calculated using the XIRR methodology on all cash flows. Primary performance metric for LP reporting.',
    `is_tax_exempt_investor` BOOLEAN COMMENT 'Indicates whether the investor is a tax-exempt entity (e.g., pension fund, endowment, foundation, ERISA plan) for purposes of UBTI (Unrelated Business Taxable Income) tracking and tax reporting. True = tax-exempt; False = taxable investor.',
    `management_fees_charged` DECIMAL(18,2) COMMENT 'Asset management fees charged to this investors capital account during the period, calculated per the funds management fee schedule (typically expressed as a percentage of committed or invested capital). Reduces the capital account balance.',
    `moic` DECIMAL(18,2) COMMENT 'Multiple on Invested Capital (MOIC) for this investor from inception through the statement period end date. Calculated as (ending_capital_balance + cumulative_distributions) / cumulative_contributions. Measures total value creation relative to invested capital.',
    `nav_per_unit` DECIMAL(18,2) COMMENT 'Net Asset Value per fund unit or interest as of the statement period end date, used to value the investors position. Derived from the funds total NAV divided by total units outstanding. Supports investor-level NAV attribution.',
    `notes` STRING COMMENT 'Free-text field for asset manager or fund administrator annotations regarding this capital account statement, such as restatement explanations, special allocation notes, or investor-specific adjustments.',
    `other_fees_charged` DECIMAL(18,2) COMMENT 'Miscellaneous fees charged to the investors capital account during the period not captured in management fees or carried interest, such as fund administration fees, audit fees, legal fees, or organizational expense allocations.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Investors percentage ownership interest in the fund as of the statement period end date, expressed as a decimal (e.g., 0.125000 = 12.5%). Used for income/loss allocation, voting rights, and NAV attribution calculations.',
    `period_type` STRING COMMENT 'Frequency classification of the reporting period for this capital account statement. Determines the cadence of LP reporting obligations and aligns with fund governing document requirements.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `preferred_return_accrued` DECIMAL(18,2) COMMENT 'Cumulative preferred return accrued but not yet distributed to the investor from fund inception through the statement period end date. Represents the outstanding preferred return obligation owed to the LP before carried interest can be earned.',
    `preferred_return_rate` DECIMAL(18,2) COMMENT 'Annual preferred return (hurdle rate) percentage applicable to this investors capital account per the funds limited partnership agreement (e.g., 0.0800 = 8.00%). Determines the threshold above which carried interest is charged to the investor.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Investors pro-rata share of realized gains or losses from asset dispositions completed during the statement period. Represents the difference between net sale proceeds and cost basis allocated to this investor.',
    `rvpi` DECIMAL(18,2) COMMENT 'Residual Value to Paid-In (RVPI) multiple for this investor as of the statement period end date. Calculated as ending_capital_balance / cumulative_contributions. Measures the unrealized value remaining relative to invested capital.',
    `source_system_ref` STRING COMMENT 'Identifier or reference code from the originating system of record (e.g., MRI Software or Argus Enterprise) for this capital account statement record. Supports data lineage, reconciliation, and audit traceability back to the operational system.',
    `statement_issue_date` DATE COMMENT 'Calendar date on which this capital account statement was formally issued and made available to the investor. Used for ILPA compliance tracking and investor communication audit trails.',
    `statement_number` STRING COMMENT 'Externally-visible, human-readable identifier for this capital account statement, typically formatted as FUND-INVESTOR-PERIOD (e.g., FUND001-LP042-2024Q4). Used in LP reporting packages and investor communications.',
    `statement_period_end_date` DATE COMMENT 'Last calendar date of the reporting period covered by this capital account statement (e.g., 2024-03-31 for Q1 2024). Defines the end of the measurement window and the valuation date for ending balance calculations.',
    `statement_period_start_date` DATE COMMENT 'First calendar date of the reporting period covered by this capital account statement (e.g., 2024-01-01 for Q1 2024). Defines the beginning of the measurement window for all period activity fields.',
    `statement_status` STRING COMMENT 'Current lifecycle state of the capital account statement. Draft indicates in-preparation; preliminary indicates unaudited release; final indicates audited and approved; restated indicates a corrected reissuance; superseded indicates replaced by a newer version.. Valid values are `draft|preliminary|final|restated|superseded`',
    `tax_basis_adjustment` DECIMAL(18,2) COMMENT 'Cumulative tax basis adjustment to the investors capital account from inception through the statement period end date, reflecting differences between GAAP book basis and tax basis (e.g., depreciation timing differences, Section 754 elections). Supports K-1 preparation.',
    `total_commitment_amount` DECIMAL(18,2) COMMENT 'Investors total committed capital to the fund as stated in the limited partnership agreement or subscription agreement. Represents the maximum capital obligation of the investor regardless of how much has been called.',
    `uncalled_commitment_amount` DECIMAL(18,2) COMMENT 'Remaining capital commitment not yet called by the fund as of the statement period end date. Calculated as total_commitment_amount minus cumulative_contributions. Represents the investors remaining unfunded obligation (dry powder).',
    `units_held` DECIMAL(18,2) COMMENT 'Number of fund units, interests, or shares held by the investor as of the statement period end date. Used in conjunction with nav_per_unit to calculate the investors total NAV position.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Investors pro-rata share of unrealized appreciation or depreciation in the funds portfolio as of the statement period end date, based on current fair market valuations versus cost basis. Positive values indicate unrealized gain; negative values indicate unrealized loss.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capital account statement record was last modified in the data platform. Tracks restatements, corrections, and preliminary-to-final transitions for audit and SOX compliance purposes.',
    CONSTRAINT pk_capital_account PRIMARY KEY(`capital_account_id`)
) COMMENT 'Periodic investor capital account statement summarizing each investors position in a fund. Captures statement period, beginning capital account balance, capital contributions in period, distributions in period, allocated income/loss, management fees charged, carried interest allocated, ending capital account balance, ownership percentage, unrealized gain/loss, and cumulative IRR since inception. Supports LP reporting obligations and ILPA transparency standards. SSOT for investor-level fund position reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`fee_structure` (
    `fee_structure_id` BIGINT COMMENT 'Primary key for fee_structure',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fee schedule approval by a named employee is required for LPA compliance, investor side-letter management, and SEC fee disclosure. Real estate fund managers must document who authorized fee terms. fee',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Management fees and carried interest must post to specific GL accounts for fee accrual, payment processing, and LP reporting. Real estate fund accountants require COA mapping on fee schedules to autom',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fee expenses (management fees, admin fees) are tracked against cost centers for fund-level P&L and NOI reporting. Real estate fund controllers require cost center coding on fee schedules for accurate ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Fee schedule currency drives fee cap calculations, minimum fee thresholds, and management fee invoicing — required for accurate fee billing and LP fee disclosure reporting.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund or vehicle to which this fee structure applies. Links the fee schedule to the parent fund entity.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fee structures are subject to regulatory obligations (SEC fee disclosure rules, MiFID II, investment adviser regulations, Form ADV). Linking fee schedules to regulatory obligations supports regulatory',
    `amendment_version` STRING COMMENT 'Version identifier for this fee schedule, incremented each time the fee terms are amended (e.g., v1.0, v2.0). Enables tracking of fee schedule history and supersession across fund lifecycle.. Valid values are `^v[0-9]+.[0-9]+$`',
    `approval_date` DATE COMMENT 'The date on which the fee schedule was formally approved by the authorized approver. Supports SOX audit trail and regulatory compliance documentation.',
    `approval_status` STRING COMMENT 'Workflow approval state of the fee schedule record, tracking whether it has been reviewed and approved by authorized personnel (e.g., Fund Controller, Compliance Officer) before becoming effective.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized individual (e.g., Fund Controller, CFO) who approved this fee schedule for use. Supports SOX internal control documentation and audit trail.',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'The percentage of profits above the hurdle rate that the general partner retains as performance compensation (carry/promote). Expressed as a decimal fraction (e.g., 0.20 = 20% carry). Applicable only to performance fee types.',
    `catch_up_rate` DECIMAL(18,2) COMMENT 'The rate at which the general partner receives distributions during the catch-up phase of the waterfall, after the preferred return hurdle is met and before the carried interest split applies. Expressed as a decimal fraction. Null if no catch-up provision exists.',
    `clawback_applies` BOOLEAN COMMENT 'Indicates whether a clawback provision exists requiring the general partner to return previously distributed carried interest if cumulative fund performance falls below the hurdle rate at fund wind-down.',
    `clawback_escrow_rate` DECIMAL(18,2) COMMENT 'The percentage of carried interest distributions held in escrow to satisfy potential clawback obligations, expressed as a decimal fraction (e.g., 0.25 = 25% of carry escrowed). Null if clawback_applies is False.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail, data lineage, and SOX compliance.',
    `effective_end_date` DATE COMMENT 'The date on which this fee structure ceases to apply. Null for open-ended fee schedules. Populated when a fee is superseded by an amendment, fund termination, or investor redemption.',
    `effective_start_date` DATE COMMENT 'The date from which this fee structure becomes binding and fee accrual begins. Aligns with fund inception, investor close date, or amendment effective date as documented in the funds legal agreements.',
    `fee_accrual_basis` STRING COMMENT 'The day count convention used to prorate fee accruals within a period (e.g., Actual/365, Actual/360, 30/360). Governs how partial-period fees are calculated for mid-period subscriptions, redemptions, or fund closes.. Valid values are `actual_365|actual_360|30_360|actual_actual`',
    `fee_basis` STRING COMMENT 'The denominator or reference base upon which the fee rate is applied. Common bases include Assets Under Management (AUM), committed capital, invested capital, Gross Asset Value (GAV), and Net Asset Value (NAV). Drives fee calculation methodology and investor transparency disclosures.. Valid values are `aum|committed_capital|invested_capital|gav|nav|gross_revenue`',
    `fee_calculation_method` STRING COMMENT 'The methodology used to compute the fee amount from the fee basis and rate. Flat rate applies a single rate uniformly; tiered applies different rates to different tranches of the basis; hurdle-based fees are only earned above a preferred return threshold; waterfall distributes proceeds in a defined sequence.. Valid values are `flat_rate|tiered|stepped|hurdle_based|waterfall`',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Absolute monetary ceiling on the fee amount in the funds base currency. When both fee_cap_rate and fee_cap_amount are defined, the lesser of the two applies. Null if no absolute cap is specified.',
    `fee_cap_rate` DECIMAL(18,2) COMMENT 'Maximum percentage rate or ceiling applied to the fee, expressed as a decimal fraction of the fee basis. Prevents fee amounts from exceeding a negotiated upper bound regardless of the fee basis growth. Null if no cap applies.',
    `fee_frequency` STRING COMMENT 'The periodicity at which the fee is assessed and accrued. Recurring fees (management, asset management) are typically quarterly or annual; transactional fees (acquisition, disposition) are one-time or upon-event.. Valid values are `monthly|quarterly|semi_annual|annual|one_time|upon_event`',
    `fee_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the fee basis to calculate the fee amount (e.g., 0.015000 = 1.5% of AUM). Expressed as a decimal fraction. Sourced from fund legal documents and MRI Software fee schedule configuration.',
    `fee_recipient_entity` STRING COMMENT 'Legal name of the entity entitled to receive the fee (e.g., the General Partner entity, the Asset Manager, or the Investment Advisor). Supports fee payment processing and regulatory disclosure.',
    `fee_schedule_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this fee schedule, as referenced in fund legal documents, investor agreements, and MRI Software. Used for cross-system reconciliation and investor reporting.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `fee_schedule_name` STRING COMMENT 'Human-readable name describing this fee structure (e.g., Class A Management Fee, Acquisition Fee — Core Fund 2024). Used in investor reporting and fund documentation.',
    `fee_structure_status` STRING COMMENT 'Current lifecycle state of the fee schedule record. Active indicates the fee is currently accruing; superseded indicates it has been replaced by a newer version; pending_approval indicates it is awaiting GP/LP approval before taking effect.. Valid values are `active|inactive|superseded|pending_approval|draft`',
    `fee_tier_structure` STRING COMMENT 'Textual description of the tiered or stepped fee schedule breakpoints and corresponding rates (e.g., 1.5% on first $100M AUM; 1.25% on next $150M; 1.0% above $250M). Populated when fee_calculation_method is tiered or stepped.',
    `fee_type` STRING COMMENT 'Classification of the fee by its business purpose within the investment vehicle. Management fees are recurring; acquisition and disposition fees are transactional; performance fees are incentive-based. [ENUM-REF-CANDIDATE: management_fee|acquisition_fee|disposition_fee|asset_management_fee|performance_fee|financing_fee|promote_fee|origination_fee|subscription_fee|redemption_fee — promote to reference product]. Valid values are `management_fee|acquisition_fee|disposition_fee|asset_management_fee|performance_fee|financing_fee`',
    `fee_waiver_conditions` STRING COMMENT 'Description of conditions under which the fee may be partially or fully waived (e.g., GP co-investment waiver, seed investor discount, regulatory restriction). Sourced from fund legal documents and side letters.',
    `high_water_mark_applies` BOOLEAN COMMENT 'Indicates whether a high water mark provision applies to this performance fee schedule. When True, performance fees are only earned on returns that exceed the highest previously achieved NAV, preventing double-charging on recovered losses.',
    `hurdle_rate` DECIMAL(18,2) COMMENT 'The minimum preferred return rate that must be achieved before performance fees (carried interest / promote) are earned by the general partner. Expressed as a decimal fraction (e.g., 0.08 = 8% preferred return). Applicable only to performance fee types.',
    `investor_class` STRING COMMENT 'The investor share class or tranche to which this fee schedule applies. Different investor classes (e.g., Class A, institutional, GP co-invest) may have distinct fee arrangements within the same fund.. Valid values are `class_a|class_b|class_c|institutional|retail|gp_co_invest`',
    `is_fee_waived` BOOLEAN COMMENT 'Indicates whether the fee is currently waived in full for this fee schedule period. True when a waiver is in effect; False when the fee is actively accruing.',
    `is_performance_fee` BOOLEAN COMMENT 'Indicates whether this fee schedule represents an incentive or performance-based fee (carried interest, promote, or profit participation) as opposed to a flat management or transactional fee. Drives separate accounting treatment under FASB ASC 946.',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'Minimum absolute fee amount payable per fee period in the funds base currency, regardless of the calculated fee. Ensures the fund manager receives a floor compensation even when the fee basis is low.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this fee schedule that are not captured in structured fields (e.g., side letter nuances, LP-specific negotiated terms).',
    `payment_timing` STRING COMMENT 'Specifies whether the fee is payable at the beginning (in advance) or end (in arrears) of each fee period. Affects cash flow timing and fee accrual accounting under FASB ASC 946.. Valid values are `in_advance|in_arrears`',
    `source_document_reference` STRING COMMENT 'Reference to the fund legal document (LPA, PPM, side letter, or amendment) from which this fee structure is sourced (e.g., LPA Section 7.2, Side Letter — Investor XYZ — Clause 4). Supports audit trail and regulatory compliance.',
    `source_system_ref` STRING COMMENT 'The unique identifier of this fee schedule record in the originating source system (MRI Software). Enables lineage tracing and reconciliation between the lakehouse silver layer and the operational system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was most recently modified, in ISO 8601 format with timezone offset. Tracks the latest change for audit trail and incremental data pipeline processing.',
    `waiver_expiry_date` DATE COMMENT 'The date on which the fee waiver expires and normal fee accrual resumes. Null if no waiver is in effect or the waiver is permanent.',
    CONSTRAINT pk_fee_structure PRIMARY KEY(`fee_structure_id`)
) COMMENT 'Defines the fee structures applicable to a fund or investment vehicle — management fees, acquisition fees, disposition fees, asset management fees, and performance fees. Captures fee type, fee basis (AUM, committed capital, invested capital, GAV, NAV), fee rate, fee calculation method, fee frequency, fee cap, fee waiver conditions, and effective date range. Supports accurate fee accrual and investor reporting. Sourced from fund legal documents and MRI Software.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`tax_allocation` (
    `tax_allocation_id` BIGINT COMMENT 'Unique system-generated identifier for each tax allocation record. Primary key for the tax_allocation data product in the investment domain.',
    `capital_account_id` BIGINT COMMENT 'Foreign key linking to investment.capital_account. Business justification: Tax allocations (K-1 items) are derived directly from the investors capital account position for the period. The capital_account (investor_statement) contains the period-level capital balance, owners',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Tax allocation line items (ordinary income, capital gains, depreciation, Section 1231) must map to COA accounts for book-tax reconciliation and deferred tax calculations. Real estate tax accountants r',
    `commitment_id` BIGINT COMMENT 'Reference to the investors capital commitment record within the fund, used to determine ownership percentage and allocation basis for tax purposes.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Tax allocation currency drives K-1 preparation, withholding tax calculations, foreign tax credit reporting, and state apportionment — required for multi-currency fund tax compliance.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund (REIT, partnership, or other vehicle) to which this tax allocation belongs. Links to the fund master record.',
    `investor_id` BIGINT COMMENT 'Reference to the investor (limited partner, REIT shareholder, or other investor type) receiving this tax allocation. Used for K-1 issuance and investor tax compliance.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Tax allocations directly produce regulatory filings (K-1s, state tax returns, FATCA/CRS reports). tax_allocation.k1_issued_flag indicates this relationship; a proper FK to regulatory_filing supports t',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Tax allocations are governed by specific regulatory obligations (IRC sections, FATCA, CRS, state tax laws, Section 199A). Linking tax allocations to regulatory obligations supports tax compliance moni',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: State apportionment code maps to geographic hierarchy for multi-state tax filing, UBTI allocation by state, and state-level income tax reporting — required for fund tax compliance in multi-state real ',
    `tax_provision_id` BIGINT COMMENT 'Foreign key linking to finance.tax_provision. Business justification: Investor-level K-1 tax allocations must reconcile with entity-level tax provisions for REIT distribution deductions, deferred tax calculations, and IRS compliance. Tax teams cross-reference these reco',
    `corrected_tax_allocation_id` BIGINT COMMENT 'Self-referencing FK on tax_allocation (corrected_tax_allocation_id)',
    `allocated_taxable_income` DECIMAL(18,2) COMMENT 'The investors pro-rata share of the funds taxable income for the allocation period, as reported on Schedule K-1 Box 1 (ordinary business income). Positive values indicate income; negative values indicate loss.',
    `allocated_taxable_loss` DECIMAL(18,2) COMMENT 'The investors pro-rata share of the funds taxable loss for the allocation period. Reported separately from income to support at-risk and passive activity loss limitation analysis per IRS rules.',
    `allocation_number` STRING COMMENT 'Externally-known unique reference number for this tax allocation record, used in K-1 packages, CPA correspondence, and investor tax statements. Sourced from MRI Software or tax preparation system.',
    `allocation_period_type` STRING COMMENT 'Indicates whether this tax allocation covers a full annual period, a quarterly period, or an interim period (e.g., upon investor admission or exit). Determines reporting frequency and K-1 timing.. Valid values are `annual|quarterly|interim`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the tax allocation record. Draft indicates in-progress; preliminary indicates initial estimate; final indicates IRS-ready; amended indicates a corrected allocation; superseded indicates replaced by a newer version; void indicates cancelled.. Valid values are `draft|preliminary|final|amended|superseded|void`',
    `amendment_number` STRING COMMENT 'Sequential amendment version number for this tax allocation record. Zero (0) indicates the original allocation; values greater than zero indicate amended K-1 versions. Used to track correction history and ensure investors receive the most current allocation data.',
    `amendment_reason` STRING COMMENT 'Free-text description of the reason for amending this tax allocation record (e.g., corrected depreciation calculation, revised ownership percentage, updated Section 1031 exchange treatment). Required when amendment_number > 0.',
    `capital_gain_allocated` DECIMAL(18,2) COMMENT 'The investors allocated share of net capital gains (short-term and long-term combined) from property dispositions or other capital events during the period. Reported on Schedule K-1 Box 9/10.',
    `cpa_review_date` DATE COMMENT 'The date on which the CPA or external tax advisor completed their review and approved this tax allocation record. Required for audit trail and SOX compliance documentation.',
    `cpa_review_status` STRING COMMENT 'The current status of the CPA (Certified Public Accountant) or external tax advisor review of this tax allocation record. Tracks the review workflow from initial preparation through final sign-off before K-1 issuance.. Valid values are `pending|in_review|approved|rejected|requires_amendment`',
    `cpa_reviewer_name` STRING COMMENT 'The name of the CPA firm or individual tax advisor responsible for reviewing and signing off on this tax allocation. Used for audit trail and professional accountability tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tax allocation record was first created in the system. Used for audit trail, data lineage, and compliance documentation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deferred_gain_1031` DECIMAL(18,2) COMMENT 'The investors allocated share of capital gain deferred under a Section 1031 like-kind exchange during the allocation period. Reduces current-period taxable gain and increases the investors carryover basis in the replacement property.',
    `depreciation_allocated` DECIMAL(18,2) COMMENT 'The investors allocated share of real property depreciation (MACRS/straight-line) passed through from the fund for the period. Reported on Schedule K-1 and used for investor tax basis calculations. Key metric for REIT and partnership tax reporting.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (Q1–Q4) of the allocation period. Null for annual allocations. Used for quarterly K-1 estimates and interim investor reporting.. Valid values are `Q1|Q2|Q3|Q4`',
    `foreign_tax_credit` DECIMAL(18,2) COMMENT 'The investors allocated share of foreign taxes paid by the fund on foreign-sourced income, passed through as a foreign tax credit. Reported on Schedule K-1 Box 16. Applicable for funds with international real estate holdings.',
    `investor_tax_basis_adjustment` DECIMAL(18,2) COMMENT 'The net adjustment to the investors outside tax basis in the partnership interest for the allocation period, reflecting contributions, distributions, income/loss allocations, and depreciation pass-throughs. Critical for at-risk limitation and gain/loss calculations on disposition.',
    `k1_delivery_method` STRING COMMENT 'The method by which the Schedule K-1 was delivered to the investor (electronic file, postal mail, investor portal, or email). Used for delivery confirmation tracking and investor preference management.. Valid values are `electronic|mail|portal|email`',
    `k1_issue_date` DATE COMMENT 'The date on which the Schedule K-1 was formally issued and distributed to the investor. Must be on or before the IRS filing deadline (typically March 15 for partnerships). Used for compliance deadline tracking.',
    `k1_issued_flag` BOOLEAN COMMENT 'Indicates whether the Schedule K-1 has been issued to the investor for this tax allocation period. True when K-1 has been formally distributed; false when pending. Used for compliance tracking and investor communication management.',
    `long_term_capital_gain` DECIMAL(18,2) COMMENT 'The investors allocated share of long-term capital gains (assets held more than 12 months) from property dispositions. Taxed at preferential rates. Reported on Schedule K-1 Box 9a.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, special tax treatment notes, CPA instructions, or investor-specific allocation adjustments that do not fit into structured fields. Used by tax preparers and asset managers for documentation.',
    `ordinary_dividend_income` DECIMAL(18,2) COMMENT 'For REIT structures, the investors allocated share of REIT dividends characterized as ordinary income (not return of capital or capital gain). Subject to standard income tax rates. Key component of REIT dividend characterization reporting.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The investors percentage ownership interest in the fund or partnership during the allocation period, used as the basis for computing pro-rata tax allocations. Expressed as a decimal (e.g., 0.125000 = 12.5%).',
    `period_end_date` DATE COMMENT 'The last day of the tax allocation period. For annual allocations this is typically December 31; for quarterly allocations it is the last day of the fiscal quarter.',
    `period_start_date` DATE COMMENT 'The first day of the tax allocation period. For annual allocations this is typically January 1; for quarterly allocations it is the first day of the fiscal quarter.',
    `return_of_capital_amount` DECIMAL(18,2) COMMENT 'The investors allocated share of distributions characterized as return of capital (ROC), which reduces the investors tax basis rather than being taxed as income. Critical for REIT dividend characterization and investor basis tracking.',
    `section_1031_exchange_flag` BOOLEAN COMMENT 'Indicates whether this tax allocation period includes a Section 1031 like-kind exchange transaction that defers capital gain recognition. When true, the allocation record must capture deferred gain details for investor basis tracking.',
    `section_1231_gain_loss` DECIMAL(18,2) COMMENT 'The investors allocated share of net Section 1231 gain or loss from the sale or exchange of real property used in a trade or business. Reported on Schedule K-1 Box 10. Positive values are treated as long-term capital gain; negative values as ordinary loss.',
    `section_199a_deduction` DECIMAL(18,2) COMMENT 'The investors allocated share of the Section 199A qualified business income (QBI) deduction passed through from the partnership or REIT. Allows eligible investors to deduct up to 20% of qualified REIT dividends or partnership income. Reported on Schedule K-1 Box 20Z.',
    `source_system_ref` STRING COMMENT 'The unique identifier or reference number of this tax allocation record in the originating source system (MRI Software or tax preparation system). Used for data lineage, reconciliation, and audit trail back to the system of record.',
    `state_taxable_income` DECIMAL(18,2) COMMENT 'The investors allocated share of taxable income apportioned to the primary state jurisdiction, after state-specific adjustments and apportionment factors. Used for state composite return filings and investor state tax compliance.',
    `tax_exempt_income` DECIMAL(18,2) COMMENT 'The investors allocated share of tax-exempt income generated by the fund (e.g., from tax-exempt bond investments or qualified opportunity zone income). Reported on Schedule K-1 Box 18A.',
    `tax_year` STRING COMMENT 'The calendar or fiscal tax year (e.g., 2024) to which this allocation applies. Used for IRS partnership reporting and investor K-1 issuance.',
    `ubti_amount` DECIMAL(18,2) COMMENT 'The investors allocated share of Unrelated Business Taxable Income (UBTI) generated by the fund. Critical for tax-exempt investors (pension funds, endowments, foundations) who are subject to UBIT on UBTI. Reported on Schedule K-1 Box 20V.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this tax allocation record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Federal or state income tax withheld on behalf of the investor by the fund or partnership during the allocation period. Reported on Schedule K-1 Box 13W or state equivalent. Relevant for foreign investors subject to FIRPTA withholding.',
    CONSTRAINT pk_tax_allocation PRIMARY KEY(`tax_allocation_id`)
) COMMENT 'Records annual and quarterly tax allocations to investors in partnership-structured funds, including K-1 data, UBTI calculations, depreciation pass-throughs, Section 1031 exchange tracking, REIT dividend characterization (ordinary income, capital gain, return of capital), and state-level tax apportionment. Captures allocation period, investor reference, allocated taxable income/loss, depreciation allocated, capital gain allocated, UBTI amount, K-1 issuance date, and CPA review status. Required for IRS partnership reporting and investor tax compliance. Sourced from MRI Software and tax preparation systems.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`investment`.`offering` (
    `offering_id` BIGINT COMMENT 'Primary key for offering',
    `legal_entity_id` BIGINT COMMENT 'Reference to the independent auditing firm providing financial statement audits.',
    `currency_code_id` BIGINT COMMENT 'FK to reference.currency_code',
    `custodian_entity_id` BIGINT COMMENT 'Reference to the custodian bank or financial institution holding the offerings assets.',
    `fund_administrator_entity_id` BIGINT COMMENT 'Reference to the third-party fund administrator providing accounting and reporting services.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: An offering is a fundraising vehicle that, when closed, becomes or contributes to a fund. This links the marketing/fundraising entity to the operational fund entity. The offering table has fund-like a',
    `legal_counsel_entity_id` BIGINT COMMENT 'Reference to the law firm providing legal counsel for the offering.',
    `sponsor_entity_id` BIGINT COMMENT 'Reference to the sponsor or general partner entity responsible for managing the offering.',
    `prior_offering_id` BIGINT COMMENT 'Self-referencing FK on offering (prior_offering_id)',
    `accredited_investor_only_flag` BOOLEAN COMMENT 'Indicates whether the offering is restricted to accredited investors only as defined by SEC regulations. True = accredited only; False = open to non-accredited.',
    `asset_class` STRING COMMENT 'Primary real estate asset class focus of the offering.',
    `carried_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of profits allocated to the general partner after preferred return is met, expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offering record was first created in the system.',
    `distribution_frequency` STRING COMMENT 'Frequency at which cash distributions are made to investors.',
    `filing_date` DATE COMMENT 'Date the offering was filed with the SEC or relevant regulatory authority.',
    `final_close_date` DATE COMMENT 'Date the offering stopped accepting new investor commitments and closed to new capital.',
    `geographic_focus` STRING COMMENT 'Primary geographic markets or regions where the offering invests (e.g., US West Coast, Southeast Asia, European Union). Free-text field for flexibility.',
    `initial_close_date` DATE COMMENT 'Date of the first capital close when the offering began accepting investor commitments.',
    `investment_strategy` STRING COMMENT 'Primary investment strategy classification defining risk-return profile and asset approach.',
    `investment_term_months` STRING COMMENT 'Expected duration of the investment holding period in months from initial close to final liquidation.',
    `leverage_target_percent` DECIMAL(18,2) COMMENT 'Target loan-to-value or debt-to-equity ratio for the portfolio, expressed as a percentage of total capitalization.',
    `management_fee_percent` DECIMAL(18,2) COMMENT 'Annual management fee charged to the fund as a percentage of committed capital or net asset value.',
    `maximum_raise_amount` DECIMAL(18,2) COMMENT 'Maximum capital the offering is authorized to accept, in USD. May be subject to regulatory caps.',
    `minimum_investment_amount` DECIMAL(18,2) COMMENT 'Minimum capital commitment required from a single investor to participate in the offering, in USD.',
    `minimum_raise_amount` DECIMAL(18,2) COMMENT 'Minimum capital required to close the offering and commence operations, in USD.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the offering record was last modified in the system.',
    `offering_description` STRING COMMENT 'Detailed narrative description of the offerings investment thesis, strategy, and objectives as presented to investors.',
    `offering_name` STRING COMMENT 'Full legal name of the investment offering as registered with regulatory authorities.',
    `offering_number` STRING COMMENT 'Externally-known unique business identifier for the offering, used in investor communications and regulatory filings.',
    `offering_status` STRING COMMENT 'Current lifecycle status of the offering. Draft = under preparation; Filed = submitted to regulators; Open = accepting investments; Closed = no longer accepting new capital; Suspended = temporarily halted; Terminated = cancelled before close; Liquidated = assets distributed and dissolved.',
    `offering_type` STRING COMMENT 'Classification of the investment vehicle structure. REIT = Real Estate Investment Trust.',
    `preferred_return_percent` DECIMAL(18,2) COMMENT 'Annualized preferred return rate (hurdle rate) that limited partners receive before general partner participates in profits, expressed as a percentage.',
    `qualified_purchaser_only_flag` BOOLEAN COMMENT 'Indicates whether the offering is restricted to qualified purchasers as defined under Investment Company Act Section 3(c)(7). True = qualified purchaser only; False = not restricted.',
    `redemption_allowed_flag` BOOLEAN COMMENT 'Indicates whether investors are permitted to redeem their interests before the end of the investment term. True = redemptions allowed; False = locked until liquidation.',
    `redemption_notice_days` STRING COMMENT 'Number of days advance notice required for an investor to request redemption of their interest.',
    `regulation_exemption` STRING COMMENT 'SEC registration exemption under which the offering is conducted.',
    `sec_file_number` STRING COMMENT 'Official SEC file number assigned to the Form D filing for this offering.',
    `target_equity_multiple` DECIMAL(18,2) COMMENT 'Projected total return multiple on invested equity over the investment period (e.g., 2.0x means investors receive twice their capital).',
    `target_irr_percent` DECIMAL(18,2) COMMENT 'Projected annualized internal rate of return target communicated to investors, expressed as a percentage.',
    `target_raise_amount` DECIMAL(18,2) COMMENT 'Total capital amount the offering aims to raise from investors, in USD.',
    `tax_treatment` STRING COMMENT 'Tax classification of the offering entity determining how income and gains are taxed to investors.',
    `termination_date` DATE COMMENT 'Date the offering was formally terminated or liquidated and all assets distributed to investors.',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Master reference table for offering. Referenced by offering_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_parent_fund_id` FOREIGN KEY (`parent_fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_parent_portfolio_id` FOREIGN KEY (`parent_portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_commitment_transferee_investor_id` FOREIGN KEY (`commitment_transferee_investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `real_estate_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_waterfall_id` FOREIGN KEY (`waterfall_id`) REFERENCES `real_estate_ecm`.`investment`.`waterfall`(`waterfall_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_waterfall_id` FOREIGN KEY (`waterfall_id`) REFERENCES `real_estate_ecm`.`investment`.`waterfall`(`waterfall_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ADD CONSTRAINT `fk_investment_waterfall_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ADD CONSTRAINT `fk_investment_waterfall_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_waterfall_id` FOREIGN KEY (`waterfall_id`) REFERENCES `real_estate_ecm`.`investment`.`waterfall`(`waterfall_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ADD CONSTRAINT `fk_investment_fee_structure_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_capital_account_id` FOREIGN KEY (`capital_account_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_account`(`capital_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_corrected_tax_allocation_id` FOREIGN KEY (`corrected_tax_allocation_id`) REFERENCES `real_estate_ecm`.`investment`.`tax_allocation`(`tax_allocation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_prior_offering_id` FOREIGN KEY (`prior_offering_id`) REFERENCES `real_estate_ecm`.`investment`.`offering`(`offering_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`investment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`investment` SET TAGS ('dbx_domain' = 'investment');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Target Geography Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `parent_fund_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `actual_aum` SET TAGS ('dbx_business_glossary_term' = 'Actual Assets Under Management (AUM)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `actual_aum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Auditor Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `called_capital` SET TAGS ('dbx_business_glossary_term' = 'Called Capital');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `called_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `concentration_limit` SET TAGS ('dbx_business_glossary_term' = 'Single Asset Concentration Limit');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `distributed_capital` SET TAGS ('dbx_business_glossary_term' = 'Distributed Capital');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `distributed_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `esg_framework` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Framework');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `esg_framework` SET TAGS ('dbx_value_regex' = 'gresb|unpri|tcfd|sfdr|leed|breeam');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `esg_mandate` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Mandate');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `extension_options` SET TAGS ('dbx_business_glossary_term' = 'Fund Term Extension Options');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Basis');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'committed_capital|invested_capital|nav|gross_asset_value');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fee_cap` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Cap');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fee_cap` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fee_waiver_conditions` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Conditions');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fee_waiver_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `final_close_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Final Close Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'fundraising|active|fully_invested|harvesting|closed|liquidating');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'open_end|closed_end|reit|partnership|cmbs_trust|rmbs_trust');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `gav` SET TAGS ('dbx_business_glossary_term' = 'Gross Asset Value (GAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `gav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `gp_entity_name` SET TAGS ('dbx_business_glossary_term' = 'General Partner (GP) Entity Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `gp_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Inception Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `investment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_value_regex' = 'core|core_plus|value_add|opportunistic|debt');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `max_deal_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Deal Size');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `min_deal_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Deal Size');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `nav` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `nav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `preferred_return_hurdle` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Hurdle Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `preferred_return_hurdle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Investor Reporting Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_aum` SET TAGS ('dbx_business_glossary_term' = 'Target Assets Under Management (AUM)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_aum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_irr` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_leverage_max` SET TAGS ('dbx_business_glossary_term' = 'Target Leverage Maximum (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `target_leverage_min` SET TAGS ('dbx_business_glossary_term' = 'Target Leverage Minimum (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `term_years` SET TAGS ('dbx_business_glossary_term' = 'Fund Term (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Termination Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `total_commitments` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Commitments');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `total_commitments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Valuation Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `parent_portfolio_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `called_capital` SET TAGS ('dbx_business_glossary_term' = 'Called Capital');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `called_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `committed_capital` SET TAGS ('dbx_business_glossary_term' = 'Committed Capital');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `committed_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|at_exit');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `ffo_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Funds From Operations (FFO) Reporting Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Inception Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `leverage_policy` SET TAGS ('dbx_business_glossary_term' = 'Leverage Policy');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `leverage_policy` SET TAGS ('dbx_value_regex' = 'unleveraged|low_leverage|moderate_leverage|high_leverage');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `leverage_policy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `open_end_flag` SET TAGS ('dbx_business_glossary_term' = 'Open-End Fund Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Code');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_name` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Name');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_status` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Status');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_status` SET TAGS ('dbx_value_regex' = 'active|inactive|winding_down|closed|pending_launch|suspended');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'mri_software|argus_enterprise|sap_s4hana|manual');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliance Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_aum` SET TAGS ('dbx_business_glossary_term' = 'Target Assets Under Management (AUM)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_aum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_fund_size` SET TAGS ('dbx_business_glossary_term' = 'Target Fund Size');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_fund_size` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_gav` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Asset Value (GAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_gav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_irr` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_ltv` SET TAGS ('dbx_business_glossary_term' = 'Target Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_ltv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_nav` SET TAGS ('dbx_business_glossary_term' = 'Target Net Asset Value (NAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_nav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_noi` SET TAGS ('dbx_business_glossary_term' = 'Target Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_wale` SET TAGS ('dbx_business_glossary_term' = 'Target Weighted Average Lease Expiry (WALE)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `target_walt` SET TAGS ('dbx_business_glossary_term' = 'Target Weighted Average Lease Term (WALT)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Termination Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'dcf|direct_capitalization|sales_comparison|cost_approach|nav_based');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Type');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `investment_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle ID');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `called_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Called Capital Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `called_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `committed_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Capital Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `committed_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `final_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Final Closing Date');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Formation Date');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `fund_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Administrator Name');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `gp_entity_name` SET TAGS ('dbx_business_glossary_term' = 'General Partner (GP) Entity Name');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `gp_ownership_pct` SET TAGS ('dbx_business_glossary_term' = 'General Partner (GP) Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `gp_ownership_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `investment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `is_co_investment` SET TAGS ('dbx_business_glossary_term' = 'Co-Investment Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `is_open_ended` SET TAGS ('dbx_business_glossary_term' = 'Open-Ended Vehicle Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `is_reit_qualified` SET TAGS ('dbx_business_glossary_term' = 'REIT Qualified Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `lp_ownership_pct` SET TAGS ('dbx_business_glossary_term' = 'Limited Partner (LP) Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `lp_ownership_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `nav_calculation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `nav_calculation_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|on_demand');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'exempt|registered|filed|pending|lapsed');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `sec_filing_number` SET TAGS ('dbx_business_glossary_term' = 'SEC Filing Number');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_equity_raise_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Raise Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_equity_raise_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_irr_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR) Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_irr_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Target Leverage Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `target_leverage_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = 'pass_through|REIT|C_Corp|S_Corp|disregarded_entity');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `term_years` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Term (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Code');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_name` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Name');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Status');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_value_regex' = 'active|closed|winding_down|pending_formation|suspended');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Type');
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Target Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Investor Accreditation Status');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|non_accredited|qualified_purchaser|pending_verification');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `aml_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Status');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `aml_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|under_review|pending');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `co_investment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Investment Eligible Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `committed_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Capital Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `committed_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `crs_classification` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Classification');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `crs_classification` SET TAGS ('dbx_value_regex' = 'reportable_person|passive_nfe|active_nfe|financial_institution');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `distribution_bank_account_ref` SET TAGS ('dbx_business_glossary_term' = 'Distribution Bank Account Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `distribution_bank_account_ref` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `distribution_bank_account_ref` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `distribution_preference` SET TAGS ('dbx_business_glossary_term' = 'Distribution Preference');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `distribution_preference` SET TAGS ('dbx_value_regex' = 'quarterly|monthly|semi_annual|annual|reinvest');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `esg_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Mandate Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `fatca_classification` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Classification');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `fatca_classification` SET TAGS ('dbx_value_regex' = 'us_person|foreign_financial_institution|nffe|exempt_beneficial_owner|excepted_nffe');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investment_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Investment Horizon (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_code` SET TAGS ('dbx_business_glossary_term' = 'Investor Code');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_code` SET TAGS ('dbx_value_regex' = '^INV-[A-Z0-9]{6,12}$');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_status` SET TAGS ('dbx_business_glossary_term' = 'Investor Status');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|redeemed|closed');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_tier` SET TAGS ('dbx_business_glossary_term' = 'Investor Tier');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|standard');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_type` SET TAGS ('dbx_business_glossary_term' = 'Investor Type');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `investor_type` SET TAGS ('dbx_value_regex' = 'institutional|hnwi|family_office|pension_fund|sovereign_wealth_fund|endowment');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'approved|pending|under_review|rejected|expired');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Investor Legal Name');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `minimum_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Investment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `minimum_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Investor Onboarding Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_business_glossary_term' = 'Registered Address City');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Country');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `sanctions_screened_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Completed Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `side_letter_flag` SET TAGS ('dbx_business_glossary_term' = 'Side Letter Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_value_regex' = 'operating_income|asset_sale|inheritance|pension_fund|endowment_corpus|debt_financing');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `target_irr_max` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR) Maximum');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `target_irr_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `target_irr_min` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR) Minimum');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `target_irr_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number Type');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_value_regex' = 'ein|ssn|itin|foreign_tin|giin');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_residency_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Country');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `tax_residency_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_transferee_investor_id` SET TAGS ('dbx_business_glossary_term' = 'Transferee Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `aum_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Contribution Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `aum_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `called_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Called Capital Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `called_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `capital_call_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Schedule Type');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `capital_call_schedule_type` SET TAGS ('dbx_value_regex' = 'as_needed|scheduled|milestone_based|hybrid');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Close Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `co_investment_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Investment Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Capital Commitment Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Commitment Number');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Capital Commitment Status');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'pending|executed|funded|defaulted|cancelled|transferred');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Default Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `distributed_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Distributed Capital Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `distributed_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `erisa_flag` SET TAGS ('dbx_business_glossary_term' = 'ERISA Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `first_call_date` SET TAGS ('dbx_business_glossary_term' = 'First Capital Call Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `fund_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Term End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `investment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `loi_reference` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `management_fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Basis');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `management_fee_basis` SET TAGS ('dbx_value_regex' = 'committed_capital|invested_capital|nav|gross_asset_value');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Rate (Hurdle Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `recallable_distributions_amount` SET TAGS ('dbx_business_glossary_term' = 'Recallable Distributions Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `recallable_distributions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `side_letter_flag` SET TAGS ('dbx_business_glossary_term' = 'Side Letter Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `side_letter_reference` SET TAGS ('dbx_business_glossary_term' = 'Side Letter Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `subscription_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Subscription Agreement Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `total_capital_calls_count` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Calls Count');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Transfer Date');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `uncalled_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Uncalled Capital Amount (Dry Powder)');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `uncalled_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `capital_call_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Call ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Number');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Percentage of Commitment');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_purpose` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Purpose');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_purpose` SET TAGS ('dbx_value_regex' = 'acquisition|capex|fees|reserves|debt_repayment|operating_expenses');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_sequence` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Sequence Number');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Status');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_status` SET TAGS ('dbx_value_regex' = 'draft|issued|funded|partially_funded|defaulted|cancelled');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Type');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'initial|follow_on|recallable|bridge|supplemental');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `cumulative_called_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Called Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `cumulative_called_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Default Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Due Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Funded Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `funded_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `funded_date` SET TAGS ('dbx_business_glossary_term' = 'Funded Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `interest_on_late_payment` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate on Late Payment');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `investment_purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Investment Purpose Description');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `is_recallable` SET TAGS ('dbx_business_glossary_term' = 'Recallable Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `notice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Notice Delivery Method');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `notice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|portal|mail|fax|docusign');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Sent Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Penalty Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `shortfall_amount` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `shortfall_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `total_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `total_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `uncalled_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Uncalled Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `uncalled_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ALTER COLUMN `wire_reference` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `investment_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Investment ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `waterfall_id` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Structure Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `affo_component_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Funds From Operations (AFFO) Component Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `amount_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Distribution Amount Per Unit');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `capital_gain_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Gain Distribution Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `carried_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `distribution_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Number');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|cancelled|reversed');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `distribution_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Type');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `distribution_type` SET TAGS ('dbx_value_regex' = 'return_of_capital|ordinary_income|capital_gain|preferred_return|carried_interest');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `ex_distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Distribution Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `ffo_component_amount` SET TAGS ('dbx_business_glossary_term' = 'Funds From Operations (FFO) Component Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|special');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Distribution Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `k1_issued` SET TAGS ('dbx_business_glossary_term' = 'Schedule K-1 Issued Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Distribution Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|drip|offset');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Period Start Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `preferred_return_amount` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `reinvestment_elected` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Election Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `reinvestment_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Price Per Unit');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `reinvestment_units` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Units Purchased');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `return_of_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Return of Capital (ROC) Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'mri_software|yardi_voyager');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `units_held` SET TAGS ('dbx_business_glossary_term' = 'Units Held');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Manager (AM) ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `acquisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `actual_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Exit Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `allocated_debt` SET TAGS ('dbx_business_glossary_term' = 'Allocated Debt');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `allocated_debt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `appraised_value` SET TAGS ('dbx_business_glossary_term' = 'Appraised Value');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `appraised_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Status');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|under_review|disposition_pending|disposed|on_hold');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `capex_budget` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `capex_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `capex_spent_to_date` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Spent to Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `capex_spent_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `disposition_price` SET TAGS ('dbx_business_glossary_term' = 'Disposition Price');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `disposition_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `equity_invested` SET TAGS ('dbx_business_glossary_term' = 'Equity Invested');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `equity_invested` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `hold_strategy` SET TAGS ('dbx_business_glossary_term' = 'Hold Strategy');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `hold_strategy` SET TAGS ('dbx_value_regex' = 'core_hold|value_add|opportunistic|disposition_target|development');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `in_place_noi` SET TAGS ('dbx_business_glossary_term' = 'In-Place Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `in_place_noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `investment_risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Investment Risk Profile');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `investment_risk_profile` SET TAGS ('dbx_value_regex' = 'core|core_plus|value_add|opportunistic');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `is_encumbered` SET TAGS ('dbx_business_glossary_term' = 'Is Encumbered Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Is Joint Venture Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `stabilized_noi` SET TAGS ('dbx_business_glossary_term' = 'Stabilized Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `stabilized_noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Target Exit Date');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_irr` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `target_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain/Loss');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `fund_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Performance ID');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `cap_rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate Benchmark Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Nav Calculation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `waterfall_id` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Structure Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `affo` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Funds From Operations (AFFO)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `affo` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `alpha` SET TAGS ('dbx_business_glossary_term' = 'Alpha (Excess Return over Benchmark)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `alpha` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `auditor_signoff_status` SET TAGS ('dbx_business_glossary_term' = 'Auditor Sign-Off Status');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `auditor_signoff_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|signed_off|qualified|adverse');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `aum` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `aum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `benchmark_return` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Return');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `capex` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `capex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Hurdle Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `distribution_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Distribution Per Unit/Share');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `distribution_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `dpi` SET TAGS ('dbx_business_glossary_term' = 'Distributions to Paid-In Capital (DPI)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `dpi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Equity Multiple (MOIC — Multiple on Invested Capital)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `ffo` SET TAGS ('dbx_business_glossary_term' = 'Funds From Operations (FFO)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `ffo` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `gav` SET TAGS ('dbx_business_glossary_term' = 'Gross Asset Value (GAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `gav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `gross_irr` SET TAGS ('dbx_business_glossary_term' = 'Gross Internal Rate of Return (Gross IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `gross_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Leverage Ratio (Loan-to-Value)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `mwr` SET TAGS ('dbx_business_glossary_term' = 'Money-Weighted Return (MWR)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `mwr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav_methodology` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Methodology');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav_methodology` SET TAGS ('dbx_value_regex' = 'independent_appraisal|internal_valuation|broker_opinion|automated_valuation|hybrid');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value Per Unit/Share (NAV per Unit)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `net_irr` SET TAGS ('dbx_business_glossary_term' = 'Net Internal Rate of Return (Net IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `net_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `noi` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `npv` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `opex` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `opex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Status');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|audited|restated');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Type');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|trailing_12|since_inception');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `premium_discount_to_nav` SET TAGS ('dbx_business_glossary_term' = 'Premium/Discount to Net Asset Value (NAV)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `premium_discount_to_nav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `rvpi` SET TAGS ('dbx_business_glossary_term' = 'Residual Value to Paid-In Capital (RVPI)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `rvpi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `total_distributions` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Paid');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `total_distributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_business_glossary_term' = 'Total Fund Liabilities');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Fund Revenue');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `total_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `tvpi` SET TAGS ('dbx_business_glossary_term' = 'Total Value to Paid-In Capital (TVPI)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `tvpi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `twr` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR)');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `twr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `units_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Units/Shares Outstanding');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `asset_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Performance ID');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `cap_rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate Benchmark Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `dcf_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Dcf Model Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `fund_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Performance Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `noi_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Noi Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `appraised_value` SET TAGS ('dbx_business_glossary_term' = 'Appraised Value');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `appraised_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `capex` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `capex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `cash_on_cash_return` SET TAGS ('dbx_business_glossary_term' = 'Cash-on-Cash Return');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'argus_enterprise|yardi_voyager|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `egi` SET TAGS ('dbx_business_glossary_term' = 'Effective Gross Income (EGI)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `egi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `exit_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Exit Capitalization Rate (Exit CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `hold_period_years` SET TAGS ('dbx_business_glossary_term' = 'Hold Period (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `levered_irr` SET TAGS ('dbx_business_glossary_term' = 'Levered Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `nla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area in Square Feet (NLA SQF)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `noi` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `npv` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `operating_expenses` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenses (OPEX)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `operating_expenses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `opex_psf` SET TAGS ('dbx_business_glossary_term' = 'Operating Expense Per Square Foot (OPEX PSF)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Record Status');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|restated|archived');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Type');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|trailing_12_month|ytd');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `pgi` SET TAGS ('dbx_business_glossary_term' = 'Potential Gross Income (PGI)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `pgi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `projected_noi_growth_rate` SET TAGS ('dbx_business_glossary_term' = 'Projected NOI Growth Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `revenue_psf` SET TAGS ('dbx_business_glossary_term' = 'Revenue Per Square Foot (Revenue PSF)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `sensitivity_scenario` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Scenario');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `sensitivity_scenario` SET TAGS ('dbx_value_regex' = 'base|upside|downside|stress');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `terminal_value` SET TAGS ('dbx_business_glossary_term' = 'Terminal Value');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `terminal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `total_return` SET TAGS ('dbx_business_glossary_term' = 'Total Return');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `unlevered_irr` SET TAGS ('dbx_business_glossary_term' = 'Unlevered Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `vacancy_credit_loss` SET TAGS ('dbx_business_glossary_term' = 'Vacancy and Credit Loss');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `vacancy_credit_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `vacancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `wale` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Lease Expiry (WALE)');
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ALTER COLUMN `walt` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Lease Term (WALT)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` SET TAGS ('dbx_subdomain' = 'debt_management');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `lender_id` SET TAGS ('dbx_business_glossary_term' = 'Lender ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `amortization_period_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period (Months)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Amortization Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'interest_only|fully_amortizing|partial_amortization|balloon');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `collateral_description` SET TAGS ('dbx_business_glossary_term' = 'Collateral Description');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Status');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|waiver|breach|cure_period');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_dscr_threshold` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR) Covenant Threshold');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_dscr_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_ltv_threshold` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Covenant Threshold');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_ltv_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Covenant Measurement Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_measurement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `covenant_occupancy_threshold` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Covenant Threshold');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Covenant Cure Period (Days)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `dscr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `extended_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Maturity Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `extension_options_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Options Count');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `extension_period_months` SET TAGS ('dbx_business_glossary_term' = 'Extension Period (Months)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Name');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `facility_number` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Number');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Status');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|closed|matured|defaulted|in_negotiation|pending_close');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|hybrid');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `io_period_months` SET TAGS ('dbx_business_glossary_term' = 'Interest-Only (IO) Period (Months)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `is_cross_collateralized` SET TAGS ('dbx_business_glossary_term' = 'Cross-Collateralized Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `is_cross_defaulted` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `last_covenant_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Covenant Test Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `lender_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Required Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Origination Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal Balance');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `prepayment_lockout_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Lockout End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `prepayment_type` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `prepayment_type` SET TAGS ('dbx_value_regex' = 'none|lockout|yield_maintenance|defeasance|step_down');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `rate_index` SET TAGS ('dbx_business_glossary_term' = 'Rate Index');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `rate_spread` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread (Basis Points)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `rate_spread` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `recourse_type` SET TAGS ('dbx_business_glossary_term' = 'Recourse Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `recourse_type` SET TAGS ('dbx_value_regex' = 'full_recourse|non_recourse|partial_recourse');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `seniority_tier` SET TAGS ('dbx_business_glossary_term' = 'Debt Seniority Tier');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `seniority_tier` SET TAGS ('dbx_value_regex' = 'senior|junior|mezzanine|subordinated|preferred_equity');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `servicer_name` SET TAGS ('dbx_business_glossary_term' = 'Loan Servicer Name');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `unfunded_commitment` SET TAGS ('dbx_business_glossary_term' = 'Unfunded Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `unfunded_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` SET TAGS ('dbx_subdomain' = 'debt_management');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `debt_covenant_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Covenant ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `lender_id` SET TAGS ('dbx_business_glossary_term' = 'Lender ID');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Breach Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Covenant Calculation Methodology');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Status');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|breach|waiver|cure_period|watch_list|not_tested');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_description` SET TAGS ('dbx_business_glossary_term' = 'Covenant Description');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_metric` SET TAGS ('dbx_business_glossary_term' = 'Covenant Metric');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_name` SET TAGS ('dbx_business_glossary_term' = 'Covenant Name');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Covenant Reference Number');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_scope` SET TAGS ('dbx_business_glossary_term' = 'Covenant Scope');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_scope` SET TAGS ('dbx_value_regex' = 'asset_level|portfolio_level|entity_level|fund_level');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_type` SET TAGS ('dbx_business_glossary_term' = 'Covenant Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `covenant_type` SET TAGS ('dbx_value_regex' = 'financial|operational|reporting|maintenance|incurrence');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `cure_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Cure Deadline Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Covenant Cure Period (Days)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Effective Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `is_cross_default` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Covenant Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `is_financial_covenant` SET TAGS ('dbx_business_glossary_term' = 'Financial Covenant Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `last_measured_value` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Covenant Value');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Covenant Measurement Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `lender_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Period (Days)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `lender_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Required Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Covenant Measurement Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Covenant Measurement Period Type');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'trailing_12_months|trailing_3_months|point_in_time|annualized');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `next_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Covenant Measurement Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Covenant Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Sent Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `reporting_due_days` SET TAGS ('dbx_business_glossary_term' = 'Covenant Reporting Due Period (Days)');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `reporting_package_required` SET TAGS ('dbx_business_glossary_term' = 'Reporting Package Required Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'MRI_Software|SAP_S4HANA|Yardi_Voyager|Argus_Enterprise|Manual');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Covenant Threshold Direction');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'minimum|maximum');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Covenant Threshold Unit of Measure');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'ratio|percentage|currency|times');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Covenant Threshold Value');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Waiver Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Covenant Waiver Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ALTER COLUMN `watch_list_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Covenant Watch List Threshold Value');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `bpo_id` SET TAGS ('dbx_business_glossary_term' = 'Bpo Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `cap_rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate Benchmark Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `dcf_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Dcf Model Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Asset Manager (AM) ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Asking Price');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `contracted_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Price');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `contracted_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `dead_reason` SET TAGS ('dbx_business_glossary_term' = 'Dead Deal Reason');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_business_glossary_term' = 'Deal Code');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|approved|rejected|withdrawn|closed');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'acquisition|disposition|recapitalization|jv_formation|refinancing|development');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `hold_period_years` SET TAGS ('dbx_business_glossary_term' = 'Hold Period (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_approving_members` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Approving Members');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Conditions of Approval');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_decision` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Decision');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|deferred|withdrawn');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Decision Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_key_risks` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Key Risks');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Recommendation');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_recommendation` SET TAGS ('dbx_value_regex' = 'recommend|do_not_recommend|conditional_recommend');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `ic_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Submission Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `is_off_market` SET TAGS ('dbx_business_glossary_term' = 'Is Off-Market Deal Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `loi_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `projected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Close Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `sourced_date` SET TAGS ('dbx_business_glossary_term' = 'Sourced Date');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Deal Stage');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `target_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `target_cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Target Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `target_irr` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `target_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Debt Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_debt_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_equity_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Equity Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_equity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_ltv` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_ltv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_noi` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_value` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Value');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `underwritten_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `ic_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Memo Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `cap_rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate Benchmark Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `dcf_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Dcf Model Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Pipeline Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `proforma_id` SET TAGS ('dbx_business_glossary_term' = 'Proforma Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `approving_members` SET TAGS ('dbx_business_glossary_term' = 'Approving IC Members');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'IC Decision Date');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `dissenting_members` SET TAGS ('dbx_business_glossary_term' = 'Dissenting IC Members');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `docusign_envelope_reference` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `esg_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Assessment Summary');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `hold_period_years` SET TAGS ('dbx_business_glossary_term' = 'Projected Hold Period (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `ic_decision` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Decision');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `ic_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|approved_with_conditions|deferred|tabled|no_quorum');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `ic_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Meeting Date');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `is_final_approval` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Status Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `key_risks` SET TAGS ('dbx_business_glossary_term' = 'Key Risks Identified');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `lp_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Limited Partner (LP) Approval Required Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Memo Date');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'IC Memo Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_number` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Memo Number');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_number` SET TAGS ('dbx_value_regex' = '^IC-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_status` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Memo Status');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_title` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Memo Title');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee (IC) Memo Type');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_version` SET TAGS ('dbx_business_glossary_term' = 'IC Memo Version');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `memo_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_business_glossary_term' = 'IC Recommendation Type');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_value_regex' = 'approve|reject|approve_with_conditions|defer|table');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `requested_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Debt Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `requested_debt_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `requested_equity_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Equity Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `requested_equity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Memo Reviewed By');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `sensitivity_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Summary');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `total_capitalization` SET TAGS ('dbx_business_glossary_term' = 'Total Capitalization');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `total_capitalization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_equity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Equity Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_irr` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_noi` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Net Operating Income (NOI)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_noi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_npv` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Net Present Value (NPV)');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `underwritten_npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `vote_count_abstain` SET TAGS ('dbx_business_glossary_term' = 'IC Vote Count — Abstain');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `vote_count_against` SET TAGS ('dbx_business_glossary_term' = 'IC Vote Count — Against');
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ALTER COLUMN `vote_count_for` SET TAGS ('dbx_business_glossary_term' = 'IC Vote Count — For');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `waterfall_id` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'LPA Amendment Number');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `clawback_lookback_years` SET TAGS ('dbx_business_glossary_term' = 'Clawback Lookback Period (Years)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_realization|at_fund_wind_down');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `equity_multiple_hurdle` SET TAGS ('dbx_business_glossary_term' = 'Equity Multiple Hurdle');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `equity_multiple_hurdle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `gp_catch_up_rate` SET TAGS ('dbx_business_glossary_term' = 'General Partner (GP) Catch-Up Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `gp_catch_up_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `has_clawback` SET TAGS ('dbx_business_glossary_term' = 'Clawback Provision Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `irr_hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Hurdle Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `irr_hurdle_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `is_recycling_permitted` SET TAGS ('dbx_business_glossary_term' = 'Capital Recycling Permitted Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `lp_carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Limited Partner (LP) Residual Profit Share Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `lp_carried_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `lpa_reference` SET TAGS ('dbx_business_glossary_term' = 'Limited Partnership Agreement (LPA) Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `lpa_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `management_fee_offset_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Offset Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `management_fee_offset_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `preferred_return_basis` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Basis');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `preferred_return_basis` SET TAGS ('dbx_value_regex' = 'cumulative|non_cumulative|cumulative_compounded');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Rate (Hurdle Rate)');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `return_of_capital_first` SET TAGS ('dbx_business_glossary_term' = 'Return of Capital First Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `structure_code` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Structure Code');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `structure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Structure Name');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_gp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 General Partner (GP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_gp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_label` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Distribution Label');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_lp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Limited Partner (LP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_lp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier1_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_gp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 General Partner (GP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_gp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_label` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Distribution Label');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_lp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Limited Partner (LP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_lp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier2_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_gp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 General Partner (GP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_gp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_label` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Distribution Label');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_lp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Limited Partner (LP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_lp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Threshold Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier3_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier4_gp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 4 General Partner (GP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier4_gp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier4_label` SET TAGS ('dbx_business_glossary_term' = 'Tier 4 Distribution Label');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier4_lp_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 4 Limited Partner (LP) Split Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier4_lp_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Distribution Tier Count');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `waterfall_status` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Structure Status');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `waterfall_status` SET TAGS ('dbx_value_regex' = 'active|superseded|draft|terminated|pending_approval');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `waterfall_type` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Type');
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ALTER COLUMN `waterfall_type` SET TAGS ('dbx_value_regex' = 'American|European');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Account Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `nav_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Nav Calculation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `waterfall_id` SET TAGS ('dbx_business_glossary_term' = 'Waterfall Structure Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `allocated_income_loss` SET TAGS ('dbx_business_glossary_term' = 'Allocated Income (Loss)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `allocated_income_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `allocated_income_loss` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `beginning_capital_balance` SET TAGS ('dbx_business_glossary_term' = 'Beginning Capital Account Balance');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `beginning_capital_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `beginning_capital_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_contributions` SET TAGS ('dbx_business_glossary_term' = 'Capital Contributions');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_contributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_contributions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_distributions` SET TAGS ('dbx_business_glossary_term' = 'Capital Distributions');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_distributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `capital_distributions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `carried_interest_allocated` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `carried_interest_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `carried_interest_allocated` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `cumulative_contributions` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Capital Contributions');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `cumulative_contributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `cumulative_contributions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `cumulative_distributions` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Capital Distributions');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `cumulative_distributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `cumulative_distributions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `dpi` SET TAGS ('dbx_business_glossary_term' = 'Distributions to Paid-In (DPI) Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `dpi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `dpi` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `ending_capital_balance` SET TAGS ('dbx_business_glossary_term' = 'Ending Capital Account Balance');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `ending_capital_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `ending_capital_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `inception_to_date_irr` SET TAGS ('dbx_business_glossary_term' = 'Inception-to-Date Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `inception_to_date_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `inception_to_date_irr` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `is_tax_exempt_investor` SET TAGS ('dbx_business_glossary_term' = 'Tax-Exempt Investor Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `management_fees_charged` SET TAGS ('dbx_business_glossary_term' = 'Management Fees Charged');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `management_fees_charged` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `management_fees_charged` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `moic` SET TAGS ('dbx_business_glossary_term' = 'Multiple on Invested Capital (MOIC)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `moic` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `moic` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Per Unit');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `other_fees_charged` SET TAGS ('dbx_business_glossary_term' = 'Other Fees Charged');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `other_fees_charged` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `other_fees_charged` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `preferred_return_accrued` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Accrued');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `preferred_return_accrued` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `preferred_return_accrued` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain (Loss)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `rvpi` SET TAGS ('dbx_business_glossary_term' = 'Residual Value to Paid-In (RVPI) Multiple');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `rvpi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `rvpi` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issue Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|restated|superseded');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `tax_basis_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Tax Basis Adjustment');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `tax_basis_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `tax_basis_adjustment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `total_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `total_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `total_commitment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `uncalled_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Uncalled Commitment Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `uncalled_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `uncalled_commitment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `units_held` SET TAGS ('dbx_business_glossary_term' = 'Units Held');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `units_held` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `units_held` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain (Loss)');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `amendment_version` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Amendment Version');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `amendment_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Approval Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Approval Status');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `catch_up_rate` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `catch_up_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `clawback_applies` SET TAGS ('dbx_business_glossary_term' = 'Clawback Provision Applies Indicator');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `clawback_escrow_rate` SET TAGS ('dbx_business_glossary_term' = 'Clawback Escrow Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `clawback_escrow_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Effective End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Effective Start Date');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_accrual_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Accrual Day Count Basis');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_accrual_basis` SET TAGS ('dbx_value_regex' = 'actual_365|actual_360|30_360|actual_actual');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'aum|committed_capital|invested_capital|gav|nav|gross_revenue');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Method');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_calculation_method` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|stepped|hurdle_based|waterfall');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fee Frequency');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|one_time|upon_event');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_recipient_entity` SET TAGS ('dbx_business_glossary_term' = 'Fee Recipient Entity Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_recipient_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_structure_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_structure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending_approval|draft');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Fee Tier Structure Description');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_tier_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'management_fee|acquisition_fee|disposition_fee|asset_management_fee|performance_fee|financing_fee');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_waiver_conditions` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Conditions');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `fee_waiver_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `high_water_mark_applies` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark Applies Indicator');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Rate (Preferred Return)');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `hurdle_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `investor_class` SET TAGS ('dbx_business_glossary_term' = 'Investor Share Class');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `investor_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|institutional|retail|gp_co_invest');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `is_fee_waived` SET TAGS ('dbx_business_glossary_term' = 'Fee Waived Indicator');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `is_performance_fee` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Indicator');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `payment_timing` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Timing');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `payment_timing` SET TAGS ('dbx_value_regex' = 'in_advance|in_arrears');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Legal Document Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Expiry Date');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` SET TAGS ('dbx_subdomain' = 'debt_management');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `tax_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Allocation ID');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `capital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Commitment ID');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor ID');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'State Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `corrected_tax_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocated_taxable_income` SET TAGS ('dbx_business_glossary_term' = 'Allocated Taxable Income');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocated_taxable_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocated_taxable_loss` SET TAGS ('dbx_business_glossary_term' = 'Allocated Taxable Loss');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocated_taxable_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Allocation Number');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocation_period_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Type');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocation_period_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|interim');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Allocation Status');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|superseded|void');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `capital_gain_allocated` SET TAGS ('dbx_business_glossary_term' = 'Capital Gain Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `capital_gain_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `cpa_review_date` SET TAGS ('dbx_business_glossary_term' = 'CPA Review Date');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `cpa_review_status` SET TAGS ('dbx_business_glossary_term' = 'CPA Review Status');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `cpa_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected|requires_amendment');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `cpa_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'CPA Reviewer Name');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `deferred_gain_1031` SET TAGS ('dbx_business_glossary_term' = 'Section 1031 Deferred Gain Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `deferred_gain_1031` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `depreciation_allocated` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `depreciation_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `foreign_tax_credit` SET TAGS ('dbx_business_glossary_term' = 'Foreign Tax Credit Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `foreign_tax_credit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `investor_tax_basis_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Investor Tax Basis Adjustment');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `investor_tax_basis_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `k1_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'K-1 Delivery Method');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `k1_delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|portal|email');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `k1_issue_date` SET TAGS ('dbx_business_glossary_term' = 'K-1 Issue Date');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `k1_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'K-1 Issued Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `long_term_capital_gain` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Capital Gain Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `long_term_capital_gain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Allocation Notes');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `ordinary_dividend_income` SET TAGS ('dbx_business_glossary_term' = 'Ordinary Dividend Income Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `ordinary_dividend_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Investor Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `return_of_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Return of Capital (ROC) Amount Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `return_of_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `section_1031_exchange_flag` SET TAGS ('dbx_business_glossary_term' = 'Section 1031 Like-Kind Exchange Flag');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `section_1231_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Section 1231 Gain/Loss Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `section_1231_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `section_199a_deduction` SET TAGS ('dbx_business_glossary_term' = 'Section 199A Qualified Business Income (QBI) Deduction');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `section_199a_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `state_taxable_income` SET TAGS ('dbx_business_glossary_term' = 'State-Level Taxable Income Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `state_taxable_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `tax_exempt_income` SET TAGS ('dbx_business_glossary_term' = 'Tax-Exempt Income Allocated');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `tax_exempt_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `ubti_amount` SET TAGS ('dbx_business_glossary_term' = 'Unrelated Business Taxable Income (UBTI) Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `ubti_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` SET TAGS ('dbx_subdomain' = 'capital_structure');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `prior_offering_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `carried_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `leverage_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `management_fee_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `maximum_raise_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `minimum_raise_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `preferred_return_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `target_equity_multiple` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `target_irr_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ALTER COLUMN `target_raise_amount` SET TAGS ('dbx_confidential' = 'true');
