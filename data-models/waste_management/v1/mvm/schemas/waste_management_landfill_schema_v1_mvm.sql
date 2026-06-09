-- Schema for Domain: landfill | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`landfill` COMMENT 'Landfill site operations including cell management, waste placement, compaction ratios, daily cover application, leachate collection and treatment, landfill gas (LFG) monitoring (LEL readings), liner integrity, environmental monitoring (groundwater, air quality), airspace consumption tracking, capacity planning, and closure/cap plans. Manages tipping fees, tonnage received (TPD), and regulatory compliance for RCRA Subtitle D facilities. Supports EPA SWIS reporting and CERCLA/Superfund obligations. Integrates with Enviance EHS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`site` (
    `site_id` BIGINT COMMENT 'Unique system-generated identifier for the landfill site. Primary key for all landfill operational, environmental, and compliance data anchored to this facility.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Large landfill sites operate as separate billing entities for host community agreements and inter-company transfers. Site generates internal invoices for corporate waste or bills host community for im',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: A landfill site operates under a municipal franchise agreement that governs its territorial rights and operational obligations. Franchise compliance reporting and renewal management require direct lin',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Landfill sites are regulated facilities. Compliance domain maintains canonical regulated facility registry with EPA IDs, RCRA status, Title V designation, and compliance risk levels that landfill oper',
    `facility_id` BIGINT COMMENT 'Facility identifier as configured in the Enviance EHS system, which is the system of record for environmental compliance, permit tracking, and incident management at this facility. Used for cross-system data integration and compliance record linkage.',
    `site_epa_facility_id` BIGINT COMMENT 'EPA-assigned facility identifier used for federal environmental reporting, RCRA compliance tracking, and CERCLA/Superfund obligations. Format: two-letter state code followed by 10-digit numeric identifier.',
    `tsdf_facility_id` BIGINT COMMENT 'Foreign key linking to hazmat.tsdf_facility. Business justification: Landfill sites permitted to accept hazardous waste must maintain RCRA TSDF status. The tsdf_facility record governs permitted waste codes, financial assurance requirements, and manifest approval statu',
    `address_line1` STRING COMMENT 'Primary street address of the landfill facility. Used for regulatory correspondence, emergency response coordination, and logistics routing.',
    `address_line2` STRING COMMENT 'Secondary address line for the landfill facility (suite, building, gate number, or additional location descriptor).',
    `airspace_survey_date` DATE COMMENT 'Date of the most recent engineering airspace survey used to calculate remaining airspace. Ensures remaining_airspace_cy reflects current conditions and supports audit trail for capacity reporting.',
    `cap_system_type` STRING COMMENT 'Type of final cover (cap) system installed or planned for the landfill. The cap is the final cover system placed over closed portions of the landfill to minimize infiltration and control LFG emissions. final_cap indicates permanent closure cap installed; interim_cap indicates temporary cover on inactive areas; none indicates active filling area; planned indicates cap design approved but not yet constructed.. Valid values are `final_cap|interim_cap|none|planned`',
    `cercla_status` STRING COMMENT 'Current CERCLA/Superfund status of the facility. Indicates whether the site is listed on the National Priorities List (NPL) or subject to CERCLA remedial action obligations. Drives legal liability accruals and environmental compliance reporting. [ENUM-REF-CANDIDATE: not_listed|npl_listed|remedial_investigation|remedial_action|completed|other — promote to reference product]. Valid values are `not_listed|npl_listed|remedial_investigation|remedial_action|completed|other`',
    `city` STRING COMMENT 'Municipality or city in which the landfill facility is located. Used for jurisdictional determination, local enforcement agency (LEA) assignment, and host community agreement management.',
    `classification` STRING COMMENT 'Regulatory and operational classification of the landfill facility. MSW (Municipal Solid Waste) accepts household and commercial waste; C&D (Construction and Demolition) accepts construction debris; monofill accepts a single waste type; industrial accepts non-hazardous industrial waste; hazardous is a RCRA Subtitle C facility. Drives applicable regulatory framework and permitted waste streams.. Valid values are `MSW|C&D|monofill|industrial|hazardous`',
    `closure_date` DATE COMMENT 'Date on which the landfill facility ceased accepting waste and initiated the formal closure process. Null for active facilities. Triggers post-closure care obligations under RCRA Subtitle D including 30-year monitoring requirements.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the facility location (e.g., USA). Supports multi-country enterprise reporting and regulatory framework determination.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County in which the landfill facility is located. Critical for determining applicable local solid waste authority jurisdiction, host community agreement obligations, and county-level regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the landfill site master record was first created in the enterprise data platform. Supports data lineage, audit trail, and record lifecycle management per SOX internal controls.',
    `ghg_reporting_required` BOOLEAN COMMENT 'Indicates whether the facility is subject to mandatory greenhouse gas (GHG) reporting under EPA 40 CFR Part 98 (Subpart HH for MSW landfills). Facilities exceeding the 25,000 metric ton CO2e threshold must report annually. Drives GHG data collection workflows in Enviance EHS.',
    `groundwater_monitoring_required` BOOLEAN COMMENT 'Indicates whether the facility is subject to groundwater monitoring requirements under RCRA Subtitle D or state permit conditions. Drives scheduling of monitoring well sampling events and Enviance EHS compliance tracking.',
    `host_community_agreement_ref` STRING COMMENT 'Reference number or document identifier for the host community agreement (HCA) between the facility operator and the local municipality. HCAs govern tipping fee sharing, traffic mitigation, odor controls, and community benefit obligations. Links to contract management records in Salesforce CRM.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the landfill facility centroid in decimal degrees (WGS84 datum). Used for geospatial analysis, route optimization, emergency response, and environmental monitoring zone mapping.',
    `lea_name` STRING COMMENT 'Name of the Local Enforcement Agency (LEA) responsible for routine inspection and enforcement at the facility. In California and other states, LEAs are county-level agencies delegated enforcement authority by the state. Required for compliance contact management and inspection scheduling.',
    `leachate_management_type` STRING COMMENT 'Type of leachate collection and management system installed at the facility. Leachate is the liquid that drains through the waste mass and must be managed to prevent groundwater contamination. Drives operational costs, permit conditions, and Clean Water Act (CWA) compliance obligations.. Valid values are `collection_and_treatment|collection_and_discharge|recirculation|none|other`',
    `lfg_collection_system` BOOLEAN COMMENT 'Indicates whether an active landfill gas (LFG) collection and control system is installed at the facility. LFG systems capture methane for waste-to-energy (WTE) or renewable natural gas (RNG) conversion, and are required under EPA New Source Performance Standards (NSPS) for qualifying facilities. Drives Clean Air Act compliance and sustainability reporting.',
    `lfg_utilization_type` STRING COMMENT 'Method by which captured landfill gas (LFG) is utilized or destroyed. flare_only indicates gas is combusted without energy recovery; electricity_generation indicates WTE power generation; RNG indicates renewable natural gas pipeline injection; direct_use indicates direct thermal use; none indicates no LFG system. Drives GHG emissions reporting and sustainability metrics.. Valid values are `flare_only|electricity_generation|RNG|direct_use|none`',
    `liner_system_type` STRING COMMENT 'Type of engineered liner system installed at the base of the landfill to prevent leachate migration into groundwater. Determines applicable regulatory standards, leachate collection design, and groundwater monitoring requirements. [ENUM-REF-CANDIDATE: single_composite|double_composite|clay|geomembrane|no_liner|other — promote to reference product if additional liner subtypes are needed]. Valid values are `single_composite|double_composite|clay|geomembrane|no_liner|other`',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the landfill facility centroid in decimal degrees (WGS84 datum). Used for geospatial analysis, route optimization, emergency response, and environmental monitoring zone mapping.',
    `monitoring_well_count` STRING COMMENT 'Total number of groundwater monitoring wells installed at the facility perimeter and downgradient locations as required by the facility permit. Used for compliance scheduling, sampling cost estimation, and permit condition verification.',
    `open_date` DATE COMMENT 'Date on which the landfill facility first began accepting waste. Used for site age calculations, post-closure care timeline planning, and historical capacity consumption analysis.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the landfill site. active indicates waste is actively being received; closed indicates waste acceptance has ceased; post_closure indicates the site is in the regulatory post-closure care period; permitted indicates permit obtained but operations not yet commenced; construction indicates liner/cell construction in progress; suspended indicates operations temporarily halted.. Valid values are `active|closed|post_closure|permitted|construction|suspended`',
    `permit_expiration_date` DATE COMMENT 'Date on which the current RCRA Subtitle D or state solid waste operating permit expires. Triggers permit renewal workflow in Enviance EHS. Facilities operating beyond this date without renewal are in violation of RCRA and state regulations.',
    `permit_issued_date` DATE COMMENT 'Date on which the current operating permit was issued by the regulatory authority. Used to calculate permit duration, track renewal cycles, and support compliance audit documentation.',
    `permitted_acreage` DECIMAL(18,2) COMMENT 'Total land area in acres authorized under the current operating permit for waste disposal activities. Drives capacity planning, cell development scheduling, and permit boundary compliance monitoring.',
    `permitted_daily_receipt_tons` DECIMAL(18,2) COMMENT 'Maximum tonnage per day (TPD) the facility is permitted to receive under its current operating permit. Operational throughput must not exceed this limit without permit modification. Used for daily tonnage monitoring and permit compliance alerts in Enviance EHS.',
    `post_closure_end_date` DATE COMMENT 'Projected or actual date on which the mandatory post-closure care period ends (minimum 30 years after closure under RCRA Subtitle D). Used for long-range financial liability estimation and closure cost accrual under IFRS/GAAP.',
    `postal_code` STRING COMMENT 'US ZIP code for the landfill facility address. Used for geographic analysis, regulatory jurisdiction mapping, and logistics coordination.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `rcra_permit_number` STRING COMMENT 'State-issued RCRA Subtitle D operating permit number authorizing the facility to receive and dispose of municipal solid waste (MSW) or other permitted waste streams. Required for regulatory compliance and annual permit renewal tracking.',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the primary state or local regulatory agency with permitting and enforcement authority over the facility (e.g., California Department of Resources Recycling and Recovery, Texas Commission on Environmental Quality). Determines applicable state-specific regulatory requirements beyond federal RCRA Subtitle D baseline.',
    `remaining_airspace_cy` DECIMAL(18,2) COMMENT 'Current remaining permitted airspace in cubic yards, calculated from the most recent engineering survey. Critical KPI for capacity planning, site life estimation, and financial asset valuation under IFRS/GAAP. Updated following each annual or semi-annual airspace survey.',
    `sap_plant_code` STRING COMMENT 'Four-character SAP S/4HANA plant code assigned to this landfill facility. Used for financial cost center assignment, materials management (MM), plant maintenance (PM), and EHS module integration. Enables cross-domain financial and operational reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `site_code` STRING COMMENT 'Internally assigned alphanumeric code uniquely identifying the landfill site across enterprise systems including SAP S/4HANA, Enviance EHS, and Infor EAM. Used as the cross-system business key.. Valid values are `^[A-Z0-9]{3,12}$`',
    `site_name` STRING COMMENT 'Official operating name of the landfill facility as registered with regulatory authorities and used in all internal and external communications.',
    `standard_tipping_fee` DECIMAL(18,2) COMMENT 'Standard gate rate charged per short ton for waste disposal at the facility (tipping fee). This is the base rate before contractual discounts or surcharges. Confidential commercial pricing data used in Oracle Revenue Management rate configuration and financial planning.',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation where the landfill facility is located. Determines applicable state environmental quality department regulations, state permit requirements, and state-specific RCRA program authority.. Valid values are `^[A-Z]{2}$`',
    `swis_registration_number` STRING COMMENT 'State Solid Waste Information System (SWIS) registration number assigned by the state environmental agency. Used for EPA SWIS reporting submissions and state-level compliance tracking.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the landfill facility location (e.g., America/Chicago, America/Los_Angeles). Required for accurate timestamp interpretation of operational events, regulatory reporting deadlines, and scheduling across multi-site enterprise operations.',
    `total_design_capacity_cy` DECIMAL(18,2) COMMENT 'Total permitted airspace capacity of the landfill in cubic yards as approved in the facility design engineering report. Represents the maximum volume of waste and cover material the site is engineered and permitted to contain. Used for long-range capacity planning and permit compliance.',
    `total_design_capacity_tons` DECIMAL(18,2) COMMENT 'Total permitted disposal capacity of the landfill in short tons as approved in the facility design engineering report. Complements cubic yard capacity for tonnage-based regulatory reporting and financial capacity valuation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the landfill site master record. Used for change detection, data synchronization across integrated systems, and audit trail maintenance.',
    `waste_streams_accepted` STRING COMMENT 'Comma-delimited list of waste stream types the facility is permitted to accept (e.g., MSW, C&D, industrial non-hazardous, special waste). Drives waste acceptance screening, manifest verification, and permit compliance. [ENUM-REF-CANDIDATE: MSW|C&D|industrial_non_hazardous|special_waste|ash|sludge|other — promote to reference product]',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master record for each landfill facility. Captures site identity, physical location (GPS coordinates, address, county, state), permitted acreage, total design capacity (cubic yards and tons), current operational status (active/closed/post-closure), RCRA Subtitle D permit number, EPA facility ID, state SWIS registration number, liner system type, leachate management system type, LFG collection system presence, host community agreement reference, regulatory jurisdiction, and site classification (MSW, C&D, monofill). Top-level anchor for all landfill operational, environmental, and compliance data.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`cell` (
    `cell_id` BIGINT COMMENT 'Unique identifier for the landfill cell. Primary key for the cell master record.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: Each landfill cell is constructed as a discrete capital project with design, permitting, and construction phases. Capital project completion triggers cell activation and asset capitalization. Construc',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Cells are sub-components of facility structures for asset hierarchy, cost center allocation, capital project tracking, and consolidated environmental reporting. New attribute establishes proper facili',
    `site_id` BIGINT COMMENT 'Reference to the parent landfill site where this cell is located. Links to the landfill facility master record.',
    `actual_fill_date` DATE COMMENT 'Actual date when the cell reached design capacity and was closed to further waste placement.',
    `area_acres` DECIMAL(18,2) COMMENT 'Horizontal footprint area of the cell in acres, measured at the base liner surface.',
    `average_daily_tonnage` DECIMAL(18,2) COMMENT 'Average tons per day (TPD) received in this cell during active operations, used for capacity planning and operational forecasting.',
    `base_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the cell base (liner surface) in feet above mean sea level, used for airspace calculations and grading plans.',
    `cell_name` STRING COMMENT 'Descriptive name for the cell used in operational and planning documents.',
    `cell_number` STRING COMMENT 'Business identifier for the cell, typically alphanumeric code used in operational communications and regulatory reporting (e.g., CELL-A1, PHASE2-C3).. Valid values are `^[A-Z0-9]{1,20}$`',
    `cell_status` STRING COMMENT 'Current operational status of the cell in its lifecycle: planned (designed but not built), under_construction (being prepared), active (receiving waste), filled (at capacity but not closed), closed (operations ceased, interim cover applied), capped (final cover system installed).. Valid values are `planned|under_construction|active|filled|closed|capped`',
    `closure_date` DATE COMMENT 'Date when formal closure activities (final grading, interim cover installation) were completed and the cell transitioned from active to closed status.',
    `compaction_ratio_target` DECIMAL(18,2) COMMENT 'Target volume reduction ratio for waste compaction operations in this cell, typically expressed as ratio of loose volume to compacted volume (e.g., 4.0 means 4:1 reduction).',
    `construction_completion_date` DATE COMMENT 'Date when cell construction was completed and the cell was certified ready for waste placement.',
    `construction_start_date` DATE COMMENT 'Date when physical construction of the cell (excavation, liner installation) commenced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cell record was first created in the system.',
    `current_elevation_feet` DECIMAL(18,2) COMMENT 'Current elevation of the active waste surface in feet above mean sea level, updated from periodic topographic surveys.',
    `daily_cover_material_type` STRING COMMENT 'Type of material used for daily cover application to control odors, vectors, and litter: soil (traditional 6-inch soil cover), alternative_daily_cover (ADC such as compost, shredded green waste), tarps (reusable geomembrane tarps), foam (spray-applied foam), auto_daily_cover (automated tarp systems).. Valid values are `soil|alternative_daily_cover|tarps|foam|auto_daily_cover`',
    `design_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Total permitted airspace volume for waste placement in cubic yards, as specified in the engineering design and regulatory permit.',
    `design_capacity_tons` DECIMAL(18,2) COMMENT 'Total permitted waste tonnage capacity, calculated from design volume and assumed compaction density.',
    `environmental_monitoring_frequency` STRING COMMENT 'Required frequency for environmental monitoring activities (groundwater sampling, gas monitoring, leachate testing) as specified in the permit.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `final_cap_installation_date` DATE COMMENT 'Date when the final cover system (cap) was installed over the closed cell, marking the beginning of post-closure care period.',
    `gas_collection_start_date` DATE COMMENT 'Date when active gas collection operations commenced in this cell, required for EPA NSPS/EG compliance tracking.',
    `gas_collection_system_installed` BOOLEAN COMMENT 'Indicates whether an active landfill gas collection system (vertical wells and/or horizontal collectors) has been installed in this cell.',
    `geometry_coordinates` STRING COMMENT 'Well-Known Text (WKT) representation of the cell boundary polygon coordinates for GIS mapping and spatial analysis.',
    `groundwater_monitoring_wells` STRING COMMENT 'Comma-separated list of groundwater monitoring well identifiers assigned to this cell for environmental compliance monitoring per RCRA Subtitle D requirements.',
    `liner_system_type` STRING COMMENT 'Classification of the engineered liner system installed at the base of the cell to prevent leachate migration: single_composite (one geomembrane + clay layer), double_composite (two geomembrane layers with leak detection), single_geomembrane, clay_only (compacted clay liner), enhanced_composite (advanced multi-layer system).. Valid values are `single_composite|double_composite|single_geomembrane|clay_only|enhanced_composite`',
    `liner_thickness_inches` DECIMAL(18,2) COMMENT 'Total thickness of the liner system in inches, including all geomembrane and clay layers.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, or historical context relevant to this cell.',
    `opening_date` DATE COMMENT 'Date when the cell was opened for active waste placement operations.',
    `permitted_waste_types` STRING COMMENT 'Comma-separated list of waste types authorized for disposal in this cell per regulatory permit (e.g., MSW, C&D, special waste, industrial non-hazardous). [ENUM-REF-CANDIDATE: MSW|C&D|special_waste|industrial_non_hazardous|asbestos|contaminated_soil|sludge|ash — promote to reference product]',
    `phase_number` STRING COMMENT 'Development phase identifier indicating the sequential construction phase of the landfill expansion plan.',
    `post_closure_care_end_date` DATE COMMENT 'Projected or actual date when the 30-year post-closure care period (monitoring, maintenance, gas management) will end or ended.',
    `projected_fill_date` DATE COMMENT 'Forecasted date when the cell is expected to reach design capacity based on current waste placement rates and airspace consumption trends.',
    `remaining_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Current available airspace for waste placement in cubic yards, updated based on survey measurements and waste placement records.',
    `responsible_engineer` STRING COMMENT 'Name of the licensed professional engineer responsible for design certification and ongoing compliance oversight for this cell.',
    `tipping_fee_per_ton` DECIMAL(18,2) COMMENT 'Standard disposal charge per ton of waste placed in this cell, used for revenue tracking and cost allocation. May vary by waste type and customer contract.',
    `top_elevation_feet` DECIMAL(18,2) COMMENT 'Permitted final elevation of the cell top surface in feet above mean sea level, defining the maximum fill height.',
    `total_tonnage_received` DECIMAL(18,2) COMMENT 'Cumulative tonnage of waste placed in this cell since opening, tracked for capacity management and regulatory reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cell record was last modified in the system.',
    CONSTRAINT pk_cell PRIMARY KEY(`cell_id`)
) COMMENT 'Master record for each discrete waste placement cell within a landfill site. Tracks cell identifier (CID), cell phase (active, filled, closed), design volume (cubic yards), permitted waste types (MSW, C&D, special waste), liner system specifications (single, double, composite), leachate collection system tie-in, cell opening date, projected fill date, actual closure date, base elevation, top elevation, and cell geometry coordinates. Supports airspace consumption tracking and cell sequencing for capacity planning. Sourced from AMCS Platform and Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` (
    `tonnage_receipt_id` BIGINT COMMENT 'Unique identifier for the tonnage receipt transaction. Primary key for the tonnage receipt record.',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Landfill tonnage receipts from direct collection routes (not transfer station hauls) need route execution reference for proof-of-service, billing reconciliation, and route-to-disposal tracking. Core d',
    `weight_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.weight_ticket. Business justification: Landfill tonnage receipts should reference originating collection weight tickets for end-to-end waste tracking, weight reconciliation, and audit trail from collection through disposal. Core collection',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Tonnage receipts often reference master service contracts for pricing validation, rate application, and revenue recognition. Critical for contract compliance tracking, invoice reconciliation, and volu',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account responsible for payment of tipping fees for this load. May be direct customer or hauler account.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Tonnage receipts must be tracked against the specific disposal agreement governing tipping fees, minimum tonnage guarantees, and permitted waste types — not just the parent contract. Disposal agreemen',
    `cell_id` BIGINT COMMENT 'Identifier of the specific landfill cell where this waste load was directed for placement and compaction.',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Landfill tonnage receipts must track the delivering driver for DOT compliance, safety incident correlation, driver performance metrics, and load verification. Currently tracks vehicle but not driver. ',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Specific identifier of the waste origin (route number, transfer station code, or customer site ID) from which this load was collected.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Tipping fee revenue reconciliation requires linking each gate receipt to its billing invoice. The denormalized invoice_number on tonnage_receipt confirms this relationship exists operationally. AR rep',
    `landfill_tipping_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to landfill.landfill_tipping_fee_schedule. Business justification: Each tonnage receipt is priced according to a tipping fee schedule based on waste type, customer segment, and effective date. Linking receipt to the fee schedule provides audit trail for rate justific',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: tonnage_receipt.manifest_number is a denormalized text field. Hazardous waste received at a landfill must be accompanied by a RCRA manifest. Linking tonnage_receipt to hazmat.manifest enables manifest',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste acceptance must comply with permit conditions. Each tonnage receipt should reference the permit authorizing acceptance of that waste type, ensuring permitted waste streams, daily tonnage limits,',
    `site_id` BIGINT COMMENT 'Identifier of the landfill facility where this tonnage receipt was recorded. Supports multi-site operations and reporting.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Waste origin tracking and billing reconciliation require linking each tonnage receipt to the originating service address. Regulatory waste-origin reporting and invoice matching depend on tracing recei',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Tipping fee billing and contract rate verification require linking a tonnage receipt to the specific service enrollment that generated the load. This supports invoice reconciliation and ensures the co',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Tonnage receipts must be reconciled with the specific driver shift/assignment that delivered the load for billing accuracy, HOS compliance verification, and route performance reporting. Existing vehic',
    `vehicle_id` BIGINT COMMENT 'Identifier of the inbound vehicle that delivered the waste load. Links to fleet management system for vehicle tracking.',
    `waste_generator_profile_id` BIGINT COMMENT 'EPA-issued generator identification number for the facility or entity that generated the waste, required for regulated waste streams.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Gate acceptance of hazardous/special waste requires validation against an approved RCRA waste profile. The waste profile governs approved disposal conditions, EPA waste codes, and handling requirement',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Tonnage receipts must be classified by waste stream for diversion rate reporting, regulatory tonnage reporting by waste category, and revenue recognition by service type. The existing waste_type/waste',
    `contamination_flag` BOOLEAN COMMENT 'Boolean indicator of whether prohibited or contaminating materials were detected in the waste load during inspection.',
    `contamination_notes` STRING COMMENT 'Detailed notes describing any contamination, prohibited materials, or acceptance criteria violations observed during load inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tonnage receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for tipping fee amounts. Defaults to USD for US operations.. Valid values are `USD`',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total weight of the loaded vehicle in tons as measured on the inbound scale, including vehicle tare weight and waste payload.',
    `inbound_scale_time` TIMESTAMP COMMENT 'Timestamp when the loaded vehicle was weighed on the inbound scale.',
    `load_inspection_status` STRING COMMENT 'Status of visual or detailed inspection performed on the waste load at the scale house to verify compliance with acceptance criteria.. Valid values are `not_inspected|visual_pass|visual_fail|detailed_inspection|random_audit`',
    `load_rejected_flag` BOOLEAN COMMENT 'Boolean indicator of whether the waste load was rejected and not accepted for disposal at the landfill.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tonnage receipt record was last modified or updated.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Estimated moisture content of the waste load as a percentage. Used for waste characterization and compaction ratio calculations.',
    `net_tonnage` DECIMAL(18,2) COMMENT 'Calculated net weight of waste material in tons (gross weight minus tare weight). Primary measure for TPD (Tons Per Day) reporting and tipping fee calculation.',
    `notes` STRING COMMENT 'Free-form notes or comments recorded by the scale operator regarding this tonnage receipt transaction.',
    `outbound_scale_time` TIMESTAMP COMMENT 'Timestamp when the empty vehicle was weighed on the outbound scale after waste disposal.',
    `payment_method` STRING COMMENT 'Method by which tipping fees for this load will be collected (account billing, immediate payment, etc.).. Valid values are `account_billing|credit_card|cash|check|electronic_transfer`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the waste load was received and weighed at the landfill scale house. Primary business event timestamp for this transaction.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the waste load was rejected, including specific violations of acceptance criteria or regulatory restrictions.',
    `special_handling_code` STRING COMMENT 'Code indicating any special handling requirements for this waste load (e.g., asbestos protocols, odor control, immediate cover).',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle in tons as measured on the outbound scale or retrieved from vehicle master data.',
    `ticket_number` STRING COMMENT 'Externally-known unique ticket number assigned at the scale house for this waste load receipt. Used for customer billing and audit trail.. Valid values are `^[A-Z0-9]{8,20}$`',
    `tipping_fee_amount` DECIMAL(18,2) COMMENT 'Total tipping fee charged for this waste load, calculated as net tonnage multiplied by tipping fee rate. Primary revenue recognition amount in USD.',
    `tipping_fee_rate` DECIMAL(18,2) COMMENT 'Per-ton tipping fee rate applied to this waste load based on waste type, customer contract, and applicable rate schedule. Expressed in USD per ton.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the tonnage receipt transaction in the billing and operational workflow.. Valid values are `draft|completed|voided|disputed|adjusted`',
    `vehicle_license_plate` STRING COMMENT 'License plate number of the vehicle that delivered the waste load. Used for vehicle identification and security tracking.. Valid values are `^[A-Z0-9]{2,10}$`',
    `waste_origin_type` STRING COMMENT 'Classification of the source from which the waste load originated (collection route, transfer station, direct customer haul, etc.).. Valid values are `collection_route|transfer_station|direct_haul|municipal_contract|commercial_account|residential_account`',
    `waste_subtype` STRING COMMENT 'Secondary or detailed classification of waste material within the primary waste type category. Provides granular categorization for specialized waste streams.',
    `waste_type` STRING COMMENT 'Primary classification of waste material type received. MSW (Municipal Solid Waste), C&D (Construction and Demolition Waste), special waste, sludge, or other regulated categories per RCRA Subtitle D. [ENUM-REF-CANDIDATE: MSW|C&D|special_waste|sludge|industrial|medical|asbestos — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_tonnage_receipt PRIMARY KEY(`tonnage_receipt_id`)
) COMMENT 'Transactional record of each waste load received at the landfill scale house. Captures ticket number, inbound vehicle ID, hauler/carrier identity, waste origin (route, transfer station, or direct customer), waste type classification (MSW, C&D, special waste, sludge), gross weight, tare weight, net tonnage, moisture content estimate, load rejection flag, rejection reason, assigned disposal cell, tipping fee rate applied, tipping fee amount charged, scale operator ID, and receipt timestamp. Primary source for TPD (Tons Per Day) reporting and tipping fee revenue recognition. Sourced from Oracle Revenue Management and AMCS Platform.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` (
    `airspace_consumption_id` BIGINT COMMENT 'Unique identifier for the airspace consumption measurement record.',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell within the site where airspace was consumed.',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where airspace consumption is measured.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Airspace consumption surveys are submitted to regulators as annual capacity reports. The submitted_to_regulator_flag and regulator_submission_date are denormalized from regulatory_submission. Linking ',
    `cnd_tonnage_tons` DECIMAL(18,2) COMMENT 'Tonnage of Construction and Demolition waste placed during the measurement period.',
    `compaction_ratio` DECIMAL(18,2) COMMENT 'Ratio of in-place waste density achieved versus design density, indicating compaction effectiveness.',
    `cover_material_volume_cubic_yards` DECIMAL(18,2) COMMENT 'Volume of daily cover material (soil, alternative daily cover) applied during the measurement period, measured in cubic yards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this airspace consumption record was first created in the system.',
    `cumulative_volume_consumed_cubic_yards` DECIMAL(18,2) COMMENT 'Total cumulative volume of airspace consumed in the cell or site since opening, measured in cubic yards.',
    `design_density_lbs_per_cubic_yard` DECIMAL(18,2) COMMENT 'Target design density for waste compaction as specified in facility design, measured in pounds per cubic yard.',
    `in_place_density_lbs_per_cubic_yard` DECIMAL(18,2) COMMENT 'Actual density of compacted waste in place, measured in pounds per cubic yard.',
    `measurement_accuracy_cubic_yards` DECIMAL(18,2) COMMENT 'Estimated accuracy or margin of error of the airspace measurement, expressed in cubic yards.',
    `measurement_date` DATE COMMENT 'Date when the airspace consumption measurement was performed.',
    `measurement_period_end_date` DATE COMMENT 'End date of the period for which airspace consumption is being measured.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the period for which airspace consumption is being measured.',
    `measurement_status` STRING COMMENT 'Current status of the airspace consumption measurement in the review and approval workflow.. Valid values are `draft|certified|submitted|approved|rejected|revised`',
    `msw_tonnage_tons` DECIMAL(18,2) COMMENT 'Tonnage of Municipal Solid Waste placed during the measurement period.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the airspace consumption measurement, including any anomalies or special conditions.',
    `projected_closure_date` DATE COMMENT 'Estimated date when the cell or site will reach permitted capacity based on current consumption rates.',
    `rate_cubic_yards_per_day` DECIMAL(18,2) COMMENT 'Average daily rate of airspace consumption during the measurement period, calculated as volume consumed divided by days in period.',
    `regulatory_reporting_period` STRING COMMENT 'Regulatory reporting period identifier (e.g., Q1 2024, Annual 2024) for which this measurement applies.',
    `remaining_permitted_airspace_cubic_yards` DECIMAL(18,2) COMMENT 'Remaining permitted airspace capacity available in the cell or site, measured in cubic yards.',
    `special_waste_tonnage_tons` DECIMAL(18,2) COMMENT 'Tonnage of special waste (non-hazardous industrial, contaminated soil, etc.) placed during the measurement period.',
    `survey_certification_date` DATE COMMENT 'Date when the surveyor certified the airspace consumption measurement.',
    `survey_method` STRING COMMENT 'Method used to measure airspace consumption (e.g., drone photogrammetry, GPS survey, LiDAR, total station).. Valid values are `drone_photogrammetry|gps_survey|lidar|total_station|manual_survey|aerial_photography`',
    `survey_report_reference` STRING COMMENT 'Reference number or document identifier for the detailed survey report supporting this measurement.',
    `surveyor_license_number` STRING COMMENT 'Professional license number of the surveyor who certified the measurement.',
    `surveyor_name` STRING COMMENT 'Name of the licensed surveyor or survey firm that performed the airspace measurement.',
    `total_permitted_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Total permitted airspace capacity for the cell or site as authorized by regulatory permit, measured in cubic yards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this airspace consumption record was last updated in the system.',
    `volume_consumed_cubic_yards` DECIMAL(18,2) COMMENT 'Volume of airspace consumed during the measurement period, measured in cubic yards.',
    `waste_tonnage_placed_tons` DECIMAL(18,2) COMMENT 'Total tonnage of waste placed in the cell or site during the measurement period.',
    `years_remaining_capacity` DECIMAL(18,2) COMMENT 'Estimated number of years of remaining airspace capacity based on current consumption trends.',
    CONSTRAINT pk_airspace_consumption PRIMARY KEY(`airspace_consumption_id`)
) COMMENT 'Periodic transactional record tracking cumulative and incremental airspace consumed within each landfill cell and across the entire site. Captures measurement date, survey method (drone photogrammetry, GPS survey, LiDAR), volume consumed in the period (cubic yards), cumulative volume consumed, remaining permitted airspace, compaction ratio achieved (in-place density vs. design density), waste tonnage placed in period, and surveyor certification reference. Feeds capacity planning and regulatory airspace reporting. Sourced from Enviance EHS and field survey data.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`daily_cover` (
    `daily_cover_id` BIGINT COMMENT 'Unique identifier for the daily cover application event record.',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell where daily cover was applied.',
    `site_id` BIGINT COMMENT 'Reference to the landfill facility where daily cover was applied.',
    `vehicle_id` BIGINT COMMENT 'Reference to the heavy equipment unit (dozer, compactor, spreader) used to apply the daily cover.',
    `adc_permit_number` STRING COMMENT 'EPA or state-issued permit number authorizing use of alternative daily cover materials in lieu of traditional soil cover.',
    `compliance_notes` STRING COMMENT 'Additional notes regarding compliance status, including reasons for non-compliance, corrective actions taken, or special circumstances.',
    `corrective_action_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when corrective action was completed and verified.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned to address daily cover deficiencies.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required to address deficiencies in the daily cover application. True = corrective action required, False = no action required.',
    `cover_application_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the daily cover application was completed.',
    `cover_date` DATE COMMENT 'The date on which the daily cover was applied to the active working face.',
    `cover_material_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of cover material used in this application event, measured in US dollars. Includes material purchase or extraction cost.',
    `cover_material_description` STRING COMMENT 'Detailed description of the specific cover material used, including brand name, product specifications, or soil classification.',
    `cover_material_type` STRING COMMENT 'Type of material used for daily cover application. Soil is traditional 6-inch cover; ADC (Alternative Daily Cover) includes tarps, foam, spray-on products, and other EPA-approved alternatives.. Valid values are `soil|alternative_daily_cover|tarp|foam|spray_on|geosynthetic`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily cover record was first created in the system.',
    `deficiencies_identified` STRING COMMENT 'Description of any deficiencies or non-conformances identified during inspection, such as inadequate thickness, incomplete coverage, or material failure.',
    `equipment_hours` DECIMAL(18,2) COMMENT 'Total equipment operating hours logged during this daily cover application event.',
    `fire_risk_mitigation` STRING COMMENT 'Assessment of how effectively the daily cover reduced subsurface fire risk by limiting oxygen infiltration.. Valid values are `excellent|good|fair|poor|ineffective`',
    `gps_coordinates` STRING COMMENT 'GPS coordinates (latitude, longitude) of the covered working face area for spatial tracking and airspace management.',
    `inspection_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal inspection of the daily cover application was performed by supervisory or compliance staff. True = inspection performed, False = no inspection.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp when the daily cover inspection was completed.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended for this daily cover application event, including operator time and support crew.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily cover record was last modified in the system.',
    `litter_control_effectiveness` STRING COMMENT 'Assessment of how effectively the daily cover prevented windblown litter and debris dispersal from the working face.. Valid values are `excellent|good|fair|poor|ineffective`',
    `odor_control_effectiveness` STRING COMMENT 'Subjective assessment of how effectively the daily cover controlled odor emissions from the working face.. Valid values are `excellent|good|fair|poor|ineffective`',
    `photo_documentation_url` STRING COMMENT 'URL or file path to photographic documentation of the daily cover application, used for compliance records and quality assurance.',
    `record_status` STRING COMMENT 'Current status of this daily cover record in the system lifecycle.. Valid values are `active|archived|deleted`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the daily cover application meets RCRA Subtitle D requirements (6-inch soil or approved ADC standard). True = compliant, False = non-compliant.',
    `remarks` STRING COMMENT 'Free-text field for additional operational notes, observations, or special circumstances related to the daily cover application event.',
    `shift` STRING COMMENT 'Work shift during which the daily cover application was performed.. Valid values are `day|night|weekend`',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient air temperature at time of cover application, measured in degrees Fahrenheit. Affects material handling and curing for certain ADC products.',
    `thickness_achieved_inches` DECIMAL(18,2) COMMENT 'Actual thickness of cover material achieved after compaction, measured in inches. RCRA Subtitle D requires minimum 6 inches of soil or approved ADC equivalent.',
    `vector_control_effectiveness` STRING COMMENT 'Assessment of how effectively the daily cover prevented access by birds, rodents, and insects (disease vectors).. Valid values are `excellent|good|fair|poor|ineffective`',
    `volume_applied_cubic_yards` DECIMAL(18,2) COMMENT 'Total volume of cover material applied measured in cubic yards. Applicable primarily to soil and bulk ADC materials.',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions during cover application. Weather impacts material performance and application effectiveness.. Valid values are `clear|rain|snow|wind|fog|extreme_heat`',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed during cover application measured in miles per hour. High winds can affect tarp and foam application effectiveness.',
    `working_face_area_square_feet` DECIMAL(18,2) COMMENT 'Total surface area of the active working face covered during this application event, measured in square feet.',
    CONSTRAINT pk_daily_cover PRIMARY KEY(`daily_cover_id`)
) COMMENT 'Transactional record of daily cover application events at the active face of each landfill cell. Tracks cover date, cell reference, cover material type (soil, alternative daily cover/ADC, tarps, foam), volume of cover material applied (cubic yards), thickness achieved (inches), working face area covered (square feet), operator ID, equipment used, weather conditions, and regulatory compliance flag (meets 6-inch soil or approved ADC standard per RCRA Subtitle D). Supports regulatory compliance documentation and cover material inventory management. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`leachate_collection` (
    `leachate_collection_id` BIGINT COMMENT 'Unique identifier for the leachate collection event record.',
    `collection_point_id` BIGINT COMMENT 'Identifier of the specific collection point such as sump ID, pipe segment, or monitoring well where leachate was collected.',
    `facility_id` BIGINT COMMENT 'Identifier of the Treatment, Storage, and Disposal Facility (TSDF) or municipal wastewater treatment plant where leachate was sent for disposal.',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Leachate disposal requires transport to treatment facilities under a hauling agreement. Leachate disposal cost tracking, manifest compliance, and permit reporting require linking each collection event',
    `site_id` BIGINT COMMENT 'Identifier of the landfill site where leachate was collected.',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: When characteristically hazardous leachate is transported off-site to a TSDF, RCRA requires a hazardous waste manifest. The leachate_collection record tracks off-site disposal events; linking to the g',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Leachate management is permit-regulated. Collection events must reference the permit establishing discharge limits, monitoring frequency, and disposal methods to track permit compliance and identify e',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Leachate monitoring results are submitted as discharge monitoring reports (DMRs) to state agencies. The regulatory_report_submitted_flag is denormalized from regulatory_submission. Linking to the subm',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Leachate containing hazardous constituents must be characterized under an approved RCRA waste profile before off-site disposal at a TSDF. Environmental managers reference the waste profile to determin',
    `ammonia_nitrogen_mg_l` DECIMAL(18,2) COMMENT 'Ammonia nitrogen concentration in milligrams per liter, a key nutrient pollutant parameter.',
    `bod_mg_l` DECIMAL(18,2) COMMENT 'Biological Oxygen Demand measurement in milligrams per liter, indicating biodegradable organic matter in the leachate.',
    `cod_mg_l` DECIMAL(18,2) COMMENT 'Chemical Oxygen Demand measurement in milligrams per liter, indicating organic pollutant load in the leachate.',
    `collection_date` DATE COMMENT 'Date when the leachate collection event occurred.',
    `collection_method` STRING COMMENT 'Method used to collect the leachate from the collection point.. Valid values are `pump|gravity_flow|manual_extraction|automated_system`',
    `collection_point_type` STRING COMMENT 'Type of collection infrastructure where leachate was gathered.. Valid values are `sump|pipe_segment|monitoring_well|drainage_layer|collection_header`',
    `collection_system_status` STRING COMMENT 'Operational status of the leachate collection system at the time of the event.. Valid values are `operational|maintenance_required|offline|under_repair`',
    `collection_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the leachate collection measurement was recorded.',
    `conductivity_umhos_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity of the leachate sample measured in micromhos per centimeter, indicating dissolved solids concentration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leachate collection record was first created in the system.',
    `disposal_cost_usd` DECIMAL(18,2) COMMENT 'Cost incurred for leachate disposal or treatment in US dollars.',
    `disposal_method` STRING COMMENT 'Method used to dispose of or treat the collected leachate.. Valid values are `on_site_treatment|off_site_tsdf|municipal_sewer_discharge|evaporation|recirculation`',
    `disposal_volume_gallons` DECIMAL(18,2) COMMENT 'Volume of leachate disposed or treated, measured in gallons.',
    `exceedance_parameters` STRING COMMENT 'Comma-separated list of parameters that exceeded permit limits during this collection event.. Valid values are `^[A-Za-z0-9,s]{0,500}$`',
    `heavy_metals_detected` STRING COMMENT 'Comma-separated list of heavy metals detected in the leachate sample (e.g., lead, cadmium, mercury, arsenic) per TCLP testing.. Valid values are `^[A-Za-z0-9,s]{0,500}$`',
    `lab_analysis_date` DATE COMMENT 'Date when the laboratory analysis of the leachate sample was completed.',
    `lab_sample_number` STRING COMMENT 'Unique identifier assigned to the laboratory sample for chain-of-custody tracking and analysis.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `leachate_head_level_inches` DECIMAL(18,2) COMMENT 'Measured leachate head level in inches above the liner at the collection point, critical for liner integrity monitoring.',
    `liner_integrity_status` STRING COMMENT 'Assessment of liner integrity at the collection point based on leachate head levels and monitoring data.. Valid values are `intact|compromised|under_investigation|repaired`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leachate collection record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes documenting observations, anomalies, or special conditions during the leachate collection event.. Valid values are `^[sS]{0,2000}$`',
    `permit_limit_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the leachate quality parameters were within permitted discharge limits (True = compliant, False = violation).',
    `ph_level` DECIMAL(18,2) COMMENT 'pH measurement of the collected leachate sample, indicating acidity or alkalinity.',
    `precipitation_last_24h_inches` DECIMAL(18,2) COMMENT 'Total precipitation in inches during the 24 hours prior to collection, affecting leachate generation volume.',
    `sample_collected_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a laboratory sample was collected during this event for detailed analysis (True = sample collected, False = no sample).',
    `total_dissolved_solids_mg_l` DECIMAL(18,2) COMMENT 'Total dissolved solids concentration in milligrams per liter.',
    `total_suspended_solids_mg_l` DECIMAL(18,2) COMMENT 'Total suspended solids concentration in milligrams per liter.',
    `volume_collected_gallons` DECIMAL(18,2) COMMENT 'Total volume of leachate collected during this event, measured in gallons.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of leachate collection, relevant for understanding generation rates and dilution effects.. Valid values are `clear|rain|snow|storm|fog`',
    CONSTRAINT pk_leachate_collection PRIMARY KEY(`leachate_collection_id`)
) COMMENT 'Transactional record of leachate generation, collection, and management events at each landfill site. Captures collection date, collection point (sump ID, pipe segment), volume collected (gallons), leachate head level (inches above liner), pH, conductivity, chemical oxygen demand (COD), and other key quality parameters. Records disposal method (on-site treatment, off-site TSDF, municipal sewer discharge under permit), disposal volume, disposal cost, and permit limit compliance flags. Critical for Clean Water Act compliance and liner integrity monitoring. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` (
    `lfg_monitoring_id` BIGINT COMMENT 'Unique identifier for the landfill gas monitoring record.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: When LFG monitoring detects exceedances requiring corrective maintenance (well repairs, header pipe leaks), operations generate work orders. Tracking this linkage is essential for demonstrating regula',
    `site_id` BIGINT COMMENT 'Identifier of the landfill site where the LFG monitoring was conducted.',
    `lfg_extraction_well_id` BIGINT COMMENT 'Foreign key linking to landfill.lfg_extraction_well. Business justification: LFG monitoring readings are collected at specific extraction wells. The monitoring_point_type can be extraction_well and monitoring_point_id currently stores well_identifier as STRING. Adding explic',
    `monitoring_point_id` BIGINT COMMENT 'Unique identifier for the specific monitoring point, probe, well, or perimeter location where the reading was taken. Examples include extraction well IDs, perimeter probe IDs, or interior monitoring point codes.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Landfill gas monitoring is mandated by air permits (NSPS/EG regulations). Each monitoring event should reference the permit establishing methane concentration limits, monitoring frequency, and correct',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: LFG monitoring data (methane, NMOC concentrations) is submitted to EPA/state agencies under NSPS Subpart WWW/XXX and NESHAP. The regulatory_report_flag is denormalized from regulatory_submission. Link',
    `barometric_pressure_inhg` DECIMAL(18,2) COMMENT 'Atmospheric barometric pressure at the time of monitoring measured in inches of mercury. Barometric pressure changes can affect landfill gas migration patterns.',
    `carbon_dioxide_concentration_pct` DECIMAL(18,2) COMMENT 'Carbon dioxide concentration measured as a percentage by volume at the monitoring point. Used to assess landfill gas composition and biological activity.',
    `carbon_monoxide_ppm` DECIMAL(18,2) COMMENT 'Carbon monoxide concentration measured in parts per million. Elevated CO levels may indicate incomplete combustion or subsurface smoldering.',
    `compliance_status` STRING COMMENT 'Current compliance status of the monitoring point based on the reading and applicable regulatory thresholds.. Valid values are `compliant|non_compliant|pending_review|corrective_action_in_progress`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions taken or planned in response to the monitoring reading, especially when exceedances or anomalies are detected.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator that is set to True when the monitoring reading requires immediate corrective action such as system adjustments, repairs, or enhanced monitoring.',
    `data_quality_flag` STRING COMMENT 'Quality assurance flag indicating the reliability and validity of the monitoring data. Suspect or invalid data may require re-sampling or equipment recalibration.. Valid values are `valid|suspect|invalid|calibration_required|equipment_malfunction`',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator that is set to True when the monitoring reading exceeds regulatory thresholds, such as LEL greater than 25%, triggering mandatory regulatory action and reporting.',
    `exceedance_type` STRING COMMENT 'Classification of the type of regulatory or operational threshold that was exceeded during the monitoring event.. Valid values are `lel_threshold|methane_threshold|surface_emission|odor_complaint|temperature_anomaly|pressure_anomaly`',
    `hydrogen_sulfide_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide concentration measured in parts per million. H2S is a toxic and corrosive gas that poses health and safety risks and can damage gas collection equipment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring point in decimal degrees. Used for spatial analysis and mapping of landfill gas distribution.',
    `lel_percentage` DECIMAL(18,2) COMMENT 'Lower Explosive Limit reading expressed as a percentage. LEL measures the concentration of combustible gas relative to the minimum concentration required for ignition. Regulatory action is triggered when LEL exceeds 25%.',
    `lfg_flow_rate_scfm` DECIMAL(18,2) COMMENT 'Volumetric flow rate of landfill gas measured in standard cubic feet per minute at the monitoring point. Used to calculate total gas extraction and energy recovery potential.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring point in decimal degrees. Used for spatial analysis and mapping of landfill gas distribution.',
    `methane_concentration_pct` DECIMAL(18,2) COMMENT 'Methane concentration measured as a percentage by volume at the monitoring point. Critical for assessing landfill gas composition and explosion risk.',
    `monitoring_date` DATE COMMENT 'Calendar date of the landfill gas monitoring event, used for daily and periodic compliance reporting.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency of monitoring at this point as required by regulatory permits or operational procedures.. Valid values are `daily|weekly|monthly|quarterly|annual|event_driven`',
    `monitoring_method` STRING COMMENT 'Standardized method or protocol used to conduct the landfill gas monitoring, ensuring consistency and regulatory compliance.. Valid values are `epa_method_21|epa_method_25|portable_analyzer|fixed_sensor|manual_sampling`',
    `monitoring_point_type` STRING COMMENT 'Classification of the monitoring point indicating its purpose and location within the landfill gas collection and monitoring system.. Valid values are `extraction_well|perimeter_probe|interior_probe|surface_emission_point|boundary_monitoring_station|gas_collection_header`',
    `monitoring_timestamp` TIMESTAMP COMMENT 'Date and time when the landfill gas monitoring reading was recorded in the field. This is the actual event time of the measurement, distinct from system audit timestamps.',
    `nitrogen_concentration_pct` DECIMAL(18,2) COMMENT 'Nitrogen concentration measured as a percentage by volume. Elevated nitrogen levels may indicate air intrusion or dilution of landfill gas.',
    `notes` STRING COMMENT 'Free-text field for technician observations, field conditions, equipment issues, or other contextual information relevant to the monitoring event.',
    `oxygen_concentration_pct` DECIMAL(18,2) COMMENT 'Oxygen concentration measured as a percentage by volume. Low oxygen levels indicate anaerobic conditions; elevated levels may indicate air intrusion into the landfill gas collection system.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring record was first created in the source system or data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring record was last updated in the source system or data platform.',
    `source_system` STRING COMMENT 'Name of the source system from which the monitoring record was ingested, typically Enviance EHS or a field data collection application.',
    `static_pressure_inches_wc` DECIMAL(18,2) COMMENT 'Static pressure measured in inches of water column at the monitoring point. Indicates the vacuum or pressure within the landfill gas collection system.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the landfill gas at the monitoring point measured in degrees Fahrenheit. Elevated temperatures may indicate subsurface fires or active decomposition.',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of monitoring. Weather can influence landfill gas migration and surface emission readings.. Valid values are `clear|cloudy|rain|snow|fog|wind`',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed at the time of monitoring measured in miles per hour. Wind conditions can influence surface emission dispersion and detection.',
    CONSTRAINT pk_lfg_monitoring PRIMARY KEY(`lfg_monitoring_id`)
) COMMENT 'Transactional record of landfill gas (LFG) monitoring readings across the site perimeter, extraction wells, and interior probes. Captures monitoring date and time, probe or well ID, location coordinates, methane concentration (% by volume), CO2 concentration, LEL (Lower Explosive Limit) percentage, oxygen level, nitrogen level, LFG flow rate (SCFM), static pressure, temperature, and exceedance flag (LEL > 25% triggers regulatory action). Supports EPA Clean Air Act surface emissions monitoring and NSPS Subpart WWW compliance. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` (
    `lfg_extraction_well_id` BIGINT COMMENT 'Primary key for lfg_extraction_well',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: LFG extraction wells are capital assets with acquisition costs, useful lives, and depreciation schedules. Asset management tracks these for RNG project valuations, warranty management, and capital rep',
    `inspection_checklist_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_checklist. Business justification: LFG extraction wells require standardized inspection checklists per 40 CFR Part 60 NSPS Subpart WWW/XXX for flow rate, vacuum, and methane concentration checks. Linking wells to their required checkli',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell where this extraction well is located. Supports cell-level gas collection tracking and capacity planning.',
    `site_id` BIGINT COMMENT 'Reference to the parent landfill site where this LFG extraction well is installed. Links to the landfill facility master record.',
    `monitoring_program_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_program. Business justification: LFG extraction wells are monitored under NSPS/NESHAP compliance monitoring programs that govern flow rate, pressure, and composition measurements. Linking lfg_extraction_well to monitoring_program ena',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: LFG extraction systems require air permits (Title V, NSPS). Wells should reference the permit authorizing gas collection, flaring, or energy recovery to ensure design extraction rates and vacuum level',
    `abandonment_date` DATE COMMENT 'Date when the well was permanently closed and abandoned. Wells are abandoned when no longer needed due to cell closure, system reconfiguration, or end of gas generation. Null for active wells.',
    `abandonment_method` STRING COMMENT 'Method used to permanently close the well. Grouted wells are filled with cement grout; capped wells have sealed wellheads; removed wells are fully extracted; other methods per site-specific procedures. Null for active wells.. Valid values are `grouted|capped|removed|other`',
    `asset_tag_number` STRING COMMENT 'Fixed asset tag or barcode identifier assigned by the asset management system. Links to Infor EAM for maintenance scheduling, parts inventory, and lifecycle tracking.',
    `casing_material` STRING COMMENT 'Material composition of the well casing. High-Density Polyethylene (HDPE) is most common for corrosion resistance; PVC, steel, and fiberglass are alternatives based on site conditions and design specifications.. Valid values are `HDPE|PVC|steel|fiberglass`',
    `construction_contractor` STRING COMMENT 'Name of the contractor or vendor that installed the extraction well. Used for warranty claims, quality tracking, and vendor performance evaluation.',
    `construction_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of well installation including materials, labor, and equipment in US dollars. Used for capital expenditure tracking, asset valuation, and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this well record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `design_extraction_rate_scfm` DECIMAL(18,2) COMMENT 'Designed gas extraction capacity of the well measured in standard cubic feet per minute (SCFM) at standard temperature and pressure. Used for system capacity planning and performance evaluation.',
    `design_vacuum_inches_h2o` DECIMAL(18,2) COMMENT 'Target vacuum pressure at the wellhead measured in inches of water column. Optimal vacuum range is typically 2-6 inches H2O to maximize gas extraction while minimizing air intrusion.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground surface elevation at the well location measured in feet above mean sea level. Used for hydraulic gradient calculations and leachate management.',
    `installation_date` DATE COMMENT 'Date when the LFG extraction well was installed and commissioned. Used for asset lifecycle tracking, warranty management, and regulatory compliance reporting.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent field inspection of the well. EPA NSPS Subpart WWW requires quarterly monitoring of wellhead parameters (flow, vacuum, temperature, methane concentration).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this well record was last updated. Used for change tracking, data quality monitoring, and audit compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the well location in decimal degrees. Used for GIS mapping, field navigation, and spatial analysis of gas collection network.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the well location in decimal degrees. Used for GIS mapping, field navigation, and spatial analysis of gas collection network.',
    `next_scheduled_inspection_date` DATE COMMENT 'Planned date for the next regulatory or preventive maintenance inspection. Supports compliance calendar management and field crew scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or historical context about the well. May include construction anomalies, performance issues, or site-specific considerations.',
    `operational_status` STRING COMMENT 'Current operational state of the LFG extraction well. Active wells are currently extracting gas; idle wells are installed but not in service; maintenance wells are temporarily offline; abandoned wells are permanently closed; planned wells are approved but not yet installed.. Valid values are `active|idle|maintenance|abandoned|planned`',
    `rng_production_eligible_flag` BOOLEAN COMMENT 'Indicates whether gas from this well is routed to the RNG production facility. True if well contributes to RNG production; false if gas is flared or used for waste-to-energy only. Supports RNG revenue allocation and environmental credit tracking.',
    `screen_interval_bottom_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the bottom of the perforated screen section. Defines the lower boundary of the gas collection zone.',
    `screen_interval_top_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the top of the perforated screen section. Defines the upper boundary of the gas collection zone.',
    `warranty_expiration_date` DATE COMMENT 'Date when the construction warranty expires. Typically 1-2 years from installation date. Used for warranty claim management and defect tracking.',
    `well_depth_feet` DECIMAL(18,2) COMMENT 'Total depth of the extraction well measured in feet from ground surface to bottom of well screen. Critical for gas collection efficiency and design capacity calculations.',
    `well_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the well casing measured in inches. Affects gas flow capacity and extraction efficiency.',
    `well_identifier` STRING COMMENT 'Business identifier or tag number for the LFG extraction well. Used for field operations, maintenance work orders, and regulatory reporting. May follow site-specific naming conventions (e.g., SITE-CELL-WELL-###).',
    `well_type` STRING COMMENT 'Classification of the extraction well design. Vertical wells are drilled vertically into waste mass; horizontal wells are installed horizontally in trenches; trench wells are perforated pipes in gravel-filled trenches.. Valid values are `vertical|horizontal|trench`',
    `wellhead_equipment_type` STRING COMMENT 'Classification of wellhead control and monitoring equipment. Standard wellheads have manual valves; adjustable wellheads allow field tuning; automated wellheads have remote control capability; monitoring-only wellheads are for observation wells.. Valid values are `standard|adjustable|automated|monitoring_only`',
    CONSTRAINT pk_lfg_extraction_well PRIMARY KEY(`lfg_extraction_well_id`)
) COMMENT 'Master record for each LFG extraction well installed within the landfill. Tracks well ID, cell reference, installation date, well depth (feet), well casing material, screen interval, wellhead equipment type, current operational status (active, idle, abandoned), connected header pipe segment, and design extraction rate (SCFM). Supports LFG collection system management, RNG (Renewable Natural Gas) production planning, and EPA compliance. Sourced from Enviance EHS and Infor EAM.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` (
    `groundwater_monitoring_well_id` BIGINT COMMENT 'Unique identifier for the groundwater monitoring well record. Primary key for the entity.',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Groundwater monitoring wells under RCRA Subtitle D are physically positioned relative to specific waste cells (e.g., downgradient of Cell 3) for detection monitoring programs. While a well is site-lev',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Groundwater monitoring wells are capitalized infrastructure assets requiring depreciation tracking, insurance valuation, and capital planning. Environmental services operators register wells as fixed ',
    `inspection_checklist_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_checklist. Business justification: Groundwater monitoring wells require standardized sampling checklists mandated by RCRA and state permits (purge procedures, field parameter measurements, chain-of-custody). Linking wells to their requ',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where this monitoring well is located. Links to the landfill facility master record.',
    `monitoring_program_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_program. Business justification: Groundwater monitoring wells operate under a formal compliance monitoring program that defines sampling parameters, frequency, and reporting requirements. The monitoring_program_type plain text is den',
    `monitoring_station_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_station. Business justification: Groundwater monitoring wells at landfills are monitoring stations tracked in compliance domain. Linking to canonical monitoring station record enables enterprise-wide environmental monitoring coordina',
    `analyte_list_code` STRING COMMENT 'Code or reference to the list of chemical analytes (parameters) tested during sampling events at this well. Typically Appendix I, Appendix II, or site-specific list per RCRA.',
    `aquifer_zone` STRING COMMENT 'Name or designation of the aquifer zone or hydrogeologic unit being monitored by this well (e.g., Upper Alluvial, Bedrock, Perched Water Table).',
    `casing_diameter_inches` DECIMAL(18,2) COMMENT 'Inside diameter of the well casing in inches. Determines sampling equipment compatibility and well capacity.',
    `casing_material` STRING COMMENT 'Material composition of the well casing. PVC is most common for environmental monitoring; stainless steel used for volatile organic compound (VOC) sampling.. Valid values are `PVC|stainless_steel|carbon_steel|HDPE`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring well record was first created in the system. Used for audit trail and data lineage.',
    `decommission_date` DATE COMMENT 'Date when the monitoring well was permanently decommissioned and sealed per regulatory requirements. Null for active wells.',
    `decommission_reason` STRING COMMENT 'Business or regulatory reason for decommissioning the well (e.g., landfill closure, well damage, redundant monitoring point, permit modification).',
    `elevation_feet_msl` DECIMAL(18,2) COMMENT 'Elevation of the well top-of-casing or ground surface reference point in feet above mean sea level. Critical for calculating hydraulic gradients and groundwater flow direction.',
    `epa_swis_well_code` STRING COMMENT 'Unique identifier assigned by EPA SWIS for this monitoring well. Used in federal reporting and data exchange with EPA.',
    `filter_pack_material` STRING COMMENT 'Material placed around the well screen to prevent fine sediment from entering the well while allowing groundwater flow. Typically clean silica sand.. Valid values are `silica_sand|gravel|natural_formation`',
    `installation_date` DATE COMMENT 'Date when the monitoring well was installed and became operational. Critical for establishing monitoring history and regulatory compliance timelines.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring well record was last updated. Used for audit trail and change tracking.',
    `last_sampling_date` DATE COMMENT 'Date of the most recent groundwater sampling event at this well. Used to track compliance with sampling frequency requirements.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring well location in decimal degrees. Used for spatial analysis and regulatory reporting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring well location in decimal degrees. Used for spatial analysis and regulatory reporting.',
    `next_scheduled_sampling_date` DATE COMMENT 'Planned date for the next groundwater sampling event. Calculated based on sampling frequency and last sampling date. Used for field scheduling.',
    `permit_reference_number` STRING COMMENT 'Reference number of the environmental permit or regulatory order that mandates monitoring at this well. Links well to specific compliance obligations.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether sampling results from this well must be included in regulatory reports to EPA or state agencies. True for compliance wells; false for supplemental monitoring points.',
    `sampling_frequency` STRING COMMENT 'Regulatory or operational frequency at which groundwater samples are collected from this well. Quarterly is typical for RCRA detection monitoring.. Valid values are `quarterly|semi_annual|annual|biennial|event_driven`',
    `screen_interval_bottom_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the bottom of the screened interval. Defines the monitored zone lower boundary.',
    `screen_interval_top_feet` DECIMAL(18,2) COMMENT 'Depth in feet from ground surface to the top of the screened interval where groundwater enters the well. Defines the monitored zone upper boundary.',
    `seal_material` STRING COMMENT 'Material used to seal the annular space between the borehole wall and well casing. Prevents surface water infiltration and cross-contamination between aquifer zones.. Valid values are `bentonite|cement_grout|bentonite_grout|neat_cement`',
    `state_well_permit_number` STRING COMMENT 'State-issued permit or registration number for the monitoring well. Required in many jurisdictions for all groundwater monitoring wells.',
    `static_water_level_feet` DECIMAL(18,2) COMMENT 'Most recent measured depth to groundwater from the top of casing, in feet. Used to calculate groundwater elevation and flow direction. Updated after each sampling event.',
    `total_depth_feet` DECIMAL(18,2) COMMENT 'Total depth of the monitoring well from ground surface to bottom, measured in feet. Determines the aquifer zone being monitored.',
    `well_construction_method` STRING COMMENT 'Drilling and installation method used to construct the monitoring well. Hollow stem auger is most common for shallow environmental wells.. Valid values are `hollow_stem_auger|mud_rotary|air_rotary|direct_push|cable_tool`',
    `well_designation` STRING COMMENT 'Business identifier for the monitoring well, typically assigned per site naming convention (e.g., MW-01, GW-UG-03). Used in regulatory reports and field operations.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `well_development_date` DATE COMMENT 'Date when well development (removal of drilling fluids and fines) was completed and the well was ready for sampling. Typically occurs shortly after installation.',
    `well_notes` STRING COMMENT 'Free-text field for operational notes, field observations, maintenance history, or special sampling instructions for this well.',
    `well_status` STRING COMMENT 'Current operational status of the monitoring well in its lifecycle. Active wells are sampled per schedule; inactive wells are not currently monitored.. Valid values are `active|inactive|abandoned|under_construction|decommissioned|temporarily_suspended`',
    `well_type` STRING COMMENT 'Classification of the well based on its position relative to the landfill and regulatory purpose. Upgradient wells establish baseline conditions; downgradient wells detect contamination migration.. Valid values are `upgradient|downgradient|compliance|detection|assessment|background`',
    CONSTRAINT pk_groundwater_monitoring_well PRIMARY KEY(`groundwater_monitoring_well_id`)
) COMMENT 'Master record for each groundwater monitoring well at a landfill site. Captures well ID, site reference, well designation (upgradient, downgradient, compliance), installation date, total depth (feet), screened interval, aquifer zone monitored, GPS coordinates, sampling frequency (quarterly, semi-annual, annual), regulatory permit reference, and current operational status. Anchors all groundwater sampling events and is required for RCRA Subtitle D detection monitoring programs. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` (
    `groundwater_sample_id` BIGINT COMMENT 'Unique identifier for the groundwater sampling event record.',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_environmental_monitoring. Business justification: Groundwater samples collected at landfills are compliance environmental monitoring events. Linking to compliance domains canonical monitoring record enables regulatory reporting (SWIS, CERCLA), excee',
    `groundwater_monitoring_well_id` BIGINT COMMENT 'Reference to the monitoring well where the sample was collected.',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where the monitoring well is located.',
    `analysis_complete_date` DATE COMMENT 'Date when laboratory analysis of the sample was completed.',
    `analysis_start_date` DATE COMMENT 'Date when laboratory analysis of the sample began.',
    `analytical_parameters_tested` STRING COMMENT 'Comma-separated list of analytical parameters and contaminants tested in this sample (e.g., VOCs, metals, indicator parameters).',
    `cercla_reportable_flag` BOOLEAN COMMENT 'Indicates whether detected concentrations trigger CERCLA (Superfund) reporting obligations.',
    `chain_of_custody_number` STRING COMMENT 'Unique chain of custody document number tracking sample handling from collection through analysis.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this groundwater sample record was first created in the system.',
    `exceedance_detected_flag` BOOLEAN COMMENT 'Indicates whether any detected concentrations exceeded applicable Groundwater Protection Standard (GWPS) limits or regulatory thresholds.',
    `exceedance_parameters` STRING COMMENT 'Comma-separated list of specific parameters that exceeded applicable Groundwater Protection Standard (GWPS) limits.',
    `field_conductivity_umhos` DECIMAL(18,2) COMMENT 'Specific conductivity measured in the field at the time of sample collection, in micromhos per centimeter.',
    `field_dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration measured in the field at the time of sample collection, in milligrams per liter.',
    `field_notes` STRING COMMENT 'Additional field observations, notes, or comments recorded by the sampling technician during sample collection.',
    `field_oxidation_reduction_potential_mv` DECIMAL(18,2) COMMENT 'Oxidation-reduction potential (ORP) measured in the field at the time of sample collection, in millivolts.',
    `field_ph` DECIMAL(18,2) COMMENT 'pH measurement taken in the field at the time of sample collection.',
    `field_temperature_celsius` DECIMAL(18,2) COMMENT 'Water temperature measured in the field at the time of sample collection, in degrees Celsius.',
    `field_turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measured in the field at the time of sample collection, in Nephelometric Turbidity Units.',
    `gwps_limit_exceeded` STRING COMMENT 'Description of the specific Groundwater Protection Standard limit that was exceeded, including the parameter name and limit value.',
    `laboratory_name` STRING COMMENT 'Name of the certified analytical laboratory that performed the sample analysis.',
    `laboratory_sample_number` STRING COMMENT 'Unique identifier assigned by the analytical laboratory for tracking and reporting purposes.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this groundwater sample record was last modified in the system.',
    `metals_analysis_method` STRING COMMENT 'EPA analytical method used for metals analysis (typically ICP or ICP-MS). [ENUM-REF-CANDIDATE: EPA_6010|EPA_6010B|EPA_6010C|EPA_6010D|EPA_6020|EPA_6020A|EPA_6020B|not_tested — 8 candidates stripped; promote to reference product]',
    `monitoring_program_type` STRING COMMENT 'Type of groundwater monitoring program under which this sample was collected (detection, assessment, corrective action, or post-closure).. Valid values are `detection|assessment|corrective_action|post_closure`',
    `purge_volume_gallons` DECIMAL(18,2) COMMENT 'Volume of water purged from the monitoring well prior to sample collection, measured in gallons.',
    `qa_qc_flag` STRING COMMENT 'Quality assurance and quality control status of the sample results.. Valid values are `passed|failed|qualified|pending`',
    `qa_qc_notes` STRING COMMENT 'Notes regarding quality assurance or quality control issues, qualifications, or observations related to the sample.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory authorities were notified of exceedance or other reportable conditions.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory notification to EPA, state, or Local Enforcement Agency (LEA) is required based on sample results.',
    `sample_appearance` STRING COMMENT 'Visual description of the sample appearance (e.g., clear, cloudy, discolored, odor present).',
    `sample_date` DATE COMMENT 'Date when the groundwater sample was collected from the monitoring well.',
    `sample_number` STRING COMMENT 'Unique field sample identification number assigned by the sampling technician or laboratory.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `sample_received_date` DATE COMMENT 'Date when the sample was received by the analytical laboratory.',
    `sample_time` TIMESTAMP COMMENT 'Precise timestamp when the groundwater sample was collected, including time zone.',
    `sample_type` STRING COMMENT 'Classification of the sample purpose (routine monitoring, confirmation, assessment, background, quality control duplicate, or blank).. Valid values are `routine|confirmation|assessment|background|duplicate|blank`',
    `sampling_method` STRING COMMENT 'Method used to collect the groundwater sample from the monitoring well.. Valid values are `bailer|peristaltic_pump|bladder_pump|submersible_pump|grab_sample|other`',
    `swis_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this sample result must be included in EPA Solid Waste Information System (SWIS) reporting.',
    `voc_analysis_method` STRING COMMENT 'EPA analytical method used for volatile organic compound analysis.. Valid values are `EPA_8260|EPA_8260B|EPA_8260C|EPA_8260D|not_tested`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection (e.g., clear, rainy, snowy).',
    CONSTRAINT pk_groundwater_sample PRIMARY KEY(`groundwater_sample_id`)
) COMMENT 'Transactional record of each groundwater sampling event conducted at a monitoring well. Captures sample date, well reference, sampling technician, field parameters (pH, temperature, conductivity, dissolved oxygen, turbidity), laboratory sample IDs, chain-of-custody number, analytical parameters tested (VOCs, metals, indicator parameters per EPA Method 8260/6010), detected concentrations, applicable groundwater protection standard (GWPS) limits, exceedance flags, and required regulatory notification status. Supports RCRA Subtitle D detection and assessment monitoring compliance. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique identifier for the capacity plan version record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: Landfill capacity plans directly drive capital projects for cell construction, liner installation, and lateral expansions. Capital budgeting and permit renewal workflows require linking approved capac',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Landfill capacity plans must validate remaining airspace against contracted annual tonnage commitments in disposal agreements. Capacity planning reports and permit renewal applications require reconci',
    `site_id` BIGINT COMMENT 'Reference to the landfill site for which this capacity plan is created.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Capacity planning must align with permitted capacity limits. Plans should reference the permit establishing total design capacity, daily tonnage limits, and vertical/lateral expansion authorization to',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Capacity plans are submitted to regulators for permit renewal and annual reporting. Linking capacity_plan to regulatory_submission tracks the formal submission document, agency response, and confirmat',
    `airspace_survey_date` DATE COMMENT 'Date of the most recent topographic survey used to determine consumed and remaining airspace for this capacity plan.',
    `annual_waste_acceptance_rate_tons` DECIMAL(18,2) COMMENT 'Assumed annual waste acceptance volume in tons used for capacity planning. Calculated from daily rate assumptions.',
    `annual_waste_acceptance_rate_tpd` DECIMAL(18,2) COMMENT 'Assumed average daily waste acceptance rate in Tons Per Day (TPD) used for capacity planning projections. Based on historical trends and market forecasts.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved this capacity plan version.',
    `assumptions_notes` STRING COMMENT 'Detailed narrative describing key assumptions, methodologies, constraints, and special considerations used in developing this capacity plan.',
    `capacity_consumed_to_date_cy` DECIMAL(18,2) COMMENT 'Cumulative airspace consumed as of the plan effective date, measured in cubic yards. Based on topographic surveys and waste placement records.',
    `capacity_consumed_to_date_tons` DECIMAL(18,2) COMMENT 'Cumulative waste tonnage received as of the plan effective date. Based on scale house records and historical acceptance data.',
    `capital_investment_required` DECIMAL(18,2) COMMENT 'Estimated total capital investment required to execute this capacity plan, including expansion construction, infrastructure, and equipment. Measured in US dollars.',
    `compaction_ratio_assumption` DECIMAL(18,2) COMMENT 'Assumed waste compaction ratio (volume reduction factor) used in capacity calculations. Represents the ratio of in-place compacted waste density to loose waste density.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was first created in the system.',
    `daily_cover_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of airspace consumed by daily cover material application. Used to adjust net waste capacity calculations.',
    `effective_date` DATE COMMENT 'Date from which this capacity plan version becomes the active planning baseline.',
    `engineer_license_number` STRING COMMENT 'Professional engineering license number of the responsible engineer who certified this capacity plan.',
    `expansion_permit_status` STRING COMMENT 'Current status of permit applications for planned capacity expansions (vertical or lateral). Not applicable if no expansion is planned.. Valid values are `not_applicable|planned|application_submitted|under_review|approved|denied`',
    `expansion_target_completion_date` DATE COMMENT 'Target date for completion of planned expansion construction and availability of additional capacity. Null if no expansion is planned.',
    `expiration_date` DATE COMMENT 'Date when this capacity plan version is superseded or expires. Null for open-ended plans.',
    `final_cover_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of airspace consumed by final cap system installation. Includes liner, drainage, and vegetation layers.',
    `intermediate_cover_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of airspace consumed by intermediate cover systems. Applied to areas inactive for extended periods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was last updated in the system.',
    `lateral_expansion_capacity_cy` DECIMAL(18,2) COMMENT 'Additional airspace capacity (cubic yards) to be gained through lateral expansion, if planned. Null if no lateral expansion is planned.',
    `lateral_expansion_planned` BOOLEAN COMMENT 'Indicates whether lateral expansion (footprint increase) is included in this capacity plan. True if lateral expansion is planned and permitted.',
    `permit_renewal_required` BOOLEAN COMMENT 'Indicates whether permit renewal or modification is required to execute this capacity plan. True if regulatory action is needed.',
    `permit_renewal_target_date` DATE COMMENT 'Target date for obtaining required permit renewals or modifications to support this capacity plan. Null if no permit action is required.',
    `plan_approval_date` DATE COMMENT 'Date when this capacity plan version was formally approved by management or regulatory authorities.',
    `plan_name` STRING COMMENT 'Descriptive name for this capacity plan version (e.g., FY2024 Long-Range Capacity Plan, 10-Year Airspace Projection).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the capacity plan. Tracks approval workflow and active status.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `plan_type` STRING COMMENT 'Classification of the capacity plan by planning horizon and purpose (e.g., annual operational plan, long-range strategic plan, permit renewal plan).. Valid values are `annual|five_year|ten_year|long_range|permit_renewal|expansion`',
    `plan_version` STRING COMMENT 'Version identifier for this capacity plan iteration (e.g., 2024.1, 2024.2). Supports tracking of plan revisions over time.',
    `planning_horizon_years` STRING COMMENT 'Number of years covered by this capacity plan (e.g., 1, 5, 10, 20).',
    `projected_closure_year` STRING COMMENT 'Calendar year in which the landfill is projected to reach capacity and begin final closure activities.',
    `projected_site_life_years` DECIMAL(18,2) COMMENT 'Estimated number of years until the landfill reaches permitted capacity and requires closure, based on current waste acceptance rates and compaction assumptions.',
    `remaining_airspace_cy` DECIMAL(18,2) COMMENT 'Available airspace remaining for waste placement, measured in cubic yards. Calculated as total permitted capacity minus capacity consumed to date.',
    `remaining_capacity_tons` DECIMAL(18,2) COMMENT 'Available waste capacity remaining, measured in tons. Calculated using remaining airspace and assumed compaction ratios.',
    `responsible_engineer` STRING COMMENT 'Name of the professional engineer responsible for preparing and certifying this capacity plan.',
    `total_permitted_capacity_cy` DECIMAL(18,2) COMMENT 'Total airspace capacity permitted for the landfill site, measured in cubic yards. Represents the maximum volume authorized by regulatory permits.',
    `total_permitted_capacity_tons` DECIMAL(18,2) COMMENT 'Total waste capacity permitted for the landfill site, measured in tons. Derived from cubic yards using assumed compaction ratios.',
    `vertical_expansion_capacity_cy` DECIMAL(18,2) COMMENT 'Additional airspace capacity (cubic yards) to be gained through vertical expansion, if planned. Null if no vertical expansion is planned.',
    `vertical_expansion_planned` BOOLEAN COMMENT 'Indicates whether vertical expansion (height increase) is included in this capacity plan. True if vertical expansion is planned and permitted.',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Versioned master record for the site-level airspace capacity planning model. Tracks plan version, effective date, total permitted capacity (cubic yards and tons), capacity consumed to date, remaining airspace, projected site life (years), annual waste acceptance rate assumption (TPD), compaction ratio assumption, cover factors (daily/intermediate/final), projected closure year, vertical expansion assumptions, and plan approval status. Drives long-range capital planning, permit renewal timing, and executive site-life reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` (
    `landfill_tipping_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the tipping fee schedule record. Primary key.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Tipping fee schedules are often structured by service offering type to enable service-specific pricing, competitive analysis, and margin management. Linking schedules to offerings ensures fee structur',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where this tipping fee schedule applies. Links to the site master for facility-specific fee structures.',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: Tipping fee schedules must be reconciled against contracted pricing records for revenue recognition and contract compliance audits. The schedules base_rate and surcharges must align with the contract',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Tipping fee schedules apply differentiated rates by customer segment (residential, commercial, industrial). Linking to customer.segment via FK replaces the denormalized customer_segment plain text col',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Tipping fee schedules are differentiated by waste stream type. Linking to service.waste_stream normalizes waste_type/waste_subtype denormalized columns, enabling waste-stream-level fee analysis, regul',
    `approval_date` DATE COMMENT 'Date when this fee schedule was formally approved for use. Part of the approval audit trail.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle state of the fee schedule. Draft (under development), Pending (awaiting approval), Approved (ready for activation), Active (currently in use), Superseded (replaced by newer version), or Cancelled (withdrawn).. Valid values are `Draft|Pending|Approved|Active|Superseded|Cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this fee schedule for activation. Supports audit trail and accountability.',
    `base_rate` DECIMAL(18,2) COMMENT 'Standard tipping fee rate per unit of measure before any surcharges or adjustments. Core pricing component for revenue calculation.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the customer contract or municipal agreement that governs this fee schedule. Links pricing to contractual terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this fee schedule. Supports multi-currency operations across North American markets.. Valid values are `USD|CAD|MXN`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rate for volume commitments, long-term contracts, or promotional pricing. Expressed as a percentage (e.g., 5.00 for 5%).',
    `effective_end_date` DATE COMMENT 'Date when this tipping fee schedule expires or is superseded by a new schedule. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this tipping fee schedule becomes active and applicable for billing. Supports time-based rate transitions.',
    `environmental_surcharge_rate` DECIMAL(18,2) COMMENT 'Per-unit fee to cover environmental compliance costs including monitoring, remediation, and regulatory reporting. Supports EPA and state environmental program funding.',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Additional per-unit charge to offset fuel cost fluctuations. Applied on top of base rate and adjusted periodically based on fuel price indices.',
    `host_community_fee_rate` DECIMAL(18,2) COMMENT 'Per-unit fee paid to the host municipality or community as part of host community agreements. Compensates local jurisdictions for hosting landfill operations.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum fee cap per transaction for high-volume loads. Used in negotiated contracts or promotional pricing structures.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum fee amount charged per transaction regardless of tonnage or volume. Ensures cost recovery for small loads and administrative processing.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this fee schedule record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fee schedule record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or clarifications related to this fee schedule. Supports operational context and exception documentation.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a special permit or pre-approval is required before accepting waste under this fee schedule. True if permit required, False otherwise.',
    `pricing_tier` STRING COMMENT 'Tiered pricing level or bracket identifier for volume-based or relationship-based pricing structures (e.g., Tier 1, Tier 2, Premium, Standard).',
    `regulatory_surcharge_rate` DECIMAL(18,2) COMMENT 'Per-unit fee to cover regulatory compliance costs including permit fees, inspections, and mandated reporting. Varies by jurisdiction and waste type.',
    `schedule_name` STRING COMMENT 'Descriptive name for the tipping fee schedule to identify the rate structure (e.g., Standard MSW Rates 2024, Commercial C&D Rates).',
    `schedule_version` STRING COMMENT 'Version identifier for the fee schedule to track revisions and updates over time. Supports historical fee analysis and audit trails.',
    `special_handling_required` BOOLEAN COMMENT 'Indicates whether waste under this fee schedule requires special handling procedures, equipment, or disposal methods. True if special handling is required, False otherwise.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this fee schedule applies to tax-exempt customers (e.g., government entities, non-profits). True if tax-exempt, False otherwise.',
    `unit_of_measure` STRING COMMENT 'Unit basis for the tipping fee calculation. Options include Ton (weight-based), Cubic Yard (volume-based), Load (per vehicle), or Each (per item for specific waste types like tires).. Valid values are `Ton|Cubic Yard|Load|Each`',
    `volume_threshold_tons` DECIMAL(18,2) COMMENT 'Minimum tonnage threshold required to qualify for this fee schedule or pricing tier. Supports volume-based pricing incentives.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this fee schedule record. Supports accountability and audit trail.',
    CONSTRAINT pk_landfill_tipping_fee_schedule PRIMARY KEY(`landfill_tipping_fee_schedule_id`)
) COMMENT 'Reference master defining tipping fee rates charged to customers and haulers for waste disposal at each landfill site. Captures fee schedule version, effective date range, site reference, waste type (MSW, C&D, special waste, sludge, tires), customer segment (municipal, commercial, self-haul), unit of measure (per ton, per cubic yard, per load), base rate, surcharges (fuel, environmental, regulatory), minimum charge, and approval status. Drives tipping fee calculation on tonnage receipts and integrates with Oracle Revenue Management for billing. Sourced from Oracle Revenue Management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`disposal_permit` (
    `disposal_permit_id` BIGINT COMMENT 'Unique identifier for the disposal permit record. Primary key.',
    `site_id` BIGINT COMMENT 'Reference to the landfill site governed by this permit.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Landfill disposal permits are compliance permits and should reference the central compliance.permit table for unified permit management, renewal tracking, and compliance reporting across all facility ',
    `compliance_status` STRING COMMENT 'Current compliance status of the facility with respect to this permit (compliant, non-compliant, conditional compliance, under investigation).. Valid values are `compliant|non_compliant|conditional_compliance|under_investigation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the permit becomes legally binding and operational requirements take effect.',
    `environmental_coordinator_name` STRING COMMENT 'Name of the internal environmental coordinator responsible for managing this permit.',
    `expiration_date` DATE COMMENT 'Date when the permit expires and is no longer valid unless renewed.',
    `financial_assurance_amount` DECIMAL(18,2) COMMENT 'Total amount of financial assurance required for closure and post-closure care under this permit, in USD.',
    `financial_assurance_mechanism` STRING COMMENT 'Type of financial assurance mechanism used to meet permit requirements (trust fund, surety bond, letter of credit, insurance, corporate guarantee, state fund).. Valid values are `trust_fund|surety_bond|letter_of_credit|insurance|corporate_guarantee|state_fund`',
    `financial_assurance_required` BOOLEAN COMMENT 'Indicates whether financial assurance (closure and post-closure care funding) is required under this permit.',
    `issue_date` DATE COMMENT 'Date when the permit was officially issued by the regulatory authority. Represents the effective start of the permit.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory agency that issued the permit (e.g., EPA, state environmental agency, Local Enforcement Agency).',
    `issuing_agency_code` STRING COMMENT 'Standardized code for the issuing regulatory agency.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection related to this permit.',
    `last_renewal_date` DATE COMMENT 'Date when the permit was most recently renewed.',
    `last_report_submission_date` DATE COMMENT 'Date when the most recent compliance report was submitted to the regulatory authority.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next regulatory inspection required under this permit.',
    `next_report_due_date` DATE COMMENT 'Deadline for the next compliance report submission required under this permit.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the permit, including historical amendments or special circumstances.',
    `permit_conditions_summary` STRING COMMENT 'High-level summary of key conditions, restrictions, and operational requirements imposed by the permit.',
    `permit_document_reference` STRING COMMENT 'File path, URL, or document management system reference to the official permit document.',
    `permitted_daily_tonnage_limit` DECIMAL(18,2) COMMENT 'Maximum tonnage of waste authorized for receipt per day under this permit, measured in tons per day (TPD).',
    `permitted_total_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Total lifetime capacity authorized under this permit, measured in cubic yards.',
    `permitted_total_capacity_tons` DECIMAL(18,2) COMMENT 'Total lifetime capacity authorized under this permit, measured in tons.',
    `permitted_waste_types` STRING COMMENT 'Comma-separated list of waste types authorized for disposal under this permit (e.g., MSW, C&D, special waste, industrial waste).',
    `renewal_application_due_date` DATE COMMENT 'Deadline by which the permit renewal application must be submitted to the regulatory authority to avoid lapse.',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to the regulatory authority (monthly, quarterly, semi-annual, annual, as required).. Valid values are `monthly|quarterly|semi_annual|annual|as_required`',
    `responsible_party_contact` STRING COMMENT 'Contact information (phone or email) for the responsible party.',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organization legally responsible for compliance with this permit.',
    `special_conditions` STRING COMMENT 'Detailed description of any special or site-specific conditions attached to the permit (e.g., enhanced monitoring, restricted hours, buffer zone requirements).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last modified in the system.',
    CONSTRAINT pk_disposal_permit PRIMARY KEY(`disposal_permit_id`)
) COMMENT 'Master record for each regulatory permit governing landfill operations at a site. Captures permit number, issuing regulatory agency (EPA, state environmental agency, LEA), permit type (solid waste facility permit, air permit, water discharge permit, stormwater NPDES), permitted waste types, permitted daily tonnage limit, permitted total capacity, permit issuance date, expiration date, renewal application due date, permit conditions summary, and current compliance status. Anchors all regulatory compliance activities and reporting obligations. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` (
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection record. Primary key.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Landfill regulatory inspections are compliance inspections - same business event. Linking to compliance domains canonical inspection record enables enterprise-wide compliance tracking, violation mana',
    `disposal_permit_id` BIGINT COMMENT 'Foreign key linking to landfill.disposal_permit. Business justification: Regulatory inspections are conducted to verify compliance with specific disposal permit conditions. Each inspection evaluates adherence to permit requirements such as permitted waste types, daily tonn',
    `site_id` BIGINT COMMENT 'Identifier of the landfill site where the inspection was conducted.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: When a landfill regulatory inspection results in enforcement action, the resulting NOV must be tracked. Enforcement tracking and penalty management require linking the landfill inspection record to th',
    `agency_jurisdiction` STRING COMMENT 'Level of government jurisdiction of the inspecting agency (federal, state, local, or tribal authority).. Valid values are `federal|state|local|tribal`',
    `areas_inspected` STRING COMMENT 'Comma-separated list or detailed description of specific physical areas and operational zones inspected (e.g., active face, leachate treatment plant, gas collection wells, perimeter monitoring stations, equipment yard).',
    `cercla_relevance` BOOLEAN COMMENT 'Boolean flag indicating whether this inspection has relevance to CERCLA (Superfund) obligations or potential liability (True) or not (False).',
    `corrective_action_completion_date` DATE COMMENT 'Actual date on which all required corrective actions were completed and documented by the facility.',
    `corrective_action_due_date` DATE COMMENT 'Deadline date by which the facility must complete and document all required corrective actions to achieve compliance.',
    `corrective_action_required` STRING COMMENT 'Detailed description of corrective actions, remediation measures, or operational changes required by the regulatory agency to address identified violations or deficiencies.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective action implementation (not started, in progress, completed, verified by agency, or overdue).. Valid values are `not-started|in-progress|completed|verified|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system.',
    `enforcement_action_taken` STRING COMMENT 'Type of formal enforcement action taken by the regulatory agency as a result of the inspection findings (none, warning letter, notice of violation, consent order, or monetary penalty).. Valid values are `none|warning-letter|notice-of-violation|consent-order|penalty`',
    `facility_response_date` DATE COMMENT 'Date on which the facility submitted its formal response or corrective action plan to the regulatory agency.',
    `facility_response_reference` STRING COMMENT 'Document reference number or file path to the facilitys formal response, corrective action plan, or appeal submitted to the regulatory agency.',
    `findings_summary` STRING COMMENT 'High-level summary of the inspection findings, including observations, deficiencies identified, and areas of compliance.',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled or actual date of the follow-up inspection conducted to verify corrective action implementation and compliance restoration.',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory agency has mandated a follow-up inspection to verify corrective action completion (True) or not (False).',
    `inspecting_agency` STRING COMMENT 'Name of the regulatory agency that conducted the inspection (e.g., EPA, state environmental quality department, Local Enforcement Agency).',
    `inspection_closure_date` DATE COMMENT 'Date on which the inspection case was officially closed by the regulatory agency, indicating all corrective actions have been verified and compliance has been restored.',
    `inspection_date` DATE COMMENT 'Date on which the regulatory inspection was conducted at the landfill site.',
    `inspection_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the inspection in hours, from arrival to departure of the inspection team.',
    `inspection_number` STRING COMMENT 'Unique business identifier assigned to the inspection by the regulatory agency or internal tracking system.',
    `inspection_report_reference` STRING COMMENT 'Document reference number, file path, or URL to the official inspection report issued by the regulatory agency.',
    `inspection_scope` STRING COMMENT 'Description of the areas, systems, and operations included in the inspection scope (e.g., active face, leachate collection system, LFG system, groundwater monitoring wells, daily cover operations, liner integrity).',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record (scheduled, in-progress, completed, closed, or pending response from facility).. Valid values are `scheduled|in-progress|completed|closed|pending-response`',
    `inspection_type` STRING COMMENT 'Classification of the inspection based on its purpose and trigger (routine scheduled, complaint-driven, follow-up to previous findings, special investigation, unannounced, or pre-operational).. Valid values are `routine|complaint-driven|follow-up|special|unannounced|pre-operational`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last modified or updated in the system.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to the inspection that do not fit into structured fields, including inspector comments or facility explanations.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed by the regulatory agency for violations identified during the inspection, in US dollars.',
    `rcra_compliance_status` STRING COMMENT 'Overall RCRA Subtitle D compliance status determination resulting from the inspection (compliant, non-compliant, or conditional compliance with corrective action plan).. Valid values are `compliant|non-compliant|conditional`',
    `regulatory_citations` STRING COMMENT 'Specific regulatory code sections, permit conditions, or rule citations that were violated or referenced in the inspection findings (e.g., 40 CFR 258.28, state permit condition 4.2.1).',
    `responsible_manager` STRING COMMENT 'Name of the facility manager or compliance officer responsible for coordinating the inspection response and corrective action implementation.',
    `severity_level` STRING COMMENT 'Overall severity classification of the inspection findings (minor, moderate, major, or critical) based on environmental risk and regulatory impact.. Valid values are `minor|moderate|major|critical`',
    `swis_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether this inspection must be reported to the EPA Solid Waste Information System (SWIS) (True) or not (False).',
    `swis_submission_date` DATE COMMENT 'Date on which the inspection data was submitted to the EPA Solid Waste Information System for regulatory reporting.',
    `violation_count` STRING COMMENT 'Total number of distinct violations or deficiencies cited in the inspection report.',
    `violations_cited` STRING COMMENT 'Detailed description of any regulatory violations cited during the inspection, including specific non-compliance issues identified.',
    CONSTRAINT pk_regulatory_inspection PRIMARY KEY(`regulatory_inspection_id`)
) COMMENT 'Transactional record of regulatory agency inspections conducted at a landfill site. Captures inspection date, inspecting agency (EPA, state, LEA), inspector name and credentials, inspection type (routine, complaint-driven, follow-up), areas inspected (active face, leachate system, LFG system, groundwater monitoring), findings and violations cited (with regulatory citation), corrective action required, corrective action due date, and inspection closure status. Supports RCRA Subtitle D compliance tracking and CERCLA/Superfund obligation management. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`closure_plan` (
    `closure_plan_id` BIGINT COMMENT 'Unique identifier for the landfill closure and post-closure care plan record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: Landfill closure plans require capital projects for cap system installation, post-closure monitoring infrastructure, and financial assurance funding. Regulatory financial assurance mechanisms (estimat',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell covered by this closure plan. Nullable if the plan applies to the entire site rather than a single cell.',
    `disposal_permit_id` BIGINT COMMENT 'Foreign key linking to landfill.disposal_permit. Business justification: Closure plans are regulatory documents that must be approved by the permitting authority under the disposal permit. The closure plan defines cap system design, post-closure care period, monitoring sch',
    `site_id` BIGINT COMMENT 'Reference to the landfill site for which this closure plan is defined.',
    `monitoring_program_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_program. Business justification: Closure plans define post-closure monitoring obligations (groundwater, LFG, leachate) that are formally managed as compliance monitoring programs. Linking closure_plan to monitoring_program enables po',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Landfill closure plans are mandated by specific regulations (RCRA Subtitle D, 40 CFR Part 258). Closure plan preparation, approval, and financial assurance calculations must reference the governing re',
    `actual_closure_completion_date` DATE COMMENT 'Actual date on which all closure construction activities were completed and the final cap system was installed.',
    `actual_closure_start_date` DATE COMMENT 'Actual date on which closure activities commenced.',
    `approval_authority` STRING COMMENT 'Name of the regulatory agency or Local Enforcement Agency (LEA) that approved the closure plan.',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority approved the closure plan.',
    `cap_barrier_material` STRING COMMENT 'Type of impermeable barrier material used in the cap system (e.g., geomembrane, clay, composite liner).',
    `cap_drainage_system` STRING COMMENT 'Description of the drainage layer and system designed to manage stormwater runoff and prevent infiltration into the waste mass.',
    `cap_inspection_frequency` STRING COMMENT 'Frequency of visual inspections of the final cap system during the post-closure care period (e.g., quarterly, semi-annually).',
    `cap_layer_count` STRING COMMENT 'Number of distinct layers in the final cap system (e.g., barrier layer, drainage layer, soil layer, vegetation layer).',
    `cap_system_design` STRING COMMENT 'Detailed description of the final cover system design, including layer composition, materials, and engineering specifications.',
    `cap_total_thickness_inches` DECIMAL(18,2) COMMENT 'Total thickness of the final cap system measured in inches, from the waste surface to the top of the vegetation layer.',
    `cap_vegetation_type` STRING COMMENT 'Type of vegetation to be established on the final cap surface (e.g., native grasses, low-maintenance groundcover).',
    `cost_estimate_basis` STRING COMMENT 'Methodology or standard used to prepare the cost estimate (e.g., third-party engineer estimate, regulatory cost formula).',
    `cost_estimate_date` DATE COMMENT 'Date on which the closure and post-closure cost estimates were prepared or last updated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closure plan record was first created in the system.',
    `engineer_license_number` STRING COMMENT 'Professional engineering license number of the responsible engineer.',
    `estimated_closure_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for completing all closure activities, including final cap installation, grading, and site preparation.',
    `estimated_post_closure_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for the 30-year post-closure care period, including monitoring, maintenance, and reporting activities.',
    `financial_assurance_amount` DECIMAL(18,2) COMMENT 'Total amount of financial assurance secured to cover closure and post-closure care costs.',
    `financial_assurance_expiration_date` DATE COMMENT 'Expiration or renewal date of the financial assurance instrument, if applicable.',
    `financial_assurance_mechanism` STRING COMMENT 'Type of financial assurance instrument used to demonstrate the ability to fund closure and post-closure care as required under RCRA Subtitle D.. Valid values are `trust_fund|surety_bond|letter_of_credit|insurance|corporate_guarantee|state_fund`',
    `financial_assurance_provider` STRING COMMENT 'Name of the institution or entity providing the financial assurance instrument (e.g., bank, insurance company, surety).',
    `groundwater_sampling_frequency` STRING COMMENT 'Frequency of groundwater monitoring well sampling during the post-closure care period (e.g., quarterly, semi-annually).',
    `leachate_monitoring_frequency` STRING COMMENT 'Frequency of leachate collection system inspections and monitoring during the post-closure care period.',
    `lfg_monitoring_frequency` STRING COMMENT 'Frequency of landfill gas monitoring activities during the post-closure care period, including Lower Explosive Limit (LEL) readings.',
    `monitoring_schedule` STRING COMMENT 'Detailed schedule of post-closure monitoring activities, including frequency and timing of inspections, sampling, and reporting.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to the closure plan.',
    `plan_document_reference` STRING COMMENT 'File path, document management system reference, or URL to the full closure plan document.',
    `plan_number` STRING COMMENT 'Business identifier for the closure plan, typically assigned by the regulatory authority or internal tracking system.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the closure plan in the regulatory approval and implementation process. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|amended|superseded|closed — 8 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the plan scope: closure only, post-closure care only, or combined closure and post-closure plan.. Valid values are `closure|post_closure|combined`',
    `plan_version` STRING COMMENT 'Version identifier for the closure plan document, incremented with each revision or amendment.',
    `planned_closure_completion_date` DATE COMMENT 'Scheduled date for completion of all closure construction activities, including final cap installation.',
    `planned_closure_start_date` DATE COMMENT 'Scheduled date for commencement of closure activities for the landfill site or cell.',
    `post_closure_care_end_date` DATE COMMENT 'Scheduled end date of the post-closure care period, typically 30 years after closure completion unless extended by regulatory authority.',
    `post_closure_care_period_years` STRING COMMENT 'Duration of the post-closure care period in years, typically 30 years as required under RCRA Subtitle D.',
    `post_closure_care_start_date` DATE COMMENT 'Date on which the 30-year post-closure care period begins, typically following completion of closure construction.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory agency approval for this closure plan.. Valid values are `pending|approved|conditionally_approved|denied|revision_required`',
    `responsible_engineer` STRING COMMENT 'Name of the professional engineer who prepared or certified the closure plan design.',
    `responsible_party` STRING COMMENT 'Name of the legal entity or organization responsible for implementing and funding the closure and post-closure care plan.',
    `revision_history` STRING COMMENT 'Summary of major revisions and amendments to the closure plan, including dates and reasons for changes.',
    `settlement_survey_frequency` STRING COMMENT 'Frequency of topographic surveys to monitor settlement and subsidence of the final cap during post-closure care.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this closure plan record was last modified in the system.',
    `vegetation_assessment_frequency` STRING COMMENT 'Frequency of vegetation health and erosion control assessments on the final cap during post-closure care.',
    CONSTRAINT pk_closure_plan PRIMARY KEY(`closure_plan_id`)
) COMMENT 'Master record for the closure and post-closure care plan for each landfill site or cell, including the 30-year post-closure monitoring program. Captures plan version, regulatory approval status, planned closure date, final cap system design (cap layers, materials, thickness), post-closure care period and monitoring schedule, estimated closure and post-closure costs, financial assurance mechanism (trust fund, surety bond, letter of credit, insurance), financial assurance amount, post-closure monitoring activities (cap inspection, settlement survey, LFG monitoring, groundwater sampling, leachate check, vegetation assessment), and plan revision history. Required under RCRA Subtitle D for all permitted MSW landfills.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`stormwater_event` (
    `stormwater_event_id` BIGINT COMMENT 'Unique identifier for the stormwater management event record.',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_environmental_monitoring. Business justification: Stormwater monitoring events are compliance environmental monitoring. Linking to canonical compliance monitoring record enables NPDES DMR reporting, exceedance tracking, and BMP effectiveness assessme',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where the stormwater event occurred.',
    `monitoring_point_id` BIGINT COMMENT 'Foreign key linking to landfill.monitoring_point. Business justification: Stormwater discharge monitoring events occur at specific, permitted monitoring points (outfalls, BMP inspection locations) that are already tracked in the monitoring_point master table. The current mo',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Stormwater discharges from landfills are NPDES-permitted. Each event must reference the permit establishing discharge limits for TSS, pH, BOD, and metals to track permit compliance and trigger correct',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Stormwater discharge events with exceedances must be reported to regulators via DMRs or NOI amendments. The regulatory_report_submitted_flag and regulatory_submission_date are denormalized from regula',
    `bmp_deficiencies` STRING COMMENT 'Detailed description of any deficiencies or maintenance needs identified during BMP inspection, such as erosion, sediment accumulation, damaged controls, or inadequate coverage.',
    `bmp_inspection_status` STRING COMMENT 'Assessment result of the BMP inspection. Satisfactory indicates controls are functioning as designed, needs maintenance indicates minor repairs required, deficient indicates significant issues requiring prompt attention, and failed indicates BMP is not functioning and requires immediate corrective action.. Valid values are `satisfactory|needs_maintenance|deficient|failed`',
    `bod_mg_l` DECIMAL(18,2) COMMENT 'Concentration of biochemical oxygen demand in the stormwater discharge, measured in milligrams per liter. BOD indicates the amount of organic pollution and oxygen depletion potential.',
    `cod_mg_l` DECIMAL(18,2) COMMENT 'Concentration of chemical oxygen demand in the stormwater discharge, measured in milligrams per liter. COD measures total organic and inorganic oxidizable matter.',
    `copper_mg_l` DECIMAL(18,2) COMMENT 'Concentration of copper in the stormwater discharge, measured in milligrams per liter. Copper is a regulated heavy metal that can be toxic to aquatic life.',
    `corrective_action_date` DATE COMMENT 'Date when corrective actions were completed to address permit exceedances or BMP deficiencies.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented in response to permit exceedances or identified deficiencies in stormwater management practices.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stormwater event record was first created in the Enviance EHS system.',
    `discharge_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Rate of stormwater discharge measured in gallons per minute at the time of monitoring.',
    `discharge_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of stormwater discharged from the outfall during the event, measured in gallons.',
    `event_date` DATE COMMENT 'Date when the stormwater event occurred or was observed.',
    `event_number` STRING COMMENT 'Business identifier for the stormwater event, used for tracking and reporting purposes.',
    `event_status` STRING COMMENT 'Current lifecycle status of the stormwater event record in the compliance workflow.. Valid values are `scheduled|in_progress|completed|cancelled|pending_review|approved`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the stormwater event occurred or monitoring was performed.',
    `event_type` STRING COMMENT 'Classification of the stormwater management event. Discharge monitoring tracks outfall water quality, BMP (Best Management Practice) inspection verifies erosion and sediment controls, spill response addresses contamination incidents, routine inspection covers scheduled site walkthroughs, corrective action implements remediation measures, and emergency response handles urgent environmental threats.. Valid values are `discharge_monitoring|bmp_inspection|spill_response|routine_inspection|corrective_action|emergency_response`',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator of whether any monitored parameter exceeded the NPDES permit limits during this event. True indicates a permit violation requiring corrective action and regulatory notification.',
    `exceedance_parameters` STRING COMMENT 'Comma-separated list of specific parameters that exceeded NPDES permit limits during this event (e.g., TSS, pH, lead). Used for compliance tracking and corrective action planning.',
    `inspector_certification` STRING COMMENT 'Professional certification or qualification held by the inspector, such as Certified Professional in Erosion and Sediment Control (CPESC) or Qualified Stormwater Manager (QSM).',
    `inspector_name` STRING COMMENT 'Name of the qualified individual who performed the stormwater inspection or monitoring, as required by NPDES permit.',
    `lab_analysis_date` DATE COMMENT 'Date when the laboratory completed analysis of the stormwater sample and issued results.',
    `lab_sample_number` STRING COMMENT 'Unique identifier assigned by the analytical laboratory to the stormwater sample for chain-of-custody tracking and results reporting.',
    `lead_mg_l` DECIMAL(18,2) COMMENT 'Concentration of lead in the stormwater discharge, measured in milligrams per liter. Lead is a toxic heavy metal regulated under NPDES permits.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this stormwater event record was last updated in the Enviance EHS system.',
    `notes` STRING COMMENT 'Additional observations, comments, or contextual information about the stormwater event that may be relevant for compliance documentation or operational decision-making.',
    `oil_grease_mg_l` DECIMAL(18,2) COMMENT 'Concentration of oil and grease in the stormwater discharge, measured in milligrams per liter. Indicates petroleum-based contamination from vehicles and equipment.',
    `permit_limit_ph_max` DECIMAL(18,2) COMMENT 'Maximum allowable pH level specified in the NPDES permit for this outfall.',
    `permit_limit_ph_min` DECIMAL(18,2) COMMENT 'Minimum allowable pH level specified in the NPDES permit for this outfall.',
    `permit_limit_tss_mg_l` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of total suspended solids specified in the NPDES permit for this outfall.',
    `ph_level` DECIMAL(18,2) COMMENT 'Measure of acidity or alkalinity of the stormwater discharge on a scale of 0-14, with 7 being neutral. Critical parameter for assessing water quality and permit compliance.',
    `precipitation_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during the monitoring period or prior to the discharge event, used to assess stormwater runoff volume and pollutant loading.',
    `sample_collected_flag` BOOLEAN COMMENT 'Boolean indicator of whether a physical water sample was collected during this event for laboratory analysis.',
    `total_nitrogen_mg_l` DECIMAL(18,2) COMMENT 'Total nitrogen concentration in the stormwater discharge, measured in milligrams per liter. Nitrogen is a nutrient pollutant that can cause eutrophication in receiving waters.',
    `total_phosphorus_mg_l` DECIMAL(18,2) COMMENT 'Total phosphorus concentration in the stormwater discharge, measured in milligrams per liter. Phosphorus is a nutrient pollutant that contributes to algal blooms and water quality degradation.',
    `tss_mg_l` DECIMAL(18,2) COMMENT 'Concentration of total suspended solids in the stormwater discharge, measured in milligrams per liter. TSS is a key indicator of sediment and particulate pollution.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of the stormwater event, including precipitation type, intensity, wind, and temperature. Weather context is critical for interpreting discharge characteristics and permit compliance.',
    `zinc_mg_l` DECIMAL(18,2) COMMENT 'Concentration of zinc in the stormwater discharge, measured in milligrams per liter. Zinc is a regulated heavy metal commonly found in stormwater runoff.',
    CONSTRAINT pk_stormwater_event PRIMARY KEY(`stormwater_event_id`)
) COMMENT 'Transactional record of stormwater management events at a landfill site including discharge monitoring, best management practice (BMP) inspections, and NPDES permit compliance checks. Captures event date, event type (discharge monitoring, BMP inspection, spill response), monitoring location, precipitation amount (inches), discharge volume (gallons), discharge point (outfall ID), analytical results (TSS, pH, BOD, metals), NPDES permit limit comparison, exceedance flag, and corrective action taken. Supports Clean Water Act NPDES stormwater permit compliance. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` (
    `special_waste_approval_id` BIGINT COMMENT 'Unique identifier for the special waste approval record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account requesting approval for special waste disposal.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Special waste approvals are governed by disposal agreements that define acceptance criteria, pricing, and handling requirements. Essential for contract compliance verification and special waste revenu',
    `disposal_permit_id` BIGINT COMMENT 'Foreign key linking to landfill.disposal_permit. Business justification: Special waste approvals are granted under the authority of disposal permits. The permit defines the permitted waste types and conditions under which special wastes may be accepted. Each approval decis',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Special waste approvals for hazardous materials require linking to the generators EPA ID registration for RCRA compliance, manifest preparation, waste profile validation, and regulatory reporting. Ne',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Special waste approvals govern what can be accepted at the landfill; the hauling agreement governs transport of that special waste to the site. Manifest compliance and DOT regulatory reporting require',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Special waste approvals authorize disposal at negotiated rates with special handling charges. Linking the approval to its resulting invoice enables special waste billing reconciliation, regulatory cos',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where the special waste is proposed for disposal.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Special waste approvals are triggered by specific service offerings requiring non-standard waste acceptance. Tracking the originating service offering is essential for approval workflow routing, prici',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Special waste approvals must verify permit authorization. Each approval should reference the permit that allows (or prohibits) that waste type, ensuring RCRA waste codes, TCLP limits, and permitted wa',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell proposed for disposal of the special waste stream.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Special waste approvals are governed by specific RCRA/state regulatory requirements that define acceptable waste codes, testing protocols, and disposal conditions. Linking to regulatory_requirement en',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Special waste approvals are site-specific: the approval is granted for waste originating from a specific customer service address. Regulators and operations staff must trace approved special waste bac',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Special waste approvals are tied to the active service enrollment under which the special waste is collected and disposed. Linking approval conditions to the contracted service enrollment enables rate',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: special_waste_approval.rcra_waste_code is a denormalized text field. Linking to hazmat.waste_code enforces referential integrity on RCRA waste codes, enables regulatory reporting by waste code, and su',
    `waste_generator_profile_id` BIGINT COMMENT 'Reference to the entity that generated the special waste stream requiring approval.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Special waste approval decisions are made by reviewing the generators submitted hazmat waste profile characterizing physical/chemical properties, EPA codes, and LDR treatment standards. Regulators an',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Special waste approvals govern acceptance of specific waste streams at a landfill. Linking to service.waste_stream enables regulatory compliance tracking by waste stream, manifest requirement enforcem',
    `analytical_profile_reference` STRING COMMENT 'Reference number or identifier for the complete analytical profile and laboratory test results submitted with the approval request.',
    `approval_decision_date` DATE COMMENT 'Date when the final approval or rejection decision was made by the approving authority.',
    `approval_decision_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the approval or rejection decision was recorded in the system.',
    `approval_expiration_date` DATE COMMENT 'Date when the special waste approval expires and a new approval request must be submitted for continued disposal.',
    `approval_request_number` STRING COMMENT 'Business identifier for the special waste approval request, used for tracking and reference in communications with customers and regulatory agencies.',
    `approval_status` STRING COMMENT 'Current status of the special waste approval request in the review and decision workflow. [ENUM-REF-CANDIDATE: pending_review|under_evaluation|approved|conditionally_approved|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `approved_disposal_conditions` STRING COMMENT 'Specific conditions, restrictions, or requirements that must be met for disposal of the approved special waste stream, such as placement requirements, cover specifications, or monitoring protocols.',
    `approved_tonnage_limit` DECIMAL(18,2) COMMENT 'Maximum tonnage of the special waste stream approved for disposal under this approval, measured in tons.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the special waste approval record was first created in the system.',
    `environmental_review_required` BOOLEAN COMMENT 'Indicates whether an additional environmental impact review or assessment is required before final approval can be granted.',
    `estimated_volume_cubic_yards` DECIMAL(18,2) COMMENT 'Estimated total volume of the special waste stream proposed for disposal, measured in cubic yards.',
    `estimated_volume_tons` DECIMAL(18,2) COMMENT 'Estimated total weight of the special waste stream proposed for disposal, measured in tons.',
    `lab_certification_number` STRING COMMENT 'Certification or accreditation number of the laboratory that performed the waste analysis.',
    `lab_name` STRING COMMENT 'Name of the certified laboratory that performed the waste characterization analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the special waste approval record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the special waste approval request, review process, or decision.',
    `ppe_requirements` STRING COMMENT 'Specific personal protective equipment required for workers handling or disposing of the approved special waste stream.',
    `regulatory_notification_date` DATE COMMENT 'Date when the regulatory agency was notified of the special waste approval decision.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the approval decision must be reported to state or federal regulatory agencies.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the special waste approval request was rejected, including specific regulatory or operational concerns.',
    `request_date` DATE COMMENT 'Date when the special waste approval request was submitted for review.',
    `request_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the special waste approval request was received in the system.',
    `special_handling_requirements` STRING COMMENT 'Description of any special handling, equipment, or operational procedures required for safe disposal of the approved special waste stream.',
    `tclp_results_available` BOOLEAN COMMENT 'Indicates whether TCLP analytical test results have been provided as part of the waste characterization data.',
    `tclp_test_date` DATE COMMENT 'Date when the TCLP analytical testing was performed on the waste sample.',
    `waste_classification` STRING COMMENT 'Regulatory classification of the special waste stream based on RCRA Subtitle D criteria and state-specific waste acceptance standards.. Valid values are `municipal_solid_waste|construction_demolition|industrial_non_hazardous|special_industrial|contaminated_soil|asbestos_containing`',
    `waste_description` STRING COMMENT 'Detailed description of the special waste stream including physical characteristics, composition, and any known contaminants or hazardous properties.',
    `waste_origin_address` STRING COMMENT 'Physical address of the facility or location where the special waste was generated.',
    `waste_origin_city` STRING COMMENT 'City where the special waste was generated.',
    `waste_origin_description` STRING COMMENT 'Description of the industrial process, facility, or activity that generated the special waste stream.',
    `waste_origin_postal_code` STRING COMMENT 'Postal code of the location where the special waste was generated.',
    `waste_origin_state_code` STRING COMMENT 'Two-letter state code where the special waste was generated.',
    CONSTRAINT pk_special_waste_approval PRIMARY KEY(`special_waste_approval_id`)
) COMMENT 'Transactional record of pre-approval decisions for non-standard or special waste streams proposed for disposal at a landfill. Captures approval request date, requesting customer or hauler, waste description, waste origin, estimated volume (tons or cubic yards), proposed disposal cell, waste characterization data (TCLP results, analytical profile), regulatory classification determination, approval or rejection decision, approved disposal conditions, approval expiration date, and approving authority. Ensures only permitted waste types are accepted and supports RCRA Subtitle D waste acceptance criteria compliance. Sourced from Enviance EHS and Waste Logics.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`collection_point` (
    `collection_point_id` BIGINT COMMENT 'Primary key for collection_point',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell where this collection point is installed, if applicable.',
    `permit_id` BIGINT COMMENT 'National Pollutant Discharge Elimination System (NPDES) or equivalent discharge permit identifier for this collection point.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Leachate collection points (pumps, sumps, pipe headers) are fixed infrastructure assets requiring depreciation, insurance, and maintenance scheduling in EAM systems. Environmental services operators c',
    `site_id` BIGINT COMMENT 'Reference to the parent landfill site where this collection point is located.',
    `upstream_collection_point_id` BIGINT COMMENT 'Self-referencing FK on collection_point (upstream_collection_point_id)',
    `action_level` DECIMAL(18,2) COMMENT 'Regulatory or operational action level threshold value that triggers response procedures when exceeded.',
    `action_level_unit` STRING COMMENT 'Unit of measure for the action level threshold (e.g., ppm, mg/L, percent, cfm).',
    `calibration_due_date` DATE COMMENT 'Next scheduled date for equipment calibration at this collection point.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection point record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the collection point was decommissioned or taken out of service, if applicable.',
    `depth_ft` DECIMAL(18,2) COMMENT 'Depth of the collection point below ground surface measured in feet, applicable for wells and subsurface monitoring points.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the collection point above sea level measured in feet.',
    `enviance_integration_flag` BOOLEAN COMMENT 'Indicates whether this collection point is integrated with the Enviance EHS system for automated compliance reporting.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer serial number of the primary equipment installed at this collection point.',
    `equipment_type` STRING COMMENT 'Type of equipment or instrumentation installed at the collection point for monitoring or collection purposes.',
    `flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum flow capacity of the collection point measured in gallons per minute, applicable for leachate and stormwater collection.',
    `inspection_frequency_days` STRING COMMENT 'Required interval in days between inspections at this collection point.',
    `installation_date` DATE COMMENT 'Date when the collection point was installed and became operational.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection performed at this collection point.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the collection point location in decimal degrees.',
    `lel_threshold_percent` DECIMAL(18,2) COMMENT 'Lower explosive limit threshold percentage for landfill gas monitoring points, triggering alerts when exceeded.',
    `liner_integrity_status` STRING COMMENT 'Current assessment status of liner integrity at or near this collection point.',
    `liner_type` STRING COMMENT 'Type of liner system associated with this collection point, relevant for leachate collection systems.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the collection point location in decimal degrees.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection point record was last modified in the system.',
    `monitoring_frequency` STRING COMMENT 'Required frequency for monitoring or sampling at this collection point as defined by regulatory requirements or operational procedures.',
    `next_inspection_date` DATE COMMENT 'Next scheduled date for inspection at this collection point based on regulatory or operational requirements.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to this collection point.',
    `operational_status` STRING COMMENT 'Current operational state of the collection point in its lifecycle.',
    `permit_number` STRING COMMENT 'Regulatory permit number associated with this collection point, if required by environmental regulations.',
    `point_code` STRING COMMENT 'Externally-known unique business identifier for the collection point, used in operational systems and reporting.',
    `point_name` STRING COMMENT 'Human-readable name or designation of the collection point within the landfill site.',
    `point_type` STRING COMMENT 'Classification of the collection point based on its primary environmental monitoring or collection function.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the collection point is currently in compliance with all applicable regulatory requirements.',
    `responsible_party` STRING COMMENT 'Name or identifier of the person, team, or contractor responsible for monitoring and maintaining this collection point.',
    `sample_method` STRING COMMENT 'Standard method or protocol used for collecting samples or readings at this collection point.',
    `treatment_required_flag` BOOLEAN COMMENT 'Indicates whether collected material from this point requires treatment before discharge or disposal.',
    CONSTRAINT pk_collection_point PRIMARY KEY(`collection_point_id`)
) COMMENT 'Master reference table for collection_point. Referenced by collection_point_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`landfill`.`monitoring_point` (
    `monitoring_point_id` BIGINT COMMENT 'Primary key for monitoring_point',
    `cell_id` BIGINT COMMENT 'Reference to the specific landfill cell or disposal unit associated with this monitoring point. Null for perimeter or off-site monitoring points.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Monitoring points (gas probes, sensors, analytical instruments) are fixed assets with acquisition costs, calibration schedules, and useful lives tracked in EAM. Regulatory compliance programs require ',
    `site_id` BIGINT COMMENT 'Reference to the landfill facility where this monitoring point is located.',
    `monitoring_program_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_program. Business justification: Landfill monitoring points (LFG perimeter, leachate, stormwater) are established under specific compliance monitoring programs that define parameters, frequency, and regulatory limits. Linking monitor',
    `parent_monitoring_point_id` BIGINT COMMENT 'Self-referencing FK on monitoring_point (parent_monitoring_point_id)',
    `access_restrictions` STRING COMMENT 'Description of any physical, safety, or regulatory restrictions affecting access to this monitoring point (e.g., confined space entry required, locked gate, hazardous area, private property).',
    `aquifer_zone` STRING COMMENT 'Hydrogeologic zone or aquifer unit monitored by this groundwater well: shallow (uppermost), intermediate, deep, bedrock, or perched water table.',
    `background_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this point serves as a background or upgradient reference location (true) for comparison with downgradient monitoring results.',
    `casing_diameter_inches` DECIMAL(18,2) COMMENT 'Inner diameter of the well casing in inches. Applicable to groundwater and gas monitoring wells.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring point record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the monitoring point was formally decommissioned or abandoned. Null for active points.',
    `detection_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this point is part of the RCRA Subtitle D detection monitoring program (true) or assessment/corrective action monitoring (false).',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Ground surface elevation at the monitoring point location measured in feet above mean sea level.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer serial number of the primary monitoring equipment installed at this point for asset tracking and calibration management.',
    `equipment_type` STRING COMMENT 'Type of monitoring equipment or instrumentation installed at this point (e.g., datalogger, gas analyzer, flow meter, weather station, piezometer).',
    `installation_date` DATE COMMENT 'Date when the monitoring point was physically installed and became operational.',
    `last_calibration_date` DATE COMMENT 'Date when the monitoring equipment at this point was last calibrated or verified for accuracy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring point record was most recently updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring point in decimal degrees (WGS84 datum).',
    `lel_alarm_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage of Lower Explosive Limit (LEL) at which an alarm or action is triggered for landfill gas monitoring points. Typically set at 25% LEL per OSHA and EPA guidance.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring point in decimal degrees (WGS84 datum).',
    `methane_threshold_pct` DECIMAL(18,2) COMMENT 'Methane concentration threshold (volume percent) for landfill gas monitoring compliance. Regulatory limit is typically 5% by volume at the facility boundary or 1.25% in structures.',
    `monitoring_frequency` STRING COMMENT 'Required sampling or measurement frequency for this monitoring point as specified in the permit or monitoring plan.',
    `monitoring_point_status` STRING COMMENT 'Current operational lifecycle state of the monitoring point: active (in service), inactive (temporarily not monitored), abandoned (permanently closed), suspended (on hold), planned (not yet installed), or decommissioned (formally retired).',
    `monitoring_subtype` STRING COMMENT 'Secondary classification providing additional detail on the monitoring point purpose (e.g., compliance well, detection well, extraction well, perimeter probe, interior probe, background station). [ENUM-REF-CANDIDATE: compliance_well|detection_well|extraction_well|perimeter_probe|interior_probe|background_station|boundary_station|meteorological_tower — promote to reference product]',
    `monitoring_type` STRING COMMENT 'Primary category of environmental monitoring performed at this point: groundwater quality, landfill gas (LFG) emissions, ambient air quality, leachate characteristics, surface water quality, or meteorological conditions.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or verification of monitoring equipment at this point.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, historical context, or special considerations related to this monitoring point.',
    `parameter_list` STRING COMMENT 'Comma-separated list of environmental parameters or analytes measured at this monitoring point (e.g., pH, conductivity, VOCs, methane, benzene, dissolved oxygen, temperature).',
    `permit_number` STRING COMMENT 'Regulatory permit or authorization number under which this monitoring point is required or approved.',
    `point_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the monitoring point for regulatory reporting and field operations (e.g., GW-001, LFG-042, AM-105).',
    `point_name` STRING COMMENT 'Human-readable descriptive name of the monitoring point location (e.g., North Boundary Groundwater Well, Cell 3 Gas Probe, East Perimeter Air Station).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether monitoring at this point is mandated by federal, state, or local environmental regulations (true) or is voluntary/supplemental (false).',
    `responsible_party` STRING COMMENT 'Name of the individual, contractor, or department responsible for monitoring activities at this point.',
    `sampling_method` STRING COMMENT 'Standard operating procedure or EPA method used for sample collection at this monitoring point (e.g., low-flow purging, bailer, passive diffusion, direct-read instrument).',
    `screen_interval_bottom_ft` DECIMAL(18,2) COMMENT 'Depth from ground surface to the bottom of the well screen interval in feet. Applicable to groundwater and gas monitoring wells.',
    `screen_interval_top_ft` DECIMAL(18,2) COMMENT 'Depth from ground surface to the top of the well screen interval in feet. Applicable to groundwater and gas monitoring wells.',
    `well_depth_ft` DECIMAL(18,2) COMMENT 'Total depth of the monitoring well from ground surface to bottom of well screen, measured in feet. Applicable to groundwater and gas monitoring wells.',
    CONSTRAINT pk_monitoring_point PRIMARY KEY(`monitoring_point_id`)
) COMMENT 'Master reference table for monitoring_point. Referenced by monitoring_point_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ADD CONSTRAINT `fk_landfill_cell_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_landfill_tipping_fee_schedule_id` FOREIGN KEY (`landfill_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule`(`landfill_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ADD CONSTRAINT `fk_landfill_airspace_consumption_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ADD CONSTRAINT `fk_landfill_airspace_consumption_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_collection_point_id` FOREIGN KEY (`collection_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`collection_point`(`collection_point_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_lfg_extraction_well_id` FOREIGN KEY (`lfg_extraction_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`lfg_extraction_well`(`lfg_extraction_well_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_monitoring_point_id` FOREIGN KEY (`monitoring_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`monitoring_point`(`monitoring_point_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ADD CONSTRAINT `fk_landfill_groundwater_sample_groundwater_monitoring_well_id` FOREIGN KEY (`groundwater_monitoring_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`groundwater_monitoring_well`(`groundwater_monitoring_well_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ADD CONSTRAINT `fk_landfill_groundwater_sample_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ADD CONSTRAINT `fk_landfill_disposal_permit_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_disposal_permit_id` FOREIGN KEY (`disposal_permit_id`) REFERENCES `waste_management_ecm`.`landfill`.`disposal_permit`(`disposal_permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_disposal_permit_id` FOREIGN KEY (`disposal_permit_id`) REFERENCES `waste_management_ecm`.`landfill`.`disposal_permit`(`disposal_permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_monitoring_point_id` FOREIGN KEY (`monitoring_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`monitoring_point`(`monitoring_point_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_disposal_permit_id` FOREIGN KEY (`disposal_permit_id`) REFERENCES `waste_management_ecm`.`landfill`.`disposal_permit`(`disposal_permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ADD CONSTRAINT `fk_landfill_collection_point_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ADD CONSTRAINT `fk_landfill_collection_point_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ADD CONSTRAINT `fk_landfill_collection_point_upstream_collection_point_id` FOREIGN KEY (`upstream_collection_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`collection_point`(`collection_point_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ADD CONSTRAINT `fk_landfill_monitoring_point_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ADD CONSTRAINT `fk_landfill_monitoring_point_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ADD CONSTRAINT `fk_landfill_monitoring_point_parent_monitoring_point_id` FOREIGN KEY (`parent_monitoring_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`monitoring_point`(`monitoring_point_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`landfill` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`landfill` SET TAGS ('dbx_domain' = 'landfill');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Enviance EHS Facility ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `site_epa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Tsdf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 1');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 2');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `airspace_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Airspace Survey Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `cap_system_type` SET TAGS ('dbx_business_glossary_term' = 'Cap System Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `cap_system_type` SET TAGS ('dbx_value_regex' = 'final_cap|interim_cap|none|planned');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `cercla_status` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Environmental Response Compensation and Liability Act (CERCLA) Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `cercla_status` SET TAGS ('dbx_value_regex' = 'not_listed|npl_listed|remedial_investigation|remedial_action|completed|other');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Site City');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Site Classification');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'MSW|C&D|monofill|industrial|hazardous');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'Site County');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `ghg_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reporting Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `groundwater_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Monitoring Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `host_community_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Host Community Agreement Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude (GPS)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `lea_name` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `leachate_management_type` SET TAGS ('dbx_business_glossary_term' = 'Leachate Management System Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `leachate_management_type` SET TAGS ('dbx_value_regex' = 'collection_and_treatment|collection_and_discharge|recirculation|none|other');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `lfg_collection_system` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Collection System Present');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `lfg_utilization_type` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Utilization Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `lfg_utilization_type` SET TAGS ('dbx_value_regex' = 'flare_only|electricity_generation|RNG|direct_use|none');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `liner_system_type` SET TAGS ('dbx_business_glossary_term' = 'Liner System Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `liner_system_type` SET TAGS ('dbx_value_regex' = 'single_composite|double_composite|clay|geomembrane|no_liner|other');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude (GPS)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `monitoring_well_count` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Well Count');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Site Open Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|closed|post_closure|permitted|construction|suspended');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `permit_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Issued Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `permitted_acreage` SET TAGS ('dbx_business_glossary_term' = 'Permitted Acreage');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `permitted_daily_receipt_tons` SET TAGS ('dbx_business_glossary_term' = 'Permitted Daily Receipt (Tons Per Day)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `post_closure_end_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Care End Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `rcra_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Subtitle D Permit Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `remaining_airspace_cy` SET TAGS ('dbx_business_glossary_term' = 'Remaining Airspace (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `standard_tipping_fee` SET TAGS ('dbx_business_glossary_term' = 'Standard Tipping Fee (USD per Ton)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `standard_tipping_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `swis_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Registration Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Site Time Zone');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `total_design_capacity_cy` SET TAGS ('dbx_business_glossary_term' = 'Total Design Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `total_design_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Design Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ALTER COLUMN `waste_streams_accepted` SET TAGS ('dbx_business_glossary_term' = 'Accepted Waste Streams');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (CID)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `actual_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Fill Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `area_acres` SET TAGS ('dbx_business_glossary_term' = 'Cell Footprint Area (Acres)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `average_daily_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Tonnage');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `base_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Base Elevation (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_name` SET TAGS ('dbx_business_glossary_term' = 'Cell Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_number` SET TAGS ('dbx_business_glossary_term' = 'Cell Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_status` SET TAGS ('dbx_business_glossary_term' = 'Cell Lifecycle Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `cell_status` SET TAGS ('dbx_value_regex' = 'planned|under_construction|active|filled|closed|capped');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Cell Closure Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `compaction_ratio_target` SET TAGS ('dbx_business_glossary_term' = 'Target Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `construction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `current_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Current Waste Surface Elevation (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `daily_cover_material_type` SET TAGS ('dbx_business_glossary_term' = 'Daily Cover Material Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `daily_cover_material_type` SET TAGS ('dbx_value_regex' = 'soil|alternative_daily_cover|tarps|foam|auto_daily_cover');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `design_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `design_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `environmental_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `environmental_monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `final_cap_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Final Cap Installation Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `gas_collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Collection Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `gas_collection_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Collection System Installed');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `geometry_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Cell Boundary Geometry Coordinates');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `groundwater_monitoring_wells` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Monitoring Well Identifiers');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `liner_system_type` SET TAGS ('dbx_business_glossary_term' = 'Liner System Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `liner_system_type` SET TAGS ('dbx_value_regex' = 'single_composite|double_composite|single_geomembrane|clay_only|enhanced_composite');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `liner_thickness_inches` SET TAGS ('dbx_business_glossary_term' = 'Liner Thickness (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Cell Opening Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `permitted_waste_types` SET TAGS ('dbx_business_glossary_term' = 'Permitted Waste Types');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `phase_number` SET TAGS ('dbx_business_glossary_term' = 'Phase Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `post_closure_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Care End Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `projected_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Fill Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `remaining_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Remaining Airspace Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Professional Engineer');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `tipping_fee_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Per Ton');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `tipping_fee_per_ton` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `top_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Top Elevation (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `total_tonnage_received` SET TAGS ('dbx_business_glossary_term' = 'Total Tonnage Received');
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` SET TAGS ('dbx_subdomain' = 'waste_intake');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `tonnage_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Receipt ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Weight Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cell ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `landfill_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_generator_profile_id` SET TAGS ('dbx_business_glossary_term' = 'EPA Generator Identification Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `contamination_notes` SET TAGS ('dbx_business_glossary_term' = 'Contamination Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `inbound_scale_time` SET TAGS ('dbx_business_glossary_term' = 'Inbound Scale Time');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `load_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Load Inspection Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `load_inspection_status` SET TAGS ('dbx_value_regex' = 'not_inspected|visual_pass|visual_fail|detailed_inspection|random_audit');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `load_rejected_flag` SET TAGS ('dbx_business_glossary_term' = 'Load Rejected Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `net_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Net Tonnage');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `outbound_scale_time` SET TAGS ('dbx_business_glossary_term' = 'Outbound Scale Time');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'account_billing|credit_card|cash|check|electronic_transfer');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Load Rejection Reason');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Scale Ticket Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Amount');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|completed|voided|disputed|adjusted');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_business_glossary_term' = 'Vehicle License Plate Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_origin_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_origin_type` SET TAGS ('dbx_value_regex' = 'collection_route|transfer_station|direct_haul|municipal_contract|commercial_account|residential_account');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_subtype` SET TAGS ('dbx_business_glossary_term' = 'Waste Subtype');
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type Classification');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` SET TAGS ('dbx_subdomain' = 'waste_intake');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `airspace_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Airspace Consumption ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Cell ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `cnd_tonnage_tons` SET TAGS ('dbx_business_glossary_term' = 'Construction and Demolition (C&D) Tonnage (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `compaction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `cover_material_volume_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Cover Material Volume (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `cumulative_volume_consumed_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Volume Consumed (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `design_density_lbs_per_cubic_yard` SET TAGS ('dbx_business_glossary_term' = 'Design Density (Pounds per Cubic Yard)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `in_place_density_lbs_per_cubic_yard` SET TAGS ('dbx_business_glossary_term' = 'In-Place Density (Pounds per Cubic Yard)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `measurement_accuracy_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|certified|submitted|approved|rejected|revised');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `msw_tonnage_tons` SET TAGS ('dbx_business_glossary_term' = 'Municipal Solid Waste (MSW) Tonnage (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `projected_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Closure Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `rate_cubic_yards_per_day` SET TAGS ('dbx_business_glossary_term' = 'Airspace Consumption Rate (Cubic Yards per Day)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `regulatory_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `remaining_permitted_airspace_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Remaining Permitted Airspace (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `special_waste_tonnage_tons` SET TAGS ('dbx_business_glossary_term' = 'Special Waste Tonnage (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `survey_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Certification Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'drone_photogrammetry|gps_survey|lidar|total_station|manual_survey|aerial_photography');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `survey_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `surveyor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Surveyor License Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `total_permitted_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Total Permitted Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `volume_consumed_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Volume Consumed (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `waste_tonnage_placed_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Tonnage Placed (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ALTER COLUMN `years_remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Years Remaining Capacity');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` SET TAGS ('dbx_subdomain' = 'waste_intake');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `daily_cover_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Cover ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Cell ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `adc_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Daily Cover (ADC) Permit Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `corrective_action_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cover Application Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_date` SET TAGS ('dbx_business_glossary_term' = 'Cover Application Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_material_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cover Material Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_material_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_material_description` SET TAGS ('dbx_business_glossary_term' = 'Cover Material Description');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_material_type` SET TAGS ('dbx_business_glossary_term' = 'Cover Material Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `cover_material_type` SET TAGS ('dbx_value_regex' = 'soil|alternative_daily_cover|tarp|foam|spray_on|geosynthetic');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `deficiencies_identified` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Identified');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `equipment_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `fire_risk_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Fire Risk Mitigation');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `fire_risk_mitigation` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|ineffective');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `gps_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Coordinates');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `inspection_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Performed Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `litter_control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Litter Control Effectiveness');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `litter_control_effectiveness` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|ineffective');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `odor_control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Odor Control Effectiveness');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `odor_control_effectiveness` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|ineffective');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `photo_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Documentation Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Operational Remarks');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Operational Shift');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|weekend');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `thickness_achieved_inches` SET TAGS ('dbx_business_glossary_term' = 'Thickness Achieved (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `vector_control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Vector Control Effectiveness');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `vector_control_effectiveness` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|ineffective');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `volume_applied_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Volume Applied (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|wind|fog|extreme_heat');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Miles Per Hour)');
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ALTER COLUMN `working_face_area_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Working Face Area (Square Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `leachate_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Leachate Collection ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_point_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Point Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Leachate Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `ammonia_nitrogen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Ammonia Nitrogen (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `bod_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Biological Oxygen Demand (BOD) (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `cod_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Chemical Oxygen Demand (COD) (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'pump|gravity_flow|manual_extraction|automated_system');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_point_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Point Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_point_type` SET TAGS ('dbx_value_regex' = 'sump|pipe_segment|monitoring_well|drainage_layer|collection_header');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_system_status` SET TAGS ('dbx_business_glossary_term' = 'Collection System Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_system_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance_required|offline|under_repair');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `conductivity_umhos_cm` SET TAGS ('dbx_business_glossary_term' = 'Conductivity (µmhos/cm)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost (USD)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'on_site_treatment|off_site_tsdf|municipal_sewer_discharge|evaporation|recirculation');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `disposal_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Disposal Volume (Gallons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `exceedance_parameters` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Parameters');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `exceedance_parameters` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9,s]{0,500}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `heavy_metals_detected` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metals Detected');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `heavy_metals_detected` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9,s]{0,500}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `lab_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `lab_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `lab_sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `leachate_head_level_inches` SET TAGS ('dbx_business_glossary_term' = 'Leachate Head Level (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `liner_integrity_status` SET TAGS ('dbx_business_glossary_term' = 'Liner Integrity Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `liner_integrity_status` SET TAGS ('dbx_value_regex' = 'intact|compromised|under_investigation|repaired');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `notes` SET TAGS ('dbx_value_regex' = '^[sS]{0,2000}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `permit_limit_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Compliance Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH Level');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `precipitation_last_24h_inches` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Last 24 Hours (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `sample_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Collected Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `total_dissolved_solids_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Dissolved Solids (TDS) (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `total_suspended_solids_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `volume_collected_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Collected (Gallons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|storm|fog');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `lfg_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Monitoring ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `lfg_extraction_well_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Extraction Well Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `barometric_pressure_inhg` SET TAGS ('dbx_business_glossary_term' = 'Barometric Pressure in Inches of Mercury (inHg)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `carbon_dioxide_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Concentration Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `carbon_monoxide_ppm` SET TAGS ('dbx_business_glossary_term' = 'Carbon Monoxide (CO) Concentration in Parts Per Million (PPM)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|corrective_action_in_progress');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|calibration_required|equipment_malfunction');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `exceedance_type` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `exceedance_type` SET TAGS ('dbx_value_regex' = 'lel_threshold|methane_threshold|surface_emission|odor_complaint|temperature_anomaly|pressure_anomaly');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `hydrogen_sulfide_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration in Parts Per Million (PPM)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `lel_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lower Explosive Limit (LEL) Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `lfg_flow_rate_scfm` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Flow Rate in Standard Cubic Feet per Minute (SCFM)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `methane_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Methane (CH4) Concentration Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|event_driven');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'epa_method_21|epa_method_25|portable_analyzer|fixed_sensor|manual_sampling');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_point_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_point_type` SET TAGS ('dbx_value_regex' = 'extraction_well|perimeter_probe|interior_probe|surface_emission_point|boundary_monitoring_station|gas_collection_header');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `monitoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `nitrogen_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen (N2) Concentration Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `oxygen_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Oxygen (O2) Concentration Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `static_pressure_inches_wc` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure in Inches of Water Column (WC)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Degrees Fahrenheit');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|cloudy|rain|snow|fog|wind');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed in Miles Per Hour (MPH)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `lfg_extraction_well_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Extraction Well Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Cell ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `abandonment_method` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `abandonment_method` SET TAGS ('dbx_value_regex' = 'grouted|capped|removed|other');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `casing_material` SET TAGS ('dbx_business_glossary_term' = 'Casing Material');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `casing_material` SET TAGS ('dbx_value_regex' = 'HDPE|PVC|steel|fiberglass');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `construction_contractor` SET TAGS ('dbx_business_glossary_term' = 'Construction Contractor');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `construction_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Construction Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `construction_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `design_extraction_rate_scfm` SET TAGS ('dbx_business_glossary_term' = 'Design Extraction Rate (Standard Cubic Feet per Minute)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `design_vacuum_inches_h2o` SET TAGS ('dbx_business_glossary_term' = 'Design Vacuum (Inches Water Column)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|idle|maintenance|abandoned|planned');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `rng_production_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Production Eligible Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `screen_interval_bottom_feet` SET TAGS ('dbx_business_glossary_term' = 'Screen Interval Bottom (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `screen_interval_top_feet` SET TAGS ('dbx_business_glossary_term' = 'Screen Interval Top (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `well_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Well Depth (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `well_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Well Diameter (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `well_identifier` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `well_type` SET TAGS ('dbx_business_glossary_term' = 'Well Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `well_type` SET TAGS ('dbx_value_regex' = 'vertical|horizontal|trench');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `wellhead_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Wellhead Equipment Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ALTER COLUMN `wellhead_equipment_type` SET TAGS ('dbx_value_regex' = 'standard|adjustable|automated|monitoring_only');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `groundwater_monitoring_well_id` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Monitoring Well ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `monitoring_station_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Station Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `analyte_list_code` SET TAGS ('dbx_business_glossary_term' = 'Analyte List Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `aquifer_zone` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Zone Monitored');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `casing_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Well Casing Diameter (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `casing_material` SET TAGS ('dbx_business_glossary_term' = 'Well Casing Material');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `casing_material` SET TAGS ('dbx_value_regex' = 'PVC|stainless_steel|carbon_steel|HDPE');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Well Decommission Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Well Decommission Reason');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `elevation_feet_msl` SET TAGS ('dbx_business_glossary_term' = 'Well Elevation (Feet Mean Sea Level)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `epa_swis_well_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Solid Waste Information System (SWIS) Well ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `filter_pack_material` SET TAGS ('dbx_business_glossary_term' = 'Filter Pack Material');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `filter_pack_material` SET TAGS ('dbx_value_regex' = 'silica_sand|gravel|natural_formation');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Well Installation Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `last_sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Last Groundwater Sampling Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Well Latitude Coordinate');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Well Longitude Coordinate');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `next_scheduled_sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sampling Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `permit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Reference Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Sampling Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual|biennial|event_driven');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `screen_interval_bottom_feet` SET TAGS ('dbx_business_glossary_term' = 'Screen Interval Bottom Depth (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `screen_interval_top_feet` SET TAGS ('dbx_business_glossary_term' = 'Screen Interval Top Depth (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `seal_material` SET TAGS ('dbx_business_glossary_term' = 'Annular Seal Material');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `seal_material` SET TAGS ('dbx_value_regex' = 'bentonite|cement_grout|bentonite_grout|neat_cement');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `state_well_permit_number` SET TAGS ('dbx_business_glossary_term' = 'State Well Permit Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `static_water_level_feet` SET TAGS ('dbx_business_glossary_term' = 'Static Water Level Depth (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `total_depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Well Depth (Feet)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_construction_method` SET TAGS ('dbx_business_glossary_term' = 'Well Construction Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_construction_method` SET TAGS ('dbx_value_regex' = 'hollow_stem_auger|mud_rotary|air_rotary|direct_push|cable_tool');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_designation` SET TAGS ('dbx_business_glossary_term' = 'Well Designation Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_designation` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_development_date` SET TAGS ('dbx_business_glossary_term' = 'Well Development Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_notes` SET TAGS ('dbx_business_glossary_term' = 'Well Operational Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_status` SET TAGS ('dbx_business_glossary_term' = 'Well Operational Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|under_construction|decommissioned|temporarily_suspended');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Well Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ALTER COLUMN `well_type` SET TAGS ('dbx_value_regex' = 'upgradient|downgradient|compliance|detection|assessment|background');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `groundwater_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Sample ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `groundwater_monitoring_well_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Well ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `analysis_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `analysis_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `analytical_parameters_tested` SET TAGS ('dbx_business_glossary_term' = 'Analytical Parameters Tested');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `cercla_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Environmental Response Compensation and Liability Act (CERCLA) Reportable Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `exceedance_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Detected Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `exceedance_parameters` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Parameters');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_conductivity_umhos` SET TAGS ('dbx_business_glossary_term' = 'Field Specific Conductivity (µmhos/cm)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_dissolved_oxygen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Dissolved Oxygen (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_notes` SET TAGS ('dbx_business_glossary_term' = 'Field Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_oxidation_reduction_potential_mv` SET TAGS ('dbx_business_glossary_term' = 'Field Oxidation-Reduction Potential (mV)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_ph` SET TAGS ('dbx_business_glossary_term' = 'Field pH Measurement');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Field Temperature (Celsius)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `field_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Field Turbidity (NTU)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `gwps_limit_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Protection Standard (GWPS) Limit Exceeded');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Analytical Laboratory Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `laboratory_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `laboratory_sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `metals_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Metals Analysis Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `monitoring_program_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `monitoring_program_type` SET TAGS ('dbx_value_regex' = 'detection|assessment|corrective_action|post_closure');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `purge_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Purge Volume (Gallons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `qa_qc_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `qa_qc_flag` SET TAGS ('dbx_value_regex' = 'passed|failed|qualified|pending');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `qa_qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_appearance` SET TAGS ('dbx_business_glossary_term' = 'Sample Appearance');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_received_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Receipt Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'routine|confirmation|assessment|background|duplicate|blank');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `sampling_method` SET TAGS ('dbx_value_regex' = 'bailer|peristaltic_pump|bladder_pump|submersible_pump|grab_sample|other');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `swis_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `voc_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compounds (VOC) Analysis Method');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `voc_analysis_method` SET TAGS ('dbx_value_regex' = 'EPA_8260|EPA_8260B|EPA_8260C|EPA_8260D|not_tested');
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Sampling');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `airspace_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Airspace Survey Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `annual_waste_acceptance_rate_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Waste Acceptance Rate (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `annual_waste_acceptance_rate_tpd` SET TAGS ('dbx_business_glossary_term' = 'Annual Waste Acceptance Rate (Tons Per Day)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `assumptions_notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Assumptions and Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `capacity_consumed_to_date_cy` SET TAGS ('dbx_business_glossary_term' = 'Capacity Consumed to Date (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `capacity_consumed_to_date_tons` SET TAGS ('dbx_business_glossary_term' = 'Capacity Consumed to Date (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `capital_investment_required` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Required (USD)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `capital_investment_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `compaction_ratio_assumption` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio Assumption');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `daily_cover_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Daily Cover Factor (Percent)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `engineer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Engineer License Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `expansion_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Expansion Permit Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `expansion_permit_status` SET TAGS ('dbx_value_regex' = 'not_applicable|planned|application_submitted|under_review|approved|denied');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `expansion_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expansion Target Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiration Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `final_cover_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Final Cover Factor (Percent)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `intermediate_cover_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Intermediate Cover Factor (Percent)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `lateral_expansion_capacity_cy` SET TAGS ('dbx_business_glossary_term' = 'Lateral Expansion Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `lateral_expansion_planned` SET TAGS ('dbx_business_glossary_term' = 'Lateral Expansion Planned Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `permit_renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `permit_renewal_target_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Target Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|five_year|ten_year|long_range|permit_renewal|expansion');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `planning_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Years)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `projected_closure_year` SET TAGS ('dbx_business_glossary_term' = 'Projected Closure Year');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `projected_site_life_years` SET TAGS ('dbx_business_glossary_term' = 'Projected Site Life (Years)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `remaining_airspace_cy` SET TAGS ('dbx_business_glossary_term' = 'Remaining Airspace (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `remaining_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `total_permitted_capacity_cy` SET TAGS ('dbx_business_glossary_term' = 'Total Permitted Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `total_permitted_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Permitted Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `vertical_expansion_capacity_cy` SET TAGS ('dbx_business_glossary_term' = 'Vertical Expansion Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ALTER COLUMN `vertical_expansion_planned` SET TAGS ('dbx_business_glossary_term' = 'Vertical Expansion Planned Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` SET TAGS ('dbx_subdomain' = 'waste_intake');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `landfill_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Tipping Fee Schedule ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending|Approved|Active|Superseded|Cancelled');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `environmental_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Environmental Surcharge Rate');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `host_community_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Host Community Fee Rate');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `regulatory_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Surcharge Rate');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `special_handling_required` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'Ton|Cubic Yard|Load|Each');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `volume_threshold_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Tons');
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `disposal_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Permit Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional_compliance|under_investigation');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `environmental_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Environmental Coordinator Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `financial_assurance_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Mechanism');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `financial_assurance_mechanism` SET TAGS ('dbx_value_regex' = 'trust_fund|surety_bond|letter_of_credit|insurance|corporate_guarantee|state_fund');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `financial_assurance_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Required Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `issuing_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `last_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Submission Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permit_conditions_summary` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions Summary');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permit_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Document Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permitted_daily_tonnage_limit` SET TAGS ('dbx_business_glossary_term' = 'Permitted Daily Tonnage Limit (Tons Per Day)');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permitted_total_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Permitted Total Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permitted_total_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Permitted Total Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `permitted_waste_types` SET TAGS ('dbx_business_glossary_term' = 'Permitted Waste Types');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `renewal_application_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Due Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_required');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Permit Conditions');
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `disposal_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Agency Jurisdiction');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `agency_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|local|tribal');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `areas_inspected` SET TAGS ('dbx_business_glossary_term' = 'Areas Inspected');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `cercla_relevance` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Environmental Response Compensation and Liability Act (CERCLA) Relevance');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|verified|overdue');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Taken');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_value_regex' = 'none|warning-letter|notice-of-violation|consent-order|penalty');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `facility_response_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Response Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `facility_response_reference` SET TAGS ('dbx_business_glossary_term' = 'Facility Response Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspecting_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspecting Agency');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Closure Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration Hours');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|closed|pending-response');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|complaint-driven|follow-up|special|unannounced|pre-operational');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `rcra_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Compliance Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `rcra_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|conditional');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `regulatory_citations` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citations');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `responsible_manager` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `swis_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Reporting Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `swis_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Submission Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ALTER COLUMN `violations_cited` SET TAGS ('dbx_business_glossary_term' = 'Violations Cited');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `closure_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `disposal_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `actual_closure_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `actual_closure_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_barrier_material` SET TAGS ('dbx_business_glossary_term' = 'Cap Barrier Material');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_drainage_system` SET TAGS ('dbx_business_glossary_term' = 'Cap Drainage System');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cap Inspection Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Cap Layer Count');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_system_design` SET TAGS ('dbx_business_glossary_term' = 'Cap System Design');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_total_thickness_inches` SET TAGS ('dbx_business_glossary_term' = 'Cap Total Thickness (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cap_vegetation_type` SET TAGS ('dbx_business_glossary_term' = 'Cap Vegetation Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cost_estimate_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Basis');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `cost_estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `engineer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Engineer License Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `estimated_closure_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Closure Cost');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `estimated_closure_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `estimated_post_closure_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Post-Closure Cost');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `estimated_post_closure_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `financial_assurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `financial_assurance_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Mechanism');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `financial_assurance_mechanism` SET TAGS ('dbx_value_regex' = 'trust_fund|surety_bond|letter_of_credit|insurance|corporate_guarantee|state_fund');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `financial_assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Provider');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `groundwater_sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Sampling Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `leachate_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Leachate Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `lfg_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `monitoring_schedule` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Schedule');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `plan_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'closure|post_closure|combined');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `planned_closure_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Closure Completion Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `planned_closure_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Closure Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `post_closure_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Care End Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `post_closure_care_period_years` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Care Period (Years)');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `post_closure_care_start_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Care Start Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|denied|revision_required');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Revision History');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `settlement_survey_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Survey Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ALTER COLUMN `vegetation_assessment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Vegetation Assessment Frequency');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `stormwater_event_id` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Event ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `bmp_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practice (BMP) Deficiencies');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `bmp_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practice (BMP) Inspection Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `bmp_inspection_status` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_maintenance|deficient|failed');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `bod_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand (BOD) Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `cod_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Chemical Oxygen Demand (COD) Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `copper_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Copper Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `corrective_action_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `discharge_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Discharge Flow Rate (Gallons Per Minute)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `discharge_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Discharge Volume (Gallons)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|pending_review|approved');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'discharge_monitoring|bmp_inspection|spill_response|routine_inspection|corrective_action|emergency_response');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Exceedance Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `exceedance_parameters` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Parameters');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `lab_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `lab_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `lead_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Lead Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `oil_grease_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Oil and Grease Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `permit_limit_ph_max` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Limit for pH (Maximum)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `permit_limit_ph_min` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Limit for pH (Minimum)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `permit_limit_tss_mg_l` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Limit for Total Suspended Solids (TSS) (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH Level');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `precipitation_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Amount (Inches)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `sample_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Collected Flag');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `total_nitrogen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `total_phosphorus_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Phosphorus Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `tss_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ALTER COLUMN `zinc_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Zinc Concentration (mg/L)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` SET TAGS ('dbx_subdomain' = 'waste_intake');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `special_waste_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Special Waste Approval Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `disposal_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Disposal Cell Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_generator_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Generator Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `analytical_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Analytical Profile Reference');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approval_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approval_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approval_request_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Request Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approved_disposal_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approved Disposal Conditions');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `approved_tonnage_limit` SET TAGS ('dbx_business_glossary_term' = 'Approved Tonnage Limit');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `environmental_review_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `estimated_volume_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume in Cubic Yards');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `estimated_volume_tons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume in Tons');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `lab_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Request Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Request Timestamp');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `tclp_results_available` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Results Available');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `tclp_test_date` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Test Date');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Classification');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_classification` SET TAGS ('dbx_value_regex' = 'municipal_solid_waste|construction_demolition|industrial_non_hazardous|special_industrial|contaminated_soil|asbestos_containing');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Description');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_address` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Address');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_city` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin City');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Description');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Postal Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ALTER COLUMN `waste_origin_state_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin State Code');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `collection_point_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Point Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `upstream_collection_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `treatment_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ALTER COLUMN `treatment_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Identifier');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `parent_monitoring_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
