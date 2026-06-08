-- Schema for Domain: brokerage | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`brokerage` COMMENT 'Manages sales and leasing brokerage activity including deal pipelines, listing agreements, commission structures, co-broker arrangements, MLS/CoStar listing syndication, and agent/broker licensing. Tracks production metrics, prospect management, brokerage agreements, and Salesforce CRM deal stages from prospect to close. Supports both buy-side and sell-side brokerage operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`listing` (
    `listing_id` BIGINT COMMENT 'Unique surrogate identifier for the property listing record in the brokerage data platform. Primary key for the listing entity.',
    `asset_id` BIGINT COMMENT 'Reference to the underlying property asset being listed. Links the listing to the master property record.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed agent or broker responsible for originating and managing this listing.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Building class (A/B/C) on a listing drives rent benchmarking, cap rate expectations, REIT eligibility assessment, and investor targeting. Brokers use standardized building class to position listings i',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Commercial listings reference a specific building within a multi-building asset for building class, floor count, LEED certification, and parking ratio. Brokers and tenants search by building. asset_id',
    `green_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.green_certification. Business justification: Green certifications (LEED, ENERGY STAR) directly affect listing price, ESG disclosure requirements, and marketing. leed_certification and energy_star_rating are denormalized text fields; compliance.g',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Commercial and residential listings require verified active permits (COO, zoning, building permits) as mandatory disclosure obligations. Brokers must confirm permit status before listing. Linking list',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Listing coordinators (employees distinct from the listing broker) manage marketing, MLS submissions, and showing schedules. Operational reporting on listing workload and staff productivity requires th',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-market and cross-border listing pricing requires standardized currency classification for financial reporting, FX conversion, and investment analytics. currency_code is a denormalized reference ',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Listings are associated with marketing and leasing budgets. Asset managers track marketing spend per listing against approved budgets — a standard real estate asset management reporting process requir',
    `market_survey_id` BIGINT COMMENT 'Foreign key linking to marketing.market_survey. Business justification: Listings are priced against current market survey data (avg asking rent PSF, vacancy rates, concessions). Linking a listing to the market survey used for pricing is standard brokerage practice and sup',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial listings are for specific leasable spaces. CoStar/MLS syndication requires space-level data (rentable area, availability date, condition). Listing must reference the space record to reflect',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: MLS syndication, CoStar reporting, and commission benchmarking all require standardized property type classification. Brokers use property type to determine applicable lease structures, TI benchmarks,',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease type on a listing drives CAM recovery rules, TI allowance benchmarks, ASC 842 classification, and commission structure. Brokers and tenants rely on standardized lease type definitions to price a',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market and submarket classification drives CoStar reporting, competitive market analysis, broker performance dashboards, and investment benchmarking. Standardized geographic hierarchy is required for ',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to reference.sustainability_rating. Business justification: ESG reporting, green building premium rent analysis, and GRESB scoring require standardized sustainability certification references. Brokers market LEED/Energy Star certifications to attract ESG-focus',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type determines regulatory disclosures (HUD, SEC), 1031 eligibility, required document checklist, and commission applicability. Every listing must be classified by a standardized transacti',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential/multifamily listings are for specific units. MLS syndication and leasing platforms require unit-level data (bedroom count, floor, availability date). Listing must reference the unit record',
    `zoning_code_id` BIGINT COMMENT 'Foreign key linking to reference.zoning_code. Business justification: Zoning classification on a listing is required for permitted-use disclosure, buyer/tenant due diligence, and regulatory compliance. Brokers must reference standardized zoning definitions to confirm pe',
    `cam_rate_psf` DECIMAL(18,2) COMMENT 'Estimated annual Common Area Maintenance (CAM) charge per square foot applicable to the lease listing. Used in total occupancy cost analysis for tenant prospects.',
    `close_date` DATE COMMENT 'The date on which the transaction was completed — sale closed or lease executed. Null for active or pending listings. Used for production reporting and commission trigger.',
    `close_price` DECIMAL(18,2) COMMENT 'The final agreed transaction price at which the property was sold or the lease was executed. Used for comparable sales analysis, commission calculation, and investment performance reporting.',
    `co_broker_commission_pct` DECIMAL(18,2) COMMENT 'The portion of the total commission allocated to the cooperating or buy-side broker in a co-brokerage arrangement. Null if no co-broker is involved.',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The agreed brokerage commission rate expressed as a percentage of the transaction price or lease value. Drives commission payable calculations and co-broker split agreements.',
    `costar_code` STRING COMMENT 'CoStar Suite-assigned identifier for this listing, used for commercial property syndication, market research, and comparable data alignment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the listing record was first created in the data platform. Used for audit trail, data lineage, and Silver layer ingestion tracking.',
    `days_on_market` STRING COMMENT 'Number of calendar days the listing has been active on the market, calculated from listing_start_date to the current date or close date. Key performance metric for brokerage production reporting.',
    `deal_stage` STRING COMMENT 'Salesforce CRM deal pipeline stage tracking the progression of the listing from initial prospect through close. Aligns with brokerage workflow from Letter of Intent (LOI) submission through contract execution. [ENUM-REF-CANDIDATE: prospecting|qualification|loi_submitted|under_contract|due_diligence|closed_won|closed_lost — promote to reference product]',
    `expiration_date` DATE COMMENT 'The contractual expiration date of the listing agreement. After this date, the brokerages exclusive marketing rights lapse unless renewed.',
    `gla_sqft` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the property or space being listed, measured in square feet. Used for PSF rate calculations, market comparables, and FAR compliance.',
    `is_costar_syndicated` BOOLEAN COMMENT 'Indicates whether this listing has been published and syndicated to the CoStar Suite commercial property database for market exposure.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the brokerage holds an exclusive listing agreement, granting sole marketing rights for the property during the listing term.',
    `is_mls_syndicated` BOOLEAN COMMENT 'Indicates whether this listing has been syndicated to the Multiple Listing Service (MLS) network. Drives listing visibility and co-broker cooperation eligibility.',
    `lease_rate_psf` DECIMAL(18,2) COMMENT 'Annual or monthly asking lease rate expressed on a Per Square Foot (PSF) basis for lease listings. Null for for-sale listings. Used for market comparables and deal underwriting.',
    `listing_status` STRING COMMENT 'Current lifecycle state of the listing. Active indicates available for marketing; pending indicates an accepted offer under contract; expired/withdrawn indicate the listing has ended without a transaction; sold/leased indicate a completed deal. [ENUM-REF-CANDIDATE: active|pending|expired|withdrawn|sold|leased|on_hold|draft — promote to reference product]',
    `listing_type` STRING COMMENT 'Classification of the listing agreement type governing the brokerage relationship. Exclusive grants sole marketing rights; open allows multiple brokers; co-exclusive is shared between two brokers. [ENUM-REF-CANDIDATE: exclusive|open|co_exclusive|exclusive_agency|net — promote to reference product]. Valid values are `exclusive|open|co_exclusive|exclusive_agency|net`',
    `mls_number` STRING COMMENT 'The externally-known Multiple Listing Service (MLS) identifier assigned to this listing upon syndication to the MLS network. Used for cross-brokerage identification and public-facing search.',
    `nla_sqft` DECIMAL(18,2) COMMENT 'Net Leasable Area (NLA) of the property, excluding common areas and structural elements. Used for tenant space calculations and lease rate benchmarking.',
    `notes` STRING COMMENT 'Free-text field for broker remarks, marketing highlights, or special conditions associated with the listing (e.g., owner financing available, sale-leaseback opportunity, as-is condition).',
    `number_of_floors` STRING COMMENT 'Total number of above-grade floors in the building. Used for property classification, elevator requirement analysis, and comparable selection.',
    `parking_ratio` DECIMAL(18,2) COMMENT 'Number of parking spaces per 1,000 square feet of rentable area. A key amenity metric for commercial lease listings and tenant prospect qualification.',
    `price` DECIMAL(18,2) COMMENT 'The asking or offering price for a for-sale listing, expressed in the local currency. For lease listings, this field is null and lease_rate_psf is used instead.',
    `salesforce_opportunity_code` STRING COMMENT 'The corresponding Salesforce CRM opportunity or deal record ID that tracks the brokerage pipeline activity associated with this listing.',
    `source_system` STRING COMMENT 'The originating operational system of record from which this listing record was sourced (e.g., Salesforce CRM, CoStar Suite). Used for data lineage, reconciliation, and Silver layer provenance tracking.. Valid values are `salesforce_crm|costar|yardi|mri|manual`',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier of this listing in the originating source system (e.g., Salesforce Opportunity ID, CoStar property listing ID). Enables traceability and reconciliation back to the system of record.',
    `start_date` DATE COMMENT 'The date on which the listing became active and was authorized for marketing. Used to calculate Days on Market (DOM) and listing agreement compliance.',
    `tenant_improvement_allowance` DECIMAL(18,2) COMMENT 'The landlord-offered Tenant Improvement (TI) allowance in absolute dollar terms for lease listings. Represents the capital contribution toward tenant fit-out and is a key deal negotiation lever.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the listing record was last modified in the data platform. Used for change data capture, incremental processing, and audit compliance.',
    `year_built` STRING COMMENT 'The year in which the property was originally constructed. Used for property age analysis, capital expenditure planning, and market comparable filtering.',
    CONSTRAINT pk_listing PRIMARY KEY(`listing_id`)
) COMMENT 'Master record for all property listings managed by the brokerage — commercial and residential, for sale or lease. Captures listing type (exclusive, open, co-exclusive), listing status (active, pending, expired, withdrawn, sold/leased), MLS/CoStar syndication flags, listing price/rate PSF, GLA/NLA, property class, submarket, listing start and expiration dates, days on market, and the originating source system (Salesforce CRM, CoStar). Serves as the SSOT for all brokerage-managed property offerings.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` (
    `listing_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the listing agreement record in the Silver Layer lakehouse. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the property being listed under this brokerage agreement. Links to the property master record.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the primary listing agent or broker responsible for marketing and transacting the property under this agreement.',
    `listing_id` BIGINT COMMENT 'The unique identifier assigned by CoStar Suite when the property listing is syndicated to the CoStar commercial real estate (CRE) platform for market exposure and comparable tracking.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Commission amounts and financial terms in listing agreements require standardized currency classification for multi-market financial reporting and cross-border transaction compliance. currency_code is',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Listing agreements are governed by specific state/local jurisdictions determining mandatory disclosure requirements, commission rules, dual agency laws, and contract enforceability. governing_law_stat',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Listing agreements are executed by the property-owning legal entity (LLC/SPE). The contracting legal entity must be referenced for contract validity, commission liability attribution, and financial co',
    `mls_listing_id` BIGINT COMMENT 'The unique identifier assigned by the Multiple Listing Service (MLS) when the property is syndicated to the MLS platform. Enables cross-referencing between the internal listing agreement and the MLS public listing record.',
    `owner_id` BIGINT COMMENT 'Reference to the property owner or seller who is the principal party authorizing the brokerage engagement.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: The listing agreement governs commission terms for the sale. Linking listing_agreement to property_sale enables post-closing commission validation against agreed terms, protection period enforcement, ',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial sublease listing agreements are executed for specific spaces. The agreement grants marketing rights for that suite. Space-level listing agreements are common in commercial sublease transact',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type on a listing agreement determines applicable commission benchmarks, required disclosures, and agreement terms. Brokers structure agreements differently for industrial vs. retail vs. offi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Listing agreements must satisfy specific regulatory obligations (mandatory agency disclosure, lead paint disclosure, environmental disclosure, fair housing posting requirements) that vary by jurisdict',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Listing agreement terms, commission structure, and required regulatory disclosures are governed by transaction type. A sale agreement has different legal requirements than a lease agreement. transacti',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential listing agreements (condos, co-ops, multifamily units) are executed for specific units. The agreement governs marketing rights for that unit. asset_id alone is insufficient; unit-level lis',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the listing agreement, used in DocuSign CLM and Salesforce CRM for cross-system reference and document tracking.. Valid values are `^LA-[0-9]{4}-[0-9]{6}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the listing agreement. Draft indicates the agreement is being prepared. Active indicates it is fully executed and in force. Expired indicates the term has lapsed without a transaction. Terminated indicates early cancellation by either party. Withdrawn indicates the property was removed from market. Closed indicates a successful transaction was completed.. Valid values are `draft|active|expired|terminated|withdrawn|closed`',
    `agreement_type` STRING COMMENT 'Classification of the listing agreement defining the scope of brokerage authority and commission entitlement. Exclusive Right to Sell grants the broker commission regardless of who procures the buyer. Exclusive Agency allows the owner to sell without commission if they find the buyer themselves. Open Listing allows multiple brokers with commission only to the procuring broker. Net Listing pays the broker any amount above the owners net price. Exclusive Right to Lease applies to leasing engagements.. Valid values are `exclusive_right_to_sell|exclusive_agency|open_listing|net_listing|exclusive_right_to_lease`',
    `amendment_count` STRING COMMENT 'The total number of formal amendments executed against this listing agreement since its original execution, tracking changes to price, term, commission, or other material terms.',
    `broker_license_number` STRING COMMENT 'The state-issued real estate broker license number of the brokerage firm executing this listing agreement, required for regulatory compliance and agreement validity under state licensing laws.',
    `broker_license_state` STRING COMMENT 'The two-letter US state code in which the brokers license is issued and under whose laws this listing agreement is governed.. Valid values are `^[A-Z]{2}$`',
    `brokerage_side` STRING COMMENT 'Identifies the brokerages role in the transaction: sell-side (representing the seller/landlord), buy-side (representing the buyer/tenant), lease listing (marketing a property for lease), tenant representation, or dual agency (representing both parties with disclosed consent).. Valid values are `sell_side|buy_side|lease_listing|tenant_rep|dual_agency`',
    `co_broker_authorized` BOOLEAN COMMENT 'Indicates whether the listing agreement authorizes the listing broker to cooperate with and compensate a co-broker (buyers agent or tenants representative) from the total commission. True enables MLS co-broker cooperation.',
    `co_broker_split_rate` DECIMAL(18,2) COMMENT 'The portion of the total commission allocated to the cooperating co-broker (buyers agent), expressed as a decimal percentage of the total commission or of the transaction price, as specified in the agreement. Null when co-broker authorization is false.',
    `commission_flat_fee` DECIMAL(18,2) COMMENT 'The agreed fixed brokerage commission amount in the agreement currency, applicable when the commission structure is a flat fee rather than a percentage. Null when a percentage-based commission rate is used.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The agreed brokerage commission expressed as a decimal percentage of the transaction price (e.g., 0.0600 = 6.00%). Applicable when the commission structure is percentage-based. Null when a flat fee structure is used.',
    `commission_structure` STRING COMMENT 'Defines the method by which the brokerage commission is calculated: percentage of transaction price, flat fee, tiered based on price thresholds, or net above a reserve price (net listing).. Valid values are `percentage|flat_fee|tiered|net_above_reserve`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this listing agreement record was first created in the Silver Layer lakehouse, sourced from DocuSign CLM or Salesforce CRM ingestion. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `docusign_envelope_code` STRING COMMENT 'The DocuSign CLM envelope identifier for the executed listing agreement document, enabling retrieval of the signed contract and audit trail of digital signatures.',
    `dual_agency_consent` BOOLEAN COMMENT 'Indicates whether the property owner has provided informed written consent for the broker to act as a dual agent, representing both the seller/landlord and the buyer/tenant in the same transaction, as required by state licensing laws.',
    `effective_date` DATE COMMENT 'The date on which the listing agreement becomes legally binding and the brokerage is authorized to begin marketing the property. Corresponds to the commencement date in DocuSign CLM.',
    `esg_disclosure_required` BOOLEAN COMMENT 'Indicates whether the listing agreement requires the broker to include Environmental, Social, and Governance (ESG) disclosures or sustainability certifications (e.g., LEED, BREEAM, ENERGY STAR) in the property marketing materials.',
    `exclusive_territory` STRING COMMENT 'Free-text description of the geographic or market territory within which the broker holds exclusive marketing rights under this agreement, if applicable (e.g., specific zip codes, submarkets, or building floors).',
    `execution_date` DATE COMMENT 'The date on which all parties signed and fully executed the listing agreement via DocuSign CLM or physical signature. May differ from the effective date.',
    `expiration_date` DATE COMMENT 'The date on which the listing agreement term ends and the brokerage authorization lapses if no transaction has been completed. Nullable for open-ended arrangements.',
    `last_amended_date` DATE COMMENT 'The date of the most recent formal amendment to the listing agreement. Null if no amendments have been executed.',
    `lockbox_authorized` BOOLEAN COMMENT 'Indicates whether the property owner has authorized the broker to install a lockbox on the property to facilitate agent showings without requiring the owner to be present.',
    `marketing_budget` DECIMAL(18,2) COMMENT 'The agreed marketing expenditure budget allocated for promoting the listed property, covering advertising, photography, virtual tours, signage, and digital syndication costs as specified in the listing agreement.',
    `minimum_acceptable_price` DECIMAL(18,2) COMMENT 'The lowest transaction price the owner has authorized the broker to accept or present for consideration, as agreed in the listing agreement. Used to guide offer evaluation and negotiation boundaries.',
    `owner_disclosure_completed` BOOLEAN COMMENT 'Indicates whether the property owner has completed and delivered all required property disclosure statements (e.g., sellers disclosure, lead paint, environmental hazards) as mandated by applicable state and federal regulations.',
    `price_reduction_authorized` BOOLEAN COMMENT 'Indicates whether the listing agreement grants the broker authority to reduce the listing price within defined parameters without requiring a formal amendment, enabling faster market responsiveness.',
    `protection_period_days` STRING COMMENT 'The number of days after the listing agreement expires during which the broker retains the right to earn a commission if the property is sold or leased to a prospect introduced by the broker during the listing term. Also known as the safety clause or tail period.',
    `salesforce_opportunity_code` STRING COMMENT 'The Salesforce CRM Opportunity record ID associated with this listing agreement, enabling traceability from the deal pipeline stage through to agreement execution and transaction close.',
    `showing_instructions` STRING COMMENT 'Free-text instructions governing how and when the property may be shown to prospective buyers or tenants, including notice requirements, access restrictions, and contact protocols as specified by the owner.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this listing agreement record was ingested: DocuSign CLM (contract execution), Salesforce CRM (deal pipeline), or manual entry for legacy records.. Valid values are `docusign_clm|salesforce_crm|manual`',
    `termination_date` DATE COMMENT 'The actual date on which the listing agreement was terminated prior to its scheduled expiration, whether by mutual consent, breach, or unilateral withdrawal. Null if the agreement ran to its natural expiration or closed successfully.',
    `termination_reason` STRING COMMENT 'The reason code explaining why the listing agreement was terminated before its scheduled expiration. Used for brokerage performance analysis and pipeline reporting. [ENUM-REF-CANDIDATE: mutual_consent|owner_withdrawal|broker_default|property_sold_off_market|expired_no_renewal|other — promote to reference product if additional values are needed]. Valid values are `mutual_consent|owner_withdrawal|broker_default|property_sold_off_market|expired_no_renewal|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this listing agreement record was last modified in the Silver Layer lakehouse, capturing any updates from source systems or manual corrections. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_listing_agreement PRIMARY KEY(`listing_agreement_id`)
) COMMENT 'Formal contractual agreement between the brokerage and a property owner/seller authorizing the brokerage to market and transact on their behalf. Captures agreement type (exclusive right to sell, exclusive agency, open listing, net listing), term start and end dates, agreed commission rate or flat fee, co-broker split authorization, listing price, and execution status. Sourced from DocuSign CLM and Salesforce CRM. Distinct from a lease agreement (owned by the lease domain) — this governs the brokerage engagement itself.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` (
    `brokerage_deal_id` BIGINT COMMENT 'Unique surrogate identifier for the brokerage deal record in the Silver Layer lakehouse. Primary key for the deal entity.',
    `asset_id` BIGINT COMMENT 'Reference to the property asset that is the subject of this brokerage deal. Links to the property master record.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the primary broker or agent responsible for managing and closing this deal. Drives commission attribution and production metric reporting.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Building class on a deal drives market analytics, broker production reporting by asset class, and investment benchmarking. Deal pipeline reports are routinely segmented by building class for strategic',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Direct campaign-to-deal attribution is required for marketing ROI reporting when deals are sourced directly from campaigns without a lead record (e.g., inbound from a digital campaign). deal.deal_sour',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Deal financial metrics (total consideration, commission amounts) require standardized currency classification for multi-market financial reporting, FX conversion, and investment analytics. currency_co',
    `environmental_review_id` BIGINT COMMENT 'Foreign key linking to development.environmental_review. Business justification: Environmental review findings are material to transaction due diligence. Buyers and lenders require Phase I/II results during the inspection contingency period. Linking deal to environmental_review su',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Deals are tracked against leasing/sales budgets for variance reporting. Asset managers compare actual deal activity to budgeted leasing commissions and revenue — a standard real estate budget-vs-actua',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Real estate deals are subject to jurisdiction-specific transfer taxes, FIRPTA withholding, HSR antitrust filings, and disclosure laws. Linking deal to compliance.jurisdiction enables jurisdiction-spec',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each deal is transacted under a specific legal entity (SPE/LLC) for tax and liability purposes. Real estate deals must be attributed to the correct legal entity for financial consolidation, tax report',
    `listing_id` BIGINT COMMENT 'Reference to the active listing record associated with this deal, if the deal originated from a listed property in the brokerage.listing product.',
    `lead_id` BIGINT COMMENT 'Foreign key linking to marketing.lead. Business justification: Lead-to-deal conversion is the primary marketing ROI metric in real estate brokerage. Linking a deal to its originating marketing lead enables pipeline attribution reporting. Role-prefix originating',
    `proforma_id` BIGINT COMMENT 'Foreign key linking to development.proforma. Business justification: When a developed asset is sold, the deals actual close price is compared against the proformas projected sale proceeds and exit cap rate. This variance analysis is a standard investment committee an',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial lease deals are executed for specific spaces. Deal close triggers space status change to leased and feeds space absorption reports. Lease administration systems require space_id from the de',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease type on a deal drives ASC 842 classification, CAM structure, TI allowance benchmarking, and commission calculation. Deal economics and financial reporting depend on standardized lease type class',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market and submarket on a deal drive broker performance dashboards, market share reporting, and investment strategy alignment. Standardized geographic hierarchy enables cross-market deal analytics. Ro',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transaction coordinators (non-broker employees) are assigned to deals for compliance, document management, and closing coordination. Deal management reports and workload tracking require this link. A ',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Deal transaction type determines regulatory requirements (HUD, SEC), tax treatment (1031 eligibility), required document checklist, and commission applicability. Every deal must be classified by stand',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential lease deals close on a specific unit. Deal closing triggers unit status change to leased and initiates move-in coordination. Property management systems require unit_id from the deal recor',
    `actual_close_date` DATE COMMENT 'Date on which the deal was formally closed and the transaction was completed. Populated upon deal_stage transition to closed. Drives commission income recognition and production metric reporting.',
    `co_broker_commission_pct` DECIMAL(18,2) COMMENT 'Percentage of the total commission allocated to the cooperating (co-broker) firm in a co-brokerage arrangement. Drives commission split calculations and co-broker AP disbursements.',
    `co_broker_firm` STRING COMMENT 'Name of the cooperating brokerage firm participating in the deal on the opposing side. Required for co-brokerage commission disbursement, MLS reporting, and NAR cooperative compensation compliance.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Calculated gross commission dollar amount payable upon deal close, derived from commission_rate_pct applied to total_consideration. Stored as a business field for commission tracking, AP processing, and broker production reporting. Not a KPI — represents the contractual commission obligation.',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'Agreed brokerage commission rate expressed as a percentage of total consideration or lease value. Basis for commission income recognition and broker production reporting.',
    `costar_code` STRING COMMENT 'CoStar Suite identifier for the property or deal record. Enables cross-referencing with CoStar market data, comparable sales/lease analytics, and property analytics benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal record was first created in the system, sourced from Salesforce CRM opportunity creation date. Supports audit trail, pipeline age analysis, and data lineage tracking.',
    `dead_date` DATE COMMENT 'Date on which the deal was marked as dead or terminated. Populated when deal_stage transitions to dead. Used for pipeline attrition analysis and dead deal reason reporting.',
    `dead_reason` STRING COMMENT 'Reason code explaining why the deal was terminated or lost. Populated when deal_stage = dead. Used for pipeline loss analysis, broker coaching, and CRM closed-lost reporting. [ENUM-REF-CANDIDATE: price_gap|financing_failed|due_diligence_failure|client_withdrew|competing_offer|market_conditions|regulatory_issue|other — promote to reference product]',
    `deal_name` STRING COMMENT 'Descriptive name of the deal as entered in the CRM pipeline (e.g., Acme Corp — 50 Hudson Yards — Office Lease). Used for quick identification in pipeline reports and dashboards.',
    `deal_number` STRING COMMENT 'Human-readable, externally-known business identifier for the deal (e.g., BRK-2024-00412). Used in correspondence, reporting, and CRM references. Distinct from the surrogate deal_id.',
    `deal_source` STRING COMMENT 'Origin channel through which the deal opportunity was identified or generated. Used for lead source attribution, marketing ROI analysis, and broker prospecting effectiveness reporting. [ENUM-REF-CANDIDATE: inbound_referral|outbound_prospecting|mls|costar|repeat_client|broker_network|marketing_campaign|cold_call|website|other — promote to reference product]',
    `deal_type` STRING COMMENT 'Classification of the brokerage transaction type. Determines applicable commission structures, regulatory requirements, and pipeline reporting categories. [ENUM-REF-CANDIDATE: sale|lease|sublease|assignment|renewal|expansion|ground_lease|sale_leaseback — promote to reference product if additional types are needed]. Valid values are `sale|lease|sublease|assignment|renewal|expansion`',
    `exclusivity_end_date` DATE COMMENT 'End date of the exclusivity period. After this date, the brokers exclusive representation rights expire. Used to trigger listing agreement renewal workflows and pipeline expiry alerts.',
    `exclusivity_start_date` DATE COMMENT 'Start date of the exclusivity period during which the broker has the exclusive right to represent the property or client for this deal. Governs competing offer restrictions and listing agreement compliance.',
    `is_co_brokerage` BOOLEAN COMMENT 'Indicates whether a cooperating (co-broker) firm is involved in this deal. True = co-brokerage arrangement exists, triggering commission split processing and co-broker disclosure requirements.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the brokerage firm holds an exclusive representation agreement for this deal. True = exclusive listing or exclusive buyer/tenant representation. Drives exclusivity period enforcement and competing offer restrictions.',
    `lease_rate_psf` DECIMAL(18,2) COMMENT 'Annual or monthly base rent rate expressed on a Per Square Foot (PSF) basis. Applicable for lease and sublease deal types. Used for market comparables analysis and CoStar/MLS benchmarking.',
    `lease_term_months` STRING COMMENT 'Total duration of the lease agreement in months. Applicable for lease, sublease, and renewal deal types. Used to compute total lease consideration and Weighted Average Lease Term (WALT) portfolio metrics.',
    `loi_date` DATE COMMENT 'Date on which the Letter of Intent (LOI) was executed between the parties. Marks the transition from prospect to LOI stage in the pipeline. Key milestone for pipeline velocity and stage duration analysis.',
    `mls_number` STRING COMMENT 'MLS listing identifier associated with this deal, if the property is listed on a Multiple Listing Service (MLS). Used for MLS syndication tracking and cooperative compensation compliance.',
    `notes` STRING COMMENT 'Free-text field for broker notes, deal narrative, special conditions, or CRM activity log summaries relevant to the deal. Supports deal context preservation and broker handoff documentation.',
    `probability_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0.00–100.00%) that the deal will close successfully, as assessed by the assigned broker or CRM workflow automation. Used for weighted pipeline value calculations and revenue forecasting.',
    `projected_close_date` DATE COMMENT 'Broker-estimated date by which the deal is expected to close. Used for pipeline forecasting, revenue recognition planning, and CRM opportunity management. Distinct from actual_close_date.',
    `prospect_company` STRING COMMENT 'Legal entity or company name of the prospective buyer or tenant. Used for CRM account matching, credit screening, and lease counterparty identification.',
    `prospect_name` STRING COMMENT 'Name of the prospective buyer, tenant, or counterparty associated with this deal. Sourced from Salesforce CRM contact/account. Classified confidential as it represents business relationship data.',
    `sale_price` DECIMAL(18,2) COMMENT 'Agreed or listed purchase price for sale transaction deals. Null for lease-only deals. Used for CAP Rate analysis, LTV calculations, and comparable sales (CMA/BPO) benchmarking.',
    `salesforce_opportunity_code` STRING COMMENT 'External identifier from Salesforce CRM opportunity pipeline. Used to trace the deal back to its source system record for reconciliation and lineage.',
    `side` STRING COMMENT 'Indicates which side of the transaction the brokerage firm represents. Critical for commission split calculations, conflict-of-interest disclosures, and regulatory compliance. Dual agency requires specific disclosure per NAR ethics rules.. Valid values are `buy_side|sell_side|tenant_rep|landlord_rep|dual_agency`',
    `size_sqft` DECIMAL(18,2) COMMENT 'Total rentable or saleable area covered by this deal, expressed in square feet (SQF). For lease deals, represents the leased premises area. For sale deals, represents the total building or unit area transacted. Key metric for Per Square Foot (PSF) analysis.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this deal record was ingested into the Silver Layer. Supports data lineage, reconciliation, and multi-source integration governance.. Valid values are `salesforce_crm|yardi_voyager|mri_software|manual`',
    `stage` STRING COMMENT 'Current stage of the deal in the brokerage pipeline lifecycle. Maps directly to Salesforce CRM opportunity stages. Drives pipeline velocity analysis and CRM workflow compliance auditing. Values: prospect (initial identification), loi (Letter of Intent executed), under_contract (purchase/lease agreement signed), due_diligence (inspection/review period), closed (transaction completed), dead (deal terminated).. Valid values are `prospect|loi|under_contract|due_diligence|closed|dead`',
    `tenant_improvement_allowance` DECIMAL(18,2) COMMENT 'Dollar amount of Tenant Improvement (TI) allowance offered by the landlord to fund build-out of the leased premises. Applicable for lease deals. Impacts effective net rent calculations and deal economics.',
    `total_consideration` DECIMAL(18,2) COMMENT 'Gross total monetary value of the transaction. For sale deals: total purchase price. For lease deals: total lease value over the full lease term (base rent × term). Expressed in the deal currency. Core metric for pipeline value reporting and commission base calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the deal record. Used for incremental data pipeline processing, change detection, and CRM synchronization auditing.',
    CONSTRAINT pk_brokerage_deal PRIMARY KEY(`brokerage_deal_id`)
) COMMENT 'Core transactional record representing a brokerage deal from prospect to close, sourced from Salesforce CRM opportunity pipeline. Tracks deal type (sale, lease, sublease, assignment), deal stage (prospect, LOI, under contract, due diligence, closed, dead), property reference, deal size (SF/SQM, total consideration), projected and actual close dates, probability percentage, deal source, assigned broker/agent, and exclusivity periods. Includes immutable stage transition history as child records capturing prior stage, new stage, transition timestamp, reason for change, and triggering broker — enabling pipeline velocity analysis, stage duration tracking, and CRM workflow compliance auditing. Serves as the SSOT for brokerage deal pipeline activity and deal stage audit trail across buy-side and sell-side operations.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` (
    `brokerage_prospect_id` BIGINT COMMENT 'Unique system-generated identifier for the brokerage prospect record in the Salesforce CRM deal pipeline.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Prospects are classified into audience segments for targeted re-marketing and nurture campaigns. Linking prospect to audience_segment enables segment-level conversion analysis (segment → showing → dea',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign (e.g., email blast, CoStar ad, event) that generated this prospect lead. Applicable when lead_source = marketing_campaign. Used for campaign ROI attribution.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Prospect budget and financial qualification metrics require standardized currency classification for multi-market prospect management and cross-border investment advisory. currency_code is a denormali',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Prospect geographic preference drives listing matching, broker territory assignment, and market demand analytics. Standardized geographic hierarchy enables cross-market prospect analysis. Role prefix ',
    `brokerage_broker_id` BIGINT COMMENT 'Identifier of the licensed broker or agent assigned to manage this prospect relationship and advance the deal pipeline. Links to the broker/agent master record.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Prospect property type preference drives automated listing matching, broker assignment, and pipeline qualification. Standardized property type classification enables accurate prospect-to-listing match',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Prospect lease type preference drives listing matching and deal structuring. Standardized lease type classification enables accurate prospect-to-listing matching and informs TI allowance and CAM struc',
    `lead_id` BIGINT COMMENT 'Reference identifier for the corresponding Lead or Contact record in Salesforce CRM, enabling cross-system traceability between the lakehouse silver layer and the operational CRM.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Prospect transaction type preference determines deal routing, broker specialization matching, and pipeline reporting segmentation. Standardized transaction type classification is required for accurate',
    `budget_psf` DECIMAL(18,2) COMMENT 'Prospects stated budget or target lease rate expressed in dollars per square foot (PSF) per annum for lease prospects, or acquisition price PSF for buyers. Key qualifier for deal viability assessment.',
    `cap_rate_target` DECIMAL(18,2) COMMENT 'Investor prospects target CAP Rate (Capitalization Rate) expressed as a decimal (e.g., 0.0550 = 5.50%). Used to filter investment listings and assess deal viability against NOI-based valuations.',
    `company_name` STRING COMMENT 'Name of the company or organization the prospect represents, applicable for corporate tenants, institutional investors, or commercial buyers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Establishes the audit trail start point and pipeline entry date.',
    `email` STRING COMMENT 'Primary email address used for brokerage outreach and CRM communication with the prospect.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `full_name` STRING COMMENT 'Full legal name of the prospective buyer, tenant, investor, or owner/seller as captured in the CRM at the time of introduction.',
    `gdpr_consent_date` DATE COMMENT 'Date on which the prospect provided GDPR data processing consent. Required for audit trail and regulatory compliance documentation.',
    `gdpr_consent_given` BOOLEAN COMMENT 'Indicates whether the prospect has provided explicit consent for personal data processing under GDPR. Required for EU-based prospects; must be True before marketing communications are sent.',
    `irr_target` DECIMAL(18,2) COMMENT 'Investor prospects minimum required Internal Rate of Return (IRR) expressed as a decimal (e.g., 0.1200 = 12.00%). Used in DCF-based investment screening and portfolio advisory.',
    `is_do_not_contact` BOOLEAN COMMENT 'Indicates whether the prospect has requested to be removed from all brokerage outreach. True suppresses all automated and manual contact attempts, ensuring compliance with GDPR and CAN-SPAM opt-out requirements.',
    `last_contact_date` DATE COMMENT 'Most recent date on which the assigned broker made contact with the prospect (call, email, meeting, or site tour). Used to monitor engagement cadence and identify stale prospects.',
    `lead_source` STRING COMMENT 'Channel or method through which the prospect was introduced to the brokerage. Used for marketing attribution, ROI analysis on lead generation spend, and broker performance reporting. [ENUM-REF-CANDIDATE: referral|cold_call|marketing_campaign|costar_lead|walk_in|mls_inquiry|website|broker_network|other — promote to reference product]',
    `loi_date` DATE COMMENT 'Date on which a Letter of Intent (LOI) was issued to or by the prospect, marking formal deal progression beyond negotiation. Null if no LOI has been issued.',
    `lost_reason` STRING COMMENT 'Reason the prospect was marked as lost or disqualified in the CRM pipeline. Used for win/loss analysis and brokerage strategy refinement. Null when qualification_status is not lost. [ENUM-REF-CANDIDATE: price|location|size|competitor|no_requirement|timing|financing|other — promote to reference product]',
    `max_size_sqft` STRING COMMENT 'Maximum space requirement in square feet (SQF) as stated by the prospect. Upper bound for listing matching against GLA/NLA of available properties.',
    `min_size_sqft` STRING COMMENT 'Minimum space requirement in square feet (SQF) as stated by the prospect. Used for listing matching against GLA/NLA of available properties.',
    `next_followup_date` DATE COMMENT 'Scheduled date for the next broker outreach or follow-up action with the prospect. Drives CRM task management and pipeline hygiene reporting.',
    `notes` STRING COMMENT 'Free-text field for broker notes, special requirements, deal nuances, or contextual information about the prospect that does not fit structured fields. Supports qualitative deal intelligence.',
    `phone` STRING COMMENT 'Primary contact phone number for the prospect, used by the assigned broker for outreach and follow-up.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `prospect_type` STRING COMMENT 'Categorizes the prospects role in the anticipated transaction: buyer (acquisition), tenant (leasing), investor (capital deployment), or owner/seller (disposition). Drives deal pipeline routing and broker assignment logic.. Valid values are `buyer|tenant|investor|owner_seller`',
    `qualification_status` STRING COMMENT 'Current qualification stage of the prospect in the brokerage CRM pipeline. MQL (Marketing Qualified Lead) indicates marketing-sourced interest; SQL (Sales Qualified Lead) indicates broker-validated readiness. Converted means the prospect has become a confirmed deal counterparty; Lost means the prospect has disengaged.. Valid values are `unqualified|mql|sql|nurturing|converted|lost`',
    `referral_source_name` STRING COMMENT 'Name of the individual, firm, or campaign that referred this prospect to the brokerage. Applicable when lead_source = referral. Used for referral fee tracking and relationship management.',
    `site_tours_count` STRING COMMENT 'Total number of property site tours conducted with this prospect to date. Indicates engagement depth and deal progression velocity.',
    `source_system` STRING COMMENT 'Operational system of record from which this prospect record originated (e.g., Salesforce CRM, CoStar lead, MLS inquiry). Supports data lineage and ETL reconciliation in the Databricks lakehouse silver layer.. Valid values are `salesforce|costar|mls|manual|other`',
    `target_lease_term_months` STRING COMMENT 'Prospects preferred lease duration in months. Applicable for tenant prospects. Used to assess WALT impact and match against landlord minimum term requirements.',
    `target_move_in_date` DATE COMMENT 'Prospects desired move-in or occupancy commencement date. For buyers, this represents the target closing/possession date. Critical for matching against available listing dates and lease commencement scheduling.',
    `ti_requirement` BOOLEAN COMMENT 'Indicates whether the prospect requires a Tenant Improvement (TI) allowance as part of the deal structure. True signals that TI negotiation will be a material deal term.',
    `total_budget` DECIMAL(18,2) COMMENT 'Total maximum budget or investment capital the prospect is prepared to deploy, expressed in the deal currency. For buyers and investors, this is the maximum acquisition price; for tenants, the total lease commitment ceiling.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the prospect record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, data freshness monitoring, and audit compliance.',
    CONSTRAINT pk_brokerage_prospect PRIMARY KEY(`brokerage_prospect_id`)
) COMMENT 'Brokerage-specific record for a prospective buyer, tenant, or investor tracked in the Salesforce CRM deal pipeline before they become a confirmed counterparty on a deal. Captures prospect type (buyer, tenant, investor, owner/seller), contact details, requirement profile (target SF range, budget PSF, preferred submarket, property type, move-in timeline), source of introduction (referral, cold call, marketing campaign, CoStar lead, walk-in), qualification status (unqualified, MQL, SQL, nurturing, converted, lost), assigned broker, last contact date, next follow-up date, and CRM lead/contact reference. Distinct from the tenant domains tenant master — this is a pre-transaction brokerage pipeline entity that converts into a deal counterparty upon qualification.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`showing` (
    `showing_id` BIGINT COMMENT 'Unique system-generated identifier for each property showing or tour event record in the brokerage pipeline.',
    `asset_id` BIGINT COMMENT 'Reference to the physical property asset being shown, enabling direct property-level analytics independent of listing lifecycle.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: A property showing is a key activity in the deal pipeline. Linking showing to deal enables tracking of how many showings occurred before a deal was created, showing-to-deal conversion analytics, and d',
    `brokerage_prospect_id` BIGINT COMMENT 'Reference to the prospect, tenant, or buyer contact attending the showing, sourced from Salesforce CRM contact records.',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Showings in multi-building assets require building-level coordination for access control, security sign-in, and elevator scheduling. Building operations teams need showing schedules per building. asse',
    `buyer_representation_id` BIGINT COMMENT 'Foreign key linking to brokerage.buyer_representation. Business justification: A property showing is conducted on behalf of a buyer or tenant who has signed a buyer representation agreement. Linking showing to buyer_representation enables tracking of all showings conducted under',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Showing coordinators (non-broker employees) schedule, confirm, and manage property showings in high-volume brokerages. Showing throughput reports, staff workload analysis, and operational KPIs require',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Budget and price feedback captured during showings require standardized currency classification for multi-market prospect analytics and pricing intelligence reporting. currency_code is a denormalized ',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_event. Business justification: Open houses are marketing events that generate showings. Linking a showing to the open house/marketing event that produced it enables event ROI measurement (event → showings → deals) — a standard real',
    `listing_id` BIGINT COMMENT 'Reference to the active property listing associated with this showing event, linking to the brokerage listing record.',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial tenant showings are conducted for specific leasable spaces (suites/floors). Brokers track which spaces were shown to which prospects for space absorption reporting and leasing pipeline mana',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type on showing records drives conversion rate analytics by asset class, broker specialization reporting, and market demand analysis. Standardized property type classification enables cross-m',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed broker or agent who conducted or hosted the showing on behalf of the listing side.',
    `showing_buyer_agent_broker_brokerage_broker_id` BIGINT COMMENT 'Reference to the co-broker or buyers/tenants agent who accompanied the prospect during the showing, supporting co-broker commission tracking.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Submarket-level showing analytics enable broker performance reporting, market activity tracking, and demand heat-mapping. Standardized geographic hierarchy is required for cross-market showing volume ',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Showing records are categorized by transaction type for pipeline conversion analytics and broker performance reporting. Standardized transaction type enables showing-to-deal conversion rate analysis b',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential/multifamily showings are scheduled for a specific unit (e.g., Apt 3B). Leasing teams track showing history per unit for availability management and prospect follow-up. No unit_id FK exists',
    `access_method` STRING COMMENT 'Method used to access the property for the showing, such as lockbox, agent-accompanied entry, or electronic access system, relevant for security and compliance tracking.. Valid values are `lockbox|agent_accompanied|key_pickup|electronic_access|building_security`',
    `actual_end` TIMESTAMP COMMENT 'The actual date and time the showing concluded, enabling calculation of actual showing duration for productivity analytics.',
    `actual_start` TIMESTAMP COMMENT 'The actual date and time the showing commenced, which may differ from the scheduled start due to delays or early arrivals.',
    `attendee_count` STRING COMMENT 'Total number of individuals who attended the showing, including the prospect, their representatives, and any accompanying decision-makers.',
    `budget_psf` DECIMAL(18,2) COMMENT 'Prospects stated budget or target lease rate per square foot (PSF) or price per square foot for purchase, used to qualify the prospect and assess deal viability.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation or no-show when showing_status is cancelled or no_show, used for pipeline analytics and agent performance reporting.. Valid values are `prospect_cancelled|agent_cancelled|property_unavailable|weather|scheduling_conflict|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the showing record was first created in the source system (Salesforce CRM), establishing the audit trail for data lineage and SOX compliance.',
    `deal_stage` STRING COMMENT 'Salesforce CRM deal pipeline stage at the time of the showing, tracking progression from initial prospect through close or loss. [ENUM-REF-CANDIDATE: prospect|qualified|showing|offer_pending|under_contract|closed|lost — 7 candidates stripped; promote to reference product]',
    `feedback_notes` STRING COMMENT 'Free-text broker or prospect feedback captured after the showing, including property impressions, objections, pricing comments, and space suitability observations.',
    `follow_up_action` STRING COMMENT 'Specific next-step action to be taken following the showing, such as sending a Letter of Intent (LOI), scheduling a second showing, or submitting comparable market analysis (CMA). [ENUM-REF-CANDIDATE: send_proposal|schedule_second_showing|submit_loi|send_comps|no_action_required|other — promote to reference product]. Valid values are `send_proposal|schedule_second_showing|submit_loi|send_comps|no_action_required|other`',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action must be completed, used for agent task management and pipeline velocity tracking.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up action is required after the showing, triggering task creation in Salesforce CRM for the responsible agent.',
    `is_confidential_listing` BOOLEAN COMMENT 'Indicates whether the property listing is confidential (off-market or pocket listing), requiring restricted disclosure of property details during the showing process.',
    `mls_number` STRING COMMENT 'The Multiple Listing Service (MLS) identifier of the listed property at the time of the showing, enabling cross-reference with MLS syndication data.',
    `nda_executed` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) was executed by the prospect prior to the showing, required for confidential or off-market listings.',
    `outcome` STRING COMMENT 'Recorded outcome of the showing event indicating the prospects level of interest or next action, used to advance the deal pipeline in Salesforce CRM.. Valid values are `interested|not_interested|offer_pending|needs_follow_up|undecided`',
    `price_feedback` STRING COMMENT 'Prospects qualitative feedback on the asking price or lease rate per square foot (PSF) relative to their expectations, informing pricing strategy.. Valid values are `too_high|acceptable|below_expectation|no_comment`',
    `prospect_company` STRING COMMENT 'Name of the company or organization the prospect represents, relevant for commercial real estate (CRE) leasing and investment transactions.',
    `prospect_interest_level` STRING COMMENT 'Brokers qualitative assessment of the prospects interest level following the showing, used for pipeline prioritization and follow-up scheduling.. Valid values are `high|medium|low|none`',
    `prospect_name` STRING COMMENT 'Full name of the prospect, buyer, or tenant representative attending the showing, as recorded in Salesforce CRM.',
    `prospect_side` STRING COMMENT 'Identifies the brokerage representation side of the attending prospect — buy-side (buyer/tenant) or sell-side (seller/landlord) — for dual-agency and commission tracking.. Valid values are `buy_side|sell_side|tenant_side|landlord_side`',
    `required_sqft` STRING COMMENT 'Prospects stated space requirement in square feet (SQF) at the time of the showing, used to assess property-to-requirement fit and qualify the lead.',
    `salesforce_activity_code` STRING COMMENT 'External identifier of the corresponding activity record in Salesforce CRM from which this showing was sourced, enabling bi-directional traceability.',
    `scheduled_end` TIMESTAMP COMMENT 'The planned date and time at which the property showing was scheduled to conclude, used to calculate planned duration.',
    `scheduled_start` TIMESTAMP COMMENT 'The planned date and time at which the property showing was scheduled to begin, as recorded in the CRM calendar event.',
    `sequence` STRING COMMENT 'Sequential count of showings conducted for this prospect on this listing, indicating whether this is the first, second, or subsequent showing — a key pipeline velocity metric.',
    `showing_number` STRING COMMENT 'Human-readable business identifier for the showing event, used in broker communications, reporting, and CRM deal tracking (e.g., SHW-000123456).. Valid values are `^SHW-[0-9]{6,12}$`',
    `showing_status` STRING COMMENT 'Current lifecycle state of the showing event, tracking progression from scheduling through completion or cancellation.. Valid values are `scheduled|completed|cancelled|no_show|rescheduled|pending_confirmation`',
    `showing_type` STRING COMMENT 'Classification of the showing format: in-person physical tour, virtual video tour, self-guided access, open house event, or broker preview/caravan.. Valid values are `in_person|virtual|self_guided|open_house|broker_preview`',
    `source_system` STRING COMMENT 'Operational system of record from which this showing record was ingested into the Silver layer, primarily Salesforce CRM activity tracking.. Valid values are `salesforce_crm|yardi_voyager|mri_software|manual`',
    `space_feedback` STRING COMMENT 'Prospects qualitative feedback on the physical space, including size, layout, and configuration relative to their requirements.. Valid values are `too_large|too_small|right_size|layout_issue|no_comment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the showing record in the source system, supporting change data capture (CDC) and audit trail requirements.',
    `virtual_platform` STRING COMMENT 'Technology platform used to conduct a virtual showing (e.g., Zoom, Matterport 3D tour). Populated only when showing_type is virtual; otherwise not applicable. [ENUM-REF-CANDIDATE: zoom|microsoft_teams|google_meet|matterport|facetime|other|not_applicable — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_showing PRIMARY KEY(`showing_id`)
) COMMENT 'Records each property showing or tour event conducted as part of the brokerage sales or leasing process. Captures showing date and time, property and listing reference, prospect or counterparty attending, broker conducting the showing, showing type (in-person, virtual), feedback notes, follow-up action required, and outcome (interested, not interested, offer pending). Sourced from Salesforce CRM activity tracking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` (
    `negotiation_instrument_id` BIGINT COMMENT 'Primary key for negotiation_instrument',
    `asset_id` BIGINT COMMENT 'Reference to the subject property for which this negotiation instrument is submitted. Links to the property master record to provide context on asset class, location, GLA/NLA, and zoning.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed real estate agent or broker who submitted this instrument on behalf of the counterparty. Used for commission attribution, co-broker tracking, and agent production metrics.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the parent brokerage deal or opportunity record in the deal pipeline. Links this negotiation instrument to the overarching deal tracked in Salesforce CRM from prospect to close. Multiple instruments may exist per deal across negotiation rounds.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Proposed price, rent, TI allowance, and earnest money deposit on negotiation instruments require standardized currency classification for multi-market deal analytics and cross-border transaction compl',
    `deal_party_id` BIGINT COMMENT 'Reference to the counterparty (buyer, tenant, or their representative) who submitted this negotiation instrument. Serves as the PARTY_REFERENCE for this transaction header. Links to the tenant, owner, or prospect master record.',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to development.entitlement. Business justification: LOIs for development site acquisitions include zoning contingency clauses tied to specific entitlement approvals. Linking the LOI to the entitlement record enables tracking of zoning contingency satis',
    `environmental_review_id` BIGINT COMMENT 'Foreign key linking to development.environmental_review. Business justification: LOIs for commercial/industrial properties routinely include environmental contingency clauses referencing a specific Phase I or Phase II review. Linking the LOI to the environmental_review record supp',
    `listing_id` BIGINT COMMENT 'Reference to the active listing record associated with this negotiation instrument. Links to the brokerage.listing product to provide listing price, lease rate PSF, commission structure, and MLS/CoStar syndication context.',
    `parent_instrument_negotiation_instrument_id` BIGINT COMMENT 'Self-referencing identifier pointing to the prior negotiation instrument that this record is responding to. Populated for counter-offers to establish the negotiation chain. Null for initial submissions.',
    `proforma_id` BIGINT COMMENT 'Foreign key linking to development.proforma. Business justification: LOIs for development asset dispositions are evaluated against the proformas target sale price and exit cap rate. Investment committees use this link to assess whether proposed LOI terms meet the deve',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial LOIs specify the exact suite/space being negotiated. Proposed area, rent PSF, and TI allowance in the LOI must be reconciled against the space record. Space-level LOI tracking is fundamenta',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Lease type on an LOI determines CAM, TI allowance, and rent structure terms being negotiated. Standardized lease type classification ensures ASC 842 and IFRS 16 compliance in deal structuring. lease_t',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: LOI/offer instrument type, required contingencies (financing, environmental, zoning), and binding status depend on transaction type classification. Standardized transaction type drives required docume',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential LOIs and offers are submitted for specific units. Proposed rent, TI allowance, and lease terms in the instrument must be validated against unit specs. asset_id alone is insufficient; unit-',
    `closing_period_days` STRING COMMENT 'Number of calendar days from acceptance to proposed closing or lease execution as specified in the negotiation instrument. Used for deal timeline planning and pipeline velocity reporting in Salesforce CRM.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this negotiation instrument record was first created in the data platform. Serves as the RECORD_AUDIT_CREATED field for data lineage, SOX audit trail, and Silver layer ingestion tracking.',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier from DocuSign CLM associated with the digital execution or routing of this negotiation instrument. Enables traceability to the signed document and audit trail in the contract lifecycle management system.',
    `due_diligence_period_days` STRING COMMENT 'Number of calendar days proposed for the due diligence period during which the buyer or tenant may investigate the property, review financials, and conduct inspections before being bound to proceed. A standard negotiation term in commercial real estate transactions.',
    `earnest_money_deposit` DECIMAL(18,2) COMMENT 'Amount of earnest money deposit proposed or required to accompany this negotiation instrument, demonstrating the submitting partys good faith. Applicable primarily for purchase offers and binding LOIs. Confidential as it represents deal-sensitive financial terms.',
    `environmental_contingency` BOOLEAN COMMENT 'Indicates whether this negotiation instrument includes an environmental assessment contingency (True), making the offer conditional upon satisfactory Phase I or Phase II Environmental Site Assessment results. Relevant for EPA compliance and risk management.',
    `expiration_date` DATE COMMENT 'Date by which the submitting party requires a response; after this date the instrument automatically transitions to expired status if no action is taken. Critical for deal urgency management and pipeline reporting in Salesforce CRM.',
    `financing_contingency` BOOLEAN COMMENT 'Indicates whether this negotiation instrument includes a financing contingency (True), meaning the offer is conditional upon the buyer or tenant securing financing. A key risk factor in deal pipeline management and probability-to-close scoring.',
    `inspection_contingency` BOOLEAN COMMENT 'Indicates whether this negotiation instrument includes a physical inspection contingency (True), making the offer conditional upon satisfactory property inspection results. Triggers due diligence workflow in Procore and Building Engines.',
    `instrument_notes` STRING COMMENT 'Free-text field capturing additional deal-specific terms, special conditions, or negotiation commentary not captured in structured fields. Examples include parking provisions, signage rights, exclusivity clauses, or SNDA requirements. Confidential as it may contain sensitive deal terms.',
    `instrument_number` STRING COMMENT 'Externally-known business reference number assigned to this negotiation instrument, used in correspondence with counterparties, brokers, and legal counsel. Typically generated by Salesforce CRM or DocuSign CLM at submission. Format example: LOI-2024-00123.',
    `instrument_status` STRING COMMENT 'Current lifecycle status of the negotiation instrument. submitted = received and under review; countered = a counter-offer has been issued; accepted = terms agreed upon by all parties; rejected = formally declined; expired = passed expiration date without response; withdrawn = retracted by submitting party prior to response.. Valid values are `submitted|countered|accepted|rejected|expired|withdrawn`',
    `instrument_type` STRING COMMENT 'Type discriminator classifying the negotiation instrument. LOI = non-binding Letter of Intent; purchase_offer = binding purchase offer for sale transactions; lease_proposal = formal lease proposal for leasing transactions; counter_offer = counter to a prior instrument; binding_offer = binding offer distinct from a standard purchase offer. Drives downstream workflow and legal treatment.. Valid values are `LOI|purchase_offer|lease_proposal|counter_offer|binding_offer`',
    `is_binding` BOOLEAN COMMENT 'Indicates whether this negotiation instrument is legally binding (True) or non-binding (False). LOIs are typically non-binding; purchase offers and executed lease proposals are binding. Drives legal review workflows and DocuSign CLM routing.',
    `negotiation_round` STRING COMMENT 'Sequential round number within the negotiation chain for a given deal. Round 1 = initial offer or LOI; Round 2 = first counter; Round 3 = second counter, etc. Enables analysis of negotiation velocity and concession patterns.',
    `proposed_cam_rate_psf` DECIMAL(18,2) COMMENT 'Proposed annual Common Area Maintenance (CAM) charge expressed on a Per Square Foot (PSF) basis. Applicable for NNN and modified gross lease structures. Null for full gross leases. Confidential as it represents deal-sensitive operating cost terms.',
    `proposed_commencement_date` DATE COMMENT 'Proposed start date for the lease term as specified in the negotiation instrument. Drives rent commencement, free rent period calculations, and lease administration setup in Yardi Voyager.',
    `proposed_free_rent_months` STRING COMMENT 'Number of months of rent abatement proposed in the negotiation instrument as a landlord concession. Impacts effective rent calculations and Net Present Value (NPV) analysis in Argus Enterprise. Zero if no free rent is proposed.',
    `proposed_leasable_area_sqft` DECIMAL(18,2) COMMENT 'Net Leasable Area (NLA) or Gross Leasable Area (GLA) in square feet as proposed in the negotiation instrument. May differ from the total property area if the instrument covers a partial floor or suite. Used to calculate total proposed rent and TI allowance amounts.',
    `proposed_lease_term_months` STRING COMMENT 'Proposed duration of the lease in months as specified in the negotiation instrument. Used for Weighted Average Lease Term (WALT) and Weighted Average Lease Expiry (WALE) projections and portfolio analytics in Argus Enterprise.',
    `proposed_price` DECIMAL(18,2) COMMENT 'Proposed total purchase price for sale transactions, expressed in the instrument currency. Applicable when transaction_type = sale or purchase_offer. Null for pure lease proposals. Confidential as it represents deal-sensitive financial terms.',
    `proposed_rent_psf` DECIMAL(18,2) COMMENT 'Proposed annual base rent expressed on a Per Square Foot (PSF) basis for lease transactions. Applicable when transaction_type = lease, sublease, or assignment. Null for sale transactions. Confidential as it represents deal-sensitive lease economics.',
    `proposed_ti_allowance_psf` DECIMAL(18,2) COMMENT 'Proposed Tenant Improvement (TI) allowance expressed on a Per Square Foot (PSF) basis, representing the landlords contribution toward tenant fit-out costs. A key negotiation lever in commercial leasing. Confidential as it represents deal-sensitive financial concessions.',
    `response_date` DATE COMMENT 'Date on which the receiving party formally responded to this negotiation instrument (accepted, rejected, or countered). Null if no response has been issued. Used to calculate days-to-respond and negotiation cycle time KPIs.',
    `salesforce_opportunity_code` STRING COMMENT 'External identifier of the corresponding opportunity record in Salesforce CRM. Enables bidirectional traceability between the lakehouse Silver layer and the operational CRM system for deal pipeline reconciliation and data lineage.',
    `side` STRING COMMENT 'Indicates which side of the transaction the submitting brokerage firm represents for this negotiation instrument. buy_side = representing the buyer; sell_side = representing the seller; tenant_side = representing the tenant; landlord_side = representing the landlord. Drives commission split and co-broker arrangement logic.. Valid values are `buy_side|sell_side|tenant_side|landlord_side`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this negotiation instrument record was sourced. Supports data lineage, reconciliation, and Silver layer provenance tracking. Salesforce CRM is the primary source for brokerage deal instruments.. Valid values are `Salesforce CRM|DocuSign CLM|Yardi Voyager|MRI Software|manual`',
    `submission_date` DATE COMMENT 'The real-world business event date on which this negotiation instrument was formally submitted by the counterparty or their representative. Serves as the principal business event timestamp (date precision) for this transaction. Used for days-to-respond and negotiation cycle time analytics.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this negotiation instrument was received and recorded in the system, including time zone offset. Complements submission_date for precise SLA tracking and audit trail purposes. Sourced from Salesforce CRM or DocuSign CLM event log.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this negotiation instrument record was last modified in the data platform. Serves as the RECORD_AUDIT_UPDATED field for change tracking, incremental ETL processing, and audit compliance.',
    `zoning_contingency` BOOLEAN COMMENT 'Indicates whether this negotiation instrument is contingent upon receipt of required zoning approvals, entitlements, or permits. Common in development-oriented acquisitions and ground lease transactions.',
    CONSTRAINT pk_negotiation_instrument PRIMARY KEY(`negotiation_instrument_id`)
) COMMENT 'Pre-contract negotiation instrument record capturing all formal offers and letters of intent submitted during the brokerage deal process. Covers LOIs (non-binding), binding purchase offers, lease proposals, and counter-offers via a type discriminator. Records submission date, expiration date, proposed terms (price or rent PSF, lease term, TI allowance, CAM structure, NNN vs gross), contingencies (financing, inspection, due diligence period), earnest money deposit, counterparty identity, property reference, deal reference, negotiation round, binding/non-binding flag, and status (submitted, countered, accepted, rejected, expired, withdrawn). Serves as the SSOT for all pre-contract negotiation instruments in the brokerage deal lifecycle — from initial non-binding LOI through binding offer acceptance. Replaces the need for a separate offer entity by using a type discriminator to distinguish instrument types.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`commission` (
    `commission_id` BIGINT COMMENT 'Unique system-generated identifier for the commission record. Primary key for the brokerage.commission data product.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to lease.amendment. Business justification: Commissions are earned on brokered lease amendments (expansions, renewals). Linking commission to the specific amendment enables commission calculation based on amended lease terms and provides an aud',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Co-broker and referral commission disbursements are processed as AP invoices. Linking commission to its AP invoice enables payment reconciliation, 1099 reporting, and GL matching — standard real estat',
    `brokerage_broker_id` BIGINT COMMENT 'Foreign key linking to brokerage.broker. Business justification: Commission is earned by a specific broker. The commission table currently stores broker_license_number and broker_license_state as denormalized strings. Adding broker_id FK to the broker master record',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: A commission record is earned on a specific brokerage deal. While commission already links to listing, the deal is the transactional unit that triggers commission calculation and payment. Adding deal_',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Commission expense must be coded to a specific GL account for NOI statements and income reporting. Real estate finance teams require GL account coding on every commission record; gl_account_code is a ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Brokerage commissions must be allocated to a finance cost center for GL posting and P&L reporting. The commission table already carries a denormalized cost_center_code string; replacing it with a prop',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Commission amounts, splits, and disbursements require standardized currency classification for multi-market financial reporting, AP processing, and tax compliance. currency_code is a denormalized refe',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Disposition commissions on newly developed assets are tracked as soft costs against the development project budget. Development accountants reconcile actual commission expense to the proformas dispos',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Commission earned/paid triggers a GL journal entry (debit commission expense, credit commission payable). Finance controllers require the commission record to reference its GL posting for period-close',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Commission is earned upon lease execution. Linking commission directly to the executed lease agreement enables commission verification against lease terms (rent, area, term), commission audit trails, ',
    `listing_id` BIGINT COMMENT 'Reference to the property listing associated with this commission record, linking the earned commission to the specific deal or listing.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Commission calculation basis is the final sale price recorded in property_sale. Linking commission to property_sale enables commission amount validation against actual closing price, cap rate, and PSF',
    `space_id` BIGINT COMMENT 'Foreign key linking to property.space. Business justification: Commercial lease commissions are calculated on space area × lease rate × term. Commission records must reference the specific space for accurate calculation, audit, and GL allocation. Space-level comm',
    `renewal_option_id` BIGINT COMMENT 'Foreign key linking to lease.renewal_option. Business justification: Commissions earned on renewal option exercises require direct reference to the specific option to verify rent reset terms, area, and option conditions used as the commission calculation basis. The dea',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type determines commission applicability, tax withholding rules, 1099 reporting requirements, and GL account classification. Commission calculations and regulatory reporting depend on stan',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Residential lease commissions are calculated on unit rent and lease term. Commission records must reference the unit for audit trails, dispute resolution, and 1099 reporting. listing_id alone is insuf',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the net commission allocated to the primary listing or transaction agent per the agents commission split agreement with the brokerage house.',
    `agent_split_pct` DECIMAL(18,2) COMMENT 'Percentage of the net commission to house allocated to the primary agent per their individual commission split agreement. Expressed as a decimal (e.g., 70.0000 = 70%).',
    `approval_date` DATE COMMENT 'Date on which the commission was reviewed and approved for payment by the authorized approver (e.g., brokerage manager or finance controller). Required for SOX internal controls.',
    `approved_by` STRING COMMENT 'Name or identifier of the brokerage manager or finance officer who authorized the commission for payment. Supports SOX audit trail and internal controls.',
    `brokerage_side` STRING COMMENT 'Indicates which side of the transaction the brokerage firm represents: buy-side (buyer representation), sell-side (seller/landlord representation), tenant representation, landlord representation, or dual agency.. Valid values are `buy_side|sell_side|tenant_rep|landlord_rep|dual_agency`',
    `co_broker_commission_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the gross commission payable to the cooperating broker, derived from gross_commission_amount × co_broker_split_pct. Tracked separately for co-broker payment processing and 1099 reporting.',
    `co_broker_split_pct` DECIMAL(18,2) COMMENT 'Percentage of the gross commission allocated to the cooperating/co-broker in a co-brokerage arrangement. Expressed as a decimal (e.g., 50.0000 = 50%). Null if no co-broker is involved.',
    `commission_number` STRING COMMENT 'Externally-known business identifier for the commission record, used in Yardi Voyager AR and Salesforce CRM for cross-system reference and audit trail. Format: COMM-YYYY-NNNNNN.. Valid values are `^COMM-[0-9]{4}-[0-9]{6}$`',
    `commission_status` STRING COMMENT 'Current lifecycle state of the commission record: pending (awaiting trigger event), approved (authorized for payment), paid (disbursed), disputed (under review), or voided (cancelled).. Valid values are `pending|approved|paid|disputed|voided`',
    `commission_type` STRING COMMENT 'Classification of how the commission is calculated: percentage of total consideration (sale price or lease value), flat fee, Per Square Foot (PSF)-based, or hybrid combining multiple methods.. Valid values are `percentage|flat_fee|psf_based|hybrid`',
    `consideration_amount` DECIMAL(18,2) COMMENT 'The total transaction consideration on which the commission is calculated: sale price for disposition transactions, or total lease value (base rent over lease term) for leasing transactions. Expressed in the deal currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commission record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for a commission dispute when commission_status is disputed. Captures the nature of the disagreement (e.g., co-broker split disagreement, incorrect consideration amount, unauthorized dual agency).',
    `dispute_resolution_date` DATE COMMENT 'Date on which a disputed commission was formally resolved, enabling tracking of dispute lifecycle duration and compliance with NAR arbitration timelines.',
    `first_payment_due_date` DATE COMMENT 'The date on which the first (or only) commission payment is contractually due. Used for Accounts Receivable (AR) aging and cash flow forecasting.',
    `flat_fee` DECIMAL(18,2) COMMENT 'Fixed dollar amount of commission agreed upon in the listing agreement, applicable when commission_type is flat_fee. Mutually exclusive with commission_rate_pct for pure flat-fee structures.',
    `gross_commission_amount` DECIMAL(18,2) COMMENT 'Total gross commission earned before any co-broker splits, referral fee deductions, or internal adjustments. Calculated as consideration_amount × commission_rate_pct or as a flat fee or PSF-based amount per the commission type.',
    `installment_count` STRING COMMENT 'Total number of installment payments scheduled for this commission when payment_schedule is installment. Null for upfront or deferred payment schedules.',
    `is_co_broker` BOOLEAN COMMENT 'Indicates whether this commission involves a co-brokerage arrangement with an outside cooperating broker. True when a co-broker split applies; False for in-house transactions.',
    `is_referral` BOOLEAN COMMENT 'Indicates whether a referral fee deduction applies to this commission record, signaling that a portion of gross commission is payable to a referring party per a referral agreement.',
    `net_commission_to_house` DECIMAL(18,2) COMMENT 'Net commission retained by the brokerage firm after deducting co-broker split and referral fees from the gross commission. Represents the firms earned revenue for GL recognition. Calculated as gross_commission_amount − co_broker_commission_amount − referral_fee_amount.',
    `notes` STRING COMMENT 'Free-text field for additional context, special commission terms, deal-specific conditions, or internal commentary related to this commission record. Sourced from Yardi Voyager AR or Salesforce CRM deal notes.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of commission payments actually received and applied to this commission record to date. Used to calculate outstanding balance and track payment progress.',
    `paid_date` DATE COMMENT 'Date on which the commission was fully paid (status transitions to paid). Null if commission has not yet been fully disbursed.',
    `payment_schedule` STRING COMMENT 'Defines the timing structure for commission disbursement: upfront (single payment at trigger event), installment (multiple scheduled payments), deferred (payment after a future condition), or milestone-based (tied to specific project milestones).. Valid values are `upfront|installment|deferred|milestone_based`',
    `rate_pct` DECIMAL(18,2) COMMENT 'The agreed commission rate expressed as a percentage of total consideration, applicable when commission_type is percentage. Stored as a decimal (e.g., 3.0000 = 3%).',
    `rate_psf` DECIMAL(18,2) COMMENT 'Commission rate expressed as a dollar amount Per Square Foot (PSF) of Gross Leasable Area (GLA), applicable when commission_type is psf_based. Common in commercial leasing brokerage.',
    `referral_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of referral fees deducted from the gross commission payable to a referring party (agent, broker, or third-party referral source) per a referral agreement. Reduces net commission to house.',
    `salesforce_opportunity_code` STRING COMMENT 'Identifier of the corresponding deal opportunity record in Salesforce CRM, enabling traceability from deal pipeline stage to commission payment.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this commission record was sourced: Yardi Voyager AR, Salesforce CRM, MRI Software, or manually entered. Supports data lineage and reconciliation.. Valid values are `yardi_voyager|salesforce_crm|mri_software|manual`',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Dollar amount of tax withheld from the commission payment for IRS 1099 reporting purposes or applicable state/local tax withholding requirements for independent contractor agents.',
    `trigger_event` STRING COMMENT 'The contractual business event that activates the commission obligation: lease execution, property closing, Letter of Intent (LOI) acceptance, tenant occupancy, or loan funding.. Valid values are `lease_execution|closing|loi_acceptance|occupancy|funding`',
    `trigger_event_date` DATE COMMENT 'The date on which the commission trigger event occurred (e.g., lease execution date, closing date, LOI acceptance date), establishing the commission earned date for revenue recognition purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the commission record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) and audit trail in the Databricks Silver Layer.',
    `yardi_commission_code` STRING COMMENT 'Source system identifier for the commission record in Yardi Voyager Accounts Receivable module, used for reconciliation and data lineage.',
    CONSTRAINT pk_commission PRIMARY KEY(`commission_id`)
) COMMENT 'Master record defining the commission structure and earned commission for each brokerage deal or listing agreement. Captures commission type (percentage of consideration, flat fee, PSF-based), gross commission amount, co-broker split percentage, referral fee deductions, net commission to house, commission trigger event (lease execution, closing, LOI acceptance), payment schedule (upfront, installment), and commission status (pending, approved, paid, disputed). Sourced from Yardi Voyager AR and Salesforce CRM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`commission_split` (
    `commission_split_id` BIGINT COMMENT 'Unique surrogate identifier for each commission split disbursement record. Each row represents one payees share of a gross commission and its full payment lifecycle.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Commission splits to external co-brokers are paid via AP invoices. Linking split records to AP invoices enables payment reconciliation, 1099 reportability tracking, and withholding compliance — core r',
    `brokerage_broker_id` BIGINT COMMENT 'System identifier for the individual agent, co-broker firm, referral partner, or brokerage house receiving this split. Resolves to the appropriate party master record.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal or transaction that generated this commission. Corresponds to the Salesforce CRM opportunity or Yardi Voyager transaction record.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Commission split disbursements must be coded to GL accounts for agent compensation and co-broker expense reporting. gl_account_code is a denormalized representation; a proper FK to chart_of_accounts e',
    `closing_statement_id` BIGINT COMMENT 'Foreign key linking to transaction.closing_statement. Business justification: Commission splits are funded at closing. Linking commission_split to closing_statement enables reconciliation of each agents split disbursement against the HUD/ALTA closing statement, a standard brok',
    `co_broker_agreement_id` BIGINT COMMENT 'Reference to the co-brokerage agreement governing the split terms for an external co-broker firm. Null for in-house agent splits. Links to the executed co-broker contract.',
    `commission_id` BIGINT COMMENT 'Reference to the parent commission record from which this split is derived. Links all split rows belonging to the same gross commission event.',
    `commission_plan_id` BIGINT COMMENT 'Reference to the agent or co-broker commission plan that governs the split percentage and tier structure for this recipient. Provides the contractual basis for the allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Commission splits disbursed to brokers and co-brokers must be tracked against a finance cost center for GL allocation and payroll integration. The commission_split table carries a denormalized cost_ce',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Commission split disbursement amounts require standardized currency classification for AP processing, 1099 reporting, and multi-market financial reconciliation. currency_code is a denormalized referen',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each commission split disbursement generates a separate GL journal entry for agent compensation accounting. Finance teams reconcile split disbursements to journal entries during period close — a named',
    `lease_agreement_id` BIGINT COMMENT 'Reference to the referral agreement that entitles a referral partner to a portion of the commission. Null for non-referral splits. Required for NAR referral fee compliance.',
    `listing_id` BIGINT COMMENT 'Reference to the property listing associated with the commission-generating transaction. Links to the brokerage listing record.',
    `actual_disbursement_date` DATE COMMENT 'Date on which the commission payment was actually transmitted and confirmed as processed. Null until payment is executed. Used for financial close reconciliation and 1099 reporting.',
    `approval_date` DATE COMMENT 'Date on which this commission split record received management approval for disbursement processing.',
    `approval_status` STRING COMMENT 'Workflow approval status for this commission split record. Disbursements may not be processed until status is approved. Supports SOX segregation of duties controls.. Valid values are `pending_approval|approved|rejected|auto_approved`',
    `approved_by` STRING COMMENT 'Name or user identifier of the manager or finance officer who approved this commission split for disbursement. Required for SOX segregation of duties audit trail.',
    `bank_account_reference` STRING COMMENT 'Tokenized or masked reference to the recipients bank account used for ACH or wire disbursement. Actual account details are stored in the secure banking vault; this field holds only the reference token.',
    `brokerage_side` STRING COMMENT 'Indicates which side of the transaction the recipient represented: buy-side, sell-side, dual agency, tenant representation, or landlord representation. Drives commission split logic and disclosure requirements.. Valid values are `buy_side|sell_side|dual_agency|tenant_rep|landlord_rep`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission split record was first created in the system. Supports audit trail, data lineage, and SOX financial controls.',
    `desk_fee_deduction` DECIMAL(18,2) COMMENT 'Dollar amount of brokerage desk fee or franchise fee deducted from the agents gross split prior to net disbursement. Applicable for desk-fee brokerage models.',
    `disbursement_status` STRING COMMENT 'Current lifecycle status of the commission payment for this split record. Drives AP workflow actions and financial reconciliation. [ENUM-REF-CANDIDATE: scheduled|processed|failed|reversed|on_hold|cancelled — promote to reference product]. Valid values are `scheduled|processed|failed|reversed|on_hold|cancelled`',
    `errors_omissions_deduction` DECIMAL(18,2) COMMENT 'Dollar amount deducted from the agents commission split for Errors and Omissions (E&O) insurance contribution. Reduces the net disbursement amount.',
    `gross_commission_amount` DECIMAL(18,2) COMMENT 'Total gross commission earned on the transaction before any splits, overrides, or deductions. Serves as the base from which all split percentages are calculated.',
    `is_1099_reportable` BOOLEAN COMMENT 'Indicates whether this commission payment is subject to IRS Form 1099-MISC or 1099-NEC reporting. True for independent contractors and co-broker firms; False for W-2 employees.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Final net dollar amount to be disbursed to the recipient after applying the split percentage, override adjustments, and any deductions (e.g., errors and omissions insurance, desk fees). This is the actual payment amount.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or operational notes related to this commission split record. Used by AP staff and brokerage managers for exception handling.',
    `override_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any manual override or adjustment applied to the base split amount. May be positive (bonus/incentive) or negative (clawback/deduction). Requires management authorization.',
    `override_reason` STRING COMMENT 'Narrative explanation for any override adjustment applied to the base split amount. Required for audit trail and management approval documentation.',
    `payment_method` STRING COMMENT 'Method by which the commission disbursement is transmitted to the recipient (e.g., wire transfer, ACH, check). Determines processing timelines and banking requirements.. Valid values are `wire|ach|check|direct_deposit|zelle`',
    `recipient_license_number` STRING COMMENT 'State-issued real estate license number of the receiving agent or broker. Required for regulatory compliance verification and brokerage audit documentation.',
    `recipient_license_state` STRING COMMENT 'Two-letter US state code where the recipients real estate license is issued. Used for multi-state compliance tracking and license verification.. Valid values are `^[A-Z]{2}$`',
    `recipient_name` STRING COMMENT 'Full legal name of the individual agent, co-broker firm, or entity receiving this commission split. Used for 1099 reporting, remittance advices, and audit trails.',
    `recipient_type` STRING COMMENT 'Classification of the payee receiving this commission split. Determines disbursement workflow, 1099 reporting obligations, and GL coding. [ENUM-REF-CANDIDATE: in_house_agent|co_broker_firm|referral_partner|brokerage_house|team_lead|franchise_fee — promote to reference product]. Valid values are `in_house_agent|co_broker_firm|referral_partner|brokerage_house|team_lead|franchise_fee`',
    `reversal_date` DATE COMMENT 'Date on which a reversed commission disbursement was officially reversed in the AP system. Null unless disbursement_status is reversed.',
    `reversal_reason` STRING COMMENT 'Narrative explanation for why a previously processed commission disbursement was reversed. Required when disbursement_status is reversed. Supports audit trail and financial restatement documentation.',
    `salesforce_opportunity_code` STRING COMMENT 'Salesforce CRM opportunity identifier associated with the deal that generated this commission. Enables cross-system reconciliation between CRM deal pipeline and AP disbursement records.',
    `scheduled_disbursement_date` DATE COMMENT 'Date on which the commission payment is scheduled to be released to the recipient. Used for AP cash flow planning and agent expectation management.',
    `split_amount` DECIMAL(18,2) COMMENT 'Gross dollar amount allocated to this recipient based on the split percentage applied to the gross commission. Pre-override base allocation amount.',
    `split_number` STRING COMMENT 'Sequential line number of this split record within the parent commission. Used to order and identify individual payee allocations within a multi-party commission disbursement.',
    `split_pct` DECIMAL(18,2) COMMENT 'Contractual percentage of the gross commission allocated to this recipient, expressed as a decimal (e.g., 0.5000 = 50%). Defined by the agent commission plan or co-broker agreement.',
    `split_reference_number` STRING COMMENT 'Externally visible alphanumeric reference number assigned to this split disbursement record, used in AP workflows, remittance advices, and audit correspondence.',
    `tax_id_reference` STRING COMMENT 'Tokenized reference to the recipients IRS Tax Identification Number (TIN/EIN/SSN) used for 1099 reporting. Actual TIN is stored in the secure tax vault; this field holds only the reference token.',
    `transaction_close_date` DATE COMMENT 'Date on which the underlying real estate transaction (sale or lease execution) closed, triggering the commission earning event. The principal business event timestamp for this commission split.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission split record was last modified. Used for change data capture, audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Dollar amount of IRS backup withholding deducted from the commission disbursement when the recipient has not provided a valid TIN or is subject to backup withholding per IRS rules.',
    `yardi_ap_transaction_ref` STRING COMMENT 'Yardi Voyager Accounts Payable transaction identifier for this commission disbursement. Provides the financial system audit trail linking the commission split to the GL posting and AP check run.',
    CONSTRAINT pk_commission_split PRIMARY KEY(`commission_split_id`)
) COMMENT 'Detailed allocation and disbursement record breaking down how a gross commission is split among participating brokers, agents, co-brokers, and the brokerage house, and tracking actual payment execution through to settlement. Captures recipient type (in-house agent, co-broker firm, referral partner, brokerage house), recipient identity, split percentage, split dollar amount, override adjustments, disbursement date, payment method (wire, ACH, check), bank account reference, disbursement status (scheduled, processed, failed, reversed), and Yardi Voyager AP transaction reference. Serves as the SSOT for both commission allocation and disbursement — each row represents one payees share of a commission and the payment lifecycle for that share. Supports multi-party commission disbursement workflows, agent production tracking, 1099 reporting, and provides the financial audit trail for all commission payments.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` (
    `co_broker_agreement_id` BIGINT COMMENT 'Unique system-generated identifier for the co-brokerage agreement record. Primary key for this entity.',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to brokerage.deal. Business justification: A co-broker agreement is executed in the context of a specific brokerage deal. The co_broker_agreement currently links to listing but not to the deal itself. Adding deal_id enables direct association ',
    `commission_id` BIGINT COMMENT 'Foreign key linking to brokerage.commission. Business justification: A co-broker agreement defines the commission split terms between the listing brokerage and the cooperating broker. Linking co_broker_agreement to the commission record enables direct traceability betw',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Co-broker commission split amounts and flat fees require standardized currency classification for multi-market financial reporting and inter-firm commission disbursement. currency_code is a denormaliz',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Co-broker agreements are subject to jurisdiction-specific real estate commission rules, MLS cooperation requirements, and license law. governing_law_state is a denormalized text field. Linking to comp',
    `listing_id` BIGINT COMMENT 'Reference to the property listing or deal for which this co-brokerage arrangement is established. Links the agreement to a specific listing record.',
    `agreement_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to this co-brokerage agreement, used for reference in correspondence, DocuSign CLM, and Salesforce CRM deal tracking.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the co-brokerage agreement, tracking progression from draft through execution to termination or expiry.. Valid values are `draft|pending_execution|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the co-brokerage arrangement indicating whether it covers a sale transaction, lease transaction, combined sale and lease, referral arrangement, or buyer representation engagement.. Valid values are `sale|lease|sale_and_lease|referral|buyer_representation`',
    `amendment_count` STRING COMMENT 'Total number of formal amendments executed against this co-brokerage agreement since its original execution. Supports version control and audit trail requirements.',
    `brokerage_side` STRING COMMENT 'Indicates which side of the transaction the cooperating broker represents: buy-side (buyer representation), sell-side (seller representation), tenant representation, landlord representation, or dual agency where permitted.. Valid values are `buy_side|sell_side|tenant_rep|landlord_rep|dual_agency`',
    `co_broker_commission_flat_fee` DECIMAL(18,2) COMMENT 'Fixed flat-fee dollar amount agreed as the co-broker commission, used when the arrangement is structured as a flat fee rather than a percentage split. Nullable when percentage-based structure applies.',
    `co_broker_commission_split_pct` DECIMAL(18,2) COMMENT 'Agreed percentage of the total gross commission to be paid to the cooperating broker firm upon successful transaction close. Expressed as a decimal (e.g., 0.5000 = 50%). Governs commission disbursement in Yardi Voyager AR.',
    `commission_paid_date` DATE COMMENT 'Date on which the co-broker commission was disbursed to the cooperating broker firm. Nullable until payment is made. Reconciled against Yardi Voyager General Ledger.',
    `commission_paid_flag` BOOLEAN COMMENT 'Indicates whether the co-broker commission has been disbursed following transaction close. True = commission paid; False = pending payment. Supports Yardi Voyager AP commission disbursement tracking.',
    `commission_structure` STRING COMMENT 'Defines the commission payment structure for the co-broker arrangement: percentage split of gross commission, flat fee, hybrid (combination), or referral fee arrangement.. Valid values are `percentage_split|flat_fee|hybrid|referral_fee`',
    `cooperating_firm_license_number` STRING COMMENT 'State-issued real estate brokerage license number for the cooperating firm. Required for regulatory compliance and commission disbursement validation.',
    `cooperating_firm_license_state` STRING COMMENT 'Two-letter US state code in which the cooperating broker firm holds its primary real estate brokerage license (e.g., CA, NY, TX).',
    `cooperating_firm_name` STRING COMMENT 'Legal registered name of the cooperating (co-broker) brokerage firm participating in this arrangement. Sourced from Salesforce CRM and verified against state licensing records.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-brokerage agreement record was first created in the data platform. Supports audit trail and data lineage requirements under SOX and GDPR.',
    `designated_agent_email` STRING COMMENT 'Primary business email address for the designated cooperating agent, used for deal communications, DocuSign CLM routing, and Salesforce CRM contact management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `designated_agent_license_number` STRING COMMENT 'State-issued individual real estate salesperson or broker license number for the designated cooperating agent. Required for commission payment and regulatory compliance.',
    `designated_agent_license_state` STRING COMMENT 'Two-letter US state code in which the designated cooperating agent holds their individual real estate license.',
    `designated_agent_name` STRING COMMENT 'Full legal name of the individual real estate agent designated by the cooperating broker firm to represent the co-broker side of this transaction.',
    `designated_agent_phone` STRING COMMENT 'Primary business phone number for the designated cooperating agent for deal coordination and showing scheduling.',
    `dispute_resolution_method` STRING COMMENT 'Contractually agreed method for resolving disputes arising from this co-brokerage arrangement, as specified in the agreement terms.. Valid values are `arbitration|mediation|litigation|negotiation`',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier from DocuSign CLM for the digitally executed co-brokerage agreement, enabling retrieval of the signed document and audit trail of signature events.',
    `dual_agency_consent` BOOLEAN COMMENT 'Indicates whether all parties have provided informed written consent to dual agency representation where the cooperating broker or designated agent may represent both sides of the transaction.',
    `effective_date` DATE COMMENT 'Date from which the co-brokerage agreement becomes operative and the cooperating broker is authorized to act. May differ from execution date if a future start is stipulated.',
    `execution_date` DATE COMMENT 'Date on which the co-brokerage agreement was formally executed and signed by all parties, establishing the binding effective date of cooperation.',
    `expiration_date` DATE COMMENT 'Date on which the co-brokerage agreement expires if no transaction closes. Nullable for open-ended arrangements tied solely to deal close.',
    `last_amended_date` DATE COMMENT 'Date of the most recent formal amendment to this co-brokerage agreement. Nullable when no amendments have been executed.',
    `mls_cooperation_flag` BOOLEAN COMMENT 'Indicates whether this co-brokerage arrangement is governed by MLS cooperation rules and the cooperating broker was procured through MLS. True = MLS cooperation applies; False = off-MLS or private arrangement.',
    `mls_number` STRING COMMENT 'MLS listing number associated with the property or deal covered by this co-brokerage agreement, enabling cross-reference to MLS cooperation records and CoStar Suite data.',
    `notes` STRING COMMENT 'Free-text field for capturing additional deal-specific terms, special conditions, or operational notes related to the co-brokerage arrangement not captured in structured fields.',
    `protection_period_days` STRING COMMENT 'Number of days after agreement expiration during which the cooperating broker retains commission rights if a transaction closes with a prospect they introduced during the agreement term.',
    `salesforce_opportunity_code` STRING COMMENT 'Unique identifier of the corresponding deal opportunity record in Salesforce CRM, enabling traceability between the co-brokerage agreement and the deal pipeline stage.',
    `snda_execution_date` DATE COMMENT 'Date on which the required SNDA agreement was executed, confirming lender consent to the co-brokerage arrangement. Nullable when SNDA is not required.',
    `snda_required` BOOLEAN COMMENT 'Indicates whether a Subordination, Non-Disturbance and Attornment (SNDA) agreement is required as a condition of this co-brokerage arrangement, typically applicable in commercial lease transactions.',
    `source_system` STRING COMMENT 'Operational system of record from which this co-brokerage agreement record was originated or last updated (e.g., Salesforce CRM, Yardi Voyager, DocuSign CLM).. Valid values are `Salesforce|Yardi|DocuSign|MRI|Manual`',
    `termination_date` DATE COMMENT 'Date on which the co-brokerage agreement was terminated prior to its natural expiration, if applicable. Nullable for agreements that expire naturally or remain active.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the co-brokerage agreement was terminated before its natural expiration. Nullable for active or naturally expired agreements.. Valid values are `deal_closed|mutual_agreement|breach|license_revoked|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this co-brokerage agreement record in the data platform. Supports change tracking and audit compliance.',
    CONSTRAINT pk_co_broker_agreement PRIMARY KEY(`co_broker_agreement_id`)
) COMMENT 'Formal co-brokerage arrangement record between the listing brokerage and a cooperating broker firm for a specific deal or listing. Captures cooperating broker firm name, license number, designated agent, agreed co-broker commission split percentage, SNDA requirements, MLS cooperation flag, agreement execution date, and deal or listing reference. Governs the legal and financial terms of inter-firm brokerage cooperation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` (
    `brokerage_broker_id` BIGINT COMMENT 'Unique surrogate identifier for the broker or agent record within the brokerage platform. Serves as the primary key and SSOT reference for all deal, listing, commission, showing, and prospect assignment records.',
    `compensation_plan_id` BIGINT COMMENT 'Reference to the commission plan record that governs this brokers split structure, Gross Commission Income (GCI) thresholds, and payout tiers. Drives commission calculation for all closed transactions.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Broker GCI (gross commission income) tracking and compensation reporting require standardized currency classification for multi-market broker performance analytics and payroll processing. currency_cod',
    `employee_id` BIGINT COMMENT 'Reference to the corresponding workforce domain employee record in ADP Workforce Now or SAP S/4HANA HCM. Links the brokerage-specific professional identity to the HR master record. Distinct from broker_id — this is the HR system identifier.',
    `additional_license_states` STRING COMMENT 'Comma-separated list of additional US state codes where the broker holds active real estate licenses beyond the primary license state. Supports multi-state brokerage operations and deal eligibility validation.',
    `background_check_date` DATE COMMENT 'Date the most recent background check was completed for the broker. Used to determine recency of compliance verification and schedule periodic re-checks per brokerage policy.',
    `background_check_status` STRING COMMENT 'Status of the brokers most recent background check conducted as part of onboarding or periodic compliance review. Required for NAR membership, state licensing, and brokerage risk management.. Valid values are `passed|pending|failed|not_required`',
    `broker_type` STRING COMMENT 'Classification of the brokers role and authority level within the brokerage. Determines supervisory responsibilities, permissible transaction types, and commission split eligibility. [ENUM-REF-CANDIDATE: principal_broker|managing_broker|associate_broker|leasing_agent|buyers_agent|sellers_agent — promote to reference product]. Valid values are `principal_broker|managing_broker|associate_broker|leasing_agent|buyers_agent|sellers_agent`',
    `ccim_designation` BOOLEAN COMMENT 'Indicates whether the broker holds the CCIM designation from the CCIM Institute, signifying advanced expertise in commercial and investment real estate. Used for deal team assembly and marketing credentials.',
    `continuing_education_due_date` DATE COMMENT 'Date by which the broker must complete state-mandated continuing education (CE) credits to maintain their real estate license. Used to trigger CE completion reminders and license renewal workflows.',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'Number of continuing education (CE) credit hours completed by the broker in the current license renewal cycle. Tracked against state-mandated CE requirements for license renewal compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker record was first created in the brokerage data platform. Supports audit trail, data lineage, and SOX compliance for the Silver Layer lakehouse.',
    `designated_market_areas` STRING COMMENT 'Comma-separated list of geographic market area codes or names that the broker is authorized and expected to serve. Used for lead routing, listing assignment, and market coverage gap analysis in CoStar Suite.',
    `dual_agency_authorized` BOOLEAN COMMENT 'Indicates whether the broker is authorized to act as a dual agent (representing both buyer/tenant and seller/landlord in the same transaction) per state law and brokerage policy. Drives compliance checks on deal assignments.',
    `email` STRING COMMENT 'Primary business email address for the broker. Used for Salesforce CRM deal assignments, MLS communications, DocuSign CLM contract routing, and internal brokerage notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_type` STRING COMMENT 'Classification of the brokers employment relationship with the brokerage. Determines payroll processing method (W-2 via ADP vs. 1099 independent contractor), benefits eligibility, and commission payout structure.. Valid values are `W2|1099|contract|part_time`',
    `errors_omissions_expiration_date` DATE COMMENT 'Expiration date of the brokers E&O insurance policy. Used to trigger renewal alerts and enforce compliance gates before deal assignment or listing agreement execution.',
    `errors_omissions_insurer` STRING COMMENT 'Name of the insurance carrier providing Errors and Omissions (E&O) professional liability coverage for the broker. Required for brokerage compliance and risk management. Tracked for policy renewal monitoring.',
    `errors_omissions_policy_number` STRING COMMENT 'Policy number for the brokers Errors and Omissions (E&O) professional liability insurance. Required for compliance verification, co-broker agreements, and listing agreement execution.',
    `full_name` STRING COMMENT 'Full legal name of the broker or agent as it appears on their state license. Used for license verification, contract execution, MLS membership, and regulatory reporting.',
    `gci_prior_year` DECIMAL(18,2) COMMENT 'Total Gross Commission Income (GCI) earned by the broker in the prior full calendar or fiscal year. Used for year-over-year production benchmarking, tier assignment at year-start, and historical performance analytics.',
    `gci_ytd` DECIMAL(18,2) COMMENT 'Total Gross Commission Income (GCI) earned by the broker in the current calendar or fiscal year to date. Used for production tier evaluation, commission plan threshold tracking, and annual performance reporting. Sourced from closed transaction records.',
    `hire_date` DATE COMMENT 'Date the broker was formally engaged by the brokerage, either as a W-2 employee or 1099 independent contractor. Used for tenure calculations, production tier eligibility, and commission plan assignment.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the broker is currently active and eligible to be assigned to deals, listings, showings, and prospect records. Set to false upon termination, license suspension, or voluntary leave.',
    `license_expiration_date` DATE COMMENT 'Date on which the brokers state real estate license expires. Used to trigger renewal workflows, compliance alerts, and eligibility checks before deal assignment or listing execution.',
    `license_number` STRING COMMENT 'State-issued real estate license number for the broker or agent. Required for MLS membership, listing agreements, co-broker arrangements, and regulatory compliance filings. Unique per issuing state.',
    `license_state` STRING COMMENT 'Two-letter US state code of the jurisdiction that issued the brokers real estate license. Determines the governing state real estate commission and applicable transaction law.. Valid values are `^[A-Z]{2}$`',
    `license_status` STRING COMMENT 'Current status of the brokers state-issued real estate license. Drives eligibility to execute listings, represent clients, and receive commission. Monitored for compliance with state real estate commission requirements.. Valid values are `active|inactive|suspended|expired|pending_renewal`',
    `mls_board_name` STRING COMMENT 'Name of the MLS board or association through which the broker holds membership. Determines listing syndication scope, co-broker cooperation rules, and MLS data feed access.',
    `mls_member_number` STRING COMMENT 'Unique membership identifier assigned by the brokers primary Multiple Listing Service (MLS) board. Required for listing syndication, MLS data access, and co-broker cooperation agreements.',
    `mri_agent_code` STRING COMMENT 'Agent or broker code assigned in MRI Software for lease management and residential management commission tracking. Used for cross-system reconciliation of commission payouts.',
    `nar_member_number` STRING COMMENT 'NAR-assigned membership number confirming the broker holds active REALTOR® designation. Required for MLS access, NAR Code of Ethics compliance, and use of the REALTOR® trademark.',
    `office_location` STRING COMMENT 'Name or code of the brokerage office or branch to which the broker is physically assigned. Used for geographic market coverage reporting, desk assignment, and regional production analytics.',
    `phone` STRING COMMENT 'Primary contact phone number for the broker. Used for prospect assignment routing, showing coordination, and client communication tracking in Salesforce CRM.. Valid values are `^+?[1-9]d{1,14}$`',
    `production_tier` STRING COMMENT 'Brokers current production tier classification based on Gross Commission Income (GCI) thresholds defined in the commission plan. Determines commission split rates, marketing support eligibility, and recognition program participation.. Valid values are `platinum|gold|silver|bronze|associate`',
    `salesforce_user_code` STRING COMMENT 'Unique user identifier assigned to the broker in Salesforce CRM. Used to link deal pipeline records, prospect assignments, showing activity, and brokerage opportunity stages to the broker master record.',
    `sior_designation` BOOLEAN COMMENT 'Indicates whether the broker holds the SIOR designation, signifying top-tier expertise in industrial and office commercial real estate. Used for deal team assembly and client-facing credentials.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this broker record was sourced or last updated. Used for data lineage tracking, conflict resolution during ETL, and Silver Layer provenance auditing.. Valid values are `salesforce|yardi|mri|adp|manual`',
    `specialization` STRING COMMENT 'Primary property type specialization of the broker. Drives deal assignment logic, listing eligibility, and production tier benchmarking. [ENUM-REF-CANDIDATE: residential|commercial|industrial|retail|multifamily|land|mixed_use — promote to reference product]',
    `team_name` STRING COMMENT 'Name of the brokerage team or desk to which the broker is assigned. Teams share leads, listings, and commission splits. Used for production reporting, deal routing, and organizational hierarchy in Salesforce CRM.',
    `termination_date` DATE COMMENT 'Date the brokers engagement with the brokerage was formally ended. Null for active brokers. Used to close deal assignments, revoke MLS access, and finalize commission payouts for in-flight transactions.',
    `transaction_side` STRING COMMENT 'Indicates whether the broker primarily operates on the buy-side (tenant/buyer representation), sell-side (landlord/seller representation), or both. Used for deal pipeline segmentation and commission structure determination.. Valid values are `buy_side|sell_side|both|lease_side`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker record was most recently modified. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance in the Databricks Silver Layer.',
    `yardi_agent_code` STRING COMMENT 'Agent or broker code assigned in Yardi Voyager for lease administration and accounts receivable commission tracking. Used to reconcile commission payables and link broker activity to property management records.',
    CONSTRAINT pk_brokerage_broker PRIMARY KEY(`brokerage_broker_id`)
) COMMENT 'Master record for licensed brokers and agents operating within or on behalf of the brokerage. Captures broker type (principal broker, associate broker, managing broker, leasing agent, buyers agent, sellers agent), state license number, license expiration date, NAR/CCIM/SIOR membership status, MLS membership ID, designated market areas, production tier (based on GCI thresholds), hire date, employment type (W-2, 1099 independent contractor), team/desk assignment, and commission plan reference. Distinct from the workforce domains employee record — this is the brokerage-specific professional identity, licensing, and production tracking record. Serves as the SSOT for broker identity referenced by deals, listings, commissions, showings, and prospect assignments.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`broker_license` (
    `broker_license_id` BIGINT COMMENT 'Unique surrogate identifier for each broker or agent license record in the system. Primary key for the broker_license data product.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the broker or agent who holds this license. A single agent may hold multiple license records across jurisdictions.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Broker licenses are issued under specific jurisdictions governing CE requirements, renewal rules, and disciplinary authority. Linking broker_license to compliance.jurisdiction enables automated CE com',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Broker licenses are subject to specific regulatory obligations (mandatory CE hours, E&O insurance requirements, renewal filing deadlines, background check mandates). Linking broker_license to regulato',
    `ce_compliance_status` STRING COMMENT 'Current compliance status for continuing education (CE) requirements in the current renewal cycle. Deficient status triggers remediation workflows. Waived status applies when a state grants an exemption (e.g., first-time renewal, military service).. Valid values are `compliant|in_progress|deficient|waived`',
    `ce_deadline_date` DATE COMMENT 'The date by which all required continuing education (CE) hours must be completed for the current renewal cycle. Typically aligns with or precedes the license expiration date. Drives CE completion alerts and compliance reporting.',
    `ce_hours_completed` STRING COMMENT 'Total number of continuing education (CE) hours completed by the agent in the current renewal cycle. Compared against ce_hours_required to determine CE compliance status. Sourced from state CE tracking systems.',
    `ce_hours_required` STRING COMMENT 'Total number of continuing education (CE) hours required by the issuing state for the current renewal cycle. Varies by state and license type. Used to track CE compliance obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this broker license record was first created in the system. Used for audit trail, data lineage, and compliance record-keeping in accordance with SOX financial controls and GDPR data management requirements.',
    `disciplinary_action_date` DATE COMMENT 'The date on which the most recent disciplinary action was recorded or imposed by the regulatory authority. Populated only when disciplinary_flag is True. Used for compliance timeline tracking.',
    `disciplinary_action_type` STRING COMMENT 'Type of disciplinary action recorded against this license. Populated only when disciplinary_flag is True. Used for compliance risk scoring and regulatory reporting to NAR and state commissions.. Valid values are `complaint|fine|suspension|revocation|reprimand|consent_order`',
    `disciplinary_flag` BOOLEAN COMMENT 'Indicates whether the agent has an active or historical disciplinary action, complaint, or sanction on record with the issuing state commission or NAR. True triggers compliance review before deal assignment or listing authorization.',
    `errors_omissions_expiry_date` DATE COMMENT 'Expiration date of the agents Errors and Omissions (E&O) insurance policy. Drives automated alerts for policy renewal to ensure continuous coverage and brokerage compliance.',
    `errors_omissions_insured` BOOLEAN COMMENT 'Indicates whether the agent holds active Errors and Omissions (E&O) professional liability insurance coverage. E&O insurance is required by many brokerages and some states as a condition of active licensure. Supports risk management and brokerage compliance.',
    `errors_omissions_policy_number` STRING COMMENT 'Policy number of the agents active Errors and Omissions (E&O) professional liability insurance. Used for claims processing, brokerage risk management, and regulatory compliance verification.',
    `expiration_date` DATE COMMENT 'The date on which the license expires and must be renewed to remain valid. Licenses operating past this date without renewal are flagged as expired and the agent is prohibited from conducting brokerage activity. Drives automated renewal alerts.',
    `issue_date` DATE COMMENT 'The date on which the license was originally issued by the regulatory authority. Used to calculate license tenure, renewal cycles, and continuing education (CE) compliance windows.',
    `issuing_authority` STRING COMMENT 'Full name of the state real estate commission or regulatory body that issued the license (e.g., California Department of Real Estate, New York Department of State Division of Licensing Services). Supports regulatory correspondence and audit trails.',
    `issuing_state` STRING COMMENT 'Two-letter US state code of the jurisdiction that issued this license (e.g., CA, NY, TX). Brokers operating across state lines hold separate licenses per jurisdiction. Used for multi-state compliance tracking and deal assignment validation.. Valid values are `^[A-Z]{2}$`',
    `license_class` STRING COMMENT 'Indicates whether the license authorizes residential brokerage, commercial real estate (CRE) brokerage, or both. Determines which transaction types and listings the agent is authorized to handle under this license.. Valid values are `residential|commercial|both`',
    `license_endorsements` STRING COMMENT 'Comma-separated list of specialty endorsements or designations attached to this license (e.g., ABR — Accredited Buyers Representative, CRS — Certified Residential Specialist, CCIM — Certified Commercial Investment Member, SIOR). Supports agent capability matching for deal assignments.',
    `license_notes` STRING COMMENT 'Free-text field for compliance officers or brokerage administrators to record additional context about this license record, such as pending reinstatement conditions, special restrictions, or correspondence with the state commission.',
    `license_number` STRING COMMENT 'The official license number assigned by the issuing state or regulatory authority. Used for NAR compliance verification, MLS access, and co-broker arrangement validation. Corresponds to the license number tracked in Salesforce CRM brokerage activity records.',
    `license_status` STRING COMMENT 'Current lifecycle status of the license as reported by the issuing authority. Active licenses are required for brokerage activity. Suspended or revoked licenses trigger compliance flags and must be reported to NAR and state commissions.. Valid values are `active|inactive|expired|suspended|revoked|pending_renewal`',
    `license_type` STRING COMMENT 'Classification of the license held by the agent or broker, indicating their level of authority and responsibility. Salesperson licenses require broker supervision; broker and managing broker licenses allow independent practice and supervision of others.. Valid values are `salesperson|broker|managing_broker|associate_broker|broker_in_charge`',
    `license_verification_date` DATE COMMENT 'The most recent date on which the license status was verified against the issuing state commissions public license lookup or ARELLO (Association of Real Estate License Law Officials) database. Supports ongoing compliance monitoring.',
    `license_verification_source` STRING COMMENT 'The source used to verify the license status during the most recent verification. State portal refers to the issuing states online license lookup; ARELLO is the national license law officials database; manual indicates staff-verified; third_party indicates a vendor verification service.. Valid values are `state_portal|arello|manual|third_party`',
    `mls_member_number` STRING COMMENT 'The agents membership identifier with the local Multiple Listing Service (MLS) board. Required for MLS listing access and syndication. May differ from NAR member ID. Supports MLS compliance and listing authorization validation.',
    `nar_member_number` STRING COMMENT 'The agents membership identifier with the National Association of Realtors (NAR). Required for MLS access and use of the REALTOR® designation. Null if the agent is not a NAR member.',
    `original_issue_date` DATE COMMENT 'The date the license was first ever issued to this agent in this jurisdiction, regardless of subsequent renewals. Distinct from issue_date which reflects the current license term start. Used to calculate total years licensed in a state for seniority and compliance reporting.',
    `primary_practice_state` BOOLEAN COMMENT 'Indicates whether this license record represents the agents primary state of practice. An agent holding licenses in multiple states will have exactly one record with this flag set to True. Used for reporting, commission calculations, and regulatory filings.',
    `reciprocal_home_state` STRING COMMENT 'Two-letter US state code of the agents primary licensing state from which reciprocity was granted. Populated only when reciprocal_license is True. Required for multi-state compliance tracking.. Valid values are `^[A-Z]{2}$`',
    `reciprocal_license` BOOLEAN COMMENT 'Indicates whether this license was obtained through a reciprocity agreement between states, rather than by passing the full state licensing examination. Reciprocal licenses may carry additional restrictions in some jurisdictions.',
    `renewal_date` DATE COMMENT 'The date on which the license was most recently renewed by the issuing authority. Null if the license has never been renewed (original issuance still active). Supports renewal cycle tracking and CE compliance verification.',
    `renewal_status` STRING COMMENT 'Current status of the license renewal process. Tracks whether a renewal application has been initiated, submitted to the state commission, approved, or lapsed due to non-action before the expiration date.. Valid values are `not_due|pending|submitted|approved|lapsed`',
    `salesforce_contact_code` STRING COMMENT 'The unique identifier of the corresponding agent or broker contact record in Salesforce CRM. Enables cross-system traceability between the broker license compliance record and the CRM brokerage activity tracking profile.',
    `source_system` STRING COMMENT 'The operational system of record from which this license record was sourced or last updated. Supports data lineage tracking and reconciliation across Salesforce CRM, Yardi Voyager, and manual compliance entry workflows.. Valid values are `salesforce|yardi|manual|arello|state_portal`',
    `sponsoring_broker_license_number` STRING COMMENT 'The official license number of the sponsoring broker or brokerage firm. Used to validate the sponsorship relationship with the state commission and to cross-reference brokerage firm licensing records.',
    `sponsoring_broker_name` STRING COMMENT 'The name of the licensed broker or brokerage firm under whose sponsorship this salesperson or associate broker license is held. Required for salesperson-level licenses in most states. Null for independent broker licenses.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this broker license record was most recently modified. Supports change tracking, audit trails, and incremental data pipeline processing in the Databricks Lakehouse Silver Layer.',
    `yardi_agent_code` STRING COMMENT 'The agent or broker code as recorded in Yardi Voyager, used to link license compliance data to lease administration, commission processing, and accounts receivable records within the property management system.',
    CONSTRAINT pk_broker_license PRIMARY KEY(`broker_license_id`)
) COMMENT 'Tracks all real estate licenses held by each broker or agent, including state-by-state licensing, license type (salesperson, broker, managing broker), issuing authority, license number, issue date, expiration date, renewal status, CE (continuing education) hours completed, and disciplinary flags. Supports NAR and state regulatory compliance. A broker may hold multiple licenses across jurisdictions.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` (
    `mls_syndication_id` BIGINT COMMENT 'Unique surrogate identifier for each MLS syndication record tracking the distribution of a listing to a specific external platform.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed agent or broker responsible for managing the syndication of this listing to the target platform.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: MLS syndication is authorized and funded as part of a specific marketing campaign. Linking mls_syndication to campaign enables campaign spend attribution for syndication costs and tracks which campaig',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: MLS syndication is a specific marketing channel (MLS/IDX). Linking mls_syndication to marketing.channel enables unified channel performance reporting across all syndication and paid channels — standar',
    `listing_id` BIGINT COMMENT 'Reference to the internal listing record being syndicated to the external platform.',
    `costar_property_code` STRING COMMENT 'The CoStar Suite-assigned property identifier for the listing, used for cross-referencing syndication records with CoStar market data and comparable analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and timestamp when this syndication record was first created in the system, providing an audit trail for data lineage and compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the listing price transmitted to the target platform (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_feed_type` STRING COMMENT 'The technical protocol or feed standard used to transmit listing data to the target platform. IDX (Internet Data Exchange) is used for consumer-facing websites; VOW (Virtual Office Website) for registered users; RETS (Real Estate Transaction Standard) for legacy feeds; RESO Web API for modern REST-based feeds; DIRECT for proprietary platform integrations.. Valid values are `IDX|VOW|RETS|RESO_WEB_API|DIRECT`',
    `expiration_date` DATE COMMENT 'The date on which the syndication of this listing to the target platform is scheduled to expire or be automatically withdrawn, aligned with the listing agreement expiration.',
    `floor_plan_synced` BOOLEAN COMMENT 'Indicates whether a floor plan document or image was included in the syndication payload transmitted to the target platform.',
    `http_response_code` STRING COMMENT 'The HTTP status code returned by the target platforms API upon the most recent syndication transmission attempt (e.g., 200 for success, 400 for bad request, 500 for server error). Applicable for API-based transmissions.',
    `idx_opt_in` BOOLEAN COMMENT 'Indicates whether the listing owner or agent has opted in to IDX distribution, permitting the listing to be displayed on participating broker and agent websites via the IDX feed.',
    `is_featured_listing` BOOLEAN COMMENT 'Indicates whether the listing has been designated as a featured or premium placement on the target platform, typically associated with an additional marketing spend or platform subscription tier.',
    `is_reso_compliant` BOOLEAN COMMENT 'Indicates whether the syndicated listing payload conforms to the RESO Data Dictionary standard, ensuring field-level interoperability across MLS platforms and portals.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'The most recent date and timestamp when the listing data was refreshed or re-transmitted to the target platform to ensure data currency and accuracy.',
    `listing_price_synced` DECIMAL(18,2) COMMENT 'The listing price transmitted to the target platform at the time of syndication or last refresh. May differ from the current internal listing price if a refresh has not yet occurred, enabling price discrepancy detection.',
    `mls_board_code` STRING COMMENT 'The code identifying the specific MLS board or association through which the listing is syndicated (e.g., CRMLS, NWMLS, MRED). Applicable when target_platform is MLS.',
    `next_scheduled_refresh` TIMESTAMP COMMENT 'The date and timestamp when the next automated data refresh is scheduled to be transmitted to the target platform, based on the platforms refresh frequency requirements.',
    `open_house_synced` BOOLEAN COMMENT 'Indicates whether open house schedule data was included in the syndication payload transmitted to the target platform.',
    `photos_synced_count` STRING COMMENT 'The number of listing photos successfully transmitted to the target platform during the most recent syndication or refresh cycle. Used to verify media completeness on the external platform.',
    `platform_account_code` STRING COMMENT 'The brokerage or agent account identifier registered with the target syndication platform, used to attribute the listing to the correct account for billing and reporting purposes.',
    `platform_listing_url` STRING COMMENT 'The publicly accessible URL of the listing on the target external platform, used for marketing, deep-linking, and performance tracking.',
    `platform_subscription_tier` STRING COMMENT 'The subscription or membership tier held with the target platform that governs listing visibility, feature access, and syndication limits (e.g., basic, standard, premium, enterprise).. Valid values are `basic|standard|premium|enterprise`',
    `reso_version` STRING COMMENT 'The version of the RESO Data Dictionary standard used when constructing the syndication payload (e.g., 1.7, 2.0). Ensures compatibility tracking as standards evolve.',
    `retry_count` STRING COMMENT 'Number of times the syndication submission has been retried following a failed or pending transmission to the target platform. Used to identify chronic failures requiring manual intervention.',
    `source_system` STRING COMMENT 'The operational system of record from which the syndication record and listing data originate (e.g., CoStar Suite, MLS data feed, Salesforce CRM). Supports data lineage and reconciliation.. Valid values are `CoStar|MLS_Feed|Salesforce|Yardi|Manual`',
    `suppression_reason` STRING COMMENT 'The business reason why a listing has been suppressed from syndication to the target platform. Applicable only when syndication_status is suppressed. [ENUM-REF-CANDIDATE: owner_request|compliance_hold|duplicate_listing|platform_policy|legal_hold|expired|do_not_market — promote to reference product]. Valid values are `owner_request|compliance_hold|duplicate_listing|platform_policy|legal_hold|expired`',
    `syndication_authorized_by` STRING COMMENT 'The name or identifier of the person or role who authorized the syndication of this listing to the target platform, supporting audit and compliance requirements.',
    `syndication_authorized_date` DATE COMMENT 'The date on which syndication of this listing to the target platform was formally authorized by the responsible agent, broker, or owner.',
    `syndication_channel` STRING COMMENT 'The property market channel under which the listing is syndicated to the target platform, determining which section or category of the platform the listing appears in.. Valid values are `residential|commercial|rental|land|auction`',
    `syndication_date` TIMESTAMP COMMENT 'The date and timestamp when the listing was first successfully submitted and accepted by the target external platform.',
    `syndication_status` STRING COMMENT 'Current lifecycle status of the syndication record on the target platform. Active indicates the listing is live; pending indicates submission in progress; failed indicates a transmission or validation error; withdrawn indicates the listing was removed; suppressed indicates intentionally excluded from the platform.. Valid values are `active|pending|failed|withdrawn|suppressed`',
    `target_platform` STRING COMMENT 'The external listing portal or platform to which this listing is being syndicated (e.g., MLS, CoStar, LoopNet, Zillow, Realtor.com, CREXi). [ENUM-REF-CANDIDATE: MLS|CoStar|LoopNet|Zillow|Realtor.com|CREXi|Homes.com|CommercialSearch|PropertyShark — promote to reference product]. Valid values are `MLS|CoStar|LoopNet|Zillow|Realtor.com|CREXi`',
    `transmission_method` STRING COMMENT 'The technical delivery method used to transmit the listing data to the target platform (e.g., REST API, SFTP file drop, manual upload). Supports operational troubleshooting and feed management.. Valid values are `API|FTP|SFTP|EMAIL|MANUAL`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and timestamp when this syndication record was most recently modified, supporting change tracking, data freshness monitoring, and audit compliance.',
    `validation_error_code` STRING COMMENT 'Platform-specific error code returned by the target platform when the syndication submission fails validation (e.g., missing required field, invalid format, duplicate listing). Null when syndication is successful.',
    `validation_error_message` STRING COMMENT 'Human-readable description of the validation error returned by the target platform upon failed syndication submission. Provides actionable detail for remediation by the listing coordinator.',
    `virtual_tour_synced` BOOLEAN COMMENT 'Indicates whether a virtual tour URL or media asset was included in the syndication payload transmitted to the target platform.',
    `vow_opt_in` BOOLEAN COMMENT 'Indicates whether the listing owner or agent has opted in to VOW distribution, permitting the listing to be displayed on Virtual Office Websites accessible to registered users.',
    `withdrawal_date` TIMESTAMP COMMENT 'The date and timestamp when the listing was withdrawn or removed from the target external platform. Applicable when syndication_status is withdrawn.',
    CONSTRAINT pk_mls_syndication PRIMARY KEY(`mls_syndication_id`)
) COMMENT 'Tracks the syndication status of each listing to external platforms including MLS (via RETS/RESO Web API), CoStar, LoopNet, Zillow, Realtor.com, CREXi, and other listing portals. Captures target platform, syndication status (active, pending, failed, withdrawn, suppressed), external listing ID on the target platform, syndication date, last refresh timestamp, data feed type (IDX, VOW, RETS), RESO Data Dictionary compliance flag, and any platform-specific validation errors. Sourced from CoStar Suite and MLS data feeds. Supports multi-channel listing distribution management and ensures RESO/IDX compliance across syndication targets.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique system-generated identifier for the referral record. Primary key for the brokerage.referral data product.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Referral fees are paid via AP invoices. Linking referral records to AP invoices enables payment tracking, 1099 reporting, and GL reconciliation — standard real estate referral fee accounting that fina',
    `brokerage_broker_id` BIGINT COMMENT 'Identifier of the internal agent or broker responsible for managing this referral arrangement.',
    `brokerage_deal_id` BIGINT COMMENT 'Identifier of the associated deal or transaction that originated from or is linked to this referral.',
    `brokerage_prospect_id` BIGINT COMMENT 'Foreign key linking to brokerage.prospect. Business justification: A referral generates or is associated with a specific prospect record. The referral table currently stores referred_prospect_name, referred_prospect_email, and referred_prospect_phone as denormalized ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Referrals sourced from marketing campaigns (events, email, digital) require campaign attribution for referral program ROI analysis. Real estate firms track which campaigns generate referral partners. ',
    `commission_id` BIGINT COMMENT 'Foreign key linking to brokerage.commission. Business justification: A referral arrangement results in a referral fee that is paid out of the gross commission. Linking referral to commission enables direct traceability between the referral fee obligation and the commis',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Referral fee amounts and deal values require standardized currency classification for multi-market financial reporting, 1099 tax reporting, and inter-firm payment processing. currency_code is a denorm',
    `listing_id` BIGINT COMMENT 'Identifier of the property listing associated with this referral, if applicable.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Referral fees are triggered by and calculated from the closed sale price. Linking referral to property_sale enables referral fee payment processing, 1099 reporting tied to the actual closed transactio',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type on a referral drives fee benchmarking, network routing to specialized brokers, and referral analytics by asset class. Standardized property type classification enables cross-market refer',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Market and submarket on a referral drive geographic network routing, referral volume analytics, and broker territory management. Standardized geographic hierarchy enables cross-market referral perform',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Referral fee structure, tax reporting (1099), and network routing depend on transaction type classification. Sale referrals have different fee structures and tax treatment than lease referrals. transa',
    `actual_deal_value` DECIMAL(18,2) COMMENT 'Final closed transaction value (sale price or total lease value) of the referred deal upon closing, used for accurate fee calculation.',
    `agreement_date` DATE COMMENT 'The date on which the referral agreement was formally executed between the brokerage and the referring or receiving party.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was first created in the system, used for audit trail and data lineage tracking.',
    `deal_close_date` DATE COMMENT 'Date on which the referred deal was formally closed (sale completed or lease executed), triggering the referral fee obligation.',
    `deal_outcome` STRING COMMENT 'Final outcome of the referred deal, indicating whether it closed successfully, was lost to competition, remains pending, or was withdrawn.. Valid values are `closed_won|closed_lost|pending|withdrawn`',
    `direction` STRING COMMENT 'Indicates whether the referral is inbound (an external party referring a prospect to this brokerage) or outbound (this brokerage referring a prospect to an external party).. Valid values are `inbound|outbound`',
    `docusign_envelope_code` STRING COMMENT 'Unique identifier of the DocuSign envelope used to execute the referral agreement digitally.',
    `estimated_deal_value` DECIMAL(18,2) COMMENT 'Estimated transaction value (sale price or total lease value) of the referred deal at the time of referral, used for pipeline forecasting and fee estimation.',
    `expiration_date` DATE COMMENT 'The date on which the referral agreement expires if the referred deal has not closed. Null for open-ended arrangements.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Calculated or agreed referral fee amount payable to or receivable from the referring party, derived from fee_pct applied to GCI or the flat fee amount.',
    `fee_flat_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount agreed upon as the referral fee, applicable when fee_structure is flat_fee.',
    `fee_paid_date` DATE COMMENT 'Date on which the referral fee was disbursed to the referring party or received from the receiving party, confirming payment completion.',
    `fee_pct` DECIMAL(18,2) COMMENT 'Referral fee expressed as a percentage of the gross commission income (GCI) earned on the referred deal. Applicable when fee_structure is percentage. Stored as a decimal (e.g., 0.2500 = 25%).',
    `fee_structure` STRING COMMENT 'Indicates whether the referral fee is calculated as a percentage of the commission, a flat dollar amount, or a tiered schedule.. Valid values are `percentage|flat_fee|tiered`',
    `gross_commission_income` DECIMAL(18,2) COMMENT 'Total gross commission income (GCI) earned by the brokerage on the referred deal, from which the referral fee is calculated.',
    `is_reciprocal` BOOLEAN COMMENT 'Indicates whether this referral is part of a reciprocal arrangement where both parties agree to exchange referrals mutually.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, or remarks about the referral arrangement not captured in structured fields.',
    `payment_direction` STRING COMMENT 'Indicates whether the referral fee is payable by this brokerage to an external party (outbound referral) or receivable from an external party (inbound referral).. Valid values are `payable|receivable`',
    `referral_number` STRING COMMENT 'Externally-known business identifier for the referral, used in correspondence, agreements, and commission tracking. Format: REF-YYYY-NNNNNN.. Valid values are `^REF-[0-9]{4}-[0-9]{6}$`',
    `referral_status` STRING COMMENT 'Current lifecycle state of the referral arrangement. [ENUM-REF-CANDIDATE: pending|active|closed|paid|cancelled|expired — promote to reference product]. Valid values are `pending|active|closed|paid|cancelled|expired`',
    `referral_type` STRING COMMENT 'Categorizes the source or channel of the referral arrangement. [ENUM-REF-CANDIDATE: broker|relocation|affinity_network|corporate|online_lead|other — promote to reference product]. Valid values are `broker|relocation|affinity_network|corporate|online_lead|other`',
    `referring_broker_license_number` STRING COMMENT 'State-issued real estate broker or agent license number of the referring party, required for regulatory compliance and commission disbursement.',
    `referring_broker_license_state` STRING COMMENT 'Two-letter US state code in which the referring broker or agent holds their real estate license.. Valid values are `^[A-Z]{2}$`',
    `referring_firm_name` STRING COMMENT 'Name of the brokerage firm, relocation company, affinity network, or organization from which the referral originates.',
    `referring_party_name` STRING COMMENT 'Full legal name of the individual or entity that originated the referral (e.g., the referring broker, relocation company representative, or affinity network contact).',
    `salesforce_deal_stage` STRING COMMENT 'Current CRM pipeline stage of the referred deal as tracked in Salesforce (e.g., Prospect, Qualified, LOI Submitted, Under Contract, Closed). Reflects the deal progression from prospect to close.',
    `salesforce_referral_code` STRING COMMENT 'Unique identifier of the corresponding referral or opportunity record in Salesforce CRM, enabling cross-system traceability.',
    `source_network` STRING COMMENT 'Name of the referral network, relocation program, or affinity organization through which the referral was channeled (e.g., Leading RE, Cartus, USAA MoversAdvantage).',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this referral record was originated or ingested into the lakehouse.. Valid values are `salesforce|yardi|mri|manual|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was most recently modified, supporting audit trail and change tracking requirements.',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Records inbound and outbound referral arrangements between the brokerage and external parties (other brokers, relocation companies, affinity networks). Captures referral direction (inbound, outbound), referring party name and firm, referred prospect or deal, referral fee percentage or flat amount, referral agreement date, referral status (pending, active, closed, paid), and deal outcome. Supports referral fee tracking and network relationship management.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` (
    `buyer_representation_id` BIGINT COMMENT 'Unique surrogate identifier for the buyer or tenant representation agreement record in the Silver Layer lakehouse.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed real estate agent or broker assigned to represent the buyer or tenant under this agreement.',
    `brokerage_prospect_id` BIGINT COMMENT 'Reference to the buyer or tenant party (individual or entity) being represented under this agreement.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Buyer representation agreements are initiated when prospects respond to marketing campaigns. Linking the agreement to the sourcing campaign enables campaign-level representation agreement conversion r',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Budget ranges and commission amounts in buyer representation agreements require standardized currency classification for multi-market financial reporting and cross-border investment advisory. currency',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Buyer representation agreements are governed by specific jurisdictions determining fiduciary duty standards, mandatory disclosure requirements, and commission enforceability. governing_law_state is a ',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Target property type in a buyer rep agreement defines the scope of representation and drives listing matching, broker specialization assignment, and commission benchmarking. target_property_type is a ',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: Preferred lease type in a buyer rep agreement defines the scope of representation and drives listing matching and deal structuring. Standardized lease type classification ensures ASC 842 compliance in',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Target market and submarket in a buyer rep agreement define the geographic scope of representation and drive listing search, broker territory assignment, and market demand analytics. Role prefix targ',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Buyer representation agreement terms, commission structure, and regulatory disclosures (dual agency, fiduciary duty) are governed by transaction type. Standardized classification is required for compl',
    `agreement_number` STRING COMMENT 'Externally-known unique reference number assigned to this buyer or tenant representation agreement, as generated by DocuSign CLM or the brokerages contract management system.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the buyer or tenant representation agreement. Drives workflow routing in Salesforce CRM and DocuSign CLM.. Valid values are `draft|active|expired|terminated|completed|suspended`',
    `amendment_count` STRING COMMENT 'Total number of amendments executed against the original buyer or tenant representation agreement, tracking contract modification history.',
    `broker_license_number` STRING COMMENT 'State-issued real estate broker license number of the representing broker, required for regulatory compliance and agreement validity.',
    `broker_license_state` STRING COMMENT 'Two-letter US state code where the representing broker holds their active real estate license.. Valid values are `^[A-Z]{2}$`',
    `client_type` STRING COMMENT 'Legal entity classification of the buyer or tenant client being represented. Informs KYC/AML obligations and commission structuring. [ENUM-REF-CANDIDATE: individual|corporation|partnership|llc|reit|trust|government|other — promote to reference product]',
    `commission_flat_fee` DECIMAL(18,2) COMMENT 'Fixed brokerage fee amount agreed in the representation agreement, applicable when commission_structure is flat_fee or hybrid.',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'Agreed brokerage commission rate expressed as a percentage of the transaction purchase price or total lease value, applicable when commission_structure is percentage or hybrid.',
    `commission_structure` STRING COMMENT 'Method by which the brokerage fee is calculated: percentage of transaction value, flat fee, or a hybrid of both.. Valid values are `percentage|flat_fee|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this buyer or tenant representation agreement record was first created in the Silver Layer lakehouse.',
    `deal_stage` STRING COMMENT 'Current Salesforce CRM deal pipeline stage for the buyer or tenant representation engagement, tracking progression from prospect identification through transaction close. [ENUM-REF-CANDIDATE: prospect|needs_analysis|property_search|loi_submitted|under_contract|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier from DocuSign CLM for the executed buyer or tenant representation agreement, enabling retrieval of the signed document.',
    `dual_agency_consent` BOOLEAN COMMENT 'Indicates whether the client has provided written consent for the brokerage to act as a dual agent representing both buyer/tenant and seller/landlord in the same transaction.',
    `effective_date` DATE COMMENT 'Date on which the buyer or tenant representation agreement becomes legally binding and the brokerages engagement obligation commences.',
    `execution_date` DATE COMMENT 'Date on which all parties executed (signed) the buyer or tenant representation agreement via DocuSign CLM or wet signature.',
    `expiration_date` DATE COMMENT 'Date on which the buyer or tenant representation agreement expires if no transaction has been completed. Nullable for open-ended engagements.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the representation agreement contains an exclusivity clause preventing the client from engaging other brokers for the same search during the agreement term.',
    `last_amended_date` DATE COMMENT 'Date of the most recent amendment to the representation agreement. Null if no amendments have been executed.',
    `max_budget` DECIMAL(18,2) COMMENT 'Maximum purchase price or total lease commitment budget the client is authorized to commit to, as disclosed in the representation agreement.',
    `max_lease_rate_psf` DECIMAL(18,2) COMMENT 'Maximum annual or monthly lease rate per square foot the tenant client is willing to pay, used as a search filter criterion in tenant representation engagements.',
    `max_lease_term_months` STRING COMMENT 'Maximum lease term in months the tenant client is willing to commit to.',
    `max_size_sqft` DECIMAL(18,2) COMMENT 'Maximum gross leasable area or net leasable area in square feet acceptable to the client.',
    `min_budget` DECIMAL(18,2) COMMENT 'Minimum purchase price or total lease commitment budget the client is prepared to consider, expressed in the agreement currency.',
    `min_lease_term_months` STRING COMMENT 'Minimum acceptable lease term in months that the tenant client is willing to commit to, used as a search filter in tenant representation.',
    `min_size_sqft` DECIMAL(18,2) COMMENT 'Minimum gross leasable area or net leasable area in square feet that satisfies the clients space requirement criteria.',
    `protection_period_days` STRING COMMENT 'Number of days after agreement expiration during which the brokerage retains commission rights if the client transacts with a prospect introduced during the agreement term.',
    `representation_type` STRING COMMENT 'Classification of the brokerage engagement type: exclusive buyer representation, exclusive tenant representation, non-exclusive buyer representation, non-exclusive tenant representation, or dual agency. Governs the scope of fiduciary duty and exclusivity obligations.. Valid values are `exclusive_buyer_rep|exclusive_tenant_rep|non_exclusive_buyer_rep|non_exclusive_tenant_rep|dual_agency`',
    `salesforce_opportunity_code` STRING COMMENT 'Unique identifier of the corresponding deal opportunity record in Salesforce CRM, enabling cross-system traceability between the representation agreement and the deal pipeline.',
    `source_system` STRING COMMENT 'Operational system of record from which this buyer or tenant representation agreement record was sourced (DocuSign CLM, Salesforce CRM, or manual entry).. Valid values are `docusign_clm|salesforce_crm|manual`',
    `target_property_use` STRING COMMENT 'Intended use of the target property by the buyer or tenant client, distinguishing between owner-occupied, investment, owner-user, or redevelopment purposes.. Valid values are `owner_occupied|investment|owner_user|redevelopment`',
    `termination_date` DATE COMMENT 'Date on which the representation agreement was early-terminated by either party prior to the scheduled expiration date. Null if not terminated early.',
    `termination_reason` STRING COMMENT 'Reason code for early termination of the representation agreement. Null if the agreement expired naturally or is still active.. Valid values are `client_withdrawal|mutual_agreement|breach|transaction_completed|agent_reassignment|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this buyer or tenant representation agreement record was last modified in the Silver Layer lakehouse.',
    CONSTRAINT pk_buyer_representation PRIMARY KEY(`buyer_representation_id`)
) COMMENT 'Buyer or tenant representation agreement record formalizing the brokerages engagement to represent a buyer or tenant in a property search and acquisition or leasing transaction. Captures representation type (exclusive buyer rep, exclusive tenant rep, non-exclusive), client identity, target property criteria (type, size, submarket, budget), agreement term, agreed commission or fee structure, exclusivity clause, and agreement status. Sourced from DocuSign CLM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` (
    `brokerage_deal_document_id` BIGINT COMMENT 'Unique surrogate identifier for each deal document record in the brokerage deal file. Primary key for the deal_document data product.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed real estate agent or broker responsible for preparing or managing this document within the deal file.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the parent brokerage deal or transaction to which this document belongs. Links the document to its deal pipeline record in Salesforce CRM.',
    `co_broker_agreement_id` BIGINT COMMENT 'Foreign key linking to brokerage.co_broker_agreement. Business justification: Deal documents include co-broker agreement documents (signed co-brokerage contracts, commission split agreements). Linking deal_document to co_broker_agreement enables document management for co-broke',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to reference.document_type. Business justification: Document type classification drives retention period rules, regulatory filing obligations, required signatory roles, and workflow routing. Compliance and legal teams depend on standardized document ty',
    `listing_id` BIGINT COMMENT 'Reference to the property listing associated with this document, linking the document to the specific listing record in the brokerage domain.',
    `negotiation_instrument_id` BIGINT COMMENT 'Foreign key linking to brokerage.negotiation_instrument. Business justification: Deal documents include the actual LOI, offer, and counter-offer documents that correspond to negotiation_instrument records. Linking deal_document to negotiation_instrument via loi_id enables direct a',
    `parent_document_brokerage_deal_document_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original document that this record amends, supersedes, or is a counter-offer to. Enables document lineage tracking (e.g., counter-offer references original offer; amendment references original agreement).',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Property type on a deal document drives applicable regulatory framework, required disclosure documents, and retention requirements. Different property types have different mandatory disclosure and doc',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: Deal documents include the executed PSA, amendments, and addenda. Linking deal_document to purchase_agreement enables document management systems to associate brokerage deal files with the formal tran',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Transaction type on a deal document determines regulatory filing obligations, required document checklist compliance, and applicable retention rules. Standardized transaction type classification is re',
    `amendment_number` STRING COMMENT 'Sequential amendment number for documents that modify a previously executed agreement (e.g., Amendment No. 1 to Purchase and Sale Agreement). Zero or null for original documents. Supports tracking of negotiation history and contract modifications.',
    `co_broker_involved` BOOLEAN COMMENT 'Indicates whether a co-broker or cooperating broker is a party to this document. True for co-broker agreements, commission splits, and co-brokered transaction documents. Drives co-broker commission tracking and SNDA requirements.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this document based on its content sensitivity. Drives access control, sharing restrictions, and handling requirements. Values align with enterprise data classification policy.. Valid values are `public|internal|confidential|restricted`',
    `deal_stage_at_upload` STRING COMMENT 'The Salesforce CRM deal pipeline stage at the time this document was uploaded. Enables stage-gate completeness audits — verifying that all required documents were present at each deal milestone. [ENUM-REF-CANDIDATE: prospect|loi|under_contract|due_diligence|closing|closed|dead — 7 candidates stripped; promote to reference product]',
    `document_name` STRING COMMENT 'Human-readable title or name of the document as stored in DocuSign CLM or the deal file (e.g., Purchase and Sale Agreement — 123 Main St, LOI — Tenant ABC Suite 400). Used for display and search.',
    `document_number` STRING COMMENT 'Externally-known unique business identifier for the document, typically assigned by DocuSign CLM or the brokerage document management system (e.g., DOC-2024-00123). Used for cross-system reference and audit trail.',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier assigned by DocuSign CLM when the document is sent for electronic signature. Enables direct lookup of signature status, audit trail, and certificate of completion in DocuSign. Null if document was executed outside DocuSign.',
    `docusign_status` STRING COMMENT 'Status of the DocuSign envelope as reported by DocuSign CLM, reflecting the real-time signature workflow state. Distinct from execution_status which represents the business-level document state. Null if not sent via DocuSign. [ENUM-REF-CANDIDATE: created|sent|delivered|signed|completed|declined|voided — 7 candidates stripped; promote to reference product]',
    `execution_date` DATE COMMENT 'Calendar date on which all required parties completed signing and the document became fully executed. Null for documents not yet executed. Critical for determining contract effective dates and retention period start.',
    `execution_status` STRING COMMENT 'Current lifecycle state of the document reflecting its signature and execution workflow. Drives deal stage-gate validation — a deal cannot advance without all required documents in executed status. Values: draft, pending_signature, executed, voided, expired.. Valid values are `draft|pending_signature|executed|voided|expired`',
    `expiration_date` DATE COMMENT 'Date on which the document or its associated offer/LOI expires and is no longer legally binding. Applicable to time-limited documents such as Letters of Intent (LOI), offers, and counter-offers. Null for documents with no expiration.',
    `file_format` STRING COMMENT 'Format or MIME type of the document file (e.g., pdf, docx, xlsx). Supports document rendering, compatibility validation, and archival format compliance requirements.. Valid values are `pdf|docx|xlsx|jpg|png|tiff`',
    `file_name` STRING COMMENT 'Original file name of the uploaded document as stored in the document management system or cloud storage (e.g., PSA_123MainSt_v3_executed.pdf). Used for retrieval and display.',
    `file_size_kb` STRING COMMENT 'Size of the document file in kilobytes at the time of upload. Used for storage management, upload validation, and document completeness checks.',
    `governing_jurisdiction` STRING COMMENT 'U.S. state or jurisdiction whose real estate laws and document retention requirements govern this document (e.g., CA, NY, TX). Determines applicable retention period, disclosure requirements, and regulatory compliance rules.',
    `is_current_version` BOOLEAN COMMENT 'Indicates whether this record represents the most current version of the document. True for the latest version; False for superseded versions retained for audit history.',
    `is_executed_original` BOOLEAN COMMENT 'Indicates whether this document record represents the fully executed original (wet-ink or DocuSign-certified) version. Distinguishes executed originals from drafts, redlines, and working copies in the deal file.',
    `is_required_for_stage` BOOLEAN COMMENT 'Indicates whether this document is mandatory for the deal to advance past its current stage gate. True if the document is a required stage-gate document (e.g., executed PSA required before due diligence); False if supplemental.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this document record was last updated in the data platform. Used for incremental data loads, audit trails, and change detection in the Silver layer.',
    `notes` STRING COMMENT 'Free-text field for broker or deal manager annotations regarding this document — e.g., outstanding conditions, negotiation context, or instructions for the closing team. Sourced from DocuSign CLM or Salesforce CRM deal notes.',
    `received_from_party` STRING COMMENT 'Name or identifier of the external party (buyer, seller, tenant, landlord, opposing broker) who submitted or transmitted this document to the deal file. Supports deal correspondence tracking and audit trail.',
    `retention_expiration_date` DATE COMMENT 'Date after which the document may be purged per applicable state-mandated document retention requirements (typically 3–7 years depending on jurisdiction). Calculated from execution_date plus the governing retention period. Supports compliance with state real estate commission regulations.',
    `retention_period_years` STRING COMMENT 'Number of years this document must be retained per the governing jurisdictions real estate records retention law. Typically 3–7 years depending on state. Drives the calculation of retention_expiration_date and automated purge scheduling.',
    `signatory_party_names` STRING COMMENT 'Comma-separated list of the names of all parties required to sign or who have signed this document (e.g., buyer, seller, tenant, landlord, broker). Sourced from DocuSign CLM envelope recipients. Classified confidential as it contains counterparty identity information.',
    `source_system` STRING COMMENT 'Operational system of record from which this document record was sourced (e.g., DocuSign CLM, Salesforce CRM, Yardi Voyager, manual upload). Supports data lineage, reconciliation, and ETL audit.. Valid values are `docusign_clm|salesforce_crm|yardi_voyager|manual_upload`',
    `source_system_document_code` STRING COMMENT 'Native document identifier from the originating system of record (e.g., DocuSign CLM document ID, Salesforce CRM attachment ID). Enables cross-system reconciliation and traceability back to the source record.',
    `storage_uri` STRING COMMENT 'Uniform Resource Identifier (URI) pointing to the documents physical storage location in the enterprise content management system or cloud object store (e.g., Azure Blob, S3). Classified confidential as it exposes internal storage topology.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the document was first uploaded or ingested into the deal file system. Serves as the principal business event timestamp for document creation, used in audit trails and stage-gate timing analysis.',
    `version_number` STRING COMMENT 'Sequential integer version of the document, incremented each time a new draft or amendment is uploaded. Enables tracking of negotiation history (e.g., counter-offers, redlines) and ensures the executed version is clearly identified.',
    CONSTRAINT pk_brokerage_deal_document PRIMARY KEY(`brokerage_deal_document_id`)
) COMMENT 'Tracks all documents associated with a brokerage deal throughout its lifecycle — LOIs, offers, counter-offers, purchase and sale agreements, lease abstracts, commission agreements, co-broker agreements, closing statements, and regulatory disclosures. Captures document type, document name, version number, execution status (draft, pending signature, executed, voided), DocuSign envelope ID, upload timestamp, deal reference, and retention expiration date. Supports state-mandated document retention requirements (typically 3-7 years depending on jurisdiction) and provides the audit trail for deal file completeness at each stage gate. Sourced from DocuSign CLM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` (
    `broker_program_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for this broker-program enrollment record. Primary key for the association.',
    `brokerage_broker_id` BIGINT COMMENT 'Foreign key linking to the broker record in the brokerage domain. Identifies which licensed broker or agent is enrolled in this compliance program.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program record. Identifies which enterprise compliance program (Fair Housing, AML, CE, E&O) this enrollment pertains to.',
    `assigned_role` STRING COMMENT 'Role or responsibility assigned to the broker within this specific compliance program (e.g., participant, program champion, auditor, trainer). Explicitly identified in detection reasoning as relationship-specific data. Captures that brokers may have different roles across different programs.',
    `completion_status` STRING COMMENT 'Current completion status of the broker for this specific compliance program. Explicitly identified in detection reasoning as relationship-specific data. Drives compliance reporting and broker eligibility for deal assignment.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the brokers performance or completion level within this specific compliance program. Explicitly identified in detection reasoning as relationship-specific data. Used for compliance officer review and broker performance tracking.',
    `enrollment_date` DATE COMMENT 'Date on which the broker was formally enrolled in this compliance program. Explicitly identified in detection reasoning as relationship-specific data. Used to track enrollment history and calculate time-in-program for audit purposes.',
    `enrollment_status` STRING COMMENT 'Lifecycle status of this enrollment record. Active indicates ongoing participation, suspended indicates temporary pause, withdrawn indicates broker opted out, completed indicates program finished, expired indicates enrollment lapsed without renewal.',
    `exemption_granted` BOOLEAN COMMENT 'Indicates whether this broker has been granted an exemption from participation in this specific compliance program (e.g., due to prior certification, role scope, or jurisdictional exclusion). False by default.',
    `exemption_reason` STRING COMMENT 'Narrative explanation of why an exemption was granted for this broker-program enrollment. Null if exemption_granted is false. Required for audit trail when exemptions are granted.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent assessment, test, or evaluation completed by the broker for this compliance program. Used to track assessment currency and trigger re-assessment requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this enrollment record. Used for change tracking and data freshness validation.',
    `next_renewal_date` DATE COMMENT 'Date on which the broker must renew or recertify their participation in this compliance program. Explicitly identified in detection reasoning as relationship-specific data. Used to trigger renewal notifications and track ongoing compliance obligations.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Total training hours completed by this broker for this specific compliance program. Supports programs with hour-based completion requirements (e.g., Continuing Education programs requiring 15 hours annually).',
    CONSTRAINT pk_broker_program_enrollment PRIMARY KEY(`broker_program_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between licensed brokers and enterprise compliance programs. It captures the operational reality that brokers must participate in multiple mandatory compliance programs (Fair Housing, AML, Continuing Education, E&O Insurance) and each program covers many brokers across the brokerage. Each record links one broker to one compliance program with enrollment-specific attributes including enrollment date, completion status, compliance score, renewal tracking, and assigned role within the program. This is an actively managed operational entity — compliance officers create enrollments, track completion, monitor scores, and manage renewals as part of regulatory obligation management.. Existence Justification: In real estate brokerage operations, licensed brokers must participate in multiple mandatory compliance programs simultaneously (Fair Housing training, Anti-Money Laundering certification, Continuing Education requirements, Errors & Omissions insurance compliance, state-specific regulatory programs). Each compliance program covers many brokers across the brokerage organization. Compliance officers actively manage these enrollments as operational records — they enroll brokers in programs, track completion status, monitor compliance scores, manage renewal deadlines, and assign program-specific roles. This is not an analytical correlation derived from transactional data; it is an operational business entity that humans create, update, and query as part of regulatory obligation management.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` (
    `deal_compliance_id` BIGINT COMMENT 'Unique surrogate identifier for each deal-compliance requirement association record',
    `brokerage_deal_id` BIGINT COMMENT 'Foreign key linking to the brokerage deal record',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to the compliance requirement record',
    `assigned_date` DATE COMMENT 'Date on which this compliance requirement was assigned to the deal (typically when deal reaches a stage where compliance tracking begins)',
    `completion_date` DATE COMMENT 'Date on which this compliance requirement was satisfied or marked complete for this deal',
    `compliance_status` STRING COMMENT 'Current status of this compliance requirement for this specific deal. Tracks progression from identification through satisfaction or waiver.',
    `cost_incurred` DECIMAL(18,2) COMMENT 'Dollar amount of costs incurred to satisfy this compliance requirement for this deal (inspection fees, certification costs, legal review fees)',
    `due_date` DATE COMMENT 'Deal-specific due date by which this compliance requirement must be satisfied, typically calculated relative to projected_close_date or deal stage transitions',
    `evidence_submission_date` DATE COMMENT 'Date on which compliance evidence was submitted for this deal-requirement combination',
    `evidence_submitted` BOOLEAN COMMENT 'Indicates whether supporting documentation or evidence of compliance has been submitted for review for this deal-requirement combination',
    `notes` STRING COMMENT 'Free-text notes capturing deal-specific compliance considerations, issues encountered, or resolution details for this requirement',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or role assigned to ensure this compliance requirement is satisfied for this deal (may be broker, transaction coordinator, legal counsel, or third-party consultant)',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the compliance waiver for this deal',
    `waiver_date` DATE COMMENT 'Date on which the compliance waiver was granted for this deal-requirement combination',
    `waiver_granted` BOOLEAN COMMENT 'Indicates whether a waiver or exception has been granted for this compliance requirement for this specific deal',
    `waiver_justification` STRING COMMENT 'Business rationale or legal basis for granting a waiver for this compliance requirement on this deal',
    CONSTRAINT pk_deal_compliance PRIMARY KEY(`deal_compliance_id`)
) COMMENT 'This association product represents the compliance obligation tracking between brokerage deals and regulatory requirements. It captures the per-deal compliance status, evidence submission, responsible party assignment, and waiver management for each requirement that must be satisfied before deal close. Each record links one deal to one compliance requirement with attributes that exist only in the context of this specific deal-requirement relationship.. Existence Justification: In commercial real estate brokerage operations, each deal must satisfy multiple compliance requirements (environmental disclosure, ADA certification, zoning confirmation, FIRPTA, transfer tax documentation) before closing, and each compliance requirement applies to many deals across the portfolio. The business actively manages per-deal compliance tracking as a critical deal-closing workflow, with brokers and transaction coordinators monitoring status, assigning responsible parties, collecting evidence, and managing waivers for each deal-requirement combination.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` (
    `listing_disclosure_id` BIGINT COMMENT 'Unique surrogate identifier for each listing-disclosure compliance record',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to the specific regulatory disclosure requirement that applies to this listing',
    `listing_id` BIGINT COMMENT 'Foreign key linking to the property listing record for which this disclosure requirement must be fulfilled',
    `completed_by` STRING COMMENT 'Identifier of the broker, agent, or compliance officer who completed or verified this disclosure for this listing. Tracks accountability for disclosure fulfillment at the individual listing-requirement level.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this listing-disclosure compliance record was created, typically when the listing became active or when the requirement became applicable',
    `disclosure_date` DATE COMMENT 'Date on which this specific disclosure requirement was fulfilled for this listing. Used for compliance audit trails and to calculate days-to-compliance metrics. This date is specific to each listing-requirement combination.',
    `disclosure_status` STRING COMMENT 'Current fulfillment status of this disclosure requirement for this specific listing. Tracks whether the disclosure has been completed, is pending, has been waived, or is overdue. This status is specific to the listing-requirement pairing and cannot exist on either entity alone.',
    `due_date` DATE COMMENT 'Calculated or assigned due date by which this disclosure must be completed for this listing, based on listing start date, jurisdiction requirements, and deal stage. This date is specific to each listing-requirement pairing.',
    `evidence_reference` STRING COMMENT 'Reference to the documentation, form, certificate, or system record that evidences completion of this disclosure requirement for this listing (e.g., document management system URI, form number, certificate ID). This evidence is specific to each listing-requirement pairing.',
    `reminder_sent_date` DATE COMMENT 'Date on which a compliance reminder or notification was sent to the responsible party for this specific listing-disclosure combination. Used to track proactive compliance management.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this listing-disclosure compliance record',
    `waiver_reason` STRING COMMENT 'Narrative explanation of why this disclosure requirement was waived or marked not applicable for this specific listing (e.g., property built after 1978 exempt from lead paint disclosure, commercial property exempt from residential fair housing posting). This reason is contextual to the listing-requirement combination.',
    CONSTRAINT pk_listing_disclosure PRIMARY KEY(`listing_disclosure_id`)
) COMMENT 'This association product represents the compliance relationship between property listings and regulatory disclosure requirements. It captures the fulfillment status of each mandatory disclosure requirement for each listing, tracking completion dates, responsible parties, evidence documentation, and any waivers or exceptions. Each record links one listing to one compliance requirement with attributes that exist only in the context of this specific listing-requirement pairing.. Existence Justification: In real estate brokerage operations, each property listing must satisfy multiple mandatory disclosure requirements that vary by jurisdiction, property type, and transaction type (e.g., lead paint disclosure for pre-1978 residential, environmental hazard disclosure for commercial, agency disclosure for all, fair housing posting requirements). Conversely, each compliance requirement applies to many listings across the portfolio. Brokerages actively manage per-listing disclosure completion, tracking status, completion dates, responsible parties, and evidence documentation for each listing-requirement pairing as part of the listing lifecycle and transaction closing process.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`broker_commission` (
    `broker_commission_id` BIGINT COMMENT 'Primary key for the broker_commission association',
    `brokerage_broker_id` BIGINT COMMENT 'Foreign key linking to the broker or agent record',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to the property sale transaction record',
    `assignment_date` DATE COMMENT 'The date on which this broker was formally assigned to or engaged in this property sale transaction. Used for tracking broker involvement timeline and commission eligibility.',
    `brokerage_side` STRING COMMENT 'The role or side of the transaction that this broker represents. Determines commission source and fiduciary duty. Values: listing_broker, buyers_broker, co_listing_broker, co_buyers_broker, referral_broker, dual_agent.',
    `commission_amount` DECIMAL(18,2) COMMENT 'The dollar amount of commission earned by this broker for this specific property sale transaction. Calculated as (total_commission * commission_split_pct) and used for broker compensation and production tracking.',
    `commission_paid_date` DATE COMMENT 'The date on which the commission amount was paid to this broker for this transaction. Used for broker compensation tracking and financial reconciliation.',
    `commission_split_pct` DECIMAL(18,2) COMMENT 'The percentage of the total transaction commission allocated to this specific broker. Used to calculate individual broker compensation. Sum of all splits for a transaction should equal 100%.',
    `commission_status` STRING COMMENT 'Current status of the commission payment for this broker on this transaction. Drives commission payment workflow and broker compensation reporting. Values: pending, approved, paid, disputed, cancelled.',
    `license_number` STRING COMMENT 'The state real estate license number under which this broker operated for this specific transaction. Captured at transaction time for regulatory compliance and audit trail, as license numbers can change over time.',
    `representation_type` STRING COMMENT 'The type of representation agreement under which this broker participated in the transaction. Affects commission structure and legal obligations. Values: exclusive, non_exclusive, dual, referral.',
    CONSTRAINT pk_broker_commission PRIMARY KEY(`broker_commission_id`)
) COMMENT 'This association product represents the commission assignment between a property sale transaction and a broker. It captures the specific role, representation side, and commission economics for each broker involved in a property sale transaction. Each record links one property_sale to one broker with attributes that exist only in the context of this specific transaction participation.. Existence Justification: In real estate transactions, a single property sale involves multiple brokers in different roles (listing broker, buyers broker, co-brokers, referral brokers), and each broker participates in many property sales throughout their career. The business actively manages broker commission assignments as operational records, tracking each brokers specific role, representation type, commission split percentage, and payment status for each transaction. This is not an analytical correlation but an operational business process where commission assignments are created, approved, and paid as distinct business events.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` (
    `broker_market_coverage_id` BIGINT COMMENT 'Unique surrogate identifier for this broker-to-market coverage assignment record',
    `brokerage_broker_id` BIGINT COMMENT 'Foreign key linking to the broker record who is assigned coverage for this geographic market',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to the geographic hierarchy node (market, submarket, MSA, city, or zip) that this broker is assigned to cover',
    `assignment_notes` STRING COMMENT 'Free-text notes explaining the rationale for this market assignment, any special conditions, or coordination requirements with other brokers covering the same market.',
    `coverage_status` STRING COMMENT 'Current operational status of this market coverage assignment: active (broker is currently covering this market), inactive (assignment ended), suspended (temporarily paused), pending (scheduled future assignment). Drives real-time lead routing logic.',
    `designation_type` STRING COMMENT 'Classification of the brokers coverage role for this market: primary (main territory), secondary (overflow support), backup (coverage during absence), or specialty (specific property type focus within market). Drives lead routing priority and commission plan applicability.',
    `effective_date` DATE COMMENT 'Date on which this market coverage assignment became active. Used for historical territory analysis and commission dispute resolution when leads were assigned during transition periods.',
    `expiry_date` DATE COMMENT 'Date on which this market coverage assignment ended or is scheduled to end. Null for currently active assignments. Used to track broker territory changes over time and ensure leads are not routed to brokers no longer covering a market.',
    `is_primary_market` BOOLEAN COMMENT 'Boolean flag indicating whether this geographic market is the brokers primary territory for production reporting and quota assignment. Each broker typically has one primary market but may have multiple secondary market assignments.',
    CONSTRAINT pk_broker_market_coverage PRIMARY KEY(`broker_market_coverage_id`)
) COMMENT 'This association product represents the territory assignment between broker and geographic_hierarchy. It captures the formal designation of which geographic markets a broker is authorized and assigned to cover for lead routing, listing assignments, and production tracking. Each record links one broker to one geographic market node with attributes that define the nature and period of that market coverage assignment.. Existence Justification: In real estate brokerage operations, brokers are assigned to cover multiple geographic markets (MSAs, submarkets, cities, zip codes) simultaneously for lead routing and territory management, and each market has multiple brokers assigned with different coverage roles (primary, secondary, backup). The brokerage actively manages these territory assignments as operational records with effective dates, designation types, and coverage status to drive lead distribution and production reporting by market.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`brokerage`.`commission_plan` (
    `commission_plan_id` BIGINT COMMENT 'Primary key for commission_plan',
    `superseded_commission_plan_id` BIGINT COMMENT 'Self-referencing FK on commission_plan (superseded_commission_plan_id)',
    `applies_to_property_type` STRING COMMENT 'Specific property types or categories to which this commission plan applies. Pipe-separated list or null for all types.',
    `applies_to_transaction_type` STRING COMMENT 'Type of real estate transactions to which this commission plan applies.',
    `approved_by` STRING COMMENT 'Username or identifier of the manager or executive who approved this commission plan for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission plan was approved for activation and assignment to agents.',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'The foundational commission percentage rate applied to transactions under this plan, expressed as a decimal (e.g., 0.0300 for 3%).',
    `bonus_structure` STRING COMMENT 'Description of performance-based bonuses and incentives included in this commission plan. JSON or structured text format.',
    `cap_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount payable under this plan within a defined period. Null indicates no cap applies.',
    `cap_period` STRING COMMENT 'Time period over which the commission cap amount is applied and reset.',
    `co_broker_split_rate` DECIMAL(18,2) COMMENT 'Default commission split rate for co-broker arrangements under this plan, expressed as a decimal percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this commission plan.',
    `commission_plan_description` STRING COMMENT 'Detailed narrative description of the commission plan including key features, benefits, and terms.',
    `desk_fee` DECIMAL(18,2) COMMENT 'Recurring fee charged to agents for office space and administrative support under this plan.',
    `desk_fee_frequency` STRING COMMENT 'Frequency at which the desk fee is charged to the agent.',
    `effective_end_date` DATE COMMENT 'Date when the commission plan expires or is no longer available for new assignments. Null indicates open-ended plan.',
    `effective_start_date` DATE COMMENT 'Date when the commission plan becomes active and available for use in brokerage agreements.',
    `eligibility_criteria` STRING COMMENT 'Requirements and qualifications that agents or brokers must meet to be assigned to this commission plan.',
    `is_default_plan` BOOLEAN COMMENT 'Indicates whether this is the default commission plan assigned to new agents when no specific plan is selected.',
    `minimum_commission_amount` DECIMAL(18,2) COMMENT 'Minimum commission amount guaranteed per transaction regardless of calculated commission. Null indicates no minimum.',
    `mls_syndication_eligible` BOOLEAN COMMENT 'Indicates whether listings under this commission plan are eligible for syndication to MLS and other listing platforms.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this commission plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission plan record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes, special conditions, or administrative comments related to this commission plan.',
    `override_commission_rate` DECIMAL(18,2) COMMENT 'Additional commission rate paid to supervising brokers or team leaders on transactions by their agents, expressed as a decimal.',
    `payment_terms` STRING COMMENT 'Terms defining when commission payments are disbursed to agents under this plan.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier code for the commission plan used in contracts and agreements.',
    `plan_name` STRING COMMENT 'Human-readable name of the commission plan for identification and reporting purposes.',
    `plan_type` STRING COMMENT 'Classification of the commission plan structure indicating how commissions are calculated and distributed.',
    `referral_fee_rate` DECIMAL(18,2) COMMENT 'Commission rate paid for referrals to other agents or brokers, expressed as a decimal percentage.',
    `requires_broker_approval` BOOLEAN COMMENT 'Indicates whether transactions under this plan require explicit broker approval before commission disbursement.',
    `split_percentage` DECIMAL(18,2) COMMENT 'The percentage of commission that the agent receives after broker split, expressed as a decimal (e.g., 0.7000 for 70/30 split).',
    `commission_plan_status` STRING COMMENT 'Current lifecycle status of the commission plan indicating its availability for assignment to agents and brokers.',
    `team_split_allowed` BOOLEAN COMMENT 'Indicates whether commission splitting among team members is permitted under this plan.',
    `tier_structure` STRING COMMENT 'Detailed description of tiered commission rates and thresholds for graduated commission plans. JSON or structured text format.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged per transaction under this commission plan, separate from percentage-based commission.',
    `version_number` STRING COMMENT 'Version number of this commission plan for tracking changes and revisions over time.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this commission plan record.',
    CONSTRAINT pk_commission_plan PRIMARY KEY(`commission_plan_id`)
) COMMENT 'Master reference table for commission_plan. Referenced by commission_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_mls_listing_id` FOREIGN KEY (`mls_listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_showing_buyer_agent_broker_brokerage_broker_id` FOREIGN KEY (`showing_buyer_agent_broker_brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_parent_instrument_negotiation_instrument_id` FOREIGN KEY (`parent_instrument_negotiation_instrument_id`) REFERENCES `real_estate_ecm`.`brokerage`.`negotiation_instrument`(`negotiation_instrument_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_co_broker_agreement_id` FOREIGN KEY (`co_broker_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`co_broker_agreement`(`co_broker_agreement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ADD CONSTRAINT `fk_brokerage_broker_license_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ADD CONSTRAINT `fk_brokerage_mls_syndication_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ADD CONSTRAINT `fk_brokerage_mls_syndication_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_co_broker_agreement_id` FOREIGN KEY (`co_broker_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`co_broker_agreement`(`co_broker_agreement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_negotiation_instrument_id` FOREIGN KEY (`negotiation_instrument_id`) REFERENCES `real_estate_ecm`.`brokerage`.`negotiation_instrument`(`negotiation_instrument_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_parent_document_brokerage_deal_document_id` FOREIGN KEY (`parent_document_brokerage_deal_document_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal_document`(`brokerage_deal_document_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ADD CONSTRAINT `fk_brokerage_broker_program_enrollment_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ADD CONSTRAINT `fk_brokerage_deal_compliance_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ADD CONSTRAINT `fk_brokerage_listing_disclosure_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ADD CONSTRAINT `fk_brokerage_broker_commission_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ADD CONSTRAINT `fk_brokerage_broker_market_coverage_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_plan` ADD CONSTRAINT `fk_brokerage_commission_plan_superseded_commission_plan_id` FOREIGN KEY (`superseded_commission_plan_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission_plan`(`commission_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`brokerage` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`brokerage` SET TAGS ('dbx_domain' = 'brokerage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` SET TAGS ('dbx_subdomain' = 'property_marketing');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `green_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Green Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Coordinator Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `market_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Market Survey Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Submarket Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `zoning_code_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `cam_rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `cam_rate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `close_price` SET TAGS ('dbx_business_glossary_term' = 'Close Price');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `close_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `co_broker_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `co_broker_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `costar_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `days_on_market` SET TAGS ('dbx_business_glossary_term' = 'Days on Market (DOM)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `deal_stage` SET TAGS ('dbx_business_glossary_term' = 'Deal Stage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `is_costar_syndicated` SET TAGS ('dbx_business_glossary_term' = 'CoStar Syndication Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Listing Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `is_mls_syndicated` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Syndication Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `lease_rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Lease Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `lease_rate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_value_regex' = 'exclusive|open|co_exclusive|exclusive_agency|net');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `nla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area (NLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Listing Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `parking_ratio` SET TAGS ('dbx_business_glossary_term' = 'Parking Ratio');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Listing Price');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|costar|yardi|mri|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Start Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `tenant_improvement_allowance` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `tenant_improvement_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` SET TAGS ('dbx_subdomain' = 'property_marketing');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `listing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Agreement ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'CoStar Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `mls_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Listing Agreement Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^LA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Agreement Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|withdrawn|closed');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Agreement Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'exclusive_right_to_sell|exclusive_agency|open_listing|net_listing|exclusive_right_to_lease');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Agreement Amendment Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Broker License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `broker_license_state` SET TAGS ('dbx_business_glossary_term' = 'Broker License State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `broker_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_value_regex' = 'sell_side|buy_side|lease_listing|tenant_rep|dual_agency');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `co_broker_authorized` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Authorization Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `co_broker_split_rate` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Split Rate');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `co_broker_split_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `commission_flat_fee` SET TAGS ('dbx_business_glossary_term' = 'Commission Flat Fee');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `commission_flat_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `commission_structure` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `commission_structure` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|tiered|net_above_reserve');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign CLM Envelope ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `dual_agency_consent` SET TAGS ('dbx_business_glossary_term' = 'Dual Agency Consent Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `esg_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Disclosure Required Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `exclusive_territory` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Territory Description');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `last_amended_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `lockbox_authorized` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Authorization Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `marketing_budget` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `marketing_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `minimum_acceptable_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Price');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `minimum_acceptable_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `owner_disclosure_completed` SET TAGS ('dbx_business_glossary_term' = 'Owner Disclosure Completed Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `price_reduction_authorized` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Authorization Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `protection_period_days` SET TAGS ('dbx_business_glossary_term' = 'Broker Protection Period (Days)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `showing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Showing Instructions');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'docusign_clm|salesforce_crm|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'mutual_consent|owner_withdrawal|broker_default|property_sold_off_market|expired_no_renewal|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent / Broker ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `environmental_review_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Lead Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `proforma_id` SET TAGS ('dbx_business_glossary_term' = 'Proforma Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Submarket Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Coordinator Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `co_broker_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `co_broker_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `co_broker_firm` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Firm Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `costar_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Property / Deal ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `dead_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Dead / Terminated Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `dead_reason` SET TAGS ('dbx_business_glossary_term' = 'Dead Deal Reason / Closed Lost Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `deal_source` SET TAGS ('dbx_business_glossary_term' = 'Deal Source / Lead Source');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'sale|lease|sublease|assignment|renewal|expansion');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `exclusivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period End Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `exclusivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Start Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `is_co_brokerage` SET TAGS ('dbx_business_glossary_term' = 'Co-Brokerage Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Representation Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `lease_rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Lease Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `lease_rate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `loi_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Deal Close Probability Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `projected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Close Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `prospect_company` SET TAGS ('dbx_business_glossary_term' = 'Prospect Company / Tenant Entity Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `prospect_company` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect / Client Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `prospect_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `sale_price` SET TAGS ('dbx_business_glossary_term' = 'Sale Price');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `side` SET TAGS ('dbx_business_glossary_term' = 'Deal Side / Brokerage Representation');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|tenant_rep|landlord_rep|dual_agency');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Deal Size — Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Deal Stage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospect|loi|under_contract|due_diligence|closed|dead');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `tenant_improvement_allowance` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement Allowance (TI)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `tenant_improvement_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `total_consideration` SET TAGS ('dbx_business_glossary_term' = 'Total Deal Consideration');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `total_consideration` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Submarket Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Broker ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Lead/Contact ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `budget_psf` SET TAGS ('dbx_business_glossary_term' = 'Budget Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `budget_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `cap_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Target Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `cap_rate_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Company / Organization Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Prospect Primary Email Address');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Full Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `gdpr_consent_given` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Processing Consent Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `irr_target` SET TAGS ('dbx_business_glossary_term' = 'Target Internal Rate of Return (IRR)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `irr_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `is_do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source / Source of Introduction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `loi_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Intent (LOI) Issued Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `lost_reason` SET TAGS ('dbx_business_glossary_term' = 'Lost Reason / Disqualification Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `max_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Size Requirement (Square Feet / SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `min_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Minimum Size Requirement (Square Feet / SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prospect Notes / Broker Commentary');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Prospect Primary Phone Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'buyer|tenant|investor|owner_seller');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Qualification Status (MQL/SQL)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'unqualified|mql|sql|nurturing|converted|lost');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `referral_source_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `referral_source_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `site_tours_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Site Tours Conducted');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|costar|mls|manual|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `target_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Target Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `target_move_in_date` SET TAGS ('dbx_business_glossary_term' = 'Target Move-In / Occupancy Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `ti_requirement` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Requirement Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Budget / Maximum Investment Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `total_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` SET TAGS ('dbx_subdomain' = 'property_marketing');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_id` SET TAGS ('dbx_business_glossary_term' = 'Showing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `buyer_representation_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Representation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Showing Coordinator Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_buyer_agent_broker_brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer/Tenant Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Submarket Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `access_method` SET TAGS ('dbx_business_glossary_term' = 'Property Access Method');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `access_method` SET TAGS ('dbx_value_regex' = 'lockbox|agent_accompanied|key_pickup|electronic_access|building_security');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `budget_psf` SET TAGS ('dbx_business_glossary_term' = 'Budget Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `budget_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'prospect_cancelled|agent_cancelled|property_unavailable|weather|scheduling_conflict|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `deal_stage` SET TAGS ('dbx_business_glossary_term' = 'Deal Stage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `feedback_notes` SET TAGS ('dbx_business_glossary_term' = 'Showing Feedback Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_value_regex' = 'send_proposal|schedule_second_showing|submit_loi|send_comps|no_action_required|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `is_confidential_listing` SET TAGS ('dbx_business_glossary_term' = 'Confidential Listing Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `nda_executed` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Executed Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Showing Outcome');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'interested|not_interested|offer_pending|needs_follow_up|undecided');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `price_feedback` SET TAGS ('dbx_business_glossary_term' = 'Price Feedback');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `price_feedback` SET TAGS ('dbx_value_regex' = 'too_high|acceptable|below_expectation|no_comment');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_company` SET TAGS ('dbx_business_glossary_term' = 'Prospect Company Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_interest_level` SET TAGS ('dbx_business_glossary_term' = 'Prospect Interest Level');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_interest_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Full Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_side` SET TAGS ('dbx_business_glossary_term' = 'Prospect Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `prospect_side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|tenant_side|landlord_side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `required_sqft` SET TAGS ('dbx_business_glossary_term' = 'Required Square Footage (SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `salesforce_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Activity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Showing Sequence Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_number` SET TAGS ('dbx_business_glossary_term' = 'Showing Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_number` SET TAGS ('dbx_value_regex' = '^SHW-[0-9]{6,12}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_status` SET TAGS ('dbx_business_glossary_term' = 'Showing Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|no_show|rescheduled|pending_confirmation');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_type` SET TAGS ('dbx_business_glossary_term' = 'Showing Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `showing_type` SET TAGS ('dbx_value_regex' = 'in_person|virtual|self_guided|open_house|broker_preview');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|yardi_voyager|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `space_feedback` SET TAGS ('dbx_business_glossary_term' = 'Space Feedback');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `space_feedback` SET TAGS ('dbx_value_regex' = 'too_large|too_small|right_size|layout_issue|no_comment');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Showing Platform');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `negotiation_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Instrument Identifier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `deal_party_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting Party ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `environmental_review_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `parent_instrument_negotiation_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Instrument ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proforma_id` SET TAGS ('dbx_business_glossary_term' = 'Proforma Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `closing_period_days` SET TAGS ('dbx_business_glossary_term' = 'Proposed Closing Period (Days)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `due_diligence_period_days` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Period (Days)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `earnest_money_deposit` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Deposit (EMD)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `earnest_money_deposit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `environmental_contingency` SET TAGS ('dbx_business_glossary_term' = 'Environmental Contingency Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `financing_contingency` SET TAGS ('dbx_business_glossary_term' = 'Financing Contingency Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `inspection_contingency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Contingency Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_notes` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Instrument Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Instrument Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Instrument Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_value_regex' = 'submitted|countered|accepted|rejected|expired|withdrawn');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Instrument Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'LOI|purchase_offer|lease_proposal|counter_offer|binding_offer');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `is_binding` SET TAGS ('dbx_business_glossary_term' = 'Binding Instrument Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `negotiation_round` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_cam_rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Proposed Common Area Maintenance (CAM) Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_cam_rate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_free_rent_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Free Rent Period (Months)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_leasable_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Proposed Leasable Area (Square Feet / SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Lease Term (Months)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_price` SET TAGS ('dbx_business_glossary_term' = 'Proposed Purchase Price');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Proposed Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Proposed Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `proposed_ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `side` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|tenant_side|landlord_side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce CRM|DocuSign CLM|Yardi Voyager|MRI Software|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ALTER COLUMN `zoning_contingency` SET TAGS ('dbx_business_glossary_term' = 'Zoning / Entitlement Contingency Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` SET TAGS ('dbx_subdomain' = 'compensation_distribution');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Property Space Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `renewal_option_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `agent_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Agent Split Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Approval Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Commission Approved By');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|tenant_rep|landlord_rep|dual_agency');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `co_broker_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `co_broker_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `co_broker_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Split Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_number` SET TAGS ('dbx_business_glossary_term' = 'Commission Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_number` SET TAGS ('dbx_value_regex' = '^COMM-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|voided');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `commission_type` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|psf_based|hybrid');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Consideration Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Commission Dispute Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Dispute Resolution Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `first_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Commission Payment Due Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `flat_fee` SET TAGS ('dbx_business_glossary_term' = 'Commission Flat Fee');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `flat_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `gross_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Commission Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `gross_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Commission Installment Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `is_co_broker` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Arrangement Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `is_referral` SET TAGS ('dbx_business_glossary_term' = 'Referral Commission Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `net_commission_to_house` SET TAGS ('dbx_business_glossary_term' = 'Net Commission to House');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `net_commission_to_house` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commission Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Paid Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Paid Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Schedule');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'upfront|installment|deferred|milestone_based');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `referral_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `referral_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|salesforce_crm|mri_software|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Commission Trigger Event');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `trigger_event` SET TAGS ('dbx_value_regex' = 'lease_execution|closing|loi_acceptance|occupancy|funding');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `trigger_event_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Trigger Event Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ALTER COLUMN `yardi_commission_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Commission ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` SET TAGS ('dbx_subdomain' = 'compensation_distribution');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `commission_split_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Split ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Recipient ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `co_broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Agreement ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Agreement ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `actual_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Commission Disbursement Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Approval Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Approval Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|auto_approved');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Approved By');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Recipient Bank Account Reference');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|dual_agency|tenant_rep|landlord_rep');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `desk_fee_deduction` SET TAGS ('dbx_business_glossary_term' = 'Desk Fee Deduction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `desk_fee_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Disbursement Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_value_regex' = 'scheduled|processed|failed|reversed|on_hold|cancelled');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `errors_omissions_deduction` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Deduction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `errors_omissions_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `gross_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Commission Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `gross_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `is_1099_reportable` SET TAGS ('dbx_business_glossary_term' = '1099 Reportable Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Commission Disbursement Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `override_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Override Adjustment Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `override_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Commission Override Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Method');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|direct_deposit|zelle');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_license_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Real Estate License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_license_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient License State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Commission Recipient Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Recipient Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'in_house_agent|co_broker_firm|referral_partner|brokerage_house|team_lead|franchise_fee');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Disbursement Reversal Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Commission Disbursement Reversal Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `scheduled_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Commission Disbursement Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `split_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `split_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `split_number` SET TAGS ('dbx_business_glossary_term' = 'Split Line Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `split_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `split_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Reference Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `tax_id_reference` SET TAGS ('dbx_business_glossary_term' = 'Recipient Tax Identification Reference');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `tax_id_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `tax_id_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `transaction_close_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Close Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ALTER COLUMN `yardi_ap_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Accounts Payable (AP) Transaction Reference');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `co_broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Agreement ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Agreement Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Agreement Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_execution|active|suspended|terminated|expired');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Agreement Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'sale|lease|sale_and_lease|referral|buyer_representation');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|tenant_rep|landlord_rep|dual_agency');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `co_broker_commission_flat_fee` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Flat Fee');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `co_broker_commission_flat_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `co_broker_commission_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Split Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `co_broker_commission_split_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `commission_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Paid Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `commission_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Paid Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `commission_structure` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `commission_structure` SET TAGS ('dbx_value_regex' = 'percentage_split|flat_fee|hybrid|referral_fee');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `cooperating_firm_license_number` SET TAGS ('dbx_business_glossary_term' = 'Cooperating Broker Firm License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `cooperating_firm_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `cooperating_firm_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `cooperating_firm_license_state` SET TAGS ('dbx_business_glossary_term' = 'Cooperating Broker Firm License State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `cooperating_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Cooperating Broker Firm Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `cooperating_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_email` SET TAGS ('dbx_business_glossary_term' = 'Designated Agent Email Address');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_license_number` SET TAGS ('dbx_business_glossary_term' = 'Designated Agent License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_license_state` SET TAGS ('dbx_business_glossary_term' = 'Designated Agent License State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Designated Agent Full Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_phone` SET TAGS ('dbx_business_glossary_term' = 'Designated Agent Phone Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `designated_agent_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `dual_agency_consent` SET TAGS ('dbx_business_glossary_term' = 'Dual Agency Consent Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `last_amended_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `mls_cooperation_flag` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Cooperation Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `protection_period_days` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Protection Period (Days)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `snda_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment (SNDA) Execution Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `snda_required` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment (SNDA) Required Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|Yardi|DocuSign|MRI|Manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'deal_closed|mutual_agreement|breach|license_revoked|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` SET TAGS ('dbx_subdomain' = 'agent_operations');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `additional_license_states` SET TAGS ('dbx_business_glossary_term' = 'Additional Licensed States');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|pending|failed|not_required');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_value_regex' = 'principal_broker|managing_broker|associate_broker|leasing_agent|buyers_agent|sellers_agent');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `ccim_designation` SET TAGS ('dbx_business_glossary_term' = 'Certified Commercial Investment Member (CCIM) Designation');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `continuing_education_due_date` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Due Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `designated_market_areas` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Areas (DMA)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `dual_agency_authorized` SET TAGS ('dbx_business_glossary_term' = 'Dual Agency Authorization Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Broker Email Address');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'W2|1099|contract|part_time');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `errors_omissions_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `errors_omissions_insurer` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Provider');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Policy Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Full Legal Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `gci_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Gross Commission Income Prior Year (GCI Prior Year)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `gci_prior_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `gci_ytd` SET TAGS ('dbx_business_glossary_term' = 'Gross Commission Income Year-to-Date (GCI YTD)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `gci_ytd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Broker Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'State Real Estate License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License Issuing State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending_renewal');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `mls_board_name` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Board Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `mls_member_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Member ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `mls_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `mls_member_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `mri_agent_code` SET TAGS ('dbx_business_glossary_term' = 'MRI Software Agent Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `nar_member_number` SET TAGS ('dbx_business_glossary_term' = 'National Association of Realtors (NAR) Member Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Phone Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `production_tier` SET TAGS ('dbx_business_glossary_term' = 'Production Tier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `production_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|associate');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM User ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `sior_designation` SET TAGS ('dbx_business_glossary_term' = 'Society of Industrial and Office Realtors (SIOR) Designation');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|mri|adp|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Property Specialization');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team or Desk Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `transaction_side` SET TAGS ('dbx_business_glossary_term' = 'Transaction Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `transaction_side` SET TAGS ('dbx_value_regex' = 'buy_side|sell_side|both|lease_side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ALTER COLUMN `yardi_agent_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Agent Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` SET TAGS ('dbx_subdomain' = 'agent_operations');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `broker_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broker License ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `ce_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Compliance Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `ce_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|in_progress|deficient|waived');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `ce_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Deadline Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `ce_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `ce_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `disciplinary_action_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `disciplinary_action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `disciplinary_action_type` SET TAGS ('dbx_value_regex' = 'complaint|fine|suspension|revocation|reprimand|consent_order');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `disciplinary_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `errors_omissions_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Expiry Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `errors_omissions_insured` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Policy Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_class` SET TAGS ('dbx_business_glossary_term' = 'License Class');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|both');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_endorsements` SET TAGS ('dbx_business_glossary_term' = 'License Endorsements');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|revoked|pending_renewal');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'salesperson|broker|managing_broker|associate_broker|broker_in_charge');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_verification_date` SET TAGS ('dbx_business_glossary_term' = 'License Verification Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_verification_source` SET TAGS ('dbx_business_glossary_term' = 'License Verification Source');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `license_verification_source` SET TAGS ('dbx_value_regex' = 'state_portal|arello|manual|third_party');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `mls_member_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Member ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `mls_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `nar_member_number` SET TAGS ('dbx_business_glossary_term' = 'National Association of Realtors (NAR) Member ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `nar_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `original_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Original License Issue Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `primary_practice_state` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice State Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `reciprocal_home_state` SET TAGS ('dbx_business_glossary_term' = 'Reciprocal Home State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `reciprocal_home_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `reciprocal_license` SET TAGS ('dbx_business_glossary_term' = 'Reciprocal License Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|pending|submitted|approved|lapsed');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Contact ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|manual|arello|state_portal');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `sponsoring_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Broker License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `sponsoring_broker_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Broker Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ALTER COLUMN `yardi_agent_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Agent Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` SET TAGS ('dbx_subdomain' = 'property_marketing');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `mls_syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Syndication ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `costar_property_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Property ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `data_feed_type` SET TAGS ('dbx_business_glossary_term' = 'Data Feed Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `data_feed_type` SET TAGS ('dbx_value_regex' = 'IDX|VOW|RETS|RESO_WEB_API|DIRECT');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `floor_plan_synced` SET TAGS ('dbx_business_glossary_term' = 'Floor Plan Synced Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `http_response_code` SET TAGS ('dbx_business_glossary_term' = 'HTTP Response Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `idx_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Internet Data Exchange (IDX) Opt-In Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `is_featured_listing` SET TAGS ('dbx_business_glossary_term' = 'Featured Listing Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `is_reso_compliant` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Standards Organization (RESO) Data Dictionary Compliance Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `listing_price_synced` SET TAGS ('dbx_business_glossary_term' = 'Synced Listing Price');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `listing_price_synced` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `mls_board_code` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Board Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `next_scheduled_refresh` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Refresh Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `open_house_synced` SET TAGS ('dbx_business_glossary_term' = 'Open House Synced Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `photos_synced_count` SET TAGS ('dbx_business_glossary_term' = 'Photos Synced Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `platform_account_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Account ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `platform_listing_url` SET TAGS ('dbx_business_glossary_term' = 'Platform Listing URL');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `platform_subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Platform Subscription Tier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `platform_subscription_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|enterprise');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `reso_version` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Standards Organization (RESO) Data Dictionary Version');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Syndication Retry Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'CoStar|MLS_Feed|Salesforce|Yardi|Manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Syndication Suppression Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'owner_request|compliance_hold|duplicate_listing|platform_policy|legal_hold|expired');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Syndication Authorized By');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_authorized_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Authorization Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_channel` SET TAGS ('dbx_business_glossary_term' = 'Syndication Channel');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_channel` SET TAGS ('dbx_value_regex' = 'residential|commercial|rental|land|auction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `syndication_status` SET TAGS ('dbx_value_regex' = 'active|pending|failed|withdrawn|suppressed');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Syndication Platform');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `target_platform` SET TAGS ('dbx_value_regex' = 'MLS|CoStar|LoopNet|Zillow|Realtor.com|CREXi');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `transmission_method` SET TAGS ('dbx_business_glossary_term' = 'Transmission Method');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `transmission_method` SET TAGS ('dbx_value_regex' = 'API|FTP|SFTP|EMAIL|MANUAL');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Validation Error Code');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `validation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Platform Validation Error Message');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `virtual_tour_synced` SET TAGS ('dbx_business_glossary_term' = 'Virtual Tour Synced Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `vow_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Virtual Office Website (VOW) Opt-In Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Syndication Withdrawal Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Submarket Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `actual_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Deal Value');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `actual_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Agreement Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `deal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Close Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `deal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Referred Deal Outcome');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `deal_outcome` SET TAGS ('dbx_value_regex' = 'closed_won|closed_lost|pending|withdrawn');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Referral Direction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Value');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `estimated_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Agreement Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Referral Flat Fee Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_flat_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Paid Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Structure');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `fee_structure` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|tiered');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `gross_commission_income` SET TAGS ('dbx_business_glossary_term' = 'Gross Commission Income (GCI)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `gross_commission_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `is_reciprocal` SET TAGS ('dbx_business_glossary_term' = 'Is Reciprocal Referral Indicator');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Payment Direction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'payable|receivable');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|active|closed|paid|cancelled|expired');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'broker|relocation|affinity_network|corporate|online_lead|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Referring Broker License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_broker_license_state` SET TAGS ('dbx_business_glossary_term' = 'Referring Broker License State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_broker_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Firm Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_party_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Party Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `referring_party_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `salesforce_deal_stage` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Deal Stage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `salesforce_referral_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Referral Record ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `source_network` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Network');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|yardi|mri|manual|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `buyer_representation_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Representation ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `brokerage_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Target Submarket Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|completed|suspended');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Broker License Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `broker_license_state` SET TAGS ('dbx_business_glossary_term' = 'Broker License State');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `broker_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `client_type` SET TAGS ('dbx_business_glossary_term' = 'Client Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `commission_flat_fee` SET TAGS ('dbx_business_glossary_term' = 'Commission Flat Fee');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `commission_flat_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `commission_structure` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `commission_structure` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|hybrid');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `deal_stage` SET TAGS ('dbx_business_glossary_term' = 'Deal Stage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `dual_agency_consent` SET TAGS ('dbx_business_glossary_term' = 'Dual Agency Consent');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `last_amended_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amended Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `max_budget` SET TAGS ('dbx_business_glossary_term' = 'Maximum Budget');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `max_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `max_lease_rate_psf` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lease Rate Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `max_lease_rate_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `max_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lease Term Months');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `max_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Size Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `min_budget` SET TAGS ('dbx_business_glossary_term' = 'Minimum Budget');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `min_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `min_lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lease Term Months');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `min_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Minimum Size Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `protection_period_days` SET TAGS ('dbx_business_glossary_term' = 'Protection Period Days');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `representation_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `representation_type` SET TAGS ('dbx_value_regex' = 'exclusive_buyer_rep|exclusive_tenant_rep|non_exclusive_buyer_rep|non_exclusive_tenant_rep|dual_agency');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'docusign_clm|salesforce_crm|manual');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `target_property_use` SET TAGS ('dbx_business_glossary_term' = 'Target Property Use');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `target_property_use` SET TAGS ('dbx_value_regex' = 'owner_occupied|investment|owner_user|redevelopment');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'client_withdrawal|mutual_agreement|breach|transaction_completed|agent_reassignment|other');
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `brokerage_deal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Document ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `co_broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co Broker Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `negotiation_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Loi Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `parent_document_brokerage_deal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Document ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `co_broker_involved` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Involved Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `deal_stage_at_upload` SET TAGS ('dbx_business_glossary_term' = 'Deal Stage at Upload');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `docusign_status` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|pending_signature|executed|voided|expired');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xlsx|jpg|png|tiff');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Kilobytes)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `is_executed_original` SET TAGS ('dbx_business_glossary_term' = 'Is Executed Original Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `is_required_for_stage` SET TAGS ('dbx_business_glossary_term' = 'Is Required for Stage Gate Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `received_from_party` SET TAGS ('dbx_business_glossary_term' = 'Received From Party');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `received_from_party` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `signatory_party_names` SET TAGS ('dbx_business_glossary_term' = 'Signatory Party Names');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `signatory_party_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'docusign_clm|salesforce_crm|yardi_voyager|manual_upload');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `source_system_document_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Document ID');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Document Storage URI');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` SET TAGS ('dbx_subdomain' = 'agent_operations');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` SET TAGS ('dbx_association_edges' = 'brokerage.broker,compliance.program');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `broker_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Program Enrollment Identifier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Program Enrollment - Broker Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Program Enrollment - Compliance Program Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `assigned_role` SET TAGS ('dbx_business_glossary_term' = 'Broker Program Role');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Program Completion Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Broker Compliance Score');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `exemption_granted` SET TAGS ('dbx_business_glossary_term' = 'Exemption Granted Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Program Renewal Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` SET TAGS ('dbx_association_edges' = 'brokerage.deal,compliance.requirement');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `deal_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Compliance Identifier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Compliance - Deal Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Compliance - Compliance Requirement Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Completion Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `cost_incurred` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `evidence_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `evidence_submitted` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submitted Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approver');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` SET TAGS ('dbx_subdomain' = 'property_marketing');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` SET TAGS ('dbx_association_edges' = 'brokerage.listing,compliance.requirement');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `listing_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Disclosure Identifier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Disclosure - Compliance Requirement Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Disclosure - Listing Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `completed_by` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Completed By');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `completed_by` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Completion Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Due Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Evidence Reference');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Reminder Sent Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Waiver Reason');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` SET TAGS ('dbx_subdomain' = 'compensation_distribution');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` SET TAGS ('dbx_association_edges' = 'transaction.property_sale,brokerage.broker');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `broker_commission_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission - Broker Commission Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission - Broker Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission - Property Sale Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `brokerage_side` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Side');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `commission_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Paid Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `commission_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `commission_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number at Transaction');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ALTER COLUMN `representation_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` SET TAGS ('dbx_subdomain' = 'agent_operations');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` SET TAGS ('dbx_association_edges' = 'brokerage.broker,reference.geographic_hierarchy');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `broker_market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Market Coverage Identifier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Market Coverage - Broker Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Market Coverage - Geographic Hierarchy Id');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Assignment Notes');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Status');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `designation_type` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Designation Type');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Expiry Date');
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ALTER COLUMN `is_primary_market` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Flag');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_plan` SET TAGS ('dbx_subdomain' = 'compensation_distribution');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_plan` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Identifier');
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_plan` ALTER COLUMN `superseded_commission_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
