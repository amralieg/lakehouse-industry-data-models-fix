-- Schema for Domain: site | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`site` COMMENT 'Owns daily site execution data including daily logs, production tracking, work fronts, crew assignments, site logistics, mobilization/demobilization, concrete pours, earthworks volumes, and field progress measurements. Integrates with HCSS HeavyJob for cost coding and production tracking and Procore for daily logs and field management. Supports earned value computation feeding the project domain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`site`.`work_front` (
    `work_front_id` BIGINT COMMENT 'Unique surrogate identifier for the work front record. Primary key for the work_front master entity in the site domain.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: BIM models define the 3D spatial scope and constructability of each work front. Clash detection reports and 4D scheduling link BIM models to work fronts. bim_model_reference is a plain-text denormal',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Work front planning and daily productivity reporting require knowing which crew is assigned to each work front. Project engineers use this link for crew productivity analysis, work front scheduling, a',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Work fronts are governed by specific construction drawings defining scope, limits, and method. Site engineers use this link for IFC drawing control, ensuring the correct revision is active before work',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost allocation reports require each work front to reference the central cost code for budgeting and variance analysis.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: The HSE plan governs all safety requirements for a work front including PTW requirements, SWMS obligations, and induction standards. Site supervisors reference the applicable HSE plan when establishin',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Design packages (IFC packages) define the scope of work issued to a work front. Document control and earned value reporting require tracing which design package governs each work front to confirm all ',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Each work front is assigned a primary contract party (sub‑contractor or client) for responsibility, invoicing and performance tracking.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Work fronts in environmentally or regulatorily sensitive zones require a specific compliance permit before work commences. Site engineers and compliance officers use this link to verify permit coverag',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Work fronts are executed within project phases. work_front.current_phase is a denormalized plain-text field. Linking to phase enables phase-level work front reporting, mobilization planning per phase,',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project under which this work front is executed. Enables roll-up of work front data to project-level reporting and earned value computation.',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Work fronts are tied to contractual milestones (e.g., Front 3 concrete complete triggers payment milestone). Linking work_front to project_milestone enables milestone-driven work front management, L',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: REQUIRED: Work Front material requisition process creates a purchase requisition per front for tracking material needs; experts expect a direct FK.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: HSE plans and project safety management require a risk assessment to be completed and approved before each work front is activated. Construction HSE managers link risk assessments to work fronts for p',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A work front belongs to a single construction site; adding work_front.site_id creates the required parent relationship and eliminates site isolation.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Work fronts are executed under specific subcontract contracts; linking enables schedule, cost and risk integration.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: A SWMS must be in place before any work front commences — this is a mandatory HSE gate in construction. work_front.swms_reference is a denormalized text reference to the SWMS record; replacing it with',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Each work front executes work governed by a technical specification (e.g., concrete placement spec, earthworks compaction spec). Quality ITPs and hold points on a work front are defined by the governi',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element that governs the scope of work executed at this work front. Aligns spatial execution with the project schedule hierarchy.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Work fronts are physically mapped to schedule WBS nodes for 3-week lookahead planning and earned value reporting. Construction schedulers assign work fronts to WBS nodes to track production against th',
    `access_restriction` STRING COMMENT 'The access control classification for this work front. permit_required indicates a Permit to Work (PTW) is mandatory before entry; restricted_zone limits access to authorised personnel; exclusion_zone prohibits all non-essential access. Supports HSE compliance.. Valid values are `unrestricted|permit_required|restricted_zone|exclusion_zone`',
    `actual_crew_size` STRING COMMENT 'The actual number of direct labour workers present at this work front on the most recent reporting day. Compared against planned_crew_size to identify under-manning and productivity risks.',
    `actual_production_qty` DECIMAL(18,2) COMMENT 'Cumulative actual production quantity achieved at this work front to date, expressed in the production_unit. Sourced from HCSS HeavyJob production tracking and field measurements. Used to compute earned value.',
    `actual_start_date` DATE COMMENT 'The actual date on which work commenced at this work front. Compared against planned_start_date to compute schedule variance. Sourced from Procore daily logs or HCSS HeavyJob time tracking.',
    `area_sqm` DECIMAL(18,2) COMMENT 'Total plan area of the work front in square metres. Used as the principal quantitative measure of the resource for production rate calculations, crew density planning, and progress measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this work front record was first created in the system. Provides the audit trail creation marker for data lineage and compliance purposes.',
    `demobilization_date` DATE COMMENT 'The date on which all resources were demobilized from this work front and active work ceased. Null if the work front is still active. Used to calculate work front duration and close out cost codes.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Reference elevation of the work front above mean sea level in metres. Critical for earthworks volume calculations, drainage design, and structural level control.',
    `environmental_sensitivity` STRING COMMENT 'Classification of the environmental sensitivity of the work front location. sensitive and protected areas require additional environmental controls and monitoring per ISO 14001 and EPA requirements. remediation_required indicates contaminated ground conditions.. Valid values are `standard|sensitive|protected|remediation_required`',
    `forecast_finish_date` DATE COMMENT 'Current forecast date for completion of all work at this work front, updated based on actual progress and remaining work. Supports look-ahead scheduling and early warning of delays.',
    `front_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the work front within the project or site. Used in daily logs, production reports, and cost coding in HCSS HeavyJob and Procore.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `front_name` STRING COMMENT 'Human-readable descriptive name of the work front (e.g., Zone A – Pile Cap Excavation, North Abutment Face). Used in daily logs, progress reports, and field management interfaces.',
    `front_status` STRING COMMENT 'Current lifecycle status of the work front. mobilizing indicates resources are being deployed; active indicates concurrent work is in progress; suspended indicates a temporary hold; demobilized indicates resources have been withdrawn; completed indicates all planned work is finished.. Valid values are `active|inactive|mobilizing|demobilized|suspended|completed`',
    `front_type` STRING COMMENT 'Classification of the spatial unit represented by this work front. Distinguishes between zone (broad area), area (defined boundary), face (excavation or structural face), sector, corridor, level (floor/elevation), or bay. [ENUM-REF-CANDIDATE: zone|area|face|sector|corridor|level|bay — promote to reference product if additional types are required]',
    `grid_reference` STRING COMMENT 'Site-specific grid reference or chainage notation (e.g., Grid E5-F6, CH 1+200 to CH 1+450) used in engineering drawings and BIM models to locate the work front. Complements GPS coordinates for internal site navigation.',
    `heavyjob_cost_center` STRING COMMENT 'The cost center identifier in HCSS HeavyJob associated with this work front. Used for field-level cost allocation, equipment hour tracking, and production rate reporting.',
    `hse_risk_level` STRING COMMENT 'The assessed HSE risk level for this work front based on the activities being performed, proximity to hazards, and environmental conditions. Drives frequency of safety inspections and toolbox meetings (TBM) requirements.. Valid values are `low|medium|high|critical`',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this work front contains activities on the project critical path as determined by the CPM schedule in Oracle Primavera P6. Critical path work fronts receive priority resource allocation and daily progress monitoring.',
    `is_subcontracted` BOOLEAN COMMENT 'Indicates whether the work at this work front is executed by a subcontractor rather than the general contractors own workforce. Drives subcontractor management workflows and contract administration processes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this work front record was most recently modified. Used for incremental data loading in the Databricks Silver Layer and audit trail maintenance.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the work front centroid or reference point in decimal degrees (WGS84). Enables spatial aggregation and GIS-based reporting of production and progress data.',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the work front centroid or reference point in decimal degrees (WGS84). Used alongside latitude for spatial mapping and IoT sensor integration.',
    `mobilization_date` DATE COMMENT 'The date on which resources (crew, equipment, materials) were first mobilized to this work front and active work commenced. Marks the start of the work front lifecycle for scheduling and cost tracking.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current physical percent complete of all planned work at this work front, expressed as a value between 0.00 and 100.00. Sourced from field progress measurements and used as input to earned value computation in the project domain.',
    `planned_crew_size` STRING COMMENT 'The planned number of direct labour workers assigned to this work front per shift as defined in the resource-loaded schedule. Used for crew density analysis and productivity benchmarking.',
    `planned_finish_date` DATE COMMENT 'Baseline-scheduled finish date for all work activities at this work front as defined in the project schedule. Used for schedule performance index (SPI) calculation and look-ahead planning.',
    `planned_production_qty` DECIMAL(18,2) COMMENT 'Total planned production quantity for this work front expressed in the production_unit. Derived from the Bill of Quantities (BOQ) and used as the budget quantity for earned value computation.',
    `planned_start_date` DATE COMMENT 'Baseline-scheduled start date for work activities at this work front as defined in the project schedule (Oracle Primavera P6). Used for schedule variance analysis and earned value computation.',
    `procore_location_reference` STRING COMMENT 'The location identifier assigned to this work front in the Procore construction management system. Used to link daily logs, RFIs, submittals, and change orders to the correct spatial location.',
    `production_unit` STRING COMMENT 'The primary unit of measure used to track production output at this work front (e.g., m3 for earthworks, LM for piling, m2 for formwork, tonnes for steel erection). Aligns with the Bill of Quantities (BOQ) unit for earned value computation.',
    `shift_pattern` STRING COMMENT 'The shift working pattern applied at this work front. Determines daily productive hours available for scheduling and cost rate calculations.. Valid values are `single|double|rotating|night_only|continuous`',
    `weather_sensitivity` STRING COMMENT 'Classification of how sensitive the work activities at this work front are to adverse weather conditions. high sensitivity work fronts (e.g., concrete pours, earthworks) require weather monitoring and contingency planning.. Valid values are `low|medium|high`',
    `zone_classification` STRING COMMENT 'Discipline-based classification of the work front zone indicating the primary trade or engineering discipline active at this location. Supports resource planning and subcontractor assignment. [ENUM-REF-CANDIDATE: civil|structural|mep|architectural|earthworks|piling|finishing|commissioning — promote to reference product]',
    CONSTRAINT pk_work_front PRIMARY KEY(`work_front_id`)
) COMMENT 'Master record for each active work front (zone, area, or face) on a construction site where concurrent work activities are executed. Tracks work front identity, location coordinates (GPS/grid reference), zone classification, active/inactive status, assigned foreman, mobilization date, demobilization date, current phase, associated WBS element, and parent site reference. Serves as the primary spatial and organizational anchor for all site-level transactional records — every operational product in this domain holds a mandatory or optional FK to work_front. The work_front-centric topology enables spatial aggregation of production, cost, progress, and resource data by zone.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`daily_log` (
    `daily_log_id` BIGINT COMMENT 'Unique surrogate identifier for the daily site log record. Primary key for the daily_log data product in the Databricks Silver Layer.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Daily Log records activities performed each day; linking to schedule.activity enables daily progress reports and variance analysis.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Daily logs are billed to the governing contract; linking enables cost allocation and compliance reporting per agreement.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Daily Log reports reference the specific design drawing used for the days work; required for progress audit and compliance.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Daily logs must reference the active permit governing that days work to satisfy HSE audit trails and permit compliance verification.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project this daily log belongs to. Links the site log to the master project record for earned value and cost control reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A daily log is recorded for a specific construction site. Adding site_id to daily_log provides a direct FK to the site master record, enabling site-level aggregation of daily logs without requiring a ',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Daily logs are filed against WBS nodes for schedule performance reporting and earned value measurement. Construction project controls teams aggregate daily log data by WBS node for weekly schedule upd',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the daily log was formally approved by the project manager or designated reviewer. Marks the transition from submitted to approved status in the log lifecycle.',
    `concrete_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of concrete poured on site for the log date in cubic metres. Critical production metric for structural progress tracking, QA/QC compliance (ITP), and earned value computation. Sourced from Procore and HCSS HeavyJob.',
    `cost_code` STRING COMMENT 'HCSS HeavyJob cost code assigned to the primary work activity recorded in this daily log. Enables direct integration between field production data and job costing in Viewpoint Vista and SAP S/4HANA Project Systems.',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether any event recorded in this daily log has been flagged as having a potential cost impact requiring a Change Order (CO) or variation claim. True triggers cost impact assessment and contract administration workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this daily log record was first created in the system. Audit trail timestamp for data lineage and Silver Layer ingestion tracking.',
    `direct_labour_count` STRING COMMENT 'Number of direct (GC-employed) workers on site for the log date, excluding subcontractor personnel. Used for workforce planning, payroll reconciliation, and labour productivity benchmarking.',
    `earthworks_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of earthworks (cut, fill, or excavation) completed on site for the log date in cubic metres. Key production quantity for earned value computation, BOQ progress measurement, and HCSS HeavyJob production tracking.',
    `eot_impact_flag` BOOLEAN COMMENT 'Indicates whether any event recorded in this daily log has been flagged as having a potential Extension of Time (EOT) impact on the project programme. True initiates EOT substantiation documentation under FIDIC Clause 8.4 or applicable contract conditions.',
    `equipment_count` STRING COMMENT 'Total number of major equipment units (plant and machinery) present and operational on site for the log date. Used for equipment utilisation tracking, cost coding in HCSS HeavyJob, and mobilisation/demobilisation records.',
    `event_count` STRING COMMENT 'Total number of embedded line-item events (delay events, weather stoppages, utility strikes, design holds, access restrictions, safety observations) recorded within this daily log header. Supports event density analytics and claim complexity assessment.',
    `has_delay_event` BOOLEAN COMMENT 'Indicates whether one or more delay events were recorded in the embedded line-item events for this daily log. True triggers downstream delay analysis workflows and EOT claim tracking. Key filter for delay analytics.',
    `has_safety_observation` BOOLEAN COMMENT 'Indicates whether one or more HSE safety observations or incidents were recorded in the embedded line-item events for this daily log. True triggers integration with Intelex HSE management for incident reporting and corrective action workflows.',
    `hcss_log_reference` STRING COMMENT 'Reference identifier linking this daily log to the corresponding field operations record in HCSS HeavyJob. Supports production tracking reconciliation and cost code validation between Procore and HCSS.',
    `log_date` DATE COMMENT 'The calendar date for which this daily site log records field activities. The principal business event date — one log per project site per calendar day. Drives schedule performance and delay analysis.',
    `log_number` STRING COMMENT 'Externally-known sequential log number assigned by the construction management system (Procore) for this daily log. Used as the human-readable business identifier in correspondence, delay claims, and EOT substantiation. Format: DL-{ProjectCode}-{Year}-{Sequence}.. Valid values are `^DL-[A-Z0-9]+-[0-9]{4}-[0-9]{5}$`',
    `log_status` STRING COMMENT 'Current workflow state of the daily log record. Draft indicates in-progress field entry; submitted indicates superintendent sign-off pending review; approved indicates accepted by project management; rejected indicates returned for correction; void indicates cancelled/superseded entry.. Valid values are `draft|submitted|approved|rejected|void`',
    `lti_occurred_flag` BOOLEAN COMMENT 'Indicates whether a Lost Time Injury (LTI) occurred on site on this log date. True triggers mandatory incident reporting to Intelex HSE system, regulatory notification under OSHA, and TRIR (Total Recordable Incident Rate) calculation update.',
    `ncr_raised_flag` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report (NCR) was raised on this log date. True triggers integration with the QA/QC management workflow and requires corrective action documentation per ISO 9001.',
    `overall_site_status` STRING COMMENT 'High-level classification of site productivity for the log date. Productive indicates full operations; partially_productive indicates reduced output due to delays or restrictions; non_productive indicates no billable work performed; shutdown indicates planned or emergency site closure.. Valid values are `productive|partially_productive|non_productive|shutdown`',
    `permit_to_work_count` STRING COMMENT 'Number of active Permits to Work (PTW) issued and in force on site for the log date. Supports HSE compliance monitoring, Intelex PTW tracking, and regulatory audit evidence for high-risk work activities.',
    `planned_activities_narrative` STRING COMMENT 'Free-text description of the construction activities that were planned for the log date per the project schedule. Compared against work_performed_narrative to identify schedule variances and support look-ahead planning.',
    `precipitation_mm` DECIMAL(18,2) COMMENT 'Total rainfall or precipitation recorded at the site in millimetres for the log date. Key metric for weather delay claims, earthworks productivity assessment, and EOT substantiation under FIDIC Clause 8.4.',
    `procore_log_reference` STRING COMMENT 'Source system identifier for this daily log record in the Procore Construction Management platform. Enables traceability and reconciliation between the Silver Layer data product and the operational system of record.',
    `remarks` STRING COMMENT 'Additional free-text remarks or notes entered by the superintendent for items not captured in structured fields or the work performed narrative. Provides supplementary context for project management review and legal record completeness.',
    `shift_type` STRING COMMENT 'Type of work shift recorded in this daily log. Distinguishes day, night, double-shift, or split-shift operations. Relevant for overtime cost tracking, HSE fatigue management, and productivity benchmarking.. Valid values are `day|night|double_shift|split`',
    `site_access_status` STRING COMMENT 'Operational access status of the construction site for the log date. Closed or restricted access directly impacts productivity and supports delay claim documentation. Partial indicates some work fronts accessible.. Valid values are `open|restricted|closed|partial`',
    `subcontractor_count` STRING COMMENT 'Number of subcontractor personnel on site for the log date. Supports subcontractor performance monitoring, site coordination, and contract administration.',
    `superintendent_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the site superintendent formally signed off and submitted the daily log. Establishes the legal record timestamp for the site activity log. Critical for delay claim and EOT substantiation timelines.',
    `tbm_conducted_flag` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted on site for the log date. Mandatory HSE compliance indicator. True confirms daily safety briefing was held per SWMS (Safe Work Method Statement) requirements.',
    `temperature_high_c` DECIMAL(18,2) COMMENT 'Highest recorded ambient temperature at the site in degrees Celsius for the log date. Used for concrete pour suitability assessment, HSE heat stress monitoring, and weather delay substantiation.',
    `temperature_low_c` DECIMAL(18,2) COMMENT 'Lowest recorded ambient temperature at the site in degrees Celsius for the log date. Used for cold weather concreting assessment, frost protection requirements, and weather delay substantiation.',
    `total_delay_duration_hrs` DECIMAL(18,2) COMMENT 'Aggregate duration in hours of all delay events recorded in the embedded line-item events for this daily log. Used for schedule impact quantification, EOT claim substantiation, and SPI (Schedule Performance Index) computation.',
    `total_manpower_count` STRING COMMENT 'Total number of workers (all trades combined) present on site for the log date. Includes direct labour and subcontractor personnel. Key input for productivity analysis, earned value computation, and labour cost reconciliation against HCSS HeavyJob cost codes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this daily log record was last modified. Supports incremental data loading in the Databricks Silver Layer and audit trail for record changes.',
    `visitor_count` STRING COMMENT 'Number of authorised visitors (client representatives, inspectors, auditors, regulatory officials) on site for the log date. Supports site access management, HSE induction compliance, and client engagement tracking.',
    `weather_condition` STRING COMMENT 'Observed general weather condition at the site for the log date. Used to substantiate weather-related delay claims, EOT applications, and force majeure events under FIDIC contract provisions. [ENUM-REF-CANDIDATE: clear|partly_cloudy|overcast|rain|heavy_rain|snow|fog|storm|extreme_heat — promote to reference product]',
    `wind_speed_kmh` DECIMAL(18,2) COMMENT 'Recorded wind speed at the site in kilometres per hour for the log date. Used to assess crane and elevated work restrictions, HSE compliance, and weather-related work stoppages.',
    `work_performed_narrative` STRING COMMENT 'Free-text superintendent narrative describing all construction activities performed on site during the log date. Serves as the primary operational record and legal evidence base for progress claims, delay substantiation, and EOT applications. Sourced from Procore Daily Logs.',
    CONSTRAINT pk_daily_log PRIMARY KEY(`daily_log_id`)
) COMMENT 'Official daily site log (header + line-item structure) capturing all field activities for a given project site and date. The header records weather conditions (temperature, precipitation, wind), site access status, manpower headcount by trade, equipment on site, work performed narrative, superintendent sign-off, and overall site status. Embedded line-item events capture each notable occurrence including delay events, weather stoppages, utility strikes, design holds, access restrictions, and safety observations — each with event type, start/end time, duration, affected work fronts, root cause classification, responsible party, and EOT/cost impact flags. This is the SSOT for all site event data — no separate event entity exists. Sourced from Procore Daily Logs module. Serves as the legal and operational record of site activity and the primary evidence base for delay claims and EOT substantiation.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`production_entry` (
    `production_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each granular production tracking record in the silver layer lakehouse. Primary key for the production_entry data product.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity (Work Breakdown Structure task) against which production quantities are being reported. Sourced from Oracle Primavera P6 activity planning module.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Production reports require linking installed quantities to the specific equipment used for cost allocation and utilization analysis.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this production entry is recorded. Links production quantities to the project domain for earned value computation.',
    `cost_code_id` BIGINT COMMENT 'Reference to the cost code used to classify and track the financial dimension of this production entry. Sourced from HCSS HeavyJob cost coding module and aligned with SAP S/4HANA job costing.',
    `crew_id` BIGINT COMMENT 'Reference to the crew or gang assigned to execute the production work for this entry. Links to workforce domain for labor cost and productivity analysis.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: production_entry contains a daily_log_reference string that points to a daily log; adding a proper FK (daily_log_id) normalizes the model and eliminates the redundant column.',
    `estimate_line_id` BIGINT COMMENT 'Foreign key linking to bid.estimate_line. Business justification: Production entries record actual quantities and unit costs. Linking to estimate_line enables actual-vs-estimate variance analysis at the line-item level — a core construction cost control and earned-v',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to material.goods_issue. Business justification: Material consumption reconciliation: production_entry records installed quantities; goods_issue records materials issued for that installation. Linking them enables EVM cost-at-completion analysis and',
    `hours_id` BIGINT COMMENT 'Foreign key linking to equipment.hours. Business justification: Production entries record equipment hours consumed per activity. These must reconcile against the authoritative equipment hours log for earned value and cost-per-unit reporting. Construction cost engi',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: Production entries (installed quantities, labor/equipment hours) are the source records that generate job cost transactions in construction cost ledgers (HCSS HeavyJob, JD Edwards). Cost engineers use',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Production tracking against approved material catalog: installed quantities must reference the approved material catalog item for specification compliance, cost-code alignment, and QA/ITP traceability',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Production entries consume materials tied to specific purchase orders, enabling material cost verification on site.',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to site.shift_report. Business justification: Production entries are granular records of work completed during a shift. Linking production_entry to shift_report enables shift-level aggregation of production quantities and supports reconciliation ',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Production entries track installed quantities against technical specifications to ensure quality and contractual compliance.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Production entries are posted against WBS nodes for earned value measurement (BCWP calculation). Construction controls engineers require this link to compute schedule performance index (SPI) and cost ',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone on site where production was executed. Enables spatial breakdown of production progress across the site.',
    `approved_by` STRING COMMENT 'Name or identifier of the site engineer, superintendent, or project manager who approved this production entry. Required for audit trail and progress billing authorization.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry was formally approved by the authorized reviewer. Marks the transition from submitted to approved status and triggers downstream earned value and billing computations.',
    `budgeted_production_rate` DECIMAL(18,2) COMMENT 'The planned or budgeted production rate for this activity and cost code expressed as units per labor-hour. Sourced from the project estimate and HCSS HeavyJob budget. Used to compute production efficiency variance against actual production_rate.',
    `budgeted_quantity` DECIMAL(18,2) COMMENT 'The total budgeted or planned quantity for this activity and cost code as established in the project budget and BOQ (Bill of Quantities). Used as the denominator for percent complete calculation and EVM (Earned Value Management) analysis.',
    `change_order_reference` STRING COMMENT 'Reference number of the approved Change Order (CO) that authorized a scope or quantity revision reflected in this production entry. Links production tracking to contract administration for cost and schedule impact analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry record was first created in the source system (HCSS HeavyJob). Serves as the audit trail creation marker for data lineage and compliance purposes.',
    `crew_size` STRING COMMENT 'The number of workers (headcount) assigned to this production activity on the entry date. Used for labor productivity analysis, crew efficiency benchmarking, and workforce planning.',
    `cumulative_quantity` DECIMAL(18,2) COMMENT 'The total quantity of work installed to date for this activity and cost code, inclusive of the current entry. Represents the running total used for percent complete and progress billing milestone verification.',
    `entry_date` DATE COMMENT 'The calendar date on which the production quantities were recorded. Represents the actual field execution date, not the data entry date. Core dimension for daily progress reporting and schedule performance analysis.',
    `entry_number` STRING COMMENT 'Externally-known alphanumeric identifier for this production entry as assigned by the source system (HCSS HeavyJob). Used for cross-system traceability and field reference. Format: PE-[YYYYMMDD]-[SEQ].',
    `entry_status` STRING COMMENT 'Current workflow lifecycle state of the production entry record. Drives approval routing and determines whether quantities are included in earned value and progress billing computations.. Valid values are `draft|submitted|approved|rejected|voided`',
    `equipment_hours` DECIMAL(18,2) COMMENT 'Total equipment operating hours consumed on this production activity for the entry date. Aggregated across all equipment units deployed. Used for equipment cost allocation, utilization analysis, and maintenance scheduling.',
    `installed_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of work physically installed or completed during the entry date for this activity and cost code. This is the primary production measurement used to compute earned value and progress billing. Expressed in the unit of measure defined by unit_of_measure.',
    `is_baseline_revision` BOOLEAN COMMENT 'Indicates whether this production entry reflects a revision to the baseline budgeted quantity due to an approved Change Order (CO) or scope change. When true, the budgeted_quantity reflects the revised baseline.',
    `is_rework` BOOLEAN COMMENT 'Indicates whether this production entry represents rework (corrective re-execution of previously completed work) rather than new production. Rework quantities are tracked separately for quality cost analysis and NCR (Non-Conformance Report) linkage.',
    `itp_reference` STRING COMMENT 'Reference to the Inspection and Test Plan (ITP) checkpoint associated with this production entry. Confirms that quality hold points or witness points have been satisfied before production quantities are accepted for earned value credit.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended by the crew on this production activity for the entry date. Includes all direct labor hours charged to this cost code. Used as the denominator for production rate calculation and labor cost analysis.',
    `ncr_reference` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) associated with this production entry when is_rework is true. Enables traceability between rework production and quality non-conformances for QA/QC reporting.',
    `percent_complete` DECIMAL(18,2) COMMENT 'The percentage of the total budgeted quantity that has been physically installed as of this entry date, calculated as (cumulative_quantity / budgeted_quantity) × 100. Feeds schedule performance index (SPI) and earned value computation in the project domain.',
    `production_rate` DECIMAL(18,2) COMMENT 'The measured production rate for this entry expressed as units of work completed per labor-hour (e.g., CY/hr, LF/hr). Calculated from installed_quantity divided by total labor hours. Used for productivity benchmarking, crew efficiency analysis, and future bid estimation.',
    `production_type` STRING COMMENT 'Classification of the type of construction production activity being tracked. Enables domain-specific productivity benchmarking and reporting across earthworks, concrete, structural, MEP (Mechanical Electrical and Plumbing), and other work categories. [ENUM-REF-CANDIDATE: earthworks|concrete|structural_steel|paving|MEP|formwork|rebar|masonry|finishing|demolition|other — promote to reference product]',
    `remarks` STRING COMMENT 'Free-text field for field supervisors or engineers to record contextual notes about the production entry, including reasons for production variances, site conditions, delays, or other relevant observations not captured in structured fields.',
    `shift_type` STRING COMMENT 'The work shift during which this production was executed. Enables shift-based productivity analysis and supports overtime cost tracking and labor compliance reporting.. Valid values are `day|night|swing|overtime`',
    `source_record_reference` STRING COMMENT 'The native primary key or record identifier of this production entry in the originating source system (e.g., HCSS HeavyJob internal ID). Enables reverse traceability from the lakehouse silver layer back to the operational system of record.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this production entry was sourced. Supports data lineage tracking and multi-system reconciliation in the silver layer lakehouse.. Valid values are `HCSS_HeavyJob|Procore|Manual|SAP_S4HANA`',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry was submitted for approval by the field team. Used for workflow SLA tracking and audit trail.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Recorded ambient temperature in degrees Celsius at the work front on the entry date. Used to assess weather-related productivity impacts, validate concrete pour conditions per ACI standards, and support EOT (Extension of Time) claims.',
    `unit_of_measure` STRING COMMENT 'The unit of measure applicable to the installed_quantity and budgeted_quantity fields (e.g., CY for cubic yards, LF for linear feet, SF for square feet, EA for each, TON, M3, M2). Sourced from the BOQ (Bill of Quantities) and HCSS HeavyJob. [ENUM-REF-CANDIDATE: CY|LF|SF|EA|TON|M3|M2|LM|KG|HR — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry record was last modified. Tracks revisions to production quantities, status changes, or corrections. Used for data lineage and change audit trail.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition on site during the production entry date. Recorded to support analysis of weather impacts on productivity, substantiate Extension of Time (EOT) claims, and validate production rate variances. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|snow|fog|extreme_heat|wind — 8 candidates stripped; promote to reference product]',
    `work_front_location` STRING COMMENT 'Descriptive location identifier for the work front or zone where production was executed (e.g., Zone A — Grid 1-5, Pier 3 Foundation, Runway 2 Subbase). Supports spatial analysis and site logistics planning.',
    `work_item_description` STRING COMMENT 'Human-readable description of the specific work item or scope of work being tracked in this production entry (e.g., Concrete pour — Column Grid A1-A5, Earthworks cut — Zone 3). Sourced from BOQ (Bill of Quantities) or activity description.',
    CONSTRAINT pk_production_entry PRIMARY KEY(`production_entry_id`)
) COMMENT 'Granular production tracking record capturing quantities of work completed per activity, cost code, and work front for a specific date. Sourced from HCSS HeavyJob production tracking module. Stores installed quantity, unit of measure, production rate (units/hour), budgeted quantity, percent complete, crew size, equipment hours consumed, and cost code. Feeds earned value computation and progress billing in the project and finance domains.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`crew_deployment` (
    `crew_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for each daily crew deployment record. Primary key for the crew_deployment data product in the site domain Silver layer.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity (Work Breakdown Structure task) from Oracle Primavera P6 to which this crew is assigned. Enables schedule performance tracking and earned value computation.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Crew deployment plans include equipment assigned to each crew; needed for resource planning and equipment utilisation tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this crew deployment is recorded. Links deployment records to project-level earned value and cost control.',
    `crew_id` BIGINT COMMENT 'FK to workforce.crew',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: crew_deployment records reference a daily log via the string field daily_log_reference; converting to a proper FK (daily_log_id) enforces referential integrity and removes the redundant string column.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Crew deployment cost tracking uses finance cost codes to aggregate labor costs per activity for payroll and project costing.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Lead foreman accountability is a core construction site management requirement — HSE toolbox meetings, permit-to-work sign-offs, and productivity records are tied to the named foreman. lead_foreman_na',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Crew cannot legally be deployed to a work area without a valid PTW — this is a regulatory and contractual requirement. crew_deployment.permit_to_work_number is a denormalized text reference; a proper ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Subcontractor labor PO management: subcontracted crew deployments (is_subcontractor_crew=true) are governed by labor-hire purchase orders. Linking deployment to PO enables invoice validation, cost acc',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to site.shift_report. Business justification: Crew deployments are shift-level records capturing crew assignments for a specific shift. Linking crew_deployment to shift_report enables the shift report to aggregate all crew deployments for that sh',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Before crew deployment, the SWMS must be acknowledged by all crew members — this is a mandatory pre-work safety requirement in construction. crew_deployment.swms_reference is a denormalized text refer',
    `toolbox_meeting_id` BIGINT COMMENT 'Foreign key linking to safety.toolbox_meeting. Business justification: A toolbox meeting is conducted at the start of each crew deployment shift. Linking crew_deployment to the specific toolbox_meeting record provides an audit trail of which TBM covered which crew deploy',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Crew deployments are executed under trade packages. Linking enables trade-package-level labour cost tracking and productivity benchmarking against bid labour assumptions — essential for subcontract pe',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Subcontractor vendor performance management: crew deployments from subcontractor vendors must be linked to the vendor record for HSE performance tracking, KPI reporting, and vendor evaluation. Constru',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Crew deployments are tracked against WBS nodes for labor cost and schedule performance reporting. Construction project controls teams allocate labor hours to WBS nodes for earned value and resource-lo',
    `work_front_id` BIGINT COMMENT 'Mandatory reference to the work front (spatial zone or work face) to which this crew is deployed. Establishes the spatial allocation of the crew on site for the given date.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total man-hours actually worked by the crew on this deployment date, as recorded in HCSS HeavyJob time tracking. Compared against planned_hours to compute productivity variance and feed EVM calculations.',
    `actual_production_qty` DECIMAL(18,2) COMMENT 'Actual quantity of work output achieved by the crew on this deployment date, as recorded in HCSS HeavyJob production tracking. Compared against planned_production_qty for productivity analysis and earned value computation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this crew deployment record was first created in the data platform. Audit trail field for data governance and lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crew_size` STRING COMMENT 'Total number of workers (headcount) in the deployed crew or gang for this date. Used for productivity analysis, labour cost coding, and HSE compliance checks.',
    `crew_type` STRING COMMENT 'Classification of the crew by trade discipline. Drives resource planning, productivity benchmarking, and cost code allocation. [ENUM-REF-CANDIDATE: civil|mep|concrete|steel_erection|earthworks|finishing|specialist|formwork|rebar|waterproofing — promote to reference product]',
    `delay_reason_code` STRING COMMENT 'Standardised code identifying the primary reason for any production delay or underperformance on this deployment (e.g., WEATHER, MATERIAL_SHORTAGE, EQUIPMENT_BREAKDOWN, DESIGN_CHANGE, PERMIT_DELAY). Supports delay analysis and EOT claims. [ENUM-REF-CANDIDATE: WEATHER|MATERIAL_SHORTAGE|EQUIPMENT_BREAKDOWN|DESIGN_CHANGE|PERMIT_DELAY|LABOUR_SHORTAGE|REWORK|SAFETY_STOP — promote to reference product]',
    `deployment_date` DATE COMMENT 'Calendar date on which the crew is deployed to the work front. The principal business event date for this daily deployment record. Format: yyyy-MM-dd.',
    `deployment_number` STRING COMMENT 'Externally-known business identifier for this crew deployment record, typically generated by HCSS HeavyJob (e.g., CD-2024-00123). Used for cross-system referencing and field reporting.',
    `deployment_status` STRING COMMENT 'Current lifecycle state of the crew deployment record. Tracks whether the deployment is planned, actively in progress, completed, cancelled, or suspended due to site conditions.. Valid values are `planned|active|completed|cancelled|suspended`',
    `hse_toolbox_meeting_held` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted with this crew prior to commencing work on this deployment date (True) or not (False). Mandatory HSE compliance check per OSHA and ISO 45001 requirements.',
    `is_overtime` BOOLEAN COMMENT 'Indicates whether this crew deployment involved overtime work (True) or was a standard shift (False). Sourced from HCSS HeavyJob. Used for payroll flagging and cost escalation alerts.',
    `is_subcontractor_crew` BOOLEAN COMMENT 'Indicates whether this crew is supplied by a subcontractor (True) or is part of the general contractors direct workforce (False). Drives cost segregation between self-performed and subcontracted labour.',
    `is_weather_impacted` BOOLEAN COMMENT 'Indicates whether adverse weather conditions materially impacted crew productivity or caused a work stoppage on this deployment date (True) or not (False). Supports Extension of Time (EOT) and delay claim substantiation.',
    `mobilization_status` STRING COMMENT 'Indicates the mobilization lifecycle stage of the crew relative to the project site. Tracks whether the crew is in the process of mobilizing, fully on site, demobilizing, or has fully demobilized. Supports site logistics planning.. Valid values are `mobilizing|on_site|demobilizing|demobilized`',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked by the crew beyond the standard shift duration on this deployment date. Sourced from HCSS HeavyJob payroll records. Feeds Viewpoint Vista payroll and job costing.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Total man-hours planned for this crew deployment on the given date, as scheduled in Oracle Primavera P6. Used as the baseline for earned value computation and productivity variance analysis.',
    `planned_production_qty` DECIMAL(18,2) COMMENT 'Target quantity of work output planned for this crew deployment (e.g., cubic metres of concrete, linear metres of pipe, tonnes of steel). Defined in HCSS HeavyJob production tracking against the cost code.',
    `ppe_compliance` BOOLEAN COMMENT 'Indicates whether all crew members were observed to be wearing required Personal Protective Equipment (PPE) at the start of this deployment (True) or a non-compliance was recorded (False). Sourced from Procore or Intelex field inspection.',
    `production_unit_of_measure` STRING COMMENT 'Unit of measure for the planned and actual production quantities (e.g., m3, LM, tonne, m2, EA). Sourced from the HCSS HeavyJob cost code definition and aligned with the Bill of Quantities (BOQ).',
    `productivity_notes` STRING COMMENT 'Free-text field capturing foreman or site supervisor observations about crew productivity, constraints, delays, or notable events during this deployment. Sourced from HCSS HeavyJob or Procore daily log narrative.',
    `productivity_rate` DECIMAL(18,2) COMMENT 'Actual production output per man-hour achieved by this crew on this deployment date (actual_production_qty / actual_hours). Sourced from HCSS HeavyJob production tracking. Used for benchmarking and Schedule Performance Index (SPI) analysis.',
    `shift_end_time` TIMESTAMP COMMENT 'Actual date and time the crew shift ended on site. Sourced from HCSS HeavyJob time tracking. Used in conjunction with shift_start_time to compute actual hours worked. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_start_time` TIMESTAMP COMMENT 'Actual date and time the crew shift commenced on site. Sourced from HCSS HeavyJob time tracking. Used for hours calculation, overtime determination, and HSE compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_type` STRING COMMENT 'Classification of the work shift for this deployment (day, night, swing, or weekend). Drives overtime calculations, HSE fatigue management, and payroll processing.. Valid values are `day|night|swing|weekend`',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating source system (HCSS HeavyJob or Procore) for this crew deployment entry. Enables reverse traceability from the Silver layer back to the operational system of record.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this crew deployment record was sourced (HCSS HeavyJob, Procore, or Manual entry). Supports data lineage and audit traceability in the Silver layer.. Valid values are `HCSS_HeavyJob|Procore|Manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this crew deployment record was last modified in the data platform. Supports incremental data processing, audit trails, and change detection in the Silver layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition recorded on site for this deployment date, as captured in the Procore daily log. Impacts productivity analysis, delay claims, and Extension of Time (EOT) documentation. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|wind|fog|snow|extreme_heat — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_crew_deployment PRIMARY KEY(`crew_deployment_id`)
) COMMENT 'Daily assignment record linking a named crew or gang to a specific work front, activity, and cost code for a given date. Captures crew type (civil, MEP, concrete, steel erection), crew size, lead foreman, shift start/end times, overtime flag, productivity notes, and planned vs actual hours. Sourced from HCSS HeavyJob time tracking. Holds mandatory FK to work_front for spatial allocation. Distinct from workforce domain employee records — this entity tracks the operational deployment of crews to site activities, not individual labor records.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`field_progress` (
    `field_progress_id` BIGINT COMMENT 'Unique surrogate identifier for each field progress measurement record in the silver layer lakehouse. Primary key for the field_progress data product.',
    `bid_boq_line_id` BIGINT COMMENT 'Reference to the BOQ line item from the contract or estimate against which installed quantities are measured. Enables reconciliation of field-installed quantities against contracted scope.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Field progress is tracked against BIM elements for 4D progress reporting and digital twin updates. bim_element_reference is a plain-text denormalization; this FK enables structured BIM-based progres',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project under which this field progress measurement is captured. Enables project-level aggregation of earned value and progress reporting.',
    `cost_code_id` BIGINT COMMENT 'Reference to the HCSS HeavyJob cost code associated with this progress measurement. Enables cost-to-progress reconciliation and production rate analysis by cost code.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Field progress measurements are taken against specific construction drawings (e.g., as-built vs IFC drawing). Payment certification and quantity surveying require linking measured quantities to the go',
    `itp_line_id` BIGINT COMMENT 'Reference to the ITP (Inspection and Test Plan) checkpoint that must be satisfied before this progress measurement can be approved. Ensures QA/QC hold points are cleared prior to progress being recognised in EVM.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Field progress is reported against design packages for earned value (BCWP) calculation and milestone payment claims. Project controls teams require this link to reconcile installed quantities against ',
    `daily_log_id` BIGINT COMMENT 'The source system identifier of the Procore daily log entry from which this field progress measurement was derived or linked. Enables traceability back to the originating daily log record in Procore for audit and reconciliation purposes.',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Field progress measurements (BCWP, budget_at_completion) must reference the schedule baseline against which they are measured for earned value management reporting. Construction project controls engin',
    `activity_id` BIGINT COMMENT 'Reference to the WBS activity or schedule activity in Oracle Primavera P6 against which this field progress measurement is recorded. Links field measurement to the schedule domain for EVM computation.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: field_progress currently has a `work_front` STRING column that stores a text description of the work front location. This should be normalized to a proper FK work_front_id referencing site.work_front.',
    `activity_type` STRING COMMENT 'The construction discipline or work type category of the WBS activity being measured (e.g., earthworks, concrete, structural steel, MEP). Enables discipline-level progress aggregation and resource productivity benchmarking. [ENUM-REF-CANDIDATE: earthworks|concrete|structural_steel|mep|civil|finishing|commissioning|piling|roofing|other — promote to reference product]',
    `approval_status` STRING COMMENT 'Current workflow state of the field progress measurement record. Controls whether the measurement is eligible to feed EVM (Earned Value Management) calculations in the project domain. Draft and rejected records are excluded from BCWP computation.. Valid values are `draft|submitted|approved|rejected|revised`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the field progress measurement was formally approved by the designated approver. Marks the record as eligible for inclusion in EVM calculations. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approver_name` STRING COMMENT 'Full name of the supervisor, project engineer, or quantity surveyor who reviewed and approved the field progress measurement. Required for audit trail and QA/QC compliance.',
    `bcwp` DECIMAL(18,2) COMMENT 'The Budgeted Cost of Work Performed (BCWP), also known as Earned Value, computed as reported_percent_complete multiplied by the budget at completion for the activity. Expressed in project currency. Feeds CPI and SPI calculations in the project domain EVM module.',
    `budget_at_completion` DECIMAL(18,2) COMMENT 'The total approved budget allocated to the WBS activity or BOQ line item as of this measurement date. Used as the basis for BCWP computation. Classified as confidential as it contains project financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this field progress measurement record was first created in the system. Audit trail timestamp for data lineage and silver layer ingestion tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crew_size` STRING COMMENT 'The number of workers deployed on the work front for the activity during the measurement period. Used to compute production rates per worker and benchmark crew productivity against planned norms in HCSS HeavyJob.',
    `data_date` DATE COMMENT 'The official schedule data date or progress cut-off date as defined in Oracle Primavera P6 for the reporting period in which this measurement falls. Aligns field measurements with the schedule baseline for SPI computation.',
    `equipment_hours` DECIMAL(18,2) COMMENT 'Total equipment operating hours logged against this activity during the measurement period. Sourced from HCSS HeavyJob equipment hour tracking. Used for equipment productivity analysis and cost-to-progress reconciliation.',
    `field_engineer_name` STRING COMMENT 'Full name of the field engineer or site engineer who physically performed and recorded the progress measurement. Provides accountability and traceability for the measurement. Classified as confidential PII as it identifies an individual employee.',
    `installed_quantity` DECIMAL(18,2) COMMENT 'The cumulative physical quantity of work installed or completed as measured in the field at the time of this measurement (e.g., cubic metres of concrete poured, linear metres of pipe installed, tonnes of steel erected). Reconciles against the BOQ planned quantity.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether the WBS activity is on the Critical Path Method (CPM) schedule critical path (True) or has float (False). Critical path activities require priority attention as delays directly impact project completion date.',
    `is_milestone` BOOLEAN COMMENT 'Indicates whether the WBS activity associated with this progress measurement is a contract or schedule milestone (True) or a regular work activity (False). Milestone completion triggers contractual notifications and potential payment events.',
    `measurement_date` DATE COMMENT 'The calendar date on which the physical field progress measurement was taken by the field engineer or surveyor. This is the principal real-world event date used for EVM period calculations and schedule reconciliation.',
    `measurement_method` STRING COMMENT 'The technique used to determine the percent complete or installed quantity in the field. Drives confidence weighting in EVM calculations. [ENUM-REF-CANDIDATE: visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps|engineering_estimate — promote to reference product if additional methods are added]. Valid values are `visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps`',
    `measurement_notes` STRING COMMENT 'Free-text field for the field engineer to record observations, constraints, or qualifications relevant to the progress measurement (e.g., partial pour due to rain, access restriction, rework in progress). Supports contextual interpretation of progress data.',
    `measurement_number` STRING COMMENT 'Externally-known unique business identifier for this progress measurement record, typically formatted as a sequential reference number (e.g., FPM-2024-00123) used in Procore daily logs and field management reports.',
    `measurement_period_type` STRING COMMENT 'The reporting frequency or period type for this progress measurement (e.g., daily, weekly, monthly). Determines how the measurement aligns with project reporting cycles and EVM period cut-offs in Oracle Primavera P6.. Valid values are `daily|weekly|fortnightly|monthly`',
    `ncr_reference` STRING COMMENT 'Reference number of any active Non-Conformance Report (NCR) associated with the work being measured. If an NCR is open, the progress measurement may be withheld from EVM until the NCR is closed and rework is verified.',
    `period_installed_quantity` DECIMAL(18,2) COMMENT 'The incremental quantity of work physically installed during the current measurement period only (not cumulative). Used for production rate tracking and period-over-period productivity analysis in HCSS HeavyJob.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The total planned or budgeted quantity for the WBS activity or BOQ line item as per the approved schedule and BOQ. Used as the denominator for quantity-based percent complete calculations and production rate analysis.',
    `previous_percent_complete` DECIMAL(18,2) COMMENT 'The cumulative percent complete recorded in the immediately preceding measurement period for the same WBS activity or BOQ line item. Used to compute the incremental progress delta and validate that progress is monotonically increasing.',
    `progress_delta` DECIMAL(18,2) COMMENT 'The incremental percent complete gained in this measurement period, calculated as reported_percent_complete minus previous_percent_complete. Represents the period productivity for the activity and is used in period-based EVM reporting.',
    `quantity_unit_of_measure` STRING COMMENT 'The unit of measure applicable to the installed_quantity field (e.g., m3 for concrete, lm for linear metres of pipe, tonne for structural steel). Must align with the BOQ line item unit of measure. [ENUM-REF-CANDIDATE: m3|m2|lm|tonne|kg|nr|ls|hr|m — 9 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when a field progress measurement is rejected (approval_status = rejected). Documents the basis for rejection to guide the field engineer in correcting and resubmitting the measurement.',
    `reported_percent_complete` DECIMAL(18,2) COMMENT 'The cumulative percent complete for the WBS activity or BOQ line item as physically measured and reported by the field engineer at the time of this measurement. Expressed as a percentage (0.00–100.00). This is the ground-truth value used to compute BCWP in EVM.',
    `revision_number` STRING COMMENT 'Sequential revision counter for this field progress measurement record. Increments each time the measurement is revised and resubmitted after rejection. Enables version tracking and audit trail of measurement history.',
    `source_system` STRING COMMENT 'The operational system of record from which this field progress measurement was originated or ingested into the Databricks silver layer (e.g., Procore, HCSS HeavyJob, Oracle Primavera P6, manual entry). Supports data lineage and reconciliation.. Valid values are `procore|hcss_heavyjob|primavera_p6|manual|bim360`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time at which the field engineer submitted the progress measurement record for review and approval. Used to track measurement reporting timeliness and workflow cycle time.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this field progress measurement record was last modified. Supports incremental data loading in the Databricks lakehouse silver layer and audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition on site at the time of the field progress measurement. Used to contextualise productivity rates and support EOT (Extension of Time) claims where adverse weather impacted progress. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|storm|snow|fog|extreme_heat — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_field_progress PRIMARY KEY(`field_progress_id`)
) COMMENT 'Periodic field progress measurement record capturing percent complete and installed quantities for a WBS activity or BOQ line item as physically measured in the field. Stores measurement date, measurement method (visual estimate, quantity survey, milestone completion, 3D scan comparison), reported percent complete, previous percent complete, incremental progress delta, field engineer name, and approval status. Feeds EVM (Earned Value Management) calculations including BCWP, CPI, and SPI in the project domain. Provides the ground-truth measurement that reconciles against schedule domain planned progress.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`site_mobilization` (
    `site_mobilization_id` BIGINT COMMENT 'Unique surrogate identifier for the site mobilization record. Primary key for the site_mobilization data product in the Databricks Silver Layer.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Mobilization Cost & Schedule reports are generated per client account; linking site_mobilization to client.account enables billing and performance tracking.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this site mobilization is authorized. Ties mobilization activities to the governing contractual instrument.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Site mobilization records which equipment is moved to the site; essential for mobilization cost accounting and asset location management.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Site mobilization authorization in construction requires a named client contact (project manager, owners representative) who approves NTP, site access, and mobilization sign-off. This FK enables mobi',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project for which this site mobilization record is created. Links site mobilization lifecycle to the overarching project entity.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Site mobilization is triggered by and must satisfy a specific contract milestone (NTP milestone, mobilization completion milestone). Linking enables milestone-driven mobilization tracking, advance pay',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Site mobilization is contingent on EIA approval — a named regulatory prerequisite in construction. Project managers and compliance teams track which approved EIA authorises each mobilization event. No',
    `equipment_mobilization_id` BIGINT COMMENT 'Foreign key linking to equipment.equipment_mobilization. Business justification: Site mobilization events trigger equipment mobilization events. Linking them enables coordinated mobilization scheduling, transport cost tracking, and NTP compliance reporting. Construction project ma',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: An approved HSE plan is a contractual and regulatory prerequisite before site mobilization can proceed. site_mobilization.hse_plan_approval_date confirms this relationship exists operationally; a prop',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: Site mobilization costs (site establishment, temporary utilities, offices, fencing) are posted as job cost transactions under the mobilization cost category. The site_mobilization.cost_actual value ma',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Site mobilization is contingent on a mobilization permit; linking tracks permit approval status against mobilization schedule.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Site mobilization events are tied to specific project phases (Phase 1 mobilization, Phase 2 mobilization). Phase-level mobilization tracking is required for gate review approval, budget release author',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: Site Mobilization QA Gate: A quality plan must be approved before site mobilization proceeds. Project QA managers verify the governing quality plan is in place as a mobilization prerequisite — a stand',
    `activity_id` BIGINT COMMENT 'Activity identifier from Oracle Primavera P6 corresponding to the mobilization WBS activity. Enables direct traceability between this mobilization record and the project schedule baseline.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Mobilization is a distinct budget line item in construction project budgets. The site_mobilization.cost_budget references the authorized project budget allocation for mobilization expenditure. Constru',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Mobilization cost tracking: site mobilization activities (temporary facilities, site setup) are procured via purchase orders. Linking mobilization records to the governing PO enables cost-at-completio',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Pre-mobilization risk assessment is a standard construction HSE requirement — the site-level risk assessment must be completed and approved before mobilization commences. This link supports mobilizati',
    `site_id` BIGINT COMMENT 'FK to site.site',
    `submission_id` BIGINT COMMENT 'Foreign key linking to bid.bid_submission. Business justification: Mobilization plans are executed only after a bid is awarded; linking to the winning bid_submission enables cost tracking and audit of mobilization against the awarded contract.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Site mobilization activities are tracked against WBS nodes for schedule and cost performance reporting. Construction project controls teams post mobilization costs and durations to WBS nodes for earne',
    `access_road_established` BOOLEAN COMMENT 'Indicates whether the primary site access road and entry/exit gates have been constructed and are operational for heavy vehicle and workforce ingress/egress.',
    `actual_demobilization_date` DATE COMMENT 'Date on which site demobilization was physically completed and the site was vacated. Compared against planned_demobilization_date to assess demobilization schedule performance.',
    `actual_mobilization_date` DATE COMMENT 'Date on which site mobilization physically commenced (first crew or equipment on site). Compared against planned_mobilization_date to compute mobilization schedule variance.',
    `building_permit_number` STRING COMMENT 'Reference number of the building or construction permit issued by the local authority. Required before commencement of structural works and tracked for regulatory compliance.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual costs incurred for site mobilization activities as recorded in the job costing system (Viewpoint Vista / SAP S/4HANA). Used for cost variance analysis against mobilization_cost_budget.',
    `cost_budget` DECIMAL(18,2) COMMENT 'Approved budget allocated for site mobilization activities including site establishment, temporary facilities, equipment transport, and initial workforce deployment. Expressed in the project currency.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country in which the construction site is located (e.g., USA, AUS, GBR, ARE). Drives regulatory compliance framework selection and reporting jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this site mobilization record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this mobilization record (e.g., USD, AUD, GBP, AED). Ensures consistent financial reporting across multi-currency international projects.. Valid values are `^[A-Z]{3}$`',
    `dlp_end_date` DATE COMMENT 'Date on which the Defects Liability Period (DLP) for site establishment works expires. After this date, the contractor is no longer obligated to rectify defects in temporary site infrastructure.',
    `environmental_permit_number` STRING COMMENT 'Reference number of the primary environmental permit issued by the regulatory authority (e.g., EPA NPDES permit number). Required for regulatory compliance tracking and audit.',
    `environmental_permit_obtained` BOOLEAN COMMENT 'Indicates whether all required environmental permits and approvals (e.g., EPA stormwater NPDES permit, land disturbance permit) have been obtained prior to ground disturbance.',
    `hse_plan_approval_date` DATE COMMENT 'Date on which the site HSE plan was formally approved by the HSE Manager and client representative. Required for regulatory compliance and Intelex HSE management system records.',
    `hse_plan_approved` BOOLEAN COMMENT 'Indicates whether the site-specific HSE plan has been reviewed and approved prior to mobilization commencement. Mandatory pre-mobilization gate per ISO 45001 and OSHA requirements.',
    `laydown_area_established` BOOLEAN COMMENT 'Indicates whether the designated materials laydown and storage area has been prepared, demarcated, and made operational for receiving deliveries and storing equipment.',
    `leed_certification_target` STRING COMMENT 'Target LEED certification level for the project site as specified in the contract or client brief. Influences site establishment requirements for waste management, stormwater control, and sustainable practices.. Valid values are `certified|silver|gold|platinum|none`',
    `mobilization_number` STRING COMMENT 'Externally-known business identifier for this mobilization record, used in correspondence, Procore daily logs, and Aconex transmittals. Follows the enterprise MOB-XXXXXX numbering convention.. Valid values are `^MOB-[A-Z0-9]{3,20}$`',
    `mobilization_status` STRING COMMENT 'Current lifecycle state of the site mobilization record: planned (NTP received, not yet started), in_progress (site establishment underway), completed (fully mobilized and operational), demobilized (site closed and handed back), cancelled (mobilization voided), on_hold (temporarily suspended).. Valid values are `planned|in_progress|completed|demobilized|cancelled|on_hold`',
    `mobilization_type` STRING COMMENT 'Classification of the mobilization scope: full_site (complete site establishment), work_package (specific WBS package), temporary_camp (workforce accommodation), equipment_only (plant and machinery deployment), or partial (phased mobilization). [ENUM-REF-CANDIDATE: full_site|work_package|temporary_camp|equipment_only|partial|phased — promote to reference product]. Valid values are `full_site|work_package|temporary_camp|equipment_only|partial`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, constraints, special conditions, or observations related to the site mobilization that are not captured in structured fields (e.g., access restrictions, community liaison requirements).',
    `ntp_date` DATE COMMENT 'Date on which the Notice to Proceed (NTP) was issued by the client or engineer, authorizing the contractor to commence site mobilization and construction activities. Critical contractual milestone.',
    `peak_workforce_actual` STRING COMMENT 'Maximum number of workers (direct and subcontractor) actually recorded on site simultaneously during the mobilization period, as tracked in HCSS HeavyJob time records.',
    `peak_workforce_planned` STRING COMMENT 'Maximum number of workers (direct and subcontractor) planned to be on site simultaneously at peak mobilization, as per the resource-loaded schedule in Oracle Primavera P6.',
    `planned_demobilization_date` DATE COMMENT 'Baseline-scheduled date on which site demobilization was planned to be completed, as per the approved project schedule. Used for resource release planning and contract completion forecasting.',
    `planned_mobilization_date` DATE COMMENT 'Baseline-scheduled date on which site mobilization activities were planned to commence, as recorded in Oracle Primavera P6. Used for schedule variance analysis and earned value management (EVM).',
    `procore_project_reference` STRING COMMENT 'External system identifier for this site in Procore Construction Management platform. Used for cross-system reconciliation of daily logs, RFIs, and field management records.',
    `schedule_variance_days` STRING COMMENT 'Number of calendar days difference between actual_mobilization_date and planned_mobilization_date. Positive value indicates delay; negative value indicates early mobilization. Used for schedule performance reporting.',
    `site_address` STRING COMMENT 'Physical street address or location description of the construction site. Used for logistics coordination, regulatory notifications, and emergency response planning.',
    `site_area_sqm` DECIMAL(18,2) COMMENT 'Total area of the construction site in square metres as defined in the site establishment plan. Used for site logistics planning, laydown area allocation, and HSE zone management.',
    `site_closure_signoff_date` DATE COMMENT 'Date on which the formal site closure sign-off was completed by the client, engineer, and contractor, confirming all demobilization obligations have been fulfilled and the site has been restored.',
    `site_fencing_complete` BOOLEAN COMMENT 'Indicates whether site perimeter fencing and hoarding have been fully erected as part of site establishment. Key safety milestone required before workforce deployment.',
    `site_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the construction site centroid in decimal degrees (WGS84). Supports GIS-based site mapping, logistics routing, and spatial analytics.',
    `site_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the construction site centroid in decimal degrees (WGS84). Supports GIS-based site mapping, logistics routing, and spatial analytics.',
    `site_office_established` BOOLEAN COMMENT 'Indicates whether the temporary site office (including communications, IT infrastructure, and welfare facilities) has been established and is operational.',
    `temporary_utilities_connected` BOOLEAN COMMENT 'Indicates whether temporary site utilities (power, water, telecommunications, sewage) have been connected and are operational. Prerequisite for sustained site operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this site mobilization record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_site_mobilization PRIMARY KEY(`site_mobilization_id`)
) COMMENT 'Master record tracking the mobilization and demobilization lifecycle of a construction site or major work package. Captures planned mobilization date, actual mobilization date, NTP (Notice to Proceed) date, site establishment milestones (fencing, laydown area, site office, utilities), demobilization plan date, actual demobilization date, and site closure sign-off. Provides the temporal and logistical anchor for all site operations.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`equipment_deployment` (
    `equipment_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment deployment record in the site domain. Primary key for the equipment_deployment data product.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity or Work Breakdown Structure (WBS) element in the project schedule to which this equipment deployment is assigned.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment master record in the equipment domain. Identifies the specific piece of construction equipment (e.g., excavator, crane, compactor) deployed to site.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Equipment deployment is coordinated using BIM models to avoid clashes; linking enables clash‑detection reporting.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project master record. Links the equipment deployment to the construction project under which the equipment is being utilized.',
    `estimate_line_id` BIGINT COMMENT 'Foreign key linking to bid.estimate_line. Business justification: Equipment deployments consume plant budget against estimate lines. Linking enables actual plant hours vs. estimated plant hours reporting — a standard construction cost control report used by project ',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Equipment usage charges are posted to finance cost codes; linking enables equipment cost reporting and asset depreciation.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: Daily equipment deployment records must reference the governing fleet assignment to apply correct cost rates (owned/rental/standby), validate deployment is within assignment period, and produce equipm',
    `hours_id` BIGINT COMMENT 'The source system record identifier from HCSS HeavyJob equipment hours module. Used for data lineage, reconciliation, and incremental load processing from the operational system of record.',
    `maintenance_order_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_order. Business justification: When equipment breaks down on site, a maintenance order is raised and linked to the deployment record for breakdown cost attribution, downtime tracking, and equipment availability reporting. maintenan',
    `operator_certification_id` BIGINT COMMENT 'Foreign key linking to equipment.operator_certification. Business justification: WHS/OSHA regulations require construction sites to verify operator certifications before deploying equipment. Linking deployment to operator_certification enables compliance audit trails, licence expi',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Equipment operator certification compliance (license verification, OSHA requirements) and incident investigation require linking each equipment deployment to the specific craft_worker operator. operat',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Equipment operations (cranes, excavators, elevated work platforms) require a specific PTW before deployment. equipment_deployment.hse_permit_number is a denormalized text reference; a proper FK enable',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to equipment.inspection_record. Business justification: Construction regulations (WHS/OSHA) mandate pre-start equipment inspections before each shift deployment. Linking equipment_deployment to the specific inspection_record for that shifts pre-start chec',
    `daily_log_id` BIGINT COMMENT 'Reference identifier of the Procore daily log entry from which this equipment deployment record was sourced. Enables traceability back to the source construction management system.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Equipment rental or purchase orders are linked to each deployment for cost allocation and compliance reporting.',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to site.shift_report. Business justification: Equipment deployments are daily/shift-level records of equipment utilisation. Linking equipment_deployment to shift_report enables the shift report to aggregate all equipment deployed during that shif',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Plant and equipment operations require a SWMS covering the specific plant type before deployment. This is a mandatory HSE requirement in construction. Linking equipment_deployment to the governing SWM',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Equipment operations must comply with technical specifications (e.g., compaction equipment per earthworks spec, concrete pump per placement spec). Quality ITPs and method statements reference the gove',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Equipment rental vendor management: equipment deployments reference a rental/hire vendor for invoice matching, vendor performance evaluation, and insurance verification. supplier_name is a denormalize',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone on site where the equipment is deployed. A work front represents a distinct area of concurrent construction activity.',
    `breakdown_description` STRING COMMENT 'Free-text description of the nature of the equipment breakdown or mechanical failure, as recorded by the site supervisor or equipment operator. Populated only when breakdown_flag is True.',
    `breakdown_flag` BOOLEAN COMMENT 'Indicates whether the equipment experienced a mechanical breakdown or unplanned failure during this deployment period. True = breakdown occurred; False = no breakdown. Triggers maintenance workflow in SAP S/4HANA Plant Maintenance.',
    `breakdown_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was unavailable due to mechanical breakdown or unplanned maintenance during the shift or reporting period. Feeds into equipment reliability and maintenance KPI reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the hourly rate and cost values recorded in this deployment record (e.g., USD, AUD, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `deployment_date` DATE COMMENT 'The calendar date on which the equipment was mobilized and deployed to the designated work front or activity. Represents the start of the deployment period for daily or period-based tracking.',
    `deployment_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for this equipment deployment record, as assigned in HCSS HeavyJob or the site daily log system. Used for cross-system traceability and field reporting.',
    `deployment_status` STRING COMMENT 'Current operational lifecycle status of the equipment deployment record. active indicates equipment is in productive use; idle indicates on-site but not producing; breakdown indicates mechanical failure; demobilized indicates equipment has left site; standby indicates awaiting assignment; transferred indicates moved to another work front or project.. Valid values are `active|idle|breakdown|demobilized|standby|transferred`',
    `equipment_type` STRING COMMENT 'Classification of the equipment by functional category (e.g., Excavator, Bulldozer, Crane, Compactor, Concrete Pump, Dump Truck, Grader). Sourced from the equipment master but denormalized here for site-level reporting. [ENUM-REF-CANDIDATE: excavator|bulldozer|crane|compactor|concrete_pump|dump_truck|grader|loader|paver|roller|generator|pump|forklift|drill_rig — promote to reference product]',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed by the equipment during the shift or reporting period, measured in liters. Used for cost tracking, environmental reporting, and fuel efficiency benchmarking.',
    `fuel_type` STRING COMMENT 'Type of fuel consumed by the equipment. Used for environmental emissions reporting and fuel cost categorization.. Valid values are `diesel|petrol|lpg|electric|hybrid`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The contracted or internal charge rate for the equipment per operating hour, in the project currency. Used for job costing and cost-to-complete calculations. Confidential as it reflects commercial pricing.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was on-site but not in productive operation (e.g., waiting for materials, weather delays, operator breaks). Idle hours are tracked separately from operating hours for utilization analysis.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was in productive operation during the shift or reporting period. Used for earned value computation, equipment cost allocation, and maintenance scheduling.',
    `ownership_type` STRING COMMENT 'Indicates whether the deployed equipment is company-owned, rented from an external supplier, leased under a finance or operating lease, or provided by a subcontractor. Affects cost coding and financial treatment.. Valid values are `owned|rented|leased|subcontractor`',
    `planned_production_quantity` DECIMAL(18,2) COMMENT 'The target or budgeted production quantity for the equipment during this shift or reporting period, as derived from the project schedule and production plan. Enables variance analysis against actual production.',
    `pre_start_check_flag` BOOLEAN COMMENT 'Indicates whether a pre-start safety inspection was completed for the equipment prior to commencement of operations on this shift. True = pre-start check completed; False = not completed. Required for ISO 45001 and OSHA compliance.',
    `production_quantity` DECIMAL(18,2) COMMENT 'The measured quantity of work produced by the equipment during the shift or reporting period (e.g., cubic meters of earth moved, linear meters of paving laid, cubic meters of concrete poured). The unit is defined by production_unit_of_measure.',
    `production_unit_of_measure` STRING COMMENT 'The unit of measure for the production quantity recorded in this deployment (e.g., m3 for earthworks, lm for linear paving, tonne for material placement). Aligns with the cost code and activity unit of measure. [ENUM-REF-CANDIDATE: m3|m2|lm|tonne|each|load|hour — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this equipment deployment record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this equipment deployment record was last modified, in ISO 8601 format with timezone offset. Supports incremental data processing and audit trail requirements in the Databricks Silver Layer.',
    `release_date` DATE COMMENT 'The calendar date on which the equipment was released from the work front or activity and demobilized or reassigned. Null if the equipment is still actively deployed.',
    `remarks` STRING COMMENT 'Free-text field for site supervisor or equipment manager to record additional observations, instructions, or notes relevant to this equipment deployment record (e.g., special operating conditions, partial shift reasons, safety observations).',
    `rental_order_number` STRING COMMENT 'The Purchase Order (PO) or rental agreement reference number for externally rented or leased equipment. Links the deployment record to the procurement and accounts payable process.',
    `shift_date` DATE COMMENT 'The specific working date (shift date) for which this equipment utilization record is reported. Enables daily granularity within a multi-day deployment period.',
    `shift_type` STRING COMMENT 'The work shift during which the equipment was operated. Distinguishes day, night, swing, or double shifts for accurate labor and equipment cost allocation.. Valid values are `day|night|swing|double`',
    `site_location_description` STRING COMMENT 'Descriptive reference to the physical location on site where the equipment is deployed (e.g., Zone A — North Embankment, Pier 3 Foundation, Runway 2 Subbase). Supports spatial tracking and site logistics management.',
    `standby_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was on standby — available and ready but not assigned to active work. Relevant for contract billing where standby rates differ from operating rates.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition at the site during the equipment deployment shift. Recorded to support analysis of weather-related productivity impacts and Extension of Time (EOT) claims. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|fog|wind|storm|snow — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_equipment_deployment PRIMARY KEY(`equipment_deployment_id`)
) COMMENT 'Daily or period-based record of construction equipment deployed to a specific work front or activity on site. Captures equipment ID (FK to equipment domain), deployment date, release date, operating hours, idle hours, cost code, operator name, fuel consumption, and breakdown flag. Sourced from HCSS HeavyJob equipment hours module. Distinct from equipment domain master records — this entity tracks the operational utilization of equipment at the site level.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`material_delivery` (
    `material_delivery_id` BIGINT COMMENT 'Unique surrogate identifier for each material delivery receipt event recorded at the construction site. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Material deliveries are scheduled against specific construction activities; the FK enables material‑to‑activity traceability for cost and progress.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Material deliveries are executed by specific vehicles; tracking the asset supports logistics, cost, and compliance audits.',
    `bid_boq_line_id` BIGINT COMMENT 'Foreign key linking to bid.bid_boq_line. Business justification: Material deliveries fulfill quantities against BOQ line items. Tracking delivered quantities against contracted BOQ lines is fundamental for payment certification, quantity reconciliation, and materia',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: Material deliveries are site events that occur on specific dates and are captured in the daily site log. Linking material_delivery to daily_log enables the daily log to reference all deliveries receiv',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material delivery records must map to finance cost codes for material cost allocation and inventory valuation.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Site delivery to procurement GR reconciliation: the site material_delivery record must be matched to the procurement goods_receipt for three-way match (PO→GR→site delivery), payment certification, and',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: Material deliveries (goods receipts) generate material cost transactions in the job cost ledger. The delivery_value and unit_rate on material_delivery are the basis for material cost postings. Role-pr',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Material delivery tracking against approved catalog: material_code, material_description, and material_category are denormalized text fields. A FK to material_catalog formalizes the material reference',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: Material delivery conformance and traceability process: site delivery dockets must be reconciled against approved material master records (conformance certificates, specification grade, shelf life). C',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Delivery of hazardous or regulated materials requires a specific permit; linking validates compliance before receipt.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Delivery-to-PO-line quantity reconciliation: po_line_number is a denormalized plain-text field. A FK to po_line enables precise quantity matching (ordered vs. delivered vs. accepted) at line-item leve',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this material delivery belongs. Links the physical receipt event to the project context for cost coding and earned value computation.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the materials. Links to the procurement domain supplier master for vendor performance tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the procurement domain Purchase Order (PO) against which this delivery was made. Enables reconciliation between the physical receipt event and the contractual procurement record.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Material delivery ITP compliance and NCR traceability require identifying the named craft_worker who inspected and accepted/rejected each delivery. receiving_inspector is a denormalized text reference',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Material deliveries are received at a specific construction site gate or laydown area. Adding a direct site_id FK to material_delivery enables site-level delivery reporting and logistics management wi',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Material deliveries must be verified against the governing technical specification (material grade, test certificate requirements, storage conditions). Quality inspectors use this link to confirm deli',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Material deliveries are tracked against WBS nodes for procurement-schedule integration and earned value reporting. Construction project controls teams need this link to verify material availability ag',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Materials are delivered to specific work fronts or laydown areas associated with a work front. Linking material_delivery to work_front enables work-front-level material tracking, supporting production',
    `batch_number` STRING COMMENT 'The manufacturers batch or lot number for the delivered material. Critical for quality traceability, enabling recall or investigation of specific production batches if non-conformance is identified post-installation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this material delivery record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code in which the delivery value and unit rate are expressed (e.g., USD, AUD, GBP). Required for multi-currency project financial management and IFRS/GAAP reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'The calendar date on which the material physically arrived at the site gate or designated laydown area. This is the principal real-world event date for the delivery transaction, distinct from the PO expected delivery date.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the material delivery receipt event. Indicates whether the delivery was fully accepted, rejected at the gate, partially accepted, pending quality inspection, or placed on hold pending resolution of a discrepancy.. Valid values are `accepted|rejected|partial|pending_inspection|on_hold`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the delivery vehicle arrived at the site gate or laydown area. Supports site logistics scheduling, gate management, and time-stamped audit trails.',
    `delivery_value` DECIMAL(18,2) COMMENT 'The total monetary value of the accepted delivery, calculated as quantity_accepted multiplied by unit_rate. Used for goods receipt posting, cost accrual, and three-way matching against the supplier invoice. Expressed in the project currency.',
    `discrepancy_notes` STRING COMMENT 'Free-text field capturing details of any discrepancy identified at the point of receipt, including quantity shortfalls, damage descriptions, specification mismatches, or incorrect materials. Used to support NCR (Non-Conformance Report) creation and supplier claims.',
    `docket_number` STRING COMMENT 'The externally-issued delivery docket or delivery note number provided by the supplier on the physical delivery documentation. Used as the primary business identifier for the delivery event and for three-way matching against the PO and invoice.',
    `driver_name` STRING COMMENT 'The name of the delivery driver as recorded on the delivery docket or site gate register. Captured for site security, access control, and delivery audit trail purposes.',
    `expected_delivery_date` DATE COMMENT 'The date on which the delivery was originally scheduled or expected to arrive at site as per the Purchase Order (PO) or procurement schedule. Used to calculate delivery schedule variance and supplier on-time delivery performance.',
    `hazardous_material` BOOLEAN COMMENT 'Indicates whether the delivered material is classified as hazardous under applicable regulations (e.g., chemicals, solvents, fuels, asbestos-containing materials). When True, triggers HSE compliance protocols including MSDS verification and segregated storage.',
    `itp_reference` STRING COMMENT 'Reference to the Inspection and Test Plan (ITP) hold or witness point associated with this material delivery. Links the receipt event to the project quality plan to confirm that required inspections were completed before material acceptance.',
    `laydown_zone` STRING COMMENT 'The designated receiving location or laydown area on the site logistics plan where the delivered material was stored upon receipt (e.g., Zone A - Steel Yard, Zone C - Concrete Batching Area). Supports site logistics management and material traceability.',
    `msds_verified` BOOLEAN COMMENT 'Indicates whether the Material Safety Data Sheet (MSDS) or Safety Data Sheet (SDS) was verified and on file at the time of receipt for hazardous materials. Required for OSHA HazCom compliance and site HSE management.',
    `ncr_reference` STRING COMMENT 'The reference number of the Non-Conformance Report (NCR) raised as a result of a rejected or non-conforming delivery. Links the physical receipt event to the quality management process for corrective action tracking.',
    `procore_log_reference` STRING COMMENT 'The reference identifier of the associated Procore daily log entry in which this material delivery was recorded. Enables traceability back to the source system of record for field management and audit purposes.',
    `quantity_accepted` DECIMAL(18,2) COMMENT 'The quantity of material formally accepted after inspection at the point of receipt. May be less than quantity_delivered in cases of partial acceptance due to damage, non-conformance, or specification mismatch. Triggers stock update in the materials domain.',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'The actual quantity of material physically received at the site as measured or counted at the point of receipt. This is the principal quantitative fact for the delivery event and is used to update material stock records and reconcile against the PO quantity.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material that was ordered on the associated Purchase Order (PO) line for this delivery. Enables immediate over/under delivery variance calculation at the point of receipt without requiring a join to the procurement domain.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of material rejected at the point of receipt due to damage, non-conformance with specification, or incorrect material. Triggers a Non-Conformance Report (NCR) and return-to-supplier process.',
    `receipt_condition` STRING COMMENT 'The physical condition of the material as assessed at the point of receipt. Drives the acceptance/rejection decision and informs quality control processes. [ENUM-REF-CANDIDATE: good|damaged|wet|contaminated|incorrect_spec|short_delivered — promote to reference product]. Valid values are `good|damaged|wet|contaminated|incorrect_spec|short_delivered`',
    `temperature_sensitive` BOOLEAN COMMENT 'Indicates whether the delivered material requires temperature-controlled storage conditions (e.g., epoxy resins, certain adhesives, bituminous products, or cold-chain materials). When True, triggers special handling and storage protocols on site.',
    `test_certificate_number` STRING COMMENT 'The reference number of the material test certificate or mill certificate provided by the supplier with the delivery. Confirms that the material meets the specified engineering standards and is required for quality assurance sign-off.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the delivered quantity is expressed (e.g., cubic metres for concrete, tonnes for steel, each for prefabricated elements). Must align with the unit specified on the Purchase Order (PO) for reconciliation. [ENUM-REF-CANDIDATE: m3|tonne|kg|m|m2|EA|L|bag|roll|set — promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'The agreed unit price for the material as per the Purchase Order (PO), expressed in the project currency. Used to calculate the value of the delivery for goods receipt posting and cost accrual in the project financial management system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this material delivery record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `vehicle_registration` STRING COMMENT 'The registration plate number of the delivery vehicle. Recorded at the site gate for security, access control, and logistics tracking purposes.',
    CONSTRAINT pk_material_delivery PRIMARY KEY(`material_delivery_id`)
) COMMENT 'Site-level record of material deliveries received at the construction site gate or designated laydown area. Captures delivery date, supplier name, PO reference (FK to procurement domain), delivery docket number, material description, quantity delivered, unit of measure, receiving location (laydown zone per site_logistics_plan), condition on receipt (accepted/rejected/partial), receiver name, temperature-sensitive storage flag, and discrepancy notes. Distinct from procurement domain PO records — this entity captures the physical receipt event at the site and triggers material domain stock updates.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`instruction` (
    `instruction_id` BIGINT COMMENT 'Unique surrogate identifier for the site instruction record in the silver layer lakehouse. Primary key for this entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Site Instructions are issued for specific scheduled activities (e.g., change orders); the link supports instruction tracking against the activity schedule.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this site instruction is issued. Feeds the contract administration and change order process in the contract domain.',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: A site instruction is formally issued in direct response to a regulatory authority notice (e.g., stop-work notice, EPA direction). Construction compliance registers require traceability from authority',
    `change_notice_id` BIGINT COMMENT 'Foreign key linking to design.change_notice. Business justification: Site instructions often stem from formal change notices; linking tracks the originating change for audit.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client-issued site instructions (variation orders, engineers instructions) must be formally attributed to the client organization for contractual accountability, dispute resolution, and variation cla',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Formal site instructions in construction require tracking the named client representative (resident engineer, clerk of works) who issues or must acknowledge the instruction. This is essential for cont',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this site instruction was issued. Links to the project domain for earned value and cost control context.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Site instructions (variation instructions, engineers instructions) reference specific drawings they supersede or modify. Contract administration and variation claims require this link to trace which ',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCR-Triggered Instructions: Site instructions are formally issued in response to NCRs directing corrective work. Contract administrators and QA managers use this link to track instruction-to-NCR trace',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Site instructions often stem from permit conditions; linking ties each instruction to its governing permit for traceability.',
    `project_change_order_id` BIGINT COMMENT 'Foreign key linking to project.project_change_order. Business justification: Site instructions frequently originate or result in change orders. Instruction-to-change-order traceability is a core contract administration process. instruction has cost_impact_flag and estimated_co',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Variation/instruction-driven procurement: site instructions (variation orders, engineers instructions) trigger purchase requisitions for additional materials or services. Linking instruction to the r',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Site instructions are formally issued to implement or respond to specific regulatory obligations (e.g., heritage buffer compliance, noise mitigation). Compliance managers need this link to trace which',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Site instructions are frequently issued in direct response to RFIs (the engineers formal response triggers an instruction to proceed). Contract administration workflows require tracing instruction→RF',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Site instructions that change work scope require a risk assessment update before implementation. Construction HSE management processes mandate that instructions with HSE implications reference the upd',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Formal site instructions are issued for a specific construction site. Adding site_id to instruction enables site-level instruction tracking and reporting. The instruction already has physical_location',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: A site instruction changing work scope triggers a SWMS review or new SWMS requirement. Construction HSE management requires that scope-changing instructions reference the updated SWMS, enabling change',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Instructions direct work to comply with a specific technical specification clause (e.g., proceed per Spec Section 03300). Quality and contract administration require this FK to enforce specification',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Site instructions (variation orders) are issued against specific trade packages. Linking enables trade-package-level variation tracking, cost impact reporting, and contract administration — a standard',
    `aconex_mail_reference` STRING COMMENT 'Reference number of the formal correspondence or transmittal in the Aconex Document Management system through which this site instruction was officially transmitted to the contractor.',
    `affected_wbs_code` STRING COMMENT 'Work Breakdown Structure (WBS) code identifying the specific work package or activity affected by this site instruction. Enables cost and schedule impact traceability within the project control framework.',
    `contractor_acknowledgment_date` DATE COMMENT 'Date on which the contractor formally acknowledged receipt of the site instruction. Contractually significant as it starts the clock for contractor response obligations and EOT notice periods under FIDIC.',
    `contractor_dispute_flag` BOOLEAN COMMENT 'Indicates whether the contractor has formally disputed the validity, scope, or commercial basis of this site instruction, triggering the contract dispute resolution process.',
    `contractor_response_date` DATE COMMENT 'Actual date on which the contractor submitted their formal response or cost/time claim in relation to this site instruction. Used to assess compliance with contractual response obligations.',
    `contractor_response_due_date` DATE COMMENT 'Contractually required date by which the contractor must submit a formal response, cost estimate, or notice of claim in relation to this site instruction, calculated from the acknowledgment date per contract conditions.',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether the site instruction is expected to result in a cost variation to the contract. When true, triggers the change order (CO) valuation process in the contract domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this site instruction record was first created in the data platform, providing the audit trail creation marker for data governance and lineage purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the estimated cost impact amount, aligned with the contract currency for financial reporting and EVM calculations.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Narrative description of the contractors stated grounds for disputing this site instruction, captured for contract administration and potential adjudication or arbitration proceedings.',
    `document_revision` STRING COMMENT 'Revision identifier of the site instruction document, tracking amendments or superseding versions issued after the original. Supports document control and audit trail requirements.. Valid values are `^[A-Z0-9]{1,5}$`',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Preliminary estimated monetary value of the cost variation associated with this site instruction, expressed in the contract currency. Used for budget forecasting and change order (CO) initiation prior to formal valuation.',
    `estimated_time_impact_days` STRING COMMENT 'Preliminary estimate of the number of calendar days by which this site instruction may extend the contract completion date, used for Extension of Time (EOT) assessment and CPM schedule analysis.',
    `hse_implication_flag` BOOLEAN COMMENT 'Indicates whether this site instruction has Health, Safety, and Environment (HSE) implications requiring a Safe Work Method Statement (SWMS) update, permit to work review, or HSE authority notification before execution.',
    `implementation_completion_date` DATE COMMENT 'Date on which the contractor completed execution of all work directed by the site instruction, enabling closure of the instruction and final cost/time impact confirmation.',
    `implementation_start_date` DATE COMMENT 'Date on which the contractor commenced execution of the work directed by the site instruction. Used for progress tracking and earned value computation.',
    `instruction_description` STRING COMMENT 'Full narrative description of the work, method change, or site condition to be addressed as directed by the issuing authority. This is the primary contractual content of the instruction.',
    `instruction_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the site instruction by the issuing authority. Used for correspondence, filing, and cross-referencing with contract documents and RFIs. Format: SI-[ProjectCode]-[SequenceNumber].. Valid values are `^SI-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `instruction_status` STRING COMMENT 'Current workflow lifecycle status of the site instruction from issuance through contractor acknowledgment to implementation and closure. [ENUM-REF-CANDIDATE: draft|issued|acknowledged|under_review|implemented|closed|disputed|cancelled — promote to reference product]',
    `instruction_type` STRING COMMENT 'Classification of the nature and purpose of the site instruction, determining the downstream contractual and commercial treatment. [ENUM-REF-CANDIDATE: variation_order|method_change|safety_directive|quality_directive|access_instruction|suspension|acceleration|remedial_work — promote to reference product]',
    `issue_date` DATE COMMENT 'The calendar date on which the site instruction was formally issued by the engineer or client representative to the contractor. This is the principal business event date for the instruction.',
    `issued_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the site instruction was formally transmitted or published to the contractor, capturing the exact moment of issuance for audit and contractual timeline purposes.',
    `issuing_authority_role` STRING COMMENT 'Contractual role or designation of the person who issued the site instruction, determining the authority level and contractual validity of the instruction under the applicable contract conditions.. Valid values are `engineer|client_representative|resident_engineer|project_manager|site_supervisor|clerk_of_works`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time at which this site instruction record was most recently modified in the data platform, supporting change tracking, data quality monitoring, and incremental ETL processing.',
    `physical_location_description` STRING COMMENT 'Textual description of the specific physical location, chainage, grid reference, or site zone where the instructed work is to be carried out, supporting field crew navigation and site logistics.',
    `procore_instruction_reference` STRING COMMENT 'Native identifier of this site instruction record in the Procore Construction Management system, used for data lineage, reconciliation, and integration with the source system of record.',
    `quality_hold_required` BOOLEAN COMMENT 'Indicates whether a quality hold point or inspection is required before or after execution of the work directed by this site instruction, triggering an Inspection and Test Plan (ITP) checkpoint.',
    `superseded_by_instruction_number` STRING COMMENT 'Instruction number of the subsequent site instruction that supersedes or replaces this one, enabling version chain traceability in the instruction register.',
    `time_impact_flag` BOOLEAN COMMENT 'Indicates whether the site instruction is expected to result in a schedule delay or Extension of Time (EOT) claim. When true, triggers schedule impact assessment in the project domain.',
    `title` STRING COMMENT 'Short descriptive title summarising the subject matter of the site instruction, used for quick identification in registers and dashboards.',
    `urgency_classification` STRING COMMENT 'Priority level assigned to the site instruction indicating the required response timeframe. Emergency instructions may require immediate contractor action to address safety or critical path impacts.. Valid values are `routine|urgent|emergency`',
    CONSTRAINT pk_instruction PRIMARY KEY(`instruction_id`)
) COMMENT 'Formal site instruction issued by the engineer or client representative directing the contractor to carry out specific work, vary a method, or address a site condition. Captures instruction number, issue date, issuing authority, instruction description, affected work front, urgency classification, contractor acknowledgment date, and cost/time impact flag. Feeds the contract administration and change order process in the contract domain.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`shift_report` (
    `shift_report_id` BIGINT COMMENT 'Unique system-generated identifier for the shift report record. Primary key for the shift_report data product in the site domain. Entity role: TRANSACTION_HEADER.',
    `daily_log_id` BIGINT COMMENT 'Reference to the parent daily log record that this shift report rolls up into. Multiple shift reports (day/night/swing) may feed a single daily log for 24-hour continuous operations such as tunnel boring or continuous concrete pours.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Shift reports feed daily cost roll‑ups; associating each shift with a finance cost code supports daily cost variance analysis.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: REQUIRED: Shift reports record incidents during the shift; linking provides direct reference to the incident record.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Shift reports capture permit‑related delays; linking provides direct reference to the permit affecting the shift.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Each shift report references the active PTW governing work during that shift. shift_report.permit_to_work_number is a denormalized text reference; a proper FK enables PTW lifecycle management, shift-l',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this shift report belongs to. Links shift-level operational data to the parent project for earned value and cost control reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A shift report is an operational record for a specific construction site. Adding site_id to shift_report provides a direct FK to the site master record, enabling site-level shift reporting and aggrega',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Shift reports require a named supervisor sign-off for contractual and HSE regulatory compliance. The supervisor_sign_off_timestamp exists but no FK identifies the signing craft_worker. Auditors and in',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: The shift report documents which SWMS governed work during the shift. This is required for HSE audit trails, incident investigation (was the correct SWMS in place?), and regulatory compliance reportin',
    `toolbox_meeting_id` BIGINT COMMENT 'Foreign key linking to safety.toolbox_meeting. Business justification: shift_report.tbm_conducted_flag records whether a TBM occurred but provides no link to the actual TBM record. Linking to toolbox_meeting enables retrieval of TBM content, attendance, and topics for sh',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Shift reports are filed against WBS nodes for schedule performance and earned value tracking. Construction site engineers post shift production data to WBS nodes to calculate BCWP. wbs_code on shift_r',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone where shift activities were executed. Enables production tracking and resource allocation analysis by work front.',
    `activities_narrative` STRING COMMENT 'Free-text description of the principal work activities performed during the shift, including scope completed, methods used, and notable observations. Sourced from HCSS HeavyJob field notes and Procore daily log entries.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the shift report was formally approved by the authorised reviewer (typically the site superintendent or project manager). Marks the record as authoritative for earned value and cost reporting.',
    `concrete_volume_m3` DECIMAL(18,2) COMMENT 'Volume of concrete placed during the shift in cubic metres. Specifically tracked for continuous pour operations where shift-level granularity is critical for quality control, mix design compliance, and ACI/IBC structural requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shift report record was first created in the system. Audit trail field for data lineage and compliance with GDPR data management requirements.',
    `delay_cause` STRING COMMENT 'Primary cause category for any delay experienced during the shift. Supports EOT claim substantiation, delay analysis, and root cause reporting. [ENUM-REF-CANDIDATE: weather|equipment_breakdown|material_shortage|access_restriction|design_change|labour_shortage|utility_conflict|other — promote to reference product]',
    `delay_duration_hrs` DECIMAL(18,2) COMMENT 'Total hours of productive time lost during the shift due to delays (weather, equipment breakdown, material shortage, access restrictions, etc.). Used for Extension of Time (EOT) claims, Liquidated Damages (LD) assessment, and schedule impact analysis.',
    `direct_labour_count` STRING COMMENT 'Number of direct labour personnel (company-employed workers) present and working during the shift. Excludes subcontractor personnel. Used for workforce planning and productivity benchmarking.',
    `earthworks_volume_m3` DECIMAL(18,2) COMMENT 'Volume of earthworks (cut, fill, or excavation) completed during the shift in cubic metres. Key production metric for night-shift earthworks and bulk earthmoving operations. Feeds into MTO reconciliation and earned value reporting.',
    `equipment_count` STRING COMMENT 'Total number of equipment units deployed and operational during the shift. Supports equipment utilization analysis and plant maintenance scheduling in SAP S/4HANA.',
    `equipment_utilisation_pct` DECIMAL(18,2) COMMENT 'Percentage of deployed equipment that was actively productive during the shift, calculated as productive equipment hours divided by total available equipment hours multiplied by 100. Key indicator for plant efficiency and idle cost identification.',
    `handover_notes` STRING COMMENT 'Free-text notes prepared by the outgoing shift supervisor for the incoming shift team. Covers outstanding work, active risks, equipment status, pending permits, and critical instructions. Essential for 24-hour continuous operations continuity.',
    `hcss_shift_reference` STRING COMMENT 'Source system reference identifier from HCSS HeavyJob for this shift record. Enables bi-directional traceability between the lakehouse silver layer and the operational field management system for reconciliation and audit.',
    `incident_count` STRING COMMENT 'Number of safety incidents (near misses, first aid, recordable, or Lost Time Injuries) that occurred during the shift. Distinct from safety observations. Triggers mandatory reporting to Intelex and regulatory notification under OSHA/ISO 45001.',
    `issues_count` STRING COMMENT 'Total number of open issues, constraints, or blockers identified during the shift that require resolution before or during the next shift. Drives issue escalation workflows and handover briefings.',
    `lti_flag` BOOLEAN COMMENT 'Indicates whether a Lost Time Injury (LTI) occurred during this shift. An LTI is a work-related injury or illness resulting in the worker being unable to return to work on the next scheduled shift. Triggers mandatory regulatory reporting and executive escalation.',
    `ncr_raised_flag` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report (NCR) was raised during this shift for a quality defect or deviation from the Inspection and Test Plan (ITP). Triggers QA/QC workflow in Procore and links to the quality domain.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled end time for the shift as defined in the project schedule. Compared against shift_end_timestamp to measure shift overrun and overtime exposure.',
    `planned_production_quantity` DECIMAL(18,2) COMMENT 'Target production quantity for the shift as defined in the project schedule and production plan. Compared against production_quantity to compute shift-level production variance and Schedule Performance Index (SPI).',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled start time for the shift as defined in the project schedule. Compared against shift_start_timestamp to measure schedule adherence and identify mobilization delays.',
    `procore_log_reference` STRING COMMENT 'Source system reference identifier from Procore Construction Management for the corresponding daily log or field report entry. Supports cross-system reconciliation between shift-level HCSS data and Procore document management.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Measured quantity of work completed during the shift against the primary production activity (e.g., cubic metres of earthworks excavated, linear metres of pipe laid, cubic metres of concrete poured). The principal quantitative result for the shift. Unit defined in production_unit.',
    `production_unit` STRING COMMENT 'Unit of measure for the production_quantity field (e.g., m3 for earthworks or concrete, lm for linear metres of pipeline, tonne for bulk materials). Ensures dimensional consistency for productivity benchmarking and earned value calculations. [ENUM-REF-CANDIDATE: m3|m2|lm|tonne|each|kg|m|hr — 8 candidates stripped; promote to reference product]',
    `report_number` STRING COMMENT 'Externally-known alphanumeric identifier for the shift report, typically formatted as SR-[ProjectCode]-[Year]-[Sequence]. Used for document control, correspondence, and cross-system referencing in Procore and Aconex.. Valid values are `^SR-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$`',
    `report_status` STRING COMMENT 'Current workflow lifecycle state of the shift report. Tracks progression from field data entry (draft) through supervisor submission, review, and formal approval. Drives downstream integration with daily log consolidation.. Valid values are `draft|submitted|reviewed|approved|rejected`',
    `safety_observation_count` STRING COMMENT 'Number of HSE safety observations (positive or negative) recorded during the shift. Feeds into TRIR (Total Recordable Incident Rate) trending and Intelex HSE management reporting.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift occurred. Used for temporal aggregation, daily log linkage, and schedule performance analysis. Formatted as yyyy-MM-dd per model conventions.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shift concluded on site. Combined with shift_start_timestamp to derive total shift duration and labor hours. Null if shift is still in progress.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shift commenced on site. Principal business event timestamp for the shift lifecycle. Used for labor hour calculation, schedule adherence, and overtime analysis.',
    `shift_type` STRING COMMENT 'Classification of the shift period indicating the operational window. Day shifts typically cover 06:00–18:00, night shifts 18:00–06:00, swing shifts overlap transitions, and extended shifts apply to continuous 24-hour operations such as tunnel boring or continuous concrete pours.. Valid values are `day|night|swing|extended`',
    `subcontractor_count` STRING COMMENT 'Number of subcontractor personnel present and working during the shift. Tracked separately from direct labour for contract administration, cost coding, and subcontractor performance management.',
    `supervisor_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the shift supervisor formally signed off and submitted the shift report. Marks the transition from draft to submitted status and initiates the review and approval workflow.',
    `tbm_conducted_flag` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted at the start of the shift. TBMs are mandatory pre-shift safety briefings covering hazards, Safe Work Method Statements (SWMS), and permit-to-work requirements. Compliance tracked for ISO 45001 and OSHA audits.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient air temperature recorded on site during the shift in degrees Celsius. Relevant for concrete curing compliance (ACI 305/306), heat stress risk management (ISO 45001), and cold weather work procedures.',
    `total_headcount` STRING COMMENT 'Total number of all personnel on site during the shift, including direct labour, subcontractors, supervisors, and visitors. Used for site access control, emergency muster, and HSE compliance reporting.',
    `total_labour_hours` DECIMAL(18,2) COMMENT 'Total man-hours worked across all crew members during the shift, including direct labour and subcontractor labour. Core input for earned value management (EVM) cost performance index (CPI) calculations and labour productivity analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the shift report record was last modified. Supports incremental data loading in the Databricks lakehouse silver layer and audit trail requirements.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition observed on site during the shift. Impacts productivity, safety risk assessment, and supports weather-related delay and EOT claim documentation. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|fog|wind|storm|snow — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_shift_report PRIMARY KEY(`shift_report_id`)
) COMMENT 'Shift-level operational report summarizing activities, headcount, production achieved, issues encountered, and safety observations for a specific shift (day/night/swing) on a work front. Captures shift type, shift supervisor, start/end time, total labor hours, production summary by cost code, equipment utilization summary, open issues count, and shift handover notes. Distinct from daily_log in that it provides finer temporal granularity for 24-hour continuous operations (e.g., tunnel boring, continuous concrete pours, night-shift earthworks) where a single daily log is insufficient. Multiple shift_reports may feed into one daily_log.';

CREATE OR REPLACE TABLE `construction_ecm`.`site`.`site_site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: The site owner in construction is the client account. Replacing the denormalized site_owner text with a proper FK to client.account enables client portfolio reporting (all sites owned by a client), HS',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the site belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each construction site maps to a finance cost center for site overhead allocation, indirect cost reporting, and site establishment expense tracking. The site.cost_center_code plain attribute is a deno',
    `site_site_id` BIGINT COMMENT 'Self-referencing FK on site (current_location_site_id)',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite or building).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total built‑up area of the site in square feet.',
    `city` STRING COMMENT 'City where the site is located.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the site location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the system.',
    `crew_capacity` STRING COMMENT 'Maximum number of crew members that can be assigned to the site simultaneously.',
    `demobilization_date` DATE COMMENT 'Date when the site was demobilized.',
    `end_date` DATE COMMENT 'Date when the site was closed or demobilized (nullable).',
    `environmental_permit_number` STRING COMMENT 'Identifier of the environmental permit associated with the site.',
    `gps_accuracy_m` STRING COMMENT 'Estimated accuracy of the GPS coordinates in meters.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `is_mobilized` BOOLEAN COMMENT 'Indicates whether the site is currently mobilized for work.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site location.',
    `mobilization_date` DATE COMMENT 'Date when the site was mobilized.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the environmental permit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `region` STRING COMMENT 'Broad geographic region where the site is located.',
    `safety_incident_count` STRING COMMENT 'Cumulative number of safety incidents recorded at the site.',
    `site_category` STRING COMMENT 'High‑level business category of the site.',
    `site_code` STRING COMMENT 'External business identifier or code assigned to the site.',
    `site_description` STRING COMMENT 'Free‑form description of the site, including notes on purpose or special characteristics.',
    `site_name` STRING COMMENT 'Human‑readable name of the construction site.',
    `site_status` STRING COMMENT 'Current lifecycle state of the site.',
    `site_type` STRING COMMENT 'Classification of the site based on its primary function.',
    `start_date` DATE COMMENT 'Date when the site became operational or was mobilized.',
    `state` STRING COMMENT 'State or province of the site location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    CONSTRAINT pk_site_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by current_location_site_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `construction_ecm`.`site`.`shift_report`(`shift_report_id`);
