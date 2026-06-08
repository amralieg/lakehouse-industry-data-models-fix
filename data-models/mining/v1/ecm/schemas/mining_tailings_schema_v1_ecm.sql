-- Schema for Domain: tailings | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`tailings` COMMENT 'Governs tailings storage facility (TSF) operations, waste rock management, geotechnical monitoring, and rehabilitation planning. Tracks dam safety, seepage, raise schedules, and closure liabilities in compliance with ICMM Global Industry Standard on Tailings Management and EIS requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`tsf` (
    `tsf_id` BIGINT COMMENT 'Unique identifier for the Tailings Storage Facility. Primary key for the TSF master register.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Accountable executives for TSFs are key stakeholders requiring engagement tracking for regulatory compliance, consequence classification reviews, and social licence management. Mining operations track',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: TSFs are operational cost centres for AISC reporting, budget allocation, and monthly variance analysis. Every TSF must roll costs to a cost centre for financial reporting and mine-level P&L consolidat',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: TSFs require site-specific emergency response plans per dam safety regulations (ANCOLD, CDA guidelines). Emergency preparedness is mandatory for consequence-classified facilities. Natural 1:N relation',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: TSF site selection, design type, capacity, and consequence classification are critical feasibility study components. TSF capital cost, operating cost, closure liability, and regulatory approval timeli',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: TSF capacity planning, raise schedules, and closure cost estimates are mandatory components of life-of-mine financial models and regulatory reporting. Mine planners integrate tailings infrastructure c',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this TSF is located. Links the facility to its parent mining operation.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: TSFs receive tailings from processing plants treating ore from specific orebodies. Tailings geochemistry, deposition planning, consequence classification, and closure design all depend on source orebo',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: TSFs roll up to mine-site profit centres for segment reporting under IFRS 8. Required for commodity-level profitability analysis and investor reporting of all-in sustaining costs by operating segment.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: TSFs are constructed to contain tailings from specific mining prospects/orebodies. Mine planning, capacity forecasting, and closure planning all require linking TSF facilities to the source prospect. ',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: TSFs store tailings from processing operations producing specific saleable products. Required for closure liability allocation by product, environmental reporting by product line, and full lifecycle c',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: TSFs are constructed on mining tenements. Regulatory reporting (expenditure commitments, environmental conditions, closure planning), land access rights, and financial assurance all require linking th',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: TSF operations require storage of construction materials, monitoring equipment, chemicals, and spare parts. Tracking the designated warehouse location enables inventory management and material plannin',
    `catchment_area_km2` DECIMAL(18,2) COMMENT 'Size of the watershed or catchment area draining into the TSF measured in square kilometers. Critical for water balance calculations and flood risk assessment.',
    `classification_assessment_date` DATE COMMENT 'Date when the consequence classification was last assessed or updated. ICMM GISTM requires regular reassessment of consequence classification.',
    `classification_assessor` STRING COMMENT 'Name and credentials of the qualified professional who conducted the consequence classification assessment.',
    `closure_date` DATE COMMENT 'Date when the TSF was formally closed and ceased receiving tailings. Applicable only to facilities with operational status of closed.',
    `commissioning_date` DATE COMMENT 'Date when the TSF was first commissioned and began receiving tailings. Marks the start of the facility operational life.',
    `consequence_classification` STRING COMMENT 'Risk classification based on potential consequences of failure including loss of life, environmental impact, and economic damage. Classification drives design standards, monitoring frequency, and governance requirements per ICMM GISTM Requirement 3.. Valid values are `extreme|very_high|high|significant|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TSF record was first created in the system. Part of audit trail for data lineage and compliance.',
    `current_capacity_m3` DECIMAL(18,2) COMMENT 'Current available storage capacity of the TSF in cubic meters at the present raise level and configuration. Updated as raises are completed.',
    `current_height_m` DECIMAL(18,2) COMMENT 'Current height of the dam structure measured in meters from the foundation to the crest at the present raise level.',
    `current_raise_level` STRING COMMENT 'Current stage or level of dam raise construction. Tailings dams are typically built in stages called raises, with each raise increasing the height and capacity.',
    `dam_safety_review_frequency_months` STRING COMMENT 'Required frequency of comprehensive dam safety reviews measured in months. Frequency is determined by consequence classification, with higher consequence facilities requiring more frequent reviews.',
    `dam_type` STRING COMMENT 'Construction method and configuration of the tailings dam. Upstream dams are built on top of tailings, downstream dams are built on foundation material, centreline dams combine both methods, dry stack and filtered methods minimize water content.. Valid values are `upstream|downstream|centreline|dry_stack|filtered|other`',
    `design_capacity_m3` DECIMAL(18,2) COMMENT 'Maximum designed storage capacity of the TSF measured in cubic meters. Represents the total volume the facility was engineered to contain at full build-out.',
    `design_height_m` DECIMAL(18,2) COMMENT 'Maximum designed height of the dam structure in meters at full build-out. Represents the ultimate height when all planned raises are completed.',
    `downstream_infrastructure_exposure` STRING COMMENT 'Description of critical infrastructure, facilities, and environmental features located downstream that would be impacted by a dam failure. Includes roads, bridges, utilities, water sources, and ecological assets.',
    `eis_reference` STRING COMMENT 'Reference number or identifier of the Environmental Impact Statement prepared for the TSF. Links to environmental assessment and approval documentation.',
    `emergency_preparedness_plan_reference` STRING COMMENT 'Reference identifier for the Emergency Preparedness and Response Plan specific to this TSF. ICMM GISTM Requirement 15 requires site-specific emergency plans.',
    `engineer_of_record` STRING COMMENT 'Name and credentials of the qualified professional engineer responsible for the design, construction oversight, and ongoing technical review of the TSF. ICMM GISTM Requirement 5 mandates appointment of an EoR.',
    `estimated_closure_liability_usd` DECIMAL(18,2) COMMENT 'Estimated financial liability for closure and rehabilitation of the TSF measured in United States Dollars. Used for financial provisioning and reporting under IFRS and regulatory requirements.',
    `facility_code` STRING COMMENT 'Unique business identifier or code assigned to the TSF for operational tracking, reporting, and cross-system reference.',
    `facility_name` STRING COMMENT 'Official name or designation of the Tailings Storage Facility as registered with regulatory authorities and used in operational documentation.',
    `failure_mode_scenario` STRING COMMENT 'Description of the credible failure mode scenario used for consequence classification and emergency planning. Includes failure mechanism, breach characteristics, and inundation extent.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this TSF record is currently active in the system. False indicates the record has been logically deleted or superseded.',
    `itrb_assignment` STRING COMMENT 'Name of the Independent Tailings Review Board assigned to provide independent review and oversight of the TSF. ICMM GISTM Requirement 13 requires ITRB for consequence classifications of High, Very High, or Extreme.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection of the TSF. ICMM GISTM requires regular inspections with frequency determined by consequence classification.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this TSF record was most recently modified. Part of audit trail for data lineage and compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the TSF location in decimal degrees. Used for spatial analysis, regulatory reporting, and emergency response planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the TSF location in decimal degrees. Used for spatial analysis, regulatory reporting, and emergency response planning.',
    `maximum_raise_level` STRING COMMENT 'Maximum planned raise level in the facility design. Represents the final stage of construction when the TSF reaches its ultimate design capacity.',
    `next_scheduled_inspection_date` DATE COMMENT 'Date when the next formal inspection of the TSF is scheduled. Inspection frequency is determined by consequence classification per ICMM GISTM.',
    `operational_status` STRING COMMENT 'Current operational state of the TSF. Active facilities are receiving tailings, inactive facilities are not currently receiving tailings but may resume, closed facilities have completed rehabilitation, care-and-maintenance facilities are temporarily suspended, under-construction facilities are being built.. Valid values are `active|inactive|closed|care_and_maintenance|under_construction`',
    `population_at_risk` STRING COMMENT 'Estimated number of people living or working in the potential inundation zone downstream of the TSF who would be at risk in the event of a dam failure. Key input to consequence classification.',
    `regulatory_acceptance_status` STRING COMMENT 'Current status of regulatory acceptance for the TSF design, construction, or operation. Tracks whether the facility has received necessary approvals from governing authorities.. Valid values are `approved|pending|conditional|rejected|under_review`',
    `regulatory_permit_reference` STRING COMMENT 'Reference number or identifier of the primary regulatory permit or license authorizing construction and operation of the TSF. Links to regulatory compliance documentation.',
    `seepage_monitoring_system` STRING COMMENT 'Description of the seepage monitoring and detection system installed at the TSF. May include piezometers, weirs, visual inspection points, and automated monitoring equipment.',
    CONSTRAINT pk_tsf PRIMARY KEY(`tsf_id`)
) COMMENT 'Master register of all Tailings Storage Facilities (TSFs) including facility identity, dam type (upstream, downstream, centreline), design and current storage capacity, raise level, operational status (active, inactive, closed, under care-and-maintenance), geographic coordinates, catchment area, Engineer of Record (EoR), Accountable Executive (AE), Independent Tailings Review Board (ITRB) assignment, consequence classification (Extreme, Very High, High, Significant, Low), population at risk, downstream infrastructure exposure, failure mode scenario, classification assessment date, assessor credentials, regulatory acceptance status, regulatory permit references, and classification assessment history. SSOT for TSF identity, governance accountability, and consequence classification per ICMM GISTM Requirements 2 (Accountable Executive), 5 (Engineer of Record), 13 (ITRB), and 3 (consequence classification). Drives dam safety review frequency and design standards.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`tsf_raise` (
    `tsf_raise_id` BIGINT COMMENT 'Unique identifier for each TSF raise event. Primary key for the tsf_raise data product.',
    `stability_analysis_id` BIGINT COMMENT 'Foreign key linking to tailings.stability_analysis. Business justification: Each TSF raise requires geotechnical stability analysis for regulatory approval. The raise is approved based on a specific stability analysis that demonstrates the raised embankment will be stable. Th',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: Raises consume approved capex budget lines. Required for budget vs actual variance reporting, forecast-at-completion analysis, and board-level capital allocation decisions. Links estimated_cost and ac',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: TSF raises are capital projects requiring stage-gate approval, budget allocation, and project management. This FK links the tailings engineering record to the formal capital project record, enabling i',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Design engineers for TSF raises are professional stakeholders requiring engagement tracking for regulatory approvals, independent reviews, and geotechnical sign-offs. Stakeholder management tracks the',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Completed raises are capitalized as fixed assets with depreciation over remaining mine life. Required for asset register, depreciation calculation, and capex capitalization decisions upon commissionin',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: TSF raise schedules are synchronized with LOM production profiles to ensure tailings storage capacity matches planned ore processing rates. Raise capital expenditure and timing are integrated into min',
    `management_of_change_id` BIGINT COMMENT 'Foreign key linking to hse.management_of_change. Business justification: TSF raises are major facility changes requiring Management of Change (MOC) process per safety management systems. MOC ensures risk assessment, design review, training, and PSSR before commissioning. R',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Multi-year TSF raise programs typically establish framework contracts for ongoing supply of construction materials. Linking raises to supply contracts enables contract compliance monitoring, volume co',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: TSF raises are major capital projects requiring procurement of geotextiles, rockfill, instrumentation, and construction materials. Linking to the primary PO enables budget tracking, cost reconciliatio',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: TSF raise construction requires tracking responsible engineer for design accountability and regulatory sign-off. Design engineer name/registration are denormalized. Essential for engineering liability',
    `tsf_id` BIGINT COMMENT 'Reference to the parent TSF structure that is being raised. Links this raise event to the specific tailings storage facility.',
    `actual_completion_date` DATE COMMENT 'Actual date when raise construction was completed and the structure was commissioned for operational use.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Final actual cost incurred for the raise construction project. Captured from financial systems for cost performance analysis and future estimating.',
    `actual_start_date` DATE COMMENT 'Actual date when raise construction activities commenced on site. May differ from planned start date due to weather, approvals, or resource constraints.',
    `additional_storage_capacity_m3` DECIMAL(18,2) COMMENT 'Incremental tailings storage capacity gained from this raise event, measured in cubic meters. Critical for Life of Mine (LOM) planning and production scheduling.',
    `approval_authority` STRING COMMENT 'Name of the government agency or regulatory body that issued the approval (e.g., Department of Mines, EPA, state mining regulator).',
    `approval_date` DATE COMMENT 'Date when regulatory approval was granted for the raise construction. Critical milestone for project scheduling and compliance tracking.',
    `as_built_crest_elevation_m` DECIMAL(18,2) COMMENT 'Actual surveyed elevation of the embankment crest after construction completion, measured in meters above mean sea level. Captured from as-built survey and compared to design target.',
    `as_built_drawing_reference` STRING COMMENT 'Document management system reference for the as-built survey drawings and construction completion documentation.',
    `commissioning_date` DATE COMMENT 'Date when the raised embankment was formally commissioned and approved for operational tailings deposition.',
    `consequence_classification` STRING COMMENT 'Dam safety consequence classification of the TSF after this raise is completed. Based on potential downstream impacts in the event of failure. Drives monitoring and governance requirements per ICMM standards.. Valid values are `low|significant|high|very_high|extreme`',
    `construction_contractor` STRING COMMENT 'Name of the contractor or construction company responsible for executing the raise construction works.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated and actual cost amounts (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this raise record was first created in the system. Used for audit trail and data lineage tracking.',
    `design_document_reference` STRING COMMENT 'Document management system reference or identifier for the detailed design report and engineering drawings for this raise.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Budgeted or estimated cost for the raise construction project. Used for Capital Expenditure (CAPEX) planning and financial forecasting.',
    `geotechnical_sign_off_date` DATE COMMENT 'Date when the geotechnical engineer provided formal sign-off that the raise construction meets design specifications and is safe for commissioning.',
    `independent_reviewer` STRING COMMENT 'Name of the independent qualified engineer or firm conducting third-party review of the raise design and construction. Required under ICMM standards for high-consequence TSFs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this raise record was last updated in the system. Used for audit trail and change tracking.',
    `planned_completion_date` DATE COMMENT 'Scheduled date for completion of raise construction and commissioning activities.',
    `planned_start_date` DATE COMMENT 'Scheduled date for commencement of raise construction activities as per the Life of Mine (LOM) plan and TSF raise schedule.',
    `raise_height_m` DECIMAL(18,2) COMMENT 'Vertical height increment added to the embankment by this raise event, measured in meters. Calculated as the difference between new crest elevation and previous crest elevation.',
    `raise_method` STRING COMMENT 'Engineering method used for the embankment raise. Upstream: constructed on the upstream side of the previous crest. Downstream: constructed on the downstream side (most stable). Centreline: constructed directly above the previous crest.. Valid values are `upstream|downstream|centreline`',
    `raise_notes` STRING COMMENT 'Free-text field for additional notes, observations, or comments related to the raise event. May include construction challenges, design changes, or lessons learned.',
    `raise_number` STRING COMMENT 'Sequential business identifier for the raise event (e.g., RAISE-001, RAISE-002). Used for external communication and documentation.',
    `raise_status` STRING COMMENT 'Current state of the raise event in its lifecycle. Tracks progression from planning through design, regulatory approval, construction, and completion. [ENUM-REF-CANDIDATE: planned|design|approved|construction|completed|suspended|cancelled — 7 candidates stripped; promote to reference product]',
    `raise_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of embankment material (fill, rockfill, tailings) placed during the raise, measured in cubic meters. Key metric for construction planning and cost estimation.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for the regulatory approval or permit authorizing the raise construction. Links to Environmental Impact Statement (EIS) or mining permit amendments.',
    `target_crest_elevation_m` DECIMAL(18,2) COMMENT 'Design elevation of the embankment crest after completion of the raise, measured in meters above mean sea level. Critical parameter for storage capacity and dam safety.',
    CONSTRAINT pk_tsf_raise PRIMARY KEY(`tsf_raise_id`)
) COMMENT 'Records each planned and completed raise event for a TSF embankment, including raise method (upstream, downstream, centreline), target crest elevation, raise volume, design engineer, construction contractor, start and completion dates, as-built survey elevation, and regulatory approval reference. Tracks the incremental heightening lifecycle of the dam structure over its operational life.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` (
    `dam_safety_inspection_id` BIGINT COMMENT 'Unique identifier for the dam safety inspection record.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Inspection findings requiring remedial actions must link to corrective action tracking system. Core compliance workflow: inspection identifies deficiency → corrective action assigned → closure verifie',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Inspection costs (contractor fees, EOR time, instrumentation calibration) are charged to the TSFs cost centre for AISC calculation. Required for opex tracking and regulatory compliance cost reporting',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Dam safety inspections require tracking qualified inspector identity for regulatory compliance and professional liability. Inspector name/organization fields are denormalized employee data. Critical f',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Inspector organizations conducting dam safety inspections are regulatory and professional stakeholders requiring engagement tracking for scheduling, credentials verification, and regulatory submission',
    `stability_analysis_id` BIGINT COMMENT 'Foreign key linking to tailings.stability_analysis. Business justification: Dam safety inspections reference specific stability analyses as the technical basis for safety ratings. The inspection documents that a stability analysis was conducted and uses its results. Creating ',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility or waste rock embankment being inspected.',
    `consequence_classification` STRING COMMENT 'Consequence category of the TSF based on potential downstream impact in the event of failure, aligned with ANCOLD, CDA, and ICMM GISTM consequence classification frameworks.. Valid values are `low|significant|high|very_high|extreme`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dam safety inspection record was first created in the system.',
    `engineer_of_record_name` STRING COMMENT 'Full name of the Engineer of Record who is accountable for the design, construction, operation, and closure of the TSF, as required by ICMM GISTM Requirement 5.',
    `eor_signoff_date` DATE COMMENT 'Date on which the Engineer of Record formally signed off on the inspection report and stability analysis results.',
    `factor_of_safety` DECIMAL(18,2) COMMENT 'Calculated factor of safety from the stability analysis, representing the ratio of resisting forces to driving forces. Minimum FoS thresholds are defined by ANCOLD, CDA, and ICMM GISTM based on loading condition and consequence classification.',
    `failure_mode_assessed` STRING COMMENT 'Description of the failure mode evaluated in the stability analysis (e.g., circular slip, wedge failure, liquefaction, foundation failure, overtopping).',
    `fos_compliance_status` STRING COMMENT 'Assessment of whether the calculated factor of safety meets or exceeds the minimum design criteria and regulatory requirements.. Valid values are `compliant|non_compliant|marginal`',
    `freeboard_compliance_status` STRING COMMENT 'Assessment of whether the measured freeboard meets the design criteria and regulatory requirements.. Valid values are `compliant|non_compliant|marginal`',
    `freeboard_measurement_m` DECIMAL(18,2) COMMENT 'Vertical distance in meters between the current water level in the TSF and the crest of the dam, a critical safety parameter to prevent overtopping.',
    `inspection_date` DATE COMMENT 'The date on which the dam safety inspection was conducted.',
    `inspection_number` STRING COMMENT 'Business identifier for the inspection, typically a sequential or coded reference used in reports and compliance documentation.',
    `inspection_report_reference` STRING COMMENT 'Document reference or file path to the formal inspection report, including photographs, drawings, and detailed findings.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection: scheduled (planned but not started), in progress (field work underway), completed (field work done), report pending (awaiting documentation), approved (reviewed and accepted), closed (all actions resolved).. Valid values are `scheduled|in_progress|completed|report_pending|approved|closed`',
    `inspection_type` STRING COMMENT 'Classification of the inspection: routine (regular operational checks), annual (comprehensive yearly review), independent review (third-party assessment), ITRB (Independent Tailings Review Board), post-event (following seismic or extreme weather), emergency (triggered by incident), construction phase, or commissioning. [ENUM-REF-CANDIDATE: routine|annual|independent_review|itrb|post_event|emergency|construction_phase|commissioning — 8 candidates stripped; promote to reference product]',
    `instrumentation_compliance` STRING COMMENT 'Assessment of whether the instrumentation array meets the design and regulatory requirements for monitoring.. Valid values are `compliant|non_compliant|partial`',
    `instrumentation_status` STRING COMMENT 'Summary of the operational status of geotechnical instrumentation (piezometers, inclinometers, settlement monuments, flow meters), including any malfunctioning or missing instruments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dam safety inspection record was last updated.',
    `material_strength_parameters` STRING COMMENT 'Summary of the geotechnical material strength parameters used in the analysis, including cohesion, friction angle, and unit weight for tailings, foundation, and embankment materials.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next dam safety inspection, based on regulatory requirements and the consequence classification of the TSF.',
    `overall_safety_rating` STRING COMMENT 'Summary assessment of the dam safety condition: satisfactory (no concerns), fair (minor issues), marginal (requires monitoring), unsatisfactory (remedial action needed), urgent (immediate intervention required).. Valid values are `satisfactory|fair|marginal|unsatisfactory|urgent`',
    `phreatic_surface_assumption` STRING COMMENT 'Description of the phreatic surface (water table) assumptions used in the stability analysis, including piezometric data sources and interpolation methods.',
    `regulatory_submission_date` DATE COMMENT 'Date on which the inspection report was submitted to the regulatory authority, if applicable.',
    `regulatory_submission_required` BOOLEAN COMMENT 'Indicates whether this inspection report must be submitted to a regulatory authority or governing body.',
    `remedial_action_priority` STRING COMMENT 'Priority level assigned to the remedial actions: none (no action needed), low (routine maintenance), medium (planned intervention), high (near-term action), urgent (immediate response).. Valid values are `none|low|medium|high|urgent`',
    `remedial_actions_required` STRING COMMENT 'Detailed description of any corrective or remedial actions identified during the inspection, including repairs, monitoring enhancements, or operational changes.',
    `seepage_observation` STRING COMMENT 'Qualitative description of seepage conditions observed during the inspection, including location, flow rate, clarity, and any signs of internal erosion or piping.',
    `seepage_severity` STRING COMMENT 'Classification of seepage severity: none (no seepage detected), minor (expected and controlled), moderate (requires monitoring), significant (remedial action needed), critical (immediate intervention required).. Valid values are `none|minor|moderate|significant|critical`',
    `slope_condition` STRING COMMENT 'Description of the physical condition of the upstream and downstream slopes, including observations of cracking, slumping, erosion, vegetation, or other surface anomalies.',
    `slope_stability_rating` STRING COMMENT 'Assessment of slope stability based on visual inspection: stable (no concerns), minor concern (cosmetic issues), moderate concern (requires monitoring), unstable (remedial action needed).. Valid values are `stable|minor_concern|moderate_concern|unstable`',
    `stability_analysis_conducted` BOOLEAN COMMENT 'Indicates whether a formal geotechnical stability analysis was performed as part of this inspection cycle.',
    CONSTRAINT pk_dam_safety_inspection PRIMARY KEY(`dam_safety_inspection_id`)
) COMMENT 'Records formal dam safety inspections and geotechnical stability analyses conducted on TSFs and waste rock embankments. For inspections: captures inspection type (routine, annual, independent review, ITRB), inspector identity and credentials, inspection date, overall safety rating, freeboard measurement, seepage observations, slope condition, instrumentation status, and required remedial actions. For stability analyses: captures analysis type (static, pseudo-static, dynamic), software used, failure mode assessed, factor of safety (FoS) calculated, phreatic surface assumptions, material strength parameters, and engineer of record sign-off. Supports compliance with ANCOLD, CDA, MAC, USACE, and ICMM GISTM Requirements 5 (EoR), 10 (design basis), and 11 (dam safety review) including minimum FoS obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` (
    `geotechnical_instrument_id` BIGINT COMMENT 'Unique identifier for the geotechnical monitoring instrument. Primary key for the geotechnical instrument register.',
    `commissioning_activity_id` BIGINT COMMENT 'Foreign key linking to project.commissioning_activity. Business justification: Geotechnical instrumentation installation, calibration, and baseline reading establishment are commissioning activities for TSF and WRD projects. Instrument commissioning is a handover requirement wit',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Instruments (piezometers, inclinometers, survey prisms) are capitalized fixed assets with depreciation schedules. Required for asset register reconciliation, insurance valuation, and capex vs opex cla',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Instrument manufacturers/suppliers provide calibration services, technical support, and spare parts. Linking to vendor enables vendor performance tracking for calibration turnaround times, parts avail',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Geotechnical instruments require assigned responsible engineer for calibration oversight, data validation, and alert response. Responsible engineer name is denormalized. Critical for instrumentation p',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Geotechnical instruments are procured assets with manufacturer part numbers, warranty terms, and spare parts requirements. Linking to material master enables calibration parts ordering, warranty claim',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility where this instrument is installed. Links the instrument to the specific TSF being monitored.',
    `alert_threshold_level_1` DECIMAL(18,2) COMMENT 'First level alert threshold value for the instrument reading. When exceeded, triggers initial investigation and increased monitoring frequency per the TSF management plan.',
    `alert_threshold_level_2` DECIMAL(18,2) COMMENT 'Second level alert threshold value for the instrument reading. When exceeded, triggers escalated response including engineering review and potential operational restrictions.',
    `alert_threshold_level_3` DECIMAL(18,2) COMMENT 'Third level critical alert threshold value for the instrument reading. When exceeded, triggers emergency response protocols and may require immediate operational shutdown.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration or verification of the instrument against known standards. Critical for ensuring data quality and regulatory compliance.',
    `calibration_due_date` DATE COMMENT 'Date by which the next calibration or verification must be performed to maintain instrument certification and data validity. Drives preventive maintenance scheduling.',
    `commissioning_date` DATE COMMENT 'Date when the instrument was commissioned and began producing valid monitoring data after installation and baseline stabilization. May differ from installation date due to settling period requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_acquisition_method` STRING COMMENT 'Method by which readings are collected from the instrument. Automated and SCADA-integrated instruments provide real-time data; manual instruments require field visits.. Valid values are `automated|manual|remote_telemetry|scada_integrated`',
    `decommission_date` DATE COMMENT 'Date when the instrument was taken out of service, either due to failure, replacement, or completion of monitoring requirements. Null for active instruments.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the instrument installation point above mean sea level in meters. Critical for understanding vertical position relative to dam structure and phreatic surface.',
    `facility_zone` STRING COMMENT 'Specific zone or section within the TSF or waste rock facility where the instrument is located, such as upstream face, downstream toe, crest, or foundation. Used for spatial analysis and reporting.',
    `installation_contractor` STRING COMMENT 'Name of the contractor or company that performed the instrument installation. Used for warranty claims and installation quality tracking.',
    `installation_date` DATE COMMENT 'Date when the instrument was physically installed at the monitoring location. Marks the start of the instruments operational lifecycle and baseline establishment period.',
    `installation_depth_m` DECIMAL(18,2) COMMENT 'Depth below ground surface at which the instrument sensor is installed, measured in meters. Applicable to subsurface instruments such as piezometers and inclinometers. Null for surface instruments.',
    `installation_notes` STRING COMMENT 'Free-text field capturing important details about the installation process, site conditions, deviations from design, or special considerations that may affect instrument performance or data interpretation.',
    `instrument_name` STRING COMMENT 'Descriptive name or label for the instrument, typically including location context and instrument type for easy identification in reports and dashboards.',
    `instrument_subtype` STRING COMMENT 'Further classification or model specification of the instrument type, such as standpipe piezometer, pneumatic piezometer, or in-place inclinometer. Provides additional technical detail beyond the primary type.',
    `instrument_tag` STRING COMMENT 'Unique alphanumeric tag or serial number assigned to the instrument for field identification and tracking. Used by field technicians and in monitoring reports.. Valid values are `^[A-Z0-9]{3,20}$`',
    `instrument_type` STRING COMMENT 'Classification of the geotechnical monitoring instrument based on its measurement function. Determines the type of data collected and analysis methods applied. [ENUM-REF-CANDIDATE: piezometer|inclinometer|settlement_plate|survey_prism|vibrating_wire_sensor|seepage_weir|extensometer|tiltmeter — 8 candidates stripped; promote to reference product]',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this instrument is required by regulatory permits, Environmental Impact Statement (EIS) conditions, or dam safety orders. True if mandated by external authority; false if installed for internal monitoring purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the instrument installation location in decimal degrees. Used for GIS mapping and spatial analysis of monitoring network coverage.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the instrument installation location in decimal degrees. Used for GIS mapping and spatial analysis of monitoring network coverage.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Maximum value of the instruments design measurement range. Defines the upper bound of valid readings the instrument can produce.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Minimum value of the instruments design measurement range. Defines the lower bound of valid readings the instrument can produce.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the readings produced by this instrument, such as meters, millimeters, kPa, degrees, or liters per second. Must align with the instrument type and measurement range.',
    `model_number` STRING COMMENT 'Manufacturer model or part number for the instrument. Critical for identifying compatible replacement parts and understanding instrument specifications.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was last modified in the system. Used for audit trail and change tracking.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency at which readings are taken from this instrument under normal operating conditions. May be increased during alert conditions or construction activities. [ENUM-REF-CANDIDATE: real_time|hourly|daily|weekly|monthly|quarterly|event_based — 7 candidates stripped; promote to reference product]',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. Active instruments are producing valid data; failed instruments require repair or replacement; inactive instruments are temporarily not monitored.. Valid values are `active|inactive|failed|under_maintenance|decommissioned|standby`',
    `purpose` STRING COMMENT 'Primary purpose or objective for which this instrument was installed, such as phreatic surface monitoring, settlement tracking, slope stability assessment, or seepage quantification. Guides data interpretation and reporting.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit. Used for warranty claims, calibration tracking, and asset management.',
    CONSTRAINT pk_geotechnical_instrument PRIMARY KEY(`geotechnical_instrument_id`)
) COMMENT 'Master register of all geotechnical monitoring instruments installed at TSFs and waste rock facilities, including piezometers, inclinometers, settlement plates, survey prisms, vibrating wire sensors, and seepage weirs. Captures instrument type, installation date, location coordinates, depth, design range, alert thresholds, and operational status. SSOT for instrument identity used by all monitoring readings.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`geotechnical_reading` (
    `geotechnical_reading_id` BIGINT COMMENT 'Unique identifier for the geotechnical instrument reading record.',
    `employee_id` BIGINT COMMENT 'Reference to the person or system operator who captured or validated the reading.',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Geotechnical readings are captured from geotechnical instruments installed at tailings facilities. The existing instrument_id FK points to laboratory.instrument (cross-domain, generic instrument regis',
    `incident_id` BIGINT COMMENT 'Reference to the HSE incident record if this reading triggered a dam safety incident or TARP activation.',
    `instrument_id` BIGINT COMMENT 'Reference to the geotechnical monitoring instrument that captured this reading (piezometer, inclinometer, settlement plate, survey prism).',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility or waste rock facility where the instrument is installed.',
    `action_threshold` DECIMAL(18,2) COMMENT 'The action threshold value defined in the Trigger Action Response Plan (TARP) that triggers immediate intervention and response protocols.',
    `alert_threshold` DECIMAL(18,2) COMMENT 'The alert threshold value defined in the Trigger Action Response Plan (TARP) that indicates elevated monitoring attention is required.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The initial or reference baseline value established for this instrument location, used for calculating deviation and trend analysis.',
    `calibration_date` DATE COMMENT 'The date when the instrument was last calibrated, ensuring measurement accuracy and reliability.',
    `data_quality_flag` STRING COMMENT 'Quality assessment flag indicating the reliability and validity of the reading for dam safety surveillance purposes.. Valid values are `valid|suspect|invalid|missing|calibration_required|out_of_range`',
    `data_source_system` STRING COMMENT 'The source system or platform from which the reading was ingested (SCADA, manual field entry, remote telemetry, third-party monitoring service).. Valid values are `scada|manual_entry|telemetry|lims|third_party`',
    `deviation_from_baseline` DECIMAL(18,2) COMMENT 'The calculated difference between the current reading value and the established baseline value.',
    `incident_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this reading triggered an incident report or TARP response action.',
    `instrument_type` STRING COMMENT 'The category of geotechnical monitoring instrument that produced this reading.. Valid values are `piezometer|inclinometer|settlement_plate|survey_prism|extensometer|tiltmeter`',
    `rate_of_change` DECIMAL(18,2) COMMENT 'The calculated rate of change in the measured parameter over time, critical for identifying accelerating deformation or pore pressure trends.',
    `rate_of_change_unit` STRING COMMENT 'The unit expressing the rate of change calculation (e.g., millimeters per day, kilopascals per day).. Valid values are `mm_per_day|mm_per_month|kPa_per_day|degrees_per_month`',
    `reading_method` STRING COMMENT 'The method by which the reading was captured: manual field measurement, automated SCADA system, or remote telemetry.. Valid values are `manual|automated|scada|remote`',
    `reading_notes` STRING COMMENT 'Free-text field for operator or engineer comments regarding anomalies, field conditions, or contextual information relevant to the reading.',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the geotechnical reading was captured in the field, representing the actual measurement event time.',
    `reading_value` DECIMAL(18,2) COMMENT 'The measured numeric value captured by the geotechnical instrument at the reading timestamp.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reading record was first created in the data system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this reading record was last modified or updated.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature at the time of reading, which may affect instrument calibration and reading interpretation.',
    `threshold_breach_status` STRING COMMENT 'Indicates whether the reading value has breached alert or action thresholds defined in the TARP.. Valid values are `normal|alert_breached|action_breached|not_applicable`',
    `unit_of_measure` STRING COMMENT 'The unit in which the reading value is expressed (millimeters for displacement, kilopascals for pore pressure, degrees for inclination, percent for strain).. Valid values are `mm|m|kPa|MPa|degrees|percent`',
    `validated_by` BIGINT COMMENT 'Reference to the geotechnical engineer or competent person who validated the reading.',
    `validation_status` STRING COMMENT 'The validation status of the reading by a qualified geotechnical engineer or dam safety specialist.. Valid values are `pending|validated|rejected|requires_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the reading was validated by a qualified person.',
    `weather_condition` STRING COMMENT 'The weather condition at the time of reading capture, relevant for interpreting pore pressure and seepage readings.. Valid values are `clear|rain|heavy_rain|snow|fog|storm`',
    CONSTRAINT pk_geotechnical_reading PRIMARY KEY(`geotechnical_reading_id`)
) COMMENT 'Time-series records of geotechnical instrument readings captured from piezometers, inclinometers, settlement plates, and survey prisms at TSFs and waste rock facilities. Stores reading timestamp, measured value, unit of measure, reading method (manual, automated SCADA), operator, data quality flag, and comparison against alert and action thresholds. Feeds dam safety surveillance and trigger action response plans (TARPs).';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`seepage_monitoring` (
    `seepage_monitoring_id` BIGINT COMMENT 'Unique identifier for the seepage monitoring record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Seepage monitoring costs (field sampling, lab analysis, data management) are allocated to the TSF cost centre for environmental compliance cost tracking and AISC reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the technician or employee who performed the seepage monitoring measurement.',
    `laboratory_sample_id` BIGINT COMMENT 'Unique identifier assigned by the laboratory information management system (LIMS) for tracking the sample through analysis.',
    `monitoring_location_id` BIGINT COMMENT 'Foreign key reference to the specific monitoring location (toe drain, seepage collection pond, underdrain) where the measurement was taken.',
    `tsf_id` BIGINT COMMENT 'Foreign key reference to the tailings storage facility where seepage is monitored.',
    `water_balance_id` BIGINT COMMENT 'Foreign key linking to tailings.water_balance. Business justification: Seepage monitoring records measure water outflow from the TSF through seepage collection systems. These measurements are inputs to water balance calculations as outflow components. Each seepage monito',
    `alert_triggered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this measurement triggered an automated alert or notification due to threshold exceedance (True = alert triggered, False = no alert).',
    `arsenic_concentration` DECIMAL(18,2) COMMENT 'Arsenic concentration in seepage water in milligrams per liter (mg/L).',
    `comments` STRING COMMENT 'Free-text field for technician observations, anomalies, or contextual notes related to the seepage measurement.',
    `conductivity_unit` STRING COMMENT 'Unit of measure for electrical conductivity.. Valid values are `µS/cm|mS/cm|dS/m`',
    `copper_concentration` DECIMAL(18,2) COMMENT 'Copper metal concentration in seepage water in milligrams per liter (mg/L).',
    `design_exceedance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the measured flow rate exceeds the design seepage rate (True = exceeded, False = within design).',
    `design_seepage_rate` DECIMAL(18,2) COMMENT 'Expected design seepage flow rate for this monitoring location in liters per second (L/s), used for comparison against actual measurements.',
    `electrical_conductivity` DECIMAL(18,2) COMMENT 'Electrical conductivity of seepage water in microsiemens per centimeter (µS/cm), indicating dissolved ion concentration.',
    `environmental_licence_limit` DECIMAL(18,2) COMMENT 'Maximum allowable concentration or flow rate as specified in the environmental operating licence for this parameter.',
    `flow_rate` DECIMAL(18,2) COMMENT 'Measured seepage flow rate in liters per second (L/s).',
    `flow_rate_unit` STRING COMMENT 'Unit of measure for the seepage flow rate.. Valid values are `L/s|m3/day|gpm|m3/hr`',
    `internal_erosion_risk_indicator` STRING COMMENT 'Risk assessment indicator for potential internal erosion based on turbidity, flow rate trends, and other seepage characteristics.. Valid values are `low|moderate|high|critical`',
    `iron_concentration` DECIMAL(18,2) COMMENT 'Iron metal concentration in seepage water in milligrams per liter (mg/L).',
    `laboratory_analysis_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sample was sent for laboratory analysis (True) or measured in-field (False).',
    `lead_concentration` DECIMAL(18,2) COMMENT 'Lead metal concentration in seepage water in milligrams per liter (mg/L).',
    `licence_exceedance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the measurement exceeds the environmental licence limit (True = exceeded, False = compliant).',
    `licence_limit_parameter` STRING COMMENT 'The specific parameter to which the environmental licence limit applies. [ENUM-REF-CANDIDATE: flow_rate|turbidity|ph|copper|iron|manganese|zinc|arsenic|lead|sulfate|tds — 11 candidates stripped; promote to reference product]',
    `location_type` STRING COMMENT 'Type of monitoring location where seepage is measured.. Valid values are `toe_drain|seepage_collection_pond|underdrain|piezometer|observation_well|surface_seepage`',
    `manganese_concentration` DECIMAL(18,2) COMMENT 'Manganese metal concentration in seepage water in milligrams per liter (mg/L).',
    `measurement_status` STRING COMMENT 'Quality status of the measurement indicating whether the data is valid for reporting and analysis.. Valid values are `valid|invalid|under_review|calibration_required|instrument_fault`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the seepage measurement was recorded in the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `monitoring_point_code` STRING COMMENT 'Alphanumeric code identifying the specific monitoring point or instrument (e.g., TD-01, SCP-03, UD-05).',
    `ph_level` DECIMAL(18,2) COMMENT 'pH measurement of seepage water on a scale of 0-14, indicating acidity or alkalinity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this seepage monitoring record was first created in the system in the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this seepage monitoring record was last updated in the system in the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this measurement must be included in regulatory environmental reporting (True = required, False = internal monitoring only).',
    `sample_collection_method` STRING COMMENT 'Method used to collect the seepage water sample for analysis.. Valid values are `grab_sample|composite_sample|continuous_monitoring|automated_sampler`',
    `sulfate_concentration` DECIMAL(18,2) COMMENT 'Sulfate ion concentration in seepage water in milligrams per liter (mg/L).',
    `total_dissolved_solids` DECIMAL(18,2) COMMENT 'Total dissolved solids concentration in milligrams per liter (mg/L).',
    `turbidity` DECIMAL(18,2) COMMENT 'Turbidity measurement of seepage water in Nephelometric Turbidity Units (NTU), indicating suspended solids and potential internal erosion.',
    `turbidity_unit` STRING COMMENT 'Unit of measure for turbidity reading.. Valid values are `NTU|FNU|JTU`',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of measurement, which may influence seepage rates.. Valid values are `clear|rain|snow|fog|storm`',
    `zinc_concentration` DECIMAL(18,2) COMMENT 'Zinc metal concentration in seepage water in milligrams per liter (mg/L).',
    CONSTRAINT pk_seepage_monitoring PRIMARY KEY(`seepage_monitoring_id`)
) COMMENT 'Records seepage flow measurements and water quality observations at TSF toe drains, seepage collection ponds, and underdrains. Captures measurement date, flow rate, turbidity, pH, conductivity, metal concentrations, and comparison against design seepage rates and environmental licence limits. Supports early detection of internal erosion and regulatory environmental reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`tarp_trigger` (
    `tarp_trigger_id` BIGINT COMMENT 'Unique identifier for the TARP trigger event record. Primary key for the tarp_trigger product.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: TARP triggers require corrective actions to address root causes and prevent recurrence. Links monitoring threshold exceedances to formal action tracking. Core safety management workflow: trigger activ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: TARP response actions (investigations, remediation, additional monitoring) incur costs charged to the facility cost centre. Required for incident cost tracking and management reporting of unplanned ex',
    `geotechnical_instrument_id` BIGINT COMMENT 'Identifier of the specific monitoring instrument or sensor that recorded the parameter breach (e.g., piezometer ID, survey monument ID, flow meter ID).',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: TARP trigger activations indicating dam safety issues often result in community grievances about risk exposure. Mining operations link TARP events to grievance management for stakeholder notification,',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: TARP (Trigger Action Response Plan) Level 2/3 exceedances escalate to formal HSE incidents requiring investigation per mining safety management systems. Links operational monitoring thresholds to inci',
    `monitoring_location_id` BIGINT COMMENT 'FK to tailings.monitoring_location',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Emergency response equipment (pumps, excavators, generators) pre-assigned to TARP trigger levels for rapid deployment. Critical for emergency preparedness planning, TARP drill exercises, equipment rea',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: TARP trigger events require tracking responsible engineer for investigation and corrective action accountability. Responsible engineer name is denormalized. Essential for emergency response management',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility where the TARP trigger event occurred.',
    `activation_timestamp` TIMESTAMP COMMENT 'The date and time when the TARP trigger was activated due to the parameter threshold breach. This is the principal business event timestamp for the trigger record.',
    `closure_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the closure of the TARP trigger event, confirming that all required actions have been satisfactorily completed.',
    `closure_timestamp` TIMESTAMP COMMENT 'The date and time when the TARP trigger event was formally closed after all response actions, investigations, and corrective measures were completed and verified.',
    `corrective_actions` STRING COMMENT 'Description of corrective actions implemented to address the root cause and prevent recurrence of similar TARP trigger events.',
    `data_source_system` STRING COMMENT 'The operational system of record from which this TARP trigger event data originated (e.g., IsoMetrix HSE Incident Management, OSIsoft PI System, custom TSF monitoring system).',
    `detection_method` STRING COMMENT 'The method by which the parameter breach was detected, indicating whether it was identified through automated monitoring systems, manual inspection, or other means.. Valid values are `automated_monitoring|manual_inspection|routine_survey|visual_observation|laboratory_analysis`',
    `environmental_impact_assessment` STRING COMMENT 'Summary of any environmental impacts resulting from the TARP trigger event, including potential or actual effects on water quality, soil, air, or surrounding ecosystems.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage by which the measured value exceeded the threshold value, calculated as ((measured_value - threshold_value) / threshold_value) * 100.',
    `investigation_completion_date` DATE COMMENT 'The date when the formal investigation into the TARP trigger event was completed and findings were documented.',
    `investigation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal investigation is required for this TARP trigger event based on its severity and potential consequences.',
    `lessons_learned` STRING COMMENT 'Documentation of lessons learned from the TARP trigger event and response, used to improve future monitoring, response protocols, and risk management practices.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual measured value of the parameter at the time of trigger activation, recorded in the unit of measure specified for that parameter.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when key personnel and authorities were notified of the TARP trigger activation.',
    `notified_personnel` STRING COMMENT 'List of personnel, roles, or positions that were notified of the TARP trigger activation as per the emergency response protocol (e.g., TSF Manager, Chief Geotechnical Engineer, Site Manager, Regulatory Authority).',
    `parameter_category` STRING COMMENT 'Classification of the triggering parameter into broad monitoring categories for analysis and reporting purposes.. Valid values are `geotechnical|hydrological|structural|operational|environmental|seismic`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this TARP trigger record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this TARP trigger record was last modified or updated.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or governing body that was notified of the TARP trigger event (e.g., state mining department, environmental protection agency).',
    `regulatory_notification_date` DATE COMMENT 'The date when regulatory authorities were formally notified of the TARP trigger event, if required.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the TARP trigger event severity requires formal notification to regulatory authorities or governing bodies.',
    `response_actions_taken` STRING COMMENT 'Detailed description of the immediate response actions taken following the TARP trigger activation, including operational adjustments, additional monitoring, engineering interventions, or emergency procedures initiated.',
    `response_initiated_timestamp` TIMESTAMP COMMENT 'The date and time when the formal response actions were initiated following the TARP trigger activation.',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis findings that identified the underlying factors contributing to the parameter threshold breach.',
    `safety_impact_assessment` STRING COMMENT 'Summary of any health and safety impacts or risks to personnel, communities, or infrastructure resulting from the TARP trigger event.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The defined threshold limit for the parameter that was breached, triggering the TARP response. This value corresponds to the trigger level (green, yellow, orange, or red) in the TARP framework.',
    `trigger_level` STRING COMMENT 'Severity classification of the TARP trigger event. Green indicates normal operations, yellow indicates alert threshold breach, orange indicates action threshold breach requiring immediate response, and red indicates emergency threshold breach requiring critical intervention.. Valid values are `green|yellow|orange|red`',
    `trigger_reference_number` STRING COMMENT 'Business identifier for the TARP trigger event, used for external reporting and communication with regulatory authorities and management.',
    `trigger_status` STRING COMMENT 'Current lifecycle status of the TARP trigger event, tracking progression from initial activation through investigation and resolution.. Valid values are `active|under_investigation|resolved|escalated|closed`',
    `triggering_parameter` STRING COMMENT 'The specific geotechnical or operational parameter that breached its threshold and activated the TARP trigger (e.g., piezometric level, settlement rate, seepage flow, freeboard, beach length, dam crest displacement).',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value and threshold value are expressed (e.g., meters, millimeters, liters per second, kilopascals, degrees).',
    CONSTRAINT pk_tarp_trigger PRIMARY KEY(`tarp_trigger_id`)
) COMMENT 'Records Trigger Action Response Plan (TARP) trigger events activated at a TSF when geotechnical or operational parameters breach defined alert, action, or emergency thresholds. Captures trigger level (green, yellow, orange, red), triggering parameter, measured value, threshold value, activation timestamp, notified personnel, and response actions taken. Critical for dam safety governance and emergency preparedness.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`deposition` (
    `deposition_id` BIGINT COMMENT 'Primary key for deposition',
    `capacity_model_id` BIGINT COMMENT 'Foreign key reference to the capacity model used for survey calculations.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Deposition operations (pumping, spigot management, surveys) are core TSF operating costs allocated to the facility cost centre for unit cost calculation and AISC reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the competent person or supervisor who approved the record.',
    `deposition_employee_id` BIGINT COMMENT 'Foreign key reference to the operator or surveyor who recorded the event.',
    `deposition_plan_id` BIGINT COMMENT 'Foreign key reference to the approved deposition plan governing this event.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Tailings deposition events originate from specific processing plant. Source tracking for TSF management, mass balance reconciliation between plant output and TSF input, and operational planning. Links',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Daily tailings deposition volumes must reconcile with planned mill throughput from mining production schedules. Variance analysis between scheduled ore tonnes and actual tailings generation is a stand',
    `shift_production_run_id` BIGINT COMMENT 'Foreign key linking to processing.shift_production_run. Business justification: Tailings deposition tied to specific production shift for operational reconciliation. Enables matching processing tonnes_processed with TSF solids_tonnage_t, shift-level mass balance, and production r',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key reference to the operational shift during which the deposition event occurred. Null for capacity survey records.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Survey equipment (drones, GPS rovers, total stations) used for tailings beach elevation surveys and capacity assessments must be tracked for calibration status, accuracy classification, and regulatory',
    `tsf_id` BIGINT COMMENT 'Foreign key reference to the tailings storage facility where deposition occurred.',
    `water_balance_id` BIGINT COMMENT 'Foreign key linking to tailings.water_balance. Business justification: Deposition events deliver tailings slurry (solids + water) to the TSF, representing water inflow. Each deposition event occurs within a specific water balance period. The water component of the slurry',
    `approval_status` STRING COMMENT 'Approval status of the survey record or deposition event in the operational workflow.. Valid values are `draft|approved|rejected|pending_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the record was approved.',
    `beach_elevation_m` DECIMAL(18,2) COMMENT 'Average elevation of the tailings beach surface at time of survey, measured in meters above sea level. Null for deposition event records.',
    `beach_length_m` DECIMAL(18,2) COMMENT 'Length of the tailings beach from the deposition point to the pond edge, measured in meters.',
    `compliance_status` STRING COMMENT 'Compliance status of the deposition event or survey against the approved deposition plan and regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `current_storage_volume_m3` DECIMAL(18,2) COMMENT 'Volume of tailings currently stored in the TSF at time of survey, measured in cubic meters. Null for deposition event records.',
    `data_source_system` STRING COMMENT 'Name of the operational system or device that captured the deposition or survey data (e.g., SCADA, survey equipment model).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the deposition event occurred or the capacity survey was conducted.',
    `event_type` STRING COMMENT 'Type of event recorded: deposition event or periodic capacity survey.. Valid values are `deposition|capacity_survey`',
    `freeboard_m` DECIMAL(18,2) COMMENT 'Vertical distance between the pond water level and the crest of the dam at time of event, measured in meters.',
    `notes` STRING COMMENT 'Free-text notes capturing additional operational context, anomalies, or observations related to the deposition event or survey.',
    `point_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the deposition point or spigot location. Null for capacity survey records.',
    `point_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the deposition point or spigot location. Null for capacity survey records.',
    `pond_level_m` DECIMAL(18,2) COMMENT 'Elevation of the pond water surface at time of event, measured in meters above sea level.',
    `pond_surface_area_m2` DECIMAL(18,2) COMMENT 'Surface area of the supernatant pond at time of survey, measured in square meters. Null for deposition event records.',
    `raise_trigger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the survey results trigger the need for a dam raise or expansion. Null for deposition event records.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this record was last modified in the system.',
    `remaining_airspace_m3` DECIMAL(18,2) COMMENT 'Available storage volume remaining in the TSF at time of survey, measured in cubic meters. Null for deposition event records.',
    `remaining_life_years` DECIMAL(18,2) COMMENT 'Calculated remaining operational life of the TSF based on current storage volume and deposition rate, measured in years. Null for deposition event records.',
    `slurry_density_t_per_m3` DECIMAL(18,2) COMMENT 'Density of the tailings slurry at time of deposition, measured in tonnes per cubic meter. Null for capacity survey records.',
    `solids_tonnage_t` DECIMAL(18,2) COMMENT 'Dry tonnage of solid tailings material deposited, measured in tonnes. Null for capacity survey records.',
    `spigot_configuration` STRING COMMENT 'Configuration of spigots used during deposition: single, multiple, rotating, or fixed. Null for capacity survey records.. Valid values are `single|multiple|rotating|fixed`',
    `survey_accuracy_class` STRING COMMENT 'Classification of survey accuracy based on method and conditions: high, medium, or low. Null for deposition event records.. Valid values are `high|medium|low`',
    `survey_method` STRING COMMENT 'Method used to conduct the capacity survey: drone photogrammetry, LiDAR, GPS, total station, or other. Null for deposition event records.. Valid values are `drone_photogrammetry|lidar|gps|total_station|other`',
    `total_storage_capacity_m3` DECIMAL(18,2) COMMENT 'Total design storage capacity of the TSF at time of survey, measured in cubic meters. Null for deposition event records.',
    `variance_from_plan_m3` DECIMAL(18,2) COMMENT 'Variance between actual deposition volume and planned volume, measured in cubic meters. Positive indicates over-plan, negative indicates under-plan.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Volume of tailings deposited during the event, measured in cubic meters. Null for capacity survey records.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at time of event or survey, relevant for operational context and data quality assessment.',
    CONSTRAINT pk_deposition PRIMARY KEY(`deposition_id`)
) COMMENT 'Records tailings deposition events and periodic volumetric capacity surveys for TSFs. For deposition: captures volume deposited, slurry density, solids tonnage, deposition point location, spigot configuration, beach length, pond level, and freeboard at time of deposition. For capacity surveys: captures survey date, survey method (drone photogrammetry, LiDAR, GPS), total storage capacity, remaining airspace, current storage volume, beach elevation, and pond surface area. SSOT for TSF filling status and remaining life calculations. Tracks operational filling against the approved deposition plan and capacity model, informing raise scheduling and operational planning. Supports GISTM Requirement 12 (management and operations).';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`waste_rock_dump` (
    `waste_rock_dump_id` BIGINT COMMENT 'Unique identifier for the waste rock dump facility. Primary key for the waste rock dump master register.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Waste rock dump construction is a capital project with design, regulatory approval, budget, and contractor management. Mining operations track WRD construction as capital projects for cost control and',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Waste rock dumps contain overburden from mining specific commodity deposits. Required for closure cost allocation by commodity, commodity-specific ARD risk assessment, rehabilitation planning, and reg',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Waste dumps are cost centres for waste haulage and placement cost allocation. Required for mining cost per tonne calculations, strip ratio costing, and AISC reporting.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Waste rock dumps require emergency response plans for slope failure, acid drainage release, or instability scenarios. Regulatory requirement for high-consequence facilities. Links facility to site-lev',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: Waste rock dump location, capacity, design, and ARD management strategy are integral components of mine feasibility studies. WRD design directly impacts mine layout, haulage costs, environmental appro',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Waste rock dumps receive material from specific orebodies. Source orebody tracking is critical for ARD management, encapsulation strategy planning, and closure liability estimation. Required for geoch',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Dumps roll up to mine profit centres for segment reporting. Required for commodity-level cost analysis and investor reporting of mining costs by operating segment.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Waste rock dumps receive waste material from mining specific prospects. Mine planning requires tracking which prospects generate waste to specific dumps for capacity management, geochemical risk asses',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this waste rock dump is located.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Waste rock dumps are physical infrastructure located on mining tenements. Required for regulatory compliance reporting, land use planning, expenditure tracking against tenement commitments, and closur',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Waste rock dump operations require storage of dust suppressants, rehabilitation materials, monitoring equipment, and operational consumables. Linking to warehouse location enables inventory planning a',
    `approval_reference` STRING COMMENT 'Reference number or identifier of the regulatory approval or permit authorizing construction and operation of this waste rock dump.',
    `ard_classification` STRING COMMENT 'Geochemical classification of the waste rock material: PAF (Potentially Acid Forming), NAF (Non-Acid Forming), or UC (Uncertain Classification).. Valid values are `PAF|NAF|UC`',
    `batter_angle_degrees` DECIMAL(18,2) COMMENT 'Design slope angle of the dump face in degrees from horizontal, as per geotechnical stability requirements.',
    `closure_date` DATE COMMENT 'Date when the waste rock dump facility was closed and ceased receiving material.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to this waste rock dump facility.',
    `compaction_required_flag` BOOLEAN COMMENT 'Indicates whether compaction of placed material is required per the geotechnical design specification.',
    `construction_start_date` DATE COMMENT 'Date when construction of the waste rock dump facility commenced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste rock dump facility record was first created in the system.',
    `current_lift_number` STRING COMMENT 'Current lift or layer number being actively placed or most recently completed.',
    `current_volume_m3` DECIMAL(18,2) COMMENT 'Current total volume of material placed in the dump facility in cubic meters, updated from placement events and surveys.',
    `design_capacity_m3` DECIMAL(18,2) COMMENT 'Total approved design capacity of the waste rock dump in cubic meters as per the approved mine plan.',
    `dominant_material_type` STRING COMMENT 'Primary lithology or material type of waste rock placed in this dump facility.',
    `drainage_system_type` STRING COMMENT 'Type of drainage system installed to manage surface water runoff and seepage from the dump facility.. Valid values are `none|surface|subsurface|combined`',
    `dump_code` STRING COMMENT 'Externally-known unique code or designation for the waste rock dump facility, used in mine planning systems and operational reporting.. Valid values are `^[A-Z0-9]{3,12}$`',
    `dump_name` STRING COMMENT 'Human-readable name or title of the waste rock dump facility.',
    `dump_type` STRING COMMENT 'Classification of the dump facility by material type: waste rock, overburden stockpile, low-grade ore stockpile, or mixed material.. Valid values are `waste_rock|overburden|low_grade_ore|mixed`',
    `elevation_m` DECIMAL(18,2) COMMENT 'Base elevation of the waste rock dump facility in meters above sea level.',
    `geochemical_risk_rating` STRING COMMENT 'Overall geochemical risk rating for acid rock drainage and metal leaching potential based on material characterization and environmental assessment.. Valid values are `low|moderate|high|extreme`',
    `inspection_outcome` STRING COMMENT 'Outcome or finding classification from the most recent inspection of this dump facility.. Valid values are `satisfactory|minor_issues|major_issues|critical`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent geotechnical or environmental compliance inspection of this dump facility.',
    `last_survey_date` DATE COMMENT 'Date of the most recent topographic or volumetric survey conducted on this dump facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the dump facility centroid in decimal degrees.',
    `liner_type` STRING COMMENT 'Type of liner system installed at the base of the dump facility for environmental protection and seepage control.. Valid values are `none|clay|geomembrane|composite|engineered`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the dump facility centroid in decimal degrees.',
    `maximum_lift_height_m` DECIMAL(18,2) COMMENT 'Maximum approved vertical lift height for each placement layer in meters as per geotechnical design.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste rock dump facility record was last modified or updated.',
    `monitoring_frequency` STRING COMMENT 'Required frequency of geotechnical and environmental monitoring inspections for this dump facility.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `operational_start_date` DATE COMMENT 'Date when the waste rock dump facility became operational and began receiving material.',
    `operational_status` STRING COMMENT 'Current operational state of the waste rock dump facility in its lifecycle.. Valid values are `active|inactive|suspended|closed|rehabilitation`',
    `rehabilitation_provision_amount` DECIMAL(18,2) COMMENT 'Financial provision amount set aside for future rehabilitation and closure of this waste rock dump facility in the reporting currency.',
    `rehabilitation_status` STRING COMMENT 'Current status of rehabilitation and closure activities for this dump facility.. Valid values are `not_started|in_progress|completed|monitoring`',
    `remaining_capacity_m3` DECIMAL(18,2) COMMENT 'Remaining available capacity in cubic meters, calculated as design capacity minus current volume.',
    CONSTRAINT pk_waste_rock_dump PRIMARY KEY(`waste_rock_dump_id`)
) COMMENT 'Master register of all waste rock dumps, overburden stockpiles, and low-grade ore stockpiles, including full placement event history. For facility master: captures dump identity, location, design capacity, current volume, lift height, batter angle, liner and drainage configuration, ARD classification (PAF/NAF/UC), geochemical risk rating, and operational status. For placement events: captures placement date, material type, volume placed, lift number, compaction method, geochemical classification (PAF/NAF), source pit or mining area, and placement equipment. SSOT for waste rock facility identity, physical characteristics, ARD risk profile, and incremental build-up tracking against approved designs and waste management plans.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`waste_placement` (
    `waste_placement_id` BIGINT COMMENT 'Unique identifier for the waste placement event. Primary key for the waste placement record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Placement activity costs (equipment, labor, compaction) are charged to the dump cost centre for mining cost tracking and reconciliation against planned unit costs.',
    `employee_id` BIGINT COMMENT 'Identifier of the inspector or geotechnical engineer who conducted the quality control inspection of the waste placement.',
    `pit_design_id` BIGINT COMMENT 'Identifier of the pit or mining area from which the waste material originated, enabling traceability from extraction to placement.',
    `asset_id` BIGINT COMMENT 'Identifier of the primary equipment unit (dozer, grader, compactor) used to place and spread the waste material.',
    `primary_waste_employee_id` BIGINT COMMENT 'Identifier of the equipment operator responsible for the waste placement activity, enabling accountability and performance tracking.',
    `shift_report_id` BIGINT COMMENT 'Identifier of the operational shift during which the waste placement occurred, supporting shift-based reporting and reconciliation.',
    `waste_dump_id` BIGINT COMMENT 'Identifier of the waste rock dump facility where the material was placed. Links to the waste dump master data.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Waste placement events occur at waste rock dumps within the tailings domain. The existing waste_dump_id FK points to mine.waste_dump (cross-domain). Adding waste_rock_dump_id creates the in-domain rel',
    `compaction_method` STRING COMMENT 'The method used to compact the placed waste material, critical for geotechnical stability and compliance with dump design specifications.. Valid values are `dozer_tracked|dozer_wheeled|roller_compaction|no_compaction|natural_settlement`',
    `compaction_passes` STRING COMMENT 'The number of compaction passes performed on the placed material, ensuring compliance with geotechnical design requirements for density and stability.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required to address non-conformance or quality issues identified during waste placement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this waste placement record was first created in the system, supporting audit trail and data lineage tracking.',
    `density_achieved_t_m3` DECIMAL(18,2) COMMENT 'The in-situ density achieved after compaction, measured in tonnes per cubic meter (t/m³), critical for geotechnical stability assessment.',
    `design_compliance_status` STRING COMMENT 'Indicates whether the waste placement complies with the approved waste dump design specifications and geotechnical requirements.. Valid values are `compliant|non_compliant|under_review|not_assessed`',
    `dump_location_code` STRING COMMENT 'The specific location or cell code within the waste dump where material was placed, enabling spatial tracking within the facility.. Valid values are `^[A-Z0-9]{3,20}$`',
    `elevation_m` DECIMAL(18,2) COMMENT 'The elevation above sea level of the waste placement location, measured in meters, critical for dump design compliance and stability monitoring.',
    `environmental_clearance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether environmental clearance was obtained prior to waste placement, ensuring compliance with Environmental Impact Statement (EIS) requirements.',
    `geochemical_classification` STRING COMMENT 'Geochemical classification indicating whether the material is Potentially Acid Forming (PAF) or Non-Acid Forming (NAF), critical for environmental management and acid rock drainage prevention.. Valid values are `PAF|NAF|PAF_encapsulated|uncertain|not_tested`',
    `gps_coordinates` STRING COMMENT 'The GPS coordinates (latitude, longitude) of the waste placement location, enabling precise spatial tracking and GIS integration.. Valid values are `^-?[0-9]{1,3}.[0-9]{4,10},s?-?[0-9]{1,3}.[0-9]{4,10}$`',
    `inspection_date` DATE COMMENT 'The date when quality control or geotechnical inspection of the waste placement was conducted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this waste placement record was last updated, enabling change tracking and audit compliance.',
    `lift_number` STRING COMMENT 'The sequential lift or layer number within the waste dump structure, tracking the vertical build-up against approved design specifications.',
    `material_type` STRING COMMENT 'Classification of the waste material placed, distinguishing between waste rock, overburden, topsoil, and other material categories.. Valid values are `waste_rock|overburden|topsoil|low_grade_ore|mixed_material|other`',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'The moisture content of the placed waste material as a percentage, affecting compaction effectiveness and geotechnical stability.',
    `non_conformance_description` STRING COMMENT 'Detailed description of any non-conformance, deviation, or issue identified during the waste placement activity, supporting corrective action tracking.',
    `non_conformance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any non-conformance or deviation from design specifications was identified during the waste placement.',
    `placement_date` DATE COMMENT 'The date when the waste rock or overburden was placed at the waste rock dump. Represents the principal business event timestamp for this transaction.',
    `placement_end_time` TIMESTAMP COMMENT 'The timestamp when the waste placement activity was completed, enabling duration calculation and productivity analysis.',
    `placement_start_time` TIMESTAMP COMMENT 'The timestamp when the waste placement activity commenced, providing precise timing for operational tracking and shift reconciliation.',
    `placement_status` STRING COMMENT 'Current lifecycle status of the waste placement event, tracking progression from initiation through completion or cancellation.. Valid values are `completed|in_progress|suspended|cancelled|under_review`',
    `planned_volume_m3` DECIMAL(18,2) COMMENT 'The planned or scheduled volume of waste material to be placed, enabling variance analysis between planned and actual placement.',
    `quality_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether quality control inspection was performed on the waste placement, ensuring compliance with operational standards.',
    `remarks` STRING COMMENT 'Free-text field for additional comments, observations, or contextual information related to the waste placement event.',
    `source_mining_area` STRING COMMENT 'The specific mining area, bench, or excavation zone from which the waste material was extracted, providing detailed source traceability.. Valid values are `^[A-Z0-9_]{2,50}$`',
    `tonnage_placed_t` DECIMAL(18,2) COMMENT 'The mass of waste material placed during this event, measured in tonnes (t). Used for reconciliation with haulage records and capacity planning.',
    `volume_placed_m3` DECIMAL(18,2) COMMENT 'The volume of waste material placed during this event, measured in cubic meters (m³). Principal quantitative measurement for waste placement tracking.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition during the waste placement activity, relevant for operational safety and material handling quality.. Valid values are `clear|rain|snow|wind|fog|extreme_heat`',
    `work_order_number` STRING COMMENT 'The work order or task number associated with this waste placement activity, linking to the mine planning and scheduling system.. Valid values are `^WO[0-9]{6,12}$`',
    CONSTRAINT pk_waste_placement PRIMARY KEY(`waste_placement_id`)
) COMMENT 'Records waste rock and overburden placement events at waste rock dumps, capturing placement date, material type, volume placed, lift number, compaction method, geochemical classification (PAF/NAF), source pit or mining area, and placement equipment. Tracks the incremental build-up of waste rock dumps against approved designs and waste management plans.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`water_balance` (
    `water_balance_id` BIGINT COMMENT 'Unique identifier for the water balance record. Primary key for the water balance data product.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Water management costs (pumping, treatment, monitoring) are allocated to the TSF cost centre for environmental compliance cost tracking and water licence fee allocation.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Water balance reporting is typically a permit condition for TSF operations. Links operational water management data to regulatory compliance obligations. Required for demonstrating permit compliance a',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: TSF water balance must reconcile decant_return_outflow_m3 with source processing plant water usage. Integrated water management requirement for site-wide water balance, licence compliance, and water c',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Water balance calculations require tracking preparer for regulatory compliance and technical accountability. Prepared_by name is denormalized. Critical for water licence reporting and audit trail.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Process water availability from TSF decant return directly constrains mining production rates in water-scarce operations. Mine planners schedule production based on water balance forecasts; decant vol',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility for which this water balance is calculated.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the water balance for operational use or regulatory submission. Typically a senior technical authority or site manager.',
    `balance_calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the water balance calculation was performed. Supports audit trail and version control for reconciliation purposes.',
    `balance_notes` STRING COMMENT 'Free-text field for recording observations, assumptions, data quality issues, or operational events that affected the water balance during the period. Supports interpretation and future reference.',
    `balance_period_end_date` DATE COMMENT 'End date of the water balance calculation period. Defines the reporting interval for inflows, outflows, and storage changes.',
    `balance_period_start_date` DATE COMMENT 'Start date of the water balance calculation period. Typically daily, weekly, or monthly depending on operational requirements and regulatory reporting frequency.',
    `balance_reconciliation_variance_m3` DECIMAL(18,2) COMMENT 'Difference between calculated storage change and measured storage change, measured in cubic meters. Represents the water balance closure error and indicates measurement accuracy and unaccounted losses or gains.',
    `balance_reconciliation_variance_percent` DECIMAL(18,2) COMMENT 'Balance reconciliation variance expressed as a percentage of total inflow. Provides a normalized measure of water balance accuracy. Acceptable variance thresholds are typically defined in operational procedures.',
    `balance_status` STRING COMMENT 'Current status of the water balance record in the approval workflow. Draft indicates initial calculation, preliminary for review, final for operational use, revised for corrections, and approved for regulatory submission.. Valid values are `draft|preliminary|final|revised|approved`',
    `closing_pond_level_m` DECIMAL(18,2) COMMENT 'Elevation of the TSF pond water surface at the end of the balance period, measured in meters above a defined datum. Used to calculate closing storage volume and freeboard.',
    `closing_storage_volume_m3` DECIMAL(18,2) COMMENT 'Volume of water stored in the TSF pond at the end of the balance period, measured in cubic meters. Derived from pond level survey and storage-elevation relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the water balance record was first created in the system. Supports audit trail and data lineage tracking.',
    `crest_elevation_m` DECIMAL(18,2) COMMENT 'Current elevation of the TSF embankment crest at the time of the balance period, measured in meters above a defined datum. Used to calculate freeboard and assess storage capacity.',
    `decant_return_outflow_m3` DECIMAL(18,2) COMMENT 'Volume of water returned from the TSF to the process plant or water storage via decant structures during the balance period, measured in cubic meters. Primary mechanism for water recovery and freeboard management.',
    `design_freeboard_m` DECIMAL(18,2) COMMENT 'Minimum required freeboard specified in the TSF design for the current operational stage, measured in meters. Used to assess compliance with design criteria and trigger operational responses.',
    `evaporation_outflow_m3` DECIMAL(18,2) COMMENT 'Volume of water lost from the TSF pond through evaporation during the balance period, measured in cubic meters. Calculated from evaporation rate and pond surface area.',
    `freeboard_m` DECIMAL(18,2) COMMENT 'Vertical distance between the pond water level and the embankment crest at the end of the balance period, measured in meters. Critical safety parameter for TSF operational management and regulatory compliance.',
    `groundwater_inflow_m3` DECIMAL(18,2) COMMENT 'Volume of groundwater ingress into the TSF pond during the balance period, measured in cubic meters. Typically estimated from piezometric monitoring and seepage models.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the water balance record was last updated. Supports version control and change tracking for water management data.',
    `opening_pond_level_m` DECIMAL(18,2) COMMENT 'Elevation of the TSF pond water surface at the start of the balance period, measured in meters above a defined datum. Used to calculate opening storage volume.',
    `opening_storage_volume_m3` DECIMAL(18,2) COMMENT 'Volume of water stored in the TSF pond at the start of the balance period, measured in cubic meters. Derived from pond level survey and storage-elevation relationship.',
    `other_inflow_m3` DECIMAL(18,2) COMMENT 'Volume of any other water sources entering the TSF during the balance period not captured in standard inflow categories, measured in cubic meters. May include emergency water transfers or unplanned sources.',
    `other_outflow_m3` DECIMAL(18,2) COMMENT 'Volume of any other water losses from the TSF during the balance period not captured in standard outflow categories, measured in cubic meters. May include emergency releases or unplanned discharges.',
    `process_water_inflow_m3` DECIMAL(18,2) COMMENT 'Volume of process water discharged to the TSF from mineral processing operations during the balance period, measured in cubic meters. Includes tailings slurry water and any additional process water streams.',
    `rainfall_inflow_m3` DECIMAL(18,2) COMMENT 'Volume of direct rainfall onto the TSF pond surface during the balance period, calculated from rainfall depth and pond area, measured in cubic meters.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who reviewed and validated the water balance calculation. Ensures quality control and technical oversight of water management data.',
    `runoff_inflow_m3` DECIMAL(18,2) COMMENT 'Volume of surface water runoff from the TSF catchment area entering the pond during the balance period, measured in cubic meters. Includes runoff from embankment slopes and upstream catchment if not diverted.',
    `seepage_outflow_m3` DECIMAL(18,2) COMMENT 'Volume of water lost through seepage from the TSF embankment and foundation during the balance period, measured in cubic meters. Estimated from piezometric data, seepage collection systems, and geotechnical models.',
    `spillway_discharge_outflow_m3` DECIMAL(18,2) COMMENT 'Volume of water discharged through the TSF spillway during the balance period, measured in cubic meters. Typically occurs during extreme rainfall events when pond capacity is exceeded.',
    `storage_change_m3` DECIMAL(18,2) COMMENT 'Net change in water storage volume during the balance period, measured in cubic meters. Calculated as closing storage minus opening storage. Should reconcile with total inflow minus total outflow.',
    `total_inflow_m3` DECIMAL(18,2) COMMENT 'Sum of all water inflows to the TSF during the balance period, measured in cubic meters. Calculated as process water + rainfall + runoff + groundwater + other inflows.',
    `total_outflow_m3` DECIMAL(18,2) COMMENT 'Sum of all water outflows from the TSF during the balance period, measured in cubic meters. Calculated as evaporation + seepage + decant return + spillway discharge + other outflows.',
    `water_licence_compliance_status` STRING COMMENT 'Assessment of whether the water balance period operations complied with water licence conditions including discharge limits, return water quality, and reporting requirements.. Valid values are `compliant|non_compliant|not_applicable|under_review`',
    CONSTRAINT pk_water_balance PRIMARY KEY(`water_balance_id`)
) COMMENT 'Periodic water balance calculations and decant operation records for TSFs and associated water management infrastructure. For water balance: captures all inflows (process water, rainfall, runoff, groundwater ingress), outflows (evaporation, seepage, decant return, spillway discharge), storage volumes, pond levels, freeboard, and reconciliation against design assumptions. For decant operations: captures decant event date, decant structure used (penstock, decant tower, pump), volume decanted, water quality at point of decant, destination (process water return, evaporation pond, treatment plant), and compliance with water licence conditions. SSOT for TSF water management including return water quality. Supports water licence compliance, TSF operational planning, and GISTM Requirement 12 (management of water).';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`closure_plan` (
    `closure_plan_id` BIGINT COMMENT 'Unique identifier for the mine closure and rehabilitation plan record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Closure plan execution is managed as a capital project with approved budget, schedule, contractors, and stage gates. Regulatory requirements mandate project-level governance for closure activities inc',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Closure plans must reference environmental permits that govern closure obligations, post-closure water quality limits, and rehabilitation standards. Required for regulatory approval and financial assu',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: TSF closure cost NPV and timing are mandatory inputs to LOM financial models for reserve reporting under JORC/NI 43-101. Integrated mine-TSF closure planning is required for regulatory approval and fi',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Closure plans require consultation with primary affected stakeholders (traditional owners, downstream communities, regulatory bodies). Mining operations track stakeholder consultation requirements, FP',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Closure execution involves long-term rehabilitation service contracts with specialized contractors. Linking closure plans to contracts enables financial assurance validation, contractor performance mo',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Closure plans require tracking responsible engineer for design accountability and regulatory approval. Engineer name/registration are denormalized. Essential for closure liability management and regul',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Closure plans must attribute rehabilitation costs to revenue-generating products for full lifecycle costing. Required for product profitability analysis including closure provisions, financial reporti',
    `social_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to community.social_impact_assessment. Business justification: Closure planning is a major project phase requiring social impact assessment under IFC PS1 and regulatory frameworks. SIA informs closure strategy, stakeholder engagement, resettlement needs, and post',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Closure plans must reference the specific tenement for regulatory submission to the granting authority, financial assurance lodgement (tied to tenement holder obligations), and relinquishment planning',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility or waste rock facility covered by this closure plan.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Closure plans are required for waste rock dumps under mining regulations. Currently closure_plan only has tsf_id. Adding waste_rock_dump_id enables tracking closure planning for waste rock facilities.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Closure projects are tracked as WBS elements for detailed cost estimation, budget tracking, and financial assurance reconciliation. Required for NPV calculation and regulatory bond updates.',
    `approval_date` DATE COMMENT 'Date on which the closure plan received formal approval from the regulatory authority.',
    `assurance_expiry_date` DATE COMMENT 'Expiry or renewal date of the financial assurance instrument, requiring periodic review and renewal to maintain regulatory compliance.',
    `assurance_lodgement_date` DATE COMMENT 'Date on which the financial assurance instrument was lodged with or accepted by the regulatory authority.',
    `closure_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated closure cost and financial assurance amounts.. Valid values are `^[A-Z]{3}$`',
    `closure_cost_npv` DECIMAL(18,2) COMMENT 'Net present value of the closure liability, discounted to current date using the specified discount rate, for financial provisioning and balance sheet reporting.',
    `closure_strategy` STRING COMMENT 'High-level description of the closure approach, including final landform design philosophy, rehabilitation objectives, and post-closure land use intent.',
    `consultation_date` DATE COMMENT 'Date on which formal stakeholder consultation activities were completed for this closure plan version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closure plan record was first created in the system.',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Annual discount rate applied to calculate the net present value of future closure costs, typically aligned with corporate weighted average cost of capital or regulatory guidance.',
    `estimated_closure_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for executing the closure plan, including earthworks, revegetation, water management, demolition, and post-closure monitoring, expressed in the specified currency.',
    `final_landform_design` STRING COMMENT 'Detailed description of the engineered final landform configuration, including slope angles, drainage patterns, vegetation cover, and integration with surrounding topography.',
    `financial_assurance_amount` DECIMAL(18,2) COMMENT 'Total amount of financial assurance lodged with the regulatory body, expressed in the closure cost currency, to guarantee availability of funds for closure execution.',
    `financial_assurance_instrument_type` STRING COMMENT 'Type of financial assurance mechanism lodged with the regulatory authority to secure closure obligations.. Valid values are `bond|bank_guarantee|trust_fund|letter_of_credit|insurance_policy|self_insurance`',
    `independent_review_date` DATE COMMENT 'Date on which the independent technical review of the closure plan was completed.',
    `independent_reviewer` STRING COMMENT 'Name of the independent third-party expert or firm that conducted technical review of the closure plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this closure plan record was most recently updated, supporting audit trail and version control.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review and update of the closure plan, typically required every 3-5 years or upon material change to operations.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, constraints, or special conditions relevant to the closure plan and financial provisioning.',
    `plan_document_reference` STRING COMMENT 'Document management system reference or file path to the formal closure plan document, drawings, and supporting technical reports.',
    `plan_reference_number` STRING COMMENT 'Externally-known business identifier for the closure plan, used in regulatory submissions and internal documentation.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the closure plan in the regulatory approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|superseded|archived — 7 candidates stripped; promote to reference product]',
    `plan_version` STRING COMMENT 'Version number of the closure plan document, incremented with each major or minor revision.. Valid values are `^[0-9]{1,2}.[0-9]{1,2}$`',
    `planned_closure_completion_date` DATE COMMENT 'Target date for completion of all closure and rehabilitation works, after which post-closure monitoring and maintenance phase begins.',
    `planned_closure_start_date` DATE COMMENT 'Scheduled date for commencement of final closure activities for the facility, aligned with Life of Mine (LOM) planning.',
    `post_closure_monitoring_period_years` STRING COMMENT 'Duration in years for which post-closure environmental and geotechnical monitoring will be conducted before final relinquishment.',
    `progressive_rehabilitation_flag` BOOLEAN COMMENT 'Indicates whether the closure plan incorporates progressive rehabilitation activities during the operational Life of Mine (LOM) phase.',
    `regulatory_approval_authority` STRING COMMENT 'Name of the government agency or regulatory body responsible for reviewing and approving the closure plan and financial assurance.',
    `regulatory_approval_reference` STRING COMMENT 'Official reference number or identifier assigned by the regulatory authority upon approval of the closure plan.',
    `rehabilitation_objectives` STRING COMMENT 'Documented rehabilitation goals including ecosystem restoration targets, water quality outcomes, geotechnical stability criteria, and community land use expectations.',
    `review_frequency_years` STRING COMMENT 'Regulatory or corporate mandated frequency in years for periodic review and update of the closure plan.',
    `stakeholder_consultation_flag` BOOLEAN COMMENT 'Indicates whether community and stakeholder consultation was conducted as part of closure plan development, as required by ICMM GISTM.',
    `variance_to_approved_estimate_percent` DECIMAL(18,2) COMMENT 'Percentage variance between the current estimated closure cost and the last regulatory-approved estimate, triggering re-approval if threshold exceeded.',
    CONSTRAINT pk_closure_plan PRIMARY KEY(`closure_plan_id`)
) COMMENT 'Master records for mine closure and rehabilitation plans associated with TSFs and waste rock facilities, including closure strategy, final landform design, rehabilitation objectives, progressive rehabilitation milestones, and regulatory approval status. Incorporates financial liability provisioning: estimated closure cost, net present value (NPV) of liability, discount rate, financial assurance instrument type (bond, bank guarantee, trust fund), assurance amount lodged, regulatory body, review schedule, and variance to approved estimate. Supports ICMM GISTM Requirements 6 (closure planning) and 9 (financial assurance), IFRS/IAS 37 provisioning, and regulatory financial assurance compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` (
    `rehabilitation_activity_id` BIGINT COMMENT 'Unique identifier for the rehabilitation activity record. Primary key.',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: Progressive rehabilitation activities consume capex budget (sustaining capital). Required for budget vs actual variance reporting and forecast-at-completion analysis for closure cost estimates.',
    `closure_plan_id` BIGINT COMMENT 'Foreign key linking to tailings.closure_plan. Business justification: Rehabilitation activities are executed according to a specific closure plan. The existing closure_plan_reference is a STRING; adding FK enables proper parent-child relationship. Cardinality is N:1 (ma',
    `commitment_id` BIGINT COMMENT 'Foreign key linking to community.community_commitment. Business justification: Rehabilitation milestones are often tracked as community commitments in closure agreements, benefit-sharing arrangements, and regulatory conditions. Mining operations link rehabilitation activities to',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: Rehabilitation work is commonly contractor-executed. Tracking contractor identity enables cost management, performance evaluation, and compliance verification. Contractor name/registration are denorma',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Rehabilitation contractors are stakeholders requiring engagement for local content commitments, contractor registration verification, and performance monitoring. Stakeholder register tracks contractor',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Rehabilitation contractors work under service contracts specifying rates, performance criteria, and terms. Linking activities to contracts enables contractor performance evaluation, payment verificati',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Rehabilitation activities procure topsoil, seed mixes, fertilizers, erosion control materials, and mulch. Linking to PO enables cost tracking against rehabilitation budgets, material delivery scheduli',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rehabilitation activities require tracking site supervisor for field execution accountability and quality control. Supervisor name is denormalized. Critical for rehabilitation program management and c',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Rehabilitation activities are often explicit conditions of tenement grant or renewal (regulatory_condition). Mining operators must report rehabilitation progress against tenement-specific obligations ',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility where the rehabilitation activity is being performed.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Rehabilitation activities occur at waste rock dumps as well as TSFs. Currently rehabilitation_activity only has tsf_id. Adding waste_rock_dump_id enables tracking rehabilitation at waste rock faciliti',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Individual rehab activities are WBS sub-elements under closure plans for detailed cost tracking, contractor payment processing, and progressive rehabilitation cost capitalization decisions.',
    `activity_notes` STRING COMMENT 'Additional notes, comments, or observations related to the rehabilitation activity including challenges encountered, lessons learned, or special conditions.',
    `activity_reference_number` STRING COMMENT 'Business identifier or work order number assigned to this rehabilitation activity for tracking and reporting purposes.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the rehabilitation activity (e.g., planned, in progress, completed, on hold, cancelled, under review).. Valid values are `planned|in_progress|completed|on_hold|cancelled|under_review`',
    `activity_type` STRING COMMENT 'Classification of the rehabilitation work being undertaken (e.g., regrading, capping, revegetation, erosion control, drainage installation, soil amendment, topsoil placement, seeding, mulching, fencing). [ENUM-REF-CANDIDATE: regrading|capping|revegetation|erosion_control|drainage_installation|soil_amendment|topsoil_placement|seeding|mulching|fencing — 10 candidates stripped; promote to reference product]',
    `actual_completion_date` DATE COMMENT 'Actual date when the rehabilitation activity was completed and signed off.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for the rehabilitation activity upon completion.',
    `actual_start_date` DATE COMMENT 'Actual date when the rehabilitation activity commenced on site.',
    `approval_authority` STRING COMMENT 'Name of the regulatory authority or government body that approved the rehabilitation activity.',
    `area_treated_hectares` DECIMAL(18,2) COMMENT 'Total area in hectares that has been or will be rehabilitated under this activity.',
    `assessment_date` DATE COMMENT 'Date when the rehabilitation activity was assessed against the success criteria.',
    `assessment_notes` STRING COMMENT 'Detailed notes and observations from the rehabilitation success criteria assessment.',
    `assessment_outcome` STRING COMMENT 'Outcome of the success criteria assessment (e.g., passed, failed, partial, pending, not assessed).. Valid values are `passed|failed|partial|pending|not_assessed`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated and actual costs (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rehabilitation activity record was first created in the system.',
    `environmental_monitoring_required` BOOLEAN COMMENT 'Flag indicating whether ongoing environmental monitoring is required following completion of this rehabilitation activity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of the rehabilitation activity as per the budget or closure plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rehabilitation activity record was last updated in the system.',
    `materials_used_description` STRING COMMENT 'Description of materials used in the rehabilitation activity including topsoil, seed mix, mulch, geotextiles, rock, or other materials.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which environmental monitoring will be conducted post-rehabilitation (e.g., weekly, monthly, quarterly, semi-annual, annual, as required).. Valid values are `weekly|monthly|quarterly|semi_annual|annual|as_required`',
    `planned_completion_date` DATE COMMENT 'Scheduled date for completion of the rehabilitation activity as per the approved closure plan.',
    `planned_start_date` DATE COMMENT 'Scheduled date for commencement of the rehabilitation activity as per the approved closure plan.',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was granted for this rehabilitation activity.',
    `rehabilitation_phase` STRING COMMENT 'Phase of mine rehabilitation lifecycle this activity belongs to (progressive, interim, final, post-closure).. Valid values are `progressive|interim|final|post_closure`',
    `seed_application_rate_kg_per_ha` DECIMAL(18,2) COMMENT 'Rate at which seed was applied measured in kilograms per hectare.',
    `seed_mix_type` STRING COMMENT 'Type or specification of seed mix used for revegetation (e.g., native species blend, pasture mix, erosion control mix).',
    `site_location_description` STRING COMMENT 'Textual description of the specific location within the TSF or waste rock dump where the rehabilitation activity is taking place.',
    `success_criteria_description` STRING COMMENT 'Description of the success criteria or performance indicators that will be used to assess the effectiveness of the rehabilitation activity (e.g., vegetation cover percentage, erosion rate, species diversity).',
    `target_vegetation_cover_percent` DECIMAL(18,2) COMMENT 'Target percentage of vegetation cover to be achieved as part of the rehabilitation success criteria.',
    `topsoil_volume_m3` DECIMAL(18,2) COMMENT 'Volume of topsoil in cubic meters placed during the rehabilitation activity.',
    CONSTRAINT pk_rehabilitation_activity PRIMARY KEY(`rehabilitation_activity_id`)
) COMMENT 'Records progressive and final rehabilitation activities undertaken at TSFs, waste rock dumps, and disturbed areas, including activity type (regrading, capping, revegetation, erosion control), area treated, materials used, completion date, responsible contractor, and success criteria assessment. Tracks rehabilitation progress against the approved closure plan and regulatory milestones.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`closure_liability` (
    `closure_liability_id` BIGINT COMMENT 'Unique identifier for the mine closure and rehabilitation financial liability record.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: Closure liability timing and costs affect benefit-sharing calculations, trust fund contributions, and community compensation arrangements. Mining operations link closure financial provisions to benefi',
    `closure_plan_id` BIGINT COMMENT 'Foreign key linking to tailings.closure_plan. Business justification: Financial liability records are calculated based on a specific closure plan version. The existing closure_plan_reference is a STRING reference number; adding a proper FK enables relational integrity a',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Closure liabilities are allocated to cost centres for management accounting and rehabilitation provision tracking. The current cost_centre_code (string) should be replaced with FK to finance.cost_cent',
    `legal_register_id` BIGINT COMMENT 'Foreign key linking to hse.legal_register. Business justification: Closure liabilities are driven by regulatory obligations documented in legal register (mining acts, environmental protection acts, rehabilitation codes). Links financial provisioning to specific legal',
    `rehabilitation_provision_id` BIGINT COMMENT 'Foreign key linking to finance.rehabilitation_provision. Business justification: Direct link between closure liability estimates and financial provision accounting. Required for IAS 37 provision reconciliation, discount rate application, and annual provision movement reporting.',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Financial closure liabilities must be attributed to products for accurate lifecycle cost accounting. Required for product-level profitability analysis, financial provisioning by product line, regulato',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility or waste facility for which this closure liability is recorded.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Closure liabilities exist for waste rock dumps as well as TSFs. Currently closure_liability only has tsf_id. Mining operations must provision for closure costs of all facilities. Cardinality is N:1. B',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Closure liabilities are linked to closure WBS elements for detailed cost breakdown and reconciliation between provision accounting and project cost estimates. Required for financial assurance updates.',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority approved the closure liability estimate and financial assurance arrangement.',
    `approved_estimate_amount` DECIMAL(18,2) COMMENT 'The closure cost estimate amount that was formally approved by the regulatory authority, used as the baseline for variance analysis.',
    `assurance_amount_lodged` DECIMAL(18,2) COMMENT 'Total amount of financial assurance currently lodged with the regulatory body to cover the closure liability.',
    `assurance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the financial assurance amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `consequence_classification` STRING COMMENT 'Risk-based consequence classification of the facility requiring closure, based on potential environmental, social, and economic impacts of failure.. Valid values are `low|significant|high|very_high|extreme`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the closure cost and net present value are denominated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the closure liability record was first created in the system.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Annual discount rate applied to calculate the net present value of future closure costs, typically based on risk-free rate or weighted average cost of capital.',
    `estimate_basis` STRING COMMENT 'Description of the methodology, assumptions, and data sources used to calculate the closure cost estimate.',
    `estimate_date` DATE COMMENT 'Date on which the current closure cost estimate was prepared or last updated.',
    `estimate_prepared_by` STRING COMMENT 'Name of the individual or consulting firm responsible for preparing the closure cost estimate.',
    `estimated_closure_cost` DECIMAL(18,2) COMMENT 'Total estimated cost to complete closure and rehabilitation activities for the facility, expressed in the reporting currency.',
    `expected_closure_completion_date` DATE COMMENT 'Anticipated date when all closure and rehabilitation activities are expected to be completed and the site relinquished.',
    `expected_closure_start_date` DATE COMMENT 'Anticipated date when closure and rehabilitation activities are expected to commence, based on the current life of mine plan.',
    `financial_assurance_instrument_type` STRING COMMENT 'Type of financial instrument lodged with the regulatory authority to secure the closure liability obligation.. Valid values are `surety_bond|bank_guarantee|trust_fund|letter_of_credit|cash_deposit|insurance_policy`',
    `independent_review_date` DATE COMMENT 'Date on which the independent review of the closure liability estimate was completed.',
    `independent_review_required` BOOLEAN COMMENT 'Indicates whether an independent third-party review of the closure liability estimate is required by regulation or company policy.',
    `independent_reviewer` STRING COMMENT 'Name of the independent third-party reviewer or firm that validated the closure cost estimate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the closure liability record was last updated or modified.',
    `liability_notes` STRING COMMENT 'Free-text field for additional comments, assumptions, or context related to the closure liability estimate and financial assurance arrangement.',
    `liability_reference_number` STRING COMMENT 'External business identifier for the closure liability record, used in financial reporting and regulatory submissions.',
    `liability_status` STRING COMMENT 'Current lifecycle status of the closure liability estimate in the financial provisioning and regulatory approval process.. Valid values are `estimated|approved|under_review|revised|closed`',
    `liability_type` STRING COMMENT 'Classification of the closure liability by the type of facility or activity requiring rehabilitation.. Valid values are `tsf_closure|waste_rock_dump_closure|pit_rehabilitation|infrastructure_decommissioning|water_treatment|ongoing_monitoring`',
    `net_present_value` DECIMAL(18,2) COMMENT 'Discounted present value of the estimated closure cost, calculated using the discount rate and expected timing of expenditures.',
    `provision_account_code` STRING COMMENT 'General ledger account code in the enterprise resource planning system where the closure liability provision is recorded.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier of the regulatory approval or permit under which the closure liability estimate was accepted.',
    `regulatory_body` STRING COMMENT 'Name of the government or regulatory authority responsible for approving and monitoring the closure liability and financial assurance.',
    `review_date` DATE COMMENT 'Scheduled date for the next regulatory or internal review of the closure liability estimate and financial assurance adequacy.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between the current estimated closure cost and the approved estimate, calculated as variance divided by approved estimate.',
    `variance_to_approved_estimate` DECIMAL(18,2) COMMENT 'Difference between the current estimated closure cost and the approved estimate amount, indicating cost escalation or reduction.',
    CONSTRAINT pk_closure_liability PRIMARY KEY(`closure_liability_id`)
) COMMENT 'Financial liability records for mine closure and rehabilitation obligations associated with TSFs and waste facilities, capturing estimated closure cost, net present value (NPV) of liability, discount rate, financial assurance instrument type (bond, bank guarantee, trust fund), assurance amount lodged, regulatory body, review date, and variance to approved estimate. Supports IFRS financial provisioning and regulatory financial assurance compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`ard_assessment` (
    `ard_assessment_id` BIGINT COMMENT 'Unique identifier for the acid rock drainage assessment record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: ARD testing costs (lab analysis, kinetic testing) are charged to the facility cost centre for environmental compliance cost tracking and closure cost estimation.',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: ARD risk classifications and metal leaching test results showing contamination potential trigger community environmental grievances about water quality and health impacts. Operations link ARD assessme',
    `laboratory_id` BIGINT COMMENT 'FK to laboratory.laboratory',
    `laboratory_sample_id` BIGINT COMMENT 'Unique identifier for the waste rock or tailings sample subjected to geochemical testing. Links to laboratory sample management system.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Acid rock drainage assessments inform tenement-level environmental conditions and may trigger specific regulatory conditions attached to the tenement. Results are reported to regulatory authorities as',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility from which the sample was collected, if applicable.',
    `waste_rock_dump_id` BIGINT COMMENT 'Reference to the waste rock dump or stockpile from which the sample was collected, if applicable.',
    `anc_kg_caco3_per_tonne` DECIMAL(18,2) COMMENT 'Acid neutralization capacity expressed as kilograms of calcium carbonate equivalent per tonne of material.',
    `ard_risk_classification` STRING COMMENT 'Classification of acid rock drainage risk: PAF (Potentially Acid Forming), NAF (Non-Acid Forming), UC (Uncertain), or risk level (low, moderate, high).. Valid values are `PAF|NAF|UC|low_risk|moderate_risk|high_risk`',
    `arsenic_leachate_mg_per_l` DECIMAL(18,2) COMMENT 'Arsenic concentration in leachate solution expressed in milligrams per liter.',
    `assessed_by` STRING COMMENT 'Name of the geochemist or environmental specialist who interpreted the test results and assigned the ARD risk classification.',
    `assessment_date` DATE COMMENT 'Date when the ARD assessment was completed and results were finalized.',
    `assessment_notes` STRING COMMENT 'Additional comments, observations, or contextual information relevant to the ARD assessment and management recommendations.',
    `assessment_status` STRING COMMENT 'Current status of the ARD assessment record in the approval workflow.. Valid values are `draft|pending_review|approved|superseded`',
    `carbonate_content_percent` DECIMAL(18,2) COMMENT 'Carbonate mineral content expressed as weight percentage, primary source of acid neutralization capacity.',
    `copper_leachate_mg_per_l` DECIMAL(18,2) COMMENT 'Copper concentration in leachate solution expressed in milligrams per liter.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ARD assessment record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ARD assessment record was last updated or modified.',
    `lead_leachate_mg_per_l` DECIMAL(18,2) COMMENT 'Lead concentration in leachate solution expressed in milligrams per liter.',
    `lithology` STRING COMMENT 'Geological rock type or lithological unit of the sample (e.g., granite, basalt, shale, schist).',
    `management_strategy` STRING COMMENT 'Recommended waste management strategy based on ARD and ML assessment results (e.g., encapsulation, co-disposal with NAF material, underwater storage, lime treatment).',
    `material_type` STRING COMMENT 'Classification of the material tested: waste rock, tailings, overburden, ore reject, or mixed material.. Valid values are `waste_rock|tailings|overburden|ore_reject|mixed`',
    `maximum_potential_acidity_kg_h2so4_per_tonne` DECIMAL(18,2) COMMENT 'Maximum potential acidity calculated from total sulfur content, representing worst-case acid generation potential.',
    `metal_leaching_risk` STRING COMMENT 'Assessment of metal leaching risk based on leachate test results and metal concentrations.. Valid values are `low|moderate|high|very_high`',
    `nag_ph` DECIMAL(18,2) COMMENT 'Final pH value from Net Acid Generation test, indicating the acid-generating potential after oxidation.',
    `nag_value_kg_h2so4_per_tonne` DECIMAL(18,2) COMMENT 'Net acid generation potential expressed as kilograms of sulfuric acid equivalent per tonne of material.',
    `net_neutralization_potential_ratio` DECIMAL(18,2) COMMENT 'Ratio of acid neutralization capacity to maximum potential acidity (ANC/MPA), used to classify ARD risk.',
    `paste_ph` DECIMAL(18,2) COMMENT 'pH value measured from paste pH test, indicating acidity or alkalinity of the sample when mixed with water.',
    `review_date` DATE COMMENT 'Date when the assessment was reviewed and approved by the senior reviewer.',
    `reviewed_by` STRING COMMENT 'Name of the senior geochemist or competent person who reviewed and approved the assessment.',
    `sample_collection_date` DATE COMMENT 'Date when the physical sample was collected from the field location.',
    `sample_depth_m` DECIMAL(18,2) COMMENT 'Depth in meters below surface at which the sample was collected, relevant for drill core or pit samples.',
    `sample_location_description` STRING COMMENT 'Textual description of the specific location within the TSF, waste rock dump, or mine site where the sample was collected.',
    `sulfate_sulfur_percent` DECIMAL(18,2) COMMENT 'Sulfate sulfur content expressed as weight percentage, representing pre-oxidized sulfur that does not contribute to further acid generation.',
    `sulfide_sulfur_percent` DECIMAL(18,2) COMMENT 'Sulfide sulfur content expressed as weight percentage, representing the acid-generating sulfur fraction.',
    `test_method` STRING COMMENT 'Geochemical test method applied: NAG (Net Acid Generation), ANC (Acid Neutralization Capacity), paste pH, SPLP (Synthetic Precipitation Leaching Procedure), kinetic cell, humidity cell, column leach, or other. [ENUM-REF-CANDIDATE: NAG|ANC|paste_pH|SPLP|kinetic_cell|humidity_cell|column_leach|other — 8 candidates stripped; promote to reference product]',
    `test_report_reference` STRING COMMENT 'Document reference or file path to the detailed laboratory test report.',
    `total_sulfur_percent` DECIMAL(18,2) COMMENT 'Total sulfur content of the sample expressed as weight percentage, primary indicator of acid generation potential.',
    `zinc_leachate_mg_per_l` DECIMAL(18,2) COMMENT 'Zinc concentration in leachate solution expressed in milligrams per liter.',
    CONSTRAINT pk_ard_assessment PRIMARY KEY(`ard_assessment_id`)
) COMMENT 'Records Acid Rock Drainage (ARD) and Metal Leaching (ML) geochemical assessments conducted on waste rock and tailings materials, including sample identity, test type (NAG, ANC, paste pH, SPLP leach), net acid generation potential, acid neutralisation capacity, net neutralisation potential ratio (NPR), ARD risk classification (PAF/NAF/UC), and recommended management strategy. Critical for waste characterisation and closure planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` (
    `tsf_capacity_survey_id` BIGINT COMMENT 'Unique identifier for the TSF capacity survey record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Survey costs (contractor fees, drone surveys, data processing) are charged to the TSF cost centre for operational cost tracking and regulatory compliance reporting.',
    `tsf_id` BIGINT COMMENT 'Foreign key reference to the tailings storage facility that was surveyed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Capacity surveys require validation by qualified engineer for regulatory acceptance and design compliance. Validation engineer name is denormalized. Critical for survey quality assurance and regulator',
    `beach_elevation_m` DECIMAL(18,2) COMMENT 'Average elevation of the tailings beach surface in meters above sea level or site datum, measured during the survey. The beach is the sloped surface of deposited tailings.',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of total storage capacity currently utilized, calculated as (current storage volume / total storage capacity) × 100. Key indicator for TSF filling rate monitoring.',
    `coordinate_system` STRING COMMENT 'Geodetic coordinate reference system used for the survey, including datum and projection (e.g., WGS84 UTM Zone 50S, GDA2020 MGA Zone 51).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey record was first created in the system. Audit trail field.',
    `crest_elevation_m` DECIMAL(18,2) COMMENT 'Current elevation of the TSF embankment crest in meters above sea level or site datum at the time of survey.',
    `current_storage_volume_m3` DECIMAL(18,2) COMMENT 'Current volume of tailings material stored in the TSF in cubic meters at the time of the survey.',
    `design_capacity_m3` DECIMAL(18,2) COMMENT 'Original design storage capacity of the TSF in cubic meters at the current stage or raise level, as specified in engineering design documents.',
    `estimated_filling_rate_m3_per_day` DECIMAL(18,2) COMMENT 'Estimated average daily rate at which the TSF is being filled with tailings material in cubic meters per day, calculated from historical deposition data.',
    `freeboard_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measured freeboard meets or exceeds the minimum required freeboard. True indicates compliance, False indicates non-compliance requiring immediate action.',
    `freeboard_m` DECIMAL(18,2) COMMENT 'Vertical distance in meters between the pond water surface elevation and the crest elevation. Critical safety parameter monitored against design requirements and regulatory limits.',
    `horizontal_accuracy_m` DECIMAL(18,2) COMMENT 'Horizontal positional accuracy of the survey measurements in meters, representing the precision of X-Y coordinate data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey record was last modified in the system. Audit trail field.',
    `minimum_required_freeboard_m` DECIMAL(18,2) COMMENT 'Minimum freeboard distance in meters required by design specifications and regulatory requirements. Used to assess compliance and trigger operational responses.',
    `pond_elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the supernatant pond water surface in meters above sea level or site datum, measured during the survey.',
    `pond_surface_area_m2` DECIMAL(18,2) COMMENT 'Surface area of the supernatant pond (water body) on the TSF in square meters at the time of survey. Critical for freeboard and dam safety monitoring.',
    `projected_capacity_exhaustion_date` DATE COMMENT 'Forecasted date when the TSF will reach full capacity based on remaining airspace and estimated filling rate. Critical for raise scheduling and operational planning.',
    `regulatory_submission_date` DATE COMMENT 'Date on which the survey results were submitted to regulatory authorities for compliance reporting.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Boolean indicator of whether this survey was submitted to regulatory authorities as part of compliance reporting requirements. True indicates submission was made.',
    `remaining_airspace_m3` DECIMAL(18,2) COMMENT 'Available remaining storage capacity in cubic meters, calculated as the difference between total storage capacity and current storage volume. Critical metric for operational planning and raise scheduling.',
    `survey_accuracy_classification` STRING COMMENT 'Classification of the survey accuracy level based on surveying standards and methodology. High accuracy surveys use advanced methods like LiDAR or drone photogrammetry with ground control.. Valid values are `high|medium|standard|reconnaissance`',
    `survey_date` DATE COMMENT 'The date on which the volumetric capacity survey was conducted. Principal business event timestamp for this survey record.',
    `survey_method` STRING COMMENT 'The surveying technology or method used to capture volumetric data for the TSF capacity assessment. Includes drone photogrammetry, LiDAR, GPS survey, total station, bathymetric survey, and terrestrial laser scanning.. Valid values are `drone_photogrammetry|lidar|gps_survey|total_station|bathymetric_survey|terrestrial_laser_scanning`',
    `survey_notes` STRING COMMENT 'Free-text field for additional observations, conditions, limitations, or contextual information relevant to the capacity survey.',
    `survey_reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this capacity survey for tracking and reporting purposes.',
    `survey_report_reference` STRING COMMENT 'Document reference number or identifier for the detailed survey report containing methodology, data, calculations, and certifications.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the capacity survey record. Tracks progression from draft through validation and approval stages.. Valid values are `draft|in_progress|completed|validated|approved|superseded`',
    `surveyor_company` STRING COMMENT 'Name of the surveying company or contractor that performed the capacity survey.',
    `surveyor_name` STRING COMMENT 'Name of the licensed surveyor or lead surveyor responsible for conducting and certifying the capacity survey.',
    `surveyor_registration_number` STRING COMMENT 'Professional registration or license number of the surveyor who conducted the capacity survey, as required by regulatory authorities.',
    `total_storage_capacity_m3` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity of the TSF in cubic meters as determined by the survey, measured from the base to the current crest elevation.',
    `validation_date` DATE COMMENT 'Date on which the survey results were validated and approved by the responsible engineer.',
    `variance_from_design_m3` DECIMAL(18,2) COMMENT 'Difference in cubic meters between the surveyed total storage capacity and the design capacity. Positive values indicate capacity exceeding design; negative values indicate capacity below design.',
    `vertical_accuracy_m` DECIMAL(18,2) COMMENT 'Vertical positional accuracy of the survey measurements in meters, representing the precision of elevation (Z) data. Critical for volume calculations.',
    CONSTRAINT pk_tsf_capacity_survey PRIMARY KEY(`tsf_capacity_survey_id`)
) COMMENT 'Records periodic volumetric surveys of TSF storage capacity, including survey date, survey method (drone photogrammetry, LiDAR, GPS), total storage capacity, remaining airspace, current storage volume, beach elevation, pond surface area, and freeboard. Tracks TSF filling rate against design capacity and informs raise scheduling and operational planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`stability_analysis` (
    `stability_analysis_id` BIGINT COMMENT 'Unique identifier for the geotechnical stability analysis record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Stability analysis costs (EOR fees, software licenses, independent review) are charged to the facility cost centre for dam safety compliance cost tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Stability analyses require tracking engineer of record for professional liability and regulatory compliance. Engineer name/registration are denormalized. Essential for geotechnical governance and dam ',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: Stability analysis is a key technical input to feasibility studies for TSF and WRD design. Factor of safety, failure modes, and design parameters from stability studies directly inform feasibility stu',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility or waste rock dump that is the subject of this stability analysis.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Geotechnical stability analyses are performed on waste rock dumps as well as TSF embankments. Waste rock dumps require slope stability assessment for batter angles and lift heights. Currently stabilit',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Major stability studies (DSRs, consequence classifications) are tracked as WBS elements when they trigger capital works. Required for capex project justification and regulatory approval cost tracking.',
    `analysis_date` DATE COMMENT 'Date on which the stability analysis was completed or the report was finalized.',
    `analysis_notes` STRING COMMENT 'Free-text field for additional comments, assumptions, limitations, or observations related to the stability analysis that are not captured in other structured fields.',
    `analysis_reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this stability analysis report by the engineering firm or internal team.',
    `analysis_software` STRING COMMENT 'Name and version of the geotechnical software used to perform the stability analysis (e.g., SLOPE/W, PLAXIS, GeoStudio, FLAC).',
    `analysis_status` STRING COMMENT 'Current lifecycle status of the stability analysis: draft (in preparation), under review (submitted for peer review), approved (accepted by engineer of record), superseded (replaced by newer analysis), or archived (historical record).. Valid values are `draft|under review|approved|superseded|archived`',
    `analysis_type` STRING COMMENT 'Type of geotechnical stability analysis performed: static (steady-state), pseudo-static (simplified seismic), dynamic (time-history seismic), limit equilibrium, finite element method, or probabilistic risk assessment.. Valid values are `static|pseudo-static|dynamic|limit equilibrium|finite element|probabilistic`',
    `approval_date` DATE COMMENT 'Date on which the stability analysis was formally approved by the engineer of record and/or the accountable executive.',
    `cohesion_kpa` DECIMAL(18,2) COMMENT 'Effective cohesion parameter (c) of the critical soil or tailings material used in the stability analysis, measured in kilopascals.',
    `consequence_classification` STRING COMMENT 'Consequence category of the TSF as per ANCOLD or ICMM GISTM classification (low, significant, high, very high, extreme), reflecting the potential impact of failure on life, environment, and infrastructure.. Valid values are `low|significant|high|very high|extreme`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability analysis record was first created in the system.',
    `critical_slip_surface_description` STRING COMMENT 'Textual description or coordinates of the critical slip surface or failure plane identified in the analysis, including depth, geometry, and location relative to the embankment.',
    `factor_of_safety` DECIMAL(18,2) COMMENT 'Calculated factor of safety for the critical failure surface or mechanism. Represents the ratio of resisting forces to driving forces; values above 1.0 indicate stability.',
    `failure_mode` STRING COMMENT 'Description of the failure mechanism or mode assessed in this analysis (e.g., circular slip, wedge failure, foundation failure, liquefaction, piping, overtopping).',
    `fos_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the calculated factor of safety meets or exceeds the minimum required FoS. True indicates compliance; False indicates non-compliance requiring remedial action.',
    `friction_angle_degrees` DECIMAL(18,2) COMMENT 'Effective internal friction angle (φ) of the critical soil or tailings material used in the stability analysis, measured in degrees.',
    `independent_reviewer` STRING COMMENT 'Name of the independent qualified professional engineer or firm who conducted the independent technical review of the stability analysis, as required by ICMM GISTM.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stability analysis record was last updated or modified in the system.',
    `loading_condition` STRING COMMENT 'Operational or environmental loading scenario under which the stability analysis was performed (e.g., end of construction, long-term steady state, rapid drawdown, seismic event, post-seismic, extreme precipitation).. Valid values are `end of construction|long-term steady state|rapid drawdown|seismic|post-seismic|extreme precipitation`',
    `minimum_required_fos` DECIMAL(18,2) COMMENT 'Minimum acceptable factor of safety as specified by design standards (e.g., ANCOLD, ICMM GISTM) for the given loading condition and consequence classification.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic stability analysis review, as required by ICMM GISTM and regulatory permits (typically annual or biennial for high-consequence facilities).',
    `peak_ground_acceleration_g` DECIMAL(18,2) COMMENT 'Peak ground acceleration (PGA) used in seismic stability analysis, expressed as a fraction of gravitational acceleration (g).',
    `phreatic_surface_assumption` STRING COMMENT 'Description of the assumed groundwater or phreatic surface condition used in the analysis (e.g., measured piezometric levels, design phreatic surface, saturated to crest, drained condition).',
    `regulatory_authority` STRING COMMENT 'Name of the government regulatory body or authority to which the stability analysis was submitted (e.g., Department of Resources, Environmental Protection Agency, Mine Safety and Health Administration).',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Boolean indicator of whether this stability analysis was submitted to a regulatory authority as part of a permit application, annual review, or compliance reporting. True indicates submission; False indicates internal use only.',
    `report_document_reference` STRING COMMENT 'Document management system reference or file path to the full stability analysis report, including all appendices, calculations, and supporting data.',
    `return_period_years` STRING COMMENT 'Design return period in years for the loading condition assessed (e.g., 1000-year seismic event, 10000-year flood event), used to determine the design criteria.',
    `review_date` DATE COMMENT 'Date on which the independent technical review of the stability analysis was completed.',
    `seismic_coefficient` DECIMAL(18,2) COMMENT 'Horizontal seismic coefficient (kh) applied in pseudo-static or dynamic stability analysis, representing the fraction of gravity used to simulate earthquake loading.',
    `unit_weight_kn_m3` DECIMAL(18,2) COMMENT 'Bulk or saturated unit weight of the critical soil or tailings material used in the stability analysis, measured in kilonewtons per cubic meter.',
    CONSTRAINT pk_stability_analysis PRIMARY KEY(`stability_analysis_id`)
) COMMENT 'Records geotechnical stability analyses performed on TSF embankments and waste rock dumps, including analysis type (static, pseudo-static, dynamic), software used, failure mode assessed, factor of safety (FoS) calculated, phreatic surface assumptions, material strength parameters, and engineer of record. Tracks compliance with minimum FoS requirements per ANCOLD and ICMM GISTM design standards.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`consequence_classification` (
    `consequence_classification_id` BIGINT COMMENT 'Unique identifier for the consequence classification assessment record.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Consequence classifications identify population at risk and downstream communities requiring engagement for emergency preparedness, inundation mapping, and evacuation planning. Stakeholder register tr',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Consequence classifications require tracking qualified assessor for regulatory compliance and professional accountability. Assessor name/credentials/organization are denormalized. Critical for dam saf',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Classification assessment costs (independent review, inundation studies) are charged to the facility cost centre for regulatory compliance cost tracking.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Consequence classification (Very High, High, Significant, Low) drives emergency response plan requirements per dam safety standards. Higher classifications mandate more detailed ERPs, shorter notifica',
    `social_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to community.social_impact_assessment. Business justification: Consequence classification assessments (population at risk, loss of life potential, cultural heritage impact) inform social impact assessment scope for dam safety projects and raise approvals. SIA use',
    `stage_gate_id` BIGINT COMMENT 'Foreign key linking to project.stage_gate. Business justification: Consequence classification determines design standards, regulatory approval requirements, and risk ratings that are mandatory inputs to stage gate decisions. High consequence facilities require additi',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility or waste rock facility being assessed.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Consequence classification assessments apply to waste rock facilities as well as TSFs, particularly for high-risk dumps. The product has facility_type attribute indicating it covers multiple facility ',
    `assessment_date` DATE COMMENT 'Date when the consequence classification assessment was performed.',
    `assessment_methodology` STRING COMMENT 'Description of the methodology and standards used to conduct the consequence classification assessment.',
    `assessment_version` STRING COMMENT 'Version identifier for the consequence classification assessment, used to track revisions and updates over the facility lifecycle.',
    `classification_category` STRING COMMENT 'The assigned consequence classification category based on potential downstream impact in the event of failure. Drives dam safety review frequency and design standards per ANCOLD and ICMM GISTM.. Valid values are `Extreme|Very High|High|Significant|Low`',
    `classification_notes` STRING COMMENT 'Additional notes, assumptions, limitations, and key considerations documented during the consequence classification assessment process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consequence classification record was first created in the system.',
    `cultural_heritage_impact` STRING COMMENT 'Assessment of potential impact to cultural heritage sites, indigenous sacred sites, and archaeological resources in the downstream zone.. Valid values are `None|Low|Moderate|High|Very High`',
    `dam_safety_review_frequency_months` STRING COMMENT 'Required frequency in months for comprehensive dam safety reviews based on the assigned consequence classification category.',
    `design_standard_reference` STRING COMMENT 'Reference to the applicable design standard and criteria required for the assigned consequence classification category.',
    `downstream_infrastructure_impact` STRING COMMENT 'Description of critical infrastructure at risk downstream including roads, railways, utilities, industrial facilities, and residential areas.',
    `economic_impact_rating` STRING COMMENT 'Assessment of potential economic consequences including property damage, business interruption, agricultural losses, and infrastructure replacement costs.. Valid values are `Minimal|Minor|Moderate|Major|Severe`',
    `environmental_impact_rating` STRING COMMENT 'Assessment of potential environmental consequences including water quality, aquatic ecosystems, terrestrial habitat, and protected areas.. Valid values are `Minimal|Minor|Moderate|Major|Severe`',
    `facility_type` STRING COMMENT 'Type of facility being classified for consequence assessment.. Valid values are `TSF|Waste Rock Dump|Water Retention Dam|Sediment Pond|Combined Facility|Other`',
    `failure_mode_scenario` STRING COMMENT 'Description of the credible failure mode scenario used for consequence assessment, including breach mechanism, release volume, and inundation extent.',
    `independent_review_date` DATE COMMENT 'Date when the independent review of the consequence classification was completed.',
    `independent_review_outcome` STRING COMMENT 'Outcome of the independent review process indicating whether the consequence classification was endorsed by the reviewer.. Valid values are `Endorsed|Endorsed with Conditions|Not Endorsed|Pending`',
    `independent_review_required_flag` BOOLEAN COMMENT 'Indicates whether independent third-party review of the consequence classification is required based on the assigned category.',
    `independent_reviewer_name` STRING COMMENT 'Name of the independent reviewer who validated the consequence classification assessment, if applicable.',
    `inundation_area_km2` DECIMAL(18,2) COMMENT 'Estimated area of downstream inundation in square kilometers based on dam break analysis for the credible failure scenario.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consequence classification record was last updated in the system.',
    `loss_of_life_potential` STRING COMMENT 'Qualitative assessment of potential loss of life in the event of facility failure, based on population at risk and warning time availability.. Valid values are `None|Low|Significant|High|Very High`',
    `next_reassessment_due_date` DATE COMMENT 'Scheduled date for the next consequence classification reassessment, typically triggered by material changes to the facility or downstream conditions.',
    `peak_discharge_m3_per_sec` DECIMAL(18,2) COMMENT 'Estimated peak discharge rate in cubic meters per second at the breach point for the credible failure scenario.',
    `population_at_risk` STRING COMMENT 'Estimated number of people potentially affected in the downstream impact zone in the event of facility failure. Critical factor in determining consequence category.',
    `regulatory_acceptance_date` DATE COMMENT 'Date when the regulatory authority formally accepted the consequence classification assessment.',
    `regulatory_acceptance_status` STRING COMMENT 'Current status of regulatory acceptance for the consequence classification assessment. Drives compliance with dam safety regulations.. Valid values are `Accepted|Conditionally Accepted|Rejected|Under Review|Not Submitted`',
    `regulatory_authority` STRING COMMENT 'Name of the government regulatory authority responsible for reviewing and accepting the consequence classification.',
    `regulatory_reference_number` STRING COMMENT 'Official reference number assigned by the regulatory authority for the consequence classification submission and approval.',
    `regulatory_submission_date` DATE COMMENT 'Date when the consequence classification assessment was submitted to the regulatory authority for review.',
    `supporting_document_reference` STRING COMMENT 'Reference to the detailed consequence classification report and supporting technical documentation including dam break studies and inundation mapping.',
    `warning_time_hours` DECIMAL(18,2) COMMENT 'Estimated time available for downstream warning and evacuation from detection of failure precursors to breach occurrence.',
    CONSTRAINT pk_consequence_classification PRIMARY KEY(`consequence_classification_id`)
) COMMENT 'Records the consequence classification assessments for TSFs and waste rock facilities, capturing classification category (Extreme, Very High, High, Significant, Low), population at risk, downstream infrastructure, failure mode scenario, assessment date, assessor credentials, and regulatory acceptance status. Drives dam safety review frequency and design standards per ANCOLD and ICMM GISTM.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`emergency_action_plan` (
    `emergency_action_plan_id` BIGINT COMMENT 'Unique identifier for the Emergency Action Plan record. Primary key for the emergency action plan entity.',
    `commitment_id` BIGINT COMMENT 'Foreign key linking to community.community_commitment. Business justification: EAP development, community engagement, and drill exercise frequency are often tracked as regulatory and community commitments. Mining operations link EAP milestones to commitment registers for evidenc',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: EAP maintenance costs (updates, drills, community engagement) are charged to the facility cost centre for emergency preparedness cost tracking and regulatory compliance reporting.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Tailings Emergency Action Plans (dam-specific) integrate with site-level Emergency Response Plans for coordination, notification chains, and resource allocation. EAP focuses on dam failure scenario; E',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Emergency action plans require designated community emergency contacts for notification procedures and evacuation coordination. Stakeholder register tracks emergency contact details, notification prot',
    `tsf_id` BIGINT COMMENT 'Reference to the Tailings Storage Facility for which this Emergency Action Plan is prepared. Links to the TSF master record.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Emergency Action Plans may be required for high-consequence waste rock dumps under dam safety regulations. Currently emergency_action_plan only has tsf_id. Adding waste_rock_dump_id enables tracking E',
    `approval_date` DATE COMMENT 'Date on which the Emergency Action Plan was formally approved by the accountable executive or regulatory authority.',
    `approved_by` STRING COMMENT 'Name and title of the accountable executive or authority who approved the Emergency Action Plan.',
    `community_engagement_status` STRING COMMENT 'Status of engagement activities with downstream communities to inform them of the Emergency Action Plan and their role in emergency response.. Valid values are `not_started|in_progress|completed|ongoing`',
    `consequence_classification` STRING COMMENT 'Consequence classification of the associated TSF as per ANCOLD or equivalent standard, determining the level of emergency preparedness required. EAPs are mandatory for high and extreme consequence facilities.. Valid values are `low|significant|high|very_high|extreme`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Emergency Action Plan record was first created in the system.',
    `drill_exercise_frequency` STRING COMMENT 'Required frequency for conducting emergency response drills and exercises to test the effectiveness of the Emergency Action Plan (e.g., annually, bi-annually).',
    `effective_date` DATE COMMENT 'Date from which this version of the Emergency Action Plan becomes operationally effective and supersedes any prior version.',
    `emergency_notification_procedure` STRING COMMENT 'Description of the procedure for notifying internal personnel, emergency services, regulatory authorities, and downstream communities in the event of a TSF emergency.',
    `evacuation_procedure` STRING COMMENT 'Detailed description of evacuation procedures for on-site personnel and downstream communities, including evacuation routes, assembly points, and transportation arrangements.',
    `evacuation_trigger_criteria` STRING COMMENT 'Specific observable conditions or monitoring thresholds that trigger the activation of evacuation procedures, such as critical deformation rates, seepage increases, or seismic events.',
    `independent_review_date` DATE COMMENT 'Date on which the independent technical review of the Emergency Action Plan was completed.',
    `independent_reviewer` STRING COMMENT 'Name of the independent qualified person or firm who reviewed the Emergency Action Plan as part of the independent technical review process.',
    `inundation_study_date` DATE COMMENT 'Date when the downstream inundation zone mapping study was completed or last updated.',
    `inundation_zone_mapping_reference` STRING COMMENT 'Reference identifier or document number for the downstream inundation zone mapping study that defines the area at risk in the event of a TSF failure. Critical for evacuation planning.',
    `last_drill_exercise_date` DATE COMMENT 'Date of the most recent emergency response drill or exercise conducted to test the Emergency Action Plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this Emergency Action Plan record was last modified or updated in the system.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the Emergency Action Plan, tracking compliance with periodic review requirements.',
    `next_drill_exercise_date` DATE COMMENT 'Scheduled date for the next emergency response drill or exercise.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review and update of the Emergency Action Plan. GISTM requires annual review for high and extreme consequence TSFs.',
    `plan_document_reference` STRING COMMENT 'Reference identifier or file path to the full Emergency Action Plan document stored in the document management system.',
    `plan_notes` STRING COMMENT 'Additional notes, comments, or observations related to the Emergency Action Plan, including lessons learned from drills or actual incidents.',
    `plan_reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this Emergency Action Plan for regulatory and internal tracking purposes.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the Emergency Action Plan indicating its approval and operational state.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `plan_version` STRING COMMENT 'Version identifier of the Emergency Action Plan document, tracking revisions and updates over time.',
    `population_at_risk` STRING COMMENT 'Estimated number of people residing or working within the downstream inundation zone who would be at risk in the event of a TSF failure.',
    `primary_emergency_contact_phone` STRING COMMENT '24/7 contact phone number for the primary emergency contact person.',
    `regulatory_acceptance_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory authority upon acceptance of the Emergency Action Plan.',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body responsible for reviewing and accepting the Emergency Action Plan.',
    `regulatory_submission_date` DATE COMMENT 'Date on which the Emergency Action Plan was submitted to the regulatory authority for review.',
    `regulatory_submission_status` STRING COMMENT 'Status of the Emergency Action Plan submission to the relevant regulatory authority for review and acceptance.. Valid values are `not_submitted|submitted|under_review|accepted|rejected`',
    `responsible_engineer` STRING COMMENT 'Full name of the qualified engineer responsible for the preparation and maintenance of the Emergency Action Plan.',
    `responsible_engineer_registration` STRING COMMENT 'Professional registration or license number of the responsible engineer, demonstrating their qualification to prepare emergency action plans.',
    `secondary_emergency_contact_name` STRING COMMENT 'Name of the secondary or backup emergency contact person in case the primary contact is unavailable.',
    `secondary_emergency_contact_phone` STRING COMMENT '24/7 contact phone number for the secondary emergency contact person.',
    CONSTRAINT pk_emergency_action_plan PRIMARY KEY(`emergency_action_plan_id`)
) COMMENT 'Master records for Emergency Action Plans (EAPs) associated with TSFs, capturing plan version, approval date, responsible engineer, downstream inundation zone mapping, emergency notification contacts, evacuation procedures, regulatory submission status, and next review date. Mandatory for high and extreme consequence TSFs under ANCOLD and ICMM GISTM requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`material_characterisation` (
    `material_characterisation_id` BIGINT COMMENT 'Primary key for material_characterisation',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Characterisation testing costs (geotechnical, geochemical, metallurgical) are charged to the facility cost centre for design validation cost tracking and closure cost estimation.',
    `exploration_sample_id` BIGINT COMMENT 'Unique laboratory or field sample identifier assigned to the material specimen for traceability through the Laboratory Information Management System (LIMS).',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: Tailings and waste rock characterization (geotechnical properties, ARD risk, metal leaching) is fundamental input to feasibility studies. Characterization results drive TSF/WRD design, liner requireme',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Tailings and waste rock material characterisation requires linking to source geological units for predictive geochemical modeling. Different geological units produce distinct ARD risks and metal leach',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Geochemical characterisation results showing high metal concentrations, ARD risk, or contamination potential trigger community grievances about environmental and health impacts. Operations link charac',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Material characterisation samples from TSFs and waste rock dumps must be traced to source orebody for geochemical risk modeling, ARD prediction, and closure liability estimation. Essential for environ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Tailings characterization samples reference source processing plant for ore type correlation and geochemical risk assessment. Links material_type and ard_classification to plant processing_method and ',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Material characterization tests (ARD, geochemical, geotechnical) are performed on materials from specific prospects to inform TSF/WRD design and management strategies. Essential for pre-feasibility st',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility from which the material sample was collected.',
    `waste_rock_dump_id` BIGINT COMMENT 'Reference to the waste rock dump from which the material sample was collected, if applicable.',
    `acid_neutralisation_capacity_kg_h2so4_per_tonne` DECIMAL(18,2) COMMENT 'Capacity of the material to neutralise acid, expressed as kilograms of sulphuric acid equivalent per tonne, measured through ANC testing.',
    `ard_classification` STRING COMMENT 'Classification of the materials acid rock drainage risk: PAF (Potentially Acid Forming), NAF (Non-Acid Forming), or UC (Uncertain), based on geochemical test results and NPR ratio.. Valid values are `PAF|NAF|UC`',
    `arsenic_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total arsenic content in the material, measured in milligrams per kilogram, critical heavy metal for environmental risk assessment.',
    `cadmium_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total cadmium content in the material, measured in milligrams per kilogram, critical heavy metal for environmental risk assessment.',
    `characterisation_notes` STRING COMMENT 'Free-text field for additional observations, anomalies, limitations, or contextual information related to the characterisation testing and results.',
    `characterisation_status` STRING COMMENT 'Current status of the characterisation record in the data lifecycle: draft (preliminary results), validated (quality-checked), approved (accepted for design use), or superseded (replaced by newer testing).. Valid values are `draft|validated|approved|superseded`',
    `compression_index` DECIMAL(18,2) COMMENT 'Slope of the virgin compression curve in a consolidation test, indicating the compressibility of the material under loading.',
    `consolidation_coefficient_m2_per_year` DECIMAL(18,2) COMMENT 'Rate at which the material consolidates under load, expressed in square metres per year, critical for settlement prediction in TSF design.',
    `copper_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total copper content in the material, measured in milligrams per kilogram, relevant for copper mining operations and environmental assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the characterisation record was first created in the system.',
    `cyanide_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Concentration of cyanide compounds in the material, measured in milligrams per kilogram, critical for tailings from gold processing operations using cyanide leaching.',
    `encapsulation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the material requires encapsulation within non-acid-forming material to prevent acid generation and metal leaching.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the characterisation record was last updated or modified.',
    `lead_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total lead content in the material, measured in milligrams per kilogram, critical heavy metal for environmental risk assessment.',
    `liquid_limit_percent` DECIMAL(18,2) COMMENT 'Moisture content at which the material transitions from plastic to liquid state, expressed as a percentage.',
    `management_strategy` STRING COMMENT 'Recommended management approach for the material based on characterisation results, including disposal method, encapsulation requirements, co-disposal restrictions, or special handling procedures.',
    `material_source` STRING COMMENT 'Description of the ore body, processing plant, or mining area from which the material originated.',
    `material_type` STRING COMMENT 'Classification of the material sampled: tailings (processed ore residue), waste rock (unprocessed gangue), overburden (surface material), or mixed.. Valid values are `tailings|waste_rock|overburden|mixed`',
    `maximum_potential_acidity_kg_h2so4_per_tonne` DECIMAL(18,2) COMMENT 'Maximum potential acidity that could be generated if all sulphide minerals in the material were to oxidise, expressed as kilograms of sulphuric acid equivalent per tonne.',
    `mercury_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total mercury content in the material, measured in milligrams per kilogram, critical heavy metal for environmental risk assessment.',
    `metal_leaching_risk_rating` STRING COMMENT 'Risk rating for metal leaching potential from the material: low, moderate, high, or very high, based on leachate test results and regulatory thresholds.. Valid values are `low|moderate|high|very_high`',
    `nag_ph` DECIMAL(18,2) COMMENT 'Final pH value from the Net Acid Generation test, indicating the acid-generating potential of the material after oxidation.',
    `net_acid_generation_kg_h2so4_per_tonne` DECIMAL(18,2) COMMENT 'Net acid generation potential of the material, expressed as kilograms of sulphuric acid equivalent per tonne of material, calculated from NAG test results.',
    `net_acid_producing_potential_kg_h2so4_per_tonne` DECIMAL(18,2) COMMENT 'Net acid producing potential calculated as the difference between Maximum Potential Acidity (MPA) and Acid Neutralisation Capacity (ANC), expressed as kilograms of sulphuric acid equivalent per tonne.',
    `neutralisation_potential_ratio` DECIMAL(18,2) COMMENT 'Ratio of Acid Neutralisation Capacity (ANC) to Maximum Potential Acidity (MPA), used to classify ARD risk: NPR less than 1 indicates Potentially Acid Forming (PAF), NPR greater than 3 indicates Non-Acid Forming (NAF), and NPR between 1 and 3 indicates Uncertain (UC).',
    `nickel_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total nickel content in the material, measured in milligrams per kilogram, relevant for nickel mining operations and environmental assessment.',
    `particle_size_d10_mm` DECIMAL(18,2) COMMENT 'Particle size distribution metric representing the diameter at which 10% of the sample mass is finer, measured in millimetres.',
    `particle_size_d50_mm` DECIMAL(18,2) COMMENT 'Median particle size (D50) representing the diameter at which 50% of the sample mass is finer, measured in millimetres.',
    `particle_size_d90_mm` DECIMAL(18,2) COMMENT 'Particle size distribution metric representing the diameter at which 90% of the sample mass is finer, measured in millimetres.',
    `paste_ph` DECIMAL(18,2) COMMENT 'pH measurement of a paste formed by mixing the material with distilled water, indicating current acidity or alkalinity of the material.',
    `permeability_m_per_s` DECIMAL(18,2) COMMENT 'Hydraulic conductivity of the material, representing the rate at which water can flow through the material under a hydraulic gradient, measured in metres per second.',
    `plastic_limit_percent` DECIMAL(18,2) COMMENT 'Moisture content at which the material transitions from semi-solid to plastic state, expressed as a percentage.',
    `plasticity_index` DECIMAL(18,2) COMMENT 'Difference between the liquid limit and plastic limit of the material, indicating the range of moisture content over which the material exhibits plastic behaviour.',
    `sample_collection_date` DATE COMMENT 'Date when the material sample was collected from the facility or dump.',
    `sample_location_description` STRING COMMENT 'Textual description of the specific location within the facility or dump where the sample was collected, including depth, zone, or lift reference.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the density of the material to the density of water, dimensionless value used in geotechnical design and volume calculations.',
    `sulphide_content_percent` DECIMAL(18,2) COMMENT 'Total sulphide mineral content in the material, expressed as a percentage by weight, key indicator for Acid Rock Drainage (ARD) potential.',
    `sulphur_content_percent` DECIMAL(18,2) COMMENT 'Total sulphur content in the material, expressed as a percentage by weight, used in conjunction with sulphide content for ARD assessment.',
    `test_date` DATE COMMENT 'Date when the laboratory characterisation test was completed.',
    `test_method` STRING COMMENT 'Specific laboratory test method or standard applied for characterisation, such as NAG (Net Acid Generation), ANC (Acid Neutralisation Capacity), paste pH, SPLP (Synthetic Precipitation Leaching Procedure), kinetic column test, or physical property test standard.',
    `test_type` STRING COMMENT 'Category of characterisation testing performed: physical properties, geochemical analysis, Acid Rock Drainage (ARD) and Metal Leaching (ML) assessment, or combined testing.. Valid values are `physical|geochemical|ard_ml|combined`',
    `testing_laboratory` STRING COMMENT 'Name of the accredited laboratory that performed the characterisation testing.',
    `validated_by` STRING COMMENT 'Name or identifier of the geochemist, geotechnical engineer, or competent person who validated the characterisation results.',
    `validation_date` DATE COMMENT 'Date when the characterisation results were validated and approved for use in design and planning.',
    `waste_classification` STRING COMMENT 'Regulatory waste classification assigned to the material based on characterisation results and jurisdictional waste classification frameworks.',
    `zinc_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Total zinc content in the material, measured in milligrams per kilogram, relevant for environmental risk assessment.',
    CONSTRAINT pk_material_characterisation PRIMARY KEY(`material_characterisation_id`)
) COMMENT 'Records physical and geochemical characterisation of tailings and waste rock materials, including particle size distribution (PSD), specific gravity, plasticity index, permeability, consolidation parameters, sulphide content, cyanide concentration, and heavy metal content. Incorporates full Acid Rock Drainage (ARD) and Metal Leaching (ML) assessment: sample identity, test type (NAG, ANC, paste pH, SPLP leach, kinetic column), net acid generation potential, acid neutralisation capacity, NPR ratio, ARD risk classification (PAF/NAF/UC), and recommended management strategy. SSOT for all material property and geochemical risk data informing TSF design, waste classification, encapsulation requirements, and closure planning. Supports GISTM Requirement 6 (knowledge of the tailings) and Requirement 8 (design).';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`decant_operation` (
    `decant_operation_id` BIGINT COMMENT 'Unique identifier for the decant operation record. Primary key for the decant operation entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Decant operation costs (pumping, water quality monitoring, operator time) are charged to the TSF cost centre for water management cost tracking and AISC reporting.',
    `decant_structure_id` BIGINT COMMENT 'Unique identifier or tag of the specific decant structure or equipment used (e.g., pump ID, tower ID, penstock reference).',
    `destination_facility_id` BIGINT COMMENT 'Identifier of the specific facility or location where the decanted water was sent (e.g., process plant ID, evaporation pond ID, treatment plant ID).',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Decant operations (water discharge from TSF) must comply with environmental permits specifying discharge limits, monitoring requirements, and receiving environment conditions. Links operational activi',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Decant water quality exceedances (pH, TDS, TSS, turbidity) and licence non-compliance trigger community grievances about water management and downstream impacts. Operations link decant events to griev',
    `incident_id` BIGINT COMMENT 'Reference identifier to the incident record if an incident occurred during the decant operation.',
    `laboratory_sample_id` BIGINT COMMENT 'Reference identifier for the laboratory sample taken during the decant operation for detailed water quality analysis.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Decanted water from TSF returns to specific processing plant for reuse. Closed water circuit tracking requirement for water balance, recycled_water_ratio_pct calculation, and water licence compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or operator who performed or supervised the decant operation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Decant operations may use water treatment chemicals (flocculants, pH adjusters) to meet discharge quality standards. Linking to material master enables chemical consumption tracking, inventory plannin',
    `tsf_id` BIGINT COMMENT 'Identifier of the tailings storage facility where the decant operation occurred.',
    `water_balance_id` BIGINT COMMENT 'Foreign key linking to tailings.water_balance. Business justification: Decant operations are water outflow events that contribute to TSF water balance calculations. Each decant operation occurs within a specific water balance period and its volume is accounted for in tha',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the decant operation was formally approved by the authorising person.',
    `compliance_status` STRING COMMENT 'Assessment of whether the decant operation met all applicable water licence conditions and regulatory requirements.. Valid values are `compliant|non_compliant|under_review|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this decant operation record was first created in the data system.',
    `data_source_system` STRING COMMENT 'Name or identifier of the source system from which this decant operation record was captured (e.g., SCADA, manual log, OSIsoft PI System).',
    `decant_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the decant operation was completed.',
    `decant_event_date` DATE COMMENT 'The date on which the decant operation was performed. Principal business event timestamp for this transaction.',
    `decant_event_reference` STRING COMMENT 'Business reference number or code assigned to this decant operation event for tracking and reporting purposes.',
    `decant_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the decant operation commenced, including time of day.',
    `decant_structure_type` STRING COMMENT 'Type of decant structure or mechanism used to extract supernatant water from the TSF (e.g., penstock, decant tower, pump, spillway, siphon).. Valid values are `penstock|decant_tower|pump|spillway|siphon|other`',
    `destination_type` STRING COMMENT 'Classification of the destination where the decanted water was directed (process water return to plant, evaporation pond, treatment plant, discharge to environment, storage dam).. Valid values are `process_water_return|evaporation_pond|treatment_plant|discharge_to_environment|storage_dam|other`',
    `flow_rate_m3_per_hour` DECIMAL(18,2) COMMENT 'Average flow rate of water during the decant operation, measured in cubic meters per hour.',
    `freeboard_after_decant_m` DECIMAL(18,2) COMMENT 'Vertical distance between the water level and the crest of the TSF embankment after the decant operation, measured in meters. Critical safety parameter.',
    `incident_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any incident, anomaly, or safety event occurred during the decant operation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this decant operation record was last updated or modified in the data system.',
    `licence_condition_reference` STRING COMMENT 'Reference to the specific water licence condition or permit requirement that governs this decant operation.',
    `non_compliance_reason` STRING COMMENT 'Detailed explanation of any non-compliance issues identified during or after the decant operation.',
    `operation_notes` STRING COMMENT 'Free-text notes and observations recorded by the operator or supervisor regarding the decant operation, including any anomalies or special conditions.',
    `operation_status` STRING COMMENT 'Current lifecycle status of the decant operation (planned, in progress, completed, suspended, aborted, failed).. Valid values are `planned|in_progress|completed|suspended|aborted|failed`',
    `rainfall_during_operation_mm` DECIMAL(18,2) COMMENT 'Total rainfall recorded during the decant operation period, measured in millimeters. Relevant for water balance calculations.',
    `volume_decanted_m3` DECIMAL(18,2) COMMENT 'Total volume of supernatant water decanted from the TSF during this operation, measured in cubic meters.',
    `water_level_after_m` DECIMAL(18,2) COMMENT 'Elevation of the supernatant water level in the TSF pond after the decant operation was completed, measured in meters above datum.',
    `water_level_before_m` DECIMAL(18,2) COMMENT 'Elevation of the supernatant water level in the TSF pond before the decant operation commenced, measured in meters above datum.',
    `water_quality_ph` DECIMAL(18,2) COMMENT 'pH level of the decanted water measured at the point of decant. Critical water quality parameter.',
    `water_quality_tds_mg_per_l` DECIMAL(18,2) COMMENT 'Total dissolved solids concentration in the decanted water, measured in milligrams per liter.',
    `water_quality_tss_mg_per_l` DECIMAL(18,2) COMMENT 'Total suspended solids concentration in the decanted water, measured in milligrams per liter.',
    `water_quality_turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity of the decanted water measured in Nephelometric Turbidity Units (NTU).',
    `weather_condition` STRING COMMENT 'Description of weather conditions during the decant operation (e.g., clear, rain, storm). Weather can impact decant operations and water quality.',
    CONSTRAINT pk_decant_operation PRIMARY KEY(`decant_operation_id`)
) COMMENT 'Records decant and supernatant water management operations at TSFs, including decant event date, decant structure used (penstock, decant tower, pump), volume decanted, water quality at point of decant, destination (process water return, evaporation pond, treatment plant), and compliance with water licence conditions. Manages the return of process water from TSF to the processing plant.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`decant_structure` (
    `decant_structure_id` BIGINT COMMENT 'Primary key for decant_structure',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility where this decant structure is located.',
    `superseded_decant_structure_id` BIGINT COMMENT 'Self-referencing FK on decant_structure (superseded_decant_structure_id)',
    `asset_condition_rating` STRING COMMENT 'Current physical condition assessment rating of the decant structure.',
    `blockage_risk_level` STRING COMMENT 'Assessment of the risk level for blockage or clogging of the decant structure.',
    `construction_contractor` STRING COMMENT 'Name of the contractor responsible for constructing and installing the decant structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the decant structure record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the decant structure was decommissioned and removed from active service.',
    `design_capacity_m3_per_hour` DECIMAL(18,2) COMMENT 'Maximum designed flow rate capacity of the decant structure measured in cubic meters per hour.',
    `design_engineer` STRING COMMENT 'Name of the engineering firm or individual responsible for the design of the decant structure.',
    `design_standard` STRING COMMENT 'Engineering standard or code used in the design of the decant structure.',
    `emergency_response_plan_reference` STRING COMMENT 'Reference identifier to the emergency response plan applicable to this decant structure.',
    `inlet_elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the decant structure inlet measured in meters above sea level.',
    `inspection_frequency_days` STRING COMMENT 'Required interval in days between consecutive inspections of the decant structure.',
    `installation_date` DATE COMMENT 'Date when the decant structure was installed and commissioned for operation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection conducted on the decant structure.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the decant structure location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the decant structure location in decimal degrees.',
    `maintenance_notes` STRING COMMENT 'Free-text notes documenting maintenance activities, observations, and recommendations for the decant structure.',
    `monitoring_system_installed` BOOLEAN COMMENT 'Indicates whether an automated monitoring system is installed on the decant structure.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection of the decant structure.',
    `operational_status` STRING COMMENT 'Current operational state of the decant structure within its lifecycle.',
    `outlet_elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the decant structure outlet measured in meters above sea level.',
    `pipe_diameter_mm` DECIMAL(18,2) COMMENT 'Internal diameter of the decant pipe measured in millimeters.',
    `pipe_material` STRING COMMENT 'Material composition of the decant pipe used in the structure.',
    `regulatory_permit_number` STRING COMMENT 'Official permit or authorization number issued by regulatory authorities for the decant structure operation.',
    `rehabilitation_plan_reference` STRING COMMENT 'Reference identifier to the rehabilitation plan associated with the decant structure closure.',
    `safety_classification` STRING COMMENT 'Risk classification of the decant structure based on consequence of failure assessment.',
    `structure_code` STRING COMMENT 'Unique alphanumeric code assigned to the decant structure for identification and tracking purposes.',
    `structure_name` STRING COMMENT 'Business name or designation of the decant structure for operational reference.',
    `structure_type` STRING COMMENT 'Classification of the decant structure based on its design and operational mechanism.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the decant structure record was last modified in the system.',
    CONSTRAINT pk_decant_structure PRIMARY KEY(`decant_structure_id`)
) COMMENT 'Master reference table for decant_structure. Referenced by decant_structure_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`destination_facility` (
    `destination_facility_id` BIGINT COMMENT 'Primary key for destination_facility',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Destination facilities are where decanted water is sent. In mining operations, one common destination is transfer to another TSF for water reuse. When the destination facility IS a TSF, this FK links ',
    `emergency_response_plan_id` BIGINT COMMENT 'Reference to the approved emergency response plan document specific to this destination facility.',
    `employee_id` BIGINT COMMENT 'Reference to the qualified engineer accountable for the technical oversight and safety of this destination facility.',
    `closure_plan_id` BIGINT COMMENT 'Reference to the approved rehabilitation and closure plan for this destination facility.',
    `site_id` BIGINT COMMENT 'Reference to the parent mining site or operation where this destination facility is located.',
    `parent_destination_facility_id` BIGINT COMMENT 'Self-referencing FK on destination_facility (parent_destination_facility_id)',
    `address_line_1` STRING COMMENT 'Primary street address or location descriptor for the destination facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building, zone, or area designation for the destination facility.',
    `city` STRING COMMENT 'City or municipality where the destination facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the destination facility was officially commissioned and approved for operational use.',
    `consequence_classification` STRING COMMENT 'Risk-based classification of potential consequences from facility failure, used for determining monitoring and governance requirements.',
    `construction_method` STRING COMMENT 'Engineering construction methodology used for the tailings storage facility, critical for risk assessment and regulatory compliance.',
    `contact_email` STRING COMMENT 'Primary email address for operational communications regarding the destination facility.',
    `contact_phone` STRING COMMENT 'Primary contact telephone number for the destination facility operations team.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the destination facility is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this destination facility record was first created in the system.',
    `crest_elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the dam crest above mean sea level, measured in meters, used for monitoring and raise planning.',
    `current_capacity_m3` DECIMAL(18,2) COMMENT 'Current utilized volumetric capacity of the destination facility, measured in cubic meters, reflecting actual tailings or waste stored.',
    `dam_height_m` DECIMAL(18,2) COMMENT 'Maximum vertical height of the tailings dam structure measured from the foundation to the crest, in meters.',
    `destination_facility_description` STRING COMMENT 'Detailed textual description of the destination facility including key characteristics, purpose, and operational context.',
    `design_capacity_m3` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the destination facility as per engineering design specifications, measured in cubic meters.',
    `estimated_closure_liability_usd` DECIMAL(18,2) COMMENT 'Estimated financial liability for closure and rehabilitation of the destination facility, denominated in United States Dollars.',
    `facility_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the destination facility for operational reference and reporting.',
    `facility_name` STRING COMMENT 'Official name of the destination facility as recognized in operational and regulatory documentation.',
    `facility_type` STRING COMMENT 'Classification of the destination facility based on its primary operational purpose within the tailings management system.',
    `geotechnical_monitoring_frequency` STRING COMMENT 'Required frequency of geotechnical monitoring activities including piezometer readings, settlement surveys, and stability assessments.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal safety and compliance inspection conducted on the destination facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the destination facility centroid in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the destination facility centroid in decimal degrees.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection of the destination facility per regulatory and internal requirements.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the destination facility indicating its operational readiness and regulatory standing.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the current regulatory permit, requiring renewal or facility closure.',
    `permit_number` STRING COMMENT 'Regulatory permit or license number authorizing the operation of this destination facility.',
    `planned_closure_date` DATE COMMENT 'Anticipated date for facility closure and commencement of rehabilitation activities as per mine closure plan.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the destination facility location.',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body with jurisdiction over this destination facility.',
    `remaining_capacity_m3` DECIMAL(18,2) COMMENT 'Available volumetric capacity remaining in the destination facility before reaching design limits, measured in cubic meters.',
    `seepage_monitoring_required` BOOLEAN COMMENT 'Indicates whether continuous seepage monitoring is mandated for this facility based on risk classification and regulatory requirements.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the destination facility is located.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this destination facility record was last modified in the system.',
    CONSTRAINT pk_destination_facility PRIMARY KEY(`destination_facility_id`)
) COMMENT 'Master reference table for destination_facility. Referenced by destination_facility_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`deposition_plan` (
    `deposition_plan_id` BIGINT COMMENT 'Primary key for deposition_plan',
    `schedule_id` BIGINT COMMENT 'Reference to the dam raise schedule associated with this deposition plan, coordinating embankment construction with tailings placement.',
    `superseded_by_plan_id` BIGINT COMMENT 'Reference to the deposition plan that supersedes this plan, establishing plan lineage and succession. Nullable if plan is current.',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility where this deposition plan will be executed.',
    `superseded_deposition_plan_id` BIGINT COMMENT 'Self-referencing FK on deposition_plan (superseded_deposition_plan_id)',
    `approval_authority` STRING COMMENT 'Name of the regulatory body or internal authority that approved the deposition plan.',
    `approval_date` DATE COMMENT 'Date when the deposition plan received formal approval from the designated authority.',
    `approval_reference_number` STRING COMMENT 'Official reference or permit number assigned by the approval authority for tracking and compliance purposes.',
    `closure_rehabilitation_plan_reference` STRING COMMENT 'Reference to the closure and rehabilitation plan document that outlines post-deposition reclamation activities and long-term stewardship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deposition plan record was first created in the system.',
    `deposition_method` STRING COMMENT 'Specific technique used for tailings placement: spigot (point discharge), cyclone (classification discharge), subaerial (above water), subaqueous (below water), beach discharge (distributed along beach), or tower discharge (central tower distribution).',
    `deposition_rate_m3_per_day` DECIMAL(18,2) COMMENT 'Planned average daily rate of tailings deposition in cubic meters per day.',
    `design_engineer_license_number` STRING COMMENT 'Professional engineering license or registration number of the design engineer, required for regulatory compliance.',
    `design_engineer_name` STRING COMMENT 'Name of the professional engineer or engineering firm responsible for designing the deposition plan.',
    `effective_end_date` DATE COMMENT 'Date when the deposition plan is scheduled to end or be superseded. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the deposition plan becomes effective and operational execution begins.',
    `emergency_response_plan_reference` STRING COMMENT 'Reference to the emergency preparedness and response plan document for incidents related to this deposition plan.',
    `environmental_impact_statement_reference` STRING COMMENT 'Reference number or identifier of the Environmental Impact Statement document associated with this deposition plan.',
    `estimated_closure_liability_amount` DECIMAL(18,2) COMMENT 'Estimated financial liability for closure and rehabilitation activities associated with this deposition plan, in the operating currency.',
    `geotechnical_stability_rating` STRING COMMENT 'Assessment of the planned deposition configurations geotechnical stability: very high (excellent stability), high (good stability), moderate (acceptable with monitoring), low (requires mitigation), or very low (significant risk).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the deposition plan record was most recently updated or modified.',
    `monitoring_plan_reference` STRING COMMENT 'Reference to the geotechnical and environmental monitoring plan document that defines surveillance requirements during plan execution.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the deposition plan, used in operational documentation and regulatory submissions.',
    `plan_description` STRING COMMENT 'Detailed narrative description of the deposition plan objectives, methodology, and key operational considerations.',
    `plan_name` STRING COMMENT 'Human-readable name or title of the deposition plan, describing the planned tailings placement strategy.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the deposition plan: draft (under development), approved (authorized for execution), active (currently being executed), suspended (temporarily halted), completed (execution finished), superseded (replaced by newer plan), or cancelled (terminated).',
    `plan_type` STRING COMMENT 'Classification of the deposition method: upstream (raise built on deposited tailings), downstream (raise built downstream), centerline (hybrid method), dry stack (filtered tailings), filtered (dewatered), thickened (high-density slurry), or paste (very high-density slurry).',
    `planned_capacity_m3` DECIMAL(18,2) COMMENT 'Total volume of tailings material planned for deposition under this plan, measured in cubic meters.',
    `planned_capacity_tonnes` DECIMAL(18,2) COMMENT 'Total mass of tailings material planned for deposition under this plan, measured in metric tonnes.',
    `revision_date` DATE COMMENT 'Date when the current revision of the deposition plan was issued or approved.',
    `revision_number` STRING COMMENT 'Version or revision number of the deposition plan, incremented with each formal update or amendment.',
    `risk_classification` STRING COMMENT 'Overall risk classification of the deposition plan based on consequence of failure analysis: extreme (catastrophic potential), very high (major potential), high (serious potential), significant (moderate potential), or low (minor potential).',
    `seepage_control_strategy` STRING COMMENT 'Description of the planned approach for managing and controlling seepage from the tailings facility, including drainage systems, liners, and collection methods.',
    `target_beach_slope_percent` DECIMAL(18,2) COMMENT 'Planned slope angle of the tailings beach expressed as a percentage, critical for stability and drainage management.',
    `target_freeboard_m` DECIMAL(18,2) COMMENT 'Planned vertical distance between the water surface and the crest of the dam, measured in meters, required for flood containment and safety.',
    `water_management_strategy` STRING COMMENT 'Description of the planned approach for managing water balance, including reclaim water, stormwater, and process water within the deposition plan.',
    CONSTRAINT pk_deposition_plan PRIMARY KEY(`deposition_plan_id`)
) COMMENT 'Master reference table for deposition_plan. Referenced by plan_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`capacity_model` (
    `capacity_model_id` BIGINT COMMENT 'Primary key for capacity_model',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility for which this capacity model applies.',
    `superseded_capacity_model_id` BIGINT COMMENT 'Self-referencing FK on capacity_model (superseded_capacity_model_id)',
    `approval_date` DATE COMMENT 'Date when this capacity model received formal approval for operational use.',
    `approved_by` STRING COMMENT 'Name or identifier of the responsible engineer or authority who approved this capacity model for operational use.',
    `compliance_standard` STRING COMMENT 'Reference to the regulatory or industry standard framework that this capacity model complies with, such as ICMM Global Industry Standard on Tailings Management or local Environmental Impact Statement requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity model record was first created in the system.',
    `current_capacity_m3` DECIMAL(18,2) COMMENT 'Remaining volumetric capacity available for tailings deposition at the time of model calculation, measured in cubic meters.',
    `current_capacity_tonnes` DECIMAL(18,2) COMMENT 'Remaining mass capacity available for tailings deposition at the time of model calculation, measured in metric tonnes.',
    `current_elevation_m` DECIMAL(18,2) COMMENT 'Current elevation of the tailings surface above sea level at the time of model calculation, measured in meters.',
    `deposition_rate_m3_per_day` DECIMAL(18,2) COMMENT 'Average daily volumetric rate at which tailings are deposited into the storage facility, measured in cubic meters per day.',
    `deposition_rate_tonnes_per_day` DECIMAL(18,2) COMMENT 'Average daily mass rate at which tailings are deposited into the storage facility, measured in metric tonnes per day.',
    `effective_date` DATE COMMENT 'Date from which this capacity model becomes operationally effective and applicable for planning and reporting.',
    `estimated_life_years` DECIMAL(18,2) COMMENT 'Projected number of years until the tailings storage facility reaches full capacity based on current deposition rates and available capacity.',
    `expiry_date` DATE COMMENT 'Date when this capacity model is no longer valid or has been superseded by a newer version. Nullable for models with indefinite validity.',
    `freeboard_requirement_m` DECIMAL(18,2) COMMENT 'Minimum required vertical distance between the tailings surface and the crest of the dam for safety and operational purposes, measured in meters.',
    `maximum_elevation_m` DECIMAL(18,2) COMMENT 'Maximum elevation above sea level that the tailings storage facility is designed to reach, measured in meters.',
    `model_assumptions` STRING COMMENT 'Key assumptions and constraints underlying the capacity model calculations and projections.',
    `model_code` STRING COMMENT 'Unique business identifier or code assigned to the capacity model for external reference and reporting purposes.',
    `model_confidence_level` STRING COMMENT 'Qualitative assessment of the confidence level in the capacity model predictions based on data quality, methodology robustness, and validation results.',
    `model_description` STRING COMMENT 'Detailed textual description of the capacity model including methodology, assumptions, and key parameters.',
    `model_name` STRING COMMENT 'Human-readable name or designation of the capacity model used for tailings storage facility planning and analysis.',
    `model_type` STRING COMMENT 'Classification of the capacity model methodology used for tailings storage facility capacity estimation and forecasting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity model record was last updated or modified in the system.',
    `next_review_date` DATE COMMENT 'Date when the next scheduled review and validation of the capacity model is due.',
    `raise_method` STRING COMMENT 'Engineering method used for raising the tailings dam embankment to increase storage capacity.',
    `raise_stage_number` STRING COMMENT 'Sequential number identifying the current or planned raise stage of the tailings dam embankment.',
    `review_frequency_months` STRING COMMENT 'Required frequency in months for periodic review and validation of the capacity model to ensure continued accuracy.',
    `settlement_factor` DECIMAL(18,2) COMMENT 'Factor accounting for consolidation and settlement of tailings over time, applied to capacity calculations.',
    `solids_concentration_percentage` DECIMAL(18,2) COMMENT 'Average percentage of solids by weight in the tailings slurry deposited into the storage facility.',
    `solids_density_tonnes_per_m3` DECIMAL(18,2) COMMENT 'Average density of tailings solids used in capacity calculations, measured in metric tonnes per cubic meter.',
    `capacity_model_status` STRING COMMENT 'Current lifecycle status of the capacity model indicating its operational state and approval level.',
    `total_design_capacity_m3` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the tailings storage facility as designed, measured in cubic meters.',
    `total_design_capacity_tonnes` DECIMAL(18,2) COMMENT 'Maximum mass capacity of the tailings storage facility as designed, measured in metric tonnes.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of total design capacity currently utilized by deposited tailings, calculated as (used capacity / total design capacity) × 100.',
    `version_number` STRING COMMENT 'Version identifier for the capacity model to track revisions and updates over time.',
    `void_ratio` DECIMAL(18,2) COMMENT 'Ratio of void volume to solids volume in deposited tailings, used for capacity and settlement calculations.',
    CONSTRAINT pk_capacity_model PRIMARY KEY(`capacity_model_id`)
) COMMENT 'Master reference table for capacity_model. Referenced by capacity_model_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`tailings`.`monitoring_location` (
    `monitoring_location_id` BIGINT COMMENT 'Primary key for monitoring_location',
    `tsf_id` BIGINT COMMENT 'Reference to the tailings storage facility where this monitoring location is installed.',
    `parent_monitoring_location_id` BIGINT COMMENT 'Self-referencing FK on monitoring_location (parent_monitoring_location_id)',
    `access_difficulty` STRING COMMENT 'Classification of the difficulty level for field personnel to physically access the monitoring location for manual readings or maintenance.',
    `alert_threshold_lower` DECIMAL(18,2) COMMENT 'Lower boundary threshold value that triggers an alert condition when readings fall below this level.',
    `alert_threshold_upper` DECIMAL(18,2) COMMENT 'Upper boundary threshold value that triggers an alert condition when readings exceed this level.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration or verification of the monitoring instrument to ensure measurement accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring location record was first created in the system.',
    `critical_threshold_lower` DECIMAL(18,2) COMMENT 'Lower boundary critical threshold value that triggers emergency response protocols when readings fall below this level.',
    `critical_threshold_upper` DECIMAL(18,2) COMMENT 'Upper boundary critical threshold value that triggers emergency response protocols when readings exceed this level.',
    `data_logger_code` STRING COMMENT 'Identifier of the automated data logger or telemetry system connected to this monitoring location for continuous data capture.',
    `decommission_date` DATE COMMENT 'Date when the monitoring location was decommissioned or removed from active service. Null if still active.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the monitoring location above mean sea level in meters.',
    `installation_date` DATE COMMENT 'Date when the monitoring location or instrument was installed and commissioned for operation.',
    `installation_depth_m` DECIMAL(18,2) COMMENT 'Depth below ground surface at which the monitoring instrument is installed, measured in meters. Applicable to subsurface instruments such as piezometers and inclinometers.',
    `instrument_manufacturer` STRING COMMENT 'Name of the manufacturer or supplier of the monitoring instrument installed at this location.',
    `instrument_model` STRING COMMENT 'Model number or designation of the monitoring instrument installed at this location.',
    `instrument_serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to the monitoring instrument for traceability and warranty purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring location in decimal degrees.',
    `location_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the monitoring location for field identification and reporting purposes.',
    `location_name` STRING COMMENT 'Human-readable descriptive name of the monitoring location (e.g., Piezometer PZ-12A, Seepage Weir SW-03).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring location in decimal degrees.',
    `measurement_unit` STRING COMMENT 'Standard unit of measure for readings collected at this monitoring location (e.g., kPa for pore pressure, mm for settlement).',
    `monitoring_purpose` STRING COMMENT 'Primary purpose or objective of the monitoring location within the tailings management framework.',
    `monitoring_type` STRING COMMENT 'Classification of the monitoring instrument or location type used for geotechnical or environmental surveillance.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or verification of the monitoring instrument.',
    `notes` STRING COMMENT 'Free-text field for additional observations, maintenance history, or contextual information about the monitoring location.',
    `reading_frequency` STRING COMMENT 'Scheduled frequency at which readings are collected from this monitoring location as per the monitoring plan.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether readings from this monitoring location must be included in regulatory compliance reports submitted to governing authorities.',
    `responsible_engineer` STRING COMMENT 'Name of the geotechnical engineer or responsible person assigned to oversee this monitoring location.',
    `monitoring_location_status` STRING COMMENT 'Current operational status of the monitoring location in its lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring location record was last modified in the system.',
    `zone_classification` STRING COMMENT 'Geotechnical zone or area within the tailings storage facility where the monitoring location is positioned.',
    CONSTRAINT pk_monitoring_location PRIMARY KEY(`monitoring_location_id`)
) COMMENT 'Master reference table for monitoring_location. Referenced by monitoring_location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_stability_analysis_id` FOREIGN KEY (`stability_analysis_id`) REFERENCES `mining_ecm`.`tailings`.`stability_analysis`(`stability_analysis_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_stability_analysis_id` FOREIGN KEY (`stability_analysis_id`) REFERENCES `mining_ecm`.`tailings`.`stability_analysis`(`stability_analysis_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_monitoring_location_id` FOREIGN KEY (`monitoring_location_id`) REFERENCES `mining_ecm`.`tailings`.`monitoring_location`(`monitoring_location_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_water_balance_id` FOREIGN KEY (`water_balance_id`) REFERENCES `mining_ecm`.`tailings`.`water_balance`(`water_balance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_monitoring_location_id` FOREIGN KEY (`monitoring_location_id`) REFERENCES `mining_ecm`.`tailings`.`monitoring_location`(`monitoring_location_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_capacity_model_id` FOREIGN KEY (`capacity_model_id`) REFERENCES `mining_ecm`.`tailings`.`capacity_model`(`capacity_model_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_deposition_plan_id` FOREIGN KEY (`deposition_plan_id`) REFERENCES `mining_ecm`.`tailings`.`deposition_plan`(`deposition_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_water_balance_id` FOREIGN KEY (`water_balance_id`) REFERENCES `mining_ecm`.`tailings`.`water_balance`(`water_balance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_closure_plan_id` FOREIGN KEY (`closure_plan_id`) REFERENCES `mining_ecm`.`tailings`.`closure_plan`(`closure_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_closure_plan_id` FOREIGN KEY (`closure_plan_id`) REFERENCES `mining_ecm`.`tailings`.`closure_plan`(`closure_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ADD CONSTRAINT `fk_tailings_stability_analysis_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ADD CONSTRAINT `fk_tailings_stability_analysis_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ADD CONSTRAINT `fk_tailings_emergency_action_plan_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ADD CONSTRAINT `fk_tailings_emergency_action_plan_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ADD CONSTRAINT `fk_tailings_material_characterisation_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_decant_structure_id` FOREIGN KEY (`decant_structure_id`) REFERENCES `mining_ecm`.`tailings`.`decant_structure`(`decant_structure_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_destination_facility_id` FOREIGN KEY (`destination_facility_id`) REFERENCES `mining_ecm`.`tailings`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ADD CONSTRAINT `fk_tailings_decant_operation_water_balance_id` FOREIGN KEY (`water_balance_id`) REFERENCES `mining_ecm`.`tailings`.`water_balance`(`water_balance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_structure` ADD CONSTRAINT `fk_tailings_decant_structure_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`decant_structure` ADD CONSTRAINT `fk_tailings_decant_structure_superseded_decant_structure_id` FOREIGN KEY (`superseded_decant_structure_id`) REFERENCES `mining_ecm`.`tailings`.`decant_structure`(`decant_structure_id`);
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ADD CONSTRAINT `fk_tailings_destination_facility_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ADD CONSTRAINT `fk_tailings_destination_facility_closure_plan_id` FOREIGN KEY (`closure_plan_id`) REFERENCES `mining_ecm`.`tailings`.`closure_plan`(`closure_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ADD CONSTRAINT `fk_tailings_destination_facility_parent_destination_facility_id` FOREIGN KEY (`parent_destination_facility_id`) REFERENCES `mining_ecm`.`tailings`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ADD CONSTRAINT `fk_tailings_deposition_plan_superseded_by_plan_id` FOREIGN KEY (`superseded_by_plan_id`) REFERENCES `mining_ecm`.`tailings`.`deposition_plan`(`deposition_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ADD CONSTRAINT `fk_tailings_deposition_plan_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ADD CONSTRAINT `fk_tailings_deposition_plan_superseded_deposition_plan_id` FOREIGN KEY (`superseded_deposition_plan_id`) REFERENCES `mining_ecm`.`tailings`.`deposition_plan`(`deposition_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`capacity_model` ADD CONSTRAINT `fk_tailings_capacity_model_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`capacity_model` ADD CONSTRAINT `fk_tailings_capacity_model_superseded_capacity_model_id` FOREIGN KEY (`superseded_capacity_model_id`) REFERENCES `mining_ecm`.`tailings`.`capacity_model`(`capacity_model_id`);
ALTER TABLE `mining_ecm`.`tailings`.`monitoring_location` ADD CONSTRAINT `fk_tailings_monitoring_location_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`tailings`.`monitoring_location` ADD CONSTRAINT `fk_tailings_monitoring_location_parent_monitoring_location_id` FOREIGN KEY (`parent_monitoring_location_id`) REFERENCES `mining_ecm`.`tailings`.`monitoring_location`(`monitoring_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`tailings` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`tailings` SET TAGS ('dbx_domain' = 'tailings');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Accountable Executive Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Materials Storage Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `catchment_area_km2` SET TAGS ('dbx_business_glossary_term' = 'Catchment Area (Square Kilometers)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `classification_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Assessment Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `classification_assessor` SET TAGS ('dbx_business_glossary_term' = 'Classification Assessor Name');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_value_regex' = 'extreme|very_high|high|significant|low');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `current_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Current Storage Capacity (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `current_height_m` SET TAGS ('dbx_business_glossary_term' = 'Current Dam Height (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `current_raise_level` SET TAGS ('dbx_business_glossary_term' = 'Current Raise Level');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `dam_safety_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Dam Safety Review Frequency (Months)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `dam_type` SET TAGS ('dbx_business_glossary_term' = 'Dam Construction Type');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `dam_type` SET TAGS ('dbx_value_regex' = 'upstream|downstream|centreline|dry_stack|filtered|other');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `design_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Design Storage Capacity (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `design_height_m` SET TAGS ('dbx_business_glossary_term' = 'Design Dam Height (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `downstream_infrastructure_exposure` SET TAGS ('dbx_business_glossary_term' = 'Downstream Infrastructure Exposure');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `eis_reference` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Statement (EIS) Reference');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `emergency_preparedness_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Emergency Preparedness Plan Reference');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `engineer_of_record` SET TAGS ('dbx_business_glossary_term' = 'Engineer of Record (EoR)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `estimated_closure_liability_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Closure Liability (United States Dollars)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `estimated_closure_liability_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Code');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Name');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `failure_mode_scenario` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Scenario');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `itrb_assignment` SET TAGS ('dbx_business_glossary_term' = 'Independent Tailings Review Board (ITRB) Assignment');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `maximum_raise_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Raise Level');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|care_and_maintenance|under_construction');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk (PAR)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Status');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_value_regex' = 'approved|pending|conditional|rejected|under_review');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `regulatory_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Reference');
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ALTER COLUMN `seepage_monitoring_system` SET TAGS ('dbx_business_glossary_term' = 'Seepage Monitoring System Type');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `tsf_raise_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Raise Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `stability_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Stability Analysis Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management Of Change Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Raise Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Raise Cost');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Raise Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `additional_storage_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Additional Storage Capacity (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Authority');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `as_built_crest_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'As-Built Crest Elevation (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `as_built_drawing_reference` SET TAGS ('dbx_business_glossary_term' = 'As-Built Drawing Reference');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Raise Commissioning Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_value_regex' = 'low|significant|high|very_high|extreme');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `construction_contractor` SET TAGS ('dbx_business_glossary_term' = 'Construction Contractor Name');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `design_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Document Reference');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Raise Cost');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `geotechnical_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Sign-Off Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Independent Technical Reviewer Name');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Raise Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Raise Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_height_m` SET TAGS ('dbx_business_glossary_term' = 'Raise Height (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_method` SET TAGS ('dbx_business_glossary_term' = 'Raise Construction Method');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_method` SET TAGS ('dbx_value_regex' = 'upstream|downstream|centreline');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_notes` SET TAGS ('dbx_business_glossary_term' = 'Raise Event Notes');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_number` SET TAGS ('dbx_business_glossary_term' = 'Raise Sequence Number');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_status` SET TAGS ('dbx_business_glossary_term' = 'Raise Lifecycle Status');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `raise_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Raise Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ALTER COLUMN `target_crest_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Target Crest Elevation (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `dam_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Dam Safety Inspection ID');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `stability_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Analysis Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_value_regex' = 'low|significant|high|very_high|extreme');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `engineer_of_record_name` SET TAGS ('dbx_business_glossary_term' = 'Engineer of Record (EoR) Name');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `engineer_of_record_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `eor_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Engineer of Record (EoR) Sign-off Date');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `factor_of_safety` SET TAGS ('dbx_business_glossary_term' = 'Factor of Safety (FoS)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `failure_mode_assessed` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Assessed');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `fos_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Factor of Safety (FoS) Compliance Status');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `fos_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|marginal');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `freeboard_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Freeboard Compliance Status');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `freeboard_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|marginal');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `freeboard_measurement_m` SET TAGS ('dbx_business_glossary_term' = 'Freeboard Measurement (m)');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `inspection_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Reference');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|report_pending|approved|closed');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `instrumentation_compliance` SET TAGS ('dbx_business_glossary_term' = 'Instrumentation Compliance');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `instrumentation_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `instrumentation_status` SET TAGS ('dbx_business_glossary_term' = 'Instrumentation Status');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `material_strength_parameters` SET TAGS ('dbx_business_glossary_term' = 'Material Strength Parameters');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `overall_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Safety Rating');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `overall_safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|fair|marginal|unsatisfactory|urgent');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `phreatic_surface_assumption` SET TAGS ('dbx_business_glossary_term' = 'Phreatic Surface Assumption');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `remedial_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Remedial Action Priority');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `remedial_action_priority` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|urgent');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `remedial_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Remedial Actions Required');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `seepage_observation` SET TAGS ('dbx_business_glossary_term' = 'Seepage Observation');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `seepage_severity` SET TAGS ('dbx_business_glossary_term' = 'Seepage Severity');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `seepage_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|significant|critical');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `slope_condition` SET TAGS ('dbx_business_glossary_term' = 'Slope Condition');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `slope_stability_rating` SET TAGS ('dbx_business_glossary_term' = 'Slope Stability Rating');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `slope_stability_rating` SET TAGS ('dbx_value_regex' = 'stable|minor_concern|moderate_concern|unstable');
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ALTER COLUMN `stability_analysis_conducted` SET TAGS ('dbx_business_glossary_term' = 'Stability Analysis Conducted');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` SET TAGS ('dbx_subdomain' = 'stability_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `alert_threshold_level_1` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Level 1');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `alert_threshold_level_2` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Level 2');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `alert_threshold_level_3` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Level 3');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `data_acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Data Acquisition Method');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `data_acquisition_method` SET TAGS ('dbx_value_regex' = 'automated|manual|remote_telemetry|scada_integrated');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Meters (m)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `facility_zone` SET TAGS ('dbx_business_glossary_term' = 'Facility Zone');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `installation_contractor` SET TAGS ('dbx_business_glossary_term' = 'Installation Contractor Name');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `installation_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Installation Depth in Meters (m)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `installation_notes` SET TAGS ('dbx_business_glossary_term' = 'Installation Notes');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `instrument_subtype` SET TAGS ('dbx_business_glossary_term' = 'Instrument Subtype');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_business_glossary_term' = 'Instrument Tag Number');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `measurement_range_max` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Maximum');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `measurement_range_min` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Minimum');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|failed|under_maintenance|decommissioned|standby');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Purpose');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` SET TAGS ('dbx_subdomain' = 'stability_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `geotechnical_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Reading ID');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `action_threshold` SET TAGS ('dbx_business_glossary_term' = 'Action Threshold');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `alert_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|missing|calibration_required|out_of_range');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'scada|manual_entry|telemetry|lims|third_party');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `deviation_from_baseline` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Baseline');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Flag');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'piezometer|inclinometer|settlement_plate|survey_prism|extensometer|tiltmeter');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `rate_of_change` SET TAGS ('dbx_business_glossary_term' = 'Rate of Change');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `rate_of_change_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate of Change Unit');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `rate_of_change_unit` SET TAGS ('dbx_value_regex' = 'mm_per_day|mm_per_month|kPa_per_day|degrees_per_month');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `reading_method` SET TAGS ('dbx_business_glossary_term' = 'Reading Method');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `reading_method` SET TAGS ('dbx_value_regex' = 'manual|automated|scada|remote');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `reading_notes` SET TAGS ('dbx_business_glossary_term' = 'Reading Notes');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `reading_value` SET TAGS ('dbx_business_glossary_term' = 'Reading Value');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `threshold_breach_status` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Status');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `threshold_breach_status` SET TAGS ('dbx_value_regex' = 'normal|alert_breached|action_breached|not_applicable');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mm|m|kPa|MPa|degrees|percent');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|requires_review');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|heavy_rain|snow|fog|storm');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` SET TAGS ('dbx_subdomain' = 'stability_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `seepage_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Seepage Monitoring ID');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Technician ID');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `monitoring_location_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Water Balance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `alert_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered Flag');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `arsenic_concentration` SET TAGS ('dbx_business_glossary_term' = 'Arsenic Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `conductivity_unit` SET TAGS ('dbx_business_glossary_term' = 'Conductivity Unit of Measure');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `conductivity_unit` SET TAGS ('dbx_value_regex' = 'µS/cm|mS/cm|dS/m');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `copper_concentration` SET TAGS ('dbx_business_glossary_term' = 'Copper Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `design_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Design Exceedance Flag');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `design_seepage_rate` SET TAGS ('dbx_business_glossary_term' = 'Design Seepage Rate');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `electrical_conductivity` SET TAGS ('dbx_business_glossary_term' = 'Electrical Conductivity');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `environmental_licence_limit` SET TAGS ('dbx_business_glossary_term' = 'Environmental Licence Limit');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Unit of Measure');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_value_regex' = 'L/s|m3/day|gpm|m3/hr');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `internal_erosion_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Internal Erosion Risk Indicator');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `internal_erosion_risk_indicator` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `iron_concentration` SET TAGS ('dbx_business_glossary_term' = 'Iron Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `laboratory_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Flag');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `lead_concentration` SET TAGS ('dbx_business_glossary_term' = 'Lead Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `licence_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Licence Exceedance Flag');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `licence_limit_parameter` SET TAGS ('dbx_business_glossary_term' = 'Licence Limit Parameter');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'toe_drain|seepage_collection_pond|underdrain|piezometer|observation_well|surface_seepage');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `manganese_concentration` SET TAGS ('dbx_business_glossary_term' = 'Manganese Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|under_review|calibration_required|instrument_fault');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `monitoring_point_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Code');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH Level');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'grab_sample|composite_sample|continuous_monitoring|automated_sampler');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `sulfate_concentration` SET TAGS ('dbx_business_glossary_term' = 'Sulfate Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `total_dissolved_solids` SET TAGS ('dbx_business_glossary_term' = 'Total Dissolved Solids (TDS)');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `turbidity` SET TAGS ('dbx_business_glossary_term' = 'Turbidity');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `turbidity_unit` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Unit of Measure');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `turbidity_unit` SET TAGS ('dbx_value_regex' = 'NTU|FNU|JTU');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|fog|storm');
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ALTER COLUMN `zinc_concentration` SET TAGS ('dbx_business_glossary_term' = 'Zinc Concentration');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` SET TAGS ('dbx_subdomain' = 'stability_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `tarp_trigger_id` SET TAGS ('dbx_business_glossary_term' = 'Trigger Action Response Plan (TARP) Trigger ID');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Instrument ID');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `monitoring_location_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Response Equipment Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `closure_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_monitoring|manual_inspection|routine_survey|visual_observation|laboratory_analysis');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `notified_personnel` SET TAGS ('dbx_business_glossary_term' = 'Notified Personnel');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `parameter_category` SET TAGS ('dbx_business_glossary_term' = 'Parameter Category');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `parameter_category` SET TAGS ('dbx_value_regex' = 'geotechnical|hydrological|structural|operational|environmental|seismic');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `response_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Response Actions Taken');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `response_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Initiated Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `safety_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Assessment');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `trigger_level` SET TAGS ('dbx_business_glossary_term' = 'Trigger Level');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `trigger_level` SET TAGS ('dbx_value_regex' = 'green|yellow|orange|red');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `trigger_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Trigger Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `trigger_status` SET TAGS ('dbx_business_glossary_term' = 'Trigger Status');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `trigger_status` SET TAGS ('dbx_value_regex' = 'active|under_investigation|resolved|escalated|closed');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `triggering_parameter` SET TAGS ('dbx_business_glossary_term' = 'Triggering Parameter');
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` SET TAGS ('dbx_subdomain' = 'operational_activities');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `deposition_id` SET TAGS ('dbx_business_glossary_term' = 'Deposition Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `capacity_model_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Model ID');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `deposition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `deposition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `deposition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `deposition_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Deposition Plan ID');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `shift_production_run_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Production Run Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Equipment Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Water Balance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|approved|rejected|pending_review');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `beach_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Beach Elevation (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `beach_length_m` SET TAGS ('dbx_business_glossary_term' = 'Beach Length (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `current_storage_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Current Storage Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'deposition|capacity_survey');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `freeboard_m` SET TAGS ('dbx_business_glossary_term' = 'Freeboard (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `point_latitude` SET TAGS ('dbx_business_glossary_term' = 'Deposition Point Latitude');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `point_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `point_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `point_longitude` SET TAGS ('dbx_business_glossary_term' = 'Deposition Point Longitude');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `point_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `point_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `pond_level_m` SET TAGS ('dbx_business_glossary_term' = 'Pond Level (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `pond_surface_area_m2` SET TAGS ('dbx_business_glossary_term' = 'Pond Surface Area (Square Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `raise_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Raise Trigger Flag');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `remaining_airspace_m3` SET TAGS ('dbx_business_glossary_term' = 'Remaining Airspace (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `remaining_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life (Years)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `slurry_density_t_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Slurry Density (Tonnes per Cubic Meter)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `solids_tonnage_t` SET TAGS ('dbx_business_glossary_term' = 'Solids Tonnage (Tonnes)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `spigot_configuration` SET TAGS ('dbx_business_glossary_term' = 'Spigot Configuration');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `spigot_configuration` SET TAGS ('dbx_value_regex' = 'single|multiple|rotating|fixed');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `survey_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Survey Accuracy Class');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `survey_accuracy_class` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'drone_photogrammetry|lidar|gps|total_station|other');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `total_storage_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `variance_from_plan_m3` SET TAGS ('dbx_business_glossary_term' = 'Variance from Plan (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Deposition Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Materials Storage Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `ard_classification` SET TAGS ('dbx_business_glossary_term' = 'Acid Rock Drainage (ARD) Classification');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `ard_classification` SET TAGS ('dbx_value_regex' = 'PAF|NAF|UC');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `batter_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Batter Angle (degrees)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `compaction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compaction Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `current_lift_number` SET TAGS ('dbx_business_glossary_term' = 'Current Lift Number');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `current_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Current Volume (cubic meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `design_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (cubic meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `dominant_material_type` SET TAGS ('dbx_business_glossary_term' = 'Dominant Material Type');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `drainage_system_type` SET TAGS ('dbx_business_glossary_term' = 'Drainage System Type');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `drainage_system_type` SET TAGS ('dbx_value_regex' = 'none|surface|subsurface|combined');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `dump_code` SET TAGS ('dbx_business_glossary_term' = 'Dump Code');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `dump_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `dump_name` SET TAGS ('dbx_business_glossary_term' = 'Dump Name');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `dump_type` SET TAGS ('dbx_business_glossary_term' = 'Dump Type');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `dump_type` SET TAGS ('dbx_value_regex' = 'waste_rock|overburden|low_grade_ore|mixed');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `geochemical_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Geochemical Risk Rating');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `geochemical_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|extreme');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'satisfactory|minor_issues|major_issues|critical');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `liner_type` SET TAGS ('dbx_business_glossary_term' = 'Liner Type');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `liner_type` SET TAGS ('dbx_value_regex' = 'none|clay|geomembrane|composite|engineered');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `maximum_lift_height_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lift Height (meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `operational_start_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|rehabilitation');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `rehabilitation_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Amount');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `rehabilitation_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `rehabilitation_status` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Status');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `rehabilitation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ALTER COLUMN `remaining_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity (cubic meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` SET TAGS ('dbx_subdomain' = 'operational_activities');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `waste_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Placement ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Source Pit ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Equipment ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `primary_waste_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `primary_waste_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `primary_waste_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `waste_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump ID');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `compaction_method` SET TAGS ('dbx_business_glossary_term' = 'Compaction Method');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `compaction_method` SET TAGS ('dbx_value_regex' = 'dozer_tracked|dozer_wheeled|roller_compaction|no_compaction|natural_settlement');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `compaction_passes` SET TAGS ('dbx_business_glossary_term' = 'Compaction Passes');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `density_achieved_t_m3` SET TAGS ('dbx_business_glossary_term' = 'Density Achieved (Tonnes per Cubic Meter)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `design_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Design Compliance Status');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `design_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_assessed');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `dump_location_code` SET TAGS ('dbx_business_glossary_term' = 'Dump Location Code');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `dump_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `environmental_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Flag');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `geochemical_classification` SET TAGS ('dbx_business_glossary_term' = 'Geochemical Classification (Potentially Acid Forming / Non-Acid Forming)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `geochemical_classification` SET TAGS ('dbx_value_regex' = 'PAF|NAF|PAF_encapsulated|uncertain|not_tested');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `gps_coordinates` SET TAGS ('dbx_business_glossary_term' = 'GPS Coordinates (Global Positioning System)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `gps_coordinates` SET TAGS ('dbx_value_regex' = '^-?[0-9]{1,3}.[0-9]{4,10},s?-?[0-9]{1,3}.[0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `lift_number` SET TAGS ('dbx_business_glossary_term' = 'Lift Number');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'waste_rock|overburden|topsoil|low_grade_ore|mixed_material|other');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `non_conformance_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `non_conformance_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Flag');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `placement_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Date');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `placement_end_time` SET TAGS ('dbx_business_glossary_term' = 'Placement End Time');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `placement_start_time` SET TAGS ('dbx_business_glossary_term' = 'Placement Start Time');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|suspended|cancelled|under_review');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `planned_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Flag');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `source_mining_area` SET TAGS ('dbx_business_glossary_term' = 'Source Mining Area');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `source_mining_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,50}$');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `tonnage_placed_t` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Placed (Tonnes)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `volume_placed_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Placed (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|wind|fog|extreme_heat');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` SET TAGS ('dbx_subdomain' = 'operational_activities');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Water Balance ID');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Calculation Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_notes` SET TAGS ('dbx_business_glossary_term' = 'Balance Notes');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Period End Date');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Period Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_reconciliation_variance_m3` SET TAGS ('dbx_business_glossary_term' = 'Balance Reconciliation Variance (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_reconciliation_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Balance Reconciliation Variance Percentage');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised|approved');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `closing_pond_level_m` SET TAGS ('dbx_business_glossary_term' = 'Closing Pond Level (m)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `closing_storage_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Closing Storage Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `crest_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Crest Elevation (m)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `decant_return_outflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Decant Return Outflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `design_freeboard_m` SET TAGS ('dbx_business_glossary_term' = 'Design Freeboard (m)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `evaporation_outflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Evaporation Outflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `freeboard_m` SET TAGS ('dbx_business_glossary_term' = 'Freeboard (m)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `groundwater_inflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Inflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `opening_pond_level_m` SET TAGS ('dbx_business_glossary_term' = 'Opening Pond Level (m)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `opening_storage_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Opening Storage Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `other_inflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Other Inflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `other_outflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Other Outflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `process_water_inflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Process Water Inflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `rainfall_inflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Inflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `runoff_inflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Runoff Inflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `seepage_outflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Seepage Outflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `spillway_discharge_outflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Spillway Discharge Outflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `storage_change_m3` SET TAGS ('dbx_business_glossary_term' = 'Storage Change Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `total_inflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Inflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `total_outflow_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Outflow Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `water_licence_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Water Licence Compliance Status');
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ALTER COLUMN `water_licence_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable|under_review');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` SET TAGS ('dbx_subdomain' = 'environmental_rehabilitation');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `closure_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `assurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Expiry Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `assurance_lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Lodgement Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `closure_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Closure Cost Currency Code');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `closure_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `closure_cost_npv` SET TAGS ('dbx_business_glossary_term' = 'Closure Cost Net Present Value (NPV)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `closure_strategy` SET TAGS ('dbx_business_glossary_term' = 'Closure Strategy');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `estimated_closure_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Closure Cost');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `final_landform_design` SET TAGS ('dbx_business_glossary_term' = 'Final Landform Design');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `financial_assurance_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Instrument Type');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `financial_assurance_instrument_type` SET TAGS ('dbx_value_regex' = 'bond|bank_guarantee|trust_fund|letter_of_credit|insurance_policy|self_insurance');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `independent_review_date` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Independent Reviewer');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Closure Plan Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Notes');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `plan_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Document Reference');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Status');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Version');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `planned_closure_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Closure Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `planned_closure_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Closure Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `post_closure_monitoring_period_years` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Monitoring Period (Years)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `progressive_rehabilitation_flag` SET TAGS ('dbx_business_glossary_term' = 'Progressive Rehabilitation Flag');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `regulatory_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Authority');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `rehabilitation_objectives` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Objectives');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `review_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Review Frequency (Years)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `stakeholder_consultation_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Flag');
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ALTER COLUMN `variance_to_approved_estimate_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance to Approved Estimate (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` SET TAGS ('dbx_subdomain' = 'environmental_rehabilitation');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `rehabilitation_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Activity Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `closure_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Community Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Materials Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Supervisor Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `activity_notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `activity_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Activity Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled|under_review');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Activity Type');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `area_treated_hectares` SET TAGS ('dbx_business_glossary_term' = 'Area Treated (Hectares)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|pending|not_assessed');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `environmental_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Required');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `materials_used_description` SET TAGS ('dbx_business_glossary_term' = 'Materials Used Description');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|semi_annual|annual|as_required');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `rehabilitation_phase` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Phase');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `rehabilitation_phase` SET TAGS ('dbx_value_regex' = 'progressive|interim|final|post_closure');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `seed_application_rate_kg_per_ha` SET TAGS ('dbx_business_glossary_term' = 'Seed Application Rate (Kilograms per Hectare)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `seed_mix_type` SET TAGS ('dbx_business_glossary_term' = 'Seed Mix Type');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `site_location_description` SET TAGS ('dbx_business_glossary_term' = 'Site Location Description');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `success_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria Description');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `target_vegetation_cover_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Vegetation Cover (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ALTER COLUMN `topsoil_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Topsoil Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` SET TAGS ('dbx_subdomain' = 'environmental_rehabilitation');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `closure_liability_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Liability Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `closure_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `legal_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Legal Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `rehabilitation_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Identifier (ID)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `approved_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Estimate Amount');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `approved_estimate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `assurance_amount_lodged` SET TAGS ('dbx_business_glossary_term' = 'Assurance Amount Lodged');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `assurance_amount_lodged` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `assurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Assurance Currency Code');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `assurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_value_regex' = 'low|significant|high|very_high|extreme');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `estimate_basis` SET TAGS ('dbx_business_glossary_term' = 'Estimate Basis');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `estimate_prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Estimate Prepared By');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `estimated_closure_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Closure Cost');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `estimated_closure_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `expected_closure_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Closure Completion Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `expected_closure_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Closure Start Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `financial_assurance_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Instrument Type');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `financial_assurance_instrument_type` SET TAGS ('dbx_value_regex' = 'surety_bond|bank_guarantee|trust_fund|letter_of_credit|cash_deposit|insurance_policy');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `independent_review_date` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `independent_review_required` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Independent Reviewer');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `liability_notes` SET TAGS ('dbx_business_glossary_term' = 'Liability Notes');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `liability_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `liability_status` SET TAGS ('dbx_business_glossary_term' = 'Liability Status');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `liability_status` SET TAGS ('dbx_value_regex' = 'estimated|approved|under_review|revised|closed');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `liability_type` SET TAGS ('dbx_business_glossary_term' = 'Liability Type');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `liability_type` SET TAGS ('dbx_value_regex' = 'tsf_closure|waste_rock_dump_closure|pit_rehabilitation|infrastructure_decommissioning|water_treatment|ongoing_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `net_present_value` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) of Liability');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `net_present_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `provision_account_code` SET TAGS ('dbx_business_glossary_term' = 'Provision Account Code');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `variance_to_approved_estimate` SET TAGS ('dbx_business_glossary_term' = 'Variance to Approved Estimate');
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ALTER COLUMN `variance_to_approved_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` SET TAGS ('dbx_subdomain' = 'environmental_rehabilitation');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `ard_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Acid Rock Drainage (ARD) Assessment ID');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump ID');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `anc_kg_caco3_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Acid Neutralization Capacity (ANC) (kg CaCO3 per tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `ard_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Acid Rock Drainage (ARD) Risk Classification');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `ard_risk_classification` SET TAGS ('dbx_value_regex' = 'PAF|NAF|UC|low_risk|moderate_risk|high_risk');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `arsenic_leachate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Arsenic Leachate Concentration (mg/L)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessed By');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|superseded');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `carbonate_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbonate Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `copper_leachate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Copper Leachate Concentration (mg/L)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `lead_leachate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Lead Leachate Concentration (mg/L)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `lithology` SET TAGS ('dbx_business_glossary_term' = 'Lithology');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `management_strategy` SET TAGS ('dbx_business_glossary_term' = 'Management Strategy');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'waste_rock|tailings|overburden|ore_reject|mixed');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `maximum_potential_acidity_kg_h2so4_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Maximum Potential Acidity (MPA) (kg H2SO4 per tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `metal_leaching_risk` SET TAGS ('dbx_business_glossary_term' = 'Metal Leaching (ML) Risk');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `metal_leaching_risk` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `nag_ph` SET TAGS ('dbx_business_glossary_term' = 'Net Acid Generation (NAG) pH');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `nag_value_kg_h2so4_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Net Acid Generation (NAG) Value (kg H2SO4 per tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `net_neutralization_potential_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net Neutralization Potential Ratio (NPR)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `paste_ph` SET TAGS ('dbx_business_glossary_term' = 'Paste pH');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `sample_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Sample Depth (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `sample_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Description');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `sulfate_sulfur_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfate Sulfur Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `sulfide_sulfur_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfide Sulfur Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `total_sulfur_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Sulfur Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ALTER COLUMN `zinc_leachate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Zinc Leachate Concentration (mg/L)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` SET TAGS ('dbx_subdomain' = 'stability_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `tsf_capacity_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) Capacity Survey ID');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Engineer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `beach_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Beach Elevation (m)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percent');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `crest_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Crest Elevation (m)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `current_storage_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Current Storage Volume (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `design_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `estimated_filling_rate_m3_per_day` SET TAGS ('dbx_business_glossary_term' = 'Estimated Filling Rate (m³/day)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `freeboard_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Freeboard Compliance Flag');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `freeboard_m` SET TAGS ('dbx_business_glossary_term' = 'Freeboard (m)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `horizontal_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Accuracy (m)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `minimum_required_freeboard_m` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Freeboard (m)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `pond_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Pond Elevation (m)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `pond_surface_area_m2` SET TAGS ('dbx_business_glossary_term' = 'Pond Surface Area (m²)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `projected_capacity_exhaustion_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Capacity Exhaustion Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `remaining_airspace_m3` SET TAGS ('dbx_business_glossary_term' = 'Remaining Airspace (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_accuracy_classification` SET TAGS ('dbx_business_glossary_term' = 'Survey Accuracy Classification');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_accuracy_classification` SET TAGS ('dbx_value_regex' = 'high|medium|standard|reconnaissance');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'drone_photogrammetry|lidar|gps_survey|total_station|bathymetric_survey|terrestrial_laser_scanning');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Reference');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|validated|approved|superseded');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `surveyor_company` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Company');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Name');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `surveyor_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Registration Number');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `total_storage_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `variance_from_design_m3` SET TAGS ('dbx_business_glossary_term' = 'Variance from Design (m³)');
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ALTER COLUMN `vertical_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'Vertical Accuracy (m)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` SET TAGS ('dbx_subdomain' = 'stability_monitoring');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `stability_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Analysis ID');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Of Record Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_notes` SET TAGS ('dbx_business_glossary_term' = 'Analysis Notes');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Analysis Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_software` SET TAGS ('dbx_business_glossary_term' = 'Analysis Software');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'draft|under review|approved|superseded|archived');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Analysis Type');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_value_regex' = 'static|pseudo-static|dynamic|limit equilibrium|finite element|probabilistic');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `cohesion_kpa` SET TAGS ('dbx_business_glossary_term' = 'Cohesion (kPa)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_value_regex' = 'low|significant|high|very high|extreme');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `critical_slip_surface_description` SET TAGS ('dbx_business_glossary_term' = 'Critical Slip Surface Description');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `factor_of_safety` SET TAGS ('dbx_business_glossary_term' = 'Factor of Safety (FoS)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `fos_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Factor of Safety (FoS) Compliance Flag');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `friction_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Friction Angle (Degrees)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Independent Reviewer');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `loading_condition` SET TAGS ('dbx_business_glossary_term' = 'Loading Condition');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `loading_condition` SET TAGS ('dbx_value_regex' = 'end of construction|long-term steady state|rapid drawdown|seismic|post-seismic|extreme precipitation');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `minimum_required_fos` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Factor of Safety (FoS)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `peak_ground_acceleration_g` SET TAGS ('dbx_business_glossary_term' = 'Peak Ground Acceleration (g)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `phreatic_surface_assumption` SET TAGS ('dbx_business_glossary_term' = 'Phreatic Surface Assumption');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Document Reference');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `return_period_years` SET TAGS ('dbx_business_glossary_term' = 'Return Period (Years)');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `seismic_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Seismic Coefficient');
ALTER TABLE `mining_ecm`.`tailings`.`stability_analysis` ALTER COLUMN `unit_weight_kn_m3` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight (kN/m³)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `consequence_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification ID');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Community Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `stage_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `classification_category` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification Category');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `classification_category` SET TAGS ('dbx_value_regex' = 'Extreme|Very High|High|Significant|Low');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `classification_notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `cultural_heritage_impact` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Impact');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `cultural_heritage_impact` SET TAGS ('dbx_value_regex' = 'None|Low|Moderate|High|Very High');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `dam_safety_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Dam Safety Review Frequency (months)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `design_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Standard Reference');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `downstream_infrastructure_impact` SET TAGS ('dbx_business_glossary_term' = 'Downstream Infrastructure Impact');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `economic_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Economic Impact Rating');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `economic_impact_rating` SET TAGS ('dbx_value_regex' = 'Minimal|Minor|Moderate|Major|Severe');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `environmental_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Rating');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `environmental_impact_rating` SET TAGS ('dbx_value_regex' = 'Minimal|Minor|Moderate|Major|Severe');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'TSF|Waste Rock Dump|Water Retention Dam|Sediment Pond|Combined Facility|Other');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `failure_mode_scenario` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Scenario');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `independent_review_date` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `independent_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Outcome');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `independent_review_outcome` SET TAGS ('dbx_value_regex' = 'Endorsed|Endorsed with Conditions|Not Endorsed|Pending');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `independent_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `independent_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Independent Reviewer Name');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `inundation_area_km2` SET TAGS ('dbx_business_glossary_term' = 'Inundation Area (km²)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `loss_of_life_potential` SET TAGS ('dbx_business_glossary_term' = 'Loss of Life Potential');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `loss_of_life_potential` SET TAGS ('dbx_value_regex' = 'None|Low|Significant|High|Very High');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `next_reassessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Due Date');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `peak_discharge_m3_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Peak Discharge (m³/sec)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk (PAR)');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `regulatory_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Date');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Status');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_value_regex' = 'Accepted|Conditionally Accepted|Rejected|Under Review|Not Submitted');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ALTER COLUMN `warning_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Warning Time (hours)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `emergency_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) ID');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Community Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Approval Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Approved By');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `community_engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Community Engagement Status');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `community_engagement_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|ongoing');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_business_glossary_term' = 'Consequence Classification');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `consequence_classification` SET TAGS ('dbx_value_regex' = 'low|significant|high|very_high|extreme');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `drill_exercise_frequency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Exercise Frequency');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Effective Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `emergency_notification_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Notification Procedure');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `evacuation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Procedure');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `evacuation_trigger_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Trigger Criteria');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `independent_review_date` SET TAGS ('dbx_business_glossary_term' = 'Independent Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `independent_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Independent Reviewer Name');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `independent_reviewer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `inundation_study_date` SET TAGS ('dbx_business_glossary_term' = 'Inundation Study Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `inundation_zone_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Downstream Inundation Zone Mapping Reference');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `last_drill_exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Last Emergency Drill Exercise Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Last Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `next_drill_exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Next Emergency Drill Exercise Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Next Review Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `plan_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Document Reference');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Notes');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Status');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan (EAP) Version');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk (PAR)');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `primary_emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Emergency Contact Phone Number');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `primary_emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `primary_emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `regulatory_acceptance_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Reference');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|accepted|rejected');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Name');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `responsible_engineer_registration` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Registration Number');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `responsible_engineer_registration` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `secondary_emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Emergency Contact Name');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `secondary_emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `secondary_emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Emergency Contact Phone Number');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `secondary_emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`emergency_action_plan` ALTER COLUMN `secondary_emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` SET TAGS ('dbx_subdomain' = 'environmental_rehabilitation');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `material_characterisation_id` SET TAGS ('dbx_business_glossary_term' = 'Material Characterisation Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `exploration_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump ID');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `acid_neutralisation_capacity_kg_h2so4_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Acid Neutralisation Capacity (ANC) (kg H₂SO₄/tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `ard_classification` SET TAGS ('dbx_business_glossary_term' = 'Acid Rock Drainage (ARD) Classification');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `ard_classification` SET TAGS ('dbx_value_regex' = 'PAF|NAF|UC');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `arsenic_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Arsenic Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `cadmium_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Cadmium Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `characterisation_notes` SET TAGS ('dbx_business_glossary_term' = 'Characterisation Notes');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `characterisation_status` SET TAGS ('dbx_business_glossary_term' = 'Characterisation Status');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `characterisation_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|superseded');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `compression_index` SET TAGS ('dbx_business_glossary_term' = 'Compression Index');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `consolidation_coefficient_m2_per_year` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Coefficient (m²/year)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `copper_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Copper Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `cyanide_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Cyanide Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `encapsulation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encapsulation Required Flag');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `lead_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Lead Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `liquid_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Liquid Limit (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `management_strategy` SET TAGS ('dbx_business_glossary_term' = 'Management Strategy');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `material_source` SET TAGS ('dbx_business_glossary_term' = 'Material Source');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'tailings|waste_rock|overburden|mixed');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `maximum_potential_acidity_kg_h2so4_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Maximum Potential Acidity (MPA) (kg H₂SO₄/tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `mercury_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Mercury Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `metal_leaching_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Metal Leaching (ML) Risk Rating');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `metal_leaching_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `nag_ph` SET TAGS ('dbx_business_glossary_term' = 'Net Acid Generation (NAG) pH');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `net_acid_generation_kg_h2so4_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Net Acid Generation (kg H₂SO₄/tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `net_acid_producing_potential_kg_h2so4_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Net Acid Producing Potential (NAPP) (kg H₂SO₄/tonne)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `neutralisation_potential_ratio` SET TAGS ('dbx_business_glossary_term' = 'Neutralisation Potential Ratio (NPR)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `nickel_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Nickel Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `particle_size_d10_mm` SET TAGS ('dbx_business_glossary_term' = 'Particle Size D10 (mm)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `particle_size_d50_mm` SET TAGS ('dbx_business_glossary_term' = 'Particle Size D50 (mm)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `particle_size_d90_mm` SET TAGS ('dbx_business_glossary_term' = 'Particle Size D90 (mm)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `paste_ph` SET TAGS ('dbx_business_glossary_term' = 'Paste pH');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `permeability_m_per_s` SET TAGS ('dbx_business_glossary_term' = 'Permeability (m/s)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `plastic_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Plastic Limit (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `plasticity_index` SET TAGS ('dbx_business_glossary_term' = 'Plasticity Index');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `sample_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Description');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `sulphide_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulphide Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `sulphur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulphur Content (Percent)');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'physical|geochemical|ard_ml|combined');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `testing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Classification');
ALTER TABLE `mining_ecm`.`tailings`.`material_characterisation` ALTER COLUMN `zinc_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Zinc Concentration (mg/kg)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` SET TAGS ('dbx_subdomain' = 'operational_activities');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Decant Operation ID');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Decant Structure Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Sample Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee ID');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Chemical Material Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tailings Storage Facility (TSF) ID');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Water Balance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_assessed');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decant End Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_event_date` SET TAGS ('dbx_business_glossary_term' = 'Decant Event Date');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Decant Event Reference Number');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decant Start Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Decant Structure Type');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `decant_structure_type` SET TAGS ('dbx_value_regex' = 'penstock|decant_tower|pump|spillway|siphon|other');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'process_water_return|evaporation_pond|treatment_plant|discharge_to_environment|storage_dam|other');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `flow_rate_m3_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Cubic Meters per Hour)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `freeboard_after_decant_m` SET TAGS ('dbx_business_glossary_term' = 'Freeboard After Decant (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Flag');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `licence_condition_reference` SET TAGS ('dbx_business_glossary_term' = 'Licence Condition Reference');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `operation_notes` SET TAGS ('dbx_business_glossary_term' = 'Operation Notes');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|suspended|aborted|failed');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `rainfall_during_operation_mm` SET TAGS ('dbx_business_glossary_term' = 'Rainfall During Operation (Millimeters)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `volume_decanted_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Decanted (Cubic Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_level_after_m` SET TAGS ('dbx_business_glossary_term' = 'Water Level After Decant (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_level_before_m` SET TAGS ('dbx_business_glossary_term' = 'Water Level Before Decant (Meters)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_quality_ph` SET TAGS ('dbx_business_glossary_term' = 'Water Quality pH Level');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_quality_tds_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Total Dissolved Solids (TDS) in Milligrams per Liter');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_quality_tss_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Total Suspended Solids (TSS) in Milligrams per Liter');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `water_quality_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Turbidity (Nephelometric Turbidity Units)');
ALTER TABLE `mining_ecm`.`tailings`.`decant_operation` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `mining_ecm`.`tailings`.`decant_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`decant_structure` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`decant_structure` ALTER COLUMN `decant_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Decant Structure Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`decant_structure` ALTER COLUMN `superseded_decant_structure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `parent_destination_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `estimated_closure_liability_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`destination_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ALTER COLUMN `deposition_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Deposition Plan Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ALTER COLUMN `superseded_deposition_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ALTER COLUMN `design_engineer_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`deposition_plan` ALTER COLUMN `estimated_closure_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`capacity_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`capacity_model` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`capacity_model` ALTER COLUMN `capacity_model_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Model Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`capacity_model` ALTER COLUMN `superseded_capacity_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`tailings`.`monitoring_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`tailings`.`monitoring_location` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `mining_ecm`.`tailings`.`monitoring_location` ALTER COLUMN `monitoring_location_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Identifier');
ALTER TABLE `mining_ecm`.`tailings`.`monitoring_location` ALTER COLUMN `parent_monitoring_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
