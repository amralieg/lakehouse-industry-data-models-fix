-- Schema for Domain: insurance | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`insurance` COMMENT 'Manages property and liability insurance policies, claims, risk assessments, certificates of insurance (COI), and loss run reports across the real estate portfolio. Tracks policy renewals, premium payments, coverage limits, deductibles, and insured values for all asset types.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique surrogate identifier for each insurance policy record in the real estate portfolio. Primary key for the policy master data product.',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: LEED/BREEAM certifications qualify properties for green building insurance endorsements and premium discounts. Real estate portfolio managers and risk managers track which policies carry green buildin',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: All policy financial amounts (annual premium, insured value, coverage limit, deductible) are denominated in a currency. reference.currency_code is the authoritative currency reference for multi-curren',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: Every policy is placed through a broker of record. The policy table stores broker_of_record as a denormalized string. Adding insurance_broker_id FK normalizes broker identity to the in-domain insuranc',
    `insurance_program_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_program. Business justification: Individual policies should roll up to the enterprise insurance program. This is a standard hierarchy in insurance management - policies are components of programs. Enables program-level aggregation an',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: A policy is issued by a specific insurer — this is the most fundamental relationship in the insurance domain. The policy table stores insurer_name and insurer_naic_code as denormalized strings. Adding',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Insurance policies are subject to state-specific surplus lines eligibility, mandatory coverage requirements, and regulatory filing obligations that vary by jurisdiction. Linking policy to compliance j',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (ownership vehicle, LLC, LP, REIT subsidiary) named as the insured on this policy. Links to the legal entity master in SAP S/4HANA financial consolidation.',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Portfolio insurance management requires linking policies to the owner entity (named insured) for owner-level risk reporting, renewal notifications, and compliance tracking. Real estate risk managers p',
    `ownership_structure_id` BIGINT COMMENT 'Foreign key linking to owner.ownership_structure. Business justification: Ownership structures (LLCs, LPs, REITs) are frequently the named insured on blanket portfolio policies. Risk managers must identify which insurance policies cover assets held by a given fund or JV str',
    `asset_id` BIGINT COMMENT 'Reference to the specific property asset covered by this policy, when the policy is asset-level rather than portfolio-level. Links to the property master record in Yardi Voyager Fixed Assets.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Policy form selection and coverage class (commercial property, habitational, industrial) are driven by property type classification. Underwriters use property type to determine applicable policy forms',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Insurance policies must comply with specific regulatory frameworks (state insurance codes, NAIC model acts, CMBS lender requirements, surplus lines regulations). Linking policy to regulatory_framework',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: LEED/BREEAM/ENERGY STAR certified properties receive premium discounts and specialized green building coverage endorsements from carriers. Linking policy to sustainability_rating enables green buildin',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Tenure type (fee simple, leasehold, ground lease, condominium) fundamentally determines what is insurable, who bears the insurance obligation, and what policy form applies. Ground leases require lease',
    `renewed_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (renewed_policy_id)',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'Maximum total amount the insurer will pay for all covered losses during the policy period, regardless of the number of occurrences. Distinct from per-occurrence coverage limit.',
    `annual_premium_amount` DECIMAL(18,2) COMMENT 'Total annual insurance premium payable for this policy, expressed in the policy currency. Used for OPEX budgeting, cost allocation across properties, and insurance cost benchmarking (PSF basis).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this policy is set to automatically renew at expiration without requiring affirmative action. Used to manage renewal workflow and prevent unintended coverage lapses.',
    `cancellation_date` DATE COMMENT 'Date on which the policy was cancelled, if applicable. Populated only when policy_status is cancelled. Used for coverage gap analysis and regulatory compliance tracking.',
    `cancellation_reason` STRING COMMENT 'Reason code for policy cancellation. Distinguishes between non-payment, underwriting-driven cancellation, insured-initiated cancellation, property disposition, coverage replacement, or regulatory action.. Valid values are `non_payment|underwriting|insured_request|property_sold|coverage_replaced|regulatory`',
    `certificate_of_insurance_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Insurance (COI) must be issued and maintained for this policy to satisfy tenant lease obligations, lender requirements, or third-party contractual requirements.',
    `coinsurance_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of the propertys insured value that the policyholder must maintain coverage for to avoid a coinsurance penalty at the time of a claim. Typically 80%, 90%, or 100% of replacement cost value.',
    `coverage_basis` STRING COMMENT 'Valuation method used to settle property claims under this policy. Replacement cost (RC) pays to rebuild at current costs; actual cash value (ACV) deducts depreciation; agreed value eliminates coinsurance requirements.. Valid values are `replacement_cost|actual_cash_value|agreed_value|functional_replacement_cost`',
    `coverage_class` STRING COMMENT 'Broad classification of the insured asset class covered by this policy. Indicates whether the policy covers commercial real estate (CRE), residential, mixed-use, an entire portfolio, or corporate-level exposure.. Valid values are `commercial|residential|mixed_use|portfolio|corporate`',
    `coverage_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount the insurer will pay for a covered loss under this policy per occurrence or in aggregate, as specified in the policy declarations. Critical for risk gap analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was first created in the data platform. Supports audit trail, data lineage, and SOX internal control requirements.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount of loss the insured must absorb before insurance coverage applies per occurrence. Drives self-insured retention (SIR) budgeting and claims reserve calculations.',
    `deductible_type` STRING COMMENT 'Structure of the deductible applied under this policy. Flat deductibles are fixed dollar amounts; percentage deductibles are calculated as a percentage of insured value (common for wind/hail and named storm perils). [ENUM-REF-CANDIDATE: flat|percentage|per_occurrence|aggregate|wind_hail|named_storm — promote to reference product]. Valid values are `flat|percentage|per_occurrence|aggregate|wind_hail|named_storm`',
    `effective_date` DATE COMMENT 'Date on which the insurance policy coverage becomes active and binding. Marks the start of the coverage period for premium accrual and claims eligibility.',
    `endorsements_summary` STRING COMMENT 'Free-text summary of material policy endorsements, riders, and amendments that modify the standard policy form. Captures key coverage extensions, exclusions, and special conditions added to the base policy.',
    `expiration_date` DATE COMMENT 'Date on which the insurance policy coverage terminates. Used for renewal tracking, coverage gap analysis, and compliance reporting. Critical for WALT and WALE-equivalent insurance portfolio analytics.',
    `flood_zone` STRING COMMENT 'FEMA National Flood Insurance Program (NFIP) flood zone designation for the insured property (e.g., AE, X, VE). Determines flood insurance requirements, premium rates, and mandatory purchase obligations under HUD/lender requirements.',
    `form` STRING COMMENT 'Standard policy form number or edition used as the basis for this policy (e.g., ISO CP 00 10, ISO CG 00 01). Identifies the contractual template and coverage breadth (all-risk vs. named-peril).',
    `insured_entity_type` STRING COMMENT 'Classification of the named insured — whether the policy covers a specific legal entity, an individual property asset, an entire portfolio, a joint venture, or a Real Estate Investment Trust (REIT).. Valid values are `legal_entity|property_asset|portfolio|joint_venture|reit`',
    `insured_value` DECIMAL(18,2) COMMENT 'Declared replacement cost or agreed value of the insured property or asset as stated in the policy. Basis for coverage adequacy analysis and coinsurance compliance. Distinct from market value or appraised value.',
    `lender_additional_insured` STRING COMMENT 'Name of the lender or mortgagee listed as an additional insured or loss payee on this policy. Required by lenders as a condition of mortgage financing; critical for Loan-to-Value (LTV) and DSCR covenant compliance.',
    `loss_run_last_requested_date` DATE COMMENT 'Date on which the most recent loss run report was requested from the insurer for this policy. Loss runs document claims history and are required for renewal underwriting and portfolio risk assessments.',
    `policy_number` STRING COMMENT 'Externally-assigned unique identifier issued by the insurer for this policy. Used for all correspondence, claims, and regulatory filings. Maps to the policy number field in Yardi Voyager Fixed Assets and MRI Software.',
    `policy_status` STRING COMMENT 'Current lifecycle state of the insurance policy. Tracks whether the policy is active, expired, cancelled by insurer or insured, non-renewed at term end, pending issuance, or suspended.. Valid values are `active|expired|cancelled|non_renewed|pending|suspended`',
    `policy_type` STRING COMMENT 'Classification of the insurance policy by coverage category. Distinguishes property, general liability, umbrella, workers compensation, flood, earthquake, terrorism, title, and directors and officers (D&O) policies. [ENUM-REF-CANDIDATE: property|general_liability|umbrella|workers_comp|flood|earthquake|terrorism|title|directors_and_officers — promote to reference product]',
    `premium_finance_flag` BOOLEAN COMMENT 'Indicates whether the annual premium for this policy is being financed through a premium finance agreement rather than paid directly. Affects cash flow planning and AP scheduling in Yardi Voyager.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which insurance premium installments are due and payable to the insurer. Drives accounts payable (AP) scheduling in Yardi Voyager and SAP S/4HANA.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `renewal_date` DATE COMMENT 'Target date by which the policy must be renewed or replaced to maintain continuous coverage. May differ from expiration date when renewal negotiations begin in advance.',
    `source_system` STRING COMMENT 'Operational system of record from which this policy record was sourced. Supports data lineage tracking and reconciliation across Yardi Voyager, MRI Software, and Argus Enterprise.. Valid values are `yardi_voyager|mri_software|argus_enterprise|manual|other`',
    `sublimit_business_interruption` DECIMAL(18,2) COMMENT 'Maximum coverage amount for business interruption (loss of rental income / NOI) losses under this policy. Critical for real estate portfolios where rental income continuity is a primary financial exposure.',
    `sublimit_earthquake` DECIMAL(18,2) COMMENT 'Maximum coverage amount specifically applicable to earthquake-related losses under this policy. Earthquake sub-limits are tracked separately due to high seismic risk exposure in certain geographic markets.',
    `sublimit_flood` DECIMAL(18,2) COMMENT 'Maximum coverage amount specifically applicable to flood-related losses under this policy. Flood sub-limits are commonly lower than the overall policy limit and are critical for properties in FEMA flood zones.',
    `terrorism_coverage_flag` BOOLEAN COMMENT 'Indicates whether this policy includes terrorism coverage under the Terrorism Risk Insurance Act (TRIA). Required for TRIA certification and federal backstop compliance reporting for commercial real estate portfolios.',
    `total_insurable_value` DECIMAL(18,2) COMMENT 'Aggregate replacement cost value of all assets covered under this policy, including buildings, improvements, contents, and business interruption exposure. TIV is the primary metric for portfolio-level insurance program sizing and reinsurance treaty negotiations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was most recently modified in the data platform. Used for incremental data pipeline processing, change detection, and audit trail compliance.',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master record for every property and liability insurance policy held across the real estate portfolio. Captures policy number, insurer name, policy type (property, general liability, umbrella, D&O, workers comp, flood, earthquake, terrorism, title), coverage class, policy status (active, expired, cancelled, non-renewed), effective date, expiration date, renewal date, premium amount, payment frequency, insured value, total insurable value (TIV), deductible structure, coverage limits, sub-limits, coinsurance percentage, policy form, endorsements summary, broker of record, and the legal entity or property asset the policy covers. SSOT for all insurance policy master data across the portfolio.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`coverage` (
    `coverage_id` BIGINT COMMENT 'Unique system-generated identifier for each granular coverage line record within an insurance policy. Serves as the primary key for the coverage data product.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Individual coverage lines (property, BI, flood) set their TIV and coverage limits based on appraised values. Coverage underwriting requires linking each coverage line to the appraisal that established',
    `asset_id` BIGINT COMMENT 'Reference to the specific property asset covered under this coverage line when coverage is written on a specific or scheduled basis. Null for blanket coverage lines that span multiple properties.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Coverage lines can be part of blanket groups. The coverage table has blanket_or_specific field indicating coverage type, but no FK to blanket_group. When coverage is blanket, this FK identifies which ',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the insurance broker or intermediary who placed this coverage line on behalf of the insured. Used for broker relationship management and commission tracking.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Blanket policies with per-building coverage sublimits require building-level coverage records. Underwriters assign distinct coverage limits to buildings with different construction types or ages withi',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: Insurance coverage lines for green buildings reference specific LEED/BREEAM certifications to determine green building replacement cost endorsements and premium adjustments. The existing leed_certifie',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Coverage limits, sub-limits, deductibles, and annual premiums are currency-denominated financial amounts requiring authoritative currency reference for multi-currency portfolio reporting and regulator',
    `insurer_id` BIGINT COMMENT 'FK to insurance.insurer',
    `policy_id` BIGINT COMMENT 'Reference to the parent insurance policy under which this coverage line is written. One policy may carry multiple coverage lines across different perils or layers.',
    `underlying_coverage_id` BIGINT COMMENT 'Self-referencing FK on coverage (underlying_coverage_id)',
    `additional_insured` STRING COMMENT 'Name(s) of additional parties (e.g., lenders, property managers, tenants) granted insured status under this coverage line. Required for lender compliance and lease covenant verification.',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative amount the insurer will pay across all loss occurrences during the policy period for this coverage line. Once exhausted, no further claims are paid until renewal.',
    `agreed_value_endorsement` BOOLEAN COMMENT 'Indicates whether an agreed value endorsement is in effect for this coverage line, suspending the coinsurance clause and fixing the insured value at the agreed amount. True = agreed value applies; False = standard coinsurance applies.',
    `annual_premium` DECIMAL(18,2) COMMENT 'Total annual premium charged by the insurer for this coverage line. Used for budget allocation, OPEX tracking, and per-asset insurance cost analysis.',
    `asset_class` STRING COMMENT 'Real estate asset class of the insured property associated with this coverage line. Drives underwriting segmentation, premium benchmarking, and portfolio-level risk aggregation. [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|hospitality|mixed_use|land|healthcare|self_storage|data_center — promote to reference product]',
    `auto_renew` BOOLEAN COMMENT 'Indicates whether this coverage line is set to automatically renew upon expiration without requiring affirmative action. True = auto-renews; False = manual renewal required.',
    `blanket_or_specific` STRING COMMENT 'Indicates whether this coverage line applies on a blanket basis (covering multiple properties under a single limit), a specific basis (dedicated limit per property), or a scheduled basis (named locations with individual values).. Valid values are `blanket|specific|scheduled`',
    `cancellation_date` DATE COMMENT 'Date on which this coverage line was cancelled prior to its scheduled expiration. Null if coverage has not been cancelled. Required for compliance gap reporting and lender notification obligations.',
    `cancellation_reason` STRING COMMENT 'Reason code explaining why this coverage line was cancelled before its expiration date. Null if coverage has not been cancelled. Supports root-cause analysis of coverage gaps.. Valid values are `non_payment|underwriter_withdrawal|insured_request|property_sold|policy_replacement|other`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of the propertys insurable value that the insured must carry as coverage to avoid a coinsurance penalty at the time of loss. Typically 80%, 90%, or 100%. Null when agreed_value_endorsement is True.',
    `coverage_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount the insurer will pay for a covered loss under this coverage line. Represents the per-occurrence or per-policy-period ceiling for indemnification.',
    `coverage_status` STRING COMMENT 'Current lifecycle state of this coverage line. Indicates whether the coverage is currently in force, has lapsed, been cancelled, or is pending binding.. Valid values are `active|expired|cancelled|pending|suspended`',
    `coverage_type` STRING COMMENT 'Classification of the peril or coverage layer this line represents. Drives per-peril limit analysis and gap identification across the real estate portfolio. [ENUM-REF-CANDIDATE: building|business_interruption|general_liability|umbrella|flood|earthquake|terrorism|boiler_and_machinery|wind|hail|cyber|directors_and_officers|errors_and_omissions|workers_compensation|auto — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage line record was first created in the system. Supports audit trail requirements under SOX and data lineage tracking in the Databricks Silver Layer.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the insured must absorb before the insurers obligation is triggered. Applicable when deductible_type is per_occurrence or aggregate.',
    `deductible_percentage` DECIMAL(18,2) COMMENT 'Percentage of the Total Insured Value (TIV) applied as the deductible when deductible_type is percentage_of_tiv. For example, 2.00 represents a 2% of TIV deductible. Null when deductible_type is not percentage-based.',
    `deductible_type` STRING COMMENT 'Specifies the structure of the deductible obligation: per-occurrence (each loss event), aggregate (cumulative annual cap), or percentage of Total Insured Value (TIV) — common for wind and earthquake perils.. Valid values are `per_occurrence|aggregate|percentage_of_tiv|straight|franchise`',
    `effective_date` DATE COMMENT 'Date on which this coverage line becomes active and binding. Marks the start of the insured period for this specific peril or layer.',
    `endorsement_number` STRING COMMENT 'Identifier for any endorsement or rider that modifies the base coverage terms for this line. Null if no endorsement applies. Enables tracking of mid-term coverage changes.',
    `expiration_date` DATE COMMENT 'Date on which this coverage line expires and ceases to be in force. Used for renewal tracking, gap analysis, and compliance reporting across the portfolio.',
    `indemnity_period_months` STRING COMMENT 'Maximum number of months for which business interruption or rental income loss benefits will be paid following a covered loss. Defines the time-element exposure window for income-producing properties.',
    `line_number` STRING COMMENT 'Sequential line number ordering this coverage record within its parent policy. Enables per-peril ordering and gap analysis across all coverage layers on a single policy.',
    `loss_payee` STRING COMMENT 'Name of the lender or mortgagee designated to receive insurance proceeds in the event of a covered loss, as required by the loan agreement. Typically the mortgage lender per CMBS or RMBS requirements.',
    `named_insured` STRING COMMENT 'Legal name of the entity designated as the primary insured on this coverage line. May be a property-owning entity, REIT, LLC, or operating company. Required for certificate of insurance (COI) issuance.',
    `notes` STRING COMMENT 'Free-text field for underwriter annotations, special conditions, exclusions, or coverage nuances that do not fit structured fields. Examples include named storm exclusions, mold exclusions, or manuscript endorsement details.',
    `occurrence_limit` DECIMAL(18,2) COMMENT 'Maximum amount payable by the insurer for any single loss occurrence under this coverage line. Distinct from the aggregate limit; critical for catastrophic event exposure analysis.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which premium installments are due to the insurer for this coverage line. Drives accounts payable scheduling in Yardi Voyager and SAP S/4HANA.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `renewal_date` DATE COMMENT 'Date on which this coverage line is scheduled for renewal. Drives automated renewal workflow, premium negotiation timelines, and compliance gap monitoring.',
    `sub_limit` DECIMAL(18,2) COMMENT 'A lower maximum payout cap applicable to a specific category of loss within the broader coverage limit (e.g., a flood sub-limit within an all-risk property policy). Null if no sub-limit applies.',
    `territory` STRING COMMENT 'Geographic scope within which this coverage line provides protection. Expressed as a country code (ISO 3166-1 alpha-3), state/province code, or named territory (e.g., USA, CAN, WORLDWIDE). Defines jurisdictional boundaries of the insured risk.',
    `tiv` DECIMAL(18,2) COMMENT 'Total Insured Value (TIV) assigned to the assets covered under this coverage line. Represents the maximum replacement or agreed value used as the basis for premium calculation and percentage deductibles.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this coverage line record. Used for change data capture (CDC), audit compliance, and Silver Layer incremental processing in Databricks.',
    `valuation_basis` STRING COMMENT 'Basis on which the insured value and loss settlement are calculated: Replacement Cost (RC) — cost to rebuild at current prices; Actual Cash Value (ACV) — replacement cost less depreciation; Agreed Value — pre-agreed amount with no coinsurance penalty.. Valid values are `replacement_cost|actual_cash_value|agreed_value|functional_replacement_cost`',
    `waiting_period_days` STRING COMMENT 'Number of days following a covered loss event before business interruption or time-element coverage benefits begin to accrue. Relevant for business interruption and rental income loss coverages.',
    CONSTRAINT pk_coverage PRIMARY KEY(`coverage_id`)
) COMMENT 'Granular coverage line record defining each distinct coverage layer or peril within an insurance policy. Captures coverage type (building, business interruption, general liability, umbrella, flood, earthquake, terrorism, boiler and machinery), coverage limit, sub-limit, deductible amount, deductible type (per-occurrence, aggregate, percentage of TIV), coinsurance clause, agreed value endorsement flag, replacement cost vs. actual cash value basis, coverage territory, and effective/expiration dates. One policy may have multiple coverage lines. Enables per-peril limit analysis and gap identification.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`insured_property` (
    `insured_property_id` BIGINT COMMENT 'Unique surrogate identifier for the insured property record linking an insurance policy to a specific real estate asset in the portfolio.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Per-location insured values and replacement cost values on the insurance schedule are set from formal appraisals. Insurance-to-value (ITV) compliance requires linking each scheduled property to its go',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: International real estate portfolios measure building area in sqft (US) or sqm (international). SOV preparation and TIV calculations require authoritative UOM reference to ensure consistent area-based',
    `asset_id` BIGINT COMMENT 'Reference to the real estate asset (property, building, or parcel) covered under this insurance policy schedule.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Properties can be insured under blanket coverage groups rather than (or in addition to) specific policies. This is a common insurance structure where multiple properties are covered under a single bla',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Building class (A/B/C) is a standard underwriting factor that determines replacement cost benchmarks (PSF rent ranges, typical vacancy rates), coverage tier eligibility, and investment-grade status. U',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Insurance SOV scheduling occurs at the building level for multi-building assets. Underwriters require building-specific attributes (construction type, year built, stories) to price coverage. Real esta',
    `construction_type_id` BIGINT COMMENT 'Foreign key linking to reference.construction_type. Business justification: Construction type (ISO/IBC class) is a primary underwriting factor determining fire resistance rating, replacement cost multiplier, and insurance class code. construction_type on insured_property is',
    `cost_approach_id` BIGINT COMMENT 'Foreign key linking to valuation.cost_approach. Business justification: The cost approach valuation directly produces insurance replacement cost value (RCV) used to schedule each insured property location. Insurance-to-value (ITV) analysis and coinsurance compliance requi',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Geographic hierarchy enables catastrophe zone aggregation, submarket-level TIV concentration reporting, and regulatory jurisdiction assignment for insured property schedules — all standard insurance p',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Tenant industry classification (NAICS/SIC) drives occupancy hazard rating — a primary underwriting factor for commercial property insurance. Hazmat tenants, food service, and auto repair create higher',
    `lease_demised_space_id` BIGINT COMMENT 'Foreign key linking to lease.demised_space. Business justification: In multi-tenant buildings, each demised space (leased unit) may be individually scheduled as an insured location in the property insurance policy. Linking insured_property to the specific demised spac',
    `policy_id` BIGINT COMMENT 'Reference to the parent insurance policy under which this property is covered.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type is a primary underwriting factor for scheduled property insurance — it determines replacement cost benchmarks, fire resistance requirements, and coverage eligibility. occupancy_type is',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Space use type (retail, office, industrial, medical) determines occupancy hazard classification for underwriting mixed-use properties. Medical office and food service uses carry higher liability and f',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: Sustainability certification level (LEED Gold vs. Platinum, BREEAM Excellent vs. Outstanding) determines green building coverage endorsements, premium adjustments, and replacement cost calculations. ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential condo and apartment policies schedule individual units for replacement cost valuation. Condo association master policies and individual unit owner policies require unit-level insured prope',
    `zoning_code_id` BIGINT COMMENT 'Foreign key linking to reference.zoning_code. Business justification: Zoning classification determines ordinance-or-law coverage requirements and rebuilding cost estimates — a standard underwriting consideration. Non-conforming zoning triggers ordinance-law sublimits. R',
    `master_insured_property_id` BIGINT COMMENT 'Self-referencing FK on insured_property (master_insured_property_id)',
    `actual_cash_value` DECIMAL(18,2) COMMENT 'Replacement cost value less physical depreciation at the time of loss. Represents the ACV basis for settlement on policies that do not provide full replacement cost coverage.',
    `agreed_value` BOOLEAN COMMENT 'Indicates whether an agreed value endorsement is in effect for this property, suspending the coinsurance clause and agreeing that the stated insured value is the full insurable value.',
    `alarm_system_type` STRING COMMENT 'Type of fire and/or burglar alarm system installed at the insured property. Part of COPE protection data. Central station and governmental monitoring typically qualify for premium credits.. Valid values are `none|local|central_station|proprietary|governmental`',
    `building_area_sqft` DECIMAL(18,2) COMMENT 'Total gross building area in square feet (SQF) of the insured structure. Used for per-square-foot (PSF) insured value benchmarking and underwriting adequacy analysis.',
    `building_limit` DECIMAL(18,2) COMMENT 'Maximum insurance payout for the building structure at this location under the policy. Represents the per-location building coverage limit as stated on the policy schedule.',
    `business_interruption_limit` DECIMAL(18,2) COMMENT 'Maximum insurance payout for loss of rental income or business income resulting from a covered property loss at this location. Supports NOI protection analysis.',
    `coi_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Insurance (COI) must be issued and maintained for this property location, typically required by lenders, tenants, or joint venture partners.',
    `coinsurance_pct` DECIMAL(18,2) COMMENT 'The coinsurance requirement percentage (e.g., 80%, 90%, 100%) stipulated in the policy for this property. If the insured value falls below this percentage of the propertys full value, a coinsurance penalty applies at the time of loss.',
    `contents_limit` DECIMAL(18,2) COMMENT 'Maximum insurance payout for personal property and contents at this location. Covers furniture, fixtures, equipment, and tenant improvements owned by the insured.',
    `coverage_status` STRING COMMENT 'Current lifecycle status of this propertys coverage under the associated policy. Indicates whether the property is actively insured, temporarily suspended, excluded from coverage, or pending addition.. Valid values are `active|suspended|excluded|expired|pending`',
    `coverage_type` STRING COMMENT 'Indicates whether this property is covered as a scheduled location (individually listed with specific limits) or under a blanket coverage arrangement (shared limit across multiple properties).. Valid values are `scheduled|blanket`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this insured property record (e.g., USD, EUR, GBP). Supports multi-currency portfolio reporting.. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount applicable to this specific property location for a covered loss event. May differ from the policy-level deductible if location-specific deductibles are negotiated.',
    `deductible_type` STRING COMMENT 'Classification of the deductible structure applied to this property location. Flat deductibles are fixed dollar amounts; percentage deductibles are calculated as a percentage of TIV or insured value.. Valid values are `flat|percentage|per_occurrence|annual_aggregate`',
    `effective_date` DATE COMMENT 'Date on which this propertys coverage under the policy becomes effective. May differ from the policy inception date if the property was added mid-term.',
    `expiry_date` DATE COMMENT 'Date on which this propertys coverage under the policy expires. Typically aligns with the policy expiry date unless the property is removed mid-term.',
    `flood_zone_designation` STRING COMMENT 'FEMA National Flood Insurance Program (NFIP) flood zone designation for the property location (e.g., AE, X, VE, AO). Determines flood insurance requirements and premium loading. [ENUM-REF-CANDIDATE: A|AE|AH|AO|AR|A99|V|VE|X|D|B|C — promote to reference product]',
    `insured_value` DECIMAL(18,2) COMMENT 'The declared insured value of the property at policy inception as stated on the statement of values (SOV). Used as the basis for premium calculation and TIV roll-up reporting.',
    `lender_loss_payee` STRING COMMENT 'Name of the mortgage lender or lienholder designated as a loss payee on the policy for this property. Required by lenders as a condition of the loan per standard mortgage agreements.',
    `loss_payee_loan_number` STRING COMMENT 'Mortgage or loan reference number associated with the lender loss payee for this insured property. Used to match insurance certificates to loan files in CMBS and lender reporting.',
    `notes` STRING COMMENT 'Free-text field for underwriting notes, special conditions, endorsements, or coverage exceptions specific to this insured property location that are not captured in structured fields.',
    `number_of_stories` STRING COMMENT 'Total number of above-grade floors in the insured building. Used in underwriting risk assessment and fire/seismic exposure modeling.',
    `ordinance_law_limit` DECIMAL(18,2) COMMENT 'Coverage limit for additional costs incurred to comply with current building codes and ordinances when repairing or rebuilding after a covered loss. Particularly relevant for older buildings subject to code upgrades.',
    `protection_class` STRING COMMENT 'ISO Public Protection Classification (PPC) rating from 1 (best fire protection) to 10 (no recognized protection), assigned by ISO based on proximity to fire stations and water supply. Part of COPE underwriting data and a key driver of property insurance premiums.. Valid values are `^([1-9]|10|10W)$`',
    `replacement_cost_value` DECIMAL(18,2) COMMENT 'Estimated cost to replace or rebuild the insured property to its pre-loss condition using current materials and labor, without deduction for depreciation. Used for RCV-basis policies.',
    `roof_type` STRING COMMENT 'Classification of the roof covering material and construction type (e.g., built-up, single-ply membrane, metal, tile, shingle). Affects wind and hail loss exposure in underwriting. [ENUM-REF-CANDIDATE: built_up|single_ply|metal|tile|shingle|modified_bitumen|other — promote to reference product]',
    `roof_year_updated` STRING COMMENT 'Year in which the roof was last replaced or substantially updated. Used in underwriting to assess roof age and condition, which affects wind/hail loss exposure and premium.',
    `schedule_location_number` STRING COMMENT 'Externally-known location number assigned by the insurer on the policy schedule, used to uniquely identify this property within the policys statement of values (SOV).',
    `scheduled_address_city` STRING COMMENT 'City of the insured propertys scheduled address as listed on the policy schedule.',
    `scheduled_address_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the insured propertys scheduled address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `scheduled_address_line1` STRING COMMENT 'Primary street address of the insured property as listed on the insurance policy schedule. This is the official insured location address used for claims and coverage verification.',
    `scheduled_address_postal_code` STRING COMMENT 'ZIP or postal code of the insured propertys scheduled address as listed on the policy schedule.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `scheduled_address_state` STRING COMMENT 'Two-letter US state code (or equivalent province/territory code) of the insured propertys scheduled address.. Valid values are `^[A-Z]{2}$`',
    `seismic_zone` STRING COMMENT 'Seismic hazard zone designation for the property location based on USGS or local building code classifications. Used for earthquake coverage underwriting and premium determination. [ENUM-REF-CANDIDATE: zone_0|zone_1|zone_2a|zone_2b|zone_3|zone_4 — promote to reference product]',
    `sprinkler_system` BOOLEAN COMMENT 'Indicates whether the insured building is equipped with an automatic fire sprinkler system. Part of COPE protection data; presence of sprinklers typically reduces property insurance premiums.',
    `tiv` DECIMAL(18,2) COMMENT 'Total Insured Value for this location, representing the sum of all insurable interests (building, contents, business interruption, etc.) at this property. Used for portfolio-level TIV roll-up and reinsurance reporting.',
    `wind_zone` STRING COMMENT 'Wind hazard zone designation for the property, used for hurricane and windstorm coverage underwriting. Particularly relevant for coastal properties subject to named-storm deductibles.',
    `year_built` STRING COMMENT 'The year in which the insured building was originally constructed. Used in underwriting risk assessment and depreciation calculations for ACV determination.',
    CONSTRAINT pk_insured_property PRIMARY KEY(`insured_property_id`)
) COMMENT 'Association entity linking an insurance policy to the specific real estate assets (properties, buildings, parcels) covered under that policy. Captures insured property reference, scheduled property address, insured value at policy inception, replacement cost value (RCV), actual cash value (ACV), building square footage, year built, construction type, occupancy type, protection class, COPE (Construction, Occupancy, Protection, Exposure) data, flood zone designation, seismic zone, and whether the property is a scheduled location or blanket-covered. Supports TIV roll-up and per-location coverage analysis.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`statement_of_values` (
    `statement_of_values_id` BIGINT COMMENT 'Unique system-generated identifier for the Statement of Values record. Primary key for this entity.',
    `appraisal_id` BIGINT COMMENT 'Reference to the formal property appraisal or valuation report that supports the insured values declared in this SOV.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: SOV total GLA area measurements require authoritative UOM reference for international portfolio submissions. Insurers require consistent area measurement standards across the SOV for coinsurance compl',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Statements of Values can be submitted for blanket groups as well as individual policies. This supports blanket coverage SOV tracking where the SOV lists all properties covered under the blanket.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Total insurable value, building value, contents value, and business interruption value on the SOV are currency-denominated. Authoritative currency reference is required for insurer submission, coinsur',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: A Statement of Values is submitted to the insurer through the broker of record. The statement_of_values table stores broker_name as a denormalized string. Adding insurance_broker_id FK normalizes brok',
    `insurer_id` BIGINT COMMENT 'Reference to the insurance carrier or underwriter to whom this SOV is submitted.',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy for which this Statement of Values is submitted. Links the SOV to its governing policy record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Real estate risk management employees prepare and submit SOVs to insurers for policy underwriting and renewal. Linking to employee supports accountability, enables credential verification of the prepa',
    `prior_sov_statement_of_values_id` BIGINT COMMENT 'Reference to the immediately preceding version of this SOV, enabling version chain tracking for audit and coinsurance compliance purposes.',
    `prior_statement_of_values_id` BIGINT COMMENT 'Self-referencing FK on statement_of_values (prior_statement_of_values_id)',
    `acknowledgement_date` DATE COMMENT 'Date on which the insurer formally acknowledged receipt and acceptance of this SOV submission.',
    `appraisal_date` DATE COMMENT 'Date of the most recent formal property appraisal or replacement cost study that underpins the insured values declared in this SOV.',
    `appraisal_firm` STRING COMMENT 'Name of the independent appraisal or valuation firm that conducted the replacement cost study supporting the insured values in this SOV.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized signatory (e.g., CFO, Risk Manager, Asset Manager) who approved this SOV prior to submission to the insurer.',
    `approved_date` DATE COMMENT 'Date on which this SOV was internally approved by the authorized signatory prior to submission.',
    `asset_class` STRING COMMENT 'Primary real estate asset class of the properties covered by this SOV. Used to segment insured values by property type for underwriting and portfolio analytics. [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|hospitality|mixed_use|land|other — promote to reference product if additional classes are needed]',
    `building_value` DECIMAL(18,2) COMMENT 'Total insured value attributable to building structures across all scheduled properties in this SOV. Excludes land, contents, and business interruption values.',
    `business_interruption_value` DECIMAL(18,2) COMMENT 'Total insured value for business interruption or loss of rental income coverage across all scheduled properties. Represents the maximum indemnity period exposure declared to the insurer.',
    `catastrophe_exposed` BOOLEAN COMMENT 'Indicates whether any properties in this SOV are located in designated catastrophe-exposed zones (e.g., hurricane, earthquake, flood, wildfire zones). True if one or more locations carry catastrophe exposure.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance clause percentage required by the insurer, typically 80%, 90%, or 100% of replacement cost. If the declared TIV falls below this percentage of actual replacement cost, the insured bears a proportional share of any loss.',
    `contents_value` DECIMAL(18,2) COMMENT 'Total insured value for personal property, equipment, and contents across all scheduled properties in this SOV.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this SOV record was first created in the data platform. Used for audit trail and data lineage purposes.',
    `effective_date` DATE COMMENT 'Date from which the insured values and property schedule declared in this SOV become effective for coverage purposes. Typically aligns with policy inception or mid-term endorsement date.',
    `expiry_date` DATE COMMENT 'Date on which this SOV version ceases to be effective, typically the policy renewal date or the date superseded by a revised SOV.',
    `flood_zone_locations` STRING COMMENT 'Count of properties in this SOV located within FEMA-designated Special Flood Hazard Areas (SFHA) or equivalent flood risk zones. Used to assess flood sublimit adequacy.',
    `geographic_scope` STRING COMMENT 'Description of the geographic coverage of this SOV, such as the states, regions, or countries in which the scheduled properties are located. Used by insurers to assess catastrophe exposure zones.',
    `insured_entity_name` STRING COMMENT 'Legal name of the entity (owner, REIT, LLC, partnership, or other legal structure) declared as the named insured on the policy to which this SOV relates.',
    `insurer_reference_number` STRING COMMENT 'Reference number assigned by the insurer upon acknowledgement or acceptance of this SOV submission. Used for correspondence and claim reconciliation.',
    `location_count` STRING COMMENT 'Total count of distinct property locations (insured sites) scheduled in this SOV. Used by insurers to assess portfolio concentration risk and set per-location sublimits.',
    `notes` STRING COMMENT 'Free-text field for additional context, underwriter instructions, special conditions, or explanatory remarks associated with this SOV submission.',
    `portfolio_name` STRING COMMENT 'Name of the real estate portfolio or asset pool covered by this SOV, as defined in the investment management system (e.g., MRI Software or Argus Enterprise). Used to segment insured values by portfolio for reporting.',
    `properties_added` STRING COMMENT 'Number of new property locations added to the schedule in this SOV version compared to the prior version. Zero for initial submissions.',
    `properties_removed` STRING COMMENT 'Number of property locations removed from the schedule in this SOV version compared to the prior version due to dispositions or deletions.',
    `revision_reason` STRING COMMENT 'Business reason for creating this SOV version. Captures whether the revision was triggered by a property acquisition, disposition, insured value update, coverage structure change, data correction, or annual renewal. [ENUM-REF-CANDIDATE: property_acquisition|property_disposition|value_update|coverage_change|correction|annual_renewal|other — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Operational system of record from which property and value data was extracted to compile this SOV (e.g., Yardi Voyager for property and fixed asset data, Argus Enterprise for valuation data, MRI Software for investment management data).. Valid values are `yardi_voyager|mri_software|argus_enterprise|manual|other`',
    `sov_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to this SOV submission, used in correspondence with insurers and brokers.. Valid values are `^SOV-[A-Z0-9]{4,20}$`',
    `sov_type` STRING COMMENT 'Classification of the SOV submission trigger. Inception is the initial SOV at policy start; Renewal is the annual re-submission; Mid-term Addition reflects newly acquired properties; Mid-term Deletion reflects disposed properties; Mid-term Revision reflects value changes.. Valid values are `inception|renewal|mid_term_addition|mid_term_deletion|mid_term_revision`',
    `submission_date` DATE COMMENT 'Calendar date on which this SOV was formally submitted to the insurer or broker. Represents the principal business event date for this record.',
    `submission_status` STRING COMMENT 'Current workflow status of the SOV submission. Draft indicates preparation in progress; submitted indicates sent to insurer; acknowledged indicates receipt confirmed; accepted indicates insurer has bound coverage on this SOV; rejected indicates insurer has declined; superseded indicates replaced by a newer version.. Valid values are `draft|submitted|acknowledged|accepted|rejected|superseded`',
    `total_gla_sqft` DECIMAL(18,2) COMMENT 'Aggregate Gross Leasable Area (GLA) in square feet across all properties scheduled in this SOV. Used to compute per-square-foot insured values and benchmark against market replacement cost rates.',
    `total_insurable_value` DECIMAL(18,2) COMMENT 'The aggregate insured value of all properties scheduled in this SOV, expressed in the policy currency. TIV is the sum of all individual property insured values and is the primary figure used by insurers to set premiums and coinsurance requirements. Critical for avoiding coinsurance penalties at claim time.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this SOV record was most recently modified in the data platform. Used for change tracking and audit compliance.',
    `valuation_basis` STRING COMMENT 'The methodology used to determine insured values for properties listed in this SOV. Replacement Cost (RC) represents the cost to rebuild at current prices; Actual Cash Value (ACV) is replacement cost less depreciation; Agreed Value is a pre-agreed fixed amount; Functional Replacement Cost applies to older buildings rebuilt to modern standards; Market Value reflects current open-market price.. Valid values are `replacement_cost|actual_cash_value|agreed_value|functional_replacement_cost|market_value`',
    `version_number` STRING COMMENT 'Sequential version number of this SOV, incremented each time the SOV is revised mid-term due to property acquisitions, dispositions, or value changes. Version 1 represents the initial submission at policy inception.',
    CONSTRAINT pk_statement_of_values PRIMARY KEY(`statement_of_values_id`)
) COMMENT 'Periodic Statement of Values (SOV) record submitted to insurers at policy inception and renewal, listing all scheduled properties and their insured values. Captures SOV version, submission date, total insurable value (TIV), number of locations, valuation basis (replacement cost, ACV, agreed value), appraisal reference, and submission status. Tracks SOV revisions mid-term when properties are acquired or disposed. Critical for ensuring adequate coverage and avoiding coinsurance penalties at claim time.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`premium` (
    `premium_id` BIGINT COMMENT 'Unique system-generated identifier for each insurance premium billing and payment record in the real estate portfolio.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Insurance premiums are paid via AP invoices in RE operations. Linking the premium billing record to the AP invoice supports premium payment reconciliation, audit trail, and period-close AP/insurance e',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Insurance premiums are coded to specific GL accounts for operating expense categorization, NOI reporting, and CAM recovery calculations. premium.gl_account_code is a plain-text denormalization. FK to ',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center to which this premium charge is allocated for GL reporting and OPEX tracking.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Premium billing amounts, broker commissions, surplus lines taxes, and earned/unearned premium calculations require authoritative currency reference for GL posting, financial reporting, and multi-curre',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: Premium billing records include broker commission amounts (broker_commission_amount, broker_commission_rate), indicating a direct relationship between premium transactions and the placing broker. Addi',
    `insurance_program_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_program. Business justification: Premium billing can be tracked at the program level for consolidated billing structures. Enables program-level premium aggregation and financial reporting.',
    `insurer_id` BIGINT COMMENT 'Reference to the insurance carrier or underwriter responsible for the policy associated with this premium.',
    `policy_id` BIGINT COMMENT 'Reference to the parent insurance policy for which this premium record is generated.',
    `reversed_premium_id` BIGINT COMMENT 'Self-referencing FK on premium (reversed_premium_id)',
    `audit_adjustment_amount` DECIMAL(18,2) COMMENT 'Retrospective premium adjustment resulting from a policy audit (e.g., workers comp or general liability audit based on actual payroll or revenue). Positive = additional premium owed; negative = return premium.',
    `audit_period_end_date` DATE COMMENT 'End date of the exposure period covered by a premium audit. Populated only when premium_type is audit.',
    `audit_period_start_date` DATE COMMENT 'Start date of the exposure period covered by a premium audit. Populated only when premium_type is audit.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Gross premium amount invoiced by the carrier for this billing period before any adjustments, taxes, or fees. Expressed in the policy currency.',
    `billing_frequency` STRING COMMENT 'Frequency at which premium installments are billed: annual (single payment), semi-annual, quarterly, or monthly. Drives cash flow forecasting and AP scheduling.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `billing_period_end_date` DATE COMMENT 'Last date of the billing period covered by this premium installment or charge.',
    `billing_period_start_date` DATE COMMENT 'First date of the billing period covered by this premium installment or charge.',
    `broker_commission_amount` DECIMAL(18,2) COMMENT 'Dollar amount of broker or agent commission deducted from the gross premium. Used for cost allocation and broker performance reporting.',
    `broker_commission_rate` DECIMAL(18,2) COMMENT 'Percentage rate of broker commission applied to the gross premium, expressed as a decimal (e.g., 0.1000 = 10%). Supports commission reconciliation and cost benchmarking.',
    `coverage_type` STRING COMMENT 'Type of insurance coverage associated with this premium charge. [ENUM-REF-CANDIDATE: property|liability|casualty|umbrella|flood|earthquake|workers_comp|cyber|directors_officers|environmental — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premium record was first created in the system, used for audit trail and data lineage tracking per SOX controls.',
    `due_date` DATE COMMENT 'Date by which the premium payment must be received by the carrier to maintain coverage without lapse or penalty.',
    `earned_premium_amount` DECIMAL(18,2) COMMENT 'Portion of the billed premium that has been earned (i.e., the coverage period has elapsed). Used for FASB ASC 944 revenue recognition and financial period-close reporting.',
    `finance_agreement_number` STRING COMMENT 'Reference number of the premium finance agreement when the premium is financed. Used for reconciliation with the finance company.',
    `finance_company_name` STRING COMMENT 'Name of the premium finance company providing financing for this premium when is_premium_financed is true. Required for finance agreement tracking.',
    `installment_number` STRING COMMENT 'Sequential installment number within the policy term payment schedule (e.g., 1 of 4 for quarterly billing). Enables tracking of partial payment plans.',
    `invoice_number` STRING COMMENT 'Externally-issued invoice or billing reference number provided by the insurance carrier for this premium charge. Used for AP reconciliation in Yardi Voyager and SAP S/4HANA.',
    `is_premium_financed` BOOLEAN COMMENT 'Indicates whether the premium is being financed through a third-party premium finance company rather than paid directly by the insured.',
    `is_surplus_lines` BOOLEAN COMMENT 'Indicates whether this premium is associated with a surplus lines (non-admitted) insurance policy, triggering surplus lines tax and stamping fee obligations.',
    `late_payment_fee_amount` DECIMAL(18,2) COMMENT 'Penalty fee assessed by the carrier for late premium payment. Tracked separately for cost analysis and vendor dispute management.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Premium amount net of broker commission and applicable fees. Represents the actual cost of risk transfer retained by the carrier after deducting distribution costs.',
    `notes` STRING COMMENT 'Free-text field for underwriter comments, billing disputes, payment plan details, or other operational notes related to this premium record.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Actual amount remitted to the carrier for this premium record. May differ from billed_amount due to partial payments, credits, or adjustments.',
    `payment_date` DATE COMMENT 'Date on which the premium payment was actually remitted or confirmed as received by the carrier. Used for cash flow reporting and lapse risk monitoring.',
    `payment_method` STRING COMMENT 'Instrument used to remit the premium payment: ACH (Automated Clearing House), wire transfer, check, credit card, escrow disbursement, or premium financing arrangement.. Valid values are `ach|wire|check|credit_card|escrow|financing`',
    `payment_reference` STRING COMMENT 'Bank transaction reference, check number, ACH trace number, or wire confirmation number associated with the premium payment. Used for AP reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the premium payment record: current (within due date), past_due (overdue but policy active), lapsed (coverage suspended due to non-payment), paid (fully settled), cancelled (policy cancelled), or pending (payment initiated but not confirmed).. Valid values are `current|past_due|lapsed|paid|cancelled|pending`',
    `premium_type` STRING COMMENT 'Classification of the premium charge: base (standard policy premium), endorsement (additional coverage added mid-term), audit (retrospective adjustment based on actual exposure), minimum earned (non-refundable floor), or return (credit back to insured). [ENUM-REF-CANDIDATE: base|endorsement|audit|minimum_earned|return|cancellation — promote to reference product]. Valid values are `base|endorsement|audit|minimum_earned|return`',
    `property_allocation_method` STRING COMMENT 'Method used to allocate the premium cost across properties in the portfolio: by insured value (TIV), by square footage (SQF/SQM), equal split, or manual override. Supports property-level cost reporting.. Valid values are `insured_value|square_footage|equal_split|manual`',
    `stamping_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the surplus lines stamping office for filing and recording the surplus lines policy. Applicable in states with mandatory stamping office requirements.',
    `surplus_lines_tax_amount` DECIMAL(18,2) COMMENT 'State-mandated tax applied to surplus lines (non-admitted) insurance premiums. Required for regulatory compliance reporting in jurisdictions where the carrier is not admitted.',
    `total_installments` STRING COMMENT 'Total number of installments in the premium payment schedule for the policy term (e.g., 4 for quarterly, 12 for monthly). Used to track payment plan completion.',
    `unearned_premium_amount` DECIMAL(18,2) COMMENT 'Portion of the billed premium that has not yet been earned because the coverage period has not elapsed. Represents a liability on the balance sheet per FASB ASC 944.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this premium record. Supports change tracking, reconciliation, and SOX audit trail requirements.',
    CONSTRAINT pk_premium PRIMARY KEY(`premium_id`)
) COMMENT 'Insurance premium billing and payment record tracking all premium charges, installments, and payments for each policy. Captures premium type (base premium, endorsement premium, audit premium, minimum earned premium), billing period, due date, amount billed, amount paid, payment date, payment method, carrier invoice reference, surplus lines tax, stamping fee, broker commission, net premium, and payment status (current, past due, lapsed). Supports premium allocation across properties and cost centers for financial reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique system-generated identifier for each insurance claim record in the real estate portfolio. Primary key for the claim entity.',
    `adjuster_id` BIGINT COMMENT 'Foreign key linking to insurance.adjuster. Business justification: Every insurance claim is assigned to an adjuster for evaluation and settlement. The claim table currently stores adjuster_name and adjuster_company as denormalized strings. Adding adjuster_id FK to th',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Post-loss claim settlement requires a pre-loss or replacement-cost appraisal to establish the insured value basis for payment. Adjusters reference the governing appraisal to determine actual cash valu',
    `asset_id` BIGINT COMMENT 'Reference to the specific real estate asset (property) against which the loss event occurred. Enables portfolio-level loss aggregation and property risk analytics.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Claims can be filed against blanket coverage groups. When a loss occurs on a property covered under blanket insurance, the claim references the blanket group to determine coverage limits and deductibl',
    `bpo_id` BIGINT COMMENT 'Foreign key linking to valuation.bpo. Business justification: Residential insurance claim settlements frequently use a Broker Price Opinion (BPO) for quick-sale or as-repaired value when a full appraisal is not warranted. Adjusters order BPOs to establish loss q',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Claims are filed against specific buildings within a multi-building asset (e.g., fire at Building A). Building-level loss history is required for renewal underwriting, per-building loss ratio reportin',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Claim reserve amounts, total incurred losses, paid losses, and net claim payments are currency-denominated. Authoritative currency reference is required for loss run reporting, financial statement pre',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Builders risk claims are filed against active development projects before asset completion. The existing asset_id FK is null for under-construction projects. A construction insurance adjuster and pro',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: A claim is filed against a policy issued by a specific insurer. The claim table stores insurer_name as a denormalized string. Adding insurer_id FK normalizes carrier identity on the claim record, enab',
    `osha_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_incident. Business justification: OSHA recordable incidents at managed properties directly generate workers compensation and general liability insurance claims. Linking claim to osha_incident enables coordinated OSHA 300 log reportin',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Insurance claims are filed by or on behalf of the property owner as the insured party. Owner-level claims reporting (loss history by owner, portfolio loss ratios) is a standard real estate risk manage',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy under which this claim is filed. Links the claim to its governing policy record in the insurance domain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Property managers and maintenance staff are the primary claim reporters in real estate operations. Linking the reporting employee to a claim supports loss run analysis by employee, accountability trac',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential property managers track per-unit loss history for security deposit adjudication, lease renewal decisions, and habitability compliance. Water damage, fire, and tenant liability claims must ',
    `related_claim_id` BIGINT COMMENT 'Self-referencing FK on claim (related_claim_id)',
    `business_interruption_period_days` STRING COMMENT 'Number of days of business interruption or loss of rental income covered under the business interruption or loss of rents coverage section. Applicable only for business_interruption claim types. Used to calculate NOI impact.',
    `catastrophe_code` STRING COMMENT 'Industry-standard catastrophe event code (e.g., ISO PCS catastrophe number) assigned when the loss is part of a declared catastrophic event such as a hurricane, earthquake, or wildfire. Enables portfolio-level CAT loss aggregation and reinsurance reporting.',
    `cause_of_loss` STRING COMMENT 'Primary peril or event that caused the insured loss. Used for risk analytics, underwriting feedback, and portfolio loss trending. [ENUM-REF-CANDIDATE: fire|water_damage|wind|theft|liability|flood|earthquake|vandalism|mold|structural — promote to reference product]',
    `claim_number` STRING COMMENT 'Externally-known, human-readable unique identifier assigned to the claim by the insurer or internal risk management system. Used in all correspondence with insurers, adjusters, and legal counsel.. Valid values are `^CLM-[0-9]{4}-[0-9]{6}$`',
    `claim_status` STRING COMMENT 'Current lifecycle state of the insurance claim. Drives workflow routing, reserve management, and financial reporting. [ENUM-REF-CANDIDATE: open|closed|denied|subrogation|litigation|pending|withdrawn — promote to reference product if additional statuses are required]. Valid values are `open|closed|denied|subrogation|litigation|pending`',
    `claim_type` STRING COMMENT 'Classification of the insurance claim by coverage category. Determines which policy coverage section applies and drives reserve methodology. [ENUM-REF-CANDIDATE: property_damage|business_interruption|liability|workers_comp|flood|earthquake|environmental|cyber — promote to reference product]. Valid values are `property_damage|business_interruption|liability|workers_comp|flood|earthquake`',
    `claimant_type` STRING COMMENT 'Classification of the party filing the claim. Determines applicable coverage, subrogation rights, and regulatory reporting obligations.. Valid values are `owner|tenant|third_party|employee|contractor`',
    `closed_date` DATE COMMENT 'The calendar date on which the claim was formally closed by the insurer. Null if the claim remains open. Used for cycle time analytics and reserve release timing.',
    `coverage_limit` DECIMAL(18,2) COMMENT 'Maximum insured value or coverage limit applicable to this claim under the relevant policy section. Used to assess adequacy of coverage relative to the incurred loss.',
    `coverage_type` STRING COMMENT 'The specific insurance coverage section or endorsement under which the claim is being processed. Determines applicable limits, sublimits, and exclusions. [ENUM-REF-CANDIDATE: all_risk|named_peril|liability|workers_comp|flood|earthquake|terrorism|cyber — promote to reference product]. Valid values are `all_risk|named_peril|liability|workers_comp|flood|earthquake`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the claim record was first created in the data platform. Used for audit trail, data lineage, and SLA compliance tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The policy deductible amount applied to this specific claim, representing the insureds self-retained portion of the loss before insurer payment begins. Sourced from the applicable policy coverage terms.',
    `denial_reason` STRING COMMENT 'Narrative explanation provided by the insurer for denying the claim. Populated only when claim_status is denied. Used for dispute resolution, coverage gap analysis, and policy renewal negotiations.',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Initial estimate of the cost to repair or restore the damaged property to its pre-loss condition, as assessed by the adjuster or contractor. Distinct from the reserve amount which includes ALAE and other claim costs.',
    `insured_value` DECIMAL(18,2) COMMENT 'The declared insured value of the property or asset at the time of the loss event. Used to assess coinsurance compliance and adequacy of coverage relative to replacement cost.',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether the claim has been referred to legal counsel or is subject to active litigation. Triggers legal hold procedures and escalated reserve review.',
    `loss_date` DATE COMMENT 'The calendar date on which the insured loss event occurred. Principal real-world event date for the claim; used for policy period validation, statute of limitations tracking, and loss year reporting.',
    `loss_description` STRING COMMENT 'Narrative description of the loss event, including circumstances, affected areas, and initial damage assessment. Supports adjuster investigation and legal documentation.',
    `loss_location` STRING COMMENT 'Specific location within the property where the loss occurred (e.g., Unit 3B, Roof Level, Parking Garage Level 2). Supplements the property reference for precise damage location tracking.',
    `loss_of_rents_amount` DECIMAL(18,2) COMMENT 'Claimed amount for rental income lost during the period the property was uninhabitable or under repair due to the insured loss. Directly impacts NOI and is tracked separately from property damage indemnity.',
    `loss_run_included` BOOLEAN COMMENT 'Indicates whether this claim has been included in the most recently generated loss run report submitted to insurers or brokers for renewal underwriting purposes.',
    `net_claim_payment` DECIMAL(18,2) COMMENT 'Net amount paid to the insured after applying the deductible and any subrogation recoveries. Represents the actual cash received by the property owner or claimant. Calculated as total paid loss minus deductible minus subrogation recovery.',
    `police_report_number` STRING COMMENT 'Official police report number filed in connection with the loss event (e.g., theft, vandalism, liability incident). Required for certain claim types and supports fraud investigation.',
    `reported_date` DATE COMMENT 'The calendar date on which the claim was formally reported to the insurer or internal risk management team. Used to calculate reporting lag and assess compliance with policy notice requirements.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Estimated total financial reserve set aside by the insurer to cover the expected ultimate cost of the claim, including indemnity and allocated loss adjustment expenses (ALAE). Subject to periodic re-evaluation as the claim develops.',
    `source_claim_ref` STRING COMMENT 'The native claim identifier or reference number from the originating source system (e.g., Yardi claim record ID). Enables bidirectional traceability between the lakehouse silver layer and the operational system of record.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this claim record originated. Supports data lineage, reconciliation, and audit traceability across the real estate technology stack.. Valid values are `yardi|mri|manual|building_engines|procore`',
    `subrogation_flag` BOOLEAN COMMENT 'Indicates whether the insurer has identified subrogation potential against a responsible third party for this claim. Triggers the subrogation recovery workflow and legal referral process.',
    `subrogation_recovery` DECIMAL(18,2) COMMENT 'Amount recovered from a responsible third party through the insurers right of subrogation. Reduces the net cost of the claim to the insurer and is tracked separately for loss run reporting and financial reconciliation.',
    `third_party_involved` BOOLEAN COMMENT 'Indicates whether a third party (e.g., contractor, visitor, neighboring property owner) is involved in the loss event, either as a responsible party or as a claimant. Triggers liability coverage review and subrogation assessment.',
    `total_incurred_loss` DECIMAL(18,2) COMMENT 'Total financial exposure incurred on the claim to date, calculated as total paid loss plus outstanding reserve. Key metric for loss ratio analysis and portfolio risk reporting.',
    `total_paid_loss` DECIMAL(18,2) COMMENT 'Cumulative amount actually disbursed by the insurer to the claimant or on behalf of the insured as of the reporting date. Represents cash outflow and is used for cash flow forecasting and loss accounting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the claim record. Used for change detection, incremental processing, and audit compliance.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Core transactional record for every insurance claim filed against a policy in the real estate portfolio. Captures claim number, date of loss, date reported, cause of loss (fire, water damage, wind, theft, liability, flood, earthquake), loss description, claim type (property damage, business interruption, liability, workers comp), claim status (open, closed, denied, subrogation, litigation), claimant identity, adjuster assigned, reserve amount, total incurred loss, total paid loss, deductible applied, net claim payment, and subrogation recovery. SSOT for all loss events across the portfolio.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`claim_payment` (
    `claim_payment_id` BIGINT COMMENT 'Unique system-generated identifier for each individual claim payment disbursement record within the insurance claim lifecycle.',
    `ar_receipt_id` BIGINT COMMENT 'Foreign key linking to finance.ar_receipt. Business justification: Insurance claim proceeds (loss-of-rents, property damage recoveries) received by the property owner are recorded as AR receipts. Linking claim_payment to ar_receipt supports cash reconciliation of ins',
    `asset_id` BIGINT COMMENT 'Reference to the real estate asset (property) associated with the insured loss event for which this payment is being made.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Claim payments can be tracked against blanket groups when the claim is filed under blanket coverage. This enables financial tracking and reserve management at the blanket group level.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Claim payments for building damage (roof replacement, fire restoration) must be tracked at the building level for repair fund disbursement, lender notification under mortgagee clauses, and building-le',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Claim payments are posted to specific GL accounts (insurance recovery income, deductible expense) for financial reporting. claim_payment.gl_account_code is a plain-text denormalization. FK to chart_of',
    `claim_id` BIGINT COMMENT 'Reference to the parent insurance claim against which this payment is being disbursed. Supports multi-payment claim tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Claim payments are allocated to property cost centers for property-level financial reporting and insurance recovery tracking. claim_payment.cost_center_code is a plain-text denormalization. FK to cost',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Claim payment amounts, deductible applications, and subrogation recoveries are currency-denominated financial transactions requiring authoritative currency reference for GL posting, tax withholding ca',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy under which the claim and this payment are being processed. Links payment to coverage terms and limits.',
    `reversed_claim_payment_id` BIGINT COMMENT 'Self-referencing FK on claim_payment (reversed_claim_payment_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the claims adjuster, property manager, or authorized approver who approved this payment disbursement. Required for SOX internal controls and audit trail documentation.',
    `approved_date` DATE COMMENT 'Date on which the payment was formally approved by the authorized approver. Distinct from payment_date (issuance date). Used for approval cycle time analytics and SOX controls testing.',
    `bank_account_reference` STRING COMMENT 'Masked or tokenized reference to the payee bank account used for wire or ACH disbursement. Stored in masked format for PCI compliance. Full account details are held in the secure payment vault.',
    `check_wire_reference` STRING COMMENT 'Check number or wire/ACH transaction reference number associated with this payment disbursement. Used for bank reconciliation, payment tracing, and audit documentation.',
    `cleared_date` DATE COMMENT 'Date on which the check was cashed or the wire/ACH transfer was confirmed as settled by the receiving bank. Used for bank reconciliation and cash flow reporting in Yardi Voyager GL module.',
    `coverage_line` STRING COMMENT 'The specific insurance coverage line under the policy to which this payment is applied (e.g., property damage, business interruption, liability). Determines which coverage sub-limit is consumed by this disbursement. [ENUM-REF-CANDIDATE: property_damage|business_interruption|liability|flood|earthquake|wind|equipment_breakdown|umbrella — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim payment record was first captured in the system. Used for audit trail, data lineage, and SOX financial controls compliance.',
    `cumulative_paid_amount` DECIMAL(18,2) COMMENT 'Running total of all payments disbursed against this claim up to and including this payment. Enables comparison against coverage limits and total incurred loss tracking for loss run reports.',
    `deductible_applied_amount` DECIMAL(18,2) COMMENT 'Portion of the policy deductible applied and deducted from this payment. Tracks deductible allocation across multi-payment claims to ensure total deductible is not over-applied.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation amount deducted from the replacement cost value to arrive at actual cash value (ACV) for this payment. Applicable under ACV policies. Recoverable depreciation may be released upon proof of repair.',
    `insured_value_at_loss` DECIMAL(18,2) COMMENT 'Declared insured value of the property or asset at the time the loss event occurred. Used to calculate coinsurance compliance and maximum recoverable amount under the policy.',
    `loss_run_period` STRING COMMENT 'Reporting period (e.g., 2024-Q1, 2024-H1, 2024-01) to which this payment is attributed for loss run report generation. Required for annual insurance renewal submissions and portfolio risk analytics.. Valid values are `^[0-9]{4}-(Q[1-4]|H[12]|[0-9]{2})$`',
    `loss_type` STRING COMMENT 'Classification of the peril or cause of loss that triggered the claim and this payment. Used for loss analytics, portfolio risk reporting, and ESG/climate risk assessments across the real estate portfolio. [ENUM-REF-CANDIDATE: fire|water_damage|wind_hail|theft|vandalism|liability|flood|earthquake|other — promote to reference product]',
    `mortgagee_copayment_required` BOOLEAN COMMENT 'Indicates whether this payment requires co-endorsement or joint issuance with a mortgagee (lender) per the mortgage agreement or SNDA provisions. When true, the check or wire must include the mortgagee as a co-payee.',
    `mortgagee_name` STRING COMMENT 'Name of the mortgage lender or servicer required as co-payee on this payment per loan agreement terms. Populated when mortgagee_copayment_required is true. Required for CMBS and institutional lending compliance.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount actually disbursed to the payee after deductible application and any withholdings. Equals payment_amount minus deductible_applied_amount and other deductions. Used for cash disbursement reconciliation.',
    `payee_name` STRING COMMENT 'Full legal name of the party receiving the payment disbursement (e.g., insured property owner, mortgagee bank, contractor, or claimant). Required for check/wire issuance and co-payment compliance.',
    `payee_type` STRING COMMENT 'Classification of the party receiving the payment. Determines co-payment requirements (e.g., mortgagee co-payment per SNDA/loan agreements), tax reporting obligations, and disbursement routing. [ENUM-REF-CANDIDATE: insured|mortgagee|contractor|claimant|lienholder|subrogation_party — promote to reference product if additional types are required]. Valid values are `insured|mortgagee|contractor|claimant|lienholder|subrogation_party`',
    `payment_amount` DECIMAL(18,2) COMMENT 'Gross amount of this individual payment disbursement before any deductions. Represents the base monetary value of the disbursement for reserve reconciliation and loss run reporting.',
    `payment_date` DATE COMMENT 'The principal real-world business event date on which the payment was issued or disbursed to the payee. Used for cash flow reporting, reserve reconciliation, and regulatory loss run reporting.',
    `payment_method` STRING COMMENT 'Instrument used to disburse the payment to the payee. Determines processing requirements, clearance timelines, and bank reconciliation procedures. Wire transfers and ACH are common for large commercial real estate claim settlements.. Valid values are `check|wire_transfer|ach|direct_deposit|escrow_disbursement`',
    `payment_notes` STRING COMMENT 'Free-text field for adjuster or property manager notes regarding this specific payment disbursement, including special conditions, co-payment instructions, or dispute resolution context.',
    `payment_number` STRING COMMENT 'Externally-known sequential payment reference number within the claim (e.g., PMT-2024-00123). Used for correspondence with insurers, mortgagees, and contractors. Serves as the business identifier for this disbursement.',
    `payment_sequence` STRING COMMENT 'Sequential ordinal number of this payment within the claim (e.g., 1 = first payment, 2 = second payment). Enables ordered tracking of multi-payment claims and identification of advance, partial, and final payment sequence.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment disbursement. Tracks workflow from issuance through bank clearance or voiding. [ENUM-REF-CANDIDATE: pending|issued|cleared|voided|stopped|returned — promote to reference product if additional statuses are required]. Valid values are `pending|issued|cleared|voided|stopped|returned`',
    `payment_type` STRING COMMENT 'Classification of the payment within the claim lifecycle. Advance payments are pre-settlement disbursements; partial payments are interim; final closes the claim; supplemental addresses additional losses; subrogation_recovery represents funds recovered from liable third parties. [ENUM-REF-CANDIDATE: advance|partial|final|supplemental|subrogation_recovery|reopened — promote to reference product if additional types are required]. Valid values are `advance|partial|final|supplemental|subrogation_recovery|reopened`',
    `recoverable_depreciation_released` BOOLEAN COMMENT 'Indicates whether previously withheld recoverable depreciation has been released and included in this payment upon submission of proof of repair or replacement. Applicable to replacement cost value (RCV) policies.',
    `reserve_reduction_amount` DECIMAL(18,2) COMMENT 'Amount by which the outstanding claim reserve is reduced as a result of this payment. Enables granular reserve-to-payment reconciliation and IBNR (Incurred But Not Reported) reserve management across the claim lifecycle.',
    `source_system` STRING COMMENT 'Operational system of record from which this claim payment record originated. Supports data lineage tracking in the Databricks Silver Layer and reconciliation across Yardi Voyager, MRI Software, and SAP S/4HANA.. Valid values are `yardi_voyager|mri_software|sap_s4hana|manual_entry|insurer_portal`',
    `subrogation_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from a liable third party through subrogation proceedings. Populated when payment_type is subrogation_recovery. Reduces net claim cost and is credited back to the reserve or loss account.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the payment for tax reporting purposes (e.g., backup withholding for contractors per IRS Form 1099 requirements). Applicable when payee_type is contractor or claimant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim payment record was last modified. Supports audit trail requirements and change tracking for financial controls.',
    `void_date` DATE COMMENT 'Date on which the payment was voided, if applicable. Populated only when payment_status is voided or stopped. Required for audit trail and reserve reinstatement processing.',
    `void_reason` STRING COMMENT 'Reason code explaining why the payment was voided or stopped. Required for audit documentation and reserve reinstatement when a payment is cancelled. [ENUM-REF-CANDIDATE: stale_dated|incorrect_payee|incorrect_amount|duplicate_payment|lost_check|reissued|other — promote to reference product]',
    CONSTRAINT pk_claim_payment PRIMARY KEY(`claim_payment_id`)
) COMMENT 'Individual payment disbursement record within an insurance claim lifecycle. Captures payment number, payment date, payee name, payee type (insured, mortgagee, contractor, claimant), payment amount, payment type (advance, partial, final, supplemental, subrogation recovery), check or wire reference, coverage line applied, reserve reduction amount, and cumulative paid-to-date. Enables granular tracking of multi-payment claims and mortgagee co-payment requirements.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`loss_run` (
    `loss_run_id` BIGINT COMMENT 'Unique system-generated identifier for each loss run report record in the insurance domain.',
    `asset_id` BIGINT COMMENT 'Reference to the real estate property or portfolio asset covered under the policy for which this loss run applies.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Loss runs can be generated for blanket groups to show claims experience across the blanket coverage. This is essential for underwriting and renewal of blanket programs.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: Commercial real estate buyers request loss runs on target properties during due diligence. Deal teams track which loss runs were obtained per deal for lender submission and insurance placement. This i',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Renewal underwriters request building-level loss runs to price individual structures within a portfolio. Lenders also require building-level loss history for loan covenant compliance. The existing los',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Loss run aggregation by submarket, MSA, and geographic tier is a standard insurance portfolio management report used for renewal marketing, carrier submissions, and catastrophe exposure analysis in re',
    `insurer_id` BIGINT COMMENT 'Reference to the insurance carrier or insurer that issued the loss run report.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: A loss run report identifies the largest single loss claim within the reporting period. The loss_run table stores largest_loss_claim_number as a denormalized string reference. Adding largest_loss_clai',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy for which this loss run report was generated.',
    `prior_loss_run_id` BIGINT COMMENT 'Self-referencing FK on loss_run (prior_loss_run_id)',
    `asset_type` STRING COMMENT 'Classification of the real estate asset type covered under the policy for which this loss run applies.. Valid values are `commercial|residential|mixed_use|industrial|retail|office`',
    `broker_name` STRING COMMENT 'Name of the insurance broker or intermediary through whom the loss run was requested and received.',
    `catastrophe_losses_included` BOOLEAN COMMENT 'Indicates whether catastrophe (CAT) losses such as hurricane, earthquake, or flood events are included in the reported loss figures. Underwriters often analyze CAT and non-CAT losses separately.',
    `closed_claims_count` STRING COMMENT 'Number of claims that have been fully closed and settled as of the report as-of date.',
    `coverage_limit` DECIMAL(18,2) COMMENT 'Maximum coverage limit under the policy for the period covered by this loss run report.',
    `coverage_type` STRING COMMENT 'Type of insurance coverage to which this loss run report applies. [ENUM-REF-CANDIDATE: property|general_liability|umbrella|workers_comp|professional_liability|environmental|directors_officers|cyber|flood|earthquake — promote to reference product]. Valid values are `property|general_liability|umbrella|workers_comp|professional_liability|environmental`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loss run record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this loss run record (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Per-occurrence or aggregate deductible amount applicable to the policy, as stated in the loss run report.',
    `document_ref` STRING COMMENT 'Reference identifier or URL to the original loss run document stored in the document management system (e.g., DocuSign CLM or document repository).',
    `earned_premium` DECIMAL(18,2) COMMENT 'Total earned premium for the policy period covered by this loss run, used as the denominator in loss ratio calculations.',
    `insured_value` DECIMAL(18,2) COMMENT 'Total insured value (TIV) of the property or portfolio covered under the policy as of the report period. Used for exposure analysis and rate adequacy assessment.',
    `largest_loss_description` STRING COMMENT 'Brief description of the nature and cause of the single largest loss event in the period (e.g., fire damage, slip-and-fall, water intrusion).',
    `largest_single_loss` DECIMAL(18,2) COMMENT 'Dollar amount of the single largest individual claim incurred during the loss run period. Used by underwriters to assess severity exposure.',
    `loss_ratio` DECIMAL(18,2) COMMENT 'Ratio of total incurred losses to total earned premium for the period, expressed as a decimal (e.g., 0.65 = 65%). Key underwriting metric used in broker negotiations and renewal pricing.',
    `notes` STRING COMMENT 'Free-text notes or commentary from the risk manager or broker regarding this loss run report, such as explanations for unusual loss activity or carrier commentary.',
    `open_claims_count` STRING COMMENT 'Number of claims that remain open (unresolved) as of the report as-of date.',
    `period_end_date` DATE COMMENT 'End date of the loss experience period covered by this loss run report.',
    `period_start_date` DATE COMMENT 'Start date of the loss experience period covered by this loss run report, typically the beginning of the earliest policy year included (commonly 5 years prior).',
    `period_years` STRING COMMENT 'Number of policy years included in this loss run report. Industry standard is typically 5 years for renewal underwriting submissions.',
    `portfolio_scope` STRING COMMENT 'Scope of the real estate assets covered by this loss run — whether it applies to a single property, a defined portfolio, an entity, or a fund-level program.. Valid values are `single_property|portfolio|entity_level|fund_level`',
    `received_date` DATE COMMENT 'Date on which the loss run report was received from the insurer or broker.',
    `report_as_of_date` DATE COMMENT 'The valuation date through which the loss run data is current, as stated by the insurer. Claims activity after this date is not reflected.',
    `report_reference_number` STRING COMMENT 'Externally assigned reference number provided by the insurer on the loss run report document. Used for tracking and reconciliation with carrier records.',
    `report_status` STRING COMMENT 'Current lifecycle status of this loss run report version. superseded indicates a newer version has been received from the carrier.. Valid values are `received|pending|superseded|final|cancelled`',
    `report_version` STRING COMMENT 'Sequential version number of the loss run report received from the carrier for the same policy and period. Increments each time an updated report is received.',
    `request_date` DATE COMMENT 'Date on which the loss run report was formally requested from the insurer, typically initiated by the broker or risk manager during renewal underwriting.',
    `submission_purpose` STRING COMMENT 'Business purpose for which this loss run report was requested and will be used.. Valid values are `renewal_underwriting|broker_negotiation|actuarial_analysis|portfolio_review|regulatory_filing`',
    `total_claims_count` STRING COMMENT 'Total number of claims reported during the loss run period as stated in the loss run report.',
    `total_incurred_losses` DECIMAL(18,2) COMMENT 'Total incurred losses for the period, representing the sum of all paid losses plus outstanding reserves across all claims. Key metric for renewal underwriting and actuarial reserve analysis.',
    `total_open_reserves` DECIMAL(18,2) COMMENT 'Total outstanding reserves held by the insurer for all open claims as of the report as-of date. Represents the insurers estimate of future payments.',
    `total_paid_expenses` DECIMAL(18,2) COMMENT 'Total loss adjustment expenses (LAE) paid by the insurer, including legal, investigation, and claims handling costs across all claims in the period.',
    `total_paid_losses` DECIMAL(18,2) COMMENT 'Total amount of losses actually paid out by the insurer across all claims in the loss run period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this loss run record was last modified in the system.',
    CONSTRAINT pk_loss_run PRIMARY KEY(`loss_run_id`)
) COMMENT 'Loss run report record capturing the historical claims experience for a policy or portfolio over a defined period, as provided by the insurer. Captures loss run period (typically 5 years), insurer name, policy number, number of claims, total incurred losses, total paid losses, total open reserves, largest single loss, loss ratio, and loss run request date. Used for renewal underwriting submissions, broker negotiations, and actuarial reserve analysis. Tracks each loss run version received from carriers.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for the property-level risk assessment record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Real estate risk managers conduct internal property risk assessments for underwriting and renewal purposes. Linking to employee enables license/credential verification of the assessor, supports E&O co',
    `asset_id` BIGINT COMMENT 'Reference to the real estate asset (property) being assessed for underwriting risk and hazard evaluation.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Risk assessments can be performed at the blanket group level to evaluate the overall risk profile of the blanket coverage. This supports underwriting and risk management of blanket programs.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Building class drives underwriting risk scoring — Class A buildings with superior construction quality, HVAC systems, and technology infrastructure present lower risk profiles than Class C buildings. ',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: Insurance underwriters rely on compliance assessments (environmental phase I/II, building condition, fire safety) to set premiums and coverage terms. Linking insurance risk_assessment to compliance as',
    `construction_type_id` BIGINT COMMENT 'Foreign key linking to reference.construction_type. Business justification: Construction type is evaluated in every property risk assessment — fire resistance rating, seismic performance, and ISO construction class directly drive risk scores and underwriting decisions. const',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Geographic hierarchy enables catastrophe accumulation analysis by MSA/submarket, flood zone regulatory jurisdiction assignment, and market-level risk benchmarking in risk assessments — standard underw',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Environmental risk assessments (Phase I/II ESA), flood zone determinations, and seismic zone ratings are conducted at the parcel level. Risk assessors correlate FEMA flood maps and soil classification',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy for which this risk assessment was conducted, linking the assessment to the coverage instrument.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Risk assessors classify properties by type to determine hazard scores, protection class ratings, and recommended improvements. occupancy_type on risk_assessment is a denormalized property_type refer',
    `zoning_code_id` BIGINT COMMENT 'Foreign key linking to reference.zoning_code. Business justification: Zoning determines permitted uses and rebuilding constraints, which affect replacement cost estimates and ordinance-law exposure in risk assessments. Non-conforming use status is a material underwritin',
    `prior_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (prior_risk_assessment_id)',
    `assessment_date` DATE COMMENT 'The calendar date on which the risk assessment was physically conducted or formally completed at the property site.',
    `assessment_number` STRING COMMENT 'Externally-known unique business identifier for the risk assessment, used in correspondence with insurers, brokers, and underwriters (e.g., RA-2024-000123).. Valid values are `^RA-[0-9]{4}-[0-9]{6}$`',
    `assessment_outcome` STRING COMMENT 'Final underwriting decision resulting from the risk assessment: acceptable (coverage approved), conditional (coverage approved with requirements), or declined (coverage refused). Directly drives insurance placement decisions.. Valid values are `acceptable|conditional|declined`',
    `assessment_report_reference` STRING COMMENT 'Document reference number or URL pointing to the full risk assessment report stored in the document management system (e.g., DocuSign CLM or Yardi Voyager). Enables traceability to the source report.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the risk assessment record, tracking its workflow from initial draft through completion or cancellation.. Valid values are `draft|in_review|completed|expired|cancelled`',
    `assessor_license_number` STRING COMMENT 'Professional license or certification number of the assessor, required for regulatory compliance and insurer acceptance of the assessment report.',
    `assessor_type` STRING COMMENT 'Classification of the entity conducting the risk assessment: internal risk manager, third-party engineer, insurer inspector, independent appraiser, or environmental consultant. Influences credibility weighting in underwriting decisions. [ENUM-REF-CANDIDATE: internal_risk_manager|third_party_engineer|insurer_inspector|independent_appraiser|environmental_consultant — promote to reference product]. Valid values are `internal_risk_manager|third_party_engineer|insurer_inspector|independent_appraiser|environmental_consultant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `crime_hazard_flag` BOOLEAN COMMENT 'Indicates whether elevated crime risk was identified in the propertys location, based on local crime statistics and security assessment. Influences liability and property coverage terms.',
    `electrical_system_age_years` STRING COMMENT 'Age of the primary electrical system in years at the time of assessment. Aging electrical systems (e.g., knob-and-tube, aluminum wiring) are a significant fire risk factor in underwriting.',
    `environmental_hazard_flag` BOOLEAN COMMENT 'Indicates whether an environmental hazard was identified (e.g., soil contamination, asbestos, lead paint, underground storage tanks). Triggers environmental liability coverage review.',
    `esg_risk_flag` BOOLEAN COMMENT 'Indicates whether Environmental, Social, and Governance (ESG) risk factors were identified during the assessment, such as energy inefficiency, poor sustainability ratings, or social risk exposures. Increasingly relevant for REIT reporting and ESG-linked insurance products.',
    `fema_flood_zone` STRING COMMENT 'Federal Emergency Management Agency (FEMA) flood zone designation for the property (e.g., AE, X, VE). Determines mandatory flood insurance requirements and premium loading under the National Flood Insurance Program (NFIP).',
    `fire_hazard_flag` BOOLEAN COMMENT 'Indicates whether a fire hazard was identified during the risk assessment. Triggers specific underwriting conditions and premium loading for fire coverage.',
    `fire_suppression_system_status` STRING COMMENT 'Status of the fire suppression system installed at the property: fully sprinklered, partially sprinklered, standpipe only, or none. Critical underwriting factor for fire coverage pricing.. Valid values are `fully_sprinklered|partially_sprinklered|none|standpipe_only`',
    `flood_hazard_flag` BOOLEAN COMMENT 'Indicates whether a flood hazard was identified, including FEMA flood zone designation. Drives flood insurance requirements and premium adjustments.',
    `hvac_condition` STRING COMMENT 'Physical condition rating of the Heating, Ventilation, and Air Conditioning (HVAC) system. HVAC condition affects fire risk, habitability, and overall property insurability.. Valid values are `excellent|good|fair|poor|critical`',
    `improvement_deadline` DATE COMMENT 'Required completion date by which the insured must implement the recommended risk improvements as a condition of coverage. Failure to meet this deadline may result in policy cancellation or non-renewal.',
    `insured_replacement_value` DECIMAL(18,2) COMMENT 'Estimated cost to fully replace the insured structure at current construction costs, expressed in USD. Forms the basis for coverage limits and premium calculation. Distinct from market value or appraised value.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic risk assessment or re-inspection of the property. Drives renewal underwriting workflows and portfolio risk monitoring.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite numeric risk score assigned to the property following the assessment, typically on a standardized scale (e.g., 0–100 or 1–10). Higher scores indicate greater risk exposure. Used for premium pricing and portfolio risk stratification.',
    `plumbing_condition` STRING COMMENT 'Physical condition rating of the propertys plumbing system as assessed during inspection. Poor plumbing condition increases water damage and mold risk, affecting coverage terms.. Valid values are `excellent|good|fair|poor|critical`',
    `prior_loss_count` STRING COMMENT 'Number of insurance claims filed against this property in the lookback period (typically 3–5 years). Used alongside the prior loss history flag for detailed underwriting analysis.',
    `prior_loss_history_flag` BOOLEAN COMMENT 'Indicates whether the property has a recorded prior loss history (claims filed in the past). Presence of prior losses is a significant underwriting risk factor that may affect coverage terms and premium loading.',
    `prior_loss_total_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of all prior insurance losses paid or reserved for this property within the lookback period. Key input to loss run analysis and actuarial pricing.',
    `protection_class_rating` STRING COMMENT 'ISO Protection Class rating (1–10) assigned to the property based on proximity to fire stations, water supply, and fire department capabilities. Lower ratings indicate better fire protection and result in lower premiums.. Valid values are `^(1[0]|[1-9])$`',
    `recommended_improvements` STRING COMMENT 'Narrative description of risk mitigation improvements recommended by the assessor to reduce hazard exposure, improve insurability, or satisfy conditional coverage requirements (e.g., roof replacement, sprinkler installation, electrical upgrade).',
    `risk_grade` STRING COMMENT 'Alphabetic risk grade derived from the overall risk score, providing a simplified tier classification for underwriting and portfolio reporting purposes (A = lowest risk, F = highest risk).. Valid values are `A|B|C|D|E|F`',
    `roof_age_years` STRING COMMENT 'Age of the current roof in years at the time of assessment. Older roofs increase risk of water damage claims and may trigger replacement requirements as a condition of coverage.',
    `roof_condition` STRING COMMENT 'Physical condition rating of the propertys roof as assessed during the inspection. Roof condition is a primary driver of property insurance pricing and coverage eligibility.. Valid values are `excellent|good|fair|poor|critical`',
    `seismic_hazard_flag` BOOLEAN COMMENT 'Indicates whether a seismic or earthquake hazard was identified, based on USGS seismic zone mapping and structural vulnerability analysis.',
    `seismic_zone` STRING COMMENT 'USGS or IBC seismic design category or zone designation for the propertys location (e.g., Zone 0, Zone 4, SDC A–F). Used to assess earthquake exposure and determine seismic coverage requirements.',
    `total_building_area_sqf` DECIMAL(18,2) COMMENT 'Total gross building area in square feet (SQF) as recorded in the COPE data summary. Used to calculate insured replacement cost and exposure limits.',
    `underwriter_notes` STRING COMMENT 'Free-text notes entered by the underwriter or risk manager summarizing key findings, coverage conditions, or special considerations arising from the assessment. Confidential business data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk assessment record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Required for change tracking, audit compliance, and Silver layer data freshness monitoring.',
    `wind_hazard_flag` BOOLEAN COMMENT 'Indicates whether a wind or hurricane hazard was identified during the assessment, including exposure to high-wind corridors or coastal storm zones.',
    `year_built` STRING COMMENT 'The year the primary structure was originally constructed. Building age is a key COPE underwriting factor influencing structural integrity, code compliance, and risk pricing.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Property-level risk assessment record capturing the underwriting risk profile and hazard evaluation for insured real estate assets. Captures assessment date, assessor type (internal risk manager, third-party engineer, insurer inspector), risk score, hazard categories identified (fire, flood, wind, seismic, environmental, crime), COPE data summary, protection class rating, fire suppression system status, roof condition, electrical system age, plumbing condition, prior loss history flag, recommended risk improvements, and assessment outcome (acceptable, conditional, declined). Drives underwriting decisions and premium pricing.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` (
    `certificate_of_insurance_id` BIGINT COMMENT 'Unique system-generated identifier for the Certificate of Insurance (COI) record in the real estate portfolio insurance tracking system.',
    `asset_id` BIGINT COMMENT 'Identifier of the real estate property asset to which this COI is associated. Links the certificate to the specific property for lease compliance, lender reporting, and portfolio risk management.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Certificates of Insurance can reference blanket coverage groups when the certificate evidences blanket coverage. This is common when providing proof of insurance for multiple properties under a blanke',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Property owners are routinely named as certificate holders on COIs issued by tenants, contractors, and managers. Normalizing certificate_holder_name to a FK enables automated COI compliance tracking p',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to development.construction_contract. Business justification: Contract compliance requires COIs tied to specific construction contracts, not just contractors. Owners and lenders verify that COI coverage limits match contract values. A construction risk manager t',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Real estate compliance teams track E&O and professional liability COIs per licensed broker/agent employee. Linking COI to employee enables license compliance dashboards and ensures each active license',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: The COI stores producer_name (the broker/agent who produced the certificate) as a denormalized string. Adding insurance_broker_id FK links to the in-domain insurance_broker master. producer_name is re',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: The COI currently stores insurer_name and insurer_naic_code as denormalized strings. Adding insurer_id FK to the insurer master table normalizes carrier identity. insurer_name and insurer_naic_code ar',
    `lease_agreement_id` BIGINT COMMENT 'Identifier of the lease agreement for which this COI is required or associated. Used to verify tenant insurance compliance per lease covenants under FASB ASC 842 and IFRS 16.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: A Certificate of Insurance is issued as evidence of a specific insurance policy. The COI currently stores policy_number as a denormalized string; adding policy_id FK normalizes this to the authoritati',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease type determines COI requirements — NNN leases require tenants to provide COI naming landlord as additional insured; gross leases place insurance obligation on landlord. Linking COI to lease_type',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Landlords require tenants to provide COIs as a lease condition, tracked per unit. Property managers must verify COI compliance for each occupied unit at lease commencement and renewal. Unit-level COI ',
    `contractor_id` BIGINT COMMENT 'Identifier of the vendor or contractor from whom this COI was received. Used for vendor compliance tracking and procurement risk management.',
    `replaced_certificate_of_insurance_id` BIGINT COMMENT 'Self-referencing FK on certificate_of_insurance (replaced_certificate_of_insurance_id)',
    `additional_insured` BOOLEAN COMMENT 'Indicates whether the certificate holder or another specified party is named as an additional insured on the policy. True = additional insured endorsement is in place. Critical for lease compliance and lender requirements.',
    `additional_insured_name` STRING COMMENT 'Name of the entity added as an additional insured on the policy. May differ from the certificate holder. Required when lease or lender agreements specify named additional insured parties.',
    `auto_liability_combined_limit` DECIMAL(18,2) COMMENT 'Combined single limit for automobile liability coverage, expressed in USD. Required for vendors and contractors operating vehicles on managed properties.',
    `certificate_holder_address` STRING COMMENT 'Mailing address of the certificate holder as printed on the COI document. Required for ACORD 25 compliance and correspondence.',
    `certificate_number` STRING COMMENT 'Externally-assigned certificate number printed on the COI document, as issued by the insurer or broker. Used as the primary business reference for tracking and compliance verification.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the COI record. current indicates active and compliant coverage; expiring indicates coverage expiring within the renewal notice window; expired indicates lapsed coverage; cancelled indicates mid-term cancellation; pending_renewal indicates renewal in progress.. Valid values are `current|expiring|expired|cancelled|pending_renewal`',
    `certificate_type` STRING COMMENT 'Classifies the direction and purpose of the COI: whether it was issued by the company to a third party (tenant, lender, contractor, municipality) or received from a third party (vendor, contractor) as evidence of their coverage. [ENUM-REF-CANDIDATE: issued_to_tenant|issued_to_lender|issued_to_contractor|issued_to_municipality|received_from_vendor|received_from_contractor — promote to reference product]. Valid values are `issued_to_tenant|issued_to_lender|issued_to_contractor|issued_to_municipality|received_from_vendor|received_from_contractor`',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting any compliance deficiencies, exceptions, waivers, or follow-up actions identified during the COI review process.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether the COI has been reviewed and verified as meeting all required coverage thresholds, endorsements, and conditions specified in the applicable lease, loan agreement, or vendor contract. True = verified compliant.',
    `compliance_verified_date` DATE COMMENT 'Date on which the COI was reviewed and confirmed as compliant by the risk management or property management team.',
    `coverage_type` STRING COMMENT 'Primary type of insurance coverage evidenced by this certificate. Represents the dominant coverage line for this COI record. [ENUM-REF-CANDIDATE: general_liability|commercial_auto|workers_compensation|umbrella_excess|professional_liability|property|builders_risk|pollution_liability|cyber_liability — promote to reference product]. Valid values are `general_liability|commercial_auto|workers_compensation|umbrella_excess|professional_liability|property`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this COI record was first created in the system. Used for audit trail and data lineage tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount applicable to the primary coverage line evidenced by this certificate, expressed in USD. Relevant for loss run analysis and risk assessment.',
    `description_of_operations` STRING COMMENT 'Free-text field from the ACORD 25 form describing the specific operations, locations, vehicles, or special items covered. Often contains endorsement references, project names, property addresses, and specific additional insured language.',
    `document_reference` STRING COMMENT 'Reference path or identifier for the scanned or digital COI document stored in the document management system (e.g., DocuSign CLM or Yardi Voyager document vault). Enables direct retrieval of the source document.',
    `effective_date` DATE COMMENT 'The date on which the insurance coverage evidenced by this certificate becomes effective. Used for lease compliance verification and lender covenant tracking.',
    `employers_liability_limit` DECIMAL(18,2) COMMENT 'Maximum coverage per accident under the employers liability portion of the workers compensation policy, expressed in USD.',
    `expiration_date` DATE COMMENT 'The date on which the insurance coverage evidenced by this certificate expires. Critical for renewal tracking, lease compliance, and lender reporting. Triggers renewal workflow when within the renewal notice window.',
    `general_liability_aggregate_limit` DECIMAL(18,2) COMMENT 'Maximum total coverage amount for all claims during the policy period under the general liability policy, expressed in USD. Critical for lease compliance verification.',
    `general_liability_occurrence_limit` DECIMAL(18,2) COMMENT 'Maximum coverage amount per occurrence under the general liability policy, expressed in USD. Standard lease and lender requirements specify minimum thresholds for this limit.',
    `insured_address` STRING COMMENT 'Mailing address of the named insured as printed on the certificate. Used for identity verification and correspondence.',
    `insured_name` STRING COMMENT 'Legal name of the entity named as the insured on the policy. For received COIs, this is the vendor or contractor. For issued COIs, this is the company entity. Critical for verifying that the correct legal entity is covered.',
    `issued_date` DATE COMMENT 'The date the COI was issued or generated by the insurer or broker. Represents the principal business event timestamp for this document.',
    `notice_of_cancellation_days` STRING COMMENT 'Number of days advance written notice the insurer must provide to the certificate holder prior to policy cancellation or material change. Standard requirement is 30 days; 10 days for non-payment. Specified in lease and lender agreements.',
    `personal_advertising_injury_limit` DECIMAL(18,2) COMMENT 'Maximum coverage amount for personal and advertising injury claims under the general liability policy, expressed in USD.',
    `policy_effective_date` DATE COMMENT 'The date the underlying insurance policy becomes effective. May differ from the certificate effective date when a COI is issued mid-term.',
    `policy_expiration_date` DATE COMMENT 'The date the underlying insurance policy expires. Used to track policy renewal cycles and ensure continuous coverage for lease and lender compliance.',
    `primary_noncontributory` BOOLEAN COMMENT 'Indicates whether the policy includes a primary and non-contributory endorsement, meaning this policy pays first before any other insurance held by the certificate holder. True = endorsement is in place. Required by most commercial leases and CMBS lenders.',
    `products_completed_ops_limit` DECIMAL(18,2) COMMENT 'Maximum coverage amount for products and completed operations claims under the general liability policy, expressed in USD. Relevant for contractor COIs received for construction and development projects.',
    `property_insured_value` DECIMAL(18,2) COMMENT 'Total insured value of the property under the commercial property policy, expressed in USD. Used for lender covenant compliance (LTV-based insurance requirements) and portfolio risk management.',
    `renewal_reminder_date` DATE COMMENT 'Date on which a renewal reminder notification should be triggered, typically calculated as a specified number of days before the expiration date. Drives automated compliance workflow in Yardi Voyager and DocuSign CLM.',
    `umbrella_aggregate_limit` DECIMAL(18,2) COMMENT 'Maximum total coverage for all claims during the policy period under the umbrella or excess liability policy, expressed in USD.',
    `umbrella_each_occurrence_limit` DECIMAL(18,2) COMMENT 'Maximum coverage per occurrence under the umbrella or excess liability policy, expressed in USD. Lenders and major leases typically require umbrella coverage above primary limits.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this COI record was last modified in the system. Used for audit trail, change tracking, and data lineage in the Databricks Silver Layer.',
    `waiver_of_subrogation` BOOLEAN COMMENT 'Indicates whether a waiver of subrogation endorsement is in place, preventing the insurer from pursuing recovery claims against the certificate holder. True = waiver applies. Commonly required in commercial leases and construction contracts.',
    `workers_comp_statutory_limit` BOOLEAN COMMENT 'Indicates whether the workers compensation coverage meets statutory limits as required by applicable state law. True = statutory limits apply. Required for all contractor and vendor COIs per OSHA and state labor regulations.',
    CONSTRAINT pk_certificate_of_insurance PRIMARY KEY(`certificate_of_insurance_id`)
) COMMENT 'Certificate of Insurance (COI) record issued to or received from third parties as evidence of insurance coverage. Captures certificate number, certificate type (issued to tenant, lender, contractor, municipality; or received from vendor/contractor), certificate holder name and address, policy references, coverage types evidenced, coverage limits, effective and expiration dates, additional insured status, waiver of subrogation flag, primary and non-contributory endorsement flag, and certificate status (current, expiring, expired). Critical for lease compliance, lender requirements, and vendor management.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique system-generated identifier for the insurance policy renewal record. Primary key for the renewal lifecycle management entity.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Policy renewal underwriting requires a current appraisal to reset TIV, validate insured values, and reprice premiums. Insurers mandate updated appraisals at renewal for commercial properties — the ren',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Renewal premium comparisons (prior year vs. quoted vs. bound), premium change calculations, and TIV reporting require authoritative currency reference for renewal marketing analysis and budget forecas',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Insurance renewal premium changes directly trigger budget reforecasts in RE operations. Linking renewal to finance.budget allows risk managers and controllers to update operating expense budgets when ',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: Policy renewals are managed by the broker of record. The renewal table already has broker_id→brokerage.broker (cross-domain), but lacks a direct FK to the in-domain insurance_broker master. Adding ins',
    `insurance_program_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_program. Business justification: Renewals can occur at the program level (program renewal) as well as individual policy level. This supports program-level renewal tracking where the entire insurance program is renewed as a package.',
    `insurer_id` BIGINT COMMENT 'Reference to the incumbent insurance carrier associated with the expiring policy being renewed.',
    `policy_id` BIGINT COMMENT 'Reference to the expiring insurance policy that this renewal record is managing. Links the renewal lifecycle to the parent policy.',
    `prior_renewal_id` BIGINT COMMENT 'Self-referencing FK on renewal (prior_renewal_id)',
    `binding_date` DATE COMMENT 'The date on which the renewed insurance policy was formally bound, confirming coverage continuity. A null value indicates the renewal has not yet been bound.',
    `bound_carrier_name` STRING COMMENT 'The name of the insurance carrier with whom the renewed policy was ultimately bound. Captured as a denormalized field for reporting convenience alongside the carrier_id reference.',
    `bound_policy_number` STRING COMMENT 'The policy number assigned by the carrier for the newly bound renewal policy. Used for claims filing, certificate of insurance (COI) issuance, and regulatory compliance.',
    `bound_premium` DECIMAL(18,2) COMMENT 'The final annual premium at which the renewed policy was bound. This is the contractually agreed premium for the new policy period. Expressed in USD.',
    `broker_submission_date` DATE COMMENT 'The date on which the broker submitted the renewal application and supporting documentation to the insurance market or carrier(s) for underwriting review.',
    `carrier_quote_deadline` DATE COMMENT 'The deadline by which the carrier(s) must return a formal quote to the broker. Used to manage the renewal timeline and ensure sufficient time for coverage comparison and binding.',
    `coi_issued_date` DATE COMMENT 'The date on which the Certificate of Insurance (COI) was issued for the renewed policy. Null if COI has not yet been issued or is not required.',
    `coi_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Insurance (COI) must be issued upon binding of the renewed policy, typically required by lenders, tenants, or joint venture partners.',
    `coverage_change_description` STRING COMMENT 'Narrative description of material changes to coverage terms, limits, deductibles, or exclusions at renewal compared to the expiring policy. Populated when coverage_changed is True.',
    `coverage_changed` BOOLEAN COMMENT 'Indicates whether the scope, limits, deductibles, or terms of coverage changed materially at renewal compared to the expiring policy. True if changes exist; False if coverage was renewed on identical terms.',
    `coverage_limit` DECIMAL(18,2) COMMENT 'The maximum dollar amount the insurer will pay per occurrence or in aggregate under the renewed policy. Expressed in the currency indicated by currency_code.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this renewal record was first created in the system. Supports audit trail requirements under SOX financial controls and data lineage tracking in the Databricks Silver Layer.',
    `cycle_year` STRING COMMENT 'The calendar year in which this renewal cycle occurs (e.g., 2025). Used to track year-over-year premium trends and coverage changes across the portfolio.',
    `days_to_expiration_at_initiation` STRING COMMENT 'The number of calendar days remaining until policy expiration at the time the renewal process was initiated (expiration_date minus initiation_date). Measures proactive renewal management lead time.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The per-occurrence or aggregate deductible amount applicable under the renewed policy. Represents the insureds self-retention before carrier coverage applies. Expressed in the currency indicated by currency_code.',
    `effective_date` DATE COMMENT 'The date on which the renewed policy coverage becomes effective, typically the day after the expiring policy expires. Confirms coverage continuity with no gap.',
    `expiration_date` DATE COMMENT 'The date on which the expiring insurance policy coverage terminates. Drives renewal initiation timelines and lapse risk monitoring across the portfolio.',
    `incumbent_carrier_retained` BOOLEAN COMMENT 'Indicates whether the expiring policy was ultimately renewed with the same (incumbent) carrier. True if the bound renewal carrier matches the expiring carrier; False if a new carrier was selected.',
    `initiation_date` DATE COMMENT 'The date on which the renewal process was formally initiated, typically 90–120 days prior to policy expiration. Used to measure proactive renewal management lead time.',
    `lender_notification_date` DATE COMMENT 'The date on which the lender or lienholder was notified of the renewed policy binding. Supports loan covenant compliance tracking for leveraged real estate assets.',
    `lender_notification_required` BOOLEAN COMMENT 'Indicates whether the mortgage lender or lienholder must be notified of the renewal binding, as required by loan covenants or CMBS/RMBS servicing agreements.',
    `marketing_strategy` STRING COMMENT 'The renewal marketing approach selected by the broker and asset manager. Determines whether the renewal is placed with the incumbent carrier only or opened to competitive bidding across multiple carriers.. Valid values are `single_carrier|competitive_bid|direct_placement|remarket`',
    `new_expiration_date` DATE COMMENT 'The expiration date of the newly bound renewal policy. Establishes the end of the renewed coverage period and seeds the next renewal cycle.',
    `notes` STRING COMMENT 'Free-text field for capturing broker commentary, underwriting conditions, market observations, carrier feedback, or other qualitative notes relevant to the renewal cycle.',
    `number_of_quotes_received` STRING COMMENT 'The total count of carrier quotes received during the renewal marketing process. Relevant for competitive bid strategies; indicates market depth and broker effectiveness.',
    `premium_change_amount` DECIMAL(18,2) COMMENT 'The absolute dollar change in annual premium between the expiring policy and the bound renewal (bound_premium minus prior_year_premium). Positive values indicate an increase; negative values indicate a decrease. Expressed in USD.',
    `premium_change_pct` DECIMAL(18,2) COMMENT 'The percentage change in annual premium between the expiring policy and the bound renewal ((bound_premium - prior_year_premium) / prior_year_premium * 100). Used for portfolio-level premium trend analysis and OPEX reporting.',
    `premium_finance_used` BOOLEAN COMMENT 'Indicates whether the renewal premium was financed through a third-party premium finance company rather than paid in full upfront. Relevant for cash flow management and debt tracking.',
    `premium_payment_frequency` STRING COMMENT 'The agreed frequency at which premium installments are paid to the carrier under the renewed policy. Drives accounts payable (AP) scheduling in Yardi Voyager.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `prior_year_premium` DECIMAL(18,2) COMMENT 'The total annual premium paid for the expiring policy in the prior policy year. Serves as the baseline for calculating premium change at renewal. Expressed in USD.',
    `quoted_premium` DECIMAL(18,2) COMMENT 'The total annual premium quoted by the carrier(s) for the renewed policy. May reflect the best quote received during competitive bidding. Expressed in USD.',
    `renewal_number` STRING COMMENT 'Externally-known business identifier for the renewal cycle, used in broker submissions, carrier correspondence, and internal tracking. Format: RNW-YYYY-NNNNNN.. Valid values are `^RNW-[0-9]{4}-[0-9]{6}$`',
    `renewal_status` STRING COMMENT 'Current workflow state of the renewal lifecycle. Tracks progression from initiation through binding or lapse. [ENUM-REF-CANDIDATE: in_progress|submitted_to_market|quoted|bound|lapsed|cancelled — promote to reference product]. Valid values are `in_progress|submitted_to_market|quoted|bound|lapsed|cancelled`',
    `total_insured_value` DECIMAL(18,2) COMMENT 'The aggregate insured value of all assets covered under the renewed policy, representing the maximum replacement cost exposure. Critical for underwriting adequacy and portfolio risk management. Expressed in the currency indicated by currency_code.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this renewal record was last modified. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Policy renewal lifecycle management record tracking the end-to-end renewal process for each expiring insurance policy. Captures renewal cycle year, renewal initiation date, expiration date, renewal status (in progress, submitted to market, quoted, bound, lapsed), incumbent carrier retention flag, marketing strategy (single carrier, competitive bid), renewal premium quoted, renewal premium bound, premium change vs. prior year (dollar and percentage), coverage changes at renewal, broker submission date, carrier quote deadline, binding date, and renewal notes. Enables proactive renewal management across the portfolio.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`endorsement` (
    `endorsement_id` BIGINT COMMENT 'Unique system-generated identifier for the policy endorsement record. Primary key for the endorsement entity in the insurance domain.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Lease amendments that expand space, change permitted use, or modify insurance covenant requirements trigger insurance endorsements to update coverage limits, add locations, or change additional insure',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Value endorsements that increase or decrease coverage limits are triggered by updated appraisals. The endorsement record must reference the appraisal that justified the insured value change — a standa',
    `asset_id` BIGINT COMMENT 'Reference to the specific property asset affected by this endorsement, applicable when the endorsement adds, removes, or modifies coverage for a single location within a portfolio policy.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed insurance broker or agent who placed the endorsement request with the carrier on behalf of the insured real estate entity.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: When a sale closes, the new owner must be added as named insured via a policy endorsement. The deal is the direct trigger for post-closing endorsement requests. Risk managers track which endorsements ',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Mid-term endorsements add or remove specific buildings from a policy (e.g., newly completed construction, building disposition). The existing endorsement.asset_id covers asset level but is insufficien',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Endorsement premium adjustment amounts, prior/new coverage limit changes, and insured value changes are currency-denominated financial modifications requiring authoritative currency reference for GL p',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: An endorsement is approved and issued by the insurance carrier. The endorsement table stores carrier_name and carrier_naic_code as denormalized strings. Adding insurer_id FK normalizes carrier identit',
    `clause_id` BIGINT COMMENT 'Foreign key linking to lease.clause. Business justification: Lease clauses (additional insured requirements, waiver of subrogation, lender endorsement mandates) directly trigger insurance endorsements. The endorsement table already has lease_required_flag=true;',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Endorsements adding or removing named insureds (property owners) require direct reference to the owner entity. Ownership changes, refinancing, and JV restructurings trigger named insured endorsements.',
    `policy_id` BIGINT COMMENT 'Reference to the in-force insurance policy to which this endorsement applies. Links the endorsement to its parent policy record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Property managers and risk managers request policy endorsements when properties are acquired, renovated, or disposed of. Linking the requesting employee to the endorsement provides an audit trail for ',
    `superseded_by_endorsement_id` BIGINT COMMENT 'Reference to the subsequent endorsement that replaced or voided this record, enabling full amendment chain tracking. Null if this endorsement has not been superseded.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Endorsements are routinely triggered by specific real estate transactions — property acquisitions add locations to schedules, dispositions remove them, refinancings add lenders as additional insureds.',
    `superseded_endorsement_id` BIGINT COMMENT 'Self-referencing FK on endorsement (superseded_endorsement_id)',
    `additional_insured_type` STRING COMMENT 'Classification of the additional insured party added under this endorsement. Identifies the business relationship that necessitated the additional insured requirement.. Valid values are `lender|tenant|property_manager|joint_venture|government|other`',
    `carrier_approval_date` DATE COMMENT 'The date on which the insurance carrier formally approved and countersigned the endorsement. Required for endorsements that alter coverage terms or limits.',
    `coverage_type` STRING COMMENT 'The line of insurance coverage affected by this endorsement. Identifies which coverage section of the policy is being modified. [ENUM-REF-CANDIDATE: property|general_liability|umbrella|professional_liability|directors_officers|workers_comp|flood|earthquake — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this endorsement record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `document_reference` STRING COMMENT 'Reference identifier or URL to the executed endorsement document stored in the document management system (e.g., DocuSign CLM or Yardi Voyager document vault). Enables retrieval of the signed endorsement form.',
    `effective_date` DATE COMMENT 'The date on which the endorsement changes become binding and operative within the in-force policy. Marks the start of the amended coverage terms.',
    `endorsement_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the insurance carrier to uniquely identify this endorsement within the policy. Used for carrier correspondence and audit trails.',
    `endorsement_status` STRING COMMENT 'Current lifecycle state of the endorsement record, tracking its progression from submission through carrier approval to issuance or rejection.. Valid values are `pending|approved|issued|declined|voided|superseded`',
    `endorsement_type` STRING COMMENT 'Classification of the mid-term policy change represented by this endorsement. Defines the nature of the modification to the in-force policy. [ENUM-REF-CANDIDATE: additional_insured|location_add|location_delete|coverage_change|limit_change|exclusion_addition|waiver_of_subrogation — promote to reference product]',
    `exclusion_description` STRING COMMENT 'Narrative description of any coverage exclusion added or modified by this endorsement. Applicable for exclusion addition endorsements. Documents the specific risk or peril excluded from coverage.',
    `expiration_date` DATE COMMENT 'The date on which the endorsement ceases to be operative, if the endorsement is temporary or time-limited. Null for permanent endorsements that run to policy expiry.',
    `form_number` STRING COMMENT 'Standardized ISO or carrier-specific form number identifying the endorsement template used. Enables regulatory compliance tracking and form filing verification.',
    `insured_value_change` DECIMAL(18,2) COMMENT 'The net change in total insured value (TIV) resulting from this endorsement, expressed in the policy currency. Positive for additions (e.g., new property location added); negative for deletions.',
    `internal_notes` STRING COMMENT 'Free-text field for internal risk management or property management notes related to this endorsement, such as negotiation context, special conditions, or follow-up actions required.',
    `issued_date` DATE COMMENT 'The date on which the carrier formally issued and delivered the endorsement document to the insured or broker. Distinct from the effective date and approval date.',
    `lease_required_flag` BOOLEAN COMMENT 'Indicates whether this endorsement was required by a tenant lease agreement, such as an additional insured or waiver of subrogation clause mandated in a commercial NNN or gross lease.',
    `lender_required_flag` BOOLEAN COMMENT 'Indicates whether this endorsement was mandated by a lender as a condition of a mortgage, construction loan, or CMBS financing arrangement. Supports LTV and DSCR covenant compliance tracking.',
    `new_coverage_limit` DECIMAL(18,2) COMMENT 'The revised coverage limit effective after this endorsement is applied. Applicable for limit change endorsements. Null for endorsements that do not alter coverage limits.',
    `new_deductible_amount` DECIMAL(18,2) COMMENT 'The revised deductible amount effective after this endorsement is applied. Null for endorsements that do not alter the deductible.',
    `premium_adjustment_amount` DECIMAL(18,2) COMMENT 'The net change in annual premium resulting from this endorsement, expressed in the policy currency. Positive values indicate additional premium owed; negative values indicate return premium due to the insured.',
    `premium_adjustment_type` STRING COMMENT 'Classification of the premium change associated with this endorsement. Indicates whether the insured owes additional premium, is due a return premium, or if the endorsement carries no premium impact.. Valid values are `additional_premium|return_premium|flat|pro_rata|short_rate`',
    `prior_coverage_limit` DECIMAL(18,2) COMMENT 'The coverage limit in force on the policy immediately before this endorsement was applied. Captured to maintain a complete amendment history and support audit requirements.',
    `prior_deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount in force on the policy immediately before this endorsement was applied. Supports amendment history tracking and coverage change analysis.',
    `reason` STRING COMMENT 'Free-text narrative describing the business reason or trigger for the mid-term policy change, such as property acquisition, tenant requirement, lender requirement, or regulatory mandate.',
    `regulatory_filing_date` DATE COMMENT 'The date on which the endorsement was filed with the applicable state insurance department or regulatory authority. Null if no regulatory filing is required.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this endorsement requires a regulatory filing with the applicable state insurance department. Supports compliance tracking for publicly traded REITs and regulated entities.',
    `requested_date` DATE COMMENT 'The date on which the endorsement was formally requested by the insured, broker, or property manager. Used to track turnaround time and carrier responsiveness.',
    `requesting_party` STRING COMMENT 'The party who initiated the endorsement request. Identifies whether the change was driven by the insured, broker, lender covenant, tenant lease requirement, or internal management. [ENUM-REF-CANDIDATE: insured|broker|lender|tenant|property_manager|asset_manager|legal — 7 candidates stripped; promote to reference product]',
    `sequence` STRING COMMENT 'Sequential integer indicating the order in which this endorsement was issued relative to other endorsements on the same policy. Supports reconstruction of the full amendment history from inception to expiration.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this endorsement record was sourced. Supports data lineage and reconciliation in the Silver Layer.. Valid values are `yardi_voyager|mri_software|manual|other`',
    `source_system_record_reference` STRING COMMENT 'The native identifier of this endorsement record in the originating operational system (e.g., Yardi Voyager endorsement record ID or MRI Software endorsement key). Enables reconciliation between the lakehouse and source systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this endorsement record was last modified. Supports change data capture, audit trails, and Silver Layer incremental processing in the Databricks Lakehouse.',
    `waiver_of_subrogation_flag` BOOLEAN COMMENT 'Indicates whether this endorsement includes a waiver of subrogation clause, preventing the insurer from pursuing recovery against a third party after paying a claim. Commonly required in commercial leases.',
    CONSTRAINT pk_endorsement PRIMARY KEY(`endorsement_id`)
) COMMENT 'Policy endorsement record capturing mid-term changes, additions, or modifications to an in-force insurance policy. Captures endorsement number, endorsement type (additional insured, location add/delete, coverage change, limit change, exclusion addition, waiver of subrogation), effective date, premium adjustment (additional or return premium), endorsement reason, requesting party, carrier approval date, and endorsement status. Tracks the full amendment history of each policy between inception and expiration.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`insurer` (
    `insurer_id` BIGINT COMMENT 'Unique surrogate identifier for the insurance carrier, syndicate, or reinsurer record in the real estate portfolio insurance registry.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Insurer domicile country determines regulatory jurisdiction, admitted/non-admitted status, surplus lines eligibility, and foreign ownership restrictions. domicile_country_code is a denormalized plai',
    `parent_insurer_id` BIGINT COMMENT 'Self-referencing FK on insurer (parent_insurer_id)',
    `acord_form_support` BOOLEAN COMMENT 'Indicates whether the insurer supports ACORD standard forms (e.g., ACORD 25 Certificate of Liability Insurance, ACORD 28 Evidence of Commercial Property Insurance) for certificate issuance and policy documentation. ACORD compliance is a standard requirement in commercial real estate lease and loan transactions.',
    `am_best_financial_size_category` STRING COMMENT 'AM Best Financial Size Category (FSC) expressed as a Roman numeral class (e.g., XV, XIV, XIII) representing the insurers adjusted policyholders surplus. Used to assess capacity for large real estate portfolio placements. [ENUM-REF-CANDIDATE: I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XII|XIII|XIV|XV — promote to reference product]',
    `am_best_rating` STRING COMMENT 'AM Best Financial Strength Rating (FSR) assigned to the insurer, reflecting the carriers ability to meet ongoing insurance policy and contract obligations (e.g., A++, A+, A, A-, B++, B+, NR). Critical for carrier approval thresholds in real estate portfolio insurance programs. [ENUM-REF-CANDIDATE: A++|A+|A|A-|B++|B+|B|B-|C++|C+|C|C-|D|E|F|NR — promote to reference product]',
    `am_best_rating_date` DATE COMMENT 'Date on which the current AM Best Financial Strength Rating was assigned or last affirmed. Used to determine rating currency and trigger re-verification workflows.',
    `am_best_rating_outlook` STRING COMMENT 'AM Best outlook modifier indicating the likely direction of the financial strength rating over the medium term. Used to proactively monitor carrier financial health and trigger re-evaluation of placement decisions.. Valid values are `stable|positive|negative|under_review`',
    `approval_date` DATE COMMENT 'Date on which the insurer was formally approved by the organizations risk management function for inclusion in the approved carrier registry.',
    `approved_carrier` BOOLEAN COMMENT 'Indicates whether the insurer has been formally approved by the organizations risk management function for placement of new insurance policies. True when the carrier meets all financial strength, licensing, and compliance criteria.',
    `claims_contact_email` STRING COMMENT 'Email address of the designated claims contact at the insurer. Used for first notice of loss (FNOL) submissions, claims status inquiries, and loss run report requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claims_contact_name` STRING COMMENT 'Full name of the designated claims contact at the insurer responsible for receiving and managing first notice of loss (FNOL) and claims submissions for the real estate portfolio.',
    `claims_contact_phone` STRING COMMENT 'Direct phone number of the designated claims contact at the insurer for urgent claims reporting and first notice of loss (FNOL) communications.',
    `coi_portal_url` STRING COMMENT 'URL of the insurers self-service certificate of insurance (COI) issuance portal. Enables property managers and leasing teams to obtain and distribute COIs for tenant and lender compliance without manual carrier contact.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the insurer record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage, audit trail, and SOX internal control requirements.',
    `domicile_state_code` STRING COMMENT 'Two-letter U.S. state code (ISO 3166-2:US) of the state in which the insurer is domiciled and primarily regulated. Determines the home state regulator for surplus lines compliance and financial examination purposes.. Valid values are `^[A-Z]{2}$`',
    `fein` STRING COMMENT 'Federal Employer Identification Number (FEIN) / Tax Identification Number (TIN) of the insurer entity. Required for IRS Form 1099 reporting on premium payments and for vendor master setup in SAP S/4HANA Accounts Payable.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `hq_address_line1` STRING COMMENT 'Primary street address line of the insurers principal headquarters office. Used for formal correspondence, regulatory filings, and vendor master records in SAP S/4HANA.',
    `hq_city` STRING COMMENT 'City of the insurers principal headquarters office.',
    `hq_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the insurers principal headquarters office.. Valid values are `^[A-Z]{3}$`',
    `hq_postal_code` STRING COMMENT 'ZIP or postal code of the insurers principal headquarters office.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `hq_state_code` STRING COMMENT 'Two-letter U.S. state code (ISO 3166-2:US) of the insurers principal headquarters office.. Valid values are `^[A-Z]{2}$`',
    `insurer_status` STRING COMMENT 'Current lifecycle status of the insurer record. Active indicates the carrier is currently providing coverage; inactive indicates no current policies; in_run_off indicates the carrier is winding down existing obligations without writing new business; suspended indicates regulatory or internal hold.. Valid values are `active|inactive|in_run_off|suspended`',
    `insurer_type` STRING COMMENT 'Classification of the insurer by regulatory admission status and structural type. Admitted carriers are licensed in the state; non-admitted are surplus lines; Lloyds syndicates operate under Lloyds of London; captives are self-insurance vehicles; reinsurers provide treaty or facultative reinsurance. [ENUM-REF-CANDIDATE: admitted|non_admitted|lloyds_syndicate|captive|reinsurer — promote to reference product if additional types emerge]. Valid values are `admitted|non_admitted|lloyds_syndicate|captive|reinsurer`',
    `last_financial_review_date` DATE COMMENT 'Date on which the insurers financial strength, AM Best rating, and regulatory standing were last reviewed by the organizations risk management or asset management team. Supports periodic carrier monitoring cadence.',
    `legal_name` STRING COMMENT 'Full legal registered name of the insurance carrier, syndicate, or reinsurer as filed with the applicable state insurance department or regulatory authority.',
    `lines_of_business` STRING COMMENT 'Comma-delimited list of insurance lines of business the carrier is authorized and actively writing for the real estate portfolio (e.g., property, general_liability, umbrella, workers_compensation, directors_officers, environmental). Supports coverage gap analysis and carrier selection for new placements.',
    `lloyds_syndicate_number` STRING COMMENT 'Lloyds of London syndicate number assigned to the underwriting syndicate. Populated only when insurer_type is lloyds_syndicate. Used to identify the specific syndicate capacity and managing agent for large property and liability placements.',
    `loss_run_request_email` STRING COMMENT 'Dedicated email address for submitting loss run report requests to the insurer. Loss run reports document claims history and are required for renewal underwriting submissions and portfolio risk assessments.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `min_am_best_rating_required` STRING COMMENT 'Minimum AM Best Financial Strength Rating threshold required by the organizations insurance procurement policy for this carrier to be eligible for new policy placements (e.g., A-). Used in carrier approval workflows and lender-required insurance compliance checks.',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code uniquely identifying the insurer within the U.S. insurance regulatory framework. Used for surplus lines compliance verification and state admittance lookups.. Valid values are `^[0-9]{5}$`',
    `naic_group_code` STRING COMMENT 'NAIC group code identifying the insurance holding company group to which this insurer belongs, enabling consolidated carrier exposure monitoring across the portfolio.. Valid values are `^[0-9]{4,5}$`',
    `next_review_date` DATE COMMENT 'Date on which the next scheduled financial strength and regulatory compliance review of the insurer is due. Drives automated review reminders and carrier monitoring workflows.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about the insurer, including relationship history, special underwriting conditions, known coverage exclusions, or risk management observations not captured in structured fields.',
    `preferred_carrier` BOOLEAN COMMENT 'Indicates whether the insurer has been designated as a preferred carrier for the real estate portfolio, typically reflecting a strategic relationship, competitive pricing, or superior claims service history. Preferred carriers are prioritized in renewal and new placement solicitations.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary relationship contact at the insurer. Used for policy administration correspondence, renewal notices, and COI issuance requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary relationship contact at the insurer for general policy administration, renewal negotiations, and certificate of insurance (COI) requests.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number of the primary relationship contact at the insurer for policy administration and renewal discussions.',
    `sp_rating` STRING COMMENT 'S&P Global Ratings Insurer Financial Strength (IFS) rating assigned to the carrier (e.g., AAA, AA+, AA, A+, A, BBB, NR). Supplementary carrier strength indicator used by asset managers and lenders requiring dual-rated carriers for CMBS and REIT portfolio insurance programs.',
    `state_admittance_status` STRING COMMENT 'Indicates whether the insurer is admitted (licensed) or non-admitted (surplus lines) in the primary operating state of the real estate portfolio. Drives regulatory filing requirements, surplus lines tax obligations, and guaranty fund eligibility for policyholders.. Valid values are `admitted|non_admitted|not_applicable`',
    `surplus_lines_eligible` BOOLEAN COMMENT 'Indicates whether the insurer is eligible to write surplus lines (non-admitted) business in applicable jurisdictions. True when the carrier appears on the states approved surplus lines insurer list (e.g., SLIP, ELANY). Required for regulatory compliance on non-admitted placements.',
    `trade_name` STRING COMMENT 'Operating or brand name of the insurer if different from the legal name, used for day-to-day business communications and certificate of insurance (COI) references.',
    `underwriting_contact_email` STRING COMMENT 'Email address of the underwriting contact at the insurer for risk submission, coverage negotiation, and endorsement requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `underwriting_contact_name` STRING COMMENT 'Full name of the underwriting contact at the insurer responsible for risk assessment, coverage negotiations, endorsements, and policy terms for the real estate portfolio.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the insurer record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, incremental data loads in the Databricks Silver Layer, and audit trail compliance.',
    `website` STRING COMMENT 'Official website URL of the insurer. Used for self-service certificate of insurance (COI) portals, claims reporting portals, and carrier financial information lookups.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_insurer PRIMARY KEY(`insurer_id`)
) COMMENT 'Master registry of insurance carriers, syndicates, and reinsurers providing coverage to the real estate portfolio. Captures insurer legal name, NAIC company code, AM Best rating, AM Best financial size category, surplus lines eligibility flag, state admittance status, insurer type (admitted, non-admitted, Lloyds syndicate, captive), primary contact, claims contact, underwriting contact, and insurer status (active, inactive, in run-off). Supports carrier financial strength monitoring and regulatory compliance for surplus lines placements.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`insurance_broker` (
    `insurance_broker_id` BIGINT COMMENT 'Unique surrogate identifier for the insurance broker record in the real estate portfolio insurance program. Primary key for this master party entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Insurance broker office country determines licensing jurisdiction, regulatory compliance requirements, and applicable insurance law. office_country is a denormalized plain-text reference to referenc',
    `parent_insurance_broker_id` BIGINT COMMENT 'Self-referencing FK on insurance_broker (parent_insurance_broker_id)',
    `account_executive_email` STRING COMMENT 'Business email address of the account executive assigned by the broker firm for escalation and strategic account management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `account_executive_name` STRING COMMENT 'Full name of the senior account executive or relationship manager assigned by the broker firm to manage the real estate portfolio insurance account at a strategic level.',
    `am_best_rating` STRING COMMENT 'AM Best financial strength rating of the broker firm (if applicable, e.g., for captive managers or MGAs with carrier functions), used to assess financial stability. Typically expressed as A++, A+, A, A-, B++, etc.',
    `background_check_date` DATE COMMENT 'Date on which the most recent background check and due diligence review of the insurance broker firm was completed as part of vendor onboarding or periodic re-qualification.',
    `binding_authority` BOOLEAN COMMENT 'Indicates whether the broker firm holds delegated binding authority from one or more carriers, allowing them to bind coverage on behalf of the insurer without prior carrier approval. Relevant for managing general agents (MGAs) and wholesale brokers.',
    `broker_status` STRING COMMENT 'Current lifecycle status of the insurance broker relationship within the real estate portfolio insurance program. Active indicates the broker is currently engaged; suspended indicates a temporary hold pending review; terminated indicates the relationship has ended.. Valid values are `active|inactive|suspended|terminated|pending_approval`',
    `broker_type` STRING COMMENT 'Classification of the insurance broker by market channel and function. Retail brokers place coverage directly with admitted carriers; wholesale brokers access non-admitted markets; surplus lines brokers place coverage in the excess and surplus lines market; captive managers administer captive insurance programs; managing general agents (MGAs) have binding authority. [ENUM-REF-CANDIDATE: retail|wholesale|surplus_lines|captive_manager|managing_general_agent|reinsurance_intermediary — promote to reference product]. Valid values are `retail|wholesale|surplus_lines|captive_manager|managing_general_agent`',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'Standard brokerage commission rate expressed as a percentage of gross written premium (GWP) earned by the broker for placing and servicing insurance policies for the real estate portfolio. Used in premium allocation and OPEX budgeting.',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Indicates whether a known or disclosed conflict of interest exists with this broker, such as ownership interests in carriers, contingent commission arrangements, or affiliated party relationships that require disclosure under NAIC or SEC regulations.',
    `contingent_commission_eligible` BOOLEAN COMMENT 'Indicates whether the broker firm is eligible to receive contingent or profit-sharing commissions from carriers based on portfolio loss ratios or volume thresholds, which may create a conflict of interest requiring disclosure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the insurance broker record was first created in the system, used for audit trail and data lineage tracking.',
    `domicile_state` STRING COMMENT 'Two-letter U.S. state code of the broker firms state of domicile (home state) where the primary insurance producer license is issued.. Valid values are `^[A-Z]{2}$`',
    `eo_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum coverage limit in USD of the broker firms Errors and Omissions (E&O) professional liability insurance policy. Validates the brokers financial capacity to cover claims arising from professional negligence in placing or servicing the real estate portfolios insurance programs.',
    `eo_expiration_date` DATE COMMENT 'Expiration date of the broker firms Errors and Omissions (E&O) professional liability insurance policy. Triggers renewal tracking workflows to ensure continuous coverage before engaging the broker for new placements.',
    `eo_insurer_name` STRING COMMENT 'Name of the insurance carrier underwriting the broker firms Errors and Omissions (E&O) professional liability policy.',
    `eo_policy_number` STRING COMMENT 'Policy number of the broker firms Errors and Omissions (E&O) professional liability insurance policy, used for verification and claims reference.',
    `firm_name` STRING COMMENT 'Legal registered name of the insurance brokerage firm or agency engaged to place and service insurance programs for the real estate portfolio. Distinct from brokerage.broker which represents real estate sales/leasing brokers.',
    `license_number` STRING COMMENT 'Primary state-issued insurance producer or broker license number for the brokerage firm. Used to verify regulatory standing and compliance with state insurance department requirements.',
    `licensed_states` STRING COMMENT 'Comma-separated list of U.S. state abbreviations (e.g., CA,NY,TX,FL) in which the insurance broker firm holds active producer or surplus lines licenses. Used to validate the brokers authority to place coverage for properties in each jurisdiction.',
    `lines_of_business` STRING COMMENT 'Comma-separated list of insurance lines of business the broker is authorized and experienced to place for the real estate portfolio (e.g., property, general_liability, umbrella, workers_comp, directors_officers, environmental, cyber, builders_risk).',
    `naic_company_code` STRING COMMENT 'Five-digit NAIC company code assigned to the insurance broker or agency firm by the National Association of Insurance Commissioners for regulatory identification and market conduct reporting.. Valid values are `^[0-9]{5}$`',
    `notes` STRING COMMENT 'Free-text field for internal notes, special instructions, or contextual information about the insurance broker relationship not captured in structured fields (e.g., negotiation history, service issues, market access notes).',
    `of_record` BOOLEAN COMMENT 'Indicates whether this broker holds Broker of Record (BOR) status for the real estate portfolio insurance program, granting exclusive authority to represent the insured in placing and servicing designated insurance lines with carriers.',
    `office_address_line1` STRING COMMENT 'Primary street address line of the broker firms principal office used for correspondence, regulatory filings, and vendor records.',
    `office_city` STRING COMMENT 'City of the broker firms principal office address.',
    `office_postal_code` STRING COMMENT 'ZIP or postal code of the broker firms principal office address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `office_state` STRING COMMENT 'Two-letter U.S. state code of the broker firms principal office location.. Valid values are `^[A-Z]{2}$`',
    `parent_firm_name` STRING COMMENT 'Legal name of the parent company or holding group of the insurance broker firm, if the broker is a subsidiary or affiliate of a larger brokerage group (e.g., Marsh McLennan, Aon, Willis Towers Watson).',
    `performance_rating` STRING COMMENT 'Internal qualitative performance rating assigned to the insurance broker based on service quality, claims advocacy, market access, renewal outcomes, and responsiveness to the real estate portfolios insurance needs.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `preferred_carrier_relationships` STRING COMMENT 'Comma-separated list of insurance carrier names with which the broker maintains preferred or exclusive placement relationships, informing carrier selection strategy for the real estate portfolio.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the insurance broker firm for policy servicing, renewal communications, and claims coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the insurance broker firm responsible for day-to-day servicing of the real estate portfolio insurance account.',
    `primary_contact_phone` STRING COMMENT 'Direct business phone number for the primary contact at the insurance broker firm.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `relationship_end_date` DATE COMMENT 'Date on which the insurance broker relationship was terminated or is scheduled to end. Null for active ongoing relationships.',
    `relationship_start_date` DATE COMMENT 'Date on which the insurance broker relationship was formally established with the real estate organization, marking the effective start of the broker-of-record or service engagement.',
    `renewal_review_date` DATE COMMENT 'Scheduled date for the annual or periodic review of the broker engagement, including performance evaluation, commission renegotiation, and broker-of-record letter renewal.',
    `surplus_lines_license_number` STRING COMMENT 'State-issued surplus lines broker license number, applicable when the broker places coverage in the non-admitted (excess and surplus lines) market for hard-to-place real estate risks such as vacant properties, high-value assets, or environmental exposures.',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID of the insurance broker firm, required for IRS Form 1099 commission reporting and vendor onboarding in the accounts payable system.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `trading_name` STRING COMMENT 'Doing-business-as (DBA) or trade name used by the insurance broker firm if different from the legal registered firm name.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the insurance broker record was most recently modified, supporting audit trail, change tracking, and incremental data pipeline processing in the Databricks Silver Layer.',
    CONSTRAINT pk_insurance_broker PRIMARY KEY(`insurance_broker_id`)
) COMMENT 'Master record for insurance brokers, agents, and risk management consultants engaged to place and service insurance programs for the real estate portfolio. Captures broker firm name, broker license number, state licenses held, broker type (retail, wholesale, surplus lines, captive manager), primary contact, account executive assigned, broker of record status, errors and omissions (E&O) coverage limit, E&O expiration date, brokerage commission rate, and broker status. Distinct from brokerage.broker (real estate sales/leasing brokers) — this entity represents insurance intermediaries.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`adjuster` (
    `adjuster_id` BIGINT COMMENT 'Unique system-generated identifier for the insurance adjuster record in the real estate portfolio insurance management system.',
    `vendor_id` BIGINT COMMENT 'Vendor or supplier identifier assigned to the adjusting firm or independent adjuster in the accounts payable (AP) system (Yardi Voyager / SAP S/4HANA). Links adjuster fee payments to the AP module.',
    `supervising_adjuster_id` BIGINT COMMENT 'Self-referencing FK on adjuster (supervising_adjuster_id)',
    `adjuster_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the adjuster for cross-system reference and claim assignment tracking across the real estate portfolio.. Valid values are `^ADJ-[A-Z0-9]{6,12}$`',
    `adjuster_status` STRING COMMENT 'Current lifecycle status of the adjuster record. Active indicates the adjuster is eligible for claim assignment. Suspended indicates a temporary hold pending license review or performance investigation.. Valid values are `active|inactive|suspended|pending|retired`',
    `adjuster_type` STRING COMMENT 'Classification of the adjuster by engagement model: staff (employed by insurer), independent (contracted third party), public (retained by policyholder), catastrophe (deployed for large-scale loss events), or desk (remote/virtual adjuster). [ENUM-REF-CANDIDATE: staff|independent|public|catastrophe|desk|field — promote to reference product]. Valid values are `staff|independent|public|catastrophe|desk`',
    `asset_type_expertise` STRING COMMENT 'Pipe-delimited list of real estate asset types the adjuster specializes in (e.g., multifamily|office|retail|industrial|hospitality|mixed_use). Enables precise claim routing by property type within the CRE portfolio.',
    `background_check_date` DATE COMMENT 'Date on which the most recent background check was completed for the adjuster. Required for adjusters with access to occupied residential or commercial properties in the real estate portfolio. Format: yyyy-MM-dd.',
    `background_check_status` STRING COMMENT 'Current status of the adjusters background check. Passed = cleared for property access. Expired = re-check required. Failed = access restricted pending review.. Valid values are `passed|failed|pending|expired`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the adjusters primary business location (e.g., USA, CAN). Supports international portfolio coverage.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjuster record was first created in the system. Supports audit trail and data lineage requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `current_claim_count` STRING COMMENT 'Number of open claims currently assigned to this adjuster. Used for workload balancing and capacity management during claim assignment. Updated by the claims management system.',
    `designation` STRING COMMENT 'Industry professional designation(s) held by the adjuster (e.g., AIC — Associate in Claims, CPCU — Chartered Property Casualty Underwriter, SCLA — Senior Claim Law Associate). Pipe-delimited if multiple. Indicates expertise level for large-loss and complex CRE claims.',
    `e_and_o_expiry_date` DATE COMMENT 'Expiration date of the adjusters E&O professional liability insurance policy. Triggers renewal alert and may block new assignments if expired. Format: yyyy-MM-dd.',
    `e_and_o_policy_number` STRING COMMENT 'Policy number of the adjusters or firms Errors and Omissions (E&O) professional liability insurance policy. Used for vendor compliance verification.',
    `email` STRING COMMENT 'Primary business email address for the adjuster. Used for claim assignment notifications, document exchange, and adjuster performance communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fee_basis` STRING COMMENT 'Basis on which the adjusters compensation is calculated: hourly rate, flat fee per claim, percentage of loss settlement, or retainer. Drives AP invoice validation in Yardi Voyager.. Valid values are `hourly|flat_fee|percentage_of_loss|retainer`',
    `firm_name` STRING COMMENT 'Name of the independent adjusting firm or third-party administrator (TPA) the adjuster is affiliated with. Null for staff adjusters employed directly by the insurer.',
    `first_name` STRING COMMENT 'Legal first name of the individual insurance adjuster. Applies to staff, independent, public, and catastrophe adjusters. Null for firm-level records.',
    `geographic_coverage_region` STRING COMMENT 'Pipe-delimited list of geographic regions (e.g., Southeast|Gulf Coast|Mid-Atlantic) where the adjuster is available for on-site property inspections. Supports portfolio-level claim routing for multi-region real estate assets.',
    `hourly_rate_usd` DECIMAL(18,2) COMMENT 'Contracted hourly billing rate in US dollars for independent or public adjusters. Used for fee accrual and OPEX tracking against the insurance cost center.',
    `is_catastrophe_eligible` BOOLEAN COMMENT 'Indicates whether the adjuster is qualified and available for deployment in catastrophe (CAT) events such as hurricanes, floods, or wildfires affecting the real estate portfolio. True = CAT-eligible.',
    `is_e_and_o_insured` BOOLEAN COMMENT 'Indicates whether the adjuster or adjusting firm carries active Errors and Omissions (E&O) professional liability insurance. Required for independent and public adjusters engaged on the real estate portfolio.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the individual insurance adjuster. Used in claim assignment records, correspondence, and adjuster performance reporting.',
    `license_expiry_date` DATE COMMENT 'Date on which the adjusters primary state license expires. Triggers renewal workflow and blocks new claim assignments if expired. Format: yyyy-MM-dd.',
    `license_number` STRING COMMENT 'Primary state-issued adjuster license number. Used to verify regulatory compliance before claim assignment. Each state issues its own license; this field captures the home-state or primary license.',
    `license_state` STRING COMMENT 'Two-letter US state code for the adjusters primary (home-state) license. Determines the base jurisdiction for regulatory compliance and reciprocity agreements.. Valid values are `^[A-Z]{2}$`',
    `licensed_states` STRING COMMENT 'Pipe-delimited list of US state codes (e.g., CA|TX|FL|NY) in which the adjuster holds an active license or reciprocal authorization. Governs geographic eligibility for claim assignment across the real estate portfolios multi-state footprint.',
    `mailing_address_line1` STRING COMMENT 'Primary street address line for the adjusters business mailing address. Used for correspondence, certificate of insurance (COI) delivery, and regulatory filings.',
    `mailing_city` STRING COMMENT 'City component of the adjusters business mailing address.',
    `mailing_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the adjusters business mailing address.. Valid values are `^d{5}(-d{4})?$`',
    `mailing_state` STRING COMMENT 'Two-letter US state code for the adjusters business mailing address.. Valid values are `^[A-Z]{2}$`',
    `max_claim_authority_usd` DECIMAL(18,2) COMMENT 'Maximum dollar amount the adjuster is authorized to settle a claim without escalation or supervisory approval. Critical for claim routing in high-value commercial real estate loss events.',
    `max_claim_capacity` STRING COMMENT 'Maximum number of concurrent open claims the adjuster or firm is contracted or rated to handle. Used to prevent over-assignment and ensure timely claim resolution across the real estate portfolio.',
    `mobile_phone` STRING COMMENT 'Mobile phone number for the adjuster, used for field coordination during property inspections and catastrophe deployments.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text field for operational notes regarding the adjuster, such as availability constraints, specialization nuances, escalation contacts, or historical performance observations.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Internal performance rating score on a 1.0–5.0 scale, derived from claim resolution timeliness, settlement accuracy, and policyholder satisfaction surveys. Used for preferred adjuster panel management.',
    `phone` STRING COMMENT 'Primary business phone number for the adjuster. Used for urgent claim coordination, site inspection scheduling, and loss run follow-up.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_contact_method` STRING COMMENT 'Adjusters preferred channel for receiving claim assignment notifications and communications: email, phone, mobile, or insurer portal.. Valid values are `email|phone|mobile|portal`',
    `preferred_panel_flag` BOOLEAN COMMENT 'Indicates whether the adjuster is on the insurers or real estate companys preferred adjuster panel, qualifying them for priority claim assignment. True = preferred panel member.',
    `secondary_specialty` STRING COMMENT 'Secondary area of claims expertise, enabling flexible assignment when the primary specialty adjuster is unavailable. Supports multi-peril claims common in commercial real estate portfolios.',
    `specialty` STRING COMMENT 'Primary area of claims expertise for the adjuster within the real estate insurance context. Drives claim routing logic for property damage, liability, business interruption, large loss (typically >$500K), and environmental claims. [ENUM-REF-CANDIDATE: property|liability|business_interruption|large_loss|environmental|flood|casualty — promote to reference product]. Valid values are `property|liability|business_interruption|large_loss|environmental`',
    `tax_identifier` STRING COMMENT 'Federal Tax Identification Number (EIN for firms, SSN/ITIN for individual adjusters) used for IRS 1099 reporting of adjuster fee payments. Required for AP payment processing in Yardi Voyager.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjuster record was most recently modified. Used for change tracking, data freshness monitoring, and Silver Layer incremental load processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `years_experience` STRING COMMENT 'Total number of years of professional claims adjusting experience. Used in adjuster performance scoring and assignment eligibility for complex large-loss real estate claims.',
    CONSTRAINT pk_adjuster PRIMARY KEY(`adjuster_id`)
) COMMENT 'Master record for insurance adjusters and independent adjusting firms assigned to evaluate and settle claims against the real estate portfolio. Captures adjuster name, adjuster type (staff adjuster, independent adjuster, public adjuster, catastrophe adjuster), firm name, license number, states licensed, contact information, adjuster specialty (property, liability, business interruption, large loss), current claim assignment count, and adjuster status. Enables claim assignment tracking and adjuster performance monitoring.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`claim_reserve` (
    `claim_reserve_id` BIGINT COMMENT 'Unique system-generated identifier for each claim reserve record. Primary key for the claim_reserve data product in the insurance domain.',
    `adjuster_id` BIGINT COMMENT 'Reference to the claims adjuster or third-party administrator (TPA) who authorized or established this reserve record.',
    `asset_id` BIGINT COMMENT 'Reference to the real estate asset (property) associated with the insured claim. Supports portfolio-level reserve aggregation and loss analysis by asset.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Claim reserves can be established at the blanket group level when claims are filed under blanket coverage. This supports reserve management and financial reporting for blanket programs.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Claim reserves are accrued to specific GL liability accounts for balance sheet reporting. claim_reserve.gl_account_code is a plain-text denormalization. FK to chart_of_accounts supports period-close G',
    `claim_id` BIGINT COMMENT 'Reference to the parent insurance claim for which this reserve record is established. Links the reserve to its associated claim lifecycle.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Claim reserves are tracked at the property/cost-center level for property-level P&L reporting and CAM reconciliation. claim_reserve.cost_center_code is a plain-text denormalization. FK to cost_center ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Reserve amounts, cumulative reserves, paid-to-date amounts, and reinsurance recoverables are currency-denominated. Authoritative currency reference is required for actuarial reserve adequacy analysis,',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Claim reserves require GL accrual journal entries under GAAP/IFRS for RE financial reporting. Linking claim_reserve to journal_entry supports period-close accrual reconciliation, SOX controls over res',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy under which the claim and reserve are established. Enables reserve reporting by policy.',
    `superseded_claim_reserve_id` BIGINT COMMENT 'Self-referencing FK on claim_reserve (superseded_claim_reserve_id)',
    `actuarial_review_date` DATE COMMENT 'The date on which an actuarial review of this reserve was last performed. Supports reserve adequacy certification and regulatory filing requirements for publicly traded REITs.',
    `adjuster_authorization_code` STRING COMMENT 'Unique authorization code issued by the claims adjuster or supervisor approving the reserve establishment or adjustment. Provides an audit trail for reserve authority compliance and SOX controls.. Valid values are `^AUTH-[A-Z0-9]{6,12}$`',
    `authority_limit_amount` DECIMAL(18,2) COMMENT 'The maximum reserve amount the authorizing adjuster is permitted to establish or adjust under the insurers claims authority matrix. Used to validate that reserve actions are within delegated authority.',
    `cat_event_code` STRING COMMENT 'Industry-standard catastrophe event identifier (e.g., ISO CAT code or internal CAT designation) linking this reserve to a specific declared catastrophe. Null if is_cat_event is False. Supports CAT loss aggregation and reinsurance treaty reporting.. Valid values are `^CAT-[A-Z0-9]{4,10}$`',
    `change_amount` DECIMAL(18,2) COMMENT 'The incremental dollar amount of the most recent reserve adjustment. Positive values indicate a reserve increase (strengthening); negative values indicate a reserve decrease (release). Critical for loss development and financial reporting.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the most recent reserve adjustment. Supports reserve development analysis and adjuster performance review. [ENUM-REF-CANDIDATE: new_information|litigation_update|settlement_negotiation|coverage_determination|actuarial_review|reopen|payment_applied|subrogation_recovery — promote to reference product]. Valid values are `new_information|litigation_update|settlement_negotiation|coverage_determination|actuarial_review|reopen`',
    `change_reason_description` STRING COMMENT 'Free-text narrative provided by the adjuster explaining the specific circumstances or findings that prompted the reserve adjustment. Supplements the change_reason_code with contextual detail.',
    `coverage_type` STRING COMMENT 'The insurance coverage line under which this reserve is established. Reflects the type of loss being reserved (e.g., property damage to a building, general liability for a tenant slip-and-fall, business interruption from a covered peril). [ENUM-REF-CANDIDATE: property_damage|general_liability|workers_compensation|business_interruption|environmental|umbrella|directors_officers — promote to reference product]. Valid values are `property_damage|general_liability|workers_compensation|business_interruption|environmental`',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this reserve record was first created in the data platform. Used for audit trail, data lineage, and SOX compliance purposes.',
    `cumulative_reserve_amount` DECIMAL(18,2) COMMENT 'The total cumulative reserve amount established for this claim from inception through the current reporting date, inclusive of all adjustments. Used in loss development triangle construction and actuarial analysis.',
    `current_reserve_amount` DECIMAL(18,2) COMMENT 'The current outstanding reserve balance for this reserve record after all adjustments have been applied. Represents the insurers best estimate of remaining financial exposure at the reporting date.',
    `established_amount` DECIMAL(18,2) COMMENT 'The initial gross reserve amount set at the time the reserve was first established for this claim, expressed in the policy currency. Represents the adjusters initial estimate of total financial exposure.',
    `financial_period` STRING COMMENT 'The accounting period (year-quarter or year-month) to which this reserve record is allocated for financial reporting and GL posting purposes (e.g., 2024-Q3 or 2024-09). Aligns with the finance domains period close process.. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `incurred_amount` DECIMAL(18,2) COMMENT 'The total incurred loss amount for this reserve, calculated as paid-to-date plus current outstanding reserve. Represents the insurers best estimate of ultimate claim cost. Used in loss ratio and NOI impact analysis.',
    `is_cat_event` BOOLEAN COMMENT 'Boolean flag indicating whether this reserve is associated with a declared catastrophe event (e.g., hurricane, earthquake, wildfire). True = CAT event reserve. Enables segregated CAT loss reporting and reinsurance recovery tracking.',
    `is_ibnr` BOOLEAN COMMENT 'Boolean flag indicating whether this reserve record represents an IBNR (Incurred But Not Reported) estimate rather than a case reserve for a reported claim. True = IBNR reserve; False = case reserve. Critical for actuarial loss development and financial statement disclosure.',
    `loss_category` STRING COMMENT 'Classification of the peril or cause of loss that triggered the claim and reserve. Used for loss trend analysis, CAT (catastrophe) modeling, and portfolio risk management across the real estate asset base. [ENUM-REF-CANDIDATE: fire|water_damage|wind_storm|theft|liability|flood|earthquake|vandalism|mold|structural — promote to reference product]',
    `loss_run_report_date` DATE COMMENT 'The date of the most recent loss run report from the insurer or TPA that includes this reserve record. Used to confirm reserve data currency and support policy renewal negotiations.',
    `notes` STRING COMMENT 'Free-text field for adjuster or actuarial commentary on the reserve record, including observations on claim development, coverage disputes, litigation status, or other material factors affecting reserve adequacy.',
    `paid_to_date_amount` DECIMAL(18,2) COMMENT 'Total loss payments made against this claim from inception through the current reporting date. Combined with the current reserve amount to derive the ultimate incurred loss estimate.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'The estimated portion of the current reserve that is expected to be recovered from reinsurance treaties or facultative arrangements. Reduces net reserve exposure on the insurers balance sheet. Relevant for REIT and large portfolio insurance programs.',
    `reserve_adequacy_flag` BOOLEAN COMMENT 'Boolean indicator set by the adjuster or actuarial team confirming whether the current reserve is considered adequate to cover the estimated ultimate loss. True = adequate; False = deficient and requiring strengthening. Critical for financial reporting and regulatory compliance.',
    `reserve_basis` STRING COMMENT 'The methodology used to establish the reserve amount. Case basis reserves are set individually by the adjuster; actuarial estimates are derived from statistical models; bulk reserves cover groups of similar claims; formula basis uses a predetermined calculation rule.. Valid values are `case_basis|actuarial_estimate|bulk_reserve|formula_basis`',
    `reserve_change_date` DATE COMMENT 'The calendar date on which the most recent reserve adjustment was applied. Tracks the timeline of reserve development for actuarial and loss forecasting purposes.',
    `reserve_close_date` DATE COMMENT 'The calendar date on which the reserve was closed upon claim settlement or denial. Null if the reserve remains open. Used for loss development triangle analysis.',
    `reserve_established_date` DATE COMMENT 'The calendar date on which this reserve was first established for the claim. Used for aging analysis, financial period allocation, and regulatory reporting.',
    `reserve_number` STRING COMMENT 'Externally-known alphanumeric identifier for this reserve record, used in adjuster systems, TPA portals, and financial reporting. Follows the format RES-XXXXXXXXXX.. Valid values are `^RES-[0-9]{8,12}$`',
    `reserve_status` STRING COMMENT 'Current lifecycle state of the reserve record. Open indicates an active reserve; pending_review indicates the reserve is under adjuster or actuarial review; adjusted indicates a change has been applied; closed indicates the claim is settled and reserve released; reopened indicates a previously closed reserve has been reinstated.. Valid values are `open|pending_review|adjusted|closed|reopened`',
    `reserve_type` STRING COMMENT 'Classification of the reserve by its financial purpose. Indemnity reserve covers the estimated loss payment to the claimant; expense reserve covers allocated loss adjustment expenses (ALAE); IBNR (Incurred But Not Reported) covers estimated unreported losses; salvage and subrogation reserves offset expected recoveries. [ENUM-REF-CANDIDATE: indemnity|expense|ibnr|salvage|subrogation|allocated_loss_adjustment — promote to reference product]. Valid values are `indemnity|expense|ibnr|salvage|subrogation|allocated_loss_adjustment`',
    `revision_sequence` STRING COMMENT 'Sequential integer indicating the version or revision number of this reserve record within the claims reserve history. Revision 1 is the initial establishment; subsequent increments represent each adjustment. Enables full reserve development history tracking.',
    `salvage_recoverable_amount` DECIMAL(18,2) COMMENT 'Estimated amount expected to be recovered through salvage of damaged property assets. Offsets the gross reserve to derive the net reserve exposure. Applicable to property damage claims on real estate assets.',
    `subrogation_recoverable_amount` DECIMAL(18,2) COMMENT 'Estimated amount expected to be recovered through subrogation actions against liable third parties (e.g., contractors, tenants, neighboring property owners). Reduces net reserve exposure.',
    `tpa_reference_number` STRING COMMENT 'The external reference number assigned by the Third-Party Administrator (TPA) managing this claim on behalf of the insured. Enables reconciliation between internal reserve records and TPA loss run reports.',
    `updated_timestamp` TIMESTAMP COMMENT 'The system timestamp when this reserve record was most recently modified in the data platform. Supports incremental data processing in the Databricks Lakehouse Silver Layer and audit trail requirements.',
    CONSTRAINT pk_claim_reserve PRIMARY KEY(`claim_reserve_id`)
) COMMENT 'Reserve establishment and adjustment record tracking the financial reserves set by the insurer or TPA for each open claim. Captures reserve type (indemnity reserve, expense reserve, IBNR), reserve amount established, reserve change amount, reserve change reason, reserve change date, adjuster authorization, cumulative reserve, and reserve adequacy flag. Tracks the full reserve history for each claim from opening through closure. Critical for loss forecasting, financial reporting, and actuarial analysis.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`liability_event` (
    `liability_event_id` BIGINT COMMENT 'Unique system-generated identifier for the liability incident event record. Primary key for the liability_event data product.',
    `building_id` BIGINT COMMENT 'Reference to the specific building within a multi-building property where the incident occurred. Enables granular risk analysis at the building level within a portfolio asset.',
    `claim_id` BIGINT COMMENT 'Reference to the formal insurance claim record created when a claim is filed arising from this liability event. Null until a formal claim is submitted. Links the event to the downstream claim lifecycle.',
    `common_area_id` BIGINT COMMENT 'Foreign key linking to property.common_area. Business justification: Liability incidents in lobbies, stairwells, and mechanical rooms are a primary source of GL claims. Linking liability events to specific common areas enables property managers to prioritize maintenanc',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Estimated exposure amounts for liability events (slip-and-fall, premises liability) are currency-denominated. Authoritative currency reference is required for litigation reserve setting, insurer notif',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_event. Business justification: When a liability incident (slip-and-fall, injury) occurs during a marketing event such as an open house or broker tour, risk management must trace the incident to the specific marketing event for clai',
    `document_id` BIGINT COMMENT 'Reference to the formal incident report document stored in the document management system (e.g., DocuSign CLM or Building Engines). Provides access to the original written incident report.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Liability events on managed properties frequently involve employees (negligence, workplace injury). Linking to employee is required for workers compensation coordination, HR incident reporting, and O',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (property-owning entity or management company) that bears the liability exposure for this incident. Required for financial disclosure, insurance coverage determination, and legal defense coordination.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to remediate the property condition that contributed to the incident. Links the liability event to the corrective maintenance action in Building Engines.',
    `osha_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_incident. Business justification: Slip-and-fall and workplace injury events are simultaneously OSHA recordable incidents and insurance liability events. Linking liability_event to osha_incident enables coordinated incident response, e',
    `parking_id` BIGINT COMMENT 'Foreign key linking to property.parking. Business justification: Parking facility incidents (vehicle damage, pedestrian injuries, slip-and-falls) are a major GL liability category in real estate. Linking liability events to specific parking facilities enables risk ',
    `policy_id` BIGINT COMMENT 'Reference to the general liability or premises liability insurance policy under which this incident may be covered. Links the event to the applicable policy record.',
    `asset_id` BIGINT COMMENT 'Reference to the managed property or real estate asset where the liability incident occurred. Used to associate the event with the specific portfolio asset.',
    `showing_id` BIGINT COMMENT 'Foreign key linking to brokerage.showing. Business justification: Slip-and-fall and other liability incidents occur during property showings. When a liability event is reported, the showing record provides the operational context (who attended, broker present, time/',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant record if the incident involves a tenant-occupied space or a tenant as the injured party. Links the event to the tenant relationship for lease and liability context.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Slip-and-fall, habitability, and tenant injury incidents are tracked at the unit level for loss history, lease renewal decisions, and maintenance work order correlation. The existing liability_event.u',
    `related_liability_event_id` BIGINT COMMENT 'Self-referencing FK on liability_event (related_liability_event_id)',
    `attorney_assigned` BOOLEAN COMMENT 'Indicates whether a defense attorney has been assigned to represent the property owner or manager in connection with this incident. Relevant once litigation or formal claim proceedings begin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the liability event record was first created in the system. Audit trail field for data governance and lineage tracking.',
    `defense_counsel_firm` STRING COMMENT 'Name of the law firm or attorney assigned to defend the property owner or manager against the liability claim or lawsuit. Used for legal spend tracking and matter management.',
    `estimated_exposure_amount` DECIMAL(18,2) COMMENT 'Risk management teams estimate of the maximum potential financial exposure from this incident, in the portfolios base currency. Used for reserve setting, financial disclosure under FASB ASC 450, and portfolio risk reporting.',
    `event_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the liability incident for tracking across systems, correspondence, and insurer communication. Format: LBE-YYYY-NNNNNN.. Valid values are `^LBE-[0-9]{4}-[0-9]{6}$`',
    `incident_description` STRING COMMENT 'Detailed narrative description of how the liability incident occurred, including circumstances, contributing factors, and immediate actions taken. Serves as the primary factual record for claims investigation and legal defense.',
    `incident_location_detail` STRING COMMENT 'Free-text description of the precise location within the property where the incident occurred (e.g., North stairwell between floors 2 and 3, Parking space B-14 near entrance). Supplements the incident_location_type classification.',
    `incident_location_type` STRING COMMENT 'Classification of the specific area within the property where the incident occurred. Used for risk hotspot analysis and property maintenance prioritization. [ENUM-REF-CANDIDATE: common_area|parking_lot|lobby|stairwell|unit_interior|exterior_grounds|roof|mechanical_room|other — promote to reference product]',
    `incident_status` STRING COMMENT 'Current lifecycle status of the liability incident event. Tracks progression from initial report through resolution. claim_filed indicates a formal claim has been submitted to the insurer. litigated indicates active legal proceedings.. Valid values are `open|under_review|claim_filed|closed_no_claim|closed_with_claim|litigated`',
    `incident_timestamp` TIMESTAMP COMMENT 'The precise date and time the liability incident occurred at the property. This is the principal real-world event timestamp, distinct from the report date. Critical for statute of limitations and coverage determination.',
    `incident_type` STRING COMMENT 'Classification of the nature of the liability incident. Drives coverage determination, claims routing, and risk analytics. [ENUM-REF-CANDIDATE: slip_and_fall|property_damage|bodily_injury|wrongful_eviction|discrimination_allegation|assault|environmental_exposure|other — promote to reference product]',
    `injured_party_address` STRING COMMENT 'Mailing or residential address of the injured party. Required for formal notice of claim, legal service, and insurer correspondence. Classified as restricted PII.',
    `injured_party_contact` STRING COMMENT 'Primary contact phone number for the injured party or their legal representative. Used for claims communication and legal correspondence. Classified as restricted PII.',
    `injured_party_name` STRING COMMENT 'Full legal name of the individual who was injured or suffered loss in the incident. Required for claim filing and legal proceedings. Classified as restricted PII.',
    `injured_party_type` STRING COMMENT 'Classification of the relationship of the injured or affected party to the property. Affects liability exposure, coverage applicability, and legal strategy. [ENUM-REF-CANDIDATE: tenant|visitor|vendor|employee|trespasser|unknown|other — 7 candidates stripped; promote to reference product]',
    `insurer_notification_date` DATE COMMENT 'Date on which the insurance carrier was formally notified of the incident. Used to verify compliance with policy notice requirements and avoid coverage denial.',
    `insurer_notified` BOOLEAN COMMENT 'Indicates whether the insurance carrier has been formally notified of the incident. Compliance with policy notice requirements is critical to preserving coverage rights.',
    `liability_category` STRING COMMENT 'Broad insurance coverage category under which the incident is classified. Determines which policy type and insurer is notified. Premises liability covers injuries on managed property; professional liability covers errors and omissions by property management staff.. Valid values are `general_liability|premises_liability|professional_liability|product_liability|employment_practices`',
    `litigation_date` DATE COMMENT 'Date on which formal legal proceedings (lawsuit filing) were initiated against the property owner or manager. Marks the transition from pre-litigation to active litigation status.',
    `litigation_status` STRING COMMENT 'Current legal proceedings status associated with the liability incident. Tracks escalation from pre-litigation demand through active lawsuit, settlement, or judgment. Critical for legal reserve setting and disclosure requirements. [ENUM-REF-CANDIDATE: none|demand_letter|pre_litigation|active_litigation|settled|dismissed|judgment — 7 candidates stripped; promote to reference product]',
    `medical_treatment_sought` BOOLEAN COMMENT 'Indicates whether the injured party sought or received medical treatment as a result of the incident. A key indicator of claim severity and potential bodily injury liability exposure.',
    `medical_treatment_type` STRING COMMENT 'Level of medical care received by the injured party. Used to assess claim severity and reserve adequacy. Escalating treatment levels indicate higher potential liability exposure.. Valid values are `none|first_aid|emergency_room|hospitalized|ongoing_treatment|unknown`',
    `notice_of_claim_date` DATE COMMENT 'Date on which the formal notice of claim was received from the injured party or their attorney. Starts the clock on insurer notification deadlines and statute of limitations tracking.',
    `notice_of_claim_received` BOOLEAN COMMENT 'Indicates whether a formal notice of claim has been received from the injured party or their legal representative. Triggers the formal claims process and insurer notification obligations.',
    `police_report_filed` BOOLEAN COMMENT 'Indicates whether a police report was filed in connection with the incident. True if law enforcement was involved and a report was generated.',
    `police_report_number` STRING COMMENT 'Official police report reference number if law enforcement was called to the scene. Provides an independent third-party record of the incident for claims and legal proceedings.',
    `property_condition_flag` BOOLEAN COMMENT 'Indicates whether a property condition defect (e.g., wet floor, broken handrail, poor lighting, uneven pavement) was identified as a contributing factor to the incident. Drives maintenance work order creation and risk remediation.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time the incident was first reported to property management or the risk management team. Used to measure reporting lag and assess compliance with policy notice requirements.',
    `surveillance_footage_available` BOOLEAN COMMENT 'Indicates whether security camera or surveillance footage of the incident is available and has been preserved. Critical evidence for claims defense and litigation support.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the liability event record was most recently modified. Supports audit trail and change tracking for compliance and data governance purposes.',
    `witness_count` STRING COMMENT 'Number of witnesses present at the time of the incident. Indicates the availability of corroborating testimony for claims investigation and litigation support.',
    `witness_names` STRING COMMENT 'Names of individuals who witnessed the incident. Stored as a delimited text field. Required for claims investigation and potential deposition. Classified as restricted PII.',
    CONSTRAINT pk_liability_event PRIMARY KEY(`liability_event_id`)
) COMMENT 'Liability incident and third-party claim event record capturing occurrences at managed properties that may give rise to general liability, premises liability, or professional liability claims. Captures incident date, incident location (property, building, common area), incident type (slip and fall, property damage to third party, bodily injury, wrongful eviction, discrimination allegation), injured party description, witness information, incident description, police report reference, medical treatment sought flag, notice of claim received flag, and litigation status. Feeds into the claim record when a formal claim is filed.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`captive_account` (
    `captive_account_id` BIGINT COMMENT 'Unique system-generated identifier for the captive insurance program account record. Primary key for this entity. Role: MASTER_AGREEMENT.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Captive insurance programs maintain dedicated bank/trust accounts for loss funds and reserves. Linking captive_account to finance.bank_account supports treasury management, bank reconciliation, and re',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Captive accounts can utilize blanket coverage structures. This links captive insurance programs to blanket groups when the captive provides blanket coverage.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Captive insurance accounts post premiums, losses, and reserves to specific GL accounts for consolidated financial reporting. captive_account.gl_account_code is a plain-text denormalization. FK to char',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Captive account financial amounts (capitalization, retained limits, loss fund balance, gross/net written premium) are currency-denominated. Authoritative currency reference is required for captive reg',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: Captive insurance programs use a fronting carrier (a licensed insurer) to issue policies on behalf of the captive. The captive_account table stores fronting_carrier_name and fronting_carrier_naic_code',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Large institutional real estate funds establish captive insurance entities to self-insure portfolio risks. The captive account must reference the sponsoring fund for consolidated risk reporting, regul',
    `insurance_program_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_program. Business justification: A captive insurance account operates within an enterprise insurance program structure. The captive_account table has program_year and lines_of_business but no FK to the insurance_program master. Addin',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Captive insurance programs are subject to domicile jurisdiction regulatory frameworks (e.g., Vermont, Cayman, Bermuda captive regulations, IRS 953(d) election rules). Linking to regulatory_framework e',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Captive insurance accounts are subject to domicile-specific regulatory obligations (IRS 953(d) elections, annual actuarial filings, domicile solvency reporting). Linking captive_account to regulatory_',
    `ownership_structure_id` BIGINT COMMENT 'Foreign key linking to owner.ownership_structure. Business justification: Large real estate ownership structures (REITs, institutional funds) establish captive insurance programs as their risk financing vehicle. The ownership structure is the sponsoring entity of the captiv',
    `parent_captive_account_id` BIGINT COMMENT 'Self-referencing FK on captive_account (parent_captive_account_id)',
    `account_status` STRING COMMENT 'Current lifecycle status of the captive insurance program account. Drives regulatory filing obligations, premium cession activity, and loss fund management.. Valid values are `active|inactive|pending|suspended|terminated|under-review`',
    `actuary_firm_name` STRING COMMENT 'Name of the independent actuarial firm engaged to perform loss reserve certifications, premium adequacy studies, and feasibility analyses for the captive program.',
    `aggregate_retention_limit` DECIMAL(18,2) COMMENT 'Maximum total dollar amount the captive retains across all losses in a policy period before aggregate stop-loss reinsurance responds. Controls the captives maximum annual loss exposure.',
    `capitalization_amount` DECIMAL(18,2) COMMENT 'Total capital and surplus contributed to the captive insurance entity to meet domicile minimum capitalization requirements and support underwriting capacity. Expressed in the programs functional currency.',
    `captive_account_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the captive program account, used in regulatory filings, reinsurance contracts, and fronting carrier correspondence.',
    `captive_entity_name` STRING COMMENT 'Legal name of the captive insurance entity as registered with the domicile jurisdiction regulator. Used for regulatory filings, financial reporting, and fronting carrier arrangements.',
    `captive_manager_contact` STRING COMMENT 'Primary email address of the captive management firms account manager or relationship contact. Used for regulatory filing coordination, loss fund reporting, and program renewal communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `captive_manager_name` STRING COMMENT 'Name of the third-party captive management firm responsible for day-to-day administration, regulatory filings, accounting, and compliance of the captive entity (e.g., Marsh Captive Solutions, Aon Captive & Insurance Management).',
    `captive_premium_ceded` DECIMAL(18,2) COMMENT 'Total premium amount ceded by the parent real estate entity to the captive insurance vehicle during the current program period. Represents the self-insurance cost allocation and is a key input to OPEX and insurance cost reporting.',
    `captive_type` STRING COMMENT 'Classification of the captive insurance structure. Single-parent captives are wholly owned by one parent; group captives are owned by multiple unrelated entities; rent-a-captive and cell captives share infrastructure. [ENUM-REF-CANDIDATE: single-parent|group|rent-a-captive|cell-captive|association|protected-cell — promote to reference product if additional types emerge]. Valid values are `single-parent|group|rent-a-captive|cell-captive|association`',
    `combined_ratio` DECIMAL(18,2) COMMENT 'Sum of the captives loss ratio and expense ratio, expressed as a decimal. A combined ratio below 1.0 indicates underwriting profitability. Key performance indicator for captive program viability and renewal decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the captive account record was first created in the system. Used for audit trail, data lineage, and SOX compliance.',
    `dividend_paid_amount` DECIMAL(18,2) COMMENT 'Total dividends paid by the captive to its parent entity during the current program year, subject to domicile regulatory approval and minimum surplus requirements. Represents return of underwriting profit to the parent.',
    `domicile_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the nation in which the captive is domiciled (e.g., USA, CYM for Cayman Islands, BMU for Bermuda). Required for cross-border regulatory and tax reporting.. Valid values are `^[A-Z]{3}$`',
    `domicile_jurisdiction` STRING COMMENT 'State or territory where the captive insurance entity is licensed and domiciled (e.g., Vermont, Cayman Islands, Bermuda, Delaware). Governs regulatory requirements, capitalization minimums, and annual filing obligations.',
    `fronting_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of gross written premium charged by the fronting carrier for issuing policies on behalf of the captive. Represents a program cost that impacts the captives net economics.',
    `gross_written_premium` DECIMAL(18,2) COMMENT 'Total premium written by the captive across all lines of business before cessions to reinsurers. Used to assess captive underwriting volume and regulatory capital adequacy.',
    `investment_portfolio_value` DECIMAL(18,2) COMMENT 'Current fair market value of the captives invested assets (bonds, money market instruments, equities per domicile investment guidelines). Supports solvency monitoring and regulatory capital adequacy assessment.',
    `irs_953d_election_flag` BOOLEAN COMMENT 'Indicates whether the captive has made an IRC Section 953(d) election to be treated as a U.S. domestic insurance company for federal tax purposes. Relevant for offshore captives domiciled in Bermuda, Cayman Islands, or other non-U.S. jurisdictions.',
    `last_actuarial_review_date` DATE COMMENT 'Date of the most recent independent actuarial review of the captives loss reserves and premium adequacy. Required annually by most domicile regulators and for FASB ASC 944 reserve certification.',
    `lines_of_business` STRING COMMENT 'Comma-delimited list of insurance lines of business written by the captive (e.g., property, general liability, workers compensation, professional liability, environmental). Determines regulatory capital requirements and reinsurance structure.',
    `loss_fund_balance` DECIMAL(18,2) COMMENT 'Current balance of the captives loss reserve fund, representing funds set aside to pay anticipated and incurred but not reported (IBNR) claims. A critical solvency and liquidity indicator for the captive program.',
    `loss_reserve_amount` DECIMAL(18,2) COMMENT 'Actuarially determined reserve for known and estimated future claim payments, including case reserves and IBNR reserves. Distinct from the loss fund balance which reflects actual cash held.',
    `micro_captive_flag` BOOLEAN COMMENT 'Indicates whether the captive has elected small insurance company tax treatment under IRC Section 831(b), limiting annual premium income to the statutory threshold. Triggers enhanced IRS scrutiny and disclosure requirements.',
    `net_written_premium` DECIMAL(18,2) COMMENT 'Gross written premium less amounts ceded to reinsurers. Represents the captives actual retained underwriting exposure and is used in loss ratio and combined ratio calculations.',
    `program_expiration_date` DATE COMMENT 'Date on which the current captive program term expires or is scheduled for renewal. Null for open-ended programs. Triggers renewal workflow and regulatory re-filing.',
    `program_inception_date` DATE COMMENT 'Date on which the captive insurance program became effective and began writing risk. Marks the start of the captives binding coverage obligations and regulatory standing.',
    `program_year` STRING COMMENT 'Four-digit calendar or fiscal year of the captive program period (e.g., 2024). Used to segregate underwriting results, loss development, and financial reporting by accident year.',
    `regulatory_filing_date` DATE COMMENT 'Actual date on which the captives annual regulatory filing was submitted to the domicile jurisdiction insurance department. Used to confirm compliance and calculate any late filing penalties.',
    `regulatory_filing_due_date` DATE COMMENT 'Date by which the captives annual regulatory filing must be submitted to the domicile jurisdiction insurance department. Used to trigger compliance workflow and avoid penalties.',
    `regulatory_filing_status` STRING COMMENT 'Current status of the captives annual regulatory filing with the domicile jurisdiction insurance department. Tracks compliance with mandatory reporting obligations and flags overdue submissions.. Valid values are `filed|pending|overdue|accepted|rejected|not-required`',
    `reinsurance_structure` STRING COMMENT 'Type of reinsurance arrangement protecting the captive above its retained limit. Quota-share cedes a fixed percentage; excess-of-loss responds above a per-occurrence threshold; stop-loss caps aggregate losses. [ENUM-REF-CANDIDATE: quota-share|excess-of-loss|stop-loss|facultative|proportional|aggregate-stop-loss|none — promote to reference product]. Valid values are `quota-share|excess-of-loss|stop-loss|facultative|proportional|none`',
    `reinsurer_name` STRING COMMENT 'Name of the primary reinsurance carrier providing excess-of-loss or quota-share protection to the captive. Critical for counterparty credit risk assessment and regulatory reporting.',
    `renewal_date` DATE COMMENT 'Scheduled date for the captive programs annual renewal, including re-capitalization review, reinsurance renegotiation, and regulatory filing submission.',
    `retained_limit_per_occurrence` DECIMAL(18,2) COMMENT 'Maximum dollar amount the captive retains on any single loss occurrence before reinsurance or fronting carrier coverage responds. A key parameter in the captives risk retention strategy and reinsurance treaty design.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or equivalent tax identification number assigned to the captive insurance entity. Required for IRS reporting, REIT tax compliance, and cross-border tax filings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the captive account record. Supports change tracking, audit compliance, and Silver Layer data freshness monitoring in the Databricks Lakehouse.',
    CONSTRAINT pk_captive_account PRIMARY KEY(`captive_account_id`)
) COMMENT 'Captive insurance program account record for real estate enterprises that self-insure through a captive insurance vehicle. Captures captive entity name, domicile jurisdiction, captive type (single-parent, group, rent-a-captive, cell captive), lines of business written, capitalization amount, retained limit per occurrence, aggregate retention, fronting carrier arrangement, reinsurance structure, captive premium ceded, loss fund balance, and regulatory filing status. Supports captive program management and financial reporting for self-insurance structures.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`insurance_program` (
    `insurance_program_id` BIGINT COMMENT 'Unique surrogate identifier for the enterprise insurance program record. Primary key for the insurance_program table in the Silver Layer lakehouse.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Total program premium and total insurable value are currency-denominated program-level financial metrics. Authoritative currency reference is required for program budget reporting, carrier submissions',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Insurance programs have total annual premiums budgeted as operating expenses. Linking insurance_program to finance.budget supports program-level budget vs actual premium tracking, renewal cost forecas',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: Every insurance program is placed and managed by a broker of record. The insurance_program table stores broker_of_record, broker_contact_name, and broker_contact_email as denormalized strings. Adding ',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Insurance programs are structured by investment market segment (core, value-add, opportunistic, development) which drives coverage requirements, risk appetite, and program structure. Core portfolios r',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Institutional real estate owners (REITs, large investors) are the named insured on portfolio-level blanket insurance programs. Normalizing named_insured to owner_id enables program-level risk reportin',
    `ownership_structure_id` BIGINT COMMENT 'Foreign key linking to owner.ownership_structure. Business justification: Fund-level blanket insurance programs are sponsored by and cover assets held within a specific ownership structure (LP, REIT, JV). Linking insurance_program to ownership_structure enables fund adminis',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: Every insurance program has a primary carrier (insurer) providing the foundational coverage layer. The insurance_program table stores primary_carrier_name and primary_carrier_naic_code as denormalized',
    `prior_year_program_insurance_program_id` BIGINT COMMENT 'Reference to the insurance_program record for the immediately preceding program year. Enables year-over-year premium trend analysis, TIV growth tracking, and renewal benchmarking.',
    `investment_vehicle_id` BIGINT COMMENT 'Foreign key linking to reference.investment_vehicle. Business justification: Investment vehicle type (REIT, private equity fund, JV, CMBS) determines insurance program structure, regulatory requirements, and coverage obligations. REITs require specific D&O/E&O coverage; CMBS r',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Insurance programs (OCIP, CCIP, captive programs) must be structured to comply with applicable regulatory frameworks including surplus lines regulations, state insurance department requirements, and R',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Real estate firms assign an internal risk manager employee to each insurance program. This link supports program ownership reporting, renewal accountability, and regulatory compliance. risk_manager_n',
    `prior_insurance_program_id` BIGINT COMMENT 'Self-referencing FK on insurance_program (prior_insurance_program_id)',
    `aggregate_deductible` DECIMAL(18,2) COMMENT 'Maximum cumulative deductible amount the insured is obligated to pay across all claims within the program year before the aggregate deductible is exhausted, expressed in the program currency.',
    `asset_class_scope` STRING COMMENT 'Description of the real estate asset classes covered under the program (e.g., Office, Retail, Industrial, Multifamily Residential, Mixed-Use). Drives underwriting segmentation and carrier appetite alignment.',
    `asset_count_covered` STRING COMMENT 'Total count of real estate assets (properties, buildings, land parcels) covered under this insurance program. Used for per-asset premium allocation and portfolio coverage gap analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance program record was first created in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and SOX compliance requirements.',
    `earthquake_coverage_flag` BOOLEAN COMMENT 'Indicates whether the program includes earthquake coverage. Relevant for portfolios with assets in seismically active zones. True = earthquake coverage included.',
    `environmental_coverage_flag` BOOLEAN COMMENT 'Indicates whether the program includes environmental liability coverage for pollution, contamination, or remediation exposures. Relevant for industrial, brownfield, and mixed-use real estate assets. True = environmental coverage included.',
    `esg_aligned_flag` BOOLEAN COMMENT 'Indicates whether the insurance program has been structured or selected with ESG criteria in mind, such as green building endorsements, LEED/BREEAM premium credits, or sustainability-linked pricing. True = ESG-aligned program.',
    `excess_tower_layers` STRING COMMENT 'Number of excess or umbrella coverage layers stacked above the primary layer in the program tower structure. Used for carrier capacity planning and coverage gap analysis in large commercial real estate portfolios.',
    `expiration_date` DATE COMMENT 'Date on which the insurance program expires and coverage ceases. Used to trigger renewal workflows and compliance alerts. Format: yyyy-MM-dd.',
    `flood_coverage_flag` BOOLEAN COMMENT 'Indicates whether the program includes flood coverage, either through NFIP (National Flood Insurance Program) or private market. Critical for properties in FEMA-designated flood zones. True = flood coverage included.',
    `geographic_scope` STRING COMMENT 'Description of the geographic coverage territory of the program (e.g., Nationwide USA, Northeast US, Multi-state: NY, NJ, CT). Used for regulatory filing jurisdiction determination and carrier licensing validation.',
    `inception_date` DATE COMMENT 'Date on which the insurance program becomes effective and coverage commences. Aligns with the policy year start for all underlying policies within the program. Format: yyyy-MM-dd.',
    `loss_run_as_of_date` DATE COMMENT 'Date as of which the most recent loss run report was generated for this program. Used to track loss history currency for renewal submissions and carrier negotiations.',
    `ocip_ccip_flag` BOOLEAN COMMENT 'Indicates whether this program is structured as an Owner Controlled Insurance Program (OCIP) or Contractor Controlled Insurance Program (CCIP), typically used for large-scale real estate development and construction projects. True = OCIP/CCIP wrap-up program.',
    `policy_count` STRING COMMENT 'Total count of individual insurance policies included within this program structure for the program year. Used for program complexity assessment and carrier capacity planning.',
    `premium_finance_flag` BOOLEAN COMMENT 'Indicates whether the program premium is financed through a third-party premium finance company rather than paid directly. True = premium is financed. Impacts cash flow planning and debt service tracking.',
    `premium_payment_schedule` STRING COMMENT 'Frequency at which the total program premium is paid to the carrier(s). Drives AP payment scheduling in Yardi Voyager and SAP S/4HANA accounts payable workflows.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `primary_carrier_am_best_rating` STRING COMMENT 'AM Best financial strength rating of the primary carrier (e.g., A++, A+, A, A-, B++). Used to validate carrier creditworthiness per lender requirements and internal risk management policy.',
    `primary_layer_limit` DECIMAL(18,2) COMMENT 'Coverage limit of the primary (first-layer) insurance policy within the program tower, expressed in the program currency. Defines the threshold at which excess/umbrella layers are triggered.',
    `program_name` STRING COMMENT 'Human-readable name of the enterprise insurance program (e.g., FY2024 Commercial Property & Casualty Program). Used as the primary display label in risk management dashboards and renewal submissions.',
    `program_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the program by the broker of record or risk management system (e.g., PROG-2024-001). Used for cross-referencing with Yardi Voyager insurance module and broker submissions.',
    `program_status` STRING COMMENT 'Current lifecycle state of the insurance program. Drives renewal workflows, premium payment scheduling, and compliance reporting. Values: active (in-force), expired (past expiration), pending_renewal (renewal in progress), cancelled, in_negotiation (terms being negotiated), bound (coverage confirmed, policy not yet issued).. Valid values are `active|expired|pending_renewal|cancelled|in_negotiation|bound`',
    `program_type` STRING COMMENT 'Classification of the insurance program by coverage category. Drives program structure, carrier selection, and regulatory reporting. [ENUM-REF-CANDIDATE: property|casualty|management_liability|environmental|construction_wrap_up|umbrella_excess|ocip|ccip|cyber|workers_compensation — promote to reference product]. Valid values are `property|casualty|management_liability|environmental|construction_wrap_up|umbrella_excess`',
    `renewal_date` DATE COMMENT 'Target date by which the program renewal must be bound and confirmed. Typically 30–90 days prior to expiration. Drives renewal pipeline management in Salesforce CRM and risk management workflows.',
    `self_insured_retention` DECIMAL(18,2) COMMENT 'Dollar amount of loss the insured entity retains before insurance coverage is triggered, expressed in the program currency. Distinct from a deductible in that the insured manages claims within the SIR. Key metric for captive and large-portfolio risk management strategies.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this insurance program record was sourced or is primarily managed. Supports data lineage tracking in the Silver Layer lakehouse.. Valid values are `yardi_voyager|mri_software|argus_enterprise|manual|other`',
    `structure` STRING COMMENT 'Describes the structural arrangement of the insurance program. Blanket: single limit covers all properties; Scheduled: per-property limits; Layered: primary plus excess/umbrella tower; Quota Share: risk shared among carriers; Captive: self-insured retention vehicle; Wrap-Up: OCIP/CCIP construction program.. Valid values are `blanket|scheduled|layered|quota_share|captive|wrap_up`',
    `terrorism_coverage_flag` BOOLEAN COMMENT 'Indicates whether the program includes terrorism coverage under the Terrorism Risk Insurance Act (TRIA). Required disclosure for lenders and publicly traded REITs. True = terrorism coverage included.',
    `total_program_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate coverage limit available across all layers of the program tower, expressed in the program currency. Represents the total insurance capacity procured for the portfolio.',
    `total_program_premium` DECIMAL(18,2) COMMENT 'Aggregate annual premium amount payable across all policies within the program for the program year, expressed in the program currency. Used for budget forecasting (CAPEX/OPEX allocation), carrier negotiations, and portfolio-level cost benchmarking.',
    `total_tiv` DECIMAL(18,2) COMMENT 'Aggregate Total Insurable Value (TIV) of all assets covered under the program, expressed in the program currency. Represents the maximum replacement cost exposure and is the primary basis for property insurance pricing and carrier capacity allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance program record was most recently modified in the data platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports change tracking, audit trail, and SOX compliance.',
    `year` STRING COMMENT 'Four-digit calendar or fiscal year to which this insurance program applies (e.g., 2024). Enables year-over-year premium trend analysis and renewal benchmarking across the real estate portfolio.',
    CONSTRAINT pk_insurance_program PRIMARY KEY(`insurance_program_id`)
) COMMENT 'Insurance program master record defining the enterprise-level insurance program structure for a given policy year. Captures program name, program year, program type (property, casualty, management liability, environmental, construction wrap-up, OCIP/CCIP), total program premium, total TIV covered, number of policies in program, primary carrier, excess/umbrella tower structure, program inception and expiration dates, broker of record, risk management contact, and program status. Provides the top-level view of the insurance portfolio structure for a given year.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`excess_layer` (
    `excess_layer_id` BIGINT COMMENT 'Unique system-generated identifier for each excess or umbrella insurance layer record within the coverage tower.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Excess layers can apply to blanket groups in the coverage tower structure. Blanket primary coverage can have excess layers sitting above it, and this FK links the excess layer to the underlying blanke',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the insurance broker or intermediary responsible for placing this excess layer in the market.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Excess layer attachment points, layer limits, exhaustion points, and layer premiums are currency-denominated. Authoritative currency reference is required for excess tower placement analysis, rate-on-',
    `insurance_program_id` BIGINT COMMENT 'Reference to the insurance program (e.g., property catastrophe, general liability, D&O) under which this excess layer is structured.',
    `insurer_id` BIGINT COMMENT 'FK to insurance.insurer',
    `policy_id` BIGINT COMMENT 'Reference to the primary or master insurance policy record to which this excess layer belongs.',
    `underlying_excess_layer_id` BIGINT COMMENT 'Self-referencing FK on excess_layer (underlying_excess_layer_id)',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'The maximum total amount payable by this excess layer across all occurrences during the policy period. Caps the insurers total exposure for the layer.',
    `attachment_point` DECIMAL(18,2) COMMENT 'The dollar amount at which this excess layer begins to respond, i.e., the total loss amount that must be exceeded before this layer is triggered. Also known as the attaching limit. Critical for structuring the coverage tower and calculating total insured capacity.',
    `broker_of_record` STRING COMMENT 'The name of the brokerage firm designated as broker of record for this excess layer placement. Used for commission tracking and market access.',
    `cancellation_date` DATE COMMENT 'The date on which this excess layer was or will be cancelled prior to its natural expiration date. Null if the layer has not been cancelled.',
    `cancellation_reason` STRING COMMENT 'The reason this excess layer was cancelled before its expiration date. Used for program analysis and insurer relationship management.. Valid values are `non_payment|underwriter_withdrawal|portfolio_restructure|merger_acquisition|coverage_replaced|other`',
    `catastrophe_coverage_flag` BOOLEAN COMMENT 'Indicates whether this excess layer is specifically structured to respond to catastrophic loss events (e.g., named windstorm, earthquake, flood) as part of a property catastrophe program.',
    `co_insurer_count` STRING COMMENT 'The number of participating co-insurers (excluding the lead) sharing this excess layer. Used to assess concentration risk and manage the placement process.',
    `coverage_line` STRING COMMENT 'The line of insurance coverage this excess layer applies to (e.g., property catastrophe, general liability, D&O). Determines which underlying policy this layer follows. [ENUM-REF-CANDIDATE: property|general_liability|directors_and_officers|umbrella|workers_compensation|cyber|environmental|professional_liability — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this excess layer record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `drop_down_provision_flag` BOOLEAN COMMENT 'Indicates whether this layer contains a drop-down provision that allows it to respond as primary coverage if the underlying layer is exhausted, insolvent, or unavailable.',
    `effective_date` DATE COMMENT 'The date on which this excess layer becomes effective and coverage commences, aligned with the policy period start.',
    `endorsements_summary` STRING COMMENT 'Free-text summary of material endorsements, exclusions, or manuscript modifications attached to this excess layer that alter standard coverage terms.',
    `exhaustion_point` DECIMAL(18,2) COMMENT 'The total loss amount at which this layer is fully exhausted, calculated as attachment_point plus layer_limit. Defines the top of this layer and the attachment point for the next layer above.',
    `expiration_date` DATE COMMENT 'The date on which this excess layer expires and coverage ceases. Used for renewal tracking and WALT/WALE calculations across the insurance program.',
    `follows_form_flag` BOOLEAN COMMENT 'Indicates whether this excess layer follows the terms and conditions of the underlying primary policy (True) or has its own bespoke policy form (False). Critical for claims handling and coverage gap analysis.',
    `layer_limit` DECIMAL(18,2) COMMENT 'The maximum dollar amount of coverage provided by this specific excess layer above the attachment point. Represents the depth of this layer in the coverage tower.',
    `layer_number` STRING COMMENT 'Sequential integer indicating the position of this layer within the coverage tower (e.g., 1 = first excess, 2 = second excess). Used to order layers from attachment point upward.',
    `layer_premium` DECIMAL(18,2) COMMENT 'The total annual premium charged for this excess layer across all participating insurers. Represents the cost of the layer for the policy period.',
    `layer_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to this excess layer by the insurer or broker, used for correspondence and claims routing.',
    `layer_status` STRING COMMENT 'Current lifecycle status of the excess layer record. Active indicates the layer is in force; bound indicates placement confirmed but not yet effective; pending indicates placement in progress; expired, cancelled, and non_renewed indicate the layer is no longer in force.. Valid values are `active|bound|pending|expired|cancelled|non_renewed`',
    `layer_type` STRING COMMENT 'Classification of the excess layer within the coverage tower structure. Values include first_excess (sits immediately above primary), second_excess, umbrella (follows form with broader coverage), quota_share (proportional participation), and drop_down (activates when underlying layer is exhausted or unavailable). [ENUM-REF-CANDIDATE: first_excess|second_excess|umbrella|quota_share|drop_down|buffer — promote to reference product if additional types emerge]. Valid values are `first_excess|second_excess|umbrella|quota_share|drop_down`',
    `lead_insurer_naic_code` STRING COMMENT 'The National Association of Insurance Commissioners (NAIC) company code for the lead insurer on this excess layer. Used for regulatory reporting and carrier identification.. Valid values are `^[0-9]{5}$`',
    `lead_insurer_share_pct` DECIMAL(18,2) COMMENT 'The percentage of the layer limit underwritten by the lead insurer. Combined with co-insurer shares, must sum to the total placement percentage.',
    `occurrence_limit` DECIMAL(18,2) COMMENT 'The maximum amount payable by this excess layer for any single occurrence or loss event. May differ from the layer limit if per-occurrence sub-limits apply.',
    `placement_pct` DECIMAL(18,2) COMMENT 'The percentage of the layer limit that has been placed with participating insurers. A value of 100.00 indicates the layer is fully subscribed; less than 100 indicates a gap in coverage.',
    `program_type` STRING COMMENT 'The type of insurance program this excess layer belongs to. Determines the risk class and regulatory treatment. [ENUM-REF-CANDIDATE: property_catastrophe|general_liability|directors_and_officers|umbrella|workers_compensation|cyber|environmental|professional_liability — promote to reference product]',
    `rate_on_line_pct` DECIMAL(18,2) COMMENT 'The rate on line expressed as a percentage, calculated as layer premium divided by layer limit. A key pricing metric for excess layers used in benchmarking and renewal negotiations.',
    `reinstatement_count` STRING COMMENT 'The number of times the layer limit can be reinstated after a loss event depletes it. Common in property catastrophe programs; zero indicates no reinstatement provision.',
    `reinstatement_premium_pct` DECIMAL(18,2) COMMENT 'The percentage of the original layer premium charged to reinstate the layer limit after a loss. Expressed as a percentage of the pro-rata layer premium.',
    `renewal_date` DATE COMMENT 'The date by which renewal negotiations for this excess layer must be completed. Used for proactive renewal management and broker engagement scheduling.',
    `source_system` STRING COMMENT 'The operational system of record from which this excess layer record originated (e.g., Yardi Voyager, MRI Software, Argus Enterprise, DocuSign CLM, or manual entry).. Valid values are `Yardi Voyager|MRI Software|Argus Enterprise|DocuSign CLM|manual`',
    `surplus_lines_flag` BOOLEAN COMMENT 'Indicates whether this excess layer is placed with a surplus lines (non-admitted) insurer. Surplus lines placements have different regulatory and tax treatment.',
    `terrorism_coverage_flag` BOOLEAN COMMENT 'Indicates whether this excess layer includes coverage for acts of terrorism under TRIA (Terrorism Risk Insurance Act) or equivalent provisions.',
    `total_layer_capacity` DECIMAL(18,2) COMMENT 'The aggregate capacity placed across all participating insurers for this layer. May equal layer_limit when fully subscribed, or be less if the layer is partially placed.',
    `underlying_policy_number` STRING COMMENT 'The policy number of the immediately underlying insurance layer or primary policy that this excess layer sits above. Used to trace the full coverage tower structure.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this excess layer record was last modified in the data platform. Used for change tracking, audit compliance, and incremental data loads.',
    CONSTRAINT pk_excess_layer PRIMARY KEY(`excess_layer_id`)
) COMMENT 'Excess and umbrella insurance layer record defining each layer in the coverage tower above the primary policy. Captures layer number, layer type (first excess, second excess, umbrella, quota share), attaching limit (attachment point), layer limit, total layer capacity, participating insurer(s), each insurers share percentage, layer premium, and layer status. Models the full excess tower structure for property catastrophe, general liability, and D&O programs. Essential for large real estate portfolios with complex layered programs.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`premium_allocation` (
    `premium_allocation_id` BIGINT COMMENT 'Unique system-generated identifier for each premium cost allocation record. Primary key for the premium_allocation data product.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: TIV-based premium allocation across properties uses appraised values as the allocation basis. The `tiv_at_allocation` column is a denormalized snapshot of the appraised TIV. Linking to the source appr',
    `asset_id` BIGINT COMMENT 'Reference to the specific property asset to which this premium allocation is assigned. Enables property-level insurance cost tracking and Net Operating Income (NOI) impact analysis.',
    `budget_line_id` BIGINT COMMENT 'Reference to the operating budget line item against which this allocated premium is tracked. Enables budget-vs-actual variance analysis for insurance Operating Expenditure (OPEX) at the property or cost center level.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Insurance premiums are allocated to individual buildings as operating expenses for building-level P&L reporting and CAM reconciliation. Property accountants must allocate blanket policy premiums to bu',
    `unit_id` BIGINT COMMENT 'Reference to the business unit (e.g., Commercial, Residential, Industrial) to which the allocated premium is charged for segment-level reporting and budgeting.',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center to which the allocated insurance premium charge is posted for internal financial reporting and budgeting.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Allocated premium amounts and adjusted amounts are currency-denominated. Authoritative currency reference is required for GL journal entry posting, budget variance analysis, and multi-currency propert',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Premium allocations are posted to the GL via journal entries for property-level insurance expense recognition. premium_allocation.journal_entry_number is a plain-text denormalization. FK to journal_en',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (e.g., LLC, REIT subsidiary, partnership) responsible for bearing the allocated insurance premium cost. Supports entity-level financial consolidation.',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy under which the premium being allocated was issued. Enables traceability from allocation back to the originating policy.',
    `premium_id` BIGINT COMMENT 'Reference to the parent insurance premium record from which this allocation is derived. Links the allocation back to the billed premium invoice.',
    `reversal_allocation_premium_allocation_id` BIGINT COMMENT 'Reference to the original premium allocation record that this entry reverses. Populated only when allocation_status is reversed. Maintains a complete audit chain for GL reversals.',
    `parent_premium_allocation_id` BIGINT COMMENT 'Self-referencing FK on premium_allocation (parent_premium_allocation_id)',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'The allocated premium amount after any manual adjustments, audit corrections, or true-up entries. Differs from allocated_amount when a post-allocation adjustment has been applied.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The gross insurance premium dollar amount allocated to this property, cost center, or legal entity for the allocation period. Core financial field used in NOI calculations and budget variance reporting.',
    `allocation_basis_unit` STRING COMMENT 'Unit of measure for the allocation basis value (e.g., USD for TIV or revenue-based allocation, SQF or SQM for square footage-based allocation, PCT for percentage-based).. Valid values are `USD|SQF|SQM|PCT`',
    `allocation_basis_value` DECIMAL(18,2) COMMENT 'The numeric driver value used in the allocation calculation for this property or entity (e.g., TIV amount in dollars, square footage in SQF, or revenue amount). Provides the denominator/numerator input for the pro-rata calculation.',
    `allocation_method` STRING COMMENT 'The methodology used to distribute the insurance premium across properties, cost centers, or entities. Common methods include pro-rata by Total Insurable Value (TIV), square footage (SQF/SQM), revenue, equal split, or manual override.. Valid values are `pro_rata_tiv|pro_rata_sqft|pro_rata_revenue|equal_split|manual`',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments entered by the finance team regarding this allocation record, such as reasons for manual adjustments, special allocation instructions, or audit observations.',
    `allocation_number` STRING COMMENT 'Externally-visible, human-readable reference number uniquely identifying this premium allocation record. Used in financial reporting, audit trails, and GL journal entries.. Valid values are `^ALLOC-[0-9]{4}-[0-9]{6}$`',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The percentage share of the total premium assigned to this property, cost center, or entity. Expressed as a decimal (e.g., 0.125000 = 12.5%). All allocation percentages for a given premium and period must sum to 1.0.',
    `allocation_status` STRING COMMENT 'Current workflow state of the premium allocation record. Controls whether the allocation has been approved and posted to the General Ledger (GL). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|reversed|cancelled — promote to reference product]. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `approved_by` STRING COMMENT 'Name or user identifier of the finance or accounting manager who approved this premium allocation for GL posting. Required for SOX internal control compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this premium allocation record was approved for GL posting. Supports SOX audit trail and period-close workflow tracking.',
    `asset_class` STRING COMMENT 'The real estate asset class of the property receiving the allocation (e.g., office, retail, industrial, multifamily). Enables asset-class-level insurance cost benchmarking and portfolio analytics. [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|hospitality|mixed_use|land — 7 candidates stripped; promote to reference product]',
    `coverage_type` STRING COMMENT 'The type of insurance coverage to which this premium allocation relates (e.g., property, general liability, umbrella, flood). Enables coverage-level cost analysis across the portfolio. [ENUM-REF-CANDIDATE: property|general_liability|umbrella|flood|earthquake|business_interruption|workers_comp — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this premium allocation record was first created in the system. Supports audit trail, data lineage, and SOX compliance requirements.',
    `fiscal_period` STRING COMMENT 'The fiscal month or accounting period number (1–12) within the fiscal year to which this allocation is posted. Used for period-level GL posting and monthly accrual tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this premium allocation is attributed for budgeting and financial reporting purposes (e.g., 2024). Supports annual budget variance analysis.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which the allocated premium expense is posted in the accounting system (e.g., Yardi Voyager or SAP S/4HANA). Ensures correct financial statement classification.',
    `is_accrual` BOOLEAN COMMENT 'Indicates whether this allocation record represents an accrual entry (True) rather than an actual cash-basis posting (False). Accrual entries are reversed in the subsequent period upon receipt of the actual invoice.',
    `is_true_up` BOOLEAN COMMENT 'Indicates whether this allocation record is a true-up or audit adjustment entry (True) correcting a prior period allocation. Supports audit trail integrity and period-close reconciliation.',
    `period_end_date` DATE COMMENT 'The last date of the allocation period to which this premium charge applies. Typically aligns with the policy expiration date or the end of a billing installment period.',
    `period_start_date` DATE COMMENT 'The first date of the allocation period to which this premium charge applies. Typically aligns with the policy effective date or the start of a billing installment period.',
    `posting_date` DATE COMMENT 'The date on which this premium allocation was posted to the General Ledger (GL). May differ from the allocation period dates due to accrual timing or period-close processing.',
    `property_code` STRING COMMENT 'The internal property identifier code (e.g., Yardi property code) for the allocated property. Carried as a denormalized reference to support reporting without requiring a join to the property master.',
    `property_name` STRING COMMENT 'The human-readable name of the property to which this premium is allocated (e.g., One Market Plaza). Denormalized for ease of reporting and financial statement presentation.',
    `source_reference_code` STRING COMMENT 'The unique identifier of this record in the originating source system (e.g., Yardi transaction ID, SAP document number). Enables reconciliation between the lakehouse Silver layer and the system of record.',
    `source_system` STRING COMMENT 'The operational system of record from which this allocation record originated (e.g., Yardi Voyager, MRI Software, SAP S/4HANA, or manual entry). Supports data lineage and reconciliation.. Valid values are `yardi|mri|sap|manual`',
    `sqft_at_allocation` DECIMAL(18,2) COMMENT 'The Gross Leasable Area (GLA) or Net Leasable Area (NLA) in square feet of the property as of the allocation date, used as the basis for square footage pro-rata allocation calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this premium allocation record was most recently modified. Tracks the full change history for audit and reconciliation purposes.',
    CONSTRAINT pk_premium_allocation PRIMARY KEY(`premium_allocation_id`)
) COMMENT 'Premium cost allocation record distributing insurance premium charges across properties, cost centers, legal entities, and business units for internal financial reporting and budgeting. Captures allocation method (pro-rata by TIV, square footage, revenue, equal split), allocated premium amount, allocation period, property reference, cost center reference, legal entity reference, and allocation status. Enables property-level insurance cost tracking and NOI impact analysis.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`subrogation` (
    `subrogation_id` BIGINT COMMENT 'Unique system-generated identifier for the subrogation recovery record. Primary key for the subrogation data product in the insurance domain.',
    `ar_receipt_id` BIGINT COMMENT 'Foreign key linking to finance.ar_receipt. Business justification: Subrogation recoveries collected from responsible third parties are deposited and recorded as AR receipts in RE finance. Linking subrogation to ar_receipt supports cash reconciliation of recovery proc',
    `asset_id` BIGINT COMMENT 'Reference to the real estate property asset where the insured loss occurred, enabling portfolio-level subrogation tracking.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Subrogation recoveries are posted to specific GL income accounts. subrogation.gl_account_code is a plain-text denormalization. FK to chart_of_accounts supports income recognition accuracy, period-clos',
    `claim_id` BIGINT COMMENT 'Reference to the originating insurance claim from which the subrogation right arises. Links the subrogation record to the underlying loss event.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Subrogation demand amounts, recovery amounts, and recovery expenses are currency-denominated. Authoritative currency reference is required for GL recovery posting, loss ratio improvement reporting, an',
    `employee_id` BIGINT COMMENT 'Reference to the vendor or contact record for the engaged legal counsel firm. Enables linkage to legal spend, engagement letters, and outside counsel management records.',
    `policy_id` BIGINT COMMENT 'Reference to the insurance policy under which the original loss was covered and subrogation rights were triggered.',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: In real estate subrogation cases, the responsible party is frequently another property owner (e.g., adjacent property owner causing water damage). Normalizing responsible_party_name to a FK enables su',
    `related_subrogation_id` BIGINT COMMENT 'Self-referencing FK on subrogation (related_subrogation_id)',
    `arbitration_case_number` STRING COMMENT 'Case reference number assigned by the arbitration forum for the subrogation dispute. Used for tracking and correspondence with the arbitration body.',
    `arbitration_forum` STRING COMMENT 'Name of the arbitration forum or dispute resolution body used to resolve the subrogation claim (e.g., Arbitration Forums Inc., AAA). Applicable when litigation_status is arbitration.',
    `basis` STRING COMMENT 'Legal theory or basis upon which the insurers subrogation right is founded. Determines the legal strategy and applicable statutes. Common bases include negligence (e.g., tenant fault), contractor fault (construction defect), or product liability (equipment failure).. Valid values are `negligence|product_liability|contractor_fault|breach_of_contract|strict_liability|other`',
    `claim_reference_number` STRING COMMENT 'The insurer-assigned claim number associated with the original loss event from which subrogation rights derive. Used for cross-referencing with insurer records and loss run reports.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subrogation record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount retained by the insured on the underlying claim. Subrogation recovery is typically allocated first to reimburse the insureds deductible before the insurer recovers its paid loss.',
    `demand_amount` DECIMAL(18,2) COMMENT 'Total monetary amount formally demanded from the responsible party or their insurer in the subrogation demand letter. May include loss amount, expenses, and interest.',
    `demand_issued_date` DATE COMMENT 'Date on which the formal subrogation demand letter was issued to the responsible party or their insurer. Anchors negotiation timelines and statute of limitations tracking.',
    `identified_date` DATE COMMENT 'Date on which the subrogation opportunity was identified and the recovery pursuit was formally initiated. Used to measure time-to-identification and assess recovery pipeline aging.',
    `insurer_subrogation_contact` STRING COMMENT 'Name of the subrogation specialist or adjuster at the insurance carrier responsible for managing the recovery effort on the insurers behalf. Used for coordination and escalation.',
    `legal_counsel_name` STRING COMMENT 'Name of the law firm or attorney engaged to pursue the subrogation recovery on behalf of the insurer or insured. Used for legal spend tracking and outside counsel management.',
    `litigation_filed_date` DATE COMMENT 'Date on which legal action (lawsuit or arbitration) was formally filed against the responsible party to enforce the subrogation right. Null if no litigation has been initiated.',
    `litigation_status` STRING COMMENT 'Current status of any legal proceedings initiated to enforce the subrogation right. Tracks progression through the litigation lifecycle from filing through judgment. [ENUM-REF-CANDIDATE: not_in_litigation|filed|discovery|mediation|arbitration|trial|judgment|appeal|dismissed — promote to reference product]',
    `loss_date` DATE COMMENT 'Date on which the original insured loss event occurred. This is the principal real-world business event timestamp for the subrogation record and anchors statute of limitations calculations.',
    `loss_type` STRING COMMENT 'Classification of the type of loss that gave rise to the subrogation right. Supports segmentation of recovery efforts by loss category for portfolio analytics and insurer reporting.. Valid values are `property_damage|bodily_injury|business_interruption|liability|environmental|other`',
    `notes` STRING COMMENT 'Free-text field for capturing supplementary case notes, negotiation history, key correspondence summaries, or other contextual information relevant to the subrogation recovery effort.',
    `outcome` STRING COMMENT 'Final disposition of the subrogation recovery effort. Recovered indicates full or partial payment received; settled indicates negotiated resolution; waived indicates the insurer voluntarily relinquished the right; uncollectible indicates the responsible party is judgment-proof or insolvent.. Valid values are `recovered|settled|waived|uncollectible|pending`',
    `property_asset_type` STRING COMMENT 'Classification of the real estate asset type where the loss occurred. Supports portfolio-level subrogation analytics segmented by asset class (e.g., commercial vs. residential). [ENUM-REF-CANDIDATE: office|retail|industrial|multifamily|mixed_use|land|hospitality|other — promote to reference product]',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Actual monetary amount recovered from the responsible party or their insurer. Reduces net loss costs and is credited back to the originating claim and policy loss experience.',
    `recovery_date` DATE COMMENT 'Date on which the subrogation recovery payment was received from the responsible party or their insurer. Used for cash flow reporting and recovery accounting entries.',
    `recovery_expense_amount` DECIMAL(18,2) COMMENT 'Total expenses incurred in pursuing the subrogation recovery, including legal fees, expert witness costs, court filing fees, and investigation costs. Net recovery is calculated as recovery_amount minus recovery_expense_amount.',
    `recovery_pct` DECIMAL(18,2) COMMENT 'Percentage of the total demand amount actually recovered, calculated as (recovery_amount / demand_amount) * 100. Stored as a raw business metric for recovery effectiveness reporting and benchmarking against industry norms.',
    `recovery_status` STRING COMMENT 'Current lifecycle status of the subrogation recovery effort. Tracks progression from initial identification through demand, negotiation, litigation, and final resolution. [ENUM-REF-CANDIDATE: open|demand_issued|negotiating|litigation|settled|recovered|waived|uncollectible|closed — promote to reference product]',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the subrogation case, used for communication with insurers, legal counsel, and responsible parties. Sourced from the insurer or internal claims management system.',
    `responsible_party_insurer` STRING COMMENT 'Name of the insurance carrier for the responsible third party, if known. Used to direct demand letters and negotiate recovery directly with the adverse insurer.',
    `responsible_party_policy_number` STRING COMMENT 'Insurance policy number of the responsible third partys carrier. Enables direct insurer-to-insurer subrogation demand and arbitration proceedings.',
    `responsible_party_type` STRING COMMENT 'Classification of the responsible third party. Supports segmentation of subrogation recovery by counterparty category for portfolio analytics and vendor risk management. [ENUM-REF-CANDIDATE: contractor|vendor|tenant|property_owner|manufacturer|utility|government|other — promote to reference product]',
    `statute_of_limitations_date` DATE COMMENT 'Date by which legal action must be filed or the subrogation right is extinguished by the applicable statute of limitations. Critical compliance date for recovery management and legal escalation decisions.',
    `total_loss_amount` DECIMAL(18,2) COMMENT 'Gross total amount of the insured loss paid by the insurer on the underlying claim, representing the maximum theoretical subrogation recovery ceiling before deductible and expense adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the subrogation record was most recently modified. Enables change detection, incremental processing in the Databricks lakehouse pipeline, and audit trail compliance.',
    `waiver_of_subrogation_flag` BOOLEAN COMMENT 'Indicates whether a waiver of subrogation endorsement or contractual clause (e.g., in a lease or construction contract) was in effect at the time of loss, which may limit or eliminate the subrogation right.',
    `waiver_reason` STRING COMMENT 'Explanation for why the subrogation right was waived, such as a pre-existing waiver of subrogation endorsement in the policy, tenant lease clause, or business relationship preservation. Populated only when subrogation_outcome is waived.',
    CONSTRAINT pk_subrogation PRIMARY KEY(`subrogation_id`)
) COMMENT 'Subrogation recovery record tracking the insurers right to pursue third parties responsible for insured losses. Captures subrogation claim reference, responsible party identity, subrogation basis (negligence, product liability, contractor fault), demand amount, recovery amount received, recovery date, legal counsel engaged, litigation status, statute of limitations date, and subrogation outcome (recovered, settled, waived, uncollectible). Reduces net loss costs and supports recovery accounting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'Unique surrogate identifier for each insurance policy document record in the repository. Primary key for the policy_document entity.',
    `blanket_group_id` BIGINT COMMENT 'Foreign key linking to insurance.blanket_group. Business justification: Documents can be associated with blanket groups (blanket policy documents, blanket certificates, blanket schedules, etc.). This enables document management for blanket coverage structures.',
    `building_id` BIGINT COMMENT 'Reference to the specific property asset in the real estate portfolio to which this document applies. Null for portfolio-level or entity-level documents not tied to a single property.',
    `claim_id` BIGINT COMMENT 'Reference to the insurance claim record if this document is associated with a specific claim event (e.g., proof of loss, reservation of rights letter, claim correspondence). Null if document is policy-level only.',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to reference.document_type. Business justification: reference.document_type is the authoritative classification for all document types including insurance instruments (policy forms, endorsements, COIs, loss runs). document_type on policy_document is ',
    `endorsement_id` BIGINT COMMENT 'Reference to the endorsement record if this document is specifically associated with a policy endorsement. Null if not endorsement-related.',
    `insurance_program_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_program. Business justification: Documents can be associated with the overall insurance program (program summaries, program renewals, program marketing materials, etc.). This enables document management at the program level.',
    `insurer_id` BIGINT COMMENT 'FK to insurance.insurer',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (insured entity) associated with this document. Supports multi-entity REIT structures where policies are held at the entity level.',
    `policy_id` BIGINT COMMENT 'Reference to the parent insurance policy with which this document is associated. Links the document to its governing policy record.',
    `renewal_id` BIGINT COMMENT 'Reference to the renewal record if this document is generated as part of a policy renewal cycle (e.g., renewal binder, renewal quote). Null if not renewal-related.',
    `superseded_by_document_policy_document_id` BIGINT COMMENT 'Self-referencing identifier pointing to the newer document record that replaced this version. Null if this is the current version. Enables full document version chain traversal.',
    `superseded_policy_document_id` BIGINT COMMENT 'Self-referencing FK on policy_document (superseded_policy_document_id)',
    `access_restriction` STRING COMMENT 'Description of specific access restrictions applied to this document beyond the standard confidentiality level (e.g., Legal and Risk Management only, Lender distribution authorized). Supports need-to-know access control.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this document governing access controls and distribution restrictions. Aligns with the enterprise data classification framework and GDPR data handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `coverage_type` STRING COMMENT 'The line of insurance coverage to which this document pertains (e.g., property, general liability, workers compensation, umbrella, flood, earthquake, directors and officers). Enables filtering and reporting by coverage line. [ENUM-REF-CANDIDATE: property|general_liability|workers_compensation|umbrella|flood|earthquake|directors_and_officers|cyber|environmental — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was first created in the data platform. Immutable audit field supporting SOX internal controls and GDPR data processing records.',
    `document_date` DATE COMMENT 'The official date printed on or assigned to the document by the issuing party (insurer, broker, or appraiser). Represents the business event date, distinct from the upload or received date.',
    `document_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this document by the issuing party (insurer, broker, or internal document management system). Used for cross-referencing with carrier and broker systems.',
    `document_status` STRING COMMENT 'Current lifecycle state of the document within the insurance document management workflow. Controls document visibility, access, and retention actions. [ENUM-REF-CANDIDATE: draft|pending_review|active|superseded|expired|cancelled|archived — 7 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Human-readable title or name of the document as it appears on the face of the document or as assigned by the document management system (e.g., Commercial Property Policy Form ISO CP 00 10, Certificate of Insurance – Tenant ABC Corp).',
    `docusign_envelope_reference` STRING COMMENT 'Unique envelope identifier assigned by DocuSign CLM for electronically executed documents. Enables direct retrieval of the e-signature audit trail from the DocuSign system of record.',
    `effective_date` DATE COMMENT 'Date from which the document becomes legally binding or operationally effective (e.g., binder effective date, endorsement effective date, COI effective date). Aligns with policy or endorsement effective dates where applicable.',
    `execution_date` DATE COMMENT 'Date on which the document was fully executed by all required signatories. Distinct from the document date and effective date. Null if document is not yet executed.',
    `expiration_date` DATE COMMENT 'Date on which the document ceases to be valid or effective (e.g., binder expiration, certificate of insurance expiry). Drives renewal alerts and compliance monitoring workflows.',
    `file_format` STRING COMMENT 'Format of the stored document file. Governs rendering, archival, and e-signature compatibility requirements.. Valid values are `PDF|DOCX|XLSX|TIFF|JPG|PNG`',
    `file_name` STRING COMMENT 'Original file name of the document as stored in the document management system or cloud storage repository (e.g., Policy_Form_CP0010_2024.pdf). Used for file retrieval and audit trail.',
    `file_size_kb` STRING COMMENT 'Size of the document file in kilobytes. Used for storage management, archival planning, and document integrity verification.',
    `is_current_version` BOOLEAN COMMENT 'Indicates whether this document record represents the most current active version. False for superseded or prior versions retained for audit trail purposes.',
    `is_executed` BOOLEAN COMMENT 'Indicates whether this document has been fully executed (signed by all required parties). Particularly relevant for binders, endorsements, and SNDA agreements. Unexecuted documents may not be legally binding.',
    `issuing_party` STRING COMMENT 'Name of the organization or individual that produced and issued this document (e.g., insurer, broker, independent appraiser, risk engineering firm, legal counsel). Distinct from the insurer when documents are broker-issued.',
    `issuing_party_type` STRING COMMENT 'Classification of the entity that issued this document. Used to route documents to the appropriate review team and apply correct retention and compliance rules.. Valid values are `insurer|broker|appraiser|risk_engineer|legal_counsel|internal`',
    `notes` STRING COMMENT 'Free-text field for additional context, annotations, or instructions related to this document (e.g., Pending carrier countersignature, Lender copy distributed on 2024-03-15). Not for structured data.',
    `received_date` DATE COMMENT 'Date on which the document was received by the real estate organization from the issuing party (insurer, broker, or third-party appraiser). Used for SLA tracking and compliance deadline management.',
    `retention_expiry_date` DATE COMMENT 'Date after which this document may be purged or archived per the organizations document retention policy. Calculated based on document type, regulatory requirements, and policy expiration. Supports GDPR data minimization and SOX retention compliance.',
    `review_date` DATE COMMENT 'Date on which the document was formally reviewed and approved by the responsible team member. Supports internal control and audit trail requirements.',
    `reviewed_by` STRING COMMENT 'Name or user identifier of the employee who reviewed and approved this document for accuracy and completeness. Required for compliance and internal control documentation.',
    `source_system` STRING COMMENT 'Operational system of record from which this document record was originated or ingested into the data lakehouse. Supports data lineage tracking and reconciliation.. Valid values are `Yardi Voyager|DocuSign CLM|MRI Software|Procore|Building Engines|Manual Upload`',
    `source_system_doc_reference` STRING COMMENT 'Native document identifier from the originating source system (e.g., Yardi document ID, Procore document number). Enables reconciliation and traceability back to the system of record.',
    `storage_location` STRING COMMENT 'Full path or URI to the document in the enterprise document management system or cloud storage (e.g., SharePoint path, S3 URI, DocuSign envelope URL). Enables direct retrieval of the document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this document record in the data platform. Supports change data capture, audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `upload_date` DATE COMMENT 'Date on which the document was uploaded or ingested into the enterprise document repository. Distinct from the document date and received date; used for system audit trail.',
    `uploaded_by` STRING COMMENT 'Name or user identifier of the employee or system that uploaded this document into the repository. Supports audit trail and accountability requirements under SOX and GDPR.',
    `version_number` STRING COMMENT 'Version identifier of the document following a major.minor versioning scheme (e.g., 1.0, 2.1). Tracks document revisions and supersession history for audit and compliance purposes.. Valid values are `^d+.d+$`',
    CONSTRAINT pk_policy_document PRIMARY KEY(`policy_document_id`)
) COMMENT 'Document repository record for all insurance-related documents associated with policies, claims, renewals, and risk assessments. Captures document type (policy form, endorsement, binder, certificate, loss run, appraisal, risk engineering report, claim correspondence, proof of loss, reservation of rights letter), document title, document date, file reference, storage location, version number, and document status. Provides a complete document audit trail for each insurance policy and claim lifecycle.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`policy_assignment` (
    `policy_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each policy assignment record at closing',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the insurance policy being assigned or transferred at closing',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to the property sale transaction during which this policy assignment occurs',
    `assignment_date` DATE COMMENT 'Date on which the insurance policy was formally assigned or transferred as part of the property sale closing process',
    `assignment_notes` STRING COMMENT 'Free-text notes capturing special conditions, exceptions, or issues related to the policy assignment at closing (e.g., pending endorsements, coverage gaps, lender requirements)',
    `assignment_type` STRING COMMENT 'Classification of how the insurance policy was handled at closing. Full assignment transfers the entire policy to the buyer; partial assignment may occur in portfolio sales; new policy required indicates buyer must obtain separate coverage; seller retained means seller keeps the policy; buyer replaced means buyer obtained their own coverage.',
    `certificate_issued_date` DATE COMMENT 'Date on which the Certificate of Insurance (COI) reflecting the policy assignment was issued to the buyer or lender as part of closing deliverables',
    `coverage_status_at_closing` STRING COMMENT 'Status of the insurance policy coverage at the time of property sale closing. Indicates whether the policy was assigned to the buyer, transferred, replaced with new coverage, cancelled, or continued under existing terms.',
    `lender_notification_required` BOOLEAN COMMENT 'Indicates whether the lender or mortgagee must be notified of the policy assignment or transfer as a closing requirement. Typically required when the lender is listed as loss payee or additional insured.',
    `lender_notified_date` DATE COMMENT 'Date on which the lender or mortgagee was formally notified of the policy assignment or transfer, fulfilling closing requirements',
    `proration_amount` DECIMAL(18,2) COMMENT 'Dollar amount of insurance premium prorated between buyer and seller at closing based on the effective date of policy transfer and the policy period. Positive values indicate buyer credit; negative values indicate seller credit.',
    CONSTRAINT pk_policy_assignment PRIMARY KEY(`policy_assignment_id`)
) COMMENT 'This association product represents the assignment or transfer of insurance policies during property sale transactions. It captures the relationship between a property sale and the insurance policies that must be assigned, transferred, or replaced at closing. Each record links one property_sale to one policy with attributes that exist only in the context of the closing transaction, including assignment status, effective dates, proration calculations, and lender notification requirements.. Existence Justification: In real estate transactions, a property sale can involve multiple insurance policies that must be assigned or transferred at closing (e.g., property hazard, title insurance, flood, general liability, umbrella coverage). Conversely, in portfolio sales or bulk transactions, a single master insurance policy can cover multiple properties being sold across different transactions. The assignment of each policy at closing is an operational business process managed by closing coordinators, with specific attributes like assignment status, effective date, proration amount, and lender notification requirements that belong to the relationship itself, not to either the sale or the policy alone.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`insurance`.`blanket_group` (
    `blanket_group_id` BIGINT COMMENT 'Primary key for blanket_group',
    `insurance_broker_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_broker. Business justification: Blanket groups are placed through an insurance broker. Currently has broker_name (STRING) which should be normalized to FK. Broker_name is redundant once FK exists - can retrieve via JOIN to insurance',
    `insurance_program_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_program. Business justification: Blanket groups are typically part of an enterprise insurance program structure. This links the blanket coverage grouping to the overall program for program-level reporting and management.',
    `insurer_id` BIGINT COMMENT 'Foreign key linking to insurance.insurer. Business justification: Blanket groups are provided by an insurer/carrier. Currently has carrier_name and carrier_code (STRING) which should be normalized to FK. These are redundant once FK exists - can retrieve via JOIN to ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Blanket groups reference a master policy. Currently has policy_number (STRING) which should be normalized to FK. The policy_number string is redundant once FK exists - can retrieve via JOIN to policy.',
    `parent_blanket_group_id` BIGINT COMMENT 'Self-referencing FK on blanket_group (parent_blanket_group_id)',
    `additional_insured_provisions` STRING COMMENT 'Description of any additional insured parties covered under the blanket group policy, such as lenders, lessors, or property managers.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the blanket group policy automatically renews at expiration or requires explicit renewal action.',
    `certificate_holder_required_flag` BOOLEAN COMMENT 'Indicates whether certificates of insurance must be issued to third parties for properties in the blanket group.',
    `claims_made_basis_flag` BOOLEAN COMMENT 'Indicates whether coverage is on a claims-made basis (claim must be filed during policy period) versus occurrence basis (loss must occur during policy period).',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of insured value that must be maintained to avoid coinsurance penalties. Typically 80%, 90%, or 100% of property value.',
    `coverage_endorsements` STRING COMMENT 'List of policy endorsements or riders that modify standard coverage terms for the blanket group. Includes special provisions and exclusions.',
    `coverage_limit` DECIMAL(18,2) COMMENT 'Maximum amount the insurer will pay for all covered losses under the blanket group policy during the policy period.',
    `coverage_scope` STRING COMMENT 'Defines the breadth of assets or properties included in the blanket group. Determines which properties are eligible for coverage under the group policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket group record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the blanket group including premiums, limits, and deductibles.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured must pay out-of-pocket before insurance coverage applies to claims under the blanket group policy.',
    `deductible_type` STRING COMMENT 'Method by which the deductible is applied to claims. Determines whether deductible applies per incident, per claim, or as an aggregate across all claims.',
    `effective_date` DATE COMMENT 'Date when the blanket insurance group coverage becomes active and binding. Marks the start of the coverage period.',
    `expiration_date` DATE COMMENT 'Date when the blanket insurance group coverage terminates. Nullable for open-ended or evergreen policies subject to annual renewal.',
    `geographic_scope` STRING COMMENT 'Description of the geographic area covered by the blanket group. May include specific states, regions, or nationwide coverage.',
    `group_code` STRING COMMENT 'Externally-known unique business identifier code for the blanket insurance group used in policy documentation and claims processing.',
    `group_name` STRING COMMENT 'Human-readable name of the blanket insurance group describing the collection of properties or assets covered under a single policy limit.',
    `group_type` STRING COMMENT 'Classification of the blanket insurance group by coverage category. Determines the type of risk pooling and premium calculation methodology.',
    `last_valuation_date` DATE COMMENT 'Date when the most recent property valuation was completed for the blanket group. Used to ensure adequate coverage limits.',
    `loss_history_summary` STRING COMMENT 'Summary of historical claims and losses for properties in the blanket group. Used for underwriting and premium calculation.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the blanket group record. Supports change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket group record was last modified. Tracks the most recent update to any attribute in the record.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Total premium charged for the blanket group coverage during the policy period. Represents the cost of insurance protection.',
    `premium_frequency` STRING COMMENT 'Frequency at which premium payments are due for the blanket group policy. Determines billing cycle and cash flow requirements.',
    `property_count` STRING COMMENT 'Total number of individual properties or assets covered under the blanket group. Used for premium allocation and exposure analysis.',
    `renewal_date` DATE COMMENT 'Date when the blanket group policy is scheduled for renewal. Triggers renewal underwriting and premium renegotiation processes.',
    `risk_category` STRING COMMENT 'Overall risk classification of the blanket group based on loss exposure, property characteristics, and geographic concentration.',
    `blanket_group_status` STRING COMMENT 'Current lifecycle status of the blanket insurance group indicating whether it is actively providing coverage or has been terminated.',
    `total_insured_value` DECIMAL(18,2) COMMENT 'Aggregate insured value of all properties and assets covered under the blanket group. Represents the maximum potential loss exposure.',
    `underwriting_notes` STRING COMMENT 'Special underwriting considerations, risk factors, or conditions noted during policy issuance for the blanket group.',
    `valuation_method` STRING COMMENT 'Method used to determine the insured value of properties in the blanket group. Affects claim settlement calculations.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the blanket group record. Used for accountability and audit purposes.',
    CONSTRAINT pk_blanket_group PRIMARY KEY(`blanket_group_id`)
) COMMENT 'Master reference table for blanket_group. Referenced by blanket_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_renewed_policy_id` FOREIGN KEY (`renewed_policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_underlying_coverage_id` FOREIGN KEY (`underlying_coverage_id`) REFERENCES `real_estate_ecm`.`insurance`.`coverage`(`coverage_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_master_insured_property_id` FOREIGN KEY (`master_insured_property_id`) REFERENCES `real_estate_ecm`.`insurance`.`insured_property`(`insured_property_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_prior_sov_statement_of_values_id` FOREIGN KEY (`prior_sov_statement_of_values_id`) REFERENCES `real_estate_ecm`.`insurance`.`statement_of_values`(`statement_of_values_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_prior_statement_of_values_id` FOREIGN KEY (`prior_statement_of_values_id`) REFERENCES `real_estate_ecm`.`insurance`.`statement_of_values`(`statement_of_values_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_reversed_premium_id` FOREIGN KEY (`reversed_premium_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium`(`premium_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_adjuster_id` FOREIGN KEY (`adjuster_id`) REFERENCES `real_estate_ecm`.`insurance`.`adjuster`(`adjuster_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_related_claim_id` FOREIGN KEY (`related_claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_reversed_claim_payment_id` FOREIGN KEY (`reversed_claim_payment_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim_payment`(`claim_payment_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_prior_loss_run_id` FOREIGN KEY (`prior_loss_run_id`) REFERENCES `real_estate_ecm`.`insurance`.`loss_run`(`loss_run_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_prior_risk_assessment_id` FOREIGN KEY (`prior_risk_assessment_id`) REFERENCES `real_estate_ecm`.`insurance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_replaced_certificate_of_insurance_id` FOREIGN KEY (`replaced_certificate_of_insurance_id`) REFERENCES `real_estate_ecm`.`insurance`.`certificate_of_insurance`(`certificate_of_insurance_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_prior_renewal_id` FOREIGN KEY (`prior_renewal_id`) REFERENCES `real_estate_ecm`.`insurance`.`renewal`(`renewal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_superseded_by_endorsement_id` FOREIGN KEY (`superseded_by_endorsement_id`) REFERENCES `real_estate_ecm`.`insurance`.`endorsement`(`endorsement_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_superseded_endorsement_id` FOREIGN KEY (`superseded_endorsement_id`) REFERENCES `real_estate_ecm`.`insurance`.`endorsement`(`endorsement_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ADD CONSTRAINT `fk_insurance_insurer_parent_insurer_id` FOREIGN KEY (`parent_insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ADD CONSTRAINT `fk_insurance_insurance_broker_parent_insurance_broker_id` FOREIGN KEY (`parent_insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ADD CONSTRAINT `fk_insurance_adjuster_supervising_adjuster_id` FOREIGN KEY (`supervising_adjuster_id`) REFERENCES `real_estate_ecm`.`insurance`.`adjuster`(`adjuster_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_adjuster_id` FOREIGN KEY (`adjuster_id`) REFERENCES `real_estate_ecm`.`insurance`.`adjuster`(`adjuster_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_superseded_claim_reserve_id` FOREIGN KEY (`superseded_claim_reserve_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim_reserve`(`claim_reserve_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_related_liability_event_id` FOREIGN KEY (`related_liability_event_id`) REFERENCES `real_estate_ecm`.`insurance`.`liability_event`(`liability_event_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_parent_captive_account_id` FOREIGN KEY (`parent_captive_account_id`) REFERENCES `real_estate_ecm`.`insurance`.`captive_account`(`captive_account_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_prior_year_program_insurance_program_id` FOREIGN KEY (`prior_year_program_insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_prior_insurance_program_id` FOREIGN KEY (`prior_insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_underlying_excess_layer_id` FOREIGN KEY (`underlying_excess_layer_id`) REFERENCES `real_estate_ecm`.`insurance`.`excess_layer`(`excess_layer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_premium_id` FOREIGN KEY (`premium_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium`(`premium_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_reversal_allocation_premium_allocation_id` FOREIGN KEY (`reversal_allocation_premium_allocation_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium_allocation`(`premium_allocation_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_parent_premium_allocation_id` FOREIGN KEY (`parent_premium_allocation_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium_allocation`(`premium_allocation_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_related_subrogation_id` FOREIGN KEY (`related_subrogation_id`) REFERENCES `real_estate_ecm`.`insurance`.`subrogation`(`subrogation_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_endorsement_id` FOREIGN KEY (`endorsement_id`) REFERENCES `real_estate_ecm`.`insurance`.`endorsement`(`endorsement_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_renewal_id` FOREIGN KEY (`renewal_id`) REFERENCES `real_estate_ecm`.`insurance`.`renewal`(`renewal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_superseded_by_document_policy_document_id` FOREIGN KEY (`superseded_by_document_policy_document_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy_document`(`policy_document_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_superseded_policy_document_id` FOREIGN KEY (`superseded_policy_document_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy_document`(`policy_document_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ADD CONSTRAINT `fk_insurance_policy_assignment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ADD CONSTRAINT `fk_insurance_blanket_group_insurance_broker_id` FOREIGN KEY (`insurance_broker_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_broker`(`insurance_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ADD CONSTRAINT `fk_insurance_blanket_group_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ADD CONSTRAINT `fk_insurance_blanket_group_insurer_id` FOREIGN KEY (`insurer_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurer`(`insurer_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ADD CONSTRAINT `fk_insurance_blanket_group_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ADD CONSTRAINT `fk_insurance_blanket_group_parent_blanket_group_id` FOREIGN KEY (`parent_blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`insurance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `real_estate_ecm`.`insurance` SET TAGS ('dbx_domain' = 'insurance');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `ownership_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Structure Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property Asset ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `renewed_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'non_payment|underwriting|insured_request|property_sold|coverage_replaced|regulatory');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `certificate_of_insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coinsurance_pct` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coverage_basis` SET TAGS ('dbx_business_glossary_term' = 'Coverage Basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coverage_basis` SET TAGS ('dbx_value_regex' = 'replacement_cost|actual_cash_value|agreed_value|functional_replacement_cost');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coverage_class` SET TAGS ('dbx_business_glossary_term' = 'Coverage Class');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coverage_class` SET TAGS ('dbx_value_regex' = 'commercial|residential|mixed_use|portfolio|corporate');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `deductible_type` SET TAGS ('dbx_business_glossary_term' = 'Deductible Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `deductible_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|per_occurrence|aggregate|wind_hail|named_storm');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `endorsements_summary` SET TAGS ('dbx_business_glossary_term' = 'Endorsements Summary');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `flood_zone` SET TAGS ('dbx_business_glossary_term' = 'FEMA Flood Zone Designation');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `form` SET TAGS ('dbx_business_glossary_term' = 'Policy Form');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insured_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Insured Entity Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insured_entity_type` SET TAGS ('dbx_value_regex' = 'legal_entity|property_asset|portfolio|joint_venture|reit');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `lender_additional_insured` SET TAGS ('dbx_business_glossary_term' = 'Lender Additional Insured / Mortgagee');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `lender_additional_insured` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `loss_run_last_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Last Requested Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|non_renewed|pending|suspended');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `premium_finance_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Finance Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|argus_enterprise|manual|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sublimit_business_interruption` SET TAGS ('dbx_business_glossary_term' = 'Business Interruption Sub-Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sublimit_business_interruption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sublimit_earthquake` SET TAGS ('dbx_business_glossary_term' = 'Earthquake Sub-Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sublimit_earthquake` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sublimit_flood` SET TAGS ('dbx_business_glossary_term' = 'Flood Sub-Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `sublimit_flood` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `terrorism_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Terrorism Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `total_insurable_value` SET TAGS ('dbx_business_glossary_term' = 'Total Insurable Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `total_insurable_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `insurer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `underlying_coverage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `additional_insured` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `additional_insured` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `agreed_value_endorsement` SET TAGS ('dbx_business_glossary_term' = 'Agreed Value Endorsement Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `annual_premium` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `annual_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `auto_renew` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `blanket_or_specific` SET TAGS ('dbx_business_glossary_term' = 'Blanket or Specific Coverage Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `blanket_or_specific` SET TAGS ('dbx_value_regex' = 'blanket|specific|scheduled');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Cancellation Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'non_payment|underwriter_withdrawal|insured_request|property_sold|policy_replacement|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|pending|suspended');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `deductible_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deductible Percentage of Total Insured Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `deductible_type` SET TAGS ('dbx_business_glossary_term' = 'Deductible Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `deductible_type` SET TAGS ('dbx_value_regex' = 'per_occurrence|aggregate|percentage_of_tiv|straight|franchise');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `endorsement_number` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `indemnity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Maximum Indemnity Period (Months)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Line Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `loss_payee` SET TAGS ('dbx_business_glossary_term' = 'Loss Payee');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `loss_payee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `named_insured` SET TAGS ('dbx_business_glossary_term' = 'Named Insured');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `named_insured` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `occurrence_limit` SET TAGS ('dbx_business_glossary_term' = 'Per-Occurrence Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `occurrence_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Renewal Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `sub_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Sub-Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `sub_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `tiv` SET TAGS ('dbx_business_glossary_term' = 'Total Insured Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `tiv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_business_glossary_term' = 'Valuation Basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_value_regex' = 'replacement_cost|actual_cash_value|agreed_value|functional_replacement_cost');
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period (Days)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `insured_property_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `construction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `cost_approach_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Approach Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `lease_demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `zoning_code_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `master_insured_property_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `actual_cash_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Cash Value (ACV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `actual_cash_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `agreed_value` SET TAGS ('dbx_business_glossary_term' = 'Agreed Value Endorsement Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `alarm_system_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm System Type (COPE)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `alarm_system_type` SET TAGS ('dbx_value_regex' = 'none|local|central_station|proprietary|governmental');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `building_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Building Area (SQF)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `building_limit` SET TAGS ('dbx_business_glossary_term' = 'Building Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `building_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `business_interruption_limit` SET TAGS ('dbx_business_glossary_term' = 'Business Interruption (BI) Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `business_interruption_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `coi_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Required Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `coinsurance_pct` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `contents_limit` SET TAGS ('dbx_business_glossary_term' = 'Contents Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `contents_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|suspended|excluded|expired|pending');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'scheduled|blanket');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Per-Location Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `deductible_type` SET TAGS ('dbx_business_glossary_term' = 'Deductible Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `deductible_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|per_occurrence|annual_aggregate');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Expiry Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `flood_zone_designation` SET TAGS ('dbx_business_glossary_term' = 'Flood Zone Designation');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `lender_loss_payee` SET TAGS ('dbx_business_glossary_term' = 'Lender Loss Payee');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `lender_loss_payee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `loss_payee_loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Payee Loan Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `loss_payee_loan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Insured Property Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `number_of_stories` SET TAGS ('dbx_business_glossary_term' = 'Number of Stories');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `ordinance_law_limit` SET TAGS ('dbx_business_glossary_term' = 'Ordinance or Law Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `ordinance_law_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `protection_class` SET TAGS ('dbx_business_glossary_term' = 'Protection Class (COPE)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `protection_class` SET TAGS ('dbx_value_regex' = '^([1-9]|10|10W)$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `replacement_cost_value` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost Value (RCV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `replacement_cost_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `roof_type` SET TAGS ('dbx_business_glossary_term' = 'Roof Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `roof_year_updated` SET TAGS ('dbx_business_glossary_term' = 'Roof Year Updated');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `schedule_location_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Location Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_city` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Property City');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_country` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Property Country Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Property Address Line 1');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Property Postal Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_state` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Property State');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `scheduled_address_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `sprinkler_system` SET TAGS ('dbx_business_glossary_term' = 'Sprinkler System Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `tiv` SET TAGS ('dbx_business_glossary_term' = 'Total Insured Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `tiv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `wind_zone` SET TAGS ('dbx_business_glossary_term' = 'Wind Zone');
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `statement_of_values_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Values (SOV) ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Reference ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `prior_sov_statement_of_values_id` SET TAGS ('dbx_business_glossary_term' = 'Prior SOV ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `prior_statement_of_values_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Acknowledgement Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `appraisal_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `appraisal_firm` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Firm Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'SOV Approved By');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'SOV Approval Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `building_value` SET TAGS ('dbx_business_glossary_term' = 'Building Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `building_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `business_interruption_value` SET TAGS ('dbx_business_glossary_term' = 'Business Interruption (BI) Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `business_interruption_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `catastrophe_exposed` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe Exposure Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `contents_value` SET TAGS ('dbx_business_glossary_term' = 'Contents Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `contents_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'SOV Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SOV Expiry Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `flood_zone_locations` SET TAGS ('dbx_business_glossary_term' = 'Number of Flood Zone Locations');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `insured_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Insured Entity Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `insurer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `location_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Scheduled Locations');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SOV Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `portfolio_name` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `properties_added` SET TAGS ('dbx_business_glossary_term' = 'Properties Added Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `properties_removed` SET TAGS ('dbx_business_glossary_term' = 'Properties Removed Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'SOV Revision Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|argus_enterprise|manual|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `sov_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Values (SOV) Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `sov_number` SET TAGS ('dbx_value_regex' = '^SOV-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `sov_type` SET TAGS ('dbx_business_glossary_term' = 'SOV Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `sov_type` SET TAGS ('dbx_value_regex' = 'inception|renewal|mid_term_addition|mid_term_deletion|mid_term_revision');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'SOV Submission Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'SOV Submission Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|accepted|rejected|superseded');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `total_gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `total_insurable_value` SET TAGS ('dbx_business_glossary_term' = 'Total Insurable Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `total_insurable_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_business_glossary_term' = 'Valuation Basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_value_regex' = 'replacement_cost|actual_cash_value|agreed_value|functional_replacement_cost|market_value');
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SOV Version Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `premium_id` SET TAGS ('dbx_business_glossary_term' = 'Premium ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `reversed_premium_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `audit_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Adjustment Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `audit_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Premium Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `billed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `broker_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `broker_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `broker_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Rate');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `broker_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Due Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `earned_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Earned Premium Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `earned_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `finance_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Premium Finance Agreement Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `finance_company_name` SET TAGS ('dbx_business_glossary_term' = 'Premium Finance Company Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Invoice Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `is_premium_financed` SET TAGS ('dbx_business_glossary_term' = 'Premium Financing Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `is_surplus_lines` SET TAGS ('dbx_business_glossary_term' = 'Surplus Lines Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `late_payment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `late_payment_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Premium Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Premium Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|credit_card|escrow|financing');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'current|past_due|lapsed|paid|cancelled|pending');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `premium_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `premium_type` SET TAGS ('dbx_value_regex' = 'base|endorsement|audit|minimum_earned|return');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `property_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Property Allocation Method');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `property_allocation_method` SET TAGS ('dbx_value_regex' = 'insured_value|square_footage|equal_split|manual');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `stamping_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Stamping Fee Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `stamping_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `surplus_lines_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Surplus Lines Tax Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `surplus_lines_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `unearned_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Unearned Premium Amount (UPR)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `unearned_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `adjuster_id` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `bpo_id` SET TAGS ('dbx_business_glossary_term' = 'Bpo Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Incident Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `related_claim_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `business_interruption_period_days` SET TAGS ('dbx_business_glossary_term' = 'Business Interruption Period (Days)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `catastrophe_code` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `cause_of_loss` SET TAGS ('dbx_business_glossary_term' = 'Cause of Loss');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^CLM-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|closed|denied|subrogation|litigation|pending');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'property_damage|business_interruption|liability|workers_comp|flood|earthquake');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'owner|tenant|third_party|employee|contractor');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Closed Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'all_risk|named_peril|liability|workers_comp|flood|earthquake');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount Applied');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `loss_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Loss');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `loss_location` SET TAGS ('dbx_business_glossary_term' = 'Loss Location Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `loss_of_rents_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss of Rents Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `loss_of_rents_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `loss_run_included` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Included Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `net_claim_payment` SET TAGS ('dbx_business_glossary_term' = 'Net Claim Payment');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `net_claim_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Date Reported');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `source_claim_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim Reference');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|mri|manual|building_engines|procore');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `subrogation_recovery` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `subrogation_recovery` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `third_party_involved` SET TAGS ('dbx_business_glossary_term' = 'Third Party Involved Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `total_incurred_loss` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Loss');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `total_incurred_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `total_paid_loss` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Loss');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `total_paid_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `claim_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Receipt Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `reversed_claim_payment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Payment Approved By');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Approved Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Account Reference');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `check_wire_reference` SET TAGS ('dbx_business_glossary_term' = 'Check or Wire Transfer Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `coverage_line` SET TAGS ('dbx_business_glossary_term' = 'Coverage Line Applied');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `cumulative_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Paid-to-Date Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `cumulative_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `cumulative_paid_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `deductible_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applied Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `deductible_applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `deductible_applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Deduction Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `insured_value_at_loss` SET TAGS ('dbx_business_glossary_term' = 'Insured Value at Time of Loss');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `insured_value_at_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `insured_value_at_loss` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `loss_run_period` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Reporting Period');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `loss_run_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|H[12]|[0-9]{2})$');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `loss_type` SET TAGS ('dbx_business_glossary_term' = 'Loss Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `mortgagee_copayment_required` SET TAGS ('dbx_business_glossary_term' = 'Mortgagee Co-Payment Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `mortgagee_name` SET TAGS ('dbx_business_glossary_term' = 'Mortgagee Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `mortgagee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `mortgagee_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Claim Payment Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payee_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'insured|mortgagee|contractor|claimant|lienholder|subrogation_party');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|direct_deposit|escrow_disbursement');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_sequence` SET TAGS ('dbx_business_glossary_term' = 'Payment Sequence Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|issued|cleared|voided|stopped|returned');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'advance|partial|final|supplemental|subrogation_recovery|reopened');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `recoverable_depreciation_released` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Depreciation Released Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `reserve_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Reduction Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `reserve_reduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `reserve_reduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|sap_s4hana|manual_entry|insurer_portal');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Void Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Void Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `loss_run_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Run ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Largest Loss Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `prior_loss_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Asset Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'commercial|residential|mixed_use|industrial|retail|office');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `catastrophe_losses_included` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe Losses Included Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `closed_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Closed Claims Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Policy Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'property|general_liability|umbrella|workers_comp|professional_liability|environmental');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `document_ref` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Document Reference');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `earned_premium` SET TAGS ('dbx_business_glossary_term' = 'Earned Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `earned_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Total Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `largest_loss_description` SET TAGS ('dbx_business_glossary_term' = 'Largest Loss Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `largest_single_loss` SET TAGS ('dbx_business_glossary_term' = 'Largest Single Loss Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `largest_single_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `loss_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loss Ratio');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `loss_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `open_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Open Claims Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Period End Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Period Start Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `period_years` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Period Years');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Portfolio Scope');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_value_regex' = 'single_property|portfolio|entity_level|fund_level');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Received Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `report_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Report As-Of Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Report Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Report Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'received|pending|superseded|final|cancelled');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Report Version');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Request Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `submission_purpose` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Submission Purpose');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `submission_purpose` SET TAGS ('dbx_value_regex' = 'renewal_underwriting|broker_negotiation|actuarial_analysis|portfolio_review|regulatory_filing');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_incurred_losses` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Losses');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_incurred_losses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_open_reserves` SET TAGS ('dbx_business_glossary_term' = 'Total Open Reserves');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_open_reserves` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_paid_expenses` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Loss Adjustment Expenses');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_paid_expenses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_paid_losses` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Losses');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `total_paid_losses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_underwriting');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `construction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `zoning_code_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `prior_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'acceptable|conditional|declined');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report Reference');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|completed|expired|cancelled');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Assessor License Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessor_type` SET TAGS ('dbx_business_glossary_term' = 'Assessor Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `assessor_type` SET TAGS ('dbx_value_regex' = 'internal_risk_manager|third_party_engineer|insurer_inspector|independent_appraiser|environmental_consultant');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `crime_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Crime Hazard Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `electrical_system_age_years` SET TAGS ('dbx_business_glossary_term' = 'Electrical System Age (Years)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `environmental_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Hazard Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `esg_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Risk Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `fema_flood_zone` SET TAGS ('dbx_business_glossary_term' = 'FEMA Flood Zone Designation');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `fire_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Hazard Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `fire_suppression_system_status` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `fire_suppression_system_status` SET TAGS ('dbx_value_regex' = 'fully_sprinklered|partially_sprinklered|none|standpipe_only');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `flood_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Flood Hazard Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `hvac_condition` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Condition');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `hvac_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `improvement_deadline` SET TAGS ('dbx_business_glossary_term' = 'Improvement Deadline');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `insured_replacement_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Replacement Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `insured_replacement_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `plumbing_condition` SET TAGS ('dbx_business_glossary_term' = 'Plumbing Condition');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `plumbing_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `prior_loss_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Loss Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `prior_loss_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Loss History Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `prior_loss_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Loss Total Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `prior_loss_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `protection_class_rating` SET TAGS ('dbx_business_glossary_term' = 'Protection Class (PC) Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `protection_class_rating` SET TAGS ('dbx_value_regex' = '^(1[0]|[1-9])$');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `recommended_improvements` SET TAGS ('dbx_business_glossary_term' = 'Recommended Risk Improvements');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `risk_grade` SET TAGS ('dbx_business_glossary_term' = 'Risk Grade');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `risk_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `roof_age_years` SET TAGS ('dbx_business_glossary_term' = 'Roof Age (Years)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `roof_condition` SET TAGS ('dbx_business_glossary_term' = 'Roof Condition');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `roof_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `seismic_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Seismic Hazard Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `total_building_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Total Building Area (SQF)');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `underwriter_notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `underwriter_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `wind_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Wind Hazard Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_of_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Contractor ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `replaced_certificate_of_insurance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `additional_insured` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Status Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `additional_insured_name` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `additional_insured_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `additional_insured_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `auto_liability_combined_limit` SET TAGS ('dbx_business_glossary_term' = 'Automobile Liability Combined Single Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `auto_liability_combined_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'current|expiring|expired|cancelled|pending_renewal');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'issued_to_tenant|issued_to_lender|issued_to_contractor|issued_to_municipality|received_from_vendor|received_from_contractor');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `compliance_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'general_liability|commercial_auto|workers_compensation|umbrella_excess|professional_liability|property');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `description_of_operations` SET TAGS ('dbx_business_glossary_term' = 'Description of Operations / Locations / Vehicles');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'COI Document Reference');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `employers_liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Employers Liability Each Accident Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `employers_liability_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `general_liability_aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'General Liability General Aggregate Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `general_liability_aggregate_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `general_liability_occurrence_limit` SET TAGS ('dbx_business_glossary_term' = 'General Liability Each Occurrence Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `general_liability_occurrence_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insured_address` SET TAGS ('dbx_business_glossary_term' = 'Named Insured Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insured_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insured_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insured_name` SET TAGS ('dbx_business_glossary_term' = 'Named Insured Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insured_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `insured_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `notice_of_cancellation_days` SET TAGS ('dbx_business_glossary_term' = 'Notice of Cancellation Days');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `personal_advertising_injury_limit` SET TAGS ('dbx_business_glossary_term' = 'Personal and Advertising Injury Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `personal_advertising_injury_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `policy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `policy_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `primary_noncontributory` SET TAGS ('dbx_business_glossary_term' = 'Primary and Non-Contributory Endorsement Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `products_completed_ops_limit` SET TAGS ('dbx_business_glossary_term' = 'Products and Completed Operations Aggregate Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `products_completed_ops_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `property_insured_value` SET TAGS ('dbx_business_glossary_term' = 'Property Insured Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `property_insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `renewal_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `umbrella_aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'Umbrella / Excess Liability Aggregate Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `umbrella_aggregate_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `umbrella_each_occurrence_limit` SET TAGS ('dbx_business_glossary_term' = 'Umbrella / Excess Liability Each Occurrence Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `umbrella_each_occurrence_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `waiver_of_subrogation` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Subrogation Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ALTER COLUMN `workers_comp_statutory_limit` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Statutory Limit Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `prior_renewal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `binding_date` SET TAGS ('dbx_business_glossary_term' = 'Binding Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `bound_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Bound Carrier Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `bound_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Bound Policy Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `bound_premium` SET TAGS ('dbx_business_glossary_term' = 'Renewal Premium Bound');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `bound_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `broker_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Submission Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `carrier_quote_deadline` SET TAGS ('dbx_business_glossary_term' = 'Carrier Quote Deadline');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `coi_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Issued Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `coi_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `coverage_change_description` SET TAGS ('dbx_business_glossary_term' = 'Coverage Change Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `coverage_changed` SET TAGS ('dbx_business_glossary_term' = 'Coverage Changed Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Year');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `days_to_expiration_at_initiation` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiration at Initiation');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `incumbent_carrier_retained` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Carrier Retained Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Initiation Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `lender_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `lender_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `marketing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Marketing Strategy');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `marketing_strategy` SET TAGS ('dbx_value_regex' = 'single_carrier|competitive_bid|direct_placement|remarket');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `new_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'New Policy Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `number_of_quotes_received` SET TAGS ('dbx_business_glossary_term' = 'Number of Quotes Received');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Change Amount (Dollar)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_change_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Premium Change Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_change_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_finance_used` SET TAGS ('dbx_business_glossary_term' = 'Premium Finance Used Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `prior_year_premium` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `prior_year_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `quoted_premium` SET TAGS ('dbx_business_glossary_term' = 'Renewal Premium Quoted');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `quoted_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_value_regex' = '^RNW-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'in_progress|submitted_to_market|quoted|bound|lapsed|cancelled');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `total_insured_value` SET TAGS ('dbx_business_glossary_term' = 'Total Insured Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `total_insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `endorsement_id` SET TAGS ('dbx_business_glossary_term' = 'Endorsement ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Clause Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `superseded_by_endorsement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Endorsement ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `superseded_endorsement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `additional_insured_type` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `additional_insured_type` SET TAGS ('dbx_value_regex' = 'lender|tenant|property_manager|joint_venture|government|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `carrier_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Approval Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Document Reference');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `endorsement_number` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `endorsement_status` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `endorsement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|issued|declined|voided|superseded');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `endorsement_type` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `exclusion_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Form Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `insured_value_change` SET TAGS ('dbx_business_glossary_term' = 'Insured Value Change');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `insured_value_change` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Issued Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `lease_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `lender_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lender Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `new_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'New Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `new_coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `new_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'New Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `new_deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `premium_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `premium_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `premium_adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `premium_adjustment_type` SET TAGS ('dbx_value_regex' = 'additional_premium|return_premium|flat|pro_rata|short_rate');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `prior_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Prior Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `prior_coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `prior_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `prior_deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Requested Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `requesting_party` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Sequence Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|manual|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ALTER COLUMN `waiver_of_subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Subrogation Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` SET TAGS ('dbx_subdomain' = 'vendor_relations');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `parent_insurer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `acord_form_support` SET TAGS ('dbx_business_glossary_term' = 'ACORD Form Support Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `am_best_financial_size_category` SET TAGS ('dbx_business_glossary_term' = 'AM Best Financial Size Category (FSC)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `am_best_rating` SET TAGS ('dbx_business_glossary_term' = 'AM Best Financial Strength Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `am_best_rating_date` SET TAGS ('dbx_business_glossary_term' = 'AM Best Rating Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `am_best_rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'AM Best Rating Outlook');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `am_best_rating_outlook` SET TAGS ('dbx_value_regex' = 'stable|positive|negative|under_review');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Approval Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `approved_carrier` SET TAGS ('dbx_business_glossary_term' = 'Approved Carrier Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Claims Contact Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Claims Contact Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Claims Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `claims_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `coi_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Portal URL');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `coi_portal_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `domicile_state_code` SET TAGS ('dbx_business_glossary_term' = 'Domicile State Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `domicile_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `fein` SET TAGS ('dbx_business_glossary_term' = 'Federal Employer Identification Number (FEIN)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `fein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `fein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_state_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `hq_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `insurer_status` SET TAGS ('dbx_business_glossary_term' = 'Insurer Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `insurer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|in_run_off|suspended');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `insurer_type` SET TAGS ('dbx_business_glossary_term' = 'Insurer Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `insurer_type` SET TAGS ('dbx_value_regex' = 'admitted|non_admitted|lloyds_syndicate|captive|reinsurer');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `last_financial_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Financial Review Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Legal Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `lines_of_business` SET TAGS ('dbx_business_glossary_term' = 'Lines of Business');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `lloyds_syndicate_number` SET TAGS ('dbx_business_glossary_term' = 'Lloyds Syndicate Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `loss_run_request_email` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Request Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `loss_run_request_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `loss_run_request_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `loss_run_request_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `min_am_best_rating_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum AM Best Rating Required');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `naic_group_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Group Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `naic_group_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `preferred_carrier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `sp_rating` SET TAGS ('dbx_business_glossary_term' = 'S&P Global Insurer Financial Strength Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `state_admittance_status` SET TAGS ('dbx_business_glossary_term' = 'State Admittance Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `state_admittance_status` SET TAGS ('dbx_value_regex' = 'admitted|non_admitted|not_applicable');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `surplus_lines_eligible` SET TAGS ('dbx_business_glossary_term' = 'Surplus Lines Eligible Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Trade Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Contact Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Contact Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `underwriting_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Insurer Website URL');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ALTER COLUMN `website` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` SET TAGS ('dbx_subdomain' = 'vendor_relations');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `parent_insurance_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `account_executive_email` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `account_executive_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `account_executive_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `account_executive_name` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `account_executive_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `am_best_rating` SET TAGS ('dbx_business_glossary_term' = 'AM Best Financial Strength Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `binding_authority` SET TAGS ('dbx_business_glossary_term' = 'Binding Authority Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending_approval');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|surplus_lines|captive_manager|managing_general_agent');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `contingent_commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Contingent Commission Eligible Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `domicile_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `eo_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `eo_coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `eo_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `eo_insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurer Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `eo_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `eo_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `firm_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Firm Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker License Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `licensed_states` SET TAGS ('dbx_business_glossary_term' = 'Licensed States');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `lines_of_business` SET TAGS ('dbx_business_glossary_term' = 'Lines of Business Serviced');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Company Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `naic_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Broker Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `of_record` SET TAGS ('dbx_business_glossary_term' = 'Broker of Record (BOR) Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Office Address Line 1');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_city` SET TAGS ('dbx_business_glossary_term' = 'Office City');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Office Postal Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_state` SET TAGS ('dbx_business_glossary_term' = 'Office State');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `office_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `parent_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Firm Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `parent_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Broker Performance Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `preferred_carrier_relationships` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Relationships');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Relationship End Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Relationship Start Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `renewal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Renewal Review Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `surplus_lines_license_number` SET TAGS ('dbx_business_glossary_term' = 'Surplus Lines License Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `surplus_lines_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Identification Number (EIN)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Trading Name (DBA)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `trading_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_id` SET TAGS ('dbx_business_glossary_term' = 'Adjuster ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `supervising_adjuster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_code` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_code` SET TAGS ('dbx_value_regex' = '^ADJ-[A-Z0-9]{6,12}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_status` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_type` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `adjuster_type` SET TAGS ('dbx_value_regex' = 'staff|independent|public|catastrophe|desk');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `asset_type_expertise` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Expertise');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|expired');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `current_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Current Active Claim Assignment Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `designation` SET TAGS ('dbx_business_glossary_term' = 'Professional Designation');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `e_and_o_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Expiry Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `e_and_o_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `e_and_o_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Email Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|percentage_of_loss|retainer');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `firm_name` SET TAGS ('dbx_business_glossary_term' = 'Adjusting Firm Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Adjuster First Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `geographic_coverage_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Region');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `hourly_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Hourly Rate (USD)');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `hourly_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `is_catastrophe_eligible` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe Deployment Eligible Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `is_e_and_o_insured` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Last Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Adjuster License Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License Home State');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `licensed_states` SET TAGS ('dbx_business_glossary_term' = 'Licensed States List');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_state` SET TAGS ('dbx_business_glossary_term' = 'Mailing State');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mailing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `max_claim_authority_usd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Claim Settlement Authority (USD)');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `max_claim_authority_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `max_claim_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Claim Capacity');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Mobile Phone Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Performance Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Phone Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|portal');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `preferred_panel_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Adjuster Panel Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `secondary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Secondary Specialty');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Specialty');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `specialty` SET TAGS ('dbx_value_regex' = 'property|liability|business_interruption|large_loss|environmental');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ALTER COLUMN `years_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `claim_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Reserve ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `adjuster_id` SET TAGS ('dbx_business_glossary_term' = 'Adjuster ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `superseded_claim_reserve_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `actuarial_review_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Review Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `adjuster_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Authorization Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `adjuster_authorization_code` SET TAGS ('dbx_value_regex' = '^AUTH-[A-Z0-9]{6,12}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `authority_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Authority Limit Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `authority_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `cat_event_code` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe (CAT) Event Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `cat_event_code` SET TAGS ('dbx_value_regex' = '^CAT-[A-Z0-9]{4,10}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `change_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Reason Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'new_information|litigation_update|settlement_negotiation|coverage_determination|actuarial_review|reopen');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Reason Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'property_damage|general_liability|workers_compensation|business_interruption|environmental');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `cumulative_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Reserve Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `cumulative_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `current_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Reserve Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `current_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `established_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Established Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `established_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `financial_period` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Period');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `financial_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `incurred_amount` SET TAGS ('dbx_business_glossary_term' = 'Incurred Loss Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `incurred_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `is_cat_event` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe (CAT) Event Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `is_ibnr` SET TAGS ('dbx_business_glossary_term' = 'Incurred But Not Reported (IBNR) Indicator');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `loss_run_report_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Report Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `paid_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid-to-Date Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `paid_to_date_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_adequacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_business_glossary_term' = 'Reserve Basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_value_regex' = 'case_basis|actuarial_estimate|bulk_reserve|formula_basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_change_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_close_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Close Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_established_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Established Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_number` SET TAGS ('dbx_value_regex' = '^RES-[0-9]{8,12}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'open|pending_review|adjusted|closed|reopened');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'indemnity|expense|ibnr|salvage|subrogation|allocated_loss_adjustment');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `revision_sequence` SET TAGS ('dbx_business_glossary_term' = 'Reserve Revision Sequence Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `salvage_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Salvage Recoverable Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `salvage_recoverable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `subrogation_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recoverable Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `subrogation_recoverable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `tpa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Administrator (TPA) Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `liability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Event ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `common_area_id` SET TAGS ('dbx_business_glossary_term' = 'Common Area Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Document ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Incident Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `parking_id` SET TAGS ('dbx_business_glossary_term' = 'Parking Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property Asset ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `showing_id` SET TAGS ('dbx_business_glossary_term' = 'Showing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `related_liability_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `attorney_assigned` SET TAGS ('dbx_business_glossary_term' = 'Defense Attorney Assigned Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `defense_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Defense Counsel Law Firm Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Liability Exposure Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `estimated_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Event Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_value_regex' = '^LBE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_location_detail` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Detail');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_location_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_review|claim_filed|closed_no_claim|closed_with_claim|litigated');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_address` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Address');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Contact Phone');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Full Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `insurer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notification Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `insurer_notified` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notified Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `liability_category` SET TAGS ('dbx_business_glossary_term' = 'Liability Category');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `liability_category` SET TAGS ('dbx_value_regex' = 'general_liability|premises_liability|professional_liability|product_liability|employment_practices');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `litigation_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Initiated Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `litigation_status` SET TAGS ('dbx_business_glossary_term' = 'Litigation Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `medical_treatment_sought` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Sought Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `medical_treatment_sought` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `medical_treatment_sought` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `medical_treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `medical_treatment_type` SET TAGS ('dbx_value_regex' = 'none|first_aid|emergency_room|hospitalized|ongoing_treatment|unknown');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `notice_of_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Notice of Claim Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `notice_of_claim_received` SET TAGS ('dbx_business_glossary_term' = 'Notice of Claim Received Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `police_report_filed` SET TAGS ('dbx_business_glossary_term' = 'Police Report Filed Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `property_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Condition Contributing Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Date and Time');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `surveillance_footage_available` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Footage Available Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `witness_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ALTER COLUMN `witness_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` SET TAGS ('dbx_subdomain' = 'risk_underwriting');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_account_id` SET TAGS ('dbx_business_glossary_term' = 'Captive Account ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Fronting Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `ownership_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Ownership Structure Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `parent_captive_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Captive Account Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated|under-review');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `actuary_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Firm Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `aggregate_retention_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Retention Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `aggregate_retention_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `capitalization_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `capitalization_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_account_number` SET TAGS ('dbx_business_glossary_term' = 'Captive Account Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Captive Entity Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_manager_contact` SET TAGS ('dbx_business_glossary_term' = 'Captive Manager Contact Email');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_manager_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_manager_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_manager_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Captive Manager Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_premium_ceded` SET TAGS ('dbx_business_glossary_term' = 'Captive Premium Ceded');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_premium_ceded` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_type` SET TAGS ('dbx_business_glossary_term' = 'Captive Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `captive_type` SET TAGS ('dbx_value_regex' = 'single-parent|group|rent-a-captive|cell-captive|association');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `combined_ratio` SET TAGS ('dbx_business_glossary_term' = 'Combined Ratio');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `dividend_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Dividend Paid Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `dividend_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `domicile_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Domicile Jurisdiction');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `fronting_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Fronting Fee Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `fronting_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `gross_written_premium` SET TAGS ('dbx_business_glossary_term' = 'Gross Written Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `gross_written_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `investment_portfolio_value` SET TAGS ('dbx_business_glossary_term' = 'Investment Portfolio Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `investment_portfolio_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `irs_953d_election_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS Section 953(d) Election Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `last_actuarial_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Actuarial Review Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `lines_of_business` SET TAGS ('dbx_business_glossary_term' = 'Lines of Business Written');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `loss_fund_balance` SET TAGS ('dbx_business_glossary_term' = 'Loss Fund Balance');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `loss_fund_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `loss_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Reserve Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `loss_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `micro_captive_flag` SET TAGS ('dbx_business_glossary_term' = 'Micro-Captive (831(b)) Election Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `net_written_premium` SET TAGS ('dbx_business_glossary_term' = 'Net Written Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `net_written_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `program_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `program_inception_date` SET TAGS ('dbx_business_glossary_term' = 'Program Inception Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `regulatory_filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Due Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'filed|pending|overdue|accepted|rejected|not-required');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `reinsurance_structure` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Structure');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `reinsurance_structure` SET TAGS ('dbx_value_regex' = 'quota-share|excess-of-loss|stop-loss|facultative|proportional|none');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `reinsurer_name` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `retained_limit_per_occurrence` SET TAGS ('dbx_business_glossary_term' = 'Retained Limit Per Occurrence');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `retained_limit_per_occurrence` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `ownership_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Structure Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `prior_year_program_insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Insurance Program ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `investment_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Investment Vehicle Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Manager Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `prior_insurance_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `aggregate_deductible` SET TAGS ('dbx_business_glossary_term' = 'Program Aggregate Deductible');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `aggregate_deductible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Scope');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `asset_count_covered` SET TAGS ('dbx_business_glossary_term' = 'Number of Assets Covered Under Program');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `earthquake_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Earthquake Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `environmental_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Liability Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `esg_aligned_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Aligned Program Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `excess_tower_layers` SET TAGS ('dbx_business_glossary_term' = 'Excess and Umbrella Tower Layer Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `flood_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Flood Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Geographic Scope');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Program Inception Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `loss_run_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Report As-Of Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `ocip_ccip_flag` SET TAGS ('dbx_business_glossary_term' = 'Owner/Contractor Controlled Insurance Program (OCIP/CCIP) Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Policies in Program');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `premium_finance_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Finance Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `premium_payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Schedule');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `premium_payment_schedule` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `primary_carrier_am_best_rating` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier AM Best Financial Strength Rating');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `primary_layer_limit` SET TAGS ('dbx_business_glossary_term' = 'Primary Layer Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `primary_layer_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|cancelled|in_negotiation|bound');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'property|casualty|management_liability|environmental|construction_wrap_up|umbrella_excess');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Program Renewal Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `self_insured_retention` SET TAGS ('dbx_business_glossary_term' = 'Self-Insured Retention (SIR)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `self_insured_retention` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|argus_enterprise|manual|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `structure` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Structure');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `structure` SET TAGS ('dbx_value_regex' = 'blanket|scheduled|layered|quota_share|captive|wrap_up');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `terrorism_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Terrorism Coverage Flag (TRIA)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `total_program_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Program Coverage Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `total_program_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `total_program_premium` SET TAGS ('dbx_business_glossary_term' = 'Total Insurance Program Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `total_program_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `total_tiv` SET TAGS ('dbx_business_glossary_term' = 'Total Insurable Value (TIV)');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `total_tiv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Year');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `excess_layer_id` SET TAGS ('dbx_business_glossary_term' = 'Excess Layer ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `insurer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `underlying_excess_layer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `attachment_point` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point (Attaching Limit)');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `attachment_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `broker_of_record` SET TAGS ('dbx_business_glossary_term' = 'Broker of Record');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Layer Cancellation Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'non_payment|underwriter_withdrawal|portfolio_restructure|merger_acquisition|coverage_replaced|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `catastrophe_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Catastrophe Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `co_insurer_count` SET TAGS ('dbx_business_glossary_term' = 'Co-Insurer Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `coverage_line` SET TAGS ('dbx_business_glossary_term' = 'Coverage Line');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `drop_down_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Drop-Down Provision Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Layer Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `endorsements_summary` SET TAGS ('dbx_business_glossary_term' = 'Endorsements Summary');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `exhaustion_point` SET TAGS ('dbx_business_glossary_term' = 'Exhaustion Point');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `exhaustion_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Layer Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `follows_form_flag` SET TAGS ('dbx_business_glossary_term' = 'Follows Form Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_limit` SET TAGS ('dbx_business_glossary_term' = 'Layer Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_number` SET TAGS ('dbx_business_glossary_term' = 'Layer Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_premium` SET TAGS ('dbx_business_glossary_term' = 'Layer Premium');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Layer Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_status` SET TAGS ('dbx_business_glossary_term' = 'Layer Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_status` SET TAGS ('dbx_value_regex' = 'active|bound|pending|expired|cancelled|non_renewed');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_type` SET TAGS ('dbx_business_glossary_term' = 'Layer Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `layer_type` SET TAGS ('dbx_value_regex' = 'first_excess|second_excess|umbrella|quota_share|drop_down');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `lead_insurer_naic_code` SET TAGS ('dbx_business_glossary_term' = 'Lead Insurer NAIC Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `lead_insurer_naic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `lead_insurer_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Lead Insurer Share Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `occurrence_limit` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Limit');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `occurrence_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `placement_pct` SET TAGS ('dbx_business_glossary_term' = 'Placement Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `rate_on_line_pct` SET TAGS ('dbx_business_glossary_term' = 'Rate on Line Percentage (ROL)');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `rate_on_line_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `reinstatement_count` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Count');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `reinstatement_premium_pct` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Premium Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Layer Renewal Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|MRI Software|Argus Enterprise|DocuSign CLM|manual');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `surplus_lines_flag` SET TAGS ('dbx_business_glossary_term' = 'Surplus Lines Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `terrorism_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Terrorism Coverage Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `total_layer_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Layer Capacity');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `total_layer_capacity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `underlying_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Underlying Policy Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `premium_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Allocation ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center (CC) ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `premium_id` SET TAGS ('dbx_business_glossary_term' = 'Premium ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `reversal_allocation_premium_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Allocation ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `parent_premium_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Allocated Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Premium Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Unit');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_value_regex' = 'USD|SQF|SQM|PCT');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_basis_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Value');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Premium Allocation Method');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'pro_rata_tiv|pro_rata_sqft|pro_rata_revenue|equal_split|manual');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Premium Allocation Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage (PCT)');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `is_accrual` SET TAGS ('dbx_business_glossary_term' = 'Is Accrual Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `is_true_up` SET TAGS ('dbx_business_glossary_term' = 'Is True-Up Adjustment Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `property_name` SET TAGS ('dbx_business_glossary_term' = 'Property Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|mri|sap|manual');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `sqft_at_allocation` SET TAGS ('dbx_business_glossary_term' = 'Square Footage (SQF) at Allocation');
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` SET TAGS ('dbx_subdomain' = 'claims_management');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `subrogation_id` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Record ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Receipt Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property Asset ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Vendor ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `related_subrogation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `arbitration_case_number` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Case Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `arbitration_forum` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Forum Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Legal Basis');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'negligence|product_liability|contractor_fault|breach_of_contract|strict_liability|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Insurer Claim Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Deductible Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `demand_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Demand Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `demand_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `demand_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Demand Issued Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Identification Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `insurer_subrogation_contact` SET TAGS ('dbx_business_glossary_term' = 'Insurer Subrogation Contact Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `insurer_subrogation_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `litigation_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Filed Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `litigation_status` SET TAGS ('dbx_business_glossary_term' = 'Litigation Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `loss_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Event Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `loss_type` SET TAGS ('dbx_business_glossary_term' = 'Loss Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `loss_type` SET TAGS ('dbx_value_regex' = 'property_damage|bodily_injury|business_interruption|liability|environmental|other');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Outcome');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'recovered|settled|waived|uncollectible|pending');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `property_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Property Asset Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Expense Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_expense_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Percentage');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Reference Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `responsible_party_insurer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Insurer Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `responsible_party_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Policy Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `statute_of_limitations_date` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Expiry Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `total_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Insured Loss Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `total_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `waiver_of_subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Subrogation Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Waiver Reason');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `endorsement_id` SET TAGS ('dbx_business_glossary_term' = 'Endorsement ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `insurer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `superseded_by_document_policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `superseded_policy_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `access_restriction` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `docusign_envelope_reference` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Document Effective Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Document Execution Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|XLSX|TIFF|JPG|PNG');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Kilobytes)');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `is_executed` SET TAGS ('dbx_business_glossary_term' = 'Is Executed Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `issuing_party` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `issuing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `issuing_party_type` SET TAGS ('dbx_value_regex' = 'insurer|broker|appraiser|risk_engineer|legal_counsel|internal');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|DocuSign CLM|MRI Software|Procore|Building Engines|Manual Upload');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `source_system_doc_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Document ID');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `upload_date` SET TAGS ('dbx_business_glossary_term' = 'Document Upload Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `uploaded_by` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` SET TAGS ('dbx_association_edges' = 'transaction.property_sale,insurance.policy');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `policy_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Identifier');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment - Policy Id');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment - Property Sale Id');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Notes');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance Issued Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `coverage_status_at_closing` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status at Closing');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `lender_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Required Flag');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `lender_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Lender Notification Date');
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ALTER COLUMN `proration_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Proration Amount');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` SET TAGS ('dbx_subdomain' = 'policy_administration');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group Identifier');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `insurance_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `insurance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Program Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `insurer_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `parent_blanket_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `loss_history_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `total_insured_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`insurance`.`blanket_group` ALTER COLUMN `underwriting_notes` SET TAGS ('dbx_confidential' = 'true');
