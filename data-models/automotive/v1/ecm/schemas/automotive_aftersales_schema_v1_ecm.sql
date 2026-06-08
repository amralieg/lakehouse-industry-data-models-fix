-- Schema for Domain: aftersales | Business: Automotive | Version: v1_ecm
-- Generated on: 2026-05-07 00:14:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`aftersales` COMMENT 'Post-sale customer support including warranty management, service campaigns, recall execution, and parts distribution. Manages service appointments, repair orders, TSB (Technical Service Bulletin) distribution, DTC (Diagnostic Trouble Code) analysis, and labor time standards. Tracks warranty claims, parts consumption, service revenue, and customer retention. Includes field service operations and authorized service center network management. Integrates with CDK Global DMS and OBD (On-Board Diagnostics) systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`nameplate` (
    `nameplate_id` BIGINT COMMENT 'Primary key for nameplate',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting per nameplate required for budgeting and internal reporting; finance cost_center tracks expenses for each product line.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: REQUIRED: Nameplate strategy teams record the primary jurisdiction to align emissions, safety, and tax compliance across markets.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: REQUIRED: Assign primary assembly plant for each nameplate; production planners need this for plant‑level capacity and allocation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product Manager role must be linked to an employee for accountability in nameplate strategy and performance dashboards.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis per nameplate uses finance profit_center to allocate revenue and margin; essential for product line P&L reports.',
    `adas_level` STRING COMMENT 'Highest SAE automation level supported by this nameplates ADAS features (Level 0 = no automation, Level 5 = full automation). Based on SAE J3016 standard.. Valid values are `level_0|level_1|level_2|level_3|level_4|level_5`',
    `body_style_primary` STRING COMMENT 'Primary body style configuration for this nameplate (e.g., 4-door sedan, 2-door coupe, crew cab pickup, extended wheelbase van). Multiple body styles may exist within a nameplate; this represents the flagship or most common configuration.',
    `brand_code` STRING COMMENT 'Code representing the brand or marque under which this nameplate is marketed (e.g., FORD, CHEV, TOYOTA, LEXUS).. Valid values are `^[A-Z]{2,10}$`',
    `cafe_category` STRING COMMENT 'CAFE regulatory category for fuel economy compliance: passenger car, light truck, or exempt. Used for EPA and NHTSA reporting.. Valid values are `passenger_car|light_truck|exempt`',
    `competitive_set` STRING COMMENT 'Comma-separated list of primary competitor nameplates that this nameplate is benchmarked against (e.g., Toyota Camry, Honda Accord, Nissan Altima). Used for competitive analysis and positioning.',
    `connectivity_capability` STRING COMMENT 'Level of connected vehicle capability: none (no connectivity), basic (telematics only), advanced (OTA updates, cloud services), v2x (Vehicle-to-Everything communication).. Valid values are `none|basic|advanced|v2x`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this nameplate record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this nameplate record was first created in the system. Used for audit trail and data lineage.',
    `design_language_theme` STRING COMMENT 'Name or description of the design language or styling theme applied to this nameplate (e.g., Kodo Soul of Motion, Sensual Purity, Bold American Truck). Used for design continuity and brand identity.',
    `emissions_standard_target` STRING COMMENT 'Target emissions compliance standard for this nameplate (e.g., EPA Tier 3, Euro 6d, China 6b, LEV III). Multiple standards may apply; this represents the most stringent.',
    `eop_quarter` STRING COMMENT 'Fiscal quarter within the EOP year when production ceased or is planned to cease (Q1, Q2, Q3, Q4). Null if eop_year is null.. Valid values are `Q1|Q2|Q3|Q4`',
    `eop_year` STRING COMMENT 'Calendar year when this nameplate ceased or is planned to cease production. Null for active nameplates with no planned discontinuation.',
    `global_availability_flag` BOOLEAN COMMENT 'Indicates whether this nameplate is available globally (true) or limited to specific regional markets (false).',
    `heritage_lineage` STRING COMMENT 'Textual description of the nameplates heritage and generational lineage (e.g., Successor to Model T, 14th generation). Used for brand storytelling and historical tracking.',
    `homologation_markets` STRING COMMENT 'Comma-separated list of regulatory markets for which this nameplate has received or is pursuing homologation approval (e.g., USA, EUR, CHN, JPN). Used for compliance tracking.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the nameplate: concept (pre-development), development (engineering phase), active (in production and sales), phaseout (end-of-life transition), discontinued (no longer produced).. Valid values are `concept|development|active|phaseout|discontinued`',
    `market_positioning_tier` STRING COMMENT 'Strategic market positioning tier indicating the target customer segment and price point (entry-level, mainstream, premium, luxury, performance).. Valid values are `entry|mainstream|premium|luxury|performance`',
    `marketing_tagline` STRING COMMENT 'Primary marketing tagline or slogan associated with this nameplate (e.g., Built Ford Tough, The Ultimate Driving Machine). Used for brand consistency across campaigns.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this nameplate record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this nameplate record was last modified. Used for audit trail and change tracking.',
    `nameplate_code` STRING COMMENT 'Unique alphanumeric code identifying the nameplate in enterprise systems (e.g., F150, CAMRY, SILVERADO). Used as the business identifier across PLM, ERP, and DMS systems.. Valid values are `^[A-Z0-9]{3,15}$`',
    `nameplate_name` STRING COMMENT 'Commercial brand name of the vehicle nameplate as marketed to consumers (e.g., F-150, Camry, Silverado, Mustang Mach-E).',
    `ncap_rating_target` STRING COMMENT 'Target safety rating for this nameplate under applicable NCAP programs (e.g., 5-star Euro NCAP, 5-star NHTSA). Used for safety engineering and marketing.. Valid values are `3_star|4_star|5_star|not_rated`',
    `ota_update_enabled` BOOLEAN COMMENT 'Indicates whether this nameplate supports over-the-air software updates for ECU firmware, infotainment, and vehicle systems (true/false).',
    `platform_code` STRING COMMENT 'Engineering platform or architecture code on which this nameplate is built (e.g., MQB, TNGA, T1XX). Shared platforms enable economies of scale across multiple nameplates.. Valid values are `^[A-Z0-9]{2,10}$`',
    `powertrain_family` STRING COMMENT 'Primary powertrain technology family for this nameplate: ICE (Internal Combustion Engine), HEV (Hybrid Electric Vehicle), PHEV (Plug-in Hybrid Electric Vehicle), BEV (Battery Electric Vehicle), FCEV (Fuel Cell Electric Vehicle).. Valid values are `ice|hev|phev|bev|fcev`',
    `predecessor_nameplate_code` STRING COMMENT 'Nameplate code of the direct predecessor model that this nameplate replaced or evolved from. Null for entirely new nameplates with no predecessor.. Valid values are `^[A-Z0-9]{3,15}$`',
    `record_source_system` STRING COMMENT 'Name or code of the source system from which this nameplate record originated (e.g., Teamcenter PLM, SAP S/4HANA MM, Salesforce Automotive Cloud). Used for data lineage and integration tracking.',
    `regional_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or regional market codes where this nameplate is available (e.g., USA,CAN,MEX for North America; EUR for Europe). Null if global_availability_flag is true.',
    `regulatory_class` STRING COMMENT 'Regulatory classification for emissions, safety, and fuel economy standards (e.g., passenger car, light truck, medium-duty vehicle). Varies by jurisdiction (NHTSA, EPA, CARB, UNECE).',
    `seating_capacity_range` STRING COMMENT 'Range of seating capacity across all configurations of this nameplate (e.g., 5, 5-7, 2-3). Format: single number or range (min-max).. Valid values are `^d{1,2}(-d{1,2})?$`',
    `sop_quarter` STRING COMMENT 'Fiscal quarter within the SOP year when production commenced (Q1, Q2, Q3, Q4).. Valid values are `Q1|Q2|Q3|Q4`',
    `sop_year` STRING COMMENT 'Calendar year when this nameplate first entered production. Used for heritage tracking and program planning.',
    `target_annual_volume` STRING COMMENT 'Planned annual production volume (units) for this nameplate at steady-state production. Used for capacity planning and supply chain forecasting.',
    `target_msrp_max` DECIMAL(18,2) COMMENT 'Maximum target MSRP in USD for the highest-trim configuration of this nameplate. Used for portfolio planning and competitive positioning.',
    `target_msrp_min` DECIMAL(18,2) COMMENT 'Minimum target MSRP in USD for the base configuration of this nameplate. Used for portfolio planning and competitive positioning.',
    `vehicle_segment` STRING COMMENT 'Market segment classification of the nameplate (e.g., sedan, SUV, truck, commercial vehicle). Used for portfolio planning and market analysis. [ENUM-REF-CANDIDATE: sedan|coupe|suv|crossover|truck|van|commercial|sports|luxury — 9 candidates stripped; promote to reference product]',
    `warranty_program_code` STRING COMMENT 'Code identifying the standard warranty program applicable to this nameplate (e.g., basic warranty, powertrain warranty, EV battery warranty). Links to warranty terms and coverage details.. Valid values are `^[A-Z0-9]{3,10}$`',
    CONSTRAINT pk_nameplate PRIMARY KEY(`nameplate_id`)
) COMMENT 'SSOT for vehicle nameplate definitions — the commercial brand identity of a vehicle line (e.g., F-150, Silverado, Camry, Mustang). Owns nameplate code, brand affiliation, vehicle segment classification (car/truck/SUV/commercial), powertrain family (ICE/HEV/PHEV/EV), market positioning tier, global vs. regional availability flag, nameplate lifecycle status (active/discontinued), SOP (Start of Production) year, EOP (End of Production) year, and nameplate heritage lineage. This is the root anchor for all program and model year planning.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` (
    `aftersales_model_year_program_id` BIGINT COMMENT 'Primary key for model_year_program',
    `control_plan_id` BIGINT COMMENT 'Unique identifier for the model year program. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Program‑level budgeting and cost tracking rely on a dedicated cost_center for each model year program.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for overall program execution, budget, and milestone delivery.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Inspection plans are scoped to a specific model‑year program; linking supports scheduling and compliance reporting per program.',
    `nameplate_id` BIGINT COMMENT 'Reference to the nameplate (vehicle brand/model family) that this program is for.',
    `plant_id` BIGINT COMMENT 'Reference to the primary manufacturing plant assigned to produce vehicles for this model year program.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Program profitability (EBITDA, margin) is reported via a profit_center linked to the model_year_program.',
    `program_manager_employee_id` BIGINT COMMENT 'Reference to the employee responsible for overall program execution, budget, and milestone delivery.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: REQUIRED: Program managers track which regulatory requirements apply to each vehicle program for compliance planning and budgeting.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Model Year Program Planning aligns with the engineering vehicle program for schedule, budget, and target volume decisions (Program Alignment Dashboard).',
    `actual_production_volume` STRING COMMENT 'Cumulative number of units actually produced to date for this model year program. Updated as production progresses.',
    `adas_level` STRING COMMENT 'SAE automation level for ADAS features included in this model year program. Level 0: no automation; Level 5: full automation.. Valid values are `level_0|level_1|level_2|level_3|level_4|level_5`',
    `bom_complexity_score` DECIMAL(18,2) COMMENT 'Calculated score representing the complexity of the BOM for this model year program, based on part count, variant count, and engineering change frequency.',
    `cafe_target` DECIMAL(18,2) COMMENT 'Target CAFE rating (miles per gallon or equivalent) for this model year program to meet regulatory compliance in the United States.',
    `capex_amount` DECIMAL(18,2) COMMENT 'Portion of the program budget allocated to capital expenditures: tooling, equipment, facility modifications, and fixed assets required for this program.',
    `connected_services_enabled` BOOLEAN COMMENT 'Indicates whether this model year program includes connected vehicle services (telematics, OTA updates, V2X communication, remote diagnostics).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model year program record was first created in the system.',
    `eop_date` DATE COMMENT 'Planned or actual date when series production ends for this model year program. Triggers runout planning, parts obsolescence, and service support transition.',
    `epa_rating_target` DECIMAL(18,2) COMMENT 'Target EPA fuel economy or emissions rating for this model year program to meet U.S. environmental compliance and consumer labeling requirements.',
    `fmea_completed` BOOLEAN COMMENT 'Indicates whether FMEA has been completed for this model year program as part of APQP quality planning.',
    `homologation_region` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country or region codes where this model year program is planned for regulatory homologation and sale (e.g., USA,CAN,MEX for North America).. Valid values are `^[A-Z]{3}(,[A-Z]{3})*$`',
    `launch_date` DATE COMMENT 'Date when vehicles from this program become available for customer delivery and retail sale. May differ from SOP due to inventory build and distribution lead time.',
    `model_year` STRING COMMENT 'The model year designation for this program (e.g., 2024, 2025). Represents the marketing and regulatory year, not necessarily the calendar year of production.',
    `msrp_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the MSRP targets (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `ncap_target_rating` STRING COMMENT 'Target safety rating (1 to 5 stars) for this model year program under applicable NCAP testing (Euro NCAP, NHTSA, etc.). Influences marketing and regulatory compliance.. Valid values are `1_star|2_star|3_star|4_star|5_star`',
    `ota_capable` BOOLEAN COMMENT 'Indicates whether vehicles in this model year program support over-the-air software updates for ECU firmware, infotainment, and vehicle features.',
    `platform_code` STRING COMMENT 'Engineering platform or architecture code that this model year program is built on. Shared platforms enable cost efficiencies and parts commonality across nameplates.. Valid values are `^[A-Z0-9]{2,10}$`',
    `powertrain_type` STRING COMMENT 'Primary powertrain technology for this model year program. ICE: Internal Combustion Engine; HEV: Hybrid Electric Vehicle; PHEV: Plug-in Hybrid Electric Vehicle; BEV: Battery Electric Vehicle; FCEV: Fuel Cell Electric Vehicle.. Valid values are `ICE|HEV|PHEV|BEV|FCEV`',
    `ppap_status` STRING COMMENT 'Current status of PPAP submissions for this model year program. PPAP approval is required before series production can begin.. Valid values are `not_started|in_progress|submitted|approved|rejected`',
    `program_budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for this model year program, including CapEx for tooling, engineering, validation, and launch costs. Excludes variable production costs.',
    `program_budget_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the program budget amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `program_code` STRING COMMENT 'Unique alphanumeric code assigned to this model year program for internal tracking and cross-system reference.. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the model year program, including key features, strategic objectives, target market, and differentiation from prior model years.',
    `program_name` STRING COMMENT 'Human-readable name of the model year program, typically combining nameplate and model year (e.g., F-150 MY2025 Program).',
    `program_phase` STRING COMMENT 'Current lifecycle phase of the model year program. Concept: initial planning; Development: engineering and design; Validation: PPAP and testing; Launch: SOP preparation; Production: active manufacturing; Runout: approaching EOP; Discontinued: post-EOP. [ENUM-REF-CANDIDATE: concept|development|validation|launch|production|runout|discontinued — 7 candidates stripped; promote to reference product]',
    `program_priority` STRING COMMENT 'Strategic priority level assigned to this model year program for resource allocation, executive attention, and portfolio management.. Valid values are `critical|high|medium|low`',
    `program_status` STRING COMMENT 'Operational status of the program. Active: proceeding as planned; On Hold: temporarily paused; Cancelled: terminated before completion; Completed: finished lifecycle.. Valid values are `active|on_hold|cancelled|completed`',
    `risk_level` STRING COMMENT 'Overall risk assessment for this model year program based on technical complexity, supply chain dependencies, regulatory uncertainty, and market conditions.. Valid values are `low|medium|high|critical`',
    `sop_date` DATE COMMENT 'Planned or actual date when series production begins for this model year program. Critical milestone for supply chain, manufacturing, and dealer planning.',
    `supplier_count` STRING COMMENT 'Number of unique suppliers engaged to provide parts and components for this model year program. Used for supply chain complexity assessment.',
    `target_msrp_max` DECIMAL(18,2) COMMENT 'Maximum MSRP target for the fully-loaded configuration of this model year program. Defines the upper bound of the pricing envelope.',
    `target_msrp_min` DECIMAL(18,2) COMMENT 'Minimum MSRP target for the base configuration of this model year program. Used for pricing strategy and competitive positioning.',
    `target_production_volume` STRING COMMENT 'Planned total number of units to be produced during the lifecycle of this model year program. Used for capacity planning, procurement, and sales forecasting.',
    `tooling_investment` DECIMAL(18,2) COMMENT 'Total investment in tooling (dies, molds, fixtures, jigs) required for this model year program. Subset of CapEx.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this model year program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this model year program record was last modified.',
    `vehicle_segment` STRING COMMENT 'Market segment classification for this model year program. Used for competitive analysis, marketing strategy, and portfolio planning. [ENUM-REF-CANDIDATE: compact|midsize|fullsize|suv|crossover|truck|van|luxury|sports|commercial — 10 candidates stripped; promote to reference product]',
    `wltp_target` DECIMAL(18,2) COMMENT 'Target WLTP fuel consumption or CO2 emissions rating for this model year program to meet regulatory compliance in markets using WLTP standards.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this model year program record.',
    CONSTRAINT pk_aftersales_model_year_program PRIMARY KEY(`aftersales_model_year_program_id`)
) COMMENT 'Defines the annual program plan for each nameplate by MY (Model Year). Captures MY designation, program code, program phase (concept/development/launch/production/runout), SOP date, EOP date, target plant assignments, planned production volume, regulatory homologation targets (CAFE, WLTP, EPA), program budget envelope (CapEx), and program manager reference. Acts as the planning backbone linking nameplate definitions to annual production and sales programs.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` (
    `aftersales_trim_level_id` BIGINT COMMENT 'Unique identifier for the trim level. Primary key for the trim level entity.',
    `nameplate_id` BIGINT COMMENT 'Reference to the parent nameplate (e.g., F-150, Mustang, Explorer) under which this trim level is offered.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: REQUIRED: Each trim level is built on a dedicated production line; line scheduling and takt‑time calculations depend on this link.',
    `adas_level` STRING COMMENT 'The SAE automation level of the standard ADAS features included in this trim (none, Level 1, Level 2, Level 3).. Valid values are `none|level_1|level_2|level_3`',
    `availability_regions` STRING COMMENT 'Comma-separated list of geographic regions or markets where this trim level is available for sale (e.g., USA, CAN, MEX, EUR, CHN). Detailed region-to-trim mappings maintained in separate association tables.',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT 'Total battery pack capacity in kilowatt-hours for electric and plug-in hybrid vehicles. Null for ICE-only vehicles.',
    `body_style` STRING COMMENT 'The body style configuration for this trim level (e.g., sedan, coupe, SUV, pickup). Some nameplates may offer multiple body styles across different trim levels. [ENUM-REF-CANDIDATE: sedan|coupe|hatchback|wagon|suv|crossover|pickup|van|convertible — 9 candidates stripped; promote to reference product]',
    `cargo_volume_cu_ft` DECIMAL(18,2) COMMENT 'Total cargo volume in cubic feet behind the first row of seats. For pickups, represents bed volume.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trim level record was first created in the system.',
    `drivetrain` STRING COMMENT 'The drivetrain configuration: FWD (Front-Wheel Drive), RWD (Rear-Wheel Drive), AWD (All-Wheel Drive), or 4WD (Four-Wheel Drive).. Valid values are `FWD|RWD|AWD|4WD`',
    `electric_range_miles` STRING COMMENT 'EPA-rated all-electric driving range in miles for BEV and PHEV trim levels. Null for ICE-only vehicles.',
    `engine_displacement_liters` DECIMAL(18,2) COMMENT 'The engine displacement in liters for ICE and hybrid powertrains. Null for battery electric vehicles.',
    `eop_date` DATE COMMENT 'The date when production of this trim level ended or is planned to end. Used for phase-out planning and parts support.',
    `epa_city_mpg` STRING COMMENT 'EPA-rated fuel economy for city driving in miles per gallon. For electric vehicles, this represents MPGe (miles per gallon equivalent).',
    `epa_combined_mpg` STRING COMMENT 'EPA-rated combined fuel economy in miles per gallon. For electric vehicles, this represents MPGe.',
    `epa_highway_mpg` STRING COMMENT 'EPA-rated fuel economy for highway driving in miles per gallon. For electric vehicles, this represents MPGe.',
    `fuel_type` STRING COMMENT 'The primary fuel type for this trim level (gasoline, diesel, E85, electric, hydrogen, or hybrid).. Valid values are `gasoline|diesel|E85|electric|hydrogen|hybrid`',
    `horsepower` STRING COMMENT 'The rated horsepower output of the powertrain. For electric vehicles, represents the combined motor output.',
    `invoice_price` DECIMAL(18,2) COMMENT 'The wholesale price charged to dealers for this trim level in base configuration. Used for dealer margin calculations and incentive programs.',
    `is_fleet_eligible` BOOLEAN COMMENT 'Indicates whether this trim level is available for fleet and commercial sales programs.',
    `is_special_edition` BOOLEAN COMMENT 'Indicates whether this trim level is a limited or special edition with unique features, badging, or production volume constraints.',
    `market_segment` STRING COMMENT 'The target market segment for this trim level, indicating the positioning strategy and customer demographic focus. [ENUM-REF-CANDIDATE: entry|mid|premium|luxury|performance|commercial|fleet — 7 candidates stripped; promote to reference product]',
    `model_year` STRING COMMENT 'The model year for which this trim level is defined. Represents the commercial year designation, not the calendar year of production.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trim level record was last modified in the system.',
    `msrp_base_price` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this trim level in the base configuration, excluding options, packages, destination charges, and taxes. Expressed in the home currency.',
    `msrp_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP base price (e.g., USD, EUR, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `ncap_overall_rating` STRING COMMENT 'Overall safety rating from NCAP testing (1-5 stars). May vary by market (NHTSA, Euro NCAP, etc.).',
    `payload_capacity_lbs` STRING COMMENT 'Maximum payload capacity in pounds. Particularly relevant for pickup trucks and commercial vehicles.',
    `powertrain_type` STRING COMMENT 'The primary powertrain technology for this trim level: ICE (Internal Combustion Engine), HEV (Hybrid Electric Vehicle), PHEV (Plug-in Hybrid Electric Vehicle), BEV (Battery Electric Vehicle), or FCEV (Fuel Cell Electric Vehicle).. Valid values are `ICE|HEV|PHEV|BEV|FCEV`',
    `production_status` STRING COMMENT 'Current production lifecycle status of this trim level: planned (not yet in production), pre_production (tooling and validation), active (in production), discontinued (no longer produced but still sold), or end_of_life (fully retired).. Valid values are `planned|pre_production|active|discontinued|end_of_life`',
    `seating_capacity` STRING COMMENT 'The standard number of passenger seats in this trim level configuration. May vary with optional seating packages.',
    `sop_date` DATE COMMENT 'The date when production of this trim level began or is planned to begin. Critical milestone for manufacturing and supply chain planning.',
    `standard_features_summary` STRING COMMENT 'High-level summary of the standard features included in this trim level (e.g., engine type, transmission, infotainment system, safety features). Detailed feature-to-trim mappings are maintained in separate association tables.',
    `torque_lb_ft` STRING COMMENT 'The rated torque output in pound-feet. For electric vehicles, represents the combined motor torque.',
    `towing_capacity_lbs` STRING COMMENT 'Maximum towing capacity in pounds when properly equipped. Critical specification for trucks and SUVs.',
    `transmission_type` STRING COMMENT 'The standard transmission type for this trim level (e.g., 10-speed automatic, 6-speed manual, CVT, single-speed electric).',
    `trim_code` STRING COMMENT 'The internal alphanumeric code uniquely identifying this trim level within the nameplate and model year. Used in manufacturing, ordering, and dealer systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `trim_description` STRING COMMENT 'Detailed description of the trim level, including key features, positioning, and target customer segment. Used for marketing materials and dealer training.',
    `trim_name` STRING COMMENT 'The commercial marketing name of the trim level (e.g., Base, XL, XLT, Lariat, Platinum, Limited, King Ranch, Raptor). This is the customer-facing designation.',
    `trim_rank` STRING COMMENT 'Ordinal ranking of this trim level within the nameplate hierarchy, where lower numbers indicate entry-level trims and higher numbers indicate premium trims. Used for sorting and comparison.',
    `warranty_basic_miles` STRING COMMENT 'Mileage limit of the basic bumper-to-bumper warranty in miles for this trim level.',
    `warranty_basic_months` STRING COMMENT 'Duration of the basic bumper-to-bumper warranty in months for this trim level.',
    `warranty_powertrain_miles` STRING COMMENT 'Mileage limit of the powertrain warranty in miles for this trim level.',
    `warranty_powertrain_months` STRING COMMENT 'Duration of the powertrain warranty in months for this trim level.',
    CONSTRAINT pk_aftersales_trim_level PRIMARY KEY(`aftersales_trim_level_id`)
) COMMENT 'Defines the commercial trim hierarchy for a model year program (e.g., Base, XL, XLT, Lariat, Platinum, Limited). Captures trim code, trim name, trim rank/order within the nameplate hierarchy, standard feature set description, MSRP base price, market segment positioning, availability regions, and active/inactive lifecycle status. Trim levels are the primary commercial differentiation layer between the nameplate and individual option packages.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` (
    `aftersales_option_package_id` BIGINT COMMENT 'Unique identifier for the option package. Primary key.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Required for the Option Package Sourcing Report, which tracks which supplier provides each option package for cost, compliance, and lead‑time management.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: REQUIRED: Option packages are assembled on specific lines; tooling and labor planning reports require the association.',
    `attachment_rate_percent` DECIMAL(18,2) COMMENT 'Historical attachment rate percentage indicating how often this option package is selected when available. Used for demand forecasting and production planning.',
    `available_markets` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or market region codes where this option package is available for sale. Supports regional product portfolio management.',
    `available_model_years` STRING COMMENT 'Comma-separated list of model years (MY) for which this option package is available. Supports multi-year planning and phase-in/phase-out management.',
    `available_trim_levels` STRING COMMENT 'Comma-separated list of trim level codes where this option package can be ordered. Defines the commercial availability matrix by vehicle configuration.',
    `bom_reference_number` STRING COMMENT 'Reference to the engineering Bill of Materials (BOM) that defines the complete parts structure for this option package. Links commercial catalog to engineering product structure.',
    `content_description` STRING COMMENT 'Detailed description of all features, components, and equipment included in this option package. Used for customer communication, sales training, and regulatory disclosure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this option package record was first created in the system.',
    `dealer_cost_amount` DECIMAL(18,2) COMMENT 'Wholesale cost to the dealer for this option package. Used for dealer margin calculations and incentive program eligibility. Business-confidential pricing data.',
    `discontinuation_date` DATE COMMENT 'Date when this option package was or will be removed from the orderable catalog. Corresponds to End of Production (EOP) or phase-out date. Null if still active.',
    `emissions_impact_grams_co2_km` DECIMAL(18,2) COMMENT 'Incremental CO2 emissions impact of this option package in grams per kilometer under WLTP test cycle. Used for CAFE and emissions compliance reporting.',
    `excludes_package_codes` STRING COMMENT 'Comma-separated list of package codes that cannot be selected if this package is chosen. Enforces mutual exclusivity constraints in the vehicle configuration logic.',
    `fuel_economy_impact_percent` DECIMAL(18,2) COMMENT 'Percentage impact on vehicle fuel economy when this option package is installed. Positive values indicate reduced efficiency; negative values indicate improved efficiency. Used for EPA fuel economy label calculations.',
    `included_in_package_codes` STRING COMMENT 'Comma-separated list of higher-level package codes that already include this package as a component. Prevents duplicate ordering and pricing.',
    `installation_location` STRING COMMENT 'Designated location where this option package is installed: factory (during main assembly line production), port (at port facility before delivery), dealer (at dealership after delivery).. Valid values are `factory|port|dealer`',
    `introduction_date` DATE COMMENT 'Date when this option package was first made available for customer ordering. Corresponds to Start of Production (SOP) or commercial launch date.',
    `is_orderable` BOOLEAN COMMENT 'Indicates whether this option package is currently available for customer ordering. May be false due to supply constraints, regulatory holds, or lifecycle status.',
    `is_visible_to_customer` BOOLEAN COMMENT 'Indicates whether this option package should be displayed in customer-facing configurators and marketing materials. May be hidden for dealer-only or internal packages.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Standard labor hours required to install this option package during vehicle assembly or at dealer/port. Used for production scheduling and capacity planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this option package record was last updated. Used for change tracking and data synchronization.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the option package in the commercial catalog: planned (future availability), active (orderable), phasing_out (limited availability), discontinued (no longer orderable), obsolete (historical record only).. Valid values are `planned|active|phasing_out|discontinued|obsolete`',
    `marketing_description` STRING COMMENT 'Customer-facing marketing copy highlighting the benefits and value proposition of this option package. Used in brochures, websites, and configurators.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'Manufacturer Suggested Retail Price uplift amount for this option package in the base currency. Represents the incremental price added to the base vehicle MSRP when this package is selected.',
    `msrp_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP amount (e.g., USD, EUR, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `package_category` STRING COMMENT 'High-level functional category grouping for the option package used for catalog organization and customer navigation. [ENUM-REF-CANDIDATE: exterior|interior|technology|safety|performance|comfort|convenience|appearance — 8 candidates stripped; promote to reference product]',
    `package_code` STRING COMMENT 'Manufacturer-assigned alphanumeric code uniquely identifying this option package in the commercial catalog (e.g., TECH01, TOW-PKG, PREM-AUD). Used in ordering systems, dealer management systems, and customer-facing configurators.. Valid values are `^[A-Z0-9]{3,10}$`',
    `package_name` STRING COMMENT 'Marketing name of the option package as presented to customers and dealers (e.g., Technology Package, Towing Package, Premium Audio System).',
    `package_type` STRING COMMENT 'Classification of the option package: group (bundle of multiple features), standalone (single feature option), accessory (aftermarket add-on), dealer_installed (installed at dealership), port_installed (installed at port before delivery).. Valid values are `group|standalone|accessory|dealer_installed|port_installed`',
    `production_feasibility_status` STRING COMMENT 'Current manufacturing feasibility status indicating whether the option package can be produced given current supply chain, capacity, and tooling constraints.. Valid values are `feasible|constrained|unavailable|pending_validation`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether this option package requires specific regulatory approval or homologation before it can be sold in certain markets (e.g., NHTSA, EPA, Euro NCAP certification).',
    `requires_package_codes` STRING COMMENT 'Comma-separated list of package codes that must be selected before this package can be ordered. Enforces prerequisite dependencies in the vehicle configuration logic.',
    `sales_rank` STRING COMMENT 'Relative sales popularity ranking of this option package compared to other packages in the same category. Used for inventory planning and marketing prioritization.',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier used for inventory management, parts ordering, and dealer stock tracking. May differ from package_code in multi-channel distribution scenarios.',
    `source_system` STRING COMMENT 'Name of the source system of record where this option package data originates (e.g., SAP SD, Teamcenter PLM, Product Configurator).',
    `supplier_part_number` STRING COMMENT 'Primary supplier part number for the main component or assembly of this option package. Used for procurement, supply chain traceability, and warranty tracking.',
    `warranty_miles` STRING COMMENT 'Standard warranty coverage mileage limit for this option package. Used in conjunction with warranty_months for warranty claim validation.',
    `warranty_months` STRING COMMENT 'Standard warranty coverage period for this option package in months. May differ from base vehicle warranty for certain accessory or technology packages.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight contribution of this option package in kilograms. Used for vehicle weight calculations, fuel economy ratings (CAFE compliance), and payload capacity determination.',
    CONSTRAINT pk_aftersales_option_package PRIMARY KEY(`aftersales_option_package_id`)
) COMMENT 'Defines commercially available option packages and standalone options that can be ordered on a vehicle (e.g., Technology Package, Tow Package, Panoramic Roof, Premium Audio). Captures package code, package name, package type (group/standalone/accessory), MSRP uplift price, content description, constraint rules (requires/excludes other packages), availability by trim level, market availability regions, and lifecycle status. Distinct from engineering feature definitions — this is the commercial catalog layer.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`sku` (
    `sku_id` BIGINT COMMENT 'Primary key for sku',
    `aftersales_trim_level_id` BIGINT COMMENT 'FK to product.trim_level',
    `body_style_id` BIGINT COMMENT 'FK to product.body_style',
    `color_option_id` BIGINT COMMENT 'Foreign key linking to product.color_option. Business justification: Color option is a master list; replacing the free‑form color code with a FK normalizes color data and removes the redundant exterior_color_code column.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Sales posting for each SKU uses a specific GL account; required for accurate revenue GL mapping in AR invoices.',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: REQUIRED: Recall and warranty teams need to map each SKU to its homologation approval for regulatory reporting and certification traceability.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (brand model line) that this SKU belongs to.',
    `production_bom_id` BIGINT COMMENT 'Reference to the production BOM defining the complete parts and assembly structure for manufacturing this SKU.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Required for Production Planning & Inventory Allocation report linking each vehicle SKU to its master inventory SKU for stock tracking, WIP allocation, and regulatory compliance.',
    `adas_level` STRING COMMENT 'The SAE automation level for the ADAS features included in this SKU (none, Level 1 through Level 5).. Valid values are `none|level_1|level_2|level_3|level_4|level_5`',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT 'The total battery pack energy capacity in kilowatt-hours for electric and plug-in hybrid vehicles. Null for non-electric powertrains.',
    `cargo_volume_cu_ft` DECIMAL(18,2) COMMENT 'The cargo area volume in cubic feet behind the rear seats.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SKU record was first created in the system.',
    `curb_weight_lbs` STRING COMMENT 'The vehicle weight in pounds without passengers or cargo, but with all fluids and standard equipment.',
    `door_count` STRING COMMENT 'The total number of doors including passenger doors and rear hatch/trunk (e.g., 2, 4, 5).',
    `drivetrain_type` STRING COMMENT 'The drivetrain configuration: FWD (Front-Wheel Drive), RWD (Rear-Wheel Drive), AWD (All-Wheel Drive), or 4WD (Four-Wheel Drive).. Valid values are `FWD|RWD|AWD|4WD`',
    `electric_range_miles` DECIMAL(18,2) COMMENT 'The EPA-certified all-electric driving range in miles for BEV and PHEV configurations. Null for non-electric powertrains.',
    `emission_standard` STRING COMMENT 'The emissions certification standard this SKU complies with (e.g., EPA Tier 3, Euro 6d, CARB LEV III).',
    `engine_displacement_liters` DECIMAL(18,2) COMMENT 'The total engine displacement volume in liters for ICE and hybrid powertrains. Null for pure electric vehicles.',
    `eop_date` DATE COMMENT 'The date when production of this SKU configuration ended or is planned to end. Null for active SKUs with no planned discontinuation.',
    `epa_city_mpg` DECIMAL(18,2) COMMENT 'The EPA-certified city fuel economy rating in miles per gallon. Null for pure electric vehicles.',
    `epa_combined_mpg` DECIMAL(18,2) COMMENT 'The EPA-certified combined fuel economy rating in miles per gallon. Null for pure electric vehicles.',
    `epa_highway_mpg` DECIMAL(18,2) COMMENT 'The EPA-certified highway fuel economy rating in miles per gallon. Null for pure electric vehicles.',
    `fuel_type` STRING COMMENT 'The primary fuel or energy source for the powertrain. [ENUM-REF-CANDIDATE: gasoline|diesel|e85|cng|electric|hydrogen|hybrid — 7 candidates stripped; promote to reference product]',
    `gvwr_lbs` STRING COMMENT 'The maximum allowable total weight of the vehicle including passengers, cargo, and fluids, in pounds.',
    `horsepower` STRING COMMENT 'The maximum engine or motor power output in horsepower.',
    `interior_color_code` STRING COMMENT 'The manufacturer code identifying the interior color and material combination (e.g., black leather, beige cloth).. Valid values are `^[A-Z0-9]{3,8}$`',
    `interior_material_type` STRING COMMENT 'The primary upholstery material used for seats and interior surfaces.. Valid values are `cloth|leather|synthetic_leather|alcantara|vinyl`',
    `invoice_price_amount` DECIMAL(18,2) COMMENT 'The dealer invoice price for this SKU configuration, representing the base cost to the dealer before incentives.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SKU record was last updated.',
    `lifecycle_status` STRING COMMENT 'The current lifecycle state of this SKU: planned (future), active (available for order), orderable (accepting orders), production (being built), phasing_out (limited availability), or discontinued (no longer available).. Valid values are `planned|active|orderable|production|phasing_out|discontinued`',
    `market_destination_code` STRING COMMENT 'The ISO country or regional market code indicating the regulatory and specification destination for this SKU (e.g., USA, CAN, EUR, CHN).. Valid values are `^[A-Z]{2,3}$`',
    `model_year` STRING COMMENT 'The model year designation for this SKU configuration, representing the production year cycle.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this SKU configuration in the base currency, excluding destination charges and options.',
    `msrp_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the MSRP amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `ncap_safety_rating` STRING COMMENT 'The overall NCAP safety rating (1-5 stars) for this vehicle configuration. Null or not_rated if not yet tested.. Valid values are `^[1-5]$|not_rated`',
    `option_package_codes` STRING COMMENT 'Comma-separated list of option package codes included in this SKU configuration (e.g., technology package, premium audio, towing package).',
    `orderable_end_date` DATE COMMENT 'The date when this SKU will no longer be available for new customer orders. Null for active SKUs with no planned end date.',
    `orderable_start_date` DATE COMMENT 'The date when this SKU became or will become available for customer orders.',
    `powertrain_code` STRING COMMENT 'The engineering code identifying the engine or electric powertrain configuration, including displacement, fuel type, and power output characteristics.. Valid values are `^[A-Z0-9]{4,12}$`',
    `powertrain_type` STRING COMMENT 'The powertrain technology category: ICE (Internal Combustion Engine), HEV (Hybrid Electric Vehicle), PHEV (Plug-in Hybrid Electric Vehicle), BEV (Battery Electric Vehicle), or FCEV (Fuel Cell Electric Vehicle).. Valid values are `ICE|HEV|PHEV|BEV|FCEV`',
    `seating_capacity` STRING COMMENT 'The maximum number of passenger seats in this vehicle configuration.',
    `sop_date` DATE COMMENT 'The date when production of this SKU configuration began or is planned to begin.',
    `torque_lb_ft` STRING COMMENT 'The maximum engine or motor torque output in pound-feet.',
    `towing_capacity_lbs` STRING COMMENT 'The maximum trailer weight this vehicle configuration can tow, in pounds. Null if not rated for towing.',
    `transmission_speed_count` STRING COMMENT 'The number of forward gears in the transmission (e.g., 6, 8, 10). Null for CVT and single-speed electric drivetrains.',
    `transmission_type` STRING COMMENT 'The transmission technology: manual, automatic, CVT (Continuously Variable Transmission), DCT (Dual-Clutch Transmission), or AMT (Automated Manual Transmission).. Valid values are `manual|automatic|cvt|dct|amt`',
    `wheelbase_inches` DECIMAL(18,2) COMMENT 'The distance between the front and rear axle centerlines in inches.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'SSOT for the orderable SKU (Stock Keeping Unit) — the fully specified, buildable vehicle configuration combining nameplate, MY, trim level, powertrain, body style, and option packages into a unique orderable unit. Captures SKU code, SKU description, body style, drivetrain type (FWD/RWD/AWD/4WD), engine/powertrain code, transmission type, exterior color code, interior color/material code, market destination code, and SKU lifecycle status. The SKU is the atomic unit used in order management, production scheduling, and dealer inventory.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` (
    `msrp_price_book_id` BIGINT COMMENT 'Unique identifier for the MSRP price book. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Price book approvals are performed by a pricing manager employee; linking enables compliance reporting and audit of pricing decisions.',
    `superseded_by_price_book_msrp_price_book_id` BIGINT COMMENT 'Reference to the price book that replaces this one when status transitions to superseded. Nullable if not yet superseded.',
    `approved_date` DATE COMMENT 'The date on which this price book received formal approval from the designated authority.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this price book record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price book record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all prices in this book are denominated (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `dealer_access_level` STRING COMMENT 'Access control level defining which dealer tiers or internal users can view and use this price book.. Valid values are `public|authorized_dealer|franchise_only|internal`',
    `destination_charge_included_flag` BOOLEAN COMMENT 'Indicates whether destination and delivery charges are included in the MSRP prices within this book.',
    `distribution_channel` STRING COMMENT 'SAP SD distribution channel code identifying the sales channel for which this price book applies (e.g., retail, fleet, direct).',
    `effective_end_date` DATE COMMENT 'The date on which this price book ceases to be valid. Nullable for open-ended price books.',
    `effective_start_date` DATE COMMENT 'The date from which this price book becomes valid and active for dealer ordering and MSRP publication.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this price book record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this price book record was last updated or modified.',
    `market_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country or region code identifying the geographic market for which this price book applies (e.g., USA, CAN, DEU).. Valid values are `^[A-Z]{2,3}$`',
    `model_year` STRING COMMENT 'The model year (MY) for which this price book applies, representing the production year designation for vehicles.. Valid values are `^(19|20)d{2}$`',
    `msrp_price_book_status` STRING COMMENT 'Current lifecycle status of the price book governing its availability for dealer ordering and consumer communications.. Valid values are `draft|approved|published|active|superseded|archived`',
    `price_book_code` STRING COMMENT 'Externally-known unique business identifier for the price book, used in dealer ordering systems and OEM communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `price_book_name` STRING COMMENT 'Human-readable name of the price book, typically including model year and market designation.',
    `price_book_type` STRING COMMENT 'Classification of the price book by customer segment or channel (e.g., standard retail, fleet, government, export).. Valid values are `standard|fleet|government|export|promotional`',
    `price_list_category` STRING COMMENT 'Category of pricing entries contained in this book (e.g., base vehicle, options, packages, accessories, destination charges).. Valid values are `base|option|package|accessory|destination`',
    `publication_format` STRING COMMENT 'Primary format in which this price book is published and distributed to dealers and systems (e.g., PDF, XML, JSON, EDI, print).. Valid values are `pdf|xml|json|edi|print`',
    `published_date` DATE COMMENT 'The date on which this price book was officially published and made available to dealers and distribution channels.',
    `region_code` STRING COMMENT 'Internal regional grouping code for sales and distribution management, may represent sub-national regions or dealer territories.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes documenting compliance with pricing disclosure regulations such as NHTSA labeling requirements or EPA fuel economy disclosures.',
    `remarks` STRING COMMENT 'Additional free-text remarks or special instructions related to this price book, such as promotional conditions or market-specific notes.',
    `sales_organization` STRING COMMENT 'SAP SD sales organization code representing the legal entity or business unit responsible for this price book.',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment applicable to prices in this book (e.g., tax-inclusive, tax-exclusive, VAT, GST).',
    `version_number` STRING COMMENT 'Semantic version number of the price book, incremented for revisions and updates (e.g., 1.0, 1.1, 2.0).. Valid values are `^d+.d+$`',
    CONSTRAINT pk_msrp_price_book PRIMARY KEY(`msrp_price_book_id`)
) COMMENT 'SSOT for MSRP (Manufacturer Suggested Retail Price) price books by model year, market, and currency. Captures price book code, effective date range, market/region code, currency code, price book status (draft/approved/published/superseded), approval authority, and publication date. The price book is the container for all MSRP pricing entries and governs which prices are active for dealer ordering and consumer-facing communications.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` (
    `msrp_price_entry_id` BIGINT COMMENT 'Unique identifier for the MSRP price entry record. Primary key for the price entry entity.',
    `aftersales_trim_level_id` BIGINT COMMENT 'Reference to the specific trim level or grade within the nameplate. Represents the feature and equipment tier (e.g., base, mid-level, premium).',
    `market_availability_id` BIGINT COMMENT 'Reference to the geographic market or sales region for which this price entry is applicable. Enables regional pricing strategies and market-specific MSRP variations.',
    `msrp_price_book_id` BIGINT COMMENT 'Reference to the parent price book that contains this price entry. Links to the price book master entity.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (model line) to which this price entry applies. Examples include specific car, truck, or SUV model lines.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU or product variant being priced. May represent a base vehicle, option package, accessory, or standalone component.',
    `advertising_fee_amount` DECIMAL(18,2) COMMENT 'Mandatory regional or national advertising fee charged to the dealer and passed through to the customer. Supports cooperative advertising programs and brand marketing initiatives.',
    `approval_date` DATE COMMENT 'Date on which this price entry was formally approved by pricing management and authorized for publication. Null for draft or pending entries.',
    `approved_by` STRING COMMENT 'Name or identifier of the pricing manager or executive who approved this price entry. Supports audit trail and accountability for pricing decisions.',
    `base_msrp_amount` DECIMAL(18,2) COMMENT 'The base MSRP amount for the SKU or option before any additional charges, taxes, or adjustments. Represents the manufacturers suggested retail price in the price book currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price entry record was first created in the data product. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which all amounts in this price entry are denominated (e.g., USD, CAD, EUR, MXN).. Valid values are `^[A-Z]{3}$`',
    `dealer_invoice_amount` DECIMAL(18,2) COMMENT 'The wholesale price charged to the dealer by the manufacturer for this SKU or option. Confidential business data used for dealer margin calculation and holdback determination. Typically lower than MSRP.',
    `destination_charge_amount` DECIMAL(18,2) COMMENT 'Mandatory freight and delivery charge from the manufacturing plant or port to the dealer. Also known as destination and delivery fee. Typically uniform within a region but may vary by vehicle size class.',
    `effective_end_date` DATE COMMENT 'The date on which this price entry expires and is no longer valid for new transactions. Nullable for open-ended pricing. Used to manage model year transitions and mid-year price changes.',
    `effective_start_date` DATE COMMENT 'The date on which this price entry becomes active and applicable for dealer invoicing and customer quotations. Represents the beginning of the price validity period.',
    `employee_pricing_amount` DECIMAL(18,2) COMMENT 'Special pricing available to manufacturer employees, retirees, and eligible family members. Confidential pricing tier typically below dealer invoice. Null if no employee program applies.',
    `fleet_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU or option is available for fleet sales programs at this price point. Fleet pricing may differ from retail MSRP. True if eligible for fleet programs, false otherwise.',
    `gas_guzzler_tax_amount` DECIMAL(18,2) COMMENT 'Federal excise tax applied to vehicles that do not meet EPA fuel economy standards. Applicable only to passenger cars (not trucks or SUVs) with combined fuel economy below the statutory threshold. Zero for compliant vehicles.',
    `government_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SKU or option is available for government or municipal fleet purchases under special pricing programs. True if eligible for government sales, false otherwise.',
    `holdback_percentage` DECIMAL(18,2) COMMENT 'Percentage of MSRP or invoice that the manufacturer retains and later rebates to the dealer. Confidential dealer incentive mechanism. Typically ranges from 1% to 3% of MSRP.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this price entry record was most recently updated. Tracks the recency of pricing data and supports change detection.',
    `luxury_tax_amount` DECIMAL(18,2) COMMENT 'Additional tax or surcharge applied to high-value vehicles exceeding a statutory price threshold. Jurisdiction-specific; may be zero in regions without luxury vehicle taxation.',
    `model_year` STRING COMMENT 'The model year for which this price entry is applicable. Represents the vehicle program year, not the calendar year of sale.',
    `notes` STRING COMMENT 'Free-text field for additional pricing notes, special conditions, or explanatory comments. May include details on regional restrictions, bundle requirements, or pricing rationale.',
    `price_change_reason` STRING COMMENT 'Business reason or trigger for the price entry or price change. Supports audit trail and pricing strategy analysis. [ENUM-REF-CANDIDATE: initial_launch|model_year_change|cost_adjustment|competitive_response|incentive_program|regulatory_compliance|currency_adjustment|supply_constraint — 8 candidates stripped; promote to reference product]',
    `price_protection_flag` BOOLEAN COMMENT 'Indicates whether this price entry is covered by a price protection program that compensates dealers for inventory devaluation due to mid-year price reductions. True if protected, false otherwise.',
    `price_status` STRING COMMENT 'Current lifecycle status of the price entry. Tracks the approval and activation workflow from initial draft through active use to eventual expiration or withdrawal.. Valid values are `draft|pending_approval|active|superseded|expired|withdrawn`',
    `price_type` STRING COMMENT 'Classification of the price entry indicating what is being priced. Distinguishes between base vehicle MSRP, individual options, bundled packages, dealer-installed accessories, mandatory destination charges, and regional pricing adjustments. [ENUM-REF-CANDIDATE: base_vehicle|option|package|accessory|destination_charge|regional_adjustment|port_installed_option — 7 candidates stripped; promote to reference product]',
    `prior_msrp_amount` DECIMAL(18,2) COMMENT 'The previous total MSRP amount before the current price change. Used for price change tracking, competitive analysis, and dealer communication. Null for initial price entries.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this price entry is part of a limited-time promotional pricing program. True for promotional pricing, false for standard pricing.',
    `publication_date` DATE COMMENT 'Date on which this price entry was published to dealers and made available in dealer management systems and configurator tools. May differ from effective start date.',
    `source_record_reference` STRING COMMENT 'The unique identifier or key of this price entry in the source system. Enables traceability and reconciliation back to the system of record.',
    `source_system` STRING COMMENT 'Identifier of the upstream system of record from which this price entry was sourced. Typically SAP SD pricing module, PLM system, or pricing management application.',
    `supplier_pricing_amount` DECIMAL(18,2) COMMENT 'Special pricing available to employees of the manufacturers supplier partners. Confidential pricing tier used as a supplier relationship benefit. Null if no supplier program applies.',
    `total_msrp_amount` DECIMAL(18,2) COMMENT 'The total MSRP including base price, destination charge, gas guzzler tax, luxury tax, and any other mandatory manufacturer charges. This is the price displayed on the Monroney window sticker.',
    CONSTRAINT pk_msrp_price_entry PRIMARY KEY(`msrp_price_entry_id`)
) COMMENT 'Individual MSRP (Manufacturer Suggested Retail Price) pricing entries within a price book. Captures the SKU or option package being priced, base MSRP amount, destination charge, gas guzzler tax (if applicable), effective start and end dates, price type (base vehicle/option/package/accessory), and prior price for change tracking. Enables dealer invoice generation, consumer window sticker production, and competitive pricing analysis.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`feature_content` (
    `feature_content_id` BIGINT COMMENT 'Unique identifier for the feature content record. Primary key.',
    `aftersales_trim_level_id` BIGINT COMMENT 'Foreign key linking to product.trim_level. Business justification: Feature content is defined per trim level; linking provides a proper hierarchy and removes any need for duplicate trim identifiers in feature_content.',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Feature‑to‑Design traceability matrix requires linking each product feature to its engineering design specification for validation and regulatory compliance.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature content record was approved for publication. Used for audit trail and compliance verification.',
    `approved_by` STRING COMMENT 'User ID or name of the product manager or marketing manager who approved this feature content for publication. Used for accountability and content governance.',
    `availability_type` STRING COMMENT 'Indicates whether the feature is included as standard equipment, available as a standalone option, only available within a package, or not available for a given trim or market.. Valid values are `standard|optional|package_only|not_available`',
    `content_source_code` STRING COMMENT 'Unique identifier of this feature content record in the source system, used for traceability and data lineage.',
    `content_source_system` STRING COMMENT 'Name of the source system from which this feature content record originates, such as PLM (Product Lifecycle Management), PIM (Product Information Management), or marketing content management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature content record was first created in the system. Used for audit trail and data lineage.',
    `customer_demand_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing customer demand or take-rate for this feature based on market research, configurator analytics, and sales data. Used for product planning and inventory optimization.',
    `dealer_cost_impact_amount` DECIMAL(18,2) COMMENT 'The incremental dealer invoice cost when this feature is included. Used for dealer margin calculations and incentive program design.',
    `ecu_dependency_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this feature requires specific ECU (Electronic Control Unit) hardware or software configuration. Used for manufacturing planning and service diagnostics.',
    `effective_end_date` DATE COMMENT 'The date when this feature content record is no longer effective. Null if the record is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date when this feature content record becomes effective and available for use in configurators, ordering systems, and marketing materials.',
    `feature_category` STRING COMMENT 'High-level classification of the feature grouping for marketing segmentation and consumer navigation. Categories align with consumer decision-making patterns.. Valid values are `safety|technology|comfort|performance|exterior|interior`',
    `feature_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the feature within the product catalog system. Used for cross-system integration and configurator mapping.. Valid values are `^[A-Z0-9]{3,12}$`',
    `feature_description_long` STRING COMMENT 'Comprehensive consumer-facing description of the feature including benefits, technical highlights, and usage scenarios. Used in brochures, website detail pages, and dealer training materials.',
    `feature_description_short` STRING COMMENT 'Brief consumer-facing description of the feature, typically 50-100 characters, used in configurator tooltips and mobile applications.',
    `feature_name` STRING COMMENT 'Consumer-facing marketing name of the feature as displayed in brochures, window stickers, and online configurators.',
    `feature_status` STRING COMMENT 'Current lifecycle status of the feature content record. Active features are available for configuration; discontinued features are retained for historical reference; pending features are awaiting approval; under_review features are being evaluated for changes.. Valid values are `active|discontinued|pending|under_review`',
    `feature_subcategory` STRING COMMENT 'Detailed sub-classification within the feature category for granular filtering and reporting (e.g., within safety: active safety, passive safety, driver assistance).',
    `fuel_economy_impact_percent` DECIMAL(18,2) COMMENT 'The estimated percentage impact on fuel economy (positive or negative) when this feature is included. Used for EPA fuel economy label calculations and CAFE compliance.',
    `installation_time_minutes` STRING COMMENT 'Standard time in minutes required to install this feature on the production line. Used for manufacturing capacity planning and line balancing in MES (Manufacturing Execution System).',
    `is_adas_feature` BOOLEAN COMMENT 'Boolean flag indicating whether this feature is classified as an ADAS (Advanced Driver Assistance Systems) technology, such as adaptive cruise control, lane keeping assist, or automated emergency braking.',
    `is_ev_specific` BOOLEAN COMMENT 'Boolean flag indicating whether this feature is specific to electric vehicle (EV) or plug-in hybrid electric vehicle (PHEV) powertrains, such as regenerative braking display, charging port, or battery thermal management.',
    `is_hev_specific` BOOLEAN COMMENT 'Boolean flag indicating whether this feature is specific to hybrid electric vehicle (HEV) powertrains, such as hybrid system display, EV mode selector, or hybrid battery cooling.',
    `is_regulatory_mandated` BOOLEAN COMMENT 'Boolean flag indicating whether this feature is mandated by regulatory requirements such as NHTSA Federal Motor Vehicle Safety Standards (FMVSS), EPA emissions standards, or regional safety regulations (e.g., backup camera, tire pressure monitoring system).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature content record was last modified. Used for change tracking and synchronization with downstream systems.',
    `market_availability_region` STRING COMMENT 'Geographic region or market where this feature is available, using standardized region codes (e.g., NAM for North America, EUR for Europe, CHN for China). Multiple regions may be pipe-separated.',
    `marketing_priority_rank` STRING COMMENT 'Numerical ranking indicating the marketing priority of this feature for promotional campaigns and sales emphasis. Lower numbers indicate higher priority.',
    `model_year_discontinued` STRING COMMENT 'The model year (MY) when this feature was discontinued or phased out. Null if the feature is still active in the current lineup.',
    `model_year_introduced` STRING COMMENT 'The model year (MY) when this feature was first introduced into the product lineup. Used for product evolution tracking and historical analysis.',
    `msrp_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP impact amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `msrp_impact_amount` DECIMAL(18,2) COMMENT 'The incremental MSRP (Manufacturer Suggested Retail Price) value added when this feature is included as an option. Zero for standard features. Used for pricing calculations and configurator display.',
    `ota_updateable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this feature can be enabled, updated, or modified via OTA (Over-the-Air) software updates post-production.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory standard or requirement that mandates this feature, such as FMVSS number, EPA regulation code, or Euro NCAP protocol. Populated only when is_regulatory_mandated is true.',
    `safety_rating_impact` STRING COMMENT 'Indicates the level of impact this feature has on vehicle safety ratings such as NCAP (New Car Assessment Programme) star ratings or IIHS Top Safety Pick awards.. Valid values are `none|low|medium|high`',
    `supplier_name` STRING COMMENT 'Name of the primary supplier or OEM (Original Equipment Manufacturer) partner providing the component or system that delivers this feature. Used for supply chain traceability and warranty management.',
    `technology_level` STRING COMMENT 'Classification of the features technology sophistication level, used for market positioning and trim-level differentiation strategies.. Valid values are `basic|advanced|premium|luxury`',
    `warranty_extension_months` STRING COMMENT 'Number of additional warranty months provided specifically for this feature beyond the base vehicle warranty. Zero if no extension applies.',
    `weight_impact_kg` DECIMAL(18,2) COMMENT 'The incremental vehicle weight in kilograms added by this feature. Used for CAFE (Corporate Average Fuel Economy) calculations, performance modeling, and engineering analysis.',
    CONSTRAINT pk_feature_content PRIMARY KEY(`feature_content_id`)
) COMMENT 'Defines the commercial feature content associated with a trim level or option package — the consumer-facing feature descriptions used in marketing, window stickers, and configurators. Captures feature code, feature name, feature category (safety/technology/comfort/performance/exterior/interior), feature description, standard vs. optional flag, ADAS (Advanced Driver Assistance Systems) classification flag, EV/HEV-specific flag, regulatory-mandated flag, and content source system reference. Bridges the commercial product catalog to consumer-facing communications.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`market_availability` (
    `market_availability_id` BIGINT COMMENT 'Unique identifier for the market availability record. Primary key for the market availability entity.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Market availability is specific to a SKU; adding the FK eliminates the need for separate SKU code columns and enables direct joins.',
    `allocation_constraint_flag` BOOLEAN COMMENT 'Indicates whether this product configuration is subject to allocation constraints or supply limitations in the target market. True indicates constrained supply requiring allocation management.',
    `assembly_mode` STRING COMMENT 'The assembly and import mode for this product configuration. CBU (Completely Built Up) indicates fully assembled import, CKD (Completely Knocked Down) indicates full disassembly for local assembly, and SKD (Semi Knocked Down) indicates partial disassembly for local assembly. Impacts duty rates and local content requirements.. Valid values are `cbu|ckd|skd`',
    `availability_status` STRING COMMENT 'The current offering status of this product configuration in the specified market and channel. Available indicates orderable, restricted indicates conditional availability, not-offered indicates not sold in this market, discontinued indicates end of sales, pre-order indicates future availability, and limited indicates constrained supply.. Valid values are `available|restricted|not-offered|discontinued|pre-order|limited`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this market availability record was first created in the system. Used for audit trail and data lineage tracking.',
    `dealer_ordering_code` STRING COMMENT 'The code used by dealers in the Dealer Management System (DMS) to order this specific product configuration. May differ from internal SKU codes for legacy system compatibility.. Valid values are `^[A-Z0-9]{4,15}$`',
    `destination_charge_amount` DECIMAL(18,2) COMMENT 'The freight and delivery charge from the manufacturing plant or port to the dealer in the target market. Typically added to MSRP for total customer pricing.',
    `effective_date` DATE COMMENT 'The date when this market availability record became effective. Used for temporal tracking of availability changes and pricing updates.',
    `emissions_standard` STRING COMMENT 'The emissions certification standard that this product configuration meets in the target market. Examples include Euro 6, EPA Tier 3, BS6 (Bharat Stage 6), China 6, and California LEV3. Critical for regulatory compliance and market entry. [ENUM-REF-CANDIDATE: euro6|euro5|tier3|tier2|bs6|bs4|china6|china5|lev3|ulev|zlev — 11 candidates stripped; promote to reference product]',
    `ev_battery_warranty_months` STRING COMMENT 'The duration of the manufacturers battery warranty coverage for electric or hybrid vehicles in the target market, expressed in months. Null for non-electrified vehicles.',
    `expiration_date` DATE COMMENT 'The date when this market availability record expires or is superseded by a new record. Null indicates the current active record.',
    `fuel_economy_rating` DECIMAL(18,2) COMMENT 'The official fuel economy or energy efficiency rating for this product configuration in the target market, expressed in the local standard unit (MPG, L/100km, kWh/100km). Based on standardized test procedures.',
    `fuel_economy_unit` STRING COMMENT 'The unit of measure for the fuel economy rating. MPG (miles per gallon) used in US, L/100km (liters per 100 kilometers) used in Europe and Asia, kWh/100km (kilowatt-hours per 100 kilometers) used for electric vehicles.. Valid values are `mpg|l-per-100km|kwh-per-100km|km-per-l`',
    `government_incentive_amount` DECIMAL(18,2) COMMENT 'The value of government incentives (tax credits, rebates, grants) available for this product configuration in the target market. Commonly applies to electric vehicles and fuel-efficient vehicles. Null if no government incentive available.',
    `homologation_approval_date` DATE COMMENT 'The date when regulatory type-approval was granted for this product configuration in the target market. Critical for compliance tracking and market entry timing.',
    `homologation_approval_status` STRING COMMENT 'The regulatory type-approval status for this product configuration in the target market. Approved indicates certification complete, pending indicates under review, rejected indicates failed certification, not-required indicates no certification needed, and expired indicates certification lapsed.. Valid values are `approved|pending|rejected|not-required|expired`',
    `homologation_certificate_number` STRING COMMENT 'The official type-approval or certification number issued by the regulatory authority for this product configuration in the target market. Required for legal sale in regulated markets.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `homologation_expiry_date` DATE COMMENT 'The date when the regulatory type-approval expires and must be renewed. Null indicates no expiration or perpetual approval.',
    `import_duty_classification` STRING COMMENT 'The Harmonized System (HS) tariff code or customs classification for this product configuration when imported into the target market. Used for duty calculation and customs clearance.. Valid values are `^[0-9]{4,10}$`',
    `import_duty_rate_percent` DECIMAL(18,2) COMMENT 'The applicable import duty or tariff rate as a percentage of the customs value for this product configuration in the target market. Used for landed cost calculation.',
    `incentive_eligible_flag` BOOLEAN COMMENT 'Indicates whether this product configuration is eligible for manufacturer or government incentives in the target market. True indicates eligibility for rebates, tax credits, or promotional programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this market availability record was last updated. Used for change tracking and data synchronization.',
    `launch_date` DATE COMMENT 'The date when this product configuration became available for order or sale in the specified market and channel. Represents the Start of Production (SOP) date for market availability.',
    `lead_time_days` STRING COMMENT 'The typical number of days from order placement to vehicle delivery for this product configuration in the target market. Used for customer expectation setting and order promising.',
    `local_content_percent` DECIMAL(18,2) COMMENT 'The percentage of the product value that is sourced or manufactured locally in the target market. Used for trade agreement compliance and preferential duty qualification.',
    `market_code` STRING COMMENT 'The geographic market or country code where this product configuration is available for sale. Uses ISO 3166-1 alpha-2 or alpha-3 country codes.. Valid values are `^[A-Z]{2,3}$`',
    `max_order_quantity` STRING COMMENT 'The maximum number of units of this product configuration that can be ordered per dealer or per order cycle in the target market. Used for allocation management and demand control. Null indicates no limit.',
    `model_year` STRING COMMENT 'The model year designation for this product availability. Represents the production year classification used for marketing and regulatory purposes.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this product configuration in the target market, expressed in the local currency. Represents the baseline pricing before dealer adjustments, incentives, or negotiations.',
    `msrp_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the MSRP amount. Indicates the local currency of the target market.. Valid values are `^[A-Z]{3}$`',
    `nameplate_code` STRING COMMENT 'The vehicle nameplate or model family identifier (e.g., F-150, Camry, Model 3). Represents the brand-level product designation.. Valid values are `^[A-Z0-9_]{3,15}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, restrictions, or special instructions related to this market availability record. May include dealer ordering notes, allocation rules, or market-specific requirements.',
    `option_package_code` STRING COMMENT 'The optional equipment package identifier that can be added to the base trim configuration. May represent technology packages, appearance packages, or convenience packages.. Valid values are `^[A-Z0-9]{3,10}$`',
    `ordering_priority` STRING COMMENT 'The priority ranking for order allocation and production scheduling for this product configuration in the target market. Lower numbers indicate higher priority. Used when demand exceeds supply.',
    `powertrain_warranty_months` STRING COMMENT 'The duration of the manufacturers powertrain warranty coverage (engine, transmission, drivetrain) for this product configuration in the target market, expressed in months. Typically longer than basic warranty.',
    `pre_delivery_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a formal pre-delivery inspection is required before customer delivery for this product configuration in the target market. True indicates PDI is mandatory per OEM or regulatory requirements.',
    `record_source_system` STRING COMMENT 'The source system that created or last updated this market availability record. SAP-SD indicates SAP Sales and Distribution, PLM indicates Product Lifecycle Management system, DMS indicates Dealer Management System, pricing-engine indicates automated pricing system, manual indicates manual data entry.. Valid values are `sap-sd|plm|dms|pricing-engine|manual`',
    `safety_rating` STRING COMMENT 'The official safety rating from the target markets New Car Assessment Programme (NCAP). Expressed as star rating (e.g., 5-star, 4-star) or not-rated if not yet tested.. Valid values are `^[0-5]-star$|not-rated`',
    `sales_channel` STRING COMMENT 'The distribution channel through which this product configuration is sold. Retail represents dealer network sales, fleet represents commercial bulk sales, government represents public sector contracts, export represents international distribution, direct represents factory-to-customer, and online represents e-commerce channels.. Valid values are `retail|fleet|government|export|direct|online`',
    `trim_level_code` STRING COMMENT 'The trim or grade level identifier (e.g., Base, Sport, Limited, Premium). Defines the feature and equipment package tier.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `warranty_mileage` STRING COMMENT 'The mileage limit of the manufacturers basic warranty coverage for this product configuration in the target market. Warranty expires at the earlier of warranty_months or warranty_mileage.',
    `warranty_months` STRING COMMENT 'The duration of the manufacturers basic warranty coverage for this product configuration in the target market, expressed in months. Represents the bumper-to-bumper or comprehensive warranty period.',
    `withdrawal_date` DATE COMMENT 'The date when this product configuration was or will be withdrawn from sale in the specified market and channel. Represents the End of Production (EOP) date for market availability. Null indicates ongoing availability.',
    CONSTRAINT pk_market_availability PRIMARY KEY(`market_availability_id`)
) COMMENT 'Defines the feature-to-market availability matrix — which SKUs, trim levels, and option packages are available in which geographic markets and sales channels. Captures market code, sales channel (retail/fleet/government/export), availability status (available/restricted/not-offered), launch date, withdrawal date, homologation approval status, import duty classification, and CKD/SKD (Completely Knocked Down / Semi Knocked Down) assembly flag. Critical for order management, dealer ordering systems, and regulatory compliance.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`powertrain_config` (
    `powertrain_config_id` BIGINT COMMENT 'Unique identifier for the powertrain configuration. Primary key for this product.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (model line) for which this powertrain configuration is available.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: REQUIRED: Powertrain configurations are produced at designated plants; supply‑chain and capacity forecasts rely on this mapping.',
    `powertrain_spec_id` BIGINT COMMENT 'Foreign key linking to engineering.powertrain_spec. Business justification: Powertrain configuration must reference detailed engineering powertrain specifications for emissions, WLTP, and cost validation (Powertrain Spec Validation Report).',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Needed for Powertrain Supplier Performance Dashboard, linking each powertrain configuration to its component supplier for quality, cost, and regulatory compliance tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: REQUIRED: Emissions certification links each powertrain configuration to the specific regulatory requirement it must meet.',
    `aspiration_type` STRING COMMENT 'Method of air induction for the internal combustion engine. Null for pure electric and fuel cell powertrains.. Valid values are `naturally_aspirated|turbocharged|supercharged|twin_turbo`',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT 'Total usable battery capacity in kilowatt-hours for electric and plug-in hybrid powertrains. Null for pure ICE vehicles.',
    `battery_chemistry` STRING COMMENT 'Chemical composition of the battery pack for electric and hybrid powertrains. none for pure ICE vehicles.. Valid values are `none|lithium_ion|nickel_metal_hydride|solid_state|lithium_iron_phosphate`',
    `cafe_credit_value` DECIMAL(18,2) COMMENT 'CAFE credit multiplier or value assigned to this powertrain configuration for fleet average fuel economy compliance calculations. Higher for electric and alternative fuel vehicles.',
    `charging_capability` STRING COMMENT 'Maximum charging capability supported by the powertrain for electric and plug-in hybrid vehicles. none for pure ICE and non-plug-in hybrids.. Valid values are `none|level_1|level_2|dc_fast_charge|ultra_fast_charge`',
    `co2_emissions_g_km` STRING COMMENT 'Certified carbon dioxide emissions in grams per kilometer under WLTP or NEDC test cycle. Zero for pure electric vehicles. Used for regulatory compliance and CAFE calculations.',
    `combined_horsepower` STRING COMMENT 'Total system horsepower combining ICE and electric motor output at peak performance. For hybrids, represents maximum combined output, not sum of individual components.',
    `combined_torque_nm` STRING COMMENT 'Total system torque in Newton-meters combining ICE and electric motor output. For hybrids, represents maximum combined torque available to the drivetrain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this powertrain configuration record was first created in the system.',
    `cylinder_count` STRING COMMENT 'Number of cylinders in the internal combustion engine. Null for pure electric (BEV) and fuel cell (FCEV) powertrains.',
    `dealer_invoice_cost_usd` DECIMAL(18,2) COMMENT 'Dealer invoice cost for this powertrain configuration in US dollars. Used for dealer margin calculations and incentive programs.',
    `drivetrain_layout` STRING COMMENT 'Drive wheel configuration. FWD=Front-Wheel Drive, RWD=Rear-Wheel Drive, AWD=All-Wheel Drive (full-time or automatic), 4WD=Four-Wheel Drive (part-time, driver-selectable).. Valid values are `fwd|rwd|awd|4wd`',
    `electric_motor_position` STRING COMMENT 'Physical location of electric motor(s) in the vehicle architecture. integrated indicates motor integrated with transmission. none for pure ICE.. Valid values are `none|front|rear|front_rear|integrated`',
    `electric_motor_type` STRING COMMENT 'Configuration of electric motors in the powertrain. Applicable to HEV, PHEV, BEV, and MHEV. none for pure ICE powertrains.. Valid values are `none|single_motor|dual_motor|tri_motor|quad_motor`',
    `emissions_standard` STRING COMMENT 'Regulatory emissions standard to which this powertrain is certified. ZLEV=Zero Emission Vehicle, SULEV=Super Ultra Low Emission Vehicle, ULEV=Ultra Low Emission Vehicle, LEV III=Low Emission Vehicle III (California), Tier 3=EPA Tier 3, Euro 6=European Standard.. Valid values are `euro_6|tier_3|lev_iii|ulev|sulev|zlev`',
    `end_of_production_date` DATE COMMENT 'Date when this powertrain configuration was discontinued from production. Null for currently active configurations.',
    `engine_configuration` STRING COMMENT 'Physical arrangement of engine cylinders (inline, V-type, flat/boxer, rotary, W-type). Null for pure electric and fuel cell powertrains.. Valid values are `inline|v_type|flat|rotary|w_type`',
    `engine_displacement_liters` DECIMAL(18,2) COMMENT 'Total swept volume of all engine cylinders in liters. Null for pure BEV and FCEV powertrains without an ICE component.',
    `epa_city_mpg` STRING COMMENT 'EPA-certified city fuel economy rating in miles per gallon. For electric vehicles, this represents MPGe (miles per gallon equivalent). Null if EPA rating not applicable.',
    `epa_combined_mpg` STRING COMMENT 'EPA-certified combined (55% city, 45% highway) fuel economy rating in miles per gallon. For electric vehicles, this represents MPGe. Null if EPA rating not applicable.',
    `epa_electric_range_miles` STRING COMMENT 'EPA-certified all-electric driving range in miles for BEV and PHEV powertrains before ICE engagement or recharge required. Null for pure ICE and HEV.',
    `epa_highway_mpg` STRING COMMENT 'EPA-certified highway fuel economy rating in miles per gallon. For electric vehicles, this represents MPGe. Null if EPA rating not applicable.',
    `fuel_type` STRING COMMENT 'Primary fuel type consumed by the powertrain. For hybrids, this represents the ICE fuel; electric component is captured separately.. Valid values are `gasoline|diesel|electric|hydrogen|flex_fuel|cng`',
    `homologation_status` STRING COMMENT 'Current regulatory homologation and type-approval status for this powertrain configuration. Required for legal sale in regulated markets.. Valid values are `certified|pending|not_required|expired`',
    `manufacturing_cost_usd` DECIMAL(18,2) COMMENT 'Standard manufacturing cost for this powertrain configuration in US dollars. Used for margin analysis and profitability reporting.',
    `market_availability` STRING COMMENT 'Geographic market regions where this powertrain configuration is available for sale. [ENUM-REF-CANDIDATE: global|north_america|europe|asia_pacific|china|japan|middle_east|latin_america|africa — promote to reference product]. Valid values are `global|north_america|europe|asia_pacific|china|japan`',
    `max_charging_power_kw` STRING COMMENT 'Maximum DC fast charging power acceptance rate in kilowatts for electric and plug-in hybrid vehicles. Null for pure ICE and non-plug-in hybrids.',
    `model_year` STRING COMMENT 'The model year for which this powertrain configuration is offered. Represents the marketing year, not the calendar year of production.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this powertrain configuration record was last updated in the system.',
    `msrp_base_usd` DECIMAL(18,2) COMMENT 'Base MSRP premium or cost associated with selecting this powertrain configuration, in US dollars. May be zero for base powertrain or represent upgrade cost.',
    `payload_capacity_lbs` STRING COMMENT 'Maximum cargo and passenger weight capacity in pounds for this powertrain configuration. Critical for commercial and truck applications.',
    `powertrain_code` STRING COMMENT 'Manufacturer-assigned alphanumeric code uniquely identifying this powertrain configuration across all nameplates and model years. Used in ordering systems, BOMs, and production planning.. Valid values are `^[A-Z0-9]{6,12}$`',
    `powertrain_config_status` STRING COMMENT 'Current lifecycle status of this powertrain configuration in the product catalog. Active=currently orderable, Discontinued=no longer available, Planned=future introduction, Phase-out=being discontinued.. Valid values are `active|discontinued|planned|phase_out`',
    `powertrain_name` STRING COMMENT 'Customer-facing marketing name for the powertrain configuration (e.g., EcoBoost 2.0L Turbo, PowerMax V8, e-Drive Electric).',
    `powertrain_type` STRING COMMENT 'High-level classification of the powertrain architecture. ICE=Internal Combustion Engine, HEV=Hybrid Electric Vehicle, PHEV=Plug-in Hybrid Electric Vehicle, BEV=Battery Electric Vehicle, FCEV=Fuel Cell Electric Vehicle, MHEV=Mild Hybrid Electric Vehicle.. Valid values are `ICE|HEV|PHEV|BEV|FCEV|MHEV`',
    `start_of_production_date` DATE COMMENT 'Date when this powertrain configuration entered production and became available for vehicle assembly. Used for program planning and phase-in/phase-out management.',
    `towing_capacity_lbs` STRING COMMENT 'Maximum trailer weight rating in pounds that can be safely towed with this powertrain configuration when properly equipped.',
    `transmission_speeds` STRING COMMENT 'Number of forward gear ratios in the transmission. Null for CVT and single-speed transmissions.',
    `transmission_type` STRING COMMENT 'Type of transmission paired with this powertrain. CVT=Continuously Variable Transmission, DCT=Dual Clutch Transmission, AMT=Automated Manual Transmission. Single-speed common for BEVs.. Valid values are `manual|automatic|cvt|dct|amt|single_speed`',
    `warranty_battery_miles` STRING COMMENT 'Battery pack warranty coverage mileage limit for electric and plug-in hybrid powertrains. Null for pure ICE vehicles.',
    `warranty_battery_months` STRING COMMENT 'Battery pack warranty coverage period in months for electric and plug-in hybrid powertrains. Null for pure ICE vehicles.',
    `warranty_powertrain_miles` STRING COMMENT 'Standard powertrain warranty coverage mileage limit offered with this configuration. Warranty expires at earlier of months or miles.',
    `warranty_powertrain_months` STRING COMMENT 'Standard powertrain warranty coverage period in months offered with this configuration.',
    `wltp_city_range_km` STRING COMMENT 'WLTP-certified city driving range in kilometers for electric vehicles. Null if WLTP not applicable.',
    `wltp_combined_range_km` STRING COMMENT 'WLTP-certified combined driving range in kilometers for electric vehicles (BEV, PHEV electric-only mode). Used for European and international markets. Null if WLTP not applicable.',
    `zero_to_sixty_seconds` DECIMAL(18,2) COMMENT 'Manufacturer-tested acceleration time from 0 to 60 mph in seconds. Key performance metric for marketing and competitive positioning.',
    CONSTRAINT pk_powertrain_config PRIMARY KEY(`powertrain_config_id`)
) COMMENT 'Commercial powertrain configuration catalog defining the orderable powertrain combinations available for each nameplate and MY. Captures powertrain code, engine displacement, cylinder count, fuel type (gasoline/diesel/hybrid/PHEV/BEV/FCEV), electric motor configuration (for EV/HEV/PHEV), combined horsepower, combined torque, transmission type, EPA fuel economy rating (city/highway/combined), WLTP range (for EVs), battery capacity (kWh for EVs), and emissions classification. Distinct from engineering powertrain design data — this is the commercial specification layer.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`body_style` (
    `body_style_id` BIGINT COMMENT 'Unique identifier for the body style definition. Primary key for the body style reference catalog.',
    `aerodynamic_profile` STRING COMMENT 'Classification of the body styles aerodynamic characteristics. Influences fuel economy, NVH performance, and powertrain calibration. Used in CFD analysis and performance modeling.. Valid values are `low_drag|standard|high_profile|utility`',
    `bed_length_inches` DECIMAL(18,2) COMMENT 'Length of the cargo bed for pickup truck body styles, measured in inches. Critical specification for commercial and fleet customers. Null for non-pickup body styles.',
    `bed_type` STRING COMMENT 'Classification of pickup truck bed length category. Used in SKU construction and customer filtering. Set to not_applicable for non-pickup body styles.. Valid values are `short|standard|long|extra_long|not_applicable`',
    `body_structure_type` STRING COMMENT 'Fundamental structural architecture of the vehicle body (unibody vs body-on-frame). Determines manufacturing process, crash performance, NVH characteristics, and platform engineering decisions.. Valid values are `unibody|body_on_frame|space_frame|monocoque`',
    `body_style_category` STRING COMMENT 'High-level body style classification grouping similar configurations. Used for portfolio analysis, market segmentation, and regulatory reporting aggregation. [ENUM-REF-CANDIDATE: sedan|coupe|hatchback|wagon|suv|crossover|pickup|van|convertible|roadster — 10 candidates stripped; promote to reference product]',
    `body_style_code` STRING COMMENT 'Standardized alphanumeric code representing the body style (e.g., 2DR, 4DR, CREW, EXT, SUV3). Used in SKU construction, order management systems, and regulatory homologation documentation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `body_style_description` STRING COMMENT 'Detailed description of the body style including design characteristics, intended use case, and distinguishing features. Supports product marketing and customer education.',
    `body_style_name` STRING COMMENT 'Human-readable name of the body style (e.g., 2-Door Coupe, 4-Door Sedan, Crew Cab Pickup, Extended Cab, SUV 3-Row, Cargo Van). Used in marketing materials, dealer systems, and customer-facing documentation.',
    `body_style_status` STRING COMMENT 'Current lifecycle status of the body style definition. Active indicates current production availability. Used for SKU validation and order management system filtering.. Valid values are `active|discontinued|planned|concept|archived`',
    `cab_configuration` STRING COMMENT 'Pickup truck cab style classification (regular cab, extended cab, crew cab, mega cab). Determines seating capacity and interior space. Set to not_applicable for non-pickup body styles.. Valid values are `regular|extended|crew|mega|not_applicable`',
    `cargo_volume_cubic_feet` DECIMAL(18,2) COMMENT 'Total cargo volume capacity in cubic feet for North American market specifications. Derived from liters but maintained separately for regional marketing and regulatory requirements.',
    `cargo_volume_liters` DECIMAL(18,2) COMMENT 'Total cargo volume capacity in liters measured according to SAE standards. Critical specification for commercial vehicles, SUVs, and vans. Used in competitive analysis and customer decision-making.',
    `competitive_set` STRING COMMENT 'List of primary competitor vehicles that this body style competes against in the market. Used for benchmarking, feature parity analysis, and pricing strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this body style record was first created in the system. Used for audit trail and data lineage tracking.',
    `door_count` STRING COMMENT 'Number of passenger doors on the vehicle body style. Critical for regulatory classification, insurance rating, and customer preference filtering. Excludes trunk/hatch/tailgate.',
    `end_model_year` STRING COMMENT 'Final model year this body style was available. Null for current production body styles. Used for EOP planning and service parts forecasting.',
    `generation` STRING COMMENT 'Generation or version identifier for the body style design. Tracks major redesigns and facelifts. Used in parts interchangeability analysis and service documentation.. Valid values are `^[A-Z0-9]{1,6}$`',
    `ground_clearance_category` STRING COMMENT 'Classification of ride height and ground clearance relative to segment norms. Impacts off-road capability, entry/exit ergonomics, and suspension tuning.. Valid values are `low|standard|raised|high`',
    `homologation_class` STRING COMMENT 'Regulatory vehicle classification code used for type approval and homologation processes. Varies by jurisdiction (UNECE, EPA, CARB). Critical for compliance and market entry.',
    `is_commercial_vehicle` BOOLEAN COMMENT 'Indicates whether this body style is classified as a commercial vehicle for regulatory, tax, and fleet sales purposes. Impacts CAFE exemptions and depreciation schedules.',
    `is_light_truck` BOOLEAN COMMENT 'Indicates whether this body style is classified as a light truck for CAFE and EPA emissions standards. Impacts fuel economy requirements and regulatory compliance strategy.',
    `is_passenger_vehicle` BOOLEAN COMMENT 'Indicates whether this body style is classified as a passenger vehicle for regulatory and safety standard purposes. Determines applicable FMVSS requirements.',
    `manufacturing_complexity_score` STRING COMMENT 'Relative complexity rating (1-10 scale) for manufacturing this body style. Considers stamping complexity, welding operations, assembly sequence, and quality control requirements. Used in capacity planning and cost estimation.',
    `market_availability` STRING COMMENT 'Geographic market regions where this body style is available for sale. Supports regional product portfolio management and market-specific homologation tracking. [ENUM-REF-CANDIDATE: global|north_america|europe|asia_pacific|china|latin_america|middle_east|africa — 8 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this body style record. Supports audit requirements and change management tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this body style record was last modified. Used for change tracking and data synchronization across systems.',
    `msrp_base_usd` DECIMAL(18,2) COMMENT 'Base MSRP for this body style in US dollars, excluding options, packages, and destination charges. Used for pricing strategy, competitive analysis, and dealer quoting systems. Confidential business data.',
    `ncap_body_type` STRING COMMENT 'Body type classification used in NCAP safety testing and rating protocols. Determines applicable crash test procedures and rating methodology.',
    `platform_code` STRING COMMENT 'Engineering platform identifier that this body style is built upon. Links to platform architecture, shared components, and engineering BOM. Critical for PLM integration and variant management.. Valid values are `^[A-Z0-9]{2,8}$`',
    `roof_type` STRING COMMENT 'Classification of the roof structure and configuration. Impacts aerodynamics, structural engineering, manufacturing complexity, and customer appeal. Critical for BOM planning and option package definition. [ENUM-REF-CANDIDATE: fixed|convertible|targa|t-top|removable_panel|sunroof|panoramic — 7 candidates stripped; promote to reference product]',
    `seating_capacity` STRING COMMENT 'Maximum number of passenger seating positions designed into the body style. Used for regulatory compliance (CAFE standards), safety rating (NCAP), and customer filtering in configurators.',
    `seating_row_count` STRING COMMENT 'Number of seating rows in the body style (e.g., 2-row, 3-row). Important for SUV and crossover segmentation and customer preference analysis.',
    `sku_prefix` STRING COMMENT 'Standard prefix used in SKU construction for vehicles with this body style. Ensures consistent SKU formatting across order management, inventory, and dealer systems.. Valid values are `^[A-Z0-9]{2,6}$`',
    `source_system` STRING COMMENT 'System of record that is the authoritative source for this body style definition (PLM for engineering data, ERP for commercial data, MDM for master reference). Used for data lineage and reconciliation.. Valid values are `PLM|ERP|MDM|MANUAL`',
    `start_model_year` STRING COMMENT 'First model year this body style was introduced into production. Used for historical analysis, parts supersession, and product lifecycle tracking.',
    `target_customer_segment` STRING COMMENT 'Primary customer demographic or psychographic segment this body style is designed to appeal to. Used in marketing strategy, feature prioritization, and portfolio positioning.',
    `vehicle_segment` STRING COMMENT 'Market segment classification for the body style. Used for competitive benchmarking, CAFE compliance planning, pricing strategy, and portfolio management. Aligns with industry-standard segmentation. [ENUM-REF-CANDIDATE: subcompact|compact|midsize|fullsize|luxury|sports|suv_compact|suv_midsize|suv_fullsize|pickup_compact|pickup_fullsize|van_cargo|van_passenger|commercial — 14 candidates stripped; promote to reference product]',
    `wheelbase_category` STRING COMMENT 'Classification of wheelbase length relative to the nameplate family. Impacts ride quality, cargo capacity, and maneuverability. Used in platform engineering and variant planning.. Valid values are `short|standard|long|extended`',
    `created_by` STRING COMMENT 'User identifier or system account that created this body style record. Supports audit requirements and data stewardship accountability.',
    CONSTRAINT pk_body_style PRIMARY KEY(`body_style_id`)
) COMMENT 'Reference catalog of commercial body style definitions available across nameplates (e.g., 2-door coupe, 4-door sedan, crew cab pickup, extended cab, SUV 3-row, cargo van). Captures body style code, body style name, door count, seating capacity, cargo volume, roof type, body structure classification (unibody/body-on-frame), and applicable vehicle segment. Used in SKU construction, order management, and regulatory homologation classification.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`color_option` (
    `color_option_id` BIGINT COMMENT 'Unique identifier for the color option. Primary key for the color option catalog.',
    `color_availability_status` STRING COMMENT 'Current lifecycle status of the color option. Controls visibility in configurators, order acceptance, and production scheduling. Phase-out colors may have restricted order windows.. Valid values are `active|discontinued|limited_availability|pre_launch|phase_out`',
    `color_code` STRING COMMENT 'Manufacturer-assigned alphanumeric code uniquely identifying the color option. Used in Bill of Materials (BOM), production scheduling, and order management systems. Examples: WP9, B3Q, NH731P.. Valid values are `^[A-Z0-9]{3,10}$`',
    `color_description` STRING COMMENT 'Detailed marketing description of the color option including visual characteristics, finish effects, and brand positioning. Used in sales literature, website content, and dealer training materials.',
    `color_durability_rating` STRING COMMENT 'Qualitative assessment of color fade resistance and durability based on accelerated weathering tests. Influences warranty terms and customer expectations for long-term appearance retention.. Valid values are `standard|enhanced|premium`',
    `color_family` STRING COMMENT 'Broad color category grouping for reporting, inventory management, and market analysis. Enables aggregation of similar colors across model years and nameplates. [ENUM-REF-CANDIDATE: white|black|gray|silver|red|blue|green|brown|beige|yellow|orange|other — 12 candidates stripped; promote to reference product]',
    `color_image_url` STRING COMMENT 'Uniform Resource Locator (URL) to the digital asset management system hosting the color swatch or vehicle image in this color. Used in online configurators, mobile apps, and dealer portals.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `color_match_tolerance` STRING COMMENT 'Acceptable color variation tolerance expressed in Delta E (ΔE) units or manufacturer-specific scale. Used in quality control, paint booth calibration, and supplier acceptance criteria.',
    `color_name` STRING COMMENT 'Marketing name of the color option as presented to customers and dealers. Examples: Arctic White, Midnight Black, Crimson Red, Graphite Metallic.',
    `color_type` STRING COMMENT 'Classification indicating whether the color option applies to exterior paint, interior trim/upholstery, or both. Determines applicability in vehicle configuration.. Valid values are `exterior|interior|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this color option record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP uplift amount. Supports multi-currency pricing across global markets.. Valid values are `^[A-Z]{3}$`',
    `end_of_production_date` DATE COMMENT 'Date when this color option is discontinued from production. Nullable for ongoing colors. Used to manage phase-out inventory and dealer order cutoff dates.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this color option meets all applicable environmental regulations including Volatile Organic Compound (VOC) limits, REACH, and RoHS directives. Required for regulatory reporting and market certification.',
    `historical_sales_volume` STRING COMMENT 'Cumulative number of vehicles sold with this color option across all model years and nameplates. Used for demand forecasting, inventory planning, and portfolio optimization. Confidential business metric.',
    `interior_material_type` STRING COMMENT 'Material composition for interior color options. Applicable only when color_type is interior or both. Drives Bill of Materials (BOM) component selection and supplier sourcing. [ENUM-REF-CANDIDATE: cloth|leather|synthetic_leather|premium_leather|alcantara|vinyl|suede|not_applicable — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this color option record was last updated. Supports change tracking, data quality monitoring, and synchronization with downstream systems.',
    `lead_time_days` STRING COMMENT 'Additional production lead time in days required for this color option beyond standard build cycle. Used in order promising and delivery date calculation.',
    `marketing_priority_rank` STRING COMMENT 'Relative priority ranking for marketing and promotional activities. Lower numbers indicate higher priority. Used to determine featured colors in advertising, configurator defaults, and showroom displays.',
    `model_year` STRING COMMENT 'Model year for which this color option is available. Enables year-over-year color portfolio management and historical analysis. Format: YYYY.',
    `msrp_uplift_amount` DECIMAL(18,2) COMMENT 'Additional charge in base currency for selecting this color option above the standard color. Zero for no-charge colors. Used in pricing configuration and dealer quotation systems.',
    `package_compatibility` STRING COMMENT 'Comma-separated list of option package codes that are compatible or required with this color option. Supports complex configuration dependencies and upsell strategies.',
    `paint_code_supplier` STRING COMMENT 'Supplier-specific paint code or formula reference used in procurement and quality control. Links to supplier master data and Production Part Approval Process (PPAP) documentation.',
    `paint_technology` STRING COMMENT 'Paint finish technology and application method. Impacts manufacturing process complexity, cost, and visual appearance. Tri-coat and multi-stage finishes require additional production steps.. Valid values are `solid|metallic|pearl|matte|tri-coat|multi-stage`',
    `production_cost_delta` DECIMAL(18,2) COMMENT 'Incremental manufacturing cost for this color option compared to base color. Used in margin analysis, Total Cost of Ownership (TCO) calculations, and profitability reporting. Confidential business data.',
    `regional_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or region codes where this color option is offered. Supports market-specific color strategies and regulatory compliance. Example: USA,CAN,MEX or EMEA.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record that originated this color option data. Examples: SAP_PLM, Teamcenter, CATIA. Enables data lineage and reconciliation across enterprise systems.',
    `special_order_flag` BOOLEAN COMMENT 'Indicates whether this color option requires special order processing with extended lead times. True for low-volume or custom colors not stocked in standard production flow.',
    `start_of_production_date` DATE COMMENT 'Date when this color option becomes available for production scheduling and vehicle assembly. Aligns with manufacturing readiness and supplier qualification milestones.',
    `touch_up_paint_available_flag` BOOLEAN COMMENT 'Indicates whether touch-up paint kits are available through after-sales parts channels for this color option. Supports service operations and customer self-repair.',
    `trim_level_compatibility` STRING COMMENT 'Comma-separated list of trim level codes or names for which this color option is available. Enforces configuration rules in order management and prevents invalid SKU (Stock Keeping Unit) combinations.',
    `voc_content_grams_per_liter` DECIMAL(18,2) COMMENT 'Volatile Organic Compound content measured in grams per liter for paint formulation. Required for Environmental Protection Agency (EPA) and California Air Resources Board (CARB) compliance reporting.',
    CONSTRAINT pk_color_option PRIMARY KEY(`color_option_id`)
) COMMENT 'Commercial color catalog defining all available exterior paint colors and interior color/material combinations offered across model year programs. Captures color code, color name, color type (exterior/interior), color family, paint technology (solid/metallic/pearl/matte), interior material type (cloth/leather/synthetic/premium), availability by trim level, MSRP uplift (for premium colors), regional availability, and active/discontinued status. Used in SKU configuration, order management, and production scheduling.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`program_milestone` (
    `program_milestone_id` BIGINT COMMENT 'Unique identifier for the program milestone record. Primary key for the program milestone entity.',
    `aftersales_model_year_program_id` BIGINT COMMENT 'Reference to the parent MY (Model Year) program to which this milestone belongs. Links to the program master entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or program manager accountable for delivering this milestone. Links to workforce/employee master data.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (brand/model) associated with this program milestone. Links to nameplate master data in the product domain.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant where this milestone applies. Relevant for production-related milestones (SOP, Job 1, EOP). Null for program-level milestones. Links to plant master data.',
    `predecessor_milestone_program_milestone_id` BIGINT COMMENT 'Reference to the immediately preceding milestone that must be achieved before this milestone can begin. Null for the first milestone in the program sequence. Enables critical path analysis.',
    `responsible_person_employee_id` BIGINT COMMENT 'Reference to the employee or program manager accountable for delivering this milestone. Links to workforce/employee master data.',
    `actual_date` DATE COMMENT 'Actual date the milestone was achieved. Populated when milestone_status transitions to achieved. Used for variance analysis and lessons learned.',
    `baseline_date` DATE COMMENT 'Approved baseline date after program approval or re-baseline. Used as the official target for performance measurement and variance calculation.',
    `budget_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (in base currency) if this milestone is delayed. Used for prioritization and executive escalation. Null if no quantified impact.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of work completed toward achieving this milestone (0.00 to 100.00). Updated during program reviews. 100.00 when milestone_status is achieved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system. Audit trail for data lineage.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the program critical path. True if any delay to this milestone will delay the overall program SOP date. Used for prioritization and risk management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget_impact_amount (e.g., USD, EUR, JPY). Null if budget_impact_amount is null.. Valid values are `^[A-Z]{3}$`',
    `deliverable_completed_count` STRING COMMENT 'Number of deliverables that have been completed and approved. Used to calculate completion_percentage and assess readiness for gate review.',
    `deliverable_count` STRING COMMENT 'Number of formal deliverables (documents, approvals, test results) required to achieve this milestone. Used to track completion progress.',
    `external_dependency_description` STRING COMMENT 'Description of external dependencies, including supplier names, partner organizations, or regulatory agencies. Null if external_dependency_flag is false.',
    `external_dependency_flag` BOOLEAN COMMENT 'Indicates whether this milestone depends on external parties (suppliers, partners, regulatory agencies) for completion. True if external coordination required, false if fully internal.',
    `forecast_date` DATE COMMENT 'Current forecast date for milestone achievement based on latest program status. Updated regularly during program reviews. Null if milestone already achieved.',
    `gate_review_comments` STRING COMMENT 'Executive comments, conditions, or action items resulting from the gate review meeting. Captures key decisions and follow-up requirements.',
    `gate_review_date` DATE COMMENT 'Date the formal gate review meeting was held. Null if gate_review_required is false or review not yet conducted.',
    `gate_review_outcome` STRING COMMENT 'Result of the formal gate review meeting: approved (proceed to next phase), approved_with_conditions (proceed with action items), deferred (reschedule review), rejected (do not proceed). Null if gate_review_required is false or review not yet held.. Valid values are `approved|approved_with_conditions|deferred|rejected`',
    `gate_review_required` BOOLEAN COMMENT 'Indicates whether a formal gate review (executive approval meeting) is required before this milestone can be marked as achieved. True for major program gates (e.g., Program Approval, SOP), false for intermediate checkpoints.',
    `milestone_code` STRING COMMENT 'Standardized code identifying the milestone type (e.g., PROG_APPR, DESIGN_FREEZE, PPAP_COMP, SOP, JOB1, EOP). Used for system integration and reporting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `milestone_name` STRING COMMENT 'Human-readable name of the milestone (e.g., Program Approval, Design Freeze, PPAP Completion, Start of Production, Job 1, End of Production).',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone: pending (not started), in_progress (activities underway), achieved (completed on time), delayed (missed target), waived (skipped by exception), cancelled (no longer required).. Valid values are `pending|in_progress|achieved|delayed|waived|cancelled`',
    `milestone_type` STRING COMMENT 'Classification of the milestone by functional category: program_gate (strategic approval), design_gate (engineering freeze), quality_gate (PPAP/APQP), production_gate (SOP/EOP), regulatory_gate (homologation), commercial_gate (launch readiness).. Valid values are `program_gate|design_gate|quality_gate|production_gate|regulatory_gate|commercial_gate`',
    `mitigation_plan` STRING COMMENT 'Action plan to address identified risks and recover schedule. Includes specific actions, owners, and target dates. Null if risk_level is low.',
    `model_year` STRING COMMENT 'Model Year for which this program milestone applies (e.g., 2024, 2025). Aligns with automotive industry MY planning cycles.',
    `modified_by` STRING COMMENT 'User ID or system account that last modified this milestone record. Audit trail for data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last updated. Audit trail for change tracking.',
    `notes` STRING COMMENT 'Additional notes, context, or historical information about this milestone. Free-text field for program team collaboration.',
    `planned_date` DATE COMMENT 'Originally planned target date for achieving this milestone, as defined in the program master schedule. Baseline for variance tracking.',
    `program_phase` STRING COMMENT 'High-level program phase in which this milestone occurs: concept (initial planning), design (engineering), development (prototyping), validation (testing/PPAP), launch (SOP/Job 1), production (volume ramp), end_of_life (EOP). [ENUM-REF-CANDIDATE: concept|design|development|validation|launch|production|end_of_life — 7 candidates stripped; promote to reference product]',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body requiring this milestone (e.g., NHTSA, EPA, Euro NCAP, CARB, UNECE). Null if regulatory_requirement_flag is false.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this milestone is driven by regulatory or homologation requirements (e.g., NHTSA, EPA, Euro NCAP, WLTP certification). True for regulatory gates, false for internal program milestones.',
    `responsible_function` STRING COMMENT 'Primary functional organization accountable for achieving this milestone: engineering (design/CAE), manufacturing (plant readiness), quality (PPAP/APQP), supply_chain (supplier readiness), regulatory (homologation), commercial (launch), program_management (gate reviews). [ENUM-REF-CANDIDATE: engineering|manufacturing|quality|supply_chain|regulatory|commercial|program_management — 7 candidates stripped; promote to reference product]',
    `risk_description` STRING COMMENT 'Detailed description of risks, issues, or blockers that may prevent timely achievement of this milestone. Updated during program status reviews.',
    `risk_level` STRING COMMENT 'Current risk assessment for achieving this milestone on time: low (on track, no issues), medium (minor concerns), high (significant risk of delay), critical (delay highly likely or already occurred).. Valid values are `low|medium|high|critical`',
    `variance_days` STRING COMMENT 'Number of calendar days between baseline_date and actual_date. Positive values indicate delay, negative values indicate early completion. Null if milestone not yet achieved.',
    `waiver_approved_by` BIGINT COMMENT 'Reference to the executive who approved the milestone waiver. Links to workforce/employee master data. Null if milestone not waived.',
    `waiver_approved_date` DATE COMMENT 'Date the milestone waiver was formally approved. Null if milestone not waived.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving this milestone. Populated when milestone_status is set to waived. Requires executive approval.',
    `created_by` STRING COMMENT 'User ID or system account that created this milestone record. Audit trail for data governance.',
    CONSTRAINT pk_program_milestone PRIMARY KEY(`program_milestone_id`)
) COMMENT 'Tracks key program milestones and gate reviews for each MY program (e.g., Program Approval, Design Freeze, PPAP completion, SOP, Job 1, EOP). Captures milestone type, planned date, actual date, milestone status (pending/achieved/delayed/waived), responsible function, gate review outcome, and variance days. Enables program management tracking, cross-functional alignment, and executive reporting on program health.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` (
    `product_engineering_change_id` BIGINT COMMENT 'Unique identifier for the product_engineering_change data product (auto-inserted pre-linking).',
    `aftersales_model_year_program_id` BIGINT COMMENT 'Foreign key linking to product.model_year_program. Business justification: Engineering changes are scoped to a model year program; linking provides traceability and prevents orphan change records.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Engineering change requests need the responsible engineer employee for traceability in change management system.',
    CONSTRAINT pk_product_engineering_change PRIMARY KEY(`product_engineering_change_id`)
) COMMENT 'Commercial product domain record of engineering changes (ECNs/ECOs) that impact the commercial product catalog — affecting BOM structures, SKU configurations, option availability, or MSRP pricing. Captures change request number, change type (cost reduction/quality improvement/regulatory/customer-driven), affected SKUs and BOM lines, effective MY and date, commercial impact assessment (price change/feature change/availability change), approval status, and Teamcenter PLM reference. Distinct from the engineering domains full ECN lifecycle — this is the commercial impact view.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`option_constraint` (
    `option_constraint_id` BIGINT COMMENT 'Unique identifier for the option constraint rule. Primary key.',
    `aftersales_option_package_id` BIGINT COMMENT 'Reference to the option or package that triggers this constraint rule. The if side of the constraint logic.',
    `aftersales_trim_level_id` BIGINT COMMENT 'Reference to the specific trim level to which this constraint applies. Nullable if constraint applies across all trims for the nameplate/MY.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (brand/model family) to which this constraint applies.',
    `primary_aftersales_option_package_id` BIGINT COMMENT 'Reference to the option or package that triggers this constraint rule. The if side of the constraint logic.',
    `target_option_aftersales_option_package_id` BIGINT COMMENT 'Reference to the option or package that is affected by this constraint rule. The then side of the constraint logic.',
    `target_option_option_package_aftersales_option_package_id` BIGINT COMMENT 'Reference to the option or package that is affected by this constraint rule. The then side of the constraint logic.',
    `applies_to_fleet` BOOLEAN COMMENT 'Indicates whether this constraint applies to fleet orders. Some constraints are relaxed or different for high-volume fleet customers.',
    `applies_to_retail` BOOLEAN COMMENT 'Indicates whether this constraint applies to retail customer orders through dealer networks.',
    `approval_status` STRING COMMENT 'Workflow approval status for this constraint rule. Only approved constraints are activated in production ordering systems.. Valid values are `draft|pending_review|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this constraint rule was approved for production use.',
    `approved_by` STRING COMMENT 'User identifier or name of the product manager or engineering lead who approved this constraint for production use.',
    `bom_impact` STRING COMMENT 'Indicates the severity of Bill of Materials changes triggered by this constraint. Critical impacts may require PPAP or APQP review.. Valid values are `none|minor|major|critical`',
    `change_request_number` STRING COMMENT 'Reference to the Engineering Change Request or Product Change Notice that authorized the creation or modification of this constraint.',
    `configurator_display_order` STRING COMMENT 'Numeric sequence controlling the order in which constraint messages are displayed in consumer and dealer configurators.',
    `constraint_code` STRING COMMENT 'Business-readable code identifying this constraint rule, often used in dealer ordering systems and configurators.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `constraint_description` STRING COMMENT 'Detailed business explanation of why this constraint exists, including engineering, regulatory, or commercial rationale.',
    `constraint_priority` STRING COMMENT 'Numeric priority for resolving conflicts when multiple constraints apply to the same option combination. Lower numbers indicate higher priority.',
    `constraint_source` STRING COMMENT 'The business function or domain that originated this constraint rule (e.g., engineering for technical incompatibility, regulatory for compliance, commercial for pricing strategy).. Valid values are `engineering|regulatory|commercial|manufacturing|supply_chain`',
    `constraint_status` STRING COMMENT 'Current lifecycle status of the constraint rule. Active constraints are enforced in ordering systems; inactive/deprecated constraints are retained for historical reference.. Valid values are `active|inactive|pending|deprecated|superseded`',
    `constraint_type` STRING COMMENT 'The type of constraint relationship: requires (source option mandates target), excludes (source option prohibits target), includes (source option automatically bundles target), upgrades (source option supersedes target), replaces (source option substitutes target), prerequisite (target requires source to be selected first).. Valid values are `requires|excludes|includes|upgrades|replaces|prerequisite`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this constraint record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which this constraint rule becomes active and enforceable in dealer ordering and consumer configurator systems.',
    `error_message` STRING COMMENT 'User-facing error or warning message displayed in dealer ordering systems or consumer configurators when this constraint is violated.',
    `expiration_date` DATE COMMENT 'The date after which this constraint rule is no longer active. Nullable for constraints with indefinite validity.',
    `fmea_reference` STRING COMMENT 'Reference identifier to the FMEA document that analyzed the risk associated with this option constraint.',
    `homologation_region` STRING COMMENT 'Regulatory region code (e.g., EPA, CARB, EURO6, UNECE) for which this constraint is applicable. Some option combinations are prohibited or required by regional emissions or safety standards.. Valid values are `^[A-Z]{2,10}$`',
    `is_hard_constraint` BOOLEAN COMMENT 'Indicates whether this is a hard constraint (cannot be violated under any circumstances) or a soft constraint (generates warning but can be overridden).',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this constraint rule.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this constraint record.',
    `lead_time_impact_days` STRING COMMENT 'The number of additional production days required when this constraint is triggered, impacting On-Time Delivery (OTD) commitments.',
    `manufacturing_complexity_score` STRING COMMENT 'Numeric score (1-10) indicating the manufacturing complexity introduced by this constraint. Higher scores may impact production scheduling and Just-in-Sequence (JIS) logistics.',
    `market_code` STRING COMMENT 'Three-letter ISO country or regional market code indicating where this constraint applies. Constraints may vary by market due to regulatory or feature availability differences.. Valid values are `^[A-Z]{3}$`',
    `model_year` STRING COMMENT 'The model year for which this option constraint is applicable. Constraints may vary by MY due to engineering changes or regulatory updates.',
    `msrp_impact_amount` DECIMAL(18,2) COMMENT 'The incremental MSRP change (positive or negative) resulting from this constraint being applied. Used for dynamic pricing in configurators.',
    `msrp_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the MSRP impact amount.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or historical notes about this constraint rule.',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether authorized users (e.g., fleet sales managers, product planners) can override this constraint in special circumstances.',
    `override_approval_level` STRING COMMENT 'The minimum authorization level required to override this constraint, if override_allowed is true.. Valid values are `none|dealer_manager|regional_manager|oem_product_planner|oem_executive`',
    `ppap_required` BOOLEAN COMMENT 'Indicates whether this constraint triggers a PPAP requirement due to significant engineering or supplier changes.',
    `supplier_constraint` BOOLEAN COMMENT 'Indicates whether this constraint is driven by supplier capacity, tooling, or material availability limitations.',
    `created_by` STRING COMMENT 'User identifier or name of the product planner, engineer, or system administrator who created this constraint rule.',
    CONSTRAINT pk_option_constraint PRIMARY KEY(`option_constraint_id`)
) COMMENT 'Defines the business rules governing option and package compatibility — which options require, exclude, or are included with other options on a given trim level and MY. Captures constraint type (requires/excludes/includes/upgrades), source option/package, target option/package, applicable trim levels, applicable markets, effective date range, and constraint priority. Enforces valid vehicle configurations in dealer ordering systems and consumer configurators, preventing invalid build combinations.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`fleet_spec` (
    `fleet_spec_id` BIGINT COMMENT 'Unique identifier for the fleet specification record. Primary key.',
    `account_manager_employee_id` BIGINT COMMENT 'Reference to the sales or account manager responsible for this fleet specification and customer relationship. Primary point of contact for commercial and operational matters.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fleet specification contracts are budgeted to a dedicated cost_center for tracking fleet‑specific expenses.',
    `customer_fleet_account_id` BIGINT COMMENT 'Reference to the fleet customer organization that this specification was negotiated for. Links to customer master data and account management.',
    `employee_id` BIGINT COMMENT 'Reference to the sales or account manager responsible for this fleet specification and customer relationship. Primary point of contact for commercial and operational matters.',
    `fleet_customer_customer_fleet_account_id` BIGINT COMMENT 'Reference to the fleet customer organization that this specification was negotiated for. Links to customer master data and account management.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (model line) that this fleet specification is based on.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fleet profitability (net price, discounts) is measured via a profit_center linked to each fleet_spec.',
    `actual_volume_ytd` STRING COMMENT 'Actual number of units ordered or delivered under this fleet specification in the current fiscal year. Used to track performance against volume commitments.',
    `annual_volume_commitment` STRING COMMENT 'Number of units the fleet customer has committed to purchase annually under this specification. Drives production planning and supplier commitments.',
    `approved_option_packages` STRING COMMENT 'Comma-separated list of option package codes that are pre-approved for inclusion in this fleet specification. May include safety, technology, or utility packages negotiated at fleet pricing.',
    `approved_trim_levels` STRING COMMENT 'Comma-separated list of trim level codes that are approved for this fleet specification. Defines the range of configurations available to the fleet customer.',
    `contract_number` STRING COMMENT 'Reference to the master fleet sales agreement or contract under which this specification is governed. Links to legal and commercial terms.',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this fleet specification record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet specification record was first created in the system. Audit trail for record lifecycle.',
    `delivery_lead_time_days` STRING COMMENT 'Committed lead time in days from order placement to vehicle delivery for this fleet specification. Service level commitment tied to production scheduling and logistics.',
    `delivery_location_code` STRING COMMENT 'Code identifying the primary delivery location or distribution center for vehicles under this fleet specification. May reference a fleet customer facility or a designated delivery hub.',
    `distribution_channel_code` STRING COMMENT 'Code identifying the distribution channel through which vehicles under this fleet specification are sold. Fleet sales typically use a dedicated channel distinct from retail.',
    `effective_end_date` DATE COMMENT 'Date after which this fleet specification is no longer valid for new orders. May be extended through contract renewal or renegotiation.',
    `effective_start_date` DATE COMMENT 'Date from which this fleet specification becomes valid and can be used for order placement. Aligns with contract execution and product availability.',
    `emissions_standard` STRING COMMENT 'Emissions standard that vehicles under this fleet specification must comply with. Examples: EPA Tier 3, Euro 6d, CARB LEV III.',
    `fleet_customer_segment` STRING COMMENT 'Classification of the fleet customer type. Determines applicable pricing structures, compliance requirements, and service level agreements.. Valid values are `government|corporate|rental|utility|emergency_services|municipal`',
    `fleet_discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to the base MSRP for fleet orders. Confidential commercial term tied to volume commitments and customer segment.',
    `fleet_msrp_base` DECIMAL(18,2) COMMENT 'Base MSRP for the fleet specification before discounts and volume adjustments. Represents the starting price point for fleet negotiations.',
    `fleet_net_price` DECIMAL(18,2) COMMENT 'Final negotiated net price per unit after all discounts and adjustments. Confidential commercial term used for fleet order processing.',
    `fleet_priority_rank` STRING COMMENT 'Priority ranking for production scheduling and allocation when demand exceeds capacity. Higher priority fleet specs receive preferential treatment in build sequence planning.',
    `fleet_spec_code` STRING COMMENT 'Business identifier for the fleet specification, used in contracts and ordering systems. Unique alphanumeric code assigned to each negotiated fleet configuration.. Valid values are `^[A-Z0-9]{6,12}$`',
    `homologation_region` STRING COMMENT 'Three-letter ISO country code or region code indicating the regulatory homologation region for vehicles under this fleet specification. Determines emissions, safety, and certification requirements.. Valid values are `^[A-Z]{3}$`',
    `last_modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this fleet specification record. Audit trail for change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet specification record was last updated. Audit trail for change tracking and version control.',
    `maximum_order_quantity` STRING COMMENT 'Maximum number of units that can be ordered under this fleet specification within the contract period. Caps exposure and production allocation.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be ordered under this fleet specification to qualify for the negotiated pricing and terms. Enforces volume commitment.',
    `model_year` STRING COMMENT 'The model year for which this fleet specification is valid. Aligns with product lifecycle and homologation cycles.',
    `payment_terms_code` STRING COMMENT 'Code identifying the negotiated payment terms for this fleet specification. Examples: Net 30, Net 60, progress billing, lease arrangement.',
    `price_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all pricing fields in this fleet specification.. Valid values are `^[A-Z]{3}$`',
    `primary_use_case` STRING COMMENT 'Description of the primary operational use case for vehicles under this fleet specification. Examples: patrol vehicles, delivery vans, executive transport, utility service trucks.',
    `sales_organization_code` STRING COMMENT 'Code identifying the sales organization responsible for managing this fleet specification and customer relationship.',
    `service_contract_included_flag` BOOLEAN COMMENT 'Indicates whether a prepaid service or maintenance contract is included as part of this fleet specification. Common for government and corporate fleet agreements.',
    `spec_approval_status` STRING COMMENT 'Current lifecycle status of the fleet specification. Controls whether the spec can be used for order entry and production planning. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `spec_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or clarifications related to this fleet specification. May include operational guidance, customer preferences, or exception handling procedures.',
    `special_equipment_requirements` STRING COMMENT 'Description of any special equipment, upfitting, or modifications required for this fleet specification beyond standard options. May include emergency lighting, cargo racks, communication systems, or specialized tooling.',
    `warranty_program_code` STRING COMMENT 'Code identifying the warranty program applicable to this fleet specification. Fleet customers may have extended or customized warranty terms.',
    CONSTRAINT pk_fleet_spec PRIMARY KEY(`fleet_spec_id`)
) COMMENT 'Defines fleet-specific vehicle specifications and configurations negotiated for fleet customers (government, corporate, rental). Captures fleet spec code, fleet customer segment (government/corporate/rental/utility), applicable nameplate and MY, approved trim levels, approved option packages, fleet MSRP discount structure, minimum order quantity, delivery lead time commitment, and spec approval status. Distinct from retail SKU configurations — fleet specs represent negotiated commercial configurations with volume commitments.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`order_guide` (
    `order_guide_id` BIGINT COMMENT 'Unique identifier for the dealer order guide. Primary key for the order guide entity.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created this order guide record. Typically a product manager or sales operations analyst.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this order guide for publication. Typically a product manager or sales director with authority to release order guides.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this order guide record. Used for accountability and audit trail purposes.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (product line) that this order guide governs. Links to the nameplate master data.',
    `primary_order_employee_id` BIGINT COMMENT 'Identifier of the user who approved this order guide for publication. Typically a product manager or sales director with authority to release order guides.',
    `superseded_by_order_guide_id` BIGINT COMMENT 'Reference to the order guide that supersedes this one. Used to track order guide version history and guide dealers to the current version.',
    `tertiary_order_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this order guide record. Used for accountability and audit trail purposes.',
    `allocation_method` STRING COMMENT 'The method used to allocate vehicle inventory to dealers for this order guide. Determines how production capacity is distributed across the dealer network.. Valid values are `turn_and_earn|historical_sales|market_share|equal_distribution|custom`',
    `approval_status` STRING COMMENT 'Approval workflow status indicating whether the order guide has been reviewed and approved by product management, pricing, and sales leadership.. Valid values are `not_submitted|pending_review|approved|rejected|conditional_approval`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the order guide was approved for publication. Critical for audit trail and compliance tracking.',
    `base_msrp_max` DECIMAL(18,2) COMMENT 'The maximum base MSRP across all orderable configurations in this order guide. Excludes options and packages. Used for pricing range communication.',
    `base_msrp_min` DECIMAL(18,2) COMMENT 'The minimum base MSRP across all orderable configurations in this order guide. Excludes options and packages. Used for pricing range communication.',
    `build_to_stock_flag` BOOLEAN COMMENT 'Indicates whether vehicles in this order guide are built to stock (for dealer inventory) versus build to order (for specific customer orders).',
    `cafe_compliance_flag` BOOLEAN COMMENT 'Indicates whether vehicles in this order guide contribute positively to the manufacturers CAFE compliance targets. Used for regulatory planning.',
    `color_option_count` STRING COMMENT 'The total number of exterior and interior color combinations available in this order guide. Used for configuration complexity tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order guide record was first created in the system. Part of the audit trail for order guide lifecycle tracking.',
    `dealer_invoice_discount_percentage` DECIMAL(18,2) COMMENT 'The standard discount percentage from MSRP to dealer invoice price for vehicles in this order guide. Confidential dealer pricing information.',
    `effective_end_date` DATE COMMENT 'The date after which this order guide is no longer valid for new orders. Nullable for open-ended order guides. Part of the order guide validity period.',
    `effective_start_date` DATE COMMENT 'The date from which this order guide becomes active and dealers can begin placing orders using this guide. Part of the order guide validity period.',
    `emissions_standard` STRING COMMENT 'The emissions standard that vehicles in this order guide are certified to meet. Critical for regulatory compliance and market eligibility.. Valid values are `EPA_TIER3|CARB_LEV3|EURO6|EURO7|CHINA6|BS6`',
    `fleet_eligible_flag` BOOLEAN COMMENT 'Indicates whether this order guide is available for fleet sales orders. Fleet orders may have different pricing, configurations, and lead times.',
    `homologation_region` STRING COMMENT 'The regulatory homologation standard that vehicles in this order guide comply with. Determines which markets the vehicles can be sold in. [ENUM-REF-CANDIDATE: FMVSS|ECE|CMVSS|ADR|GB|INMETRO|CCC — 7 candidates stripped; promote to reference product]',
    `incentive_program_eligible_flag` BOOLEAN COMMENT 'Indicates whether vehicles ordered through this order guide are eligible for manufacturer incentive programs (rebates, financing offers, lease programs).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this order guide record was last updated. Used for change tracking and synchronization with dealer systems.',
    `lead_time_days_max` STRING COMMENT 'The maximum number of days from order placement to vehicle delivery for the slowest configuration in this order guide. Used for dealer planning.',
    `lead_time_days_min` STRING COMMENT 'The minimum number of days from order placement to vehicle delivery for the fastest configuration in this order guide. Used for dealer planning.',
    `market_region` STRING COMMENT 'The geographic market or region for which this order guide is applicable. Uses ISO 3166-1 alpha-3 country codes. Determines which dealers can order from this guide. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|DEU|GBR|FRA|ITA|ESP|CHN|JPN|KOR|AUS|IND|RUS|ZAF — 16 candidates stripped; promote to reference product]',
    `maximum_order_quantity` STRING COMMENT 'The maximum number of units a dealer can order per submission. Used to prevent over-ordering and ensure fair allocation across dealer network.',
    `minimum_order_quantity` STRING COMMENT 'The minimum number of units a dealer must order per submission. Used to enforce minimum order thresholds for production efficiency.',
    `model_year` STRING COMMENT 'The model year for which this order guide is published. Represents the production year designation for vehicles, not the calendar year.',
    `msrp_currency_code` STRING COMMENT 'The currency in which MSRP pricing is expressed for this order guide. Uses ISO 4217 three-letter currency codes. [ENUM-REF-CANDIDATE: USD|CAD|MXN|EUR|GBP|JPY|CNY|AUD|BRL|INR — 10 candidates stripped; promote to reference product]',
    `option_package_count` STRING COMMENT 'The total number of option packages available in this order guide. Packages bundle multiple options together for simplified ordering.',
    `order_bank_close_date` DATE COMMENT 'The date when the order bank closes and dealers can no longer submit new orders for vehicles in this order guide. Used for production planning cutoff.',
    `order_bank_open_date` DATE COMMENT 'The date when the order bank opens and dealers can begin submitting orders for vehicles in this order guide. May differ from effective start date.',
    `order_guide_code` STRING COMMENT 'Business identifier for the order guide. Externally-known code used by dealers and sales channels to reference this specific order guide version.. Valid values are `^OG-[A-Z0-9]{6,12}$`',
    `order_guide_description` STRING COMMENT 'Detailed description of the order guide including key features, target market, ordering instructions, and any special conditions or restrictions.',
    `order_guide_name` STRING COMMENT 'Descriptive name of the order guide, typically including nameplate, model year, and market information for easy identification by dealers.',
    `order_guide_status` STRING COMMENT 'Current lifecycle status of the order guide. Controls whether dealers can place orders and whether the guide is visible in dealer systems. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|superseded|archived — 7 candidates stripped; promote to reference product]',
    `orderable_sku_count` STRING COMMENT 'The total number of unique SKUs (trim level and option combinations) that are orderable through this order guide. Used for complexity tracking.',
    `ordering_instructions_url` STRING COMMENT 'URL link to detailed ordering instructions, configuration rules, and dealer resources for this order guide. Hosted on dealer portal.. Valid values are `^https?://.*$`',
    `production_plant_code` STRING COMMENT 'The primary assembly plant code where vehicles in this order guide will be manufactured. Used for logistics and capacity planning.. Valid values are `^[A-Z0-9]{3,6}$`',
    `publication_date` DATE COMMENT 'The date when this order guide was published and made available to dealers through DMS systems and dealer portals.',
    `sales_channel` STRING COMMENT 'The sales channel for which this order guide is designed. Different channels may have different orderable configurations, pricing, and constraints.. Valid values are `retail|fleet|government|export|internal|demo`',
    `special_order_allowed_flag` BOOLEAN COMMENT 'Indicates whether dealers can place special orders for non-standard configurations not explicitly listed in the order guide. Requires additional approval.',
    `version_number` STRING COMMENT 'Version identifier for the order guide. Incremented when changes are made to orderable configurations, pricing, or availability. Format: major.minor (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_order_guide PRIMARY KEY(`order_guide_id`)
) COMMENT 'The formal dealer order guide defining which SKUs, trim levels, option packages, and colors are orderable by dealers for a given MY, market, and sales channel. Captures order guide version, effective date range, market/region, sales channel, orderable SKU list, option availability matrix, minimum/maximum order constraints, and order guide approval status. Published to dealer DMS systems and governs what dealers can order from the factory.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`homologation_variant` (
    `homologation_variant_id` BIGINT COMMENT 'Unique identifier for the homologation variant record. Primary key.',
    `aftersales_trim_level_id` BIGINT COMMENT 'Reference to the specific trim level or configuration within the nameplate that this homologation variant applies to. Nullable if variant applies to all trims.',
    `nameplate_id` BIGINT COMMENT 'Reference to the vehicle nameplate (model line) that this homologation variant applies to. Links to the nameplate master data.',
    `sku_id` BIGINT COMMENT 'Reference to the base commercial SKU that this homologation variant is derived from. Links to the product catalog SKU master.',
    `adas_level` STRING COMMENT 'SAE automation level for the ADAS (Advanced Driver Assistance Systems) features included in this homologation variant, ranging from Level 0 (no automation) to Level 5 (full automation).. Valid values are `Level 0|Level 1|Level 2|Level 3|Level 4|Level 5`',
    `approval_authority` STRING COMMENT 'Name of the government agency, regulatory body, or authorized technical service that issued the homologation approval. Examples include NHTSA, EPA, CARB, TÜV, or national transport ministries.',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority officially granted homologation approval for this variant. Format: yyyy-MM-dd.',
    `approval_number` STRING COMMENT 'Official approval or certification number issued by the regulatory authority upon successful homologation. This number is typically required for vehicle registration and sales in the target market.',
    `bom_impact_flag` BOOLEAN COMMENT 'Indicates whether this homologation variant requires changes to the base SKU Bill of Materials. True if BOM modifications are needed, False if only calibration or documentation changes are required.',
    `cafe_compliance_flag` BOOLEAN COMMENT 'Indicates whether this homologation variant is certified for CAFE (Corporate Average Fuel Economy) compliance in the United States market. Applicable to US market variants only.',
    `compliance_notes` STRING COMMENT 'Additional notes, comments, or special instructions related to regulatory compliance, testing requirements, or market-specific considerations for this homologation variant.',
    `cost_delta_amount` DECIMAL(18,2) COMMENT 'Incremental cost associated with implementing this homologation variant compared to the base SKU, including parts, labor, testing, and certification fees. Expressed in the currency specified in cost_delta_currency.',
    `cost_delta_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cost_delta_amount field.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this homologation variant record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_start_date` DATE COMMENT 'Date from which this homologation variant becomes valid and vehicles can be legally sold or registered in the target market. Format: yyyy-MM-dd.',
    `emissions_standard_target` STRING COMMENT 'Specific emissions standard or tier that this homologation variant is designed to meet, such as Euro 6d, EPA Tier 3, CARB LEV III, or China 6b.',
    `expiry_date` DATE COMMENT 'Date on which this homologation approval expires or becomes invalid, requiring renewal or re-certification. Nullable for approvals without expiration. Format: yyyy-MM-dd.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this homologation variant record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_time_days` STRING COMMENT 'Typical lead time in days required to obtain homologation approval for this variant from the date of submission to the regulatory authority.',
    `model_year` STRING COMMENT 'Model year designation for which this homologation variant is applicable. Aligns with the automotive industry model year convention.',
    `modification_description` STRING COMMENT 'Detailed description of the technical modifications, component changes, or configuration adjustments required to meet the target market regulatory requirements. May reference specific parts, calibrations, or design changes.',
    `modification_type` STRING COMMENT 'High-level classification of the type of modification required for homologation compliance, such as hardware changes, software updates, calibration adjustments, documentation updates, labeling changes, or additional testing.. Valid values are `Hardware|Software|Calibration|Documentation|Labeling|Testing`',
    `ncap_rating` STRING COMMENT 'Safety rating achieved by this homologation variant under the applicable NCAP (New Car Assessment Programme) testing protocol, such as Euro NCAP, US NCAP, or ANCAP. Typically expressed as a star rating or score.',
    `ota_capable_flag` BOOLEAN COMMENT 'Indicates whether this homologation variant includes OTA (Over-the-Air) update capability for software and firmware updates. Relevant for regulatory compliance with evolving software update requirements.',
    `powertrain_type` STRING COMMENT 'Type of powertrain for which this homologation variant is certified. ICE (Internal Combustion Engine), HEV (Hybrid Electric Vehicle), PHEV (Plug-in Hybrid Electric Vehicle), BEV (Battery Electric Vehicle), FCEV (Fuel Cell Electric Vehicle).. Valid values are `ICE|HEV|PHEV|BEV|FCEV`',
    `regulatory_category` STRING COMMENT 'Classification of the primary regulatory domain this variant addresses, such as safety standards, emissions controls, environmental compliance, or fuel economy requirements. [ENUM-REF-CANDIDATE: Safety|Emissions|Environmental|Fuel Economy|Crash Test|Lighting|Braking|Occupant Protection — 8 candidates stripped; promote to reference product]',
    `regulatory_standard` STRING COMMENT 'Primary regulatory standard or framework that this homologation variant must comply with. Examples include UNECE (United Nations Economic Commission for Europe), FMVSS (Federal Motor Vehicle Safety Standards), ADR (Australian Design Rules), CARB (California Air Resources Board). [ENUM-REF-CANDIDATE: UNECE|FMVSS|ADR|CARB|EPA|Euro NCAP|IATF 16949|ISO 14001 — 8 candidates stripped; promote to reference product]',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this homologation approval requires periodic renewal or re-certification. True if renewal is mandated by the regulatory authority, False if approval is perpetual or tied to model year.',
    `responsible_engineer` STRING COMMENT 'Name of the engineer or technical specialist responsible for managing the homologation process and regulatory compliance for this variant.',
    `source_system` STRING COMMENT 'Name of the source system or application from which this homologation variant record originated, such as PLM, ERP, or regulatory compliance management system.',
    `submission_date` DATE COMMENT 'Date on which the homologation application and supporting documentation were submitted to the regulatory authority for review. Format: yyyy-MM-dd.',
    `target_market_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code representing the target market or jurisdiction for which this homologation variant is certified.. Valid values are `^[A-Z]{2,3}$`',
    `target_region` STRING COMMENT 'Broader geographic region classification for the target market, used for regional compliance grouping and reporting.. Valid values are `North America|Europe|Asia Pacific|Latin America|Middle East|Africa`',
    `test_report_reference` STRING COMMENT 'Reference number or identifier for the official test report(s) submitted as part of the homologation application. Links to laboratory test results, crash test data, emissions testing, or other certification evidence.',
    `testing_laboratory` STRING COMMENT 'Name of the accredited testing laboratory or technical service that conducted the homologation testing and issued the test reports.',
    `variant_code` STRING COMMENT 'Unique alphanumeric code identifying this specific homologation variant within the product catalog. Used for internal tracking and cross-referencing with regulatory submissions.. Valid values are `^[A-Z0-9]{4,20}$`',
    `variant_name` STRING COMMENT 'Human-readable name or designation for this homologation variant, typically including market and regulatory standard identifiers.',
    `variant_status` STRING COMMENT 'Current lifecycle status of the homologation variant in the approval and production process. Tracks progression from initial submission through approval, active use, and eventual expiration or withdrawal. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Approved|Active|Suspended|Expired|Withdrawn|Rejected — 9 candidates stripped; promote to reference product]',
    `wltp_certified_flag` BOOLEAN COMMENT 'Indicates whether this homologation variant has been tested and certified under the WLTP (Worldwide Harmonised Light Vehicles Test Procedure) standard for fuel consumption and emissions.',
    CONSTRAINT pk_homologation_variant PRIMARY KEY(`homologation_variant_id`)
) COMMENT 'Defines market-specific homologation variants of a base SKU required to meet local regulatory standards (UNECE, FMVSS, ADR, etc.). Captures homologation variant code, base SKU reference, target market/country, regulatory standard (UNECE/FMVSS/ADR/CARB), required modification description, homologation approval number, approval authority, approval date, expiry date, and variant status. Bridges the commercial product catalog to the compliance domains regulatory approval records.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` (
    `product_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the product lifecycle event record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lifecycle event approvals must record the approving employee to satisfy regulatory audit trails and internal change control.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lifecycle events (e.g., recall, launch) trigger cost allocations; linking to cost_center enables event‑driven expense tracking.',
    `nameplate_id` BIGINT COMMENT 'Foreign key linking to product.nameplate. Business justification: Lifecycle events are tied to a nameplate; the FK anchors events to the correct product entity.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Recall and safety event notifications require linking each product lifecycle event to the affected customer party to generate regulatory compliance reports and direct communications.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit impact of lifecycle events is captured via profit_center to reflect margin changes in financial statements.',
    `actual_date` DATE COMMENT 'Actual date when the lifecycle event occurred, used for variance analysis against planned date.',
    `affected_entity_code` STRING COMMENT 'Business code or identifier of the affected entity (e.g., nameplate code, program code, SKU code) for human-readable reference and reporting.',
    `affected_entity_reference` BIGINT COMMENT 'Identifier of the specific product entity affected by this event. References the primary key of the entity type specified in affected_entity_type.',
    `affected_entity_type` STRING COMMENT 'Type of product entity affected by this lifecycle event (e.g., nameplate, model year program, SKU, trim level, platform, powertrain).. Valid values are `nameplate|model_year_program|sku|trim_level|platform|powertrain`',
    `announcement_date` DATE COMMENT 'Date when the lifecycle event was publicly or internally announced, which may differ from the actual event date.',
    `announcement_type` STRING COMMENT 'Classification of the event announcement scope: internal (company-only), public (press release), regulatory (mandatory filing), or confidential (restricted distribution).. Valid values are `internal|public|regulatory|confidential`',
    `approval_date` DATE COMMENT 'Date when the lifecycle event was formally approved by the required authority.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether executive or board approval was required for this lifecycle event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle event record was first created in the data platform.',
    `customer_communication_required_flag` BOOLEAN COMMENT 'Indicates whether direct customer communication or notification is required for this lifecycle event (e.g., for recalls, service campaigns, or discontinuations affecting existing owners).',
    `dealer_notification_date` DATE COMMENT 'Date when dealers were notified of this lifecycle event.',
    `dealer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether dealer network notification is required for this lifecycle event.',
    `engineering_change_number` STRING COMMENT 'Engineering Change Notice or Engineering Change Order number associated with this lifecycle event, if applicable.',
    `event_category` STRING COMMENT 'High-level categorization of the lifecycle event: milestone (key program achievement), phase gate (APQP gate), regulatory (compliance-driven), commercial (market-facing), or operational (internal process).. Valid values are `milestone|phase_gate|regulatory|commercial|operational`',
    `event_code` STRING COMMENT 'Standardized code identifying the type of lifecycle event (e.g., PROG_APPR, DSGN_FRZ, SOP, JOB1, MCR_ANN, EOP, DISC).. Valid values are `^[A-Z0-9_]{4,20}$`',
    `event_date` DATE COMMENT 'The calendar date on which the lifecycle event occurred or is scheduled to occur. This is the principal business event timestamp for this transaction.',
    `event_status` STRING COMMENT 'Current status of the lifecycle event: planned (scheduled but not confirmed), confirmed (approved and scheduled), completed (occurred), cancelled, or postponed.. Valid values are `planned|confirmed|completed|cancelled|postponed`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the lifecycle event was recorded or occurred, including time zone information.',
    `event_type` STRING COMMENT 'Business classification of the lifecycle event. Captures major milestones such as program approval, design freeze, Start of Production (SOP), Job 1 (first production unit), mid-cycle refresh announcement, End of Production (EOP), or nameplate discontinuation. [ENUM-REF-CANDIDATE: program_approval|design_freeze|sop|job_1|mid_cycle_refresh|eop|nameplate_discontinuation|phase_gate|homologation_approval|ppap_approval — 10 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of this lifecycle event in the specified currency (e.g., CapEx investment for SOP, cost savings from EOP, write-off for discontinuation).',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `impact_level` STRING COMMENT 'Business impact level of this lifecycle event on operations, supply chain, sales, and customer commitments.. Valid values are `critical|high|medium|low`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle event record was last updated in the data platform.',
    `market_region` STRING COMMENT 'Geographic market or region affected by this lifecycle event (e.g., North America, Europe, Asia-Pacific, Global).',
    `model_year` STRING COMMENT 'The model year associated with the affected product entity at the time of this lifecycle event.',
    `new_state` STRING COMMENT 'The lifecycle state or phase of the affected entity after this event (e.g., approved, frozen, in-production, discontinued). Represents the state transition resulting from this event.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context about this lifecycle event for audit trail and business reference.',
    `planned_date` DATE COMMENT 'Originally planned or target date for the lifecycle event, which may differ from the actual event date if the event was rescheduled.',
    `plant_code` STRING COMMENT 'Manufacturing plant or assembly facility code where the lifecycle event is relevant (e.g., for SOP or EOP events).',
    `platform_code` STRING COMMENT 'Vehicle platform or architecture code associated with the affected product entity.',
    `press_release_reference` STRING COMMENT 'Reference number, URL, or document identifier for the associated press release or public announcement, if applicable.',
    `prior_state` STRING COMMENT 'The lifecycle state or phase of the affected entity immediately before this event occurred (e.g., concept, development, pre-production, production, phase-out).',
    `production_volume_impact` STRING COMMENT 'Estimated change in production volume (units) resulting from this lifecycle event. Positive for ramp-up events, negative for phase-out or discontinuation.',
    `program_code` STRING COMMENT 'Internal program code or project identifier for the vehicle program associated with this lifecycle event.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason or driver for this lifecycle event (e.g., market demand, regulatory requirement, cost reduction, quality improvement, end of platform life).',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the business rationale, circumstances, or drivers behind this lifecycle event.',
    `regulatory_filing_reference` STRING COMMENT 'Reference to any regulatory filing or submission associated with this event (e.g., NHTSA recall notice, EPA certification, homologation approval number).',
    `source_record_reference` STRING COMMENT 'Unique identifier or key of this event record in the source system, used for traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name or code of the operational system that originated this lifecycle event record (e.g., Teamcenter PLM, SAP PP, Windchill, internal event management system).',
    `supplier_impact_count` STRING COMMENT 'Number of suppliers affected by this lifecycle event (e.g., new suppliers onboarded for SOP, suppliers phased out for EOP).',
    `triggering_authority` STRING COMMENT 'Name or identifier of the person, role, or organizational unit that authorized or triggered this lifecycle event (e.g., Chief Product Officer, Program Manager, Executive Committee).',
    `triggering_authority_reference` BIGINT COMMENT 'System identifier for the person or role that authorized this event, linking to employee or role master data.',
    `variance_days` STRING COMMENT 'Number of days between planned and actual event dates. Positive values indicate delay; negative values indicate early completion.',
    CONSTRAINT pk_product_lifecycle_event PRIMARY KEY(`product_lifecycle_event_id`)
) COMMENT 'Captures significant lifecycle state transitions for nameplates, model year programs, and SKUs (e.g., program approval, design freeze, SOP, Job 1, mid-cycle refresh announcement, EOP, nameplate discontinuation). Captures event type, affected entity type and ID, event date, prior state, new state, triggering authority, announcement type (internal/public), and associated press release or regulatory filing reference. Provides a complete audit trail of commercial product lifecycle decisions.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` (
    `aftersales_repair_order_id` BIGINT COMMENT 'Unique identifier for the repair_order data product (auto-inserted pre-linking).',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_change. Business justification: Repair orders must reference the engineering change that introduced the fix, enabling field impact tracking and change effectiveness reporting.',
    `connected_vehicle_id` BIGINT COMMENT 'Foreign key linking to mobility.connected_vehicle. Business justification: Remote Diagnostic Session process requires linking a repair order to the specific connected vehicle for OTA updates and diagnostics.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service revenue posting requires linking each repair order to a cost center for cost allocation in the Service Revenue Report.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the customer who owns the vehicle.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer/service center handling the repair.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer/service center handling the repair.',
    `employee_id` BIGINT COMMENT 'Identifier of the service advisor who created the repair order.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: General Ledger posting of repair order revenue requires a GL account reference for the Service Revenue GL Posting process.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Repair orders are created when a quality inspection lot fails; linking provides the Inspection‑to‑Repair Traceability Report.',
    `party_id` BIGINT COMMENT 'Identifier of the customer who owns the vehicle.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Needed for Repair Order Cost Tracking report to associate parts spend on a repair with the originating purchase order.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Traceability report linking each repair order to the original production order enables warranty and recall investigations per VIN.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis per repair order uses profit center to track service margin in the Service Profitability Dashboard.',
    `recall_campaign_id` BIGINT COMMENT 'Identifier of a recall campaign linked to this repair.',
    `service_advisor_employee_id` BIGINT COMMENT 'Identifier of the service advisor who created the repair order.',
    `service_campaign_id` BIGINT COMMENT 'Identifier of a service campaign (e.g., TSB) associated with this repair.',
    `service_center_id` BIGINT COMMENT 'Identifier of the physical service location.',
    `technician_id` BIGINT COMMENT 'Identifier of the primary technician assigned to perform the work.',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Required for warranty eligibility and service cost attribution; repair orders must reference the original vehicle order to verify coverage and allocate service revenue.',
    `vehicle_ownership_id` BIGINT COMMENT 'Foreign key linking to customer.vehicle_ownership. Business justification: Service order processing uses the ownership record to confirm warranty coverage and apply owner‑specific service rules.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Required for warranty verification and recall tracking in the Repair Order processing workflow, linking each order to the vehicles VIN registry record.',
    `actual_completion_time` TIMESTAMP COMMENT 'Actual date and time when the repair was completed.',
    `aftersales_repair_order_status` STRING COMMENT 'Current lifecycle status of the repair order.. Valid values are `open|in_progress|quality_check|closed|invoiced|cancelled`',
    `appointment_arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle arrived at the service center.',
    `appointment_departure_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle left the service center.',
    `appointment_scheduled_timestamp` TIMESTAMP COMMENT 'Date and time when the service appointment was scheduled.',
    `close_timestamp` TIMESTAMP COMMENT 'Date and time when the repair order was closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the repair order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `customer_feedback_score` STRING COMMENT 'Numeric rating (1-5) provided by the customer after service.',
    `customer_signature_flag` BOOLEAN COMMENT 'Indicates whether the customer signed off on the repair order.',
    `diagnostic_code` STRING COMMENT 'Standard OBD diagnostic code recorded during service.. Valid values are `^[0-9]{4}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the repair order.',
    `is_estimate` BOOLEAN COMMENT 'Indicates whether the record is an estimate prior to work being performed.',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Standard labor rate applied per hour.',
    `labor_total_cost` DECIMAL(18,2) COMMENT 'Total cost of labor before taxes and discounts.',
    `labor_total_hours` DECIMAL(18,2) COMMENT 'Total labor hours recorded for the repair order.',
    `mileage_at_service` STRING COMMENT 'Vehicle odometer reading at the time of service.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax and discount.',
    `open_timestamp` TIMESTAMP COMMENT 'Date and time when the repair order was opened.',
    `parts_total_cost` DECIMAL(18,2) COMMENT 'Total cost of parts consumed before taxes and discounts.',
    `payment_method` STRING COMMENT 'Method used by the customer to settle the repair order.. Valid values are `cash|credit_card|debit_card|bank_transfer|mobile_payment|check`',
    `payment_status` STRING COMMENT 'Current status of the payment for the repair order.. Valid values are `pending|paid|failed|refunded`',
    `promised_completion_time` TIMESTAMP COMMENT 'Scheduled date and time promised to the customer for repair completion.',
    `ro_number` STRING COMMENT 'External repair order number assigned by the service center.',
    `service_center_region` STRING COMMENT 'Geographic region where the service center is located.. Valid values are `North|South|East|West|Central`',
    `service_notes` STRING COMMENT 'Free-text notes entered by service advisor describing work performed.',
    `service_priority` STRING COMMENT 'Priority level assigned to the repair order.. Valid values are `high|medium|low|critical`',
    `service_type` STRING COMMENT 'Category of service performed.. Valid values are `maintenance|repair|recall|campaign|diagnostic`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the repair order.',
    `technician_notes` STRING COMMENT 'Free-text notes entered by the technician during repair.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount of the repair order before tax and discount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the repair order record.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the warranty claim associated with this repair.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the repair is covered under warranty.',
    `warranty_type` STRING COMMENT 'Type of warranty covering the repair.. Valid values are `manufacturer|extended|service_contract`',
    CONSTRAINT pk_aftersales_repair_order PRIMARY KEY(`aftersales_repair_order_id`)
) COMMENT 'Core transactional record capturing a vehicle service or repair event at an authorized service center or dealership. Tracks RO number, vehicle VIN, customer, service advisor, open/close dates, labor operations performed, parts consumed, total labor cost, total parts cost, total RO value, payment method, warranty vs. customer pay vs. internal pay type, DMS source (CDK Global), mileage at write-up, promised completion time, actual completion time, technician assignments, and RO status lifecycle (open, in-progress, quality-check, closed, invoiced).';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`repair_order_line` (
    `repair_order_line_id` BIGINT COMMENT 'System-generated unique identifier for the repair order line.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Identifier of the parent repair order header to which this line belongs.',
    `aftersales_service_appointment_id` BIGINT COMMENT 'Identifier of the service appointment linked to this line.',
    `aftersales_warranty_claim_id` BIGINT COMMENT 'Identifier of the warranty claim associated with this line, if applicable.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to inventory.batch_record. Business justification: REQUIRED: When batch‑controlled parts are used in service, the batch_record must be recorded for quality and recall traceability.',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_change. Business justification: Specific line items may be affected by an engineering change; linking supports detailed root‑cause analysis and cost allocation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each lines labor/parts expense is posted to a specific GL account for detailed expense reporting.',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: REQUIRED: Parts Traceability Report for warranty investigations needs to link each repair line to the inbound part record it originated from.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: REQUIRED: Repair Order Shipment Tracking report ties repaired parts to the specific inbound shipment they arrived on for logistics audit.',
    `labor_time_standard_id` BIGINT COMMENT 'Foreign key linking to aftersales.labor_time_standard. Business justification: Repair order line should reference the standard labor time definition for the operation code.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the external vendor performing the sublet work.',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: REQUIRED: Serialized components (e.g., battery modules) installed during repair need a FK to the serialized_unit for warranty and service history.',
    `service_center_id` BIGINT COMMENT 'Identifier of the authorized service center where work was performed.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: REQUIRED: Parts used in a repair order line must be tracked against the inventory SKU master for cost, stock deduction, and compliance reporting.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: REQUIRED: Service parts are issued from a specific warehouse bin; linking to storage_location enables inventory location traceability for service.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor performing the sublet work.',
    `technician_id` BIGINT COMMENT 'Identifier of the technician who performed the labor.',
    `actual_technician_hours` DECIMAL(18,2) COMMENT 'Actual labor hours logged by the technician for this line.',
    `cause_complaint` STRING COMMENT 'Narrative describing the customer complaint or issue that initiated the service.',
    `correction` STRING COMMENT 'Narrative describing the corrective action taken to resolve the complaint.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the repair order line record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values on the line.. Valid values are `USD|CAD|EUR|GBP|JPY|CNY`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line, if any.',
    `labor_category` STRING COMMENT 'Broad classification of the labor type performed.. Valid values are `mechanical|electrical|diagnostic|body|software`',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate applied to the technician for this operation.',
    `labor_skill_level` STRING COMMENT 'Skill level required for the technician to perform the operation.. Valid values are `apprentice|journeyman|master|specialist`',
    `labor_time_standard` DECIMAL(18,2) COMMENT 'Flat‑rate standard labor time in hours for the operation code.',
    `line_sequence` STRING COMMENT 'Sequential number of the line within the repair order for ordering.',
    `line_status` STRING COMMENT 'Current processing status of the repair order line.. Valid values are `open|in_progress|completed|closed|canceled`',
    `line_total` DECIMAL(18,2) COMMENT 'Total monetary amount for the line (labor_rate * actual_technician_hours) before discounts and taxes.',
    `notes` STRING COMMENT 'Additional free‑form notes entered by the technician or service advisor.',
    `operation_code` STRING COMMENT 'Standard code representing the specific labor operation performed (e.g., oil change, brake inspection).',
    `overtime_flag` BOOLEAN COMMENT 'True if overtime rates were applied to this labor line.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the labor_rate when overtime_flag is true (e.g., 1.5).',
    `part_price` DECIMAL(18,2) COMMENT 'Standard price per unit of the part at the time of service.',
    `part_quantity` DECIMAL(18,2) COMMENT 'Quantity of the part used for this line.',
    `parts_used_flag` BOOLEAN COMMENT 'Indicates whether any parts were consumed on this line.',
    `service_date` DATE COMMENT 'Date on which the service work was performed.',
    `sublet_cost` DECIMAL(18,2) COMMENT 'Total cost charged by the sublet vendor for this line.',
    `sublet_flag` BOOLEAN COMMENT 'True if the work was performed by an external subcontractor.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the line total.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the repair order line record.',
    `vehicle_vin` STRING COMMENT 'Unique 17‑character identifier of the vehicle serviced.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the labor line is covered under warranty (true) or not (false).',
    CONSTRAINT pk_repair_order_line PRIMARY KEY(`repair_order_line_id`)
) COMMENT 'Individual labor operation or job line within a repair order. Captures operation code, labor time standard (flat-rate hours), actual technician hours, labor rate, line total, technician ID, cause/complaint/correction (3C) narrative, warranty flag, sublet flag, and line status. Supports granular cost analysis and technician productivity tracking per CDK Global DMS job line structure.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` (
    `aftersales_warranty_claim_id` BIGINT COMMENT 'Unique identifier for the warranty_claim data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Associates warranty claim creation with the responsible employee for accountability and claim processing KPI.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Warranty claims must reference the originating sales contract to verify coverage terms and reconcile financials between sales and aftersales.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the vehicle owner who is the warranty claimant.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer or service center submitting the claim.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer or service center submitting the claim.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Warranty claim investigation requires linking each claim to the originating quality defect record (Warranty Claim Investigation Report).',
    `party_id` BIGINT COMMENT 'Identifier of the vehicle owner who is the warranty claimant.',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_recall_campaign. Business justification: Regulatory warranty claim reporting mandates associating claims arising from a recall campaign with that campaign for audit and reimbursement.',
    `remote_diagnostic_session_id` BIGINT COMMENT 'Foreign key linking to mobility.remote_diagnostic_session. Business justification: Warranty Claim Investigation often uses a remote diagnostic session to verify fault, linking claim to the session record.',
    `service_campaign_id` BIGINT COMMENT 'Identifier of the recall or service campaign linked to the claim.',
    `service_center_id` BIGINT COMMENT 'Identifier of the authorized service center performing the repair.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Warranty Claim Settlement process requires linking each claim to the supplier contract that governs parts coverage.',
    `vehicle_ownership_id` BIGINT COMMENT 'Foreign key linking to customer.vehicle_ownership. Business justification: Claims processing must reference the specific ownership period to determine coverage limits and calculate accurate claim payouts.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Aggregating warranty claims by vehicle program is required for reliability analysis and program improvement decisions.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Needed for claim eligibility validation against the vehicles VIN registry during Warranty Claim adjudication.',
    `warranty_policy_id` BIGINT COMMENT 'Foreign key linking to aftersales.warranty_policy. Business justification: A warranty claim is filed under a specific warranty policy; linking directly to warranty_policy provides direct access to policy terms without needing to traverse vehicle_warranty.',
    `warranty_reserve_id` BIGINT COMMENT 'Foreign key linking to finance.warranty_reserve. Business justification: Warranty claim settlements are charged against a warranty reserve record for IFRS warranty liability tracking.',
    `adjudication_outcome` STRING COMMENT 'Result of the OEMs review of the claim.. Valid values are `approved|rejected|partial|pending`',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment applied to the claim.',
    `approved_labor_cost` DECIMAL(18,2) COMMENT 'Monetary amount approved for labor services.',
    `approved_labor_hours` DECIMAL(18,2) COMMENT 'Number of labor hours approved for reimbursement.',
    `approved_parts_cost` DECIMAL(18,2) COMMENT 'Monetary amount approved for parts used in the repair.',
    `claim_adjusted_flag` BOOLEAN COMMENT 'Indicates whether the claim amount was later adjusted.',
    `claim_category` STRING COMMENT 'High‑level classification of the claim type.. Valid values are `repair|recall|service_campaign|maintenance`',
    `claim_created_by` STRING COMMENT 'User identifier of the employee who entered the claim.',
    `claim_number` STRING COMMENT 'External claim identifier assigned by the OEM or dealer for tracking.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the warranty claim.. Valid values are `submitted|approved|rejected|adjusted|paid`',
    `claim_submission_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the warranty claim was submitted to the OEM.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the claim amounts.. Valid values are `USD|EUR|JPY|CAD|GBP|CNY`',
    `failure_date` DATE COMMENT 'Date the vehicle failure that triggered the warranty claim occurred.',
    `goodwill_flag` BOOLEAN COMMENT 'Indicates whether the claim is processed as goodwill (no reimbursement).',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Standard labor rate used for calculating labor cost.',
    `notes` STRING COMMENT 'Free‑form text notes entered by the service advisor or adjudicator.',
    `parts_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to the approved parts cost.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    `rejection_reason_code` STRING COMMENT 'Code indicating why a claim was rejected, if applicable.',
    `repair_date` DATE COMMENT 'Date the repair work was performed on the vehicle.',
    `repair_order_number` STRING COMMENT 'Reference number of the service repair order linked to the claim.',
    `total_claim_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the claim (labor + parts).',
    `warranty_end_date` DATE COMMENT 'Date when the vehicles warranty coverage expires.',
    `warranty_start_date` DATE COMMENT 'Date when the vehicles warranty coverage began.',
    `warranty_type` STRING COMMENT 'Category of warranty coverage applicable to the claim.. Valid values are `bumper_to_bumper|powertrain|corrosion|roadside_assistance`',
    CONSTRAINT pk_aftersales_warranty_claim PRIMARY KEY(`aftersales_warranty_claim_id`)
) COMMENT 'Warranty claim submitted by a dealer or authorized service center to the OEM for reimbursement of warranty-covered repairs. Tracks claim number, VIN, repair order reference, failure date, repair date, claim submission date, claim status (submitted, approved, rejected, adjusted, paid), approved labor hours, approved parts cost, total claim amount, rejection reason code, goodwill flag, campaign/recall linkage, and OEM adjudication outcome. Integrates with SAP SD warranty module and CDK Global DMS.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`warranty_policy` (
    `warranty_policy_id` BIGINT COMMENT 'System-generated unique identifier for the warranty policy record.',
    `nameplate_id` BIGINT COMMENT 'Foreign key linking to product.nameplate. Business justification: Warranty administration reports need to associate each warranty policy with the exact nameplate model to determine coverage eligibility and claim validation.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Warranty policies are defined per vehicle program; the link supports cost forecasting and compliance tracking per program.',
    `authorized_dealer_required_flag` BOOLEAN COMMENT 'Indicates whether warranty service must be performed at an authorized dealer (true) or can be performed at any qualified service center (false).',
    `claim_limit_per_year` STRING COMMENT 'Maximum number of warranty claims allowed per vehicle per calendar year.',
    `claim_limit_total` STRING COMMENT 'Overall maximum number of warranty claims permitted during the policy term.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the primary country of warranty applicability.',
    `coverage_description` STRING COMMENT 'Free‑text description of what components or systems are covered under the policy.',
    `coverage_type` STRING COMMENT 'Category of coverage provided by the warranty (e.g., basic, powertrain, corrosion, emissions, EV battery, ADAS).. Valid values are `basic|powertrain|corrosion|emissions|ev_battery|adas`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the warranty policy record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount the customer must pay for each covered repair under the warranty.',
    `duration_months` STRING COMMENT 'Length of the warranty coverage expressed in calendar months.',
    `effective_end_date` TIMESTAMP COMMENT 'Date and time when the warranty coverage expires (typically EOP or calculated from duration).',
    `effective_start_date` TIMESTAMP COMMENT 'Date and time when the warranty coverage becomes effective (typically SOP).',
    `eop_date` DATE COMMENT 'The production end date of the vehicle model to which the warranty applies.',
    `exclusions` STRING COMMENT 'List of components, conditions, or events excluded from coverage.',
    `extension_allowed_flag` BOOLEAN COMMENT 'True if the warranty may be extended beyond the original term under defined conditions.',
    `extension_terms` STRING COMMENT 'Free‑text description of the conditions, cost, and duration for extending the warranty.',
    `inclusions` STRING COMMENT 'List of components, systems, or services explicitly covered.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the warranty policy record.',
    `market_region` STRING COMMENT 'Geographic market or region where the warranty is offered (e.g., North America, EU).',
    `mileage_limit` STRING COMMENT 'Maximum distance the vehicle may travel while the warranty remains valid, expressed in miles.',
    `model_year` STRING COMMENT 'Model year of the vehicle for which the warranty is defined.',
    `notes` STRING COMMENT 'Additional free‑form notes or remarks about the warranty policy.',
    `policy_number` STRING COMMENT 'External business identifier assigned to the warranty policy, used in contracts and customer communications.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the warranty policy.. Valid values are `active|expired|suspended|terminated`',
    `powertrain_type` STRING COMMENT 'Type of powertrain the warranty applies to (e.g., ICE, HEV, PHEV, EV).',
    `regulatory_body` STRING COMMENT 'Governing authority that mandates or oversees the warranty (e.g., NHTSA, EPA).',
    `regulatory_reference_number` STRING COMMENT 'Identifier of the regulatory filing or certification linked to the warranty.',
    `renewal_allowed_flag` BOOLEAN COMMENT 'Indicates whether the warranty can be renewed after expiration.',
    `renewal_terms` STRING COMMENT 'Details of renewal options, pricing, and eligibility.',
    `service_center_network` STRING COMMENT 'Identifier of the service‑center network eligible for warranty work (e.g., OEM network, third‑party network).',
    `sop_date` DATE COMMENT 'The production start date of the vehicle model to which the warranty applies.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the warranty can be transferred to a subsequent owner (true) or is non‑transferable (false).',
    CONSTRAINT pk_warranty_policy PRIMARY KEY(`warranty_policy_id`)
) COMMENT 'Master definition of warranty coverage terms applicable to a vehicle nameplate, model year, powertrain type, or market. Captures warranty type (basic/bumper-to-bumper, powertrain, corrosion, emissions, EV battery, ADAS), coverage duration in months, coverage distance in miles/km, deductible amount, transferability flag, market/region applicability, SOP and EOP dates, and governing regulatory body (NHTSA, EPA). Serves as the authoritative reference for warranty eligibility determination.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` (
    `vehicle_warranty_id` BIGINT COMMENT 'Unique surrogate key for the vehicle warranty record.',
    `warranty_policy_id` BIGINT COMMENT 'Foreign key linking to aftersales.warranty_policy. Business justification: Vehicle warranty must reference the applicable warranty policy; adds inbound to warranty_policy and outbound from vehicle_warranty.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer that sold the vehicle or issued the warranty.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer that sold the vehicle or issued the warranty.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Warranty administration requires linking each warranty to the owning party for eligibility verification and regulatory compliance reporting.',
    `recall_campaign_id` BIGINT COMMENT 'Reference to a recall record that may affect the warranty.',
    `recall_recall_campaign_id` BIGINT COMMENT 'Reference to a recall record that may affect the warranty.',
    `service_center_id` BIGINT COMMENT 'Identifier of the authorized service center handling warranty work.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the service contract linked to the warranty.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Connects warranty contracts to the VIN registry to validate coverage periods and claim eligibility.',
    `claims_last_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the most recent warranty claim.',
    `claims_last_date` DATE COMMENT 'Date of the most recent warranty claim.',
    `coverage_area` STRING COMMENT 'Geographic scope of the warranty coverage.. Valid values are `domestic|international`',
    `coverage_description` STRING COMMENT 'Free‑text description of what components and services are covered.',
    `coverage_end_mileage` STRING COMMENT 'Maximum mileage at which warranty coverage ends.',
    `coverage_start_mileage` STRING COMMENT 'Mileage reading at which warranty coverage begins.',
    `cpo_warranty_flag` BOOLEAN COMMENT 'True if the warranty applies to a Certified Pre‑Owned vehicle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warranty record was first created in the system.',
    `duration_months` STRING COMMENT 'Total length of the warranty in months.',
    `eligible_for_recall` BOOLEAN COMMENT 'Indicates whether the vehicle is eligible for a safety recall under this warranty.',
    `end_date` DATE COMMENT 'Date the warranty coverage ends.',
    `exclusions` STRING COMMENT 'Text describing items or conditions excluded from coverage.',
    `extended_warranty_flag` BOOLEAN COMMENT 'Indicates whether the warranty has been extended beyond the original terms.',
    `last_transfer_date` DATE COMMENT 'Date of the most recent warranty transfer.',
    `mileage_limit` STRING COMMENT 'Maximum mileage allowed under the warranty.',
    `original_purchase_date` DATE COMMENT 'Date the vehicle was originally purchased by the first owner.',
    `policy_code` STRING COMMENT 'Internal code representing the warranty policy.',
    `program_category` STRING COMMENT 'Broad category of the warranty program.. Valid values are `new_vehicle|used_vehicle|cpo|extended`',
    `program_name` STRING COMMENT 'Name of the warranty program (e.g., New Vehicle, CPO, Extended).',
    `remaining_mileage` STRING COMMENT 'Mileage remaining before the warranty limit is reached.',
    `remaining_months` STRING COMMENT 'Number of months remaining before warranty expiration.',
    `renewal_date` DATE COMMENT 'Date on which the warranty was renewed or is scheduled to renew.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the warranty is eligible for renewal.',
    `service_plan` STRING COMMENT 'Name of the service plan associated with the warranty.',
    `start_date` DATE COMMENT 'Date the warranty coverage became effective (in‑service date).',
    `status_reason` STRING COMMENT 'Reason why the warranty is in its current status.. Valid values are `normal|customer_cancel|manufacturer_recall|non_payment`',
    `transfer_allowed` BOOLEAN COMMENT 'True if the warranty may be transferred to a subsequent owner.',
    `transfer_count` STRING COMMENT 'Number of times the warranty has been transferred to a new owner.',
    `transfer_fee` DECIMAL(18,2) COMMENT 'Fee charged for transferring the warranty to a new owner.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warranty record.',
    `vehicle_warranty_status` STRING COMMENT 'Current lifecycle status of the warranty.. Valid values are `active|expired|voided|suspended|transferred`',
    `warranty_claims_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all warranty claims.',
    `warranty_claims_count` STRING COMMENT 'Total number of warranty claims filed to date.',
    `warranty_document_url` STRING COMMENT 'Link to the electronic copy of the warranty contract.',
    `warranty_number` STRING COMMENT 'External warranty contract number assigned by the manufacturer or dealer.',
    `warranty_terms_version` STRING COMMENT 'Version identifier of the warranty terms document.',
    `warranty_type` STRING COMMENT 'Category of coverage provided by the warranty.. Valid values are `bumper_to_bumper|powertrain|corrosion|roadside_assistance|extended`',
    CONSTRAINT pk_vehicle_warranty PRIMARY KEY(`vehicle_warranty_id`)
) COMMENT 'VIN-level warranty entitlement record linking a specific vehicle to its applicable warranty policies. Tracks warranty start date (in-service date), expiration date, remaining months, remaining mileage, warranty status (active, expired, voided), extended warranty flag, CPO (Certified Pre-Owned) warranty flag, and any warranty transfer history. This is the SSOT for whether a specific vehicle is under warranty at any point in time.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`service_campaign` (
    `service_campaign_id` BIGINT COMMENT 'Unique surrogate key for the service campaign record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.sales_campaign. Business justification: Service campaigns are often launched from sales campaigns; linking tracks campaign effectiveness and regulatory reporting across domains.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Service campaigns are planned per vehicle program; linking enables program‑level impact analysis and regulatory reporting.',
    `affected_model_year_end` STRING COMMENT 'Last model year in the range of vehicles covered.',
    `affected_model_year_start` STRING COMMENT 'First model year in the range of vehicles covered.',
    `affected_vin_population` BIGINT COMMENT 'Estimated count of VINs that fall within the campaign scope.',
    `campaign_cost_estimate` DECIMAL(18,2) COMMENT 'Projected total cost to execute the campaign (currency assumed USD).',
    `campaign_notes` STRING COMMENT 'Free‑form notes or comments from campaign managers.',
    `campaign_priority` STRING COMMENT 'Priority level for resource allocation and scheduling.. Valid values are `high|medium|low`',
    `campaign_region` STRING COMMENT 'Primary geographic region(s) affected; uses ISO‑3 country codes.. Valid values are `USA|CAN|MEX|EU|JP|KR`',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `open|closed|suspended|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the campaign: safety recall, emissions recall, customer satisfaction program, or technical service bulletin action.. Valid values are `safety_recall|emissions_recall|customer_satisfaction|technical_service_bulletin`',
    `compliance_status` STRING COMMENT 'Overall compliance status of the campaign with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `customer_satisfaction_flag` BOOLEAN COMMENT 'True if the campaign is a voluntary customer‑satisfaction program.',
    `effective_end_date` DATE COMMENT 'Date when the campaign is closed or no longer applicable (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the campaign becomes effective for affected vehicles.',
    `emissions_recall_flag` BOOLEAN COMMENT 'True if the campaign addresses emissions compliance.',
    `estimated_repair_time_minutes` STRING COMMENT 'Average time, in minutes, required to complete the repair per vehicle.',
    `nhtsa_compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign meets NHTSA requirements.',
    `parts_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of parts required for the campaign.',
    `parts_required` STRING COMMENT 'Comma‑separated list of part numbers needed to perform the remedy.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    `regulatory_reporting_date` DATE COMMENT 'Date on which the campaign was reported to the regulator.',
    `regulatory_reporting_status` STRING COMMENT 'Current status of the campaigns regulatory filing with NHTSA/UNECE.. Valid values are `pending|submitted|approved|rejected`',
    `remedy_description` STRING COMMENT 'Detailed description of the repair or corrective action required.',
    `safety_recall_flag` BOOLEAN COMMENT 'True if the campaign is a safety‑related recall.',
    `technical_service_bulletin_flag` BOOLEAN COMMENT 'True if the campaign originates from a TSB.',
    `unece_compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign meets UNECE regulations.',
    `warranty_impact_flag` BOOLEAN COMMENT 'Indicates whether the campaign affects warranty coverage.',
    CONSTRAINT pk_service_campaign PRIMARY KEY(`service_campaign_id`)
) COMMENT 'Master record for a service campaign (recall or non-safety field action) issued by the OEM. Captures NHTSA recall number, campaign code, campaign type (safety recall, emissions recall, customer satisfaction program, technical service bulletin action), affected nameplate/model year range, affected VIN population count, remedy description, estimated repair time, parts required, campaign open date, campaign close date, regulatory reporting status, and NHTSA/UNECE compliance flags. Integrates with NHTSA recall database and SAP QM.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`campaign_vin` (
    `campaign_vin_id` BIGINT COMMENT 'Surrogate primary key for the campaign VIN association record.',
    `service_campaign_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_campaign. Business justification: Campaign VIN records need to be linked to the parent service campaign for proper campaign tracking.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Associates vehicles with recall or service campaigns, enabling campaign effectiveness reporting and regulatory compliance.',
    `campaign_code` STRING COMMENT 'Code identifying the service campaign or recall.',
    `campaign_description` STRING COMMENT 'Brief description of the campaign purpose and remedy.',
    `compliance_deadline` DATE COMMENT 'Regulatory compliance deadline for completing the remedy.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status for the vehicle.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign VIN record was created.',
    `dealer_code` STRING COMMENT 'Identifier of the dealer where remedy was performed.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating if the campaign is classified as critical safety.',
    `labor_rate_usd_per_hour` DECIMAL(18,2) COMMENT 'Labor rate applied for the remedy in USD per hour.',
    `labor_time_hours` DECIMAL(18,2) COMMENT 'Labor time recorded for the remedy in hours.',
    `last_service_date` DATE COMMENT 'Date of the most recent service performed on the vehicle.',
    `notes` STRING COMMENT 'Free‑text notes entered by the service technician.',
    `notification_date` DATE COMMENT 'Date when the vehicle was notified about the campaign.',
    `notification_status` STRING COMMENT 'Current notification status of the vehicle for the campaign.. Valid values are `not_notified|notified|scheduled|completed|parts_on_order|owner_refused`',
    `odometer_reading_km` STRING COMMENT 'Vehicle odometer reading at time of remedy in kilometers.',
    `owner_response` STRING COMMENT 'Owners response to the campaign notification.. Valid values are `accepted|refused|pending`',
    `parts_consumed` STRING COMMENT 'Comma‑separated list of part numbers consumed for the remedy.',
    `recall_number` STRING COMMENT 'Official recall number assigned by regulatory authority.',
    `recall_type` STRING COMMENT 'Category of the recall or campaign.. Valid values are `safety|emissions|performance|software`',
    `remedy_completion_date` DATE COMMENT 'Date when the remedy was completed.',
    `remedy_status` STRING COMMENT 'Current status of the remedy execution.. Valid values are `pending|in_progress|completed|cancelled`',
    `scheduled_service_date` DATE COMMENT 'Date scheduled for the service remedy.',
    `service_center_location` STRING COMMENT 'Location identifier of the service center where remedy was performed.',
    `service_order_number` STRING COMMENT 'Dealer service order number associated with the remedy.',
    `total_labor_cost_usd` DECIMAL(18,2) COMMENT 'Total labor cost for the remedy in USD.',
    `total_parts_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of parts consumed for the remedy in USD.',
    `total_remedy_cost_usd` DECIMAL(18,2) COMMENT 'Aggregate cost (parts + labor) for the remedy in USD.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `warranty_covered` BOOLEAN COMMENT 'Indicates if the remedy is covered under warranty.',
    CONSTRAINT pk_campaign_vin PRIMARY KEY(`campaign_vin_id`)
) COMMENT 'Association record linking a specific VIN to an open service campaign or recall. Tracks VIN, campaign code, notification status (not notified, notified, scheduled, completed, parts-on-order, owner-refused), remedy completion date, dealer code where remedy was performed, parts consumed for remedy, and compliance deadline. Enables OEM and NHTSA to track recall completion rates at the individual vehicle level.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` (
    `aftersales_service_appointment_id` BIGINT COMMENT 'Unique identifier for the service_appointment data product (auto-inserted pre-linking).',
    `connected_vehicle_id` BIGINT COMMENT 'Foreign key linking to mobility.connected_vehicle. Business justification: OTA Update Appointment workflow ties a service appointment to the target connected vehicle to schedule firmware upgrades.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service appointment labor and parts costs are allocated to a cost center for service cost analysis.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the vehicle owner or service requester.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealership or authorized service center hosting the appointment.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealership or authorized service center hosting the appointment.',
    `employee_id` BIGINT COMMENT 'Identifier of the service advisor assigned to the appointment.',
    `party_id` BIGINT COMMENT 'Identifier of the vehicle owner or service requester.',
    `service_advisor_employee_id` BIGINT COMMENT 'Identifier of the service advisor assigned to the appointment.',
    `vehicle_ownership_id` BIGINT COMMENT 'Foreign key linking to customer.vehicle_ownership. Business justification: Appointment scheduling needs the ownership record to apply loyalty benefits and verify owner eligibility for scheduled services.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Ensures service appointment scheduling aligns with the correct vehicle record for service history and recall compliance.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the service work was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle actually entered service.',
    `aftersales_service_appointment_status` STRING COMMENT 'Current lifecycle status of the appointment.. Valid values are `scheduled|confirmed|completed|cancelled|no_show`',
    `appointment_number` STRING COMMENT 'Business identifier assigned to the service appointment, used in dealer and customer communications.',
    `appointment_source` STRING COMMENT 'Origin channel through which the appointment was booked.. Valid values are `online|phone|dms|mobile_app`',
    `bay_number` STRING COMMENT 'Identifier of the service bay where the vehicle will be serviced.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer checked in at the service center.',
    `confirmation_status` STRING COMMENT 'Current confirmation state of the appointment.. Valid values are `pending|confirmed|declined`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the appointment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `customer_feedback_score` STRING COMMENT 'Numeric rating (0‑10) provided by the customer after service.',
    `estimated_duration_minutes` STRING COMMENT 'Planned length of the service appointment in minutes.',
    `estimated_gross_amount` DECIMAL(18,2) COMMENT 'Projected total charge before taxes and discounts.',
    `estimated_net_amount` DECIMAL(18,2) COMMENT 'Projected total charge after taxes and discounts.',
    `estimated_tax_amount` DECIMAL(18,2) COMMENT 'Projected tax component of the service charge.',
    `invoice_number` STRING COMMENT 'Identifier of the invoice generated for the service appointment.',
    `is_first_time_customer` BOOLEAN COMMENT 'True if this is the customers first service appointment with the dealer.',
    `is_repeat_service` BOOLEAN COMMENT 'True if the vehicle has previously received the same service type.',
    `labor_time_actual_minutes` STRING COMMENT 'Actual labor minutes recorded for the service.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the customer failed to appear for the scheduled appointment.',
    `parts_actual_amount` DECIMAL(18,2) COMMENT 'Total cost of parts actually used during service.',
    `recall_flag` BOOLEAN COMMENT 'True if the appointment is part of a manufacturer recall campaign.',
    `required_parts_flag` BOOLEAN COMMENT 'Indicates whether specific parts must be ordered before the appointment.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time when the service is to start.',
    `service_category` STRING COMMENT 'Higher‑level grouping of the service (e.g., oil change, brake service, battery replacement).',
    `service_notes` STRING COMMENT 'Free‑form notes entered by the service advisor or technician.',
    `service_priority` STRING COMMENT 'Priority level assigned to the appointment for scheduling.. Valid values are `low|medium|high`',
    `service_type` STRING COMMENT 'Classification of the service (e.g., routine maintenance, warranty repair, recall, pre‑delivery inspection, customer‑pay).. Valid values are `maintenance|warranty_repair|recall|pdi|customer_pay`',
    `total_actual_amount` DECIMAL(18,2) COMMENT 'Final charge for the appointment after labor, parts, taxes, and discounts.',
    `transportation_option` STRING COMMENT 'Customer transportation provision during service.. Valid values are `loaner|shuttle|wait|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the appointment record.',
    `vehicle_mileage` BIGINT COMMENT 'Odometer reading at the time of service appointment.',
    `warranty_flag` BOOLEAN COMMENT 'True if the appointment is covered under a warranty agreement.',
    CONSTRAINT pk_aftersales_service_appointment PRIMARY KEY(`aftersales_service_appointment_id`)
) COMMENT 'Scheduled service appointment record for a vehicle at a dealership or authorized service center. Captures appointment date/time, customer contact, VIN, service type (maintenance, warranty repair, recall, PDI, customer pay), service advisor assigned, estimated duration, transportation option (loaner, shuttle, wait), appointment source (online, phone, DMS, mobile app), confirmation status, check-in time, and no-show flag. Sourced from CDK Global DMS scheduling module.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`tsb` (
    `tsb_id` BIGINT COMMENT 'System-generated unique identifier for the Technical Service Bulletin record.',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Technical Service Bulletins are issued based on design specifications; the link provides traceability for compliance audits.',
    `service_campaign_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_campaign. Business justification: Technical Service Bulletin (TSB) is issued as part of a service campaign; linking provides campaign context.',
    `affected_model_year_end` STRING COMMENT 'Last model year in the range affected by the bulletin.',
    `affected_model_year_start` STRING COMMENT 'First model year in the range affected by the bulletin.',
    `affected_vehicle_model` STRING COMMENT 'Vehicle model name or code to which the bulletin applies.',
    `affected_vin_end` STRING COMMENT 'Ending VIN in the range covered by the bulletin.',
    `affected_vin_start` STRING COMMENT 'Starting VIN (Vehicle Identification Number) in the range covered by the bulletin.',
    `attachment_url` STRING COMMENT 'Link to the full PDF or digital document of the bulletin.',
    `author_department` STRING COMMENT 'Organizational department responsible for the bulletin (e.g., Powertrain, Body, Electronics).',
    `author_engineer` STRING COMMENT 'Name of the OEM engineer who authored the bulletin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulletin record was first created in the data lake.',
    `distribution_status` STRING COMMENT 'Current status of bulletin distribution to the dealer network.. Valid values are `pending|distributed|completed`',
    `effective_from` DATE COMMENT 'Date from which the bulletin recommendations become applicable.',
    `effective_until` DATE COMMENT 'Date after which the bulletin is no longer applicable (nullable for open‑ended bulletins).',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated technician labor time required to complete the repair.',
    `is_ota_capable` BOOLEAN COMMENT 'Indicates whether the fix can be delivered via Over‑The‑Air update.',
    `issue_date` DATE COMMENT 'Date the bulletin was officially issued by the OEM.',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Standard labor rate applied for cost estimation (currency assumed USD).',
    `last_review_date` DATE COMMENT 'Date when the bulletin was last reviewed for relevance or accuracy.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `part_number` STRING COMMENT 'OEM part number required for the repair.',
    `part_revision` STRING COMMENT 'Revision identifier of the required part.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the bulletin satisfies a regulatory requirement (e.g., NHTSA, EPA).',
    `repair_procedure` STRING COMMENT 'Step‑by‑step instructions for service technicians to resolve the issue.',
    `required_parts` STRING COMMENT 'Comma‑separated list of part numbers and revisions needed for the repair.',
    `review_status` STRING COMMENT 'Outcome of the most recent technical review.. Valid values are `pending|approved|rejected`',
    `root_cause` STRING COMMENT 'Technical explanation of why the symptom occurs.',
    `severity_level` STRING COMMENT 'Impact severity of the issue addressed by the bulletin.. Valid values are `low|medium|high|critical`',
    `superseded_by_tsb_number` STRING COMMENT 'TSB number that supersedes this bulletin, if any.',
    `symptom_description` STRING COMMENT 'Narrative of the customer‑reported or observed symptom that triggers the bulletin.',
    `title` STRING COMMENT 'Short descriptive title of the bulletin.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Combined estimated cost of parts and labor for the bulletin repair.',
    `tsb_number` STRING COMMENT 'OEM-assigned alphanumeric identifier for the bulletin (e.g., TSB-2023-001).',
    `tsb_status` STRING COMMENT 'Current lifecycle status of the bulletin.. Valid values are `draft|active|retired|superseded`',
    `tsb_type` STRING COMMENT 'Category of the bulletin indicating its purpose.. Valid values are `safety|recall|service|maintenance|software`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bulletin record.',
    `vehicle_system_affected` STRING COMMENT 'Specific vehicle subsystem (e.g., ECU, transmission) impacted by the issue.',
    `version_number` STRING COMMENT 'Incremental version of the bulletin content.',
    `warranty_impact_flag` BOOLEAN COMMENT 'Indicates whether the repair is covered under vehicle warranty.',
    CONSTRAINT pk_tsb PRIMARY KEY(`tsb_id`)
) COMMENT 'Technical Service Bulletin master record issued by OEM engineering to communicate repair procedures, diagnostic guidance, or part supersessions to the dealer service network. Captures TSB number, title, affected nameplate/model year/VIN range, symptom description, root cause, recommended repair procedure, required parts list, estimated labor time, issue date, supersession reference, and distribution status to dealer network. Integrates with PTC Windchill and CDK Global DMS.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` (
    `aftersales_dtc_event_id` BIGINT COMMENT 'Unique identifier for the DTC event record.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Link to the service repair order associated with the DTC investigation.',
    `ecu_catalog_id` BIGINT COMMENT 'Identifier of the ECU module that reported the DTC.',
    `ecu_specification_id` BIGINT COMMENT 'Identifier of the ECU module that reported the DTC.',
    `fmea_id` BIGINT COMMENT 'Foreign key linking to quality.fmea. Business justification: DTC analysis uses FMEA data to identify failure modes (DTC‑FMEA Mapping Report).',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Recall root‑cause analysis links DTC events to the specific production order that built the vehicle for batch‑level defect tracking.',
    `service_center_id` BIGINT COMMENT 'Identifier of the authorized service location handling the DTC.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Links diagnostic trouble code events to the VIN registry for emission compliance reporting and service history.',
    `ambient_temperature_c` STRING COMMENT 'Outside air temperature in degrees Celsius when the DTC was logged.',
    `battery_voltage_v` DECIMAL(18,2) COMMENT 'Vehicle battery voltage measured at the event.',
    `cleared_flag` BOOLEAN COMMENT 'Indicates whether the DTC has been cleared (true) or remains active (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DTC event record was first inserted.',
    `diagnostic_session_type` STRING COMMENT 'Type of diagnostic session during which the DTC was captured.. Valid values are `default|extended|programming`',
    `dtc_category` STRING COMMENT 'High‑level functional area the DTC belongs to.. Valid values are `powertrain|chassis|body|network|emissions`',
    `dtc_code` STRING COMMENT 'Standardized fault code captured from the vehicle ECU.',
    `dtc_description` STRING COMMENT 'Human‑readable description of the fault represented by the DTC.',
    `dtc_recall_indicator` BOOLEAN COMMENT 'True if the DTC is associated with an active manufacturer recall.',
    `dtc_related_part_description` STRING COMMENT 'Human‑readable description of the part linked to the DTC.',
    `dtc_related_part_number` STRING COMMENT 'Part number of the component replaced or inspected for the DTC.',
    `dtc_resolution_code` STRING COMMENT 'Standardized code representing the corrective action taken.',
    `dtc_resolution_description` STRING COMMENT 'Narrative description of the repair or fix applied.',
    `dtc_status` STRING COMMENT 'Current lifecycle status of the DTC (e.g., pending, confirmed).. Valid values are `pending|confirmed|stored|permanent`',
    `emission_related_flag` BOOLEAN COMMENT 'True if the DTC is related to emissions control systems.',
    `engine_rpm` STRING COMMENT 'Engine revolutions per minute recorded when the DTC occurred.',
    `event_source_reference` STRING COMMENT 'Identifier of the system or device that generated the DTC event record.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the DTC event was recorded in the system.',
    `event_type` STRING COMMENT 'Category of source that produced the DTC event.. Valid values are `obd|telematics|service_tool`',
    `first_occurrence_timestamp` TIMESTAMP COMMENT 'Date‑time when the DTC first appeared on the vehicle.',
    `freeze_frame_data` STRING COMMENT 'Snapshot of sensor values captured at the time the DTC was set, stored as a JSON string.',
    `fuel_level_percent` STRING COMMENT 'Fuel tank level as a percentage at the time of the event.',
    `is_test_event` BOOLEAN COMMENT 'True if the DTC record originates from a test or diagnostic simulation.',
    `last_occurrence_timestamp` TIMESTAMP COMMENT 'Date‑time when the DTC was most recently observed.',
    `mileage_at_event` STRING COMMENT 'Odometer reading (kilometres) when the DTC was captured.',
    `occurrence_count` STRING COMMENT 'Number of times the DTC has been recorded for this vehicle.',
    `odometer_km` STRING COMMENT 'Total distance traveled by the vehicle in kilometres at the time of the DTC.',
    `service_date` DATE COMMENT 'Calendar date on which the vehicle was serviced for the DTC.',
    `severity_level` STRING COMMENT 'Business‑defined severity of the fault, used for prioritization.. Valid values are `low|medium|high|critical`',
    `source_module` STRING COMMENT 'Software module that generated the DTC event.',
    `source_version` STRING COMMENT 'Version identifier of the source module at event time.',
    `technician_action` STRING COMMENT 'Summary of diagnostic steps or repairs performed by the technician.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the DTC event record.',
    `vehicle_speed_kph` STRING COMMENT 'Speed of the vehicle in kilometres per hour at the time of the DTC.',
    `warranty_covered_flag` BOOLEAN COMMENT 'Indicates whether the repair for this DTC is covered under warranty.',
    CONSTRAINT pk_aftersales_dtc_event PRIMARY KEY(`aftersales_dtc_event_id`)
) COMMENT 'Diagnostic Trouble Code (DTC) event record captured from OBD-II (On-Board Diagnostics) systems during a vehicle service visit or via connected vehicle telematics. Tracks VIN, DTC code (SAE J2012 standardized or OEM-proprietary), ECU module source, fault type (confirmed, pending, permanent), fault description, freeze frame data snapshot, first occurrence timestamp, last occurrence timestamp, occurrence count, MIL (Malfunction Indicator Lamp) status, cleared flag, repair order linkage, and technician diagnostic action taken. Enables fleet-wide DTC pattern analysis for TSB development, early warning quality detection, and warranty cost forecasting.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` (
    `labor_time_standard_id` BIGINT COMMENT 'Unique surrogate key for each labor time standard record.',
    `body_style` STRING COMMENT 'Body style classification of the vehicle (e.g., hatchback, pickup). [ENUM-REF-CANDIDATE: coupe|sedan|hatchback|wagon|pickup|van|SUV — 7 candidates stripped; promote to reference product]',
    `compliance_nhtsa_code` STRING COMMENT 'Regulatory code from NHTSA that the labor operation must satisfy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `effective_from` DATE COMMENT 'Date from which the labor time standard becomes effective.',
    `effective_until` DATE COMMENT 'Date after which the labor time standard is no longer valid (null if open‑ended).',
    `is_mandatory` BOOLEAN COMMENT 'True if the operation is mandatory for the vehicle model/year, false otherwise.',
    `labor_category` STRING COMMENT 'Broad category of labor (e.g., maintenance, repair).. Valid values are `maintenance|repair|diagnostic|installation`',
    `labor_time_standard_status` STRING COMMENT 'Current lifecycle status of the labor time standard.. Valid values are `active|inactive|deprecated`',
    `labor_type` STRING COMMENT 'Indicates whether the labor is covered under warranty, billed to the customer, or part of a recall.. Valid values are `warranty|customer_pay|recall`',
    `last_revision_date` DATE COMMENT 'Date when the labor time standard was last revised.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the labor operation.',
    `oem_part_number` STRING COMMENT 'Part number of the OEM component associated with the operation, if any.',
    `operation_code` STRING COMMENT 'Standardized code identifying the labor operation (e.g., "A123").',
    `operation_description` STRING COMMENT 'Human‑readable description of the labor operation performed.',
    `region` STRING COMMENT 'Geographic region where the standard applies.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `revision_number` STRING COMMENT 'Sequential number indicating the revision of the standard.',
    `skill_level` STRING COMMENT 'Technician skill level required to perform the operation.. Valid values are `L1|L2|L3|L4|L5|L6`',
    `source` STRING COMMENT 'Origin of the labor time data (OEM guide, MOTOR, Alldata, etc.).. Valid values are `OEM|MOTOR|Alldata|Other`',
    `special_tool_required` BOOLEAN COMMENT 'Indicates whether a special tool is needed (true) or not (false).',
    `standard_hours` DECIMAL(18,2) COMMENT 'Flat‑rate labor time in hours for the operation.',
    `tool_code` STRING COMMENT 'Identifier of the special tool required for the operation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `vehicle_model_year_end` STRING COMMENT 'Last model year for which this labor time standard applies.',
    `vehicle_model_year_start` STRING COMMENT 'First model year for which this labor time standard applies.',
    `vehicle_segment` STRING COMMENT 'Segment of vehicle (e.g., sedan, SUV) to which the standard is applicable.. Valid values are `sedan|SUV|truck|van|crossover|commercial`',
    CONSTRAINT pk_labor_time_standard PRIMARY KEY(`labor_time_standard_id`)
) COMMENT 'Reference master for flat-rate labor time standards (operation times) used to price warranty claims and customer-pay repair operations. Captures operation code, operation description, applicable nameplate/model year range, standard flat-rate hours, skill level required, special tool requirement flag, last revision date, and source (OEM labor time guide or MOTOR/Alldata industry standard). Used by CDK Global DMS to auto-populate labor time on repair order lines.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`service_part` (
    `service_part_id` BIGINT COMMENT 'Unique surrogate key for the service part record.',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: REQUIRED: Service Part Origin Traceability needed for regulatory compliance (NHTSA/UNECE) links service parts to their inbound part records.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Required for parts traceability report linking service inventory to engineering part master specs, essential for compliance and quality analysis.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Service Part Master Data must reference the supplying vendor for procurement planning and compliance reporting.',
    `compliance_certification` STRING COMMENT 'Regulatory certification(s) applicable to the part (e.g., EPA, DOT).',
    `core_charge` DECIMAL(18,2) COMMENT 'Refundable deposit required for parts that are returned for reuse.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO country code indicating where the part was manufactured.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the service part record was first created in the system.',
    `dealer_net_price` DECIMAL(18,2) COMMENT 'Price offered to authorized dealers after standard discounts.',
    `effective_end_date` DATE COMMENT 'Date when the part is retired from the service catalog (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the part becomes valid for use in service operations.',
    `epa_hazardous_material_code` STRING COMMENT 'EPA classification code for hazardous parts, if applicable.',
    `hazardous_classification` STRING COMMENT 'Regulatory classification code for hazardous parts (e.g., UN number).',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous material.',
    `height_mm` DECIMAL(18,2) COMMENT 'Physical height of the part in millimetres.',
    `inventory_status` STRING COMMENT 'Current inventory availability status of the part.. Valid values are `in_stock|out_of_stock|backordered|discontinued`',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time when the part was last consumed in a service transaction.',
    `length_mm` DECIMAL(18,2) COMMENT 'Physical length of the part in millimetres.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the part within the after‑sales catalog.. Valid values are `active|superseded|discontinued|obsolete`',
    `list_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price before any discounts.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer that produces the part.',
    `part_category` STRING COMMENT 'High‑level classification of the part type.. Valid values are `mechanical|electrical|body|consumable|accessory`',
    `part_name` STRING COMMENT 'Human‑readable name or description of the part.',
    `part_number` STRING COMMENT 'Manufacturer-assigned part number used to uniquely identify the part across the enterprise.',
    `part_revision` STRING COMMENT 'Revision identifier for engineering changes to the part.',
    `service_part_description` STRING COMMENT 'Full textual description of the part, including fitment notes.',
    `superseded_by_part_number` STRING COMMENT 'Part number that replaces this part when it is superseded.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for inventory and transaction quantities (e.g., EA, SET).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the service part record.',
    `warranty_eligible_flag` BOOLEAN COMMENT 'Indicates whether the part is covered under the standard warranty program.',
    `warranty_period_months` STRING COMMENT 'Number of months the part is covered by warranty from the date of installation.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the part in kilograms.',
    `width_mm` DECIMAL(18,2) COMMENT 'Physical width of the part in millimetres.',
    CONSTRAINT pk_service_part PRIMARY KEY(`service_part_id`)
) COMMENT 'Aftersales service parts master record for parts stocked and consumed in dealer service and repair operations. Captures OEM part number, supersession chain (current and all prior part numbers), part description, part category (mechanical, electrical, body, consumable, fluid, accessory), unit of measure, standard list price, dealer net price, core charge amount, weight, hazmat flag, country of origin, minimum order quantity, and lifecycle status (active, superseded, discontinued, obsolete). Serves as the aftersales-specific view of the parts catalog optimized for service ordering and warranty claims — distinct from the manufacturing BOM parts master in the engineering domain.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` (
    `aftersales_parts_order_id` BIGINT COMMENT 'Unique identifier for the parts_order data product (auto-inserted pre-linking).',
    `dealership_id` BIGINT COMMENT 'FK to dealer.dealership',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Parts procurement cost is charged to a cost center for expense reporting in the Parts Spend Report.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account reference is required for posting parts purchase amounts in the Procurement GL Posting process.',
    `primary_aftersales_dealership_id` BIGINT COMMENT 'Unique identifier of the dealer or service center that placed the parts order.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center allocation allows analysis of parts cost contribution to overall profitability.',
    `supply_purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: REQUIRED: Dealer‑to‑Supplier PO Reconciliation report matches dealership parts orders to supplier purchase orders for cost allocation and audit.',
    `actual_delivery_date` DATE COMMENT 'Date the parts were actually received at the dealer.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether any line items are on backorder.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parts order record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the order.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the order.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Cost of shipping the parts from the fulfillment location to the dealer.',
    `freight_terms` STRING COMMENT 'Terms governing freight cost responsibility.. Valid values are `prepaid|collect|third_party`',
    `fulfillment_location_code` STRING COMMENT 'Code of the Parts Distribution Center (PDC) or regional warehouse fulfilling the order.',
    `net_total` DECIMAL(18,2) COMMENT 'Final amount payable after applying discounts, taxes, and freight.',
    `order_number` STRING COMMENT 'External business identifier assigned to the parts order by the dealer or OEM system.',
    `order_status` STRING COMMENT 'Current lifecycle state of the parts order (e.g., submitted, confirmed, picked, shipped, received, invoiced, cancelled). [ENUM-REF-CANDIDATE: submitted|confirmed|picked|shipped|received|invoiced|cancelled — promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'Date and time when the parts order was placed by the dealer.',
    `order_type` STRING COMMENT 'Classification of the order based on business need.. Valid values are `stock|emergency|campaign|special`',
    `payment_terms` STRING COMMENT 'Agreed payment condition for the order.. Valid values are `net30|net45|net60|cod`',
    `priority_flag` BOOLEAN COMMENT 'Indicates if the order is marked as high priority.',
    `requested_delivery_date` DATE COMMENT 'Date requested by the dealer for parts to be delivered.',
    `shipping_method` STRING COMMENT 'Mode of transportation used to deliver the parts.. Valid values are `ground|air|sea|rail`',
    `special_instructions` STRING COMMENT 'Free‑text field for any additional handling or delivery instructions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the order.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Gross monetary value of the order before discounts, taxes, and freight.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the parts order record.',
    CONSTRAINT pk_aftersales_parts_order PRIMARY KEY(`aftersales_parts_order_id`)
) COMMENT 'Parts order placed by a dealer or service center to the OEM parts distribution center (PDC) or regional warehouse. Captures order number, ordering dealer code, PDC fulfillment location, order date, requested delivery date, order type (stock, emergency, campaign/recall, special), order status (submitted, confirmed, picked, shipped, received, invoiced), total order value, freight terms, and backorder flags. Integrates with SAP MM and dealer DMS parts ordering module.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`parts_order_line` (
    `parts_order_line_id` BIGINT COMMENT 'Unique surrogate key for each line item within a dealer parts order.',
    `aftersales_parts_order_id` BIGINT COMMENT 'Identifier of the parts order (header) to which this line belongs.',
    `procurement_supplier_id` BIGINT COMMENT 'Surrogate key of the supplier responsible for delivering the part.',
    `service_part_id` BIGINT COMMENT 'Surrogate key of the part master record referenced by this line.',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'Units still pending fulfillment after initial shipment.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Number of units the supplier confirmed it can supply.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the line record was first created in the system.',
    `currency_code` STRING COMMENT 'Currency in which the monetary amounts are expressed.. Valid values are `USD|EUR|JPY|CAD|GBP|AUD`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount granted for this line item.',
    `estimated_availability_date` DATE COMMENT 'Projected calendar date when the part can be shipped.',
    `line_sequence` STRING COMMENT 'Ordinal position of the line item in the parts order.',
    `line_status` STRING COMMENT 'Lifecycle status of the line item.. Valid values are `open|confirmed|shipped|backordered|canceled`',
    `line_total` DECIMAL(18,2) COMMENT 'Gross amount for the line before discounts, taxes, and adjustments.',
    `notes` STRING COMMENT 'Additional remarks entered by the dealer or supplier regarding the line item.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Number of units the dealer ordered.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Number of units dispatched from the warehouse.',
    `substitution_part_number` STRING COMMENT 'Part number of a substitute component offered in place of the original.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax calculated for the line based on applicable rates.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit of the part before discounts and taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the line record.',
    `warranty_flag` BOOLEAN COMMENT 'True if the part is supplied under warranty terms.',
    CONSTRAINT pk_parts_order_line PRIMARY KEY(`parts_order_line_id`)
) COMMENT 'Individual line item within a dealer parts order. Captures part number, ordered quantity, confirmed quantity, shipped quantity, unit price, line total, backorder quantity, estimated availability date, and substitution part number if original is unavailable. Enables granular parts fulfillment tracking and backorder management at the line level.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`service_contract` (
    `service_contract_id` BIGINT COMMENT 'System-generated unique identifier for the service contract record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Service contracts extend the original sales contract; linking enables contract profitability analysis and compliance reporting across sales and aftersales.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contract revenue allocation uses a cost center to capture service contract income in the Contract Revenue Report.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the customer who purchased the service contract.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer that sold the service contract to the customer.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account reference is required for posting contract revenue and expense in the Contract Accounting process.',
    `party_id` BIGINT COMMENT 'Identifier of the customer who purchased the service contract.',
    `primary_service_dealership_id` BIGINT COMMENT 'Identifier of the dealer that sold the service contract to the customer.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center links enable profitability analysis of service contracts across business units.',
    `service_center_id` BIGINT COMMENT 'Identifier of the primary service center authorized to fulfill the contract.',
    `service_id` BIGINT COMMENT 'Foreign key linking to mobility.mobility_service. Business justification: OEM bundles connectivity services into service contracts; tracking which mobility service is included per contract is required for billing and compliance.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Required for Service Contract Cost Allocation Report linking each service contract to its underlying supplier contract for cost tracking.',
    `transfer_to_dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer that received the transferred contract.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Service contracts are sold per vehicle program; linking enables revenue forecasting and program‑level service planning.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Binds service contracts to the VIN registry to enforce service plan applicability and mileage tracking.',
    `warranty_policy_id` BIGINT COMMENT 'Foreign key linking to aftersales.warranty_policy. Business justification: A service contract defines coverage based on a warranty policy; linking to warranty_policy enables consistent policy lookup and eliminates redundant policy attributes in service_contract.',
    `administrator_code` BIGINT COMMENT 'Identifier of the entity (OEM or third‑party) that administers the contract.',
    `cancellation_date` DATE COMMENT 'Date on which the contract was formally cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Free‑text reason provided for contract cancellation.',
    `claim_count` STRING COMMENT 'Total number of service claims submitted under this contract.',
    `contract_description` STRING COMMENT 'Free‑text description of the contract terms and conditions.',
    `contract_type` STRING COMMENT 'Category of coverage provided by the service contract.. Valid values are `powertrain|comprehensive|maintenance|tire_and_wheel|roadside_assistance|extended_warranty`',
    `coverage_mileage_limit` BIGINT COMMENT 'Maximum mileage (kilometres) covered under the contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the contract value.. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Fixed amount the customer must pay per claim before the contract pays.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount granted on the contract price before tax.',
    `effective_from` DATE COMMENT 'Date when the contract coverage becomes effective.',
    `effective_until` DATE COMMENT 'Date when the contract coverage expires or terminates (nullable for open‑ended contracts).',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the contract value is refundable upon early termination.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether the contract may be transferred to another dealer or owner.',
    `last_claim_date` DATE COMMENT 'Date of the most recent claim filed against the contract.',
    `mileage_used` BIGINT COMMENT 'Total mileage recorded on the vehicle while the contract was active.',
    `net_contract_value` DECIMAL(18,2) COMMENT 'Final contract value after applying discounts and taxes.',
    `payment_method` STRING COMMENT 'Method used by the customer to pay for the contract.. Valid values are `credit_card|debit_card|bank_transfer|cash|check`',
    `payment_term_code` STRING COMMENT 'Standard payment term applied to the contract invoice.. Valid values are `net30|net45|net60|cash|credit`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the contract complies with all applicable automotive regulatory requirements.',
    `renewal_date` DATE COMMENT 'Scheduled date for contract renewal if renewal_option is not none.',
    `renewal_option` STRING COMMENT 'Policy for contract renewal: automatic, manual, or none.. Valid values are `auto|manual|none`',
    `service_contract_status` STRING COMMENT 'Current lifecycle state of the service contract.. Valid values are `active|expired|cancelled|transferred|pending|suspended`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the contract price.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Gross monetary value of the contract at the time of sale.',
    `transfer_date` DATE COMMENT 'Date when the contract ownership was transferred to another dealer or party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the contract record.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the vehicle is still under the original OEM warranty (true) or not (false).',
    CONSTRAINT pk_service_contract PRIMARY KEY(`service_contract_id`)
) COMMENT 'Extended service contract or vehicle service agreement (VSA) sold to a customer beyond the standard OEM warranty. Captures contract number, VIN, customer reference, contract type (powertrain, comprehensive, maintenance plan, tire and wheel), coverage start date, coverage end date, coverage mileage limit, deductible amount, selling dealer, administrator (OEM or third-party), contract status (active, expired, cancelled, transferred), and total contract value. Distinct from the OEM warranty_policy which is factory-issued.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` (
    `service_contract_claim_id` BIGINT COMMENT 'System-generated unique identifier for the service contract claim record.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Identifier of the repair order associated with the claim.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks which employee submitted each service contract claim for audit and performance metrics.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each claim expense is allocated to a cost center for accurate service contract cost tracking.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the customer who owns the vehicle and holds the service contract.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer associated with the claim.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer associated with the claim.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account is needed to post claim expense entries in the Service Contract Claim GL Posting routine.',
    `party_id` BIGINT COMMENT 'Identifier of the customer who owns the vehicle and holds the service contract.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center linkage enables claim profitability analysis per business unit.',
    `service_center_id` BIGINT COMMENT 'Identifier of the service center that performed the repair.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the extended service contract under which the claim is filed.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Claims are aggregated by vehicle program for reliability metrics and warranty cost analysis.',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Amount of monetary adjustment applied to the approved claim.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Final amount approved for payment after adjustments and deductible.',
    `claim_adjusted_flag` BOOLEAN COMMENT 'Indicates whether the claim amount has been adjusted after initial approval.',
    `claim_adjustment_reason` STRING COMMENT 'Reason provided for any monetary adjustment to the claim.',
    `claim_category` STRING COMMENT 'High‑level classification of the claim type.. Valid values are `repair|maintenance|upgrade|other`',
    `claim_closure_date` DATE COMMENT 'Date when the claim was closed or paid.',
    `claim_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `claim_effective_date` DATE COMMENT 'Date on which the claim becomes effective for processing.',
    `claim_line_item_count` STRING COMMENT 'Number of individual line items (parts, labor, etc.) associated with the claim.',
    `claim_number` STRING COMMENT 'External reference number assigned to the claim by the service contract system.',
    `claim_original_amount` DECIMAL(18,2) COMMENT 'Original total amount requested before any deductions or adjustments.',
    `claim_payment_method` STRING COMMENT 'Method used to remit payment for the claim.. Valid values are `check|credit|direct_deposit`',
    `claim_payment_status` STRING COMMENT 'Current status of the claim payment.. Valid values are `pending|completed|failed`',
    `claim_payment_timestamp` TIMESTAMP COMMENT 'Timestamp when the approved claim amount was paid to the service provider.',
    `claim_priority` STRING COMMENT 'Priority level assigned to the claim for processing.. Valid values are `high|medium|low`',
    `claim_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim was reviewed.',
    `claim_reviewed_by` STRING COMMENT 'User identifier of the employee who reviewed the claim.',
    `claim_status` STRING COMMENT 'Current processing status of the claim.. Valid values are `pending|approved|denied|paid`',
    `claim_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the claim was submitted to the service contract system.',
    `claim_submitted_by` STRING COMMENT 'User identifier of the employee who submitted the claim.',
    `claim_type` STRING COMMENT 'Indicates whether the claim is under an extended service contract or a voluntary service agreement.. Valid values are `extended_service_contract|voluntary_service_agreement`',
    `claim_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    `claimed_labor_amount` DECIMAL(18,2) COMMENT 'Labor cost claimed for the repair, before any adjustments.',
    `claimed_parts_amount` DECIMAL(18,2) COMMENT 'Parts cost claimed for the repair, before any adjustments.',
    `covered_repair_description` STRING COMMENT 'Narrative description of the repair work covered by the claim.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the claim.. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible applied to the claim as per the service contract terms.',
    `denial_reason_code` STRING COMMENT 'Code indicating why a claim was denied, if applicable.',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Standard labor rate applied to calculate labor charges.',
    `notes` STRING COMMENT 'Free‑form text notes entered by claim processors.',
    `parts_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to the parts portion of the claim.',
    `vin` STRING COMMENT 'Unique vehicle identifier for the automobile covered by the claim.',
    CONSTRAINT pk_service_contract_claim PRIMARY KEY(`service_contract_claim_id`)
) COMMENT 'Claim submitted against an extended service contract or VSA for a covered repair. Tracks claim number, service contract reference, repair order reference, VIN, claim submission date, covered repair description, claimed labor amount, claimed parts amount, deductible applied, approved amount, claim status (pending, approved, denied, paid), and denial reason code. Distinct from OEM warranty_claim which is submitted to the manufacturer.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` (
    `goodwill_adjustment_id` BIGINT COMMENT 'System-generated unique identifier for the goodwill adjustment record.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Identifier of the repair order linked to this goodwill transaction.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the customer receiving the goodwill assistance.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer or service center that processed the goodwill adjustment.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer or service center that processed the goodwill adjustment.',
    `party_id` BIGINT COMMENT 'Identifier of the customer receiving the goodwill assistance.',
    `service_campaign_id` BIGINT COMMENT 'Identifier of a service or recall campaign linked to the goodwill adjustment.',
    `adjustment_number` STRING COMMENT 'External reference number assigned to the goodwill adjustment for tracking and audit.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the goodwill adjustment was applied to the customers account.',
    `approval_authority_level` STRING COMMENT 'Organizational level of the person who approved the goodwill adjustment.. Valid values are `supervisor|manager|director|vice_president|executive`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the goodwill adjustment received final approval.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Total monetary value approved for the goodwill adjustment before tax.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the goodwill adjustment.',
    `business_justification` STRING COMMENT 'Narrative explanation why the goodwill adjustment was granted.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the goodwill adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the approved amount.',
    `goodwill_adjustment_status` STRING COMMENT 'Current lifecycle state of the goodwill adjustment.. Valid values are `pending|approved|rejected|closed|cancelled`',
    `goodwill_type` STRING COMMENT 'Category of goodwill assistance provided to the customer.. Valid values are `full_coverage|partial_coverage|parts_only|labor_only|cash_reimbursement`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Monetary value of labor covered by the goodwill adjustment.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the goodwill adjustment.',
    `nps_impact_flag` BOOLEAN COMMENT 'Indicates whether the goodwill adjustment is linked to a Net Promoter Score (NPS) impact initiative.',
    `nps_score_change` STRING COMMENT 'Projected change in the customers NPS score attributable to this goodwill adjustment.',
    `part_cost` DECIMAL(18,2) COMMENT 'Monetary value of parts covered by the goodwill adjustment.',
    `source_system` STRING COMMENT 'Originating operational system that created the goodwill adjustment record.. Valid values are `SAP_S4HANA|CDK_DMS|Other`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the goodwill adjustment amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Sum of approved amount, parts cost, labor cost, and tax.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the goodwill adjustment record.',
    `vin` STRING COMMENT 'Unique 17‑character identifier of the vehicle associated with the goodwill adjustment.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the goodwill adjustment is associated with a warranty claim.',
    CONSTRAINT pk_goodwill_adjustment PRIMARY KEY(`goodwill_adjustment_id`)
) COMMENT 'Goodwill or customer assistance transaction where the OEM or dealer provides financial relief to a customer for a repair outside standard warranty coverage. Captures adjustment number, VIN, customer reference, repair order reference, goodwill type (full coverage, partial coverage, parts-only, labor-only, cash reimbursement), requested amount, approved amount, approval authority level (service manager, zone manager, regional, national), business justification narrative, policy exception code, and customer retention outcome. Tracks OEM goodwill spend against budget allocations and enables cost management reporting by region, model, and failure type.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`service_center` (
    `service_center_id` BIGINT COMMENT 'Unique surrogate key for the service center record.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer group to which the service center belongs.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to asset.functional_location. Business justification: Facility Management report links each service center to its functional location for maintenance planning and OEE aggregation, a standard practice in automotive manufacturing.',
    `geofence_id` BIGINT COMMENT 'Foreign key linking to mobility.geofence. Business justification: Service Center Geofence defines the service area for mobile service teams and is used in routing and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links each service center to its manager employee for operational oversight and manager performance reporting.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Service Center performance dashboard aggregates service metrics by originating plant for warranty and recall analysis.',
    `adas_calibration_authorized` BOOLEAN COMMENT 'Indicates whether the center can calibrate Advanced Driver Assistance Systems.',
    `address_line1` STRING COMMENT 'Primary street address of the service center.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `authorization_level` STRING COMMENT 'Combined classification of services the center is authorized to perform.. Valid values are `warranty|recall|collision|ev_certified|adas_calibration|none`',
    `average_service_time_minutes` DECIMAL(18,2) COMMENT 'Mean duration from service order start to completion, expressed in minutes.',
    `city` STRING COMMENT 'City where the service center is located.',
    `collision_authorized` BOOLEAN COMMENT 'Indicates whether the center is certified to perform collision repairs.',
    `country` STRING COMMENT 'Three‑letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service center record was first created.',
    `dsk_instance_code` BIGINT COMMENT 'Identifier of the CDK Global DMS instance that manages this service center.',
    `effective_end_date` DATE COMMENT 'Date when the service center ceased operations (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the service center became active in the network.',
    `ev_certified` BOOLEAN COMMENT 'Indicates whether the center is qualified to service electric vehicles.',
    `iatf_certified` BOOLEAN COMMENT 'Indicates compliance with IATF 16949 quality management standards.',
    `is_primary_center` BOOLEAN COMMENT 'Indicates if this center is the primary hub for its dealer group.',
    `iso9001_certified` BOOLEAN COMMENT 'Indicates compliance with ISO 9001 quality management standards.',
    `last_audit_date` DATE COMMENT 'Date when the most recent compliance audit was performed.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the service center location.',
    `loaner_fleet_size` STRING COMMENT 'Number of loaner vehicles maintained for customer use.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the service center location.',
    `market` STRING COMMENT 'Market segment served (e.g., premium, mass‑market, commercial).',
    `network_status` STRING COMMENT 'Current participation status of the center in the OEM service network.. Valid values are `active|suspended|terminated`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the service center.',
    `operating_hours` STRING COMMENT 'Standard weekly operating hours (e.g., Mon‑Fri 08:00‑18:00).',
    `postal_code` STRING COMMENT 'Postal or ZIP code.. Valid values are `^[A-Z0-9]{3,10}$`',
    `recall_authorized` BOOLEAN COMMENT 'Indicates whether the center can execute manufacturer recall campaigns.',
    `region` STRING COMMENT 'Regional grouping (e.g., North America, EMEA) used for reporting.',
    `regulatory_status` STRING COMMENT 'Current status of the centers compliance with automotive regulations.. Valid values are `compliant|non_compliant|under_review`',
    `service_bay_count` STRING COMMENT 'Total count of service bays available for vehicle work.',
    `service_center_code` STRING COMMENT 'External business code used to reference the service center in dealer and OEM systems.',
    `service_center_name` STRING COMMENT 'Human‑readable name of the authorized service center.',
    `service_center_type` STRING COMMENT 'Category of the service center based on ownership and relationship to OEM.. Valid values are `dealership|independent|authorized|factory`',
    `service_orders_processed` BIGINT COMMENT 'Cumulative count of service orders completed at the center.',
    `state` STRING COMMENT 'State or province abbreviation.. Valid values are `^[A-Z]{2}$`',
    `technician_headcount` STRING COMMENT 'Number of technicians employed at the service center.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service center record.',
    `warranty_authorized` BOOLEAN COMMENT 'Indicates whether the center can perform warranty repairs.',
    `warranty_claims_processed` BIGINT COMMENT 'Cumulative count of warranty claims handled by the center.',
    CONSTRAINT pk_service_center PRIMARY KEY(`service_center_id`)
) COMMENT 'Master record for authorized service centers and dealership service departments in the OEM aftersales network. Captures service center code, name, address, dealer group affiliation, authorization level (warranty, recall, certified collision, EV-certified, ADAS-calibration), service bay count, technician headcount, CDK Global DMS instance ID, operating hours, loaner fleet size, and network status (active, suspended, terminated). Distinct from the dealer domains dealer profile — this is the service-operations-specific view.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`technician` (
    `technician_id` BIGINT COMMENT 'System-generated unique identifier for the service technician.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Technicians are employees; linking enables HR skill tracking and labor cost allocation.',
    `service_center_id` BIGINT COMMENT 'Identifier of the service center to which the technician is assigned.',
    `availability_status` STRING COMMENT 'Current availability of the technician for new assignments.. Valid values are `available|unavailable|on_leave|scheduled`',
    `certification_expiry_date` DATE COMMENT 'Date on which the technicians current certification expires.',
    `certification_level` STRING COMMENT 'Level of certification achieved by the technician.. Valid values are `level1|level2|master|expert`',
    `certification_type` STRING COMMENT 'Type of certification held by the technician (e.g., ASE, OEM, EV, ADAS).. Valid values are `ASE|OEM|EV|ADAS|HV|GENERAL`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the technician record was first created.',
    `current_active_ro_count` STRING COMMENT 'Number of repair orders currently assigned to the technician.',
    `email_address` STRING COMMENT 'Primary email address used for communication with the technician.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `flat_rate_efficiency_rating` DECIMAL(18,2) COMMENT 'Efficiency rating expressed as a percentage of flat‑rate labor productivity.',
    `full_name` STRING COMMENT 'Legal full name of the technician.',
    `hire_date` DATE COMMENT 'Date the technician was hired by the organization.',
    `last_training_date` DATE COMMENT 'Date of the most recent training session attended by the technician.',
    `max_concurrent_ro` STRING COMMENT 'Maximum number of repair orders the technician can handle simultaneously.',
    `notes` STRING COMMENT 'Free‑form notes about the technician (e.g., performance comments, special accommodations).',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the technician is eligible for overtime pay.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base labor rate for overtime work.',
    `phone_number` STRING COMMENT 'Primary telephone number for the technician.',
    `shift_type` STRING COMMENT 'Work shift classification for the technician.. Valid values are `day|night|flex|rotating`',
    `skill_level` STRING COMMENT 'Skill tier of the technician based on experience and performance.. Valid values are `junior|mid|senior|lead`',
    `specialization` STRING COMMENT 'Technical area of expertise for the technician.. Valid values are `powertrain|electrical|body|diagnostics|software|hvac`',
    `technician_status` STRING COMMENT 'Current employment status of the technician.. Valid values are `active|inactive|suspended|retired`',
    `training_hours_completed` STRING COMMENT 'Cumulative hours of formal training completed by the technician.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the technician record.',
    `years_of_experience` STRING COMMENT 'Total number of years the technician has worked in automotive service.',
    CONSTRAINT pk_technician PRIMARY KEY(`technician_id`)
) COMMENT 'Master record for service technicians employed at authorized service centers. Captures technician ID, name, service center assignment, certification level (ASE, OEM-certified, EV-certified, ADAS-certified), specialization (powertrain, electrical, body, diagnostics), flat-rate efficiency rating, current active RO count, hire date, and certification expiry dates. This is the aftersales-specific technician profile focused on service capacity and certification — distinct from the workforce domains employee record.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`parts_return` (
    `parts_return_id` BIGINT COMMENT 'Unique surrogate key for the parts return transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Returned parts credit is allocated to a cost center for accurate reverse logistics cost accounting.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer originating the return.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Returned parts are analyzed against the engineering part master to identify systemic defects and drive quality improvements.',
    `primary_parts_dealership_id` BIGINT COMMENT 'Identifier of the dealer originating the return.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the part supplier.',
    `service_campaign_id` BIGINT COMMENT 'Identifier of the service or recall campaign linked to the return.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier of the returned part, if applicable.',
    `core_return_flag` BOOLEAN COMMENT 'True when the part is a core that must be returned for reuse.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the return record was created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Gross credit amount owed to the dealer before taxes or adjustments.',
    `credit_memo_date` DATE COMMENT 'Date the credit memo was generated.',
    `credit_memo_reference` STRING COMMENT 'Identifier of the credit memo generated for the return.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the credit amount.',
    `inspected_by` STRING COMMENT 'Identifier of the employee who performed the inspection.',
    `inspection_date` DATE COMMENT 'Date the returned parts were inspected.',
    `inspection_notes` STRING COMMENT 'Free‑form notes from the inspection process.',
    `inspection_outcome` STRING COMMENT 'Result of OEM inspection of the returned part.. Valid values are `accepted|rejected|partial`',
    `is_credit_issued` BOOLEAN COMMENT 'Indicates whether a credit memo has been issued.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the returned part.',
    `net_credit_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and any adjustments.',
    `notes` STRING COMMENT 'Any supplemental information related to the return.',
    `original_order_line_number` STRING COMMENT 'Line identifier within the original order.',
    `original_order_number` STRING COMMENT 'Order number of the original parts purchase.',
    `overstock_flag` BOOLEAN COMMENT 'True when the return is due to dealer overstock.',
    `part_condition` STRING COMMENT 'Condition of the part at the time of return.. Valid values are `new|used|defective|repaired`',
    `quantity_returned` STRING COMMENT 'Number of units returned.',
    `received_date` DATE COMMENT 'Date the OEM received the returned parts.',
    `return_authorization_number` STRING COMMENT 'External reference number issued to authorize the parts return.',
    `return_date` DATE COMMENT 'Date the dealer initiated the return.',
    `return_location` STRING COMMENT 'Physical location where the returned parts are received.',
    `return_method` STRING COMMENT 'Means by which the parts were returned to the OEM.. Valid values are `mail|carrier|dropoff|pickup`',
    `return_reason_category` STRING COMMENT 'High‑level category of the return reason.. Valid values are `quality|logistics|regulatory|other`',
    `return_reason_code` STRING COMMENT 'Standardized code describing why the part is being returned.',
    `return_reason_description` STRING COMMENT 'Human‑readable description of the return reason.',
    `return_source_system` STRING COMMENT 'Originating ERP or MES system that created the return record.',
    `return_status` STRING COMMENT 'Current processing status of the return.. Valid values are `pending|approved|rejected|processed|cancelled`',
    `return_type` STRING COMMENT 'Category of the return based on business rules.. Valid values are `warranty|core|overstock|campaign`',
    `shipment_tracking_number` STRING COMMENT 'Carrier tracking identifier for the return shipment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the credit.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity returned.. Valid values are `each|box|kg|liter`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the return record.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates if the return is covered under warranty.',
    CONSTRAINT pk_parts_return PRIMARY KEY(`parts_return_id`)
) COMMENT 'Parts return transaction record for defective, warranty-core, or over-ordered parts returned from a dealer to the OEM PDC. Captures return authorization number, originating dealer, return reason code (warranty defect, core return, overstock, campaign supersession), part number, quantity returned, credit amount, return shipment tracking, OEM inspection outcome (accepted, rejected, partial credit), and credit memo reference. Integrates with SAP MM returns management.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`aftersales_pdi_inspection` (
    `aftersales_pdi_inspection_id` BIGINT COMMENT 'Unique identifier for the aftersales_pdi_inspection data product (auto-inserted pre-linking).',
    `aftersales_service_appointment_id` BIGINT COMMENT 'Foreign key linking to aftersales.aftersales_service_appointment. Business justification: aftersales_pdi_inspection is currently isolated; linking it to aftersales_service_appointment provides the necessary relationship and eliminates the silo.',
    CONSTRAINT pk_aftersales_pdi_inspection PRIMARY KEY(`aftersales_pdi_inspection_id`)
) COMMENT 'Pre-Delivery Inspection (PDI) record completed by a dealer before vehicle handover to the customer. Captures VIN, inspection date, performing technician, checklist version, pass/fail status per inspection category (fluid levels, tire pressure TPMS, lighting, ADAS calibration, software version, cosmetic), defects found, defects rectified, PDI completion timestamp, and dealer certification signature. Mandatory OEM quality gate before retail delivery.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` (
    `customer_satisfaction_survey_id` BIGINT COMMENT 'Unique surrogate key for each survey response record.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Identifier of the service repair order linked to the survey.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the customer who completed the survey.',
    `dealer_dealership_id` BIGINT COMMENT 'Identifier of the dealer franchise handling the service.',
    `dealership_id` BIGINT COMMENT 'Identifier of the dealer franchise handling the service.',
    `party_id` BIGINT COMMENT 'Identifier of the customer who completed the survey.',
    `service_campaign_id` BIGINT COMMENT 'Identifier of any service campaign associated with the visit.',
    `service_center_id` BIGINT COMMENT 'Identifier of the dealer/service center where the service was performed.',
    `comments` STRING COMMENT 'Free‑text feedback entered by the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first persisted in the lakehouse.',
    `customer_satisfaction_survey_status` STRING COMMENT 'Current processing state of the survey response.. Valid values are `completed|pending|cancelled`',
    `facility_score` STRING COMMENT 'Rating of the overall service facility (cleanliness, comfort, etc.).',
    `follow_up_action_flag` BOOLEAN COMMENT 'Indicates whether the response triggers a follow‑up action by the service team.',
    `language_code` STRING COMMENT 'ISO 639‑1 code representing the language in which the survey was presented.',
    `nps_score` STRING COMMENT 'NPS rating (0‑10) indicating likelihood to recommend the service center.',
    `overall_score` STRING COMMENT 'Overall rating provided by the customer, typically on a 0‑10 scale.',
    `respondent_type` STRING COMMENT 'Role of the individual completing the survey.. Valid values are `owner|driver|fleet_manager`',
    `response_duration_seconds` STRING COMMENT 'Time taken by the customer to complete the survey, measured in seconds.',
    `response_source` STRING COMMENT 'Origin of the response capture device or medium.. Valid values are `online|paper|tablet`',
    `response_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the customer submitted the survey.',
    `service_advisor_score` STRING COMMENT 'Rating of the service advisors performance.',
    `service_type` STRING COMMENT 'Category of service performed (e.g., routine maintenance, repair, recall).. Valid values are `maintenance|repair|recall|campaign`',
    `survey_channel` STRING COMMENT 'Medium through which the survey was delivered to the customer.. Valid values are `email|sms|ivr|app|phone`',
    `survey_code` STRING COMMENT 'External identifier or code assigned to the survey instance by the survey provider.',
    `survey_date` DATE COMMENT 'Calendar date on which the survey was completed (date component of response_timestamp).',
    `survey_method` STRING COMMENT 'Methodology used to collect the survey (e.g., post‑service email, in‑app prompt).',
    `technician_quality_score` STRING COMMENT 'Rating of the technicians workmanship and professionalism.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the survey record.',
    `vehicle_mileage_at_service` STRING COMMENT 'Odometer reading of the vehicle at the time of service.',
    `vehicle_vin` STRING COMMENT 'VIN of the vehicle serviced during the visit associated with this survey.',
    `warranty_flag` BOOLEAN COMMENT 'True if the service was performed under warranty.',
    CONSTRAINT pk_customer_satisfaction_survey PRIMARY KEY(`customer_satisfaction_survey_id`)
) COMMENT 'Post-service customer satisfaction survey response record (CSI — Customer Satisfaction Index) collected after a service visit. Captures survey ID, VIN, repair order reference, service center, survey channel (email, SMS, IVR, app), response date, overall satisfaction score, service advisor score, technician quality score, facility score, NPS score, verbatim comments, and follow-up action flag. Feeds OEM dealer performance scorecards and NPS tracking. Sourced from Salesforce Automotive Cloud or third-party CSI provider.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` (
    `loaner_vehicle_id` BIGINT COMMENT 'Surrogate primary key for the loaner vehicle record.',
    `service_center_id` BIGINT COMMENT 'Identifier of the service center currently responsible for the loaner vehicle.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Tracks loaner vehicle assignments to the original vehicles VIN registry for fleet management and liability.',
    `acquisition_date` DATE COMMENT 'Date the loaner vehicle was added to the fleet.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loaner vehicle record was created in the system.',
    `current_location` STRING COMMENT 'Identifier of the current physical location of the loaner vehicle (e.g., lot, depot).',
    `current_odometer` BIGINT COMMENT 'Current mileage reading of the loaner vehicle.',
    `depreciation_value` DECIMAL(18,2) COMMENT 'Current depreciated book value of the loaner vehicle.',
    `fuel_type` STRING COMMENT 'Primary fuel propulsion type of the loaner vehicle.. Valid values are `gasoline|diesel|ev|hybrid|plug_in_hybrid`',
    `insurance_expiry_date` DATE COMMENT 'Date when the vehicles insurance coverage expires.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance performed on the loaner vehicle.',
    `license_plate` STRING COMMENT 'Vehicle registration plate identifier.',
    `loan_out_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle was returned from loan.',
    `loan_out_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle was checked out to a customer.',
    `loaner_vehicle_status` STRING COMMENT 'Operational status of the loaner vehicle.. Valid values are `available|on_loan|in_service|retired|maintenance`',
    `make` STRING COMMENT 'Manufacturer of the loaner vehicle.',
    `mileage_at_acquisition` BIGINT COMMENT 'Odometer reading at the time the vehicle entered the loaner fleet.',
    `model` STRING COMMENT 'Model designation of the loaner vehicle.',
    `model_year` STRING COMMENT 'Calendar year the vehicle model was released.',
    `notes` STRING COMMENT 'Free-text field for additional remarks about the loaner vehicle.',
    `pool_type` STRING COMMENT 'Category of loaner vehicle usage within the service network.. Valid values are `courtesy|rental|ev_demo|test`',
    `powertrain_type` STRING COMMENT 'Powertrain technology used by the loaner vehicle.. Valid values are `internal_combustion|electric|hybrid|plug_in_hybrid`',
    `purchase_price` DECIMAL(18,2) COMMENT 'Original purchase price of the loaner vehicle.',
    `registration_state` STRING COMMENT 'State or province where the vehicle is registered.',
    `total_loan_out_count` STRING COMMENT 'Cumulative number of times the vehicle has been loaned out.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loaner vehicle record.',
    `vehicle_type` STRING COMMENT 'Body style classification of the loaner vehicle.. Valid values are `sedan|suv|truck|van|crossover`',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturers warranty ends.',
    CONSTRAINT pk_loaner_vehicle PRIMARY KEY(`loaner_vehicle_id`)
) COMMENT 'Master record for loaner vehicles managed by service centers for customer use during vehicle repairs. Captures loaner VIN, service center assignment, vehicle make/model/year, loaner pool type (courtesy, rental, EV demo), current status (available, on-loan, in-service, retired), total loan-out count, current odometer, insurance expiry date, and last maintenance date. Tracks loaner fleet availability and utilization for service center capacity planning.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` (
    `loaner_assignment_id` BIGINT COMMENT 'System-generated unique identifier for each loaner vehicle assignment record.',
    `aftersales_repair_order_id` BIGINT COMMENT 'Identifier of the service repair order associated with this loaner assignment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Loaner vehicle usage cost is charged to a cost center for fleet expense tracking.',
    `customer_party_id` BIGINT COMMENT 'Identifier of the customer who received the loaner vehicle.',
    `loaner_vehicle_id` BIGINT COMMENT 'Foreign key linking to aftersales.loaner_vehicle. Business justification: Loaner assignment should reference the loaner vehicle entity; VIN string becomes redundant.',
    `party_id` BIGINT COMMENT 'Identifier of the customer who received the loaner vehicle.',
    `service_center_id` BIGINT COMMENT 'Identifier of the service center where the loaner was assigned.',
    `actual_return_timestamp` TIMESTAMP COMMENT 'Date and time when the loaner vehicle was actually returned (null if not yet returned).',
    `assignment_number` STRING COMMENT 'Human‑readable identifier assigned to the loaner assignment (e.g., LA‑2023‑000123).',
    `assignment_source` STRING COMMENT 'Origin of the loaner vehicle assignment (e.g., dealer inventory, central fleet, partner network).. Valid values are `dealer|fleet|partner`',
    `assignment_type` STRING COMMENT 'Indicates whether the loaner is provided for a short‑term (single visit) or long‑term (multiple days) period.. Valid values are `short_term|long_term`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Total monetary charge applied to the customer for the loaner assignment (e.g., fuel, mileage, damage).',
    `charge_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the charge amount.. Valid values are `USD|EUR|CAD|GBP|JPY|CHF`',
    `charge_reason` STRING COMMENT 'Reason for the monetary charge (fuel, damage, excess mileage, or other).. Valid values are `fuel|damage|mileage|other`',
    `checkout_timestamp` TIMESTAMP COMMENT 'Date and time when the loaner vehicle was handed to the customer.',
    `damage_assessed_flag` BOOLEAN COMMENT 'Indicates whether the returned loaner vehicle was inspected for damage (true/false).',
    `damage_noted_at_return` STRING COMMENT 'Free‑text description of any damage observed when the loaner vehicle is returned.',
    `expected_return_timestamp` TIMESTAMP COMMENT 'Planned date and time for the loaner vehicle to be returned.',
    `fuel_level_checkout` DECIMAL(18,2) COMMENT 'Fuel tank level (percentage) recorded at checkout.',
    `fuel_level_return` DECIMAL(18,2) COMMENT 'Fuel tank level (percentage) recorded at return.',
    `fuel_refill_charge` DECIMAL(18,2) COMMENT 'Monetary charge for refilling fuel if required.',
    `fuel_refill_required` BOOLEAN COMMENT 'Indicates whether a fuel refill charge is applicable (true/false).',
    `loaner_assignment_status` STRING COMMENT 'Current lifecycle state of the loaner assignment.. Valid values are `assigned|in_use|returned|cancelled|lost`',
    `loaner_category` STRING COMMENT 'Business classification of the loaner vehicle based on service level.. Valid values are `standard|premium|luxury`',
    `loaner_vehicle_status` STRING COMMENT 'Current operational status of the loaner vehicle in the fleet.. Valid values are `available|maintenance|assigned|retired`',
    `loaner_vehicle_type` STRING COMMENT 'Classification of the loaner vehicle (e.g., sedan, SUV, electric).. Valid values are `sedan|suv|truck|van|electric|hybrid`',
    `mileage_allowance_km` STRING COMMENT 'Maximum number of kilometers the customer may drive the loaner without incurring excess mileage charges.',
    `mileage_excess` STRING COMMENT 'Number of kilometers driven beyond the allowed mileage, if any.',
    `mileage_excess_charge` DECIMAL(18,2) COMMENT 'Monetary charge for excess mileage.',
    `notes` STRING COMMENT 'Additional free‑form notes related to the loaner assignment.',
    `odometer_checkout` STRING COMMENT 'Vehicle odometer reading (kilometers) at the time of checkout.',
    `odometer_return` STRING COMMENT 'Vehicle odometer reading (kilometers) when the loaner is returned.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the loaner assignment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loaner assignment record.',
    CONSTRAINT pk_loaner_assignment PRIMARY KEY(`loaner_assignment_id`)
) COMMENT 'Transactional record of a loaner vehicle being assigned to a customer during a service visit. Captures assignment ID, loaner VIN, customer reference, repair order linkage, checkout date/time, expected return date, actual return date, odometer at checkout, odometer at return, fuel level at checkout, fuel level at return, damage noted at return, and any charges applied. Enables loaner fleet utilization tracking and customer accountability.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` (
    `warranty_parts_return_id` BIGINT COMMENT 'Unique identifier for the warranty parts return record.',
    `aftersales_warranty_claim_id` BIGINT COMMENT 'Identifier of the associated warranty claim.',
    `dealer_dealership_id` BIGINT COMMENT 'Dealer or service center handling the return.',
    `dealership_id` BIGINT COMMENT 'Dealer or service center handling the return.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Warranty parts returns need to reference the engineering part master for root‑cause analysis and supplier quality feedback.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier responsible for the part.',
    `analysis_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when failure analysis was completed.',
    `analysis_notes` STRING COMMENT 'Free‑form notes from the analysis team.',
    `batch_number` STRING COMMENT 'Batch identifier for the returned part.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged to the supplier.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates if the supplier will be charged for the defect.',
    `compliance_epa_code` STRING COMMENT 'Regulatory compliance code from EPA, if applicable.',
    `compliance_nhtsa_code` STRING COMMENT 'Regulatory compliance code from NHTSA, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the return record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `disposition` STRING COMMENT 'Final disposition of the returned part.. Valid values are `scrap|rework|return_to_supplier|store`',
    `disposition_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition decision was recorded.',
    `failure_analysis_outcome` STRING COMMENT 'Result of OEM failure analysis.. Valid values are `confirmed_defect|no_fault|misdiagnosis|abuse`',
    `failure_description` STRING COMMENT 'Narrative of the part failure as reported.',
    `inspection_status` STRING COMMENT 'Result of any post‑return inspection.. Valid values are `pending|passed|failed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection was performed.',
    `is_critical_part` BOOLEAN COMMENT 'Flag indicating if the part is safety‑critical.',
    `is_recall_related` BOOLEAN COMMENT 'Indicates whether the return is linked to a recall campaign.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier for traceability.',
    `model_year` STRING COMMENT 'Model year of the vehicle associated with the return.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `oem_receipt_date` DATE COMMENT 'Date the OEM received the returned parts.',
    `part_cost` DECIMAL(18,2) COMMENT 'Cost of the part unit as recorded by the OEM.',
    `part_description` STRING COMMENT 'Textual description of the returned part.',
    `part_number` STRING COMMENT 'Manufacturer part number of the returned component.',
    `part_serial_number` STRING COMMENT 'Serial number stamped on the returned part, if applicable.',
    `quality_feedback_status` STRING COMMENT 'Status of the quality feedback loop after analysis.. Valid values are `pending|completed|escalated`',
    `quantity` STRING COMMENT 'Number of units returned.',
    `return_authorization_number` STRING COMMENT 'External reference number authorizing the parts return.',
    `return_reason_code` STRING COMMENT 'Code indicating the business reason for the return.',
    `return_shipment_date` DATE COMMENT 'Date the returned parts were shipped to the OEM.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return.. Valid values are `authorized|shipped|received|analyzed|closed|rejected`',
    `supplier_part_number` STRING COMMENT 'Part number as used by the supplier.',
    `total_return_value` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the returned parts.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity, e.g., pcs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `vehicle_vin` STRING COMMENT 'Unique identifier of the vehicle from which the part was removed.',
    `warranty_type` STRING COMMENT 'Category of warranty covering the part.. Valid values are `basic|extended|powertrain|service`',
    CONSTRAINT pk_warranty_parts_return PRIMARY KEY(`warranty_parts_return_id`)
) COMMENT 'Defective parts return record for components replaced under warranty and returned to the OEM for failure analysis. Captures return authorization number, warranty claim reference, part number, part description, quantity, failure description, return shipment date, OEM receipt date, failure analysis outcome (confirmed defect, no fault found, misdiagnosis, abuse), supplier chargeback flag, and quality feedback loop status. Feeds quality domain FMEA and supplier PPM tracking.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`recall_coverage` (
    `recall_coverage_id` BIGINT COMMENT 'Primary key for the recall_coverage association',
    `nameplate_id` BIGINT COMMENT 'Foreign key linking to the vehicle nameplate',
    `service_campaign_id` BIGINT COMMENT 'Foreign key linking to the service campaign',
    `campaign_number` STRING COMMENT 'Official campaign identifier (recall number) specific to this nameplate linkage',
    `effective_end_date` DATE COMMENT 'Date when the campaign ends for the linked nameplate (nullable if open)',
    `effective_start_date` DATE COMMENT 'Date when the campaign becomes effective for the linked nameplate',
    CONSTRAINT pk_recall_coverage PRIMARY KEY(`recall_coverage_id`)
) COMMENT 'Association representing the coverage of a service campaign (recall) for a specific vehicle nameplate, capturing the effective dates and campaign identifier for each linkage.. Existence Justification: A service campaign (recall) can be applied to multiple vehicle nameplates, and a single nameplate can be subject to multiple campaigns over its lifecycle. The association is actively managed by the OEM with start/end dates and campaign identifiers, making the relationship a distinct business entity.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` (
    `rebate_coverage_id` BIGINT COMMENT 'Primary key for the rebate_coverage association',
    `nameplate_id` BIGINT COMMENT 'Foreign key linking to the vehicle nameplate',
    `rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to the rebate agreement',
    `agreement_status` STRING COMMENT 'Current status of the rebate agreement for this nameplate (e.g., active, draft, expired)',
    `effective_end_date` DATE COMMENT 'Date the rebate coverage expires for this nameplate',
    `effective_start_date` DATE COMMENT 'Date the rebate coverage becomes active for this nameplate',
    `rebate_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to sales of this nameplate under the agreement',
    `target_volume` STRING COMMENT 'Target number of units of this nameplate to be sold to achieve the rebate',
    CONSTRAINT pk_rebate_coverage PRIMARY KEY(`rebate_coverage_id`)
) COMMENT 'Represents the contractual coverage of a rebate agreement for a specific vehicle nameplate. Each record links one nameplate to one rebate agreement and stores the terms that apply to that pairing.. Existence Justification: A vehicle nameplate can be covered by multiple rebate agreements over its lifecycle, and a single rebate agreement can apply to many nameplates (e.g., a dealer incentive that spans a model family). The agreement terms (rates, dates, status, target volume) are managed as a contract and are not intrinsic to either the nameplate or the agreement alone, requiring a link that captures this many‑to‑many participation.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`order_shipment` (
    `order_shipment_id` BIGINT COMMENT 'Primary key for the order_shipment association',
    `aftersales_parts_order_id` BIGINT COMMENT 'Foreign key linking to the parts order',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to the shipment',
    `line_status` STRING COMMENT 'Status of this order‑shipment line (e.g., pending, shipped, cancelled)',
    `quantity` DECIMAL(18,2) COMMENT 'Total quantity of parts requested in the order for this shipment',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity of parts actually shipped in this shipment for the order',
    `tracking_number` STRING COMMENT 'Carrier tracking number for this order‑shipment segment',
    CONSTRAINT pk_order_shipment PRIMARY KEY(`order_shipment_id`)
) COMMENT 'This association product represents the contractual relationship between a parts order and a shipment. It captures the quantity of parts allocated to each shipment, the shipped quantity, line status, and tracking number for each order‑shipment pair.. Existence Justification: A parts order can be fulfilled by multiple outbound shipments, and a single shipment can consolidate parts from multiple orders. The business tracks the quantity shipped, line status, and tracking number for each order‑shipment pair, making the relationship an operational entity that is actively created and maintained.';

