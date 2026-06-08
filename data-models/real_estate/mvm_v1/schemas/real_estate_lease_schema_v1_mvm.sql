-- Schema for Domain: lease | Business: Real Estate | Version: v1_mvm
-- Generated on: 2026-05-02 05:06:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`lease` COMMENT 'Governs the full lifecycle of lease agreements — LOIs, executed leases, amendments, renewals, and terminations. Owns lease terms (NNN, gross, modified gross), TI allowances, CAM schedules, rent escalation clauses, WALT/WALE metrics, SNDA agreements, and renewal options. Authoritative source for ASC 842 / IFRS 16 lease accounting data including lease classification, measurement, and disclosure.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`lease_agreement` (
    `lease_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the lease agreement record in the lakehouse. Primary key for the lease.agreement data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property record against which this lease agreement is executed. Links the agreement to the property domain.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Building-level lease roll reports, NOI analysis by building, and occupancy dashboards require agreement→building. For multi-building assets, asset_id alone is insufficient. Every leasing professional ',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: Green leases explicitly reference the buildings LEED/BREEAM certification and impose sustainability obligations on tenants. The green lease is a named industry concept; linking the agreement to the',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.requirement. Business justification: Lease agreements are directly subject to specific compliance requirements (ADA accessibility, energy benchmarking, fire safety, affordable housing mandates). Compliance teams track which requirement g',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Every lease agreement is assigned to a cost center for property-level NOI reporting, budget variance analysis, and GL revenue allocation. Real estate controllers require this linkage to route base ren',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-currency lease portfolios require every agreement to reference a validated currency for rent billing, security deposit tracking, and FX reporting. Replaces denormalized currency_code string with',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Pre-leasing and lease-up tracking: executed leases must be linked to the originating development project for investor reporting, construction lender pre-leasing covenant compliance, and pro forma vali',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: Asset managers reconcile actual in-place lease terms (rent, TI, WALT) against acquisition deal underwriting assumptions. This link enables deal-vs-actual variance reporting, a core investment manageme',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Lease agreements are governed by specific jurisdictions determining rent control applicability, notice requirements, and security deposit rules. Compliance teams must identify which jurisdictions reg',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: ASC 842/IFRS 16 compliance requires each lease to be posted to a specific ledger (GAAP, IFRS, tax). Multi-ledger RE accounting systems track ROU assets and lease liabilities per ledger. A RE accountan',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each lease agreement is executed by a specific landlord legal entity. Required for ASC 842/IFRS 16 entity-level ROU asset and lease liability reporting, REIT compliance, and entity-level financial sta',
    `market_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.market_survey. Business justification: Leasing teams benchmark asking rents and negotiate lease terms against current market survey data. Linking lease_agreement to the market_survey used to price it enables rent benchmarking reports, audi',
    `owner_id` BIGINT COMMENT 'Reference to the property owner or landlord entity who is the lessor under this agreement. Links to the owner domain master record.',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Portfolio asset valuation (NOI, cap rate, WALT, WALE) and ASC 842 lease portfolio reporting require direct linkage between in-place leases and the investment portfolio asset they generate income for. ',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type (office, retail, industrial, multifamily) drives lease structure, CAM applicability rules, TI benchmarks, and REIT portfolio reporting. Real estate lease abstractors always classify leas',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease administration and ASC842 classification require every agreement to reference a structured lease type (NNN, gross, modified gross). Drives CAM responsibility, rent structure, and accounting clas',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: NNN leases contractually obligate tenants to pay property taxes based on the tax assessment. The lease agreement must reference the governing tax assessment to define tenant tax obligations, calculate',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant party who is the lessee under this agreement. Links to the tenant domain master record.',
    `assignment_permitted` BOOLEAN COMMENT 'Indicates whether the tenant is contractually permitted to assign the lease to a third party, subject to landlord consent conditions. Relevant for M&A transactions and corporate restructurings.',
    `base_rent_monthly` DECIMAL(18,2) COMMENT 'The contractual monthly base rent amount payable by the tenant, expressed in the agreement currency. Excludes CAM charges, taxes, and insurance. Core input for NOI and EGI calculations.',
    `base_rent_psf_annual` DECIMAL(18,2) COMMENT 'Annual base rent expressed on a per-square-foot (PSF) basis. Industry-standard metric used for market comparisons, CMA analysis, and CoStar benchmarking.',
    `cam_annual_budget` DECIMAL(18,2) COMMENT 'The annual budgeted Common Area Maintenance (CAM) charge allocated to this lease. Used for NNN and modified gross leases to estimate tenants pro-rata share of operating expenses.',
    `cam_reconciliation_date` DATE COMMENT 'The annual date on which CAM charges are reconciled against actual operating expenses and adjustments are billed or credited to the tenant.',
    `co_tenancy_clause` BOOLEAN COMMENT 'Indicates whether the lease contains a co-tenancy clause allowing the tenant to reduce rent or terminate the lease if anchor tenants or a minimum occupancy threshold at the property is not maintained.',
    `commencement_date` DATE COMMENT 'The date on which the lease term begins and the tenants right to use the premises commences. Used as the ASC 842 / IFRS 16 lease commencement date for right-of-use asset and lease liability measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the lease agreement record was first created in the source system (Yardi Voyager or MRI). Used for audit trail and data lineage tracking in the lakehouse silver layer.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The interest rate used to discount future lease payments to present value for ASC 842 / IFRS 16 measurement. Typically the implicit rate in the lease or the lessees incremental borrowing rate (IBR), expressed as a decimal (e.g., 0.045000 = 4.5%).',
    `exclusivity_clause` BOOLEAN COMMENT 'Indicates whether the lease contains an exclusivity clause restricting the landlord from leasing space to competing tenants within the same property. Common in retail leases.',
    `execution_date` DATE COMMENT 'The date on which all parties signed and the lease agreement became legally binding. Sourced from DocuSign CLM execution records.',
    `expiration_date` DATE COMMENT 'The contractual date on which the lease term ends. Used for WALT/WALE calculations, renewal option tracking, and ASC 842 lease term determination. Null for month-to-month leases.',
    `free_rent_months` STRING COMMENT 'The number of months of rent abatement (free rent) granted to the tenant at lease commencement or during the lease term. Recognized as a lease incentive under ASC 842 and amortized over the lease term.',
    `holdover_rent_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base rent if the tenant remains in occupancy beyond the lease expiration date without executing a renewal (holdover tenancy). Typically 1.25 to 1.50 (125%–150% of base rent).',
    `insurance_required_amount` DECIMAL(18,2) COMMENT 'The minimum general liability insurance coverage amount the tenant is contractually required to maintain and name the landlord as an additional insured, as specified in the lease abstract.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the lease agreement record was most recently updated in the source system. Used for incremental data pipeline processing and change data capture in the Databricks lakehouse.',
    `lease_classification` STRING COMMENT 'ASC 842 / IFRS 16 accounting classification of the lease as either an operating lease or a finance lease (capital lease). Determines balance sheet treatment, amortization method, and income statement presentation for the lessee.. Valid values are `operating|finance`',
    `lease_liability` DECIMAL(18,2) COMMENT 'The present value of future lease payments recognized as a liability on the balance sheet at lease commencement under ASC 842 / IFRS 16. Decreases as lease payments are made over the lease term.',
    `lease_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the lease agreement, as recorded in Yardi Voyager or MRI. Used for cross-system reference and tenant-facing communications.',
    `lease_status` STRING COMMENT 'Current lifecycle state of the lease agreement. Drives ASC 842 / IFRS 16 recognition, billing activation, and portfolio reporting. [ENUM-REF-CANDIDATE: draft|executed|active|expired|terminated|holdover — promote to reference product if additional states are required]. Valid values are `draft|executed|active|expired|terminated|holdover`',
    `lease_term_months` STRING COMMENT 'The total contractual lease term expressed in months from commencement to expiration. Used for WALT/WALE calculations, Argus Enterprise cash flow modeling, and portfolio duration analysis.',
    `leased_area_sqft` DECIMAL(18,2) COMMENT 'The net leasable area (NLA) in square feet covered by this lease agreement. Used for PSF rent calculations, CAM pro-rata share computation, and GLA occupancy reporting.',
    `loi_date` DATE COMMENT 'The date on which the Letter of Intent (LOI) was signed by the prospective tenant, marking the formal start of lease negotiation. Sourced from Salesforce CRM deal pipeline records.',
    `permitted_use` STRING COMMENT 'The contractually defined purpose for which the tenant is permitted to use the leased premises (e.g., retail clothing store, general office use, restaurant and bar). Restricts tenant operations and is a key lease abstract field.',
    `portfolio_type` STRING COMMENT 'Indicates whether the lease agreement belongs to the commercial or residential portfolio, driving applicable regulatory frameworks (ASC 842 vs. residential tenancy law) and reporting hierarchies.. Valid values are `commercial|residential`',
    `pro_rata_share` DECIMAL(18,2) COMMENT 'The tenants proportionate share of the buildings total rentable area, expressed as a decimal (e.g., 0.125000 = 12.5%). Used to allocate CAM, tax, and insurance charges in NNN and modified gross leases.',
    `renewal_option_count` STRING COMMENT 'The number of renewal options available to the tenant under the lease agreement. Each option typically specifies a term length and rent determination method.',
    `renewal_option_exercised` BOOLEAN COMMENT 'Indicates whether the tenant has formally exercised a renewal option under this lease agreement. True when the renewal notice has been received and acknowledged by the landlord.',
    `renewal_option_term_months` STRING COMMENT 'The duration in months of each renewal option period available to the tenant. Used in ASC 842 lease term assessment to determine if renewal options are reasonably certain to be exercised.',
    `rent_commencement_date` DATE COMMENT 'The date on which the tenants obligation to pay base rent begins. May differ from the lease commencement date due to free-rent periods or tenant improvement construction periods.',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'The percentage or fixed amount by which base rent escalates per the rent_escalation_type. Expressed as a decimal for percentage types (e.g., 0.0300 = 3%). Null when escalation type is none or CPI-linked.',
    `rent_escalation_type` STRING COMMENT 'Method by which base rent increases over the lease term. Fixed percent applies a set annual percentage increase. CPI ties escalation to the Consumer Price Index. Fixed amount adds a set dollar increment. None indicates flat rent for the full term.. Valid values are `fixed_percent|cpi|fixed_amount|none`',
    `rou_asset_value` DECIMAL(18,2) COMMENT 'The initial measurement of the right-of-use (ROU) asset recognized on the balance sheet at lease commencement under ASC 842 / IFRS 16. Equals the present value of future lease payments plus initial direct costs and prepaid rent.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'The total security deposit held by the landlord as collateral against tenant default or damage. Tracked for AR reconciliation and return obligations upon lease expiration.',
    `snda_executed` BOOLEAN COMMENT 'Indicates whether a Subordination, Non-Disturbance, and Attornment (SNDA) agreement has been executed between the tenant, landlord, and lender. Required by most commercial mortgage lenders to protect tenant occupancy rights in foreclosure.',
    `subletting_permitted` BOOLEAN COMMENT 'Indicates whether the tenant is contractually permitted to sublet all or part of the leased premises to a subtenant, subject to landlord consent conditions specified in the lease.',
    `termination_option_date` DATE COMMENT 'The contractual date on or before which the tenant may exercise an early termination option, if such a right exists in the lease. Null if no early termination option is granted.',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'The contractual fee or penalty payable by the tenant upon exercising an early termination option. Factored into ASC 842 lease term assessment and lease liability measurement.',
    `ti_allowance_amount` DECIMAL(18,2) COMMENT 'The total Tenant Improvement (TI) allowance granted by the landlord to fund tenant fit-out or renovation of the leased premises. Capitalized under FASB ASC 842 lease incentive accounting.',
    CONSTRAINT pk_lease_agreement PRIMARY KEY(`lease_agreement_id`)
) COMMENT 'Master record for every executed lease agreement across commercial and residential portfolios. Captures lease type (NNN, gross, modified gross, full-service, ground), commencement and expiration dates, base rent, rent escalation structure, security deposit terms, TI allowance, CAM obligations, permitted use, holdover provisions, and key lease abstract data (critical dates, exclusivity, co-tenancy, assignment/subletting rights, insurance requirements). Stores WALT/WALE metrics, ASC 842/IFRS 16 classification (operating vs. finance), right-of-use asset value, lease liability, and discount rate. Authoritative SSOT for all lease terms. Sourced from Yardi Voyager Lease Administration and MRI Lease Management modules. Links to property, tenant, and owner domains via FK.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique surrogate identifier for the lease amendment record in the Silver Layer lakehouse. Primary key for this entity.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Amendments track prior_gla_sqft and revised_gla_sqft area measurements. International portfolios require a formal UOM reference (sqft vs sqm) for remeasurement events, ASC 842 modification assessments',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with the amended lease, enabling property-level amendment reporting and portfolio analytics.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: Lease amendments (expansions, renewals) are frequently brokered transactions generating commissions. Linking amendment to the originating brokerage deal enables commission calculation on amendment tra',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lease amendments trigger ASC 842 remeasurement entries posted to cost centers. Finance teams need cost center on amendments to route remeasurement journal entries and produce cost-center-level lease m',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Amendment financial terms (revised rent, TI allowance) require a validated currency reference for multi-currency portfolio reporting and ASC842 remeasurement calculations using functional currency con',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent base lease agreement that this amendment modifies. Every amendment must be associated with exactly one executed base lease.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: ASC 842 lease modifications require remeasurement entries posted to a specific ledger. GAAP and IFRS 16 treat modifications differently; ledger assignment on amendment drives which accounting book rec',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Lease amendments trigger ASC 842 modification accounting requiring remeasurement JEs posted under a specific legal entity. Finance teams need the legal entity to route intercompany entries and produce',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease amendments frequently convert lease structures (e.g., gross to NNN). ASC842 modification analysis requires identifying the revised lease type to determine remeasurement triggers and updated CAM/',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lease amendments are frequently triggered by regulatory changes (rent control ordinance updates, ADA modifications, habitability code changes). Compliance teams track which regulatory obligation drove',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant party who is a signatory to this amendment, supporting tenant relationship management and ASC 842 lessee disclosure.',
    `amendment_number` STRING COMMENT 'Externally-known sequential identifier for the amendment as assigned in Yardi Voyager and DocuSign CLM (e.g., AMD-2024-000001). Used for legal referencing and audit trails.. Valid values are `^AMD-[0-9]{4}-[0-9]{6}$`',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment instrument. executed indicates a fully signed legal document; superseded indicates a later amendment replaced this one; voided indicates the amendment was cancelled before execution.. Valid values are `draft|pending_execution|executed|voided|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the primary business purpose of the amendment. Drives ASC 842 lease modification assessment workflow. [ENUM-REF-CANDIDATE: expansion|contraction|rent_modification|term_extension|term_reduction|permitted_use_change|ti_reallowance|snda_update|assignment_consent|other — promote to reference product]',
    `asc842_modification_type` STRING COMMENT 'Classification of the amendment under FASB ASC 842 lease modification guidance: separate_contract if the modification grants additional right-of-use at market rate; modification_of_existing if it changes the scope or consideration of the existing lease; not_applicable for non-US GAAP entities.. Valid values are `separate_contract|modification_of_existing|not_applicable`',
    `cam_revised` BOOLEAN COMMENT 'Indicates whether this amendment modifies the Common Area Maintenance (CAM) charge structure, caps, or reconciliation methodology applicable to the tenant.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this amendment record was first created in the Silver Layer data product. Supports data lineage, audit trail, and ASC 842 disclosure timing requirements.',
    `docusign_envelope_code` STRING COMMENT 'The unique envelope identifier assigned by DocuSign CLM for the executed amendment document. Enables direct retrieval of the signed document and audit trail from DocuSign.. Valid values are `^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$`',
    `docusign_status` STRING COMMENT 'The current status of the DocuSign CLM envelope for this amendment, reflecting the e-signature workflow state. completed confirms all parties have executed the document.. Valid values are `sent|delivered|completed|declined|voided`',
    `effective_date` DATE COMMENT 'The date on which the amendment terms become legally binding and operationally effective. This is the EFFECTIVE_FROM date for ASC 842 lease modification measurement purposes.',
    `execution_date` DATE COMMENT 'The date on which all parties completed signing the amendment instrument, as recorded in DocuSign CLM. May differ from effective_date when amendments are backdated or forward-dated.',
    `expiry_date` DATE COMMENT 'The date on which the terms introduced by this amendment cease to apply, if the amendment is time-limited (e.g., a temporary rent abatement). Null for permanent modifications.',
    `landlord_signed_date` DATE COMMENT 'The date on which the landlord or authorized representative executed (signed) the amendment. Supports execution timeline tracking and legal enforceability confirmation.',
    `lender_consent_date` DATE COMMENT 'The date on which lender consent was obtained for this amendment. Null if lender_consent_required is False or consent is pending.',
    `lender_consent_required` BOOLEAN COMMENT 'Indicates whether lender consent is required for this amendment under the terms of the propertys financing agreements. Relevant for CMBS-encumbered properties and loan covenant compliance.',
    `notes` STRING COMMENT 'Free-text field for additional legal, operational, or business context regarding this amendment, including special conditions, side letters, or negotiation notes not captured in structured fields.',
    `permitted_use_prior` STRING COMMENT 'The permitted use clause as stated in the lease before this amendment. Provides the before value for permitted use change amendments, supporting legal and compliance review.',
    `permitted_use_revised` STRING COMMENT 'The revised permitted use clause introduced by this amendment. Defines the authorized business activities the tenant may conduct in the leased premises.',
    `prior_base_rent_monthly` DECIMAL(18,2) COMMENT 'The monthly base rent amount in effect under the lease immediately before this amendment. Provides the before value for rent modification amendments and supports variance analysis.',
    `prior_gla_sqft` DECIMAL(18,2) COMMENT 'The Gross Leasable Area (GLA) in square feet as defined in the lease before this amendment. Provides the before value for expansion or contraction amendments.',
    `remeasurement_required` BOOLEAN COMMENT 'Indicates whether this amendment triggers a remeasurement of the right-of-use (ROU) asset and lease liability under ASC 842 / IFRS 16. Set to True when the modification is not accounted for as a separate contract.',
    `renewal_option_revised` BOOLEAN COMMENT 'Indicates whether this amendment modifies, adds, or removes renewal option rights for the tenant. Triggers update of renewal option tracking in Yardi Voyager.',
    `rent_abatement_months` STRING COMMENT 'Number of months of free rent or rent abatement granted to the tenant under this amendment. Used in ASC 842 straight-line rent calculations and lease incentive accounting.',
    `rent_abatement_start_date` DATE COMMENT 'The date on which the rent abatement period granted by this amendment commences. Null if no abatement is included in this amendment.',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'The annual escalation rate applicable to base rent under the revised terms (expressed as a decimal, e.g., 0.0300 for 3%). Applicable when rent_escalation_type is fixed_percentage. Used in Argus Enterprise DCF modeling.',
    `rent_escalation_type` STRING COMMENT 'The method by which base rent escalates under the revised terms introduced by this amendment. Drives rent schedule generation in Yardi Voyager and Argus Enterprise cash flow modeling.. Valid values are `fixed_percentage|cpi_indexed|fixed_amount|market_review|none`',
    `revised_base_rent_monthly` DECIMAL(18,2) COMMENT 'The monthly base rent amount as revised by this amendment. Drives updated rent billing schedules in Yardi Voyager AR and ASC 842 lease liability remeasurement.',
    `revised_gla_sqft` DECIMAL(18,2) COMMENT 'The Gross Leasable Area (GLA) in square feet as revised by this amendment. Populated for expansion or contraction amendments. Used to update portfolio GLA reporting.',
    `revised_lease_end_date` DATE COMMENT 'Updated lease expiration date resulting from this amendment. Populated for term extensions or reductions. Used to recalculate Weighted Average Lease Expiry (WALE) and Weighted Average Lease Term (WALT) metrics.',
    `revised_lease_start_date` DATE COMMENT 'Updated lease commencement date resulting from this amendment, if the amendment modifies the original start date (e.g., early possession or delayed commencement). Null if start date is unchanged.',
    `revised_rent_psf_annual` DECIMAL(18,2) COMMENT 'The revised annual rent expressed on a Per Square Foot (PSF) basis following this amendment. Standard CRE metric used for market comparability and portfolio benchmarking.',
    `sequence` STRING COMMENT 'Ordinal sequence of this amendment relative to the parent lease (1st amendment, 2nd amendment, etc.). Supports chronological ordering of all modifications to a lease.',
    `snda_included` BOOLEAN COMMENT 'Indicates whether a Subordination, Non-Disturbance and Attornment (SNDA) agreement is included as part of or triggered by this amendment. Relevant for lender consent and financing compliance.',
    `tenant_signed_date` DATE COMMENT 'The date on which the tenant or authorized representative executed (signed) the amendment. Supports execution timeline tracking and legal enforceability confirmation.',
    `ti_allowance_amount` DECIMAL(18,2) COMMENT 'The Tenant Improvement (TI) allowance granted to the tenant under this amendment, expressed in the amendment currency. Triggers CAPEX tracking in Yardi Voyager Fixed Assets and ASC 842 lease incentive accounting.',
    `ti_allowance_psf` DECIMAL(18,2) COMMENT 'The Tenant Improvement (TI) allowance expressed on a Per Square Foot (PSF) basis. Standard CRE metric for benchmarking TI packages against market norms.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this amendment record was most recently modified in the Silver Layer data product. Supports incremental data processing, change detection, and audit compliance.',
    `yardi_amendment_ref` STRING COMMENT 'The source system amendment reference code as recorded in Yardi Voyager Lease Administration. Used for reconciliation between the Silver Layer and the operational system of record.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Records all executed amendments to a base lease agreement, including expansion options exercised, contraction events, rent modifications, term extensions, TI re-allowances, and permitted use changes. Tracks amendment number, effective date, amendment type, changed clauses with before/after values, revised rent, revised GLA/NLA, and DocuSign execution metadata. Each amendment is a distinct legal instrument modifying the parent agreement and triggers ASC 842 lease modification assessment. Sourced from Yardi Voyager and DocuSign CLM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`renewal_option` (
    `renewal_option_id` BIGINT COMMENT 'Unique surrogate identifier for a contractual renewal option record within the lease domain. Primary key for the renewal_option data product.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: renewal_option.amendment_reference is a denormalized STRING field. Replacing it with amendment_id → lease.amendment.amendment_id normalizes the link between a renewal option and the amendment that exe',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: When a renewal option is exercised, the extended lease term triggers new cost center budget allocations for the renewal period. RE finance teams track renewal-driven cost center impacts for multi-year',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent lease agreement from which this renewal option is derived. Links the option to its governing lease contract.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: ASC 842 requires reassessment of renewal options and remeasurement of lease liability posted to a specific ledger. When reasonably_certain status changes, the ledger determines which accounting book r',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Renewal option exercise status drives WALE/WALT calculations and ASC 842 reasonably-certain assessments reported at portfolio asset level. Portfolio managers need renewal option data for hold strategy',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Renewal option terms specify the lease structure for the renewal period (NNN, gross, etc.) which determines CAM, opex responsibilities, and ASC842 reasonably-certain assessment. Domain experts expect ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Renewal options in rent-stabilized/controlled markets must comply with mandatory renewal rights and regulated rent reset mechanisms. Compliance teams track which regulatory obligation governs each ren',
    `abstract_source` STRING COMMENT 'Identifies the operational system of record from which this renewal option data was abstracted — Yardi Voyager, MRI Software, manual entry, or DocuSign CLM. Supports data lineage and audit.. Valid values are `yardi_voyager|mri_software|manual_entry|docusign_clm`',
    `abstracted_by` STRING COMMENT 'Name or identifier of the person or team responsible for abstracting the renewal option terms from the lease document. Used for quality control and accountability in the lease administration process.',
    `abstracted_date` DATE COMMENT 'Date on which the renewal option terms were abstracted from the executed lease document and entered into the system of record. Supports data quality auditing and lease abstract workflow management.',
    `asc842_assessment_date` DATE COMMENT 'Date on which the ASC 842 / IFRS 16 reasonably-certain assessment was last performed or reassessed for this renewal option. Required for lease accounting disclosure and audit trail.',
    `asc842_reasonably_certain` BOOLEAN COMMENT 'Accounting determination under FASB ASC 842 (and IFRS 16) as to whether the lessee is reasonably certain to exercise this renewal option. When True, the renewal term is included in the lease term for right-of-use (ROU) asset and lease liability measurement.',
    `asc842_reassessment_trigger` STRING COMMENT 'Reason for the most recent reassessment of the reasonably-certain determination under ASC 842 / IFRS 16 — significant event, change in circumstances, periodic review, or none (initial assessment). Required for lease accounting audit trail.. Valid values are `significant_event|change_in_circumstances|periodic_review|none`',
    `cam_applicable` BOOLEAN COMMENT 'Indicates whether Common Area Maintenance (CAM) charges are applicable to the tenant during the renewal term. Relevant for NNN and modified gross lease structures.',
    `cpi_base_index` DECIMAL(18,2) COMMENT 'The baseline Consumer Price Index (CPI) value at lease commencement used as the reference point for CPI-linked rent escalation calculations during the renewal term.',
    `cpi_cap_percent` DECIMAL(18,2) COMMENT 'Maximum percentage increase in rent allowed under a CPI-linked reset mechanism for the renewal term, expressed as a percentage. Protects the tenant from excessive rent escalation.',
    `cpi_floor_percent` DECIMAL(18,2) COMMENT 'Minimum percentage increase in rent guaranteed under a CPI-linked reset mechanism for the renewal term. Protects the landlord from rent reduction in deflationary environments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal option record was first created in the data platform. Supports audit trail and data lineage requirements under SOX financial controls.',
    `exercise_date` DATE COMMENT 'Actual date on which the tenant formally exercised the renewal option by delivering written notice to the landlord. Null if the option has not yet been exercised.',
    `exercise_status` STRING COMMENT 'Current lifecycle state of the renewal option indicating whether the tenant has exercised, waived, allowed to expire, or has yet to act on the option. Drives WALT/WALE forecasting and lease expiry pipeline management.. Valid values are `unexercised|exercised|expired|waived|pending_exercise`',
    `fixed_renewal_rent_psf` DECIMAL(18,2) COMMENT 'Pre-agreed base rent rate per square foot (PSF) applicable during the renewal term when the rent reset mechanism is fixed. Null for non-fixed reset mechanisms.',
    `fmv_appraisal_required` BOOLEAN COMMENT 'Indicates whether a formal Fair Market Value (FMV) appraisal is contractually required to determine the renewal rent when the reset mechanism is fair_market_value. True if appraisal is mandated.',
    `fmv_determination_method` STRING COMMENT 'Contractual process for determining Fair Market Value (FMV) rent during the renewal term — single appraiser, dual appraiser (each party appoints one), arbitration, or mutual agreement. Applicable only when rent_reset_mechanism is fair_market_value.. Valid values are `single_appraiser|dual_appraiser|arbitration|mutual_agreement`',
    `free_rent_months` STRING COMMENT 'Number of months of rent abatement (free rent) granted to the tenant at the commencement of the renewal term as a leasing concession. Impacts effective rent calculations and ASC 842 straight-line rent recognition.',
    `no_default_condition` BOOLEAN COMMENT 'Indicates whether the lease requires the tenant to be in good standing (no material default) at the time of notice and at the commencement of the renewal term as a condition of exercising the option.',
    `notes` STRING COMMENT 'Free-text field for capturing additional contractual nuances, special conditions, or qualifications related to this renewal option that are not captured in structured fields. Sourced from Yardi Voyager lease abstract comments.',
    `notice_deadline_date` DATE COMMENT 'The contractual deadline by which the tenant must provide written notice of intent to exercise or waive the renewal option. Failure to meet this date typically results in automatic expiry of the option.',
    `notice_period_days` STRING COMMENT 'Number of calendar days prior to the option deadline by which the tenant must deliver written notice of exercise. Derived from lease abstract and used to trigger automated notice alerts.',
    `option_end_date` DATE COMMENT 'Contractual expiration date of the renewal term if the option is exercised. Represents the last day of the renewed lease period. Critical for WALE (Weighted Average Lease Expiry) pipeline reporting.',
    `option_number` STRING COMMENT 'Sequential ordinal number identifying this renewal option within the lease (e.g., 1st option, 2nd option). Used when a lease contains multiple successive renewal options.',
    `option_reference_code` STRING COMMENT 'Externally-known alphanumeric code or identifier assigned to this renewal option in the source system (Yardi Voyager lease abstract). Used for cross-system reconciliation.',
    `option_start_date` DATE COMMENT 'Contractual commencement date of the renewal term if the option is exercised. Represents the first day of the renewed lease period.',
    `option_term_months` STRING COMMENT 'Duration of the renewal period expressed in whole months. Provides month-level precision for lease term calculations and ASC 842 / IFRS 16 measurement where fractional years are insufficient.',
    `option_term_years` DECIMAL(18,2) COMMENT 'Duration of the renewal period in years as stipulated in the lease agreement. Used in WALT (Weighted Average Lease Term) and WALE (Weighted Average Lease Expiry) calculations.',
    `option_type` STRING COMMENT 'Classification of the contractual option embedded in the lease — renewal (new term), extension (continuation), holdover (month-to-month), or purchase option. Determines accounting treatment under ASC 842 / IFRS 16.. Valid values are `renewal|extension|holdover|purchase_option`',
    `personal_guarantee_required` BOOLEAN COMMENT 'Indicates whether a personal guarantee from the tenant principal is required as a condition of exercising the renewal option. Relevant for credit risk assessment and lease underwriting.',
    `renewal_rent_escalation_rate` DECIMAL(18,2) COMMENT 'Annual rent escalation rate (as a percentage) applicable within the renewal term when escalation type is fixed_percent. Used in Argus Enterprise DCF cash flow modeling for the renewal period.',
    `renewal_rent_escalation_type` STRING COMMENT 'Type of annual rent escalation clause applicable within the renewal term — fixed percentage, CPI-linked, fixed dollar amount per year, or no escalation. Distinct from the initial rent reset mechanism.. Valid values are `fixed_percent|cpi|fixed_amount|none`',
    `rent_reset_mechanism` STRING COMMENT 'Method by which the base rent is determined for the renewal term. Options include fixed (predetermined amount), CPI (Consumer Price Index-linked), fair market value (FMV appraisal), negotiated, or stepped escalation. Drives Argus Enterprise cash flow modeling.. Valid values are `fixed|cpi|fair_market_value|negotiated|stepped`',
    `snda_required` BOOLEAN COMMENT 'Indicates whether a Subordination, Non-Disturbance and Attornment (SNDA) agreement is required from the lender as a condition of the tenant exercising this renewal option.',
    `ti_allowance_psf` DECIMAL(18,2) COMMENT 'Landlord-funded Tenant Improvement (TI) allowance per square foot (PSF) granted to the tenant upon exercise of the renewal option. Represents capital commitment by the landlord for the renewal term.',
    `ti_allowance_total` DECIMAL(18,2) COMMENT 'Total dollar amount of Tenant Improvement (TI) allowance committed by the landlord for the renewal term. Calculated as TI PSF multiplied by the leased area, or specified as a lump sum in the lease abstract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal option record was last modified in the data platform. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `verified_date` DATE COMMENT 'Date on which the abstracted renewal option terms were independently verified against the executed lease document by a second reviewer. Supports dual-control lease abstract quality standards.',
    CONSTRAINT pk_renewal_option PRIMARY KEY(`renewal_option_id`)
) COMMENT 'Defines contractual renewal options embedded within a lease agreement, including option number, notice deadline, option term length, rent reset mechanism (fixed, CPI, fair market value), exercise status (unexercised, exercised, expired, waived), and exercise date. Enables WALT/WALE forecasting and lease expiry pipeline management. Sourced from Yardi Voyager lease abstract data.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique system-generated identifier for the lease termination record. Primary key for the termination data product in the lease domain.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Early termination options are frequently exercised through a termination amendment. The amendment that documents the mutual surrender or early termination agreement should be directly linked to the te',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Early lease terminations triggered by property sales or redevelopment require an appraisal to determine fair market value for settlement calculations, including gain/loss on termination, unamortized T',
    `asset_id` BIGINT COMMENT 'Reference to the property where the terminated lease is located. Enables property-level termination reporting and vacancy tracking.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Lease terminations are directly caused by compliance violations (habitability violations, building code violations triggering constructive eviction, or tenant violations). Linking the termination to t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Termination-related financial impacts (unamortized TI write-off, gain/loss on derecognition, termination fee income) are posted to cost centers for property-level P&L reporting. Controllers need cost ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Termination fee amounts, security deposit settlements, and ASC842 derecognition gain/loss calculations require a validated currency reference. Replaces denormalized termination_fee_currency string for',
    `guaranty_id` BIGINT COMMENT 'Foreign key linking to lease.guaranty. Business justification: Lease termination events trigger guaranty enforcement — when a tenant defaults and the lease terminates, the guaranty is called upon. Linking termination to guaranty enables direct traceability from t',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Lease terminations trigger ASC 842 derecognition journal entries (ROU asset write-off, lease liability settlement, gain/loss recognition). Linking termination to the resulting journal_entry provides a',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent lease agreement being terminated. Links the termination event to the originating lease record.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: ASC 842 lease termination requires derecognition of ROU asset and lease liability posted to a specific ledger. Termination accounting entries differ between GAAP and IFRS 16; ledger assignment on term',
    `legal_entity_id` BIGINT COMMENT 'Reference to the landlord legal entity under which the terminated lease was held. Required for ASC 842 / IFRS 16 financial consolidation and SEC reporting for REITs.',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Lease termination is a direct legal action against the landlord/owner entity. Real estate legal teams send termination notices directly to the owner, process security deposit returns with the owner, a',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Property sales frequently trigger lease terminations (vacant possession requirement). The termination record must reference the triggering sale for closing statement reconciliation, AR settlement, and',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Lease termination returns a specific space to the landlord. Space availability management — knowing when a specific property.space becomes available for re-leasing — requires termination→space. termin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lease terminations must comply with just-cause eviction ordinances, COVID-era moratoriums, and habitability regulations. Linking to the governing regulatory obligation is required for compliance repor',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to finance.reporting_period. Business justification: Lease termination derecognition must be tied to a reporting period for period-close processes and ASC 842 disclosure of terminated leases. RE finance teams use reporting_period to ensure termination g',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: termination has security_deposit_amount, security_deposit_return_amount, and security_deposit_forfeited_amount — denormalized fields that duplicate data from the security_deposit record. Linking termi',
    `sublease_id` BIGINT COMMENT 'Foreign key linking to lease.sublease. Business justification: A lease termination can be triggered by or result in the termination of an associated sublease arrangement. When a head lease terminates, any subleases must also be terminated. Linking termination to ',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant party whose lease is being terminated. Used for downstream AR settlement and security deposit return processing.',
    `unit_id` BIGINT COMMENT 'Reference to the specific leasable unit or space being surrendered upon termination. Drives space availability updates.',
    `ar_settlement_complete` BOOLEAN COMMENT 'Indicates whether all outstanding AR balances related to the terminated lease have been settled, written off, or transferred to collections.',
    `asc842_derecognition_complete` BOOLEAN COMMENT 'Indicates whether the ASC 842 / IFRS 16 derecognition journal entries for the ROU asset and lease liability have been posted in the general ledger upon termination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the termination record was first created in the system. Used for audit trail and data lineage tracking in the Databricks lakehouse silver layer.',
    `cure_period_days` STRING COMMENT 'Number of days granted to the defaulting party to remedy a lease breach before the termination becomes final. Typically specified in the lease agreement.',
    `cure_period_expiry_date` DATE COMMENT 'Date on which the cure period expires. Calculated as notice_date plus cure_period_days. Determines when default-driven termination becomes irrevocable.',
    `docusign_envelope_code` STRING COMMENT 'Unique identifier of the DocuSign CLM envelope containing the executed termination agreement or mutual surrender document. Enables traceability to the signed legal instrument.',
    `effective_date` DATE COMMENT 'The contractually agreed date on which the lease termination becomes legally effective. Used as the derecognition date for ASC 842 / IFRS 16 right-of-use asset and lease liability.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee payable by the tenant (or landlord) as consideration for early or negotiated termination of the lease. Triggers AR invoice generation in Yardi Voyager.',
    `fee_waived` BOOLEAN COMMENT 'Indicates whether the termination fee was waived as part of a negotiated mutual surrender or other agreement. Affects AR settlement processing.',
    `gain_loss_on_termination` DECIMAL(18,2) COMMENT 'Net gain or loss recognized in the income statement upon lease termination, calculated as the difference between the derecognized lease liability and ROU asset, adjusted for termination fees and other consideration.',
    `holdover_rent_rate` DECIMAL(18,2) COMMENT 'Monthly rent rate per square foot (PSF) charged during the holdover period, typically a premium above the base lease rate as stipulated in the lease agreement.',
    `holdover_status_at_termination` BOOLEAN COMMENT 'Indicates whether the tenant was in holdover status (occupying the premises beyond the lease expiry without a new agreement) at the time the termination was processed.',
    `initiating_party` STRING COMMENT 'Identifies which party initiated the termination — landlord, tenant, mutual agreement, or court order. Affects legal rights, fee obligations, and accounting treatment.. Valid values are `landlord|tenant|mutual|court_order`',
    `keys_returned` BOOLEAN COMMENT 'Indicates whether the tenant has returned all physical access credentials (keys, access cards, fobs) for the leased premises upon surrender.',
    `lease_classification` STRING COMMENT 'ASC 842 / IFRS 16 lease classification at the time of termination — finance lease or operating lease. Determines the derecognition accounting entries and disclosure requirements.. Valid values are `finance_lease|operating_lease`',
    `lease_liability_derecognition_amount` DECIMAL(18,2) COMMENT 'Remaining lease liability balance derecognized from the balance sheet upon lease termination per ASC 842 / IFRS 16. Used to generate the derecognition journal entry.',
    `notice_date` DATE COMMENT 'Date on which the termination notice was formally issued by either the landlord or tenant. Triggers the notice period and cure period calculations.',
    `notice_period_days` STRING COMMENT 'Contractually required number of days of advance notice required before the termination effective date, as stipulated in the lease agreement.',
    `original_lease_expiry_date` DATE COMMENT 'The originally scheduled lease expiration date before any termination event. Used to calculate early termination penalties and remaining lease term at termination.',
    `outstanding_ar_balance` DECIMAL(18,2) COMMENT 'Total unpaid accounts receivable balance owed by the tenant at the time of termination, including rent arrears, CAM charges, and other lease obligations. Drives AR settlement workflow.',
    `possession_return_date` DATE COMMENT 'Actual date on which the tenant physically vacated and returned possession of the leased premises to the landlord. May differ from the effective termination date.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the termination (e.g., non-payment, lease breach, relocation, business closure, redevelopment). [ENUM-REF-CANDIDATE: non_payment|lease_breach|relocation|business_closure|redevelopment|condemnation|mutual_agreement|natural_expiry — promote to reference product]',
    `reason_notes` STRING COMMENT 'Free-text narrative providing additional context or explanation for the termination reason, supplementing the standardized reason code.',
    `restoration_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to restore the surrendered premises to the required condition for re-leasing. Informs CAPEX planning and security deposit deduction calculations.',
    `restoration_required` BOOLEAN COMMENT 'Indicates whether the tenant is contractually obligated to restore the premises to original condition upon surrender, as specified in the lease agreement.',
    `rou_asset_derecognition_amount` DECIMAL(18,2) COMMENT 'Net book value of the Right-of-Use (ROU) asset derecognized from the balance sheet upon lease termination per ASC 842 / IFRS 16 accounting requirements.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Total security deposit held by the landlord at the time of termination. Drives security deposit return or forfeiture processing upon lease close-out.',
    `security_deposit_forfeited_amount` DECIMAL(18,2) COMMENT 'Portion of the security deposit retained by the landlord to cover damages, unpaid rent, or other lease obligations not fulfilled by the tenant at termination.',
    `security_deposit_processed` BOOLEAN COMMENT 'Indicates whether the security deposit return or forfeiture has been fully processed and disbursed through Yardi Voyager Accounts Payable.',
    `security_deposit_return_amount` DECIMAL(18,2) COMMENT 'Amount of the security deposit to be returned to the tenant after deductions for damages, unpaid rent, or other charges. Triggers AP disbursement in Yardi Voyager.',
    `space_condition_at_surrender` STRING COMMENT 'Assessed physical condition of the leased premises at the time of tenant surrender. Determines security deposit deductions and informs re-leasing capital expenditure planning.. Valid values are `broom_clean|good_condition|minor_damage|major_damage|requires_remediation`',
    `termination_number` STRING COMMENT 'Externally-known business reference number assigned to the termination event, used in correspondence with tenants, legal counsel, and DocuSign CLM workflows.. Valid values are `^TERM-[0-9]{4}-[0-9]{6}$`',
    `termination_status` STRING COMMENT 'Current lifecycle state of the termination event, from initial notice through final possession return and accounting close-out.. Valid values are `pending|notice_issued|in_cure_period|executed|completed|cancelled`',
    `termination_type` STRING COMMENT 'Classification of the termination event. Drives downstream accounting treatment, ASC 842 derecognition methodology, and AR settlement workflows. [ENUM-REF-CANDIDATE: early_termination|mutual_surrender|lease_expiration|default_termination|holdover_resolution|condemnation — promote to reference product]. Valid values are `early_termination|mutual_surrender|lease_expiration|default_termination|holdover_resolution|condemnation`',
    `unamortized_ti_balance` DECIMAL(18,2) COMMENT 'Remaining unamortized balance of Tenant Improvement (TI) allowances at the time of termination. Triggers accelerated amortization or write-off entries under ASC 842 derecognition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the termination record was last modified. Supports incremental data loading, change data capture, and audit compliance in the Databricks lakehouse.',
    `yardi_termination_ref` STRING COMMENT 'Source system reference identifier from Yardi Voyager for the termination transaction record. Used for reconciliation and audit trail between the lakehouse silver layer and the operational system of record.',
    CONSTRAINT pk_termination PRIMARY KEY(`termination_id`)
) COMMENT 'Records lease termination events — early terminations, mutual surrenders, lease expirations, default-driven terminations, and holdover resolutions. Captures termination type, effective termination date, termination fee, notice date, cure period, holdover status at termination, final possession return date, and space condition at surrender. Triggers downstream AR settlement, security deposit return processing, and ASC 842 derecognition entries. Sourced from Yardi Voyager and DocuSign CLM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`rent_schedule` (
    `rent_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each rent schedule row. Primary key for the rent_schedule data product in the lease domain.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Rent PSF calculations require a validated area unit of measure (BOMA, IPMS, sq ft, sq m). The UOM reference drives rent per square foot/meter computations, lease abstracts, and cross-market portfolio ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Each rent schedule step maps to a GL account (base rent revenue, straight-line rent adjustment, percentage rent) for automated journal entry generation and ASC 842 straight-line rent recognition. Real',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rent schedule steps generate recurring GL postings to specific cost centers for property-level revenue tracking and NOI computation. Finance teams need cost center on rent schedules to automate billin',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Rent schedule amounts (base rent, escalations) must reference a validated currency for multi-currency portfolio cash flow modeling, straight-line rent calculations, and ASC842 lease liability present ',
    `demised_space_id` BIGINT COMMENT 'Foreign key linking to lease.lease_demised_space. Business justification: Rent schedules are tied to specific demised spaces, particularly for multi-space leases where different spaces may have different rent escalation schedules. Linking rent_schedule to lease_demised_spac',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Rent control and rent stabilization laws are jurisdiction-specific and directly govern rent schedules (NYC rent stabilization, California AB 1482, Oregon statewide rent control). Compliance teams requ',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent lease agreement that this rent schedule row belongs to. One lease agreement may have many rent schedule rows representing each rent step period.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Straight-line rent adjustments and lease liability amortization schedules are ledger-specific under ASC 842 vs IFRS 16 vs tax books. RE accounting systems require ledger assignment on rent schedules t',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Rent schedules are posted under a specific legal entity for financial consolidation and intercompany rent allocations. RE portfolio companies with multiple legal entities require entity-level rent sch',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Rent schedule structure (what charges are included in base rent vs. passed through) is directly determined by lease type. NNN vs. gross lease type drives straight-line rent calculations and ASC842 lea',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Rent schedules in rent-controlled jurisdictions must comply with regulatory obligations specifying allowable increase percentages and escalation caps. Compliance teams must verify each rent step again',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: Rent schedule steps covering renewal periods should be linked to the specific renewal_option they represent. renewal_option has fixed_renewal_rent_psf, renewal_rent_escalation_type, and renewal_rent_e',
    `annual_rent_amount` DECIMAL(18,2) COMMENT 'The annualized base rent amount for this rent step period (typically base_rent_amount × 12 for monthly leases). Used in Argus Enterprise cash flow modeling and portfolio-level NOI reporting.',
    `base_rent_amount` DECIMAL(18,2) COMMENT 'The gross monthly base rent amount payable by the tenant for this rent step period, expressed in the lease currency. Excludes CAM charges, operating expenses, and other pass-throughs. Core input for ASC 842 straight-line rent calculation.',
    `cpi_base_value` DECIMAL(18,2) COMMENT 'The baseline CPI index value at the commencement of the lease or the start of the CPI measurement period. Used to calculate the percentage change for CPI-linked rent escalation. Null for non-CPI escalation types.',
    `cpi_cap_rate` DECIMAL(18,2) COMMENT 'The maximum annual CPI escalation rate permitted under the lease terms, expressed as a decimal (e.g., 0.0500 = 5.00% cap). Protects the tenant from excessive CPI-driven rent increases. Null for uncapped CPI or non-CPI escalation types.',
    `cpi_floor_rate` DECIMAL(18,2) COMMENT 'The minimum annual CPI escalation rate guaranteed under the lease terms, expressed as a decimal (e.g., 0.0200 = 2.00% floor). Protects the landlord from zero or negative CPI adjustments. Null for non-CPI escalation types.',
    `cpi_index_name` STRING COMMENT 'The name of the CPI index used for rent escalation when escalation_type is cpi (e.g., US CPI-U All Items, UK RPI). Null for non-CPI escalation types.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rent schedule record was first created in the data platform. Used for audit trail, data lineage, and SOX compliance controls.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate used to calculate the present value of lease payments for this rent step under ASC 842 / IFRS 16. Typically the implicit rate in the lease or the lessees incremental borrowing rate (IBR). Expressed as a decimal annual rate (e.g., 0.0450 = 4.50%).',
    `effective_end_date` DATE COMMENT 'The last date on which this rent step period is in effect. The next steps effective_start_date should immediately follow. Null for open-ended final steps.',
    `effective_start_date` DATE COMMENT 'The date on which this rent step period begins and the corresponding base rent amount becomes billable to the tenant. Aligns with the lease commencement or escalation trigger date.',
    `escalation_amount` DECIMAL(18,2) COMMENT 'The fixed dollar increment added to the prior steps base rent to arrive at this steps base rent. Used when escalation_type is fixed_step with a dollar-denominated increase rather than a percentage. Null for percentage or CPI escalations.',
    `escalation_rate` DECIMAL(18,2) COMMENT 'The escalation rate applied to derive this steps rent from the prior step. Expressed as a decimal percentage (e.g., 0.0300 = 3.00%). Applicable when escalation_type is fixed_step (percentage) or cpi. Null for fixed-dollar steps or percentage-of-sales.',
    `escalation_type` STRING COMMENT 'The mechanism by which rent increases from one step to the next. fixed_step = predetermined dollar or percentage increase; cpi = Consumer Price Index-linked; percentage_of_sales = percentage rent tied to tenant gross sales; market_review = reset to fair market value; none = flat rent with no escalation.. Valid values are `fixed_step|cpi|percentage_of_sales|market_review|none`',
    `free_rent_months` STRING COMMENT 'The number of months of rent abatement granted to the tenant within this step period. Used to quantify the total concession value for ASC 842 straight-line rent amortization and Argus Enterprise cash flow modeling.',
    `grace_period_days` STRING COMMENT 'The number of calendar days after the payment due date before a late fee is assessed. Defined in the lease agreement and used by Yardi Voyager to trigger arrears events and late charge calculations.',
    `is_free_rent_period` BOOLEAN COMMENT 'Indicates whether this rent step period is a free-rent (rent abatement) period during which no base rent is payable by the tenant. True = free-rent period; False = normal rent-paying period. Critical for ASC 842 straight-line rent calculation over the full lease term.',
    `late_fee_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the overdue rent balance to calculate the late payment fee after the grace period expires. Expressed as a decimal (e.g., 0.0500 = 5.00%). Null if a flat late fee amount applies instead.',
    `lease_classification` STRING COMMENT 'The accounting classification of the lease under ASC 842 (lessee perspective) or IFRS 16. operating = operating lease with straight-line expense recognition; finance = finance/capital lease with front-loaded expense recognition. Drives balance sheet treatment and disclosure requirements.. Valid values are `operating|finance`',
    `lease_liability_amount` DECIMAL(18,2) COMMENT 'The present value of remaining lease payments attributable to this rent step period under ASC 842 / IFRS 16. Represents the lessees financial obligation for this step. Required for balance sheet disclosure and debt covenant compliance reporting.',
    `leased_area_sqft` DECIMAL(18,2) COMMENT 'The net leasable area (NLA) in square feet covered by this rent schedule step. Used to derive rent_psf and to validate rent amounts against market benchmarks in CoStar Suite.',
    `notes` STRING COMMENT 'Free-text field for lease administrators to record contextual notes about this rent step, such as negotiated concession rationale, amendment history, or special billing instructions not captured in structured fields.',
    `payment_due_day` STRING COMMENT 'The day of the month on which rent payment is due (e.g., 1 = first of the month). Used to generate AR billing schedules in Yardi Voyager and to calculate late payment penalties.',
    `payment_frequency` STRING COMMENT 'The frequency at which base rent payments are due from the tenant under this rent step. Drives accounts receivable billing cycle in Yardi Voyager and cash flow timing in Argus Enterprise.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `percentage_rent_breakpoint` DECIMAL(18,2) COMMENT 'The gross sales threshold above which percentage rent becomes payable by the tenant. Applicable when escalation_type is percentage_of_sales. Typically calculated as base_rent_amount divided by the percentage rent rate. Null for non-percentage-of-sales leases.',
    `percentage_rent_rate` DECIMAL(18,2) COMMENT 'The percentage of tenant gross sales above the breakpoint that is payable as additional rent. Expressed as a decimal (e.g., 0.0600 = 6.00%). Common in retail leases. Null for non-percentage-of-sales leases.',
    `rent_psf` DECIMAL(18,2) COMMENT 'Base rent expressed on a per-square-foot (PSF) annual basis for this rent step period. Calculated as annual_rent_amount divided by the leased area in square feet. Standard CRE benchmarking metric used in CoStar comparable analysis.',
    `rou_asset_amount` DECIMAL(18,2) COMMENT 'The right-of-use (ROU) asset value attributable to this rent step period under ASC 842 / IFRS 16 lessee accounting. Represents the present value of lease payments allocated to this step. Required for balance sheet disclosure and fixed asset register in SAP S/4HANA.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric identifier for this rent schedule row, as assigned in the source system (e.g., Yardi Voyager or MRI Software). Used for cross-system reconciliation and audit tracing.',
    `schedule_status` STRING COMMENT 'Current lifecycle state of this rent schedule row. active indicates the current billing period; future indicates an upcoming step; expired indicates a past step; superseded indicates replaced by an amendment; cancelled indicates voided.. Valid values are `active|future|expired|superseded|cancelled`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this rent schedule row was sourced. yardi = Yardi Voyager; mri = MRI Software; argus = Argus Enterprise; manual = manually entered in the data platform.. Valid values are `yardi|mri|argus|manual`',
    `source_system_ref` STRING COMMENT 'The native primary key or record identifier for this rent schedule row in the originating source system (e.g., Yardi charge code + period key). Used for data lineage, reconciliation, and incremental load deduplication in the Databricks Silver layer.',
    `step_sequence` STRING COMMENT 'Sequential integer ordering this rent step within the lease agreements full escalation schedule. Step 1 is the initial rent period; subsequent steps represent each escalation event.',
    `straight_line_rent_adjustment` DECIMAL(18,2) COMMENT 'The difference between the straight-line rent amount and the cash base rent amount for this step period. A positive value indicates deferred rent (cash < straight-line); a negative value indicates prepaid rent. Required for ASC 842 deferred rent liability/asset tracking.',
    `straight_line_rent_amount` DECIMAL(18,2) COMMENT 'The ASC 842 / IFRS 16 straight-line rent amount for this step period, representing the equal monthly recognition amount calculated by spreading total lease payments evenly over the lease term. Used for GAAP/IFRS income statement recognition, distinct from cash rent.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rent schedule record was most recently modified in the data platform. Used for incremental processing, change data capture, and audit trail in the Databricks Silver layer.',
    CONSTRAINT pk_rent_schedule PRIMARY KEY(`rent_schedule_id`)
) COMMENT 'Stores the full rent escalation schedule for a lease agreement, including each rent step period, effective start and end dates, base rent amount, rent PSF, escalation type (fixed step, CPI, percentage of sales), escalation rate or index, and free-rent periods. Enables accurate ASC 842 straight-line rent calculation and cash flow forecasting in Argus Enterprise. One agreement may have many rent schedule rows.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`cam_schedule` (
    `cam_schedule_id` BIGINT COMMENT 'Primary key for cam_schedule',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: CAM reconciliation schedules reference tenant_nla_sqft and building_gla_sqft area fields. A formal UOM FK is required for international portfolios (sqft vs sqm) and CAM reconciliation reports submitte',
    `asset_id` BIGINT COMMENT 'Reference to the property at which the leased premises are located. Used to aggregate CAM reconciliations at the building or campus level.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: CAM reconciliation is performed at the building level — building operating expenses are pooled and allocated to tenants. For multi-building assets, building-level CAM pools and reconciliation reports ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: CAM reconciliation entries post to specific GL accounts (CAM recovery income, CAM expense). The gl_account_code on cam_schedule is a denormalized reference; a proper FK enables automated GL posting, a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAM reconciliation charges and credits are posted to cost centers for property operating expense tracking and NOI reporting. Controllers need cost center linkage on CAM reconciliations to route true-u',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: CAM reconciliation amounts (estimated vs. actual, credit/charge) require a validated currency reference for multi-currency property portfolios and accurate tenant billing reconciliation reporting.',
    `demised_space_id` BIGINT COMMENT 'Foreign key linking to lease.lease_demised_space. Business justification: CAM reconciliation is performed at the demised space level — the tenants pro-rata share is based on their NLA relative to building GLA. Linking cam_schedule to lease_demised_space enables direct vali',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the executed lease agreement for which this CAM reconciliation is performed. Links the reconciliation to the governing lease instrument.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: CAM recovery postings differ between GAAP and tax ledgers (e.g., grossup treatment). RE accounting systems require ledger assignment on CAM schedules to route reconciliation entries to the correct acc',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: CAM reconciliations are booked under a specific legal entity for NOI reporting and property tax purposes. RE operators with multiple legal entities per property require entity-level CAM tracking for s',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: CAM reconciliation applicability and methodology (gross-up, exclusions, admin fee) are determined by lease type. NNN leases have full CAM pass-through while gross leases do not. Lease type reference i',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CAM reconciliation is governed by jurisdiction-specific regulatory obligations (state CAM audit rights, gross-up mandates, exclusion rules). Compliance teams must track which regulatory obligations go',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant entity responsible for paying CAM charges under the lease. Supports tenant-level CAM exposure reporting.',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: CAM Tax Reconciliation process: NNN/modified gross lease CAM reconciliations include actual property tax as a recoverable expense. Property accountants must reference the specific tax_assessment for t',
    `actual_cam_gross` DECIMAL(18,2) COMMENT 'Total actual gross operating expenses incurred at the property level for the reconciliation period, before application of the gross-up factor or tenant pro-rata share. Sourced from the property general ledger via Yardi Voyager.',
    `actual_cam_grossed_up` DECIMAL(18,2) COMMENT 'Actual CAM operating expenses after application of the gross-up factor. Represents the normalized total expense pool used as the basis for tenant pro-rata share allocation.',
    `actual_cam_psf` DECIMAL(18,2) COMMENT 'Actual CAM charge allocated to the tenant expressed on a per-square-foot basis (PSF). Calculated as tenant_cam_allocated divided by tenant_nla_sqft. Key metric for portfolio benchmarking and market comparisons.',
    `admin_fee_amount` DECIMAL(18,2) COMMENT 'Calculated dollar amount of the landlords administrative fee included in the tenants CAM allocation for the reconciliation period. Derived from admin_fee_rate applied to the eligible CAM expense pool.',
    `admin_fee_rate` DECIMAL(18,2) COMMENT 'Percentage rate charged by the landlord as an administrative or management fee on top of actual CAM expenses, expressed as a decimal (e.g., 0.15 = 15%). Permitted under many NNN leases. Null if no admin fee applies.',
    `audit_right_exercised` BOOLEAN COMMENT 'Indicates whether the tenant has exercised their contractual right to audit the landlords CAM expense records for the reconciliation period. True if an audit has been formally requested or conducted.',
    `building_gla_sqft` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area of the building in square feet used as the denominator for pro-rata share calculation. May differ from total building area if certain areas are excluded per lease terms.',
    `cam_cap_applied` BOOLEAN COMMENT 'Indicates whether the CAM increase cap was triggered and applied during this reconciliation period. True if the calculated CAM increase exceeded the cap and was limited accordingly.',
    `cam_cap_rate` DECIMAL(18,2) COMMENT 'Maximum annual percentage increase in CAM charges permitted under the lease, expressed as a decimal (e.g., 0.05 = 5% cap). Limits the tenants CAM exposure year-over-year. Null if no cap applies.',
    `cam_cap_savings` DECIMAL(18,2) COMMENT 'Monetary amount by which the tenants CAM charge was reduced due to the application of the CAM cap. Represents the difference between the uncapped allocated amount and the capped amount billed. Zero if cap was not applied.',
    `cam_cap_type` STRING COMMENT 'Specifies whether the CAM increase cap is cumulative (unused cap carries forward to future years) or non-cumulative (cap resets each year). Determines how the cap is applied in multi-year reconciliations.. Valid values are `cumulative|non_cumulative|none`',
    `cam_exclusions_amount` DECIMAL(18,2) COMMENT 'Total dollar value of operating expense line items excluded from the CAM pool per lease terms (e.g., capital expenditures, management fees above a threshold, leasing commissions). Reduces the gross CAM expense pool before tenant allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAM reconciliation record was first created in the Silver Layer lakehouse. Supports audit trail and data lineage requirements under SOX and FASB ASC 842.',
    `credit_or_charge_amount` DECIMAL(18,2) COMMENT 'Net monetary amount due to or from the tenant as a result of the CAM reconciliation. A positive value represents an additional charge invoiced to the tenant; a negative value represents a credit applied to the tenants account. Drives the AR billing or credit memo in Yardi Voyager.',
    `credit_or_charge_type` STRING COMMENT 'Indicates whether the reconciliation outcome results in an additional charge to the tenant, a credit to the tenant, or a zero-balance settlement. Drives downstream AR and billing workflow routing in Yardi Voyager.. Valid values are `additional_charge|credit|zero_balance`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the tenant has formally disputed the CAM reconciliation statement. True if a dispute has been raised; False if no dispute exists. Triggers dispute management workflow.',
    `dispute_reason` STRING COMMENT 'Free-text description of the tenants stated reason for disputing the CAM reconciliation, as recorded by the property manager. Populated only when dispute_flag is True.',
    `dispute_resolved_date` DATE COMMENT 'Date on which the CAM reconciliation dispute was formally resolved between landlord and tenant. Null if no dispute exists or dispute is still open.',
    `estimated_cam_annual` DECIMAL(18,2) COMMENT 'Total estimated CAM charges billed to the tenant over the reconciliation year, based on the budgeted CAM rate established at lease commencement or annual budget cycle. Represents the sum of monthly estimated CAM payments collected from the tenant.',
    `estimated_cam_psf` DECIMAL(18,2) COMMENT 'Estimated annual CAM charge expressed on a per-square-foot basis (PSF). Calculated as estimated_cam_annual divided by tenant_nla_sqft. Used for benchmarking and lease comparison analytics.',
    `grossup_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to actual CAM expenses to normalize costs to a fully occupied building (typically to 90–100% occupancy). Ensures tenants pay their fair share of variable operating costs regardless of actual vacancy. Expressed as a decimal (e.g., 1.05 for a 5% gross-up).',
    `notes` STRING COMMENT 'Free-text field for property manager or asset manager annotations regarding the CAM reconciliation, including explanations of unusual variances, exclusion justifications, or tenant communication summaries.',
    `payment_due_date` DATE COMMENT 'Date by which the additional CAM charge (if any) must be paid by the tenant, or by which the landlord must issue a credit. Drives AR billing and cash flow forecasting.',
    `payment_received_date` DATE COMMENT 'Date on which the tenants additional CAM payment was received and applied in Yardi Voyager. Null if no additional charge was due or payment has not yet been received.',
    `prior_year_estimated_cam` DECIMAL(18,2) COMMENT 'Total estimated CAM charges billed to the tenant in the immediately preceding reconciliation year. Used for year-over-year variance analysis and CAM cap calculations.',
    `reconciliation_number` STRING COMMENT 'Externally visible, human-readable identifier for this CAM reconciliation record as assigned by Yardi Voyager (e.g., CAMREC-2024-00123). Used in tenant correspondence, audit trails, and billing statements.',
    `reconciliation_period_end` DATE COMMENT 'Last day of the CAM reconciliation period. Defines the boundary of actual operating expenses included in the reconciliation calculation.',
    `reconciliation_period_start` DATE COMMENT 'First day of the CAM reconciliation period. May differ from the calendar year start for leases with non-standard fiscal periods or mid-year commencement dates.',
    `reconciliation_sent_date` DATE COMMENT 'Date on which the CAM reconciliation statement was formally delivered to the tenant. Triggers the tenants review and dispute window as defined in the lease.',
    `reconciliation_status` STRING COMMENT 'Current workflow state of the CAM reconciliation record. Tracks progression from initial draft through tenant review, finalization, dispute resolution, and settlement. [ENUM-REF-CANDIDATE: draft|in_review|finalized|disputed|settled|voided — promote to reference product if additional states are required]. Valid values are `draft|in_review|finalized|disputed|settled|voided`',
    `reconciliation_variance` DECIMAL(18,2) COMMENT 'Difference between the tenants allocated actual CAM charge and the estimated CAM billed during the reconciliation period (tenant_cam_allocated minus estimated_cam_annual). A positive value indicates an underpayment (additional charge due from tenant); a negative value indicates an overpayment (credit due to tenant).',
    `reconciliation_year` STRING COMMENT 'The calendar or fiscal year (four-digit integer, e.g., 2024) for which actual CAM operating expenses are being reconciled against estimated billings. Defines the reconciliation period.',
    `tenant_cam_allocated` DECIMAL(18,2) COMMENT 'Actual CAM expense allocated to this specific tenant, calculated as the grossed-up actual CAM multiplied by the tenants pro-rata share. This is the amount the tenant is contractually obligated to pay for the reconciliation period.',
    `tenant_nla_sqft` DECIMAL(18,2) COMMENT 'The tenants Net Leasable Area in square feet as defined in the lease and used for pro-rata share calculation. Captures the measurement basis for CAM allocation at the time of reconciliation.',
    `tenant_prorata_share` DECIMAL(18,2) COMMENT 'The tenants proportionate share of total building CAM expenses, expressed as a decimal fraction (e.g., 0.12500 = 12.5%). Typically calculated as the tenants Net Leasable Area (NLA) divided by the total building NLA or Gross Leasable Area (GLA), as defined in the lease.',
    `tenant_response_due_date` DATE COMMENT 'Deadline by which the tenant must respond to or dispute the CAM reconciliation statement, as stipulated in the lease agreement. Typically 30–90 days after the reconciliation statement is sent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAM reconciliation record was most recently modified in the Silver Layer lakehouse. Tracks the latest state change for audit and change-data-capture purposes.',
    `yardi_cam_batch_code` STRING COMMENT 'Source system batch identifier assigned by Yardi Voyager when the CAM reconciliation was processed or posted. Supports data lineage tracing back to the originating system batch run.',
    CONSTRAINT pk_cam_schedule PRIMARY KEY(`cam_schedule_id`)
) COMMENT 'Annual CAM (Common Area Maintenance) reconciliation record comparing estimated CAM charges billed to tenants against actual operating expenses incurred. Captures reconciliation year, estimated CAM per lease, actual CAM allocated, gross-up factor, tenant pro-rata share, reconciliation variance, credit or additional charge due, and reconciliation status. Sourced from Yardi Voyager CAM module. Critical for NNN and modified gross lease portfolios.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`ti_allowance` (
    `ti_allowance_id` BIGINT COMMENT 'Primary key for ti_allowance',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: TI allowances are frequently revised or introduced via lease amendments (e.g., expansion amendments granting additional TI). amendment has ti_allowance_amount and ti_allowance_psf fields confirming th',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: TI allowance is expressed as ti_amount_psf (per square foot/meter). A formal UOM FK is required for IFRS 16 lease incentive reporting and cross-border TI budget approvals where sqft and sqm benchmarks',
    `asset_id` BIGINT COMMENT 'Reference to the property at which the tenant improvement work is being performed. Enables property-level TI spend reporting.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: TI allowance commitments are tracked against capex budgets for property-level capital expenditure planning and budget variance reporting. Real estate asset managers require TI allowance-to-budget link',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: TI allowances post to specific GL accounts (lease incentive asset, leasehold improvement capex). The gl_account_code on ti_allowance is a denormalized reference; a proper FK enables automated GL posti',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: TI construction projects require compliance assessments (ADA post-construction assessment, environmental assessment, certificate of occupancy inspection). Compliance teams link the TI allowance record',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tenant improvement allowance disbursements are contingent on building permits and certificates of occupancy. Linking TI allowance to the compliance permit enables milestone-based disbursement tracking',
    `construction_budget_id` BIGINT COMMENT 'Foreign key linking to development.construction_budget. Business justification: TI allowance costs are line items within the development construction_budget. Development accountants reconcile TI allowance commitments and disbursements against construction_budget cost codes. This ',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to development.construction_contract. Business justification: TI allowance disbursements are governed by a construction_contract specifying scope, retainage, lien waiver requirements, and payment milestones. Asset managers and lease administrators must link TI f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: TI allowance disbursements are tracked against cost centers for capex budgeting, NOI impact analysis, and ASC 842 lease incentive accounting. The cost_center_code on ti_allowance is a denormalized ref',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: TI allowance budgets, disbursements, and loan structures are denominated in a specific currency. Multi-currency portfolios require validated currency reference for CAPEX tracking, ASC842 lease incenti',
    `demised_space_id` BIGINT COMMENT 'Foreign key linking to lease.lease_demised_space. Business justification: TI allowances are granted for specific demised premises. The ti_allowance table already has property_space_id (cross-domain FK to property.space), but the in-domain link to lease_demised_space provide',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: In ground-up development, TI allowance work is executed as part of the dev_project scope. Development accountants and asset managers track TI commitments against the dev_project budget and delivery sc',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: TI allowance budgets are underwritten at acquisition; actual TI disbursements must be reconciled against deal underwriting assumptions. Investment committees track TI spend vs underwritten amounts as ',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the executed lease agreement to which this TI allowance is attached. Links the TI record to its governing lease instrument.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: TI allowances are treated as lease incentives under ASC 842 (reduces ROU asset) vs IFRS 16 (lease incentive receivable). Ledger assignment on ti_allowance drives which accounting book receives the cap',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: TI disbursements are made by a specific legal entity (landlord entity) and must be tracked for intercompany eliminations and tax reporting. RE portfolio structures with multiple legal entities require',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: TI allowances are capitalized capex tracked against portfolio asset capex_budget and capex_spent_to_date. Portfolio managers need direct TI-to-asset attribution for NAV and return calculations. ti_all',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: TI allowances fund improvements to a specific physical space. Space-level TI tracking, construction scope management, and capex reporting by space require ti_allowance→space. ti_allowance has asset_id',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type carries ti_allowance_benchmark_psf used to validate and approve TI budgets. Real estate asset managers compare actual TI allowances against property-type benchmarks for capital allocatio',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: TI allowances are frequently granted as an incentive tied to a renewal option exercise. The renewal_option table already carries ti_allowance_psf and ti_allowance_total fields, confirming the business',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant entity receiving the TI allowance. Supports tenant-level TI exposure and portfolio analytics.',
    `allowance_status` STRING COMMENT 'Current lifecycle state of the TI allowance record. Tracks progression from negotiation through full disbursement or expiry. [ENUM-REF-CANDIDATE: draft|approved|active|disbursing|completed|expired|cancelled — promote to reference product]',
    `allowance_type` STRING COMMENT 'Classification of the TI allowance structure: landlord_work (landlord constructs improvements), tenant_work (tenant constructs with reimbursement), turnkey (landlord delivers finished space), cash_allowance (cash paid to tenant), loan_structured (TI structured as amortizing loan). [ENUM-REF-CANDIDATE: landlord_work|tenant_work|turnkey|cash_allowance|loan_structured — promote to reference product]. Valid values are `landlord_work|tenant_work|turnkey|cash_allowance|loan_structured`',
    `approved_by` STRING COMMENT 'Name or identifier of the landlord representative (Asset Manager or Property Manager) who approved the TI allowance and construction plans.',
    `approved_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of TI expenditure formally approved by the landlord against submitted tenant work scopes and contractor bids. May be less than or equal to total_budget_amount.',
    `asc842_lease_incentive_flag` BOOLEAN COMMENT 'Indicates whether this TI allowance is classified as a lease incentive under FASB ASC 842, requiring recognition as a reduction to the right-of-use asset on the lessees balance sheet.',
    `construction_completion_date` DATE COMMENT 'Actual or projected date on which TI construction work was or is expected to be substantially completed. Triggers final disbursement eligibility.',
    `construction_start_date` DATE COMMENT 'Actual or scheduled date on which TI construction work commenced in the leased premises. Sourced from Procore project schedule.',
    `coo_received_date` DATE COMMENT 'Date on which the Certificate of Occupancy (COO) was issued by the relevant authority for the TI-improved premises. Often a prerequisite for final TI disbursement.',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar amount actually paid out by the landlord to the tenant or contractor as TI reimbursement. Represents cash outflow against the TI commitment.',
    `disbursement_method` STRING COMMENT 'Method by which TI funds are released to the tenant or contractor: lump_sum (single payment), milestone_based (tied to construction milestones), invoice_reimbursement (per submitted invoices), rent_credit (applied as rent offset), loan_advance (structured as a loan draw). [ENUM-REF-CANDIDATE: lump_sum|milestone_based|invoice_reimbursement|rent_credit|loan_advance — promote to reference product]. Valid values are `lump_sum|milestone_based|invoice_reimbursement|rent_credit|loan_advance`',
    `disbursement_milestone_count` STRING COMMENT 'Total number of disbursement milestones defined in the TI disbursement schedule. Applicable when disbursement_method is milestone_based.',
    `effective_date` DATE COMMENT 'Date on which the TI allowance becomes binding and eligible for disbursement, typically aligned with lease commencement or a negotiated milestone date.',
    `expiry_date` DATE COMMENT 'Date by which the tenant must complete TI work and submit all disbursement requests. Unused allowance after this date is typically forfeited per lease terms.',
    `ifrs16_lease_incentive_flag` BOOLEAN COMMENT 'Indicates whether this TI allowance is classified as a lease incentive under IFRS 16, requiring adjustment to the lease liability measurement for international reporting entities.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of TI-related invoices submitted by the tenant or contractor to the landlord for reimbursement. Sourced from Procore and Yardi AP module.',
    `is_loan_structured` BOOLEAN COMMENT 'Indicates whether the TI allowance is structured as an amortizing loan to the tenant rather than a grant. When true, amortization terms apply and the TI is treated as a lease incentive receivable under ASC 842.',
    `landlord_approval_date` DATE COMMENT 'Date on which the landlord formally approved the tenants TI construction plans and budget. Required before disbursement can commence.',
    `landlord_work_scope` STRING COMMENT 'Narrative description of the improvements to be constructed or funded by the landlord as part of the TI package. Sourced from the lease work letter exhibit.',
    `leasable_area_sqft` DECIMAL(18,2) COMMENT 'Net leasable area of the demised premises in square feet used as the basis for calculating the total TI budget from the PSF rate. Sourced from the lease exhibit.',
    `lien_waiver_received` BOOLEAN COMMENT 'Indicates whether all required lien waivers have been received from contractors and subcontractors prior to the most recent TI disbursement.',
    `lien_waiver_required` BOOLEAN COMMENT 'Indicates whether lien waivers from contractors and subcontractors are required as a condition of each TI disbursement. Standard risk management practice in commercial real estate construction.',
    `loan_amortization_months` STRING COMMENT 'Number of months over which the TI loan is amortized through rent payments or separate repayment schedule. Applicable only when is_loan_structured is true.',
    `loan_commencement_date` DATE COMMENT 'Date on which the TI loan amortization begins. Typically aligned with lease commencement or first disbursement date. Applicable only when is_loan_structured is true.',
    `loan_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the TI loan balance when the allowance is structured as an amortizing loan. Expressed as a decimal (e.g., 0.065 = 6.5%). Applicable only when is_loan_structured is true.',
    `milestones_completed_count` STRING COMMENT 'Number of disbursement milestones that have been completed and verified to date. Used to track TI disbursement progress against the agreed schedule.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or exceptions related to the TI allowance not captured in structured fields. Sourced from Yardi Voyager or Procore project notes.',
    `procore_project_code` STRING COMMENT 'External project identifier in Procore Construction Management system tracking the TI construction project associated with this allowance. Enables cross-system reconciliation of cost data.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TI allowance record was first created in the Silver layer data product. Supports audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this TI allowance record was last modified in the Silver layer data product. Supports change tracking and incremental processing.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Remaining undisbursed TI allowance balance calculated as total_budget_amount minus disbursed_amount. Represents the landlords outstanding TI commitment at any point in time.',
    `tenant_work_scope` STRING COMMENT 'Narrative description of the improvements to be constructed by the tenant using the TI allowance. Defines the boundary between landlord and tenant construction responsibilities.',
    `ti_allowance_number` STRING COMMENT 'Externally-known business identifier for the TI allowance record, used in lease exhibits, Procore project references, and Yardi Voyager TI tracking. Format: TIA- followed by alphanumeric characters.. Valid values are `^TIA-[A-Z0-9]{4,20}$`',
    `ti_amount_psf` DECIMAL(18,2) COMMENT 'TI allowance expressed as a dollar amount per square foot (PSF) of the leased premises. Standard industry metric used for benchmarking TI generosity across deals and markets.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total negotiated TI allowance budget in the lease currency. Represents the maximum landlord commitment for tenant improvement expenditure as agreed in the lease exhibit.',
    `work_letter_reference` STRING COMMENT 'Reference number or exhibit identifier for the work letter attached to the lease that defines the TI scope, budget, and construction obligations. Sourced from DocuSign CLM or lease document management.',
    `yardi_ti_code` STRING COMMENT 'TI allowance tracking code assigned in Yardi Voyager Lease Administration module. Used for reconciliation between the Silver layer and the Yardi source system.',
    CONSTRAINT pk_ti_allowance PRIMARY KEY(`ti_allowance_id`)
) COMMENT 'Tenant Improvement (TI) allowance record tracking the negotiated TI budget, disbursement schedule, approved spend, invoiced amounts, and remaining balance for a lease. Captures TI amount PSF, total TI budget, disbursement milestones, landlord work vs. tenant work scope, TI expiry date, and amortization terms if TI is structured as a loan. Sourced from Yardi Voyager and Procore project cost data.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`clause` (
    `clause_id` BIGINT COMMENT 'Primary key for clause',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: clause.amendment_reference is a denormalized STRING field referencing an amendment. Replacing it with a proper FK amendment_id → lease.amendment.amendment_id normalizes this relationship. Lease clause',
    `debt_facility_id` BIGINT COMMENT 'Foreign key linking to investment.debt_facility. Business justification: SNDA and subordination clauses in leases are executed in favor of specific debt facilities. Lenders require tracking which lease clauses cover which loan facility for covenant compliance and lender co',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent executed lease agreement from which this clause is extracted. Links the clause to its governing lease instrument.',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease clauses (co-tenancy, exclusivity, SNDA, termination options) are specific to lease types — retail NNN leases have different standard clauses than gross office leases. Clause library management a',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lease clauses (exclusivity, co-tenancy, termination options, ADA accommodations) are often required by or must comply with specific regulatory obligations. Lease abstraction teams link clauses to gove',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: Lease clauses of type renewal_option correspond to specific renewal_option records. Linking clause.renewal_option_id → lease.renewal_option.renewal_option_id connects the granular clause text (claus',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Exclusivity clauses and permitted use clauses are directly tied to space use type (e.g., food service exclusivity, retail category restrictions). Lease compliance monitoring and exclusivity enforcemen',
    `sublease_id` BIGINT COMMENT 'Foreign key linking to lease.sublease. Business justification: Sublease agreements contain specific clauses (subletting restrictions, landlord consent requirements, assignment provisions). The clause table is a granular repository of individual lease clauses extr',
    `termination_id` BIGINT COMMENT 'Foreign key linking to lease.termination. Business justification: Lease clauses of type termination_option or early_termination correspond to termination events when exercised. Linking clause.termination_id → lease.termination.termination_id connects the clause ',
    `abstract_source` STRING COMMENT 'Identifies the operational system of record from which this clause was abstracted or sourced (DocuSign CLM, Yardi Voyager lease abstract, MRI Software, manual entry, or other).. Valid values are `docusign_clm|yardi_voyager|mri_software|manual|other`',
    `abstracted_by` STRING COMMENT 'Name or user identifier of the individual or team responsible for abstracting this clause from the source lease document. Supports accountability and data quality review.',
    `abstracted_date` DATE COMMENT 'Date on which this clause was abstracted from the source lease document and entered into the data system. Supports data quality auditing and abstraction workflow tracking.',
    `area_threshold_sqf` DECIMAL(18,2) COMMENT 'Minimum or maximum square footage threshold relevant to this clause (e.g., co-tenancy anchor must occupy at least 50,000 SQF, expansion option covers up to 5,000 SQF of adjacent space). Expressed in square feet (SQF).',
    `asc842_impact_flag` BOOLEAN COMMENT 'Indicates whether this clause has a material impact on ASC 842 lease accounting classification, measurement, or disclosure (e.g., a purchase option, termination option, or variable rent clause that affects the right-of-use asset or lease liability calculation). True = material ASC 842 impact.',
    `clause_status` STRING COMMENT 'Current lifecycle status of the clause indicating whether it is currently in force, has been triggered, waived by mutual agreement, expired by its own terms, or superseded by an amendment.. Valid values are `active|inactive|triggered|waived|expired|superseded`',
    `clause_type` STRING COMMENT 'Categorical classification of the lease clause by its legal and operational function. Common types include exclusivity, co-tenancy, kick-out, ROFO (Right of First Offer), ROFR (Right of First Refusal), force majeure, assignment, subletting, audit rights, termination option, expansion option, and holdover. [ENUM-REF-CANDIDATE: exclusivity|co_tenancy|kick_out|rofo|rofr|force_majeure|assignment|subletting|audit_rights|termination_option|expansion_option|holdover|relocation|demolition|condemnation|insurance|indemnification|estoppel|snda|other — promote to reference product]',
    `co_tenancy_anchor_tenant` STRING COMMENT 'For co-tenancy clauses, the name of the anchor or key tenant whose continued occupancy is a condition of the co-tenancy provision. Vacancy or departure of this tenant may trigger rent abatement or termination rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause record was first created in the silver layer data product. Supports data lineage, audit trail, and ASC 842 / IFRS 16 disclosure tracking.',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier from DocuSign CLM corresponding to the executed lease document containing this clause. Enables direct traceability to the digitally signed source document.',
    `effective_date` DATE COMMENT 'Date on which this clause becomes operative and enforceable. May differ from the lease commencement date if the clause has a deferred or conditional effective date.',
    `exclusivity_use_category` STRING COMMENT 'For exclusivity clauses, specifies the protected retail or business use category that the tenant holds exclusive rights to operate within the property or defined trade area (e.g., Coffee and Espresso Beverages, Full-Service Pharmacy). Null for non-exclusivity clause types.',
    `exercise_date` DATE COMMENT 'Date on which the clause was formally exercised by the entitled party (e.g., tenant exercised ROFR, landlord exercised kick-out). Null if not yet exercised.',
    `exercising_party` STRING COMMENT 'Identifies which party holds the right to exercise or invoke this clause — landlord, tenant, either party, or a specified third party (e.g., guarantor).. Valid values are `landlord|tenant|either|third_party`',
    `expiry_date` DATE COMMENT 'Date on which this clause ceases to be operative by its own terms. Null if the clause runs for the full remaining lease term or is perpetual in nature.',
    `ifrs16_impact_flag` BOOLEAN COMMENT 'Indicates whether this clause has a material impact on IFRS 16 lease accounting classification, measurement, or disclosure. True = material IFRS 16 impact. Supports dual-standard reporting for international portfolios.',
    `is_mutual` BOOLEAN COMMENT 'Indicates whether the rights or obligations under this clause apply mutually to both landlord and tenant (True) or are unilateral in favor of one party (False). Relevant for indemnification, audit rights, and assignment clauses.',
    `is_negotiated` BOOLEAN COMMENT 'Indicates whether this clause was specifically negotiated and customized from the landlords standard lease form (True) or is a standard boilerplate provision (False). Supports risk profiling and lease negotiation benchmarking.',
    `is_triggered` BOOLEAN COMMENT 'Indicates whether the clause has been triggered or activated based on a qualifying event (e.g., co-tenancy failure, kick-out threshold breach, force majeure event). True = currently triggered; False = not triggered.',
    `lease_section_number` STRING COMMENT 'Section, article, or exhibit number within the lease document where this clause is located (e.g., Article 14, Section 22.3, Exhibit D). Enables direct cross-reference to the source legal document.',
    `monetary_threshold` DECIMAL(18,2) COMMENT 'Dollar amount threshold that governs the activation or measurement of this clause (e.g., minimum sales volume for co-tenancy, kick-out sales threshold PSF, TI allowance cap for assignment). Expressed in the lease currency.',
    `monetary_threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the monetary threshold value (e.g., USD, CAD, GBP). Supports multi-currency portfolio management.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional commentary, legal counsel observations, or operational notes regarding this clause that are not captured in structured fields. Used by property managers (PM) and asset managers (AM) for context.',
    `notice_deadline_date` DATE COMMENT 'Calculated or contractually specified deadline by which notice must be delivered to exercise or respond to this clause. Supports proactive portfolio-wide deadline monitoring.',
    `notice_period_days` STRING COMMENT 'Number of days advance written notice required to exercise, invoke, or respond to this clause. Critical for kick-out, ROFO, ROFR, and termination option clauses.',
    `priority_order` STRING COMMENT 'Numeric ordering of this clause relative to other clauses of the same type on the same lease, used when multiple clauses of the same type exist (e.g., multiple ROFR provisions with different priority rankings). Lower number = higher priority.',
    `reference_code` STRING COMMENT 'Externally-known alphanumeric code or section reference identifying this clause within the lease document (e.g., Section 12.4, Exhibit B-3). Sourced from DocuSign CLM or Yardi Voyager lease abstract.',
    `rent_abatement_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in base rent applicable when this clause is triggered (e.g., co-tenancy failure entitles tenant to 50% rent abatement). Expressed as a percentage of base rent.',
    `risk_rating` STRING COMMENT 'Portfolio risk classification assigned to this clause based on its potential financial or operational impact if triggered. Used by asset managers (AM) for portfolio-wide clause risk screening and prioritization.. Valid values are `low|medium|high|critical`',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount payable as a termination fee or penalty if this clause is exercised (e.g., kick-out fee, early termination payment). Expressed in the lease currency.',
    `text_summary` STRING COMMENT 'Abstracted plain-language summary of the clauses key provisions, obligations, and rights. Captured during lease abstraction from DocuSign CLM or Yardi Voyager. Not the full legal text but sufficient for portfolio screening and risk management.',
    `title` STRING COMMENT 'Human-readable short title or heading of the clause as it appears in the lease document (e.g., Tenant Exclusivity Provision, Co-Tenancy Requirement). Used for portfolio-wide clause screening and reporting.',
    `trigger_date` DATE COMMENT 'Date on which the clause was triggered or activated by a qualifying event. Null if the clause has not been triggered. Used for risk tracking and legal action timelines.',
    `trigger_description` STRING COMMENT 'Plain-language description of the event or condition that triggered or could trigger this clause (e.g., Anchor tenant vacancy exceeding 90 days, Sales threshold below $X PSF for two consecutive quarters).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clause record was last modified in the silver layer data product. Supports incremental data processing, change detection, and audit trail requirements.',
    `verified_by` STRING COMMENT 'Name or user identifier of the individual who verified the accuracy of the abstracted clause data against the original lease document. Supports SOX compliance and audit trail requirements.',
    `verified_date` DATE COMMENT 'Date on which the abstracted clause data was reviewed and verified against the original executed lease document by a qualified reviewer. Null if not yet verified.',
    `yardi_clause_code` STRING COMMENT 'Native clause identifier assigned by Yardi Voyager lease abstract module. Supports reconciliation and lineage tracing between the silver layer data product and the Yardi Voyager system of record.',
    CONSTRAINT pk_clause PRIMARY KEY(`clause_id`)
) COMMENT 'Granular repository of individual lease clauses and special provisions extracted from executed agreements. Captures clause type (exclusivity, co-tenancy, kick-out, ROFO, ROFR, force majeure, assignment, subletting, audit rights), clause text summary, effective date, expiry date, and whether the clause is currently triggered or active. Enables portfolio-wide clause screening and risk management. Sourced from DocuSign CLM and Yardi Voyager lease abstract.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`demised_space` (
    `demised_space_id` BIGINT COMMENT 'Primary key for demised_space',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Demised space definitions are modified by amendments — expansion options exercised, contraction events, remeasurement of GLA/NLA. Linking lease_demised_space to the amendment that created or modified ',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Demised space area measurements (GLA, NLA, usable) require a validated UOM reference (BOMA, IPMS, sq ft, sq m) for rent PSF calculations, pro-rata share determination, and cross-market lease compariso',
    `asset_id` BIGINT COMMENT 'Reference to the property (building or land parcel) within which this demised space is located. Bridges the lease domain to the property domain.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Demised spaces require certificates of occupancy and occupancy permits before tenant possession. Linking the demised space to its compliance permit is required for possession date validation, lease co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual demised spaces are tracked at cost center level for space-level NOI and CAM pool allocation. RE property managers assign cost centers to demised spaces to enable space-level revenue and exp',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Demised spaces created through ground-up development or major renovation must reference the originating dev_project for pre-leasing pipeline management, COO-contingent lease commencement tracking, and',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent lease agreement that governs this demised space. A single lease may cover multiple demised spaces.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Ground leases demise a specific legal parcel. Linking lease_demised_space to parcel supports ground lease administration, title insurance coordination, lender consent processes, and legal description ',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Demised space IS a physical space record. Leasing teams track which property.space records are under lease for vacancy/availability reporting, space absorption analysis, and lease abstract systems. su',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Demised space is classified by property type for CAM applicability rules, TI allowance benchmarking, and space-level portfolio reporting. Real estate lease abstractors classify each demised space by p',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Each demised space has a lease structure type (NNN, gross, modified gross) that determines CAM applicability, TI allowance eligibility, and rent escalation methodology at the space level for multi-spa',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: A renewal option can apply to specific demised spaces (e.g., a tenant may have the right to renew only a portion of their premises). Linking lease_demised_space to renewal_option enables space-level r',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Demised space use type (office, retail, industrial, medical) drives CAM inclusion rules, TI allowance benchmarks, zoning compliance, and permitted use verification. Domain experts universally expect s',
    `unit_id` BIGINT COMMENT 'Reference to the physical unit or space record in the property master (Yardi Voyager unit master). Represents the lowest-level physical space entity.',
    `asc842_lease_classification` STRING COMMENT 'Lease classification for this demised space under FASB ASC 842 — either Operating Lease or Finance Lease. Determines the accounting treatment for Right-of-Use (ROU) asset and lease liability recognition.. Valid values are `operating|finance`',
    `base_rent_annual` DECIMAL(18,2) COMMENT 'Total annual base rent amount for this demised space in the lease currency. Derived from base rent PSF multiplied by GLA but stored as a contractual figure from the lease abstract.',
    `base_rent_psf` DECIMAL(18,2) COMMENT 'Annual base rent rate per square foot (PSF) for this demised space as stipulated in the lease agreement. Primary rent metric used for PSF benchmarking, market comparisons, and NOI analysis.',
    `cam_applicable` BOOLEAN COMMENT 'Indicates whether Common Area Maintenance (CAM) charges are applicable to this demised space. Drives CAM reconciliation processing in Yardi Voyager.',
    `cam_estimate_psf` DECIMAL(18,2) COMMENT 'Estimated annual Common Area Maintenance (CAM) charge per square foot for this demised space. Used for tenant billing estimates and year-end CAM reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this demised space record was first created in the Silver layer data product. Audit trail for data governance and lineage.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Incremental borrowing rate (IBR) or implicit rate used to discount future lease payments for ROU asset and lease liability measurement under ASC 842 / IFRS 16 for this demised space.',
    `effective_date` DATE COMMENT 'Date from which this demised space record is effective, supporting amendment and modification tracking. For the original lease, equals the lease commencement date; for amendments, reflects the amendment effective date.',
    `expansion_option` BOOLEAN COMMENT 'Indicates whether the lease agreement grants the tenant an expansion option for additional space adjacent to or within the same building as this demised space.',
    `free_rent_months` STRING COMMENT 'Number of months of free rent (rent abatement) granted to the tenant for this demised space at lease commencement or as a lease incentive. Impacts straight-line rent calculation under ASC 842.',
    `gla_sqf` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the demised space measured in square feet (SQF) as defined in the lease agreement. GLA is the standard measurement basis for rent calculation in commercial leases.',
    `gla_sqm` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the demised space measured in square meters (SQM). Used for international reporting, IFRS 16 disclosures, and cross-border portfolio analytics.',
    `is_primary_space` BOOLEAN COMMENT 'Indicates whether this demised space is the primary (anchor) space under the lease agreement. Relevant for multi-space leases where one space is designated as the primary premises.',
    `lease_commencement_date` DATE COMMENT 'Date on which the tenants lease term for this specific demised space commences. May differ from the master lease commencement date for multi-space leases with staggered delivery.',
    `lease_expiry_date` DATE COMMENT 'Date on which the tenants lease term for this specific demised space expires. Used in WALT/WALE calculations and lease expiry schedule reporting.',
    `lease_liability_value` DECIMAL(18,2) COMMENT 'Initial lease liability recognized for this demised space at lease commencement under ASC 842 / IFRS 16. Represents the present value of future lease payments discounted at the incremental borrowing rate.',
    `load_factor` DECIMAL(18,2) COMMENT 'Ratio of Gross Leasable Area (GLA) to Usable Area, representing the tenants proportionate share of common areas added to their usable space. Calculated as GLA / Usable Area. Typical range 1.00–1.25 for office buildings.',
    `nla_sqf` DECIMAL(18,2) COMMENT 'Net Leasable Area (NLA) of the demised space in square feet, excluding common areas, structural elements, and mechanical spaces. Used for NLA-based rent calculations and PSF analysis.',
    `possession_date` DATE COMMENT 'Date on which the landlord delivered physical possession of the demised space to the tenant. Triggers the lease commencement measurement period under ASC 842 / IFRS 16.',
    `pro_rata_share` DECIMAL(18,2) COMMENT 'Tenants proportionate share of the buildings total rentable area, expressed as a decimal (e.g., 0.0523 = 5.23%). Used to allocate Common Area Maintenance (CAM) charges, operating expenses, and real estate taxes under NNN and modified gross leases.',
    `rent_commencement_date` DATE COMMENT 'Date on which the tenants obligation to pay rent for this demised space begins. May be later than the lease commencement date due to free rent or fit-out periods.',
    `rent_currency` STRING COMMENT 'ISO 4217 three-letter currency code for all rent and financial amounts associated with this demised space (e.g., USD, GBP, EUR, AUD).. Valid values are `^[A-Z]{3}$`',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'Annual rent escalation rate expressed as a decimal (e.g., 0.03 = 3%) applicable to this demised space. Used when rent_escalation_type is fixed_percent or CPI-based.',
    `rent_escalation_type` STRING COMMENT 'Method by which base rent escalates over the lease term for this demised space. Drives straight-line rent calculation and future cash flow modeling in Argus Enterprise.. Valid values are `fixed_percent|cpi|fixed_amount|market_review|stepped|none`',
    `right_of_first_refusal` BOOLEAN COMMENT 'Indicates whether the tenant holds a Right of First Refusal (ROFR) on adjacent or specified spaces within the property under this lease.',
    `rou_asset_value` DECIMAL(18,2) COMMENT 'Initial Right-of-Use (ROU) asset value recognized for this demised space at lease commencement under ASC 842 / IFRS 16. Represents the present value of future lease payments plus initial direct costs and prepaid rent.',
    `space_abstract_notes` STRING COMMENT 'Free-text notes from the lease abstract specific to this demised space, including special provisions, exclusions, permitted use restrictions, or physical description details not captured in structured fields.',
    `space_configuration` STRING COMMENT 'Physical configuration or fit-out state of the demised space at lease commencement. Drives Tenant Improvement (TI) allowance requirements and construction scope.. Valid values are `open_plan|private_offices|mixed|shell|fitted_out|cold_dark_shell`',
    `space_reference_code` STRING COMMENT 'Externally-known alphanumeric code identifying this demised space as assigned in Yardi Voyager (e.g., suite number, unit number, or space code). Used in lease documents and tenant correspondence.',
    `space_status` STRING COMMENT 'Current lifecycle status of the demised space within the lease. Indicates whether the space is actively occupied, vacant, under renovation, or has been surrendered.. Valid values are `active|inactive|vacant|under_renovation|surrendered|pending`',
    `ti_allowance_psf` DECIMAL(18,2) COMMENT 'Landlord-funded Tenant Improvement (TI) allowance per square foot granted for this demised space. Represents the landlords contribution toward tenant fit-out costs.',
    `ti_allowance_total` DECIMAL(18,2) COMMENT 'Total Tenant Improvement (TI) allowance amount in lease currency for this demised space. Equals TI PSF multiplied by GLA. Tracked for amortization under ASC 842 and unamortized balance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this demised space record was last updated in the Silver layer data product. Supports change detection, incremental processing, and audit compliance.',
    `usable_area_sqf` DECIMAL(18,2) COMMENT 'Usable area of the demised space in square feet as defined by BOMA standards — the area exclusively occupied by the tenant, excluding shared corridors and common areas. Basis for load factor calculation.',
    `yardi_space_ref` STRING COMMENT 'Source system identifier for this demised space record in Yardi Voyager (unit/space master). Used for data lineage, reconciliation, and integration with the system of record.',
    CONSTRAINT pk_demised_space PRIMARY KEY(`demised_space_id`)
) COMMENT 'Defines the specific demised premises (suite, floor, unit, or land parcel) covered by a lease agreement. Stores suite number, floor, GLA, NLA, usable area SQF/SQM, space type (office, retail, industrial, residential unit, storage), load factor, and space configuration. A single lease may cover multiple spaces (e.g., multi-floor tenants). Sourced from Yardi Voyager unit/space master. Bridges the lease domain to the property domain.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`payment` (
    `payment_id` BIGINT COMMENT 'Primary key for payment',
    `ar_invoice_id` BIGINT COMMENT 'Reference to the AR invoice or charge batch in the finance domain that this payment satisfies or partially satisfies. Links the tenant-facing collection record to the enterprise billing record.',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with the lease for which this payment was received. Supports property-level cash collection reporting.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Lease payments are deposited into specific property bank accounts. Linking payment to bank_account enables bank reconciliation, lockbox matching, and cash management reporting. The bank_account_last4 ',
    `billable_charge_id` BIGINT COMMENT 'Foreign key linking to maintenance.billable_charge. Business justification: Tenant payments for maintenance billable charges (tenant-billable work orders, CAM charges) must be traceable to the originating billable_charge for AR reconciliation and dispute resolution. Payment a',
    `cam_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.cam_schedule. Business justification: CAM reconciliation payments (credit_or_charge_amount from cam_schedule) are a distinct charge type in payment. Linking payment.cam_reconciliation_id → lease.cam_schedule.lease_cam_reconciliation_id id',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Each lease payment charge type (base rent, CAM, late fee) maps to a GL account for AR posting and revenue recognition. The gl_account_code on payment is a denormalized reference; a proper FK enables a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lease payments are allocated to cost centers for property-level cash flow tracking, AR aging by cost center, and budget vs. actual revenue reporting. The cost_center_code on payment is a denormalized ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Lease payment amounts (due, paid, applied, outstanding) require a validated currency reference for multi-currency AR reporting, delinquency tracking, and FX translation in consolidated financial state',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each rent payment generates a cash receipt journal entry. Direct FK from payment to journal_entry supports cash receipt reconciliation, delinquency reporting, and SOX audit trail requirements standard',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the executed lease agreement against which this payment is applied. Core FK linking the payment to its governing lease contract.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Rent payments are posted to a specific ledger in multi-book RE accounting systems (GAAP, IFRS, tax). Ledger assignment on payment records is required for period-close reconciliation and to ensure cash',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Rent receipts are recorded under a specific legal entity for financial consolidation and tax reporting. RE operators with multiple legal entities per property require entity-level payment tracking for',
    `percentage_rent_id` BIGINT COMMENT 'Foreign key linking to lease.percentage_rent. Business justification: Percentage rent (overage rent) obligations generate distinct payment records. Linking payment.percentage_rent_id → lease.percentage_rent.percentage_rent_id connects percentage rent payments to the cal',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: Linking payment to rent_schedule allows precise tracking of which rent escalation step a payment applies to. payment.applied_period_start_date and applied_period_end_date correspond to rent_schedule s',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: Security deposit receipts and returns are recorded as payments with a specific charge_type. Linking payment.security_deposit_id → lease.security_deposit.lease_security_deposit_id connects deposit-rela',
    `sublease_id` BIGINT COMMENT 'Foreign key linking to lease.sublease. Business justification: Sublease rent payments received from subtenants are distinct payment records that must be traceable to the specific sublease arrangement. Linking payment to sublease enables tracking of sublease incom',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant (party) who made this payment. Enables tenant-level payment performance analysis and delinquency tracking.',
    `ti_allowance_id` BIGINT COMMENT 'Foreign key linking to lease.ti_allowance. Business justification: TI allowance disbursements are payments made by the landlord to the tenant (or directly to contractors). These are tracked as payment records with charge_type indicating TI disbursement. Linking payme',
    `unit_id` BIGINT COMMENT 'Reference to the specific leasable unit (suite, floor, or space) within the property to which this payment applies.',
    `amount_applied` DECIMAL(18,2) COMMENT 'The portion of amount_paid that has been formally applied against the outstanding AR invoice balance. May differ from amount_paid if a portion is held unapplied (e.g., prepayment or overpayment held in suspense).',
    `amount_due` DECIMAL(18,2) COMMENT 'The gross amount billed to the tenant for the charge type and applied period as stated on the AR invoice. Represents the contractual obligation before any payments, credits, or adjustments are applied.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The actual monetary amount received from the tenant in this payment transaction. May be less than amount_due (partial payment) or equal to it (full payment). Core monetary fact for cash collection reporting.',
    `applied_period_end_date` DATE COMMENT 'The last day of the billing period to which this payment is applied (e.g., 2024-01-31 for January rent). Together with applied_period_start_date defines the exact coverage window for the payment.',
    `applied_period_start_date` DATE COMMENT 'The first day of the billing period to which this payment is applied (e.g., 2024-01-01 for January rent). Used for period-level cash collection analysis and ASC 842 / IFRS 16 lease liability amortization reconciliation.',
    `charge_type` STRING COMMENT 'Classification of the revenue or charge category this payment satisfies. base_rent = contractual base rent; cam = Common Area Maintenance (CAM) charges; security_deposit = security deposit receipt; late_fee = penalty for late payment; ti_reimbursement = Tenant Improvement (TI) cost reimbursement; percentage_rent = overage rent based on tenant sales. [ENUM-REF-CANDIDATE: base_rent|cam|security_deposit|late_fee|ti_reimbursement|percentage_rent|parking|utility_reimbursement|insurance_reimbursement|tax_reimbursement|holdover_rent|termination_fee — promote to reference product]. Valid values are `base_rent|cam|security_deposit|late_fee|ti_reimbursement|percentage_rent`',
    `check_number` STRING COMMENT 'The check number printed on the tenants paper check, as captured during lockbox or manual receipt processing. Populated only when payment_method is check. Used for bank reconciliation and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the Silver layer data product. Represents the audit trail creation event for data lineage and SOX compliance.',
    `days_past_due` STRING COMMENT 'The number of calendar days between the due_date and the payment_date. A positive value indicates late payment; zero or negative indicates on-time or early payment. Drives delinquency classification, late fee triggers, and tenant credit scoring.',
    `deposit_date` DATE COMMENT 'The date on which the payment funds were deposited into the propertys bank account. May differ from payment_date (receipt date) for checks held before deposit or lockbox processing delays. Used for bank reconciliation.',
    `due_date` DATE COMMENT 'The contractual date by which the tenant was required to remit payment per the lease agreement. Used to calculate days-past-due, trigger late fee assessment, and drive delinquency reporting.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the functional reporting currency at the time of receipt. Applicable for multi-currency portfolios. 1.0 for payments already in the functional currency.',
    `is_delinquent` BOOLEAN COMMENT 'Indicates whether this payment was received after the contractual due date (True) or on time (False). Set to True when days_past_due > 0 at the time of receipt. Used for tenant delinquency reporting, arrears event triggering, and portfolio risk dashboards.',
    `is_partial_payment` BOOLEAN COMMENT 'Indicates whether the amount_paid is less than the amount_due for the associated charge (True = partial payment; False = full payment). Partial payments trigger outstanding_balance tracking and may initiate default cure period monitoring.',
    `late_fee_assessed` DECIMAL(18,2) COMMENT 'The monetary amount of the late fee charged to the tenant as a result of this payment being received after the due date. Calculated per the late fee schedule in the lease agreement. Zero if payment was on time.',
    `late_fee_waived` BOOLEAN COMMENT 'Indicates whether the assessed late fee was waived by the property manager or asset manager (True = waived; False = not waived). Supports exception tracking and tenant relationship management reporting.',
    `notes` STRING COMMENT 'Free-text notes entered by the property manager or AR administrator regarding this payment (e.g., tenant dispute context, special arrangement details, partial payment agreement). Supports operational context for collections staff.',
    `nsf_flag` BOOLEAN COMMENT 'Indicates whether this payment was returned by the bank due to Non-Sufficient Funds (NSF) or a similar bank return reason (True = NSF/returned; False = cleared). NSF events trigger reversal of the posted payment and may initiate default proceedings.',
    `nsf_return_date` DATE COMMENT 'The date on which the bank returned the payment due to NSF or other bank return reason. Populated only when nsf_flag is True. Used to calculate the effective delinquency period and trigger corrective AR actions.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on the charge after this payment is applied (amount_due minus amount_applied). A non-zero value indicates a partial payment or delinquency. Used for AR aging and tenant arrears reporting.',
    `payment_date` DATE COMMENT 'The actual calendar date on which the payment was received from the tenant (receipt date). This is the principal real-world business event date used for delinquency calculation, aging analysis, and cash flow reporting. Distinct from the posting date.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used by the tenant to remit payment. ach = Automated Clearing House electronic transfer; wire = bank wire transfer; check = paper check; credit_card = card payment; lockbox = bank lockbox processing; cash = physical currency.. Valid values are `ach|wire|check|credit_card|lockbox|cash`',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment record within the AR workflow. posted = applied to ledger; pending = received but not yet applied; reversed = corrected/reversed entry; voided = cancelled before posting; returned = NSF or bank return; on_hold = held pending dispute resolution.. Valid values are `posted|pending|reversed|voided|returned|on_hold`',
    `posting_date` DATE COMMENT 'The accounting date on which the payment was posted to the General Ledger (GL) period. May differ from payment_date due to cut-off timing, bank processing delays, or period-end adjustments. Used for period-close reconciliation.',
    `reference_number` STRING COMMENT 'Externally visible, human-readable payment reference number assigned by Yardi Voyager AR at the time of receipt posting. Used for tenant remittance matching, bank reconciliation, and audit trail. Corresponds to the Yardi receipt number.',
    `remittance_reference` STRING COMMENT 'The tenant-provided reference or memo field included with the payment remittance (e.g., wire transfer memo, ACH addenda, check memo line). Used to match incoming payments to open AR charges when the reference number is not automatically matched.',
    `reversal_date` DATE COMMENT 'The date on which the payment reversal or void was processed in Yardi Voyager AR. Populated only when payment_status is reversed or voided. Used for AR aging recalculation and delinquency reassessment.',
    `reversal_reason` STRING COMMENT 'The reason code explaining why a posted payment was reversed or voided. Populated only when payment_status is reversed or voided. Supports audit trail and exception reporting.. Valid values are `nsf|data_entry_error|duplicate_payment|tenant_dispute|bank_return|void`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of amount_paid that has been received but not yet applied to a specific charge or invoice. Held in a suspense or prepayment account until the property manager allocates it. Relevant for tenant overpayment and prepaid rent scenarios.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified in the Silver layer data product (e.g., status change, reversal, correction). Used for incremental data pipeline processing and audit trail.',
    `yardi_batch_number` STRING COMMENT 'The batch or deposit batch number in Yardi Voyager under which this payment was grouped for posting. Supports batch-level reconciliation between Yardi AR and bank deposit records.',
    `yardi_receipt_code` STRING COMMENT 'The native receipt or transaction identifier assigned by Yardi Voyager AR at the time of payment posting. Used for source system traceability, reconciliation between the Silver layer and the operational system, and audit trail.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Records individual rent and charge payments received from tenants against a lease agreement. Captures payment date, payment type (base rent, CAM, TI reimbursement, security deposit, late fee, percentage rent), payment amount, payment method, applied period, outstanding balance, and delinquency flag. Sourced from Yardi Voyager Accounts Receivable module. This is the lease-domain AR transaction record tracking tenant payment performance; the finance domain GL owns the double-entry journal posting. Delineation: this product owns the tenant-facing billing/collection view; finance domain owns the enterprise accounting view.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`security_deposit` (
    `security_deposit_id` BIGINT COMMENT 'Primary key for security_deposit',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Security deposit amounts and terms are frequently revised by lease amendments (e.g., deposit reduction schedules triggered by amendment milestones, LOC substitution for cash deposit). Linking security',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with the lease for which the security deposit is held. Used for portfolio-level deposit reporting and reconciliation.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Security deposits are held in specific segregated bank accounts per state regulatory requirements. Linking security_deposit to bank_account enables bank reconciliation, regulatory compliance reporting',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Security deposit liability posts to a specific GL account for balance sheet presentation. The gl_account_code on security_deposit is a denormalized reference; a proper FK enables automated GL posting ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Security deposit liability is tracked by cost center for property-level balance sheet reporting and cash flow management. Real estate controllers need cost center linkage to produce property-level sec',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Security deposit amounts (required, held, applied, return) must reference a validated currency for multi-currency portfolios, interest accrual calculations, and regulatory compliance with deposit retu',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Security deposit laws are highly jurisdiction-specific (mandatory interest accrual, maximum deposit amounts, return deadlines, permissible deduction categories). Compliance teams require a direct juri',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Security deposit liability accounting differs between GAAP and IFRS (interest accrual treatment). Ledger assignment on security_deposit drives which accounting book records the deposit liability and i',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Security deposits are held as liabilities by a specific legal entity; required for balance sheet presentation under GAAP/IFRS and regulatory compliance (state security deposit laws). RE accountants ex',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent lease agreement for which this security deposit is held. Links the deposit record to its governing lease contract.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Security deposit handling is heavily regulated: return timelines, interest accrual requirements, and allowable deductions vary by jurisdiction. Linking to the governing regulatory obligation enables c',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant entity obligated to provide and maintain the security deposit under the lease agreement.',
    `tertiary_security_lease_lease_agreement_id` BIGINT COMMENT 'FK to lease.agreement',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'The cumulative interest accrued on the cash security deposit balance to date. Must be returned to the tenant along with the principal deposit amount where legally required.',
    `applied_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of the security deposit that has been applied against outstanding tenant obligations such as unpaid rent, damages, or lease-end charges. Reduces the returnable balance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the security deposit record was first created in the system. Supports audit trail requirements and data lineage tracking in the Silver Layer lakehouse.',
    `credit_risk_rating` STRING COMMENT 'Credit risk classification of the tenant at the time the security deposit was established. Influences the required deposit amount and instrument type. Used for portfolio-level credit exposure reporting.. Valid values are `investment_grade|non_investment_grade|speculative|unrated`',
    `deduction_notes` STRING COMMENT 'Free-text narrative describing the specific basis for deductions applied against the security deposit. Supports itemized deduction statements required by landlord-tenant law and dispute resolution.',
    `deduction_reason` STRING COMMENT 'Categorized reason code for any deduction applied against the security deposit. Required for itemized deduction statements provided to tenants and for audit trail compliance. [ENUM-REF-CANDIDATE: unpaid_rent|property_damage|cleaning_charges|lease_break_fee|outstanding_cam|other — promote to reference product if additional categories are needed]. Valid values are `unpaid_rent|property_damage|cleaning_charges|lease_break_fee|outstanding_cam|other`',
    `deposit_months_rent` DECIMAL(18,2) COMMENT 'The number of months of base rent that the required security deposit represents (e.g., 2.00 = two months rent). A standard metric used in lease underwriting and tenant credit risk assessment.',
    `deposit_received_date` DATE COMMENT 'The date on which the initial security deposit was received from the tenant. Used for interest accrual calculations and compliance with jurisdictional deposit holding requirements.',
    `deposit_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for the security deposit record as assigned in Yardi Voyager or the governing lease document. Used for cross-system reconciliation and tenant correspondence.',
    `deposit_return_date` DATE COMMENT 'The actual or scheduled date on which the security deposit (or net balance) was or is to be returned to the tenant following lease termination. Subject to jurisdictional statutory return deadlines.',
    `deposit_status` STRING COMMENT 'Current lifecycle status of the security deposit. Tracks whether the deposit is actively held, partially or fully applied against tenant obligations, returned to the tenant, or forfeited upon lease termination.. Valid values are `active|partially_applied|fully_applied|returned|forfeited|pending_return`',
    `deposit_type` STRING COMMENT 'Classification of the security deposit instrument. Determines the mechanism by which the landlord can draw on the deposit in the event of tenant default or lease-end obligations.. Valid values are `cash|letter_of_credit|surety_bond|escrow|guarantee`',
    `docusign_envelope_code` STRING COMMENT 'The DocuSign envelope identifier for the executed lease or deposit agreement document that governs the security deposit terms. Enables traceability to the signed legal instrument.',
    `held_amount` DECIMAL(18,2) COMMENT 'The actual amount of security deposit currently held by the landlord. May differ from the required amount due to partial receipt, reduction schedules, or applied deductions.',
    `interest_bearing` BOOLEAN COMMENT 'Indicates whether the security deposit is required by law or contract to accrue interest for the benefit of the tenant. Jurisdictional requirements vary; some states mandate interest-bearing accounts for residential deposits.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the cash security deposit balance where interest accrual is required by statute or lease agreement. Expressed as a decimal (e.g., 0.020000 = 2.00%).',
    `loc_amount` DECIMAL(18,2) COMMENT 'The face value of the letter of credit as issued by the bank. May differ from the required deposit amount if partial draws have been made. Applicable when deposit_type is letter_of_credit.',
    `loc_auto_renew` BOOLEAN COMMENT 'Indicates whether the letter of credit contains an evergreen/automatic renewal clause. If True, the LOC renews automatically unless the issuing bank provides non-renewal notice. Critical for deposit continuity monitoring.',
    `loc_expiry_date` DATE COMMENT 'The expiration date of the letter of credit. Landlord must monitor this date to ensure timely renewal or draw before expiry. A lapsed LOC creates unprotected credit exposure. Applicable when deposit_type is letter_of_credit.',
    `loc_issuer_name` STRING COMMENT 'Name of the financial institution (bank) that issued the letter of credit serving as the security deposit instrument. Applicable only when deposit_type is letter_of_credit.',
    `loc_number` STRING COMMENT 'The unique reference number assigned by the issuing bank to the letter of credit. Used for draw requests, renewals, and bank correspondence. Applicable when deposit_type is letter_of_credit.',
    `next_reduction_amount` DECIMAL(18,2) COMMENT 'The dollar amount by which the required security deposit will be reduced on the next scheduled reduction date. Used for cash flow planning and tenant notification.',
    `next_reduction_date` DATE COMMENT 'The next scheduled date on which the required security deposit amount is contractually reduced per the deposit reduction schedule. Triggers a review and potential partial return to the tenant.',
    `personal_guarantee_required` BOOLEAN COMMENT 'Indicates whether a personal guarantee from the tenants principal(s) is required in addition to the security deposit as a condition of the lease. Relevant for credit risk management and lease underwriting.',
    `reduction_schedule_applicable` BOOLEAN COMMENT 'Indicates whether the lease agreement includes a contractual schedule for reducing the required security deposit amount over time, typically tied to tenant performance milestones or lease anniversary dates.',
    `required_amount` DECIMAL(18,2) COMMENT 'The contractually stipulated security deposit amount as defined in the executed lease agreement. Represents the landlords minimum required collateral from the tenant.',
    `return_amount` DECIMAL(18,2) COMMENT 'The net amount of the security deposit returned or scheduled to be returned to the tenant upon lease termination, after deducting any applied charges, damages, or outstanding balances.',
    `return_deadline_date` DATE COMMENT 'The statutory or contractual deadline by which the landlord must return the security deposit or provide an itemized deduction statement to the tenant. Failure to meet this deadline may result in penalties.',
    `return_processed` BOOLEAN COMMENT 'Indicates whether the security deposit return transaction has been fully processed in the financial system, including AP payment issuance or LOC release. Used for lease-end settlement tracking.',
    `surety_bond_expiry_date` DATE COMMENT 'The expiration date of the surety bond instrument. Landlord must track this date to ensure the bond remains valid throughout the lease term. Applicable when deposit_type is surety_bond.',
    `surety_bond_issuer` STRING COMMENT 'Name of the surety company or insurance carrier that issued the surety bond serving as the security deposit. Applicable when deposit_type is surety_bond.',
    `surety_bond_number` STRING COMMENT 'Reference number of the surety bond instrument used as the security deposit. Applicable when deposit_type is surety_bond. Used for claims processing and bond renewal tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the security deposit record was last modified. Tracks changes to deposit amounts, status transitions, deductions, and return processing for audit and compliance purposes.',
    `yardi_deposit_code` STRING COMMENT 'The internal deposit charge code assigned in Yardi Voyager for this security deposit record. Used for system reconciliation, AR posting, and cross-referencing with source system transactions.',
    CONSTRAINT pk_security_deposit PRIMARY KEY(`security_deposit_id`)
) COMMENT 'Tracks security deposit obligations and balances for each lease agreement. Captures deposit type (cash, letter of credit, surety bond), required deposit amount, held amount, letter of credit issuer and expiry, deposit reduction schedule, applied deductions, and return status upon lease termination. Sourced from Yardi Voyager. Critical for tenant credit risk management and lease-end settlement.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`percentage_rent` (
    `percentage_rent_id` BIGINT COMMENT 'Unique system-generated identifier for each percentage rent (overage rent) record within the lease domain. Primary key for this data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property (retail center, shopping mall, or mixed-use asset) where the leased premises generating percentage rent are located.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Percentage rent posts to specific GL accounts (percentage rent income). A proper FK to chart_of_accounts enables automated AR invoice generation, GL posting, and financial statement classification for',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Percentage rent income is tracked by cost center for retail property NOI reporting and budget variance analysis. The gl_account_code on percentage_rent is a denormalized reference; a proper FK enables',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Percentage rent calculations (gross sales, breakpoints, billed amounts) require a validated currency reference for multi-currency retail portfolios and accurate revenue recognition reporting.',
    `demised_space_id` BIGINT COMMENT 'Foreign key linking to lease.lease_demised_space. Business justification: Percentage rent is calculated for specific retail demised spaces — the breakpoint is often based on the leased area (natural breakpoint = annual base rent / percentage rate, where base rent is space-s',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Percentage rent breakpoints and rates vary by tenant industry (retail food vs. apparel vs. electronics). Industry classification drives natural breakpoint calculations, audit rights, and retail portfo',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent retail lease agreement under which this percentage rent obligation arises. Links to the executed lease record in the lease domain.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Percentage rent revenue recognition under ASC 842/606 is ledger-specific. RE retail property accountants require ledger assignment on percentage_rent records to route variable lease payment entries to',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Percentage rent is recognized as revenue under a specific legal entity for statutory reporting and tax purposes. RE retail operators with multiple legal entities require entity-level percentage rent t',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: Percentage rent (overage rent) is calculated against the base rent schedule — the natural breakpoint is often derived from the base rent amount in the rent schedule. Linking percentage_rent to rent_sc',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Percentage rent breakpoints and rates vary by space use type (food service vs. apparel vs. entertainment). Retail lease management, percentage rent auditing, and natural breakpoint calculations requir',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant entity responsible for reporting gross sales and paying percentage rent under this lease.',
    `unit_id` BIGINT COMMENT 'Reference to the specific leasable unit or suite within the property for which percentage rent is being calculated and tracked.',
    `applicable_breakpoint_amount` DECIMAL(18,2) COMMENT 'The effective breakpoint amount used for this reporting periods percentage rent calculation — either the natural or artificial breakpoint as determined by breakpoint_type. This is the operative threshold against which reported gross sales are compared.',
    `ar_invoice_ref` STRING COMMENT 'Reference to the Accounts Receivable invoice number generated in Yardi Voyager for the billed percentage rent amount. Links the percentage rent record to the AR billing and collection workflow.',
    `artificial_breakpoint_amount` DECIMAL(18,2) COMMENT 'Fixed gross sales threshold negotiated in the lease above which percentage rent becomes payable. Applicable when breakpoint_type is artificial. May differ from the natural breakpoint to incentivize or protect the tenant.',
    `audit_completion_date` DATE COMMENT 'Date on which the landlords audit of the tenants gross sales records was completed and findings were finalized. Populated only when audit_right_exercised is True.',
    `audit_right_exercised` BOOLEAN COMMENT 'Indicates whether the landlord has exercised their contractual right to audit the tenants books and records for this reporting period. When True, audited_gross_sales should be populated upon audit completion.',
    `audit_variance_amount` DECIMAL(18,2) COMMENT 'Dollar difference between audited_gross_sales and reported_gross_sales discovered during a landlord audit. Positive value indicates tenant under-reported sales; negative indicates over-reporting. Drives additional billing or credit adjustments.',
    `audited_gross_sales` DECIMAL(18,2) COMMENT 'Gross sales amount as verified or adjusted following a landlord-initiated audit of the tenants sales records. Populated only when an audit has been completed. May differ from reported_gross_sales if discrepancies are found.',
    `breakpoint_type` STRING COMMENT 'Indicates whether the sales breakpoint is a natural breakpoint (derived as base rent divided by the percentage rate) or an artificial breakpoint (a fixed dollar amount negotiated in the lease regardless of base rent).. Valid values are `natural|artificial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this percentage rent record was first created in the data platform. Supports audit trail, data lineage, and SOX compliance requirements.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for a percentage rent dispute raised by either the landlord or tenant. Populated when reconciliation_status is disputed. Documents the nature of the disagreement for resolution tracking.',
    `lease_structure_type` STRING COMMENT 'Classification of the lease structure under which percentage rent applies. Determines the expense responsibility allocation between landlord and tenant alongside the percentage rent obligation. [ENUM-REF-CANDIDATE: nnn|gross|modified_gross|net|double_net — promote to reference product]. Valid values are `nnn|gross|modified_gross|net|double_net`',
    `lease_year_number` STRING COMMENT 'Sequential lease year (1, 2, 3, …) within the lease term to which this reporting period belongs. Used for annual breakpoint resets and lease-year-based reconciliation cycles.',
    `natural_breakpoint_amount` DECIMAL(18,2) COMMENT 'Calculated sales threshold equal to annual base rent divided by the percentage rent rate. Gross sales above this level trigger percentage rent obligations. Applicable when breakpoint_type is natural.',
    `net_sales_for_calculation` DECIMAL(18,2) COMMENT 'Gross sales net of contractual exclusions used as the operative sales figure for percentage rent calculation. Equals reported_gross_sales (or audited_gross_sales if audited) minus sales_exclusions_amount.',
    `notes` STRING COMMENT 'Free-text field for property managers or lease administrators to record additional context, special circumstances, or follow-up actions related to this percentage rent record (e.g., tenant dispute details, audit findings summary, reconciliation adjustments).',
    `payment_due_date` DATE COMMENT 'Contractual date by which the calculated percentage rent must be paid by the tenant. Typically a fixed number of days after the sales report due date or after the landlord issues the reconciliation statement.',
    `pct_rent_billed` DECIMAL(18,2) COMMENT 'Actual percentage rent amount invoiced to the tenant for the reporting period. May differ from pct_rent_calculated due to interim billing adjustments, credits applied, or reconciliation true-ups.',
    `pct_rent_calculated` DECIMAL(18,2) COMMENT 'Calculated overage rent amount due for the reporting period, derived as sales_over_breakpoint multiplied by the applicable percentage_rate (or tiered rates). This is the system-computed obligation before any adjustments or credits.',
    `pct_rent_collected` DECIMAL(18,2) COMMENT 'Total percentage rent cash received from the tenant for this reporting period. Used to track collection status and outstanding balances against billed amounts.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'The contractual percentage rate (expressed as a decimal, e.g., 0.0600 for 6%) applied to gross sales in excess of the applicable breakpoint to calculate overage rent due. Sourced directly from the lease agreement.',
    `reconciliation_date` DATE COMMENT 'Date on which the percentage rent reconciliation for this reporting period was finalized and agreed between landlord and tenant. Marks the transition to reconciled status.',
    `reconciliation_status` STRING COMMENT 'Current workflow status of the percentage rent reconciliation process for this reporting period. Tracks the lifecycle from awaiting tenant sales report through final settlement. [ENUM-REF-CANDIDATE: pending_report|report_received|under_review|reconciled|disputed|audit_initiated|closed — promote to reference product]',
    `reported_gross_sales` DECIMAL(18,2) COMMENT 'Total gross sales amount reported by the tenant for the reporting period as submitted in the tenants sales report. This is the tenant-declared figure prior to landlord audit or verification. Classified confidential as it contains commercially sensitive tenant revenue data.',
    `reporting_period_end_date` DATE COMMENT 'Last day of the sales reporting period for which the tenant is required to report gross sales and calculate percentage rent due.',
    `reporting_period_start_date` DATE COMMENT 'First day of the sales reporting period (monthly, quarterly, or annual) for which the tenant is required to report gross sales and calculate percentage rent due.',
    `reporting_period_type` STRING COMMENT 'Frequency classification of the sales reporting period as defined in the lease agreement. Determines how often the tenant must submit gross sales reports and how often percentage rent is calculated.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `sales_exclusions_amount` DECIMAL(18,2) COMMENT 'Dollar value of gross sales items contractually excluded from the percentage rent calculation per the lease (e.g., sales tax collected, returns and allowances, employee discounts, internet sales if excluded). Reduces the gross sales base for breakpoint comparison.',
    `sales_over_breakpoint` DECIMAL(18,2) COMMENT 'The amount by which net_sales_for_calculation exceeds the applicable_breakpoint_amount. This is the overage base to which the percentage_rate is applied. Zero if net sales do not exceed the breakpoint.',
    `sales_report_due_date` DATE COMMENT 'Contractual deadline by which the tenant must submit their gross sales report for the reporting period as specified in the lease agreement. Used for compliance tracking and late notice generation.',
    `sales_report_late` BOOLEAN COMMENT 'Indicates whether the tenants gross sales report was received after the contractual due date. True when sales_report_received_date exceeds sales_report_due_date or when the report has not been received by the due date.',
    `sales_report_received_date` DATE COMMENT 'Actual date on which the tenants gross sales report was received by the landlord or property manager. Compared against sales_report_due_date to identify late submissions.',
    `tiered_rate_applicable` BOOLEAN COMMENT 'Indicates whether the lease specifies multiple tiered percentage rates applied to different bands of gross sales above the breakpoint (e.g., 5% on first $500K over breakpoint, 6% on next $500K). When True, rate tiers are managed in a related reference structure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this percentage rent record in the data platform. Used for change tracking, incremental data loads, and audit compliance.',
    `yardi_pct_rent_ref` STRING COMMENT 'Source system reference code from Yardi Voyager percentage rent module uniquely identifying this record in the operational system of record. Used for reconciliation and audit trail.',
    CONSTRAINT pk_percentage_rent PRIMARY KEY(`percentage_rent_id`)
) COMMENT 'Manages percentage rent (overage rent) obligations for retail leases where rent is partially based on tenant gross sales. Stores natural breakpoint, artificial breakpoint, percentage rate, reporting period, reported gross sales, calculated percentage rent due, and reconciliation status. Sourced from Yardi Voyager percentage rent module. Applicable to retail NNN and gross leases with sales-based rent components.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`accounting_entry` (
    `accounting_entry_id` BIGINT COMMENT 'Primary key for accounting_entry',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: accounting_entry has modification_flag BOOLEAN indicating a lease modification event. Under ASC 842, lease modifications (amendments) require remeasurement and new accounting entries. Linking accounti',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with the underlying lease, used for property-level disclosure aggregation and NOI reporting.',
    `cam_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.cam_schedule. Business justification: CAM reconciliation events generate specific accounting entries — credit or charge amounts from CAM reconciliation are posted as journal entries under ASC 842 / IFRS 16. Linking accounting_entry to cam',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Each ASC 842 entry type (ROU asset, lease liability, straight-line rent) maps to a specific GL account. The gl_account_code on accounting_entry is a denormalized reference; a proper FK enables automat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ASC 842/IFRS 16 accounting entries (ROU asset amortization, lease liability interest) are posted to cost centers for property-level balance sheet and P&L reporting. The cost_center_code on accounting_',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: ASC842/IFRS16 lease accounting entries require validated currency references for ROU asset, lease liability, and interest expense calculations. Multi-currency portfolios require FX translation using t',
    `debt_facility_id` BIGINT COMMENT 'Foreign key linking to investment.debt_facility. Business justification: Debt covenant compliance (DSCR, LTV) requires mapping lease accounting cash flows (interest expense, principal, NOI) to specific debt facilities. Lenders and servicers require this attribution for cov',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: ASC 842 accounting entries are posted as journal entries in the GL. Linking accounting_entry to the resulting journal_entry provides SOX-required audit traceability from lease accounting subledger to ',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent lease agreement for which this accounting entry is generated.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: ASC 842/IFRS 16 accounting entries (ROU asset, lease liability, straight-line rent) must be posted to a specific ledger. An accounting_entry without a ledger FK is fundamentally incomplete for multi-b',
    `legal_entity_id` BIGINT COMMENT 'Reference to the reporting legal entity (e.g., REIT subsidiary or operating company) responsible for this accounting entry under ASC 842 / IFRS 16 consolidation.',
    `percentage_rent_id` BIGINT COMMENT 'Foreign key linking to lease.percentage_rent. Business justification: Percentage rent generates variable lease cost accounting entries under ASC 842 (variable_lease_cost field on accounting_entry). Linking accounting_entry to percentage_rent enables direct traceability ',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: ASC 842/IFRS 16 ROU asset and lease liability entries must be attributed to portfolio assets for fund-level NAV calculations and investor reporting. accounting_entry has asset_id (property domain) but',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: ASC 842 requires derecognition of ROU assets and lease liabilities upon property sale. The accounting_entry recording this derecognition event must reference the triggering property_sale for gain/loss',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: ASC 842 / IFRS 16 accounting entries are generated per accounting period and correspond to specific rent schedule steps (straight-line rent, variable lease cost). Linking accounting_entry.rent_schedul',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to finance.reporting_period. Business justification: Lease accounting entries must be tied to a reporting period for period-close processes, financial statement preparation, and ASC 842 disclosure schedules. RE finance teams use reporting_period to lock',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: Security deposits generate specific accounting entries — interest accrual on interest-bearing deposits, forfeiture recognition, and return processing all create journal entries. Linking accounting_ent',
    `sublease_id` BIGINT COMMENT 'Foreign key linking to lease.sublease. Business justification: accounting_entry has sublease_income field. Under ASC 842, sublease income is separately disclosed and requires its own accounting entries (net investment in sublease, sublease income recognition). Li',
    `termination_id` BIGINT COMMENT 'Foreign key linking to lease.termination. Business justification: Lease terminations require ASC 842 derecognition accounting entries (rou_asset_amortisation, lease_liability_closing_balance going to zero). Linking accounting_entry.termination_id → lease.termination',
    `ti_allowance_id` BIGINT COMMENT 'Foreign key linking to lease.ti_allowance. Business justification: TI allowances generate lease incentive accounting entries under ASC 842 (asc842_lease_incentive_flag) and IFRS 16 (ifrs16_lease_incentive_flag). The accounting_entry table tracks lease_incentive_recei',
    `accounting_period_date` DATE COMMENT 'The first day of the accounting period (month-end or quarter-end) to which this lease accounting entry relates, used for period-end close and disclosure aggregation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lease accounting entry record was first created in the Silver layer data product, used for audit trail and data lineage.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The rate used to discount future lease payments to present value — either the rate implicit in the lease or, if not determinable, the lessees incremental borrowing rate (IBR). Stored as a decimal (e.g., 0.055000 = 5.5%). Required for weighted-average rate disclosure.',
    `entry_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned by Yardi Voyager or SAP S/4HANA to uniquely identify this lease accounting entry for cross-system reconciliation and audit trail.',
    `entry_status` STRING COMMENT 'Current workflow state of the lease accounting entry. draft = pending review; posted = recorded in GL; reversed = correcting entry applied; adjusted = amended after initial posting; under_review = flagged for auditor review.. Valid values are `draft|posted|reversed|adjusted|under_review`',
    `entry_type` STRING COMMENT 'Discriminator for the nature of the accounting entry: initial_recognition = commencement date measurement; subsequent_measurement = periodic amortisation/interest; remeasurement = triggered by lease modification or reassessment; termination = derecognition; modification = lease term or payment change; disclosure_summary = aggregated period-end disclosure record.. Valid values are `initial_recognition|subsequent_measurement|remeasurement|termination|modification|disclosure_summary`',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1–4) within the fiscal year to which this entry belongs, supporting quarterly 10-Q disclosure requirements for publicly traded REITs.',
    `fiscal_year` STRING COMMENT 'The fiscal year (four-digit integer) in which this accounting entry falls, used for annual disclosure reporting and REIT financial statement preparation.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the reporting entitys functional currency. Used for foreign currency translation of lease liabilities and ROU assets under ASC 830 / IAS 21 when the lease currency differs from the functional currency.. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to translate lease amounts from the lease currency to the functional currency as of the measurement date. Equals 1.0 when both currencies are the same.',
    `interest_expense` DECIMAL(18,2) COMMENT 'Interest accrued on the lease liability during the period using the effective interest method at the incremental borrowing rate or implicit rate. Recognised in the income statement for finance leases; included in operating lease cost for operating leases under ASC 842.',
    `lease_classification` STRING COMMENT 'ASC 842 / IFRS 16 classification of the lease: operating = lessee recognises straight-line rent expense; finance = lessee recognises interest + amortisation; short_term = practical expedient, term ≤12 months; low_value = IFRS 16 practical expedient for low-value assets.. Valid values are `operating|finance|short_term|low_value`',
    `lease_incentive_received` DECIMAL(18,2) COMMENT 'Cash or non-cash lease incentives received from the lessor (e.g., Tenant Improvement allowances, free rent periods) that reduce the initial measurement of the ROU asset under ASC 842 / IFRS 16.',
    `lease_liability_closing_balance` DECIMAL(18,2) COMMENT 'Present value of remaining lease payments at the end of the accounting period, as reported on the balance sheet. Equals opening balance plus interest accrual minus principal repayment plus/minus remeasurement.',
    `lease_liability_opening_balance` DECIMAL(18,2) COMMENT 'Present value of remaining lease payments at the beginning of the accounting period, before current-period interest accrual and principal repayment.',
    `lease_liability_remeasurement` DECIMAL(18,2) COMMENT 'Adjustment to the lease liability resulting from a lease modification, change in lease term, change in variable payments indexed to a rate, or reassessment of a purchase/extension option. Positive = increase; negative = decrease.',
    `maturity_after_year5_payments` DECIMAL(18,2) COMMENT 'Undiscounted future lease payments due more than 5 years from the balance sheet date, completing the maturity analysis disclosure schedule under ASC 842-20-50-6 and IFRS 16 paragraph 58.',
    `maturity_year1_payments` DECIMAL(18,2) COMMENT 'Undiscounted future lease payments due within 12 months of the balance sheet date, as required for the lease liability maturity analysis disclosure under ASC 842-20-50-6 and IFRS 16 paragraph 58.',
    `maturity_year2_to5_payments` DECIMAL(18,2) COMMENT 'Undiscounted future lease payments due between 1 and 5 years from the balance sheet date, forming part of the maturity analysis disclosure schedule under ASC 842-20-50-6 and IFRS 16 paragraph 58.',
    `measurement_date` DATE COMMENT 'The specific date on which the ROU asset and lease liability were measured or remeasured, which may differ from the accounting period date in the case of mid-period modifications or reassessments.',
    `modification_flag` BOOLEAN COMMENT 'Indicates whether this accounting entry was triggered by a lease modification event (e.g., extension, scope change, rent renegotiation) requiring remeasurement of the ROU asset and lease liability.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when this accounting entry was posted to the General Ledger, representing the principal business event timestamp for the transaction lifecycle.',
    `practical_expedient_applied` STRING COMMENT 'Indicates which ASC 842 / IFRS 16 practical expedient, if any, has been elected for this lease: short_term = ≤12-month exemption; low_value = IFRS 16 low-value asset exemption; portfolio = portfolio-level application; hindsight = hindsight expedient on transition; none = no expedient applied.. Valid values are `none|short_term|low_value|portfolio|hindsight`',
    `principal_repayment` DECIMAL(18,2) COMMENT 'Cash payment applied to reduce the lease liability principal during the period, representing the financing portion of the lease payment.',
    `rou_asset_additions` DECIMAL(18,2) COMMENT 'Increases to the ROU asset during the period from new lease commencements, lease modifications that increase scope, or remeasurements that increase the lease liability.',
    `rou_asset_amortisation` DECIMAL(18,2) COMMENT 'Current-period amortisation charge applied to the ROU asset. For finance leases, amortised on a straight-line basis over the shorter of the lease term or useful life; for operating leases, the plug to achieve straight-line rent expense.',
    `rou_asset_closing_balance` DECIMAL(18,2) COMMENT 'Net carrying value of the ROU asset at the end of the accounting period after amortisation and any impairment, as reported on the balance sheet.',
    `rou_asset_impairment` DECIMAL(18,2) COMMENT 'Impairment loss recognised against the ROU asset during the period under ASC 360 / IAS 36, reducing the carrying value below the amortised cost.',
    `rou_asset_opening_balance` DECIMAL(18,2) COMMENT 'Carrying value of the Right-of-Use (ROU) asset at the beginning of the accounting period before current-period amortisation, as required for ASC 842 / IFRS 16 roll-forward disclosure.',
    `short_term_lease_cost` DECIMAL(18,2) COMMENT 'Lease expense recognised for leases with a term of 12 months or less where the short-term practical expedient has been elected, excluded from ROU asset and lease liability recognition. Required disclosure under ASC 842-20-50-4.',
    `straight_line_rent_expense` DECIMAL(18,2) COMMENT 'Total operating lease cost recognised on a straight-line basis over the lease term for operating leases under ASC 842, combining the amortisation of the ROU asset and the unwinding of the lease liability discount.',
    `sublease_income` DECIMAL(18,2) COMMENT 'Income received or receivable from subleasing the right-of-use asset to a third party during the period. Required as a separate disclosure line under ASC 842-20-50-4 and IFRS 16 paragraph 53(b).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this lease accounting entry record, supporting change tracking and incremental load processing in the Databricks Silver layer.',
    `variable_lease_cost` DECIMAL(18,2) COMMENT 'Lease payments not included in the lease liability measurement that vary based on an index, rate, or usage (e.g., CPI-linked rent escalations above the initial index, percentage rent, CAM true-ups). Required disclosure under ASC 842-20-50 and IFRS 16 paragraph 53.',
    `weighted_avg_discount_rate` DECIMAL(18,2) COMMENT 'Weighted average incremental borrowing rate or implicit rate applied across the lease portfolio as of period-end, required for ASC 842-20-50-6 and IFRS 16 paragraph 58 disclosure. Stored as a decimal (e.g., 0.048500 = 4.85%).',
    `weighted_avg_remaining_term_years` DECIMAL(18,2) COMMENT 'Weighted Average Lease Term (WALT) remaining as of the period-end date, expressed in years. Populated on disclosure_summary entry types for aggregated portfolio-level ASC 842 / IFRS 16 footnote disclosure.',
    CONSTRAINT pk_accounting_entry PRIMARY KEY(`accounting_entry_id`)
) COMMENT 'ASC 842 / IFRS 16 lease accounting and disclosure compliance records. Captures initial recognition and subsequent measurement of right-of-use (ROU) assets and lease liabilities: lease classification (operating, finance), ROU asset value, accumulated amortization, lease liability balance, interest expense, principal reduction, straight-line rent expense, period-end carrying values, and aggregated disclosure data (maturity analysis, weighted-average remaining term, weighted-average discount rate, operating/finance/variable lease costs, sublease income). Supports FASB/IASB quarterly and annual disclosure requirements for public REITs. Sourced from Yardi Voyager lease accounting module and SAP S/4HANA.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`sublease` (
    `sublease_id` BIGINT COMMENT 'Unique system-generated identifier for the sublease record. Primary key for the sublease data product in the Silver Layer lakehouse.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Subleases can be amended (e.g., sublease term extensions, rent modifications, space changes). Linking sublease to the amendment that created or modified it enables full lifecycle tracking of sublease ',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Sublease tracks sublet_area_sqft requiring a formal UOM reference for IFRS 16 net investment in sublease calculations and cross-border sublease reporting where sqft and sqm must be consistently applie',
    `asset_id` BIGINT COMMENT 'Reference to the property where the subleased premises are located. Used for property-level reporting and portfolio analytics.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: Subleases are frequently brokered transactions generating commissions. Linking sublease to the originating brokerage deal enables commission calculation on sublease transactions and tracks broker invo',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Sublease income posts to specific GL accounts. ASC 842 requires separate disclosure of sublease income; a proper FK to chart_of_accounts enables automated GL posting and financial statement line class',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Subleases frequently require separate occupancy or change-of-use permits for the subtenant. Real estate operations teams track permit approval as a condition precedent to sublease commencement, and co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sublease income is allocated to a cost center for property-level NOI tracking and P&L reporting. RE property managers track sublease income at cost center level to measure net occupancy cost and repor',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Sublease financial terms (rent, security deposit, profit/loss) require a validated currency reference for multi-currency portfolio reporting and ASC842 net investment in sublease calculations.',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Subtenant industry classification is required for co-tenancy analysis, permitted use compliance verification, and landlord consent decisions. Replaces denormalized subtenant_industry string with a str',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the parent head lease agreement from which this sublease is derived. Links the sublease to the primary tenants original lease with the landlord.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Sublease classification as operating vs finance sublease differs between GAAP and IFRS 16, requiring different accounting entries per ledger. RE accountants expect ledger assignment on sublease record',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Sublease income is recognized under a specific legal entity for IFRS 16 net investment in sublease reporting and tax purposes. RE accountants require entity-level sublease tracking for statutory finan',
    `market_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.market_survey. Business justification: Sublandlords price sublease rents (rent_psf, rent_annual fields) against current market survey data to set competitive rates and minimize sublease losses. Linking sublease to market_survey provides th',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Subleases require direct landlord/owner consent — sublease already tracks landlord_consent_date, landlord_consent_required, landlord_consent_status. Owner consent workflow and legal notice delivery fo',
    `tenant_id` BIGINT COMMENT 'Reference to the primary tenant acting as sublessor — the party who holds the head lease and is subletting all or part of their demised premises to a subtenant.',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: A sublease covers a specific physical space, often a portion of the head lease space. Space-level sublease tracking for occupancy reporting, availability management, and ASC 842 sublease classificatio',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Sublease rent structure (NNN, gross, modified gross) determines ASC842 sublease classification (operating vs. sales-type) and profit/loss on sublease calculations. Domain experts expect lease type ref',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Sublease arrangements must comply with regulatory obligations governing subletting rights, assignment restrictions, and tenant protections under local law. Compliance teams track regulatory constraint',
    `rent_schedule_id` BIGINT COMMENT 'Foreign key linking to lease.rent_schedule. Business justification: Subleases have their own rent escalation schedules (sublease_rent_monthly, rent_escalation_type, rent_escalation_rate on sublease). Linking sublease.rent_schedule_id → lease.rent_schedule.rent_schedul',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: Subleases have their own security deposit obligations from the subtenant. The sublease table carries a security_deposit_amount field which is a denormalized value that should be replaced by a FK to th',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Subleases are classified by space use type for portfolio analytics, REIT income categorization, and sublease income reporting. Real estate portfolio managers track sublease exposure by use type (offic',
    `sublease_subtenant_profile_tenant_id` BIGINT COMMENT 'Reference to the subtenant entity occupying the subleased premises. The subtenant has a direct contractual relationship with the sublessor, not the landlord.',
    `sublease_tenant_id` BIGINT COMMENT 'FK to tenant.tenant',
    `unit_id` BIGINT COMMENT 'Reference to the specific leasable unit or suite being sublet. May represent a partial unit if only a portion of the demised premises is subleased.',
    `abstracted_by` STRING COMMENT 'Name or identifier of the lease abstraction analyst or team who extracted and entered the sublease terms into the system. Supports data quality auditing and abstraction accountability.',
    `abstracted_date` DATE COMMENT 'Date on which the sublease terms were abstracted and entered into the system. Used for data quality tracking and audit trail purposes.',
    `asc842_sublease_classification` STRING COMMENT 'Classification of the sublease under FASB ASC 842 from the sublessors perspective as an intermediate lessor. operating means the sublessor recognizes lease income on a straight-line basis; finance means the sublessor derecognizes the underlying asset and recognizes a net investment in the sublease.. Valid values are `operating|finance|not_classified`',
    `cam_amount_annual` DECIMAL(18,2) COMMENT 'Estimated annual Common Area Maintenance (CAM) charges payable by the subtenant. Relevant for NNN and modified gross sublease structures. Used for total occupancy cost analysis.',
    `cam_applicable` BOOLEAN COMMENT 'Indicates whether Common Area Maintenance (CAM) charges are applicable to the subtenant under the sublease terms. When true, CAM reconciliation obligations flow through from the head lease.',
    `commencement_date` DATE COMMENT 'The date on which the sublease term begins and the subtenant takes possession of the subleased premises. Used as the effective start date for ASC 842 / IFRS 16 lessor accounting measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sublease record was first created in the Silver Layer lakehouse. Supports audit trail, data lineage, and SOX compliance requirements.',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'The interest rate used to discount future sublease payments for ASC 842 / IFRS 16 net investment measurement. Typically the rate implicit in the sublease or the sublessors incremental borrowing rate.',
    `docusign_envelope_code` STRING COMMENT 'Unique identifier of the DocuSign CLM envelope containing the executed sublease agreement and all associated documents. Enables direct retrieval of the signed sublease document from the contract management system.',
    `early_termination_option` BOOLEAN COMMENT 'Indicates whether the sublease contains an early termination clause allowing either party to terminate the sublease before the scheduled expiration date. Affects ASC 842 lease term determination and WALE calculations.',
    `execution_date` DATE COMMENT 'The date on which the sublease agreement was fully executed (signed by all parties) via DocuSign CLM or physical signature. Marks the legally binding commencement of the sublease contract.',
    `expiration_date` DATE COMMENT 'The scheduled date on which the sublease term ends. Must not extend beyond the head lease expiration date. Critical for WALT/WALE calculations and portfolio expiry scheduling.',
    `free_rent_months` STRING COMMENT 'Number of months of rent abatement granted to the subtenant at the commencement of the sublease. Affects straight-line rent recognition under ASC 842 operating sublease accounting.',
    `governing_law_state` STRING COMMENT 'Two-letter US state code (or equivalent jurisdiction) whose laws govern the sublease agreement. Relevant for dispute resolution, regulatory compliance, and legal enforceability analysis.. Valid values are `^[A-Z]{2}$`',
    `head_lease_rent_psf` DECIMAL(18,2) COMMENT 'The sublessors rent obligation under the head lease expressed on a PSF basis for the subleased area. Used to calculate profit or loss on sublease relative to the head lease rent obligation.',
    `ifrs16_sublease_classification` STRING COMMENT 'Classification of the sublease under IFRS 16 from the intermediate lessors perspective. Classification is based on the right-of-use (ROU) asset arising from the head lease, not the underlying asset. finance requires recognition of a net investment in the sublease.. Valid values are `operating|finance|not_classified`',
    `landlord_consent_date` DATE COMMENT 'The date on which the landlord formally granted written consent to the sublease arrangement. Required for sublease validity where landlord consent is mandated by the head lease.',
    `landlord_consent_required` BOOLEAN COMMENT 'Indicates whether the head lease requires the landlords written consent before the sublease can be executed. Derived from the head lease assignment and subletting clause.',
    `landlord_consent_status` STRING COMMENT 'Current status of the landlords consent process for the sublease. not_required indicates the head lease permits subletting without consent; conditional indicates consent granted subject to specific conditions.. Valid values are `not_required|pending|approved|denied|conditional`',
    `net_investment_in_sublease` DECIMAL(18,2) COMMENT 'Present value of future sublease payments plus any unguaranteed residual value, recognized on the balance sheet for finance subleases under ASC 842 / IFRS 16. Applicable only when asc842_sublease_classification or ifrs16_sublease_classification is finance.',
    `profit_loss_on_sublease` DECIMAL(18,2) COMMENT 'Net financial position of the sublease relative to the head lease rent obligation for the subleased area. Positive value indicates sublease rent exceeds head lease cost (profit); negative value indicates a loss position. Calculated as sublease rent minus allocated head lease rent for the sublet area.',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for the sublease agreement as recorded in Yardi Voyager or DocuSign CLM. Used for cross-system reconciliation and document retrieval.',
    `renewal_option_available` BOOLEAN COMMENT 'Indicates whether the sublease includes a renewal option allowing the subtenant to extend the sublease term. Relevant for WALT/WALE calculations and ASC 842 lease term reassessment.',
    `rent_annual` DECIMAL(18,2) COMMENT 'Total annual base rent payable by the subtenant to the sublessor under the sublease agreement. Used for NOI analysis, profit/loss on sublease calculations, and ASC 842 lessor income recognition.',
    `rent_escalation_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate applied to base rent escalation where escalation type is fixed or stepped. Expressed as a decimal (e.g., 0.0300 = 3%). Used for cash flow modeling in Argus Enterprise.',
    `rent_escalation_type` STRING COMMENT 'Method by which sublease base rent increases over the sublease term. fixed applies a fixed percentage; cpi ties escalation to the Consumer Price Index; fmv resets to fair market value; stepped uses pre-agreed step-up amounts; none indicates flat rent.. Valid values are `fixed|cpi|fmv|none|stepped`',
    `rent_monthly` DECIMAL(18,2) COMMENT 'Monthly base rent payable by the subtenant. Derived from the annual rent schedule but stored explicitly for billing and cash flow forecasting in Yardi Voyager AR.',
    `rent_psf` DECIMAL(18,2) COMMENT 'Annual base rent expressed on a per-square-foot (PSF) basis for the subleased area. Key metric for market benchmarking against CoStar comparable lease data and head lease PSF comparison.',
    `rou_asset_allocated_amount` DECIMAL(18,2) COMMENT 'Portion of the head lease Right-of-Use (ROU) asset allocated to the subleased area for ASC 842 / IFRS 16 intermediate lessor accounting. Used to determine the carrying amount of the net investment in a finance sublease or the ROU asset derecognition amount.',
    `sublease_status` STRING COMMENT 'Current lifecycle state of the sublease agreement. draft indicates the sublease is being negotiated; pending_consent indicates awaiting landlord approval; active indicates the sublease is in force; expired indicates the term has ended; terminated indicates early termination; holdover indicates the subtenant remains in possession beyond the sublease expiry.. Valid values are `draft|pending_consent|active|expired|terminated|holdover`',
    `sublease_type` STRING COMMENT 'Classification of the sublease arrangement. full_assignment transfers all rights and obligations of the head lease; partial_sublease sublets only a portion of the demised premises; master_sublease covers an entire building or multi-unit portfolio; short_term_sublease is a temporary arrangement typically under 12 months.. Valid values are `full_assignment|partial_sublease|master_sublease|short_term_sublease`',
    `sublet_area_sqft` DECIMAL(18,2) COMMENT 'The net leasable area (NLA) in square feet being subleased to the subtenant. May be less than the total demised premises area under the head lease for partial subleases. Used for PSF rent calculations and GLA reporting.',
    `term_months` STRING COMMENT 'Total duration of the sublease in months, calculated from commencement to expiration. Used for WALT/WALE analysis and ASC 842 lease term determination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sublease record in the Silver Layer lakehouse. Used for change data capture, incremental processing, and audit trail compliance.',
    `yardi_sublease_ref` STRING COMMENT 'Internal reference code assigned to the sublease record in Yardi Voyager Lease Administration. Used for cross-system reconciliation between the Silver Layer lakehouse and the operational system of record.',
    CONSTRAINT pk_sublease PRIMARY KEY(`sublease_id`)
) COMMENT 'Records sublease arrangements where a primary tenant sublets all or part of their demised premises to a subtenant. Captures sublease commencement, expiration, sublet area SQF, sublease rent, subtenant identity, landlord consent date and status, sublease type (full assignment, partial sublease), profit/loss on sublease relative to head lease rent, and ASC 842 sublease classification (operating vs. finance for lessor accounting). Sourced from Yardi Voyager and DocuSign CLM. Distinct from the head lease agreement; linked to parent agreement via FK.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`lease`.`guaranty` (
    `guaranty_id` BIGINT COMMENT 'Unique system-generated identifier for the lease guaranty record. Primary key for the guaranty data product.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: guaranty.amendment_reference is a denormalized STRING field. Replacing it with amendment_id → lease.amendment.amendment_id normalizes the relationship between a guaranty and the amendment that introdu',
    `asset_id` BIGINT COMMENT 'Reference to the property associated with the guaranteed lease. Used for portfolio-level credit risk reporting.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Guaranty amounts (guaranteed amount, burn-down schedule, amount recovered) require a validated currency reference for multi-currency portfolios and credit risk reporting on lease guaranty exposure.',
    `guarantor_id` BIGINT COMMENT 'Tax identification number (EIN/TIN) or government-issued registration number for the guarantor entity. Used for credit verification, legal enforcement, and regulatory compliance. For individuals, this may be a masked SSN reference.',
    `industry_classification_id` BIGINT COMMENT 'Foreign key linking to reference.industry_classification. Business justification: Guarantor credit risk assessment and financial covenant requirements are tied to the guarantors industry classification. Credit risk teams use industry classification to evaluate guaranty strength, s',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the commercial lease agreement this guaranty supports. Links the guaranty obligation to the underlying lease contract.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Guaranties are contingent liabilities of a specific legal entity; required for contingent liability disclosure under ASC 450 and credit risk reporting. RE finance teams track guaranty obligations at l',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: The owner/landlord is the direct beneficiary of every lease guaranty. Real estate asset managers track guaranty exposure, burn-down schedules, and enforcement actions at the owner entity level for cre',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Guaranty enforceability is governed by jurisdiction-specific regulations (NY COVID-era guaranty moratoriums, state-specific personal guaranty laws). Compliance teams must track which regulatory obliga',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: Guaranty obligations can be conditioned on renewal option exercise — the renewal_option table carries a personal_guarantee_required flag, confirming this business relationship. Linking guaranty to ren',
    `replaced_guaranty_id` BIGINT COMMENT 'Self-referencing FK on guaranty (replaced_guaranty_id)',
    `tenant_id` BIGINT COMMENT 'Reference to the tenant entity whose lease obligations are being guaranteed. The primary obligor under the lease.',
    `abstracted_by` STRING COMMENT 'Name or identifier of the lease abstraction analyst or paralegal who extracted and entered the guaranty terms from the executed document into the system of record.',
    `abstracted_date` DATE COMMENT 'Date on which the guaranty terms were abstracted from the executed document and entered into the data system. Used for data quality auditing and lease administration workflow tracking.',
    `amount_recovered` DECIMAL(18,2) COMMENT 'Total monetary amount actually recovered from the guarantor through enforcement, settlement, or voluntary payment. Used to calculate net credit loss on the lease.',
    `burn_down_applicable` BOOLEAN COMMENT 'Indicates whether the guaranty includes a contractual burn-down schedule under which the guaranteed amount reduces over time as the tenant demonstrates satisfactory lease performance.',
    `burn_down_interval_months` STRING COMMENT 'Frequency in months at which the guaranteed amount is reduced per the burn-down schedule (e.g., 12 for annual reductions). Null if burn-down is not applicable.',
    `burn_down_reduction_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount by which the guaranteed exposure is reduced at each burn-down interval. Used when the burn-down is amount-based rather than percentage-based.',
    `burn_down_reduction_pct` DECIMAL(18,2) COMMENT 'Percentage of the original guaranteed amount by which exposure is reduced at each burn-down interval. Used when the burn-down is percentage-based rather than fixed-amount-based. Stored as a decimal (e.g., 0.25 = 25%).',
    `burn_down_start_date` DATE COMMENT 'Date on which the guaranty burn-down schedule commences. Typically tied to a lease anniversary or a performance milestone such as rent payment history.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this guaranty record was first created in the Silver layer data product. Audit trail field for data lineage and compliance purposes.',
    `credit_risk_rating` STRING COMMENT 'Internal credit risk classification assigned to the guarantor based on financial statement review, credit bureau data, and underwriting analysis. Drives portfolio-level credit risk reporting and reserve calculations.. Valid values are `investment_grade|non_investment_grade|watch_list|unrated`',
    `current_guaranteed_amount` DECIMAL(18,2) COMMENT 'Present outstanding guaranteed amount after applying any burn-down reductions, partial releases, or enforcement recoveries. Reflects the landlords current credit risk exposure under this guaranty.',
    `docusign_envelope_code` STRING COMMENT 'Unique identifier of the DocuSign CLM envelope containing the executed guaranty instrument. Enables direct retrieval of the signed document from the contract lifecycle management system.',
    `effective_date` DATE COMMENT 'Date from which the guaranty obligation becomes operative and enforceable. May differ from execution date if the guaranty contains a deferred commencement provision.',
    `enforcement_date` DATE COMMENT 'Date on which the landlord formally initiated enforcement action against the guarantor (e.g., date of demand letter or filing of legal claim).',
    `enforcement_status` STRING COMMENT 'Current status of any enforcement action taken against the guarantor. demand_issued indicates a formal demand letter has been sent; litigation indicates legal proceedings are active; recovered indicates full or partial recovery has been achieved.. Valid values are `not_enforced|demand_issued|litigation|settled|recovered|written_off`',
    `execution_date` DATE COMMENT 'Date on which the guaranty instrument was fully executed (all parties signed). This is the principal business event date establishing the guaranty as legally binding.',
    `expiration_date` DATE COMMENT 'Date on which the guaranty obligation terminates by its own terms, independent of lease expiry. Null for guaranties that run co-terminus with the lease or until full performance.',
    `financial_covenant_required` BOOLEAN COMMENT 'Indicates whether the guaranty requires the guarantor to maintain specified financial covenants (e.g., minimum net worth, minimum liquidity ratio, maximum leverage). Critical for ongoing credit risk monitoring.',
    `financial_statement_frequency` STRING COMMENT 'Required frequency at which the guarantor must deliver financial statements to the landlord for covenant compliance monitoring.. Valid values are `annual|semi_annual|quarterly|on_demand`',
    `good_guy_notice_period_days` STRING COMMENT 'Number of days of advance written notice the tenant must provide to the landlord to trigger the good-guy guaranty release clause. Applicable only when guaranty_type is good_guy.',
    `good_guy_vacate_date` DATE COMMENT 'Actual date on which the tenant vacated the premises and surrendered possession, triggering the good-guy guaranty release. Populated upon confirmed surrender.',
    `governing_law_state` STRING COMMENT 'Two-letter US state code (or equivalent jurisdiction code) specifying the governing law under which the guaranty instrument is interpreted and enforced. Critical for legal enforcement strategy.. Valid values are `^[A-Z]{2}$`',
    `guaranteed_amount` DECIMAL(18,2) COMMENT 'Maximum monetary exposure covered by the guaranty at inception. For full guaranties, this equals the total lease obligation value; for limited guaranties, this is the capped dollar amount. Expressed in the lease currency.',
    `guaranteed_months` STRING COMMENT 'Number of months of lease obligations covered by the guaranty. Used for limited and rolling guaranty types where exposure is defined by a time window rather than a fixed dollar amount.',
    `guarantor_legal_name` STRING COMMENT 'Full legal name of the guarantor as stated in the executed guaranty instrument. For corporate guarantors, this is the registered entity name; for individuals, the full legal name as on government-issued ID.',
    `guarantor_type` STRING COMMENT 'Classification of the guarantor entity. individual is a natural person; corporate_parent is the tenants parent company; affiliate is a related entity; third_party_entity is an unrelated corporate guarantor; personal is a principal/owner of the tenant entity providing a personal guarantee.. Valid values are `individual|corporate_parent|affiliate|third_party_entity|personal`',
    `guaranty_status` STRING COMMENT 'Current lifecycle status of the guaranty obligation. active indicates the guaranty is in force; burned_down indicates the guaranteed amount has been reduced per schedule; enforced indicates a claim has been made against the guarantor; released indicates the landlord has formally discharged the guarantor.. Valid values are `active|pending_execution|expired|released|enforced|burned_down`',
    `guaranty_type` STRING COMMENT 'Classification of the guaranty structure. full covers all lease obligations for the full term; limited caps exposure by amount or period; good_guy releases guarantor upon tenant vacating and providing notice; rolling covers a fixed rolling window of rent; springing activates only upon a defined trigger event. [ENUM-REF-CANDIDATE: full|limited|good_guy|rolling|springing|burn_down|completion — promote to reference product]. Valid values are `full|limited|good_guy|rolling|springing`',
    `last_financial_statement_date` DATE COMMENT 'Date of the most recently received guarantor financial statement. Used to track compliance with financial reporting covenants and assess current creditworthiness.',
    `min_net_worth_covenant` DECIMAL(18,2) COMMENT 'Minimum net worth the guarantor must maintain throughout the guaranty term as a financial covenant condition. Breach of this threshold may constitute a guaranty default or trigger a springing guaranty.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, enforcement history narrative, or legal counsel observations regarding this guaranty that do not fit structured fields.',
    `personal_guarantee_flag` BOOLEAN COMMENT 'Indicates whether this guaranty is a personal guarantee provided by an individual (principal, officer, or owner of the tenant entity) as opposed to a corporate or entity guarantee. Drives different enforcement and credit risk treatment.',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for the guaranty instrument, typically assigned by DocuSign CLM or Yardi Voyager at execution. Used for cross-system reconciliation and legal document referencing.',
    `release_date` DATE COMMENT 'Date on which the landlord formally released the guarantor from all obligations under the guaranty instrument. Populated when guaranty_status transitions to released.',
    `release_reason` STRING COMMENT 'Business reason for the formal release of the guarantor. Tracks whether release was triggered by lease expiry, early termination, good-guy clause activation, full burn-down, landlord waiver, or lease assignment to a creditworthy assignee.. Valid values are `lease_expiry|lease_termination|good_guy_trigger|burn_down_complete|landlord_waiver|assignment`',
    `springing_trigger_description` STRING COMMENT 'Narrative description of the condition(s) that activate a springing guaranty (e.g., tenant credit rating downgrade below investment grade, tenant default on another obligation, change of control). Applicable only when guaranty_type is springing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this guaranty record in the Silver layer. Used for incremental data pipeline processing and audit trail compliance.',
    `yardi_guaranty_ref` STRING COMMENT 'Source system reference identifier for this guaranty record in Yardi Voyager. Used for cross-system reconciliation between the Silver layer and the operational system of record.',
    CONSTRAINT pk_guaranty PRIMARY KEY(`guaranty_id`)
) COMMENT 'Tracks lease guaranty and guarantor obligations for commercial lease agreements. Captures guarantor identity (individual, corporate parent, or entity), guaranty type (full, limited, good-guy, rolling), guaranteed amount or period, burn-down schedule, guarantor financial covenants, guaranty expiration triggers, and enforcement status. Critical for landlord credit risk management on commercial leases where tenant creditworthiness depends on a third-party guarantee. Sourced from DocuSign CLM and Yardi Voyager.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_guaranty_id` FOREIGN KEY (`guaranty_id`) REFERENCES `real_estate_ecm`.`lease`.`guaranty`(`guaranty_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_cam_schedule_id` FOREIGN KEY (`cam_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_schedule`(`cam_schedule_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_percentage_rent_id` FOREIGN KEY (`percentage_rent_id`) REFERENCES `real_estate_ecm`.`lease`.`percentage_rent`(`percentage_rent_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_ti_allowance_id` FOREIGN KEY (`ti_allowance_id`) REFERENCES `real_estate_ecm`.`lease`.`ti_allowance`(`ti_allowance_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_tertiary_security_lease_lease_agreement_id` FOREIGN KEY (`tertiary_security_lease_lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_cam_schedule_id` FOREIGN KEY (`cam_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_schedule`(`cam_schedule_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_percentage_rent_id` FOREIGN KEY (`percentage_rent_id`) REFERENCES `real_estate_ecm`.`lease`.`percentage_rent`(`percentage_rent_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_ti_allowance_id` FOREIGN KEY (`ti_allowance_id`) REFERENCES `real_estate_ecm`.`lease`.`ti_allowance`(`ti_allowance_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_replaced_guaranty_id` FOREIGN KEY (`replaced_guaranty_id`) REFERENCES `real_estate_ecm`.`lease`.`guaranty`(`guaranty_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`lease` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`lease` SET TAGS ('dbx_domain' = 'lease');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `market_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `assignment_permitted` SET TAGS ('dbx_business_glossary_term' = 'Assignment Permitted Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `base_rent_monthly` SET TAGS ('dbx_business_glossary_term' = 'Monthly Base Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `base_rent_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `base_rent_psf_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `base_rent_psf_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `cam_annual_budget` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Annual Budget');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `cam_annual_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `cam_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Reconciliation Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `co_tenancy_clause` SET TAGS ('dbx_business_glossary_term' = 'Co-Tenancy Clause Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `exclusivity_clause` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Execution Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Period (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `holdover_rent_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Holdover Rent Multiplier');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `insurance_required_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Insurance Coverage Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_classification` SET TAGS ('dbx_business_glossary_term' = 'Lease Classification (ASC 842 / IFRS 16)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_classification` SET TAGS ('dbx_value_regex' = 'operating|finance');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_liability` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_liability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Number');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'draft|executed|active|expired|terminated|holdover');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `leased_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Leased Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `loi_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `permitted_use` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'commercial|residential');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'Pro-Rata Share');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `renewal_option_exercised` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Exercised Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `renewal_option_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Term (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `rent_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Rent Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percent|cpi|fixed_amount|none');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Value');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `snda_executed` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment (SNDA) Agreement Executed Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `subletting_permitted` SET TAGS ('dbx_business_glossary_term' = 'Subletting Permitted Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `termination_option_date` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Option Date');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `ti_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ALTER COLUMN `ti_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment ID');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^AMD-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_execution|executed|voided|superseded');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `asc842_modification_type` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Lease Modification Type');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `asc842_modification_type` SET TAGS ('dbx_value_regex' = 'separate_contract|modification_of_existing|not_applicable');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `cam_revised` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Revised Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_value_regex' = '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `docusign_status` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope Status');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `docusign_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|completed|declined|voided');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `landlord_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Landlord Signature Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `lender_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Lender Consent Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `lender_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Lender Consent Required Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `permitted_use_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Permitted Use');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `permitted_use_revised` SET TAGS ('dbx_business_glossary_term' = 'Revised Permitted Use');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `prior_base_rent_monthly` SET TAGS ('dbx_business_glossary_term' = 'Prior Monthly Base Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `prior_base_rent_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `prior_gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Prior Gross Leasable Area (GLA) Square Feet');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `remeasurement_required` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Remeasurement Required Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `renewal_option_revised` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Revised Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `rent_abatement_months` SET TAGS ('dbx_business_glossary_term' = 'Rent Abatement Period (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `rent_abatement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rent Abatement Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percentage|cpi_indexed|fixed_amount|market_review|none');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_base_rent_monthly` SET TAGS ('dbx_business_glossary_term' = 'Revised Monthly Base Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_base_rent_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Revised Gross Leasable Area (GLA) Square Feet');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_rent_psf_annual` SET TAGS ('dbx_business_glossary_term' = 'Revised Annual Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `revised_rent_psf_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Amendment Sequence Number');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `snda_included` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment (SNDA) Included Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `tenant_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Signature Date');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `ti_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `ti_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ALTER COLUMN `yardi_amendment_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Amendment Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option ID');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `abstract_source` SET TAGS ('dbx_business_glossary_term' = 'Abstract Source');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `abstract_source` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|manual_entry|docusign_clm');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `abstracted_by` SET TAGS ('dbx_business_glossary_term' = 'Abstracted By');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `abstracted_date` SET TAGS ('dbx_business_glossary_term' = 'Abstracted Date');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `asc842_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Assessment Date');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `asc842_reasonably_certain` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Reasonably Certain to Exercise');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `asc842_reassessment_trigger` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Reassessment Trigger');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `asc842_reassessment_trigger` SET TAGS ('dbx_value_regex' = 'significant_event|change_in_circumstances|periodic_review|none');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `cam_applicable` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Applicable');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `cpi_base_index` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Base Index');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `cpi_cap_percent` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Cap Percentage');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `cpi_floor_percent` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Floor Percentage');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Exercise Date');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Exercise Status');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `exercise_status` SET TAGS ('dbx_value_regex' = 'unexercised|exercised|expired|waived|pending_exercise');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `fixed_renewal_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Fixed Renewal Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `fixed_renewal_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `fmv_appraisal_required` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Appraisal Required');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `fmv_determination_method` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Determination Method');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `fmv_determination_method` SET TAGS ('dbx_value_regex' = 'single_appraiser|dual_appraiser|arbitration|mutual_agreement');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `no_default_condition` SET TAGS ('dbx_business_glossary_term' = 'No Default Condition');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `notice_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Deadline Date');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_end_date` SET TAGS ('dbx_business_glossary_term' = 'Option End Date');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_number` SET TAGS ('dbx_business_glossary_term' = 'Option Number');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Option Reference Code');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_start_date` SET TAGS ('dbx_business_glossary_term' = 'Option Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_term_months` SET TAGS ('dbx_business_glossary_term' = 'Option Term (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_term_years` SET TAGS ('dbx_business_glossary_term' = 'Option Term (Years)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'renewal|extension|holdover|purchase_option');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `personal_guarantee_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Guarantee Required');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `renewal_rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Renewal Rent Escalation Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `renewal_rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `renewal_rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percent|cpi|fixed_amount|none');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `rent_reset_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Rent Reset Mechanism');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `rent_reset_mechanism` SET TAGS ('dbx_value_regex' = 'fixed|cpi|fair_market_value|negotiated|stepped');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `snda_required` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment (SNDA) Required');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `ti_allowance_total` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Total');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `ti_allowance_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verified Date');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Termination ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `guaranty_id` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `sublease_id` SET TAGS ('dbx_business_glossary_term' = 'Sublease Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `ar_settlement_complete` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Settlement Complete Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `asc842_derecognition_complete` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Derecognition Complete Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cure Period (Days)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `cure_period_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Effective Date');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Fee Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `fee_waived` SET TAGS ('dbx_business_glossary_term' = 'Termination Fee Waived Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `gain_loss_on_termination` SET TAGS ('dbx_business_glossary_term' = 'Gain/Loss on Lease Termination');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `gain_loss_on_termination` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `holdover_rent_rate` SET TAGS ('dbx_business_glossary_term' = 'Holdover Rent Rate (Per Square Foot)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `holdover_rent_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `holdover_status_at_termination` SET TAGS ('dbx_business_glossary_term' = 'Holdover Status at Termination');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `initiating_party` SET TAGS ('dbx_business_glossary_term' = 'Termination Initiating Party');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `initiating_party` SET TAGS ('dbx_value_regex' = 'landlord|tenant|mutual|court_order');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `keys_returned` SET TAGS ('dbx_business_glossary_term' = 'Keys Returned Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `lease_classification` SET TAGS ('dbx_business_glossary_term' = 'Lease Classification');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `lease_classification` SET TAGS ('dbx_value_regex' = 'finance_lease|operating_lease');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `lease_liability_derecognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Derecognition Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `lease_liability_derecognition_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Date');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `original_lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Original Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `outstanding_ar_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Accounts Receivable (AR) Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `outstanding_ar_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `possession_return_date` SET TAGS ('dbx_business_glossary_term' = 'Final Possession Return Date');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `restoration_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Restoration Cost Estimate');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `restoration_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `restoration_required` SET TAGS ('dbx_business_glossary_term' = 'Restoration Required Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `rou_asset_derecognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Derecognition Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `rou_asset_derecognition_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_forfeited_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Forfeited Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_forfeited_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_processed` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Processed Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_return_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Return Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `security_deposit_return_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `space_condition_at_surrender` SET TAGS ('dbx_business_glossary_term' = 'Space Condition at Surrender');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `space_condition_at_surrender` SET TAGS ('dbx_value_regex' = 'broom_clean|good_condition|minor_damage|major_damage|requires_remediation');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_number` SET TAGS ('dbx_business_glossary_term' = 'Termination Reference Number');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_number` SET TAGS ('dbx_value_regex' = '^TERM-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Status');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_value_regex' = 'pending|notice_issued|in_cure_period|executed|completed|cancelled');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'early_termination|mutual_surrender|lease_expiration|default_termination|holdover_resolution|condemnation');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `unamortized_ti_balance` SET TAGS ('dbx_business_glossary_term' = 'Unamortized Tenant Improvement (TI) Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `unamortized_ti_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ALTER COLUMN `yardi_termination_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Termination Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule ID');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Demised Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement ID');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `annual_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Rent Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `annual_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `base_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `cpi_base_value` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Base Value');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `cpi_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Escalation Cap Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `cpi_floor_rate` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Escalation Floor Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `cpi_index_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Index Name');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Lease Discount Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rent Step Effective End Date');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rent Step Effective Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `escalation_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Fixed Dollar Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `escalation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_step|cpi|percentage_of_sales|market_review|none');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Rent Payment Grace Period Days');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `is_free_rent_period` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Period Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `late_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `lease_classification` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 / IFRS 16 Lease Classification');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `lease_classification` SET TAGS ('dbx_value_regex' = 'operating|finance');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `lease_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `lease_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `leased_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Leased Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Rent Payment Due Day of Month');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rent Payment Frequency');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `percentage_rent_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Natural Breakpoint');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `percentage_rent_breakpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `percentage_rent_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `rou_asset_amount` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `rou_asset_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Number');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Status');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|future|expired|superseded|cancelled');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'yardi|mri|argus|manual');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference Key');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rent Step Sequence Number');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `straight_line_rent_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Straight-Line Rent Adjustment');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `straight_line_rent_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `straight_line_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Straight-Line Rent Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `straight_line_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cam Schedule Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Demised Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `actual_cam_gross` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Common Area Maintenance (CAM) Operating Expense');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `actual_cam_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `actual_cam_grossed_up` SET TAGS ('dbx_business_glossary_term' = 'Actual Grossed-Up Common Area Maintenance (CAM) Expense');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `actual_cam_grossed_up` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `actual_cam_psf` SET TAGS ('dbx_business_glossary_term' = 'Actual Common Area Maintenance (CAM) Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `admin_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Administration Fee Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `admin_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `admin_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Administration Fee Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `audit_right_exercised` SET TAGS ('dbx_business_glossary_term' = 'Tenant CAM Audit Right Exercised Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `building_gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Building Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_cap_applied` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Cap Applied Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Annual Increase Cap Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_cap_savings` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Cap Savings Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_cap_savings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_cap_type` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Cap Type');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_cap_type` SET TAGS ('dbx_value_regex' = 'cumulative|non_cumulative|none');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_exclusions_amount` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Exclusions Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `cam_exclusions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `credit_or_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'CAM Credit or Additional Charge Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `credit_or_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `credit_or_charge_type` SET TAGS ('dbx_business_glossary_term' = 'CAM Credit or Charge Type');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `credit_or_charge_type` SET TAGS ('dbx_value_regex' = 'additional_charge|credit|zero_balance');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Dispute Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Dispute Reason');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `dispute_resolved_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Dispute Resolved Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `estimated_cam_annual` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Common Area Maintenance (CAM) Charge');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `estimated_cam_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `estimated_cam_psf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Common Area Maintenance (CAM) Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `grossup_factor` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Gross-Up Factor');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Payment Due Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Payment Received Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `prior_year_estimated_cam` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Estimated Common Area Maintenance (CAM) Charge');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `prior_year_estimated_cam` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Number');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Statement Sent Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Status');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|finalized|disputed|settled|voided');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_variance` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Variance');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `reconciliation_year` SET TAGS ('dbx_business_glossary_term' = 'CAM Reconciliation Year');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tenant_cam_allocated` SET TAGS ('dbx_business_glossary_term' = 'Tenant Allocated Common Area Maintenance (CAM) Charge');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tenant_cam_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tenant_nla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Tenant Net Leasable Area (NLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tenant_prorata_share` SET TAGS ('dbx_business_glossary_term' = 'Tenant Pro-Rata Share');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `tenant_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant CAM Response Due Date');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ALTER COLUMN `yardi_cam_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager CAM Batch ID');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ti_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Ti Allowance Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `construction_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Demised Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `allowance_status` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Status');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Type');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'landlord_work|tenant_work|turnkey|cash_allowance|loan_structured');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `approved_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Tenant Improvement (TI) Spend Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `approved_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `asc842_lease_incentive_flag` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Lease Incentive Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `construction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Construction Completion Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Construction Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `coo_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Received Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Tenant Improvement (TI) Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Disbursement Method');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'lump_sum|milestone_based|invoice_reimbursement|rent_credit|loan_advance');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `disbursement_milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Disbursement Milestone Count');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Effective Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ifrs16_lease_incentive_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Incentive Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Tenant Improvement (TI) Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `is_loan_structured` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Loan Structured Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `landlord_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Landlord Approval Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `landlord_work_scope` SET TAGS ('dbx_business_glossary_term' = 'Landlord Work Scope Description');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `leasable_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area (NLA) Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `lien_waiver_received` SET TAGS ('dbx_business_glossary_term' = 'Lien Waiver Received Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `lien_waiver_required` SET TAGS ('dbx_business_glossary_term' = 'Lien Waiver Required Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `loan_amortization_months` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Loan Amortization Period (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `loan_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Loan Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `loan_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Loan Interest Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `loan_interest_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `milestones_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Milestones Completed Count');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `procore_project_code` SET TAGS ('dbx_business_glossary_term' = 'Procore Project ID');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Tenant Improvement (TI) Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `tenant_work_scope` SET TAGS ('dbx_business_glossary_term' = 'Tenant Work Scope Description');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ti_allowance_number` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Number');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ti_allowance_number` SET TAGS ('dbx_value_regex' = '^TIA-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ti_amount_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Amount Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `ti_amount_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tenant Improvement (TI) Budget Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `work_letter_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Letter Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ALTER COLUMN `yardi_ti_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Tenant Improvement (TI) Code');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Clause Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `sublease_id` SET TAGS ('dbx_business_glossary_term' = 'Sublease Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `abstract_source` SET TAGS ('dbx_business_glossary_term' = 'Clause Abstract Source System');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `abstract_source` SET TAGS ('dbx_value_regex' = 'docusign_clm|yardi_voyager|mri_software|manual|other');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `abstracted_by` SET TAGS ('dbx_business_glossary_term' = 'Clause Abstracted By');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `abstracted_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Abstracted Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `area_threshold_sqf` SET TAGS ('dbx_business_glossary_term' = 'Clause Area Threshold (Square Feet)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `asc842_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Lease Accounting Impact Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `clause_status` SET TAGS ('dbx_business_glossary_term' = 'Clause Status');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `clause_status` SET TAGS ('dbx_value_regex' = 'active|inactive|triggered|waived|expired|superseded');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `clause_type` SET TAGS ('dbx_business_glossary_term' = 'Clause Type');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `co_tenancy_anchor_tenant` SET TAGS ('dbx_business_glossary_term' = 'Co-Tenancy Anchor Tenant Name');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Effective Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `exclusivity_use_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Use Category');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Exercise Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `exercising_party` SET TAGS ('dbx_business_glossary_term' = 'Clause Exercising Party');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `exercising_party` SET TAGS ('dbx_value_regex' = 'landlord|tenant|either|third_party');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `ifrs16_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Accounting Impact Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `is_mutual` SET TAGS ('dbx_business_glossary_term' = 'Mutual Clause Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `is_negotiated` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Clause Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `is_triggered` SET TAGS ('dbx_business_glossary_term' = 'Clause Triggered Indicator');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `lease_section_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Section Number');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `monetary_threshold` SET TAGS ('dbx_business_glossary_term' = 'Clause Monetary Threshold');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `monetary_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `monetary_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Clause Monetary Threshold Currency');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `monetary_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Clause Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `notice_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Notice Deadline Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Clause Notice Period (Days)');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Clause Priority Order');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Clause Reference Code');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `rent_abatement_percent` SET TAGS ('dbx_business_glossary_term' = 'Clause Rent Abatement Percentage');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `rent_abatement_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Clause Risk Rating');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Clause Termination Penalty Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `text_summary` SET TAGS ('dbx_business_glossary_term' = 'Clause Text Summary');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `text_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Clause Title');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Trigger Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `trigger_description` SET TAGS ('dbx_business_glossary_term' = 'Clause Trigger Description');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Clause Verified By');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Clause Verified Date');
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ALTER COLUMN `yardi_clause_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Clause ID');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'Demised Space Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `asc842_lease_classification` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Lease Classification');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `asc842_lease_classification` SET TAGS ('dbx_value_regex' = 'operating|finance');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `base_rent_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `base_rent_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `base_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `base_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `cam_applicable` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Applicable');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `cam_estimate_psf` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Estimate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `cam_estimate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `expansion_option` SET TAGS ('dbx_business_glossary_term' = 'Expansion Option');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `gla_sqf` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `gla_sqm` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Meters');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `is_primary_space` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Space');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `lease_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `lease_liability_value` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Value');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `lease_liability_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `nla_sqf` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area (NLA) in Square Feet');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `possession_date` SET TAGS ('dbx_business_glossary_term' = 'Possession Date');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'Pro Rata Share');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rent_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Rent Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rent_currency` SET TAGS ('dbx_business_glossary_term' = 'Rent Currency');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rent_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percent|cpi|fixed_amount|market_review|stepped|none');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `right_of_first_refusal` SET TAGS ('dbx_business_glossary_term' = 'Right of First Refusal (ROFR)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Value');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_abstract_notes` SET TAGS ('dbx_business_glossary_term' = 'Space Abstract Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_configuration` SET TAGS ('dbx_business_glossary_term' = 'Space Configuration');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_configuration` SET TAGS ('dbx_value_regex' = 'open_plan|private_offices|mixed|shell|fitted_out|cold_dark_shell');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Space Reference Code');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_status` SET TAGS ('dbx_business_glossary_term' = 'Space Status');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `space_status` SET TAGS ('dbx_value_regex' = 'active|inactive|vacant|under_renovation|surrendered|pending');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `ti_allowance_total` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Total');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `ti_allowance_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `usable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Usable Area in Square Feet');
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ALTER COLUMN `yardi_space_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Space Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice ID');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `billable_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Charge Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `cam_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cam Reconciliation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `percentage_rent_id` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `sublease_id` SET TAGS ('dbx_business_glossary_term' = 'Sublease Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `ti_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Ti Allowance Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_applied` SET TAGS ('dbx_business_glossary_term' = 'Amount Applied');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_due` SET TAGS ('dbx_business_glossary_term' = 'Amount Due');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_due` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_due` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `amount_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `applied_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Applied Period End Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `applied_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Applied Period Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'base_rent|cam|security_deposit|late_fee|ti_reimbursement|percentage_rent');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `is_delinquent` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `late_fee_assessed` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Assessed Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `late_fee_assessed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `late_fee_assessed` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `late_fee_waived` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Waived Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `nsf_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `nsf_return_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Return Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|credit_card|lockbox|cash');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|voided|returned|on_hold');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'nsf|data_entry_error|duplicate_payment|tenant_dispute|bank_return|void');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `yardi_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Batch Number');
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ALTER COLUMN `yardi_receipt_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Receipt ID');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `tertiary_security_lease_lease_agreement_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Tenant Credit Risk Rating');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_value_regex' = 'investment_grade|non_investment_grade|speculative|unrated');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deduction_notes` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Deduction Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deduction_reason` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Deduction Reason');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deduction_reason` SET TAGS ('dbx_value_regex' = 'unpaid_rent|property_damage|cleaning_charges|lease_break_fee|outstanding_cam|other');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_months_rent` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Months of Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_received_date` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Received Date');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Reference Number');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_return_date` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Return Date');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Status');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'active|partially_applied|fully_applied|returned|forfeited|pending_return');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Type');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_value_regex' = 'cash|letter_of_credit|surety_bond|escrow|guarantee');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `held_amount` SET TAGS ('dbx_business_glossary_term' = 'Held Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `held_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `interest_bearing` SET TAGS ('dbx_business_glossary_term' = 'Interest-Bearing Deposit Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Interest Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `loc_amount` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LOC) Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `loc_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `loc_auto_renew` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LOC) Auto-Renewal Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `loc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LOC) Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `loc_issuer_name` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LOC) Issuer Name');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `loc_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LOC) Number');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `next_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Deposit Reduction Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `next_reduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `next_reduction_date` SET TAGS ('dbx_business_glossary_term' = 'Next Deposit Reduction Date');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `personal_guarantee_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Guarantee Required Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `reduction_schedule_applicable` SET TAGS ('dbx_business_glossary_term' = 'Deposit Reduction Schedule Applicable Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `required_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Security Deposit Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `required_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `return_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Return Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `return_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `return_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Return Deadline Date');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `return_processed` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Return Processed Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `surety_bond_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Surety Bond Expiry Date');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `surety_bond_issuer` SET TAGS ('dbx_business_glossary_term' = 'Surety Bond Issuer Name');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `surety_bond_number` SET TAGS ('dbx_business_glossary_term' = 'Surety Bond Number');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ALTER COLUMN `yardi_deposit_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Deposit Code');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `percentage_rent_id` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent ID');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Demised Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `applicable_breakpoint_amount` SET TAGS ('dbx_business_glossary_term' = 'Applicable Breakpoint Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `ar_invoice_ref` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `artificial_breakpoint_amount` SET TAGS ('dbx_business_glossary_term' = 'Artificial Breakpoint Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Completion Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `audit_right_exercised` SET TAGS ('dbx_business_glossary_term' = 'Audit Right Exercised Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `audit_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Variance Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `audited_gross_sales` SET TAGS ('dbx_business_glossary_term' = 'Audited Gross Sales');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `audited_gross_sales` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `breakpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Breakpoint Type');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `breakpoint_type` SET TAGS ('dbx_value_regex' = 'natural|artificial');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `lease_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Structure Type');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `lease_structure_type` SET TAGS ('dbx_value_regex' = 'nnn|gross|modified_gross|net|double_net');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `lease_year_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Year Number');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `natural_breakpoint_amount` SET TAGS ('dbx_business_glossary_term' = 'Natural Breakpoint Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `net_sales_for_calculation` SET TAGS ('dbx_business_glossary_term' = 'Net Sales for Percentage Rent Calculation');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `net_sales_for_calculation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Payment Due Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `pct_rent_billed` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Billed');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `pct_rent_calculated` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Calculated');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `pct_rent_collected` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Collected');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reported_gross_sales` SET TAGS ('dbx_business_glossary_term' = 'Reported Gross Sales');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reported_gross_sales` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `sales_exclusions_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Exclusions Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `sales_over_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Sales Over Breakpoint');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `sales_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Due Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `sales_report_late` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Late Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `sales_report_received_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Received Date');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `tiered_rate_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tiered Rate Applicable Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ALTER COLUMN `yardi_pct_rent_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Percentage Rent Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `accounting_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `cam_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cam Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `percentage_rent_id` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rent Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `sublease_id` SET TAGS ('dbx_business_glossary_term' = 'Sublease Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `ti_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Ti Allowance Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `accounting_period_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Date');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Lease Discount Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `entry_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Reference Number');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Status');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|adjusted|under_review');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Type');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'initial_recognition|subsequent_measurement|remeasurement|termination|modification|disclosure_summary');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code (ISO 4217)');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `interest_expense` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Interest Expense');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_classification` SET TAGS ('dbx_business_glossary_term' = 'Lease Classification');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_classification` SET TAGS ('dbx_value_regex' = 'operating|finance|short_term|low_value');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_incentive_received` SET TAGS ('dbx_business_glossary_term' = 'Lease Incentive Received');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_liability_closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Closing Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_liability_opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Opening Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `lease_liability_remeasurement` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Remeasurement Adjustment');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `maturity_after_year5_payments` SET TAGS ('dbx_business_glossary_term' = 'Lease Maturity Analysis — After Year 5 Undiscounted Payments');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `maturity_year1_payments` SET TAGS ('dbx_business_glossary_term' = 'Lease Maturity Analysis — Year 1 Undiscounted Payments');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `maturity_year2_to5_payments` SET TAGS ('dbx_business_glossary_term' = 'Lease Maturity Analysis — Years 2–5 Undiscounted Payments');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Modification Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `practical_expedient_applied` SET TAGS ('dbx_business_glossary_term' = 'Practical Expedient Applied');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `practical_expedient_applied` SET TAGS ('dbx_value_regex' = 'none|short_term|low_value|portfolio|hindsight');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `principal_repayment` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Principal Repayment');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `rou_asset_additions` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Additions');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `rou_asset_amortisation` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Amortisation');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `rou_asset_closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Closing Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `rou_asset_impairment` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Impairment');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `rou_asset_opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Opening Balance');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `short_term_lease_cost` SET TAGS ('dbx_business_glossary_term' = 'Short-Term Lease Cost');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `straight_line_rent_expense` SET TAGS ('dbx_business_glossary_term' = 'Straight-Line Rent Expense');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `sublease_income` SET TAGS ('dbx_business_glossary_term' = 'Sublease Income');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `variable_lease_cost` SET TAGS ('dbx_business_glossary_term' = 'Variable Lease Cost');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `weighted_avg_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Discount Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ALTER COLUMN `weighted_avg_remaining_term_years` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Remaining Lease Term (WALT) in Years');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_id` SET TAGS ('dbx_business_glossary_term' = 'Sublease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Head Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `market_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Sublessor Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rent Schedule Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_subtenant_profile_tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Subtenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_tenant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `abstracted_by` SET TAGS ('dbx_business_glossary_term' = 'Abstracted By');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `abstracted_date` SET TAGS ('dbx_business_glossary_term' = 'Abstracted Date');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `asc842_sublease_classification` SET TAGS ('dbx_business_glossary_term' = 'ASC 842 Sublease Classification');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `asc842_sublease_classification` SET TAGS ('dbx_value_regex' = 'operating|finance|not_classified');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `cam_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Annual Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `cam_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `cam_applicable` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Applicable');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Sublease Commencement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percent');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `early_termination_option` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Option');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Sublease Execution Date');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Sublease Expiration Date');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Free Rent Months');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_business_glossary_term' = 'Governing Law State');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `head_lease_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Head Lease Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `head_lease_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `ifrs16_sublease_classification` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Sublease Classification');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `ifrs16_sublease_classification` SET TAGS ('dbx_value_regex' = 'operating|finance|not_classified');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `landlord_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Landlord Consent Date');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `landlord_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Landlord Consent Required');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `landlord_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Landlord Consent Status');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `landlord_consent_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|conditional');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `net_investment_in_sublease` SET TAGS ('dbx_business_glossary_term' = 'Net Investment in Sublease');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `net_investment_in_sublease` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `profit_loss_on_sublease` SET TAGS ('dbx_business_glossary_term' = 'Profit / Loss on Sublease');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `profit_loss_on_sublease` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Sublease Reference Number');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `renewal_option_available` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Available');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_annual` SET TAGS ('dbx_business_glossary_term' = 'Sublease Annual Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed|cpi|fmv|none|stepped');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_monthly` SET TAGS ('dbx_business_glossary_term' = 'Sublease Monthly Rent');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Sublease Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rou_asset_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Allocated Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `rou_asset_allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_status` SET TAGS ('dbx_business_glossary_term' = 'Sublease Status');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_status` SET TAGS ('dbx_value_regex' = 'draft|pending_consent|active|expired|terminated|holdover');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_type` SET TAGS ('dbx_business_glossary_term' = 'Sublease Type');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublease_type` SET TAGS ('dbx_value_regex' = 'full_assignment|partial_sublease|master_sublease|short_term_sublease');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `sublet_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Sublet Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Sublease Term (Months)');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ALTER COLUMN `yardi_sublease_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Sublease Reference');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranty_id` SET TAGS ('dbx_business_glossary_term' = 'Guaranty ID');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Entity Identifier');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `industry_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `replaced_guaranty_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant ID');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `abstracted_by` SET TAGS ('dbx_business_glossary_term' = 'Abstracted By');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `abstracted_date` SET TAGS ('dbx_business_glossary_term' = 'Abstracted Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `amount_recovered` SET TAGS ('dbx_business_glossary_term' = 'Amount Recovered from Guarantor');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `amount_recovered` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `burn_down_applicable` SET TAGS ('dbx_business_glossary_term' = 'Burn-Down Schedule Applicable');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `burn_down_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Burn-Down Interval Months');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `burn_down_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Burn-Down Reduction Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `burn_down_reduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `burn_down_reduction_pct` SET TAGS ('dbx_business_glossary_term' = 'Burn-Down Reduction Percentage');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `burn_down_start_date` SET TAGS ('dbx_business_glossary_term' = 'Burn-Down Start Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Credit Risk Rating');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_value_regex' = 'investment_grade|non_investment_grade|watch_list|unrated');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `current_guaranteed_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Guaranteed Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `current_guaranteed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Effective Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `enforcement_date` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Enforcement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Enforcement Status');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'not_enforced|demand_issued|litigation|settled|recovered|written_off');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Execution Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Expiration Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `financial_covenant_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Covenant Required');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `financial_statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Delivery Frequency');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `financial_statement_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|on_demand');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `good_guy_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Good-Guy Notice Period Days');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `good_guy_vacate_date` SET TAGS ('dbx_business_glossary_term' = 'Good-Guy Vacate Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_business_glossary_term' = 'Governing Law State');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Amount');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranteed_months` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Period Months');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guarantor_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Legal Name');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guarantor_legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Type');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guarantor_type` SET TAGS ('dbx_value_regex' = 'individual|corporate_parent|affiliate|third_party_entity|personal');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranty_status` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Status');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranty_status` SET TAGS ('dbx_value_regex' = 'active|pending_execution|expired|released|enforced|burned_down');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranty_type` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Type');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `guaranty_type` SET TAGS ('dbx_value_regex' = 'full|limited|good_guy|rolling|springing');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `last_financial_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Financial Statement Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `min_net_worth_covenant` SET TAGS ('dbx_business_glossary_term' = 'Minimum Net Worth Covenant');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `min_net_worth_covenant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Notes');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `personal_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Guarantee Flag');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Reference Number');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Release Date');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Guaranty Release Reason');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `release_reason` SET TAGS ('dbx_value_regex' = 'lease_expiry|lease_termination|good_guy_trigger|burn_down_complete|landlord_waiver|assignment');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `springing_trigger_description` SET TAGS ('dbx_business_glossary_term' = 'Springing Guaranty Trigger Description');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ALTER COLUMN `yardi_guaranty_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Guaranty Reference');
