-- Schema for Domain: exploration | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`exploration` COMMENT 'Manages all mineral exploration and resource discovery activities including geological surveys, drilling programs, sampling, assay results, resource estimation, and JORC/NI 43-101/SAMREC-compliant resource and reserve reporting. Owns exploration licenses, prospect data, drill-hole collars, and resource classification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the exploration prospect or target area. Primary key.',
    `competent_person_id` BIGINT COMMENT 'Foreign key linking to exploration.competent_person. Business justification: Prospects reference the competent person responsible for resource classification and reporting. Currently prospect stores competent_person as a denormalized string. Adding competent_person_id FK to th',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Prospects are cost accumulation points in exploration. Finance assigns cost centres to prospects for expenditure tracking, budget control, and AISC reporting by prospect.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Each prospect requires an emergency response plan for exploration activities (remote location, medical emergency, environmental incident). Safety management system requirement and regulatory expectati',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Prospects require environmental permits for exploration activities (clearing, drilling, camp establishment). Permit conditions govern prospect-level operations. Critical for regulatory compliance and ',
    `heritage_clearance_id` BIGINT COMMENT 'Foreign key linking to tenement.heritage_clearance. Business justification: Heritage clearance is a direct legal prerequisite before any drilling or ground disturbance at a prospect. prospect carries a plain heritage_clearance_status — a denormalized signal. A proper FK to ',
    `licence_id` BIGINT COMMENT 'Foreign key linking to exploration.licence. Business justification: A prospect is conducted under a specific exploration licence that grants the legal right to explore the area. This is a fundamental in-domain relationship — the licence defines the legal boundary and ',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Prospects target specific commodities (iron ore, copper, lithium) - fundamental to exploration strategy, resource classification, and statutory reporting. Normalizes existing primary_commodity text fi',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Prospects transition to profit centres when moving to production. P&L reporting, segment reporting, and JORC reserve attribution require linking prospects to profit centres for financial planning.',
    `tenement_id` BIGINT COMMENT 'Reference to the exploration license or mining tenement under which this prospect is located.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Prospects are tracked as WBS project nodes in mining ERP for IFRS 6 area-of-interest capitalisation. Each prospect requires a WBS element to accumulate exploration costs for impairment testing and to ',
    `area_hectares` DECIMAL(18,2) COMMENT 'Total surface area of the prospect or area of interest, measured in hectares.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the prospect centroid in decimal degrees (WGS84 datum).',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the prospect centroid in decimal degrees (WGS84 datum).',
    `coordinate_system` STRING COMMENT 'Name and specification of the coordinate reference system used for local grid coordinates (e.g., MGA Zone 50, UTM Zone 31N).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospect record was first created in the system.',
    `cutoff_grade_percent` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold used for resource estimation and prospect evaluation, expressed as a percentage.',
    `discovery_date` DATE COMMENT 'Date when the prospect was first identified or discovered through exploration activities.',
    `drill_hole_count` STRING COMMENT 'Total number of drill holes completed within the prospect area to date.',
    `environmental_clearance_status` STRING COMMENT 'Status of environmental impact assessment and regulatory clearance for exploration activities in the prospect area.. Valid values are `not_required|pending|approved|conditional|rejected`',
    `estimated_grade_percent` DECIMAL(18,2) COMMENT 'Current estimated average grade of the primary commodity in the prospect, expressed as a percentage. Confidential business data.',
    `estimated_tonnage_mt` DECIMAL(18,2) COMMENT 'Current estimated total tonnage of mineralized material in the prospect, expressed in million tonnes. Confidential business data.',
    `exploration_stage` STRING COMMENT 'Current stage of exploration maturity for the prospect, ranging from early-stage grassroots to advanced feasibility studies.. Valid values are `grassroots|reconnaissance|advanced|pre_feasibility|feasibility|development`',
    `geological_confidence` STRING COMMENT 'Qualitative assessment of geological confidence in the prospect based on data density, quality, and geological understanding.. Valid values are `low|moderate|high`',
    `geological_province` STRING COMMENT 'Name of the regional geological province or terrane in which the prospect is located.',
    `last_drill_date` DATE COMMENT 'Date of the most recent drilling activity conducted in the prospect.',
    `last_resource_estimate_date` DATE COMMENT 'Date of the most recent mineral resource estimate prepared for this prospect.',
    `local_grid_easting` DECIMAL(18,2) COMMENT 'Easting coordinate of the prospect centroid in the local mine grid or project coordinate system, measured in meters.',
    `local_grid_northing` DECIMAL(18,2) COMMENT 'Northing coordinate of the prospect centroid in the local mine grid or project coordinate system, measured in meters.',
    `mineralization_style` STRING COMMENT 'Type or style of mineralization present in the prospect (e.g., porphyry, epithermal, sediment-hosted, banded iron formation, pegmatite).',
    `next_planned_activity` STRING COMMENT 'Description of the next planned exploration activity or program for the prospect (e.g., drilling campaign, geophysical survey, feasibility study).',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or comments about the prospect that do not fit structured fields.',
    `prospect_code` STRING COMMENT 'Unique alphanumeric code assigned to the prospect for identification in exploration systems and reporting.',
    `prospect_name` STRING COMMENT 'Business name or designation of the exploration prospect or target area.',
    `prospect_status` STRING COMMENT 'Current operational status of the exploration prospect in its lifecycle.. Valid values are `active|dormant|relinquished|converted_to_mining|suspended|under_review`',
    `reserve_classification` STRING COMMENT 'Highest level of ore reserve classification achieved for this prospect under JORC, NI 43-101, or SAMREC standards. None if no reserve has been declared.. Valid values are `probable|proved|none`',
    `resource_classification` STRING COMMENT 'Highest level of mineral resource classification achieved for this prospect under JORC, NI 43-101, or SAMREC standards. None if no resource has been estimated.. Valid values are `inferred|indicated|measured|none`',
    `structural_domain` STRING COMMENT 'Structural geological domain or zone characterizing the prospect area (e.g., fault block, fold belt, shear zone).',
    `target_depth_max_m` DECIMAL(18,2) COMMENT 'Maximum depth below surface at which mineralization is targeted or expected, measured in meters.',
    `target_depth_min_m` DECIMAL(18,2) COMMENT 'Minimum depth below surface at which mineralization is targeted or expected, measured in meters.',
    `total_meters_drilled` DECIMAL(18,2) COMMENT 'Cumulative total length of all drilling completed in the prospect, measured in meters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospect record was last modified in the system.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Master record for each exploration prospect or target area identified during mineral exploration programs. Captures prospect name, centroid coordinates (latitude/longitude and local grid), commodity targets, discovery date, exploration stage (grassroots, advanced, feasibility), geological province, structural domain, tenement reference, and current status (active, dormant, relinquished, converted to mining). Serves as the top-level spatial and business anchor for all exploration activities, drill programs, resource estimates, and regulatory reporting within a defined area of interest.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`licence` (
    `licence_id` BIGINT COMMENT 'Primary key for licence',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Exploration licences are cost centres for statutory expenditure tracking. Finance links licences to cost centres for minimum expenditure compliance reporting and regulatory audit trails.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining licences are frequently held under joint venture arrangements with an external counterparty as operator or co-holder. Linking licence to counterparty enables JV partner management, expenditure ',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Exploration licences operate under a governing environmental permit issued by the same regulatory authority. Licence compliance reporting and renewal submissions require direct reference to the enviro',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Exploration licences are assigned to profit centres for exploration accounting segment classification under IFRS 6 area-of-interest accounting. Mining finance requires profit centre on licences to cor',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Exploration licences ARE tenements in mining regulatory frameworks. Direct link enables statutory reporting, expenditure compliance tracking, and regulatory obligation management. Licence_number maps ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Exploration licences have statutory minimum expenditure commitments tracked against WBS elements for regulatory compliance reporting. Mining companies must demonstrate minimum spend per licence period',
    `annual_rent_fee` DECIMAL(18,2) COMMENT 'Annual rental or holding fee payable to the regulatory authority to maintain the exploration licence. Typically calculated per hectare or as a flat fee.',
    `application_date` DATE COMMENT 'Date on which the original application for the exploration licence was submitted to the regulatory authority.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total surface area covered by the exploration licence measured in square kilometres. Alternative measurement for international reporting and comparison.',
    `commodity_rights` STRING COMMENT 'List of minerals and commodities for which exploration rights have been granted under this licence. May include iron ore, copper, gold, lithium, nickel, coal, or all minerals depending on jurisdiction.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this exploration licence record was first created in the data platform.',
    `environmental_approval_required_flag` BOOLEAN COMMENT 'Indicates whether separate environmental impact assessment or approval is required before commencing exploration activities. True if required, False otherwise.',
    `expenditure_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all expenditure commitment amounts. Ensures consistent financial reporting across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `heritage_site_flag` BOOLEAN COMMENT 'Indicates whether the licence area contains or overlaps with registered cultural heritage sites, archaeological sites, or sacred sites. True if heritage sites are present, False otherwise.',
    `holder_registration_number` STRING COMMENT 'Company registration number, business number, or other official identifier of the licence holder as registered with the corporate regulator.',
    `joint_venture_flag` BOOLEAN COMMENT 'Indicates whether the exploration licence is held under a joint venture arrangement with multiple parties. True if joint venture, False if sole holder.',
    `last_renewal_date` DATE COMMENT 'Date on which the exploration licence was most recently renewed. Null if the licence has never been renewed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this exploration licence record was most recently modified in the data platform.',
    `maximum_renewals_allowed` STRING COMMENT 'Maximum number of renewals permitted under the applicable mining legislation. Once reached, the licence cannot be renewed further and must either be converted to a mining lease or surrendered.',
    `minimum_expenditure_commitment_year_1` DECIMAL(18,2) COMMENT 'Mandatory minimum exploration expenditure required in the first year of the licence term to maintain tenure. Failure to meet this commitment may result in penalties or licence forfeiture.',
    `minimum_expenditure_commitment_year_2` DECIMAL(18,2) COMMENT 'Mandatory minimum exploration expenditure required in the second year of the licence term to maintain tenure.',
    `minimum_expenditure_commitment_year_3` DECIMAL(18,2) COMMENT 'Mandatory minimum exploration expenditure required in the third year of the licence term to maintain tenure.',
    `minimum_expenditure_commitment_year_4` DECIMAL(18,2) COMMENT 'Mandatory minimum exploration expenditure required in the fourth year of the licence term to maintain tenure.',
    `minimum_expenditure_commitment_year_5` DECIMAL(18,2) COMMENT 'Mandatory minimum exploration expenditure required in the fifth year of the licence term to maintain tenure.',
    `next_reporting_due_date` DATE COMMENT 'Date by which the next regulatory report or expenditure statement is due. Critical for compliance tracking and avoiding penalties.',
    `regulatory_conditions` STRING COMMENT 'Special conditions, restrictions, or obligations imposed by the regulatory authority as part of the licence grant. May include environmental protection measures, heritage site restrictions, or community consultation requirements.',
    `renewal_count` STRING COMMENT 'Number of times the exploration licence has been renewed since original grant. Used to track tenure history and assess remaining renewal opportunities.',
    `renewal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the exploration licence is eligible for renewal based on compliance with expenditure commitments and regulatory conditions. True if eligible, False if not.',
    `rent_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual rent fee.. Valid values are `^[A-Z]{3}$`',
    `reporting_frequency` STRING COMMENT 'Frequency at which exploration activity reports and expenditure statements must be submitted to the regulatory authority.. Valid values are `annual|semi_annual|quarterly|as_required`',
    `security_bond_amount` DECIMAL(18,2) COMMENT 'Financial security or bond amount required to be lodged with the regulatory authority to cover potential rehabilitation costs and ensure compliance with licence conditions.',
    `security_bond_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the security bond amount.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_licence PRIMARY KEY(`licence_id`)
) COMMENT 'Master register of all exploration licences, permits, and tenements held for mineral exploration activities. Tracks licence number, issuing jurisdiction and regulatory authority, grant date, expiry date, renewal history, area in hectares/km², commodity rights granted, minimum expenditure commitments by year, security/bond requirements, reporting obligations, and regulatory conditions. Links to the tenement domain for broader land access context. Scoped exclusively to exploration-phase tenure — mining leases and production rights are owned by the tenement domain.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`drill_hole` (
    `drill_hole_id` BIGINT COMMENT 'Unique system identifier for the drill hole collar record. Primary key for the drill hole entity.',
    `asset_id` BIGINT COMMENT 'The unique identifier of the drilling rig used to execute this hole. Used for rig utilization tracking, maintenance correlation, and quality control. Typically the contractors rig fleet number or name.',
    `drill_program_id` BIGINT COMMENT 'Reference to the drilling campaign or program under which this hole was executed. Used for budget tracking, contractor assignment, and program-level reporting.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Drill holes can intersect specific geological hazards (pressurized gas zones, H2S, unstable ground). Mining operations require drill holes to reference the identified hazard for safety management, inc',
    `prospect_id` BIGINT COMMENT 'Reference to the exploration prospect or tenement where this drill hole is located. Links the hole to the broader exploration project and land package.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Individual drill holes may be tied to specific PO line items for detailed cost tracking, invoicing reconciliation, and cost-per-meter analysis. Enables accurate job costing and dispute resolution with',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Individual drill holes target specific commodities - determines sampling protocol, assay suite selection, and QAQC standards (e.g., gold requires fire assay, base metals use multi-element ICP). Normal',
    `abandonment_reason` STRING COMMENT 'Free-text description of the reason for early termination or abandonment of the drill hole. Common reasons include equipment failure, ground conditions (cavity, water ingress), deviation beyond acceptable limits, or program budget constraints. Populated only when hole_status is abandoned.',
    `actual_azimuth` DECIMAL(18,2) COMMENT 'The actual measured horizontal direction of the drill hole at the collar, measured in degrees clockwise from grid north (0-360). Captured from downhole survey or collar survey after drilling commences. May differ from planned azimuth due to setup adjustments or ground conditions.',
    `actual_depth` DECIMAL(18,2) COMMENT 'The actual total depth achieved by the drill hole measured along the hole trajectory from collar to end-of-hole, measured in meters. May differ from planned depth due to early termination, ground conditions, or program adjustments.',
    `actual_dip` DECIMAL(18,2) COMMENT 'The actual measured vertical angle of the drill hole at the collar, measured in degrees from horizontal. Captured from downhole survey or collar survey after drilling commences. May differ from planned dip due to setup adjustments or ground conditions.',
    `collar_easting` DECIMAL(18,2) COMMENT 'The easting (X) coordinate of the drill hole collar in the local mine grid coordinate system, measured in meters. This is the authoritative spatial reference for the hole location used in resource modeling and mine planning.',
    `collar_latitude` DECIMAL(18,2) COMMENT 'The latitude of the drill hole collar in WGS84 geographic coordinate system, measured in decimal degrees. Used for global positioning, regulatory reporting, and integration with external GIS systems.',
    `collar_longitude` DECIMAL(18,2) COMMENT 'The longitude of the drill hole collar in WGS84 geographic coordinate system, measured in decimal degrees. Used for global positioning, regulatory reporting, and integration with external GIS systems.',
    `collar_northing` DECIMAL(18,2) COMMENT 'The northing (Y) coordinate of the drill hole collar in the local mine grid coordinate system, measured in meters. Used in conjunction with easting and RL to define the three-dimensional collar position.',
    `collar_rl` DECIMAL(18,2) COMMENT 'The elevation (Z) coordinate of the drill hole collar in the local mine grid coordinate system, measured in meters above the site datum. RL (Reduced Level) is the mining industry standard term for elevation.',
    `comments` STRING COMMENT 'General free-text comments or notes about the drill hole, including operational issues, geological observations, or data quality notes. Used for contextual information that does not fit structured fields.',
    `completion_date` DATE COMMENT 'The date drilling operations were completed for this hole, including final survey and collar rehabilitation. Used for program reporting, contractor invoicing, and cycle time analysis.',
    `core_diameter` STRING COMMENT 'The nominal diameter of the drill core recovered, applicable only to diamond core drilling. Standard sizes include PQ (85mm), HQ (63.5mm), NQ (47.6mm), BQ (36.4mm). Used for sample volume calculations and metallurgical testwork planning. [ENUM-REF-CANDIDATE: PQ|HQ|NQ|BQ|NQ2|HQ3|NMLC|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this drill hole record was first created in the system. Used for data lineage, audit trail, and record lifecycle tracking.',
    `drill_type` STRING COMMENT 'The drilling method used for this hole. RC (Reverse Circulation) provides chip samples; diamond core provides continuous core samples; RAB (Rotary Air Blast) and aircore are used for shallow reconnaissance; percussion and rotary are used for specific geological conditions; directional drilling is used for underground or complex geometries. [ENUM-REF-CANDIDATE: RC|diamond_core|RAB|aircore|percussion|rotary|directional — 7 candidates stripped; promote to reference product]',
    `hole_code` STRING COMMENT 'Unique business identifier for the drill hole collar, typically assigned by the exploration team following site naming conventions. This is the externally-known collar identifier used in geological reports, assay certificates, and JORC/NI 43-101/SAMREC resource statements.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `hole_purpose` STRING COMMENT 'The primary objective of the drill hole. Exploration holes target new mineralization; infill holes increase resource confidence; geotechnical holes assess rock mechanics for mine design; sterilisation holes confirm absence of mineralization in infrastructure footprints; hydrogeological holes assess groundwater; metallurgical holes provide samples for processing testwork.. Valid values are `exploration|infill|geotechnical|sterilisation|hydrogeological|metallurgical`',
    `hole_status` STRING COMMENT 'Current lifecycle status of the drill hole. Planned holes are scheduled but not started; in-progress holes are actively being drilled; completed holes have reached target depth and been logged; abandoned holes were terminated early due to technical issues; suspended holes are temporarily halted; surveyed holes have had final downhole survey completed.. Valid values are `planned|in_progress|completed|abandoned|suspended|surveyed`',
    `logged_date` DATE COMMENT 'The date the geological logging of the drill hole was completed. Used for workflow tracking and data currency assessment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this drill hole record was last modified in the system. Used for data currency assessment, change tracking, and audit trail.',
    `planned_azimuth` DECIMAL(18,2) COMMENT 'The planned horizontal direction of the drill hole at the collar, measured in degrees clockwise from grid north (0-360). Azimuth defines the compass bearing of the hole trajectory.',
    `planned_depth` DECIMAL(18,2) COMMENT 'The planned total depth of the drill hole measured along the hole trajectory from collar to end-of-hole, measured in meters. Defines the target depth for the drilling contractor.',
    `planned_dip` DECIMAL(18,2) COMMENT 'The planned vertical angle of the drill hole at the collar, measured in degrees from horizontal. Positive values indicate downward inclination; negative values indicate upward inclination. A vertical hole has a dip of -90 degrees.',
    `pre_collar_depth` DECIMAL(18,2) COMMENT 'The depth of pre-collar drilling (typically RC or aircore) completed before switching to diamond core drilling, measured in meters. Used in two-stage drilling programs to reduce diamond drilling costs through overburden.',
    `qaqc_status` STRING COMMENT 'The overall quality assurance and quality control status for this drill hole, based on review of sampling procedures, assay QAQC results, survey accuracy, and logging completeness. Passed holes are suitable for resource estimation; failed holes require remediation or exclusion.. Valid values are `passed|failed|pending|not_applicable|under_review`',
    `recovery_percentage` DECIMAL(18,2) COMMENT 'The average percentage of core recovered relative to the drilled interval, applicable to diamond core drilling. High recovery (>95%) indicates competent ground and good drilling practice; low recovery may indicate fractured ground, voids, or drilling issues. Critical for resource confidence classification.',
    `sample_interval` DECIMAL(18,2) COMMENT 'The standard length interval used for sampling this drill hole, measured in meters. Typically 1m for RC drilling and variable (0.5-1.5m) for diamond core based on geological contacts. Used for sample planning and assay result interpretation.',
    `start_date` DATE COMMENT 'The date drilling operations commenced for this hole. Used for program scheduling, contractor performance tracking, and cost allocation.',
    `survey_method` STRING COMMENT 'The method used to survey the drill hole trajectory. Gyroscopic surveys are most accurate and unaffected by magnetic interference; magnetic surveys are cost-effective but affected by magnetic ore bodies; electronic multi-shot provides continuous trajectory; differential GPS and total station are used for collar positioning. [ENUM-REF-CANDIDATE: gyroscopic|magnetic|electronic_multi_shot|single_shot|differential_gps|total_station|none — 7 candidates stripped; promote to reference product]',
    `target_geology` STRING COMMENT 'Free-text description of the geological target or formation being intersected by this drill hole. Includes target lithology, structure, or mineralization style. Used for geological interpretation and targeting review.',
    CONSTRAINT pk_drill_hole PRIMARY KEY(`drill_hole_id`)
) COMMENT 'Master record for every drill hole (collar) executed across all exploration and resource definition programs. Captures hole ID (unique collar identifier), prospect reference, drill program reference, drill type (RC, diamond core, RAB, aircore, percussion), collar coordinates (easting, northing, RL in local mine grid and WGS84), planned and actual azimuth, planned and actual dip, planned and actual total depth, start date, completion date, drilling contractor, rig identifier, hole purpose (exploration, infill, geotechnical, sterilisation, hydrogeological), and hole status (planned, in-progress, completed, abandoned). The authoritative SSOT for drill hole identity and spatial metadata used by geology, laboratory, and resource estimation workflows.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`drill_program` (
    `drill_program_id` BIGINT COMMENT 'Unique identifier for the drilling program. Primary key for the drill program entity.',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: Drill programs are capital projects requiring budget approval and tracking. Finance links drill program expenditure to approved capex budgets for capital expenditure control and variance reporting.',
    `competent_person_id` BIGINT COMMENT 'FK to exploration.competent_person',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Drilling programs operate under framework agreements or master service agreements. Links program to procurement contract for pricing verification, terms compliance, scope management, and contract perf',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Drill programs incur direct costs posted to a cost centre for monthly exploration cost reporting and budget variance analysis. Standard mining ERP practice assigns a cost centre to each drill program ',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_class. Business justification: Drill programs specify required rig class (RC, diamond core, RAB) before a specific asset is assigned. This drives fleet procurement, CAPEX budgeting, and contractor tendering. A Mining planner would ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Drilling contractors executing programs must be registered vendors for PO issuance, insurance verification, and HSE prequalification. Mining procurement requires all contractors to exist in the vendor',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Drilling programs must reference site emergency response plans (medical evacuation, spill response, rig fire). Operational requirement for contractor mobilization and safety induction. Plan ID include',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Drill programs must operate under a specific environmental permit (disturbance/clearing permit). Regulatory compliance reporting requires direct traceability from program to permit. The denormalized e',
    `expenditure_commitment_id` BIGINT COMMENT 'Foreign key linking to tenement.expenditure_commitment. Business justification: Drill programs are the primary mechanism for satisfying tenement minimum expenditure commitments. Tenement managers track which drill programs contribute to which commitment obligations for statutory ',
    `licence_id` BIGINT COMMENT 'Reference to the exploration licence under which this drilling program is authorized and conducted.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Drill programs are physically executed at a mine site. Site-level drilling activity reporting, cost allocation, and environmental permit compliance require knowing which mine_site each drill_program b',
    `opex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.opex_budget. Business justification: Drill programs have operational expenditure components (consumables, labor, contractor costs). Finance links drill programs to opex budgets for operating cost control and AISC calculation.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Drill programs are assigned to profit centres for commodity segment reporting and exploration accounting under IFRS 6. Mining finance requires profit centre on drill programs to correctly classify exp',
    `prospect_id` BIGINT COMMENT 'Reference to the mineral prospect or resource area targeted by this drilling program.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Drill programs are designed to test commodity-specific targets - required for budget allocation, statutory expenditure reporting, and drilling contractor selection (e.g., RC vs diamond core). Normaliz',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Drill programs are executed under specific tenement rights. Statutory minimum expenditure reporting requires drill program metreage and spend to be attributed directly to a tenement — regulators asses',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Drill programs are capital/opex projects tracked against WBS elements in SAP for JORC expenditure compliance and cost control reporting. Mining finance teams require WBS assignment on every drill prog',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred for the drilling program to date. Used for budget variance analysis and cost control.',
    `actual_hole_count` STRING COMMENT 'Total number of drill holes actually completed as part of this program. Used for program performance tracking and variance analysis.',
    `actual_metreage` DECIMAL(18,2) COMMENT 'Total actual drilling metreage (in metres) completed for the program. Used for cost reconciliation and performance tracking against plan.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for the drilling program in the reporting currency. Includes drilling, assay, geological support, and mobilization costs.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget and actual expenditure amounts (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drill program record was first created in the system. Used for data lineage and audit trail purposes.',
    `drilling_method` STRING COMMENT 'Primary drilling technique employed in the program: diamond core (DD), reverse circulation (RC), rotary air blast (RAB), percussion, or sonic drilling. Determines sample quality and cost profile.. Valid values are `diamond_core|reverse_circulation|rotary_air_blast|percussion|sonic`',
    `expenditure_classification` STRING COMMENT 'Classification of the drilling program expenditure as Capital Expenditure (CAPEX), Operating Expenditure (OPEX), or mixed. Critical for financial reporting and tax treatment under IFRS 6.. Valid values are `capex|opex|mixed`',
    `hse_incident_count` STRING COMMENT 'Total number of recordable Health, Safety, and Environment incidents that occurred during the execution of the drilling program. Used for safety performance tracking and LTIFR/TRIFR calculation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this drill program record is currently active and valid for operational and reporting purposes. Supports soft-delete and historical record management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the drill program record was last modified. Used for change tracking and data governance.',
    `planned_hole_count` STRING COMMENT 'Total number of drill holes planned for this program as per the approved drilling plan.',
    `planned_metreage` DECIMAL(18,2) COMMENT 'Total planned drilling metreage (in metres) for the program as per the approved drilling plan. Critical for budget estimation and contractor scoping.',
    `program_code` STRING COMMENT 'Unique business identifier or code assigned to the drilling program for external reference and reporting purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `program_end_date` DATE COMMENT 'Planned or actual date when drilling operations concluded for this program. Used for program duration tracking and contractor demobilization planning.',
    `program_name` STRING COMMENT 'Descriptive name of the drilling program identifying the campaign, location, or strategic objective.',
    `program_objective` STRING COMMENT 'Detailed description of the strategic and technical objectives of the drilling program, including target resource category upgrade, geological model validation, or feasibility study support.',
    `program_start_date` DATE COMMENT 'Planned or actual date when drilling operations commenced for this program. Critical for Life of Mine (LOM) planning and resource update scheduling.',
    `program_status` STRING COMMENT 'Current lifecycle status of the drilling program: planned (design phase), approved (budget authorized), active (drilling underway), suspended (temporarily halted), completed (all holes drilled and signed off), or cancelled (terminated before completion).. Valid values are `planned|approved|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the drilling program based on its strategic purpose: scout (initial exploration), infill (increasing resource confidence), step-out (extending known mineralization), resource definition (JORC/NI 43-101 compliance), geotechnical (engineering studies), or condemnation (proving absence of mineralization).. Valid values are `scout|infill|step_out|resource_definition|geotechnical|condemnation`',
    `qaqc_protocol_applied` BOOLEAN COMMENT 'Indicates whether a formal QAQC protocol (including certified reference materials, blanks, and duplicates) was applied during the drilling program to ensure sample integrity and assay reliability.',
    `rehabilitation_completed` BOOLEAN COMMENT 'Indicates whether site rehabilitation (drill pad restoration, collar capping, and environmental remediation) has been completed following the conclusion of the drilling program.',
    `rehabilitation_completion_date` DATE COMMENT 'Date when site rehabilitation activities were completed and the drill site was returned to its pre-disturbance condition or approved final land use.',
    `sign_off_date` DATE COMMENT 'Date when the Competent Person formally approved the drilling program results for inclusion in resource and reserve reporting.',
    `sign_off_status` STRING COMMENT 'Approval status of the drilling program results by the Competent Person: pending (awaiting review), in_review (under technical review), approved (signed off for resource update), or rejected (requires additional work).. Valid values are `pending|in_review|approved|rejected`',
    `target_resource_category` STRING COMMENT 'JORC/NI 43-101/SAMREC resource classification category that the drilling program aims to achieve or upgrade: inferred (lowest confidence), indicated (moderate confidence), or measured (highest confidence).. Valid values are `inferred|indicated|measured`',
    CONSTRAINT pk_drill_program PRIMARY KEY(`drill_program_id`)
) COMMENT 'Defines a planned and executed drilling campaign associated with a prospect or resource area. Captures program name, target commodity, program type (scout, infill, step-out, resource definition), planned versus actual hole count, planned versus actual metreage, program start and end dates, approved budget (CAPEX/OPEX), actual expenditure, program objectives, and sign-off status. Links to the exploration licence and prospect. Enables LOM drilling program tracking and JORC-compliant resource update planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`drill_hole_survey` (
    `drill_hole_survey_id` BIGINT COMMENT 'Unique identifier for the drill hole survey measurement record.',
    `drill_hole_id` BIGINT COMMENT 'Reference to the parent drill hole for which this survey measurement was taken.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Downhole survey instruments (gyroscopes, magnetic tools) are tracked as equipment assets requiring calibration and maintenance records. Linking drill_hole_survey to the instrument asset enables calibr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Downhole directional surveys are performed by specialist survey contractors who are registered vendors. Mining operations require vendor traceability for instrument calibration records, insurance comp',
    `calculated_easting` DECIMAL(18,2) COMMENT 'Calculated easting coordinate at this survey depth based on collar position, azimuth, and dip measurements.',
    `calculated_elevation` DECIMAL(18,2) COMMENT 'Calculated elevation (reduced level) at this survey depth based on collar elevation and dip measurements.',
    `calculated_northing` DECIMAL(18,2) COMMENT 'Calculated northing coordinate at this survey depth based on collar position, azimuth, and dip measurements.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the survey instrument prior to this measurement.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding this survey measurement, including any anomalies, instrument issues, or special conditions.',
    `coordinate_system` STRING COMMENT 'Spatial reference system or coordinate system used for azimuth and spatial calculations (e.g., WGS84, local mine grid, UTM zone).',
    `data_source` STRING COMMENT 'Source system or database from which this survey measurement was imported (e.g., Hexagon MinePlan, Geovia GEMS, contractor database).',
    `deviation_from_planned` DECIMAL(18,2) COMMENT 'Calculated horizontal deviation distance from the planned drill hole trajectory at this survey depth, measured in meters.',
    `magnetic_declination` DECIMAL(18,2) COMMENT 'Magnetic declination correction applied to convert magnetic azimuth to true azimuth at the survey location and date. Positive values indicate eastward declination.',
    `magnetic_field_strength` DECIMAL(18,2) COMMENT 'Magnetic field strength measured at the survey point in nanoTesla. High magnetic interference may affect magnetic survey instrument accuracy.',
    `measured_azimuth` DECIMAL(18,2) COMMENT 'Horizontal angle of the drill hole at this survey point, measured in degrees clockwise from true north (0-360).',
    `measured_dip` DECIMAL(18,2) COMMENT 'Vertical angle of the drill hole at this survey point, measured in degrees from horizontal. Negative values indicate downward inclination.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey measurement record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey measurement record was last modified in the system.',
    `survey_date` DATE COMMENT 'Date on which the downhole survey measurement was taken.',
    `survey_depth` DECIMAL(18,2) COMMENT 'Depth down the hole at which this survey measurement was taken, measured in meters from the collar.',
    `survey_instrument_type` STRING COMMENT 'Type of downhole survey instrument used to capture this measurement. Gyroscope instruments are preferred for accuracy in magnetic environments.. Valid values are `gyroscope|magnetic|multi-shot|single-shot|electronic_multi-shot|reflex`',
    `survey_method` STRING COMMENT 'Method by which the survey was conducted: end of hole survey, during drilling at intervals, post-drilling, or continuous measurement.. Valid values are `end_of_hole|during_drilling|post_drilling|continuous`',
    `survey_quality_code` STRING COMMENT 'Quality assessment code indicating the reliability and verification status of this survey measurement.. Valid values are `verified|unverified|suspect|rejected|recalibrated`',
    `survey_run_number` STRING COMMENT 'Sequential number identifying the survey run or trip down the hole. Multiple runs may be performed for verification.',
    `survey_status` STRING COMMENT 'Current workflow status of this survey measurement record in the data validation and approval process.. Valid values are `draft|validated|approved|superseded|rejected`',
    `temperature_at_survey` DECIMAL(18,2) COMMENT 'Temperature recorded at the survey depth during measurement, in degrees Celsius. Temperature can affect instrument accuracy.',
    `validated_by` STRING COMMENT 'Name or identifier of the geologist or data manager who validated and approved this survey measurement.',
    `validation_date` DATE COMMENT 'Date on which this survey measurement was validated and approved for use in resource estimation.',
    CONSTRAINT pk_drill_hole_survey PRIMARY KEY(`drill_hole_survey_id`)
) COMMENT 'Downhole survey measurements capturing the deviation of a drill hole from its planned trajectory at regular depth intervals. Records hole ID, survey depth, measured azimuth, measured dip, survey instrument type (gyroscope, magnetic, multi-shot), survey date, and surveyor. Essential for accurate 3D spatial positioning of assay intervals and geological logging data used in resource estimation and Geovia GEMS block model construction.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`geological_log` (
    `geological_log_id` BIGINT COMMENT 'Unique identifier for the geological log record. Primary key for the geological log entity. Inferred role: EVENT_LOG (append-only geological observations per drill hole interval).',
    `drill_hole_id` BIGINT COMMENT 'Unique identifier for the drill hole from which this geological log was recorded. Links to the drill hole collar and survey data. Represents the EVENT_SOURCE_REFERENCE for this log entry.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Geological logs identify hazardous lithologies (asbestos-bearing formations, acid-generating rock, naturally occurring radioactive material). Mining HSE and environmental regulations require geologist',
    `alteration_intensity` STRING COMMENT 'Qualitative assessment of the intensity or degree of alteration observed: none, weak, moderate, strong, or pervasive. Used in conjunction with alteration_type for resource modeling.. Valid values are `none|weak|moderate|strong|pervasive`',
    `alteration_type` STRING COMMENT 'Type of hydrothermal or weathering alteration observed in the interval (e.g., silicification, chloritisation, sericitisation, hematisation). Critical for understanding mineralization processes and JORC Table 1 Section 1 reporting.',
    `colour` STRING COMMENT 'Primary colour of the rock observed in the interval (e.g., grey, red, green, black, white). May indicate oxidation state, alteration, or lithology.',
    `comments` STRING COMMENT 'Free-text comments and observations recorded by the geologist during logging. May include additional details not captured in structured fields.',
    `core_condition` STRING COMMENT 'Overall condition of the drill core: excellent, good, fair, poor, or very_poor. Reflects core integrity and quality for geological interpretation.. Valid values are `excellent|good|fair|poor|very_poor`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geological log record was first created in the system. Part of audit trail for data lineage and JORC compliance.',
    `data_source` STRING COMMENT 'Source of the geological log data: field_logging (original logging at drill site), re_logging (subsequent re-interpretation), or historical_import (legacy data migration).. Valid values are `field_logging|re_logging|historical_import`',
    `depth_from` DECIMAL(18,2) COMMENT 'Starting depth of the logged interval in meters below surface or collar. Used to define the from-to interval for geological observations.',
    `depth_to` DECIMAL(18,2) COMMENT 'Ending depth of the logged interval in meters below surface or collar. Used to define the from-to interval for geological observations.',
    `grain_size` STRING COMMENT 'Classification of the grain size of the rock: very_fine, fine, medium, coarse, or very_coarse. Relevant for sedimentary and some igneous rocks.. Valid values are `very_fine|fine|medium|coarse|very_coarse`',
    `hardness` STRING COMMENT 'Qualitative assessment of rock hardness: very_soft, soft, medium, hard, or very_hard. Relevant for drilling performance and geotechnical assessment.. Valid values are `very_soft|soft|medium|hard|very_hard`',
    `interval_length` DECIMAL(18,2) COMMENT 'Length of the logged interval in meters, calculated as depth_to minus depth_from. Represents the sample or observation interval.',
    `lithology_code` STRING COMMENT 'Standardized code representing the primary rock type observed in this interval (e.g., BIF for Banded Iron Formation, GRN for Granite, SHL for Shale). Follows site-specific or regional lithology coding standards.. Valid values are `^[A-Z]{2,6}$`',
    `lithology_description` STRING COMMENT 'Detailed textual description of the rock type, including texture, grain size, composition, and any distinguishing features observed by the geologist.',
    `logging_date` DATE COMMENT 'Date when the geological logging was performed. Represents the EVENT_TIMESTAMP for this observation. Critical for data lineage and JORC Table 1 Section 1 reporting.',
    `logging_method` STRING COMMENT 'Method used to perform the geological logging: visual (traditional manual logging), digital (tablet-based logging), or photographic (image-based logging with subsequent interpretation).. Valid values are `visual|digital|photographic`',
    `mineralisation_intensity` STRING COMMENT 'Qualitative assessment of the intensity or abundance of visible mineralization: none, trace, minor, moderate, or strong. Used for preliminary grade estimation and targeting.. Valid values are `none|trace|minor|moderate|strong`',
    `mineralisation_style` STRING COMMENT 'Description of the style and form of mineralization observed (e.g., disseminated, vein-hosted, massive sulfide, replacement, stockwork). Critical for understanding ore body geometry and JORC reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geological log record was last modified. Part of audit trail for data lineage and change tracking.',
    `oxidation_state` STRING COMMENT 'Oxidation state of the mineralization: oxide (fully oxidized), transitional (partially oxidized), or fresh_sulfide (unoxidized). Critical for metallurgical processing and resource classification.. Valid values are `oxide|transitional|fresh_sulfide`',
    `qaqc_status` STRING COMMENT 'Quality control status of the geological log record: pending (awaiting review), approved (validated and accepted), rejected (failed QC checks), or under_review (currently being reviewed). Critical for JORC Table 1 Section 1 data quality reporting.. Valid values are `pending|approved|rejected|under_review`',
    `recovery_percent` DECIMAL(18,2) COMMENT 'Percentage of core recovered from the drilled interval, calculated as recovered core length divided by drilled interval length. Critical quality indicator for drill hole data and JORC Table 1 Section 1 reporting.',
    `rock_type` STRING COMMENT 'High-level classification of the rock type into major geological categories: igneous, sedimentary, metamorphic, or unconsolidated material.. Valid values are `igneous|sedimentary|metamorphic|unconsolidated`',
    `rqd_percent` DECIMAL(18,2) COMMENT 'Rock Quality Designation expressed as a percentage, calculated as the sum of core pieces greater than 10cm divided by the interval length. Standard geotechnical measure of rock mass quality ranging from 0 to 100 percent.',
    `sample_collected_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a physical sample was collected from this interval for assay analysis. True if sample was collected, False otherwise.',
    `structure_orientation` STRING COMMENT 'Orientation of structural features recorded as dip direction and dip angle (e.g., 045/60 meaning dipping 60 degrees towards 045 azimuth). Critical for structural modeling and geotechnical assessment.',
    `structure_type` STRING COMMENT 'Type of structural feature observed in the interval (e.g., fault, shear zone, joint, fracture, foliation, bedding). Important for understanding ore controls and geotechnical properties.',
    `texture` STRING COMMENT 'Description of the rock texture (e.g., massive, foliated, banded, brecciated, porphyritic). Provides information on rock formation and deformation history.',
    `vein_type` STRING COMMENT 'Description of vein mineralogy and characteristics (e.g., quartz vein, calcite vein, sulfide vein). Critical for understanding mineralization style and ore genesis.',
    `veining_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of the interval occupied by veins. Important for understanding mineralization distribution and structural controls.',
    `weathering_degree` STRING COMMENT 'Degree of weathering observed in the rock: fresh, slightly_weathered, moderately_weathered, highly_weathered, or completely_weathered. Important for understanding near-surface ore characteristics and geotechnical properties.. Valid values are `fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered`',
    CONSTRAINT pk_geological_log PRIMARY KEY(`geological_log_id`)
) COMMENT 'Detailed geological logging records for each drill hole interval during exploration and resource definition drilling. Captures lithology, rock type, alteration type and intensity, mineralisation style, structural features, RQD (Rock Quality Designation), recovery percentage, colour, grain size, weathering, oxidation state, and geologist identifier. Logged at defined depth intervals (from-to) per drill hole. Scoped to exploration-phase drilling — production-phase grade control logging is owned by the geology domain. Forms the primary geological dataset for resource estimation and JORC Table 1 Section 1 disclosures.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`exploration_sample` (
    `exploration_sample_id` BIGINT COMMENT 'Unique identifier for the exploration sample record. Primary key for the sample entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Exploration samples (soil, rock chip, channel) are collected using specific equipment (augers, excavators, portable drills). Tracking collection equipment supports QA/QC protocols, method validation, ',
    `drill_hole_id` BIGINT COMMENT 'Reference to the drill hole from which this sample was collected. Null for non-drill samples such as soil, rock chip, or stream sediment samples.',
    `geological_log_id` BIGINT COMMENT 'Foreign key linking to exploration.geological_log. Business justification: An exploration sample collected from a drill core interval is directly associated with the geological log entry for that interval. geological_log has sample_collected_flag indicating a sample was take',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Exploration samples from hazardous materials (radioactive minerals, asbestos, acid-generating rock) must reference the relevant hazard for safe handling, storage, and disposal. Mining HSE regulations ',
    `parent_sample_exploration_sample_id` BIGINT COMMENT 'Reference to the original sample from which this sample was derived (e.g., for duplicates, replicates, or sub-samples). Null for primary field samples.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Exploration samples are collected from specific prospects. Currently sample stores prospect_code as a denormalized string identifier. Adding prospect_id FK to the prospect master table normalizes this',
    `survey_id` BIGINT COMMENT 'Foreign key linking to exploration.survey. Business justification: Surface samples (soil, rock chip, stream sediment, water) collected during a geochemical or geophysical survey program should reference the survey they belong to. exploration_sample already has drill_',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Exploration samples in feasibility-stage projects are tested against target product specifications (e.g., lump vs fines iron ore, concentrate grade) - critical for metallurgical testwork, product qual',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: exploration_sample carries a plain tenement_code attribute — a denormalized reference to tenement.statutory_identifier. Chain-of-custody documentation and statutory sample reporting require samples ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Assay laboratories are vendors providing analytical services. Links samples to vendor master for lab performance tracking, cost analysis, quality correlation, turnaround time monitoring, and contract ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Exploration samples are physically stored in site warehouses or cool rooms before dispatch to laboratories. Linking to warehouse_location enables chain-of-custody tracking, storage condition complianc',
    `alteration_code` STRING COMMENT 'Code representing the type and intensity of hydrothermal or weathering alteration observed in the sample. Important for understanding mineralization controls.',
    `analytical_method` STRING COMMENT 'Requested analytical technique or method suite for this sample (e.g., fire assay, ICP-MS, XRF). Determines which elements or compounds will be analyzed and detection limits.',
    `chain_of_custody_status` STRING COMMENT 'Current physical location or custody status of the sample. Critical for sample tracking, security, and audit compliance.. Valid values are `field|transit|laboratory|storage|disposed`',
    `collection_date` DATE COMMENT 'Date when the sample was physically collected from the field or drill site. Critical for chain of custody and temporal analysis of exploration programs.',
    `collection_method` STRING COMMENT 'The technique or equipment used to collect the sample from the field. Critical for understanding sample quality, representativeness, and potential biases.. Valid values are `diamond_drilling|reverse_circulation|channel_sampling|grab_sampling|auger_drilling|sonic_drilling`',
    `coordinate_system` STRING COMMENT 'Spatial reference system used for the sample location coordinates (e.g., WGS84 UTM Zone 50S, GDA94 MGA Zone 51). Critical for accurate spatial integration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was first created in the system. Used for audit trail and data lineage tracking.',
    `dispatch_batch_number` STRING COMMENT 'Identifier for the batch or shipment in which this sample was sent to the laboratory. Used for tracking, logistics, and grouping samples for analysis.',
    `dispatch_date` DATE COMMENT 'Date when the sample was dispatched from the field or core facility to the analytical laboratory. Part of chain of custody documentation.',
    `easting_m` DECIMAL(18,2) COMMENT 'Easting coordinate of the sample collection point in meters, typically in a projected coordinate system (e.g., UTM). Used for spatial analysis and resource modeling.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the sample collection point in meters above mean sea level. Used for 3D spatial modeling and geological interpretation.',
    `from_depth_m` DECIMAL(18,2) COMMENT 'Starting depth in meters of the sample interval measured from drill hole collar. Null for surface samples. Used with to_depth_m to define the sample interval.',
    `geologist_comments` STRING COMMENT 'Free-text field for geologist observations, notes, or interpretations recorded during sample collection or logging. Captures qualitative information not represented in coded fields.',
    `is_composite` BOOLEAN COMMENT 'Flag indicating whether this sample is a composite created by combining multiple individual samples. Composites are used for resource estimation and grade control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was last updated in the system. Used for audit trail and change tracking.',
    `length_m` DECIMAL(18,2) COMMENT 'Physical length of the sample interval in meters. For drill samples, typically calculated as to_depth_m minus from_depth_m. Critical for understanding sample support and compositing.',
    `lithology_code` STRING COMMENT 'Code representing the rock type or geological unit observed at the sample interval. Used for geological modeling and domain definition.',
    `mineralization_code` STRING COMMENT 'Code representing the style, type, or intensity of mineralization observed in the sample. Used for targeting and geological interpretation.',
    `northing_m` DECIMAL(18,2) COMMENT 'Northing coordinate of the sample collection point in meters, typically in a projected coordinate system (e.g., UTM). Used for spatial analysis and resource modeling.',
    `preparation_instructions` STRING COMMENT 'Specific instructions for laboratory sample preparation including crushing, grinding, splitting, and sub-sampling protocols. May reference standard preparation codes or custom procedures.',
    `qaqc_reference_material` STRING COMMENT 'Identifier of the certified reference material (CRM) or standard used for this QAQC sample. Null for routine samples. Used to validate laboratory accuracy.',
    `qaqc_type` STRING COMMENT 'Classification of the sample for quality assurance and quality control purposes. Routine samples are normal field samples; duplicates, blanks, standards, and replicates are control samples inserted to monitor analytical accuracy and precision.. Valid values are `routine|duplicate|blank|standard|replicate`',
    `recovery_percent` DECIMAL(18,2) COMMENT 'Percentage of core or sample material recovered relative to the drilled or sampled interval. Low recovery may indicate sample quality issues or geological conditions such as voids or fracturing.',
    `sample_number` STRING COMMENT 'Externally-known unique sample identifier assigned during collection. Used for laboratory tracking, chain of custody, and cross-referencing with assay results. Typically follows site-specific numbering conventions.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample in the exploration workflow. Tracks progression from field collection through laboratory analysis to final data integration. [ENUM-REF-CANDIDATE: collected|dispatched|at_laboratory|prepared|assayed|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the physical sample based on collection method and material form. Determines handling, preparation, and analytical protocols. [ENUM-REF-CANDIDATE: drill_core_half|drill_core_quarter|rc_chips|channel|soil|rock_chip|stream_sediment — 7 candidates stripped; promote to reference product]',
    `to_depth_m` DECIMAL(18,2) COMMENT 'Ending depth in meters of the sample interval measured from drill hole collar. Null for surface samples. Used with from_depth_m to define the sample interval.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the sample in kilograms as collected in the field. Used for quality control, recovery calculations, and preparation planning.',
    CONSTRAINT pk_exploration_sample PRIMARY KEY(`exploration_sample_id`)
) COMMENT 'Master record for every physical sample collected during exploration activities including drill core (half-core, quarter-core), RC chips, channel samples, soil samples, rock chips, and stream sediment samples. Captures sample ID, sample type, collection method, drill hole reference, from-to depth interval, sample weight, sample length, dispatch batch number, dispatch date to laboratory, chain of custody status, QA/QC type (routine, duplicate, blank, standard, replicate), and preparation instructions. The SSOT for sample identity and collection metadata in the exploration domain; analytical results (assays) are owned by the laboratory domain and linked back via sample ID foreign key.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`survey` (
    `survey_id` BIGINT COMMENT 'Unique identifier for the exploration survey program. Primary key.',
    `competent_person_id` BIGINT COMMENT 'Foreign key linking to exploration.competent_person. Business justification: Geophysical surveys reference the competent person responsible for survey design and interpretation. Currently survey stores competent_person_name and competent_person_registration as denormalized str',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Geophysical and other exploration surveys are executed under formal service contracts with specialist vendors. Mining procurement requires surveys to reference the governing contract for scope complia',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Geophysical and geochemical surveys are discrete cost objects with significant expenditure tracked to cost centres for exploration budget reporting. Mining finance teams require cost centre assignment',
    `licence_id` BIGINT COMMENT 'Foreign key linking to exploration.licence. Business justification: A geophysical or geochemical survey is conducted within the bounds of an exploration licence. The licence defines the legal area and conditions under which the survey is authorised. survey already ref',
    `prospect_id` BIGINT COMMENT 'Reference to the exploration prospect or tenement area where this survey was conducted.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Geophysical surveys target commodity-specific signatures (magnetics for iron ore/magnetite, EM for sulfide copper/nickel, gravity for massive sulfides) - determines survey method selection and interpr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Geophysical survey contractors are vendors. Links to vendor master for contractor performance tracking, cost management, contract compliance, and procurement planning. Essential for multi-survey contr',
    `acquisition_end_date` DATE COMMENT 'Date when field data acquisition or sample collection was completed for this survey program. Null if survey is ongoing.',
    `acquisition_start_date` DATE COMMENT 'Date when field data acquisition or sample collection commenced for this survey program.',
    `anomaly_count` STRING COMMENT 'Number of discrete anomalies identified from the survey that meet the anomaly threshold criteria and are recommended for follow-up investigation or drilling.',
    `anomaly_threshold` STRING COMMENT 'Statistical or empirical criteria used to define anomalous values that warrant follow-up investigation (e.g., mean + 2 standard deviations, >100 ppb Au). Used for target generation.',
    `area_km2` DECIMAL(18,2) COMMENT 'Total area covered by the survey program in square kilometers. Used for cost estimation and coverage analysis.',
    `coordinate_system` STRING COMMENT 'Spatial reference system used for survey location data (e.g., GDA2020 MGA Zone 50, WGS84 UTM Zone 51S). Critical for GIS integration and spatial analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the survey cost (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `data_format` STRING COMMENT 'File format and structure of the raw survey data (e.g., XYZ ASCII, Geosoft GDB, CSV, LAS, SEGY). Critical for data integration and processing workflows.',
    `data_storage_location` STRING COMMENT 'File path, database location, or cloud storage URI where the raw and processed survey data files are stored. Used for data retrieval and audit trail.',
    `detection_limit` STRING COMMENT 'Minimum detectable concentration or signal threshold for the survey method. For geochemical: analytical detection limits (e.g., 0.01 ppm Au). For geophysical: instrument sensitivity specifications.',
    `grid_spacing_m` DECIMAL(18,2) COMMENT 'Distance in meters between sample points in a regular grid for geochemical surveys (e.g., soil sampling grid). Null for line-based geophysical surveys.',
    `interpretation_status` STRING COMMENT 'Current state of geological interpretation and anomaly identification: pending (not started), in_progress (geologist reviewing), completed (interpretation finished), peer_reviewed (technical review done), approved (sign-off for drill targeting).. Valid values are `pending|in_progress|completed|peer_reviewed|approved`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this survey record is currently active (true) or has been archived/superseded (false). Used for filtering current operational surveys.',
    `line_spacing_m` DECIMAL(18,2) COMMENT 'Distance in meters between survey lines for geophysical surveys (e.g., airborne flight lines, ground traverse lines). Null for geochemical grid surveys.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, limitations, or special conditions related to the survey (e.g., weather delays, equipment issues, access constraints, data quality concerns).',
    `processing_status` STRING COMMENT 'Current state of data processing workflow: raw (unprocessed field data), in_progress (undergoing corrections and transformations), completed (processing finished), validated (QC approved), archived (final data stored).. Valid values are `raw|in_progress|completed|validated|archived`',
    `report_reference` STRING COMMENT 'Document reference or identifier for the final survey interpretation report (e.g., internal report number, contractor report ID). Links to document management system.',
    `sample_count` STRING COMMENT 'Total number of physical samples collected for geochemical surveys. Null for geophysical surveys that do not involve physical sampling.',
    `sample_interval_m` DECIMAL(18,2) COMMENT 'Distance in meters between individual sample collection points along a line or within a grid. Applicable to both geophysical station spacing and geochemical sample spacing.',
    `survey_method` STRING COMMENT 'Specific survey technique employed. For geophysical: airborne magnetics, gravity, electromagnetic (EM), induced polarization (IP), seismic, radiometric. For geochemical: soil sampling, stream sediment, rock chip, auger, lag sampling.',
    `survey_name` STRING COMMENT 'Business name or identifier for the survey program, typically including location and year (e.g., Mt Whaleback Airborne Magnetics 2023).',
    `survey_type` STRING COMMENT 'High-level classification of the survey method: geophysical (remote sensing, non-invasive) or geochemical (physical sampling and analysis).. Valid values are `geophysical|geochemical`',
    `total_line_km` DECIMAL(18,2) COMMENT 'Total length of survey lines flown or traversed in kilometers for geophysical surveys. Null for grid-based geochemical surveys.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Master record for all exploration survey programs conducted over prospect areas, encompassing both geophysical methods (airborne magnetics, gravity, EM, IP, seismic, radiometric) and geochemical methods (soil sampling grids, stream sediment surveys, rock chip programs). Captures survey name, survey type (geophysical or geochemical), survey method, target commodity, contractor, acquisition/collection date range, line spacing or grid spacing, sample interval, coordinate system, number of samples collected (geochemical), detection limits, anomaly threshold criteria, data format, processing status, and interpretation status. Surveys are primary exploration targeting tools used to identify anomalies and prioritise drill targets. Unified register eliminates dual maintenance of geophysical and geochemical survey campaigns.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`resource_estimate` (
    `resource_estimate_id` BIGINT COMMENT 'Unique identifier for the mineral resource estimate record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Resource estimates quantify tonnage and grade of specific commodities - mandatory for JORC/NI 43-101 reporting, investor disclosure, and mine planning. Normalizes existing commodity text field to ensu',
    `competent_person_id` BIGINT COMMENT 'Foreign key linking to exploration.competent_person. Business justification: Resource estimates must be signed off by a JORC/NI 43-101 competent person. Currently resource_estimate stores competent_person_name, competent_person_credentials, and competent_person_organization as',
    `orebody_id` BIGINT COMMENT 'Reference to the mineral deposit or prospect for which this resource estimate was prepared.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: A resource estimate is computed for a specific prospect or deposit area. This is a core in-domain relationship — the resource estimate quantifies the mineral resource identified at a prospect. ore_res',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Resource estimates define expected grade and quality of an ore body; product managers and geologists reference the target product specification to confirm the mineralisation meets contractual quality ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Resource estimates are prepared under specific WBS elements for JORC reporting and impairment testing. Mining finance requires WBS linkage on resource estimates to accumulate capitalised exploration c',
    `average_grade` DECIMAL(18,2) COMMENT 'The average grade of the primary commodity across the estimated resource tonnage.',
    `average_grade_unit` STRING COMMENT 'Unit of measure for average grade (e.g., %, g/t, ppm, oz/t).',
    `comments` STRING COMMENT 'Additional comments, notes, or qualifications regarding the resource estimate, including material assumptions or limitations.',
    `contained_metal` DECIMAL(18,2) COMMENT 'The total quantity of contained metal calculated as tonnage multiplied by average grade, expressed in appropriate units (e.g., tonnes, ounces).',
    `contained_metal_unit` STRING COMMENT 'Unit of measure for contained metal (e.g., t, kt, Mt, oz, koz, Moz).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this resource estimate record was first created in the system.',
    `cut_off_grade` DECIMAL(18,2) COMMENT 'The minimum economic grade used to define the resource boundary. Material below this grade is considered waste.',
    `cut_off_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade (e.g., %, g/t, ppm).',
    `density_assumption` DECIMAL(18,2) COMMENT 'Assumed bulk density (tonnes per cubic metre) used in tonnage calculations for the resource estimate.',
    `effective_date` DATE COMMENT 'The date on which this resource estimate is effective and represents the state of geological knowledge and data.',
    `estimate_confidence_level` STRING COMMENT 'Overall confidence level in the resource estimate based on data quality, density, and geological understanding.. Valid values are `High|Medium|Low`',
    `estimate_name` STRING COMMENT 'Business name or title of the resource estimate, typically referencing the deposit, prospect, or project name.',
    `estimate_status` STRING COMMENT 'Current lifecycle status of the resource estimate within the approval and governance workflow.. Valid values are `Draft|Under Review|Approved|Superseded|Archived`',
    `estimate_type` STRING COMMENT 'Classification of the estimate within the project lifecycle (e.g., initial, updated, revised, final).. Valid values are `Initial|Updated|Revised|Final`',
    `estimation_method` STRING COMMENT 'The geostatistical or geometric method used to estimate grades and tonnages (e.g., kriging, inverse distance weighting, nearest neighbour). [ENUM-REF-CANDIDATE: Ordinary Kriging|Indicator Kriging|Multiple Indicator Kriging|Inverse Distance Weighting|Nearest Neighbour|Polygonal|Other — 7 candidates stripped; promote to reference product]',
    `metallurgical_recovery_assumption` DECIMAL(18,2) COMMENT 'Assumed metallurgical recovery rate (percentage) used in economic assessment for reasonable prospects of eventual economic extraction.',
    `mining_method_assumption` STRING COMMENT 'The assumed mining method used in determining reasonable prospects for eventual economic extraction (e.g., open pit, underground, sub-level caving).',
    `public_disclosure_date` DATE COMMENT 'Date on which this resource estimate was publicly disclosed to the market or regulatory authorities.',
    `report_reference` STRING COMMENT 'Reference to the technical report or public filing document containing the full details of this resource estimate.',
    `reporting_standard` STRING COMMENT 'The international mineral resource reporting standard under which this estimate was prepared and reported.. Valid values are `JORC 2012|JORC 2004|NI 43-101|SAMREC|SEC S-K 1300|CIM`',
    `resource_classification` STRING COMMENT 'The confidence classification of the mineral resource: Measured (highest confidence), Indicated (moderate confidence), or Inferred (lowest confidence).. Valid values are `Measured|Indicated|Inferred`',
    `sample_count` STRING COMMENT 'Total number of assay samples used in the estimation process.',
    `sign_off_date` DATE COMMENT 'The date on which the Competent Person formally signed off and approved this resource estimate.',
    `tonnage` DECIMAL(18,2) COMMENT 'Total estimated tonnage of mineralized material in the resource category, typically expressed in million tonnes (Mt) or thousand tonnes (kt).',
    `tonnage_unit` STRING COMMENT 'Unit of measure for tonnage: tonnes (t), thousand tonnes (kt), million tonnes (Mt), or billion tonnes (Gt).. Valid values are `t|kt|Mt|Gt`',
    `total_metres_drilled` DECIMAL(18,2) COMMENT 'Total metres of drilling completed and used as the basis for this resource estimate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this resource estimate record was last modified in the system.',
    CONSTRAINT pk_resource_estimate PRIMARY KEY(`resource_estimate_id`)
) COMMENT 'JORC/NI 43-101/SAMREC-compliant mineral resource estimate for a defined deposit or prospect. Captures estimate name, effective date, reporting standard (JORC 2012, NI 43-101, SAMREC), commodity, classification (Measured, Indicated, Inferred), estimation method (kriging, IDW, nearest neighbour), cut-off grade, tonnage, average grade, contained metal, block model reference, competent person name and credentials, and sign-off date. The authoritative SSOT for resource inventory reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`ore_reserve` (
    `ore_reserve_id` BIGINT COMMENT 'Unique identifier for the ore reserve statement. Primary key for the ore reserve entity.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Ore reserves are commodity-specific economic inventories - required for mine planning, production scheduling, and ASX/SEC disclosure. Normalizes existing commodity text field to enforce consistent com',
    `competent_person_id` BIGINT COMMENT 'Foreign key linking to exploration.competent_person. Business justification: Ore reserves must be signed off by a JORC/NI 43-101 competent person. Currently ore_reserve stores competent_person_name, competent_person_credentials, and competent_person_organization as denormalize',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Ore reserves represent the economically mineable portion of an orebody. Every ore reserve declaration in mining operations must reference the specific orebody it pertains to for mine planning, product',
    `pricing_basis_id` BIGINT COMMENT 'Foreign key linking to product.pricing_basis. Business justification: Ore reserve economic viability assessments (NPV, LOM valuations, board sign-off) must reference a specific formal pricing basis. The existing commodity_price_assumption and commodity_price_currency pl',
    `prospect_id` BIGINT COMMENT 'Reference to the mineral deposit for which this ore reserve statement is prepared.',
    `resource_estimate_id` BIGINT COMMENT 'Reference to the underlying Measured or Indicated Mineral Resource estimate from which this ore reserve is derived.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Ore reserve declarations require modifying factors including metallurgical recovery and cut-off grade, which are set against a specific product specification. Board sign-off and public disclosure of r',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Ore reserves in operating/near-production mines are converted to specific saleable products in life-of-mine plans - required for NPV modeling, offtake contract planning, and production scheduling. Lin',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Ore reserve declarations drive LOM capital planning and are linked to WBS elements for capex allocation and units-of-production depreciation calculations. Mining finance teams use reserve-to-WBS linka',
    `approval_date` DATE COMMENT 'Date on which the ore reserve statement was formally approved by the Competent Person and authorized for public disclosure.',
    `average_grade` DECIMAL(18,2) COMMENT 'Weighted average grade of the valuable mineral or metal in the ore reserve, calculated after application of dilution and mining recovery factors.',
    `average_grade_unit` STRING COMMENT 'Unit of measure for the average grade, typically percentage (%) for bulk commodities or grams per tonne (g/t) for precious metals.',
    `board_sign_off_date` DATE COMMENT 'Date on which the ore reserve statement was formally endorsed and signed off by the company board of directors for regulatory reporting and public disclosure.',
    `contained_metal` DECIMAL(18,2) COMMENT 'Total quantity of contained metal or mineral in the ore reserve, calculated as reserve tonnage multiplied by average grade.',
    `contained_metal_unit` STRING COMMENT 'Unit of measure for the contained metal, typically tonnes, kilograms, or ounces depending on the commodity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ore reserve record was first created in the system.',
    `cut_off_grade` DECIMAL(18,2) COMMENT 'The minimum economic grade threshold applied to define ore from waste. Material below this grade is classified as waste and excluded from the ore reserve tonnage.',
    `cut_off_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade, typically percentage (%) for bulk commodities or grams per tonne (g/t) for precious metals.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Percentage or factor representing the expected dilution of ore grade due to unplanned inclusion of waste material during mining operations.',
    `disclosure_date` DATE COMMENT 'Date on which the ore reserve statement was publicly disclosed to the market and regulatory authorities.',
    `economic_assumptions` STRING COMMENT 'Summary of key economic assumptions used in the ore reserve calculation, including commodity prices, exchange rates, operating costs, and capital costs.',
    `effective_date` DATE COMMENT 'The date as of which the ore reserve estimate is current and valid, representing the cut-off for all data and assumptions used in the reserve calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ore reserve record was last updated or modified in the system.',
    `lom_years` DECIMAL(18,2) COMMENT 'Estimated life of mine in years based on the ore reserve tonnage and planned annual production rate.',
    `metallurgical_recovery_factor` DECIMAL(18,2) COMMENT 'Percentage or factor representing the expected proportion of contained metal that will be recovered during mineral processing and beneficiation.',
    `mining_method` STRING COMMENT 'The planned mining method to be applied for extraction of the ore reserve, which influences dilution, recovery, and economic viability. [ENUM-REF-CANDIDATE: Open Pit|Underground|SLC|Block Cave|Longwall|Room and Pillar|Cut and Fill|Sublevel Stoping — 8 candidates stripped; promote to reference product]',
    `mining_recovery_factor` DECIMAL(18,2) COMMENT 'Percentage or factor representing the expected proportion of in-situ ore that will be successfully extracted during mining operations.',
    `modifying_factors_applied` STRING COMMENT 'Description of the modifying factors applied to convert the Mineral Resource to an Ore Reserve, including mining, metallurgical, economic, marketing, legal, environmental, social, and governmental considerations.',
    `remarks` STRING COMMENT 'Additional notes, comments, or qualifications related to the ore reserve estimate, including material risks, uncertainties, or assumptions.',
    `reporting_standard` STRING COMMENT 'The international mineral resource and reserve reporting standard under which this ore reserve statement is prepared and disclosed.. Valid values are `JORC|NI 43-101|SAMREC|SEC S-K 1300|CIM|PERC`',
    `reserve_classification` STRING COMMENT 'Classification category of the ore reserve: Proved Reserve (highest confidence, derived from Measured Resource) or Probable Reserve (derived from Indicated Resource).. Valid values are `Proved|Probable`',
    `reserve_code` STRING COMMENT 'Unique business code or identifier for the ore reserve used in reporting and planning systems.',
    `reserve_name` STRING COMMENT 'Business name or designation of the ore reserve, typically referencing the deposit or mining area.',
    `reserve_status` STRING COMMENT 'Current lifecycle status of the ore reserve statement, indicating whether it is in draft, approved for use, publicly disclosed, superseded by a newer estimate, or archived.. Valid values are `Draft|Approved|Disclosed|Superseded|Archived`',
    `reserve_tonnage` DECIMAL(18,2) COMMENT 'Total tonnage of ore in the reserve after application of modifying factors including dilution, mining recovery, and cut-off grade.',
    `reserve_tonnage_unit` STRING COMMENT 'Unit of measure for the ore reserve tonnage.. Valid values are `tonnes|kilotonnes|megatonnes|short tons|long tons`',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste material (overburden) to ore that must be removed to access the ore reserve, applicable to open pit mining operations.',
    CONSTRAINT pk_ore_reserve PRIMARY KEY(`ore_reserve_id`)
) COMMENT 'JORC/NI 43-101/SAMREC-compliant ore reserve statement for a defined deposit, representing the economically mineable portion of a Measured or Indicated Mineral Resource. Captures reserve name, effective date, reporting standard, classification (Proved, Probable), mining method, dilution factor, mining recovery, cut-off grade, tonnage, average grade, contained metal, modifying factors applied, competent person credentials, and board sign-off date. Distinct from resource_estimate as it incorporates modifying factors and economic viability assessment.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`expenditure` (
    `expenditure_id` BIGINT COMMENT 'Primary key for expenditure',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Exploration expenditure must be attributed to specific equipment assets (drill rig hire, survey equipment) for statutory expenditure compliance reporting under JORC/NI 43-101 and for equipment-level c',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: Capitalised exploration expenditure under IFRS 6 must be tracked against capex budget lines. Mining companies capitalise qualifying exploration costs as intangible assets; linking expenditure to capex',
    `cost_centre_id` BIGINT COMMENT 'Reference to the SAP cost centre responsible for this expenditure, enabling financial reporting and variance analysis.',
    `drill_program_id` BIGINT COMMENT 'Reference to the exploration programme under which this expenditure was incurred or budgeted.',
    `expenditure_commitment_id` BIGINT COMMENT 'Foreign key linking to tenement.expenditure_commitment. Business justification: Exploration expenditure records must be reconciled against tenement statutory expenditure commitments for regulatory compliance reporting. Regulators assess whether minimum expenditure obligations are',
    `licence_id` BIGINT COMMENT 'Reference to the exploration licence (tenement) against which this expenditure is recorded for statutory compliance tracking.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Exploration expenditure postings require a GL account for IFRS 6 capitalisation vs expensing decisions and financial statement classification. Every expenditure record must reference a GL account to d',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: HSE incidents generate costs (medical treatment, environmental remediation, investigation) charged to exploration cost centers. Financial tracking requirement for incident cost recovery and budget var',
    `opex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.opex_budget. Business justification: Exploration expenditure is tracked against opex budgets for monthly budget vs actual variance reporting. Mining finance teams require direct linkage between actual exploration spend and the opex budge',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Exploration expenditure is posted to profit centres for segment reporting and commodity-level P&L analysis. Mining finance systems require profit centre on expenditure records to support IFRS 8 segmen',
    `prospect_id` BIGINT COMMENT 'Reference to the specific prospect or target area within the exploration programme where expenditure was incurred.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Exploration expenditure must trace to originating purchase orders for financial reconciliation, budget tracking, three-way match (PO-GR-Invoice), audit trail, and variance analysis. Essential for fina',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Statutory expenditure reporting to mining regulators requires direct tenement attribution. Not all exploration expenditure is prospect-specific (e.g., tenement holding costs, regional studies). Enable',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Exploration expenditure records track vendor payments for drilling, assaying, geophysics. Links to vendor master enables spend analysis by vendor, vendor performance correlation with exploration outco',
    `wbs_element_id` BIGINT COMMENT 'Reference to the SAP WBS element for project-based expenditure tracking and hierarchical cost roll-up.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance work order costs for drill rig servicing are charged to exploration cost centres and recorded as exploration expenditure for statutory minimum expenditure compliance reporting. Linking exp',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the expenditure or budget allocation in the specified currency.',
    `approval_date` DATE COMMENT 'Date on which the budget or expenditure was formally approved by the designated authority.',
    `budget_version` STRING COMMENT 'Version identifier for the budget, enabling tracking of multiple budget revisions throughout the financial year (e.g., V1, V2, V3).',
    `commitment_amount` DECIMAL(18,2) COMMENT 'The minimum statutory expenditure commitment amount required for the licence or programme in the specified financial period, used for compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this expenditure record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the expenditure amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Identifier of the source system from which this expenditure record originated (e.g., SAP S/4HANA, Pronto Xi, manual entry), supporting data lineage and reconciliation.',
    `document_number` STRING COMMENT 'The SAP financial document number (e.g., invoice number, journal entry number) associated with this expenditure, enabling traceability to source documents.',
    `expenditure_category` STRING COMMENT 'Classification of the expenditure type: drilling, geophysics, geochemistry, geological mapping, assaying, camp and logistics costs, feasibility studies, or other exploration-related activities. [ENUM-REF-CANDIDATE: drilling|geophysics|geochemistry|mapping|assaying|camp_costs|studies|other — 8 candidates stripped; promote to reference product]',
    `expenditure_date` DATE COMMENT 'The date on which the actual expenditure was incurred or the budget was allocated, serving as the principal business event timestamp for this record.',
    `expenditure_description` STRING COMMENT 'Free-text description providing additional context about the nature of the expenditure or budget allocation, including specific activities or deliverables.',
    `financial_period` STRING COMMENT 'The financial period (month) within the financial year, formatted as P01 through P12, enabling monthly budget vs actual tracking.. Valid values are `^P(0[1-9]|1[0-2])$`',
    `financial_year` STRING COMMENT 'The financial year to which this expenditure or budget applies, formatted as FY followed by the four-digit year (e.g., FY2024).. Valid values are `^FYd{4}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this expenditure record was last modified, enabling change tracking and audit compliance.',
    `notes` STRING COMMENT 'Additional notes or comments related to the expenditure, including explanations for variances, special circumstances, or audit trail information.',
    `posting_date` DATE COMMENT 'The date on which the expenditure transaction was posted to the general ledger in the SAP system, distinct from the expenditure date for audit and reconciliation purposes.',
    `record_type` STRING COMMENT 'Discriminator indicating whether this record represents an original budget allocation, a revised budget, or actual expenditure incurred.. Valid values are `budget_original|budget_revised|actual`',
    `sap_cost_object_reference` STRING COMMENT 'The SAP internal order, WBS element, or cost centre code used as the cost object for this expenditure in the ERP system.',
    `statutory_expenditure_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this expenditure contributes toward satisfying minimum statutory expenditure commitments required under the exploration licence conditions.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between budgeted and actual expenditure, enabling direct budget-vs-actual analysis. Positive values indicate under-spend, negative values indicate over-spend.',
    CONSTRAINT pk_expenditure PRIMARY KEY(`expenditure_id`)
) COMMENT 'Unified financial tracking for exploration programmes capturing approved budgets (original and revised versions by financial year and program) and actual expenditure incurred against exploration licences and programs. Records expenditure/budget category (drilling, geophysics, geochemistry, mapping, assaying, camp costs, studies), amount, currency, financial period, cost centre, record type (budget_original, budget_revised, actual), programme reference, prospect reference, SAP cost object reference, approval authority, budget version, variance calculation, and statutory expenditure compliance flag. Enables direct budget-vs-actual variance analysis at programme, prospect, and licence level. Satisfies minimum statutory expenditure commitment reporting under licence conditions. Distinct from the finance domain general ledger — scoped exclusively to exploration-phase programme financial management and planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`competent_person` (
    `competent_person_id` BIGINT COMMENT 'Unique identifier for the competent person record. Primary key.',
    `commodity_expertise` STRING COMMENT 'Comma-separated list of mineral commodities for which the CP/QP has demonstrated expertise and experience (e.g., iron ore, copper, gold, lithium, nickel, coal).',
    `competent_person_status` STRING COMMENT 'Current operational status of the Competent Person record in the master register. Active CPs are eligible to sign off on resource/reserve statements.. Valid values are `active|inactive|suspended|retired`',
    `consent_date` DATE COMMENT 'The date on which the Competent Person provided written consent for their name to be included in the public report and for the form and context in which their statement appears. Required under ASX Listing Rules 5.22 and NI 43-101.',
    `consent_expiry_date` DATE COMMENT 'The date on which the CP/QP consent expires and must be renewed for continued use of their statement in public disclosures.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this Competent Person record was first created in the system.',
    `current_employer` STRING COMMENT 'The name of the organization currently employing the Competent Person. Used to assess independence and potential conflicts of interest.',
    `declaration_effective_from` DATE COMMENT 'The start date from which the CP/QP declaration and sign-off is effective for resource/reserve reporting purposes.',
    `declaration_effective_to` DATE COMMENT 'The end date of the CP/QP declaration effective period. Nullable for ongoing declarations.',
    `discipline_expertise` STRING COMMENT 'The technical discipline(s) in which the CP/QP is qualified (e.g., geology, mining engineering, metallurgy, geophysics, resource estimation, mine planning).',
    `email_address` STRING COMMENT 'Primary email address for contacting the Competent Person for verification and consent purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employer_type` STRING COMMENT 'Classification of the CP/QPs employer type, used to determine independence status for regulatory reporting.. Valid values are `mining_company|consulting_firm|independent_consultant|academic_institution|government_agency|other`',
    `five_year_experience_confirmed` BOOLEAN COMMENT 'Boolean flag confirming that the CP/QP has at least five years of relevant experience in the style of mineralization and type of deposit under consideration, as required by JORC/NI 43-101/SAMREC.',
    `full_name` STRING COMMENT 'The full legal name of the Competent Person or Qualified Person as registered with their professional body.',
    `independence_status` STRING COMMENT 'Indicates whether the CP/QP is independent of the issuer/company. Independent means the person is not an employee, officer, or director of the company and does not have material financial interest. Required disclosure under ASX, TSX, and SEC rules.. Valid values are `independent|non_independent`',
    `insurance_expiry_date` DATE COMMENT 'The expiry date of the CP/QPs professional indemnity insurance policy, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this Competent Person record was last updated.',
    `last_verification_date` DATE COMMENT 'The date on which the CP/QP credentials, membership status, and experience were last verified by the companys compliance team.',
    `membership_grade` STRING COMMENT 'The grade or class of membership held (e.g., Fellow, Member, Associate) which determines eligibility to act as a Competent Person.',
    `membership_number` STRING COMMENT 'The unique membership or registration number issued by the professional body to the Competent Person.',
    `membership_status` STRING COMMENT 'Current standing of the CP/QP membership with their professional body. Must be current for the person to sign off on resource/reserve statements.. Valid values are `current|lapsed|suspended|retired`',
    `next_verification_due_date` DATE COMMENT 'The date by which the next verification of CP/QP credentials and membership status must be completed to maintain compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or qualifications related to the CP/QPs registration and authority.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the Competent Person.',
    `professional_body` STRING COMMENT 'The recognized professional organization through which the CP/QP is accredited. AusIMM (Australasian Institute of Mining and Metallurgy), AIG (Australian Institute of Geoscientists), CIM (Canadian Institute of Mining, Metallurgy and Petroleum), SACNASP (South African Council for Natural Scientific Professions), SME (Society for Mining, Metallurgy & Exploration), IMMM (Institute of Materials, Minerals and Mining).. Valid values are `AusIMM|AIG|CIM|SACNASP|SME|IMMM`',
    `professional_indemnity_insurance` BOOLEAN COMMENT 'Boolean flag indicating whether the CP/QP holds current professional indemnity insurance, which may be required by some professional bodies and reporting jurisdictions.',
    `qualification_degree` STRING COMMENT 'The highest relevant academic degree held by the CP/QP (e.g., Bachelor of Science in Geology, Master of Engineering in Mining).',
    `qualification_institution` STRING COMMENT 'The name of the educational institution that awarded the CP/QPs highest relevant degree.',
    `registration_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country in which the CP/QP is registered with their professional body. [ENUM-REF-CANDIDATE: AUS|CAN|ZAF|USA|GBR|CHL|PER|BRA — 8 candidates stripped; promote to reference product]',
    `reporting_code_authority` STRING COMMENT 'The mineral resource reporting code under which the CP/QP is authorized to sign off. JORC (Australia), NI 43-101 (Canada), SAMREC (South Africa), PERC (Europe), CRIRSCO (international umbrella).. Valid values are `JORC|NI_43_101|SAMREC|PERC|CRIRSCO`',
    `signature_authority_level` STRING COMMENT 'The level of reporting the CP/QP is authorized to sign off on: mineral resources only, ore reserves only, both, or exploration results only.. Valid values are `mineral_resource|ore_reserve|both|exploration_results`',
    `years_experience` STRING COMMENT 'Total number of years of relevant experience in the mineral industry. Must be at least 5 years to qualify as a Competent Person under JORC/NI 43-101/SAMREC.',
    CONSTRAINT pk_competent_person PRIMARY KEY(`competent_person_id`)
) COMMENT 'Master register of Competent Persons (CPs) and Qualified Persons (QPs) authorised to sign off on JORC, NI 43-101, or SAMREC mineral resource and ore reserve statements. Captures CP/QP name, professional body membership (AusIMM, AIG, CIM, SACNASP, SME), membership number, membership status (current, lapsed), relevant commodity expertise, minimum 5-year experience confirmation, current employer, independence status (independent, non-independent), consent date, and declaration effective period. Required for regulatory compliance with ASX Listing Rules Chapter 5, SEC S-K 1300, TSX NI 43-101, and JSE SAMREC disclosure obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`resource_estimation_input` (
    `resource_estimation_input_id` BIGINT COMMENT 'Primary key for the resource_estimation_input association',
    `drill_hole_id` BIGINT COMMENT 'Foreign key linking to the drill hole whose assay data is being included or excluded from the resource estimate.',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to the mineral resource estimate that this drill hole input record belongs to.',
    `composite_sample_flag` BOOLEAN COMMENT 'Indicates whether the assay samples from this drill hole were composited (e.g., regularised to 2m composites) before being used in the estimation. Compositing decisions are per-hole per-estimate and belong to this association.',
    `contribution_weight` DECIMAL(18,2) COMMENT 'The statistical weight assigned to this drill hole within the resource estimation algorithm (e.g., kriging weight, IDW distance-based weight). Belongs to the association because the same hole may carry different weights in different estimates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drill hole inclusion record was first created, supporting audit trail requirements under JORC 2012 and NI 43-101 for resource estimation dataset provenance.',
    `domain_code` STRING COMMENT 'The mineralisation domain or estimation domain within which this drill holes data was used. A single hole may intersect multiple domains; this attribute records which domain context applies for this estimate inclusion record.',
    `drill_hole_count` STRING COMMENT 'Total number of drill holes used as input data for this resource estimate. [Moved from resource_estimate: This INT aggregate on resource_estimate is derivable by COUNT(*) WHERE included_flag = TRUE on this association table. Storing it as a denormalised count on the estimate creates a maintenance burden and risks inconsistency. It should be removed from resource_estimate and computed from this association product.]',
    `exclusion_reason` STRING COMMENT 'Free-text reason why this drill hole was excluded from the resource estimate (e.g., insufficient depth, poor core recovery, outside domain boundary, superseded by closer hole). Only populated when included_flag is FALSE. Required for JORC Table 1 audit compliance.',
    `included_flag` BOOLEAN COMMENT 'Indicates whether this drill hole was included (TRUE) or explicitly excluded (FALSE) from the resource estimate. Excluded holes are still recorded to provide a complete audit trail of the estimation dataset decision.',
    `interval_count_used` BIGINT COMMENT 'The number of assay intervals (downhole sample intervals) from this drill hole that were used as input data in the resource estimate. A hole may have 200 intervals but only 150 within the mineralised domain used for estimation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this drill hole inclusion record was last modified, supporting change tracking for regulatory compliance and estimate revision history.',
    CONSTRAINT pk_resource_estimation_input PRIMARY KEY(`resource_estimation_input_id`)
) COMMENT 'This association product represents the Role relationship between resource_estimate and drill_hole. It captures the explicit inclusion of a drill hole in a specific mineral resource estimate, recording the geologists decision to include or exclude the hole, the statistical weight assigned, the number of assay intervals used, and whether samples were composited. Each record links one resource_estimate to one drill_hole with attributes that exist only in the context of this estimation relationship. This is the authoritative record for regulatory audit of resource estimation inputs under JORC 2012, NI 43-101, and SAMREC.. Existence Justification: In mining resource estimation, geologists explicitly manage which drill holes are included in each resource estimate — a drill hole can contribute data to multiple resource estimates (e.g., an initial estimate, an updated estimate, and a final JORC estimate for the same deposit), and a resource estimate draws on many drill holes. This is an actively managed operational relationship: geologists create, update, and delete inclusion records as estimates are revised, tracking which holes were used, how they were composited, and what weight they carried. The business concept is well-recognised as the drill hole database or resource estimation input set and is subject to regulatory audit under JORC/NI 43-101/SAMREC.';

CREATE OR REPLACE TABLE `mining_ecm`.`exploration`.`drill_target` (
    `drill_target_id` BIGINT COMMENT 'Primary key for the drill_target association',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking this drill target to the drill program it has been assigned to or is being considered for.',
    `survey_id` BIGINT COMMENT 'Foreign key linking this drill target to the survey whose anomaly or result generated this target.',
    `anomaly_reference` STRING COMMENT 'Identifier or label for the specific anomaly within the survey that generated this drill target (e.g., anomaly ID, grid reference, or named anomaly). Belongs to the relationship because a single survey may contain many anomalies, only some of which are linked to a given program.',
    `drill_targets_generated` STRING COMMENT 'Number of drill targets prioritized from this survey for inclusion in future drilling programs. Subset of total anomalies that pass economic and technical filters. [Moved from survey: drill_targets_generated on survey is a derived count of how many drill targets were generated from that survey. With the drill_target association table in place, this count is derivable via COUNT(drill_target_id) WHERE survey_id = X. Storing it as a denormalised integer on the survey creates a maintenance burden and risks inconsistency. It should be removed from survey and computed from the association.]',
    `follow_up_type` STRING COMMENT 'Type of drilling follow-up recommended for this target based on the survey result (e.g., scout, infill, step-out, resource_definition). Characterises the nature of the drilling response to the anomaly in the context of this program.',
    `priority` STRING COMMENT 'Ranked priority of this drill target within the drill program (e.g., 1 = highest priority). Priority is assigned in the context of a specific program and cannot reside on either the survey or the drill program alone.',
    `target_generated_date` DATE COMMENT 'Date on which this drill target was formally created from the survey interpretation and added to the targeting register. Records the point in time when the exploration team recognised the anomaly as a drill-worthy target.',
    CONSTRAINT pk_drill_target PRIMARY KEY(`drill_target_id`)
) COMMENT 'This association product represents the DrillTarget — the formal business entity in mineral exploration that links a specific survey (and its anomaly) to a drill program. It captures the targeting rationale, anomaly reference, priority ranking, and follow-up type that justify the inclusion of a survey-derived anomaly in a drill program. Each record documents one survey-to-program targeting decision, enabling traceability from survey anomaly through to drill hole execution and resource update. Supports JORC-compliant documentation of exploration targeting workflows.. Existence Justification: In mineral exploration, surveys (geophysical and geochemical) generate anomalies and drill targets that are formally documented and then grouped into drill programs. A single survey can generate targets that feed into multiple drill programs (e.g., a regional airborne magnetics survey informs both a scout program and a later resource definition program), and a single drill program is typically justified by and references multiple surveys (e.g., IP survey + soil geochemistry + rock chip program all pointing to the same target zone). Exploration geologists actively manage this linkage as a drill target — a recognised business entity that records which survey anomaly generated which drill target, its priority, and the rationale for inclusion in a program.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ADD CONSTRAINT `fk_exploration_drill_hole_survey_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ADD CONSTRAINT `fk_exploration_geological_log_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_geological_log_id` FOREIGN KEY (`geological_log_id`) REFERENCES `mining_ecm`.`exploration`.`geological_log`(`geological_log_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_parent_sample_exploration_sample_id` FOREIGN KEY (`parent_sample_exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `mining_ecm`.`exploration`.`survey`(`survey_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ADD CONSTRAINT `fk_exploration_resource_estimation_input_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ADD CONSTRAINT `fk_exploration_resource_estimation_input_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ADD CONSTRAINT `fk_exploration_drill_target_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ADD CONSTRAINT `fk_exploration_drill_target_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `mining_ecm`.`exploration`.`survey`(`survey_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`exploration` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`exploration` SET TAGS ('dbx_domain' = 'exploration');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` SET TAGS ('dbx_subdomain' = 'prospect_targeting');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `heritage_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Licence Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Prospect Area in Hectares');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `cutoff_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Percentage');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `drill_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Total Drill Hole Count');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `environmental_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Status');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `environmental_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|conditional|rejected');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `estimated_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Average Grade Percentage');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `estimated_grade_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `estimated_tonnage_mt` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tonnage in Million Tonnes');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `estimated_tonnage_mt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `exploration_stage` SET TAGS ('dbx_business_glossary_term' = 'Exploration Stage');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `exploration_stage` SET TAGS ('dbx_value_regex' = 'grassroots|reconnaissance|advanced|pre_feasibility|feasibility|development');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `geological_confidence` SET TAGS ('dbx_business_glossary_term' = 'Geological Confidence Level');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `geological_confidence` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `geological_province` SET TAGS ('dbx_business_glossary_term' = 'Geological Province');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drilling Activity Date');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `last_resource_estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Last Resource Estimate Date');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `local_grid_easting` SET TAGS ('dbx_business_glossary_term' = 'Local Grid Easting Coordinate');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `local_grid_northing` SET TAGS ('dbx_business_glossary_term' = 'Local Grid Northing Coordinate');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `mineralization_style` SET TAGS ('dbx_business_glossary_term' = 'Mineralization Style');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `next_planned_activity` SET TAGS ('dbx_business_glossary_term' = 'Next Planned Exploration Activity');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prospect Notes');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect Code');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Name');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Status');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_value_regex' = 'active|dormant|relinquished|converted_to_mining|suspended|under_review');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `reserve_classification` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Classification Category');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `reserve_classification` SET TAGS ('dbx_value_regex' = 'probable|proved|none');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification Category');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'inferred|indicated|measured|none');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `structural_domain` SET TAGS ('dbx_business_glossary_term' = 'Structural Domain');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `target_depth_max_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Target Depth in Meters');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `target_depth_min_m` SET TAGS ('dbx_business_glossary_term' = 'Minimum Target Depth in Meters');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `total_meters_drilled` SET TAGS ('dbx_business_glossary_term' = 'Total Meters Drilled');
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`licence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`licence` SET TAGS ('dbx_subdomain' = 'prospect_targeting');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Licence Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `annual_rent_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Rent Fee');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `annual_rent_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometres');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `commodity_rights` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rights');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `environmental_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Required Flag');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `expenditure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Currency Code');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `expenditure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `heritage_site_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Flag');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `holder_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Holder Registration Number');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `holder_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `joint_venture_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Flag');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `maximum_renewals_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Renewals Allowed');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_1` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment Year 1');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_2` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment Year 2');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_3` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment Year 3');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_4` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment Year 4');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_4` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_5` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment Year 5');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `minimum_expenditure_commitment_year_5` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `next_reporting_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reporting Due Date');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `regulatory_conditions` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Conditions');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `renewal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligibility Flag');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `rent_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rent Fee Currency Code');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `rent_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|as_required');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `security_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Bond Amount');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `security_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `security_bond_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Security Bond Currency Code');
ALTER TABLE `mining_ecm`.`exploration`.`licence` ALTER COLUMN `security_bond_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `abandonment_reason` SET TAGS ('dbx_business_glossary_term' = 'Hole Abandonment Reason');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `actual_azimuth` SET TAGS ('dbx_business_glossary_term' = 'Actual Azimuth');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `actual_depth` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Depth');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `actual_dip` SET TAGS ('dbx_business_glossary_term' = 'Actual Dip');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_easting` SET TAGS ('dbx_business_glossary_term' = 'Collar Easting Coordinate');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_latitude` SET TAGS ('dbx_business_glossary_term' = 'Collar Latitude (WGS84)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_longitude` SET TAGS ('dbx_business_glossary_term' = 'Collar Longitude (WGS84)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_northing` SET TAGS ('dbx_business_glossary_term' = 'Collar Northing Coordinate');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `collar_rl` SET TAGS ('dbx_business_glossary_term' = 'Collar Reduced Level (RL)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Comments');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Drilling Completion Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `core_diameter` SET TAGS ('dbx_business_glossary_term' = 'Core Diameter Size');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `drill_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Type');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hole_code` SET TAGS ('dbx_business_glossary_term' = 'Hole Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hole_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hole_purpose` SET TAGS ('dbx_business_glossary_term' = 'Hole Purpose');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hole_purpose` SET TAGS ('dbx_value_regex' = 'exploration|infill|geotechnical|sterilisation|hydrogeological|metallurgical');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hole_status` SET TAGS ('dbx_business_glossary_term' = 'Hole Status');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `hole_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|abandoned|suspended|surveyed');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `logged_date` SET TAGS ('dbx_business_glossary_term' = 'Geological Logging Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `planned_azimuth` SET TAGS ('dbx_business_glossary_term' = 'Planned Azimuth');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `planned_depth` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `planned_dip` SET TAGS ('dbx_business_glossary_term' = 'Planned Dip');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `pre_collar_depth` SET TAGS ('dbx_business_glossary_term' = 'Pre-Collar Depth');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Status');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable|under_review');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `recovery_percentage` SET TAGS ('dbx_business_glossary_term' = 'Core Recovery Percentage');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `sample_interval` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval Length');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Drilling Start Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Downhole Survey Method');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ALTER COLUMN `target_geology` SET TAGS ('dbx_business_glossary_term' = 'Target Geology Description');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Rig Asset Class Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Contractor Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `expenditure_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Licence Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `actual_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Hole Count');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `actual_metreage` SET TAGS ('dbx_business_glossary_term' = 'Actual Metreage');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `drilling_method` SET TAGS ('dbx_business_glossary_term' = 'Drilling Method');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `drilling_method` SET TAGS ('dbx_value_regex' = 'diamond_core|reverse_circulation|rotary_air_blast|percussion|sonic');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `expenditure_classification` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Classification (CAPEX/OPEX)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `expenditure_classification` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `hse_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `planned_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Hole Count');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `planned_metreage` SET TAGS ('dbx_business_glossary_term' = 'Planned Metreage');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Code');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Name');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_objective` SET TAGS ('dbx_business_glossary_term' = 'Program Objective');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Status');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'planned|approved|active|suspended|completed|cancelled');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Type');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'scout|infill|step_out|resource_definition|geotechnical|condemnation');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `qaqc_protocol_applied` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Protocol Applied');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `rehabilitation_completed` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Completed');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `rehabilitation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Completion Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `target_resource_category` SET TAGS ('dbx_business_glossary_term' = 'Target Resource Category');
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ALTER COLUMN `target_resource_category` SET TAGS ('dbx_value_regex' = 'inferred|indicated|measured');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `drill_hole_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Survey ID');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole ID');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Instrument Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `calculated_easting` SET TAGS ('dbx_business_glossary_term' = 'Calculated Easting (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `calculated_elevation` SET TAGS ('dbx_business_glossary_term' = 'Calculated Elevation (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `calculated_northing` SET TAGS ('dbx_business_glossary_term' = 'Calculated Northing (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Comments');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `deviation_from_planned` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Planned (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `magnetic_declination` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Declination (degrees)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `magnetic_field_strength` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Field Strength (nanoTesla)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `measured_azimuth` SET TAGS ('dbx_business_glossary_term' = 'Measured Azimuth (degrees)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `measured_dip` SET TAGS ('dbx_business_glossary_term' = 'Measured Dip (degrees)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_depth` SET TAGS ('dbx_business_glossary_term' = 'Survey Depth (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Instrument Type');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_instrument_type` SET TAGS ('dbx_value_regex' = 'gyroscope|magnetic|multi-shot|single-shot|electronic_multi-shot|reflex');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'end_of_hole|during_drilling|post_drilling|continuous');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Quality Code');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_quality_code` SET TAGS ('dbx_value_regex' = 'verified|unverified|suspect|rejected|recalibrated');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_run_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Run Number');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|superseded|rejected');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `temperature_at_survey` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Survey (Celsius)');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `validated_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `geological_log_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Log ID');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `alteration_intensity` SET TAGS ('dbx_business_glossary_term' = 'Alteration Intensity');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `alteration_intensity` SET TAGS ('dbx_value_regex' = 'none|weak|moderate|strong|pervasive');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `alteration_type` SET TAGS ('dbx_business_glossary_term' = 'Alteration Type');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `colour` SET TAGS ('dbx_business_glossary_term' = 'Rock Colour');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Geologist Comments');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `core_condition` SET TAGS ('dbx_business_glossary_term' = 'Core Condition');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `core_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|very_poor');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'field_logging|re_logging|historical_import');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `depth_from` SET TAGS ('dbx_business_glossary_term' = 'Depth From (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `depth_to` SET TAGS ('dbx_business_glossary_term' = 'Depth To (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `grain_size` SET TAGS ('dbx_business_glossary_term' = 'Grain Size Classification');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `grain_size` SET TAGS ('dbx_value_regex' = 'very_fine|fine|medium|coarse|very_coarse');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `hardness` SET TAGS ('dbx_business_glossary_term' = 'Rock Hardness');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `hardness` SET TAGS ('dbx_value_regex' = 'very_soft|soft|medium|hard|very_hard');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `interval_length` SET TAGS ('dbx_business_glossary_term' = 'Interval Length (meters)');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `lithology_code` SET TAGS ('dbx_business_glossary_term' = 'Lithology Code');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `lithology_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `lithology_description` SET TAGS ('dbx_business_glossary_term' = 'Lithology Description');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `logging_date` SET TAGS ('dbx_business_glossary_term' = 'Logging Date');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `logging_method` SET TAGS ('dbx_business_glossary_term' = 'Logging Method');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `logging_method` SET TAGS ('dbx_value_regex' = 'visual|digital|photographic');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `mineralisation_intensity` SET TAGS ('dbx_business_glossary_term' = 'Mineralisation Intensity');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `mineralisation_intensity` SET TAGS ('dbx_value_regex' = 'none|trace|minor|moderate|strong');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `mineralisation_style` SET TAGS ('dbx_business_glossary_term' = 'Mineralisation Style');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_business_glossary_term' = 'Oxidation State');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_value_regex' = 'oxide|transitional|fresh_sulfide');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Status');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Core Recovery Percentage');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `rock_type` SET TAGS ('dbx_business_glossary_term' = 'Rock Type Classification');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `rock_type` SET TAGS ('dbx_value_regex' = 'igneous|sedimentary|metamorphic|unconsolidated');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `rqd_percent` SET TAGS ('dbx_business_glossary_term' = 'Rock Quality Designation (RQD) Percentage');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `sample_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Collected Flag');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `structure_orientation` SET TAGS ('dbx_business_glossary_term' = 'Structural Feature Orientation');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `structure_type` SET TAGS ('dbx_business_glossary_term' = 'Structural Feature Type');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `texture` SET TAGS ('dbx_business_glossary_term' = 'Rock Texture');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `vein_type` SET TAGS ('dbx_business_glossary_term' = 'Vein Type');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `veining_percent` SET TAGS ('dbx_business_glossary_term' = 'Veining Percentage');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `weathering_degree` SET TAGS ('dbx_business_glossary_term' = 'Weathering Degree');
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ALTER COLUMN `weathering_degree` SET TAGS ('dbx_value_regex' = 'fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `exploration_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Sample ID');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Equipment Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole ID');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `geological_log_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Log Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `parent_sample_exploration_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sample ID');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `alteration_code` SET TAGS ('dbx_business_glossary_term' = 'Alteration Code');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'field|transit|laboratory|storage|disposed');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'diamond_drilling|reverse_circulation|channel_sampling|grab_sampling|auger_drilling|sonic_drilling');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `dispatch_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Batch Number');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `easting_m` SET TAGS ('dbx_business_glossary_term' = 'Easting (m)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (m)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `from_depth_m` SET TAGS ('dbx_business_glossary_term' = 'From Depth (m)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `geologist_comments` SET TAGS ('dbx_business_glossary_term' = 'Geologist Comments');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `is_composite` SET TAGS ('dbx_business_glossary_term' = 'Is Composite');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `length_m` SET TAGS ('dbx_business_glossary_term' = 'Sample Length (m)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `lithology_code` SET TAGS ('dbx_business_glossary_term' = 'Lithology Code');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `mineralization_code` SET TAGS ('dbx_business_glossary_term' = 'Mineralization Code');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `northing_m` SET TAGS ('dbx_business_glossary_term' = 'Northing (m)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `qaqc_reference_material` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Reference Material');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `qaqc_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Type');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `qaqc_type` SET TAGS ('dbx_value_regex' = 'routine|duplicate|blank|standard|replicate');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Percent');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `to_depth_m` SET TAGS ('dbx_business_glossary_term' = 'To Depth (m)');
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight (kg)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`survey` SET TAGS ('dbx_subdomain' = 'prospect_targeting');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Licence Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `acquisition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition End Date');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `acquisition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Start Date');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `anomaly_count` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Count');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `anomaly_threshold` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Threshold Criteria');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `area_km2` SET TAGS ('dbx_business_glossary_term' = 'Survey Area (Square Kilometers)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `data_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Data Storage Location');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `data_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `grid_spacing_m` SET TAGS ('dbx_business_glossary_term' = 'Grid Spacing (Meters)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|peer_reviewed|approved');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `line_spacing_m` SET TAGS ('dbx_business_glossary_term' = 'Line Spacing (Meters)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'raw|in_progress|completed|validated|archived');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Reference');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `sample_interval_m` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval (Meters)');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Program Name');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'geophysical|geochemical');
ALTER TABLE `mining_ecm`.`exploration`.`survey` ALTER COLUMN `total_line_km` SET TAGS ('dbx_business_glossary_term' = 'Total Line Kilometers');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` SET TAGS ('dbx_subdomain' = 'resource_reporting');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Identifier (ID)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `average_grade` SET TAGS ('dbx_business_glossary_term' = 'Average Grade');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `average_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Estimate Comments');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `contained_metal` SET TAGS ('dbx_business_glossary_term' = 'Contained Metal Quantity');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `contained_metal_unit` SET TAGS ('dbx_business_glossary_term' = 'Contained Metal Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `cut_off_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `cut_off_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `density_assumption` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density Assumption (t/m³)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Effective Date');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Estimate Confidence Level');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_confidence_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Name');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Estimate Status');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Superseded|Archived');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_business_glossary_term' = 'Estimate Type');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_value_regex' = 'Initial|Updated|Revised|Final');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `metallurgical_recovery_assumption` SET TAGS ('dbx_business_glossary_term' = 'Metallurgical Recovery Rate Assumption (%)');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `mining_method_assumption` SET TAGS ('dbx_business_glossary_term' = 'Mining Method Assumption');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Report Reference');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard Code');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC 2012|JORC 2004|NI 43-101|SAMREC|SEC S-K 1300|CIM');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification Category');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'Measured|Indicated|Inferred');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Sign-off Date');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `tonnage` SET TAGS ('dbx_business_glossary_term' = 'Resource Tonnage');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `tonnage_unit` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `tonnage_unit` SET TAGS ('dbx_value_regex' = 't|kt|Mt|Gt');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `total_metres_drilled` SET TAGS ('dbx_business_glossary_term' = 'Total Metres Drilled');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` SET TAGS ('dbx_subdomain' = 'resource_reporting');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `average_grade` SET TAGS ('dbx_business_glossary_term' = 'Average Grade');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `average_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `board_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Board Sign-off Date');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `contained_metal` SET TAGS ('dbx_business_glossary_term' = 'Contained Metal');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `contained_metal_unit` SET TAGS ('dbx_business_glossary_term' = 'Contained Metal Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `cut_off_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `cut_off_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `economic_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Economic Assumptions');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `lom_years` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Years');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `metallurgical_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Metallurgical Recovery Factor');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `mining_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Mining Recovery Factor');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `modifying_factors_applied` SET TAGS ('dbx_business_glossary_term' = 'Modifying Factors Applied');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC|NI 43-101|SAMREC|SEC S-K 1300|CIM|PERC');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_classification` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Classification');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_classification` SET TAGS ('dbx_value_regex' = 'Proved|Probable');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_code` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Code');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_name` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Name');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Status');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'Draft|Approved|Disclosed|Superseded|Archived');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Tonnage');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_tonnage_unit` SET TAGS ('dbx_business_glossary_term' = 'Reserve Tonnage Unit of Measure');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `reserve_tonnage_unit` SET TAGS ('dbx_value_regex' = 'tonnes|kilotonnes|megatonnes|short tons|long tons');
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` SET TAGS ('dbx_subdomain' = 'resource_reporting');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Programme ID');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `expenditure_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Licence ID');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Amount');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Statutory Commitment Amount');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Category');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `expenditure_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Date');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `financial_period` SET TAGS ('dbx_business_glossary_term' = 'Financial Period');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `financial_period` SET TAGS ('dbx_value_regex' = '^P(0[1-9]|1[0-2])$');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `financial_year` SET TAGS ('dbx_business_glossary_term' = 'Financial Year');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `financial_year` SET TAGS ('dbx_value_regex' = '^FYd{4}$');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Record Type');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'budget_original|budget_revised|actual');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `sap_cost_object_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Object Reference');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `statutory_expenditure_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Expenditure Compliance Flag');
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` SET TAGS ('dbx_subdomain' = 'resource_reporting');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person (CP) Identifier');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `commodity_expertise` SET TAGS ('dbx_business_glossary_term' = 'Commodity Expertise');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `competent_person_status` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Status');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `competent_person_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Organization');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `declaration_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Declaration Effective From Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `declaration_effective_to` SET TAGS ('dbx_business_glossary_term' = 'Declaration Effective To Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `discipline_expertise` SET TAGS ('dbx_business_glossary_term' = 'Technical Discipline Expertise');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `employer_type` SET TAGS ('dbx_business_glossary_term' = 'Employer Type');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `employer_type` SET TAGS ('dbx_value_regex' = 'mining_company|consulting_firm|independent_consultant|academic_institution|government_agency|other');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `five_year_experience_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Five Year Experience Confirmation');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Full Legal Name');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `independence_status` SET TAGS ('dbx_business_glossary_term' = 'Independence Status');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `independence_status` SET TAGS ('dbx_value_regex' = 'independent|non_independent');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `membership_grade` SET TAGS ('dbx_business_glossary_term' = 'Professional Membership Grade');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Professional Membership Number');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `membership_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'current|lapsed|suspended|retired');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `professional_body` SET TAGS ('dbx_business_glossary_term' = 'Professional Body Membership');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `professional_body` SET TAGS ('dbx_value_regex' = 'AusIMM|AIG|CIM|SACNASP|SME|IMMM');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `professional_indemnity_insurance` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Insurance Confirmation');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `qualification_degree` SET TAGS ('dbx_business_glossary_term' = 'Academic Qualification Degree');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `qualification_institution` SET TAGS ('dbx_business_glossary_term' = 'Academic Qualification Institution');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `registration_country` SET TAGS ('dbx_business_glossary_term' = 'Registration Country Code');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `reporting_code_authority` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code Authority');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `reporting_code_authority` SET TAGS ('dbx_value_regex' = 'JORC|NI_43_101|SAMREC|PERC|CRIRSCO');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `signature_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Signature Authority Level');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `signature_authority_level` SET TAGS ('dbx_value_regex' = 'mineral_resource|ore_reserve|both|exploration_results');
ALTER TABLE `mining_ecm`.`exploration`.`competent_person` ALTER COLUMN `years_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Relevant Experience');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` SET TAGS ('dbx_subdomain' = 'resource_reporting');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` SET TAGS ('dbx_association_edges' = 'exploration.resource_estimate,exploration.drill_hole');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `resource_estimation_input_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimation Input - Resource Estimation Input Id');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimation Input - Drill Hole Id');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimation Input - Resource Estimate Id');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `composite_sample_flag` SET TAGS ('dbx_business_glossary_term' = 'Composite Sample Flag');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `contribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Contribution Weight');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `domain_code` SET TAGS ('dbx_business_glossary_term' = 'Estimation Domain Code');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `drill_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Count');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `included_flag` SET TAGS ('dbx_business_glossary_term' = 'Hole Included Flag');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `interval_count_used` SET TAGS ('dbx_business_glossary_term' = 'Interval Count Used');
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimation_input` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` SET TAGS ('dbx_subdomain' = 'prospect_targeting');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` SET TAGS ('dbx_association_edges' = 'exploration.drill_program,exploration.survey');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `drill_target_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Target - Drill Target Id');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Target - Drill Program Id');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Target - Survey Id');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `anomaly_reference` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Reference');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `drill_targets_generated` SET TAGS ('dbx_business_glossary_term' = 'Drill Targets Generated');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `follow_up_type` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Type');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Drill Target Priority');
ALTER TABLE `mining_ecm`.`exploration`.`drill_target` ALTER COLUMN `target_generated_date` SET TAGS ('dbx_business_glossary_term' = 'Target Generated Date');