CREATE OR REPLACE TABLE `automotive_ecm`.`aftersales`.`market` (
    `market_id` BIGINT COMMENT 'Primary key for market',
    `parent_market_id` BIGINT COMMENT 'Self-referencing FK on market (parent_market_id)',
    `market_code` STRING COMMENT 'Short alphanumeric code used to reference the market in systems.',
    `continent` STRING COMMENT 'Continent where the market is located.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the primary country of the market.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the market record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for transactions in the market.',
    `market_description` STRING COMMENT 'Free‑form description providing additional context about the market.',
    `effective_from` DATE COMMENT 'Date when the market definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the market definition expires (null if open‑ended).',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the market is tax‑exempt (true) or not (false).',
    `language_code` STRING COMMENT 'Two‑letter language code representing the primary language of the market.',
    `market_growth_rate_percent` DECIMAL(18,2) COMMENT 'Annual projected growth rate of the market expressed as a percentage.',
    `market_manager_email` STRING COMMENT 'Email address of the market manager.',
    `market_manager_name` STRING COMMENT 'Name of the internal manager responsible for the market.',
    `market_segment` STRING COMMENT 'Business segment the market belongs to (e.g., luxury, electric).',
    `market_size_usd` DECIMAL(18,2) COMMENT 'Estimated total market size in US dollars.',
    `market_type` STRING COMMENT 'Classification of the market based on its sales scope.',
    `market_name` STRING COMMENT 'Human‑readable name of the market (e.g., "North America").',
    `regulatory_body` STRING COMMENT 'Primary regulatory authority governing the market (e.g., EPA, NHTSA).',
    `sales_channel` STRING COMMENT 'Primary sales channel used in the market.',
    `market_status` STRING COMMENT 'Current lifecycle status of the market record.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Standard sales tax rate applicable in the market.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the market (e.g., "America/New_York").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the market record.',
    CONSTRAINT pk_market PRIMARY KEY(`market_id`)
) COMMENT 'Master reference table for market. Referenced by market_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ADD CONSTRAINT `fk_aftersales_aftersales_model_year_program_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ADD CONSTRAINT `fk_aftersales_aftersales_trim_level_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ADD CONSTRAINT `fk_aftersales_sku_aftersales_trim_level_id` FOREIGN KEY (`aftersales_trim_level_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_trim_level`(`aftersales_trim_level_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ADD CONSTRAINT `fk_aftersales_sku_body_style_id` FOREIGN KEY (`body_style_id`) REFERENCES `automotive_ecm`.`aftersales`.`body_style`(`body_style_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ADD CONSTRAINT `fk_aftersales_sku_color_option_id` FOREIGN KEY (`color_option_id`) REFERENCES `automotive_ecm`.`aftersales`.`color_option`(`color_option_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ADD CONSTRAINT `fk_aftersales_sku_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ADD CONSTRAINT `fk_aftersales_msrp_price_book_superseded_by_price_book_msrp_price_book_id` FOREIGN KEY (`superseded_by_price_book_msrp_price_book_id`) REFERENCES `automotive_ecm`.`aftersales`.`msrp_price_book`(`msrp_price_book_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ADD CONSTRAINT `fk_aftersales_msrp_price_entry_aftersales_trim_level_id` FOREIGN KEY (`aftersales_trim_level_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_trim_level`(`aftersales_trim_level_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ADD CONSTRAINT `fk_aftersales_msrp_price_entry_market_availability_id` FOREIGN KEY (`market_availability_id`) REFERENCES `automotive_ecm`.`aftersales`.`market_availability`(`market_availability_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ADD CONSTRAINT `fk_aftersales_msrp_price_entry_msrp_price_book_id` FOREIGN KEY (`msrp_price_book_id`) REFERENCES `automotive_ecm`.`aftersales`.`msrp_price_book`(`msrp_price_book_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ADD CONSTRAINT `fk_aftersales_msrp_price_entry_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ADD CONSTRAINT `fk_aftersales_msrp_price_entry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `automotive_ecm`.`aftersales`.`sku`(`sku_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ADD CONSTRAINT `fk_aftersales_feature_content_aftersales_trim_level_id` FOREIGN KEY (`aftersales_trim_level_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_trim_level`(`aftersales_trim_level_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ADD CONSTRAINT `fk_aftersales_market_availability_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `automotive_ecm`.`aftersales`.`sku`(`sku_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ADD CONSTRAINT `fk_aftersales_powertrain_config_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ADD CONSTRAINT `fk_aftersales_program_milestone_aftersales_model_year_program_id` FOREIGN KEY (`aftersales_model_year_program_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_model_year_program`(`aftersales_model_year_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ADD CONSTRAINT `fk_aftersales_program_milestone_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ADD CONSTRAINT `fk_aftersales_program_milestone_predecessor_milestone_program_milestone_id` FOREIGN KEY (`predecessor_milestone_program_milestone_id`) REFERENCES `automotive_ecm`.`aftersales`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` ADD CONSTRAINT `fk_aftersales_product_engineering_change_aftersales_model_year_program_id` FOREIGN KEY (`aftersales_model_year_program_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_model_year_program`(`aftersales_model_year_program_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ADD CONSTRAINT `fk_aftersales_option_constraint_aftersales_option_package_id` FOREIGN KEY (`aftersales_option_package_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_option_package`(`aftersales_option_package_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ADD CONSTRAINT `fk_aftersales_option_constraint_aftersales_trim_level_id` FOREIGN KEY (`aftersales_trim_level_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_trim_level`(`aftersales_trim_level_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ADD CONSTRAINT `fk_aftersales_option_constraint_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ADD CONSTRAINT `fk_aftersales_option_constraint_primary_aftersales_option_package_id` FOREIGN KEY (`primary_aftersales_option_package_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_option_package`(`aftersales_option_package_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ADD CONSTRAINT `fk_aftersales_option_constraint_target_option_aftersales_option_package_id` FOREIGN KEY (`target_option_aftersales_option_package_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_option_package`(`aftersales_option_package_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ADD CONSTRAINT `fk_aftersales_option_constraint_target_option_option_package_aftersales_option_package_id` FOREIGN KEY (`target_option_option_package_aftersales_option_package_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_option_package`(`aftersales_option_package_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ADD CONSTRAINT `fk_aftersales_fleet_spec_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ADD CONSTRAINT `fk_aftersales_order_guide_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ADD CONSTRAINT `fk_aftersales_order_guide_superseded_by_order_guide_id` FOREIGN KEY (`superseded_by_order_guide_id`) REFERENCES `automotive_ecm`.`aftersales`.`order_guide`(`order_guide_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ADD CONSTRAINT `fk_aftersales_homologation_variant_aftersales_trim_level_id` FOREIGN KEY (`aftersales_trim_level_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_trim_level`(`aftersales_trim_level_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ADD CONSTRAINT `fk_aftersales_homologation_variant_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ADD CONSTRAINT `fk_aftersales_homologation_variant_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `automotive_ecm`.`aftersales`.`sku`(`sku_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ADD CONSTRAINT `fk_aftersales_product_lifecycle_event_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ADD CONSTRAINT `fk_aftersales_aftersales_repair_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `automotive_ecm`.`aftersales`.`technician`(`technician_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_aftersales_service_appointment_id` FOREIGN KEY (`aftersales_service_appointment_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_service_appointment`(`aftersales_service_appointment_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_aftersales_warranty_claim_id` FOREIGN KEY (`aftersales_warranty_claim_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_warranty_claim`(`aftersales_warranty_claim_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_labor_time_standard_id` FOREIGN KEY (`labor_time_standard_id`) REFERENCES `automotive_ecm`.`aftersales`.`labor_time_standard`(`labor_time_standard_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ADD CONSTRAINT `fk_aftersales_repair_order_line_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `automotive_ecm`.`aftersales`.`technician`(`technician_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ADD CONSTRAINT `fk_aftersales_aftersales_warranty_claim_warranty_policy_id` FOREIGN KEY (`warranty_policy_id`) REFERENCES `automotive_ecm`.`aftersales`.`warranty_policy`(`warranty_policy_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ADD CONSTRAINT `fk_aftersales_warranty_policy_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_warranty_policy_id` FOREIGN KEY (`warranty_policy_id`) REFERENCES `automotive_ecm`.`aftersales`.`warranty_policy`(`warranty_policy_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ADD CONSTRAINT `fk_aftersales_vehicle_warranty_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_contract`(`service_contract_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ADD CONSTRAINT `fk_aftersales_campaign_vin_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ADD CONSTRAINT `fk_aftersales_tsb_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ADD CONSTRAINT `fk_aftersales_aftersales_dtc_event_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ADD CONSTRAINT `fk_aftersales_aftersales_dtc_event_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ADD CONSTRAINT `fk_aftersales_parts_order_line_aftersales_parts_order_id` FOREIGN KEY (`aftersales_parts_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_parts_order`(`aftersales_parts_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ADD CONSTRAINT `fk_aftersales_parts_order_line_service_part_id` FOREIGN KEY (`service_part_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_part`(`service_part_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ADD CONSTRAINT `fk_aftersales_service_contract_warranty_policy_id` FOREIGN KEY (`warranty_policy_id`) REFERENCES `automotive_ecm`.`aftersales`.`warranty_policy`(`warranty_policy_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ADD CONSTRAINT `fk_aftersales_service_contract_claim_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_contract`(`service_contract_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ADD CONSTRAINT `fk_aftersales_goodwill_adjustment_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ADD CONSTRAINT `fk_aftersales_technician_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ADD CONSTRAINT `fk_aftersales_parts_return_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_pdi_inspection` ADD CONSTRAINT `fk_aftersales_aftersales_pdi_inspection_aftersales_service_appointment_id` FOREIGN KEY (`aftersales_service_appointment_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_service_appointment`(`aftersales_service_appointment_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ADD CONSTRAINT `fk_aftersales_customer_satisfaction_survey_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ADD CONSTRAINT `fk_aftersales_customer_satisfaction_survey_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ADD CONSTRAINT `fk_aftersales_customer_satisfaction_survey_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ADD CONSTRAINT `fk_aftersales_loaner_vehicle_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ADD CONSTRAINT `fk_aftersales_loaner_assignment_aftersales_repair_order_id` FOREIGN KEY (`aftersales_repair_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_repair_order`(`aftersales_repair_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ADD CONSTRAINT `fk_aftersales_loaner_assignment_loaner_vehicle_id` FOREIGN KEY (`loaner_vehicle_id`) REFERENCES `automotive_ecm`.`aftersales`.`loaner_vehicle`(`loaner_vehicle_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ADD CONSTRAINT `fk_aftersales_loaner_assignment_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_center`(`service_center_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ADD CONSTRAINT `fk_aftersales_warranty_parts_return_aftersales_warranty_claim_id` FOREIGN KEY (`aftersales_warranty_claim_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_warranty_claim`(`aftersales_warranty_claim_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ADD CONSTRAINT `fk_aftersales_recall_coverage_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ADD CONSTRAINT `fk_aftersales_recall_coverage_service_campaign_id` FOREIGN KEY (`service_campaign_id`) REFERENCES `automotive_ecm`.`aftersales`.`service_campaign`(`service_campaign_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ADD CONSTRAINT `fk_aftersales_rebate_coverage_nameplate_id` FOREIGN KEY (`nameplate_id`) REFERENCES `automotive_ecm`.`aftersales`.`nameplate`(`nameplate_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ADD CONSTRAINT `fk_aftersales_order_shipment_aftersales_parts_order_id` FOREIGN KEY (`aftersales_parts_order_id`) REFERENCES `automotive_ecm`.`aftersales`.`aftersales_parts_order`(`aftersales_parts_order_id`);
ALTER TABLE `automotive_ecm`.`aftersales`.`market` ADD CONSTRAINT `fk_aftersales_market_parent_market_id` FOREIGN KEY (`parent_market_id`) REFERENCES `automotive_ecm`.`aftersales`.`market`(`market_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`aftersales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `automotive_ecm`.`aftersales` SET TAGS ('dbx_domain' = 'aftersales');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assembly Plant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `adas_level` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `adas_level` SET TAGS ('dbx_value_regex' = 'level_0|level_1|level_2|level_3|level_4|level_5');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `body_style_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Body Style');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `cafe_category` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `cafe_category` SET TAGS ('dbx_value_regex' = 'passenger_car|light_truck|exempt');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `competitive_set` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `competitive_set` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `connectivity_capability` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Capability');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `connectivity_capability` SET TAGS ('dbx_value_regex' = 'none|basic|advanced|v2x');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `design_language_theme` SET TAGS ('dbx_business_glossary_term' = 'Design Language Theme');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `emissions_standard_target` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard Target');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `eop_quarter` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Quarter');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `eop_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `eop_year` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Year');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `global_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Availability Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `heritage_lineage` SET TAGS ('dbx_business_glossary_term' = 'Heritage Lineage');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `homologation_markets` SET TAGS ('dbx_business_glossary_term' = 'Homologation Markets');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Lifecycle Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'concept|development|active|phaseout|discontinued');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `market_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Positioning Tier');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `market_positioning_tier` SET TAGS ('dbx_value_regex' = 'entry|mainstream|premium|luxury|performance');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `marketing_tagline` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tagline');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `nameplate_code` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `nameplate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `nameplate_name` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `ncap_rating_target` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Rating Target');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `ncap_rating_target` SET TAGS ('dbx_value_regex' = '3_star|4_star|5_star|not_rated');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `ota_update_enabled` SET TAGS ('dbx_business_glossary_term' = 'Over-the-Air (OTA) Update Enabled');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `platform_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `powertrain_family` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Family');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `powertrain_family` SET TAGS ('dbx_value_regex' = 'ice|hev|phev|bev|fcev');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `predecessor_nameplate_code` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Nameplate Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `predecessor_nameplate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `regional_scope` SET TAGS ('dbx_business_glossary_term' = 'Regional Scope');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `regulatory_class` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Vehicle Class');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `seating_capacity_range` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity Range');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `seating_capacity_range` SET TAGS ('dbx_value_regex' = '^d{1,2}(-d{1,2})?$');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `sop_quarter` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Quarter');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `sop_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `sop_year` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Year');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `target_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Annual Production Volume');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `target_annual_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `target_msrp_max` SET TAGS ('dbx_business_glossary_term' = 'Target Manufacturer Suggested Retail Price (MSRP) Maximum');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `target_msrp_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `target_msrp_min` SET TAGS ('dbx_business_glossary_term' = 'Target Manufacturer Suggested Retail Price (MSRP) Minimum');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `target_msrp_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `vehicle_segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `warranty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Warranty Program Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`nameplate` ALTER COLUMN `warranty_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `aftersales_model_year_program_id` SET TAGS ('dbx_business_glossary_term' = 'Model Year Program Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY) Program ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Model Year Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Plant ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `actual_production_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Volume');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `adas_level` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `adas_level` SET TAGS ('dbx_value_regex' = 'level_0|level_1|level_2|level_3|level_4|level_5');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `bom_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Complexity Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `cafe_target` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Target');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `capex_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `connected_services_enabled` SET TAGS ('dbx_business_glossary_term' = 'Connected Services Enabled');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `eop_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `epa_rating_target` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Rating Target');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `fmea_completed` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Completed');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `homologation_region` SET TAGS ('dbx_business_glossary_term' = 'Homologation Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `homologation_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(,[A-Z]{3})*$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Market Launch Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `msrp_currency` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Currency');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `msrp_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `ncap_target_rating` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Target Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `ncap_target_rating` SET TAGS ('dbx_value_regex' = '1_star|2_star|3_star|4_star|5_star');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `ota_capable` SET TAGS ('dbx_business_glossary_term' = 'Over-the-Air (OTA) Update Capable');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `ppap_status` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `ppap_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|submitted|approved|rejected');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Currency');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_phase` SET TAGS ('dbx_business_glossary_term' = 'Program Phase');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_priority` SET TAGS ('dbx_business_glossary_term' = 'Program Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `sop_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Supplier Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `target_msrp_max` SET TAGS ('dbx_business_glossary_term' = 'Target Manufacturer Suggested Retail Price (MSRP) Maximum');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `target_msrp_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `target_msrp_min` SET TAGS ('dbx_business_glossary_term' = 'Target Manufacturer Suggested Retail Price (MSRP) Minimum');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `target_msrp_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `target_production_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Production Volume');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `tooling_investment` SET TAGS ('dbx_business_glossary_term' = 'Tooling Investment');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `tooling_investment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `vehicle_segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `wltp_target` SET TAGS ('dbx_business_glossary_term' = 'Worldwide Harmonised Light Vehicles Test Procedure (WLTP) Target');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_model_year_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `aftersales_trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `adas_level` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `adas_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|level_3');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `availability_regions` SET TAGS ('dbx_business_glossary_term' = 'Availability Regions');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `battery_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (Kilowatt-Hours)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `body_style` SET TAGS ('dbx_business_glossary_term' = 'Body Style');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `cargo_volume_cu_ft` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume (Cubic Feet)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `drivetrain` SET TAGS ('dbx_business_glossary_term' = 'Drivetrain Configuration');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `drivetrain` SET TAGS ('dbx_value_regex' = 'FWD|RWD|AWD|4WD');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `electric_range_miles` SET TAGS ('dbx_business_glossary_term' = 'Electric Range (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `engine_displacement_liters` SET TAGS ('dbx_business_glossary_term' = 'Engine Displacement (Liters)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `eop_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `epa_city_mpg` SET TAGS ('dbx_business_glossary_term' = 'EPA City Miles Per Gallon (MPG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `epa_combined_mpg` SET TAGS ('dbx_business_glossary_term' = 'EPA Combined Miles Per Gallon (MPG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `epa_highway_mpg` SET TAGS ('dbx_business_glossary_term' = 'EPA Highway Miles Per Gallon (MPG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|E85|electric|hydrogen|hybrid');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `horsepower` SET TAGS ('dbx_business_glossary_term' = 'Horsepower (HP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `invoice_price` SET TAGS ('dbx_business_glossary_term' = 'Dealer Invoice Price');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `invoice_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `is_fleet_eligible` SET TAGS ('dbx_business_glossary_term' = 'Fleet Eligible Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `is_special_edition` SET TAGS ('dbx_business_glossary_term' = 'Special Edition Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `msrp_base_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Base Price');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `msrp_base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'MSRP Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `ncap_overall_rating` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Overall Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `payload_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity (Pounds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'planned|pre_production|active|discontinued|end_of_life');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `sop_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `standard_features_summary` SET TAGS ('dbx_business_glossary_term' = 'Standard Features Summary');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `torque_lb_ft` SET TAGS ('dbx_business_glossary_term' = 'Torque (Pound-Feet)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `towing_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Towing Capacity (Pounds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `trim_code` SET TAGS ('dbx_business_glossary_term' = 'Trim Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `trim_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `trim_description` SET TAGS ('dbx_business_glossary_term' = 'Trim Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `trim_name` SET TAGS ('dbx_business_glossary_term' = 'Trim Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `trim_rank` SET TAGS ('dbx_business_glossary_term' = 'Trim Rank');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `warranty_basic_miles` SET TAGS ('dbx_business_glossary_term' = 'Basic Warranty Mileage Limit (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `warranty_basic_months` SET TAGS ('dbx_business_glossary_term' = 'Basic Warranty Duration (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `warranty_powertrain_miles` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Warranty Mileage Limit (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_trim_level` ALTER COLUMN `warranty_powertrain_months` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Warranty Duration (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `aftersales_option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Option Package ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `attachment_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Attachment Rate (Percent)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `available_markets` SET TAGS ('dbx_business_glossary_term' = 'Available Markets');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `available_model_years` SET TAGS ('dbx_business_glossary_term' = 'Available Model Years');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `available_trim_levels` SET TAGS ('dbx_business_glossary_term' = 'Available Trim Levels');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `bom_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Reference Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `content_description` SET TAGS ('dbx_business_glossary_term' = 'Content Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `dealer_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Dealer Cost Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `dealer_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `emissions_impact_grams_co2_km` SET TAGS ('dbx_business_glossary_term' = 'Emissions Impact (Grams CO2 per Kilometer)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `excludes_package_codes` SET TAGS ('dbx_business_glossary_term' = 'Excludes Package Codes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `fuel_economy_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Economy Impact (Percent)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `included_in_package_codes` SET TAGS ('dbx_business_glossary_term' = 'Included In Package Codes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `installation_location` SET TAGS ('dbx_business_glossary_term' = 'Installation Location');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `installation_location` SET TAGS ('dbx_value_regex' = 'factory|port|dealer');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Introduction Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Is Orderable');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `is_visible_to_customer` SET TAGS ('dbx_business_glossary_term' = 'Is Visible to Customer');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|active|phasing_out|discontinued|obsolete');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'MSRP Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'group|standalone|accessory|dealer_installed|port_installed');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `production_feasibility_status` SET TAGS ('dbx_business_glossary_term' = 'Production Feasibility Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `production_feasibility_status` SET TAGS ('dbx_value_regex' = 'feasible|constrained|unavailable|pending_validation');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `requires_package_codes` SET TAGS ('dbx_business_glossary_term' = 'Requires Package Codes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `sales_rank` SET TAGS ('dbx_business_glossary_term' = 'Sales Rank');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `warranty_miles` SET TAGS ('dbx_business_glossary_term' = 'Warranty Miles');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Months');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_option_package` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `aftersales_trim_level_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `body_style_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `color_option_id` SET TAGS ('dbx_business_glossary_term' = 'Color Option Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `production_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Production Bill of Materials (BOM) Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `adas_level` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `adas_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|level_3|level_4|level_5');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `battery_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (Kilowatt-Hours)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `cargo_volume_cu_ft` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume (Cubic Feet)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `curb_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Curb Weight (Pounds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `door_count` SET TAGS ('dbx_business_glossary_term' = 'Door Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `drivetrain_type` SET TAGS ('dbx_business_glossary_term' = 'Drivetrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `drivetrain_type` SET TAGS ('dbx_value_regex' = 'FWD|RWD|AWD|4WD');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `electric_range_miles` SET TAGS ('dbx_business_glossary_term' = 'Electric Range (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `engine_displacement_liters` SET TAGS ('dbx_business_glossary_term' = 'Engine Displacement (Liters)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `eop_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `epa_city_mpg` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) City Miles Per Gallon (MPG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `epa_combined_mpg` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Combined Miles Per Gallon (MPG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `epa_highway_mpg` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Highway Miles Per Gallon (MPG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `gvwr_lbs` SET TAGS ('dbx_business_glossary_term' = 'Gross Vehicle Weight Rating (GVWR) Pounds');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `horsepower` SET TAGS ('dbx_business_glossary_term' = 'Horsepower (HP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `interior_color_code` SET TAGS ('dbx_business_glossary_term' = 'Interior Color Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `interior_color_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `interior_material_type` SET TAGS ('dbx_business_glossary_term' = 'Interior Material Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `interior_material_type` SET TAGS ('dbx_value_regex' = 'cloth|leather|synthetic_leather|alcantara|vinyl');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `invoice_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Price Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `invoice_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Lifecycle Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|active|orderable|production|phasing_out|discontinued');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `market_destination_code` SET TAGS ('dbx_business_glossary_term' = 'Market Destination Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `market_destination_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `ncap_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Safety Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `ncap_safety_rating` SET TAGS ('dbx_value_regex' = '^[1-5]$|not_rated');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `option_package_codes` SET TAGS ('dbx_business_glossary_term' = 'Option Package Codes');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `orderable_end_date` SET TAGS ('dbx_business_glossary_term' = 'Orderable End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `orderable_start_date` SET TAGS ('dbx_business_glossary_term' = 'Orderable Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `powertrain_code` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `powertrain_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `sop_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `torque_lb_ft` SET TAGS ('dbx_business_glossary_term' = 'Torque (Pound-Feet)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `towing_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Towing Capacity (Pounds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `transmission_speed_count` SET TAGS ('dbx_business_glossary_term' = 'Transmission Speed Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `transmission_type` SET TAGS ('dbx_value_regex' = 'manual|automatic|cvt|dct|amt');
ALTER TABLE `automotive_ecm`.`aftersales`.`sku` ALTER COLUMN `wheelbase_inches` SET TAGS ('dbx_business_glossary_term' = 'Wheelbase (Inches)');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Price Book ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `superseded_by_price_book_msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price Book ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `dealer_access_level` SET TAGS ('dbx_business_glossary_term' = 'Dealer Access Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `dealer_access_level` SET TAGS ('dbx_value_regex' = 'public|authorized_dealer|franchise_only|internal');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `destination_charge_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Destination Charge Included Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `model_year` SET TAGS ('dbx_value_regex' = '^(19|20)d{2}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `msrp_price_book_status` SET TAGS ('dbx_business_glossary_term' = 'Price Book Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `msrp_price_book_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|active|superseded|archived');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_book_code` SET TAGS ('dbx_business_glossary_term' = 'Price Book Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_book_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_book_name` SET TAGS ('dbx_business_glossary_term' = 'Price Book Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_business_glossary_term' = 'Price Book Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_value_regex' = 'standard|fleet|government|export|promotional');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_list_category` SET TAGS ('dbx_business_glossary_term' = 'Price List Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `price_list_category` SET TAGS ('dbx_value_regex' = 'base|option|package|accessory|destination');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `publication_format` SET TAGS ('dbx_business_glossary_term' = 'Publication Format');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `publication_format` SET TAGS ('dbx_value_regex' = 'pdf|xml|json|edi|print');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_book` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `msrp_price_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Price Entry Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `aftersales_trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `market_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `advertising_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Advertising Fee Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `base_msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `dealer_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Dealer Invoice Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `dealer_invoice_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `destination_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Destination Charge Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `employee_pricing_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Pricing Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `employee_pricing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `fleet_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fleet Eligible Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `gas_guzzler_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Gas Guzzler Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `government_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Government Eligible Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `holdback_percentage` SET TAGS ('dbx_business_glossary_term' = 'Holdback Percentage');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `holdback_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `luxury_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Luxury Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `price_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|expired|withdrawn');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `prior_msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `supplier_pricing_amount` SET TAGS ('dbx_business_glossary_term' = 'Supplier Pricing Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `supplier_pricing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`msrp_price_entry` ALTER COLUMN `total_msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_content_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Content ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `aftersales_trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'standard|optional|package_only|not_available');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `content_source_code` SET TAGS ('dbx_business_glossary_term' = 'Content Source System ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `content_source_system` SET TAGS ('dbx_business_glossary_term' = 'Content Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `customer_demand_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Demand Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `dealer_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Dealer Cost Impact Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `dealer_cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `ecu_dependency_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Control Unit (ECU) Dependency Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_category` SET TAGS ('dbx_business_glossary_term' = 'Feature Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_category` SET TAGS ('dbx_value_regex' = 'safety|technology|comfort|performance|exterior|interior');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_code` SET TAGS ('dbx_business_glossary_term' = 'Feature Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_description_long` SET TAGS ('dbx_business_glossary_term' = 'Feature Long Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_description_short` SET TAGS ('dbx_business_glossary_term' = 'Feature Short Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Content Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|pending|under_review');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `feature_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Feature Subcategory');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `fuel_economy_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Economy Impact Percentage');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `installation_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Installation Time in Minutes');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `is_adas_feature` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Feature Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `is_ev_specific` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Specific Feature Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `is_hev_specific` SET TAGS ('dbx_business_glossary_term' = 'Hybrid Electric Vehicle (HEV) Specific Feature Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `is_regulatory_mandated` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandated Feature Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `market_availability_region` SET TAGS ('dbx_business_glossary_term' = 'Market Availability Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `marketing_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Marketing Priority Rank');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `model_year_discontinued` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY) Discontinued');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `model_year_introduced` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY) Introduced');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'MSRP Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `msrp_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Impact Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `msrp_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `ota_updateable_flag` SET TAGS ('dbx_business_glossary_term' = 'Over-the-Air (OTA) Updateable Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `safety_rating_impact` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating Impact Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `safety_rating_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `supplier_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `technology_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Level Classification');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `technology_level` SET TAGS ('dbx_value_regex' = 'basic|advanced|premium|luxury');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `warranty_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Extension in Months');
ALTER TABLE `automotive_ecm`.`aftersales`.`feature_content` ALTER COLUMN `weight_impact_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Impact in Kilograms (kg)');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `market_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Market Availability ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `allocation_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocation Constraint Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `assembly_mode` SET TAGS ('dbx_business_glossary_term' = 'Assembly Mode (CBU/CKD/SKD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `assembly_mode` SET TAGS ('dbx_value_regex' = 'cbu|ckd|skd');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|restricted|not-offered|discontinued|pre-order|limited');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `dealer_ordering_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Ordering Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `dealer_ordering_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `destination_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Destination Charge Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `ev_battery_warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Battery Warranty Duration Months');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `fuel_economy_rating` SET TAGS ('dbx_business_glossary_term' = 'Fuel Economy Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `fuel_economy_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Economy Unit');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `fuel_economy_unit` SET TAGS ('dbx_value_regex' = 'mpg|l-per-100km|kwh-per-100km|km-per-l');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `government_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Government Incentive Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `homologation_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `homologation_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `homologation_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not-required|expired');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `homologation_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Homologation Certificate Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `homologation_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `homologation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Homologation Expiry Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `import_duty_classification` SET TAGS ('dbx_business_glossary_term' = 'Import Duty Classification');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `import_duty_classification` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `import_duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Import Duty Rate Percent');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `incentive_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligible Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `local_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Local Content Percent');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'MSRP Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `nameplate_code` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `nameplate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,15}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `option_package_code` SET TAGS ('dbx_business_glossary_term' = 'Option Package Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `option_package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `ordering_priority` SET TAGS ('dbx_business_glossary_term' = 'Ordering Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `powertrain_warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Warranty Duration Months');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `pre_delivery_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `record_source_system` SET TAGS ('dbx_value_regex' = 'sap-sd|plm|dms|pricing-engine|manual');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = '^[0-5]-star$|not-rated');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|fleet|government|export|direct|online');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `trim_level_code` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `trim_level_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `warranty_mileage` SET TAGS ('dbx_business_glossary_term' = 'Warranty Mileage Limit');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration Months');
ALTER TABLE `automotive_ecm`.`aftersales`.`market_availability` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_config_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Configuration ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Spec Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `aspiration_type` SET TAGS ('dbx_business_glossary_term' = 'Aspiration Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `aspiration_type` SET TAGS ('dbx_value_regex' = 'naturally_aspirated|turbocharged|supercharged|twin_turbo');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `battery_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (Kilowatt-Hours)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `battery_chemistry` SET TAGS ('dbx_business_glossary_term' = 'Battery Chemistry Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `battery_chemistry` SET TAGS ('dbx_value_regex' = 'none|lithium_ion|nickel_metal_hydride|solid_state|lithium_iron_phosphate');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `cafe_credit_value` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Credit Value');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `charging_capability` SET TAGS ('dbx_business_glossary_term' = 'Charging Capability Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `charging_capability` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|dc_fast_charge|ultra_fast_charge');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `co2_emissions_g_km` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions (Grams per Kilometer)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `combined_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Combined Horsepower (HP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `combined_torque_nm` SET TAGS ('dbx_business_glossary_term' = 'Combined Torque (Newton-Meters)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `cylinder_count` SET TAGS ('dbx_business_glossary_term' = 'Cylinder Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `dealer_invoice_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Dealer Invoice Cost (US Dollars)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `dealer_invoice_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `drivetrain_layout` SET TAGS ('dbx_business_glossary_term' = 'Drivetrain Layout');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `drivetrain_layout` SET TAGS ('dbx_value_regex' = 'fwd|rwd|awd|4wd');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `electric_motor_position` SET TAGS ('dbx_business_glossary_term' = 'Electric Motor Position');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `electric_motor_position` SET TAGS ('dbx_value_regex' = 'none|front|rear|front_rear|integrated');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `electric_motor_type` SET TAGS ('dbx_business_glossary_term' = 'Electric Motor Configuration');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `electric_motor_type` SET TAGS ('dbx_value_regex' = 'none|single_motor|dual_motor|tri_motor|quad_motor');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard Certification');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_value_regex' = 'euro_6|tier_3|lev_iii|ulev|sulev|zlev');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `end_of_production_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `engine_configuration` SET TAGS ('dbx_business_glossary_term' = 'Engine Configuration');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `engine_configuration` SET TAGS ('dbx_value_regex' = 'inline|v_type|flat|rotary|w_type');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `engine_displacement_liters` SET TAGS ('dbx_business_glossary_term' = 'Engine Displacement (Liters)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `epa_city_mpg` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) City Fuel Economy (Miles Per Gallon)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `epa_combined_mpg` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Combined Fuel Economy (Miles Per Gallon)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `epa_electric_range_miles` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) All-Electric Range (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `epa_highway_mpg` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Highway Fuel Economy (Miles Per Gallon)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|electric|hydrogen|flex_fuel|cng');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `homologation_status` SET TAGS ('dbx_business_glossary_term' = 'Homologation Certification Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `homologation_status` SET TAGS ('dbx_value_regex' = 'certified|pending|not_required|expired');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `manufacturing_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Cost (US Dollars)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `manufacturing_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `market_availability` SET TAGS ('dbx_business_glossary_term' = 'Market Availability Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `market_availability` SET TAGS ('dbx_value_regex' = 'global|north_america|europe|asia_pacific|china|japan');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `max_charging_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charging Power (Kilowatts)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `msrp_base_usd` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Base Amount (US Dollars)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `msrp_base_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `payload_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload Capacity (Pounds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_code` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_config_status` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Configuration Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_config_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|planned|phase_out');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_name` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Marketing Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV|MHEV');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `start_of_production_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `towing_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Towing Capacity (Pounds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `transmission_speeds` SET TAGS ('dbx_business_glossary_term' = 'Transmission Speed Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `transmission_type` SET TAGS ('dbx_value_regex' = 'manual|automatic|cvt|dct|amt|single_speed');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `warranty_battery_miles` SET TAGS ('dbx_business_glossary_term' = 'Battery Warranty Mileage Limit (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `warranty_battery_months` SET TAGS ('dbx_business_glossary_term' = 'Battery Warranty Duration (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `warranty_powertrain_miles` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Warranty Mileage Limit (Miles)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `warranty_powertrain_months` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Warranty Duration (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `wltp_city_range_km` SET TAGS ('dbx_business_glossary_term' = 'Worldwide Harmonised Light Vehicles Test Procedure (WLTP) City Range (Kilometers)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `wltp_combined_range_km` SET TAGS ('dbx_business_glossary_term' = 'Worldwide Harmonised Light Vehicles Test Procedure (WLTP) Combined Range (Kilometers)');
ALTER TABLE `automotive_ecm`.`aftersales`.`powertrain_config` ALTER COLUMN `zero_to_sixty_seconds` SET TAGS ('dbx_business_glossary_term' = 'Zero to Sixty Miles Per Hour Acceleration Time (Seconds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_id` SET TAGS ('dbx_business_glossary_term' = 'Body Style Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `aerodynamic_profile` SET TAGS ('dbx_business_glossary_term' = 'Aerodynamic Profile Classification');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `aerodynamic_profile` SET TAGS ('dbx_value_regex' = 'low_drag|standard|high_profile|utility');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `bed_length_inches` SET TAGS ('dbx_business_glossary_term' = 'Bed Length in Inches');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `bed_type` SET TAGS ('dbx_value_regex' = 'short|standard|long|extra_long|not_applicable');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Body Structure Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_structure_type` SET TAGS ('dbx_value_regex' = 'unibody|body_on_frame|space_frame|monocoque');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_category` SET TAGS ('dbx_business_glossary_term' = 'Body Style Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_code` SET TAGS ('dbx_business_glossary_term' = 'Body Style Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_description` SET TAGS ('dbx_business_glossary_term' = 'Body Style Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_name` SET TAGS ('dbx_business_glossary_term' = 'Body Style Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_status` SET TAGS ('dbx_business_glossary_term' = 'Body Style Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `body_style_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|planned|concept|archived');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `cab_configuration` SET TAGS ('dbx_business_glossary_term' = 'Cab Configuration');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `cab_configuration` SET TAGS ('dbx_value_regex' = 'regular|extended|crew|mega|not_applicable');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `cargo_volume_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume in Cubic Feet');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `cargo_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume in Liters');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `competitive_set` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `door_count` SET TAGS ('dbx_business_glossary_term' = 'Door Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `end_model_year` SET TAGS ('dbx_business_glossary_term' = 'End Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `generation` SET TAGS ('dbx_business_glossary_term' = 'Body Style Generation Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `generation` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `ground_clearance_category` SET TAGS ('dbx_business_glossary_term' = 'Ground Clearance Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `ground_clearance_category` SET TAGS ('dbx_value_regex' = 'low|standard|raised|high');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `homologation_class` SET TAGS ('dbx_business_glossary_term' = 'Homologation Class');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `is_commercial_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Is Commercial Vehicle Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `is_light_truck` SET TAGS ('dbx_business_glossary_term' = 'Is Light Truck Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `is_passenger_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Is Passenger Vehicle Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `manufacturing_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Complexity Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `market_availability` SET TAGS ('dbx_business_glossary_term' = 'Market Availability Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `msrp_base_usd` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Base in United States Dollars (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `msrp_base_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `ncap_body_type` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Body Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `roof_type` SET TAGS ('dbx_business_glossary_term' = 'Roof Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `seating_row_count` SET TAGS ('dbx_business_glossary_term' = 'Seating Row Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `sku_prefix` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Prefix');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `sku_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'PLM|ERP|MDM|MANUAL');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `start_model_year` SET TAGS ('dbx_business_glossary_term' = 'Start Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `vehicle_segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `wheelbase_category` SET TAGS ('dbx_business_glossary_term' = 'Wheelbase Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `wheelbase_category` SET TAGS ('dbx_value_regex' = 'short|standard|long|extended');
ALTER TABLE `automotive_ecm`.`aftersales`.`body_style` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_option_id` SET TAGS ('dbx_business_glossary_term' = 'Color Option ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Color Availability Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_availability_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|limited_availability|pre_launch|phase_out');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_description` SET TAGS ('dbx_business_glossary_term' = 'Color Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_durability_rating` SET TAGS ('dbx_business_glossary_term' = 'Color Durability Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_durability_rating` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_family` SET TAGS ('dbx_business_glossary_term' = 'Color Family');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_image_url` SET TAGS ('dbx_business_glossary_term' = 'Color Image Uniform Resource Locator (URL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_match_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Color Match Tolerance');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_name` SET TAGS ('dbx_business_glossary_term' = 'Color Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_type` SET TAGS ('dbx_business_glossary_term' = 'Color Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `color_type` SET TAGS ('dbx_value_regex' = 'exterior|interior|both');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `end_of_production_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `historical_sales_volume` SET TAGS ('dbx_business_glossary_term' = 'Historical Sales Volume');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `historical_sales_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `interior_material_type` SET TAGS ('dbx_business_glossary_term' = 'Interior Material Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `marketing_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Marketing Priority Rank');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `msrp_uplift_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Uplift Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `package_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Package Compatibility');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `paint_code_supplier` SET TAGS ('dbx_business_glossary_term' = 'Paint Code Supplier Reference');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `paint_technology` SET TAGS ('dbx_business_glossary_term' = 'Paint Technology');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `paint_technology` SET TAGS ('dbx_value_regex' = 'solid|metallic|pearl|matte|tri-coat|multi-stage');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `production_cost_delta` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Delta');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `production_cost_delta` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `special_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Order Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `start_of_production_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `touch_up_paint_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Touch-Up Paint Available Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `trim_level_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Compatibility');
ALTER TABLE `automotive_ecm`.`aftersales`.`color_option` ALTER COLUMN `voc_content_grams_per_liter` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compound (VOC) Content Grams Per Liter');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `program_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Program Milestone Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `aftersales_model_year_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `predecessor_milestone_program_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `responsible_person_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `deliverable_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Completed Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `external_dependency_description` SET TAGS ('dbx_business_glossary_term' = 'External Dependency Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `external_dependency_flag` SET TAGS ('dbx_business_glossary_term' = 'External Dependency Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `gate_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Comments');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Outcome');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|deferred|rejected');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `gate_review_required` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|achieved|delayed|waived|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'program_gate|design_gate|quality_gate|production_gate|regulatory_gate|commercial_gate');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `program_phase` SET TAGS ('dbx_business_glossary_term' = 'Program Phase');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `responsible_function` SET TAGS ('dbx_business_glossary_term' = 'Responsible Function');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Variance Days');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By Person Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `automotive_ecm`.`aftersales`.`program_milestone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` ALTER COLUMN `product_engineering_change_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for product_engineering_change');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` ALTER COLUMN `aftersales_model_year_program_id` SET TAGS ('dbx_business_glossary_term' = 'Model Year Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_engineering_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `option_constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Option Constraint Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `aftersales_option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Source Option Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `aftersales_trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `primary_aftersales_option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Source Option Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `target_option_aftersales_option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Target Option Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `target_option_option_package_aftersales_option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Target Option Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `applies_to_fleet` SET TAGS ('dbx_business_glossary_term' = 'Applies to Fleet Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `applies_to_retail` SET TAGS ('dbx_business_glossary_term' = 'Applies to Retail Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `bom_impact` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Impact');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `bom_impact` SET TAGS ('dbx_value_regex' = 'none|minor|major|critical');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Request (ECR) Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `configurator_display_order` SET TAGS ('dbx_business_glossary_term' = 'Configurator Display Order');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_code` SET TAGS ('dbx_business_glossary_term' = 'Constraint Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Constraint Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_priority` SET TAGS ('dbx_business_glossary_term' = 'Constraint Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_source` SET TAGS ('dbx_business_glossary_term' = 'Constraint Source');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_source` SET TAGS ('dbx_value_regex' = 'engineering|regulatory|commercial|manufacturing|supply_chain');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_business_glossary_term' = 'Constraint Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|superseded');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'requires|excludes|includes|upgrades|replaces|prerequisite');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `fmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Reference');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `homologation_region` SET TAGS ('dbx_business_glossary_term' = 'Homologation Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `homologation_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `is_hard_constraint` SET TAGS ('dbx_business_glossary_term' = 'Hard Constraint Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `lead_time_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Impact Days');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `manufacturing_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Complexity Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `msrp_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Impact Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `msrp_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'MSRP Impact Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `msrp_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Constraint Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `override_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `override_approval_level` SET TAGS ('dbx_value_regex' = 'none|dealer_manager|regional_manager|oem_product_planner|oem_executive');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `ppap_required` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `supplier_constraint` SET TAGS ('dbx_business_glossary_term' = 'Supplier Constraint Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`option_constraint` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` SET TAGS ('dbx_subdomain' = 'dealer_management');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Specification ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `account_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `customer_fleet_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_customer_customer_fleet_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `actual_volume_ytd` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Year-to-Date (YTD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Commitment');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `approved_option_packages` SET TAGS ('dbx_business_glossary_term' = 'Approved Option Packages');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `approved_trim_levels` SET TAGS ('dbx_business_glossary_term' = 'Approved Trim Levels');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Fleet Customer Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_customer_segment` SET TAGS ('dbx_value_regex' = 'government|corporate|rental|utility|emergency_services|municipal');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fleet Discount Percentage');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_msrp_base` SET TAGS ('dbx_business_glossary_term' = 'Fleet Manufacturer Suggested Retail Price (MSRP) Base');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_net_price` SET TAGS ('dbx_business_glossary_term' = 'Fleet Net Price');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_net_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Fleet Priority Rank');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_spec_code` SET TAGS ('dbx_business_glossary_term' = 'Fleet Specification Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `fleet_spec_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `homologation_region` SET TAGS ('dbx_business_glossary_term' = 'Homologation Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `homologation_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `primary_use_case` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Case');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `service_contract_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Included Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `spec_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `spec_notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `special_equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Requirements');
ALTER TABLE `automotive_ecm`.`aftersales`.`fleet_spec` ALTER COLUMN `warranty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Warranty Program Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` SET TAGS ('dbx_subdomain' = 'dealer_management');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Order Guide Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `primary_order_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `primary_order_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `primary_order_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `superseded_by_order_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Order Guide Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `tertiary_order_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `tertiary_order_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `tertiary_order_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'turn_and_earn|historical_sales|market_share|equal_distribution|custom');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|conditional_approval');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `base_msrp_max` SET TAGS ('dbx_business_glossary_term' = 'Base Manufacturer Suggested Retail Price (MSRP) Maximum');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `base_msrp_min` SET TAGS ('dbx_business_glossary_term' = 'Base Manufacturer Suggested Retail Price (MSRP) Minimum');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `build_to_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Build To Stock Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `cafe_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `color_option_count` SET TAGS ('dbx_business_glossary_term' = 'Color Option Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `dealer_invoice_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Dealer Invoice Discount Percentage');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `dealer_invoice_discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_value_regex' = 'EPA_TIER3|CARB_LEV3|EURO6|EURO7|CHINA6|BS6');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `fleet_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fleet Eligible Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `homologation_region` SET TAGS ('dbx_business_glossary_term' = 'Homologation Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `incentive_program_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Eligible Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `lead_time_days_max` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days Maximum');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `lead_time_days_min` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days Minimum');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `msrp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `option_package_count` SET TAGS ('dbx_business_glossary_term' = 'Option Package Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_bank_close_date` SET TAGS ('dbx_business_glossary_term' = 'Order Bank Close Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_bank_open_date` SET TAGS ('dbx_business_glossary_term' = 'Order Bank Open Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_guide_code` SET TAGS ('dbx_business_glossary_term' = 'Order Guide Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_guide_code` SET TAGS ('dbx_value_regex' = '^OG-[A-Z0-9]{6,12}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_guide_description` SET TAGS ('dbx_business_glossary_term' = 'Order Guide Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_guide_name` SET TAGS ('dbx_business_glossary_term' = 'Order Guide Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `order_guide_status` SET TAGS ('dbx_business_glossary_term' = 'Order Guide Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `orderable_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Orderable Stock Keeping Unit (SKU) Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `ordering_instructions_url` SET TAGS ('dbx_business_glossary_term' = 'Ordering Instructions Uniform Resource Locator (URL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `ordering_instructions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `production_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Production Plant Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `production_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|fleet|government|export|internal|demo');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `special_order_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Order Allowed Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_guide` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `homologation_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Variant Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `aftersales_trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Trim Level Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `adas_level` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Automation Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `adas_level` SET TAGS ('dbx_value_regex' = 'Level 0|Level 1|Level 2|Level 3|Level 4|Level 5');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Authority');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `bom_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Impact Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `cafe_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `cost_delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Homologation Cost Delta Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `cost_delta_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `cost_delta_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Delta Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `cost_delta_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Homologation Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `emissions_standard_target` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard Target');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Homologation Expiry Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Homologation Lead Time in Days');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `modification_description` SET TAGS ('dbx_business_glossary_term' = 'Required Modification Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type Classification');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `modification_type` SET TAGS ('dbx_value_regex' = 'Hardware|Software|Calibration|Documentation|Labeling|Testing');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `ncap_rating` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Safety Rating');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `ota_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Over-the-Air (OTA) Update Capable Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Framework');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Homologation Engineer Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `target_market_code` SET TAGS ('dbx_business_glossary_term' = 'Target Market Country Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `target_market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `target_region` SET TAGS ('dbx_business_glossary_term' = 'Target Geographic Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `target_region` SET TAGS ('dbx_value_regex' = 'North America|Europe|Asia Pacific|Latin America|Middle East|Africa');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `testing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `variant_code` SET TAGS ('dbx_business_glossary_term' = 'Homologation Variant Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `variant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `variant_name` SET TAGS ('dbx_business_glossary_term' = 'Homologation Variant Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `variant_status` SET TAGS ('dbx_business_glossary_term' = 'Homologation Variant Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`homologation_variant` ALTER COLUMN `wltp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Worldwide Harmonised Light Vehicles Test Procedure (WLTP) Certified Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `product_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Event Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `affected_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `affected_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_value_regex' = 'nameplate|model_year_program|sku|trim_level|platform|powertrain');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `announcement_type` SET TAGS ('dbx_business_glossary_term' = 'Announcement Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `announcement_type` SET TAGS ('dbx_value_regex' = 'internal|public|regulatory|confidential');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `customer_communication_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Communication Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `dealer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Dealer Notification Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `dealer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dealer Notification Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `engineering_change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'milestone|phase_gate|regulatory|commercial|operational');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|completed|cancelled|postponed');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `impact_level` SET TAGS ('dbx_business_glossary_term' = 'Impact Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New State');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `press_release_reference` SET TAGS ('dbx_business_glossary_term' = 'Press Release Reference');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `prior_state` SET TAGS ('dbx_business_glossary_term' = 'Prior State');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `production_volume_impact` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Impact');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `supplier_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Supplier Impact Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `triggering_authority` SET TAGS ('dbx_business_glossary_term' = 'Triggering Authority');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `triggering_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Triggering Authority Identifier (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`product_lifecycle_event` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Variance Days');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for repair_order');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `connected_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Vehicle Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Advisor ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_advisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Advisor ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `vehicle_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `actual_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `aftersales_repair_order_status` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `aftersales_repair_order_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|quality_check|closed|invoiced|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `appointment_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Arrival Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `appointment_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Departure Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `appointment_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Scheduled Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Close Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `customer_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `customer_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `diagnostic_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Trouble Code (DTC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `diagnostic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `is_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimate Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate per Hour (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `labor_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Total Cost (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `labor_total_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Total Hours');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `mileage_at_service` SET TAGS ('dbx_business_glossary_term' = 'Mileage at Service (MILEAGE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Open Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `parts_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Total Cost (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|bank_transfer|mobile_payment|check');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|failed|refunded');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `promised_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Promised Completion Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `ro_number` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Number (RO)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_center_region` SET TAGS ('dbx_business_glossary_term' = 'Service Center Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_center_region` SET TAGS ('dbx_value_regex' = 'North|South|East|West|Central');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_priority` SET TAGS ('dbx_business_glossary_term' = 'Service Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'maintenance|repair|recall|campaign|diagnostic');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `technician_notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_repair_order` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'manufacturer|extended|service_contract');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `repair_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Line ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `aftersales_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `aftersales_warranty_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Time Standard Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Sublet Vendor ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Sublet Vendor ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `actual_technician_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Technician Hours');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `cause_complaint` SET TAGS ('dbx_business_glossary_term' = 'Cause / Complaint Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `correction` SET TAGS ('dbx_business_glossary_term' = 'Correction Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CNY');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|diagnostic|body|software');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (Currency per Hour)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Labor Skill Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|master|specialist');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `labor_time_standard` SET TAGS ('dbx_business_glossary_term' = 'Labor Time Standard (Hours)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|canceled');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `operation_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Operation Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Applied Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `part_price` SET TAGS ('dbx_business_glossary_term' = 'Part Unit Price');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `part_quantity` SET TAGS ('dbx_business_glossary_term' = 'Part Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `parts_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Used Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `sublet_cost` SET TAGS ('dbx_business_glossary_term' = 'Sublet Cost Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `sublet_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublet Service Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`repair_order_line` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Covered Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `aftersales_warranty_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for warranty_claim');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Created By Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Recall Campaign Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `remote_diagnostic_session_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `vehicle_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `warranty_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `warranty_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reserve Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Outcome');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|partial|pending');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `approved_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Approved Labor Cost');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `approved_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Approved Labor Hours');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `approved_parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Approved Parts Cost');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_adjusted_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjusted Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_category` SET TAGS ('dbx_business_glossary_term' = 'Claim Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_category` SET TAGS ('dbx_value_regex' = 'repair|recall|service_campaign|maintenance');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_created_by` SET TAGS ('dbx_business_glossary_term' = 'Claim Created By');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|adjusted|paid');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `claim_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CAD|GBP|CNY');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `failure_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `goodwill_flag` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `parts_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Parts Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `repair_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `repair_order_number` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `total_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_warranty_claim` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'bumper_to_bumper|powertrain|corrosion|roadside_assistance');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `warranty_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `authorized_dealer_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Dealer Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `claim_limit_per_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Warranty Claim Limit');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `claim_limit_total` SET TAGS ('dbx_business_glossary_term' = 'Total Warranty Claim Limit');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'basic|powertrain|corrosion|emissions|ev_battery|adas');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Deductible Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `eop_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Exclusions');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `extension_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Extension Allowed Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `extension_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Extension Terms');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `inclusions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Inclusions');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `mileage_limit` SET TAGS ('dbx_business_glossary_term' = 'Warranty Mileage Limit');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|terminated');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `renewal_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Renewal Allowed Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Renewal Terms');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `service_center_network` SET TAGS ('dbx_business_glossary_term' = 'Service Center Network');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `sop_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_policy` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transferability Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `vehicle_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Warranty ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Warranty Policy Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `recall_recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `claims_last_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Warranty Claim Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `claims_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Warranty Claim Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `coverage_area` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Area');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `coverage_area` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Coverage Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `coverage_end_mileage` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage End Mileage');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `coverage_start_mileage` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Start Mileage');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `cpo_warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Pre‑Owned Warranty Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `eligible_for_recall` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Recall');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Exclusions');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `extended_warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `last_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Last Warranty Transfer Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `mileage_limit` SET TAGS ('dbx_business_glossary_term' = 'Warranty Mileage Limit');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `original_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Original Purchase Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Warranty Program Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'new_vehicle|used_vehicle|cpo|extended');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Warranty Program Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `remaining_mileage` SET TAGS ('dbx_business_glossary_term' = 'Remaining Warranty Mileage');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `remaining_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Warranty Months');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Renewal Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Renewal Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `service_plan` SET TAGS ('dbx_business_glossary_term' = 'Warranty Service Plan');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status Reason');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `status_reason` SET TAGS ('dbx_value_regex' = 'normal|customer_cancel|manufacturer_recall|non_payment');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transfer Allowed');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `transfer_count` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transfer Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `transfer_fee` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transfer Fee');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `vehicle_warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `vehicle_warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|voided|suspended|transferred');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_claims_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_document_url` SET TAGS ('dbx_business_glossary_term' = 'Warranty Document URL');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_terms_version` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms Version');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`vehicle_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'bumper_to_bumper|powertrain|corrosion|roadside_assistance|extended');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Campaign Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `affected_model_year_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Model Year End');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `affected_model_year_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Model Year Start');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `affected_vin_population` SET TAGS ('dbx_business_glossary_term' = 'Affected VIN Population');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Campaign Cost Estimate');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_priority` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_region` SET TAGS ('dbx_business_glossary_term' = 'Campaign Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_region` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|EU|JP|KR');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|completed|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'safety_recall|emissions_recall|customer_satisfaction|technical_service_bulletin');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `customer_satisfaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `emissions_recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Emissions Recall Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `estimated_repair_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Time (Minutes)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `nhtsa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NHTSA Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `parts_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost Estimate');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `parts_required` SET TAGS ('dbx_business_glossary_term' = 'Parts Required');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `regulatory_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `remedy_description` SET TAGS ('dbx_business_glossary_term' = 'Remedy Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `safety_recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Recall Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `technical_service_bulletin_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `unece_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'UNECE Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_campaign` ALTER COLUMN `warranty_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Impact Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `campaign_vin_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign VIN Record ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Safety Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `labor_rate_usd_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (USD per Hour)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `labor_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Time (Hours)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notification Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'not_notified|notified|scheduled|completed|parts_on_order|owner_refused');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `odometer_reading_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (km)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `owner_response` SET TAGS ('dbx_business_glossary_term' = 'Owner Response');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `owner_response` SET TAGS ('dbx_value_regex' = 'accepted|refused|pending');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `parts_consumed` SET TAGS ('dbx_business_glossary_term' = 'Parts Consumed');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'safety|emissions|performance|software');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `remedy_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remedy Completion Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `remedy_status` SET TAGS ('dbx_business_glossary_term' = 'Remedy Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `remedy_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `service_center_location` SET TAGS ('dbx_business_glossary_term' = 'Service Center Location');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `total_labor_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `total_parts_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Cost (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `total_remedy_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Remedy Cost (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`campaign_vin` ALTER COLUMN `warranty_covered` SET TAGS ('dbx_business_glossary_term' = 'Warranty Covered Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `aftersales_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for service_appointment');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `connected_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Vehicle Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Advisor ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_advisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Advisor ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `vehicle_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Service End Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Start Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `aftersales_service_appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `aftersales_service_appointment_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|completed|cancelled|no_show');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number (APPT_NO)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `appointment_source` SET TAGS ('dbx_business_glossary_term' = 'Appointment Source');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `appointment_source` SET TAGS ('dbx_value_regex' = 'online|phone|dms|mobile_app');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `bay_number` SET TAGS ('dbx_business_glossary_term' = 'Service Bay Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check‑In Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `customer_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Minutes)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `estimated_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `estimated_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `estimated_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `is_first_time_customer` SET TAGS ('dbx_business_glossary_term' = 'First‑Time Customer Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `is_repeat_service` SET TAGS ('dbx_business_glossary_term' = 'Repeat Service Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `labor_time_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Time (Minutes)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No‑Show Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `parts_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Parts Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Service Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `required_parts_flag` SET TAGS ('dbx_business_glossary_term' = 'Required Parts Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Appointment Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_priority` SET TAGS ('dbx_business_glossary_term' = 'Service Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'maintenance|warranty_repair|recall|pdi|customer_pay');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `total_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `transportation_option` SET TAGS ('dbx_business_glossary_term' = 'Transportation Option');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `transportation_option` SET TAGS ('dbx_value_regex' = 'loaner|shuttle|wait|none');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `vehicle_mileage` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Mileage');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_service_appointment` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Service Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `tsb_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `affected_model_year_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Model Year End');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `affected_model_year_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Model Year Start');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `affected_vehicle_model` SET TAGS ('dbx_business_glossary_term' = 'Affected Vehicle Model');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `affected_vin_end` SET TAGS ('dbx_business_glossary_term' = 'Affected VIN End');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `affected_vin_start` SET TAGS ('dbx_business_glossary_term' = 'Affected VIN Start');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `author_department` SET TAGS ('dbx_business_glossary_term' = 'Author Department');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `author_engineer` SET TAGS ('dbx_business_glossary_term' = 'Author Engineer Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `author_engineer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `author_engineer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|distributed|completed');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Effective From Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Effective Until Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `is_ota_capable` SET TAGS ('dbx_business_glossary_term' = 'OTA Capable Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Issue Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `part_revision` SET TAGS ('dbx_business_glossary_term' = 'Part Revision');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `repair_procedure` SET TAGS ('dbx_business_glossary_term' = 'Repair Procedure');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `required_parts` SET TAGS ('dbx_business_glossary_term' = 'Required Parts List');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `superseded_by_tsb_number` SET TAGS ('dbx_business_glossary_term' = 'Superseding TSB Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `symptom_description` SET TAGS ('dbx_business_glossary_term' = 'Symptom Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Title');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `tsb_number` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `tsb_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `tsb_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|superseded');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `tsb_type` SET TAGS ('dbx_business_glossary_term' = 'Technical Service Bulletin Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `tsb_type` SET TAGS ('dbx_value_regex' = 'safety|recall|service|maintenance|software');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `vehicle_system_affected` SET TAGS ('dbx_business_glossary_term' = 'Vehicle System Affected');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Version Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`tsb` ALTER COLUMN `warranty_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Impact Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `aftersales_dtc_event_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Trouble Code Event ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `ecu_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Control Unit Identifier (ECU_ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `ecu_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Control Unit Identifier (ECU_ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `battery_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage (V)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'DTC Cleared Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `diagnostic_session_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Session Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `diagnostic_session_type` SET TAGS ('dbx_value_regex' = 'default|extended|programming');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_category` SET TAGS ('dbx_business_glossary_term' = 'DTC Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_category` SET TAGS ('dbx_value_regex' = 'powertrain|chassis|body|network|emissions');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Trouble Code (DTC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_description` SET TAGS ('dbx_business_glossary_term' = 'DTC Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_recall_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recall Indicator');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_related_part_description` SET TAGS ('dbx_business_glossary_term' = 'Related Part Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_related_part_number` SET TAGS ('dbx_business_glossary_term' = 'Related Part Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_resolution_code` SET TAGS ('dbx_business_glossary_term' = 'DTC Resolution Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_resolution_description` SET TAGS ('dbx_business_glossary_term' = 'DTC Resolution Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_status` SET TAGS ('dbx_business_glossary_term' = 'DTC Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `dtc_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|stored|permanent');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `emission_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Emission Related Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `engine_rpm` SET TAGS ('dbx_business_glossary_term' = 'Engine RPM');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `event_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Event Source Reference');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'obd|telematics|service_tool');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `first_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Occurrence Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `freeze_frame_data` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `fuel_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level Percent');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `is_test_event` SET TAGS ('dbx_business_glossary_term' = 'Test Event Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `last_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Occurrence Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `mileage_at_event` SET TAGS ('dbx_business_glossary_term' = 'Mileage at Event');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `occurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `odometer_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer (KM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `technician_action` SET TAGS ('dbx_business_glossary_term' = 'Technician Action');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `vehicle_speed_kph` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Speed (KPH)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_dtc_event` ALTER COLUMN `warranty_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Covered Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Time Standard ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `body_style` SET TAGS ('dbx_business_glossary_term' = 'Body Style');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `compliance_nhtsa_code` SET TAGS ('dbx_business_glossary_term' = 'NHTSA Compliance Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Operation Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'maintenance|repair|diagnostic|installation');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_time_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Labor Standard Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_time_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `labor_type` SET TAGS ('dbx_value_regex' = 'warranty|customer_pay|recall');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `oem_part_number` SET TAGS ('dbx_business_glossary_term' = 'OEM Part Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `operation_code` SET TAGS ('dbx_business_glossary_term' = 'Operation Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `operation_description` SET TAGS ('dbx_business_glossary_term' = 'Operation Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level Required');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|L4|L5|L6');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Source of Labor Standard');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'OEM|MOTOR|Alldata|Other');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `special_tool_required` SET TAGS ('dbx_business_glossary_term' = 'Special Tool Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `standard_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Labor Hours');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `tool_code` SET TAGS ('dbx_business_glossary_term' = 'Tool Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `vehicle_model_year_end` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year End');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `vehicle_model_year_start` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year Start');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `vehicle_segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`labor_time_standard` ALTER COLUMN `vehicle_segment` SET TAGS ('dbx_value_regex' = 'sedan|SUV|truck|van|crossover|commercial');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` SET TAGS ('dbx_subdomain' = 'parts_logistics');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `service_part_id` SET TAGS ('dbx_business_glossary_term' = 'Service Part ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification (CCERT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `core_charge` SET TAGS ('dbx_business_glossary_term' = 'Core Charge (CC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `dealer_net_price` SET TAGS ('dbx_business_glossary_term' = 'Dealer Net Price (DNP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `epa_hazardous_material_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Hazardous Material Code (EPA_HAZ)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `hazardous_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Classification (HC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height (MM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status (INV_ST)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'in_stock|out_of_stock|backordered|discontinued');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (LUT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length (MM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|superseded|discontinued|obsolete');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'Standard List Price (SLP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name (MFR)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Part Category (CAT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `part_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|body|consumable|accessory');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Part Name (DES)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number (OEM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `part_revision` SET TAGS ('dbx_business_glossary_term' = 'Part Revision (REV)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `service_part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description (DESC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `superseded_by_part_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Part Number (SUP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `warranty_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Eligible Flag (WEF)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (KG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_part` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width (MM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` SET TAGS ('dbx_subdomain' = 'parts_logistics');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `aftersales_parts_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for parts_order');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `dealership_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `primary_aftersales_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (DEALER_ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `supply_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACT_DELIV_DT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag (BACKORDER_FLG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CRE_TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (FRGT_COST)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (FRGT_TRMS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `fulfillment_location_code` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location Code (FULFILL_LOC_CD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `net_total` SET TAGS ('dbx_business_glossary_term' = 'Net Order Total (NET_ORD_TOT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number (ORD_NUM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status (ORD_STS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp (ORD_TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (ORD_TYPE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'stock|emergency|campaign|special');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cod');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag (PRIORITY_FLG)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIV_DT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method (SHIP_MTHD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|rail');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions (SPEC_INSTR)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value (TOT_ORD_VAL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_parts_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPD_TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` SET TAGS ('dbx_subdomain' = 'parts_logistics');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `parts_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Order Line Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `aftersales_parts_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Order Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `service_part_id` SET TAGS ('dbx_business_glossary_term' = 'Part Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `backorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CAD|GBP|AUD');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `estimated_availability_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Availability Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|shipped|backordered|canceled');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `substitution_part_number` SET TAGS ('dbx_business_glossary_term' = 'Substitution Part Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_order_line` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Selling Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `primary_service_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Selling Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Mobility Service Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `transfer_to_dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer To Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `warranty_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `administrator_code` SET TAGS ('dbx_business_glossary_term' = 'Administrator ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `claim_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'powertrain|comprehensive|maintenance|tire_and_wheel|roadside_assistance|extended_warranty');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `coverage_mileage_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Mileage Limit');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Refundable Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `mileage_used` SET TAGS ('dbx_business_glossary_term' = 'Mileage Used');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `net_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Net Contract Value');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|cash|check');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash|credit');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `service_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `service_contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|transferred|pending|suspended');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `service_contract_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Claim ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Submitted By Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Claim Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_adjusted_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjusted Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_category` SET TAGS ('dbx_business_glossary_term' = 'Claim Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_category` SET TAGS ('dbx_value_regex' = 'repair|maintenance|upgrade|other');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Closure Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Effective Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Item Count');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Method');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_payment_method` SET TAGS ('dbx_value_regex' = 'check|credit|direct_deposit');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_payment_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_business_glossary_term' = 'Claim Priority');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Claim Reviewed By');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_reviewed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_reviewed_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|paid');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Claim Submitted By');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_submitted_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_submitted_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'extended_service_contract|voluntary_service_agreement');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claim_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claimed_labor_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Labor Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `claimed_parts_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Parts Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `covered_repair_description` SET TAGS ('dbx_business_glossary_term' = 'Covered Repair Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `parts_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Parts Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `vin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_contract_claim` ALTER COLUMN `vin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `goodwill_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Adjustment ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Adjustment Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'supervisor|manager|director|vice_president|executive');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Goodwill Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `goodwill_adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Adjustment Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `goodwill_adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|closed|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `goodwill_type` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `goodwill_type` SET TAGS ('dbx_value_regex' = 'full_coverage|partial_coverage|parts_only|labor_only|cash_reimbursement');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `nps_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'NPS Impact Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `nps_score_change` SET TAGS ('dbx_business_glossary_term' = 'NPS Score Change');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `part_cost` SET TAGS ('dbx_business_glossary_term' = 'Part Cost');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|CDK_DMS|Other');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Goodwill Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`goodwill_adjustment` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` SET TAGS ('dbx_subdomain' = 'dealer_management');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Group Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `geofence_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `adas_calibration_authorized` SET TAGS ('dbx_business_glossary_term' = 'ADAS Calibration Service Authorization Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Service Authorization Level');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'warranty|recall|collision|ev_certified|adas_calibration|none');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `average_service_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Service Time per Order (Minutes)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `collision_authorized` SET TAGS ('dbx_business_glossary_term' = 'Certified Collision Service Authorization Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `dsk_instance_code` SET TAGS ('dbx_business_glossary_term' = 'CDK Global DMS Instance Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `ev_certified` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle Service Certification Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `iatf_certified` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certification Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `is_primary_center` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Center Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `iso9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certification Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Last Regulatory Audit');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `loaner_fleet_size` SET TAGS ('dbx_business_glossary_term' = 'Loaner Vehicle Fleet Size');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Service Center Market Segment');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Service Center Network Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Schedule');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `recall_authorized` SET TAGS ('dbx_business_glossary_term' = 'Recall Service Authorization Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Service Center Geographic Region');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_bay_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Service Bays');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_center_code` SET TAGS ('dbx_business_glossary_term' = 'Service Center Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_center_name` SET TAGS ('dbx_business_glossary_term' = 'Service Center Name');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_center_type` SET TAGS ('dbx_business_glossary_term' = 'Service Center Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_center_type` SET TAGS ('dbx_value_regex' = 'dealership|independent|authorized|factory');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `service_orders_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Service Orders Processed');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `technician_headcount` SET TAGS ('dbx_business_glossary_term' = 'Technician Headcount');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `warranty_authorized` SET TAGS ('dbx_business_glossary_term' = 'Warranty Service Authorization Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`service_center` ALTER COLUMN `warranty_claims_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Warranty Claims Processed');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` SET TAGS ('dbx_subdomain' = 'dealer_management');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID (SC_ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status (AVAIL_STATUS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|on_leave|scheduled');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (CERT_EXPIRY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level (CERT_LEVEL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'level1|level2|master|expert');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CERT_TYPE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'ASE|OEM|EV|ADAS|HV|GENERAL');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `current_active_ro_count` SET TAGS ('dbx_business_glossary_term' = 'Current Active Repair Order Count (ACTIVE_RO_COUNT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Technician Email Address (TECH_EMAIL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `flat_rate_efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Flat‑Rate Efficiency Rating (EFF_RATING)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Full Name (TECH_NAME)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HIRE_DATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date (LAST_TRAIN_DATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `max_concurrent_ro` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Repair Orders (MAX_CONCURRENT_RO)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes (NOTES)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible (OT_ELIGIBLE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier (OT_MULTIPLIER)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Technician Phone Number (TECH_PHONE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type (SHIFT_TYPE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|flex|rotating');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level (SKILL_LEVEL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|lead');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Technician Specialization (SPECIALIZATION)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `specialization` SET TAGS ('dbx_value_regex' = 'powertrain|electrical|body|diagnostics|software|hvac');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `technician_status` SET TAGS ('dbx_business_glossary_term' = 'Technician Status (STATUS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `technician_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed (TRAIN_HRS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`technician` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience (YEARS_EXP)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` SET TAGS ('dbx_subdomain' = 'parts_logistics');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `parts_return_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Return Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `primary_parts_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `core_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Return Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `credit_memo_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Issue Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `inspected_by` SET TAGS ('dbx_business_glossary_term' = 'Inspected By (Employee Identifier)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `is_credit_issued` SET TAGS ('dbx_business_glossary_term' = 'Credit Issued Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `net_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Credit Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `original_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Original Order Line Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `original_order_number` SET TAGS ('dbx_business_glossary_term' = 'Original Order Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `overstock_flag` SET TAGS ('dbx_business_glossary_term' = 'Overstock Return Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `part_condition` SET TAGS ('dbx_business_glossary_term' = 'Part Condition');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `part_condition` SET TAGS ('dbx_value_regex' = 'new|used|defective|repaired');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Number (RA#)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_location` SET TAGS ('dbx_business_glossary_term' = 'Return Location (Warehouse/Facility)');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'mail|carrier|dropoff|pickup');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_reason_category` SET TAGS ('dbx_value_regex' = 'quality|logistics|regulatory|other');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Return Record');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|processed|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'warranty|core|overstock|campaign');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|box|kg|liter');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`parts_return` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Return Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_pdi_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_pdi_inspection` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_pdi_inspection` ALTER COLUMN `aftersales_pdi_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for aftersales_pdi_inspection');
ALTER TABLE `automotive_ecm`.`aftersales`.`aftersales_pdi_inspection` ALTER COLUMN `aftersales_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Service Appointment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `customer_satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Survey ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Verbatim Comments');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `customer_satisfaction_survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `customer_satisfaction_survey_status` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `facility_score` SET TAGS ('dbx_business_glossary_term' = 'Facility Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `follow_up_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Code');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `respondent_type` SET TAGS ('dbx_value_regex' = 'owner|driver|fleet_manager');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `response_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Duration (Seconds)');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `response_source` SET TAGS ('dbx_business_glossary_term' = 'Response Source');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `response_source` SET TAGS ('dbx_value_regex' = 'online|paper|tablet');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `service_advisor_score` SET TAGS ('dbx_business_glossary_term' = 'Service Advisor Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'maintenance|repair|recall|campaign');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Delivery Channel');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|app|phone');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `technician_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Technician Quality Score');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `vehicle_mileage_at_service` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Mileage at Service');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`customer_satisfaction_survey` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` SET TAGS ('dbx_subdomain' = 'dealer_management');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `loaner_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Loaner Vehicle ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Service Center ID (ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date (DATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `current_location` SET TAGS ('dbx_business_glossary_term' = 'Current Location Identifier (LOC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `current_odometer` SET TAGS ('dbx_business_glossary_term' = 'Current Odometer Reading (KM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `depreciation_value` SET TAGS ('dbx_business_glossary_term' = 'Depreciated Value (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type (FUEL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|ev|hybrid|plug_in_hybrid');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date (DATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (DATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number (PLATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `loan_out_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loan-Out End Timestamp (TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `loan_out_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loan-Out Start Timestamp (TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `loaner_vehicle_status` SET TAGS ('dbx_business_glossary_term' = 'Current Status (STATUS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `loaner_vehicle_status` SET TAGS ('dbx_value_regex' = 'available|on_loan|in_service|retired|maintenance');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Manufacturer (MAKE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `mileage_at_acquisition` SET TAGS ('dbx_business_glossary_term' = 'Mileage at Acquisition (KM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model (MODEL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (TEXT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `pool_type` SET TAGS ('dbx_business_glossary_term' = 'Loaner Pool Type (POOL)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `pool_type` SET TAGS ('dbx_value_regex' = 'courtesy|rental|ev_demo|test');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type (POWERTRAIN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'internal_combustion|electric|hybrid|plug_in_hybrid');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price (USD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `registration_state` SET TAGS ('dbx_business_glossary_term' = 'Registration State (STATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `total_loan_out_count` SET TAGS ('dbx_business_glossary_term' = 'Total Loan-Out Count (COUNT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (TS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Body Type (TYPE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_value_regex' = 'sedan|suv|truck|van|crossover');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_vehicle` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date (DATE)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Loaner Assignment ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `customer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Loaner Vehicle Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center ID');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `actual_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'dealer|fleet|partner');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'short_term|long_term');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Charge Currency');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `charge_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|CHF');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `charge_reason` SET TAGS ('dbx_business_glossary_term' = 'Charge Reason');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `charge_reason` SET TAGS ('dbx_value_regex' = 'fuel|damage|mileage|other');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `damage_assessed_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Assessed Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `damage_noted_at_return` SET TAGS ('dbx_business_glossary_term' = 'Damage Noted at Return');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `expected_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `fuel_level_checkout` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level at Checkout (%)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `fuel_level_return` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level at Return (%)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `fuel_refill_charge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Refill Charge');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `fuel_refill_required` SET TAGS ('dbx_business_glossary_term' = 'Fuel Refill Required Flag');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|in_use|returned|cancelled|lost');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_category` SET TAGS ('dbx_business_glossary_term' = 'Loaner Category');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_category` SET TAGS ('dbx_value_regex' = 'standard|premium|luxury');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_vehicle_status` SET TAGS ('dbx_business_glossary_term' = 'Loaner Vehicle Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_vehicle_status` SET TAGS ('dbx_value_regex' = 'available|maintenance|assigned|retired');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Loaner Vehicle Type');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `loaner_vehicle_type` SET TAGS ('dbx_value_regex' = 'sedan|suv|truck|van|electric|hybrid');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `mileage_allowance_km` SET TAGS ('dbx_business_glossary_term' = 'Mileage Allowance (km)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `mileage_excess` SET TAGS ('dbx_business_glossary_term' = 'Excess Mileage (km)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `mileage_excess_charge` SET TAGS ('dbx_business_glossary_term' = 'Excess Mileage Charge');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `odometer_checkout` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Checkout (km)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `odometer_return` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Return (km)');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`loaner_assignment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `warranty_parts_return_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Parts Return ID (WPRID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `aftersales_warranty_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim ID (WCI)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `dealer_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (Dealer ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (Dealer ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (Supplier ID)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `analysis_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completed Timestamp (ACT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `analysis_notes` SET TAGS ('dbx_business_glossary_term' = 'Analysis Notes (AN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount (CA)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Chargeback Flag (SCF)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `compliance_epa_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Compliance Code (EPA_CC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `compliance_nhtsa_code` SET TAGS ('dbx_business_glossary_term' = 'NHTSA Compliance Code (NHTSA_CC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision (DD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'scrap|rework|return_to_supplier|store');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp (DT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `failure_analysis_outcome` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Outcome (FAO)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `failure_analysis_outcome` SET TAGS ('dbx_value_regex' = 'confirmed_defect|no_fault|misdiagnosis|abuse');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description (FD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (IS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp (IT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `is_critical_part` SET TAGS ('dbx_business_glossary_term' = 'Critical Part Indicator (CPI)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `is_recall_related` SET TAGS ('dbx_business_glossary_term' = 'Recall Related Flag (RRF)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year (MY)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (Notes)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `oem_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'OEM Receipt Date (ORD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `part_cost` SET TAGS ('dbx_business_glossary_term' = 'Part Cost (PC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description (PD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'OEM Part Number (PN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `part_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Part Serial Number (PSN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `quality_feedback_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Feedback Loop Status (QFLS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `quality_feedback_status` SET TAGS ('dbx_value_regex' = 'pending|completed|escalated');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity (Qty)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Number (RAN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code (RRC)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `return_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Date (RSD)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status (RS)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `return_status` SET TAGS ('dbx_value_regex' = 'authorized|shipped|received|analyzed|closed|rejected');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number (SPN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `total_return_value` SET TAGS ('dbx_business_glossary_term' = 'Total Return Value (TRV)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type (WT)');
ALTER TABLE `automotive_ecm`.`aftersales`.`warranty_parts_return` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'basic|extended|powertrain|service');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` SET TAGS ('dbx_association_edges' = 'product.nameplate,aftersales.service_campaign');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ALTER COLUMN `recall_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Coverage - Recall Coverage Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Coverage - Nameplate Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Coverage - Service Campaign Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ALTER COLUMN `campaign_number` SET TAGS ('dbx_business_glossary_term' = 'Campaign Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Effective End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`recall_coverage` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Effective Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` SET TAGS ('dbx_association_edges' = 'product.nameplate,billing.rebate_agreement');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `rebate_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Coverage - Rebate Coverage Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `nameplate_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Coverage - Nameplate Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Coverage - Rebate Agreement Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `rebate_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `automotive_ecm`.`aftersales`.`rebate_coverage` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` SET TAGS ('dbx_subdomain' = 'parts_logistics');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` SET TAGS ('dbx_association_edges' = 'aftersales.parts_order,logistics.shipment');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `order_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Shipment - Order Shipment Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `aftersales_parts_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Shipment - Aftersales Parts Order Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Shipment - Shipment Id');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `automotive_ecm`.`aftersales`.`order_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `automotive_ecm`.`aftersales`.`market` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`aftersales`.`market` SET TAGS ('dbx_subdomain' = 'dealer_management');
ALTER TABLE `automotive_ecm`.`aftersales`.`market` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier');
ALTER TABLE `automotive_ecm`.`aftersales`.`market` ALTER COLUMN `parent_market_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`market` ALTER COLUMN `market_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`aftersales`.`market` ALTER COLUMN `market_manager_email` SET TAGS ('dbx_pii_email' = 'true');