ALTER TABLE `construction_ecm`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `construction_ecm`.`site`.`shift_report`(`shift_report_id`);
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `construction_ecm`.`site`.`shift_report`(`shift_report_id`);
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `construction_ecm`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `construction_ecm`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_site_id` FOREIGN KEY (`site_id`) REFERENCES `construction_ecm`.`site`.`site_site`(`site_id`);
ALTER TABLE `construction_ecm`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `construction_ecm`.`site`.`work_front`(`work_front_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`site` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`site` SET TAGS ('dbx_domain' = 'site');
ALTER TABLE `construction_ecm`.`site`.`work_front` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`site`.`work_front` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `access_restriction` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `access_restriction` SET TAGS ('dbx_value_regex' = 'unrestricted|permit_required|restricted_zone|exclusion_zone');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `actual_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Actual Crew Size');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `actual_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Work Front Area (Square Metres)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Metres)');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity Classification');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_value_regex' = 'standard|sensitive|protected|remediation_required');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `forecast_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `front_code` SET TAGS ('dbx_business_glossary_term' = 'Work Front Code');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `front_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `front_name` SET TAGS ('dbx_business_glossary_term' = 'Work Front Name');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `front_status` SET TAGS ('dbx_business_glossary_term' = 'Work Front Status');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `front_status` SET TAGS ('dbx_value_regex' = 'active|inactive|mobilizing|demobilized|suspended|completed');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `front_type` SET TAGS ('dbx_business_glossary_term' = 'Work Front Type');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `grid_reference` SET TAGS ('dbx_business_glossary_term' = 'Site Grid Reference');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `heavyjob_cost_center` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Cost Center');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Method (CPM) Flag');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `is_subcontracted` SET TAGS ('dbx_business_glossary_term' = 'Subcontracted Flag');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `planned_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Planned Crew Size');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `planned_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `procore_location_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Location ID');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single|double|rotating|night_only|continuous');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `weather_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Weather Sensitivity Classification');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `weather_sensitivity` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`site`.`work_front` ALTER COLUMN `zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Zone Classification');
ALTER TABLE `construction_ecm`.`site`.`daily_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`daily_log` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log ID');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `concrete_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Volume (Cubic Metres)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `direct_labour_count` SET TAGS ('dbx_business_glossary_term' = 'Direct Labour Headcount');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `earthworks_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Earthworks Volume (Cubic Metres)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `eot_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Impact Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `equipment_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Count On Site');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `event_count` SET TAGS ('dbx_business_glossary_term' = 'Line-Item Event Count');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `has_delay_event` SET TAGS ('dbx_business_glossary_term' = 'Has Delay Event Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `has_safety_observation` SET TAGS ('dbx_business_glossary_term' = 'Has Safety Observation Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `hcss_log_reference` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Log Reference');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `log_date` SET TAGS ('dbx_business_glossary_term' = 'Log Date');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `log_number` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Number');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `log_number` SET TAGS ('dbx_value_regex' = '^DL-[A-Z0-9]+-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `log_status` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Status');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `log_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|void');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `lti_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Occurred Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `ncr_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `overall_site_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Site Status');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `overall_site_status` SET TAGS ('dbx_value_regex' = 'productive|partially_productive|non_productive|shutdown');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `permit_to_work_count` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work Count');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `planned_activities_narrative` SET TAGS ('dbx_business_glossary_term' = 'Planned Activities Narrative');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `precipitation_mm` SET TAGS ('dbx_business_glossary_term' = 'Precipitation (Millimetres)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `procore_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Superintendent Remarks');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|double_shift|split');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `site_access_status` SET TAGS ('dbx_business_glossary_term' = 'Site Access Status');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `site_access_status` SET TAGS ('dbx_value_regex' = 'open|restricted|closed|partial');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `subcontractor_count` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `superintendent_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Superintendent Sign-Off Timestamp');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `temperature_high_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `temperature_low_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `total_delay_duration_hrs` SET TAGS ('dbx_business_glossary_term' = 'Total Delay Duration (Hours)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `total_manpower_count` SET TAGS ('dbx_business_glossary_term' = 'Total Manpower Headcount');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `visitor_count` SET TAGS ('dbx_business_glossary_term' = 'Site Visitor Count');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `wind_speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Kilometres per Hour)');
ALTER TABLE `construction_ecm`.`site`.`daily_log` ALTER COLUMN `work_performed_narrative` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Narrative');
ALTER TABLE `construction_ecm`.`site`.`production_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`production_entry` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `production_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Production Entry ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `estimate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `hours_id` SET TAGS ('dbx_business_glossary_term' = 'Hours Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `budgeted_production_rate` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Production Rate (Units per Hour)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `budgeted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Reference');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `cumulative_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Installed Quantity');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Date');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Number');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Status');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|voided');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `equipment_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `is_baseline_revision` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Revision Flag');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `is_rework` SET TAGS ('dbx_business_glossary_term' = 'Is Rework Flag');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `itp_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (%)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `production_rate` SET TAGS ('dbx_business_glossary_term' = 'Production Rate (Units per Hour)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Production Remarks');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'HCSS_HeavyJob|Procore|Manual|SAP_S4HANA');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `work_front_location` SET TAGS ('dbx_business_glossary_term' = 'Work Front Location');
ALTER TABLE `construction_ecm`.`site`.`production_entry` ALTER COLUMN `work_item_description` SET TAGS ('dbx_business_glossary_term' = 'Work Item Description');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `crew_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Deployment ID');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `crew_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Foreman Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `actual_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Number');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|suspended');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `hse_toolbox_meeting_held` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Toolbox Meeting (TBM) Held Flag');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `is_subcontractor_crew` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Crew Flag');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `is_weather_impacted` SET TAGS ('dbx_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'mobilizing|on_site|demobilizing|demobilized');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `planned_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `ppe_compliance` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `productivity_notes` SET TAGS ('dbx_business_glossary_term' = 'Productivity Notes');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `productivity_rate` SET TAGS ('dbx_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|weekend');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'HCSS_HeavyJob|Procore|Manual');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`crew_deployment` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`site`.`field_progress` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`field_progress` SET TAGS ('dbx_subdomain' = 'resource_deployment');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `field_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Field Progress ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `bid_boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Line Item ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Checkpoint ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Activity ID');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type / Discipline');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `bcwp` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size (Headcount)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Data Date (Progress Cut-Off Date)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `equipment_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Field Engineer Name');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path (CPM) Flag');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Field Measurement Date');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Field Measurement Method');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_number` SET TAGS ('dbx_business_glossary_term' = 'Field Progress Measurement Number');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|fortnightly|monthly');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `period_installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Period Installed Quantity');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `previous_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Previous Percent Complete');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `progress_delta` SET TAGS ('dbx_business_glossary_term' = 'Progress Delta (Incremental Percent Complete)');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `reported_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Reported Percent Complete');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'procore|hcss_heavyjob|primavera_p6|manual|bim360');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`field_progress` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition at Measurement');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` SET TAGS ('dbx_subdomain' = 'site_management');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_mobilization_id` SET TAGS ('dbx_business_glossary_term' = 'Site Mobilization ID');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `equipment_mobilization_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Mobilization Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Oracle Primavera P6 Activity ID');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `access_road_established` SET TAGS ('dbx_business_glossary_term' = 'Access Road Established');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `actual_demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Demobilization Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `actual_mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Mobilization Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `building_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Building Permit Number');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Cost Actual');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `cost_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Cost Budget');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `cost_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `environmental_permit_obtained` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Obtained');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `hse_plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Plan Approval Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `hse_plan_approved` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Plan Approved');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `laydown_area_established` SET TAGS ('dbx_business_glossary_term' = 'Laydown Area Established');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Target');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|none');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Number');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('dbx_value_regex' = '^MOB-[A-Z0-9]{3,20}$');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|demobilized|cancelled|on_hold');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Type');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('dbx_value_regex' = 'full_site|work_package|temporary_camp|equipment_only|partial');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Notes');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `peak_workforce_actual` SET TAGS ('dbx_business_glossary_term' = 'Peak Workforce Actual');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `peak_workforce_planned` SET TAGS ('dbx_business_glossary_term' = 'Peak Workforce Planned');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `planned_demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Demobilization Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `planned_mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Mobilization Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `procore_project_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Project ID');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Schedule Variance (Days)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Site Area (Square Metres)');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_closure_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Sign-Off Date');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_fencing_complete` SET TAGS ('dbx_business_glossary_term' = 'Site Fencing Complete');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `site_office_established` SET TAGS ('dbx_business_glossary_term' = 'Site Office Established');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `temporary_utilities_connected` SET TAGS ('dbx_business_glossary_term' = 'Temporary Utilities Connected');
ALTER TABLE `construction_ecm`.`site`.`site_mobilization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` SET TAGS ('dbx_subdomain' = 'resource_deployment');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `equipment_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Deployment ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `estimate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `hours_id` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Equipment Hours ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `operator_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Start Inspection Record Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_description` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Description');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Flag');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_hours` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Hours');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `deployment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Reference Number');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'active|idle|breakdown|demobilized|standby|transferred');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (Liters)');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|petrol|lpg|electric|hybrid');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|subcontractor');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `planned_production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `pre_start_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Start Check Flag');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Deployment Remarks');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `rental_order_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Order Number');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|double');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `site_location_description` SET TAGS ('dbx_business_glossary_term' = 'Site Location Description');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `construction_ecm`.`site`.`equipment_deployment` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` SET TAGS ('dbx_subdomain' = 'resource_deployment');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `material_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Material Delivery ID');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `bid_boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Boq Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Inspector Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Material Batch Number');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Receipt Status');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial|pending_inspection|on_hold');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Arrival Timestamp');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `delivery_value` SET TAGS ('dbx_business_glossary_term' = 'Delivery Value');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `delivery_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Notes');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Docket Number');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Name');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `itp_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `laydown_zone` SET TAGS ('dbx_business_glossary_term' = 'Laydown Zone');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `msds_verified` SET TAGS ('dbx_business_glossary_term' = 'Material Safety Data Sheet (MSDS) Verified Flag');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `procore_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log Reference ID');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `quantity_accepted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Accepted');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Delivered');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `quantity_rejected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_business_glossary_term' = 'Material Receipt Condition');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_value_regex' = 'good|damaged|wet|contaminated|incorrect_spec|short_delivered');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `temperature_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Temperature-Sensitive Storage Flag');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `test_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Material Test Certificate Number');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Material Unit Rate');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`material_delivery` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_business_glossary_term' = 'Delivery Vehicle Registration Number');
ALTER TABLE `construction_ecm`.`site`.`instruction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`instruction` SET TAGS ('dbx_subdomain' = 'site_management');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction ID');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `change_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `project_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `aconex_mail_reference` SET TAGS ('dbx_business_glossary_term' = 'Aconex Mail Register Reference');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `affected_wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Work Breakdown Structure (WBS) Code');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `contractor_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Acknowledgment Date');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `contractor_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Contractor Dispute Flag');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `contractor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Response Date');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `contractor_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Response Due Date');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `document_revision` SET TAGS ('dbx_business_glossary_term' = 'Document Revision');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `document_revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `estimated_time_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time Impact (Days)');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `hse_implication_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Implication Flag');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `instruction_description` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction Description');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction Number');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_value_regex' = '^SI-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction Status');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction Type');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `issuing_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Role');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `issuing_authority_role` SET TAGS ('dbx_value_regex' = 'engineer|client_representative|resident_engineer|project_manager|site_supervisor|clerk_of_works');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `physical_location_description` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Description');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `procore_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Site Instruction ID');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `quality_hold_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Required Flag');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `superseded_by_instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Instruction Number');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `time_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Time Impact Flag');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction Title');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_business_glossary_term' = 'Urgency Classification');
ALTER TABLE `construction_ecm`.`site`.`instruction` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `construction_ecm`.`site`.`shift_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`site`.`shift_report` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report ID');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log ID');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `activities_narrative` SET TAGS ('dbx_business_glossary_term' = 'Shift Activities Narrative');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `concrete_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Volume (m³)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `delay_cause` SET TAGS ('dbx_business_glossary_term' = 'Delay Cause Category');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `delay_duration_hrs` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Hours)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `direct_labour_count` SET TAGS ('dbx_business_glossary_term' = 'Direct Labour Headcount');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `earthworks_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Earthworks Volume (m³)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `equipment_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Count');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `equipment_utilisation_pct` SET TAGS ('dbx_business_glossary_term' = 'Equipment Utilisation Percentage');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `handover_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Notes');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `hcss_shift_reference` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Shift Reference');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `issues_count` SET TAGS ('dbx_business_glossary_term' = 'Open Issues Count');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `lti_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Flag');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `ncr_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Shift End Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `planned_production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Shift Start Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `procore_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Log Reference');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Number');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^SR-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Status');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|rejected');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `safety_observation_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Count');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|extended');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `subcontractor_count` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `supervisor_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Sign-Off Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `total_headcount` SET TAGS ('dbx_business_glossary_term' = 'Total Shift Headcount');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `total_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Labour Hours');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`site`.`shift_report` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`site`.`site_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`site`.`site_site` SET TAGS ('dbx_subdomain' = 'site_management');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `site_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`site`.`site_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
