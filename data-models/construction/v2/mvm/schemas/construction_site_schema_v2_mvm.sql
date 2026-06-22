-- Schema for Domain: site | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-22 17:24:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`site` COMMENT 'Owns daily site execution data including daily logs, production tracking, work fronts, crew assignments, site logistics, mobilization/demobilization, concrete pours, earthworks volumes, and field progress measurements. Integrates with HCSS HeavyJob for cost coding and production tracking and Procore for daily logs and field management. Supports earned value computation feeding the project domain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`work_front` (
    `work_front_id` BIGINT COMMENT 'Unique surrogate identifier for the work front record. Primary key for the work_front master entity in the site domain.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Work fronts are spatially coordinated against BIM models for clash detection and 4D scheduling. BIM-based work front management is standard practice; bim_model_reference is a plain-text denormalizat',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Work fronts are spatially defined by construction drawings (grid references, zone boundaries, structural elements). Site engineers assign drawing packages to work fronts for scope definition and IFC c',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost allocation reports require each work front to reference the central cost code for budgeting and variance analysis.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Each work front is assigned a primary contract party (sub‑contractor or client) for responsibility, invoicing and performance tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project under which this work front is executed. Enables roll-up of work front data to project-level reporting and earned value computation.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A work front belongs to a single construction site; adding work_front.site_id creates the required parent relationship and eliminates site isolation.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Work fronts are executed under specific subcontract contracts; linking enables schedule, cost and risk integration.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Each work front requires a governing SWMS before work commences — a mandatory WHS regulatory requirement. HSE auditors verify SWMS coverage per work front. swms_reference is a denormalized text fiel',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`daily_log` (
    `daily_log_id` BIGINT COMMENT 'Unique surrogate identifier for the daily site log record. Primary key for the daily_log data product in the Databricks Silver Layer.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Daily logs record the achievement of contract milestones and delay events affecting milestone dates. Superintendents link daily log entries to contract milestones for EOT substantiation and milestone ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Daily logs are aggregated by cost center for project cost performance reporting. Construction cost engineers produce daily cost center burn reports from site logs. No existing cost_center FK on daily_',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Daily Log reports reference the specific design drawing used for the days work; required for progress audit and compliance.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Daily delivery reconciliation process: site supervisors must confirm that GR postings in procurement match deliveries recorded in the daily log. This link enables three-way match verification and supp',
    `construction_project_id` BIGINT COMMENT 'Reference to the project this daily log belongs to. Links the site log to the master project record for earned value and cost control reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A daily log is recorded for a specific construction site. daily_log currently has no FK to site.site despite being the official daily site log. Adding site_id establishes the direct parent-child relat',
    `toolbox_meeting_id` BIGINT COMMENT 'Foreign key linking to safety.toolbox_meeting. Business justification: Daily logs record whether a TBM was conducted (tbm_conducted_flag) but have no FK to the actual toolbox_meeting record. Site supervisors and HSE managers need to verify TBM completion against daily ',
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
    `wbs_code` STRING COMMENT 'Primary WBS (Work Breakdown Structure) code associated with the dominant work activity performed on this log date. Links site production data to the project schedule in Oracle Primavera P6 for earned value and progress reporting.',
    `weather_condition` STRING COMMENT 'Observed general weather condition at the site for the log date. Used to substantiate weather-related delay claims, EOT applications, and force majeure events under FIDIC contract provisions. [ENUM-REF-CANDIDATE: clear|partly_cloudy|overcast|rain|heavy_rain|snow|fog|storm|extreme_heat — promote to reference product]',
    `wind_speed_kmh` DECIMAL(18,2) COMMENT 'Recorded wind speed at the site in kilometres per hour for the log date. Used to assess crane and elevated work restrictions, HSE compliance, and weather-related work stoppages.',
    `work_performed_narrative` STRING COMMENT 'Free-text superintendent narrative describing all construction activities performed on site during the log date. Serves as the primary operational record and legal evidence base for progress claims, delay substantiation, and EOT applications. Sourced from Procore Daily Logs.',
    CONSTRAINT pk_daily_log PRIMARY KEY(`daily_log_id`)
) COMMENT 'Official daily site log (header + line-item structure) capturing all field activities for a given project site and date. The header records weather conditions (temperature, precipitation, wind), site access status, manpower headcount by trade, equipment on site, work performed narrative, superintendent sign-off, and overall site status. Embedded line-item events capture each notable occurrence including delay events, weather stoppages, utility strikes, design holds, access restrictions, and safety observations — each with event type, start/end time, duration, affected work fronts, root cause classification, responsible party, and EOT/cost impact flags. This is the SSOT for all site event data — no separate event entity exists. Sourced from Procore Daily Logs module. Serves as the legal and operational record of site activity and the primary evidence base for delay claims and EOT substantiation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`production_entry` (
    `production_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each granular production tracking record in the silver layer lakehouse. Primary key for the production_entry data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this production entry is recorded. Links production quantities to the project domain for earned value computation.',
    `cost_code_id` BIGINT COMMENT 'Reference to the cost code used to classify and track the financial dimension of this production entry. Sourced from HCSS HeavyJob cost coding module and aligned with SAP S/4HANA job costing.',
    `crew_id` BIGINT COMMENT 'Reference to the crew or gang assigned to execute the production work for this entry. Links to workforce domain for labor cost and productivity analysis.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: production_entry contains a daily_log_reference string that points to a daily log; adding a proper FK (daily_log_id) normalizes the model and eliminates the redundant column.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Production entries record quantities installed against specific drawing revisions — essential for as-built documentation, progress payment claims, and QA sign-off. Contract administrators require draw',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Material consumption tracking: production entries record installed quantities of specific materials. Linking to material_catalog enables budget vs actual material usage reporting, procurement lead-tim',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Production entries record work performed under high-risk conditions requiring an active PTW. Regulatory compliance and HSE audits require verifying that production was only recorded against valid, app',
    `progress_update_id` BIGINT COMMENT 'Foreign key linking to schedule.progress_update. Business justification: Production entries (installed quantities, production rates) are the quantitative basis for schedule progress updates. The progress_update BCWP and percent_complete are derived from production_entry re',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone on site where production was executed. Enables spatial breakdown of production progress across the site.',
    `approved_by` STRING COMMENT 'Name or identifier of the site engineer, superintendent, or project manager who approved this production entry. Required for audit trail and progress billing authorization.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry was formally approved by the authorized reviewer. Marks the transition from submitted to approved status and triggers downstream earned value and billing computations.',
    `budgeted_production_rate` DECIMAL(18,2) COMMENT 'The planned or budgeted production rate for this activity and cost code expressed as units per labor-hour. Sourced from the project estimate and HCSS HeavyJob budget. Used to compute production efficiency variance against actual production_rate.',
    `budgeted_quantity` DECIMAL(18,2) COMMENT 'The total budgeted or planned quantity for this activity and cost code as established in the project budget and BOQ (Bill of Quantities). Used as the denominator for percent complete calculation and EVM (Earned Value Management) analysis.',
    `change_order_reference` STRING COMMENT 'Reference number of the approved Change Order (CO) that authorized a scope or quantity revision reflected in this production entry. Links production tracking to contract administration for cost and schedule impact analysis.',
    `cost_code` STRING COMMENT 'The alphanumeric cost code string from HCSS HeavyJob used to classify the type of work for job costing and budget tracking. Aligns with SAP S/4HANA cost element structure.',
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
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry was submitted for approval by the field team. Used for workflow SLA tracking and audit trail.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Recorded ambient temperature in degrees Celsius at the work front on the entry date. Used to assess weather-related productivity impacts, validate concrete pour conditions per ACI standards, and support EOT (Extension of Time) claims.',
    `unit_of_measure` STRING COMMENT 'The unit of measure applicable to the installed_quantity and budgeted_quantity fields (e.g., CY for cubic yards, LF for linear feet, SF for square feet, EA for each, TON, M3, M2). Sourced from the BOQ (Bill of Quantities) and HCSS HeavyJob. [ENUM-REF-CANDIDATE: CY|LF|SF|EA|TON|M3|M2|LM|KG|HR — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry record was last modified. Tracks revisions to production quantities, status changes, or corrections. Used for data lineage and change audit trail.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition on site during the production entry date. Recorded to support analysis of weather impacts on productivity, substantiate Extension of Time (EOT) claims, and validate production rate variances. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|snow|fog|extreme_heat|wind — 8 candidates stripped; promote to reference product]',
    `work_front_location` STRING COMMENT 'Descriptive location identifier for the work front or zone where production was executed (e.g., Zone A — Grid 1-5, Pier 3 Foundation, Runway 2 Subbase). Supports spatial analysis and site logistics planning.',
    `work_item_description` STRING COMMENT 'Human-readable description of the specific work item or scope of work being tracked in this production entry (e.g., Concrete pour — Column Grid A1-A5, Earthworks cut — Zone 3). Sourced from BOQ (Bill of Quantities) or activity description.',
    CONSTRAINT pk_production_entry PRIMARY KEY(`production_entry_id`)
) COMMENT 'Granular production tracking record capturing quantities of work completed per activity, cost code, and work front for a specific date. Sourced from HCSS HeavyJob production tracking module. Stores installed quantity, unit of measure, production rate (units/hour), budgeted quantity, percent complete, crew size, equipment hours consumed, and cost code. Feeds earned value computation and progress billing in the project and finance domains.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`crew_deployment` (
    `crew_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for each daily crew deployment record. Primary key for the crew_deployment data product in the site domain Silver layer.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity (Work Breakdown Structure task) from Oracle Primavera P6 to which this crew is assigned. Enables schedule performance tracking and earned value computation.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Crew deployment plans include equipment assigned to each crew; needed for resource planning and equipment utilisation tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this crew deployment is recorded. Links deployment records to project-level earned value and cost control.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Daily crew deployment records must reference the crew master for productivity tracking, payroll reconciliation, and HSE reporting. crew_code and crew_name are denormalized from workforce.crew. Every c',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: crew_deployment records reference a daily log via the string field daily_log_reference; converting to a proper FK (daily_log_id) enforces referential integrity and removes the redundant string column.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Crew deployment cost tracking uses finance cost codes to aggregate labor costs per activity for payroll and project costing.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Lead foreman HSE accountability, certification compliance checks, and supervisory payroll reporting require linking the foreman to the craft_worker master. Role-prefix lead_foreman_ used because con',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Crew deployment is planned and reported by project phase for phase-level manpower histograms and resource leveling. Phase-gate reviews require labor deployment data aggregated per phase.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Subcontractor crew deployments are governed by subcontract purchase orders. Linking crew_deployment to purchase_order enables subcontractor cost tracking, progress payment certification, and verificat',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Subcontractor crew deployments are governed by a subcontract that specifies labour obligations, rates, and compliance requirements. Linking crew_deployment to subcontract enables subcontractor labour ',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Every crew deployment requires an approved SWMS for the work activity — a WHS Act obligation. HSE compliance reports verify each deployment had a valid SWMS. swms_reference is a denormalized text fi',
    `toolbox_meeting_id` BIGINT COMMENT 'Foreign key linking to safety.toolbox_meeting. Business justification: Toolbox meetings are conducted at the start of each crew deployment shift. hse_toolbox_meeting_held is a boolean flag with no traceability to the actual TBM record. HSE compliance reporting requires',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Crew deployment labor costs are charged to WBS elements for cost account reconciliation. crew_deployment has wbs_code as denormalized text; proper FK enables WBS-level labor cost reporting and times',
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
    `permit_to_work_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) issued for this crew deployment, where the work activity requires a formal permit (e.g., hot work, confined space, excavation). Sourced from Intelex HSE management system.',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this crew deployment record was last modified in the data platform. Supports incremental data processing, audit trails, and change detection in the Silver layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition recorded on site for this deployment date, as captured in the Procore daily log. Impacts productivity analysis, delay claims, and Extension of Time (EOT) documentation. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|wind|fog|snow|extreme_heat — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_crew_deployment PRIMARY KEY(`crew_deployment_id`)
) COMMENT 'Daily assignment record linking a named crew or gang to a specific work front, activity, and cost code for a given date. Captures crew type (civil, MEP, concrete, steel erection), crew size, lead foreman, shift start/end times, overtime flag, productivity notes, and planned vs actual hours. Sourced from HCSS HeavyJob time tracking. Holds mandatory FK to work_front for spatial allocation. Distinct from workforce domain employee records — this entity tracks the operational deployment of crews to site activities, not individual labor records.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`concrete_pour` (
    `concrete_pour_id` BIGINT COMMENT 'Unique system-generated identifier for each concrete pour event on site. Primary key for the concrete_pour data product.',
    `batch_lot_id` BIGINT COMMENT 'Foreign key linking to material.batch_lot. Business justification: Concrete pours consume a specific batch/lot of concrete mix. Linking pour to batch_lot enables QA traceability from structural element back to batch test results and conformance certificates — a manda',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this concrete pour event is executed.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Concrete pour records must be linked to the structural drawing defining pour locations for inspection and handover.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Concrete pour entries are charged to specific cost codes; linking enables accurate cost tracking and progress billing.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Ready-mix concrete deliveries generate goods receipts in procurement. Linking concrete_pour to goods_receipt enables reconciliation of poured volumes against received volumes per GR, supporting invoic',
    `itp_id` BIGINT COMMENT 'Reference to the Inspection and Test Plan (ITP) record in the quality domain governing the quality hold and inspection requirements for this pour.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: Each concrete pour uses an approved mix design that is a material master record. Role-prefix mix_design_ used because concrete_pour already links to batch_lot (same domain). Links pour to approved m',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: REQUIRED: Concrete pour supervision is assigned to a qualified foreman; FK supports QC, safety audit trails and traceability of pour responsibility.',
    `daily_log_id` BIGINT COMMENT 'Reference identifier of the Procore daily log entry in which this pour event was recorded. Enables cross-system traceability between the lakehouse silver layer and the Procore source system.',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Concrete pours are milestone-triggering events (e.g., first floor slab pour complete triggers a payment milestone). Linking pour records to milestones enables milestone payment certification backed ',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: Concrete mix design submittals must be approved before any pour commences — a regulatory and contractual QA requirement. Linking each pour to its approved mix design submittal enables pour-authorizati',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Concrete pours are high-risk activities requiring a specific SWMS (formwork, placement, confined space). HSE compliance audits and incident investigations require traceability from each pour to its go',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Concrete pours are executed and inspected against technical specifications defining mix design, specified strength, curing methods, and testing requirements. QA/QC inspectors verify pour compliance ag',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Ready-mix supplier performance tracking per pour: construction QC and procurement teams track on-time delivery, slump compliance, and defect rates by supplier. batch_plant_name is a denormalized vendo',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: A concrete pour event occurs at a specific work front (zone, area, or structural face). concrete_pour has grid_reference and structure_element as string descriptors but no FK to the work_front master ',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Recorded ambient air temperature in degrees Celsius at the time of the pour. Critical for hot and cold weather concreting compliance, curing regime decisions, and QA/QC records.',
    `concrete_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the fresh concrete measured at point of delivery (truck discharge), in degrees Celsius. Must comply with specification limits for hot/cold weather concreting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this concrete pour record was first created in the system. Used for audit trail, data lineage, and silver layer ingestion tracking.',
    `curing_method` STRING COMMENT 'Method applied to cure the concrete after placement to ensure adequate hydration and strength development. Compliance with specified curing method is a QA/QC requirement.. Valid values are `wet_hessian|curing_compound|ponding|steam|membrane|other`',
    `curing_start_time` TIMESTAMP COMMENT 'Date and time when curing operations commenced after completion of the pour. Used to calculate curing duration compliance against specification requirements.',
    `cylinder_set_reference` STRING COMMENT 'Unique reference number or label assigned to the set of test cylinders cast from this pour, used to track specimens through the laboratory testing process and link results back to the pour event.',
    `delivery_docket_numbers` STRING COMMENT 'Comma-separated list of concrete delivery docket (batch ticket) numbers associated with this pour event. Provides full traceability from batch plant to placement location per QA/QC requirements.',
    `formwork_drawing_ref` STRING COMMENT 'Reference number of the approved formwork or structural drawing used for this pour, as registered in Autodesk BIM 360 or Aconex document management. Provides design traceability.',
    `grid_reference` STRING COMMENT 'Structural grid reference (e.g., A3-B4) or coordinate reference identifying the precise location of the pour on the site drawing or BIM model. Enables spatial traceability and clash detection correlation.',
    `hcss_production_code` STRING COMMENT 'Reference identifier of the HCSS HeavyJob production tracking record associated with this pour event. Enables cross-system traceability for cost coding and production rate analysis.',
    `ncr_number` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) raised against this pour event if a quality non-conformance was identified. Null if no NCR has been raised.',
    `placement_method` STRING COMMENT 'Method used to place the concrete into the formwork. Affects production rate, quality, and equipment resource planning. Examples: pump (boom pump or line pump), crane and bucket, conveyor belt, direct chute.. Valid values are `pump|crane_bucket|conveyor|direct_chute|other`',
    `pour_date` DATE COMMENT 'Calendar date on which the concrete pour was executed on site. Used for daily log correlation, schedule progress reporting, and curing period calculations.',
    `pour_end_time` TIMESTAMP COMMENT 'Date and time when the last concrete delivery was placed and finishing operations completed, marking the end of the pour event. Used for duration calculation and curing start time.',
    `pour_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the pour event, used in daily logs, QA/QC records, and delivery dockets. Sourced from Procore daily logs and HCSS HeavyJob production tracking.. Valid values are `^PC-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `pour_start_time` TIMESTAMP COMMENT 'Date and time when the first concrete delivery was placed into the formwork, marking the official start of the pour event. Used for duration calculation and ambient condition correlation.',
    `pour_status` STRING COMMENT 'Current lifecycle status of the concrete pour event. on_hold indicates a QC hold has been applied pending inspection release. Drives QA/QC workflow and earned value computation.. Valid values are `planned|in_progress|completed|on_hold|cancelled|rejected`',
    `pour_type` STRING COMMENT 'Classification of the structural element type being poured. Used for production benchmarking, resource planning, and QA/QC ITP selection. [ENUM-REF-CANDIDATE: slab|column|beam|wall|footing|pile_cap|bridge_deck|other — promote to reference product]',
    `qc_hold_status` STRING COMMENT 'Quality Control (QC) hold status for this pour event. hold_applied means the pour is under QC review pending inspection or test results. hold_released means the hold has been cleared by the QA/QC engineer. rejected means the pour has been condemned and remediation is required.. Valid values are `no_hold|hold_applied|hold_released|rejected`',
    `qc_inspector` STRING COMMENT 'Name of the Quality Control (QC) inspector who witnessed the pour, conducted slump tests, and cast test cylinders. Required for QA/QC traceability and ITP sign-off.',
    `relative_humidity_pct` DECIMAL(18,2) COMMENT 'Recorded relative humidity percentage at the pour location at time of placement. Relevant for evaporation rate calculations and plastic shrinkage cracking risk assessment per ACI 305R.',
    `slump_compliant` BOOLEAN COMMENT 'Indicates whether the measured slump result falls within the specified minimum and maximum limits. True = compliant; False = non-compliant, triggering QC review or NCR.',
    `slump_specified_max_mm` DECIMAL(18,2) COMMENT 'Maximum allowable slump value in millimetres as specified in the concrete mix design or project specification. Exceedance triggers rejection or NCR issuance.',
    `slump_specified_min_mm` DECIMAL(18,2) COMMENT 'Minimum allowable slump value in millimetres as specified in the concrete mix design or project specification. Used for QC acceptance/rejection decisions.',
    `slump_test_result_mm` DECIMAL(18,2) COMMENT 'Measured slump value in millimetres from the slump cone test performed on a representative sample of fresh concrete at point of delivery. Indicates workability and water-cement ratio compliance.',
    `specified_strength_mpa` DECIMAL(18,2) COMMENT 'Design-specified characteristic compressive strength of the concrete in megapascals (MPa) at 28 days, as defined in the structural drawings and specification. Used for QC acceptance criteria.',
    `structure_element` STRING COMMENT 'Name or designation of the structural element being poured, such as Pile Cap PC-01, Column C3, Slab Level 4, Retaining Wall RW-02. Provides traceability to design drawings and BIM model elements.',
    `test_cylinders_cast` STRING COMMENT 'Number of concrete test cylinders (or cubes) cast from this pour for compressive strength testing at specified curing ages (e.g., 7-day, 28-day). Minimum count is governed by specification and ACI/ASTM standards.',
    `truck_load_count` STRING COMMENT 'Total number of ready-mix concrete truck loads (agitator trucks) delivered and placed during this pour event. Used for logistics planning, docket reconciliation, and production rate analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this concrete pour record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks lakehouse silver layer.',
    `volume_poured_m3` DECIMAL(18,2) COMMENT 'Total volume of concrete placed during this pour event, measured in cubic metres (m³). Derived from delivery docket quantities and used for earned value computation, material reconciliation, and production tracking in HCSS HeavyJob.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition recorded at the time of the pour. Used for hot/cold weather concreting compliance assessment and daily log documentation.. Valid values are `clear|cloudy|rain|high_wind|extreme_heat|extreme_cold`',
    `wind_speed_kmh` DECIMAL(18,2) COMMENT 'Recorded wind speed in kilometres per hour at the pour location at time of placement. Used in evaporation rate nomograph calculations to assess plastic shrinkage cracking risk.',
    CONSTRAINT pk_concrete_pour PRIMARY KEY(`concrete_pour_id`)
) COMMENT 'Detailed record of each concrete pour event on site, capturing pour date, pour location (structure element, grid reference), mix design code, specified compressive strength (MPa/PSI), volume poured (m³/yd³), batch plant source, delivery docket numbers, pour start/end time, ambient temperature, slump test results, number of test cylinders cast, and QC hold status. Integrates with quality domain ITP records and material domain batch traceability.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`field_progress` (
    `field_progress_id` BIGINT COMMENT 'Unique surrogate identifier for each field progress measurement record in the silver layer lakehouse. Primary key for the field_progress data product.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: BIM-based progress tracking links field measurements to specific BIM model elements for 4D/5D reporting. bim_element_reference is a plain-text denormalization; a proper FK to bim_model enables BIM-i',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project under which this field progress measurement is captured. Enables project-level aggregation of earned value and progress reporting.',
    `cost_code_id` BIGINT COMMENT 'Reference to the HCSS HeavyJob cost code associated with this progress measurement. Enables cost-to-progress reconciliation and production rate analysis by cost code.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Field progress measurements are taken against specific drawing revisions (IFC drawings). Progress reports and as-built documentation require knowing which drawing revision governed the measured work —',
    `earned_value_record_id` BIGINT COMMENT 'Foreign key linking to finance.earned_value_record. Business justification: EVM reporting directly consumes field_progress percent_complete and installed quantities to compute BCWP. Construction cost engineers expect field progress measurements to be traceable to the earned v',
    `itp_line_id` BIGINT COMMENT 'Reference to the ITP (Inspection and Test Plan) checkpoint that must be satisfied before this progress measurement can be approved. Ensures QA/QC hold points are cleared prior to progress being recognised in EVM.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Field progress measurements for high-risk work scopes must reference the active PTW authorising that work. Regulatory compliance requires demonstrating that progress was only recorded under valid perm',
    `daily_log_id` BIGINT COMMENT 'The source system identifier of the Procore daily log entry from which this field progress measurement was derived or linked. Enables traceability back to the originating daily log record in Procore for audit and reconciliation purposes.',
    `production_entry_id` BIGINT COMMENT 'The source system identifier of the HCSS HeavyJob production tracking record associated with this field progress measurement. Enables reconciliation between field production data and cost coding in HeavyJob.',
    `progress_billing_id` BIGINT COMMENT 'Foreign key linking to finance.progress_billing. Business justification: Progress billing certification process: payment applications reference specific field progress measurements as substantiation for the current_period_claim. Contract administrators and quantity surveyo',
    `progress_update_id` BIGINT COMMENT 'Foreign key linking to schedule.progress_update. Business justification: Field progress measurements are the formal input to schedule progress updates in the standard construction progress reporting workflow: field measurement → schedule update → EVM report. This link enab',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Field progress measurements are submitted as evidence for milestone payment claims. Contract administrators link field progress records to payment milestones to substantiate milestone completion and t',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: field_progress contains a string column named work_front which is a denormalized text reference to the work_front entity. Adding work_front_id as a proper FK to site.work_front normalizes this relat',
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
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time at which the field engineer submitted the progress measurement record for review and approval. Used to track measurement reporting timeliness and workflow cycle time.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this field progress measurement record was last modified. Supports incremental data loading in the Databricks lakehouse silver layer and audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition on site at the time of the field progress measurement. Used to contextualise productivity rates and support EOT (Extension of Time) claims where adverse weather impacted progress. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|storm|snow|fog|extreme_heat — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_field_progress PRIMARY KEY(`field_progress_id`)
) COMMENT 'Periodic field progress measurement record capturing percent complete and installed quantities for a WBS activity or BOQ line item as physically measured in the field. Stores measurement date, measurement method (visual estimate, quantity survey, milestone completion, 3D scan comparison), reported percent complete, previous percent complete, incremental progress delta, field engineer name, and approval status. Feeds EVM (Earned Value Management) calculations including BCWP, CPI, and SPI in the project domain. Provides the ground-truth measurement that reconciles against schedule domain planned progress.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`equipment_deployment` (
    `equipment_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment deployment record in the site domain. Primary key for the equipment_deployment data product.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity or Work Breakdown Structure (WBS) element in the project schedule to which this equipment deployment is assigned.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment master record in the equipment domain. Identifies the specific piece of construction equipment (e.g., excavator, crane, compactor) deployed to site.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project master record. Links the equipment deployment to the construction project under which the equipment is being utilized.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Equipment usage charges are posted to finance cost codes; linking enables equipment cost reporting and asset depreciation.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: Equipment deployment records must reconcile against the fleet assignment that authorized the equipments presence on site — governing hire rates, mobilization costs, and assignment period. Cost alloca',
    `hours_id` BIGINT COMMENT 'The source system record identifier from HCSS HeavyJob equipment hours module. Used for data lineage, reconciliation, and incremental load processing from the operational system of record.',
    `maintenance_order_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_order. Business justification: When equipment breaks down on site (breakdown_flag=true on equipment_deployment), a maintenance order is raised. Linking deployment to maintenance_order enables breakdown cost tracking, downtime analy',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Equipment operator license verification, pre-start check accountability, and HSE compliance reporting require linking the operator to the craft_worker master. Role-prefix operator_ distinguishes thi',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Equipment deployment is planned and reported by phase for phase-level cost control and equipment utilization reports. Phase-level equipment cost allocation is required for project controls and client ',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to equipment.inspection_record. Business justification: Pre-start inspection compliance is a regulatory HSE requirement before deploying equipment on site (pre_start_check_flag exists on equipment_deployment). Linking to the specific inspection_record that',
    `daily_log_id` BIGINT COMMENT 'Reference identifier of the Procore daily log entry from which this equipment deployment record was sourced. Enables traceability back to the source construction management system.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Equipment rental or purchase orders are linked to each deployment for cost allocation and compliance reporting.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Plant and equipment deployments require a SWMS covering machinery operation hazards. hse_permit_number is a text field referencing a PTW, not a SWMS. HSE audits require traceability from each equipm',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Hired/rented equipment deployments must be traceable to the rental vendor for cost reconciliation, insurance verification, and vendor performance reporting. supplier_name is a denormalized vendor refe',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Equipment costs are allocated to WBS elements for project cost control and EVM. Equipment deployment records must reference WBS elements for cost posting to project accounts; no existing FK from equip',
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
    `hse_permit_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) or HSE permit associated with this equipment deployment, where required by site safety regulations (e.g., crane lifts, confined space operations). Links to the Intelex HSE management system.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was on-site but not in productive operation (e.g., waiting for materials, weather delays, operator breaks). Idle hours are tracked separately from operating hours for utilization analysis.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was in productive operation during the shift or reporting period. Used for earned value computation, equipment cost allocation, and maintenance scheduling.',
    `operator_license_number` STRING COMMENT 'The certification or license number of the equipment operator, required for regulated equipment types (e.g., crane operators, forklift operators). Supports OSHA and ISO 45001 compliance verification.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`material_delivery` (
    `material_delivery_id` BIGINT COMMENT 'Unique surrogate identifier for each material delivery receipt event recorded at the construction site. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `batch_lot_id` BIGINT COMMENT 'Foreign key linking to material.batch_lot. Business justification: Construction material deliveries are received as specific batch/lot numbers for quality traceability (test certificates, conformance certs). FK to batch_lot enables end-to-end traceability from site r',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: Material deliveries are field events that occur on a specific date and are captured in the daily site log. Linking material_delivery to daily_log enables the daily log to aggregate all deliveries rece',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material delivery records must map to finance cost codes for material cost allocation and inventory valuation.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Material delivery and goods receipt represent the same physical event from site and procurement perspectives. This link is essential for three-way match (PO→GR→Invoice), quantity variance reporting, a',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Material deliveries must reference the procurement material master for catalog-level delivery analytics, inspection requirement enforcement, and shelf-life/storage condition compliance. material_code ',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: Every site material delivery is of a specific approved material master record. Links delivery to canonical spec for conformance verification, procurement reporting, and material traceability — a funda',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this material delivery belongs. Links the physical receipt event to the project context for cost coding and earned value computation.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the materials. Links to the procurement domain supplier master for vendor performance tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the procurement domain Purchase Order (PO) against which this delivery was made. Enables reconciliation between the physical receipt event and the contractual procurement record.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to material.warehouse. Business justification: Material deliveries are received into a specific warehouse or laydown area. FK to material.warehouse enables inventory management — tracking where delivered materials are stored, supporting stock reco',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Material deliveries are received at the construction site gate or designated laydown area. material_delivery currently has no FK to site.site, making it impossible to directly associate deliveries wit',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Material deliveries under supply subcontracts must be traceable to the governing subcontract for subcontractor payment verification, performance tracking, and procurement compliance. material_delivery',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: Deliveries are matched to approved design submittals to verify material compliance before acceptance.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Materials are received and inspected against technical specifications defining material requirements, test certificate standards, and acceptance criteria. Receiving inspectors verify delivered materia',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Materials are delivered to support specific work fronts on site. Linking material_delivery to work_front enables work-front-level material consumption tracking, supports cost code reconciliation (mate',
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
    `material_category` STRING COMMENT 'High-level classification of the material type delivered. Supports site logistics planning, laydown zone assignment, and HSE compliance for hazardous materials. MEP refers to Mechanical, Electrical, and Plumbing materials. [ENUM-REF-CANDIDATE: concrete|steel|timber|aggregates|MEP|civil|finishing|hazardous|other — promote to reference product]',
    `msds_verified` BOOLEAN COMMENT 'Indicates whether the Material Safety Data Sheet (MSDS) or Safety Data Sheet (SDS) was verified and on file at the time of receipt for hazardous materials. Required for OSHA HazCom compliance and site HSE management.',
    `ncr_reference` STRING COMMENT 'The reference number of the Non-Conformance Report (NCR) raised as a result of a rejected or non-conforming delivery. Links the physical receipt event to the quality management process for corrective action tracking.',
    `po_line_number` STRING COMMENT 'The specific line item number on the Purchase Order (PO) to which this delivery relates. Enables precise three-way matching at the line level between the PO, goods receipt, and supplier invoice.',
    `procore_log_reference` STRING COMMENT 'The reference identifier of the associated Procore daily log entry in which this material delivery was recorded. Enables traceability back to the source system of record for field management and audit purposes.',
    `quantity_accepted` DECIMAL(18,2) COMMENT 'The quantity of material formally accepted after inspection at the point of receipt. May be less than quantity_delivered in cases of partial acceptance due to damage, non-conformance, or specification mismatch. Triggers stock update in the materials domain.',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'The actual quantity of material physically received at the site as measured or counted at the point of receipt. This is the principal quantitative fact for the delivery event and is used to update material stock records and reconcile against the PO quantity.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material that was ordered on the associated Purchase Order (PO) line for this delivery. Enables immediate over/under delivery variance calculation at the point of receipt without requiring a join to the procurement domain.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of material rejected at the point of receipt due to damage, non-conformance with specification, or incorrect material. Triggers a Non-Conformance Report (NCR) and return-to-supplier process.',
    `receipt_condition` STRING COMMENT 'The physical condition of the material as assessed at the point of receipt. Drives the acceptance/rejection decision and informs quality control processes. [ENUM-REF-CANDIDATE: good|damaged|wet|contaminated|incorrect_spec|short_delivered — promote to reference product]. Valid values are `good|damaged|wet|contaminated|incorrect_spec|short_delivered`',
    `receiving_inspector` STRING COMMENT 'The full name of the site personnel who physically received and inspected the delivery at the site gate or laydown area. This individual is accountable for the acceptance/rejection decision recorded on the delivery docket.',
    `temperature_sensitive` BOOLEAN COMMENT 'Indicates whether the delivered material requires temperature-controlled storage conditions (e.g., epoxy resins, certain adhesives, bituminous products, or cold-chain materials). When True, triggers special handling and storage protocols on site.',
    `test_certificate_number` STRING COMMENT 'The reference number of the material test certificate or mill certificate provided by the supplier with the delivery. Confirms that the material meets the specified engineering standards and is required for quality assurance sign-off.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the delivered quantity is expressed (e.g., cubic metres for concrete, tonnes for steel, each for prefabricated elements). Must align with the unit specified on the Purchase Order (PO) for reconciliation. [ENUM-REF-CANDIDATE: m3|tonne|kg|m|m2|EA|L|bag|roll|set — promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'The agreed unit price for the material as per the Purchase Order (PO), expressed in the project currency. Used to calculate the value of the delivery for goods receipt posting and cost accrual in the project financial management system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this material delivery record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `vehicle_registration` STRING COMMENT 'The registration plate number of the delivery vehicle. Recorded at the site gate for security, access control, and logistics tracking purposes.',
    CONSTRAINT pk_material_delivery PRIMARY KEY(`material_delivery_id`)
) COMMENT 'Site-level record of material deliveries received at the construction site gate or designated laydown area. Captures delivery date, supplier name, PO reference (FK to procurement domain), delivery docket number, material description, quantity delivered, unit of measure, receiving location (laydown zone per site_logistics_plan), condition on receipt (accepted/rejected/partial), receiver name, temperature-sensitive storage flag, and discrepancy notes. Distinct from procurement domain PO records — this entity captures the physical receipt event at the site and triggers material domain stock updates.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`permit` (
    `permit_id` BIGINT COMMENT 'System generated unique identifier for the site permit record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Permit compliance and cost allocation are reported against the owning client account; linking permits to client.account provides traceability.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Permits (e.g., crane, excavation) are required for particular scheduled activities; linking permits to activity supports compliance reporting.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Site permits are authorized under a head contract/agreement. Contract administrators must verify that permitted work scope aligns with the agreement. Regulatory compliance audits require tracing each ',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Site permits are issued per project for regulatory compliance tracking and project closeout documentation. A compliance officer must retrieve all permits for a project; site_permit currently has no di',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Permit fees are charged to cost centers for project overhead tracking. site_permit has a plain cost_center_code column that is a denormalized reference to finance.cost_center. Replacing with a proper ',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Construction and environmental permit applications universally reference specific drawings to define the physical extent and scope of permitted activities. Regulatory authorities require drawing refer',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Permits are phase-specific (excavation permit for civil phase, structural permit for superstructure phase). Phase-level permit register is a regulatory compliance requirement; authorities issue and tr',
    `renewed_site_permit_id` BIGINT COMMENT 'Self-referencing FK on site_permit (renewed_site_permit_id)',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Site permits (environmental, safety-critical) must be issued based on a formal risk assessment — a regulatory compliance requirement. Linking enables auditors to verify that every permit was supported',
    `schedule_milestone_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_milestone. Business justification: Site permits (environmental, access, occupancy) are prerequisites for or evidence of milestone achievement. Linking site_permit to the milestone it gates or enables supports critical path management, ',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A site permit governs permission to execute specific work activities at a construction site. site_permit currently links to work_front (for work-front-specific permits) but has no direct FK to site.si',
    `work_front_id` BIGINT COMMENT 'Identifier of the work front to which the permit applies.',
    `application_date` DATE COMMENT 'Date the permit application was submitted.',
    `approval_date` DATE COMMENT 'Date the permit was approved and became effective.',
    `attached_document_reference` STRING COMMENT 'Identifier of the digital file storing the original permit document.',
    `permit_category` STRING COMMENT 'High‑level classification of the permit purpose.. Valid values are `safety|environment|operational`',
    `change_order_number` STRING COMMENT 'Reference to a change order that modifies the permit scope or conditions.',
    `close_out_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit was formally closed after work completion.',
    `compliance_reference` STRING COMMENT 'Reference to the specific regulation or standard (e.g., OSHA 29 CFR 1926.55).',
    `conditions` STRING COMMENT 'Textual description of conditions or restrictions imposed by the authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `expiration_notice_sent` BOOLEAN COMMENT 'True if an expiry notice has been sent to the responsible party.',
    `expiry_date` DATE COMMENT 'Date the permit expires or must be renewed.',
    `extension_approved_date` DATE COMMENT 'Date an extension to the permit was approved.',
    `extension_requested` BOOLEAN COMMENT 'Indicates whether an extension to the permit expiry has been requested.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the permit, if applicable.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the permit fee.',
    `is_environmental` BOOLEAN COMMENT 'True if the permit involves environmental impact (e.g., discharge, noise).',
    `is_safety_critical` BOOLEAN COMMENT 'Indicates whether the permit relates to a safety‑critical activity.',
    `issuing_authority` STRING COMMENT 'Regulatory body or organization that issued the permit.. Valid values are `OSHA|local_building_department|environmental_agency|other`',
    `permit_number` STRING COMMENT 'External reference number assigned by the issuing authority.',
    `permit_type` STRING COMMENT 'Category of work the permit authorizes. Includes common types; other types are captured in the conditions field.. Valid values are `hot_work|excavation|confined_space|crane_operation|road_closure|environmental_discharge`',
    `restrictions` STRING COMMENT 'Specific operational restrictions (e.g., temperature limits, PPE requirements).',
    `revision_number` STRING COMMENT 'Sequential revision number for amended permits.',
    `scope_description` STRING COMMENT 'Narrative describing the specific work scope covered by the permit.',
    `site_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `applied|active|suspended|closed|revoked`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the permit record.',
    `version` STRING COMMENT 'Alphanumeric version label (e.g., v1, v2a).',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Regulatory permit or access authorization record governing permission to execute specific work activities on a construction site. Captures permit type (hot work, excavation, confined space entry, crane operation, road closure, environmental discharge, noise variance), permit number, issuing authority, application date, approval date, expiry date, conditions/restrictions, associated work front, responsible person, permit status (applied/active/suspended/closed), and close-out sign-off. Required under OSHA 29 CFR 1926, local building codes, and environmental regulations. Provides the compliance gate that must be satisfied before work commences on regulated activities.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client account ownership of a site is fundamental to billing, access control, and client-facing site reporting. Construction domain experts universally expect a site to be attributed to a commissionin',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the site belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Construction sites are managed as cost centers for overhead allocation and site establishment cost reporting. site has a plain cost_center_code column that is a denormalized reference to finance.cost_',
    `current_location_site_id` BIGINT COMMENT 'Self-referencing FK on site (current_location_site_id)',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: Pipeline-to-execution traceability: a site is mobilised as a direct result of winning a client opportunity. BD and project controls teams require this link for win-rate analysis, opportunity-to-site c',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite or building).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total built‑up area of the site in square feet.',
    `site_category` STRING COMMENT 'High‑level business category of the site.',
    `city` STRING COMMENT 'City where the site is located.',
    `site_code` STRING COMMENT 'External business identifier or code assigned to the site.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the site location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the system.',
    `crew_capacity` STRING COMMENT 'Maximum number of crew members that can be assigned to the site simultaneously.',
    `demobilization_date` DATE COMMENT 'Date when the site was demobilized.',
    `site_description` STRING COMMENT 'Free‑form description of the site, including notes on purpose or special characteristics.',
    `end_date` DATE COMMENT 'Date when the site was closed or demobilized (nullable).',
    `environmental_permit_number` STRING COMMENT 'Identifier of the environmental permit associated with the site.',
    `gps_accuracy_m` STRING COMMENT 'Estimated accuracy of the GPS coordinates in meters.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `is_mobilized` BOOLEAN COMMENT 'Indicates whether the site is currently mobilized for work.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site location.',
    `mobilization_date` DATE COMMENT 'Date when the site was mobilized.',
    `site_name` STRING COMMENT 'Human‑readable name of the construction site.',
    `owner` STRING COMMENT 'Organization that owns the site.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the environmental permit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `region` STRING COMMENT 'Broad geographic region where the site is located.',
    `safety_incident_count` STRING COMMENT 'Cumulative number of safety incidents recorded at the site.',
    `site_status` STRING COMMENT 'Current lifecycle state of the site.',
    `site_type` STRING COMMENT 'Classification of the site based on its primary function.',
    `start_date` DATE COMMENT 'Date when the site became operational or was mobilized.',
    `state` STRING COMMENT 'State or province of the site location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by current_location_site_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_production_entry_id` FOREIGN KEY (`production_entry_id`) REFERENCES `vibe_construction_v1`.`site`.`production_entry`(`production_entry_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_renewed_site_permit_id` FOREIGN KEY (`renewed_site_permit_id`) REFERENCES `vibe_construction_v1`.`site`.`permit`(`permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_current_location_site_id` FOREIGN KEY (`current_location_site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`site` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`site` SET TAGS ('dbx_domain' = 'site');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `access_restriction` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `access_restriction` SET TAGS ('dbx_value_regex' = 'unrestricted|permit_required|restricted_zone|exclusion_zone');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `actual_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Actual Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `actual_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Work Front Area (Square Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_value_regex' = 'standard|sensitive|protected|remediation_required');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `forecast_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_code` SET TAGS ('dbx_business_glossary_term' = 'Work Front Code');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_name` SET TAGS ('dbx_business_glossary_term' = 'Work Front Name');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_status` SET TAGS ('dbx_business_glossary_term' = 'Work Front Status');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_status` SET TAGS ('dbx_value_regex' = 'active|inactive|mobilizing|demobilized|suspended|completed');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_type` SET TAGS ('dbx_business_glossary_term' = 'Work Front Type');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `grid_reference` SET TAGS ('dbx_business_glossary_term' = 'Site Grid Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `heavyjob_cost_center` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Cost Center');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Method (CPM) Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `is_subcontracted` SET TAGS ('dbx_business_glossary_term' = 'Subcontracted Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Planned Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `procore_location_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Location ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single|double|rotating|night_only|continuous');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `weather_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Weather Sensitivity Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `weather_sensitivity` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Zone Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `concrete_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Volume (Cubic Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `direct_labour_count` SET TAGS ('dbx_business_glossary_term' = 'Direct Labour Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `earthworks_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Earthworks Volume (Cubic Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `eot_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `equipment_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Count On Site');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `event_count` SET TAGS ('dbx_business_glossary_term' = 'Line-Item Event Count');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `has_delay_event` SET TAGS ('dbx_business_glossary_term' = 'Has Delay Event Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `has_safety_observation` SET TAGS ('dbx_business_glossary_term' = 'Has Safety Observation Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `hcss_log_reference` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Log Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_date` SET TAGS ('dbx_business_glossary_term' = 'Log Date');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_number` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Number');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_number` SET TAGS ('dbx_value_regex' = '^DL-[A-Z0-9]+-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_status` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Status');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|void');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `lti_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Occurred Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `ncr_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `overall_site_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Site Status');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `overall_site_status` SET TAGS ('dbx_value_regex' = 'productive|partially_productive|non_productive|shutdown');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `permit_to_work_count` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work Count');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `planned_activities_narrative` SET TAGS ('dbx_business_glossary_term' = 'Planned Activities Narrative');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `precipitation_mm` SET TAGS ('dbx_business_glossary_term' = 'Precipitation (Millimetres)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `procore_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Superintendent Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|double_shift|split');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `site_access_status` SET TAGS ('dbx_business_glossary_term' = 'Site Access Status');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `site_access_status` SET TAGS ('dbx_value_regex' = 'open|restricted|closed|partial');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `subcontractor_count` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `superintendent_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Superintendent Sign-Off Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `temperature_high_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `temperature_low_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `total_delay_duration_hrs` SET TAGS ('dbx_business_glossary_term' = 'Total Delay Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `total_manpower_count` SET TAGS ('dbx_business_glossary_term' = 'Total Manpower Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `visitor_count` SET TAGS ('dbx_business_glossary_term' = 'Site Visitor Count');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `wind_speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Kilometres per Hour)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `work_performed_narrative` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Narrative');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `production_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Production Entry ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `budgeted_production_rate` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Production Rate (Units per Hour)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `budgeted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `cumulative_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Number');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Status');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|voided');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `equipment_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `is_baseline_revision` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Revision Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `is_rework` SET TAGS ('dbx_business_glossary_term' = 'Is Rework Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `itp_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (%)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `production_rate` SET TAGS ('dbx_business_glossary_term' = 'Production Rate (Units per Hour)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Production Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `work_front_location` SET TAGS ('dbx_business_glossary_term' = 'Work Front Location');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `work_item_description` SET TAGS ('dbx_business_glossary_term' = 'Work Item Description');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Deployment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Foreman Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `actual_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Number');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|suspended');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `hse_toolbox_meeting_held` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Toolbox Meeting (TBM) Held Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `is_subcontractor_crew` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Crew Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `is_weather_impacted` SET TAGS ('dbx_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'mobilizing|on_site|demobilizing|demobilized');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work Number');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `planned_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `ppe_compliance` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `productivity_notes` SET TAGS ('dbx_business_glossary_term' = 'Productivity Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `productivity_rate` SET TAGS ('dbx_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|weekend');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `concrete_pour_id` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `batch_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Mix Design Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Pour Supervisor Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `concrete_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Concrete Temperature at Delivery (°C)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `curing_method` SET TAGS ('dbx_business_glossary_term' = 'Concrete Curing Method');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `curing_method` SET TAGS ('dbx_value_regex' = 'wet_hessian|curing_compound|ponding|steam|membrane|other');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `curing_start_time` SET TAGS ('dbx_business_glossary_term' = 'Curing Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `cylinder_set_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Cylinder Set Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `delivery_docket_numbers` SET TAGS ('dbx_business_glossary_term' = 'Delivery Docket Numbers');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `formwork_drawing_ref` SET TAGS ('dbx_business_glossary_term' = 'Formwork Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `grid_reference` SET TAGS ('dbx_business_glossary_term' = 'Grid Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `hcss_production_code` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Production Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `placement_method` SET TAGS ('dbx_business_glossary_term' = 'Concrete Placement Method');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `placement_method` SET TAGS ('dbx_value_regex' = 'pump|crane_bucket|conveyor|direct_chute|other');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_date` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Date');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_end_time` SET TAGS ('dbx_business_glossary_term' = 'Pour End Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_number` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Number');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_number` SET TAGS ('dbx_value_regex' = '^PC-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_start_time` SET TAGS ('dbx_business_glossary_term' = 'Pour Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_status` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Status');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled|rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_type` SET TAGS ('dbx_business_glossary_term' = 'Concrete Pour Type');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `qc_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Hold Status');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `qc_hold_status` SET TAGS ('dbx_value_regex' = 'no_hold|hold_applied|hold_released|rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `qc_inspector` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspector Name');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `relative_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percentage (%)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_compliant` SET TAGS ('dbx_business_glossary_term' = 'Slump Test Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_specified_max_mm` SET TAGS ('dbx_business_glossary_term' = 'Specified Maximum Slump (mm)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_specified_min_mm` SET TAGS ('dbx_business_glossary_term' = 'Specified Minimum Slump (mm)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_test_result_mm` SET TAGS ('dbx_business_glossary_term' = 'Slump Test Result (mm)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `specified_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Specified Compressive Strength (MPa)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `structure_element` SET TAGS ('dbx_business_glossary_term' = 'Structure Element');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `test_cylinders_cast` SET TAGS ('dbx_business_glossary_term' = 'Test Cylinders Cast Count');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `truck_load_count` SET TAGS ('dbx_business_glossary_term' = 'Concrete Truck Load Count');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `volume_poured_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Poured (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition at Pour');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|cloudy|rain|high_wind|extreme_heat|extreme_cold');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `wind_speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (km/h)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Field Progress ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `earned_value_record_id` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Record Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Checkpoint ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `production_entry_id` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Production Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `progress_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Billing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type / Discipline');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `bcwp` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `budget_at_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size (Headcount)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Data Date (Progress Cut-Off Date)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `equipment_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Field Engineer Name');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path (CPM) Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Field Measurement Date');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Field Measurement Method');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_number` SET TAGS ('dbx_business_glossary_term' = 'Field Progress Measurement Number');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|fortnightly|monthly');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `period_installed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Period Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `previous_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Previous Percent Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `progress_delta` SET TAGS ('dbx_business_glossary_term' = 'Progress Delta (Incremental Percent Complete)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `reported_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Reported Percent Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition at Measurement');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('dbx_subdomain' = 'field_execution');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `equipment_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Deployment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hours_id` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Equipment Hours ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Start Inspection Record Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_description` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Description');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_hours` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Reference Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'active|idle|breakdown|demobilized|standby|transferred');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (Liters)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|petrol|lpg|electric|hybrid');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hse_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_business_glossary_term' = 'Operator License Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|subcontractor');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `planned_production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `pre_start_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Start Check Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Deployment Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `rental_order_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Order Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|double');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `site_location_description` SET TAGS ('dbx_business_glossary_term' = 'Site Location Description');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Material Delivery ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `batch_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Receipt Status');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial|pending_inspection|on_hold');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Arrival Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_value` SET TAGS ('dbx_business_glossary_term' = 'Delivery Value');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Docket Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Driver Name');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `itp_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `laydown_zone` SET TAGS ('dbx_business_glossary_term' = 'Laydown Zone');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `msds_verified` SET TAGS ('dbx_business_glossary_term' = 'Material Safety Data Sheet (MSDS) Verified Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `procore_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Procore Daily Log Reference ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_accepted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Accepted');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Delivered');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_rejected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_business_glossary_term' = 'Material Receipt Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_value_regex' = 'good|damaged|wet|contaminated|incorrect_spec|short_delivered');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receiving_inspector` SET TAGS ('dbx_business_glossary_term' = 'Receiving Inspector Name');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receiving_inspector` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `temperature_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Temperature-Sensitive Storage Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `test_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Material Test Certificate Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Material Unit Rate');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_business_glossary_term' = 'Delivery Vehicle Registration Number');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Site Permit ID');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `renewed_site_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Site Permit Id');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `renewed_site_permit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `schedule_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `attached_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_value_regex' = 'safety|environment|operational');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `close_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Close‑out Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `extension_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Approved Date');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `extension_requested` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `is_environmental` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'OSHA|local_building_department|environmental_agency|other');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'hot_work|excavation|confined_space|crane_operation|road_closure|environmental_discharge');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Permit Restrictions');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Revision Number');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Permit Scope Description');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `site_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `site_permit_status` SET TAGS ('dbx_value_regex' = 'applied|active|suspended|closed|revoked');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Permit Version');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `current_location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Site Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `current_location_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Area Sqft');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_category` SET TAGS ('dbx_business_glossary_term' = 'Site Category');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `crew_capacity` SET TAGS ('dbx_business_glossary_term' = 'Crew Capacity');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `gps_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'Gps Accuracy M');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `is_mobilized` SET TAGS ('dbx_business_glossary_term' = 'Is Mobilized');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Site Owner');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
