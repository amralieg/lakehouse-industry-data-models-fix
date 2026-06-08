-- Schema for Domain: land | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`land` COMMENT 'Manages mineral rights, surface rights, lease acquisitions, title opinions, and division order processing. Owns lease agreements, working interest (WI), net revenue interest (NRI), ORRI tracking, royalty owner data, acreage positions, lease expiry management, and surface use agreements. Supports regulatory compliance for lease reporting and revenue distribution. Integrates with Quorum Land System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease` (
    `lease_id` BIGINT COMMENT 'Unique identifier for the oil and gas lease record. Primary key for the lease master data product.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Leases generate drilling/completion projects tracked via AFEs. Essential for capital cost allocation, JIB billing, and working interest expense distribution. Core upstream business process linking lan',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Leases are granted within specific basins. Basin-level resource assessments, regulatory jurisdiction, fiscal regime analysis, and portfolio reporting all require linking leases to their geological bas',
    `commercial_counterparty_id` BIGINT COMMENT 'Foreign key reference to the operator party master record. Links to the operating company entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key reference to the lessee party master record. Links to the operator or working interest owner entity.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Leases require drilling permits, surface use permits, and environmental permits to operate. Operators must track which permits authorize activities on each lease for compliance audits and regulatory i',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Leases specify covered petroleum products (crude, gas, NGLs) for mineral rights. Essential for production accounting, royalty calculations by product type, and revenue allocation. Business process: mo',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key reference to the lessor party master record. Links to the counterparty or mineral owner entity.',
    `acquisition_date` DATE COMMENT 'Date when the lessee acquired or executed the lease agreement. May differ from the effective date if the lease was backdated.',
    `api_lease_number` STRING COMMENT 'Standardized API lease identifier assigned by regulatory authorities. Used for well permitting and production reporting.',
    `bonus_consideration_amount` DECIMAL(18,2) COMMENT 'Upfront payment made to the lessor upon execution of the lease agreement. Typically expressed as dollars per acre.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the leased property is located. Primarily USA, CAN (Canada), or MEX (Mexico) for North American operations.. Valid values are `USA|CAN|MEX`',
    `county` STRING COMMENT 'County or parish where the leased property is located. Used for regulatory reporting and tax purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease record was first created in the system. Used for audit trail and data lineage.',
    `delay_rental_amount` DECIMAL(18,2) COMMENT 'Annual payment made to the lessor to maintain the lease without drilling during the primary term. Typically expressed as dollars per acre per year.',
    `depth_restriction_feet` STRING COMMENT 'Maximum or minimum depth restriction specified in the lease agreement. Defines the vertical extent of the leased mineral rights.',
    `effective_date` DATE COMMENT 'Date when the lease agreement becomes legally binding and effective. Marks the start of the lease term.',
    `expiration_date` DATE COMMENT 'Date when the lease agreement expires if not extended or held by production. Marks the end of the primary term or extended term.',
    `federal_lease_number` STRING COMMENT 'Lease number assigned by BOEM (Bureau of Ocean Energy Management) or BLM (Bureau of Land Management) for federal lands or offshore leases.',
    `field_name` STRING COMMENT 'Name of the oil or gas field associated with the lease. May be assigned by the operator or regulatory authority.',
    `first_production_date` DATE COMMENT 'Date when commercial production first commenced on the lease. Triggers held-by-production status and extends the lease beyond the primary term.',
    `formation_restriction` STRING COMMENT 'Specific geologic formation or stratigraphic interval covered by the lease. May limit production to certain zones.',
    `gross_acres` DECIMAL(18,2) COMMENT 'Total acreage covered by the lease agreement, regardless of ownership percentage. Represents the full geographic extent of the lease.',
    `last_production_date` DATE COMMENT 'Date of the most recent production activity on the lease. Used to monitor continuous production requirements for held-by-production status.',
    `lease_name` STRING COMMENT 'Common name or title of the lease, often derived from geographic location or lessor name.',
    `lease_number` STRING COMMENT 'Externally-known business identifier for the lease agreement. Unique lease number assigned by the land department or regulatory authority.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease. Indicates whether the lease is active, expired, held by production (HBP), released, suspended, or pending execution.. Valid values are `active|expired|held_by_production|released|suspended|pending`',
    `lease_type` STRING COMMENT 'Classification of the lease agreement type. Distinguishes between oil and gas leases, mineral leases, surface leases, royalty interests, and overriding royalty interests.. Valid values are `oil_and_gas|mineral|surface|royalty|overriding_royalty`',
    `legal_description` STRING COMMENT 'Full legal land description of the leased property using township, range, section, and subdivision notation (e.g., NE/4 of Section 12, Township 5N, Range 3W).',
    `lessee_name` STRING COMMENT 'Name of the party acquiring the lease rights (operator or working interest owner). Typically the oil and gas company.',
    `lessor_name` STRING COMMENT 'Name of the party granting the lease rights (mineral rights owner). May be an individual, corporation, or government entity.',
    `net_acres` DECIMAL(18,2) COMMENT 'Acreage adjusted for the lessees ownership percentage or working interest. Calculated as gross acres multiplied by working interest percentage.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue the lessee receives after deducting royalties and overriding royalty interests. Calculated as WI minus royalty burdens.',
    `operator_name` STRING COMMENT 'Name of the company designated as the operator of the lease. Responsible for day-to-day operations and regulatory compliance.',
    `pooling_unit_flag` BOOLEAN COMMENT 'Indicates whether the lease is part of a pooling or unitization agreement. True if the lease is combined with other leases for production allocation.',
    `primary_term_years` DECIMAL(18,2) COMMENT 'Duration of the initial lease term in years before production must commence or the lease expires. Typical values range from 1 to 10 years.',
    `range` STRING COMMENT 'Range designation in the Public Land Survey System (PLSS). Identifies the east-west position of the land parcel.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue or volume paid to the lessor as royalty. Typical values range from 12.5% to 25%.',
    `section` STRING COMMENT 'Section number within the township and range. Sections are typically one square mile (640 acres) and numbered 1-36.',
    `state_province` STRING COMMENT 'State or province where the leased property is located. Two-letter abbreviation (e.g., TX, OK, AB).',
    `surface_use_agreement_flag` BOOLEAN COMMENT 'Indicates whether a separate surface use agreement exists for access and operations. True if surface rights are separately negotiated.',
    `title_opinion_date` DATE COMMENT 'Date when the most recent title opinion was issued by legal counsel. Confirms the lessors ownership and the validity of the lease.',
    `title_opinion_status` STRING COMMENT 'Status of the title opinion review. Indicates whether the title is clear, has defects, is pending review, or not required.. Valid values are `clear|defective|pending|not_required`',
    `township` STRING COMMENT 'Township designation in the Public Land Survey System (PLSS). Identifies the north-south position of the land parcel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease record was last modified in the system. Used for audit trail and change tracking.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage ownership of the operating rights and obligations in the lease. Represents the lessees share of costs and revenues before royalty deductions.',
    CONSTRAINT pk_lease PRIMARY KEY(`lease_id`)
) COMMENT 'Core master record for oil and gas mineral rights leases. Captures the authoritative lease agreement details including lessor/lessee identification, lease type (oil and gas, mineral, surface), effective date, primary term, bonus consideration, delay rental provisions, royalty rate, acreage, legal description (township/range/section), county, state, and lease status (active, expired, held by production, released). Integrates with Quorum Land System as the primary lease master. Serves as the SSOT for all lease-level data consumed by royalty, JIB, and production allocation processes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`mineral_right` (
    `mineral_right_id` BIGINT COMMENT 'Unique identifier for the mineral right record. Primary key for the mineral right master data entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Mineral rights development requires AFE authorization for drilling/completion. Links subsurface ownership economics to capital project budgeting. Standard upstream cost tracking for mineral acreage de',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease instrument that grants the right to explore and produce from this mineral right. Null if the mineral right is not currently under lease. Links to lease master data.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Mineral rights grant extraction rights for specific petroleum products. Critical for determining legal production authority by product type. Business process: pre-drill legal review verifies product-s',
    `title_opinion_id` BIGINT COMMENT 'Foreign key linking to land.title_opinion. Business justification: Mineral rights ownership is validated through title opinions. The mineral_right has title_opinion_status, title_opinion_date, and title_examiner fields that duplicate title_opinion attributes. Adding ',
    `tract_id` BIGINT COMMENT 'Reference to the land tract or parcel to which this mineral right applies. Links to the tract master data.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the mineral right, including purchase price, legal fees, and transaction costs. Used for capital expenditure (CAPEX) tracking, asset valuation, and depreciation depletion and amortization (DD&A) calculations.',
    `acquisition_date` DATE COMMENT 'Date on which the mineral right was acquired by the current owner. Used for title chain analysis, cost basis calculation, and holding period determination for tax purposes.',
    `acquisition_method` STRING COMMENT 'Method by which the mineral right was acquired. Determines cost basis treatment, tax implications, and documentation requirements for title verification. [ENUM-REF-CANDIDATE: purchase|inheritance|gift|reservation|assignment|foreclosure|condemnation|merger_acquisition — 8 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the mineral right is located. Determines international regulatory compliance, fiscal regime, and production sharing agreement (PSA) applicability. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|ARG|GBR|NOR|SAU|ARE|QAT|KWT|IRQ|IRN|RUS|CHN|AUS|NGA|AGO|VEN|COL|ECU — 21 candidates stripped; promote to reference product]',
    `county` STRING COMMENT 'County in which the mineral right is located. Critical for regulatory reporting, tax assessment, and jurisdictional compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mineral right record was first created in the system. Used for audit trail, data lineage tracking, and SOX compliance.',
    `cumulative_production_boe` DECIMAL(18,2) COMMENT 'Total cumulative production from this mineral right expressed in barrels of oil equivalent (BOE). Includes oil, natural gas (converted at 6 MCF = 1 BOE), and natural gas liquids (NGL). Used for reserves reconciliation and depletion analysis.',
    `depth_from_feet` DECIMAL(18,2) COMMENT 'Starting depth in feet for depth-severed mineral rights. Defines the top of the depth interval to which the mineral ownership applies. Null if mineral right applies to all depths.',
    `depth_to_feet` DECIMAL(18,2) COMMENT 'Ending depth in feet for depth-severed mineral rights. Defines the bottom of the depth interval to which the mineral ownership applies. Null if mineral right applies to all depths below depth_from.',
    `encumbrance_description` STRING COMMENT 'Detailed description of any liens, mortgages, judgments, or other encumbrances affecting the mineral right. Includes creditor name, amount, and recording information. Used for title curative and payment suspension decisions.',
    `encumbrance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the mineral right is subject to liens, mortgages, judgments, or other encumbrances that could affect marketability or revenue distribution. True indicates encumbrances exist.',
    `estimated_ultimate_recovery_boe` DECIMAL(18,2) COMMENT 'Estimated Ultimate Recovery (EUR) for this mineral right in barrels of oil equivalent. Represents total expected production over the life of the property. Used for reserves booking, asset valuation, and economic analysis.',
    `first_production_date` DATE COMMENT 'Date of first commercial production from this mineral right. Used to determine lease holding requirements, primary term expiration, and reserves booking eligibility under SEC and PRMS guidelines.',
    `formation_name` STRING COMMENT 'Geological formation or reservoir to which the mineral right applies. Some mineral rights are severed by depth or formation, restricting ownership to specific stratigraphic intervals.',
    `last_production_date` DATE COMMENT 'Date of most recent production from this mineral right. Used to monitor continuous production requirements for lease maintenance and identify shut-in or abandoned properties.',
    `legal_description` STRING COMMENT 'Full legal description of the land parcel to which the mineral right applies. Typically includes section, township, range, county, and state information following Public Land Survey System (PLSS) or metes and bounds format.',
    `mineral_interest_type` STRING COMMENT 'Classification of the type of mineral interest held. Fee mineral represents full ownership of subsurface rights. Royalty interest (RI) is a share of production free of costs. Overriding Royalty Interest (ORRI) is carved from working interest. Non-Participating Royalty Interest (NPRI) receives royalty but has no lease execution rights. Working Interest (WI) bears costs and receives revenue. Net Profits Interest receives share after costs.. Valid values are `fee_mineral|royalty_interest|overriding_royalty_interest|non_participating_royalty_interest|working_interest|net_profits_interest`',
    `mineral_right_number` STRING COMMENT 'Business identifier or reference number assigned to the mineral right for external communication and tracking. May be assigned by land department or derived from legal description.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this mineral right record. Used for accountability, audit trail, and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this mineral right record was last modified. Used for change tracking, audit trail, and data quality monitoring.',
    `net_mineral_acres` DECIMAL(18,2) COMMENT 'Net mineral acres calculated as gross acres multiplied by ownership fraction. Represents the effective acreage owned for reserves and production allocation purposes.',
    `net_revenue_interest` DECIMAL(18,2) COMMENT 'Net Revenue Interest (NRI) is the decimal interest in production revenue after deducting royalty, overriding royalty interest (ORRI), and other burdens from Working Interest (WI). Used for revenue distribution and economic analysis. NRI = WI × (1 - Royalty - ORRI).',
    `overriding_royalty_interest` DECIMAL(18,2) COMMENT 'Overriding Royalty Interest (ORRI) is a share of production revenue carved from Working Interest, free of operating costs but burdened by production costs. Expressed as a decimal fraction. Used for revenue distribution calculations.',
    `owner_address` STRING COMMENT 'Mailing address for the mineral right owner. Used for royalty payment distribution, tax reporting, and legal correspondence. Must be kept current for unclaimed property compliance.',
    `owner_name` STRING COMMENT 'Full legal name of the mineral right owner. May be an individual, trust, estate, corporation, or partnership. Used for division order processing and revenue distribution.',
    `owner_tax_code` STRING COMMENT 'Tax identification number for the mineral right owner. Social Security Number (SSN) for individuals or Employer Identification Number (EIN) for entities. Required for IRS Form 1099 reporting of royalty payments.',
    `owner_type` STRING COMMENT 'Classification of the legal entity type of the mineral right owner. Determines tax reporting requirements, payment processing rules, and documentation standards. [ENUM-REF-CANDIDATE: individual|trust|estate|corporation|partnership|limited_liability_company|joint_venture|government_entity — 8 candidates stripped; promote to reference product]',
    `ownership_fraction` DECIMAL(18,2) COMMENT 'Decimal representation of the ownership percentage or fraction of the mineral right. For example, 0.125 represents 1/8th mineral interest. Used to calculate revenue distribution and acreage positions.',
    `payout_status` STRING COMMENT 'Indicates whether the well or property has reached payout (recovered drilling and completion costs). Some ORRI or back-in interests change after payout. Used for revenue distribution and interest reversion tracking.. Valid values are `before_payout|after_payout|not_applicable`',
    `producing_status` STRING COMMENT 'Current production status of the mineral right. Producing indicates active production. Held by production means lease is maintained by production from other tracts. Non-producing indicates no current production but lease is active. Shut-in indicates temporary cessation. Expired or released indicates lease has terminated.. Valid values are `producing|non_producing|shut_in|held_by_production|expired|released`',
    `record_status` STRING COMMENT 'Current lifecycle status of the mineral right record. Active indicates current ownership and operational relevance. Inactive indicates ownership has been transferred or lease has expired. Pending verification indicates title examination in progress. Archived indicates historical record retained for audit purposes.. Valid values are `active|inactive|pending_verification|archived`',
    `reserves_category` STRING COMMENT 'Classification of reserves associated with this mineral right per SPE PRMS and SEC guidelines. Proved Developed Producing (PDP) are currently producing. Proved Developed Non-Producing (PDNP) are drilled but not producing. Proved Undeveloped (PUD) require additional capital. Probable (2P) and Possible (3P) have lower certainty.. Valid values are `proved_developed_producing|proved_developed_non_producing|proved_undeveloped|probable|possible|unproved`',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Decimal representation of the royalty rate applicable to production from this mineral right. Typically ranges from 0.125 (1/8) to 0.25 (1/4). Used for revenue distribution and Net Revenue Interest (NRI) calculations.',
    `severance_date` DATE COMMENT 'Date on which the mineral estate was severed from the surface estate. Null if mineral and surface rights were never unified. Critical for title chain analysis and determining priority of interests.',
    `severance_instrument_type` STRING COMMENT 'Type of legal instrument that created the severance of mineral rights from surface rights. Used for title opinion preparation and chain of title verification.. Valid values are `deed|lease|reservation|assignment|court_order|patent`',
    `state_province` STRING COMMENT 'State or province in which the mineral right is located. Determines applicable regulatory framework, severance tax rates, and reporting requirements.',
    `suspended_payment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether royalty or revenue payments to this mineral right owner are currently suspended. True indicates payments are being held in suspense due to title defects, missing documentation, or legal disputes.',
    `suspension_reason` STRING COMMENT 'Reason code for suspended payments. Title defect indicates unmarketable title. Missing W-9 indicates tax documentation not received. Deceased owner indicates estate not probated. Address unknown triggers unclaimed property reporting. Legal dispute indicates litigation. Bankruptcy indicates automatic stay. [ENUM-REF-CANDIDATE: title_defect|missing_w9|deceased_owner|address_unknown|legal_dispute|bankruptcy|other — 7 candidates stripped; promote to reference product]',
    `working_interest` DECIMAL(18,2) COMMENT 'Working Interest (WI) is the operating interest that bears the cost of exploration, development, and production. Expressed as a decimal fraction. Used for Authorization for Expenditure (AFE) allocation and Joint Interest Billing (JIB).',
    CONSTRAINT pk_mineral_right PRIMARY KEY(`mineral_right_id`)
) COMMENT 'Master record representing ownership of subsurface mineral rights for a specific tract or parcel. Tracks mineral interest type (fee mineral, royalty interest, ORRI, non-participating royalty interest), ownership fraction, legal description, county, state, formation-specific rights, depth limitations, and severance history. Serves as the SSOT for mineral ownership data distinct from the lease instrument itself. Supports title chain analysis and acreage position reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`tract` (
    `tract_id` BIGINT COMMENT 'Unique identifier for the tract record. Primary key for the tract entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Tracts are developed via AFE-funded drilling/facility projects. Critical for acreage-level cost tracking and land department reporting on capital deployed per tract. Standard upstream land-to-capital ',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Tracts are located within geological basins. Basin context is essential for land valuation, leasing strategy, play-based acreage aggregation, and resource potential assessment. Removes denormalized ba',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tracts require permits for surface disturbance, drilling, environmental activities, and land use. Essential for tracking permit coverage across land holdings and ensuring compliance before operations ',
    `acquisition_date` DATE COMMENT 'Date on which the company acquired rights to the tract, either through lease, purchase, or other conveyance.',
    `api_county_code` STRING COMMENT 'Three-digit API county code assigned by the American Petroleum Institute for standardized geographic identification in oil and gas reporting.. Valid values are `^[0-9]{3}$`',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the tract centroid in decimal degrees. Used for spatial indexing and proximity analysis.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the tract centroid in decimal degrees. Used for spatial indexing and proximity analysis.',
    `comments` STRING COMMENT 'Free-form text field for additional notes, special conditions, or operational remarks related to the tract.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country in which the tract is located.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish in which the tract is located. Critical for regulatory reporting and tax jurisdiction determination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the tract record was first created in the system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the source system from which the tract record originated, typically Quorum Land System or legacy land management system.',
    `environmental_restriction_flag` BOOLEAN COMMENT 'Indicates whether the tract is subject to environmental restrictions or protected area designations that limit operations.',
    `expiration_date` DATE COMMENT 'Date on which the companys rights to the tract expire, if applicable. Used for lease expiry management and renewal tracking.',
    `gis_polygon_reference` STRING COMMENT 'Reference identifier or coordinate set linking the tract to its spatial polygon representation in the GIS system. Enables spatial analysis and mapping.',
    `gross_acres` DECIMAL(18,2) COMMENT 'Total surface area of the tract in acres, representing the full geographic extent without adjustment for ownership interest.',
    `land_classification` STRING COMMENT 'Classification of the tract based on its current development and production status. Used for reserves booking and regulatory reporting.. Valid values are `producing|non_producing|exploratory|development|held_by_production|undeveloped`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the tract record was last updated. Used for audit trail and change tracking.',
    `legal_description` STRING COMMENT 'Full legal description of the tract using metes and bounds, township/range/section/quarter notation, or other legally recognized land description methods. Critical for title and ownership verification.',
    `mineral_owner_name` STRING COMMENT 'Name of the entity or individual holding mineral rights to the tract. Critical for lease acquisition and royalty payment.',
    `mineral_ownership_type` STRING COMMENT 'Classification of mineral rights ownership for the tract. Indicates whether mineral rights are owned in fee, leased, or severed from surface rights. [ENUM-REF-CANDIDATE: fee|leased|federal|state|private|tribal|severed|other — 8 candidates stripped; promote to reference product]',
    `net_acres` DECIMAL(18,2) COMMENT 'Net acreage representing the companys proportional ownership or leasehold interest in the tract, calculated as gross acres multiplied by working interest or net revenue interest.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest held by the company in the tract. Represents the companys share of production revenue after royalty and overriding royalty deductions.',
    `overriding_royalty_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue payable as overriding royalty interest, carved out of the working interest. Does not bear operating costs.',
    `play` STRING COMMENT 'Name of the geologic play or prospective formation associated with the tract. Identifies the target hydrocarbon-bearing zone.',
    `quarter_section` STRING COMMENT 'Quarter section designation (e.g., NE, SW, NW, SE) or further subdivision (e.g., NE/NW) within the section.',
    `range` STRING COMMENT 'Range designation in the Public Land Survey System (PLSS), typically expressed as a number followed by direction (e.g., 3E, 8W).',
    `regulatory_district` STRING COMMENT 'Regulatory district or field office jurisdiction under which the tract falls. Used for permit applications and compliance reporting.',
    `royalty_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue payable to mineral rights owners as royalty. Typically ranges from 12.5% to 25% depending on lease terms.',
    `section` STRING COMMENT 'Section number within the township and range, typically 1-36 in the PLSS grid system.',
    `state_province` STRING COMMENT 'State or province in which the tract is located. Used for regulatory compliance and jurisdictional reporting.',
    `surface_owner_name` STRING COMMENT 'Name of the entity or individual holding surface ownership rights to the tract. Used for surface use agreement negotiations.',
    `surface_ownership_type` STRING COMMENT 'Classification of surface ownership rights for the tract. Determines surface use rights and access requirements. [ENUM-REF-CANDIDATE: fee|leased|federal|state|private|tribal|other — 7 candidates stripped; promote to reference product]',
    `surface_use_agreement_flag` BOOLEAN COMMENT 'Indicates whether a surface use agreement is in place for the tract. True if agreement exists, False otherwise.',
    `title_opinion_date` DATE COMMENT 'Date on which the most recent title opinion was issued for the tract. Used to track currency of title examination.',
    `title_opinion_status` STRING COMMENT 'Status of the legal title opinion for the tract. Indicates whether title has been examined and cleared for operations.. Valid values are `complete|pending|defective|curative_required|not_required`',
    `township` STRING COMMENT 'Township designation in the Public Land Survey System (PLSS), typically expressed as a number followed by direction (e.g., 5N, 12S).',
    `tract_name` STRING COMMENT 'Descriptive name or title assigned to the tract for identification purposes.',
    `tract_number` STRING COMMENT 'Business identifier for the tract, typically assigned by the land department or external authority. Used for external reference and reporting.',
    `tract_status` STRING COMMENT 'Current lifecycle status of the tract record. Indicates whether the tract is actively managed, pending acquisition, or has been released.. Valid values are `active|inactive|pending|expired|released|held`',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the company in the tract. Represents the companys share of costs and operations before royalty deductions.',
    CONSTRAINT pk_tract PRIMARY KEY(`tract_id`)
) COMMENT 'Master record for a defined land parcel or tract used as the fundamental geographic unit for land administration. Captures legal description (metes and bounds, township/range/section/quarter), gross acres, net acres, county, state, basin, play, GIS polygon reference, surface ownership, and mineral ownership status. Tracts are the foundational spatial unit to which leases, wells, and acreage positions are tied. Integrates with GIS systems for spatial analysis.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`royalty_owner` (
    `royalty_owner_id` BIGINT COMMENT 'Unique identifier for the royalty owner record. Primary key for the royalty owner entity.',
    `account_type` STRING COMMENT 'Type of bank account for electronic payment disbursement. Required for ACH payment processing.. Valid values are `checking|savings`',
    `backup_withholding_flag` BOOLEAN COMMENT 'Indicates whether backup withholding is required on royalty payments. True when owner fails to provide valid TIN or IRS notifies of underreporting. Requires 24% federal withholding on payments.',
    `backup_withholding_rate` DECIMAL(18,2) COMMENT 'Percentage rate for backup withholding on royalty payments when backup withholding flag is true. Typically 0.2400 (24%) per IRS regulations.',
    `bank_account_number` STRING COMMENT 'Bank account number for electronic payment disbursement via ACH or wire transfer. Required when payment method is electronic.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the royalty owner payment account.',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing transit number identifying the financial institution for electronic payment processing.. Valid values are `^[0-9]{9}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the royalty owner record was first created in the system. Used for audit trail and data lineage tracking.',
    `cumulative_payments_to_date` DECIMAL(18,2) COMMENT 'Total dollar amount of all royalty payments disbursed to the owner since inception. Used for lifetime value analysis and 1099 reporting threshold determination.',
    `date_of_death` DATE COMMENT 'Date the royalty owner was declared deceased. Used for estate processing, final payment calculation, and transfer of ownership to estate or heirs.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the royalty owner is deceased. True triggers estate processing workflow and payment suspension pending estate documentation.',
    `email_address` STRING COMMENT 'Primary email address for electronic correspondence, payment notifications, and division order delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `estate_representative_name` STRING COMMENT 'Full name of the executor, administrator, or personal representative managing the deceased owner estate. Used for estate payment processing and correspondence.',
    `estate_tax_identification_number` STRING COMMENT 'Employer Identification Number (EIN) assigned to the estate for tax reporting purposes. Required for payments to estates exceeding IRS thresholds.',
    `foreign_person_flag` BOOLEAN COMMENT 'Indicates whether the royalty owner is a foreign person or entity for US tax purposes. True for non-US persons, triggering Form W-8BEN requirements and potential withholding under IRC Chapter 3.',
    `foreign_withholding_rate` DECIMAL(18,2) COMMENT 'Percentage rate for foreign tax withholding on royalty payments to non-US persons. Default is 0.3000 (30%) unless reduced by tax treaty.',
    `form_1099_required_flag` BOOLEAN COMMENT 'Indicates whether the royalty owner requires IRS Form 1099-MISC reporting for annual royalty income. True for US persons receiving $600 or more in annual royalty payments.',
    `interest_owner_number` STRING COMMENT 'Unique business identifier assigned to the royalty owner in the land and lease management system. Used for cross-system integration and division order processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the royalty owner record was most recently updated. Used for change tracking and audit compliance.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the most recent royalty payment disbursed to the owner. Used for payment history and trend analysis.',
    `last_payment_date` DATE COMMENT 'Date of the most recent royalty payment disbursed to the owner. Used for payment history tracking and dormancy analysis.',
    `mailing_address_line1` STRING COMMENT 'Primary street address line for royalty payment remittance and correspondence. Includes street number, street name, and unit/suite number if applicable.',
    `mailing_address_line2` STRING COMMENT 'Secondary address line for additional address details such as apartment number, building name, or care-of information.',
    `mailing_city` STRING COMMENT 'City name for the royalty owner mailing address.',
    `mailing_country_code` STRING COMMENT 'Three-letter ISO country code for the royalty owner mailing address. Determines international payment processing and tax withholding requirements.. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'Postal or ZIP code for the royalty owner mailing address. Used for payment delivery and tax jurisdiction determination.',
    `mailing_state_province` STRING COMMENT 'State or province code for the royalty owner mailing address. Uses two-letter state abbreviations for US addresses or province codes for international addresses.',
    `minimum_payment_threshold` DECIMAL(18,2) COMMENT 'Minimum dollar amount required before issuing a royalty payment to the owner. Payments below this threshold are held and accumulated until the threshold is met. Reduces administrative costs for small payments.',
    `owner_name` STRING COMMENT 'Full legal name of the individual or entity entitled to receive royalty payments. For individuals, includes first, middle, and last name. For entities, includes full legal business name.',
    `owner_status` STRING COMMENT 'Current lifecycle status of the royalty owner record. Active owners receive payments; deceased owners trigger estate processing; suspended owners require resolution before payment.. Valid values are `active|inactive|deceased|suspended|pending_verification`',
    `owner_type` STRING COMMENT 'Classification of the royalty owner entity type. Determines tax treatment, reporting requirements, and payment processing rules. [ENUM-REF-CANDIDATE: individual|trust|estate|corporation|partnership|limited_liability_company|government — 7 candidates stripped; promote to reference product]',
    `payment_frequency` STRING COMMENT 'Frequency at which royalty payments are disbursed to the owner. Determines payment cycle and accumulation period.. Valid values are `monthly|quarterly|annual|on_demand`',
    `payment_method` STRING COMMENT 'Preferred method for royalty payment disbursement. Determines payment processing workflow and banking information requirements.. Valid values are `check|ach|wire_transfer|electronic_funds_transfer`',
    `primary_phone_number` STRING COMMENT 'Primary contact telephone number for the royalty owner. Used for payment inquiries, division order questions, and ownership verification.',
    `suspended_payment_balance` DECIMAL(18,2) COMMENT 'Dollar amount of royalty payments currently held in suspense due to missing documentation, address issues, or ownership disputes. Released when issues are resolved.',
    `suspension_reason` STRING COMMENT 'Business reason for suspending royalty payments to the owner. Examples include missing tax forms, invalid address, ownership dispute, deceased without estate documentation, or regulatory hold.',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the royalty owner. May be Social Security Number (SSN) for individuals, Employer Identification Number (EIN) for entities, or Taxpayer Identification Number (TIN) for foreign entities. Used for IRS 1099 reporting and tax withholding compliance.',
    `tax_treaty_country_code` STRING COMMENT 'Three-letter ISO country code for tax treaty application. Used to determine reduced withholding rates for foreign royalty owners under bilateral tax treaties.. Valid values are `^[A-Z]{3}$`',
    `w8_form_expiration_date` DATE COMMENT 'Expiration date of the IRS Form W-8. W-8 forms are generally valid for three years from signing. After expiration, default 30% withholding applies until new form is received.',
    `w8_form_received_date` DATE COMMENT 'Date the IRS Form W-8BEN or W-8BEN-E (Certificate of Foreign Status) was received from the foreign royalty owner. Required for non-US persons to claim tax treaty benefits and reduced withholding rates.',
    `w9_form_received_date` DATE COMMENT 'Date the IRS Form W-9 (Request for Taxpayer Identification Number and Certification) was received from the royalty owner. Required for US persons to certify TIN and avoid backup withholding.',
    CONSTRAINT pk_royalty_owner PRIMARY KEY(`royalty_owner_id`)
) COMMENT 'Master record for individuals or entities entitled to receive royalty payments from oil and gas production. Captures owner name, owner type (individual, trust, corporation, government), tax identification number (TIN/EIN/SSN), mailing address, payment preferences, 1099 reporting status, backup withholding flag, deceased/estate status, and contact information. Serves as the SSOT for royalty owner identity data used in division order processing and revenue distribution. Integrates with Quorum Land System owner master.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`division_order` (
    `division_order_id` BIGINT COMMENT 'Unique identifier for the division order record. Primary key for the division order entity.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Division orders allocate revenue by specific product type (oil vs gas vs NGL) with different pricing and tax treatment. Required for accurate royalty payment calculations. Business process: monthly re',
    `pooling_unit_id` BIGINT COMMENT 'Reference to the pooled unit or communitization agreement under which production is allocated across multiple leases. Applicable for unitized operations where production is shared across participating leases.',
    `previous_division_order_id` BIGINT COMMENT 'Reference to the prior division order record that this division order supersedes. Used to maintain historical chain of ownership and interest changes. Nullable for initial division orders.',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the royalty owner, working interest partner, or overriding royalty interest holder who receives revenue distribution. Links to the owner master data containing contact and payment information.',
    `title_opinion_id` BIGINT COMMENT 'Reference to the legal title opinion document that validates the owners interest and supports the division order. Links to the title opinion master data containing attorney certification and legal review details.',
    `tract_id` BIGINT COMMENT 'Reference to the specific tract or land parcel within the lease from which production is allocated. Used for multi-tract leases where different owners may have interests in different tracts.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Division orders are issued to venture partners for their share of production revenue. Venture_partner_id enables partner-level revenue allocation, payment processing, and 1099 reporting for joint vent',
    `allocation_method` STRING COMMENT 'The method by which production and revenue are allocated to this division order. Well indicates allocation based on individual well production. Lease indicates allocation across all wells on the lease. Unit indicates allocation based on unit participation. Tract indicates allocation to specific land tract. Proportionate indicates allocation based on decimal interest across multiple sources.. Valid values are `Well|Lease|Unit|Tract|Proportionate`',
    `approval_date` DATE COMMENT 'The date on which the division order was approved by the land department, legal counsel, or revenue accounting team. Represents formal authorization to begin revenue distribution under this division order.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the division order. Typically a land manager, revenue accountant, or legal counsel with authority to authorize revenue distribution.',
    `backup_withholding_flag` BOOLEAN COMMENT 'Indicates whether backup withholding is required for this owner due to missing or incorrect Tax Identification Number (TIN). True when backup withholding applies, false otherwise. Backup withholding rate is typically 24% per IRS regulations.',
    `cost_bearing_flag` BOOLEAN COMMENT 'Indicates whether this interest holder is responsible for bearing their proportionate share of operating costs and capital expenditures. True for working interest owners, false for royalty and overriding royalty interest holders who receive revenue net of costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this division order record was first created in the system. Used for audit trail and data lineage tracking.',
    `decimal_interest` DECIMAL(18,2) COMMENT 'The precise decimal fraction representing the owners proportionate share of production revenue or costs. Expressed as a decimal value (e.g., 0.125 for 12.5% interest). This is the authoritative value used for all revenue distribution calculations and royalty payments.',
    `division_order_number` STRING COMMENT 'Business identifier for the division order, typically formatted as DO- prefix followed by alphanumeric code. Used for external reference and communication with royalty owners and working interest partners.. Valid values are `^DO-[A-Z0-9]{6,12}$`',
    `division_order_status` STRING COMMENT 'Current lifecycle status of the division order. Active indicates revenue distribution is occurring. Suspended indicates temporary hold on payments due to title issues or disputes. Pending Title indicates awaiting title opinion clearance. Terminated indicates division order is no longer in effect. Draft indicates division order is being prepared. Under Review indicates legal or accounting review in progress.. Valid values are `Active|Suspended|Pending Title|Terminated|Draft|Under Review`',
    `effective_date` DATE COMMENT 'The date from which this division order becomes legally binding and revenue distribution begins. Typically aligned with first production date, title opinion date, or ownership transfer date.',
    `gross_acres` DECIMAL(18,2) COMMENT 'The total acreage of the lease or tract from which the owners interest is derived. Used in net acres calculation and reserve allocation.',
    `interest_calculation_method` STRING COMMENT 'The methodology used to calculate the decimal interest for this division order. Net Acres indicates calculation based on net acreage ownership. Proportionate Share indicates calculation based on lease or unit participation. Unit Formula indicates calculation per unit operating agreement. Custom indicates special calculation per lease terms or legal requirements.. Valid values are `Net Acres|Proportionate Share|Unit Formula|Custom`',
    `interest_type` STRING COMMENT 'Classification of the ownership interest type. WI (Working Interest) represents operational ownership and cost-bearing interest. NRI (Net Revenue Interest) represents the net share of production revenue after royalties. ORRI (Overriding Royalty Interest) represents a carved-out interest from working interest. Royalty represents landowner mineral rights interest. Mineral Interest represents subsurface mineral ownership. Leasehold Interest represents the lessees interest in the lease.. Valid values are `WI|NRI|ORRI|Royalty|Mineral Interest|Leasehold Interest`',
    `minimum_payment_threshold` DECIMAL(18,2) COMMENT 'The minimum dollar amount that must accumulate before a revenue payment is issued to the owner. Amounts below this threshold are carried forward to the next payment period. Typically set to reduce administrative costs for small interest holders.',
    `modified_by` STRING COMMENT 'The user identifier or system account that last modified this division order record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this division order record was last modified. Updated whenever any field in the record is changed. Used for audit trail and change tracking.',
    `net_acres` DECIMAL(18,2) COMMENT 'The owners net acreage interest calculated as gross acres multiplied by decimal interest. Represents the effective acreage ownership for revenue and reserve allocation purposes.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special instructions, or clarifications regarding the division order. May include details about title issues, ownership complexities, payment instructions, or historical context.',
    `owner_signature_date` DATE COMMENT 'The date on which the owner signed and returned the division order document. Used to track owner acknowledgment and agreement to the stated interest and terms. Nullable if owner signature is not required or not yet received.',
    `owner_signature_received_flag` BOOLEAN COMMENT 'Indicates whether a signed division order has been received from the owner. True when signed document is on file, false when signature is pending or not required. Some jurisdictions allow payment without signature after a statutory waiting period.',
    `participating_area_acres` DECIMAL(18,2) COMMENT 'The acreage within the unit or lease that is allocated to this division order for production sharing purposes. Used in unit allocation calculations to determine proportionate share of unit production.',
    `payment_method` STRING COMMENT 'The method by which revenue payments are distributed to the owner. ACH (Automated Clearing House) for electronic bank transfers, Wire Transfer for same-day electronic payments, Check for paper check mailing, Direct Deposit for recurring electronic deposits.. Valid values are `ACH|Wire Transfer|Check|Direct Deposit`',
    `percentage_interest` DECIMAL(18,2) COMMENT 'The owners interest expressed as a percentage (e.g., 12.5000 for 12.5%). Derived from decimal_interest for reporting and display purposes. Stored separately for business user convenience.',
    `revenue_deck` STRING COMMENT 'The revenue distribution deck or payment group to which this division order is assigned. Used to batch and process revenue payments for owners with similar payment timing and processing requirements.. Valid values are `^[A-Z0-9]{1,10}$`',
    `revision_number` STRING COMMENT 'Sequential version number tracking changes to the division order. Incremented each time the division order is amended due to ownership changes, interest corrections, or title updates. Used for audit trail and historical tracking.',
    `statutory_payment_date` DATE COMMENT 'The date after which payment may legally commence without owner signature, as defined by state division order statutes. Typically 120-180 days after division order is mailed to owner. Used to ensure compliance with state payment timing requirements.',
    `suspense_date` DATE COMMENT 'The date on which revenue payments were first placed in suspense. Used for aging analysis and regulatory compliance reporting of suspended funds.',
    `suspense_flag` BOOLEAN COMMENT 'Indicates whether revenue payments for this division order are currently held in suspense due to title defects, missing owner information, or legal disputes. True when payments are suspended, false when payments are being distributed normally.',
    `suspense_reason` STRING COMMENT 'The business reason why revenue payments are held in suspense. Title Defect indicates unresolved ownership issues. Missing Tax ID indicates required tax documentation not provided. Address Unknown indicates inability to locate owner. Legal Dispute indicates litigation affecting ownership. Probate Pending indicates estate settlement in progress. Bankruptcy indicates owner in bankruptcy proceedings. [ENUM-REF-CANDIDATE: Title Defect|Missing Tax ID|Address Unknown|Legal Dispute|Probate Pending|Bankruptcy|Other — 7 candidates stripped; promote to reference product]',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'The percentage rate at which federal or state income tax is withheld from revenue payments. Expressed as a decimal (e.g., 0.24 for 24% withholding). Applied for non-resident owners or when required by tax regulations.',
    `termination_date` DATE COMMENT 'The date on which this division order ceases to be effective. Nullable for active, ongoing division orders. Populated when ownership changes, lease expires, or well is plugged and abandoned.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this division order record. Used for audit trail and accountability.',
    CONSTRAINT pk_division_order PRIMARY KEY(`division_order_id`)
) COMMENT 'Authoritative document establishing the decimal interest each owner holds in production from a specific well or lease for revenue distribution purposes. Captures well/lease reference, owner reference, interest type (WI, NRI, ORRI, royalty), decimal interest fraction, effective date, termination date, division order status (active, suspended, pending title), and title opinion reference. Division orders are the legal basis for all royalty and working interest payments. Integrates with Quorum Land System division order module.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`land_working_interest` (
    `land_working_interest_id` BIGINT COMMENT 'Unique identifier for the working interest record. Primary key for the working interest master data.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Working interest records reference the governing JOA for cost allocation, voting rights, and non-consent provisions. Joa_id links interest ownership to the operating agreement framework.',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Working interests can be defined at the pooling unit level (unitized interests) in addition to lease-level or well-level WI. When a lease is pooled into a unit, the WI is often redefined at the unit l',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the party (operator or non-operator partner) who holds this working interest. Links to the joint venture partner or operator master record.',
    `assignment_date` DATE COMMENT 'The date on which this working interest was assigned or transferred to the current owner. Used for chain-of-title tracking.',
    `assignment_document_reference` STRING COMMENT 'Reference number or identifier for the legal document that created or transferred this working interest. Used for title opinion and chain-of-title verification.',
    `assignment_instrument_type` STRING COMMENT 'The type of legal instrument by which this working interest was created or transferred. Deed = mineral deed, Assignment = assignment of interest, Farmout = farmout agreement, Lease = oil and gas lease, PSA = Production Sharing Agreement, JOA = Joint Operating Agreement.. Valid values are `deed|assignment|farmout|lease|PSA|JOA`',
    `comments` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this working interest. Used for operational context and exception handling.',
    `conversion_trigger` STRING COMMENT 'The condition that triggers conversion of this interest to another type, if applicable. Payout = converts after payout, Time-Based = converts after a specified date, Production-Based = converts after cumulative production threshold, Event-Based = converts upon a specific event.. Valid values are `payout|time-based|production-based|event-based`',
    `convertible_flag` BOOLEAN COMMENT 'Indicates whether this interest is convertible to another interest type (e.g., ORRI converts to WI after payout). True = convertible, False = not convertible.',
    `cost_allocation_method` STRING COMMENT 'The method by which costs are allocated to this working interest. Proportionate = costs allocated by WI decimal, Non-Consent = non-consenting party penalty provisions apply, Penalty = penalty interest rate applies, Carried = costs borne by another party.. Valid values are `proportionate|non-consent|penalty|carried`',
    `created_date` DATE COMMENT 'The date on which this working interest record was first created in the system. Used for audit trail and data lineage tracking.',
    `division_order_flag` BOOLEAN COMMENT 'Indicates whether this working interest is subject to division order processing for revenue distribution. True = division order applies, False = not subject to division order.',
    `effective_date` DATE COMMENT 'The date on which this working interest ownership becomes effective. Used for revenue and cost allocation calculations.',
    `expiration_date` DATE COMMENT 'The date on which this working interest ownership expires or terminates, if applicable. Null for indefinite interests.',
    `interest_number` STRING COMMENT 'Business identifier or reference number assigned to this working interest for tracking and reporting purposes. May be system-generated or externally assigned.',
    `interest_type` STRING COMMENT 'Classification of the ownership interest type. WI = Working Interest (cost-bearing), ORRI = Overriding Royalty Interest (non-cost-bearing), NRI = Net Revenue Interest, RI = Royalty Interest, COPAS = COPAS-defined interest category.. Valid values are `WI|ORRI|NRI|RI|COPAS`',
    `jib_billing_code` STRING COMMENT 'The billing code used for Joint Interest Billing (JIB) cost allocation and invoicing for this working interest. Aligns with COPAS JIB standards.',
    `land_working_interest_status` STRING COMMENT 'Current lifecycle status of the working interest record. Active = currently in effect, Inactive = not currently in effect, Suspended = temporarily suspended, Terminated = permanently ended, Pending = awaiting activation.. Valid values are `active|inactive|suspended|terminated|pending`',
    `last_modified_date` DATE COMMENT 'The date on which this working interest record was last modified in the system. Used for audit trail and change tracking.',
    `nri_decimal` DECIMAL(18,2) COMMENT 'The decimal fraction representing the net revenue interest after deducting royalties, overriding royalties, and other burdens from the working interest. Represents the owners share of revenue. Example: 0.1875 = 18.75% NRI.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether the interest owner is the designated operator of the lease or well. True = operator, False = non-operator partner.',
    `orri_decimal` DECIMAL(18,2) COMMENT 'The decimal fraction representing the overriding royalty interest, if applicable. ORRI is a non-cost-bearing interest carved from the working interest. Null if not applicable.',
    `participation_status` STRING COMMENT 'Indicates the owners participation status in operations and cost-bearing. Participating = actively bearing costs, Non-Participating = not bearing costs but retaining interest, Carried = costs borne by another party, Back-In = right to re-enter after payout, Farmed-Out = interest assigned to another party.. Valid values are `participating|non-participating|carried|back-in|farmed-out`',
    `payout_date` DATE COMMENT 'The date on which payout was achieved for this working interest, if applicable. Null if payout has not been reached or does not apply.',
    `payout_status` STRING COMMENT 'Indicates whether the working interest has reached payout (recovery of capital costs). Pre-Payout = costs not yet recovered, Post-Payout = costs recovered and interest may revert or change, Not-Applicable = payout provisions do not apply.. Valid values are `pre-payout|post-payout|not-applicable`',
    `revenue_allocation_method` STRING COMMENT 'The method by which revenue is allocated to this working interest. Proportionate = revenue allocated by NRI decimal, Net = net of royalties and burdens, Gross = gross production share, Payout-Based = allocation changes after payout.. Valid values are `proportionate|net|gross|payout-based`',
    `reversion_date` DATE COMMENT 'The date on which this working interest reverted or is scheduled to revert to another party, if applicable. Null if reversion has not occurred or does not apply.',
    `reversion_flag` BOOLEAN COMMENT 'Indicates whether this working interest is subject to reversion provisions (e.g., interest reverts to another party after payout or upon certain conditions). True = reversion applies, False = no reversion.',
    `reversion_trigger` STRING COMMENT 'The condition that triggers reversion of this working interest, if applicable. Payout = reverts after payout, Time-Based = reverts after a specified date, Production-Based = reverts after cumulative production threshold, Event-Based = reverts upon a specific event.. Valid values are `payout|time-based|production-based|event-based`',
    `royalty_decimal` DECIMAL(18,2) COMMENT 'The decimal fraction representing the landowner or mineral rights holder royalty interest burden on this working interest. Null if not applicable.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this working interest record originated (e.g., Quorum Land System, SAP JV Accounting). Used for data lineage and reconciliation.',
    `suspense_flag` BOOLEAN COMMENT 'Indicates whether revenue payments for this working interest are currently held in suspense due to title issues, missing documentation, or other administrative holds. True = in suspense, False = not in suspense.',
    `suspense_reason` STRING COMMENT 'Free-text description of the reason revenue payments are held in suspense for this working interest, if applicable. Null if not in suspense.',
    `termination_condition` STRING COMMENT 'Free-text description of the conditions under which this working interest terminates, if applicable. May reference payout, production thresholds, time limits, or other contractual provisions.',
    `title_opinion_reference` STRING COMMENT 'Reference number or identifier for the title opinion document that validates the chain-of-title for this working interest. Used for legal and compliance verification.',
    `title_status` STRING COMMENT 'The current status of the title for this working interest. Clear = title is clear and marketable, Defective = title defects identified, Curative-Pending = curative work in progress, Disputed = title is under dispute.. Valid values are `clear|defective|curative-pending|disputed`',
    `wi_decimal` DECIMAL(18,2) COMMENT 'The decimal fraction representing the working interest ownership percentage. Represents the proportionate share of costs and gross production the owner is obligated to bear. Example: 0.25 = 25% WI.',
    CONSTRAINT pk_land_working_interest PRIMARY KEY(`land_working_interest_id`)
) COMMENT 'Master record tracking ownership interests in a lease or well, including working interest (WI), overriding royalty interest (ORRI), and other non-royalty interests. For WI: captures the obligation to bear a proportionate share of exploration, development, and operating costs, WI owner (operator or non-operator), WI decimal fraction, NRI decimal fraction. For ORRI: captures non-cost-bearing interests carved from the working interest entitling the holder to a fraction of gross production revenue, ORRI holder, creation instrument, termination conditions (convertible, payout-based). Common attributes: interest type, decimal fraction, lease reference, well reference, effective date, assignment history reference, participation status, and current status. Supports JIB billing, AFE cost allocation, and interest chain-of-title tracking. Integrates with Quorum Land System.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`title_opinion` (
    `title_opinion_id` BIGINT COMMENT 'Unique identifier for the title opinion record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Title opinions are AFE-funded curative/due diligence expenses. Standard land department cost allocation for pre-drill title work. Links legal review costs to capital project budgets.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Title opinions support regulatory filings for lease acquisitions, assignments, and pooling units. Required documentation for regulatory approval processes and compliance with state title requirements.',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement for which this title opinion was prepared.',
    `employee_id` BIGINT COMMENT 'Reference to the landman or land professional assigned to manage curative actions and follow-up for this title opinion.',
    `tertiary_title_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved the title opinion for operational use, typically a senior landman or land manager.',
    `tract_id` BIGINT COMMENT 'Reference to the specific tract or land parcel covered by this title opinion.',
    `approval_date` DATE COMMENT 'Date on which the title opinion was approved for operational use by the internal land department.',
    `approval_status` STRING COMMENT 'Current approval status of the title opinion within the internal review workflow. Draft indicates work in progress; submitted indicates under review; approved indicates accepted for operations; rejected indicates not acceptable; revision_required indicates attorney must revise.. Valid values are `draft|submitted|approved|rejected|revision_required`',
    `attorney_name` STRING COMMENT 'Full name of the attorney who prepared and signed the title opinion.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the jurisdiction in which the tract or lease is located. Used for international operations and regulatory compliance. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|ARG|GBR|NOR|SAU|ARE|QAT|KWT|IRQ|NGA|AGO|RUS|KAZ|AUS|CHN|IND|IDN|MYS|VNM — 22 candidates stripped; promote to reference product]',
    `county` STRING COMMENT 'County in which the tract or lease covered by this title opinion is located. Used for jurisdictional and recording purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this title opinion record was first created in the system. Used for audit trail and data lineage.',
    `curative_actions_count` STRING COMMENT 'Number of curative action items identified and tracked for this title opinion. Links to detail records in the curative action tracking system.',
    `curative_completion_date` DATE COMMENT 'Date on which all required curative actions were completed and marketable title was achieved. Null if curative work is still in progress or not required.',
    `curative_required_flag` BOOLEAN COMMENT 'Indicates whether curative action is required to achieve marketable title. True if curative work is needed; False if title is already marketable or defective beyond cure.',
    `depth_from_feet` DECIMAL(18,2) COMMENT 'Starting depth in feet for which the title opinion applies. Used when mineral rights are stratified by depth.',
    `depth_to_feet` DECIMAL(18,2) COMMENT 'Ending depth in feet for which the title opinion applies. Used when mineral rights are stratified by depth. Null indicates unlimited depth.',
    `exceptions_summary` STRING COMMENT 'Summary of exceptions, reservations, and encumbrances identified in the title opinion that may affect the mineral rights or operations.',
    `formation_limitation` STRING COMMENT 'Specific geological formation or formations to which the mineral rights and title opinion are limited, if applicable.',
    `gross_acres` DECIMAL(18,2) COMMENT 'Total acreage covered by the title opinion, regardless of ownership percentage.',
    `law_firm_name` STRING COMMENT 'Name of the law firm or legal entity that issued the title opinion.',
    `legal_description` STRING COMMENT 'Full legal description of the land covered by the title opinion, including metes and bounds, lot and block, or government survey description.',
    `marketable_title_date` DATE COMMENT 'Date on which the title was determined to be marketable, either initially or after curative work. Used for drilling authorization and division order preparation.',
    `net_acres` DECIMAL(18,2) COMMENT 'Net acreage owned after applying the working interest decimal to the gross acres. Represents the effective acreage ownership.',
    `net_revenue_interest_decimal` DECIMAL(18,2) COMMENT 'Decimal representation of the net revenue interest (NRI) percentage determined by the title opinion. Represents the ownership share in production revenue after royalties and overriding royalties.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the title opinion, curative work, or operational considerations.',
    `opinion_cost_amount` DECIMAL(18,2) COMMENT 'Total cost paid to the law firm or attorney for preparing the title opinion. Used for lease operating expense (LOE) and authorization for expenditure (AFE) tracking.',
    `opinion_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the opinion cost amount. [ENUM-REF-CANDIDATE: USD|CAD|MXN|BRL|GBP|EUR|NOK|SAR|AED|QAR|KWD|IQD|NGN|AOA|RUB|KZT|AUD|CNY|INR|IDR|MYR|VND — 22 candidates stripped; promote to reference product]',
    `opinion_date` DATE COMMENT 'Date on which the title opinion was issued by the attorney or landman. Represents the effective date of the legal assessment.',
    `opinion_number` STRING COMMENT 'Business identifier for the title opinion, typically assigned by the law firm or land department. Used for external reference and filing.',
    `opinion_type` STRING COMMENT 'Type or purpose of the title opinion. Drilling opinions are required before drilling operations; division order opinions support revenue distribution; acquisition opinions support lease purchases; supplemental opinions address specific issues; update opinions refresh prior opinions.. Valid values are `drilling|division_order|acquisition|supplemental|update`',
    `orri_burden_decimal` DECIMAL(18,2) COMMENT 'Decimal representation of the overriding royalty interest (ORRI) burden identified in the title opinion. ORRI is carved out of the working interest and does not bear operating costs.',
    `prior_conveyances_reviewed` STRING COMMENT 'Description of the chain of title and prior conveyances that were examined as part of the title opinion process.',
    `reservations_summary` STRING COMMENT 'Summary of reservations by prior owners that affect the current mineral interest, such as overriding royalty interests (ORRI) or production payments.',
    `royalty_burden_decimal` DECIMAL(18,2) COMMENT 'Decimal representation of the total royalty burden identified in the title opinion, including lessor royalties and overriding royalty interests (ORRI).',
    `state_province` STRING COMMENT 'State or province in which the tract or lease covered by this title opinion is located. Used for jurisdictional and regulatory purposes.',
    `title_defects_count` STRING COMMENT 'Number of title defects identified in the opinion that require curative action or that render the title unmarketable.',
    `title_examination_period_from` DATE COMMENT 'Starting date of the period covered by the title examination. Typically goes back to the original land patent or a specified number of years.',
    `title_examination_period_to` DATE COMMENT 'Ending date of the period covered by the title examination, typically the opinion date or the date of the most recent recorded instrument.',
    `title_status` STRING COMMENT 'Current status of the title as determined by the opinion. Marketable indicates clear title; defective indicates issues that prevent drilling; curative_required indicates issues that can be resolved; pending_review indicates opinion is under review; rejected indicates title cannot be cured.. Valid values are `marketable|defective|curative_required|pending_review|rejected`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this title opinion record was last modified. Used for audit trail and change tracking.',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'Decimal representation of the working interest (WI) percentage determined by the title opinion. Represents the ownership share in the lease for operational and cost-bearing purposes.',
    CONSTRAINT pk_title_opinion PRIMARY KEY(`title_opinion_id`)
) COMMENT 'Legal document prepared by an attorney or landman providing an opinion on the validity of title to mineral rights for a specific tract or lease. Captures opinion date, attorney/firm, title status (marketable, defective, curative required), depth limitations, exceptions and reservations, prior conveyances reviewed, and associated lease or tract. Includes curative action tracking as detail records: curative type (missing heir affidavit, probate, correction deed, ratification, release of lien), assigned landman, due date, completion date, curative status, and resolution notes. Title opinions are required before drilling and for division order preparation. The integrated curative workflow ensures marketable title before significant capital is committed.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_acquisition` (
    `lease_acquisition_id` BIGINT COMMENT 'Unique identifier for the lease acquisition transaction. Primary key for the lease acquisition record.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Lease acquisitions are AFE line items (bonus, broker fees). Existing afe_number is denormalized; replace with FK to afe_budget for proper cost tracking and capital project linkage.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Landmen and lease brokers are vendors providing acquisition services. Real procurement relationship for professional services. Role-prefixed to distinguish from lessor (not a vendor).',
    `contractor_id` BIGINT COMMENT 'Reference to the external broker or intermediary who facilitated the lease acquisition, if applicable. Null for direct acquisitions.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Lease acquisitions target specific crude grades based on basin geology and expected API gravity/sulfur content. Acquisition economics depend on crude quality expectations. Business process: economic m',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Lease acquisitions are capital projects requiring AFE authorization for budget control and JIB billing. The existing afe_number string should be replaced with proper FK to finance_afe for cost trackin',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Lease acquisitions often occur within existing JOA frameworks. Joa_id tracks the governing agreement, enabling AFE allocation, partner consent tracking, and cost recovery under the JOA.',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease that was acquired through this transaction. Links to the master lease record.',
    `party_id` BIGINT COMMENT 'Reference to the lessor party record in the land system. Links to the mineral rights owner master data.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Lease acquisitions often require regulatory approval permits, especially on federal and tribal lands. Essential for tracking permit requirements during acquisition planning and ensuring compliance bef',
    `employee_id` BIGINT COMMENT 'Reference to the landman or land agent who negotiated and executed the lease acquisition. Links to employee or contractor record.',
    `prospect_id` BIGINT COMMENT 'Reference to the exploration prospect or play that drove this lease acquisition. Links acquisition activity to upstream exploration strategy.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Lease acquisitions target specific tracts (land parcels). The acquisition record has county_name, state_code, gross_acres, net_acres that duplicate tract attributes. Adding tract_id FK normalizes thes',
    `acquisition_date` DATE COMMENT 'Date when the lease acquisition was executed and the lease rights were transferred to the company. Principal business event timestamp for this transaction.',
    `acquisition_number` STRING COMMENT 'Business identifier for the lease acquisition transaction. Externally-known reference number used in land department workflows and AFE tracking.',
    `acquisition_status` STRING COMMENT 'Current lifecycle status of the lease acquisition transaction. Tracks progression from initial prospect identification through final recording.. Valid values are `prospect|negotiation|executed|recorded|cancelled|expired`',
    `acquisition_type` STRING COMMENT 'Classification of the lease acquisition transaction type. Distinguishes between new lease acquisitions, extensions, renewals, assignments, and other acquisition methods.. Valid values are `new_lease|lease_extension|lease_renewal|assignment|farmout|top_lease`',
    `basin_name` STRING COMMENT 'Name of the geologic basin or play where the lease is located. Links acquisition activity to exploration and production strategy by basin.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Total bid amount submitted for competitive lease acquisitions. Null for non-competitive direct negotiations.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Total upfront bonus payment made to the lessor for acquiring the lease rights. One-time payment at lease execution, typically expressed in total dollars.',
    `bonus_per_acre` DECIMAL(18,2) COMMENT 'Bonus payment amount per gross acre. Key metric for evaluating acquisition cost competitiveness and land department performance.',
    `broker_commission_amount` DECIMAL(18,2) COMMENT 'Commission paid to external broker for facilitating the lease acquisition. Null for direct acquisitions without broker involvement.',
    `competitive_bid_flag` BOOLEAN COMMENT 'Indicates whether the lease was acquired through a competitive bidding process (true) or through direct negotiation (false). Relevant for federal and state lease sales.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease acquisition record was first created in the land system. Audit trail for data lineage and record creation tracking.',
    `delay_rental_amount` DECIMAL(18,2) COMMENT 'Annual delay rental payment amount required to maintain the lease during the primary term without drilling. May be per-acre or total amount.',
    `depth_rights_from_ft` STRING COMMENT 'Minimum depth in feet below surface for which mineral rights were acquired. Defines the top of the depth interval covered by the lease.',
    `depth_rights_to_ft` STRING COMMENT 'Maximum depth in feet below surface for which mineral rights were acquired. Defines the bottom of the depth interval covered by the lease. Null indicates rights to all depths.',
    `execution_date` DATE COMMENT 'Date when the lease agreement was signed by all parties. Distinct from acquisition date, which may be the effective date specified in the lease.',
    `formation_target` STRING COMMENT 'Primary geologic formation or reservoir target for the lease acquisition. Identifies the stratigraphic interval of interest for exploration and development.',
    `lease_expiry_date` DATE COMMENT 'Date when the lease primary term expires if production has not commenced. Critical date for lease expiry management and drilling obligation tracking.',
    `negotiation_start_date` DATE COMMENT 'Date when lease acquisition negotiations commenced with the lessor. Tracks the duration of the acquisition workflow from initial contact to execution.',
    `net_revenue_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest acquired in the lease. Represents the companys share of production revenue after royalty and overriding royalty deductions.',
    `notes` STRING COMMENT 'Free-text notes capturing additional details about the lease acquisition, including special terms, negotiation history, or unique conditions.',
    `primary_term_years` STRING COMMENT 'Duration of the lease primary term in years. Period during which the lease remains valid without production, typically 3-5 years for oil and gas leases.',
    `pugh_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease contains a Pugh clause that releases unproductive acreage at the end of the primary term. Important for lease retention and acreage management.',
    `recording_date` DATE COMMENT 'Date when the lease was officially recorded in the county or parish land records. Establishes legal priority and public notice.',
    `recording_reference` STRING COMMENT 'Official recording reference number or book and page citation from the county land records. Enables retrieval of the recorded lease document.',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of production revenue reserved for the lessor as royalty. Standard royalty burden negotiated in the lease agreement.',
    `surface_use_agreement_flag` BOOLEAN COMMENT 'Indicates whether a separate surface use agreement was negotiated with the surface owner. Relevant when mineral and surface rights are severed.',
    `title_opinion_date` DATE COMMENT 'Date when the title opinion was issued certifying the lessors ownership of mineral rights. Critical for validating lease enforceability.',
    `total_acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost of the lease acquisition including bonus payment, broker fees, legal fees, title work, and other acquisition-related expenses. Full CAPEX amount for financial reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease acquisition record was last modified. Audit trail for data lineage and change tracking.',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of working interest acquired in the lease. Represents the companys share of costs and production before royalty deductions.',
    CONSTRAINT pk_lease_acquisition PRIMARY KEY(`lease_acquisition_id`)
) COMMENT 'Transactional record capturing the business event of acquiring a new oil and gas lease, including negotiation details, bonus payment amount, per-acre bonus rate, broker/landman reference, acquisition date, prospect or play association, competitive bid status, and acquisition cost authorization. Tracks the full acquisition workflow from prospect identification through lease execution and recording. Supports CAPEX tracking for lease acquisition costs, acreage position building, and land department performance metrics.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_expiry` (
    `lease_expiry_id` BIGINT COMMENT 'Unique identifier for the lease expiry event record.',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement that is subject to expiry tracking.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well that is holding the lease by production. Null if lease is not HBP or if multiple wells hold the lease.',
    `acreage_at_risk` DECIMAL(18,2) COMMENT 'The total acreage (gross or net) that is at risk of being lost if the lease expires without renewal, extension, or HBP confirmation.',
    `alert_notification_date` DATE COMMENT 'The date on which an automated alert notification was sent to stakeholders regarding the upcoming lease expiry.',
    `alert_notification_recipient` STRING COMMENT 'The email address or user identifier of the recipient(s) who received the expiry alert notification.',
    `continuous_drilling_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease contains a continuous drilling clause requiring ongoing drilling activity to maintain the lease.',
    `continuous_drilling_deadline` DATE COMMENT 'The deadline by which the next well must be spudded to satisfy the continuous drilling clause requirements. Null if no continuous drilling clause applies.',
    `delay_rental_amount` DECIMAL(18,2) COMMENT 'The monetary amount of delay rental payment required per acre or per lease to extend the primary term.',
    `delay_rental_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the delay rental amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `delay_rental_due_date` DATE COMMENT 'The date by which delay rental payment must be made to extend the lease for another year during the primary term.',
    `estimated_reserves_at_risk_boe` DECIMAL(18,2) COMMENT 'The estimated proved or probable reserves (in barrels of oil equivalent) that could be lost if the lease expires without being held by production or extended.',
    `expiry_action_date` DATE COMMENT 'The date on which the expiry action was taken or is scheduled to be taken.',
    `expiry_action_responsible_party` STRING COMMENT 'The name or identifier of the land professional or team responsible for managing the expiry action.',
    `expiry_action_taken` STRING COMMENT 'The action taken or planned in response to the lease expiry event: renewed (new lease executed), released (lease terminated), extended (option exercised), HBP confirmed (held by production), under review, or pending decision.. Valid values are `renewed|released|extended|hbp_confirmed|under_review|pending_decision`',
    `expiry_event_type` STRING COMMENT 'Classification of the type of expiry event being tracked: primary term expiration, extension period expiration, option deadline, continuous drilling clause deadline, or Pugh clause partial release.. Valid values are `primary_term_expiry|extension_expiry|option_expiry|continuous_drilling_deadline|pugh_clause_partial_release`',
    `expiry_notes` STRING COMMENT 'Free-text notes capturing additional context, decisions, or special circumstances related to the lease expiry event.',
    `extension_expiry_date` DATE COMMENT 'The date on which an extension period expires if an extension option has been exercised. Null if no extension is in effect.',
    `extension_option_available_flag` BOOLEAN COMMENT 'Indicates whether the lessee has an option to extend the lease term beyond the primary term expiry.',
    `extension_option_exercise_deadline` DATE COMMENT 'The deadline by which the lessee must exercise the extension option to extend the lease term. Null if no extension option exists.',
    `extension_option_payment_amount` DECIMAL(18,2) COMMENT 'The payment amount required to exercise the extension option, typically expressed per acre or as a lump sum.',
    `extension_option_term_years` STRING COMMENT 'The number of years by which the lease can be extended if the extension option is exercised. Null if no extension option exists.',
    `hbp_status` STRING COMMENT 'Indicates whether the lease is currently held by production, meaning it has producing wells that keep the lease valid beyond the primary term.. Valid values are `not_hbp|hbp_confirmed|hbp_pending_verification|hbp_disputed`',
    `hbp_verification_date` DATE COMMENT 'The date on which HBP status was last verified through production records or well test data.',
    `hbp_well_api_number` STRING COMMENT 'The API well number of the well holding the lease by production, providing a standardized well identifier.',
    `lease_bonus_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the lease bonus amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `lease_bonus_paid` DECIMAL(18,2) COMMENT 'The total lease bonus amount paid at lease acquisition, representing the sunk cost at risk if the lease is allowed to expire.',
    `net_revenue_interest_at_risk` DECIMAL(18,2) COMMENT 'The net revenue interest percentage that is at risk of being lost if the lease expires, expressed as a decimal (e.g., 0.75 for 75%).',
    `primary_term_expiry_date` DATE COMMENT 'The date on which the primary term of the lease expires, after which the lease must be held by production or extended to remain valid.',
    `pugh_clause_flag` BOOLEAN COMMENT 'Indicates whether the lease contains a Pugh clause that allows partial release of non-producing acreage at the end of the primary term.',
    `pugh_clause_release_date` DATE COMMENT 'The date on which non-producing acreage is scheduled to be released under the Pugh clause provisions. Null if no Pugh clause or no release pending.',
    `pugh_clause_type` STRING COMMENT 'Specifies the type of Pugh clause: horizontal (acreage-based), vertical (depth-based), both, or none if no Pugh clause exists.. Valid values are `horizontal|vertical|both|none`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lease expiry record was first created in the system.',
    `record_status` STRING COMMENT 'The current lifecycle status of this expiry tracking record: active (monitoring ongoing), resolved (action completed), cancelled (no longer applicable), or archived (historical record).. Valid values are `active|resolved|cancelled|archived`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this lease expiry record was last updated in the system.',
    `regulatory_filing_date` DATE COMMENT 'The date on which the required regulatory filing was submitted or is scheduled to be submitted. Null if no filing is required.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether a regulatory filing or notification is required with state or federal agencies upon lease expiry or release.',
    `working_interest_at_risk` DECIMAL(18,2) COMMENT 'The working interest percentage that is at risk of being lost if the lease expires, expressed as a decimal (e.g., 0.875 for 87.5%).',
    CONSTRAINT pk_lease_expiry PRIMARY KEY(`lease_expiry_id`)
) COMMENT 'Tracks lease expiration events, extension actions, and held-by-production (HBP) status for all active leases. Captures primary term expiration date, extension option terms, delay rental due dates, rental amounts, HBP well references, continuous drilling clause requirements, Pugh clause applicability, and expiry action taken (renewed, released, extended, HBP confirmed). Critical for acreage management and avoiding inadvertent lease expirations. Supports automated expiry alert workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`delay_rental` (
    `delay_rental_id` BIGINT COMMENT 'Unique identifier for the delay rental payment transaction. Primary key for the delay rental record.',
    `company_code_id` BIGINT COMMENT 'Reference to the operating company responsible for making the delay rental payment on behalf of working interest owners.',
    `employee_id` BIGINT COMMENT 'The user identifier of the person who approved the delay rental payment for processing. Used for audit trail and SOX compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Delay rental payments must be coded to specific GL accounts for expense recognition, lease maintenance cost tracking, and JIB billing to working interest partners. Required for financial statement pre',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease agreement for which this delay rental payment is made. Links to the lease master record.',
    `tax_entity_id` BIGINT COMMENT 'The tax identification number (TIN or EIN) of the payee for IRS 1099 reporting and tax compliance purposes.',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the mineral rights owner or lessor who receives the delay rental payment. Links to the party master record.',
    `acreage_covered` DECIMAL(18,2) COMMENT 'The total number of acres covered by this delay rental payment. May differ from total lease acreage if partial acreage is being held.',
    `afe_number` STRING COMMENT 'The AFE number under which this delay rental payment is authorized and budgeted. Links the payment to capital or operating budget approval.',
    `approval_date` DATE COMMENT 'The date on which the delay rental payment was approved for processing by the authorized approver or land department.',
    `cost_center_code` STRING COMMENT 'The accounting cost center or business unit code to which this delay rental expense is charged for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delay rental payment record was first created in the system. Used for audit trail and data lineage.',
    `drilling_commenced_flag` BOOLEAN COMMENT 'Boolean indicator of whether drilling operations have commenced on the lease. Once drilling begins, delay rental obligations typically cease.',
    `grace_period_days` STRING COMMENT 'Number of days after the rental due date during which payment can still be made without lease termination, as specified in the lease agreement.',
    `jib_statement_number` STRING COMMENT 'The JIB statement number if this delay rental payment is being billed to non-operating working interest partners for their proportionate share.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delay rental payment record was last updated. Used for audit trail and change tracking.',
    `late_payment_penalty_amount` DECIMAL(18,2) COMMENT 'Additional penalty amount assessed for delay rental payments made after the due date, if specified in the lease agreement.',
    `lease_primary_term_flag` BOOLEAN COMMENT 'Boolean indicator of whether the lease is currently in its primary term. Delay rentals are only applicable during the primary term before drilling commences.',
    `lease_termination_risk_flag` BOOLEAN COMMENT 'Boolean indicator that the delay rental payment is overdue and the lease is at risk of automatic termination per lease terms.',
    `payee_name` STRING COMMENT 'The legal name of the lessor or designated payee receiving the delay rental payment. May differ from lessor if payment is assigned.',
    `payment_confirmation_status` STRING COMMENT 'Status indicating whether the payment has been successfully delivered and cleared with the lessor or financial institution.. Valid values are `confirmed|pending|failed|returned|cleared`',
    `payment_date` DATE COMMENT 'The actual date on which the delay rental payment was made or is scheduled to be made. Critical for determining lease continuation compliance.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to make the delay rental payment to the lessor.. Valid values are `check|wire_transfer|ach|draft|escrow|suspense`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments regarding the delay rental payment, including special circumstances, disputes, or payment arrangements.',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment system (check number, wire confirmation, ACH trace number) that confirms the payment transaction.',
    `rental_amount` DECIMAL(18,2) COMMENT 'The total monetary amount of the delay rental payment due to the lessor. Typically calculated as dollars per acre per year as specified in the lease agreement.',
    `rental_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the delay rental payment amount. Typically USD for United States operations. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|MXN|BRL|AUD — 7 candidates stripped; promote to reference product]',
    `rental_due_date` DATE COMMENT 'The contractual date by which the delay rental payment must be made to maintain the lease in force. Missing this date can result in automatic lease termination per lease terms.',
    `rental_payment_number` STRING COMMENT 'Business identifier for the delay rental payment transaction. Used for external reference and tracking in accounts payable systems.',
    `rental_period_end_date` DATE COMMENT 'The ending date of the lease period covered by this delay rental payment. Defines the coverage window for the rental obligation.',
    `rental_period_start_date` DATE COMMENT 'The beginning date of the lease period covered by this delay rental payment. Typically aligns with the lease anniversary date.',
    `rental_rate_per_acre` DECIMAL(18,2) COMMENT 'The contractual delay rental rate per acre as specified in the lease agreement. Used to calculate the total rental amount based on leased acreage.',
    `rental_status` STRING COMMENT 'Current lifecycle status of the delay rental payment. Tracks whether the payment obligation has been fulfilled, is pending, or has issues.. Valid values are `pending|paid|overdue|cancelled|waived|disputed`',
    `source_system_code` STRING COMMENT 'Identifier of the operational system from which this delay rental record originated (e.g., Quorum Land System, SAP, custom land management system).',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'The working interest ownership percentage (expressed as decimal) responsible for this delay rental payment. Used when multiple working interest owners share rental obligations.',
    CONSTRAINT pk_delay_rental PRIMARY KEY(`delay_rental_id`)
) COMMENT 'Transactional record for delay rental payments made to lessors to maintain a lease in force during the primary term before drilling commences. Captures rental due date, rental amount, payment date, payment method, lessor payee, lease reference, rental period covered, and payment confirmation status. Delay rentals are a contractual obligation — missed payments can result in lease termination. Integrates with accounts payable for payment processing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` (
    `surface_use_agreement_id` BIGINT COMMENT 'Unique identifier for the surface use agreement record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Surface damages and easement compensation are AFE costs charged to drilling/facility projects. Standard upstream cost allocation for surface rights acquisition tied to capital budgets.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Surface agreements are formalized as procurement contracts with landowners for access/damages. Links land rights to contract management system for payment terms, insurance, and compliance tracking.',
    `grantor_id` BIGINT COMMENT 'FK to land.party',
    `grantor_party_id` BIGINT COMMENT 'FK to land.party',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Surface use agreements are negotiated in conjunction with leases to secure surface access for drilling and production operations. While SUA already has tract_id, adding lease_id links the surface agre',
    `party_id` BIGINT COMMENT 'FK to land.party',
    `tract_id` BIGINT COMMENT 'Foreign key reference to the surface tract or parcel covered by this agreement. Links to the land tract master record.',
    `access_restrictions` STRING COMMENT 'Specific restrictions on access timing, methods, or conditions, such as seasonal restrictions, notification requirements, or limitations on heavy equipment use.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the surface use agreement or right-of-way easement. Format: SUA-NNNNNN for surface use agreements, ROW-NNNNNN for right-of-way easements.. Valid values are `^SUA-[0-9]{6,10}$|^ROW-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the surface use agreement. Draft: under negotiation; Pending Approval: awaiting internal or regulatory approval; Active: in force; Suspended: temporarily inactive; Terminated: ended by mutual agreement; Expired: term ended; Cancelled: voided before execution. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the surface access agreement. Surface Use Agreement (SUA) covers drilling and facility operations; Pipeline ROW, Road ROW, and Utility ROW cover linear easements; Access Easement covers general access rights; Temporary Workspace covers short-term construction areas.. Valid values are `surface_use_agreement|pipeline_row|road_row|utility_row|access_easement|temporary_workspace`',
    `annual_rental_amount` DECIMAL(18,2) COMMENT 'Annual recurring rental payment to the grantor. Applicable when compensation type is annual rental. Null for one-time or per-rod compensation.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Total monetary compensation amount paid or payable to the grantor under the agreement. For one-time payments, the lump sum; for annual rentals, the annual amount; for per-rod rates, the total calculated amount.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `compensation_type` STRING COMMENT 'Method by which the grantor is compensated for surface access. One-time payment: lump sum at signing; Annual rental: recurring annual fee; Per-rod rate: payment per linear rod of easement; Damage payment: compensation for crop or property damage; No compensation: granted without payment.. Valid values are `one_time_payment|annual_rental|per_rod_rate|damage_payment|no_compensation`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the jurisdiction of the surface tract (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish in which the surface tract is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this surface use agreement record was first created in the system.',
    `damage_payment_terms` STRING COMMENT 'Description of terms for compensating the grantor for crop damage, property damage, or loss of use during operations. May include per-acre rates, appraisal-based compensation, or fixed schedules.',
    `easement_length_ft` DECIMAL(18,2) COMMENT 'Length of the right-of-way easement corridor in feet. Applicable to pipeline ROW, road ROW, and utility ROW agreements. Null for surface use agreements without linear easement dimensions.',
    `easement_width_ft` DECIMAL(18,2) COMMENT 'Width of the right-of-way easement corridor in feet. Applicable to pipeline ROW, road ROW, and utility ROW agreements. Null for surface use agreements without linear easement dimensions.',
    `effective_date` DATE COMMENT 'Date on which the surface use agreement becomes legally binding and operational activities may commence.',
    `expiration_date` DATE COMMENT 'Date on which the surface use agreement term ends. Null for perpetual easements or agreements with no fixed term.',
    `hse_compliance_notes` STRING COMMENT 'Notes on Health, Safety, and Environment (HSE) compliance requirements specific to this agreement, such as spill prevention plans, noise restrictions, or environmental monitoring obligations.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum required liability insurance coverage amount in the agreement currency. Null if insurance is not required.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether the operator is required to maintain liability insurance covering surface activities under this agreement. True if insurance is required; False if not required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this surface use agreement record was last updated in the system.',
    `legal_description` STRING COMMENT 'Full legal land description of the surface area covered by the agreement, typically using metes and bounds, lot and block, or government survey system (section, township, range).',
    `notarized` BOOLEAN COMMENT 'Indicates whether the agreement has been notarized. True if notarized; False if not notarized. Notarization may be required for recording in county land records.',
    `operator_signature_date` DATE COMMENT 'Date on which the operator or company representative signed the agreement.',
    `per_rod_rate` DECIMAL(18,2) COMMENT 'Compensation rate per rod (16.5 feet) of linear easement. Applicable to pipeline and utility ROW agreements using per-rod pricing. Null if compensation type is not per-rod.',
    `permitted_activities` STRING COMMENT 'Detailed description of the activities authorized under the agreement, such as drilling operations, facility construction, pipeline installation, road construction, seismic surveys, or utility placement.',
    `reclamation_obligations` STRING COMMENT 'Detailed description of reclamation and restoration obligations, including topsoil replacement, reseeding, erosion control, removal of structures, and timeline for completion.',
    `reclamation_required` BOOLEAN COMMENT 'Indicates whether the operator is obligated to reclaim and restore the surface to its original or agreed-upon condition after operations cease. True if reclamation is required; False if not required or if easement is perpetual.',
    `recorded` BOOLEAN COMMENT 'Indicates whether the agreement has been recorded in the county land records or registry of deeds. True if recorded; False if not recorded.',
    `recording_date` DATE COMMENT 'Date on which the agreement was recorded in the county land records. Null if not yet recorded.',
    `recording_reference` STRING COMMENT 'County clerk or recorder reference number, book and page, or instrument number for the recorded agreement. Null if not recorded.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for any regulatory filing, permit, or approval associated with this surface use agreement, such as Bureau of Land Management (BLM) right-of-way grant number or state pipeline permit number.',
    `restricted_areas` STRING COMMENT 'Description of areas within the tract where access or activities are restricted or prohibited, such as residential zones, water sources, cultural sites, or environmentally sensitive areas.',
    `state_province` STRING COMMENT 'State or province in which the surface tract is located. Use two-letter abbreviation (e.g., TX, OK, AB).',
    `surface_owner_consent_date` DATE COMMENT 'Date on which the surface owner or grantor signed and consented to the agreement.',
    `term_type` STRING COMMENT 'Duration structure of the agreement. Fixed term: specific start and end dates; Perpetual: no expiration (common for pipeline ROW); As needed: temporary access for specific activities; Project duration: tied to the life of a specific project or well.. Valid values are `fixed_term|perpetual|as_needed|project_duration`',
    `total_acreage` DECIMAL(18,2) COMMENT 'Total surface acreage covered by the agreement. For linear easements, calculated from width and length. For surface use agreements, the total disturbed or leased acreage.',
    CONSTRAINT pk_surface_use_agreement PRIMARY KEY(`surface_use_agreement_id`)
) COMMENT 'Master record for all surface access agreements including surface use agreements (SUAs) and right-of-way (ROW) easements. For SUAs: covers agreements with surface owners to permit access for drilling, facility installation, and operations. For ROWs: covers pipeline, road, and utility easements granting passage across surface tracts. Common attributes: agreement type (SUA, pipeline ROW, road ROW, utility ROW), grantor/surface owner, tract reference, permitted activities, compensation terms (one-time payment, annual rental, damage payments, per-rod rate), term (fixed or perpetual), easement dimensions (width, length for ROW), reclamation obligations, restricted areas, regulatory filing reference, and agreement status. Distinct from mineral lease — surface rights and mineral rights may be severed. Required for regulatory permitting, HSE compliance, and pipeline operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_amendment` (
    `lease_amendment_id` BIGINT COMMENT 'Unique identifier for the lease amendment record. Primary key.',
    `party_id` BIGINT COMMENT 'Reference to the lessee (operator or working interest owner) party executing the amendment. Links to the party master for lessee information.',
    `lessor_party_id` BIGINT COMMENT 'Reference to the lessor (mineral rights owner) party executing the amendment. Links to the party master for lessor information.',
    `operator_party_id` BIGINT COMMENT 'Reference to the designated operator party after the amendment. May differ from lessee if operator assignment is modified. Links to the party master.',
    `lease_id` BIGINT COMMENT 'Reference to the original lease agreement being amended. Links to the parent lease record to maintain title chain integrity.',
    `superseded_by_amendment_lease_amendment_id` BIGINT COMMENT 'Reference to a later amendment that supersedes or replaces this amendment. Null if this amendment is current. Supports amendment history tracking.',
    `title_opinion_id` BIGINT COMMENT 'Reference to the title opinion that supports or validates this amendment. Links to the title opinion record for chain of title verification.',
    `amended_net_revenue_interest` DECIMAL(18,2) COMMENT 'New net revenue interest percentage established by the amendment, expressed as a decimal fraction (e.g., 0.60 for 60% NRI). Applicable when amendment modifies revenue interests. Null if NRI is not changed.',
    `amended_primary_term_months` STRING COMMENT 'New primary term duration in months established by the amendment. Applicable when amendment type is extension. Null if primary term is not changed.',
    `amended_royalty_rate` DECIMAL(18,2) COMMENT 'New royalty rate established by the amendment, expressed as a decimal fraction (e.g., 0.1875 for 18.75%). Applicable when amendment type is royalty modification. Null if royalty rate is not changed.',
    `amended_working_interest` DECIMAL(18,2) COMMENT 'New working interest percentage established by the amendment, expressed as a decimal fraction (e.g., 0.75 for 75% WI). Applicable when amendment modifies ownership interests. Null if WI is not changed.',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the amendment terms, changes, and business rationale. Captures the full scope of modifications for legal and operational reference.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, typically sequential (e.g., Amendment 1, Amendment 2) or following organizational numbering convention. Used for external reference and document tracking.',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment. Draft indicates preparation, pending approval awaits authorization, executed means signed by all parties, recorded indicates filing with county recorder, rejected means not approved, superseded means replaced by later amendment.. Valid values are `draft|pending_approval|executed|recorded|rejected|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the amendment action. Ratification confirms prior actions, royalty modification changes payment terms, depth severance splits rights by formation, acreage reduction releases portions (Pugh clause), extension extends lease term, pooling combines interests, unitization creates operating unit, assignment consent approves transfer, surface use modification changes land use terms. [ENUM-REF-CANDIDATE: ratification|royalty_modification|depth_severance|acreage_reduction|extension|pooling|unitization|assignment_consent|surface_use_modification|other — 10 candidates stripped; promote to reference product]',
    `approval_authority` STRING COMMENT 'Name or role of the internal authority who approved the amendment (e.g., Land Manager, VP Land, Legal Counsel). Used for governance and audit trail.',
    `approval_date` DATE COMMENT 'Date when the amendment was internally approved for execution. Supports governance and audit requirements.',
    `consideration_amount` DECIMAL(18,2) COMMENT 'Monetary consideration paid for the amendment, if applicable. Common for extensions, acreage releases, or depth severances. Expressed in USD.',
    `consideration_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the consideration amount (e.g., USD, CAD, GBP). Supports international operations and multi-currency lease portfolios.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the leased property is located (e.g., USA, CAN, MEX). Supports international lease portfolios.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County where the leased property is located. Used for recording jurisdiction and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Used for audit trail and data lineage.',
    `depth_from_feet` STRING COMMENT 'Starting depth in feet for depth severance amendments. Defines the top of the depth interval affected by the amendment. Null if not a depth severance.',
    `depth_to_feet` STRING COMMENT 'Ending depth in feet for depth severance amendments. Defines the bottom of the depth interval affected by the amendment. Null if not a depth severance.',
    `document_reference` STRING COMMENT 'Reference to the physical or electronic document storage location for the executed amendment (e.g., document management system ID, file path, SharePoint link).',
    `effective_date` DATE COMMENT 'Date when the amendment terms become legally binding and operational. May differ from execution date if amendment specifies retroactive or future effective date.',
    `execution_date` DATE COMMENT 'Date when the amendment was signed by all required parties. Establishes the legal execution timestamp for the modification.',
    `formation_name` STRING COMMENT 'Geological formation name affected by the amendment, applicable for depth severance or formation-specific modifications (e.g., Bakken, Permian, Marcellus).',
    `legal_description` STRING COMMENT 'Legal land description of the acreage affected by the amendment, using metes and bounds, lot and block, or government survey system (township, range, section). Required for recording and title purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified in the system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special conditions, or operational considerations related to the amendment. Used for internal reference and knowledge transfer.',
    `pooling_unit_acreage` DECIMAL(18,2) COMMENT 'Total acreage of the pooling or drilling unit established by this amendment. Expressed in gross acres.',
    `pooling_unit_name` STRING COMMENT 'Name or identifier of the pooling unit created or modified by this amendment. Applicable when amendment type is pooling or unitization.',
    `recording_date` DATE COMMENT 'Date when the amendment was filed with the county recorder or appropriate land records office. Establishes public notice and priority for title purposes.',
    `recording_reference` STRING COMMENT 'Official recording number, book and page, or instrument number assigned by the county recorder when the amendment is filed. Used for title research and chain of title verification.',
    `released_acreage` DECIMAL(18,2) COMMENT 'Number of acres released from the original lease by this amendment. Common in Pugh clause releases or partial terminations. Expressed in net mineral acres.',
    `retained_acreage` DECIMAL(18,2) COMMENT 'Number of acres retained under the lease after this amendment. Represents the remaining leased acreage post-release. Expressed in net mineral acres.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this amendment data originated (e.g., Quorum Land System, SAP, custom land management system). Supports data lineage and integration traceability.',
    `state_province` STRING COMMENT 'State or province where the leased property is located. Used for regulatory compliance and jurisdictional reporting.',
    CONSTRAINT pk_lease_amendment PRIMARY KEY(`lease_amendment_id`)
) COMMENT 'Transactional record capturing formal amendments to existing lease agreements, including ratifications, modifications to royalty rates, depth severances, acreage reductions (Pugh clause releases), extension agreements, and pooling amendments. Captures amendment type, effective date, original lease reference, changed terms, consideration paid, and execution status. Maintains the full amendment history for each lease to support title chain integrity and regulatory compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`pooling_unit` (
    `pooling_unit_id` BIGINT COMMENT 'Unique identifier for the pooling or unitization unit. Primary key.',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Pooling units are formed within basins for regulatory and operational purposes. Basin-level resource allocation, regulatory approval tracking, and reserves reporting require linking pooling units to t',
    `operator_id` BIGINT COMMENT 'Foreign key reference to the operator entity responsible for managing operations within the pooling unit.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pooling units require regulatory approval permits from state agencies. Core regulatory process for unitization, production allocation, and compliance with state conservation laws.',
    `allocation_method` STRING COMMENT 'Method used to allocate production and costs among participating tracts within the pooling unit: surface acreage (based on surface area), subsurface acreage (based on mineral ownership), productivity (based on well performance), well count (equal per well), or agreement-specified (custom formula in unit agreement).. Valid values are `surface_acreage|subsurface_acreage|productivity|well_count|agreement_specified`',
    `api_county_code` STRING COMMENT 'Five-digit API county code uniquely identifying the county location of the pooling unit (first two digits = state, last three = county).. Valid values are `^[0-9]{5}$`',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority officially approved the pooling unit formation.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational remarks related to the pooling unit that do not fit structured fields.',
    `county_name` STRING COMMENT 'Name of the county or parish where the pooling unit is located.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the pooling unit record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the pooling unit agreement becomes legally binding and operational activities may commence.',
    `estimated_ultimate_recovery_boe` DECIMAL(18,2) COMMENT 'Estimated total recoverable hydrocarbons from the pooling unit over its productive life, expressed in barrels of oil equivalent (BOE).',
    `expiration_date` DATE COMMENT 'Date on which the pooling unit agreement terminates unless extended or renewed by participating parties and regulatory approval.',
    `field_name` STRING COMMENT 'Name of the oil or gas field within which the pooling unit is situated, as designated by regulatory authorities.',
    `formation_name` STRING COMMENT 'Geological formation or reservoir that the pooling unit is designed to develop and produce from (e.g., Bakken, Marcellus, Permian).',
    `gross_unit_acres` DECIMAL(18,2) COMMENT 'Total surface acreage encompassed by the pooling unit boundaries, regardless of ownership or working interest.',
    `is_federal_land` BOOLEAN COMMENT 'Boolean flag indicating whether the pooling unit includes federal lands managed by Bureau of Land Management (BLM) or Bureau of Ocean Energy Management (BOEM), requiring additional regulatory compliance.',
    `is_tribal_land` BOOLEAN COMMENT 'Boolean flag indicating whether the pooling unit includes Native American tribal lands, requiring compliance with Bureau of Indian Affairs (BIA) regulations and tribal agreements.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the pooling unit record was most recently updated in the system.',
    `legal_description` STRING COMMENT 'Complete legal description of the pooling unit boundaries using Public Land Survey System (PLSS) notation (e.g., Section-Township-Range format).',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Companys net revenue interest percentage in the pooling unit, representing the share of production revenues after royalty and overriding royalty interest (ORRI) deductions.',
    `net_unit_acres` DECIMAL(18,2) COMMENT 'Companys net acreage position within the pooling unit after applying working interest (WI) percentages across all participating tracts.',
    `participating_tract_count` STRING COMMENT 'Number of individual land tracts or leases that have been pooled together to form this unit.',
    `payout_date` DATE COMMENT 'Date on which the pooling unit achieved payout, meaning all drilling and completion costs have been recovered from production revenues.',
    `payout_status` STRING COMMENT 'Indicates whether the pooling unit has reached payout (recovery of drilling and completion costs): pre-payout (costs not yet recovered), post-payout (costs recovered, revenue distribution changes), or not applicable (no payout provision in agreement).. Valid values are `pre_payout|post_payout|not_applicable`',
    `primary_product_type` STRING COMMENT 'Primary hydrocarbon product expected from the pooling unit: oil (crude oil), gas (natural gas), NGL (natural gas liquids), or condensate (light liquid hydrocarbons).. Valid values are `oil|gas|NGL|condensate`',
    `range` STRING COMMENT 'Range designation in PLSS format (e.g., R96W for Range 96 West).',
    `regulatory_agency` STRING COMMENT 'Name of the state or federal regulatory body that approved and oversees the pooling unit (e.g., Texas Railroad Commission, North Dakota Industrial Commission).',
    `regulatory_approval_number` STRING COMMENT 'Official approval or order number issued by the state regulatory commission authorizing the formation of the pooling unit.',
    `reserves_category` STRING COMMENT 'SPE PRMS reserves classification for the pooling unit: 1P (proved), 2P (proved plus probable), 3P (proved plus probable plus possible), PDP (proved developed producing), PDNP (proved developed non-producing), or PUD (proved undeveloped).. Valid values are `1P|2P|3P|PDP|PDNP|PUD`',
    `royalty_burden_percent` DECIMAL(18,2) COMMENT 'Total royalty burden percentage applicable to the pooling unit, representing the aggregate royalty obligations to mineral rights owners.',
    `section_number` STRING COMMENT 'Section number(s) within the Public Land Survey System (PLSS) grid that the pooling unit encompasses.',
    `state_code` STRING COMMENT 'Two-letter US state code where the pooling unit is geographically located (e.g., TX for Texas, ND for North Dakota).. Valid values are `^[A-Z]{2}$`',
    `township` STRING COMMENT 'Township designation in PLSS format (e.g., T154N for Township 154 North).',
    `unit_agreement_document_reference` STRING COMMENT 'Reference identifier or file path to the executed pooling or unitization agreement document stored in the document management system.',
    `unit_name` STRING COMMENT 'Official name of the pooling or unitization unit as registered with regulatory authorities.',
    `unit_number` STRING COMMENT 'Regulatory or internal identification number assigned to the pooling unit for tracking and reporting purposes.',
    `unit_status` STRING COMMENT 'Current lifecycle status of the pooling unit: proposed (application submitted), approved (regulatory approval received), active (unit operational), producing (wells producing), suspended (temporarily halted), inactive (no current operations), dissolved (unit terminated), or expired (agreement ended). [ENUM-REF-CANDIDATE: proposed|approved|active|producing|suspended|inactive|dissolved|expired — 8 candidates stripped; promote to reference product]',
    `unit_type` STRING COMMENT 'Classification of the pooling arrangement: voluntary (agreed by all parties), compulsory (forced by regulatory authority), communitization (combining federal and non-federal lands), unitization (reservoir-wide development), spacing unit (regulatory minimum acreage), or drilling unit (operational grouping).. Valid values are `voluntary|compulsory|communitization|unitization|spacing_unit|drilling_unit`',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Companys working interest percentage in the pooling unit, representing the share of costs and revenues before royalty deductions.',
    CONSTRAINT pk_pooling_unit PRIMARY KEY(`pooling_unit_id`)
) COMMENT 'Master record for a pooling or unitization unit combining multiple tracts or leases for the purpose of drilling a single well or developing a reservoir. Captures unit name, unit type (voluntary, compulsory, communitization), formation, gross unit acres, net unit acres, participating tracts, unit operator, regulatory approval reference, and unit agreement effective date. Pooling units are required for regulatory compliance in many states and affect royalty calculation and production allocation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` (
    `royalty_disbursement_id` BIGINT COMMENT 'Primary key for royalty_disbursement',
    `division_order_id` BIGINT COMMENT 'Reference to the division order that governs the decimal interest and revenue distribution for this payment.',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement from which the production revenue originated.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Royalty payments are product-specific with distinct volumes, pricing, severance taxes, and processing costs per product. Essential for 1099 reporting and detailed owner statements. Business process: m',
    `production_well_id` BIGINT COMMENT 'Reference to the producing well that generated the revenue for this royalty payment.',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the royalty owner receiving this disbursement payment.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Royalty payments to venture partners holding overriding royalty interests. Venture_partner_id enables partner-level payment tracking, tax reporting, and reconciliation with JIB statements.',
    `check_number` STRING COMMENT 'The check number if payment method is check. Null for electronic payment methods.. Valid values are `^[0-9]{6,12}$`',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this payment record. Typically USD for United States operations.. Valid values are `^[A-Z]{3}$`',
    `decimal_interest` DECIMAL(18,2) COMMENT 'The royalty owners proportional share of revenue from the lease, expressed as a decimal fraction. Derived from the division order and represents the owners Net Revenue Interest (NRI) for royalty purposes.',
    `escheat_date` DATE COMMENT 'The date the payment was or will be escheated to the state unclaimed property office. Null if payment has not been escheated.',
    `escheat_eligible_flag` BOOLEAN COMMENT 'Indicates whether this suspended payment is eligible for escheatment to state unclaimed property. True if payment has been in suspense beyond the state-mandated dormancy period. False otherwise.',
    `form_1099_reportable_flag` BOOLEAN COMMENT 'Indicates whether this payment is reportable on IRS Form 1099-MISC for the tax year. True if payment meets IRS reporting thresholds and owner is subject to 1099 reporting. False otherwise.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'The total revenue generated from the sale of production before any deductions, attributable to the royalty owners decimal interest.',
    `interest_paid_amount` DECIMAL(18,2) COMMENT 'The amount of interest paid to the royalty owner for late payment beyond the contractual due date, as required by state regulations.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'The annual interest rate percentage applied to calculate late payment interest, as mandated by state law or lease terms.',
    `marketing_cost_amount` DECIMAL(18,2) COMMENT 'Post-production costs for marketing and selling the product, deducted from gross revenue if the lease terms allow cost deductions.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'The revenue amount after all deductions, before applying the royalty owners decimal interest. Calculated as gross revenue minus total deductions.',
    `net_royalty_amount` DECIMAL(18,2) COMMENT 'The final royalty payment amount disbursed to the royalty owner, calculated as net revenue multiplied by decimal interest.',
    `other_deduction_amount` DECIMAL(18,2) COMMENT 'Miscellaneous deductions from gross revenue not categorized as taxes or post-production costs, such as adjustments or prior period corrections.',
    `payment_date` DATE COMMENT 'The date the royalty payment was disbursed or is scheduled to be disbursed to the royalty owner.',
    `payment_due_date` DATE COMMENT 'The contractual due date by which the royalty payment must be disbursed per lease terms, typically 90-120 days after production month end.',
    `payment_method` STRING COMMENT 'The method used to disburse the royalty payment to the owner. Check for paper check, ACH for Automated Clearing House transfer, wire for wire transfer, EFT for electronic funds transfer, direct deposit for bank account deposit.. Valid values are `check|ach|wire|eft|direct_deposit`',
    `payment_notes` STRING COMMENT 'Free-text notes providing additional context about the payment, such as adjustments, corrections, or special circumstances.',
    `payment_number` STRING COMMENT 'Unique business identifier for the royalty payment transaction, used for external reference and reconciliation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `payment_period_end_date` DATE COMMENT 'The ending date of the period covered by this royalty payment.',
    `payment_period_start_date` DATE COMMENT 'The beginning date of the period covered by this royalty payment, may span multiple production months for consolidated payments.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the royalty payment. Pending indicates awaiting approval, processed indicates calculated and ready for disbursement, paid indicates funds disbursed, suspended indicates held due to title issues or missing documentation, cancelled indicates voided payment, reversed indicates payment clawback, escheat indicates transferred to state unclaimed property. [ENUM-REF-CANDIDATE: pending|processed|paid|suspended|cancelled|reversed|escheat — 7 candidates stripped; promote to reference product]',
    `price_per_unit` DECIMAL(18,2) COMMENT 'The realized price per unit of production used to calculate gross revenue. Dollars per barrel for oil, dollars per MCF for gas.',
    `processing_cost_amount` DECIMAL(18,2) COMMENT 'Post-production costs for processing or treating the product, such as gas processing or oil treating, deducted from gross revenue if the lease terms allow cost deductions.',
    `production_month` DATE COMMENT 'The calendar month during which the production occurred that generated the revenue for this royalty payment. Typically first day of the production month.',
    `production_tax_amount` DECIMAL(18,2) COMMENT 'Additional production-related taxes deducted from gross revenue, may include ad valorem taxes or other state/local production taxes.',
    `production_volume` DECIMAL(18,2) COMMENT 'The quantity of product produced during the payment period that is attributable to this royalty owner based on their decimal interest. Measured in barrels for oil and condensate, MCF for gas, gallons for NGL.',
    `production_volume_uom` STRING COMMENT 'The unit of measure for the production volume. BBL for barrels (oil, condensate), MCF for thousand cubic feet (gas), GAL for gallons (NGL), TON for tons (sulfur), BOE for barrel of oil equivalent.. Valid values are `bbl|mcf|gal|ton|boe`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty payment record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty payment record was last modified in the system.',
    `severance_tax_amount` DECIMAL(18,2) COMMENT 'The state severance tax deducted from gross revenue, representing the tax on extraction of natural resources.',
    `suspense_date` DATE COMMENT 'The date the payment was placed into suspense status. Null if payment is not in suspense.',
    `suspense_flag` BOOLEAN COMMENT 'Indicates whether this payment is being held in suspense. True if payment is suspended due to title issues, missing tax documentation, address issues, or other administrative holds. False if payment is not suspended.',
    `suspense_reason_code` STRING COMMENT 'The reason code explaining why the payment is in suspense. Title defect indicates unresolved ownership issues, missing W9 indicates lack of tax documentation, invalid address indicates undeliverable payment, deceased owner indicates estate not settled, probate indicates estate in probate, litigation indicates legal dispute, other indicates miscellaneous reasons. [ENUM-REF-CANDIDATE: title_defect|missing_w9|invalid_address|deceased_owner|probate|litigation|other — 7 candidates stripped; promote to reference product]',
    `tax_year` STRING COMMENT 'The calendar tax year to which this payment is attributed for IRS Form 1099 reporting purposes.',
    `total_deduction_amount` DECIMAL(18,2) COMMENT 'The sum of all deductions (severance tax, production tax, transportation, processing, marketing, and other deductions) subtracted from gross revenue.',
    `transportation_cost_amount` DECIMAL(18,2) COMMENT 'Post-production costs for transporting the product from the wellhead to the point of sale, deducted from gross revenue if the lease terms allow cost deductions.',
    CONSTRAINT pk_royalty_disbursement PRIMARY KEY(`royalty_disbursement_id`)
) COMMENT 'Transactional record for royalty payments disbursed to royalty owners based on production revenue. Captures payment period, production month, product type (oil, gas, NGL), gross revenue, deductions (severance tax, production tax, post-production costs), net royalty amount, decimal interest applied, division order reference, check number, payment date, and suspense status. Supports 1099 reporting and state unclaimed property compliance. Integrates with revenue domain for payment reconciliation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`suspense_account` (
    `suspense_account_id` BIGINT COMMENT 'Unique identifier for the suspense account record. Primary key.',
    `division_order_id` BIGINT COMMENT 'Foreign key linking to land.division_order. Business justification: Suspense accounts often arise from division order issues (missing owner signatures, title defects preventing DO execution, disputed ownership). Adding division_order_id FK links the suspense account t',
    `escheatment_report_id` BIGINT COMMENT 'Reference number of the state unclaimed property report in which this suspense account was included.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Suspense accounts hold royalty payments awaiting proper owner identification or title clearance. Must map to specific GL accounts for balance sheet reporting, escheatment tracking, and SOX compliance ',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement associated with this suspense account.',
    `owner_id` BIGINT COMMENT 'FK to land.royalty_owner',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the royalty owner or interest owner for whom payment is being held in suspense.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well producing the revenue held in suspense.',
    `cumulative_suspense_balance` DECIMAL(18,2) COMMENT 'Total accumulated balance of all suspense amounts for this owner and lease combination, including historical unpaid amounts.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the suspense amount (typically USD for US operations).. Valid values are `USD|CAD|GBP|EUR`',
    `division_order_required_flag` BOOLEAN COMMENT 'Indicates whether a signed division order is required to release this suspense account (True/False).',
    `escheatment_date` DATE COMMENT 'Date when suspense funds were remitted to the state unclaimed property office.',
    `escheatment_deadline_date` DATE COMMENT 'Calculated date by which suspense funds must be released to owner or escheated to the state. Typically 1-7 years from suspense date depending on state law.',
    `escheatment_flag` BOOLEAN COMMENT 'Indicates whether this suspense account has been escheated to the state (True) or is still held by the operator (False).',
    `escheatment_state` STRING COMMENT 'State jurisdiction to which funds will be escheated if not claimed by owner. Determined by owners last known address or property location.',
    `jib_statement_number` STRING COMMENT 'Reference to the JIB statement that originally reported the revenue now held in suspense.',
    `last_contact_date` DATE COMMENT 'Date of most recent communication attempt with the owner regarding the suspense account. Used to demonstrate due diligence for escheatment reporting.',
    `last_contact_method` STRING COMMENT 'Method used for the most recent owner contact attempt (mail, email, phone, certified mail).. Valid values are `mail|email|phone|certified_mail|registered_mail`',
    `net_revenue_interest_decimal` DECIMAL(18,2) COMMENT 'Net Revenue Interest percentage expressed as a decimal representing the owners share of production revenue after royalties and overriding royalties.',
    `payment_method` STRING COMMENT 'Method used to disburse suspense funds to owner upon release (check, ACH, wire transfer, direct deposit).. Valid values are `check|ach|wire_transfer|direct_deposit`',
    `payment_reference_number` STRING COMMENT 'Check number, ACH trace number, or wire confirmation number for the released suspense payment.',
    `payment_release_date` DATE COMMENT 'Date when suspense funds were released and paid to the owner following resolution.',
    `product_type` STRING COMMENT 'Type of hydrocarbon product for which revenue is being held in suspense (oil, gas, Natural Gas Liquids, condensate, residue gas).. Valid values are `oil|gas|ngl|condensate|residue_gas`',
    `production_period_end_date` DATE COMMENT 'Ending date of the production period for which revenue is being held in suspense.',
    `production_period_start_date` DATE COMMENT 'Beginning date of the production period for which revenue is being held in suspense.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this suspense account record was first created in the land system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this suspense account record was last modified. Critical for audit trail and compliance.',
    `resolution_date` DATE COMMENT 'Date when the suspense issue was resolved and payment was authorized for release.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution process, actions taken, documentation received, and final disposition of the suspense account.',
    `resolution_status` STRING COMMENT 'Current status of efforts to resolve the suspense issue and release payment to the owner.. Valid values are `unresolved|in_progress|documentation_received|title_cleared|payment_authorized|completed`',
    `suspense_account_number` STRING COMMENT 'Business identifier for the suspense account used in reporting and reconciliation.',
    `suspense_amount` DECIMAL(18,2) COMMENT 'Current payment amount being held in suspense for this specific transaction or production period.',
    `suspense_date` DATE COMMENT 'Date when the revenue was first placed into suspense status. Critical for calculating escheatment deadlines.',
    `suspense_reason_code` STRING COMMENT 'Standardized code indicating the reason revenue is being held in suspense (e.g., missing division order, title dispute, unlocatable owner, probate proceedings).. Valid values are `missing_division_order|title_dispute|unlocatable_owner|probate_pending|address_unknown|signature_required`',
    `suspense_reason_description` STRING COMMENT 'Detailed narrative explanation of why the payment is being held in suspense, including specific circumstances and documentation requirements.',
    `suspense_status` STRING COMMENT 'Current lifecycle status of the suspense account indicating whether funds are still held, resolved, released to owner, or escheated to state.. Valid values are `open|pending_resolution|resolved|released|escheated|transferred`',
    `title_opinion_required_flag` BOOLEAN COMMENT 'Indicates whether a title opinion or curative work is required to resolve ownership and release suspense (True/False).',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'Working Interest percentage expressed as a decimal (e.g., 0.25000000 for 25%) associated with the suspense account.',
    CONSTRAINT pk_suspense_account PRIMARY KEY(`suspense_account_id`)
) COMMENT 'Master record tracking royalty and revenue payments held in suspense pending resolution of title issues, missing division orders, unlocatable owners, disputed interests, or probate proceedings. Captures suspense reason code, suspense date, production period, product type (oil, gas, NGL), suspense amount, cumulative suspense balance, owner reference, lease/well reference, resolution status, and escheatment deadline. Suspense management is a critical compliance function — most states mandate release or escheatment of suspense funds within defined periods (typically 1-7 years). Supports state unclaimed property reporting and audit defense. Integrates with Quorum Land System suspense module.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`right_of_way` (
    `right_of_way_id` BIGINT COMMENT 'Unique identifier for the right-of-way agreement record. Primary key for the right_of_way product.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: ROW acquisition and construction are AFE-funded for pipelines/facilities. Existing afe_number is denormalized; replace with FK for proper capital project cost tracking.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: ROW agreements formalized as contracts, especially for midstream infrastructure. Links easement terms to procurement contract management for payment schedules, insurance requirements, and restoration ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: ROW agreements for pipelines and facilities are capital projects requiring AFE authorization. Costs include easement payments, legal fees, and environmental clearances. Essential for capitalization de',
    `hierarchy_id` BIGINT COMMENT 'Reference to the specific pipeline, road, or utility asset that utilizes this ROW. Links to the asset master record for operational tracking.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Right-of-way agreements often relate to specific leases for pipeline, road, or utility access across leased land. While ROW already has tract_id, adding lease_id provides the operational context of wh',
    `operator_id` BIGINT COMMENT 'Reference to the operating company responsible for the infrastructure within the ROW. Links to the operator master record.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Rights of way require environmental permits, land use permits, and cultural resource clearances. Essential for pipeline construction compliance and regulatory approval of surface disturbance.',
    `title_opinion_id` BIGINT COMMENT 'Foreign key linking to land.title_opinion. Business justification: Right-of-way agreements require title verification to ensure the grantor has authority to grant the easement. The right_of_way has title_opinion_date and title_opinion_attorney fields that should be n',
    `tract_id` BIGINT COMMENT 'Reference to the surface tract across which the ROW easement is granted. Links to the land tract master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: ROW services (surveying, legal, environmental clearance) procured from vendors. Real procurement relationship for professional services supporting easement acquisition and regulatory compliance.',
    `agreement_document_reference` STRING COMMENT 'File path, document management system reference, or URL to the executed ROW agreement document. Used for legal review and audit.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Total or periodic compensation amount paid to the grantor for the ROW easement. Currency is specified separately.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for compensation amounts. Typically USD for US operations.. Valid values are `USD|CAD|MXN`',
    `compensation_type` STRING COMMENT 'Method by which the grantor is compensated for granting the easement. Determines payment calculation and timing.. Valid values are `lump_sum|annual_payment|per_rod|per_acre|damage_only|no_compensation`',
    `cost_center_code` STRING COMMENT 'General ledger cost center code to which ROW costs are allocated. Used for financial reporting and cost tracking.',
    `county_name` STRING COMMENT 'County or parish name where the ROW is recorded. Required for property records and local tax reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ROW record was first created in the system. Used for audit trail and data lineage.',
    `cultural_resource_clearance_flag` BOOLEAN COMMENT 'Indicates whether cultural resource surveys and clearances (Section 106 NHPA) have been completed for the ROW. True if clearance is complete.',
    `easement_acres` DECIMAL(18,2) COMMENT 'Total acreage of the ROW easement calculated from width and length. Used for compensation calculations and land use reporting.',
    `easement_length_feet` DECIMAL(18,2) COMMENT 'Length of the ROW corridor in feet along the route centerline. Used to calculate total easement acreage and compensation.',
    `easement_width_feet` DECIMAL(18,2) COMMENT 'Width of the ROW corridor in feet. Defines the lateral extent of the easement for construction, operation, and maintenance activities.',
    `effective_date` DATE COMMENT 'Date on which the ROW agreement becomes legally effective and operational rights commence.',
    `environmental_clearance_flag` BOOLEAN COMMENT 'Indicates whether environmental clearance (NEPA, ESA, CWA Section 404) has been obtained for the ROW. True if clearance is complete.',
    `expiration_date` DATE COMMENT 'Date on which the ROW agreement expires for fixed-term easements. Null for perpetual easements.',
    `gl_account_code` STRING COMMENT 'General ledger account code for ROW asset capitalization or expense recognition. Follows company chart of accounts.',
    `grantee_name` STRING COMMENT 'Legal name of the party receiving the easement rights (typically the operating company or pipeline operator).',
    `grantor_name` STRING COMMENT 'Legal name of the party granting the easement (landowner or surface rights holder). May be an individual, corporation, or government entity.',
    `grantor_tax_code` STRING COMMENT 'Tax identification number (TIN or EIN) of the grantor for payment and reporting purposes. Required for IRS 1099 reporting.',
    `insurance_amount` DECIMAL(18,2) COMMENT 'Minimum liability insurance coverage amount required by the ROW agreement, if applicable. Typically expressed in USD.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the ROW agreement requires the grantee to maintain liability insurance covering activities within the easement. True if insurance is required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ROW record was most recently updated. Used for audit trail and change tracking.',
    `legal_description` STRING COMMENT 'Full legal description of the ROW corridor including metes and bounds, section-township-range, or lot-block references as recorded in county records.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special provisions, negotiation history, or operational considerations for the ROW agreement.',
    `permitted_uses` STRING COMMENT 'Detailed description of activities permitted under the ROW agreement, including construction, operation, maintenance, inspection, and emergency access rights.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this ROW record originated, typically Quorum Land System. Used for data lineage and reconciliation.',
    `recording_date` DATE COMMENT 'Date the ROW agreement was officially recorded with the county clerk or recorder of deeds. Establishes priority and public notice.',
    `recording_reference` STRING COMMENT 'Official recording reference number, book and page, or instrument number assigned by the county recorder. Used to locate the recorded document.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number for any required regulatory filings with FERC, PHMSA, state utility commissions, or other agencies governing ROW approvals.',
    `restoration_obligation` STRING COMMENT 'Description of the grantees obligation to restore the surface following construction or maintenance activities, including topsoil replacement, reseeding, and drainage restoration.',
    `restrictions` STRING COMMENT 'Limitations or prohibitions on grantee activities within the ROW corridor, such as depth restrictions, seasonal access limits, or environmental protections.',
    `row_agreement_number` STRING COMMENT 'Business identifier for the ROW agreement, typically assigned by the land department or legal team. Used for external reference and filing.',
    `row_status` STRING COMMENT 'Current lifecycle status of the ROW agreement. Active indicates the easement is in force and operational.. Valid values are `active|pending|expired|terminated|suspended|under_negotiation`',
    `row_type` STRING COMMENT 'Classification of the infrastructure type for which the easement is granted. Determines operational use and regulatory requirements. [ENUM-REF-CANDIDATE: pipeline|road|power_line|water_line|fiber_optic|access_road|utility_corridor — 7 candidates stripped; promote to reference product]',
    `state_code` STRING COMMENT 'Two-letter US state code or equivalent jurisdiction code where the ROW is located. Used for regulatory compliance and reporting.',
    `term_type` STRING COMMENT 'Duration classification of the ROW agreement. Perpetual easements run with the land indefinitely; fixed-term easements expire on a specific date.. Valid values are `perpetual|fixed_term|life_of_facility|renewable`',
    CONSTRAINT pk_right_of_way PRIMARY KEY(`right_of_way_id`)
) COMMENT 'Master record for pipeline, road, and utility right-of-way (ROW) agreements granting easements across surface tracts for infrastructure installation and operation. Captures ROW type (pipeline, road, power line, water line), grantor, grantee, tract reference, easement width, length, compensation terms, term (perpetual or fixed), permitted uses, and regulatory filing reference. ROW management is essential for pipeline operations and facility development. Distinct from surface use agreements which cover drilling operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_document` (
    `lease_document_id` BIGINT COMMENT 'Unique system identifier for the lease document record. Primary key for the lease document master table.',
    `curative_action_id` BIGINT COMMENT 'Foreign key linking to land.curative_action. Business justification: Curative documents (affidavits, corrective deeds, releases) are created to resolve title defects identified in curative actions. The lease_document has curative_action_required_flag and curative_actio',
    `interest_assignment_id` BIGINT COMMENT 'Foreign key linking to land.interest_assignment. Business justification: Assignment documents (assignments of lease, assignments of overriding royalty, farmout agreements) are a specific type of lease document that execute interest transfers. Adding interest_assignment_id ',
    `lease_amendment_id` BIGINT COMMENT 'Foreign key linking to land.lease_amendment. Business justification: Many lease documents ARE amendments (ratifications, extensions, partial releases) or support amendments. While lease_document already has lease_id for the base lease, adding lease_amendment_id allows ',
    `lease_id` BIGINT COMMENT 'Reference to the parent lease agreement to which this document is associated. Links document to the underlying lease master record.',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Right-of-way agreement documents (easement agreements, pipeline agreements, road use agreements) are a specific type of lease document. Adding right_of_way_id FK links the document to the ROW agreemen',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Surface use agreement documents are a specific type of lease document that govern surface access and use. Adding surface_use_agreement_id FK links the document to the SUA it executes, enabling documen',
    `title_opinion_id` BIGINT COMMENT 'Foreign key linking to land.title_opinion. Business justification: Many lease documents are title-related instruments (title opinions, curative documents, title insurance policies). The lease_document has title_opinion_reference (string) that should be replaced with ',
    `approval_date` DATE COMMENT 'Date on which the document was formally approved for execution or recording. Part of the document workflow audit trail.',
    `approved_by` STRING COMMENT 'Name of the individual with authority who approved the document for execution or recording. Establishes accountability for document approval decisions.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity of the document and access restrictions. Governs who may view or handle the document.. Valid values are `public|internal|confidential|restricted`',
    `consideration_amount` DECIMAL(18,2) COMMENT 'Monetary consideration or payment amount stated in the document for the conveyance, assignment, or release. May be nominal or actual purchase price.',
    `consideration_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the consideration amount. Typically USD for U.S. domestic transactions.. Valid values are `USD|CAD|MXN|GBP|EUR`',
    `document_description` STRING COMMENT 'Detailed narrative description of the document contents, purpose, and key provisions. Provides context for land department users reviewing the document index.',
    `document_file_path` STRING COMMENT 'File system path or URI to the digital image or PDF of the executed document. Links the metadata record to the physical document stored in the document management system.',
    `document_number` STRING COMMENT 'Business identifier or control number assigned to the document by the land department or recording authority. May be internal tracking number or external instrument number.',
    `document_repository_code` STRING COMMENT 'Unique identifier assigned by the external document management or content management system. Enables retrieval of the document from the repository.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document. Tracks progression from draft through execution, recording, and archival stages. [ENUM-REF-CANDIDATE: draft|pending_execution|executed|recorded|filed|rejected|cancelled|superseded|archived — 9 candidates stripped; promote to reference product]',
    `document_subtype` STRING COMMENT 'Secondary classification providing additional granularity for the document type. For example, assignment may be partial or full; title opinion may be preliminary or final.',
    `document_title` STRING COMMENT 'Formal title or caption of the document as it appears on the instrument. Provides human-readable identification of the document purpose.',
    `document_type` STRING COMMENT 'Classification of the legal document type. Defines the nature and purpose of the document within the land and lease administration workflow. [ENUM-REF-CANDIDATE: lease|assignment|release|ratification|amendment|extension|surrender|pooling_agreement|unitization_agreement|surface_use_agreement|right_of_way|easement|title_opinion|curative_document|affidavit|memorandum|notice_of_lease|division_order|farmout_agreement|operating_agreement — 20 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the terms and conditions of the document become legally binding and enforceable. May differ from execution date based on contractual provisions.',
    `execution_date` DATE COMMENT 'Date on which the document was signed or executed by the parties. Represents the effective date of the legal instrument unless otherwise specified.',
    `grantee_name` STRING COMMENT 'Legal name of the party receiving rights, acquiring interest, or benefiting from the document. May be lessee, assignee, or beneficiary depending on document type.',
    `grantor_name` STRING COMMENT 'Legal name of the party granting rights, conveying interest, or releasing claims under the document. May be lessor, assignor, or releasing party depending on document type.',
    `gross_acres` DECIMAL(18,2) COMMENT 'Total surface acreage covered by the document without regard to ownership percentage. Represents the full geographic extent of the lands described.',
    `instrument_number` STRING COMMENT 'Unique instrument or reception number assigned by the county recording office. Modern recording systems use instrument numbers instead of or in addition to book and page references.',
    `legal_description` STRING COMMENT 'Legal description of the lands or mineral interests covered by the document. May include metes and bounds, lot and block, or government survey descriptions.',
    `net_acres` DECIMAL(18,2) COMMENT 'Net mineral acreage calculated by multiplying gross acres by the fractional interest conveyed or affected by the document. Represents the effective ownership position.',
    `notarized_flag` BOOLEAN COMMENT 'Indicates whether the document was notarized by a notary public. Notarization is often required for recording and legal validity.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or special instructions related to the document. Captures information not accommodated in structured fields.',
    `original_document_flag` BOOLEAN COMMENT 'Indicates whether the company holds the original executed document (true) or only a copy (false). Important for legal enforceability and audit purposes.',
    `page_count` STRING COMMENT 'Total number of pages in the scanned or digital document. Used for document completeness verification and imaging quality control.',
    `prepared_by` STRING COMMENT 'Name of the individual, law firm, or organization that prepared or drafted the document. May be internal land staff or external legal counsel.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document metadata record was first created in the system. Supports audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the document metadata record was last modified. Tracks the most recent change to the record for audit and synchronization purposes.',
    `recording_book` STRING COMMENT 'Book or volume number in the county recording system where the document is filed. Part of the official recording reference.',
    `recording_county` STRING COMMENT 'Name of the county where the document was recorded. Critical for establishing jurisdiction and public record location.',
    `recording_date` DATE COMMENT 'Date on which the document was officially recorded with the county clerk or appropriate governmental recording authority. Establishes public notice and priority.',
    `recording_page` STRING COMMENT 'Page number within the recording book where the document begins. Used in conjunction with book number for complete recording reference.',
    `recording_state` STRING COMMENT 'Two-letter state code where the document was recorded. Identifies the state jurisdiction for the recorded instrument.',
    `retention_category` STRING COMMENT 'Document retention classification based on legal, regulatory, and business requirements. Determines how long the document must be retained before eligible for destruction.. Valid values are `permanent|long_term|standard|short_term`',
    `retention_expiration_date` DATE COMMENT 'Date on which the document retention period expires and the document becomes eligible for destruction per the retention schedule. Null for permanent retention documents.',
    `reviewed_by` STRING COMMENT 'Name of the individual who reviewed the document for accuracy, completeness, and compliance before execution or recording. Supports quality control and audit trail.',
    `source_system` STRING COMMENT 'Name of the operational system from which the document metadata was sourced. Typically Quorum Land System or document management system identifier.',
    `witnessed_flag` BOOLEAN COMMENT 'Indicates whether the document execution was witnessed by one or more parties. Witnessing requirements vary by jurisdiction and document type.',
    CONSTRAINT pk_lease_document PRIMARY KEY(`lease_document_id`)
) COMMENT 'Master record for all legal documents associated with land and lease administration, including original lease instruments, assignments, releases, ratifications, title opinions, curative documents, and recorded instruments. Captures document type, recording information (book, page, instrument number, county, state), execution date, recording date, grantor, grantee, document status, and digital document reference. Serves as the document management index for the land department. Integrates with document management systems.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`interest_assignment` (
    `interest_assignment_id` BIGINT COMMENT 'Unique identifier for the interest assignment transaction. Primary key for the interest assignment record.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the party receiving or acquiring the interest. The entity gaining ownership or rights.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Interest assignments transfer ownership between venture partners. Assignor_venture_partner_id tracks the transferring party, enabling JOA consent tracking, preferential rights enforcement, and divisio',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Interest assignments trigger mandatory regulatory notifications to state agencies. Required for operator designation compliance, production allocation updates, and regulatory oversight of ownership tr',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE associated with this assignment, particularly relevant for farmout and farm-in transactions.',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease to which this interest assignment applies.',
    `primary_interest_commercial_counterparty_id` BIGINT COMMENT 'Reference to the party transferring or assigning the interest. The entity relinquishing ownership or rights.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Interest assignments can apply to specific tracts within a lease, particularly for partial assignments or when a lease covers multiple tracts. The assignment has acreage_assigned which could be valida',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well to which this interest assignment applies, if assignment is well-specific rather than lease-wide.',
    `assignee_party_name` STRING COMMENT 'Legal name of the party receiving the interest, captured for chain of title documentation.',
    `assignment_document_reference` STRING COMMENT 'Reference to the physical or electronic assignment instrument document in the document management system.',
    `assignment_notes` STRING COMMENT 'Free-text notes capturing additional details, special conditions, or context regarding the interest assignment.',
    `assignment_number` STRING COMMENT 'Business identifier for the assignment transaction, typically used for external reference and recording purposes.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment transaction in the approval and recording workflow.. Valid values are `draft|pending_approval|executed|recorded|cancelled|rejected`',
    `assignment_type` STRING COMMENT 'Classification of the assignment transaction indicating the nature of the interest transfer. [ENUM-REF-CANDIDATE: full_assignment|partial_assignment|farmout|farm_in|conveyance|reservation|reversion — 7 candidates stripped; promote to reference product]',
    `consideration_amount` DECIMAL(18,2) COMMENT 'Monetary value or consideration paid for the interest assignment. May be cash, assumption of obligations, or other value exchanged.',
    `consideration_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the consideration amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interest assignment record was first created in the system.',
    `depth_restriction_flag` BOOLEAN COMMENT 'Indicates whether the assignment includes depth restrictions limiting the vertical extent of the assigned interest.',
    `depth_restriction_from_feet` DECIMAL(18,2) COMMENT 'Starting depth in feet for depth-restricted assignments, measured from surface or another datum.',
    `depth_restriction_to_feet` DECIMAL(18,2) COMMENT 'Ending depth in feet for depth-restricted assignments, measured from surface or another datum.',
    `division_order_update_required_flag` BOOLEAN COMMENT 'Indicates whether division orders must be updated to reflect this interest assignment for revenue distribution purposes.',
    `effective_date` DATE COMMENT 'Date on which the interest assignment becomes legally effective for revenue and cost allocation purposes. Critical for Joint Interest Billing (JIB) accuracy.',
    `execution_date` DATE COMMENT 'Date on which the assignment instrument was signed and executed by the parties.',
    `formation_restriction` STRING COMMENT 'Specific geological formation or formations to which the assignment is restricted, if applicable.',
    `interest_type` STRING COMMENT 'Classification of the oil and gas interest being assigned, defining the nature of ownership or revenue rights.. Valid values are `working_interest|net_revenue_interest|overriding_royalty_interest|royalty_interest|mineral_interest|leasehold_interest`',
    `jib_effective_date` DATE COMMENT 'Date from which the assignee begins receiving revenue distributions and bearing costs in joint interest billing. May differ from legal effective date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interest assignment record was most recently updated in the system.',
    `nri_decimal_assigned` DECIMAL(18,2) COMMENT 'Decimal fraction of net revenue interest being transferred in this assignment. Represents revenue-bearing ownership percentage after royalty burdens.',
    `orri_decimal_assigned` DECIMAL(18,2) COMMENT 'Decimal fraction of overriding royalty interest being transferred. ORRI is carved out of working interest and does not bear operating costs.',
    `preferential_right_flag` BOOLEAN COMMENT 'Indicates whether the assignment is subject to preferential purchase rights or rights of first refusal by other interest owners.',
    `preferential_right_waived_flag` BOOLEAN COMMENT 'Indicates whether preferential purchase rights were waived or declined by other interest owners.',
    `recording_book_number` STRING COMMENT 'Book or volume number in the county records where the assignment is recorded.',
    `recording_date` DATE COMMENT 'Date on which the assignment was officially recorded with the appropriate county or regulatory authority.',
    `recording_instrument_number` STRING COMMENT 'Official instrument or document number assigned by the recording authority.',
    `recording_jurisdiction` STRING COMMENT 'County, parish, or other governmental jurisdiction where the assignment instrument was recorded.',
    `recording_page_number` STRING COMMENT 'Page number in the recording book where the assignment instrument is filed.',
    `sec_reporting_impact_flag` BOOLEAN COMMENT 'Indicates whether this assignment has material impact on SEC reserves reporting and disclosure requirements.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this interest assignment data originated (e.g., Quorum Land System, SAP JV Accounting).',
    `title_opinion_reference` STRING COMMENT 'Reference to the title opinion or title examination document supporting the validity of this assignment.',
    `well_api_number` STRING COMMENT 'API well number for the well associated with this interest assignment, used for regulatory reporting and identification.',
    `wi_decimal_assigned` DECIMAL(18,2) COMMENT 'Decimal fraction of working interest being transferred in this assignment. Represents cost-bearing ownership percentage.',
    CONSTRAINT pk_interest_assignment PRIMARY KEY(`interest_assignment_id`)
) COMMENT 'Transactional record capturing the assignment or transfer of working interest, overriding royalty interest (ORRI), or other oil and gas interests between parties. Captures assignor, assignee, interest type, decimal fraction assigned, effective date, consideration, lease or well reference, recording information, and assignment type (full assignment, partial assignment, farmout, farm-in). Maintains the chain of title for working interest ownership. Critical for JIB billing accuracy and SEC reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`orri` (
    `orri_id` BIGINT COMMENT 'Unique identifier for the overriding royalty interest record. Primary key.',
    `lease_id` BIGINT COMMENT 'Reference to the lease from which this ORRI is carved. ORRIs are typically associated with a specific lease or well.',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the party (individual or entity) who holds the ORRI. Commonly geologists, brokers, landmen, or consultants who were granted the interest as compensation.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: ORRI holders are often venture partners. Venture_partner_id tracks the payee, enables payment processing, supports JIB netting, and ensures proper tax reporting for partner-held overriding royalties.',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well to which this ORRI applies, if the ORRI is well-specific rather than lease-wide.',
    `conversion_date` DATE COMMENT 'The date on which the ORRI was converted to another interest type, if conversion has occurred.',
    `conversion_trigger` STRING COMMENT 'Description of the conditions or events that trigger conversion of the ORRI to another interest type, if applicable.',
    `convertible_flag` BOOLEAN COMMENT 'Indicates whether the ORRI is convertible to another interest type (typically working interest) under specified conditions.',
    `cost_bearing_flag` BOOLEAN COMMENT 'Indicates whether the ORRI holder bears any costs. By definition, ORRIs are non-cost-bearing, so this should typically be False. Included for completeness and exception handling.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country in which the ORRI property is located.. Valid values are `USA|CAN|MEX|GBR`',
    `county_name` STRING COMMENT 'The county in which the lease or well associated with this ORRI is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this ORRI record was first created in the system.',
    `creation_instrument_reference` STRING COMMENT 'Document reference number or identifier for the legal instrument that created the ORRI, used for title research and audit purposes.',
    `creation_instrument_type` STRING COMMENT 'The type of legal instrument that created or granted the ORRI. Common instruments include deeds, assignments, farmout agreements, leases with ORRI provisions, consulting agreements, and brokerage agreements. [ENUM-REF-CANDIDATE: deed|assignment|farmout_agreement|lease|consulting_agreement|brokerage_agreement|other — 7 candidates stripped; promote to reference product]',
    `cumulative_payout_amount` DECIMAL(18,2) COMMENT 'The cumulative amount paid to the ORRI holder to date, used to track progress toward payout threshold for payout-based ORRIs.',
    `decimal` DECIMAL(18,2) COMMENT 'The decimal fraction representing the ORRI holders share of gross production revenue. For example, 0.0125 represents a 1.25% ORRI.',
    `depth_from_feet` DECIMAL(18,2) COMMENT 'The starting depth in feet for depth-limited ORRIs. The ORRI applies only to production from this depth and below.',
    `depth_to_feet` DECIMAL(18,2) COMMENT 'The ending depth in feet for depth-limited ORRIs. The ORRI applies only to production from above this depth.',
    `division_order_date` DATE COMMENT 'The date on which the division order was issued for this ORRI.',
    `division_order_flag` BOOLEAN COMMENT 'Indicates whether a division order has been issued for this ORRI, authorizing revenue distribution to the holder.',
    `effective_date` DATE COMMENT 'The date on which the ORRI becomes effective and the holder begins to receive revenue distributions.',
    `formation_name` STRING COMMENT 'The geological formation to which the ORRI applies, for formation-specific ORRIs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this ORRI record was last updated in the system.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special conditions, or administrative notes related to the ORRI.',
    `orri_number` STRING COMMENT 'Business identifier for the ORRI, typically assigned by the operator or land department for tracking and reference purposes.',
    `orri_status` STRING COMMENT 'Current lifecycle status of the ORRI. Active indicates the ORRI is currently in effect and revenue is being distributed; suspended indicates temporary hold on payments; terminated indicates the ORRI has ended; pending indicates the ORRI is awaiting activation; converted indicates the ORRI has been converted to another interest type.. Valid values are `active|suspended|terminated|pending|converted`',
    `orri_type` STRING COMMENT 'Classification of the ORRI based on its termination conditions. Perpetual ORRIs continue indefinitely; convertible ORRIs convert to working interest under certain conditions; payout-based ORRIs terminate after cost recovery; term-limited ORRIs expire after a specified period; depth-limited ORRIs apply only to specific depth intervals; formation-specific ORRIs apply only to designated formations.. Valid values are `perpetual|convertible|payout_based|term_limited|depth_limited|formation_specific`',
    `payout_status` STRING COMMENT 'Indicates whether the ORRI is in pre-payout or post-payout status. Not applicable for non-payout-based ORRIs.. Valid values are `not_applicable|pre_payout|post_payout`',
    `payout_threshold_amount` DECIMAL(18,2) COMMENT 'The cumulative revenue or cost recovery amount at which a payout-based ORRI terminates. Applicable only to payout-based ORRIs.',
    `payout_threshold_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payout threshold amount. Typically USD for U.S. operations.. Valid values are `USD|CAD|GBP|EUR`',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage representation of the ORRI decimal for reporting and display purposes. For example, 1.2500 represents 1.25%.',
    `product_type` STRING COMMENT 'The type of hydrocarbon product to which the ORRI applies. Can be oil-only, gas-only, natural gas liquids (NGL)-only, or all products.. Valid values are `oil|gas|ngl|all_products`',
    `recording_date` DATE COMMENT 'The date on which the ORRI instrument was recorded in the county or jurisdiction land records.',
    `recording_reference` STRING COMMENT 'The book, page, or instrument number assigned by the county recorders office when the ORRI instrument was recorded.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this ORRI record originated, typically Quorum Land System or SAP Joint Venture Accounting.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code for the jurisdiction in which the ORRI property is located.',
    `suspense_flag` BOOLEAN COMMENT 'Indicates whether revenue payments to the ORRI holder are currently held in suspense due to title issues, missing documentation, or other administrative holds.',
    `suspense_reason` STRING COMMENT 'Description of the reason why revenue payments are held in suspense, if applicable.',
    `termination_condition` STRING COMMENT 'Description of the conditions under which the ORRI will terminate, such as payout thresholds, time limits, depth restrictions, or conversion triggers.',
    `termination_date` DATE COMMENT 'The date on which the ORRI terminates or is scheduled to terminate, if applicable. Null for perpetual ORRIs.',
    `title_opinion_reference` STRING COMMENT 'Reference to the title opinion document that validates the ORRI holders interest and chain of title.',
    `title_status` STRING COMMENT 'Status of the title opinion for this ORRI. Clear indicates no title defects; defective indicates title issues exist; pending review indicates title examination is in progress; curative required indicates remedial action is needed.. Valid values are `clear|defective|pending_review|curative_required`',
    CONSTRAINT pk_orri PRIMARY KEY(`orri_id`)
) COMMENT 'Master record for Overriding Royalty Interests (ORRI) — non-cost-bearing interests carved out of the working interest that entitle the holder to a fraction of gross production revenue. Captures ORRI holder, decimal fraction, lease or well reference, creation instrument, effective date, termination conditions (convertible ORRI, payout-based ORRI), and current status. ORRIs are commonly granted to geologists, brokers, and landmen as compensation. Distinct from royalty interests which are carved from the mineral estate.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`curative_action` (
    `curative_action_id` BIGINT COMMENT 'Unique identifier for the title curative action record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Title curative is AFE line item (legal fees, document recording). Existing afe_number is denormalized; replace with FK for proper cost tracking against capital project budgets.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Title curative actions may be required by regulatory corrective actions following audits or violations. Links land title remediation to compliance remediation for integrated tracking and closure verif',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Title curative work (missing deeds, heirship determinations, quiet title actions) incurs legal costs charged to drilling or acquisition AFEs. Required for cost tracking when curative blocks operations',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Title curative actions are required before JOA operations can proceed. Joa_id links curative work to the governing agreement, enabling AFE cost allocation and partner consent tracking.',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement affected by the title defect requiring curative action.',
    `employee_id` BIGINT COMMENT 'Reference to the landman or land professional assigned responsibility for completing the curative action.',
    `quaternary_curative_assigned_landman_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `tertiary_curative_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who approved the curative action for execution.',
    `title_opinion_id` BIGINT COMMENT 'Reference to the title opinion that identified the defect requiring curative action.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Curative actions address title defects on specific land parcels (tracts). The curative_action has county_name and state_province_code that duplicate tract attributes. Adding tract_id FK allows normali',
    `well_asset_id` BIGINT COMMENT 'Reference to the well for which curative action is required before drilling or division order preparation.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to complete the curative action, including all legal fees, recording fees, landman time, and consideration paid.',
    `affected_acreage` DECIMAL(18,2) COMMENT 'Total acreage affected by the title defect requiring curative action. Measured in acres.',
    `affected_net_revenue_interest` DECIMAL(18,2) COMMENT 'Net Revenue Interest (NRI) percentage affected by the title defect. Expressed as a decimal (e.g., 0.187500 represents 18.75% NRI).',
    `affected_working_interest` DECIMAL(18,2) COMMENT 'Working Interest (WI) percentage affected by the title defect. Expressed as a decimal (e.g., 0.250000 represents 25% WI).',
    `approval_date` DATE COMMENT 'Date when the curative action was formally approved for execution by authorized management or legal counsel.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the curative action requires management or legal approval before execution. True indicates approval workflow is required.',
    `assigned_date` DATE COMMENT 'Date when the curative action was formally assigned to a landman for resolution.',
    `blocking_division_order_flag` BOOLEAN COMMENT 'Boolean indicator whether this curative action must be completed before division orders can be prepared and revenue distributed. True indicates division order processing is blocked.',
    `blocking_drilling_flag` BOOLEAN COMMENT 'Boolean indicator whether this curative action must be completed before drilling operations can commence. True indicates drilling is blocked until resolution.',
    `completion_date` DATE COMMENT 'Actual date when the curative action was completed and the title defect was resolved to achieve marketable title.',
    `cost_center_code` STRING COMMENT 'Cost center code for financial allocation of curative action expenses within the enterprise resource planning system.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for curative action costs (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the affected lease is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the curative action record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `curative_action_number` STRING COMMENT 'Business identifier for the curative action, typically assigned by the land department for tracking and reference purposes.',
    `curative_status` STRING COMMENT 'Current lifecycle status of the curative action. Tracks progress from identification through resolution.. Valid values are `pending|in progress|completed|cancelled|on hold|escalated`',
    `curative_type` STRING COMMENT 'Classification of the type of curative action required to resolve the title defect. Common types include missing heir affidavit, probate, correction deed, ratification, release of lien, quiet title action, and curative affidavit. [ENUM-REF-CANDIDATE: missing heir affidavit|probate|correction deed|ratification|release of lien|quiet title action|curative affidavit — 7 candidates stripped; promote to reference product]',
    `defect_description` STRING COMMENT 'Detailed description of the title defect identified in the title opinion that necessitates curative action. Describes the specific issue affecting marketable title.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the curative instrument document stored in the document management system.',
    `due_date` DATE COMMENT 'Target completion date for the curative action, typically driven by drilling schedule or Authorization for Expenditure (AFE) approval timeline.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost to complete the curative action, including legal fees, recording fees, landman time, and any consideration paid to resolve the defect.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code for posting curative action costs in the financial system.',
    `identified_date` DATE COMMENT 'Date when the title defect was identified in the title opinion, triggering the need for curative action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the curative action record was last updated in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `priority_level` STRING COMMENT 'Business priority assigned to the curative action based on drilling schedule, capital commitment, and operational impact. Critical priority typically indicates pre-drilling requirement.. Valid values are `critical|high|medium|low`',
    `recording_date` DATE COMMENT 'Date when the curative instrument was officially recorded in the county land records office.',
    `recording_reference` STRING COMMENT 'Official recording reference number, book and page, or instrument number assigned by the county clerk when the curative document was recorded.',
    `recording_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the curative instrument must be recorded in the county land records to perfect title. True indicates recording is required.',
    `resolution_method` STRING COMMENT 'Detailed explanation of the method used to resolve the title defect, including specific instruments executed, parties involved, and legal mechanisms employed.',
    `resolution_notes` STRING COMMENT 'Additional notes and commentary regarding the resolution of the curative action, including challenges encountered, alternative approaches considered, and lessons learned.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this curative action data originated (e.g., QUORUM for Quorum Land System).',
    CONSTRAINT pk_curative_action PRIMARY KEY(`curative_action_id`)
) COMMENT 'Transactional record tracking title curative actions required to resolve defects identified in title opinions before drilling or division order preparation. Captures curative type (missing heir affidavit, probate, correction deed, ratification, release of lien), assigned landman, due date, completion date, curative status, title opinion reference, and resolution notes. Curative management is a critical pre-drilling workflow ensuring marketable title before significant capital is committed.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_obligation` (
    `lease_obligation_id` BIGINT COMMENT 'Unique identifier for the lease obligation record. Primary key for the lease obligation master record tracking all contractual obligations and critical dates associated with a lease.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Lease obligations (delay rentals, shut-in payments) charged to AFEs. Existing afe_number is denormalized; replace with FK for proper cost allocation to capital projects.',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who approved the obligation satisfaction. Used for audit trail and segregation of duties compliance.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Lease obligations (delay rentals, shut-in payments, surface damages) are charged to AFEs for proper cost allocation and working interest billing. Essential for JIB statement preparation and partner co',
    `lease_id` BIGINT COMMENT 'Reference to the parent lease agreement to which this obligation applies. Links the obligation to the master lease record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Lease obligations (delay rentals, shut-in payments, surface damages) are compliance obligations tracked in compliance calendars. Required for obligation management, deadline tracking, and compliance r',
    `operator_id` BIGINT COMMENT 'Reference to the operating company responsible for satisfying this obligation. In joint venture arrangements, the operator manages lease obligations on behalf of all working interest owners.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Lease obligations (delay rentals, shut-in payments) paid to venture partners. Venture_partner_id enables partner-level obligation tracking, AFE cost allocation, and JIB statement reconciliation.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well associated with this obligation, applicable for shut-in royalty obligations, offset well requirements, or continuous drilling obligations. Links obligation to specific wellbore operations.',
    `acreage_affected` DECIMAL(18,2) COMMENT 'Number of gross acres subject to this obligation. For delay rentals, this is the acreage covered by the rental payment; for Pugh clause obligations, this is the acreage at risk of release; for offset well obligations, this is the acreage requiring protection.',
    `action_completion_date` DATE COMMENT 'Date the required non-monetary action was completed. Used to verify compliance with continuous drilling clauses, offset well requirements, and other operational obligations. Null if action not yet completed.',
    `action_required` STRING COMMENT 'Description of the non-monetary action required to satisfy the obligation. Examples include: commence drilling operations, complete offset well, file regulatory report, execute lease extension, release acreage under Pugh clause, restore surface damage. Null for purely monetary obligations.',
    `alert_notification_date` DATE COMMENT 'Date when automated alert notification was sent to responsible parties regarding the upcoming obligation. Supports proactive obligation management and audit trail of notification workflows.',
    `alert_recipient_email` STRING COMMENT 'Email address of the land administrator or responsible party who received the obligation alert notification. Used for tracking notification delivery and escalation workflows.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee with authority to approve satisfaction of this obligation. Used for internal controls and SOX compliance in expenditure authorization workflows.',
    `approval_date` DATE COMMENT 'Date the obligation payment or action was approved by the designated authority. Used for audit trail and internal control verification. Null if not yet approved.',
    `cost_center_code` STRING COMMENT 'Internal cost center code for financial accounting and reporting. Used to allocate obligation costs to appropriate organizational units in the ERP system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the obligation amount. Supports multi-currency operations for international joint ventures and cross-border lease agreements. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|MXN|BRL|NOK|AUD — 8 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'The date by which the obligation must be satisfied to maintain lease compliance. Critical for automated alert workflows and lease administration calendar. Missing this date may result in lease termination or regulatory violation.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting the obligation expense or liability. Ensures proper financial statement classification and compliance with petroleum accounting standards.',
    `grace_period_days` STRING COMMENT 'Number of days after the due date during which the obligation may be satisfied without lease termination or penalty. Varies by lease terms and state regulations. Null if no grace period applies.',
    `jib_statement_number` STRING COMMENT 'JIB statement number on which this obligation cost was billed to non-operating working interest partners. Used for joint venture cost recovery and partner reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this obligation record was last updated. Used for audit trail, change tracking, and data synchronization with source systems.',
    `late_payment_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for late satisfaction of the obligation, if specified in the lease agreement. May be a flat fee or percentage of the obligation amount.',
    `lease_termination_risk_flag` BOOLEAN COMMENT 'Boolean indicator that failure to satisfy this obligation may result in automatic lease termination. True for critical obligations such as delay rentals during primary term, continuous drilling deadlines, and Pugh clause compliance dates. Triggers high-priority alerts.',
    `net_revenue_interest_decimal` DECIMAL(18,2) COMMENT 'Net revenue interest percentage expressed as a decimal, representing the working interest after deducting royalty and overriding royalty burdens. Used to calculate net obligation impact on revenue distribution.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, dispute details, or resolution notes. Used by land administrators to document non-standard situations and provide audit trail commentary.',
    `obligation_amount` DECIMAL(18,2) COMMENT 'Monetary value of the obligation if applicable. For delay rentals, this is the rental payment amount; for shut-in royalty, the royalty payment; for minimum royalty, the baseline payment. Null for non-monetary obligations such as drilling requirements or compliance actions.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the obligation. Pending indicates future obligation not yet due; due indicates payment or action required; paid indicates completed payment; overdue indicates missed deadline with lease termination risk; waived indicates lessor forgiveness; cancelled indicates obligation no longer applicable; in dispute indicates contested terms; resolved indicates dispute settlement. [ENUM-REF-CANDIDATE: pending|due|paid|overdue|waived|cancelled|in_dispute|resolved — 8 candidates stripped; promote to reference product]',
    `obligation_type` STRING COMMENT 'Classification of the contractual obligation. Delay rental payments maintain lease during primary term; shut-in royalty payments cover non-producing periods; minimum royalty ensures baseline lessor payments; offset well obligations require drilling to protect lease boundaries; lease extension payments exercise option terms; continuous drilling obligations maintain lease through active operations; Pugh clause compliance releases non-producing acreage; surface damage covers land restoration; environmental remediation addresses HSE requirements. [ENUM-REF-CANDIDATE: delay_rental|shut_in_royalty|minimum_royalty|offset_well|lease_extension_payment|continuous_drilling|pugh_clause_compliance|surface_damage|environmental_remediation|other — 10 candidates stripped; promote to reference product]',
    `payee_tax_code` STRING COMMENT 'Tax identification number for the payee, used for IRS 1099 reporting and tax compliance. Typically EIN for entities or SSN for individuals.',
    `payment_date` DATE COMMENT 'Actual date the obligation payment was made or the required action was completed. Used to track compliance history and calculate grace period violations. Null if obligation not yet satisfied.',
    `payment_method` STRING COMMENT 'Method used to satisfy the monetary obligation. Check indicates paper check payment; wire transfer indicates electronic funds transfer; ACH indicates automated clearing house; draft indicates bank draft; suspense release indicates payment from held funds; offset indicates credit against other obligations. [ENUM-REF-CANDIDATE: check|wire_transfer|ach|draft|suspense_release|offset|other — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External reference number for the payment transaction, such as check number, wire confirmation, or accounts payable voucher number. Used for audit trail and reconciliation with financial systems.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency to which filing or notification is required, such as BSEE, BOEM, state oil and gas commission, or county clerk. Null if no regulatory filing required.',
    `regulatory_filing_date` DATE COMMENT 'Date the required regulatory filing was submitted to the governing agency. Used to track compliance with state and federal reporting obligations. Null if no filing required or not yet submitted.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Boolean indicator that satisfaction of this obligation requires regulatory filing or notification. True for obligations involving lease amendments, acreage releases, or well commitments that must be reported to state or federal agencies.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this obligation data originated. QUORUM indicates Quorum Land System; SAP_JV indicates SAP Joint Venture Accounting; SAP_FI indicates SAP Financial Accounting; MANUAL indicates manual entry by land administrator; OTHER indicates alternative source.. Valid values are `QUORUM|SAP_JV|SAP_FI|MANUAL|OTHER`',
    `well_api_number` STRING COMMENT 'Standard API well number for the associated well, following the 10-14 digit format (state-county-unique well identifier). Used for regulatory reporting and cross-system well identification.',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'Working interest ownership percentage expressed as a decimal (e.g., 0.75000000 for 75% WI). Determines the operators share of obligation costs in joint venture arrangements. Used for AFE cost allocation.',
    CONSTRAINT pk_lease_obligation PRIMARY KEY(`lease_obligation_id`)
) COMMENT 'Master record tracking all contractual obligations and critical dates associated with a lease, serving as the unified obligation calendar for land administration. Covers obligation types including: delay rental payments (rental due dates, amounts, payment confirmation), shut-in royalty payments (shut-in periods, reasons, well references), lease expiration management (primary term expiry, extension options, HBP status, continuous drilling clauses, Pugh clause applicability), minimum royalty obligations, offset well obligations, and other contractual commitments. Captures obligation type, due date, amount or action required, compliance status, payment history, associated lease reference, and resolution/action taken. Proactive obligation management prevents inadvertent lease terminations and regulatory violations. Supports automated alert workflows for upcoming deadlines. Integrates with accounts payable for payment processing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` (
    `shut_in_royalty_id` BIGINT COMMENT 'Unique identifier for the shut-in royalty payment transaction record.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the operating company responsible for making the shut-in royalty payment and managing the well.',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who approved the shut-in royalty payment for disbursement.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Shut-in royalty payments maintain lease rights when wells are temporarily non-producing. Costs are allocated to well AFEs for LOE tracking and working interest billing. Critical for lease maintenance ',
    `lease_id` BIGINT COMMENT 'Reference to the lease agreement under which the shut-in royalty obligation exists.',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the mineral rights owner (lessor) receiving the shut-in royalty payment.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Shut-in royalty payments to venture partners holding lease interests. Venture_partner_id enables partner-level payment tracking, JIB allocation, and compliance with JOA shut-in provisions.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well that is shut in and capable of production but not currently producing.',
    `acreage_covered` DECIMAL(18,2) COMMENT 'The net mineral acreage covered by this shut-in royalty payment, used in calculating the total payment amount.',
    `approval_date` DATE COMMENT 'The date when the shut-in royalty payment was approved by the authorized approver or land department.',
    `consecutive_shut_in_months` STRING COMMENT 'The cumulative number of consecutive months the well has been shut in under this shut-in royalty arrangement.',
    `cost_center_code` STRING COMMENT 'The internal cost center or business unit code to which the shut-in royalty expense is allocated.',
    `gl_account_code` STRING COMMENT 'The general ledger account code for recording the shut-in royalty expense in the financial system.',
    `jib_statement_number` STRING COMMENT 'The JIB statement number on which this shut-in royalty payment is billed to non-operating working interest owners.',
    `lease_clause_reference` STRING COMMENT 'Reference to the specific lease clause or paragraph that governs the shut-in royalty terms and conditions.',
    `lease_maintenance_flag` BOOLEAN COMMENT 'Indicates whether this shut-in royalty payment successfully maintains the lease in force during the shut-in period, preventing lease expiration.',
    `maximum_shut_in_duration_months` STRING COMMENT 'The maximum number of consecutive months the well may remain shut in under shut-in royalty payments before the lease terminates, as specified in the lease agreement.',
    `net_revenue_interest_decimal` DECIMAL(18,2) COMMENT 'The net revenue interest percentage (expressed as decimal) after royalty and other burdens, relevant to cost allocation.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the shut-in royalty payment made to the lessor for the specified shut-in period.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the shut-in royalty payment amount.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The actual date when the shut-in royalty payment was disbursed to the lessor.',
    `payment_due_date` DATE COMMENT 'The contractual date by which the shut-in royalty payment must be made to maintain the lease in force.',
    `payment_method` STRING COMMENT 'The disbursement method used to deliver the shut-in royalty payment to the lessor.. Valid values are `check|wire_transfer|ach|direct_deposit`',
    `payment_notes` STRING COMMENT 'Free-form notes or comments regarding special circumstances, adjustments, or issues related to this shut-in royalty payment.',
    `payment_number` STRING COMMENT 'Business identifier for the shut-in royalty payment transaction, used for tracking and reconciliation.',
    `payment_rate_per_acre` DECIMAL(18,2) COMMENT 'The per-acre rate used to calculate the shut-in royalty payment, as specified in the lease agreement.',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment system (check number, wire confirmation, ACH trace number) for reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the shut-in royalty payment in the approval and disbursement workflow.. Valid values are `pending|approved|paid|rejected|cancelled|suspended`',
    `production_capability_verification_date` DATE COMMENT 'The date when the wells production capability was last verified through testing or production history.',
    `production_capability_verified_flag` BOOLEAN COMMENT 'Indicates whether the wells capability to produce in paying quantities has been verified, a requirement for valid shut-in royalty payments under most lease terms.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this shut-in royalty payment record was first created in the system.',
    `record_status` STRING COMMENT 'The current data lifecycle status of this shut-in royalty payment record in the data warehouse.. Valid values are `active|inactive|deleted|archived`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this shut-in royalty payment record was last modified in the system.',
    `shut_in_period_end_date` DATE COMMENT 'The date when the shut-in period ended, either through resumption of production or lease termination.',
    `shut_in_period_start_date` DATE COMMENT 'The date when the well was shut in and ceased production, marking the beginning of the shut-in royalty obligation period.',
    `shut_in_reason_code` STRING COMMENT 'Categorical code indicating the primary reason the well is shut in and not producing. [ENUM-REF-CANDIDATE: lack_of_market|no_pipeline|mechanical_failure|regulatory_restriction|economic|weather|other — 7 candidates stripped; promote to reference product]',
    `shut_in_reason_description` STRING COMMENT 'Detailed narrative explanation of the specific circumstances causing the well to be shut in during this period.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this shut-in royalty payment record originated (e.g., Quorum, SAP JV Accounting).',
    `well_api_number` STRING COMMENT 'The standardized API well number for the shut-in well, providing regulatory identification.',
    `well_name` STRING COMMENT 'The business name or designation of the shut-in well for operational reference.',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'The working interest ownership percentage (expressed as decimal) of the operator or party responsible for the shut-in royalty payment.',
    CONSTRAINT pk_shut_in_royalty PRIMARY KEY(`shut_in_royalty_id`)
) COMMENT 'Transactional record for shut-in royalty payments made to lessors when a well capable of production is shut in (not producing) due to lack of market, pipeline connection, or other operational reasons. Captures shut-in period, payment amount, payment date, shut-in reason, well reference, lease reference, and whether the shut-in royalty maintains the lease in force. Shut-in royalty provisions are a critical lease maintenance mechanism when production ceases temporarily.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`leasing_prospect` (
    `leasing_prospect_id` BIGINT COMMENT 'Primary key for leasing_prospect',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Leasing prospects are exploration projects with approved AFE budgets covering bonus payments, broker commissions, and title work. Essential for tracking leasing spend against budget and capitalizing s',
    `land_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `operator_id` BIGINT COMMENT 'Reference to the operating company responsible for leasing activities and prospect development. May be internal or external operator.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Leasing prospects require environmental permits and drilling permits during planning. Essential for prospect evaluation, permitting timeline planning, and ensuring regulatory feasibility before lease ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Prospects target specific product types (oil vs gas vs liquids-rich) with dramatically different leasing economics and infrastructure requirements. Business process: portfolio planning, capital alloca',
    `prospect_id` BIGINT COMMENT 'Reference to the upstream exploration prospect that drives this leasing activity. Links land acquisition strategy to exploration targets.',
    `actual_completion_date` DATE COMMENT 'Actual date when leasing activities were completed or substantially completed. Used for performance measurement and lessons learned.',
    `actual_leasing_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure on lease acquisitions for this prospect to date. Used for budget variance analysis and cost control.',
    `average_royalty_burden_percent` DECIMAL(18,2) COMMENT 'Average royalty burden expected across leases within this prospect. Impacts net revenue interest calculations and economic viability.',
    `basin_name` STRING COMMENT 'Name of the sedimentary basin where the prospect is located. Critical for regional acreage strategy and geological context.',
    `cost_center_code` STRING COMMENT 'Cost center code for financial tracking and allocation of leasing expenditures. Used for internal management accounting and reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the leasing prospect is located. Determines applicable regulatory framework and fiscal terms. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|ARG|GBR|NOR|NGA|AGO|SAU|ARE|QAT|KWT|IRQ|RUS|KAZ|AUS|CHN|IND|IDN|MYS — 21 candidates stripped; promote to reference product]',
    `county_name` STRING COMMENT 'County or parish name where the leasing prospect is located. Required for local regulatory filings and tax assessments.',
    `current_gross_acres_leased` DECIMAL(18,2) COMMENT 'Current gross surface acres already under lease within the prospect boundary. Tracks total surface position for operational planning.',
    `current_net_acres_leased` DECIMAL(18,2) COMMENT 'Current net mineral acres already under lease within the prospect boundary. Used to calculate remaining acreage gap and leasing progress.',
    `estimated_gross_acres_required` DECIMAL(18,2) COMMENT 'Estimated gross surface acres required to support the prospect development plan including surface use and drilling locations.',
    `estimated_net_acres_required` DECIMAL(18,2) COMMENT 'Estimated net mineral acres required to support the prospect development plan. Drives leasing acquisition targets and acreage position strategy.',
    `estimated_ultimate_recovery_boe` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery potential of the prospect expressed in barrels of oil equivalent. Drives economic evaluation and leasing justification.',
    `federal_land_flag` BOOLEAN COMMENT 'Indicates whether the prospect includes federal lands requiring compliance with BOEM or BLM regulations. True if federal lands are involved.',
    `formation_target` STRING COMMENT 'Primary geological formation or reservoir target for drilling and production. Defines depth and leasing depth restrictions.',
    `geographic_boundary_description` STRING COMMENT 'Textual description of the geographic area of interest for leasing. Includes legal descriptions, section-township-range references, or coordinate boundaries.',
    `leasing_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for lease acquisition, bonus payments, and delay rentals for this prospect. Expressed in functional currency.',
    `leasing_budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for the leasing budget amount. Required for multi-currency portfolio reporting and consolidation. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|BRL|MXN|NOK|AUD — 8 candidates stripped; promote to reference product]',
    `leasing_priority` STRING COMMENT 'Business priority assigned to this leasing prospect relative to other opportunities. Drives resource allocation and budget prioritization.. Valid values are `critical|high|medium|low|deferred`',
    `leasing_start_date` DATE COMMENT 'Date when leasing activities commenced for this prospect. Marks the beginning of the land acquisition campaign.',
    `leasing_status` STRING COMMENT 'Current status of leasing activities for this prospect. Indicates progress toward acreage acquisition targets and readiness for drilling.. Valid values are `open_acreage|partially_leased|substantially_leased|fully_leased|on_hold|abandoned`',
    `net_revenue_interest_target_percent` DECIMAL(18,2) COMMENT 'Target net revenue interest percentage after royalty burdens. Used for economic modeling and investment decision support.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special considerations, or contextual information about the leasing prospect. Supports operational decision-making.',
    `offshore_flag` BOOLEAN COMMENT 'Indicates whether the prospect is located in offshore waters requiring BOEM permits and offshore safety compliance. True if offshore.',
    `play_type` STRING COMMENT 'Classification of the geological play type that defines the exploration and production strategy. Determines leasing approach and acreage requirements.. Valid values are `conventional|unconventional_shale|unconventional_tight_gas|unconventional_coalbed_methane|deepwater|ultra_deepwater`',
    `prospect_risk_classification` STRING COMMENT 'Risk classification of the exploration prospect based on geological certainty, technical complexity, and commercial viability. Influences leasing strategy and investment decisions.. Valid values are `low_risk|moderate_risk|high_risk|exploratory|appraisal|development`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leasing prospect record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_status` STRING COMMENT 'Current lifecycle status of this leasing prospect record. Indicates whether the record is actively used or has been retired.. Valid values are `active|inactive|archived|deleted`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this leasing prospect record was last modified. Used for audit trail and change tracking.',
    `reserves_category` STRING COMMENT 'Classification of reserves or resources associated with this prospect per SPE PRMS standards. Determines booking eligibility and disclosure requirements.. Valid values are `prospective|contingent|proved|probable|possible`',
    `secondary_formation_target` STRING COMMENT 'Secondary or alternative geological formation target that may be pursued if primary target is not viable. Supports multi-zone development strategy.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code where the leasing prospect is located. Used for regulatory compliance and jurisdictional reporting.',
    `target_completion_date` DATE COMMENT 'Target date by which leasing activities should be substantially complete to support drilling schedule. Used for project planning and milestone tracking.',
    `target_depth_feet` DECIMAL(18,2) COMMENT 'Target drilling depth in feet to reach the primary formation. Used for lease depth restriction negotiations and drilling cost estimation.',
    `tribal_land_flag` BOOLEAN COMMENT 'Indicates whether the prospect includes tribal or Native American lands requiring special consultation and approval processes. True if tribal lands are involved.',
    `water_depth_feet` DECIMAL(18,2) COMMENT 'Water depth in feet for offshore prospects. Determines drilling complexity, cost, and regulatory requirements. Null for onshore prospects.',
    `working_interest_target_percent` DECIMAL(18,2) COMMENT 'Target working interest percentage the company aims to acquire in this prospect. Drives leasing strategy and partnership negotiations.',
    CONSTRAINT pk_leasing_prospect PRIMARY KEY(`leasing_prospect_id`)
) COMMENT 'Master record linking land and lease activities to upstream exploration prospects and plays. Captures prospect name, play type, basin, formation targets, geographic boundary, estimated net acres required, leasing status (open acreage, partially leased, fully leased), leasing budget, and prospect risk classification. Bridges the land domain with the exploration domain to ensure leasing activities are aligned with prospect development priorities. Supports acreage position strategy and CAPEX planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` (
    `land_regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the land regulatory filing record. Primary key for this entity.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the operator party responsible for submitting and managing this regulatory filing. Identifies the company acting as operator for the lease or well.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Land-specific regulatory filings are a subset of all regulatory filings. Links land domain filings to enterprise compliance tracking for consolidated reporting, audit trails, and compliance calendar m',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Regulatory consultants and attorneys are vendors providing filing/compliance services. Real procurement relationship for professional services supporting land regulatory compliance. Role-prefixed to d',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well record if this filing relates to well-specific regulatory actions such as drilling permits, spacing exceptions, or location exceptions. Null for non-well filings.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Regulatory filings (pooling orders, unitization) reference the governing JOA. Joa_id enables partner notification, voting threshold compliance, and tracking of regulatory approvals affecting joint ope',
    `lease_id` BIGINT COMMENT 'Reference to the lease record associated with this regulatory filing. Links filing to the specific lease requiring regulatory action or approval.',
    `pooling_unit_id` BIGINT COMMENT 'Reference to the pooling unit record if this filing relates to pooling or unitization actions. Null for non-pooling filings.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who prepared and submitted this regulatory filing. Used for accountability and workflow tracking.',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Right-of-way agreements often require regulatory filings for environmental clearance, cultural resource surveys, and permits (e.g., Army Corps of Engineers wetlands permits, state environmental permit',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Surface use agreements may require regulatory filings for environmental clearances, cultural resource clearances, and permits before surface disturbance can occur. Adding surface_use_agreement_id FK l',
    `tract_id` BIGINT COMMENT 'Reference to the land tract record if this filing relates to tract-specific regulatory actions. Null for non-tract filings.',
    `api_well_number` STRING COMMENT 'Standardized API well number for the well associated with this filing. Unique 10-14 digit identifier assigned by regulatory agencies for well tracking.',
    `approval_date` DATE COMMENT 'Date when the regulatory agency officially approved or denied the filing. Null if still pending or withdrawn.',
    `approval_status` STRING COMMENT 'Final disposition status indicating whether the regulatory agency approved, denied, or conditionally approved the filing.. Valid values are `pending|approved|conditionally_approved|denied|withdrawn`',
    `conditions_of_approval` STRING COMMENT 'Special conditions, restrictions, or requirements imposed by the regulatory agency as part of the approval. Null if no conditions apply or filing is not approved.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the country where the land or well subject to this regulatory filing is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County name where the land or well subject to this regulatory filing is located. Used for jurisdictional and reporting purposes.',
    `denial_reason` STRING COMMENT 'Explanation provided by the regulatory agency for denying the filing. Null if filing was approved or is still pending.',
    `depth_from_feet` DECIMAL(18,2) COMMENT 'Starting depth in feet for depth-restricted regulatory filings. Defines the upper boundary of the depth interval covered by the filing.',
    `depth_to_feet` DECIMAL(18,2) COMMENT 'Ending depth in feet for depth-restricted regulatory filings. Defines the lower boundary of the depth interval covered by the filing.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the physical or electronic filing document stored in the document management system. Enables retrieval of supporting documentation.',
    `effective_date` DATE COMMENT 'Date when the approved regulatory action becomes legally effective and enforceable. May differ from approval date based on regulatory requirements.',
    `expiration_date` DATE COMMENT 'Date when the regulatory approval expires or the filing becomes invalid, requiring renewal or re-filing. Null for filings without expiration.',
    `field_name` STRING COMMENT 'Name of the oil or gas field associated with this regulatory filing, if applicable. Provides geological and operational context.',
    `filing_date` DATE COMMENT 'Date when the regulatory filing was officially submitted to the regulatory agency. Represents the principal business event timestamp for this transaction.',
    `filing_description` STRING COMMENT 'Detailed narrative description of the regulatory filing purpose, scope, and requested action. Provides business context and justification for the filing.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the filing fee charged by the regulatory agency for processing this submission. Null if no fee applies.',
    `filing_fee_currency_code` STRING COMMENT 'Three-letter ISO currency code for the filing fee amount (e.g., USD, CAD). Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `filing_number` STRING COMMENT 'Externally-known unique filing number or reference code assigned by the regulatory agency or internal tracking system for this submission.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing in the approval workflow. Tracks progression from initial submission through final disposition. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|denied|withdrawn|pending_additional_info — 7 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'Classification of the regulatory filing submission type. Indicates the nature of the regulatory action or approval being sought. [ENUM-REF-CANDIDATE: pooling_application|unitization_order|spacing_exception|well_location_exception|lease_assignment|drilling_permit|surface_use_permit|environmental_impact_statement|right_of_way_application|abandonment_notice|production_report|other — promote to reference product]',
    `formation_name` STRING COMMENT 'Geological formation or reservoir name targeted by this regulatory filing, if applicable (e.g., Bakken, Permian, Marcellus). Relevant for drilling and spacing filings.',
    `gross_acres` DECIMAL(18,2) COMMENT 'Total surface acreage covered by this regulatory filing, regardless of ownership interest. Represents the full geographic scope of the filing.',
    `internal_approval_date` DATE COMMENT 'Date when the filing received internal company approval before submission to the regulatory agency. Tracks internal compliance workflow.',
    `legal_description` STRING COMMENT 'Full legal land description for the area covered by this regulatory filing, using township, range, section, and subdivision notation (e.g., NE/4 NW/4 Section 12, T5N, R3W).',
    `net_acres` DECIMAL(18,2) COMMENT 'Net acreage covered by this regulatory filing, adjusted for ownership interest. Represents the companys proportional interest in the filing area.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or internal notes related to this regulatory filing. Used for operational context and knowledge capture.',
    `operator_name` STRING COMMENT 'Name of the operator company responsible for this regulatory filing. Provides human-readable reference for operational users.',
    `payment_date` DATE COMMENT 'Date when the filing fee was paid to the regulatory agency. Used for financial reconciliation and compliance tracking.',
    `payment_reference_number` STRING COMMENT 'Payment confirmation or transaction reference number for the filing fee payment. Used for audit trail and reconciliation.',
    `permit_number` STRING COMMENT 'Official permit or authorization number issued by the regulatory agency upon approval. Used for compliance tracking and field operations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was last modified in the system. Used for audit trail and change tracking.',
    `regulatory_agency` STRING COMMENT 'Name of the federal, state, or local regulatory agency to which the filing was submitted (e.g., BOEM, Texas Railroad Commission, North Dakota Industrial Commission, BLM).',
    `regulatory_agency_code` STRING COMMENT 'Standardized code or abbreviation for the regulatory agency (e.g., BOEM, BSEE, RRC, NDIC) for system integration and reporting purposes.',
    `state_province` STRING COMMENT 'State or province where the land or well subject to this regulatory filing is located. Critical for determining applicable regulatory jurisdiction.',
    CONSTRAINT pk_land_regulatory_filing PRIMARY KEY(`land_regulatory_filing_id`)
) COMMENT 'Transactional record for regulatory filings and submissions required by state and federal agencies related to land and lease operations, including pooling applications, unitization orders, spacing exceptions, well location exceptions, and lease assignments requiring regulatory approval. Captures filing type, regulatory agency (BOEM, state oil and gas commission), filing date, approval status, approval date, permit number, and associated lease or pooling unit. Supports compliance tracking for land operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`unit_participation` (
    `unit_participation_id` BIGINT COMMENT 'Unique identifier for this unit participation record. Primary key.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to the lease that participates in the pooling unit',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to the pooling unit in which the lease participates',
    `allocation_method` STRING COMMENT 'The method used to calculate this leases participation factor and allocate production/costs. Common methods: acreage (proportional to acres), surface_acreage, subsurface_acreage, well_count, production_potential, regulatory_formula (state-mandated calculation).',
    `cost_bearing_status` STRING COMMENT 'Indicates whether this lease participation bears its proportional share of drilling and operating costs. Values: cost_bearing (pays proportional costs), non_cost_bearing (receives revenue only), carried_interest (costs carried by other parties), back_in_after_payout (becomes cost-bearing after payout).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this unit participation record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this leases participation in the pooling unit becomes effective. May differ from the units overall effective date if leases are added to the unit over time.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this unit participation record was last modified.',
    `lease_acres_in_unit` DECIMAL(18,2) COMMENT 'The acreage of the lease that is included within the pooling unit boundaries. Used for calculating participation factors and allocation percentages.',
    `lease_net_revenue_interest_in_unit` DECIMAL(18,2) COMMENT 'The net revenue interest percentage that this specific lease holds within the pooling unit context, after accounting for royalties and overriding interests specific to this participation.',
    `lease_participation_factor` DECIMAL(18,2) COMMENT 'The decimal factor representing this leases proportional participation in the pooling unit, used for allocating production, revenue, and costs. Typically calculated based on acreage, net revenue interest, or regulatory formula.',
    `lease_working_interest_in_unit` DECIMAL(18,2) COMMENT 'The working interest percentage that this specific lease contributes to the pooling unit. May differ from the leases overall working interest if only a portion of the lease participates.',
    `participating_status` STRING COMMENT 'Current participation status of this lease in the pooling unit. Values: participating (actively included in unit operations and allocation), non_participating (excluded from current operations), suspended (temporarily inactive), pending_approval (awaiting regulatory or contractual approval).',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory order or approval document that authorizes this leases participation in the pooling unit. Required for compulsory pooling arrangements.',
    `termination_date` DATE COMMENT 'Date when this leases participation in the pooling unit terminates. Null if participation is ongoing.',
    `unit_agreement_exhibit_reference` STRING COMMENT 'Reference to the specific exhibit or schedule in the unit operating agreement that documents this leases participation terms, allocation factors, and interest percentages.',
    CONSTRAINT pk_unit_participation PRIMARY KEY(`unit_participation_id`)
) COMMENT 'This association product represents the participation of a lease in a pooling or unitization unit. It captures the contractual and regulatory relationship between a lease and the pooling unit it participates in, including allocation factors, participating acreage, interest percentages, and participation status. Each record links one lease to one pooling unit with attributes that exist only in the context of this participation relationship. This is a critical operational entity for revenue accounting, joint interest billing, and production allocation processes.. Existence Justification: In oil and gas land administration, a pooling unit combines multiple leases to develop a common reservoir, and a single lease can participate in multiple pooling units if it covers acreage in different formations or geographic areas. The business actively manages unit participation through unit operating agreements, participation schedules maintained in land systems, and detailed allocation factors used by revenue accounting and joint interest billing systems. This is a recognized operational relationship with contractual, regulatory, and financial significance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_tract` (
    `lease_tract_id` BIGINT COMMENT 'Unique identifier for the lease-tract assignment record. Primary key.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to the lease master record',
    `tract_id` BIGINT COMMENT 'Foreign key linking to the tract master record',
    `assignment_source` STRING COMMENT 'How this tract became part of this lease (original lease execution, amendment, pooling, etc.). Critical for audit and title tracking.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this lease-tract assignment record was created in the system.',
    `depth_restriction` STRING COMMENT 'Depth interval or formation restriction for this lease-tract combination (e.g., Surface to base of Wolfcamp, 5000ft to 10000ft). Critical for stacked lease scenarios.',
    `effective_date` DATE COMMENT 'Date when this tract became part of this lease. May differ from the lease effective date if tracts are added via amendment or pooling.',
    `expiration_date` DATE COMMENT 'Date when this tract is no longer covered by this lease. May differ from lease expiration if tracts are released or subdivided.',
    `gross_acres_in_lease` DECIMAL(18,2) COMMENT 'Gross acreage of this specific tract covered by this specific lease, regardless of ownership percentage. Used for lease compliance and acreage reporting.',
    `lease_status_for_tract` STRING COMMENT 'Status of this specific lease-tract assignment. A lease may be active for some tracts but expired or released for others.',
    `mineral_rights_type` STRING COMMENT 'Type of mineral rights covered by this lease-tract assignment. A tract may have different leases for different mineral types.',
    `net_acres_in_lease` DECIMAL(18,2) COMMENT 'Net acreage of this specific tract allocated to this specific lease, adjusted for ownership percentage. Critical for royalty calculations and acreage position reporting.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Net revenue interest percentage for this specific lease-tract combination. Calculated after deducting royalties and may vary by tract.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this lease-tract assignment record was last updated.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Working interest percentage for this specific lease-tract combination. May vary by tract within the same lease due to different ownership structures.',
    CONSTRAINT pk_lease_tract PRIMARY KEY(`lease_tract_id`)
) COMMENT 'This association product represents the operational assignment of specific tracts to oil and gas leases. It captures the fundamental land administration relationship where a single lease can cover multiple non-contiguous tracts, and a single tract can be included in multiple overlapping leases (e.g., different depths, different mineral rights, or stacked leases). Each record links one lease to one tract with acreage allocations, interest percentages, and effective dates that exist only in the context of this specific lease-tract combination.. Existence Justification: In oil and gas land administration, leases routinely cover multiple non-contiguous tracts (a single lease agreement can span dozens of tracts across a field), and tracts are frequently included in multiple leases simultaneously due to depth severance (stacked leases at different depths), split mineral rights (separate oil vs gas leases), or overlapping lease periods during transitions. Land departments actively manage lease-tract assignments through acreage schedules, tract participation records, and amendment tracking, with specific acreage allocations, interest percentages, and effective dates maintained for each lease-tract combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`lease_interest` (
    `lease_interest_id` BIGINT COMMENT 'Unique surrogate identifier for each working interest position record. Primary key for the lease_interest association.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to the counterparty holding the working interest position in this lease. Identifies the party (IOC, NOC, independent operator, or working interest owner) with ownership stake and revenue entitlement.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to the oil and gas lease in which the counterparty holds a working interest position. Identifies the specific mineral rights agreement subject to joint ownership.',
    `acquisition_method` STRING COMMENT 'Method by which this counterparty acquired their working interest position. Original lease indicates they were a party to the initial lease agreement. Farm-in indicates they earned interest through drilling or development obligations. Assignment indicates purchase from another working interest owner. Used for audit trail and title verification.',
    `cost_bearing_flag` BOOLEAN COMMENT 'Indicates whether this counterparty bears their proportionate share of lease operating costs and capital expenditures. In some carried interest arrangements, a party may hold working interest without bearing costs during initial development. Used for joint interest billing (JIB) and AFE cost allocation.',
    `created_date` TIMESTAMP COMMENT 'System timestamp when this lease interest record was created in the land system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date when this counterpartys working interest position became effective. Marks the start of their ownership stake, cost-bearing obligations, and revenue entitlement. Critical for production allocation and royalty calculation temporal logic.',
    `interest_type` STRING COMMENT 'Classification of the type of interest held by this counterparty in the lease. Distinguishes between standard working interest (cost-bearing ownership), overriding royalty interest (revenue share without costs), carried interest (non-cost-bearing during payout), and back-in interest (contingent future interest after payout). Determines cost allocation and revenue distribution treatment.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue this counterparty receives after deducting royalties, overriding royalties, and other burdens from their working interest. Calculated as working_interest_percent minus all revenue deductions. Used for production allocation and revenue distribution.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether this counterparty is designated as the operator of the lease. The operator is responsible for day-to-day operations, drilling, production, and regulatory compliance. Typically only one working interest owner per lease has operator_flag = true.',
    `overriding_royalty_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue carved out of the working interest and paid to a third party. Does not bear operating costs. [Moved from lease: This attribute currently exists in the lease product but represents a specific partys ORRI carve-out, not a lease-level aggregate. Multiple parties may hold different ORRI percentages in the same lease. This attribute belongs in the lease_interest association to support multiple ORRI holders per lease.]',
    `payout_status` STRING COMMENT 'Indicates whether this working interest position has reached payout (recovery of capital costs). Pre-payout indicates the counterparty is still recovering their investment. Post-payout indicates capital has been recovered and different revenue sharing terms may apply. Relevant for carried interest and back-in interest arrangements.',
    `termination_date` DATE COMMENT 'Date when this counterpartys working interest position terminated due to sale, assignment, or lease expiration. Null indicates the interest is currently active. Used to track historical ownership changes and calculate revenue entitlement periods.',
    `updated_date` TIMESTAMP COMMENT 'System timestamp when this lease interest record was last modified. Used for change tracking and data synchronization with downstream systems (royalty, JIB, production allocation).',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage ownership of the operating rights and cost-bearing obligations in the lease held by this counterparty. Represents the partys share of capital expenditures, operating expenses, and gross production. Sum of all working interests in a lease typically equals 100%.',
    CONSTRAINT pk_lease_interest PRIMARY KEY(`lease_interest_id`)
) COMMENT 'This association product represents the Working Interest Position between customer_counterparty and lease. It captures the joint operating agreement terms that define each counterpartys ownership stake, revenue entitlement, and operational responsibilities in a specific oil and gas lease. Each record links one customer_counterparty to one lease with attributes that exist only in the context of this co-ownership relationship, including working interest percentage, net revenue interest, operator designation, and cost-bearing obligations.. Existence Justification: In oil and gas joint ventures, multiple counterparties (IOCs, NOCs, independent operators) routinely hold simultaneous working interest positions in a single lease, and each counterparty typically holds interests across a portfolio of multiple leases. The business actively manages these working interest positions as operational records with specific attributes (working interest %, net revenue interest %, operator designation, effective dates) that belong to neither the counterparty nor the lease alone, but to the specific counterparty-lease combination. This is the core business concept of Lease Interest or Working Interest Position tracked in land systems and consumed by royalty, JIB, and production allocation processes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`tax_entity` (
    `tax_entity_id` BIGINT COMMENT 'Primary key for tax_entity',
    `parent_entity_id` BIGINT COMMENT 'Identifier of the parent tax entity in a hierarchical relationship, if applicable.',
    `parent_tax_entity_id` BIGINT COMMENT 'Self-referencing FK on tax_entity (parent_tax_entity_id)',
    `address_line1` STRING COMMENT 'Primary street address of the tax entity.',
    `city` STRING COMMENT 'City component of the tax entitys address.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the entity with tax reporting obligations.',
    `contact_name` STRING COMMENT 'Primary contact person for the tax entity.',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code for the tax entitys location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the tax entity record was first created in the system.',
    `tax_entity_description` STRING COMMENT 'Free‑form description of the tax entitys business purpose or notes.',
    `effective_from` DATE COMMENT 'Date when the tax entity became effective for reporting purposes.',
    `effective_until` DATE COMMENT 'Date when the tax entity ceases to be effective; null if still active.',
    `email_address` STRING COMMENT 'Primary email address for communications with the tax entity.',
    `entity_type` STRING COMMENT 'Classification of the tax entity based on legal structure.',
    `foreign_tax_code` STRING COMMENT 'Tax identification number issued by the foreign jurisdiction.',
    `is_foreign_entity` BOOLEAN COMMENT 'True if the tax entity is organized outside the United States.',
    `last_review_date` DATE COMMENT 'Date when the tax entity record was last reviewed for accuracy.',
    `tax_entity_name` STRING COMMENT 'Legal name of the tax entity as used in contracts and tax filings.',
    `phone_number` STRING COMMENT 'Primary telephone number for the tax entity.',
    `registration_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the registration jurisdiction.',
    `registration_number` STRING COMMENT 'Official registration number (e.g., EIN) assigned by the corporate registry.',
    `registration_state` STRING COMMENT 'State where the entity is legally registered.',
    `state` STRING COMMENT 'State or province component of the tax entitys address.',
    `tax_entity_status` STRING COMMENT 'Current lifecycle status of the tax entity record.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the entity is exempt from withholding tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason for tax exemption, if applicable.',
    `tax_form_type` STRING COMMENT 'Standard tax form associated with the entity (e.g., W‑9, 1099).',
    `tax_id_number` STRING COMMENT 'Government‑issued tax identification number for the entity (e.g., EIN, SSN, GSTIN).',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction (e.g., IRS, state tax authority).',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Standard tax rate applicable to the entity, expressed as a percent.',
    `tax_withholding_percent` DECIMAL(18,2) COMMENT 'Withholding tax percentage applied to payments to the entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the tax entity record.',
    `zip_code` STRING COMMENT 'Postal/ZIP code for the tax entitys address.',
    CONSTRAINT pk_tax_entity PRIMARY KEY(`tax_entity_id`)
) COMMENT 'Master reference table for tax_entity. Referenced by payee_tax_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Identifier of the parent party if this party is a subsidiary or affiliate.',
    `address_line1` STRING COMMENT 'First line of the partys mailing address.',
    `address_line2` STRING COMMENT 'Second line of the partys mailing address.',
    `bank_account_number` STRING COMMENT 'Bank account number for payments to the party.',
    `bank_routing_number` STRING COMMENT 'Bank routing number (e.g., ABA) for the partys bank.',
    `city` STRING COMMENT 'City of the partys address.',
    `classification` STRING COMMENT 'Business classification of the party.',
    `contact_person_email` STRING COMMENT 'Email address of the primary contact person.',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person for the party.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the partys address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the party record was first created.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the party. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|NR — promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code used for transactions with the party.',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates if the party has consented to data sharing.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the party.',
    `effective_from` DATE COMMENT 'Date when the party relationship becomes effective.',
    `effective_to` DATE COMMENT 'Date when the party relationship ends or expires.',
    `email_address` STRING COMMENT 'Primary email address for the party.',
    `external_party_code` STRING COMMENT 'Identifier for the party in the external source system.',
    `industry_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS) for the party.',
    `is_active` BOOLEAN COMMENT 'Flag indicating if the party is currently active in the system.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates if the party is tax-exempt.',
    `is_vat_registered` BOOLEAN COMMENT 'Indicates if the party is registered for VAT.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact with the party.',
    `legal_entity_identifier` STRING COMMENT 'Global legal entity identifier for the party.',
    `notes` STRING COMMENT 'Free-text notes about the party.',
    `party_name` STRING COMMENT 'Legal name of the party (person or organization).',
    `party_type` STRING COMMENT 'Indicates whether the party is an individual, organization, joint venture, or government entity.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30) agreed with the party.',
    `phone_number` STRING COMMENT 'Primary telephone number for the party.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the partys address.',
    `preferred_language` STRING COMMENT 'Preferred language for communications.',
    `primary_contact_method` STRING COMMENT 'Preferred primary contact channel for the party.',
    `registration_number` STRING COMMENT 'Official registration number of the organization.',
    `source_system` STRING COMMENT 'Name of the source system where the party data originated.',
    `state_province` STRING COMMENT 'State or province of the partys address.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party.',
    `tax_classification` STRING COMMENT 'Tax classification applicable to the party.',
    `tax_identifier` STRING COMMENT 'Tax identification number (e.g., EIN for organizations, SSN for individuals).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by lessor_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`operator` (
    `operator_id` BIGINT COMMENT 'Primary key for operator',
    `address_line1` STRING COMMENT 'First line of the operators mailing address.',
    `address_line2` STRING COMMENT 'Second line of the operators mailing address, if applicable.',
    `city` STRING COMMENT 'City component of the operators address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the operators primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the operator record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for financial reporting of the operator.',
    `effective_from` DATE COMMENT 'Date when the operator record became effective.',
    `effective_until` DATE COMMENT 'Date when the operator record expires or is superseded; null if still active.',
    `external_reference_code` STRING COMMENT 'Identifier used to reference the operator in external systems such as Quorum Land.',
    `incorporation_date` DATE COMMENT 'Date on which the operator was legally incorporated.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the operator is exempt from certain taxes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the operator record.',
    `legal_name` STRING COMMENT 'Full legal name of the operating entity as registered.',
    `license_expiry_date` DATE COMMENT 'Expiration date of the operators regulatory license.',
    `license_number` STRING COMMENT 'Regulatory license number authorizing the operator to conduct activities.',
    `naics_code` STRING COMMENT 'North American Industry Classification System code for the operators primary activity.',
    `operator_name` STRING COMMENT 'Common name used to refer to the operator.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the operator.',
    `operator_category` STRING COMMENT 'Business segment in which the operator primarily operates.',
    `operator_code` STRING COMMENT 'Unique alphanumeric code assigned to the operator for reference.',
    `operator_role` STRING COMMENT 'Specific role the entity plays in lease and production arrangements.',
    `operator_type` STRING COMMENT 'Category describing the nature of the operator entity.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership the parent operator holds in this entity.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the operators address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the operator.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `sic_code` STRING COMMENT 'Standard Industrial Classification code for the operator.',
    `state_of_incorporation` STRING COMMENT 'U.S. state or jurisdiction where the operator was incorporated.',
    `state_province` STRING COMMENT 'State or province component of the operators address.',
    `operator_status` STRING COMMENT 'Current lifecycle status of the operator.',
    `status_effective_date` DATE COMMENT 'Date on which the current status became effective.',
    `tax_code` STRING COMMENT 'Government‑issued tax identification number for the operator.',
    `website_url` STRING COMMENT 'Public website address for the operator.',
    CONSTRAINT pk_operator PRIMARY KEY(`operator_id`)
) COMMENT 'Master reference table for operator. Referenced by operator_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`escheatment_report` (
    `escheatment_report_id` BIGINT COMMENT 'Primary key for escheatment_report',
    `parent_escheatment_report_id` BIGINT COMMENT 'Self-referencing FK on escheatment_report (parent_escheatment_report_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (e.g., penalties, interest) applied to the total unclaimed amount.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report received final approval.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values in the report.',
    `escheatment_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum balance amount that triggers escheatment under state law.',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the report has been reviewed and approved for submission.',
    `jurisdiction_state_code` STRING COMMENT 'Two‑letter ISO code of the U.S. state whose unclaimed property is being reported.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount to be escheated after adjustments, expressed in the report currency.',
    `number_of_accounts` STRING COMMENT 'Count of distinct account numbers that have unclaimed balances in the period.',
    `number_of_owners` STRING COMMENT 'Count of unique owners (individuals or entities) associated with the unclaimed balances.',
    `period_end_date` DATE COMMENT 'Last calendar day of the reporting period covered by the escheatment report.',
    `period_start_date` DATE COMMENT 'First calendar day of the reporting period covered by the escheatment report.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the report record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the report record.',
    `report_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special notes for the report.',
    `report_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the report was generated.',
    `report_number` STRING COMMENT 'External reference number assigned to the escheatment report by the reporting system.',
    `report_type` STRING COMMENT 'Classification of the report based on its periodicity or purpose.',
    `reporting_entity_code` BIGINT COMMENT 'Identifier of the business unit or legal entity that produced the report.',
    `escheatment_report_status` STRING COMMENT 'Current processing state of the escheatment report.',
    `submission_method` STRING COMMENT 'Channel used to deliver the report to the state authority.',
    `submitted_to_state_date` DATE COMMENT 'Date on which the escheatment report was officially submitted to the state agency.',
    `total_unclaimed_amount` DECIMAL(18,2) COMMENT 'Aggregate dollar amount of all unclaimed balances identified for the reporting period.',
    CONSTRAINT pk_escheatment_report PRIMARY KEY(`escheatment_report_id`)
) COMMENT 'Master reference table for escheatment_report. Referenced by escheatment_report_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`land`.`property` (
    `property_id` BIGINT COMMENT 'Primary key for property',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Property represents a land parcel and shares geographic attributes with tract. Adding property_tract_id FK normalizes location data, removes duplicated columns, and connects the previously isolated pr',
    `parent_property_id` BIGINT COMMENT 'Self-referencing FK on property (parent_property_id)',
    `acreage` DECIMAL(18,2) COMMENT 'Total land area measured in acres.',
    `classification` STRING COMMENT 'Business classification indicating the property’s lifecycle stage.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the property location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the property record was first created in the system.',
    `drilling_permit_expiry` DATE COMMENT 'Expiration date of the drilling permit.',
    `drilling_permit_number` STRING COMMENT 'Identifier of the active drilling permit, if any.',
    `effective_date` DATE COMMENT 'Date when the property record became effective for reporting.',
    `elevation_ft` STRING COMMENT 'Elevation above sea level in feet.',
    `environmental_status` STRING COMMENT 'Status of environmental compliance for the property.',
    `expiration_date` DATE COMMENT 'Date when the property record is no longer valid (if applicable).',
    `is_historical` BOOLEAN COMMENT 'True if the record represents a historical snapshot rather than a current active property.',
    `land_use_type` STRING COMMENT 'Current land use designation for the property.',
    `last_valuation_date` DATE COMMENT 'Date when the most recent valuation was performed.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the property centroid.',
    `lease_expiration_date` DATE COMMENT 'Date on which the current lease on the property expires.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the property centroid.',
    `mineral_ownership_type` STRING COMMENT 'Classification of mineral ownership rights for the property.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Net revenue interest percentage for the property.',
    `parcel_number` STRING COMMENT 'Government‑issued parcel identifier for the land parcel.',
    `property_name` STRING COMMENT 'Human‑readable name or title of the property.',
    `property_type` STRING COMMENT 'Primary resource type produced or managed on the property.',
    `royalty_owner` STRING COMMENT 'Name of the entity that receives royalty payments for the property.',
    `state` STRING COMMENT 'State or province where the property resides.',
    `property_status` STRING COMMENT 'Current operational status of the property.',
    `surface_area_acres` DECIMAL(18,2) COMMENT 'Surface area of the property in acres (may differ from total acreage due to topography).',
    `surface_use_agreement_expiry` DATE COMMENT 'Expiration date of the surface use agreement, if applicable.',
    `surface_use_agreement_flag` BOOLEAN COMMENT 'Indicates whether a surface use agreement is in place (true) or not (false).',
    `tax_assessed_value` DECIMAL(18,2) COMMENT 'Assessed monetary value of the property for tax purposes.',
    `tax_assessed_year` STRING COMMENT 'Fiscal year for which the tax assessment applies.',
    `tax_code` STRING COMMENT 'Tax assessment identifier assigned by the taxing authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the property record.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Monetary valuation of the property.',
    `valuation_currency` STRING COMMENT 'Currency code of the valuation amount.',
    `valuation_method` STRING COMMENT 'Methodology used to determine the property’s valuation.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of the working interest held by the company.',
    `zoning_code` STRING COMMENT 'Local government zoning classification code.',
    CONSTRAINT pk_property PRIMARY KEY(`property_id`)
) COMMENT 'Master reference table for property. Referenced by property_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_title_opinion_id` FOREIGN KEY (`title_opinion_id`) REFERENCES `oil_gas_ecm`.`land`.`title_opinion`(`title_opinion_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_previous_division_order_id` FOREIGN KEY (`previous_division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_title_opinion_id` FOREIGN KEY (`title_opinion_id`) REFERENCES `oil_gas_ecm`.`land`.`title_opinion`(`title_opinion_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ADD CONSTRAINT `fk_land_land_working_interest_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ADD CONSTRAINT `fk_land_land_working_interest_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ADD CONSTRAINT `fk_land_title_opinion_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ADD CONSTRAINT `fk_land_title_opinion_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_party_id` FOREIGN KEY (`party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ADD CONSTRAINT `fk_land_lease_expiry_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_tax_entity_id` FOREIGN KEY (`tax_entity_id`) REFERENCES `oil_gas_ecm`.`land`.`tax_entity`(`tax_entity_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_grantor_id` FOREIGN KEY (`grantor_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_grantor_party_id` FOREIGN KEY (`grantor_party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ADD CONSTRAINT `fk_land_lease_amendment_party_id` FOREIGN KEY (`party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ADD CONSTRAINT `fk_land_lease_amendment_lessor_party_id` FOREIGN KEY (`lessor_party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ADD CONSTRAINT `fk_land_lease_amendment_operator_party_id` FOREIGN KEY (`operator_party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ADD CONSTRAINT `fk_land_lease_amendment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ADD CONSTRAINT `fk_land_lease_amendment_superseded_by_amendment_lease_amendment_id` FOREIGN KEY (`superseded_by_amendment_lease_amendment_id`) REFERENCES `oil_gas_ecm`.`land`.`lease_amendment`(`lease_amendment_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ADD CONSTRAINT `fk_land_lease_amendment_title_opinion_id` FOREIGN KEY (`title_opinion_id`) REFERENCES `oil_gas_ecm`.`land`.`title_opinion`(`title_opinion_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_division_order_id` FOREIGN KEY (`division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_division_order_id` FOREIGN KEY (`division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_escheatment_report_id` FOREIGN KEY (`escheatment_report_id`) REFERENCES `oil_gas_ecm`.`land`.`escheatment_report`(`escheatment_report_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_title_opinion_id` FOREIGN KEY (`title_opinion_id`) REFERENCES `oil_gas_ecm`.`land`.`title_opinion`(`title_opinion_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_curative_action_id` FOREIGN KEY (`curative_action_id`) REFERENCES `oil_gas_ecm`.`land`.`curative_action`(`curative_action_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_interest_assignment_id` FOREIGN KEY (`interest_assignment_id`) REFERENCES `oil_gas_ecm`.`land`.`interest_assignment`(`interest_assignment_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_lease_amendment_id` FOREIGN KEY (`lease_amendment_id`) REFERENCES `oil_gas_ecm`.`land`.`lease_amendment`(`lease_amendment_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `oil_gas_ecm`.`land`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ADD CONSTRAINT `fk_land_lease_document_title_opinion_id` FOREIGN KEY (`title_opinion_id`) REFERENCES `oil_gas_ecm`.`land`.`title_opinion`(`title_opinion_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ADD CONSTRAINT `fk_land_orri_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ADD CONSTRAINT `fk_land_orri_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_title_opinion_id` FOREIGN KEY (`title_opinion_id`) REFERENCES `oil_gas_ecm`.`land`.`title_opinion`(`title_opinion_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `oil_gas_ecm`.`land`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ADD CONSTRAINT `fk_land_unit_participation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ADD CONSTRAINT `fk_land_unit_participation_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ADD CONSTRAINT `fk_land_lease_tract_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ADD CONSTRAINT `fk_land_lease_tract_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ADD CONSTRAINT `fk_land_lease_interest_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ADD CONSTRAINT `fk_land_tax_entity_parent_entity_id` FOREIGN KEY (`parent_entity_id`) REFERENCES `oil_gas_ecm`.`land`.`tax_entity`(`tax_entity_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ADD CONSTRAINT `fk_land_tax_entity_parent_tax_entity_id` FOREIGN KEY (`parent_tax_entity_id`) REFERENCES `oil_gas_ecm`.`land`.`tax_entity`(`tax_entity_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`party` ADD CONSTRAINT `fk_land_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`escheatment_report` ADD CONSTRAINT `fk_land_escheatment_report_parent_escheatment_report_id` FOREIGN KEY (`parent_escheatment_report_id`) REFERENCES `oil_gas_ecm`.`land`.`escheatment_report`(`escheatment_report_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`property` ADD CONSTRAINT `fk_land_property_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`property` ADD CONSTRAINT `fk_land_property_parent_property_id` FOREIGN KEY (`parent_property_id`) REFERENCES `oil_gas_ecm`.`land`.`property`(`property_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`land` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`land` SET TAGS ('dbx_domain' = 'land');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Lessee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Acquisition Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `api_lease_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Lease Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `bonus_consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Consideration Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `bonus_consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `delay_rental_amount` SET TAGS ('dbx_business_glossary_term' = 'Delay Rental Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `delay_rental_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `depth_restriction_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth Restriction (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `federal_lease_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Lease Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `formation_restriction` SET TAGS ('dbx_business_glossary_term' = 'Formation Restriction');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `gross_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `last_production_date` SET TAGS ('dbx_business_glossary_term' = 'Last Production Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_name` SET TAGS ('dbx_business_glossary_term' = 'Lease Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'active|expired|held_by_production|released|suspended|pending');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'oil_and_gas|mineral|surface|royalty|overriding_royalty');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lessee_name` SET TAGS ('dbx_business_glossary_term' = 'Lessee Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lessee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lessor_name` SET TAGS ('dbx_business_glossary_term' = 'Lessor Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `lessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `net_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `pooling_unit_flag` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `primary_term_years` SET TAGS ('dbx_business_glossary_term' = 'Primary Term (Years)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `range` SET TAGS ('dbx_business_glossary_term' = 'Range');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate (Percent)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `section` SET TAGS ('dbx_business_glossary_term' = 'Section');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `surface_use_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `title_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `title_opinion_status` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `title_opinion_status` SET TAGS ('dbx_value_regex' = 'clear|defective|pending|not_required');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `township` SET TAGS ('dbx_business_glossary_term' = 'Township');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `mineral_right_id` SET TAGS ('dbx_business_glossary_term' = 'Mineral Right Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `cumulative_production_boe` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `depth_from_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth From (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `depth_to_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth To (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `encumbrance_description` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Description');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `encumbrance_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery Barrels of Oil Equivalent (EUR BOE)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `last_production_date` SET TAGS ('dbx_business_glossary_term' = 'Last Production Date');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `mineral_interest_type` SET TAGS ('dbx_business_glossary_term' = 'Mineral Interest Type');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `mineral_interest_type` SET TAGS ('dbx_value_regex' = 'fee_mineral|royalty_interest|overriding_royalty_interest|non_participating_royalty_interest|working_interest|net_profits_interest');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `mineral_right_number` SET TAGS ('dbx_business_glossary_term' = 'Mineral Right Number');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `net_mineral_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Mineral Acres (NMA)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `net_revenue_interest` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `net_revenue_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `overriding_royalty_interest` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `overriding_royalty_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_address` SET TAGS ('dbx_business_glossary_term' = 'Owner Address');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Owner Tax Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_tax_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_tax_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `ownership_fraction` SET TAGS ('dbx_business_glossary_term' = 'Ownership Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'before_payout|after_payout|not_applicable');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `producing_status` SET TAGS ('dbx_business_glossary_term' = 'Producing Status');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `producing_status` SET TAGS ('dbx_value_regex' = 'producing|non_producing|shut_in|held_by_production|expired|released');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|archived');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'proved_developed_producing|proved_developed_non_producing|proved_undeveloped|probable|possible|unproved');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `reserves_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `severance_date` SET TAGS ('dbx_business_glossary_term' = 'Severance Date');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `severance_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Severance Instrument Type');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `severance_instrument_type` SET TAGS ('dbx_value_regex' = 'deed|lease|reservation|assignment|court_order|patent');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `suspended_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspended Payment Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `working_interest` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI)');
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ALTER COLUMN `working_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `api_county_code` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) County Code');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `api_county_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Tract Comments');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `environmental_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Restriction Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `gis_polygon_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Polygon Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `gross_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `land_classification` SET TAGS ('dbx_business_glossary_term' = 'Land Classification');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `land_classification` SET TAGS ('dbx_value_regex' = 'producing|non_producing|exploratory|development|held_by_production|undeveloped');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `mineral_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Mineral Owner Name');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `mineral_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `mineral_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Mineral Ownership Type');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `net_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `overriding_royalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `play` SET TAGS ('dbx_business_glossary_term' = 'Geologic Play');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `quarter_section` SET TAGS ('dbx_business_glossary_term' = 'Quarter Section');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `range` SET TAGS ('dbx_business_glossary_term' = 'Range');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `regulatory_district` SET TAGS ('dbx_business_glossary_term' = 'Regulatory District');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `royalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `section` SET TAGS ('dbx_business_glossary_term' = 'Section');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `surface_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Surface Owner Name');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `surface_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `surface_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Surface Ownership Type');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `surface_use_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `title_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `title_opinion_status` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Status');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `title_opinion_status` SET TAGS ('dbx_value_regex' = 'complete|pending|defective|curative_required|not_required');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `township` SET TAGS ('dbx_business_glossary_term' = 'Township');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `tract_name` SET TAGS ('dbx_business_glossary_term' = 'Tract Name');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `tract_number` SET TAGS ('dbx_business_glossary_term' = 'Tract Number');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `tract_status` SET TAGS ('dbx_business_glossary_term' = 'Tract Status');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `tract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|released|held');
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `backup_withholding_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `backup_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Rate');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `cumulative_payments_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Payments to Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `date_of_death` SET TAGS ('dbx_business_glossary_term' = 'Date of Death');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `estate_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Estate Representative Name');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `estate_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `estate_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `estate_tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Estate Tax Identification Number (EIN)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `estate_tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `estate_tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `foreign_person_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Person Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `foreign_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Withholding Rate');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `form_1099_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `interest_owner_number` SET TAGS ('dbx_business_glossary_term' = 'Interest Owner Number');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `minimum_payment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Threshold');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Name');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `owner_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Status');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `owner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|suspended|pending_verification');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Type');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|on_demand');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|electronic_funds_transfer');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `suspended_payment_balance` SET TAGS ('dbx_business_glossary_term' = 'Suspended Payment Balance');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN/EIN/SSN)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `tax_treaty_country_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treaty Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `tax_treaty_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `w8_form_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'W-8 Form Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `w8_form_received_date` SET TAGS ('dbx_business_glossary_term' = 'W-8 Form Received Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ALTER COLUMN `w9_form_received_date` SET TAGS ('dbx_business_glossary_term' = 'W-9 Form Received Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `previous_division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Division Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'Well|Lease|Unit|Tract|Proportionate');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `backup_withholding_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Withholding Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `cost_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Bearing Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `decimal_interest` SET TAGS ('dbx_business_glossary_term' = 'Decimal Interest Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `division_order_number` SET TAGS ('dbx_business_glossary_term' = 'Division Order Number');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `division_order_number` SET TAGS ('dbx_value_regex' = '^DO-[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `division_order_status` SET TAGS ('dbx_business_glossary_term' = 'Division Order Status');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `division_order_status` SET TAGS ('dbx_value_regex' = 'Active|Suspended|Pending Title|Terminated|Draft|Under Review');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `gross_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'Net Acres|Proportionate Share|Unit Formula|Custom');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `interest_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Type');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `interest_type` SET TAGS ('dbx_value_regex' = 'WI|NRI|ORRI|Royalty|Mineral Interest|Leasehold Interest');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `minimum_payment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Threshold');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `net_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Division Order Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `owner_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Owner Signature Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `owner_signature_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Owner Signature Received Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `participating_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Participating Area Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire Transfer|Check|Direct Deposit');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `percentage_interest` SET TAGS ('dbx_business_glossary_term' = 'Percentage Interest');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `revenue_deck` SET TAGS ('dbx_business_glossary_term' = 'Revenue Deck');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `revenue_deck` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `statutory_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Statutory Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `suspense_date` SET TAGS ('dbx_business_glossary_term' = 'Suspense Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `suspense_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspense Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `suspense_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `land_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Owner Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `assignment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `assignment_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Instrument Type');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `assignment_instrument_type` SET TAGS ('dbx_value_regex' = 'deed|assignment|farmout|lease|PSA|JOA');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `conversion_trigger` SET TAGS ('dbx_business_glossary_term' = 'Conversion Trigger');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `conversion_trigger` SET TAGS ('dbx_value_regex' = 'payout|time-based|production-based|event-based');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `convertible_flag` SET TAGS ('dbx_business_glossary_term' = 'Convertible Interest Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'proportionate|non-consent|penalty|carried');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `division_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Division Order Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `interest_number` SET TAGS ('dbx_business_glossary_term' = 'Interest Number');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `interest_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Type');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `interest_type` SET TAGS ('dbx_value_regex' = 'WI|ORRI|NRI|RI|COPAS');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `jib_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Code');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `land_working_interest_status` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Status');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `land_working_interest_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `nri_decimal` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `orri_decimal` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Decimal Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'participating|non-participating|carried|back-in|farmed-out');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'pre-payout|post-payout|not-applicable');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Method');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_value_regex' = 'proportionate|net|gross|payout-based');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `reversion_date` SET TAGS ('dbx_business_glossary_term' = 'Reversion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `reversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversion Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `reversion_trigger` SET TAGS ('dbx_business_glossary_term' = 'Reversion Trigger');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `reversion_trigger` SET TAGS ('dbx_value_regex' = 'payout|time-based|production-based|event-based');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `royalty_decimal` SET TAGS ('dbx_business_glossary_term' = 'Royalty Interest (RI) Decimal Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `suspense_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspense Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `suspense_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `termination_condition` SET TAGS ('dbx_business_glossary_term' = 'Termination Condition');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `title_opinion_reference` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `title_status` SET TAGS ('dbx_business_glossary_term' = 'Title Status');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `title_status` SET TAGS ('dbx_value_regex' = 'clear|defective|curative-pending|disputed');
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ALTER COLUMN `wi_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Landman Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `tertiary_title_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `tertiary_title_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `tertiary_title_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revision_required');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Attorney Name');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `curative_actions_count` SET TAGS ('dbx_business_glossary_term' = 'Curative Actions Count');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `curative_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Curative Completion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `curative_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Curative Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `depth_from_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth From (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `depth_to_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth To (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `exceptions_summary` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Summary');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `formation_limitation` SET TAGS ('dbx_business_glossary_term' = 'Formation Limitation');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `gross_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `law_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Law Firm Name');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `marketable_title_date` SET TAGS ('dbx_business_glossary_term' = 'Marketable Title Date');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `net_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `net_revenue_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Cost Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_number` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Number');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Type');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `opinion_type` SET TAGS ('dbx_value_regex' = 'drilling|division_order|acquisition|supplemental|update');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `orri_burden_decimal` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Burden Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `prior_conveyances_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Prior Conveyances Reviewed');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `reservations_summary` SET TAGS ('dbx_business_glossary_term' = 'Reservations Summary');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `royalty_burden_decimal` SET TAGS ('dbx_business_glossary_term' = 'Royalty Burden Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `title_defects_count` SET TAGS ('dbx_business_glossary_term' = 'Title Defects Count');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `title_examination_period_from` SET TAGS ('dbx_business_glossary_term' = 'Title Examination Period From Date');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `title_examination_period_to` SET TAGS ('dbx_business_glossary_term' = 'Title Examination Period To Date');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `title_status` SET TAGS ('dbx_business_glossary_term' = 'Title Status');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `title_status` SET TAGS ('dbx_value_regex' = 'marketable|defective|curative_required|pending_review|rejected');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `lease_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Acquisition Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Landman Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `acquisition_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'prospect|negotiation|executed|recorded|cancelled|expired');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'new_lease|lease_extension|lease_renewal|assignment|farmout|top_lease');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `basin_name` SET TAGS ('dbx_business_glossary_term' = 'Basin Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `bid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `bonus_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Bonus Per Acre');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `bonus_per_acre` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `broker_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `broker_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `competitive_bid_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `delay_rental_amount` SET TAGS ('dbx_business_glossary_term' = 'Delay Rental Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `depth_rights_from_ft` SET TAGS ('dbx_business_glossary_term' = 'Depth Rights From (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `depth_rights_to_ft` SET TAGS ('dbx_business_glossary_term' = 'Depth Rights To (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `formation_target` SET TAGS ('dbx_business_glossary_term' = 'Formation Target');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `net_revenue_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `primary_term_years` SET TAGS ('dbx_business_glossary_term' = 'Primary Term Years');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `pugh_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Pugh Clause Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Recording Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `surface_use_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `title_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `total_acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Acquisition Cost');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `total_acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `lease_expiry_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry ID');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Held-By-Production (HBP) Well ID');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `acreage_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Acreage At Risk');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `alert_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `alert_notification_recipient` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Recipient');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `continuous_drilling_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Drilling Clause Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `continuous_drilling_deadline` SET TAGS ('dbx_business_glossary_term' = 'Continuous Drilling Deadline');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `delay_rental_amount` SET TAGS ('dbx_business_glossary_term' = 'Delay Rental Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `delay_rental_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Rental Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `delay_rental_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `delay_rental_due_date` SET TAGS ('dbx_business_glossary_term' = 'Delay Rental Due Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `estimated_reserves_at_risk_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reserves At Risk Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_action_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Action Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_action_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Expiry Action Responsible Party');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Expiry Action Taken');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_action_taken` SET TAGS ('dbx_value_regex' = 'renewed|released|extended|hbp_confirmed|under_review|pending_decision');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_event_type` SET TAGS ('dbx_business_glossary_term' = 'Expiry Event Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_event_type` SET TAGS ('dbx_value_regex' = 'primary_term_expiry|extension_expiry|option_expiry|continuous_drilling_deadline|pugh_clause_partial_release');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `expiry_notes` SET TAGS ('dbx_business_glossary_term' = 'Expiry Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `extension_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Expiry Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `extension_option_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Available Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `extension_option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Exercise Deadline');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `extension_option_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Payment Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `extension_option_term_years` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Term Years');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `hbp_status` SET TAGS ('dbx_business_glossary_term' = 'Held-By-Production (HBP) Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `hbp_status` SET TAGS ('dbx_value_regex' = 'not_hbp|hbp_confirmed|hbp_pending_verification|hbp_disputed');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `hbp_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Held-By-Production (HBP) Verification Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `hbp_well_api_number` SET TAGS ('dbx_business_glossary_term' = 'Held-By-Production (HBP) Well American Petroleum Institute (API) Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `lease_bonus_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Lease Bonus Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `lease_bonus_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `lease_bonus_paid` SET TAGS ('dbx_business_glossary_term' = 'Lease Bonus Paid');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `lease_bonus_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `net_revenue_interest_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) At Risk');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `primary_term_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Term Expiry Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `pugh_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Pugh Clause Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `pugh_clause_release_date` SET TAGS ('dbx_business_glossary_term' = 'Pugh Clause Release Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `pugh_clause_type` SET TAGS ('dbx_business_glossary_term' = 'Pugh Clause Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `pugh_clause_type` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|both|none');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|resolved|cancelled|archived');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ALTER COLUMN `working_interest_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) At Risk');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `delay_rental_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Rental ID');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Tax Identification Number');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor ID');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `acreage_covered` SET TAGS ('dbx_business_glossary_term' = 'Acreage Covered');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `drilling_commenced_flag` SET TAGS ('dbx_business_glossary_term' = 'Drilling Commenced Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `jib_statement_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Number');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `late_payment_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `lease_primary_term_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Primary Term Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `lease_termination_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Termination Risk Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Status');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|failed|returned|cleared');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|draft|escrow|suspense');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rental Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_due_date` SET TAGS ('dbx_business_glossary_term' = 'Rental Due Date');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_payment_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Payment Number');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rental Period End Date');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rental Period Start Date');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_rate_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Per Acre');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_status` SET TAGS ('dbx_business_glossary_term' = 'Rental Payment Status');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `rental_status` SET TAGS ('dbx_value_regex' = 'pending|paid|overdue|cancelled|waived|disputed');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement ID');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `grantor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `grantor_party_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract ID');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SUA-[0-9]{6,10}$|^ROW-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'surface_use_agreement|pipeline_row|road_row|utility_row|access_easement|temporary_workspace');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `annual_rental_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Rental Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `annual_rental_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'one_time_payment|annual_rental|per_rod_rate|damage_payment|no_compensation');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `damage_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Damage Payment Terms');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `easement_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Easement Length (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `easement_width_ft` SET TAGS ('dbx_business_glossary_term' = 'Easement Width (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `hse_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Compliance Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `notarized` SET TAGS ('dbx_business_glossary_term' = 'Notarized');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `operator_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Operator Signature Date');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `per_rod_rate` SET TAGS ('dbx_business_glossary_term' = 'Per-Rod Rate');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `per_rod_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `permitted_activities` SET TAGS ('dbx_business_glossary_term' = 'Permitted Activities');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `reclamation_obligations` SET TAGS ('dbx_business_glossary_term' = 'Reclamation Obligations');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `reclamation_required` SET TAGS ('dbx_business_glossary_term' = 'Reclamation Required');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `recorded` SET TAGS ('dbx_business_glossary_term' = 'Recorded');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Recording Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `restricted_areas` SET TAGS ('dbx_business_glossary_term' = 'Restricted Areas');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `surface_owner_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Surface Owner Consent Date');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Term Type');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'fixed_term|perpetual|as_needed|project_duration');
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ALTER COLUMN `total_acreage` SET TAGS ('dbx_business_glossary_term' = 'Total Acreage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `lease_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Amendment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Lessee Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `lessor_party_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `operator_party_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Original Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `superseded_by_amendment_lease_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amended_net_revenue_interest` SET TAGS ('dbx_business_glossary_term' = 'Amended Net Revenue Interest (NRI)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amended_primary_term_months` SET TAGS ('dbx_business_glossary_term' = 'Amended Primary Term (Months)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amended_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Amended Royalty Rate');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amended_working_interest` SET TAGS ('dbx_business_glossary_term' = 'Amended Working Interest (WI)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|executed|recorded|rejected|superseded');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `depth_from_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth From (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `depth_to_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth To (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `pooling_unit_acreage` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Acreage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `pooling_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Recording Reference Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `released_acreage` SET TAGS ('dbx_business_glossary_term' = 'Released Acreage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `retained_acreage` SET TAGS ('dbx_business_glossary_term' = 'Retained Acreage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_amendment` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Production Allocation Method');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'surface_acreage|subsurface_acreage|productivity|well_count|agreement_specified');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `api_county_code` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) County Code');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `api_county_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Comments');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Agreement Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Agreement Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Oil or Gas Field Name');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Target Formation Name');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `gross_unit_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Unit Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `is_federal_land` SET TAGS ('dbx_business_glossary_term' = 'Federal Land Indicator');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `is_tribal_land` SET TAGS ('dbx_business_glossary_term' = 'Tribal Land Indicator');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Land Description');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `net_unit_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `participating_tract_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Tract Count');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Achievement Date');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'pre_payout|post_payout|not_applicable');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `primary_product_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Type');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `primary_product_type` SET TAGS ('dbx_value_regex' = 'oil|gas|NGL|condensate');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `range` SET TAGS ('dbx_business_glossary_term' = 'Range Designation');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Classification');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = '1P|2P|3P|PDP|PDNP|PUD');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `reserves_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `royalty_burden_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Burden Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `royalty_burden_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `township` SET TAGS ('dbx_business_glossary_term' = 'Township Designation');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `unit_agreement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Unit Agreement Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Name');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Number');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Status');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Type');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'voluntary|compulsory|communitization|unitization|spacing_unit|drilling_unit');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `royalty_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Disbursement Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `decimal_interest` SET TAGS ('dbx_business_glossary_term' = 'Decimal Interest');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `escheat_date` SET TAGS ('dbx_business_glossary_term' = 'Escheat Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `escheat_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheat Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `form_1099_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `interest_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Paid Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `marketing_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Cost Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `other_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deduction Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire|eft|direct_deposit');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `processing_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Cost Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `production_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Tax Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `production_volume` SET TAGS ('dbx_business_glossary_term' = 'Production Volume');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `production_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `production_volume_uom` SET TAGS ('dbx_value_regex' = 'bbl|mcf|gal|ton|boe');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `severance_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Severance Tax Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `suspense_date` SET TAGS ('dbx_business_glossary_term' = 'Suspense Date');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `suspense_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspense Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason Code');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `total_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deduction Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ALTER COLUMN `transportation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_account_id` SET TAGS ('dbx_business_glossary_term' = 'Suspense Account Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `escheatment_report_id` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Report Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `owner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `cumulative_suspense_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Suspense Balance');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `division_order_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Division Order Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `escheatment_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `escheatment_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Deadline Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `escheatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `escheatment_state` SET TAGS ('dbx_business_glossary_term' = 'Escheatment State');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `jib_statement_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Number');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Method');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_value_regex' = 'mail|email|phone|certified_mail|registered_mail');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `net_revenue_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire_transfer|direct_deposit');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `payment_release_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Release Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'oil|gas|ngl|condensate|residue_gas');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `production_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production Period End Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `production_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Period Start Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'unresolved|in_progress|documentation_received|title_cleared|payment_authorized|completed');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_account_number` SET TAGS ('dbx_business_glossary_term' = 'Suspense Account Number');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_amount` SET TAGS ('dbx_business_glossary_term' = 'Suspense Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_date` SET TAGS ('dbx_business_glossary_term' = 'Suspense Date');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason Code');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_value_regex' = 'missing_division_order|title_dispute|unlocatable_owner|probate_pending|address_unknown|signature_required');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason Description');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_status` SET TAGS ('dbx_business_glossary_term' = 'Suspense Status');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `suspense_status` SET TAGS ('dbx_value_regex' = 'open|pending_resolution|resolved|released|escheated|transferred');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `title_opinion_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right of Way (ROW) Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Tract Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `agreement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'lump_sum|annual_payment|per_rod|per_acre|damage_only|no_compensation');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `cultural_resource_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Cultural Resource Clearance Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `easement_acres` SET TAGS ('dbx_business_glossary_term' = 'Easement Acreage');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `easement_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Easement Length (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `easement_width_feet` SET TAGS ('dbx_business_glossary_term' = 'Easement Width (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `environmental_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `grantee_name` SET TAGS ('dbx_business_glossary_term' = 'Grantee Name');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `grantor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `grantor_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Grantor Tax Identification Number');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `grantor_tax_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `grantor_tax_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `permitted_uses` SET TAGS ('dbx_business_glossary_term' = 'Permitted Uses');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Recording Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `restoration_obligation` SET TAGS ('dbx_business_glossary_term' = 'Restoration Obligation');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Restrictions');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `row_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Right of Way (ROW) Agreement Number');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `row_status` SET TAGS ('dbx_business_glossary_term' = 'Right of Way (ROW) Status');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `row_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|suspended|under_negotiation');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `row_type` SET TAGS ('dbx_business_glossary_term' = 'Right of Way (ROW) Type');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Term Type');
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'perpetual|fixed_term|life_of_facility|renewable');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `lease_document_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Document Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `curative_action_id` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `interest_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Assignment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `lease_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Amendment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|GBP|EUR');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_repository_code` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_subtype` SET TAGS ('dbx_business_glossary_term' = 'Document Subtype');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `grantee_name` SET TAGS ('dbx_business_glossary_term' = 'Grantee Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `gross_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `net_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `notarized_flag` SET TAGS ('dbx_business_glossary_term' = 'Notarized Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `original_document_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Document Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `recording_book` SET TAGS ('dbx_business_glossary_term' = 'Recording Book Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `recording_county` SET TAGS ('dbx_business_glossary_term' = 'Recording County');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `recording_page` SET TAGS ('dbx_business_glossary_term' = 'Recording Page Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `recording_state` SET TAGS ('dbx_business_glossary_term' = 'Recording State');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `retention_category` SET TAGS ('dbx_value_regex' = 'permanent|long_term|standard|short_term');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_document` ALTER COLUMN `witnessed_flag` SET TAGS ('dbx_business_glossary_term' = 'Witnessed Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `interest_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Assignment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Assignee Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Assignor Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `primary_interest_commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Assignor Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignee_party_name` SET TAGS ('dbx_business_glossary_term' = 'Assignee Party Name');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|executed|recorded|cancelled|rejected');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `depth_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Depth Restriction Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `depth_restriction_from_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth Restriction From Feet');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `depth_restriction_to_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth Restriction To Feet');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `division_order_update_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Division Order Update Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Execution Date');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `formation_restriction` SET TAGS ('dbx_business_glossary_term' = 'Formation Restriction');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `interest_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Type');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `interest_type` SET TAGS ('dbx_value_regex' = 'working_interest|net_revenue_interest|overriding_royalty_interest|royalty_interest|mineral_interest|leasehold_interest');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `jib_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `nri_decimal_assigned` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal Assigned');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `orri_decimal_assigned` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Decimal Assigned');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `preferential_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Right Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `preferential_right_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Right Waived Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `recording_book_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Book Number');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `recording_instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Instrument Number');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `recording_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Recording Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `recording_page_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Page Number');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `sec_reporting_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reporting Impact Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `title_opinion_reference` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `well_api_number` SET TAGS ('dbx_business_glossary_term' = 'Well American Petroleum Institute (API) Number');
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ALTER COLUMN `wi_decimal_assigned` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal Assigned');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `orri_id` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Holder Party Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `conversion_trigger` SET TAGS ('dbx_business_glossary_term' = 'Conversion Trigger');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `convertible_flag` SET TAGS ('dbx_business_glossary_term' = 'Convertible Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `cost_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Bearing Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `creation_instrument_reference` SET TAGS ('dbx_business_glossary_term' = 'Creation Instrument Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `creation_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Creation Instrument Type');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `cumulative_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Payout Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `decimal` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Decimal Fraction');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `depth_from_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth From (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `depth_to_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth To (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `division_order_date` SET TAGS ('dbx_business_glossary_term' = 'Division Order Date');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `division_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Division Order Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `orri_number` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Number');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `orri_status` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Status');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `orri_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|converted');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `orri_type` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Type');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `orri_type` SET TAGS ('dbx_value_regex' = 'perpetual|convertible|payout_based|term_limited|depth_limited|formation_specific');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pre_payout|post_payout');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `payout_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Payout Threshold Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `payout_threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payout Threshold Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `payout_threshold_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'oil|gas|ngl|all_products');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Recording Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `suspense_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspense Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `suspense_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `termination_condition` SET TAGS ('dbx_business_glossary_term' = 'Termination Condition');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `title_opinion_reference` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `title_status` SET TAGS ('dbx_business_glossary_term' = 'Title Status');
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ALTER COLUMN `title_status` SET TAGS ('dbx_value_regex' = 'clear|defective|pending_review|curative_required');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `curative_action_id` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Landman Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `quaternary_curative_assigned_landman_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `tertiary_curative_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `tertiary_curative_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `tertiary_curative_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `title_opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Curative Cost');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `affected_acreage` SET TAGS ('dbx_business_glossary_term' = 'Affected Acreage');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `affected_net_revenue_interest` SET TAGS ('dbx_business_glossary_term' = 'Affected Net Revenue Interest (NRI)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `affected_working_interest` SET TAGS ('dbx_business_glossary_term' = 'Affected Working Interest (WI)');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Assigned Date');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `blocking_division_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Division Order Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `blocking_drilling_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Drilling Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Completion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `curative_action_number` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Number');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `curative_status` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Status');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `curative_status` SET TAGS ('dbx_value_regex' = 'pending|in progress|completed|cancelled|on hold|escalated');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `curative_type` SET TAGS ('dbx_business_glossary_term' = 'Curative Type');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Title Defect Description');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Due Date');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Curative Cost');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Defect Identified Date');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Recording Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `recording_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recording Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `lease_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Obligation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `acreage_affected` SET TAGS ('dbx_business_glossary_term' = 'Acreage Affected');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `action_required` SET TAGS ('dbx_business_glossary_term' = 'Action Required');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `alert_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `alert_recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipient Email Address');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `alert_recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `alert_recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `alert_recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `jib_statement_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `late_payment_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `lease_termination_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Termination Risk Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `net_revenue_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Obligation Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `payee_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Tax Identification Number (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `payee_tax_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'QUORUM|SAP_JV|SAP_FI|MANUAL|OTHER');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `well_api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` SET TAGS ('dbx_subdomain' = 'royalty_accounting');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `shut_in_royalty_id` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Royalty ID');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor ID');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `acreage_covered` SET TAGS ('dbx_business_glossary_term' = 'Acreage Covered');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `consecutive_shut_in_months` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Shut-In Months');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `jib_statement_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Number');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `lease_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Lease Clause Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `lease_maintenance_flag` SET TAGS ('dbx_business_glossary_term' = 'Lease Maintenance Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `maximum_shut_in_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Maximum Shut-In Duration Months');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `net_revenue_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Royalty Payment Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|direct_deposit');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Royalty Payment Number');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_rate_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Payment Rate Per Acre');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|rejected|cancelled|suspended');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `production_capability_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Production Capability Verification Date');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `production_capability_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Capability Verified Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `shut_in_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Period End Date');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `shut_in_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Period Start Date');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `shut_in_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Reason Code');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `shut_in_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Reason Description');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `well_api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Leasing Prospect Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `land_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `actual_leasing_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leasing Spend to Date');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `actual_leasing_spend_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `average_royalty_burden_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Royalty Burden Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `basin_name` SET TAGS ('dbx_business_glossary_term' = 'Basin Name');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `current_gross_acres_leased` SET TAGS ('dbx_business_glossary_term' = 'Current Gross Acres Leased');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `current_net_acres_leased` SET TAGS ('dbx_business_glossary_term' = 'Current Net Acres Leased');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `estimated_gross_acres_required` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Acres Required');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `estimated_net_acres_required` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Acres Required');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery in Barrels of Oil Equivalent (EUR BOE)');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `federal_land_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Land Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `formation_target` SET TAGS ('dbx_business_glossary_term' = 'Formation Target');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `geographic_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Leasing Budget Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Leasing Budget Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_priority` SET TAGS ('dbx_business_glossary_term' = 'Leasing Priority');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leasing Start Date');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_status` SET TAGS ('dbx_business_glossary_term' = 'Leasing Status');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `leasing_status` SET TAGS ('dbx_value_regex' = 'open_acreage|partially_leased|substantially_leased|fully_leased|on_hold|abandoned');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `net_revenue_interest_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Target Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `net_revenue_interest_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `play_type` SET TAGS ('dbx_value_regex' = 'conventional|unconventional_shale|unconventional_tight_gas|unconventional_coalbed_methane|deepwater|ultra_deepwater');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `prospect_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Prospect Risk Classification');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `prospect_risk_classification` SET TAGS ('dbx_value_regex' = 'low_risk|moderate_risk|high_risk|exploratory|appraisal|development');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deleted');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'prospective|contingent|proved|probable|possible');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `secondary_formation_target` SET TAGS ('dbx_business_glossary_term' = 'Secondary Formation Target');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `target_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Target Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `tribal_land_flag` SET TAGS ('dbx_business_glossary_term' = 'Tribal Land Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `water_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Water Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `working_interest_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Target Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ALTER COLUMN `working_interest_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `land_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Land Regulatory Filing Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Consultant Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|denied|withdrawn');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `depth_from_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth From (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `depth_to_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth To (Feet)');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `gross_acres` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `net_acres` SET TAGS ('dbx_business_glossary_term' = 'Net Acres');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `regulatory_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Code');
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` SET TAGS ('dbx_association_edges' = 'land.pooling_unit,land.lease');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `unit_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Participation Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Participation - Lease Id');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Participation - Pooling Unit Id');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `cost_bearing_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Bearing Status');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `lease_acres_in_unit` SET TAGS ('dbx_business_glossary_term' = 'Lease Acres in Unit');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `lease_net_revenue_interest_in_unit` SET TAGS ('dbx_business_glossary_term' = 'Lease Net Revenue Interest in Unit');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `lease_participation_factor` SET TAGS ('dbx_business_glossary_term' = 'Lease Participation Factor');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `lease_working_interest_in_unit` SET TAGS ('dbx_business_glossary_term' = 'Lease Working Interest in Unit');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `participating_status` SET TAGS ('dbx_business_glossary_term' = 'Participating Status');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `oil_gas_ecm`.`land`.`unit_participation` ALTER COLUMN `unit_agreement_exhibit_reference` SET TAGS ('dbx_business_glossary_term' = 'Unit Agreement Exhibit Reference');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` SET TAGS ('dbx_association_edges' = 'land.lease,land.tract');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `lease_tract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Tract Assignment ID');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Tract - Lease Id');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Tract - Tract Id');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `depth_restriction` SET TAGS ('dbx_business_glossary_term' = 'Depth Restriction');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Tract Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Tract Expiration Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `gross_acres_in_lease` SET TAGS ('dbx_business_glossary_term' = 'Gross Acres in Lease');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `lease_status_for_tract` SET TAGS ('dbx_business_glossary_term' = 'Lease Status for Tract');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `mineral_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Mineral Rights Type');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `net_acres_in_lease` SET TAGS ('dbx_business_glossary_term' = 'Net Acres in Lease');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_tract` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` SET TAGS ('dbx_subdomain' = 'lease_administration');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` SET TAGS ('dbx_association_edges' = 'customer.customer_counterparty,land.lease');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `lease_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Interest Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Interest - Customer Counterparty Id');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Interest - Lease Id');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Acquisition Method');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `cost_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Bearing Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Effective Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `interest_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Type Classification');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Designation Flag');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `overriding_royalty_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Percent');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `overriding_royalty_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Termination Date');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Entity Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `parent_tax_entity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `foreign_tax_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `foreign_tax_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`tax_entity` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`party` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `tax_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ALTER COLUMN `tax_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`escheatment_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`escheatment_report` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`escheatment_report` ALTER COLUMN `escheatment_report_id` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Report Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`escheatment_report` ALTER COLUMN `parent_escheatment_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`property` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`land`.`property` SET TAGS ('dbx_subdomain' = 'land_compliance');
ALTER TABLE `oil_gas_ecm`.`land`.`property` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier');
ALTER TABLE `oil_gas_ecm`.`land`.`property` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Property Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`land`.`property` ALTER COLUMN `parent_property_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`land`.`property` ALTER COLUMN `tax_code` SET TAGS ('dbx_confidential' = 'true');
