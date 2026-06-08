-- Schema for Domain: tenement | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`tenement` COMMENT 'Manages the land access and mineral rights portfolio including exploration licences, mining leases, native title agreements, heritage clearances, surface rights, and royalty agreements. Tracks tenement boundaries via GIS, renewal obligations, expenditure commitments, and regulatory conditions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`tenement` (
    `tenement_id` BIGINT COMMENT 'Unique system identifier for the tenement record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Tenements are primary cost objects in mining operations. Each tenement is assigned to a cost centre for operational cost tracking, AISC calculation, and unit cost reporting. Essential for monthly mana',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Tenements are evaluated as profit-generating assets. Assignment to profit centres enables segment P&L reporting, asset-level profitability analysis, and investment decision support. Required for IFRS ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each tenement requires an accountable manager for operational oversight, expenditure approval, regulatory correspondence, and delegation of authority. Real business process: tenement management accoun',
    `annual_expenditure_commitment` DECIMAL(18,2) COMMENT 'The minimum annual expenditure amount (in local currency) that must be spent on exploration or development activities to maintain the tenement in good standing. Failure to meet this commitment may result in forfeiture.',
    `application_date` DATE COMMENT 'The date on which the tenement application was submitted to the regulatory authority. Establishes priority in jurisdictions with first-in-time rules.',
    `area_hectares` DECIMAL(18,2) COMMENT 'The total surface area of the tenement measured in hectares. Defines the spatial extent of the mineral rights.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the tenement centroid in decimal degrees. Used for approximate location reference and spatial queries.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the tenement centroid in decimal degrees. Used for approximate location reference and spatial queries.',
    `coordinate_system` STRING COMMENT 'The coordinate reference system (CRS) or projection used for the tenement boundary (e.g., GDA2020 MGA Zone 50, NAD83 UTM Zone 11N). Critical for accurate spatial representation.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the tenement is located (e.g., AUS, CAN, USA, ZAF).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tenement record was first created in the system. Audit trail for data lineage.',
    `environmental_conditions` STRING COMMENT 'Summary of key environmental conditions or restrictions imposed on the tenement by the regulatory authority (e.g., No clearing within 100m of watercourses, Seasonal access restrictions during breeding season). Free-text field for recording compliance obligations.',
    `expenditure_currency` STRING COMMENT 'Three-letter ISO currency code for the annual expenditure commitment (e.g., AUD, CAD, USD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The date on which the tenement licence term ends unless renewed. Critical for tracking renewal obligations and avoiding forfeiture.',
    `gis_boundary_reference` STRING COMMENT 'Reference identifier or file path to the GIS spatial dataset defining the tenement boundary coordinates. Enables integration with GIS systems for spatial analysis and mapping.',
    `grant_date` DATE COMMENT 'The date on which the tenement was officially granted by the regulatory authority, marking the commencement of the licence term.',
    `granted_commodities` STRING COMMENT 'Comma-separated list of minerals or commodities for which the tenement grants exploration or extraction rights (e.g., Iron Ore, Gold, Copper, Lithium, Nickel). Defines the scope of permitted mineral activities.',
    `heritage_clearance_status` STRING COMMENT 'The status of cultural heritage clearance for the tenement. Not Required: no heritage survey needed; Cleared: heritage survey completed with no restrictions; Survey Required: heritage assessment not yet conducted; Restricted Areas Identified: heritage sites present requiring protection; Pending: clearance process underway.. Valid values are `not_required|cleared|survey_required|restricted_areas_identified|pending`',
    `holder_name` STRING COMMENT 'The legal name of the entity or individual registered as the holder of the tenement. May be the company itself or a subsidiary.',
    `holder_percentage` DECIMAL(18,2) COMMENT 'The percentage ownership interest held by the registered holder in this tenement. Relevant for joint ventures or partial interests. Value between 0.00 and 100.00.',
    `joint_venture_flag` BOOLEAN COMMENT 'Indicates whether the tenement is held under a joint venture arrangement with one or more partners. True if joint venture; False if sole ownership.',
    `jurisdiction` STRING COMMENT 'The state, province, or territory in which the tenement is registered and governed (e.g., Western Australia, Queensland, British Columbia). Determines the applicable mining legislation and regulatory authority.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent physical or regulatory inspection of the tenement. Used to track compliance monitoring and site visit schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tenement record was last updated in the system. Audit trail for change tracking.',
    `licence_type` STRING COMMENT 'The category of mineral tenement defining the permitted activities and rights. Exploration Licence (EL) allows exploration activities; Mining Lease (ML) permits extraction; Prospecting Licence (PL) for small-scale exploration; Retention Licence (RL) to retain discovered resources not yet economically viable; Miscellaneous Licence for ancillary purposes.. Valid values are `exploration_licence|mining_lease|prospecting_licence|retention_licence|miscellaneous_licence`',
    `lifecycle_status` STRING COMMENT 'Current state of the tenement in its regulatory lifecycle. Application: submitted but not yet granted; Granted: approved and active; Active: in good standing with all obligations met; Suspended: temporarily inactive due to regulatory or operational reasons; Surrendered: voluntarily relinquished by holder; Expired: lapsed due to term completion; Forfeited: revoked by authority for non-compliance; Renewal Pending: application for extension submitted. [ENUM-REF-CANDIDATE: application|granted|active|suspended|surrendered|expired|forfeited|renewal_pending — 8 candidates stripped; promote to reference product]',
    `native_title_status` STRING COMMENT 'The status of native title considerations for the tenement. Not Applicable: jurisdiction does not recognize native title; Determined: native title has been legally determined; Registered Claim: a native title claim is registered over the area; Agreement in Place: native title agreement (e.g., ILUA) executed; Negotiation Required: consultation or agreement process underway.. Valid values are `not_applicable|determined|registered_claim|agreement_in_place|negotiation_required`',
    `next_reporting_date` DATE COMMENT 'The date by which the next statutory report (e.g., annual expenditure report, exploration report) must be submitted to the regulatory authority. Critical for compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for recording additional information, special conditions, historical context, or operational notes relevant to the tenement management.',
    `regulatory_authority` STRING COMMENT 'The name of the government department or agency responsible for administering the tenement (e.g., Department of Mines, Industry Regulation and Safety, Ministry of Energy and Mines).',
    `renewal_date` DATE COMMENT 'The date by which a renewal application must be submitted to extend the tenement term. Nullable for tenements not yet requiring renewal.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage royalty rate payable on production from the tenement, either to the government or to a third-party royalty holder. Nullable if no royalty applies.',
    `royalty_type` STRING COMMENT 'The type of royalty obligation applicable to the tenement. Government: statutory royalty to state; Private: royalty to third party; Net Smelter Return (NSR): based on net proceeds after smelting; Gross Revenue: based on gross sales; Profit Based: based on net profit.. Valid values are `government|private|net_smelter_return|gross_revenue|profit_based`',
    `statutory_identifier` STRING COMMENT 'The official government-issued unique identifier for the tenement as registered with the mining authority (e.g., EL12345, ML67890, PL54321). This is the externally-known business identifier used in all regulatory correspondence and public registers.',
    `strategic_priority` STRING COMMENT 'Internal classification of the tenements strategic importance to the companys portfolio. Tier 1: highest priority, active development or production; Tier 2: medium priority, advanced exploration; Tier 3: early-stage or prospective; Non-Core: retained but not strategic; Divestment Candidate: targeted for sale or surrender.. Valid values are `tier_1|tier_2|tier_3|non_core|divestment_candidate`',
    `surface_rights_status` STRING COMMENT 'The status of surface land access rights for the tenement. Owned: company owns the surface land; Leased: surface land leased from owner; Access Agreement: formal access agreement in place; Negotiation Required: access rights being negotiated; Restricted: surface access limited or denied.. Valid values are `owned|leased|access_agreement|negotiation_required|restricted`',
    `tenement_name` STRING COMMENT 'The common or project name assigned to the tenement for internal reference and communication (e.g., Iron Ridge North, Copper Creek Prospect).',
    CONSTRAINT pk_tenement PRIMARY KEY(`tenement_id`)
) COMMENT 'Master register of all mineral tenements held or applied for by the company, including exploration licences, mining leases, prospecting licences, and retention licences. SSOT for tenement identity, licence type, status, jurisdiction, granted commodities, area (hectares), grant/expiry dates, and lifecycle status (application, granted, suspended, surrendered, expired, forfeited). Each record represents one tenement with its unique statutory identifier.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`boundary` (
    `boundary_id` BIGINT COMMENT 'Unique identifier for the tenement boundary record. Primary key for the tenement boundary data product.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Boundary surveys are professional services contracted to licensed surveyors. Mining operations link boundary records to survey service contracts for survey cost allocation, surveyor performance tracki',
    `tenement_id` BIGINT COMMENT 'Reference to the parent tenement for which this boundary is defined. Links to the tenement master record.',
    `accuracy_class` STRING COMMENT 'Classification of the boundary accuracy. Survey accurate for professionally surveyed boundaries, cadastral for official land registry boundaries, digitized for boundaries traced from maps, approximate for estimated boundaries.. Valid values are `survey_accurate|cadastral|digitized|approximate`',
    `amendment_reason` STRING COMMENT 'Business or regulatory reason for the boundary change. Examples include partial relinquishment, area reduction, survey correction, native title agreement, or regulatory directive.',
    `area_calculation_method` STRING COMMENT 'Method used to calculate the tenement area. Planar for flat-earth approximation, geodesic for spherical earth, ellipsoidal for precise WGS84 calculations, or surveyed for official cadastral measurements.. Valid values are `planar|geodesic|ellipsoidal|surveyed`',
    `area_hectares` DECIMAL(18,2) COMMENT 'Total area of the tenement boundary in hectares. Calculated from the polygon geometry. Used for expenditure commitment calculations and regulatory reporting.',
    `area_square_kilometers` DECIMAL(18,2) COMMENT 'Total area of the tenement boundary in square kilometers. Alternative area measurement for reporting and analysis.',
    `boundary_status` STRING COMMENT 'Current lifecycle status of the boundary definition. Indicates whether the boundary is in draft, under regulatory review, officially approved, or has been superseded by a newer version.. Valid values are `draft|submitted|approved|superseded|withdrawn|current`',
    `comments` STRING COMMENT 'Free-text field for additional notes, clarifications, or context about the boundary definition. May include survey notes, regulatory correspondence references, or operational considerations.',
    `coordinate_reference_system` STRING COMMENT 'The spatial reference system used for the boundary coordinates. Typically an EPSG code (e.g., EPSG:4326 for WGS84, EPSG:28350 for GDA94 MGA Zone 50). Critical for accurate spatial alignment and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this boundary record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `data_source` STRING COMMENT 'Source system or document from which the boundary geometry was obtained. Examples include regulatory portal, survey plan, GPS field capture, or digitized from historical maps.',
    `effective_from_date` DATE COMMENT 'Date from which this boundary definition becomes legally effective. Marks the start of the boundary version validity period.',
    `effective_to_date` DATE COMMENT 'Date until which this boundary definition remains valid. Null for the current active boundary. Populated when a new boundary version supersedes this one.',
    `environmental_overlay_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the tenement boundary intersects with environmental protection zones, national parks, or conservation areas. Impacts permitting and operational constraints.',
    `geometry_wkb` STRING COMMENT 'Spatial polygon geometry of the tenement boundary in Well-Known Binary format. Binary representation for efficient storage and processing in GIS systems.',
    `geometry_wkt` STRING COMMENT 'Spatial polygon geometry of the tenement boundary in Well-Known Text format. Represents the precise geographic coordinates defining the tenement perimeter. Used for GIS integration and spatial analysis.',
    `gis_layer_name` STRING COMMENT 'Name of the GIS layer or feature class where this boundary is stored in the corporate GIS system. Supports integration with spatial data platforms.',
    `heritage_area_overlap_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the tenement boundary intersects with registered heritage sites or protected cultural areas. Triggers heritage clearance requirements.',
    `is_current_boundary` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active boundary for the tenement. True for the latest approved version, false for historical versions.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last modified this boundary record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this boundary record was last updated in the system. Tracks the most recent change for audit and synchronization purposes.',
    `map_sheet_reference` STRING COMMENT 'Reference to the topographic map sheet or cadastral map on which the tenement boundary is depicted. Used for regulatory submissions and field operations.',
    `native_title_overlap_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the tenement boundary intersects with registered native title claims or determinations. Used for heritage and consultation planning.',
    `perimeter_meters` DECIMAL(18,2) COMMENT 'Total perimeter length of the tenement boundary in meters. Calculated from the polygon geometry. Used for boundary management and overlap analysis.',
    `positional_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated positional accuracy of the boundary coordinates in meters. Represents the maximum expected deviation from true ground position. Critical for spatial analysis and overlap detection.',
    `regulatory_approval_date` DATE COMMENT 'Date when the boundary definition was officially approved by the mining regulator or land authority. Establishes the legal effective date of the boundary.',
    `regulatory_approval_reference` STRING COMMENT 'Official reference number or document identifier for the regulatory approval of this boundary. Used for compliance tracking and audit purposes.',
    `submission_date` DATE COMMENT 'Date when the boundary definition was submitted to the regulatory authority for approval. Used for tracking regulatory processing timelines.',
    `survey_date` DATE COMMENT 'Date when the boundary survey was conducted. Critical for establishing the official boundary definition and regulatory compliance.',
    `survey_datum` STRING COMMENT 'The geodetic datum used for the boundary survey. Common values include GDA94 (Geocentric Datum of Australia 1994), GDA2020, WGS84. Ensures consistency with regulatory mapping standards.',
    `survey_plan_reference` STRING COMMENT 'Official reference number or identifier for the survey plan document lodged with the regulatory authority. Links to the formal cadastral record.',
    `surveyor_licence_number` STRING COMMENT 'Professional licence number of the surveyor who certified the boundary. Required for regulatory compliance and validation of survey accuracy.',
    `surveyor_name` STRING COMMENT 'Name of the licensed surveyor or surveying firm that conducted the boundary survey. Required for regulatory submissions and audit trail.',
    `version_number` STRING COMMENT 'Sequential version number for this boundary definition. Increments with each boundary amendment or survey update. Supports tracking of boundary changes over the tenement lifecycle.',
    `vertex_count` STRING COMMENT 'Number of vertices (corner points) defining the boundary polygon. Indicates the complexity of the boundary shape.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this boundary record in the system. Supports audit trail and data governance.',
    CONSTRAINT pk_boundary PRIMARY KEY(`boundary_id`)
) COMMENT 'GIS spatial boundary definition for each tenement, storing polygon geometry (WKT/WKB), coordinate reference system (CRS), survey datum, area calculation method, and version history of boundary amendments. Supports GIS integration for overlap analysis, native title intersection, and regulatory mapping submissions. One tenement may have multiple boundary versions over its lifecycle.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`expenditure_commitment` (
    `expenditure_commitment_id` BIGINT COMMENT 'Unique identifier for the expenditure commitment record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Expenditure commitments require formal approval by authorized personnel for financial controls, audit trails, and delegation of authority verification. Real business process: expenditure commitment ap',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Statutory expenditure commitments must be budgeted and tracked against cost centres for budget vs actual variance reporting. Essential for regulatory compliance reporting and ensuring commitments are ',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Statutory expenditure commitments on mining tenements are fulfilled through actual procurement spend. Mining companies must demonstrate regulatory compliance by linking committed amounts to actual POs',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement (exploration licence or mining lease) to which this expenditure commitment applies.',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'The actual expenditure incurred to date against this commitment during the reporting period. Updated as expenditure is recorded and approved.',
    `approval_date` DATE COMMENT 'The date on which the mining authority approved or accepted the expenditure report and confirmed compliance. Null if not yet approved or if under review.',
    `carry_forward_amount` DECIMAL(18,2) COMMENT 'The amount of surplus expenditure from this reporting period that is eligible to be carried forward to offset future period commitments, where permitted by regulation.',
    `carry_forward_expiry_date` DATE COMMENT 'The date by which any carry-forward expenditure credit must be utilized, after which it expires and can no longer be applied to future commitments.',
    `commitment_reference_number` STRING COMMENT 'External reference number or code assigned by the mining authority or internal system to uniquely identify this expenditure commitment obligation.',
    `commitment_type` STRING COMMENT 'Classification of the expenditure commitment based on its origin and nature. Statutory commitments are mandated by regulation, voluntary commitments are self-imposed, negotiated commitments result from agreements with authorities.. Valid values are `statutory|voluntary|negotiated|reduced|suspended`',
    `committed_amount` DECIMAL(18,2) COMMENT 'The statutory minimum expenditure amount that must be spent on exploration or mining activities within the reporting period to maintain the tenement in good standing. Expressed in the currency of the jurisdiction.',
    `compliance_status` STRING COMMENT 'Current compliance status of the expenditure commitment. Indicates whether the commitment has been met, is at risk of non-compliance, or has been granted an exemption or carry-forward arrangement.. Valid values are `compliant|non_compliant|at_risk|pending_review|exempted|carried_forward`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this expenditure commitment record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the commitment and expenditure amounts are denominated (e.g., AUD, USD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `exemption_granted_flag` BOOLEAN COMMENT 'Indicates whether an exemption from the expenditure commitment has been granted by the mining authority for this reporting period. True if exemption granted, False otherwise.',
    `exemption_reason` STRING COMMENT 'The reason or justification provided for the exemption from the expenditure commitment, if an exemption was granted. May reference force majeure, regulatory delays, or other circumstances.',
    `expenditure_category` STRING COMMENT 'The category of expenditure that qualifies toward meeting the commitment. Different tenement types and jurisdictions may have specific rules about what expenditure categories are eligible.. Valid values are `exploration|development|mining|rehabilitation|administration|community`',
    `forfeiture_risk_flag` BOOLEAN COMMENT 'Indicates whether the tenement is at risk of forfeiture due to non-compliance with this expenditure commitment. True if forfeiture risk exists, False otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this expenditure commitment record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this expenditure commitment, including explanations of variances, special circumstances, or correspondence with authorities.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty imposed by the mining authority for non-compliance with the expenditure commitment, if applicable. Null if no penalty assessed.',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period for which this expenditure commitment applies. Defines the deadline by which committed expenditure must be incurred and reported.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period for which this expenditure commitment applies. Typically aligned with the tenement grant anniversary or regulatory year.',
    `responsible_party` STRING COMMENT 'The name or identifier of the internal business unit, cost centre, or individual responsible for ensuring this expenditure commitment is met and reported.',
    `submission_date` DATE COMMENT 'The actual date on which the expenditure report was submitted to the mining authority. Null if not yet submitted.',
    `submission_due_date` DATE COMMENT 'The date by which the expenditure report must be submitted to the mining authority to demonstrate compliance with the commitment. Typically falls after the reporting period end date.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between committed amount and actual expenditure amount. Positive values indicate surplus (over-expenditure), negative values indicate shortfall (under-expenditure).',
    CONSTRAINT pk_expenditure_commitment PRIMARY KEY(`expenditure_commitment_id`)
) COMMENT 'Tracks the statutory minimum expenditure obligations attached to each tenement for each reporting period. Records the committed amount, actual expenditure to date, shortfall or surplus, reporting period start/end dates, and compliance status. Supports regulatory reporting to mining authorities and internal CAPEX/OPEX planning. Failure to meet commitments can result in tenement forfeiture.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`renewal_obligation` (
    `renewal_obligation_id` BIGINT COMMENT 'Unique identifier for the tenement renewal obligation record. Primary key for the renewal obligation entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Renewal obligations require task assignment to specific employees for reminder workflows, accountability tracking, and performance management. Real business process: renewal deadline management and lo',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement (exploration licence or mining lease) for which this renewal obligation applies.',
    `alert_notification_date` DATE COMMENT 'The date on which the system or responsible person should be alerted about the upcoming renewal deadline, typically set several months before the lodgement deadline.',
    `area_relinquishment_required_flag` BOOLEAN COMMENT 'Indicates whether the renewal requires the tenement holder to relinquish a portion of the tenement area as a condition of renewal (True if relinquishment is required, False otherwise).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this renewal obligation record was first created in the system.',
    `decision_date` DATE COMMENT 'The date on which the regulatory authority made a formal decision on the renewal application (granted, refused, or other outcome).',
    `environmental_compliance_status` STRING COMMENT 'The environmental compliance status of the tenement at the time of renewal application: compliant (meets all requirements), non_compliant (violations identified), under_review (being assessed), or remediation_required (corrective action needed before renewal).. Valid values are `compliant|non_compliant|under_review|remediation_required`',
    `expenditure_commitment_amount` DECIMAL(18,2) COMMENT 'The minimum exploration or mining expenditure amount that the tenement holder commits to spend during the renewed term as a condition of renewal.',
    `expenditure_commitment_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the expenditure commitment amount.. Valid values are `^[A-Z]{3}$`',
    `heritage_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether cultural heritage clearance or survey is required as a condition of this renewal (True if required, False otherwise).',
    `heritage_clearance_status` STRING COMMENT 'The current status of heritage clearance for this renewal: not_required (no clearance needed), pending (clearance process not started), in_progress (survey underway), obtained (clearance granted), or refused (clearance denied).. Valid values are `not_required|pending|in_progress|obtained|refused`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this renewal obligation record was last updated or modified.',
    `lodgement_deadline_date` DATE COMMENT 'The final date by which the renewal application must be lodged with the regulatory authority, typically occurring before the renewal due date to allow processing time.',
    `lodgement_submitted_date` DATE COMMENT 'The actual date on which the renewal application was submitted to the regulatory authority.',
    `native_title_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether native title consultation or clearance is required as a condition of this renewal (True if required, False otherwise).',
    `native_title_clearance_status` STRING COMMENT 'The current status of native title clearance for this renewal: not_required (no clearance needed), pending (clearance process not started), in_progress (consultation underway), obtained (clearance granted), or refused (clearance denied).. Valid values are `not_required|pending|in_progress|obtained|refused`',
    `new_expiry_date` DATE COMMENT 'The new expiry date of the tenement following successful renewal, marking the end of the renewed term.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information, special circumstances, or internal comments related to this renewal obligation.',
    `regulatory_authority_name` STRING COMMENT 'The name of the government department or regulatory body responsible for processing and deciding on this renewal application (e.g., Department of Mines, Ministry of Natural Resources).',
    `regulatory_jurisdiction` STRING COMMENT 'The state, province, or national jurisdiction under whose mining legislation this renewal is governed (e.g., Western Australia, Queensland, British Columbia).',
    `relinquishment_area_hectares` DECIMAL(18,2) COMMENT 'The area in hectares that must be relinquished from the tenement as a condition of renewal, if area relinquishment is required.',
    `relinquishment_percentage` DECIMAL(18,2) COMMENT 'The percentage of the original tenement area that must be relinquished as a condition of renewal, expressed as a decimal (e.g., 25.00 for 25%).',
    `renewal_conditions` STRING COMMENT 'Detailed description of any conditions, restrictions, or obligations attached to the renewal by the regulatory authority (e.g., environmental monitoring requirements, heritage clearance obligations, reporting requirements).',
    `renewal_due_date` DATE COMMENT 'The date by which the tenement renewal must be completed to maintain continuous tenure. This is the expiry date of the current tenement term.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'The total fee amount payable to the regulatory authority for processing and granting the tenement renewal, expressed in the operating currency.',
    `renewal_fee_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the renewal fee amount (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `renewal_fee_paid_date` DATE COMMENT 'The date on which the renewal fee was paid to the regulatory authority.',
    `renewal_outcome` STRING COMMENT 'The final outcome of the renewal application: granted (renewal approved), refused (renewal denied by authority), lapsed (tenement expired without renewal), withdrawn (application withdrawn by holder), or pending (decision not yet made).. Valid values are `granted|refused|lapsed|withdrawn|pending`',
    `renewal_priority` STRING COMMENT 'The business priority assigned to this renewal obligation based on strategic importance, production impact, and resource value: critical (active mining operations), high (near-term development), medium (exploration with potential), or low (non-core assets).. Valid values are `critical|high|medium|low`',
    `renewal_reference_number` STRING COMMENT 'The official reference number or application identifier assigned by the regulatory authority for this renewal submission.',
    `renewal_status` STRING COMMENT 'Current lifecycle status of the renewal obligation: pending (not yet lodged), lodged (submitted to authority), under_review (being assessed), approved (renewal granted), refused (renewal denied), lapsed (expired without renewal), or withdrawn (application withdrawn by holder). [ENUM-REF-CANDIDATE: pending|lodged|under_review|approved|refused|lapsed|withdrawn — 7 candidates stripped; promote to reference product]',
    `renewal_term_years` STRING COMMENT 'The duration in years for which the tenement is renewed upon approval of this renewal application.',
    `renewal_type` STRING COMMENT 'The category of renewal being processed: standard (routine renewal), expedited (fast-track), conditional (subject to additional requirements), extension (temporary extension pending decision), or variation (renewal with modified terms).. Valid values are `standard|expedited|conditional|extension|variation`',
    CONSTRAINT pk_renewal_obligation PRIMARY KEY(`renewal_obligation_id`)
) COMMENT 'Manages the renewal lifecycle for each tenement, capturing renewal due date, lodgement deadline, renewal fee amount, renewal application reference number, submitted date, decision date, outcome (granted, refused, lapsed), and conditions attached to renewal. Enables proactive management of the tenement portfolio to prevent unintended expiry.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`regulatory_condition` (
    `regulatory_condition_id` BIGINT COMMENT 'Unique identifier for the regulatory condition record. Primary key for the regulatory condition entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each regulatory condition requires an accountable employee (environmental manager, mine manager, compliance officer) for compliance tracking, audit trails, performance management, and regulatory corre',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement (exploration licence or mining lease) to which this regulatory condition applies.',
    `breach_date` DATE COMMENT 'Date on which the breach or non-compliance with this condition was identified or formally notified by the granting authority.',
    `breach_description` STRING COMMENT 'Detailed description of the nature and circumstances of the breach or non-compliance event, including any formal notices or directions issued by the granting authority.',
    `breach_flag` BOOLEAN COMMENT 'Indicator of whether this regulatory condition has been breached or is currently subject to a non-compliance notice, show-cause notice, or enforcement action.',
    `compliance_due_date` DATE COMMENT 'Deadline by which the condition must be satisfied or the required action/deliverable must be completed. Used for tracking compliance milestones and reporting obligations.',
    `condition_description` STRING COMMENT 'Full text description of the regulatory condition, including detailed requirements, restrictions, obligations, and any specific actions or deliverables mandated by the granting authority.',
    `condition_reference_number` STRING COMMENT 'The official reference number or code assigned by the granting authority (e.g., DMIRS, DPE) to uniquely identify this condition within the tenement approval documentation.',
    `condition_status` STRING COMMENT 'Current compliance status of the regulatory condition. Tracks whether the condition is being met, breached, or is under regulatory review or enforcement action. [ENUM-REF-CANDIDATE: active|compliant|non_compliant|under_review|suspended|revoked|superseded — 7 candidates stripped; promote to reference product]',
    `condition_title` STRING COMMENT 'Short descriptive title or summary of the regulatory condition as stated in the approval documentation.',
    `condition_type` STRING COMMENT 'Classification of the regulatory condition based on its nature and purpose. Defines the category of obligation or restriction imposed by the granting authority. [ENUM-REF-CANDIDATE: environmental_management_plan|operational_restriction|annual_reporting_obligation|access_limitation|heritage_protection|rehabilitation_requirement|water_management|noise_emission_limit|dust_control|blasting_restriction|operating_hours|community_consultation|financial_assurance|other — 14 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory condition record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'Name of the source system or application from which this regulatory condition record was ingested (e.g., IsoMetrix, SAP EHS, Tenement Management System).',
    `effective_date` DATE COMMENT 'Date from which the regulatory condition becomes legally binding and enforceable. Marks the commencement of compliance obligations.',
    `enforcement_action_date` DATE COMMENT 'Date on which the enforcement action was formally issued or commenced by the granting authority.',
    `enforcement_action_type` STRING COMMENT 'Type of enforcement action taken or threatened by the granting authority in response to non-compliance with this condition. [ENUM-REF-CANDIDATE: warning_letter|show_cause_notice|remediation_direction|penalty_notice|prosecution|suspension|revocation|none — 8 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date on which the regulatory condition ceases to apply or is scheduled for review. Null if the condition is ongoing or perpetual.',
    `granting_authority` STRING COMMENT 'Name of the government department, agency, or regulatory body that imposed this condition (e.g., Department of Mines, Industry Regulation and Safety - DMIRS, Department of Planning and Environment - DPE).',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicator of whether this condition requires periodic regulatory inspections or site visits by the granting authority to verify compliance.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent internal or external compliance review or audit conducted to assess adherence to this regulatory condition.',
    `last_compliance_review_outcome` STRING COMMENT 'Result of the most recent compliance review or audit for this condition. Indicates whether the condition was found to be satisfied or breached.. Valid values are `compliant|non_compliant|partially_compliant|not_reviewed`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or site visit conducted by the granting authority to assess compliance with this condition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory condition record was last updated or modified. Supports audit trail and change tracking.',
    `legislation_reference` STRING COMMENT 'Citation of the specific legislation, act, regulation, or statutory instrument under which this condition was imposed (e.g., Mining Act 1978 Section 82, Environmental Protection Act 1986).',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next regulatory inspection or site visit by the granting authority to verify ongoing compliance with this condition.',
    `next_report_due_date` DATE COMMENT 'Date by which the next statutory report or compliance submission is due to the granting authority for this condition.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context regarding the regulatory condition, compliance activities, or interactions with the granting authority.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine imposed by the granting authority for breach of this regulatory condition, expressed in the reporting currency (typically AUD for Australian operations).',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to this condition based on risk, materiality, and potential impact of non-compliance on operations, reputation, or licence tenure.. Valid values are `critical|high|medium|low`',
    `remediation_due_date` DATE COMMENT 'Deadline by which remediation or corrective action must be completed to satisfy the granting authority and restore compliance.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicator of whether remediation or corrective action is required to address a breach or bring the operation into compliance with this condition.',
    `remediation_status` STRING COMMENT 'Current status of remediation or corrective action activities undertaken to address non-compliance with this condition.. Valid values are `not_started|in_progress|completed|verified|overdue|not_applicable`',
    `reporting_frequency` STRING COMMENT 'Frequency at which statutory reports or compliance evidence must be submitted to the granting authority to demonstrate adherence to this condition. [ENUM-REF-CANDIDATE: annual|semi_annual|quarterly|monthly|ad_hoc|one_time|not_applicable — 7 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Risk assessment rating for non-compliance with this condition, considering likelihood and consequence of breach on business operations and regulatory standing.. Valid values are `extreme|high|medium|low|negligible`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation, evidence, or records that demonstrate compliance with this condition (e.g., environmental management plans, monitoring reports, approvals).',
    CONSTRAINT pk_regulatory_condition PRIMARY KEY(`regulatory_condition_id`)
) COMMENT 'Unified compliance management entity recording all conditions, restrictions, obligations, enforcement actions, and statutory reporting requirements imposed on tenements by granting authorities (e.g., DMIRS, DPE). Covers condition types including environmental management plans, operational restrictions, annual reporting obligations, access limitations, and heritage protection conditions. Tracks compliance status per condition, breach/show-cause notices, remediation directions, and statutory report lodgement deadlines. Excludes heritage survey clearances (owned by heritage_clearance) to maintain SSOT boundary. Supports audit trails for regulatory inspections, licence compliance reviews, and enforcement response management.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`native_title_agreement` (
    `native_title_agreement_id` BIGINT COMMENT 'Unique identifier for the native title agreement record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Traditional owner groups are often registered as counterparties for royalty payments, commercial joint ventures, and employment agreements. Links agreement to counterparty master for payment processin',
    `tenement_id` BIGINT COMMENT 'Foreign key reference to the primary tenement or mining lease associated with this native title agreement.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Native title agreements are executed with specific traditional owner groups registered as stakeholders. Essential for tracking agreement parties, consultation obligations, and benefit distribution. Re',
    `agreement_number` STRING COMMENT 'The official registered agreement number assigned by the National Native Title Tribunal or equivalent regulatory body. This is the externally-known unique identifier for the agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the native title agreement. Registered indicates formal registration with the National Native Title Tribunal. Active indicates the agreement is in force and obligations are being met. [ENUM-REF-CANDIDATE: Draft|Negotiation|Executed|Registered|Active|Suspended|Terminated|Expired — 8 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'The category of native title agreement. ILUA = Indigenous Land Use Agreement.. Valid values are `ILUA|Heritage Agreement|Land Access Agreement|Compensation Agreement|Co-Management Agreement|Right to Negotiate Agreement`',
    `compensation_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for monetary compensation amounts.. Valid values are `AUD|USD|CAD|ZAR`',
    `compensation_type` STRING COMMENT 'The primary form of compensation provided to traditional owners under this agreement.. Valid values are `Monetary|In-Kind|Royalty|Employment|Mixed`',
    `compliance_status` STRING COMMENT 'Current compliance status indicating whether the mining company is meeting all obligations under this agreement.. Valid values are `Compliant|Non-Compliant|Under Review|Remediation Required`',
    `consultation_requirements` STRING COMMENT 'Description of ongoing consultation, engagement, and notification requirements with traditional owners for mining activities.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this agreement record was first created in the system.',
    `cultural_heritage_obligations` STRING COMMENT 'Description of the cultural heritage protection obligations and requirements imposed on the mining company under this agreement, including survey requirements, site avoidance, and consultation protocols.',
    `dispute_resolution_mechanism` STRING COMMENT 'The primary mechanism specified in the agreement for resolving disputes between parties.. Valid values are `Mediation|Arbitration|Traditional Law|Court|Mixed`',
    `document_repository_path` STRING COMMENT 'File path or URI to the location where the executed agreement document and related legal documents are stored in the document management system.',
    `effective_from_date` DATE COMMENT 'The date from which the agreement terms and obligations become effective and enforceable.',
    `employment_commitment` STRING COMMENT 'Description of commitments to provide employment, training, and business opportunities to traditional owner group members.',
    `environmental_obligations` STRING COMMENT 'Description of environmental management and rehabilitation obligations specific to this agreement, beyond standard regulatory requirements.',
    `execution_date` DATE COMMENT 'The date on which the agreement was formally executed by all parties. This is the principal business event timestamp for the agreement.',
    `expiry_date` DATE COMMENT 'The date on which the agreement expires or terminates, if applicable. Nullable for perpetual or open-ended agreements.',
    `geographic_coverage_description` STRING COMMENT 'Textual description of the geographic area covered by this agreement. Detailed spatial boundaries are maintained in GIS systems.',
    `ilua_type` STRING COMMENT 'The specific sub-category of ILUA if agreement_type is ILUA. Area Agreement covers a defined area, Body Corporate Agreement is with a registered native title body corporate, Alternative Procedure Agreement uses alternative state/territory processes.. Valid values are `Area Agreement|Body Corporate Agreement|Alternative Procedure Agreement`',
    `land_access_rights` STRING COMMENT 'Description of the land access rights granted to the mining company under this agreement, including permitted activities and geographic scope.',
    `last_compliance_audit_date` DATE COMMENT 'The date of the most recent compliance audit or review conducted for this agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this agreement record was last modified or updated in the system.',
    `legal_counsel_name` STRING COMMENT 'Name of the legal firm or counsel that advised on or drafted this agreement on behalf of the mining company.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of agreement compliance and performance.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the agreement, including any special conditions or historical context.',
    `registration_date` DATE COMMENT 'The date on which the agreement was officially registered with the National Native Title Tribunal or equivalent body, making it legally binding.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an option for renewal or extension beyond the initial term.',
    `renewal_terms` STRING COMMENT 'Description of the terms and conditions under which the agreement may be renewed or extended, if renewal_option_flag is true.',
    `royalty_basis` STRING COMMENT 'The basis on which royalty payments are calculated, if royalty compensation is included in the agreement.. Valid values are `Revenue|Production Volume|Net Profit|Gross Profit`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage royalty rate payable to traditional owners on mineral production or revenue, if applicable.',
    `termination_date` DATE COMMENT 'The actual date on which the agreement was terminated prior to its scheduled expiry, if applicable.',
    `total_compensation_amount` DECIMAL(18,2) COMMENT 'The total monetary compensation amount payable under the agreement, in the currency specified. Excludes in-kind or royalty-based compensation.',
    CONSTRAINT pk_native_title_agreement PRIMARY KEY(`native_title_agreement_id`)
) COMMENT 'Master record of all native title agreements, Indigenous Land Use Agreements (ILUAs), and heritage protection agreements associated with tenements. Stores agreement type, registered agreement number, traditional owner group name, execution date, expiry date, compensation terms, cultural heritage obligations, and current status. Critical for legal compliance with native title legislation (e.g., Native Title Act 1993 Australia).';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`heritage_clearance` (
    `heritage_clearance_id` BIGINT COMMENT 'Unique identifier for the heritage clearance record. Primary key for the heritage clearance entity.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Heritage incidents during clearance activities (disturbance, unauthorized access). Compliance tracking, regulatory notification, and traditional owner consultation require this link. Mining operations',
    `native_title_agreement_id` BIGINT COMMENT 'Foreign key linking to tenement.native_title_agreement. Business justification: Heritage clearances often require consent from traditional owners under a specific native title agreement. The clearance record currently has traditional_owner_group (string), traditional_owner_consen',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Heritage surveys clear specific orebody development areas for disturbance. Cultural heritage management and mine development planning require direct linkage between clearances and geological resources',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Heritage surveys are contracted services from specialized archaeological/anthropological firms. Real mining operations link clearance records to service contracts for heritage survey procurement track',
    `programme_of_work_id` BIGINT COMMENT 'Reference to the programme of work approval that requires this heritage clearance. Links clearance to the specific ground disturbance activity plan.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Heritage surveys conducted by internal heritage officers/archaeologists require competency verification, insurance coverage validation, and regulatory compliance tracking. Real business process: herit',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement on which the heritage clearance applies. Links this clearance to the specific exploration licence or mining lease requiring heritage assessment.',
    `clearance_area_hectares` DECIMAL(18,2) COMMENT 'Total area in hectares covered by this heritage clearance. Represents the spatial extent of the surveyed and cleared area for ground disturbance activities.',
    `clearance_expiry_date` DATE COMMENT 'Date on which the heritage clearance expires and a new survey or renewal is required. Nullable for clearances with indefinite validity subject to ongoing compliance.',
    `clearance_outcome` STRING COMMENT 'Detailed outcome of the heritage survey. Indicates whether no heritage sites were identified, sites were identified and will be avoided, sites were salvaged, sites require restricted access zones, or clearance was denied due to significant heritage values.. Valid values are `no_sites_identified|sites_identified_avoided|sites_identified_salvaged|sites_identified_restricted|clearance_denied`',
    `clearance_reference_number` STRING COMMENT 'External reference number or code assigned to this heritage clearance by the surveying authority, consultant, or regulatory body. Used for tracking and correspondence.',
    `clearance_status` STRING COMMENT 'Current lifecycle status of the heritage clearance. Indicates whether the area is pending assessment, cleared for disturbance, cleared with spatial or activity restrictions, refused clearance, expired, or under regulatory review.. Valid values are `pending|cleared|cleared_with_restrictions|refused|expired|under_review`',
    `clearance_valid_from_date` DATE COMMENT 'Date from which the heritage clearance becomes effective and ground disturbance activities may commence. Represents the start of the clearance validity period.',
    `conditions_and_restrictions` STRING COMMENT 'Detailed textual description of any conditions, restrictions, or mitigation measures imposed as part of the heritage clearance. May include activity limitations, monitoring requirements, or salvage protocols.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this heritage clearance record was first created in the system. Audit trail for data lineage and compliance tracking.',
    `heritage_site_register_numbers` STRING COMMENT 'Comma-separated list of heritage site register numbers identified during the survey. References official heritage site databases such as state Aboriginal heritage registers, National Heritage List, or Commonwealth Heritage List.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this heritage clearance record was last updated. Tracks the most recent change to the clearance status, conditions, or associated data.',
    `monitoring_required` BOOLEAN COMMENT 'Indicates whether ongoing heritage monitoring is required during ground disturbance activities. True if a heritage monitor must be present during excavation or earthworks, false otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context regarding the heritage clearance. May include stakeholder feedback, site-specific considerations, or follow-up actions.',
    `regulatory_approval_authority` STRING COMMENT 'Name of the government regulatory authority that reviewed and approved the heritage clearance. May include state heritage departments, environmental protection agencies, or federal heritage bodies.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority formally approved the heritage clearance. Represents the official compliance milestone for pre-disturbance heritage requirements.',
    `regulatory_approval_reference` STRING COMMENT 'Official reference number or permit number issued by the regulatory authority for this heritage clearance. Used for compliance tracking and audit purposes.',
    `restricted_zone_description` STRING COMMENT 'Textual description of any restricted zones or exclusion areas identified in the clearance. Describes spatial boundaries, buffer distances, and activity restrictions to protect heritage sites.',
    `restricted_zone_spatial_reference` STRING COMMENT 'Geographic Information System (GIS) spatial reference or coordinate set defining the boundaries of restricted heritage zones. May include polygon coordinates, GIS layer references, or map grid references.',
    `salvage_completion_date` DATE COMMENT 'Date on which required archaeological salvage operations were completed. Nullable if salvage is not required or is still in progress.',
    `salvage_required` BOOLEAN COMMENT 'Indicates whether archaeological salvage operations are required before ground disturbance. True if artifacts or sites must be salvaged and relocated, false otherwise.',
    `survey_completion_date` DATE COMMENT 'Date on which the heritage survey report was finalized and submitted. May differ from survey_date if report preparation takes additional time.',
    `survey_cost_aud` DECIMAL(18,2) COMMENT 'Total cost in Australian Dollars incurred for conducting the heritage survey, including consultant fees, traditional owner consultation costs, and report preparation. Business-confidential financial data.',
    `survey_date` DATE COMMENT 'Date on which the heritage survey was conducted in the field. Represents the principal business event timestamp for the clearance process.',
    `survey_report_document_path` STRING COMMENT 'File path or document management system reference to the full heritage survey report. Enables retrieval of detailed survey findings, site maps, and recommendations.',
    `survey_type` STRING COMMENT 'Type of heritage survey conducted. Distinguishes between Aboriginal heritage surveys, historical heritage assessments, archaeological salvage operations, ethnographic surveys, combined surveys, or desktop assessments.. Valid values are `aboriginal_heritage_survey|historical_heritage_assessment|archaeological_salvage|ethnographic_survey|combined_heritage_survey|desktop_assessment`',
    `surveying_authority` STRING COMMENT 'Name of the heritage consultant, archaeological firm, or traditional owner group that conducted the heritage survey. May include accredited heritage practitioners or registered native title bodies corporate.',
    `surveyor_contact_email` STRING COMMENT 'Primary email address of the surveying authority or lead consultant for correspondence regarding this clearance.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `surveyor_contact_phone` STRING COMMENT 'Primary phone number of the surveying authority or lead consultant for urgent clearance inquiries.',
    `traditional_owner_consent_obtained` BOOLEAN COMMENT 'Indicates whether formal consent from the traditional owner group was obtained for ground disturbance activities. True if consent was granted, false if consent was not obtained or not required.',
    `traditional_owner_group` STRING COMMENT 'Name of the Aboriginal traditional owner group or native title claimant group consulted during the heritage survey. Identifies the Indigenous custodians of the land with cultural heritage rights.',
    CONSTRAINT pk_heritage_clearance PRIMARY KEY(`heritage_clearance_id`)
) COMMENT 'Tracks cultural and archaeological heritage survey clearances required before ground disturbance on a tenement. Records survey type (Aboriginal heritage survey, historical heritage assessment, archaeological salvage), survey date, surveying authority or consultant, clearance outcome (pending, cleared, cleared-with-restrictions, refused), restricted zones with spatial references, and associated heritage site register numbers. Distinct from regulatory_condition in that it captures the pre-disturbance survey and clearance workflow rather than ongoing compliance conditions. Mandatory pre-disturbance compliance record linked to programme_of_work approvals.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`surface_right` (
    `surface_right_id` BIGINT COMMENT 'Unique identifier for the surface right record. Primary key for the surface right entity.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Surface rights agreements (land access, landholder compensation) are formalized as procurement contracts with landowners treated as vendors for payment processing. Business process: land access paymen',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Surface rights require ongoing management by designated employees for stakeholder liaison, compliance monitoring, payment tracking, and renewal management. Real business process: surface rights admini',
    `tenement_id` BIGINT COMMENT 'Reference to the parent tenement or mining lease to which this surface right is associated. Links the surface right to the underlying mineral rights holder.',
    `agreement_document_reference` STRING COMMENT 'Reference identifier or file path to the legal agreement document or contract governing this surface right. Links to document management system.',
    `area_description` STRING COMMENT 'Textual description of the geographic area or land parcel covered by the surface right. May include lot numbers, cadastral references, or natural feature descriptions.',
    `area_hectares` DECIMAL(18,2) COMMENT 'The total area covered by the surface right measured in hectares. Provides quantitative measure of the land extent subject to the right.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The total monetary compensation or payment amount agreed to be paid to the grantor for the surface right. May be a one-time payment, annual fee, or total over term.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which compensation is denominated and paid.. Valid values are `^[A-Z]{3}$`',
    `compensation_frequency` STRING COMMENT 'The frequency or schedule on which compensation payments are made to the grantor. Indicates whether payment is a single lump sum or recurring.. Valid values are `one-time|annual|quarterly|monthly|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this surface right record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'The date on which the surface right agreement expires or terminates. Nullable for perpetual or indefinite rights. Marks the end of the term.',
    `effective_start_date` DATE COMMENT 'The date on which the surface right agreement becomes legally effective and the rights granted commence. Marks the beginning of the term.',
    `environmental_conditions` STRING COMMENT 'Textual description of any environmental management conditions, rehabilitation obligations, or ecological constraints attached to the surface right. Captures environmental compliance requirements.',
    `gis_boundary_reference` STRING COMMENT 'Reference identifier or file name linking this surface right to its spatial boundary representation in the corporate GIS system. Enables mapping and spatial analysis.',
    `grantor_contact_email` STRING COMMENT 'Primary email address for the grantor contact. Used for formal correspondence and notifications related to the surface right.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `grantor_contact_name` STRING COMMENT 'The name of the primary contact person representing the grantor for correspondence and negotiation related to this surface right.',
    `grantor_contact_phone` STRING COMMENT 'Primary telephone number for the grantor contact. Used for operational communication regarding the surface right agreement.',
    `grantor_name` STRING COMMENT 'The legal name of the party granting the surface right. May be a private landowner, government authority, indigenous group, or other entity holding surface title.',
    `grantor_type` STRING COMMENT 'Classification of the grantor entity. Distinguishes between private landowners, government bodies, indigenous or native title holders, corporate entities, trusts, and other grantor types.. Valid values are `private|government|indigenous|corporate|trust|other`',
    `heritage_clearance_flag` BOOLEAN COMMENT 'Indicates whether cultural heritage clearance or archaeological survey has been completed and approved for the surface right area. True if clearance is in place, false otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this surface right record was most recently modified or updated. Audit trail for change tracking and data currency.',
    `native_title_clearance_flag` BOOLEAN COMMENT 'Indicates whether native title clearance or indigenous land use agreement has been obtained for this surface right. True if clearance is in place, false otherwise. Critical for compliance in jurisdictions with indigenous land rights.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or contextual information related to the surface right. Captures ad-hoc information not covered by structured fields.',
    `purpose` STRING COMMENT 'Description of the intended purpose or use for which the surface right is granted. Explains the business or operational need driving the right (e.g., haul road construction, water extraction, pipeline installation).',
    `registered_authority` STRING COMMENT 'The name of the government department, land registry, or regulatory body with which the surface right is registered or lodged. Relevant for compliance and legal standing.',
    `registration_date` DATE COMMENT 'The date on which the surface right was formally registered or lodged with the relevant authority. Establishes legal priority and public record.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the surface right agreement includes an option for renewal or extension beyond the initial term. True if renewal provisions exist, false otherwise.',
    `renewal_terms` STRING COMMENT 'Textual description of the conditions, notice periods, and terms under which the surface right may be renewed or extended. Captures renewal provisions from the agreement.',
    `restrictions` STRING COMMENT 'Textual description of any restrictions, limitations, or conditions placed on the use of the surface right. May include environmental conditions, access limitations, or operational constraints.',
    `right_number` STRING COMMENT 'The externally-known unique identifier or registration number assigned to this surface right by the grantor or regulatory authority. Used for legal reference and tracking.',
    `right_type` STRING COMMENT 'Classification of the surface right indicating the nature of the right granted. Distinguishes between access rights, water rights, pipeline easements, road access, and other infrastructure or utility rights. [ENUM-REF-CANDIDATE: access|water|pipeline|road|easement|infrastructure|utility|other — 8 candidates stripped; promote to reference product]',
    `surface_right_status` STRING COMMENT 'Current lifecycle status of the surface right agreement. Indicates whether the right is currently in force, awaiting approval, has lapsed, or has been terminated.. Valid values are `active|pending|expired|terminated|suspended|draft`',
    `term_years` STRING COMMENT 'The duration of the surface right agreement expressed in whole years. Calculated from effective start to end date, or specified contractually.',
    CONSTRAINT pk_surface_right PRIMARY KEY(`surface_right_id`)
) COMMENT 'Master register of surface rights, easements, and access agreements associated with tenement areas. Captures right type (access, water, pipeline, road), grantor details, area description, term start and end dates, compensation amount, and any restrictions on use. Distinguishes surface rights from the underlying mineral rights and supports land access management.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`royalty_agreement` (
    `royalty_agreement_id` BIGINT COMMENT 'Unique identifier for the royalty agreement record. Primary key for the royalty agreement entity.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Royalty payees (landowners, previous tenement holders, state entities, traditional owners) are registered counterparties for payment processing via bank_account, credit limit management, and commercia',
    `royalty_obligation_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_obligation. Business justification: Tenement-level royalty agreements create financial obligations tracked in finance for accrual calculation, payment processing, and cash flow forecasting. Essential for reconciling contractual terms wi',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement (exploration licence or mining lease) to which this royalty agreement is attached.',
    `accrual_method` STRING COMMENT 'The accounting method used to accrue royalty obligations. Production-based accrues royalties when minerals are extracted; sales-based accrues when minerals are sold; cash basis recognizes when payment is made; shipment-based accrues when minerals are shipped.. Valid values are `production_based|sales_based|cash_basis|shipment_based`',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the royalty agreement for business reference and reporting purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the royalty agreement, used in contracts and financial reporting.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the royalty agreement. Active agreements are in force and accruing obligations; suspended agreements are temporarily paused; terminated agreements have ended; pending agreements are awaiting execution; under review agreements are being renegotiated; disputed agreements have unresolved conflicts.. Valid values are `active|suspended|terminated|pending|under_review|disputed`',
    `applicable_commodity` STRING COMMENT 'The mineral commodity or commodities to which this royalty agreement applies (e.g., iron ore, copper, coal, lithium, nickel, gold). May be a single commodity or multiple commodities separated by delimiters.',
    `assignment_restrictions` STRING COMMENT 'Description of any restrictions on the companys ability to assign or transfer the royalty agreement to another party, or on the payees ability to assign their royalty entitlement.',
    `audit_rights` STRING COMMENT 'Description of the payees rights to audit the companys books and records to verify royalty calculations, including frequency, notice period, and scope of audit rights as specified in the agreement.',
    `calculation_basis` STRING COMMENT 'The method used to calculate the royalty payment. Ad valorem royalties are percentage-based on the value of minerals extracted; specific royalties are fixed amounts per unit of production; profit-based royalties are calculated on net operating profit; NSR (Net Smelter Return) royalties are based on revenue after processing costs; gross revenue royalties are based on total sales value; production volume royalties are based on tonnage or units extracted.. Valid values are `ad_valorem|specific|profit_based|nsr|gross_revenue|production_volume`',
    `contract_document_reference` STRING COMMENT 'Reference to the physical or electronic location of the executed royalty agreement contract document in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty agreement record was first created in the system. Used for audit trail and data lineage purposes.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which royalty payments are calculated and remitted (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `data_classification` STRING COMMENT 'The data classification level assigned to this royalty agreement record based on the sensitivity of the information contained within it. Determines access controls and handling requirements.. Valid values are `restricted|confidential|internal|public`',
    `deduction_allowances` STRING COMMENT 'Description of any allowable deductions from the royalty calculation basis, such as transportation costs, processing costs, marketing costs, or other expenses that may be deducted before calculating the royalty payment.',
    `dispute_resolution_mechanism` STRING COMMENT 'The method specified in the agreement for resolving disputes between the parties regarding royalty calculations, payments, or interpretation of agreement terms.. Valid values are `litigation|arbitration|mediation|expert_determination|negotiation`',
    `effective_end_date` DATE COMMENT 'The date on which the royalty agreement expires or terminates. Nullable for perpetual royalty agreements that continue for the life of the mine or tenement.',
    `effective_start_date` DATE COMMENT 'The date from which the royalty agreement becomes legally binding and royalty obligations commence. Typically aligned with the grant date of the tenement or the execution date of a private royalty deed.',
    `escalation_clause` STRING COMMENT 'Description of any escalation provisions in the royalty agreement, such as rate increases tied to commodity price thresholds, inflation indices (CPI), or production volume milestones.',
    `governing_law` STRING COMMENT 'The legal jurisdiction and governing law that applies to the interpretation and enforcement of the royalty agreement (e.g., Western Australia, Queensland, British Columbia).',
    `ifrs_classification` STRING COMMENT 'The classification of the royalty obligation under IFRS accounting standards for financial reporting purposes. Determines how the royalty is recognized in financial statements.. Valid values are `operating_expense|revenue_deduction|financial_liability|contingent_consideration`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty agreement record was last updated in the system. Used for audit trail and change tracking purposes.',
    `maximum_royalty_amount` DECIMAL(18,2) COMMENT 'The maximum royalty payment amount cap per period, if specified in the agreement. Used in some profit-sharing or capped royalty structures.',
    `minimum_royalty_amount` DECIMAL(18,2) COMMENT 'The minimum royalty payment amount required per period regardless of production or revenue levels, as specified in some royalty agreements to guarantee minimum returns to the payee.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the royalty agreement that do not fit into structured fields.',
    `payment_frequency` STRING COMMENT 'The frequency at which royalty payments are calculated and remitted to the payee as specified in the agreement terms.. Valid values are `monthly|quarterly|semi_annually|annually|per_shipment|on_demand`',
    `payment_terms_days` STRING COMMENT 'The number of days after the calculation period end or invoice date within which the royalty payment must be made to the payee.',
    `reporting_obligation` STRING COMMENT 'Description of the reporting requirements specified in the royalty agreement, including frequency, format, and content of production reports, sales reports, and royalty calculations that must be provided to the payee.',
    `royalty_formula` STRING COMMENT 'The detailed formula or algorithm used to calculate the royalty payment, including any tiered rates, thresholds, or complex calculation logic. Used when a simple rate is insufficient to capture the calculation method.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to the calculation basis to determine the royalty payment amount. For ad valorem and percentage-based royalties. Stored as a decimal (e.g., 0.025 for 2.5%).',
    `royalty_type` STRING COMMENT 'Classification of the royalty obligation. Government royalties are statutory payments to the state; private royalties are contractual payments to landowners or previous tenement holders; Net Smelter Return (NSR) royalties are calculated on gross revenue from mineral sales after smelting and refining costs; gross revenue royalties are based on total sales; profit-based royalties are calculated on net profit; production-based royalties are based on volume or tonnage extracted.. Valid values are `government|private|net_smelter_return|gross_revenue|profit_based|production_based`',
    `security_interest` STRING COMMENT 'Description of any security interests, liens, or encumbrances granted to the payee to secure royalty payment obligations, such as charges over mining assets or revenue streams.',
    `termination_conditions` STRING COMMENT 'Description of the conditions under which the royalty agreement may be terminated by either party, including breach provisions, notice periods, and termination payments.',
    CONSTRAINT pk_royalty_agreement PRIMARY KEY(`royalty_agreement_id`)
) COMMENT 'Master record of royalty obligations attached to tenements, including government royalties, private royalties, and net smelter return (NSR) royalties. Stores royalty type, rate or formula, calculation basis (ad valorem, specific, profit-based), payee details, payment frequency, and applicable commodity. Supports royalty accrual calculations and financial reporting under IFRS.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`royalty_payment` (
    `royalty_payment_id` BIGINT COMMENT 'Unique identifier for the tenement royalty payment transaction record. Primary key for this entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Royalty payments are operating costs that must be allocated to cost centres for unit cost calculation (AISC and C1 cost). Required for accurate cost reporting and profitability analysis by tenement/si',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Each royalty payment must post to specific GL accounts for financial statement preparation and expense recognition. Essential for monthly financial close, audit trail, and ensuring correct classificat',
    `royalty_agreement_id` BIGINT COMMENT 'Reference to the parent royalty agreement under which this payment is calculated and remitted.',
    `tenement_id` BIGINT COMMENT 'Reference to the mining tenement (exploration licence or mining lease) from which the production subject to this royalty payment originated.',
    `actual_payment_date` DATE COMMENT 'Actual date on which the royalty payment was remitted to the payee. Null if payment has not yet been made.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to the calculated royalty amount, including credits, deductions, prior period corrections, or dispute resolutions. Positive values increase the payment; negative values reduce it.',
    `approval_date` DATE COMMENT 'Date on which the royalty payment was approved for remittance by authorized personnel. Null if not yet approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the royalty payment for remittance.',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'Gross royalty amount calculated by applying the royalty rate to the production value or tonnage, before any adjustments or deductions.',
    `calculation_date` DATE COMMENT 'Date on which the royalty payment amount was calculated and recorded in the system.',
    `commodity_grade_percent` DECIMAL(18,2) COMMENT 'Average grade or quality of the commodity produced during the period, expressed as a percentage (e.g., iron ore Fe content, copper Cu content). Used for royalty rate determination where applicable.',
    `commodity_type` STRING COMMENT 'Type of mineral commodity produced during the period for which the royalty is calculated (e.g., iron ore, copper, coal, lithium, nickel). [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|lead|other — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the royalty payment is denominated and remitted (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `finance_gl_account_code` STRING COMMENT 'General ledger account code in the finance system to which this royalty payment liability is posted for reconciliation with the finance domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty payment record was last modified or updated in the system.',
    `net_royalty_amount` DECIMAL(18,2) COMMENT 'Final net royalty amount payable after applying all adjustments to the calculated royalty amount. This is the amount remitted to the payee.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this royalty payment, including explanations of adjustments, dispute details, or special circumstances affecting the payment.',
    `payee_account_reference` STRING COMMENT 'Reference to the payees bank account or payment destination to which the royalty payment is remitted. May be an account number, payment reference, or identifier in the finance system.',
    `payee_name` STRING COMMENT 'Name of the party (individual, organization, or government authority) to whom the royalty payment is remitted.',
    `payee_type` STRING COMMENT 'Classification of the royalty payee indicating the type of entity receiving the payment (e.g., government authority, private landowner, native title holder, joint venture partner).. Valid values are `government|private_landowner|native_title_holder|joint_venture_partner|other`',
    `payment_due_date` DATE COMMENT 'Contractual due date by which the royalty payment must be remitted to the payee, as specified in the royalty agreement terms.',
    `payment_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this royalty payment for tracking and reconciliation purposes with payee and finance systems.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the royalty payment indicating its progression through calculation, approval, remittance, and reconciliation stages. [ENUM-REF-CANDIDATE: calculated|accrued|approved|remitted|reconciled|disputed|cancelled — 7 candidates stripped; promote to reference product]',
    `production_period_end_date` DATE COMMENT 'End date of the production period for which this royalty payment is calculated. Defines the conclusion of the reporting period covered by this payment.',
    `production_period_start_date` DATE COMMENT 'Start date of the production period for which this royalty payment is calculated. Defines the beginning of the reporting period covered by this payment.',
    `production_tonnage` DECIMAL(18,2) COMMENT 'Total tonnage of mineral commodity produced or sold during the production period that is subject to royalty calculation, measured in metric tonnes.',
    `production_value_amount` DECIMAL(18,2) COMMENT 'Total value of production during the period used as the basis for royalty calculation. For revenue-based royalties, this is the sales revenue; for profit-based, this is the net profit.',
    `reconciliation_date` DATE COMMENT 'Date on which this royalty payment was reconciled with the finance general ledger. Null if reconciliation is pending or incomplete.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between this tenement-domain royalty payment record and the corresponding finance general ledger entry. Indicates whether the payment has been successfully reconciled or if variances exist.. Valid values are `pending|reconciled|variance_identified|under_review`',
    `regulatory_return_reference` STRING COMMENT 'Reference number of the regulatory royalty return or report submitted to government authorities (e.g., Mining Rehabilitation Fund return, state royalty return) that includes this payment.',
    `royalty_basis` STRING COMMENT 'Basis on which the royalty is calculated: revenue-based (percentage of sales revenue), profit-based (percentage of net profit), tonnage-based (per tonne rate), or fixed fee.. Valid values are `revenue|profit|tonnage|fixed_fee`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Applicable royalty rate percentage applied to the production value or tonnage to calculate the royalty amount. Rate is determined by the royalty agreement terms and may vary by commodity, grade, or production volume.',
    CONSTRAINT pk_royalty_payment PRIMARY KEY(`royalty_payment_id`)
) COMMENT 'Transactional record of each royalty payment calculated, accrued, or remitted against a royalty agreement for a specific production period. Captures payment period, production tonnage, commodity grade/quality, applicable royalty rate, calculated royalty amount, payment due date, actual payment date, payee, and payment reference number. This is the tenement-domain SSOT for royalty liability calculation; actual cash disbursement is recorded in the finance domain. Supports reconciliation with finance general ledger and regulatory royalty returns submitted to government authorities (e.g., Mining Rehabilitation Fund returns).';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`application` (
    `application_id` BIGINT COMMENT 'Unique identifier for the tenement application record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Applications by external parties (farm-in partners, acquisition targets, joint venture applicants) require counterparty linkage for due diligence reviews, commercial negotiation tracking, KYC complian',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: When a tenement application is granted, it results in the creation of a tenement record. This FK tracks the outcome of the application process. The FK is populated when application_status = Granted ',
    `application_number` STRING COMMENT 'The externally-known unique reference number assigned by the regulatory authority to this tenement application upon lodgement. This is the official identifier used in all correspondence and regulatory filings.',
    `application_status` STRING COMMENT 'Current state of the application in its regulatory approval workflow, from initial lodgement through final decision. [ENUM-REF-CANDIDATE: lodged|under_review|objection_period|hearing_scheduled|approved|refused|withdrawn|lapsed — 8 candidates stripped; promote to reference product]',
    `application_type` STRING COMMENT 'The category of tenement being applied for, determining the rights and obligations associated with the application.. Valid values are `exploration_licence|mining_lease|retention_lease|prospecting_licence|mineral_claim|assessment_lease`',
    `area_hectares` DECIMAL(18,2) COMMENT 'The total surface area covered by the tenement application, measured in hectares. Used to calculate application fees and expenditure commitments.',
    `conditions_of_grant` STRING COMMENT 'A description of any special conditions, restrictions, or obligations imposed by the regulatory authority as part of the tenement grant (e.g., environmental monitoring requirements, access restrictions, rehabilitation bonds).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this application record was first created in the system. Used for audit trail and data lineage.',
    `decision_date` DATE COMMENT 'The date on which the regulatory authority made a final determination to grant, refuse, or otherwise dispose of the application.',
    `environmental_assessment_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an Environmental Impact Statement (EIS) or environmental assessment is required as part of the application approval process.',
    `environmental_assessment_status` STRING COMMENT 'The current status of the environmental assessment or EIS submission and approval process.. Valid values are `not_required|pending|submitted|approved|refused`',
    `expenditure_commitment_amount` DECIMAL(18,2) COMMENT 'The minimum amount the applicant commits to spend on exploration or development activities within a specified period as a condition of the tenement grant. Critical for compliance tracking.',
    `expenditure_commitment_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the expenditure commitment amount. [ENUM-REF-CANDIDATE: AUD|USD|CAD|ZAR|CLP|PEN|BRL — 7 candidates stripped; promote to reference product]',
    `fee_amount` DECIMAL(18,2) COMMENT 'The total fee payable to the regulatory authority for processing the tenement application, typically calculated based on area and application type.',
    `fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the application fee amount. [ENUM-REF-CANDIDATE: AUD|USD|CAD|ZAR|CLP|PEN|BRL — 7 candidates stripped; promote to reference product]',
    `grant_date` DATE COMMENT 'The date on which the tenement was officially granted and the applicants rights became effective. Null if application was refused or withdrawn.',
    `hearing_scheduled_date` DATE COMMENT 'The date scheduled for a formal hearing or tribunal to adjudicate the objection. Null if no hearing is required or scheduled.',
    `heritage_clearance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether cultural heritage clearance or survey is required before the application can be granted, to protect Indigenous or historical heritage sites.',
    `heritage_clearance_status` STRING COMMENT 'The current status of cultural heritage clearance or survey for this application.. Valid values are `not_required|pending|obtained|refused`',
    `jurisdiction` STRING COMMENT 'The state, province, territory, or country in which the tenement application is lodged and governed. Determines applicable legislation and regulatory framework.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this application record was last updated in the system. Used for audit trail and change tracking.',
    `lodgement_date` DATE COMMENT 'The date on which the tenement application was formally submitted to the regulatory authority. This date establishes priority in jurisdictions operating under first-in-time principles.',
    `mineral_sought` STRING COMMENT 'The primary mineral, metal, or commodity that the applicant intends to explore for or extract under this tenement. May list multiple commodities separated by commas (e.g., iron ore, copper, gold).',
    `native_title_clearance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether native title clearance or Indigenous Land Use Agreement (ILUA) is required before the application can be granted, based on the location and applicable native title claims.',
    `native_title_clearance_status` STRING COMMENT 'The current status of native title clearance or ILUA negotiation for this application.. Valid values are `not_required|pending|obtained|refused`',
    `objection_grounds` STRING COMMENT 'A description of the legal, environmental, cultural, or other grounds on which the objection is based (e.g., native title conflict, environmental impact, overlapping tenure, heritage site protection).',
    `objection_lodgement_date` DATE COMMENT 'The date on which the objection was formally lodged with the regulatory authority. Null if no objection received.',
    `objection_received_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any formal objections have been lodged against this application by third parties, native title claimants, environmental groups, or other stakeholders.',
    `objection_resolution` STRING COMMENT 'The outcome of the objection process: whether the objection was upheld (application refused or modified), dismissed (application proceeds), settled (parties reached agreement), withdrawn by objector, or still pending.. Valid values are `upheld|dismissed|settled|withdrawn|pending`',
    `objection_resolution_date` DATE COMMENT 'The date on which the objection was formally resolved through hearing, settlement, or withdrawal. Null if objection is still pending.',
    `objector_name` STRING COMMENT 'The name of the individual, organization, or entity that lodged an objection to the application. Null if no objection received. May contain multiple objectors separated by semicolons if multiple objections exist.',
    `outcome` STRING COMMENT 'The final disposition of the application after regulatory review and decision-making process.. Valid values are `granted|refused|withdrawn|lapsed|converted`',
    `priority_date` DATE COMMENT 'The date from which the applicants priority rights are calculated, which may differ from lodgement date in cases of renewals, conversions, or transfers. Critical for determining precedence over competing applications.',
    `refusal_reason` STRING COMMENT 'A description of the reason(s) the regulatory authority refused the application, if applicable. Null if application was granted or is still pending.',
    `regulatory_authority` STRING COMMENT 'The name of the government department, ministry, or agency responsible for processing and deciding on this tenement application (e.g., Department of Mines, Ministry of Natural Resources).',
    `withdrawal_reason` STRING COMMENT 'A description of the reason the applicant withdrew the application, if applicable. Null if application was not withdrawn.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Tracks the full lifecycle of tenement applications from lodgement through grant or refusal, including objection management. Records application type, lodgement date, fees, regulatory reference, applicant entity, priority date, objection details (objector, grounds, hearing date, resolution), decision date, and outcome. Enables portfolio pipeline management and application risk assessment.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`transfer` (
    `transfer_id` BIGINT COMMENT 'Unique identifier for the tenement transfer transaction. Primary key for the tenement transfer record.',
    `counterparty_id` BIGINT COMMENT 'Reference to the party receiving or acquiring interest in the tenement. The buyer or assignee in the transaction.',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement being transferred. Links to the exploration licence, mining lease, or other land tenure instrument subject to the transfer.',
    `transfer_counterparty_id` BIGINT COMMENT 'Reference to the party transferring or assigning their interest in the tenement. The seller or assignor in the transaction.',
    `holder_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement_holder. Business justification: Transfer records currently store transferor_legal_name as a string. This should normalize to reference the actual tenement_holder record representing the transferors ownership position at the time of',
    `agreement_document_reference` STRING COMMENT 'Reference to the legal transfer agreement or deed of assignment document. May be a document management system identifier or contract reference number.',
    `completion_date` DATE COMMENT 'The date on which all conditions precedent were satisfied and the transfer was formally completed. This is when ownership and operational control transferred to the transferee.',
    `consideration_amount` DECIMAL(18,2) COMMENT 'The monetary value paid or payable by the transferee to the transferor for the transferred interest. Excludes contingent payments and royalties unless explicitly included in the transfer agreement.',
    `consideration_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the consideration amount. Typically AUD, USD, CAD, or other major currencies depending on jurisdiction and transaction structure.. Valid values are `^[A-Z]{3}$`',
    `contingent_payment_flag` BOOLEAN COMMENT 'Indicates whether the transfer agreement includes contingent or deferred payments tied to future events such as production milestones, resource upgrades, or commodity price thresholds.',
    `created_by_user` STRING COMMENT 'The user identifier or name of the person who created this tenement transfer record. Audit trail field for data governance and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tenement transfer record was first created in the system. Audit trail field for data governance and compliance.',
    `due_diligence_completion_date` DATE COMMENT 'The date on which the transferee completed due diligence on the tenement. Marks the end of the investigation period and typically precedes the transfer execution date.',
    `effective_date` DATE COMMENT 'The date from which the transfer becomes legally binding and the transferee assumes rights and obligations. May differ from transfer_date if regulatory approval is required.',
    `environmental_approval_flag` BOOLEAN COMMENT 'Indicates whether environmental approvals or notifications were required for the transfer. May be required when the transfer involves change of operator or modification of environmental management plans.',
    `expenditure_commitment_transferred_flag` BOOLEAN COMMENT 'Indicates whether outstanding expenditure commitments on the tenement were transferred to the transferee. Relevant for exploration licences with minimum annual expenditure obligations.',
    `heritage_clearance_flag` BOOLEAN COMMENT 'Indicates whether cultural heritage clearances or approvals were required and obtained as part of the transfer process. Relevant when the transfer involves change of operator or new work programs.',
    `interest_percentage_transferred` DECIMAL(18,2) COMMENT 'The percentage of ownership interest in the tenement being transferred. For full assignments this is 100.00; for partial assignments this reflects the fractional interest transferred.',
    `last_modified_by_user` STRING COMMENT 'The user identifier or name of the person who last modified this tenement transfer record. Audit trail field for data governance and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this tenement transfer record was last updated. Audit trail field for data governance and compliance.',
    `native_title_consent_date` DATE COMMENT 'The date on which native title holder consent was formally obtained or the notification period expired. Required for compliance with indigenous land rights legislation.',
    `native_title_consent_flag` BOOLEAN COMMENT 'Indicates whether native title holder consent or notification was required and obtained for the transfer. Relevant in jurisdictions with indigenous land rights frameworks such as Australia and Canada.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or remarks about the transfer. May include details on contingent payments, earn-in structures, or regulatory conditions.',
    `reference_number` STRING COMMENT 'Externally-known business identifier for the transfer transaction. May be assigned by the regulatory authority or internal system. Used for regulatory correspondence and audit trails.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `regulatory_approval_date` DATE COMMENT 'The date on which the mining regulatory authority formally approved the transfer. This date often determines when the transfer becomes legally effective.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier assigned by the mining regulatory authority when approving the transfer. Required for transfers of exploration licences and mining leases in most jurisdictions.',
    `regulatory_authority_name` STRING COMMENT 'Name of the government department or statutory body that approved the transfer. Examples include Department of Mines, Mineral Resources Authority, or equivalent jurisdiction-specific body.',
    `royalty_obligation_flag` BOOLEAN COMMENT 'Indicates whether the transfer creates or modifies a royalty obligation payable to the transferor or a third party. Common in partial divestments and joint venture structures.',
    `security_bond_transferred_flag` BOOLEAN COMMENT 'Indicates whether environmental or rehabilitation security bonds were transferred to the transferee or whether new bonds were required. Critical for mining leases with rehabilitation obligations.',
    `transfer_date` DATE COMMENT 'The date on which the transfer transaction was executed or became effective. This is the principal business event timestamp for the transfer.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the transfer transaction. Tracks progression from draft through regulatory approval to completion or cancellation. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer transaction. Indicates whether the transfer is a full assignment of all rights, partial assignment of interest, change of control due to corporate restructure, merger, divestment, or joint venture entry.. Valid values are `full_assignment|partial_assignment|change_of_control|merger|divestment|joint_venture_entry`',
    `transferee_legal_name` STRING COMMENT 'The full legal name of the transferee party as registered with the regulatory authority. Captured for regulatory notification and audit trail purposes.',
    `transferor_retained_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership interest retained by the transferor after the transfer. For full assignments this is 0.00; for partial assignments this reflects the remaining interest.',
    CONSTRAINT pk_transfer PRIMARY KEY(`transfer_id`)
) COMMENT 'Records all transfers, assignments, and changes of ownership or interest in tenements. Captures transferor, transferee, transfer date, percentage interest transferred, regulatory approval reference, consideration amount, and post-transfer ownership structure. Supports corporate transaction due diligence, regulatory notification obligations, and ownership history audit trails.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the tenement holder record. Primary key for this association entity tracking ownership interests in tenements over time.',
    `counterparty_id` BIGINT COMMENT 'Reference to the legal entity (company, joint venture participant, or individual) holding an ownership interest in the tenement. Links to the party master for counterparty details.',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement (exploration licence, mining lease, or other mineral right) for which ownership is being recorded.',
    `annual_return_lodgement_flag` BOOLEAN COMMENT 'Indicates whether this ownership interest has been included in the most recent annual return lodged with the mining registrar. True if reported; False if not yet reported. Used to track compliance with annual reporting obligations.',
    `beneficial_owner_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the ultimate beneficial owner of this interest has been disclosed to the mining registrar, as required by anti-money laundering and transparency regulations. True if disclosed; False if not yet disclosed or not required.',
    `consideration_amount` DECIMAL(18,2) COMMENT 'Monetary consideration paid for this ownership interest transfer. Used for financial reporting, tax calculations, and asset valuation. Null if no consideration (e.g., initial grant, inheritance, or corporate restructure). Confidential commercial information.',
    `consideration_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the consideration amount. Examples: AUD (Australian Dollar), USD (United States Dollar), CAD (Canadian Dollar). Null if no consideration amount.. Valid values are `^[A-Z]{3}$`',
    `contributing_interest_flag` BOOLEAN COMMENT 'Indicates whether this holder is contributing to ongoing expenditure commitments and operations. True if actively funding; False if carried or diluted. Used for cost allocation and expenditure commitment tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tenement holder record was first created in the system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dilution_trigger_event` STRING COMMENT 'Description of the event or milestone that triggered a dilution of this holders interest. Examples include failure to contribute to expenditure, decision not to participate in development, or automatic dilution clause in joint venture agreement. Null if no dilution has occurred.',
    `effective_date` DATE COMMENT 'Date from which this ownership interest became legally effective. Typically the date of transfer registration, farm-in completion, or initial grant. Used for temporal queries on historical ownership structures.',
    `end_date` DATE COMMENT 'Date on which this ownership interest ceased or was transferred. Null for current active holdings. Used to track historical ownership changes, dilutions, and exits from joint ventures.',
    `free_carried_percentage` DECIMAL(18,2) COMMENT 'Percentage of this holders interest that is free-carried (not required to contribute to costs) through a specified stage or milestone. Common in farm-in agreements where one party funds exploration in exchange for equity. Null if not applicable.',
    `free_carried_until_date` DATE COMMENT 'Date until which the free-carried interest applies. After this date, the holder must contribute pro-rata to costs or face dilution. Null if free-carried arrangement is perpetual or not applicable.',
    `joint_venture_agreement_reference` STRING COMMENT 'Reference to the joint venture agreement document that governs this ownership interest and the relationship between multiple holders. Used to link to contract management systems and legal repositories.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tenement holder record was last modified in the system. Used for audit trail, change tracking, and data quality monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context about this ownership interest, such as special conditions, disputes, pending legal matters, or historical context. Used for operational reference and audit trail.',
    `notification_acknowledgement_date` DATE COMMENT 'Date on which the mining registrar acknowledged receipt and acceptance of the ownership change notification. Used to confirm regulatory compliance and avoid penalties for late notification.',
    `notification_lodged_date` DATE COMMENT 'Date on which notification of this ownership change was lodged with the mining registrar or regulatory authority. Required for compliance with mining legislation that mandates timely notification of ownership transfers.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether this holder is the designated operator of the tenement. True if this party manages day-to-day operations and regulatory compliance; False if non-operator (passive investor). Only one holder per tenement should be operator at any given time.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage interest held by this party in the tenement, expressed as a decimal (e.g., 45.50 for 45.5%). Used for royalty calculations, cost allocation, and regulatory reporting. Must sum to 100.00 across all holders for a given tenement and effective period.',
    `reference_number` STRING COMMENT 'External business identifier for this holder record, often used in regulatory filings, joint venture agreements, and mining registrar notifications. May be a registration number or transaction reference.',
    `registration_date` DATE COMMENT 'Date on which this ownership interest was formally registered with the mining registrar. May differ from effective_date if there is a lag between transaction completion and official registration.',
    `registration_status` STRING COMMENT 'Current status of this ownership interest with the mining registrar. Registered indicates formal acceptance; Pending indicates lodged but not yet approved; Lodged indicates submitted for processing; Rejected indicates application denied; Cancelled indicates ownership revoked; Transferred indicates interest moved to another party.. Valid values are `registered|pending|lodged|rejected|cancelled|transferred`',
    `royalty_obligation_flag` BOOLEAN COMMENT 'Indicates whether this holder has a royalty obligation attached to their interest. True if holder must pay royalties on production; False if no royalty applies. Used for revenue forecasting and financial modeling.',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate of royalty payable on production or revenue from this tenement interest. Expressed as a decimal (e.g., 2.50 for 2.5%). Null if no royalty applies. Confidential commercial term.',
    `stamp_duty_amount` DECIMAL(18,2) COMMENT 'Amount of stamp duty or transfer tax paid on this ownership transfer. Used for financial reporting and tax reconciliation. Null if no stamp duty applies or not yet paid.',
    `stamp_duty_paid_flag` BOOLEAN COMMENT 'Indicates whether stamp duty or transfer tax has been paid on this ownership transfer. True if paid; False if not yet paid or not applicable. Required for registration in many jurisdictions.',
    `transaction_reference` STRING COMMENT 'Reference to the source transaction document or system record that created this ownership change. May be a contract number, transfer deed reference, or internal transaction identifier. Used for audit trail and reconciliation.',
    `transaction_type` STRING COMMENT 'Type of transaction that created or modified this ownership interest. Initial Grant for original tenement award; Transfer for sale/purchase; Farm-In for earning interest through expenditure; Farm-Out for divesting interest; Dilution for reduced percentage due to other parties earning in; Acquisition for corporate takeover; Divestment for sale; Merger for corporate combination; Relinquishment for voluntary surrender. [ENUM-REF-CANDIDATE: initial_grant|transfer|farm_in|farm_out|dilution|acquisition|divestment|merger|relinquishment — 9 candidates stripped; promote to reference product]',
    `transfer_deed_reference` STRING COMMENT 'Reference number of the transfer deed or instrument that legally transferred this ownership interest. Required for mining registrar lodgement and audit trail. Null if this is an initial grant rather than a transfer.',
    CONSTRAINT pk_holder PRIMARY KEY(`holder_id`)
) COMMENT 'Association entity recording the legal ownership structure of each tenement at any point in time, supporting temporal queries on historical and current interests. Captures joint venture participant identity, percentage interest held, operator/non-operator designation, effective date, end date, registration status with the mining registrar, and source transaction reference (transfer, farm-in, dilution). Supports multi-party JV management, interest reconciliation, regulatory notifications of ownership changes, and annual return lodgement to the mining registrar. SSOT for who owns what percentage of which tenement at any given date.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`relinquishment` (
    `relinquishment_id` BIGINT COMMENT 'Unique identifier for the tenement relinquishment event. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Tenement relinquishments trigger asset write-offs and cost adjustments in assigned cost centres. Required for impairment assessment, budget revision, and ensuring accurate cost centre performance repo',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Relinquishments require an accountable employee for project management, regulatory liaison, documentation preparation, and approval workflows. Real business process: relinquishment planning and regula',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement from which area is being relinquished.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority formally approved the relinquishment.',
    `approving_authority` STRING COMMENT 'Name of the government department or regulatory body that approved the relinquishment (e.g., Department of Mines, Industry Regulation and Safety).',
    `area_relinquished_hectares` DECIMAL(18,2) COMMENT 'The total area surrendered in this relinquishment event, measured in hectares.',
    `coordinate_system` STRING COMMENT 'The spatial reference system or coordinate system used to define the relinquished area boundaries (e.g., GDA2020, WGS84, MGA Zone 50).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this relinquishment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `environmental_condition_status` STRING COMMENT 'Status of environmental conditions and rehabilitation obligations for the relinquished area at the time of surrender.. Valid values are `compliant|rehabilitation_required|monitoring_ongoing|cleared`',
    `expenditure_commitment_impact` STRING COMMENT 'Describes the impact of the relinquishment on ongoing expenditure commitments for the remaining tenement area.. Valid values are `reduced|eliminated|unchanged|recalculated`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The estimated or actual financial impact of the relinquishment, including write-offs, rehabilitation costs, or savings.',
    `gis_boundary_file_reference` STRING COMMENT 'Reference to the GIS spatial data file or layer that defines the precise geographic boundaries of the relinquished area.',
    `heritage_clearance_flag` BOOLEAN COMMENT 'Indicates whether cultural heritage clearance was required and obtained for the relinquished area prior to surrender.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this relinquishment record was most recently modified or updated.',
    `lodgement_date` DATE COMMENT 'The date on which the relinquishment application or notice was lodged with the regulatory authority.',
    `native_title_clearance_flag` BOOLEAN COMMENT 'Indicates whether native title clearance or consultation was required and obtained prior to relinquishment approval.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to the relinquishment event, including any special conditions or follow-up actions.',
    `notification_sent_date` DATE COMMENT 'The date on which formal notification of the relinquishment was sent to relevant stakeholders, including regulatory authorities and affected parties.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage of the original tenement area that is being relinquished, calculated as (area_relinquished / original_tenement_area) * 100.',
    `public_notice_flag` BOOLEAN COMMENT 'Indicates whether a public notice of the relinquishment was required and published as per regulatory requirements.',
    `reason_code` STRING COMMENT 'Standardized code indicating the primary business or regulatory reason for the relinquishment. [ENUM-REF-CANDIDATE: statutory_obligation|exploration_complete|uneconomic|strategic_focus|environmental_constraint|native_title_issue|access_limitation|resource_depletion|cost_reduction|portfolio_rationalization — promote to reference product]. Valid values are `statutory_obligation|exploration_complete|uneconomic|strategic_focus|environmental_constraint|native_title_issue`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the business rationale and circumstances leading to the relinquishment decision.',
    `reference_number` STRING COMMENT 'External reference number or identifier assigned by the regulatory authority for this relinquishment event.',
    `regulatory_approval_reference` STRING COMMENT 'Official reference number or document identifier issued by the regulatory authority confirming approval of the relinquishment.',
    `rehabilitation_completion_date` DATE COMMENT 'The date on which rehabilitation activities for the relinquished area were completed and certified, if applicable.',
    `relinquishment_date` DATE COMMENT 'The effective date on which the relinquished area was formally surrendered back to the Crown or regulatory authority.',
    `relinquishment_status` STRING COMMENT 'Current lifecycle status of the relinquishment event in the regulatory approval workflow.. Valid values are `pending|approved|rejected|withdrawn|completed`',
    `relinquishment_type` STRING COMMENT 'Classification of the relinquishment event indicating whether it is partial, full, voluntary, statutory obligation, or conditional.. Valid values are `partial|full|voluntary|statutory|conditional`',
    `remaining_area_hectares` DECIMAL(18,2) COMMENT 'The area of the tenement that remains under the companys control after this relinquishment, measured in hectares.',
    `statutory_obligation_flag` BOOLEAN COMMENT 'Indicates whether this relinquishment is mandated by statutory relinquishment obligations at renewal (True) or is a voluntary surrender (False).',
    CONSTRAINT pk_relinquishment PRIMARY KEY(`relinquishment_id`)
) COMMENT 'Records partial or full relinquishment events where the company voluntarily surrenders portions of a tenement area back to the Crown. Captures relinquishment date, area surrendered in hectares, relinquishment percentage, regulatory approval reference, reason code, and post-relinquishment remaining area. Mandatory for tenements with statutory relinquishment obligations at renewal.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`programme_of_work` (
    `programme_of_work_id` BIGINT COMMENT 'Unique identifier for the programme of work record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: PoW activities incur operational costs that must be allocated to cost centres for activity-based costing and AISC calculation. Required for unit cost reporting and operational cost variance analysis.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Mining POW approvals authorize disturbance activities within specific orebodies. Regulatory compliance and mine planning require tracking which approved work programs apply to which geological resourc',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Mining programmes of work (drilling, exploration, construction) require procurement of materials, equipment, and services. Real operations track which PO funded each programme for capital expenditure ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: POWs require an accountable employee (geologist, mine planner, environmental officer) for approval workflows, regulatory reporting, and competency verification. Real business process: POW submission a',
    `tenement_id` BIGINT COMMENT 'Reference to the tenement on which the programme of work is planned. Links to the tenement product.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Each PoW represents a discrete work program requiring project cost tracking via WBS structure. Enables capitalization decisions (opex vs capex), project cost control, and reconciliation between operat',
    `activity_type` STRING COMMENT 'The type of exploration or mining activity planned under this programme of work, such as drilling, land clearing, bulk sampling, road construction, trenching, or geophysical survey.. Valid values are `drilling|clearing|bulk_sampling|road_construction|trenching|geophysical_survey`',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'The actual total expenditure amount incurred during the execution of the programme of work activities, used for expenditure commitment evidence and regulatory audit trails.',
    `approval_conditions` STRING COMMENT 'Specific conditions, restrictions, or requirements imposed by the regulatory authority as part of the programme of work approval that must be adhered to during activity execution.',
    `approval_date` DATE COMMENT 'The date on which the programme of work was formally approved by the regulatory authority.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the programme of work submission in the regulatory approval process.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `close_out_date` DATE COMMENT 'The date on which the programme of work was formally closed out with the regulatory authority, including submission of completion reports and rehabilitation evidence.',
    `completion_date` DATE COMMENT 'The date on which all planned activities under the programme of work were completed on the ground.',
    `completion_status` STRING COMMENT 'Current status of the programme of work execution and close-out, indicating whether activities have commenced, are in progress, completed, or formally closed out with the regulator.. Valid values are `not_started|in_progress|completed|closed_out|partially_completed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this programme of work record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated expenditure amount (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `disturbance_area_hectares` DECIMAL(18,2) COMMENT 'The total area in hectares proposed to be disturbed by the planned activities under this programme of work.',
    `environmental_management_commitments` STRING COMMENT 'Detailed description of the environmental management measures, mitigation strategies, and commitments made as part of the programme of work submission to minimize environmental impact.',
    `estimated_expenditure_amount` DECIMAL(18,2) COMMENT 'The estimated total expenditure amount in the base currency for the planned activities under this programme of work.',
    `heritage_clearance_obtained_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the required heritage clearance has been obtained before programme of work approval for ground-disturbing activities. True if clearance obtained, False otherwise.',
    `heritage_clearance_reference` STRING COMMENT 'Reference number or identifier of the heritage clearance approval that is a prerequisite for this programme of work.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this programme of work record was last modified or updated in the system.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to the programme of work submission, approval, execution, or close-out.',
    `pow_reference_number` STRING COMMENT 'The externally-known reference number or identifier assigned by the regulatory authority or internal system for this programme of work submission.',
    `regulatory_authority` STRING COMMENT 'Name of the government department or regulatory body to which the programme of work was submitted and by which it was approved (e.g., Department of Mines, Industry Regulation and Safety).',
    `submission_date` DATE COMMENT 'The date on which the programme of work was submitted to the regulatory authority for approval.',
    `submission_type` STRING COMMENT 'Type of programme of work submission, indicating whether it is an initial submission, an amendment to an existing PoW, a renewal, or a variation.. Valid values are `initial|amendment|renewal|variation`',
    `validity_end_date` DATE COMMENT 'The date on which the approved programme of work expires and activities must be completed or a new submission made.',
    `validity_start_date` DATE COMMENT 'The date from which the approved programme of work becomes valid and activities may commence.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The variance between estimated and actual expenditure amounts, calculated as actual minus estimated expenditure.',
    CONSTRAINT pk_programme_of_work PRIMARY KEY(`programme_of_work_id`)
) COMMENT 'Records approved programmes of work (PoW), mining proposals, and activity notifications submitted to regulatory authorities for planned exploration or mining activities on a tenement. Captures PoW reference number, submission date, approval date, planned activity type (drilling, clearing, bulk sampling, road construction), proposed disturbance area in hectares, estimated expenditure, environmental management commitments, approval conditions, validity period, and completion/close-out status. Prerequisite: heritage_clearance must be obtained before PoW approval for ground-disturbing activities. Required before commencing any ground-disturbing activity under mining regulations (e.g., WA Mining Act 1978 s.20). Supports expenditure commitment evidence and regulatory audit trails.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` (
    `tenement_recovery_target_id` BIGINT COMMENT 'Primary key for tenement_recovery_target',
    `processing_recovery_target_id` BIGINT COMMENT 'Foreign key linking to the recovery target record in the LOM plan',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to the tenement that supplies ore to this recovery target',
    `assignment_status` STRING COMMENT 'Current status of this tenement-recovery target assignment: active (currently feeding), planned (future), suspended (temporarily halted), completed (historical)',
    `effective_from_date` DATE COMMENT 'Start date from which this tenement-recovery target linkage is effective in the LOM plan',
    `effective_to_date` DATE COMMENT 'End date until which this tenement-recovery target linkage is effective in the LOM plan',
    `ore_type` STRING COMMENT 'Classification of the ore type or metallurgical domain from this tenement that applies to this recovery target',
    `target_recovery_pct` DECIMAL(18,2) COMMENT 'Planned metallurgical recovery rate for ore from this specific tenement in this recovery target context, expressed as percentage of valuable mineral extracted',
    `target_throughput_tph` DECIMAL(18,2) COMMENT 'Planned processing throughput rate in dry metric tonnes per hour for ore sourced from this tenement',
    `tenement_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of the total recovery target throughput that is expected to come from this specific tenement',
    CONSTRAINT pk_tenement_recovery_target PRIMARY KEY(`tenement_recovery_target_id`)
) COMMENT 'This association product represents the planning linkage between recovery targets and the tenements that supply ore to those targets. It captures which tenements contribute ore to which recovery targets in the Life of Mine plan. Each record links one recovery target to one tenement with attributes that exist only in the context of this relationship, enabling tenement-specific recovery performance tracking and variance analysis.. Existence Justification: In mining operations, recovery targets are set at the processing circuit level and can receive ore from multiple tenements with different ore characteristics, while a single tenement can supply ore to multiple recovery targets (different circuits, time periods, or ore types). The business actively manages these linkages in Life of Mine planning to track which tenements feed which processing targets, with tenement-specific recovery rates and throughput allocations that vary by the tenement-target combination.';

CREATE OR REPLACE TABLE `mining_ecm`.`tenement`.`contract_allocation` (
    `contract_allocation_id` BIGINT COMMENT 'Unique system identifier for the tenement-contract allocation record. Primary key.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract being allocated',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to the tenement receiving the contract allocation',
    `allocated_by_user` STRING COMMENT 'Username or identifier of the person who created or last modified this allocation record. Supports audit trail and accountability.',
    `allocation_date` DATE COMMENT 'The date on which this allocation record was created or last modified in the system. Supports audit trail and change tracking.',
    `allocation_reason` STRING COMMENT 'Business justification or reason for allocating this contract to this tenement (e.g., Drilling services for exploration program, Equipment hire for site development, Shared infrastructure maintenance).',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the contract allocation. Active: allocation is currently in effect; Pending: allocation approved but not yet effective; Suspended: temporarily inactive; Terminated: manually ended before expiry; Expired: ended due to reaching effective_to_date or contract end.',
    `cost_centre_code` STRING COMMENT 'The financial cost centre code to which costs from this contract allocation should be charged for this tenement. Enables accurate financial reporting and cost tracking at the tenement level.',
    `effective_from_date` DATE COMMENT 'The date from which this contract allocation to the tenement becomes effective. Supports time-bound allocation changes as tenement activities evolve or contracts are reallocated.',
    `effective_to_date` DATE COMMENT 'The date on which this contract allocation to the tenement ceases to be effective. Nullable for current active allocations. Enables historical tracking of allocation changes over time.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage of the contract value or usage allocated to this specific tenement. Used for cost apportionment when a single contract serves multiple tenements. Sum of allocations across all tenements for a given contract should equal 100%.',
    CONSTRAINT pk_contract_allocation PRIMARY KEY(`contract_allocation_id`)
) COMMENT 'This association product represents the allocation of procurement contracts to mineral tenements for cost tracking and financial reporting. It captures the commercial relationship between a tenement and a contract, including allocation percentages, cost centre assignments, and time-bound effectiveness periods. Each record links one tenement to one contract with attributes that exist only in the context of this allocation relationship, enabling accurate cost attribution and contract compliance monitoring across the mining portfolio.. Existence Justification: In mining operations, a single procurement contract (e.g., drilling services, equipment hire, site services) is routinely allocated across multiple active tenements based on where the work is performed or resources are consumed. Conversely, each tenement draws from multiple contracts simultaneously (drilling, equipment, consumables, services). The business actively manages these allocations with specific percentages, cost centres, and time periods to ensure accurate cost attribution and financial reporting at the tenement level.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ADD CONSTRAINT `fk_tenement_boundary_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ADD CONSTRAINT `fk_tenement_renewal_obligation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ADD CONSTRAINT `fk_tenement_regulatory_condition_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ADD CONSTRAINT `fk_tenement_native_title_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_native_title_agreement_id` FOREIGN KEY (`native_title_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`native_title_agreement`(`native_title_agreement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_programme_of_work_id` FOREIGN KEY (`programme_of_work_id`) REFERENCES `mining_ecm`.`tenement`.`programme_of_work`(`programme_of_work_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`application` ADD CONSTRAINT `fk_tenement_application_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ADD CONSTRAINT `fk_tenement_transfer_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ADD CONSTRAINT `fk_tenement_transfer_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `mining_ecm`.`tenement`.`holder`(`holder_id`);
ALTER TABLE `mining_ecm`.`tenement`.`holder` ADD CONSTRAINT `fk_tenement_holder_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ADD CONSTRAINT `fk_tenement_programme_of_work_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ADD CONSTRAINT `fk_tenement_tenement_recovery_target_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ADD CONSTRAINT `fk_tenement_contract_allocation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`tenement` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `mining_ecm`.`tenement` SET TAGS ('dbx_domain' = 'tenement');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `annual_expenditure_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Expenditure Commitment');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `annual_expenditure_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Tenement Area (Hectares)');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `expenditure_currency` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `expenditure_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `granted_commodities` SET TAGS ('dbx_business_glossary_term' = 'Granted Commodities');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `heritage_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Status');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `heritage_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|cleared|survey_required|restricted_areas_identified|pending');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Tenement Holder Name');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `holder_percentage` SET TAGS ('dbx_business_glossary_term' = 'Holder Ownership Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `joint_venture_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Flag');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `licence_type` SET TAGS ('dbx_business_glossary_term' = 'Licence Type');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `licence_type` SET TAGS ('dbx_value_regex' = 'exploration_licence|mining_lease|prospecting_licence|retention_licence|miscellaneous_licence');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Tenement Lifecycle Status');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `native_title_status` SET TAGS ('dbx_business_glossary_term' = 'Native Title Status');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `native_title_status` SET TAGS ('dbx_value_regex' = 'not_applicable|determined|registered_claim|agreement_in_place|negotiation_required');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `next_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reporting Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tenement Notes');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate (Percent)');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'government|private|net_smelter_return|gross_revenue|profit_based');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `statutory_identifier` SET TAGS ('dbx_business_glossary_term' = 'Statutory Tenement Identifier');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Classification');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|non_core|divestment_candidate');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `surface_rights_status` SET TAGS ('dbx_business_glossary_term' = 'Surface Rights Status');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `surface_rights_status` SET TAGS ('dbx_value_regex' = 'owned|leased|access_agreement|negotiation_required|restricted');
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ALTER COLUMN `tenement_name` SET TAGS ('dbx_business_glossary_term' = 'Tenement Name');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `boundary_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Boundary Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Boundary Accuracy Class');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_value_regex' = 'survey_accurate|cadastral|digitized|approximate');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Boundary Amendment Reason');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `area_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Area Calculation Method');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `area_calculation_method` SET TAGS ('dbx_value_regex' = 'planar|geodesic|ellipsoidal|surveyed');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Area in Hectares');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `area_square_kilometers` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometers');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `boundary_status` SET TAGS ('dbx_business_glossary_term' = 'Boundary Status');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `boundary_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|superseded|withdrawn|current');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `coordinate_reference_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System (CRS)');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `environmental_overlay_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Overlay Flag');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `geometry_wkb` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Binary (WKB)');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `gis_layer_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Layer Name');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `heritage_area_overlap_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Area Overlap Flag');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `is_current_boundary` SET TAGS ('dbx_business_glossary_term' = 'Is Current Boundary Flag');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `map_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Map Sheet Reference');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `native_title_overlap_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Title Overlap Flag');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `perimeter_meters` SET TAGS ('dbx_business_glossary_term' = 'Perimeter in Meters');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `positional_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Positional Accuracy in Meters');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `survey_datum` SET TAGS ('dbx_business_glossary_term' = 'Survey Datum');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `survey_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Survey Plan Reference');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `surveyor_licence_number` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Licence Number');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `surveyor_licence_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `surveyor_licence_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Name');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Boundary Version Number');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `vertex_count` SET TAGS ('dbx_business_glossary_term' = 'Vertex Count');
ALTER TABLE `mining_ecm`.`tenement`.`boundary` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `expenditure_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `carry_forward_amount` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Amount');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `carry_forward_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Expiry Date');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `commitment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'statutory|voluntary|negotiated|reduced|suspended');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Expenditure Amount');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|at_risk|pending_review|exempted|carried_forward');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `exemption_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Granted Flag');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Category');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_value_regex' = 'exploration|development|mining|rehabilitation|administration|community');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `forfeiture_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Risk Flag');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `submission_due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Obligation Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `alert_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `area_relinquishment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Area Relinquishment Required Flag');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Status');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|remediation_required');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `expenditure_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Amount');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `expenditure_commitment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `expenditure_commitment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `heritage_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Required Flag');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `heritage_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Status');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `heritage_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|obtained|refused');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `lodgement_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Lodgement Deadline Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `lodgement_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Lodgement Submitted Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `native_title_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Title Clearance Required Flag');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `native_title_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Native Title Clearance Status');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `native_title_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|obtained|refused');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `new_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'New Expiry Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `relinquishment_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Area Hectares');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `relinquishment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_conditions` SET TAGS ('dbx_business_glossary_term' = 'Renewal Conditions');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Date');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_outcome` SET TAGS ('dbx_value_regex' = 'granted|refused|lapsed|withdrawn|pending');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_priority` SET TAGS ('dbx_business_glossary_term' = 'Renewal Priority');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|conditional|extension|variation');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `condition_title` SET TAGS ('dbx_business_glossary_term' = 'Condition Title');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `enforcement_action_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `granting_authority` SET TAGS ('dbx_business_glossary_term' = 'Granting Authority');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `last_compliance_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Outcome');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `last_compliance_review_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|not_reviewed');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `legislation_reference` SET TAGS ('dbx_business_glossary_term' = 'Legislation Reference');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue|not_applicable');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'extreme|high|medium|low|negligible');
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `native_title_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Native Title Agreement ID');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement ID');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Registration Number');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'ILUA|Heritage Agreement|Land Access Agreement|Compensation Agreement|Co-Management Agreement|Right to Negotiate Agreement');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = 'AUD|USD|CAD|ZAR');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'Monetary|In-Kind|Royalty|Employment|Mixed');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Under Review|Remediation Required');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `consultation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Consultation and Engagement Requirements');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `cultural_heritage_obligations` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Protection Obligations');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'Mediation|Arbitration|Traditional Law|Court|Mixed');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document Repository Path');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective From Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `employment_commitment` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Employment Commitment');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `environmental_obligations` SET TAGS ('dbx_business_glossary_term' = 'Environmental Management Obligations');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `geographic_coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Description');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `ilua_type` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Land Use Agreement (ILUA) Type');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `ilua_type` SET TAGS ('dbx_value_regex' = 'Area Agreement|Body Corporate Agreement|Alternative Procedure Agreement');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `land_access_rights` SET TAGS ('dbx_business_glossary_term' = 'Land Access Rights Granted');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `last_compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Name');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Registration Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms and Conditions');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Basis');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_value_regex' = 'Revenue|Production Volume|Net Profit|Gross Profit');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Amount');
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `heritage_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance ID');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `native_title_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Native Title Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `programme_of_work_id` SET TAGS ('dbx_business_glossary_term' = 'Programme of Work (POW) ID');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement ID');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Clearance Area (Hectares)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiry Date');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Outcome');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_outcome` SET TAGS ('dbx_value_regex' = 'no_sites_identified|sites_identified_avoided|sites_identified_salvaged|sites_identified_restricted|clearance_denied');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Status');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|cleared_with_restrictions|refused|expired|under_review');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `clearance_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Valid From Date');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `conditions_and_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Clearance Conditions and Restrictions');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `heritage_site_register_numbers` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Register Numbers');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Heritage Monitoring Required');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Notes');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `regulatory_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Authority');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `restricted_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Restricted Zone Description');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `restricted_zone_spatial_reference` SET TAGS ('dbx_business_glossary_term' = 'Restricted Zone Spatial Reference');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `salvage_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Salvage Completion Date');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `salvage_required` SET TAGS ('dbx_business_glossary_term' = 'Archaeological Salvage Required');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Date');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_cost_aud` SET TAGS ('dbx_business_glossary_term' = 'Survey Cost (AUD)');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_cost_aud` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Heritage Survey Date');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_report_document_path` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Document Path');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Heritage Survey Type');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'aboriginal_heritage_survey|historical_heritage_assessment|archaeological_salvage|ethnographic_survey|combined_heritage_survey|desktop_assessment');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `surveying_authority` SET TAGS ('dbx_business_glossary_term' = 'Surveying Authority or Consultant');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `surveyor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Contact Email');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `surveyor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `surveyor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `surveyor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Contact Phone');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `surveyor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `traditional_owner_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Consent Obtained');
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ALTER COLUMN `traditional_owner_group` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Group');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `surface_right_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `agreement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document Reference');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `agreement_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `area_description` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Area Description');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Area in Hectares');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Payment Frequency');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_value_regex' = 'one-time|annual|quarterly|monthly|other');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Grantor Contact Email Address');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Contact Name');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Grantor Contact Phone Number');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_type` SET TAGS ('dbx_business_glossary_term' = 'Grantor Type');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `grantor_type` SET TAGS ('dbx_value_regex' = 'private|government|indigenous|corporate|trust|other');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `heritage_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Flag');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `native_title_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Title Clearance Flag');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Notes');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Purpose');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `registered_authority` SET TAGS ('dbx_business_glossary_term' = 'Registered Authority');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Use Restrictions');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `right_number` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Number');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `right_type` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Type');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `surface_right_status` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Status');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `surface_right_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|suspended|draft');
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ALTER COLUMN `term_years` SET TAGS ('dbx_business_glossary_term' = 'Term in Years');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` SET TAGS ('dbx_subdomain' = 'financial_settlements');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `royalty_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Method');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'production_based|sales_based|cash_basis|shipment_based');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Name');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Number');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Status');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|under_review|disputed');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `applicable_commodity` SET TAGS ('dbx_business_glossary_term' = 'Applicable Commodity');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `assignment_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Assignment Restrictions');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Royalty Audit Rights');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Basis');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'ad_valorem|specific|profit_based|nsr|gross_revenue|production_volume');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Royalty Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `deduction_allowances` SET TAGS ('dbx_business_glossary_term' = 'Royalty Deduction Allowances');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|expert_determination|negotiation');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Effective End Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Effective Start Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Royalty Escalation Clause');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `ifrs_classification` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Classification');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `ifrs_classification` SET TAGS ('dbx_value_regex' = 'operating_expense|revenue_deduction|financial_liability|contingent_consideration');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `maximum_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Royalty Payment Amount');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `minimum_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Royalty Payment Amount');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Notes');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Frequency');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|per_shipment|on_demand');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Royalty Reporting Obligation');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `royalty_formula` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Formula');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'government|private|net_smelter_return|gross_revenue|profit_based|production_based');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `security_interest` SET TAGS ('dbx_business_glossary_term' = 'Security Interest Description');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ALTER COLUMN `termination_conditions` SET TAGS ('dbx_business_glossary_term' = 'Termination Conditions');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` SET TAGS ('dbx_subdomain' = 'financial_settlements');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `royalty_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Royalty Payment Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `commodity_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `finance_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Finance General Ledger (GL) Account Code');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Amount');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Payee Account Reference');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'government|private_landowner|native_title_holder|joint_venture_partner|other');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `production_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production Period End Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `production_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Period Start Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `production_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Production Tonnage');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `production_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Value Amount');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `production_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance_identified|under_review');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `regulatory_return_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Reference');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Basis');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_value_regex' = 'revenue|profit|tonnage|fixed_fee');
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`application` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Application Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Granted Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Lifecycle Status');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Tenement Application Type');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'exploration_licence|mining_lease|retention_lease|prospecting_licence|mineral_claim|assessment_lease');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Application Area in Hectares');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `conditions_of_grant` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Grant Description');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Application Decision Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `environmental_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Required Indicator');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Status');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|refused');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `expenditure_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment Amount');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `expenditure_commitment_currency` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Tenement Grant Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `hearing_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Objection Hearing Scheduled Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `heritage_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Required Indicator');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `heritage_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Status');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `heritage_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|obtained|refused');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction or Region');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Application Lodgement Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `mineral_sought` SET TAGS ('dbx_business_glossary_term' = 'Target Mineral or Commodity');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `native_title_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Title Clearance Required Indicator');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `native_title_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Native Title Clearance Status');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `native_title_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|obtained|refused');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objection_grounds` SET TAGS ('dbx_business_glossary_term' = 'Objection Grounds Description');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objection_lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Objection Lodgement Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objection_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Objection Received Indicator');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objection_resolution` SET TAGS ('dbx_business_glossary_term' = 'Objection Resolution Outcome');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objection_resolution` SET TAGS ('dbx_value_regex' = 'upheld|dismissed|settled|withdrawn|pending');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objection_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Objection Resolution Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objector_name` SET TAGS ('dbx_business_glossary_term' = 'Objector Party Name');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `objector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Application Final Outcome');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'granted|refused|withdrawn|lapsed|converted');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `refusal_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Refusal Reason');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `mining_ecm`.`tenement`.`application` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawal Reason');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Transfer Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Transferee Party Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transfer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Transferor Party Identifier (ID)');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Transferor Holder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `agreement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agreement Document Reference');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `agreement_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `contingent_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingent Payment Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `environmental_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `expenditure_commitment_transferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Transferred Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `heritage_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `interest_percentage_transferred` SET TAGS ('dbx_business_glossary_term' = 'Interest Percentage Transferred');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `native_title_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Native Title Consent Date');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `native_title_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Title Consent Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `royalty_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `security_bond_transferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Bond Transferred Flag');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'full_assignment|partial_assignment|change_of_control|merger|divestment|joint_venture_entry');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transferee_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Transferee Legal Name');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transferee_legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`transfer` ALTER COLUMN `transferor_retained_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Transferor Retained Interest Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`holder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tenement`.`holder` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Holder Identifier');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Party Identifier');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `annual_return_lodgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Return Lodgement Flag');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `beneficial_owner_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Disclosed Flag');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount for Transfer');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `contributing_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Contributing Interest Flag');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `dilution_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Dilution Trigger Event Description');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Effective Date');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership End Date');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `free_carried_percentage` SET TAGS ('dbx_business_glossary_term' = 'Free Carried Percentage Interest');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `free_carried_until_date` SET TAGS ('dbx_business_glossary_term' = 'Free Carried Until Date');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `joint_venture_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Agreement Reference');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Holder Record Notes');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `notification_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Acknowledgement Date');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `notification_lodged_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Lodged Date');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Designation Flag');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage Interest');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Holder Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Mining Registrar Registration Date');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status with Mining Registrar');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending|lodged|rejected|cancelled|transferred');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `royalty_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Flag');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `stamp_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Stamp Duty Amount Paid');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `stamp_duty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `stamp_duty_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Stamp Duty Paid Flag');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Reference');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transaction Type');
ALTER TABLE `mining_ecm`.`tenement`.`holder` ALTER COLUMN `transfer_deed_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Deed Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` SET TAGS ('dbx_subdomain' = 'lifecycle_management');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `relinquishment_id` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment ID');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement ID');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `area_relinquished_hectares` SET TAGS ('dbx_business_glossary_term' = 'Area Relinquished (Hectares)');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `environmental_condition_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Status');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `environmental_condition_status` SET TAGS ('dbx_value_regex' = 'compliant|rehabilitation_required|monitoring_ongoing|cleared');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `expenditure_commitment_impact` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Impact');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `expenditure_commitment_impact` SET TAGS ('dbx_value_regex' = 'reduced|eliminated|unchanged|recalculated');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `gis_boundary_file_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Boundary File Reference');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `heritage_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Flag');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Lodgement Date');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `native_title_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Native Title Clearance Flag');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `public_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Flag');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'statutory_obligation|exploration_complete|uneconomic|strategic_focus|environmental_constraint|native_title_issue');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `rehabilitation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Completion Date');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `relinquishment_date` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Date');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `relinquishment_status` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Status');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `relinquishment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn|completed');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `relinquishment_type` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Type');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `relinquishment_type` SET TAGS ('dbx_value_regex' = 'partial|full|voluntary|statutory|conditional');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `remaining_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Remaining Area (Hectares)');
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ALTER COLUMN `statutory_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Obligation Flag');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `programme_of_work_id` SET TAGS ('dbx_business_glossary_term' = 'Programme of Work (PoW) ID');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement ID');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Planned Activity Type');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'drilling|clearing|bulk_sampling|road_construction|trenching|geophysical_survey');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `close_out_date` SET TAGS ('dbx_business_glossary_term' = 'Close-Out Date');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed_out|partially_completed');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `disturbance_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Proposed Disturbance Area (Hectares)');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `environmental_management_commitments` SET TAGS ('dbx_business_glossary_term' = 'Environmental Management Commitments');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `estimated_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Expenditure Amount');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `heritage_clearance_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Obtained Flag');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `heritage_clearance_reference` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Reference');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `pow_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Programme of Work (PoW) Reference Number');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|amendment|renewal|variation');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Period End Date');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Start Date');
ALTER TABLE `mining_ecm`.`tenement`.`programme_of_work` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Variance Amount');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` SET TAGS ('dbx_subdomain' = 'financial_settlements');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` SET TAGS ('dbx_association_edges' = 'processing.recovery_target,tenement.tenement');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `tenement_recovery_target_id` SET TAGS ('dbx_business_glossary_term' = 'tenement_recovery_target Identifier');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `processing_recovery_target_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Recovery Target - Recovery Target Id');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Recovery Target - Tenement Id');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `ore_type` SET TAGS ('dbx_business_glossary_term' = 'Ore Type');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `target_recovery_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Recovery Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `target_throughput_tph` SET TAGS ('dbx_business_glossary_term' = 'Target Throughput Rate');
ALTER TABLE `mining_ecm`.`tenement`.`tenement_recovery_target` ALTER COLUMN `tenement_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Tenement Contribution Percentage');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` SET TAGS ('dbx_subdomain' = 'financial_settlements');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` SET TAGS ('dbx_association_edges' = 'tenement.tenement,procurement.contract');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `contract_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Contract Allocation ID');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Contract Allocation - Procurement Contract Id');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Contract Allocation - Tenement Id');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `allocated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Allocated By User');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `allocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reason');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective From Date');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective To Date');
ALTER TABLE `mining_ecm`.`tenement`.`contract_allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Contract Allocation Percentage');
