-- Schema for Domain: renewable | Business: Energy Utilities | Version: v1_ecm
-- Generated on: 2026-05-04 21:10:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`renewable` COMMENT 'Renewable energy resource management including utility-scale wind farms, solar arrays, battery storage, and hydroelectric facilities. Manages DER registration, DERMS integration, REC issuance and retirement, RPS compliance portfolios, renewable generation forecasting, curtailment management, BTM generation tracking, NEM credits, and VPP aggregation configurations. Supports state renewable portfolio standards and clean energy mandates.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`der_registry` (
    `der_registry_id` BIGINT COMMENT 'Unique identifier for the DER registration record. Primary key for the DER registry.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DER commissioning requires licensed electricians to perform final inspections, sign-off, and permission-to-operate certification. Tracks responsible technician for regulatory compliance, warranty clai',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: DERs operate within specific control areas for balancing authority coordination, ACE calculation, frequency regulation, and interchange scheduling. Control area operators need visibility of all DER ca',
    `distribution_substation_id` BIGINT COMMENT 'Distribution substation identifier serving the DER location. Used for substation-level DER aggregation, capacity planning, and grid impact analysis.',
    `ems_node_id` BIGINT COMMENT 'Foreign key linking to grid.ems_node. Business justification: Large DERs (>1MW typically) modeled as EMS nodes for state estimation, power flow analysis, and contingency analysis. Required for grid operators to include DER generation in real-time network models ',
    `feeder_id` BIGINT COMMENT 'Distribution feeder circuit identifier where the DER is interconnected. Used for hosting capacity analysis, voltage regulation studies, and feeder-level DER penetration tracking.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Utility-owned DER installations (solar, storage) are capitalized fixed assets requiring FERC account assignment, depreciation, and rate base inclusion; core link for renewable asset accounting and reg',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: DER assets are geographically assigned to forecast zones for aggregated load and generation forecasting, resource adequacy assessments, and distribution planning. Essential for modeling DER impact on ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: DER equipment (inverters, batteries, solar panels) are procured materials with part numbers, specifications, and warranty tracking. Real business process: asset lifecycle management, spare parts plann',
    `btm_generation_flag` BOOLEAN COMMENT 'Indicates whether the DER is a behind-the-meter installation serving on-site load. True for customer-sited resources that offset premise consumption. False for front-of-meter or utility-scale resources that export all generation to the grid.',
    `commissioning_date` DATE COMMENT 'Date when the DER completed all interconnection requirements and was authorized to begin commercial operation. Used for Renewable Energy Certificate (REC) vintage determination, incentive eligibility, and asset age tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DER registry record was first created in the system. Used for audit trail and data lineage tracking.',
    `curtailment_capable_flag` BOOLEAN COMMENT 'Indicates whether the DER can be remotely curtailed by the utility or aggregator. True if the resource has communication and control infrastructure for dispatch down commands. False if the resource operates autonomously without remote control capability.',
    `data_source_system` STRING COMMENT 'Name of the source system or application that provided this DER registration data. Examples include interconnection application systems, DERMS platforms, or manual registration portals. Used for data lineage and reconciliation.',
    `decommissioning_date` DATE COMMENT 'Date when the DER was permanently removed from service and disconnected from the grid. Null for active resources. Used for asset lifecycle tracking and capacity planning.',
    `demand_response_eligible_flag` BOOLEAN COMMENT 'Indicates whether the DER is eligible to participate in utility demand response programs. True if the resource has controllable load or dispatchable generation/storage capability. False if ineligible due to size, technology, or operational constraints.',
    `der_name` STRING COMMENT 'Business name or designation of the distributed energy resource installation.',
    `der_to_enrollment` BIGINT COMMENT 'FK to renewable.renewable_der_enrollment.renewable_der_enrollment_id — DER enrollment records must reference the specific DER they enroll. This is the fundamental master-to-transaction link for DER program management.',
    `der_type` STRING COMMENT 'Classification of the DER technology. Solar PV includes rooftop and ground-mount photovoltaic systems. Battery storage includes lithium-ion, flow batteries, and other electrochemical storage. Wind includes small-scale turbines under 1 MW. Fuel cell includes hydrogen and natural gas fuel cells. Combined heat and power (CHP) includes cogeneration systems. Microturbine includes small combustion turbines.. Valid values are `solar_pv|battery_storage|wind|fuel_cell|combined_heat_power|microturbine`',
    `derms_system_code` STRING COMMENT 'External system identifier used by the DERMS platform to monitor and control this DER. Enables real-time dispatch, curtailment commands, and telemetry integration. Null for DERs not enrolled in DERMS programs.',
    `export_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power export limit in kilowatts (kW) allowed by the interconnection agreement. May be less than nameplate capacity due to grid constraints, NEM program rules, or hosting capacity limitations. Null if no export limit applies.',
    `forecast_provider` STRING COMMENT 'Name of the third-party or internal system providing generation forecasts for this DER. Used for solar and wind resources requiring day-ahead and real-time production forecasting. Null for non-variable resources.',
    `incentive_program_code` STRING COMMENT 'Code identifying the utility or state incentive program under which the DER was installed. Examples include solar rebate programs, storage incentives, or federal Investment Tax Credit (ITC) tracking. Null if no incentive was claimed.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'Total installed cost of the DER in US dollars including equipment, labor, permitting, and interconnection fees. Business-confidential. Used for incentive program cost-effectiveness analysis and LCOE calculations.',
    `interconnection_agreement_number` STRING COMMENT 'Unique identifier for the executed interconnection agreement governing the DERs connection to the utility grid. References the legal contract specifying technical requirements, liability, and operational protocols.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent utility or third-party inspection of the DER installation. Used for compliance verification, safety audit tracking, and periodic re-certification requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DER registry record was most recently updated. Used for change tracking, data quality monitoring, and audit trail purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the DER installation in decimal degrees. Used for GIS mapping, solar irradiance modeling, weather correlation, and grid topology analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the DER installation in decimal degrees. Used for GIS mapping, solar irradiance modeling, weather correlation, and grid topology analysis.',
    `meter_number` STRING COMMENT 'Utility meter identifier associated with the DER interconnection point. References the revenue meter or production meter used for NEM credit calculation, billing, and generation tracking. May reference a dedicated production meter or the premise service meter.',
    `nameplate_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum rated power output or storage capacity of the DER in kilowatts (kW). For generation resources, this is the AC output rating. For battery storage, this is the maximum discharge rate. Critical for grid planning, interconnection studies, and program eligibility determination.',
    `nem_eligible_flag` BOOLEAN COMMENT 'Indicates whether the DER is eligible for Net Energy Metering (NEM) programs. True if the resource meets size, technology, and jurisdictional requirements for NEM credit generation. False if ineligible or enrolled in alternative compensation mechanisms.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection or compliance verification. Null if no periodic inspection is required. Used for proactive maintenance scheduling and regulatory compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or operational notes related to the DER registration. May include interconnection study findings, operational restrictions, or program-specific requirements.',
    `operational_status` STRING COMMENT 'Current operational state of the DER. Commissioned indicates the resource has completed interconnection and is authorized to operate. Operational indicates active generation or storage capability. Offline indicates temporary non-operation due to maintenance or technical issues. Decommissioned indicates permanent removal from service. Suspended indicates administrative hold. Testing indicates pre-commissioning validation phase.. Valid values are `commissioned|operational|offline|decommissioned|suspended|testing`',
    `owner_name` STRING COMMENT 'Legal name of the entity that owns the DER asset. May be a residential customer, commercial entity, or third-party developer. Business-confidential for competitive and privacy reasons.',
    `ownership_structure` STRING COMMENT 'Legal ownership model of the DER. Customer-owned indicates the premise owner owns the asset. Third-party-owned indicates a solar lease, PPA, or other third-party financing arrangement. Utility-owned indicates utility-scale BTM assets. Community-shared indicates community solar or shared renewable programs.. Valid values are `customer_owned|third_party_owned|utility_owned|community_shared`',
    `poi_identifier` STRING COMMENT 'Unique identifier for the physical point where the DER connects to the utility distribution system. References the specific transformer, service panel, or substation bus where interconnection occurs. Critical for grid modeling, outage management, and voltage regulation analysis.',
    `rec_eligible_flag` BOOLEAN COMMENT 'Indicates whether the DER is eligible to generate Renewable Energy Certificates (RECs). True if the resource is a qualifying renewable technology under state RPS rules. False if ineligible due to technology type, vintage, or jurisdictional requirements.',
    `registration_date` DATE COMMENT 'Date when the DER was first registered in the utility DER registry. Represents the initial record creation date, which may precede commissioning. Used for audit trail and registration workflow tracking.',
    `rps_compliance_tier` STRING COMMENT 'RPS tier classification for the DER under state renewable portfolio standards. Tiers typically differentiate by technology type, vintage, or geographic location. Examples include Tier 1 (new renewables), Tier 2 (existing renewables), Solar Carve-Out, or Distributed Generation tier. Null if not RPS-eligible.',
    `service_territory` STRING COMMENT 'Utility service territory or operating company jurisdiction where the DER is located. Used for regulatory reporting, RPS compliance tracking, and jurisdictional analysis.',
    `smart_inverter_capable_flag` BOOLEAN COMMENT 'Indicates whether the DER is equipped with IEEE 1547-2018 compliant smart inverter functionality. True if the inverter supports advanced grid support functions including volt-VAR, frequency-watt, and dynamic reactive power control. False for legacy inverters without advanced functions.',
    `storage_capacity_kwh` DECIMAL(18,2) COMMENT 'Total energy storage capacity in kilowatt-hours (kWh) for battery storage and other energy storage systems. Null for non-storage DER types. Used for Virtual Power Plant (VPP) aggregation and demand response program sizing.',
    `technology_class` STRING COMMENT 'Detailed technology classification including manufacturer model, inverter type, panel efficiency class, or battery chemistry. Provides granular technical categorization beyond the primary DER type.',
    CONSTRAINT pk_der_registry PRIMARY KEY(`der_registry_id`)
) COMMENT 'Master registry of all Distributed Energy Resources (DERs) registered within the utility service territory. Captures DER type (solar PV, battery storage, small wind, fuel cell), nameplate capacity (kW/MW), technology class, interconnection point (POI), DERMS system identifier, commissioning date, operational status, ownership structure (customer-owned, third-party, utility), and geographic coordinates. SSOT for all distributed generation and storage assets participating in utility programs including NEM, VPP, demand response, and storage incentives. Excludes utility-scale generation facilities mastered in the generation domain and customer-level interconnection applications managed in the interconnection domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` (
    `renewable_rec_certificate_id` BIGINT COMMENT 'Unique identifier for the renewable energy certificate record. Primary key.',
    `attestation_document_id` BIGINT COMMENT 'Reference identifier for the supporting documentation or attestation filed with the registry to verify generation and REC issuance. Used for audit and compliance verification.',
    `der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — Each REC must trace back to the generation source (DER or facility) that produced the 1 MWh of renewable electricity. This is a regulatory requirement for REC validity.',
    `irp_scenario_id` BIGINT COMMENT 'Foreign key linking to forecast.irp_scenario. Business justification: IRP scenarios project REC generation and retirement to model RPS compliance pathways, renewable attribute tracking, and ACP exposure. Essential for long-term renewable procurement planning.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: REC issuance, transfer, and retirement trigger GL entries for inventory valuation, revenue recognition, and compliance cost accounting; direct link automates posting and provides audit trail for renew',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: REC issuance requires validated metered generation data from specific revenue-quality meters for attestation. REC audit trail and compliance verification link certificate to source meter for data line',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: RECs must be tracked against specific RPS compliance obligations for regulatory reporting. Utilities track which RPS mandate each REC satisfies. Critical for RPS compliance verification and obligation',
    `power_plant_id` BIGINT COMMENT 'Reference to the renewable generation facility or distributed energy resource (DER) that produced the electricity represented by this REC.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: RECs issued from utility-owned renewable assets require asset linkage for RPS compliance audits, vintage tracking, and double-counting prevention. Complements existing power_plant_id for non-plant ren',
    `rps_obligation_id` BIGINT COMMENT 'FK to renewable.rps_obligation.rps_obligation_id — RECs are retired to satisfy RPS obligations. This is the core compliance linkage — every REC retirement for RPS compliance must reference the specific obligation period it satisfies. Production-critic',
    `vpp_configuration_id` BIGINT COMMENT 'Reference to the virtual power plant (VPP) or DER aggregation program if this REC was generated by a facility participating in aggregated dispatch. Null for standalone facilities.',
    `certificate_serial_number` STRING COMMENT 'Unique serial number assigned by the issuing registry to this REC. This is the externally-known identifier used for tracking, trading, and retirement across registries and market participants.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the REC. Issued: newly created; Active: available for trading; Transferred: ownership changed; Retired: used for compliance or voluntary claim; Expired: past validity period; Cancelled: invalidated; Suspended: temporarily held. [ENUM-REF-CANDIDATE: issued|active|transferred|retired|expired|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `compliance_year` STRING COMMENT 'Calendar year for which this REC was retired to meet RPS compliance obligations. May differ from vintage year due to banking or forward compliance rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC record was first created in the internal system. Used for audit trail and data lineage tracking.',
    `curtailment_mwh` DECIMAL(18,2) COMMENT 'Amount of renewable generation that was curtailed (not delivered to grid) during the generation period due to grid constraints or economic dispatch. Subtracted from gross generation to determine net REC-eligible generation.',
    `data_source_system` STRING COMMENT 'Name of the source system or registry API from which this REC data was ingested. Examples: WREGIS API, M-RETS API, manual entry, internal generation system.',
    `eligibility_flags` STRING COMMENT 'Comma-separated list of eligibility attributes for this REC, such as tier classification (Tier I, Tier II), solar carve-out eligibility, new facility status, or other state-specific program qualifications.',
    `expiration_date` DATE COMMENT 'Date after which the REC can no longer be used for compliance or voluntary claims. Typically 3-5 years from vintage year depending on state rules.',
    `facility_commercial_operation_date` DATE COMMENT 'Date when the generation facility began commercial operation. Used to determine new vs. existing facility status for RPS tier classification.',
    `facility_county` STRING COMMENT 'County or equivalent administrative region where the generation facility is located. Used for local content and economic development tracking.',
    `facility_state` STRING COMMENT 'Two-letter US state code or three-letter country code where the generation facility is located. Used for determining RPS eligibility and geographic tracking.',
    `generation_end_date` DATE COMMENT 'End date of the generation period during which the renewable electricity represented by this REC was produced.',
    `generation_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable electricity generation represented by this REC, measured in megawatt-hours. Each REC typically represents 1 MWh of renewable generation injected into the grid.',
    `generation_start_date` DATE COMMENT 'Start date of the generation period during which the renewable electricity represented by this REC was produced.',
    `grid_injection_point` STRING COMMENT 'Point of interconnection (POI) identifier where the renewable generation was injected into the transmission or distribution grid. Used for locational tracking and grid impact analysis.',
    `issuance_date` DATE COMMENT 'Date on which the REC was officially issued by the registry and became available for trading or retirement.',
    `issuing_registry` STRING COMMENT 'Name of the regional or national registry that issued and tracks this REC. WREGIS: Western Renewable Energy Generation Information System; M-RETS: Midwest Renewable Energy Tracking System; PJM-GATS: PJM Generation Attribute Tracking System; NAR: North American Renewables Registry; NEPOOL-GIS: New England Power Pool Generation Information System; ERCOT: Electric Reliability Council of Texas; MIRECS: Michigan Renewable Energy Certification System. [ENUM-REF-CANDIDATE: WREGIS|M-RETS|PJM-GATS|NAR|NEPOOL-GIS|ERCOT|MIRECS — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC record was last updated in the internal system. Used for audit trail and change tracking.',
    `market_value_usd` DECIMAL(18,2) COMMENT 'Estimated or actual market value of this REC in US dollars at the time of issuance or most recent valuation. Used for financial reporting and portfolio valuation.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum rated electrical output capacity of the generation facility in megawatts at the time of REC issuance. Used for facility classification and program eligibility.',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether the generation represented by this REC came from a behind-the-meter (BTM) net metering facility. True if NEM generation; False if utility-scale or non-NEM DER.',
    `retirement_date` DATE COMMENT 'Date on which the REC was retired and removed from circulation. Null if the REC has not been retired.',
    `retirement_reason` STRING COMMENT 'Business reason for retiring the REC. RPS Compliance: used to meet state renewable portfolio standard obligations; Voluntary Green Power: customer voluntary renewable energy program; Export Compliance: retired for out-of-state RPS; Corporate Sustainability: retired for corporate renewable energy goals; Carbon Offset: retired for carbon neutrality claims.. Valid values are `rps_compliance|voluntary_green_power|export_compliance|corporate_sustainability|carbon_offset`',
    `rps_obligation_period` STRING COMMENT 'The compliance period (typically a calendar year or program year) for which this REC is being applied toward RPS obligations. Format: YYYY or YYYY-YYYY for multi-year periods.',
    `technology_type` STRING COMMENT 'Type of renewable energy technology used to generate the electricity. Solar PV: photovoltaic solar; Wind: onshore or offshore wind turbines; Hydroelectric: run-of-river or reservoir hydro; Biomass: organic material combustion; Geothermal: earth heat; Landfill Gas: methane capture.. Valid values are `solar_pv|wind|hydroelectric|biomass|geothermal|landfill_gas`',
    `trading_platform` STRING COMMENT 'Name of the electronic trading platform or bilateral agreement mechanism through which this REC was last traded. Examples: Marex Spectron, Evolution Markets, bilateral OTC.',
    `transfer_history_count` STRING COMMENT 'Number of times this REC has been transferred between accounts since issuance. Used for audit trail and market activity analysis.',
    `vintage_year` STRING COMMENT 'Calendar year in which the renewable electricity was generated. Used for RPS compliance tracking and market valuation, as some programs require current or recent vintage RECs.',
    CONSTRAINT pk_renewable_rec_certificate PRIMARY KEY(`renewable_rec_certificate_id`)
) COMMENT 'Renewable Energy Certificate (REC) issuance and retirement record. Each REC represents 1 MWh of renewable electricity generated and injected into the grid. Captures certificate serial number, generation source facility or DER, generation period, technology type, vintage year, issuing registry (WREGIS, M-RETS, PJM-GATS, NAR), certificate status (issued, transferred, retired, expired), retirement reason (RPS compliance, voluntary, export), and associated RPS obligation period. SSOT for REC inventory, lifecycle tracking, and compliance retirement within the renewable domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` (
    `rps_obligation_id` BIGINT COMMENT 'Unique identifier for the RPS compliance obligation record. Primary key for the RPS obligation entity.',
    `irp_scenario_id` BIGINT COMMENT 'Foreign key linking to forecast.irp_scenario. Business justification: RPS compliance obligations drive renewable capacity targets in IRP scenarios. Scenarios model pathways to meet RPS requirements, including capacity additions, REC procurement, and ACP exposure.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: RPS obligations are regulatory compliance obligations under state renewable portfolio standards. Links RPS-specific tracking to enterprise compliance framework. Essential for integrated compliance man',
    `regulatory_asset_id` BIGINT COMMENT 'Foreign key linking to finance.regulatory_asset. Business justification: RPS compliance costs (ACP payments, REC procurement above market) create regulatory assets for future rate recovery; link supports rate case filings, FERC Form 1 reporting, and amortization tracking.',
    `acp_exposure_amount` DECIMAL(18,2) COMMENT 'Total financial exposure in dollars for Alternative Compliance Payments based on projected shortfall multiplied by ACP rate. Represents potential penalty cost if shortfall is not remedied.',
    `acp_paid_amount` DECIMAL(18,2) COMMENT 'Actual Alternative Compliance Payment amount in dollars paid to the state for this compliance period. Null if no ACP has been paid.',
    `acp_rate_per_mwh` DECIMAL(18,2) COMMENT 'Regulatory penalty rate per MWh for shortfall, expressed in dollars per MWh. This is the Alternative Compliance Payment rate that the utility must pay for each MWh of unmet RPS obligation.',
    `compliance_deadline_date` DATE COMMENT 'Regulatory deadline by which the utility must demonstrate full compliance with the RPS obligation for this period. Typically 3-6 months after the compliance period end date.',
    `compliance_percentage_achieved` DECIMAL(18,2) COMMENT 'Current compliance percentage achieved based on RECs retired to date divided by required renewable MWh, expressed as a percentage. Indicates progress toward meeting the RPS obligation.',
    `compliance_period_end_date` DATE COMMENT 'End date of the compliance period for this RPS obligation. Typically December 31 of the compliance year.',
    `compliance_period_start_date` DATE COMMENT 'Start date of the compliance period for this RPS obligation. Typically January 1 of the compliance year.',
    `compliance_period_year` STRING COMMENT 'Calendar year for which this RPS obligation applies. RPS compliance is typically measured annually or over multi-year periods.',
    `compliance_status` STRING COMMENT 'Current status of the RPS obligation compliance. In_progress indicates the compliance period is active; compliant indicates full compliance achieved; shortfall indicates projected or actual deficit; surplus indicates excess compliance; filed indicates compliance report submitted; under_review indicates regulatory review in progress.. Valid values are `in_progress|compliant|shortfall|surplus|filed|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RPS obligation record was first created in the system. Audit field for data lineage.',
    `filing_status` STRING COMMENT 'Status of the regulatory compliance filing to the state PUC. Not_filed indicates no filing yet; draft indicates filing in preparation; submitted indicates filing delivered to regulator; accepted indicates regulator approval; rejected indicates regulator rejection; amended indicates revised filing submitted.. Valid values are `not_filed|draft|submitted|accepted|rejected|amended`',
    `filing_submission_date` DATE COMMENT 'Date on which the RPS compliance filing was submitted to the state PUC. Null if not yet filed.',
    `jurisdiction_code` STRING COMMENT 'Two-letter state code identifying the regulatory jurisdiction imposing the RPS obligation (e.g., CA for California, NY for New York, MA for Massachusetts).. Valid values are `^[A-Z]{2}$`',
    `last_reconciliation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reconciliation of the RPS compliance position. Indicates when RECs retired, inventory, and shortfall/surplus calculations were last updated.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, assumptions, or special circumstances related to this RPS obligation. May include details on carve-out strategies, banking decisions, or regulatory correspondence.',
    `obligated_retail_sales_mwh` DECIMAL(18,2) COMMENT 'Total retail electricity sales in MWh subject to the RPS obligation for this compliance period. This is the base quantity against which the renewable percentage requirement is applied.',
    `offshore_wind_carveout_mwh` DECIMAL(18,2) COMMENT 'Absolute quantity of offshore wind energy in MWh required to meet the offshore wind carve-out. Null if no offshore wind carve-out applies.',
    `offshore_wind_carveout_percentage` DECIMAL(18,2) COMMENT 'Technology-specific carve-out percentage requiring a minimum portion of the RPS obligation to be met with offshore wind generation. Null if no offshore wind carve-out applies.',
    `projected_shortfall_mwh` DECIMAL(18,2) COMMENT 'Projected shortfall in MWh between the required renewable MWh and the sum of RECs retired plus RECs in inventory. Positive value indicates a deficit; null or zero indicates compliance is on track or surplus exists.',
    `projected_surplus_mwh` DECIMAL(18,2) COMMENT 'Projected surplus in MWh beyond the required renewable MWh. Positive value indicates excess RECs available for banking or future compliance periods; null or zero indicates no surplus.',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which the RPS compliance position is reconciled and updated. Indicates how often the running position is refreshed.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `recs_inventory_mwh` DECIMAL(18,2) COMMENT 'Quantity of RECs in MWh currently held in inventory and available for retirement toward this compliance period. Represents banked RECs not yet applied.',
    `recs_retired_mwh` DECIMAL(18,2) COMMENT 'Total quantity of RECs in MWh that have been retired to date for this compliance period. This is the running compliance position representing actual compliance achieved.',
    `required_renewable_mwh` DECIMAL(18,2) COMMENT 'Absolute quantity of renewable energy in MWh required to meet the RPS obligation. Calculated as obligated_retail_sales_mwh multiplied by required_renewable_percentage.',
    `required_renewable_percentage` DECIMAL(18,2) COMMENT 'Mandated percentage of retail sales that must be served by renewable energy sources for this compliance period. Expressed as a percentage (e.g., 33.00 for 33%).',
    `responsible_party_name` STRING COMMENT 'Name of the internal business unit or individual responsible for managing this RPS obligation and ensuring compliance.',
    `rps_rec_retirement` BIGINT COMMENT 'FK to renewable.rec_certificate.rec_certificate_id — RPS obligations are satisfied by retiring RECs. The compliance position tracks RECs retired against the obligation. This FK is essential for compliance reconciliation and regulatory reporting.',
    `solar_carveout_mwh` DECIMAL(18,2) COMMENT 'Absolute quantity of solar energy in MWh required to meet the solar carve-out. Null if no solar carve-out applies.',
    `solar_carveout_percentage` DECIMAL(18,2) COMMENT 'Technology-specific carve-out percentage requiring a minimum portion of the RPS obligation to be met with solar generation. Null if no solar carve-out applies.',
    `storage_carveout_mwh` DECIMAL(18,2) COMMENT 'Absolute quantity of energy storage in MWh required to meet the storage carve-out. Null if no storage carve-out applies.',
    `storage_carveout_percentage` DECIMAL(18,2) COMMENT 'Technology-specific carve-out percentage requiring a minimum portion of the RPS obligation to be met with energy storage systems. Null if no storage carve-out applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RPS obligation record was last modified. Audit field for data lineage and change tracking.',
    CONSTRAINT pk_rps_obligation PRIMARY KEY(`rps_obligation_id`)
) COMMENT 'Renewable Portfolio Standard (RPS) compliance obligation and running position record per compliance period and state jurisdiction. Captures the regulatory target (obligated retail sales MWh, required renewable percentage, technology-specific carve-outs for solar/offshore wind/storage, ACP rate) and the running compliance position against that target (RECs retired to date, RECs in inventory, projected shortfall or surplus MWh, compliance percentage achieved, last reconciliation timestamp). Includes compliance deadline, filing status, and alternative compliance payment exposure. SSOT for RPS obligation targets AND compliance position tracking within the renewable domain — no separate position product exists. Feeds regulatory filings to state PUCs and internal compliance dashboards.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` (
    `ppa_contract_id` BIGINT COMMENT 'Primary key for ppa_contract',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: PPAs finance renewable generation projects; linking contract to capex project enables rate base inclusion tracking, regulatory cost recovery filings, and FERC reporting of contracted generation assets',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Power purchase agreements require designated contract managers for negotiation, execution, amendment tracking, and ongoing administration. Essential for accountability in multi-million dollar renewabl',
    `counterparty_id` BIGINT COMMENT 'Reference to the independent power producer (IPP), project developer, or renewable energy supplier that is the counterparty to this PPA contract.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: PPA contracts reference forward price forecasts for contract valuation, hedging strategy development, and financial risk assessment. Critical for procurement and portfolio management decisions.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: PPAs often require FERC or state PUC approval filings. Utilities must track which regulatory filing authorized each contract for compliance and audit purposes. Standard practice in regulated markets f',
    `base_price_per_mwh` DECIMAL(18,2) COMMENT 'Base energy price in USD per MWh at contract inception, before escalation or indexing adjustments. Business-confidential pricing term.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Expected or contracted capacity factor (ratio of actual output to maximum possible output) expressed as a percentage, used for forecasting and performance evaluation.',
    `contract_amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original PPA contract since execution.',
    `contract_execution_date` DATE COMMENT 'Date when the PPA contract was signed and executed by both parties.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the PPA contract, typically referencing the project or facility name.',
    `contract_notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the PPA contract.',
    `contract_number` STRING COMMENT 'Externally-known business identifier for the PPA contract, used in legal documents, regulatory filings, and counterparty communications.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the PPA contract: draft (under negotiation), pending approval (awaiting internal or regulatory approval), active (in force), suspended (temporarily halted), terminated (ended early), or expired (reached end of term).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_term_years` STRING COMMENT 'Total duration of the PPA contract in years from effective start date to effective end date.',
    `contract_type` STRING COMMENT 'Classification of the PPA pricing structure: fixed price (flat rate), indexed (tied to market index), escalating (annual increases), hybrid (combination), or tolling (capacity payment plus energy).. Valid values are `fixed_price|indexed|escalating|hybrid|tolling`',
    `contracted_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum generation capacity in megawatts (MW) that the counterparty is obligated to make available under this PPA contract.',
    `contracted_energy_volume_mwh_annual` DECIMAL(18,2) COMMENT 'Total annual energy volume in megawatt-hours (MWh) that the utility commits to purchase under this PPA contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PPA contract record was first created in the system.',
    `curtailment_compensation_flag` BOOLEAN COMMENT 'Indicates whether the counterparty is entitled to compensation for curtailed energy (True) or not (False).',
    `curtailment_provision` STRING COMMENT 'Contractual terms allowing the utility to curtail (reduce or halt) energy delivery from the renewable facility due to grid constraints, oversupply, or operational needs, including compensation or penalty terms.',
    `delivery_point_poi` STRING COMMENT 'Physical location or substation where energy is delivered from the renewable facility to the utility grid, also known as the Point of Interconnection (POI).',
    `effective_end_date` DATE COMMENT 'Date when the PPA contract term expires and energy delivery obligations cease. Nullable for open-ended or evergreen contracts.',
    `effective_start_date` DATE COMMENT 'Date when the PPA contract becomes legally binding and energy delivery obligations commence.',
    `ferc_filing_reference` STRING COMMENT 'Reference number or docket ID for the FERC filing associated with this PPA contract, if applicable for wholesale market transactions.',
    `force_majeure_clause` STRING COMMENT 'Legal clause defining events beyond the control of either party (natural disasters, regulatory changes, grid failures) that excuse non-performance without penalty.',
    `generation_source` STRING COMMENT 'Type of renewable energy resource covered by this PPA: solar (photovoltaic or thermal), wind (onshore or offshore), hydro (run-of-river or reservoir), battery storage (energy storage system), biomass, or geothermal.. Valid values are `solar|wind|hydro|battery_storage|biomass|geothermal`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the PPA contract. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PPA contract record was last updated in the system.',
    `minimum_delivery_obligation_mwh` DECIMAL(18,2) COMMENT 'Minimum annual energy volume in MWh that the counterparty must deliver to avoid penalties or contract breach.',
    `performance_guarantee_terms` STRING COMMENT 'Contractual terms specifying performance guarantees, including availability targets, capacity factor commitments, and associated liquidated damages or penalties for underperformance.',
    `price_escalation_rate_percent` DECIMAL(18,2) COMMENT 'Annual percentage rate at which the energy price escalates over the contract term. Null for fixed-price contracts. Business-confidential pricing term.',
    `price_index_reference` STRING COMMENT 'Name of the market index or benchmark to which the PPA price is tied (e.g., Locational Marginal Price (LMP) at specific PNode, CPI, natural gas index). Null for fixed-price contracts.',
    `pricing_node_pnode` STRING COMMENT 'Specific pricing node (PNode) in the Regional Transmission Organization (RTO) or Independent System Operator (ISO) market used for settlement and Locational Marginal Price (LMP) determination.',
    `rec_ownership` STRING COMMENT 'Specifies which party owns the Renewable Energy Certificates (RECs) generated by the facility: utility (utility retains RECs for RPS compliance), counterparty (IPP retains RECs), shared (split between parties), or unbundled (RECs sold separately).. Valid values are `utility|counterparty|shared|unbundled`',
    `rec_transfer_terms` STRING COMMENT 'Detailed terms governing the transfer, retirement, and tracking of RECs, including timing, registry requirements, and compliance obligations.',
    `regulatory_approval_date` DATE COMMENT 'Date when the PPA contract received required regulatory approval from the Public Utility Commission (PUC) or other governing body. Nullable if approval is not required.',
    `renewable_attribute_transfer` STRING COMMENT 'Detailed terms governing the transfer of renewable energy attributes (environmental benefits, carbon offsets, green tags) beyond RECs, including timing and compliance obligations.',
    `rps_compliance_flag` BOOLEAN COMMENT 'Indicates whether this PPA contract contributes to the utilitys Renewable Portfolio Standard (RPS) compliance obligations (True) or not (False).',
    `rps_jurisdiction` STRING COMMENT 'State or regulatory jurisdiction whose RPS requirements this PPA contract helps satisfy (e.g., California, New York, Texas).',
    `settlement_frequency` STRING COMMENT 'Frequency at which energy delivery and payments are settled between the utility and counterparty: monthly, quarterly, or annual.. Valid values are `monthly|quarterly|annual`',
    `termination_clause` STRING COMMENT 'Contractual terms under which either party may terminate the PPA early, including notice periods, breach conditions, and financial penalties.',
    CONSTRAINT pk_ppa_contract PRIMARY KEY(`ppa_contract_id`)
) COMMENT 'Power Purchase Agreement (PPA) master record for renewable energy procurement contracts between the utility and independent power producers (IPPs) or project developers. Captures counterparty, contracted capacity (MW), energy volume (MWh/year), contract term, pricing structure (fixed, indexed, escalating), delivery point (POI/PNode), REC ownership and transfer terms, curtailment provisions, force majeure clauses, FERC filing reference, and contract status. SSOT boundary: scoped ONLY to renewable-source PPAs where REC ownership, renewable attributes, and RPS compliance are integral contract terms. Conventional/thermal PPAs, tolling agreements, and wholesale trading contracts are managed in the trading domain. Cross-domain SSOT adjudication pending with global architect.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` (
    `ppa_settlement_id` BIGINT COMMENT 'Primary key for ppa_settlement',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity (renewable generator, independent power producer, or purchasing utility) involved in this PPA settlement.',
    `der_registry_id` BIGINT COMMENT 'Reference to the renewable generation facility (wind farm, solar array, hydro plant, battery storage) that produced the generation for this settlement.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: PPA settlements reference market price forecasts for imbalance charge calculation, curtailment credit valuation, and contract performance assessment. Required for accurate financial settlement and rep',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: PPA settlements account for curtailment and unavailability caused by grid outages under force majeure provisions. Counterparties dispute settlement amounts when outages prevent contracted delivery. Re',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Every PPA settlement generates GL entries for energy revenue, REC transfers, curtailment credits, and transmission charges; direct link enables automated posting, audit trail, and SOX compliance for r',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: PPA settlements require metered generation from specific revenue meters at generation facilities. Monthly PPA invoice reconciliation and dispute resolution link settlement calculations to source meter',
    `original_settlement_ppa_settlement_id` BIGINT COMMENT 'Reference to the original settlement record if this is an adjustment settlement. Null for original settlements.',
    `power_plant_id` BIGINT COMMENT 'Foreign key linking to generation.power_plant. Business justification: PPA settlements require metered generation data from the renewable power plant to calculate invoice amounts, reconcile contracted vs. actual delivery, and resolve disputes over curtailment credits or ',
    `ppa_contract_id` BIGINT COMMENT 'FK to renewable.ppa_contract.ppa_contract_id — Each PPA settlement record is for a specific PPA contract. This is a classic header-line relationship. Without this FK, settlements cannot be reconciled to contracts.',
    `primary_ppa_contract_id` BIGINT COMMENT 'Reference to the parent renewable PPA contract under which this settlement is executed.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: PPA settlements for utility-owned generation reference the physical asset for cost allocation, depreciation matching, and FERC compliance reporting. Asset-specific PPAs require direct linkage for regu',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PPA settlements require energy analysts to reconcile metered generation against contracted volumes, calculate curtailment credits, and resolve invoice disputes. Tracks analyst for settlement accuracy,',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: PPA counterparties are registered as vendors for accounts payable processing, payment terms management, and vendor performance evaluation. Real business process: invoice verification, payment processi',
    `adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement record is an adjustment to a previously finalized settlement.',
    `adjustment_reason` STRING COMMENT 'Description of the reason for the settlement adjustment, such as meter data correction, contract amendment, or billing error correction.',
    `ancillary_services_charge_amount` DECIMAL(18,2) COMMENT 'Charges in dollars for ancillary services (regulation, spinning reserves, voltage support) allocated to this settlement period.',
    `availability_percent` DECIMAL(18,2) COMMENT 'Facility availability percentage during the settlement period, representing the proportion of time the facility was available for generation.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Capacity factor percentage for the renewable facility during the settlement period, calculated as actual generation divided by maximum potential generation.',
    `contracted_price_per_mwh` DECIMAL(18,2) COMMENT 'The contracted unit price in dollars per MWh as specified in the PPA contract for this settlement period. May vary by time-of-use or seasonal schedules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this settlement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement record.. Valid values are `USD|CAD|MXN`',
    `curtailment_credit_amount` DECIMAL(18,2) COMMENT 'Financial credit or compensation in dollars for curtailed generation as specified in the PPA contract curtailment provisions.',
    `curtailment_mwh` DECIMAL(18,2) COMMENT 'Total energy curtailed during the settlement period due to grid constraints, economic dispatch, or operational requirements, measured in megawatt-hours.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this settlement is under dispute by either party.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the dispute flag is true. Null if no dispute exists.',
    `dispute_resolution_date` DATE COMMENT 'Date the dispute was resolved, if applicable. Null if dispute is unresolved or no dispute exists.',
    `gross_settlement_amount` DECIMAL(18,2) COMMENT 'Gross financial settlement amount in dollars calculated as metered generation multiplied by contracted price, before adjustments.',
    `imbalance_charge_amount` DECIMAL(18,2) COMMENT 'Financial charge or credit in dollars for deviations between scheduled and actual generation, calculated per RTO/ISO imbalance settlement rules.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued for this settlement.',
    `invoice_number` STRING COMMENT 'Invoice number issued by the renewable generator or counterparty for this settlement period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this settlement record was last modified.',
    `metered_generation_mwh` DECIMAL(18,2) COMMENT 'Total metered energy generation delivered during the settlement period, measured in megawatt-hours. Source of truth for settlement calculations.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Net financial settlement amount in dollars after all adjustments, credits, and charges. This is the final payable or receivable amount.',
    `payment_date` DATE COMMENT 'Actual date payment was made or received for this settlement.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due per the PPA contract payment terms.',
    `payment_reference_number` STRING COMMENT 'Payment transaction reference number from the financial system for traceability and reconciliation.',
    `rec_quantity_transferred` STRING COMMENT 'Number of RECs transferred to the purchasing utility as part of this settlement, typically one REC per MWh of renewable generation.',
    `rec_tracking_system_code` STRING COMMENT 'External identifier from the REC tracking system registry confirming the REC transfer transaction.',
    `rec_transfer_confirmed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether REC transfer has been confirmed in the applicable REC tracking system (e.g., WREGIS, M-RETS, NEPOOL GIS).',
    `rps_compliance_year` STRING COMMENT 'The compliance year for which this settlement and associated RECs count toward the utilitys RPS obligations.',
    `settlement_approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement was approved for invoicing and payment.',
    `settlement_calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement calculation was executed by the energy trading and risk management system.',
    `settlement_notes` STRING COMMENT 'Free-text notes or comments regarding this settlement, including special circumstances, operational issues, or contractual clarifications.',
    `settlement_number` STRING COMMENT 'Business identifier for the settlement transaction, typically used in invoicing and payment reconciliation.',
    `settlement_period_end_date` DATE COMMENT 'The last date of the settlement period for which generation and financial calculations apply.',
    `settlement_period_start_date` DATE COMMENT 'The first date of the settlement period for which generation and financial calculations apply.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement record in the settlement-to-payment workflow. [ENUM-REF-CANDIDATE: draft|calculated|invoiced|paid|disputed|adjusted|cancelled — 7 candidates stripped; promote to reference product]',
    `transmission_charge_amount` DECIMAL(18,2) COMMENT 'Transmission service charges in dollars allocated to this settlement period for delivery of renewable generation to the point of interconnection or delivery point.',
    CONSTRAINT pk_ppa_settlement PRIMARY KEY(`ppa_settlement_id`)
) COMMENT 'Monthly or periodic financial settlement record for each active renewable PPA contract. Captures settlement period, metered generation (MWh), contracted price ($/MWh), settlement amount ($), curtailment adjustments (MWh and $), imbalance charges, REC transfer confirmation, invoice reference, payment status, and dispute flags. SSOT boundary: scoped ONLY to renewable PPA settlements where REC transfer and curtailment credit calculations are integral. Wholesale market settlements and conventional contract settlements are managed in the trading domain. Cross-domain SSOT adjudication pending with global architect.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` (
    `curtailment_event_id` BIGINT COMMENT 'Unique identifier for the curtailment event record. Primary key for this product.',
    `congestion_event_id` BIGINT COMMENT 'Foreign key linking to transmission.congestion_event. Business justification: Transmission congestion is a primary cause of renewable curtailment in constrained areas. ISO/RTO dispatch instructions curtail renewable generation when transmission constraints bind. Linking curtail',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Transmission line or substation outages directly cause renewable generation curtailment when the outage isolates generation or creates post-contingency overloads requiring dispatch reduction. Linking ',
    `contingency_id` BIGINT COMMENT 'Foreign key linking to grid.contingency. Business justification: Renewable curtailments triggered by specific contingency analysis results (thermal overloads, voltage violations). Operators need traceability from curtailment instruction to triggering contingency fo',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Curtailment instructions originate from control area operators managing transmission congestion, voltage violations, and reliability constraints. Required for NERC compliance reporting and operational',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Curtailment events incur operational costs and lost revenue tracked by cost center for FERC functional classification, rate case support, and opex variance analysis in renewable operations management.',
    `der_registry_id` BIGINT COMMENT 'Reference to the distributed energy resource or renewable facility affected by this curtailment event.',
    `dispatch_instruction_id` BIGINT COMMENT 'Reference identifier for the ISO/RTO dispatch instruction or market signal that initiated the curtailment.',
    `distribution_substation_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_substation. Business justification: Curtailment events driven by substation-level capacity constraints require direct substation link for capacity planning, thermal limit tracking, and investment prioritization. Standard practice in DER',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: Curtailment events are often triggered by outages (transmission constraints, distribution faults requiring generation reduction). Operators distinguish economic curtailment from reliability-driven cur',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Curtailment events must track the specific feeder experiencing grid constraints for reliability reporting (SAIDI/SAIFI impact), hosting capacity analysis, and operational constraint management. Essent',
    `forecast_renewable_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_renewable. Business justification: Curtailment events are compared against renewable generation forecasts to assess forecast accuracy, grid constraint prediction, and curtailment risk modeling. Essential for operational and financial p',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Curtailment compliance verification requires metered output data before/during/after curtailment instruction. Curtailment compensation calculation and performance verification link event to meter read',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Curtailment events may be mandated by compliance obligations (environmental limits, reliability standards, NERC directives). Tracking the driving obligation justifies curtailment decisions and support',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Grid operators issue curtailment instructions to renewable generators during transmission constraints or oversupply conditions. Tracks responsible operator for NERC compliance, audit trails, and dispu',
    `power_plant_id` BIGINT COMMENT 'Reference to the renewable generation facility (wind farm, solar array, battery storage, hydroelectric plant) affected by this curtailment event.',
    `ppa_contract_id` BIGINT COMMENT 'FK to renewable.ppa_contract.ppa_contract_id — Curtailment events affecting PPA-contracted facilities need to reference the PPA contract for curtailment credit calculations and settlement adjustments.',
    `primary_der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — Curtailment events must reference the affected facility/DER. Essential for PPA curtailment credit calculations and lost revenue tracking.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Grid-directed curtailments of utility-scale renewable assets (wind farms, solar plants) tracked against physical assets for compensation calculations, reliability reporting, and transmission constrain',
    `scada_point_id` BIGINT COMMENT 'Foreign key linking to grid.scada_point. Business justification: Curtailment execution monitored via SCADA points for real-time compliance verification and response time measurement. Operators track actual MW reduction against instruction via SCADA telemetry for se',
    `tertiary_der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — Curtailment events reference the affected DER or facility. FK to der_registry enables curtailment impact analysis per asset.',
    `constraint_id` BIGINT COMMENT 'Identifier for the specific transmission constraint or flowgate that caused the curtailment, as defined by the ISO/RTO.',
    `actual_output_mw` DECIMAL(18,2) COMMENT 'The actual generation output in megawatts (MW) delivered during the curtailment period after reduction.',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'The generation capacity in megawatts (MW) that was available from the resource at the time of curtailment, based on weather conditions and equipment status.',
    `compliance_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this curtailment event must be included in regulatory compliance reports to FERC, state PUC, or other governing bodies.',
    `congestion_zone` STRING COMMENT 'The transmission congestion zone or pricing node (PNode) associated with the curtailment event, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this curtailment event record was first created in the system.',
    `curtailed_capacity_mw` DECIMAL(18,2) COMMENT 'The amount of generation capacity in megawatts (MW) that was curtailed or reduced during the event.',
    `curtailed_energy_mwh` DECIMAL(18,2) COMMENT 'The total energy volume in megawatt-hours (MWh) that was not generated due to the curtailment event, calculated as the difference between available and actual generation over the curtailment duration.',
    `curtailment_credit_amount_usd` DECIMAL(18,2) COMMENT 'The financial credit or compensation amount in US dollars owed to the facility owner for this curtailment event, as calculated per PPA terms.',
    `curtailment_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether this curtailment event qualifies for financial compensation or credit under the applicable PPA or regulatory framework.',
    `curtailment_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the curtailment event in minutes, calculated from start to end timestamp.',
    `curtailment_end_timestamp` TIMESTAMP COMMENT 'Date and time when the curtailment event ended and generation was restored to available capacity. Null if curtailment is still active.',
    `curtailment_event_number` STRING COMMENT 'Business-facing unique identifier or reference number for the curtailment event, used for tracking and reporting purposes.',
    `curtailment_reason_description` STRING COMMENT 'Detailed narrative explanation of the specific reason for the curtailment event, including operational context and decision rationale.',
    `curtailment_start_timestamp` TIMESTAMP COMMENT 'Date and time when the curtailment event began and generation output was reduced below available capacity.',
    `curtailment_status` STRING COMMENT 'Current lifecycle status of the curtailment event: initiated (instruction issued), active (curtailment in effect), restored (generation resumed), cancelled (instruction withdrawn), or expired (time limit reached).. Valid values are `initiated|active|restored|cancelled|expired`',
    `curtailment_type` STRING COMMENT 'Classification of the curtailment reason: economic (negative pricing, market conditions), reliability (grid stability), transmission constraint (congestion), regulatory (compliance mandate), environmental (permit limits), or operational (equipment limitation).. Valid values are `economic|reliability|transmission_constraint|regulatory|environmental|operational`',
    `data_source_system` STRING COMMENT 'The operational system of record that originated this curtailment event data (e.g., DERMS, ADMS, SCADA, EMS).',
    `estimated_lost_revenue_usd` DECIMAL(18,2) COMMENT 'The estimated financial impact in US dollars of the curtailed energy, calculated using applicable market prices or PPA rates at the time of curtailment.',
    `forecast_accuracy_variance_pct` DECIMAL(18,2) COMMENT 'The percentage variance between forecasted and actual available generation capacity at the time of curtailment, used for forecast model improvement.',
    `grid_constraint_type` STRING COMMENT 'The specific grid constraint or limitation that triggered the curtailment: transmission congestion, voltage limit, frequency deviation, thermal overload, stability limit, or none if not constraint-driven.. Valid values are `transmission_congestion|voltage_limit|frequency_deviation|thermal_overload|stability_limit|none`',
    `instruction_source` STRING COMMENT 'Origin of the curtailment instruction: ISO/RTO dispatch, ADMS (Advanced Distribution Management System), DERMS (Distributed Energy Resource Management System), manual operator, market signal, or automatic control system.. Valid values are `iso_rto|adms|derms|operator|market|automatic`',
    `instruction_timestamp` TIMESTAMP COMMENT 'Date and time when the curtailment instruction was issued to the facility or DER operator.',
    `iso_rto_code` STRING COMMENT 'The ISO or RTO jurisdiction under which this curtailment event occurred: CAISO, ERCOT, MISO, PJM, SPP, NYISO, ISO-NE, or OTHER. [ENUM-REF-CANDIDATE: CAISO|ERCOT|MISO|PJM|SPP|NYISO|ISONE|OTHER — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this curtailment event record was last updated or modified.',
    `market_price_per_mwh` DECIMAL(18,2) COMMENT 'The locational marginal price (LMP) or applicable market price per megawatt-hour at the time and location of the curtailment event.',
    `notification_lead_time_minutes` STRING COMMENT 'The number of minutes of advance notice provided to the facility operator before curtailment execution.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether advance notification was sent to the facility operator or DER owner prior to curtailment execution.',
    `post_event_review_completed_flag` BOOLEAN COMMENT 'Indicates whether a post-event operational review has been completed to analyze the curtailment decision and outcomes.',
    `ppa_rate_per_mwh` DECIMAL(18,2) COMMENT 'The contracted power purchase agreement rate per megawatt-hour applicable to this facility, used for curtailment credit calculations.',
    `rec_adjustment_mwh` DECIMAL(18,2) COMMENT 'The adjustment in megawatt-hours to REC generation accounting due to this curtailment event, if applicable.',
    `rec_impact_flag` BOOLEAN COMMENT 'Indicates whether this curtailment event impacts the generation and issuance of renewable energy certificates (RECs) for the affected facility.',
    `restoration_timestamp` TIMESTAMP COMMENT 'Date and time when full generation capacity was confirmed restored following the curtailment event.',
    `review_findings` STRING COMMENT 'Summary of findings from the post-event review, including lessons learned and recommended process improvements.',
    `rps_compliance_impact_flag` BOOLEAN COMMENT 'Indicates whether this curtailment event affects the utilitys renewable portfolio standard compliance calculations or reporting obligations.',
    `weather_condition` STRING COMMENT 'Description of the weather conditions at the time of curtailment (e.g., high wind, peak solar irradiance, low hydro flow) that influenced available capacity.',
    CONSTRAINT pk_curtailment_event PRIMARY KEY(`curtailment_event_id`)
) COMMENT 'Record of each renewable generation curtailment event where a facility or DER output is intentionally reduced below available capacity. Captures curtailment start/end timestamp, affected DER or facility reference, curtailment type (economic, reliability, transmission constraint, regulatory), instruction source (ISO/RTO, ADMS, operator), curtailed energy volume (MWh), estimated lost revenue ($), associated grid constraint or congestion zone, and restoration timestamp. SSOT for renewable curtailment tracking within this domain. Supports FERC compliance reporting, PPA curtailment credit calculations, REC generation impact analysis, and grid operations post-event review.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`nem_account` (
    `nem_account_id` BIGINT COMMENT 'Unique identifier for the NEM account record. Primary key for the NEM account entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account enrolled in the NEM program. Links to the billing customer account master.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: NEM accounts reference utility-owned interconnection equipment (service transformers, meter sockets, service panel upgrades) capitalized by the utility. Links NEM program costs to rate base assets for',
    `meter_id` BIGINT COMMENT 'Reference to the AMI (Advanced Metering Infrastructure) meter measuring bidirectional energy flow for the NEM account. Links to the meter registry for interval data and device metadata.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Net Energy Metering (NEM) accounts are for behind-the-meter (BTM) DERs that must be registered in the DER registry. This FK links the NEM billing/credit account to the registered DER asset. Cardinalit',
    `premise_id` BIGINT COMMENT 'Reference to the physical service location where the BTM generation system is installed. Links to the premise master for geographic and service point data.',
    `primary_der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — NEM accounts are tied to specific BTM DER installations. The NEM account must reference the DER registry entry for the BTM system generating the credits.',
    `annual_true_up_date` DATE COMMENT 'Anniversary date when cumulative NEM credits are reconciled. Any remaining credit balance may be paid out, rolled over, or forfeited based on program rules.',
    `battery_storage_capacity_kwh` DECIMAL(18,2) COMMENT 'Total energy storage capacity of paired battery system in kilowatt-hours. Null if no battery is installed. Used for SGIP (Self-Generation Incentive Program) eligibility and VPP dispatch.',
    `billing_period_end_date` DATE COMMENT 'End date of the current NEM billing period. Marks the cutoff for credit calculation and ledger posting.',
    `billing_period_start_date` DATE COMMENT 'Start date of the current NEM billing period for which credit transactions are recorded. Aligns with the customer billing cycle.',
    `btm_system_type` STRING COMMENT 'Type of distributed energy resource installed behind the customer meter. Identifies the generation technology for capacity planning and forecasting.. Valid values are `solar_pv|solar_battery|wind|fuel_cell|chp|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NEM account record was first created in the system. Used for audit trail and data lineage.',
    `credit_expiry_date` DATE COMMENT 'Date on which unused NEM credits expire if not applied or paid out. Typically aligns with the annual true-up date for programs with credit expiration policies.',
    `cumulative_credit_balance` DECIMAL(18,2) COMMENT 'Running total of NEM credits available to offset future charges. Accumulates across billing periods until the annual true-up date.',
    `enrollment_date` DATE COMMENT 'Date the customer was officially enrolled in the NEM program and began receiving export credits. Marks the start of the NEM billing cycle.',
    `export_credit_value` DECIMAL(18,2) COMMENT 'Dollar value of NEM credits earned during the billing period, calculated as net_export_kwh multiplied by export_rate_per_kwh. Posted to the cumulative credit balance.',
    `export_limit_kw` DECIMAL(18,2) COMMENT 'Maximum instantaneous power export allowed to the grid in kilowatts. May be lower than installed capacity due to interconnection constraints or grid hosting capacity limits.',
    `export_rate_per_kwh` DECIMAL(18,2) COMMENT 'Compensation rate in dollars per kWh for energy exported to the grid. Rate varies by NEM program type and may differ from retail rate. Used to calculate export credit value.',
    `gross_consumption_kwh` DECIMAL(18,2) COMMENT 'Total energy consumed by the customer from the grid during the billing period, measured in kilowatt-hours. Does not net out BTM generation.',
    `gross_generation_kwh` DECIMAL(18,2) COMMENT 'Total energy generated by the BTM system during the billing period, measured in kilowatt-hours. Includes both self-consumed and exported energy.',
    `installation_date` DATE COMMENT 'Date the BTM generation system was physically installed and commissioned. Used for warranty tracking and depreciation calculations.',
    `installed_capacity_kw` DECIMAL(18,2) COMMENT 'Nameplate capacity of the BTM generation system in kilowatts. Used for interconnection limits, export calculations, and grid impact analysis.',
    `installer_company_name` STRING COMMENT 'Name of the contractor or company that installed the BTM generation system. Used for quality assurance and warranty claims.',
    `installer_license_number` STRING COMMENT 'State-issued contractor license number for the installer. Verifies that installation was performed by a certified professional.. Valid values are `^[A-Z0-9]{6,20}$`',
    `interconnection_application_number` STRING COMMENT 'Unique application number assigned during the DER interconnection approval process. Tracks the regulatory approval for BTM generation interconnection to the utility grid.. Valid values are `^[A-Z0-9]{8,20}$`',
    `inverter_manufacturer` STRING COMMENT 'Name of the company that manufactured the inverter. Used for equipment certification verification and technical support.',
    `inverter_model` STRING COMMENT 'Model number of the inverter installed. Used to verify compliance with interconnection standards and grid support functions.',
    `inverter_serial_number` STRING COMMENT 'Manufacturer serial number of the primary inverter converting DC generation to AC for grid export. Used for equipment tracking, warranty claims, and performance monitoring.. Valid values are `^[A-Z0-9]{10,30}$`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent utility or third-party inspection of the BTM system. Used to verify ongoing compliance with safety and interconnection standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the NEM account record. Used for change tracking and audit compliance.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified the record. Used for audit trail and accountability.',
    `nem_program_type` STRING COMMENT 'Specific NEM tariff program under which the customer is enrolled. Determines export credit rates, true-up rules, and credit expiration policies. NEM 1.0 offers full retail rate credits; NEM 2.0 includes non-bypassable charges; NEM 3.0/NEM-A uses export compensation rates below retail.. Valid values are `nem_1_0|nem_2_0|nem_3_0|nema|vnem|aggregated_nem`',
    `net_export_kwh` DECIMAL(18,2) COMMENT 'Net energy exported to the grid during the billing period after self-consumption. Positive value indicates surplus generation sent to the grid. Basis for export credit calculation.',
    `net_import_kwh` DECIMAL(18,2) COMMENT 'Net energy imported from the grid during the billing period after accounting for BTM generation. Positive value indicates net consumption from the grid.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the BTM system. Used for compliance tracking and maintenance planning.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, or exceptions related to the NEM account. Used by customer service and billing operations.',
    `permission_to_operate_date` DATE COMMENT 'Date the utility granted permission for the BTM system to operate and export to the grid. Marks the official start of interconnection and may differ from enrollment date.',
    `program_status` STRING COMMENT 'Current lifecycle status of the NEM account. Active accounts receive export credits; suspended accounts are temporarily paused; terminated accounts are closed.. Valid values are `active|suspended|terminated|pending_approval|inactive`',
    `rec_eligible_flag` BOOLEAN COMMENT 'Indicates whether generation from this NEM account is eligible for REC issuance. True if the system meets RPS (Renewable Portfolio Standard) eligibility criteria.',
    `termination_date` DATE COMMENT 'Date the NEM account was closed or terminated. Null for active accounts. Marks the end of credit accrual and triggers final true-up processing.',
    `termination_reason` STRING COMMENT 'Reason code for NEM account termination. Used for program analytics and customer retention analysis.. Valid values are `customer_request|system_removal|non_compliance|account_closure|relocation`',
    `true_up_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of credit adjustment applied during the annual true-up reconciliation. May represent payout, rollover, or forfeiture of remaining credits based on program rules.',
    `vpp_participation_flag` BOOLEAN COMMENT 'Indicates whether this NEM account is enrolled in a VPP aggregation program for demand response or grid services. True if the customer has opted into VPP dispatch.',
    CONSTRAINT pk_nem_account PRIMARY KEY(`nem_account_id`)
) COMMENT 'Net Energy Metering (NEM) account master record and full credit transaction ledger for customers with Behind-the-Meter (BTM) generation. Captures customer account reference, interconnection application number, BTM system type (solar PV, battery+solar, wind), installed capacity (kW), NEM program type (NEM 1.0, NEM 2.0, NEM 3.0/NEM-A), enrollment date, export rate ($/kWh), annual true-up date, and program status. Includes all billing-period credit transactions: gross consumption/generation (kWh), net import/export (kWh), export credit value ($), cumulative credit balance ($), true-up adjustments, and credit expiry dates. SSOT for NEM program enrollment, credit ledger, and annual true-up processing — no separate credit transaction product exists. Credit summaries feed into the billing domain for invoice generation.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` (
    `interconnection_queue_id` BIGINT COMMENT 'Primary key for interconnection_queue',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Interconnection queue applications track applicant customer account for study deposits, cost allocation, communications, and eventual service agreement creation upon project completion. Essential for ',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Queue projects that proceed to construction become capex projects; link tracks progression from interconnection application to capital investment for IRP alignment, budget forecasting, and CPCN regula',
    `cpcn_application_id` BIGINT COMMENT 'Foreign key linking to compliance.cpcn_application. Business justification: Large generation projects in interconnection queue typically require Certificate of Public Convenience and Necessity. Links project development pipeline to regulatory approval process. Standard workfl',
    `distribution_substation_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_substation. Business justification: Interconnection queue entries specify point-of-interconnection substation for system impact studies, hosting capacity analysis, and queue management. Critical for FERC/state interconnection process co',
    `irp_scenario_id` BIGINT COMMENT 'Foreign key linking to forecast.irp_scenario. Business justification: IRP scenarios model future capacity additions from the interconnection queue to assess resource adequacy, planning reserve margins, and renewable penetration pathways. Core IRP modeling input.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Interconnection queue entries link to utility network upgrade assets (substation expansions, line upgrades, protection equipment) funded by generators for cost reconciliation and rate base inclusion. ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Interconnection projects require network upgrade materials (transformers, switchgear, cables, protection equipment) for cost estimation and procurement planning. Real business process: capital project',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Interconnection applications require utility engineers to conduct feasibility studies, system impact studies, and facilities studies per FERC Order 2023. Tracks assigned engineer for workload manageme',
    `transmission_service_request_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_service_request. Business justification: Large renewable projects requiring network upgrades or long-haul delivery often file transmission service requests under FERC OATT alongside interconnection applications. ISO/RTO interconnection proce',
    `affected_systems_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether the interconnection requires coordination with adjacent transmission systems or neighboring utilities due to potential impacts on their facilities.',
    `applicant_contact_email` STRING COMMENT 'Primary email address for the applicant or project developer for interconnection study communications and milestone notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_contact_phone` STRING COMMENT 'Primary phone number for the applicant or project developer for interconnection coordination and study discussions.',
    `applicant_name` STRING COMMENT 'Legal name of the entity or developer submitting the interconnection request for the renewable generation or storage project.',
    `application_number` STRING COMMENT 'External business identifier for the interconnection request assigned by the utility or ISO/RTO. Used in regulatory filings and customer communications.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `application_received_date` DATE COMMENT 'Date the interconnection application was received and accepted by the utility or ISO/RTO, establishing the queue position and study timeline.',
    `cluster_study_group` STRING COMMENT 'Identifier for the cluster study group if this application is being studied as part of a batch of interconnection requests in the same geographic area or queue window.',
    `commercial_readiness_deposit_received_flag` BOOLEAN COMMENT 'Indicates whether the applicant has posted the commercial readiness deposit or financial security required under FERC Order 2023 to demonstrate project viability and reduce speculative queue entries.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the country where the proposed facility will be located. Primarily USA, CAN (Canada), or MEX (Mexico) for North American interconnection queues.. Valid values are `USA|CAN|MEX`',
    `county` STRING COMMENT 'County where the proposed renewable generation or storage facility will be located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interconnection queue record was first created in the system.',
    `environmental_permit_status` STRING COMMENT 'Status of environmental permitting for the renewable project, including federal and state environmental reviews, endangered species assessments, and wetlands permits.. Valid values are `not_started|in_progress|approved|denied`',
    `expected_commercial_operation_date` DATE COMMENT 'Target date for the renewable facility to achieve commercial operation and begin energy delivery, as declared by the applicant.',
    `facilities_study_completion_date` DATE COMMENT 'Date the facilities study was completed and results delivered to the applicant. Null if study is in progress or not started.',
    `facilities_study_start_date` DATE COMMENT 'Date the facilities study phase commenced. Null if study has not yet started.',
    `feasibility_study_completion_date` DATE COMMENT 'Date the feasibility study was completed and results delivered to the applicant. Null if study is in progress or not started.',
    `feasibility_study_start_date` DATE COMMENT 'Date the feasibility study phase commenced. Null if study has not yet started.',
    `ferc_oatt_compliance_flag` BOOLEAN COMMENT 'Indicates whether the interconnection request is being processed under FERC OATT pro forma procedures for wholesale generation interconnection. True for bulk/wholesale projects; False for retail/distribution interconnections.',
    `generation_capacity_mw` DECIMAL(18,2) COMMENT 'Requested nameplate generation capacity of the renewable facility in megawatts. For hybrid projects, represents the generation component only.',
    `interconnection_agreement_executed_date` DATE COMMENT 'Date the final interconnection agreement was executed between the applicant and the utility or ISO/RTO. Null if agreement not yet signed.',
    `interconnection_facilities_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost in dollars for direct interconnection facilities such as gen-tie lines, transformers, and switchgear required to connect the facility to the POI.',
    `interconnection_service_type` STRING COMMENT 'Type of interconnection service requested under FERC OATT. Energy Resource allows injection but no delivery guarantee; Network Resource includes firm transmission rights.. Valid values are `energy_resource|network_resource`',
    `iso_rto_jurisdiction` STRING COMMENT 'Name of the ISO or RTO managing the interconnection queue if the project is in an organized wholesale market region (e.g., CAISO, PJM, MISO, ERCOT, NYISO, ISO-NE, SPP). Null for non-ISO utility territories.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interconnection queue record was last updated, reflecting changes to study phase, status, or milestone dates.',
    `network_upgrade_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost in dollars for required transmission network upgrades to accommodate the interconnection, as determined by system impact and facilities studies.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or coordination notes related to the interconnection request and study process.',
    `poi_voltage_kv` DECIMAL(18,2) COMMENT 'Transmission or distribution voltage level in kilovolts at the proposed point of interconnection. Determines study complexity and upgrade requirements.',
    `project_name` STRING COMMENT 'Business name or designation of the proposed renewable generation or storage facility as provided by the applicant.',
    `project_type` STRING COMMENT 'Classification of the renewable generation or storage technology proposed for interconnection. Hybrid projects combine generation and storage at the same POI. [ENUM-REF-CANDIDATE: solar|wind|battery_storage|hybrid_solar_storage|hybrid_wind_storage|hydroelectric|other_renewable — 7 candidates stripped; promote to reference product]',
    `queue_position` STRING COMMENT 'Sequential position in the interconnection queue determining study priority and processing order. Lower numbers indicate earlier queue entry and higher priority.',
    `queue_status` STRING COMMENT 'Current lifecycle status of the interconnection queue entry. Active indicates ongoing study; Withdrawn indicates applicant termination; Approved indicates studies complete and agreement executed; In Service indicates facility is operational.. Valid values are `active|suspended|withdrawn|approved|in_service`',
    `site_control_documentation_received_flag` BOOLEAN COMMENT 'Indicates whether the applicant has provided evidence of site control (land lease, purchase option, or ownership) as required for interconnection study progression under FERC Order 2023 reforms.',
    `state` STRING COMMENT 'State or province where the proposed renewable generation or storage facility will be located.',
    `storage_capacity_mw` DECIMAL(18,2) COMMENT 'Requested nameplate storage discharge capacity in megawatts for battery storage or hybrid projects. Null for generation-only projects.',
    `storage_duration_hours` DECIMAL(18,2) COMMENT 'Energy storage duration in hours at rated discharge capacity. Represents the time the battery can discharge at full power. Null for generation-only projects.',
    `study_deposit_amount` DECIMAL(18,2) COMMENT 'Total deposit amount paid by the applicant to fund interconnection studies. Typically covers feasibility, system impact, and facilities study costs.',
    `study_phase` STRING COMMENT 'Current phase of the interconnection study process. Feasibility assesses viability, System Impact evaluates grid impacts, Facilities designs required upgrades.. Valid values are `feasibility|system_impact|facilities|completed|withdrawn`',
    `system_impact_study_completion_date` DATE COMMENT 'Date the system impact study was completed and results delivered to the applicant. Null if study is in progress or not started.',
    `system_impact_study_start_date` DATE COMMENT 'Date the system impact study phase commenced. Null if study has not yet started.',
    `withdrawal_date` DATE COMMENT 'Date the applicant withdrew the interconnection request from the queue. Null if application remains active or was approved.',
    `withdrawal_reason` STRING COMMENT 'Business reason provided by the applicant for withdrawing the interconnection request, such as project economics, permitting issues, or site constraints.',
    CONSTRAINT pk_interconnection_queue PRIMARY KEY(`interconnection_queue_id`)
) COMMENT 'Queue management record for utility-scale and large renewable generation/storage interconnection requests submitted to the utility or ISO/RTO under FERC OATT. Captures queue position, applicant, project type (solar, wind, storage, hybrid), requested capacity (MW), proposed POI substation, study phase (feasibility, system impact, facilities), study fees, milestone dates, cluster study group, FERC OATT compliance status, and queue withdrawal/approval status. SSOT boundary: scoped ONLY to bulk/wholesale renewable generation interconnection queue entries managed as part of the renewable procurement pipeline. Customer-level BTM interconnection applications (residential solar, EV chargers, small DER) are managed in the interconnection domain. Cross-domain SSOT adjudication pending with global architect.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` (
    `vpp_configuration_id` BIGINT COMMENT 'Unique identifier for the Virtual Power Plant configuration record. Primary key.',
    `aggregator_id` BIGINT COMMENT 'FK to demand.aggregator',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: VPPs participate in control area AGC, regulation reserves, and ancillary services markets. Control area operators dispatch VPPs for frequency regulation and must track aggregated capacity for reserve ',
    `der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — VPP configurations aggregate multiple DERs. The VPP must reference participating DERs from the registry. This is a many-to-many relationship critical for VPP dispatch and settlement.',
    `program_id` BIGINT COMMENT 'Reference identifier linking this VPP configuration to the controlling DERMS program or platform that orchestrates dispatch commands and monitors DER performance.',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the primary distribution substation or point of interconnection (POI) serving the majority of DERs in this VPP aggregation.',
    `feeder_id` BIGINT COMMENT 'Identifier of the primary distribution feeder circuit serving the majority of DERs in this VPP aggregation. Used for distribution-level constraint management.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: VPP programs must comply with ISO/RTO market rules, FERC Orders 841/2222, state DER regulations. Tracks which compliance obligation governs each VPP configuration. Essential for market participation a',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: VPP programs operate as distinct business units with revenue (capacity payments, energy sales) and costs (incentives, operations); link enables P&L reporting by program for regulatory filings and mana',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Virtual power plant programs require designated program managers for aggregator coordination, ISO/RTO market registration, performance monitoring, and settlement reconciliation. Essential for operatio',
    `meter_id` BIGINT COMMENT 'Identifier of the revenue-quality meter or virtual meter used for settlement and billing of VPP dispatch performance in ISO/RTO markets.',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: VPPs are dispatched during outages for grid support (black start, islanding, load restoration). Outage management coordinates with DERMS to activate VPP resources during major events. Required for mut',
    `activation_window_end_time` TIMESTAMP COMMENT 'Daily time-of-day (HH:MM format) when the VPP is no longer eligible for dispatch. Supports time-of-use constraints and operational availability windows.',
    `activation_window_start_time` TIMESTAMP COMMENT 'Daily time-of-day (HH:MM format) when the VPP becomes eligible for dispatch. Supports time-of-use constraints and operational availability windows.',
    `aggregation_type` STRING COMMENT 'Classification of the VPP aggregation strategy: demand response (load reduction), storage dispatch (battery discharge/charge), solar curtailment (PV output reduction), wind curtailment, load shifting, or mixed DER (combination of multiple resource types).. Valid values are `demand_response|storage_dispatch|solar_curtailment|mixed_der|wind_curtailment|load_shifting`',
    `average_performance_score` DECIMAL(18,2) COMMENT 'Rolling average performance score (0-100 scale) across all dispatch events, calculated as the ratio of actual delivered capacity to requested capacity. Used for aggregator performance evaluation.',
    `baseline_calculation_method` STRING COMMENT 'Methodology used to establish the counterfactual baseline for measuring VPP dispatch performance: customer baseline load (CBL), day-ahead forecast, historical average, or control group comparison.. Valid values are `customer_baseline_load|day_ahead_forecast|historical_average|control_group`',
    `capacity_payment_rate_per_mw_month` DECIMAL(18,2) COMMENT 'Monthly capacity payment rate in dollars per MW for maintaining the VPP in a dispatchable state, independent of actual dispatch events.',
    `communication_latency_ms` STRING COMMENT 'Maximum acceptable communication latency in milliseconds between the DERMS platform and participating DER assets for dispatch signal transmission and acknowledgment. Critical for fast-response ancillary services.',
    `compliance_certification_date` DATE COMMENT 'Date on which the VPP configuration received compliance certification from the applicable ISO/RTO or Public Utility Commission (PUC) for market participation.',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the VPP aggregation contract or program enrollment period. Null for open-ended contracts.',
    `contract_start_date` DATE COMMENT 'Effective start date of the VPP aggregation contract or program enrollment period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VPP configuration record was first created in the system.',
    `dispatch_protocol` STRING COMMENT 'Method by which dispatch commands are issued to the VPP: automated (DERMS-driven without human intervention), manual (operator-initiated), semi-automated (operator approval required), or api_driven (external system integration).. Valid values are `automated|manual|semi_automated|api_driven`',
    `geographic_zone` STRING COMMENT 'ISO/RTO pricing zone, load zone, or distribution service territory in which the VPP operates. Used for locational marginal pricing (LMP) and congestion management.',
    `incentive_rate_per_mwh` DECIMAL(18,2) COMMENT 'Financial incentive rate in dollars per MWh paid to the VPP for successful dispatch performance and energy delivery.',
    `iso_rto_market_code` STRING COMMENT 'Unique market participant identifier assigned by the ISO/RTO for this VPP in wholesale energy, capacity, or ancillary services markets.',
    `iso_rto_registration_status` STRING COMMENT 'Registration status of the VPP with the applicable ISO or RTO for wholesale market participation: registered (approved and active), pending (application submitted), not registered (no application), expired (registration lapsed), or rejected (application denied).. Valid values are `registered|pending|not_registered|expired|rejected`',
    `last_dispatch_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent dispatch event issued to this VPP. Used for operational monitoring and performance tracking.',
    `maximum_dispatch_duration_minutes` STRING COMMENT 'Maximum duration in minutes that a single dispatch event can be sustained before requiring a rest period or recharge cycle (relevant for battery storage VPPs).',
    `minimum_dispatch_duration_minutes` STRING COMMENT 'Minimum duration in minutes that a dispatch event must be sustained once activated. Ensures operational stability and prevents rapid cycling of DER assets.',
    `minimum_performance_threshold_percent` DECIMAL(18,2) COMMENT 'Minimum percentage of requested dispatch capacity that must be delivered for the event to qualify for settlement payment. Typical values range from 70% to 90%.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VPP configuration record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or configuration comments related to this VPP aggregation.',
    `participating_der_count` STRING COMMENT 'Number of individual DER assets (solar arrays, battery storage units, demand response participants, etc.) currently enrolled and participating in this VPP aggregation.',
    `penalty_rate_per_mwh` DECIMAL(18,2) COMMENT 'Financial penalty rate in dollars per MWh applied when the VPP fails to meet minimum performance thresholds during a dispatch event.',
    `performance_measurement_interval_minutes` STRING COMMENT 'Time interval in minutes over which VPP dispatch performance is measured and aggregated for settlement purposes (e.g., 5-minute, 15-minute, or hourly intervals).',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'Rate at which the VPP can increase or decrease its aggregated output in megawatts per minute. Critical for frequency regulation and ramping services.',
    `regulatory_program_name` STRING COMMENT 'Name of the state or federal regulatory program under which the VPP operates (e.g., California DRAM, NYISO DER Participation Model, PJM DER Aggregation).',
    `telemetry_interval_seconds` STRING COMMENT 'Frequency in seconds at which telemetry data is transmitted from participating DERs to the DERMS platform during active dispatch events.',
    `telemetry_reporting_enabled` BOOLEAN COMMENT 'Indicates whether real-time telemetry data (voltage, frequency, power output) from participating DERs is transmitted to the ISO/RTO or utility control center during dispatch events.',
    `total_aggregated_capacity_mw` DECIMAL(18,2) COMMENT 'Total nameplate capacity in megawatts (MW) of all Distributed Energy Resources (DERs) aggregated within this VPP portfolio. Represents the maximum dispatchable capacity under ideal conditions.',
    `total_dispatch_events_count` STRING COMMENT 'Cumulative count of all dispatch events issued to this VPP since configuration inception. Used for performance analytics and settlement auditing.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class in kilovolts (kV) of the distribution system at which the VPP DERs are interconnected (e.g., 12.47 kV, 34.5 kV).',
    `vpp_code` STRING COMMENT 'Unique business identifier or registration code for the VPP used in ISO/RTO market systems and DERMS platforms.',
    `vpp_name` STRING COMMENT 'Business name or designation of the Virtual Power Plant aggregation portfolio.',
    `vpp_status` STRING COMMENT 'Current operational lifecycle status of the VPP configuration: active (operational and dispatchable), inactive (configured but not operational), suspended (temporarily disabled), pending approval (awaiting ISO/RTO or regulatory approval), decommissioned (retired), or testing (pilot phase).. Valid values are `active|inactive|suspended|pending_approval|decommissioned|testing`',
    CONSTRAINT pk_vpp_configuration PRIMARY KEY(`vpp_configuration_id`)
) COMMENT 'Virtual Power Plant (VPP) master record defining DER aggregation into a dispatchable virtual fleet, including complete dispatch event history. Captures VPP name, aggregation type (demand response, storage dispatch, solar curtailment), total aggregated capacity (MW), participating DER count, ISO/RTO registration status, DERMS program reference, dispatch protocol (automated/manual), communication latency requirements, and activation eligibility windows. Includes all dispatch event records: timestamp, dispatch trigger (ISO/RTO signal, operator command, automated rule), requested MW, actual MW response, response time, participating DER count, dispatch success rate, settlement-eligible energy (MWh), and performance score. SSOT for VPP portfolio management AND dispatch performance — no separate dispatch event product exists. Supports FERC Order 2222 market participation and settlement.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` (
    `battery_storage_asset_id` BIGINT COMMENT 'Unique identifier for the battery energy storage system (BESS) asset. Primary key for the battery storage asset master record.',
    `asset_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.asset_risk_assessment. Business justification: Battery storage risk assessment covers technology risk (degradation faster than expected), market risk (revenue sufficiency in evolving markets), safety risk (thermal events), and stranded asset risk ',
    `battery_der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Battery energy storage systems (BESS) are Distributed Energy Resources and must be registered in the DER registry. This FK establishes the authoritative link between the asset master record and its DE',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Storage assets provide regulation and frequency response within specific control areas. Control area operators dispatch storage for AGC participation, primary frequency response, and must account for ',
    `depreciation_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.depreciation_schedule. Business justification: Battery storage has unique depreciation profiles (faster degradation, potential mid-life augmentation, cycle-based useful life). Separate depreciation tracking required for rate base treatment, tax op',
    `der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — Battery storage assets should be registered in the DER registry. This link connects the detailed storage asset record to its DER registration.',
    `dr_program_id` BIGINT COMMENT 'Foreign key linking to demand.dr_program. Business justification: Battery storage assets participate in demand response programs as dispatchable resources for grid services (frequency regulation, peak shaving). ISO/RTO markets and utility DR programs enroll storage ',
    `ems_node_id` BIGINT COMMENT 'Foreign key linking to grid.ems_node. Business justification: Storage assets represented as EMS nodes for real-time dispatch, state estimation, and power flow modeling. Grid operators require EMS node representation for accurate network analysis, voltage control',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_permit. Business justification: Storage facilities require environmental permits (fire safety, hazardous materials, stormwater management). Tracks permit compliance for each storage asset. Standard practice for facility permitting a',
    `failure_event_id` BIGINT COMMENT 'Foreign key linking to asset.failure_event. Business justification: Battery failures (cell failures, thermal events, BMS faults, inverter trips) tracked for safety reporting, warranty claims, and reliability analysis. High-consequence thermal events require NERC repor',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Storage assets are capitalized fixed assets requiring FERC account classification, depreciation calculation, RAB inclusion, and rate base treatment; fundamental link for utility asset accounting and r',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Battery storage assets are located within forecast zones for capacity planning, resource adequacy modeling, and dispatch optimization. Required for integrating storage into load and generation forecas',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to asset.asset_inspection. Business justification: Regular inspections for battery safety (thermal runaway risk, fire suppression systems), performance (capacity fade, round-trip efficiency), and regulatory compliance (fire code, electrical code, NFPA',
    `application_id` BIGINT COMMENT 'Foreign key linking to interconnection.application. Business justification: Asset management and warranty tracking require linking operational battery storage assets back to their originating interconnection application for technical specifications, approval conditions, and c',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to asset.maintenance_plan. Business justification: Scheduled maintenance plans for battery systems (quarterly inspections, annual capacity tests, thermal system checks, BMS software updates). Required by manufacturers for warranty validity and by ISOs',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Battery storage assets require certified technicians for preventive maintenance, thermal management system checks, and degradation monitoring. Tracks responsible technician for warranty compliance, sa',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Battery storage systems are capital equipment with material master records for procurement, maintenance parts inventory, and lifecycle management. Real business process: capital asset procurement, O&M',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: Grid-connected storage assets meeting BES criteria must be tracked for NERC CIP cyber security compliance. Links operational asset registry to CIP compliance tracking. Required for critical infrastruc',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the renewable generation asset (solar, wind) with which this battery storage system is co-located, if applicable. Null if standalone storage.',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: Battery storage assets are aggregated into VPP portfolios for coordinated dispatch to wholesale markets and grid services. VPP configuration defines dispatch protocols, telemetry requirements, and set',
    `warranty_id` BIGINT COMMENT 'Foreign key linking to asset.asset_warranty. Business justification: Battery warranties are complex (capacity guarantees, cycle limits, throughput warranties, degradation curves). Separate tracking required for performance-based warranty claims and lifecycle cost model',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Battery storage systems require frequent maintenance work orders (thermal management, BMS updates, cell balancing, capacity testing). Tracks O&M costs, warranty service, and performance guarantee comp',
    `annual_om_cost_usd` DECIMAL(18,2) COMMENT 'Estimated annual operations and maintenance (O&M) cost for the battery storage system, measured in US dollars. Includes routine maintenance, monitoring, and performance optimization.',
    `asset_name` STRING COMMENT 'Human-readable name or designation of the battery storage facility (e.g., Riverside Solar + Storage, Downtown Grid Battery).',
    `asset_tag` STRING COMMENT 'Externally-visible unique asset tag or serial number assigned to the battery storage system for field identification and maintenance tracking.. Valid values are `^BESS-[A-Z0-9]{8,12}$`',
    `capital_cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure (CAPEX) for the battery storage system acquisition and installation, measured in US dollars. Includes equipment, installation, and interconnection costs.',
    `charge_ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'Maximum rate at which the battery storage system can increase its charging power, measured in megawatts per minute. Critical for grid frequency regulation and ancillary services.',
    `co_location_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the battery storage system is co-located with a renewable generation asset (e.g., solar array, wind farm) for integrated dispatch and energy arbitrage.',
    `commissioning_date` DATE COMMENT 'Date when the battery storage system was officially commissioned and placed into commercial operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this battery storage asset record was first created in the system. Audit trail for data lineage and compliance.',
    `current_soc_percent` DECIMAL(18,2) COMMENT 'Current real-time state of charge (SoC) percentage of the battery storage system. Updated continuously from SCADA or BMS integration.',
    `cycle_count` STRING COMMENT 'Total number of charge-discharge cycles the battery storage system has completed since commissioning. Key metric for tracking battery degradation and remaining useful life.',
    `degradation_rate_percent_per_year` DECIMAL(18,2) COMMENT 'Annual capacity degradation rate of the battery storage system expressed as a percentage per year. Used for forecasting remaining useful life and replacement planning.',
    `derms_integration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the battery storage system is integrated with the utility Distributed Energy Resource Management System (DERMS) for centralized dispatch and control.',
    `discharge_ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'Maximum rate at which the battery storage system can increase its discharge power, measured in megawatts per minute. Critical for grid frequency regulation and ancillary services.',
    `expected_end_of_life_date` DATE COMMENT 'Projected date when the battery storage system will reach end of useful life based on degradation rate, cycle count, and manufacturer specifications. Used for asset retirement planning.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the battery storage system installation site in decimal degrees. Used for GIS mapping and outage analysis.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the battery storage system installation site in decimal degrees. Used for GIS mapping and outage analysis.',
    `interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level at which the battery storage system interconnects to the electric grid, measured in kilovolts (kV). Determines transmission vs distribution classification.',
    `iso_rto_market_participant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the battery storage asset is registered and actively participating in ISO/RTO wholesale energy and ancillary services markets.',
    `iso_rto_registration_code` STRING COMMENT 'Unique registration identifier assigned by the Independent System Operator (ISO) or Regional Transmission Organization (RTO) for market participation and dispatch scheduling.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or unscheduled maintenance activity performed on the battery storage system.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this battery storage asset record was last modified. Audit trail for data lineage and compliance.',
    `max_soc_percent` DECIMAL(18,2) COMMENT 'Maximum allowable state of charge (SoC) percentage for the battery system to prevent overcharging and preserve battery health. Operational upper limit.',
    `min_soc_percent` DECIMAL(18,2) COMMENT 'Minimum allowable state of charge (SoC) percentage for the battery system to prevent deep discharge and preserve battery health. Operational lower limit.',
    `nerc_region` STRING COMMENT 'North American Electric Reliability Corporation (NERC) regional entity jurisdiction where the battery storage asset operates (WECC, ERCOT, MRO, NPCC, RF, SERC, SPP, TRE). [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|SPP|TRE — 8 candidates stripped; promote to reference product]',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for the battery storage system. Used for work order scheduling and resource planning.',
    `operational_status` STRING COMMENT 'Current operational lifecycle status of the battery storage asset (commissioned, in-service, standby, under maintenance, degraded performance, or decommissioned).. Valid values are `commissioned|in_service|standby|maintenance|degraded|decommissioned`',
    `ownership_type` STRING COMMENT 'Ownership structure of the battery storage asset (utility-owned, third-party owned under PPA, customer-owned BTM, or joint venture).. Valid values are `utility_owned|third_party_owned|customer_owned|joint_venture`',
    `poi_substation_name` STRING COMMENT 'Name of the substation or grid node where the battery storage system physically interconnects to the transmission or distribution network.',
    `primary_use_case` STRING COMMENT 'Primary operational use case or market participation mode for the battery storage system (energy arbitrage, frequency regulation, spinning reserve, capacity market, peak shaving, or renewable firming).. Valid values are `energy_arbitrage|frequency_regulation|spinning_reserve|capacity|peak_shaving|renewable_firming`',
    `rated_energy_capacity_mwh` DECIMAL(18,2) COMMENT 'Total energy storage capacity of the battery system measured in megawatt-hours (MWh). Represents the total amount of energy that can be stored and discharged.',
    `rated_power_mw` DECIMAL(18,2) COMMENT 'Maximum continuous power output or input capacity of the battery storage system measured in megawatts (MW). Represents the instantaneous charge or discharge rate.',
    `round_trip_efficiency_percent` DECIMAL(18,2) COMMENT 'Round-trip energy efficiency of the battery storage system expressed as a percentage. Represents the ratio of energy discharged to energy charged, accounting for conversion and storage losses.',
    `scada_integration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the battery storage system is integrated with the utility SCADA system for real-time monitoring and control.',
    `site_address` STRING COMMENT 'Physical street address of the battery storage system installation site. Organizational contact data classified as confidential.',
    `site_city` STRING COMMENT 'City or municipality where the battery storage system is located.',
    `site_postal_code` STRING COMMENT 'US postal ZIP code of the battery storage system installation site. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `site_state` STRING COMMENT 'Two-letter US state code where the battery storage system is located. Used for regulatory jurisdiction and RPS compliance tracking.. Valid values are `^[A-Z]{2}$`',
    `storage_technology_type` STRING COMMENT 'Type of battery energy storage technology deployed (lithium-ion, flow battery, compressed air energy storage, sodium-sulfur, lead-acid, or other emerging technologies).. Valid values are `lithium_ion|flow_battery|compressed_air|sodium_sulfur|lead_acid|other`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the battery storage system expires. Critical for maintenance planning and capital replacement forecasting.',
    CONSTRAINT pk_battery_storage_asset PRIMARY KEY(`battery_storage_asset_id`)
) COMMENT 'Master record for utility-scale and grid-connected battery energy storage systems (BESS), including day-ahead and real-time dispatch schedules. Captures storage technology type (lithium-ion, flow battery, compressed air), rated power (MW), rated energy capacity (MWh), SoC range limits, round-trip efficiency, cycle count, degradation rate, charge/discharge ramp rates, interconnection voltage level, co-location flag, and ISO/RTO storage registration status. Includes dispatch schedules: interval timestamps, scheduled charge/discharge MW, target SoC, market participation mode (energy arbitrage, frequency regulation, spinning reserve, capacity), ISO/RTO schedule submission reference, and revision history. SSOT for battery storage asset master data AND dispatch scheduling — no separate dispatch schedule product exists. Excludes generation-domain thermal storage or pumped hydro assets.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` (
    `generation_meter_read_id` BIGINT COMMENT 'Primary key for generation_meter_read',
    `der_registry_id` BIGINT COMMENT 'FK to renewable.der_registry.der_registry_id — Generation meter reads reference the DER or facility being metered. For distributed resources, this must resolve to der_registry. Critical for REC issuance, PPA settlement, and NEM credit calculation.',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: Generation meter reads provide forensic data for outage investigations (voltage sags, frequency deviations, timestamp correlation). AMI data validates outage start/end times and customer impact. Essen',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Renewable generation meter reads (from solar/wind farms) must reference the specific generating unit for NERC GADS reporting, ISO/RTO settlement, REC issuance, and operational performance tracking. Me',
    `generation_der_registry_id` BIGINT COMMENT 'Reference to the Behind-the-Meter (BTM) DER asset for customer-owned generation. Null for utility-scale facilities.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Generation meter reads should reference physical meter asset for data lineage and validation. Revenue meter data validation and VEE processing require generation reads linked to meter asset. Replaces ',
    `power_plant_id` BIGINT COMMENT 'Reference to the renewable generation facility (wind farm, solar array, hydro plant, battery storage) where this meter read was captured.',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.run. Business justification: Actual generation meter reads validate forecast accuracy and feed model training. Linking reads to forecast runs enables systematic accuracy measurement and model improvement workflows.',
    `vpp_configuration_id` BIGINT COMMENT 'Reference to the VPP aggregation configuration if this DER participates in a virtual power plant program.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature at the generation site during the interval. Used for performance analysis and generation forecasting model validation.',
    `availability_flag` BOOLEAN COMMENT 'Indicates whether the generation asset was available for operation during the interval. False during planned or forced outages.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of actual generation to maximum possible generation during the interval, expressed as percentage. Key performance indicator for renewable assets.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Nameplate capacity of the generation facility or DER asset in megawatts. Used for capacity factor and performance ratio calculations.',
    `charge_discharge_mode` STRING COMMENT 'Operating mode of battery storage system during the interval. Applicable to battery storage assets for dispatch verification.. Valid values are `Charging|Discharging|Idle|Standby`',
    `curtailed_energy_kwh` DECIMAL(18,2) COMMENT 'Amount of potential generation curtailed during the interval in kilowatt-hours. Used for curtailment compensation calculations and renewable integration analysis.',
    `curtailment_flag` BOOLEAN COMMENT 'Indicates whether generation was curtailed during this interval due to grid constraints, negative pricing, or dispatch instructions from ISO/RTO.',
    `data_quality_flag` STRING COMMENT 'Overall data quality indicator for the meter read. Used to filter reads for financial settlement and regulatory reporting.. Valid values are `Good|Questionable|Bad|Not_Validated`',
    `data_source_timestamp` TIMESTAMP COMMENT 'Timestamp when the read was captured by the source system (AMI, SCADA, MDM). May differ from read_timestamp due to communication latency.',
    `daylight_saving_flag` BOOLEAN COMMENT 'Indicates whether the read timestamp falls within daylight saving time. Used for interval alignment during DST transitions.',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Average grid frequency during the interval in hertz. Must remain within NERC reliability standards (59.95-60.05 Hz for North America).',
    `gross_generation_kwh` DECIMAL(18,2) COMMENT 'Total energy generated during the interval in kilowatt-hours before auxiliary load deduction. Used for REC issuance calculations and renewable portfolio standard compliance reporting.',
    `interconnection_queue_number` STRING COMMENT 'ISO/RTO or utility interconnection queue identifier for the generation facility. Links meter reads to interconnection agreements.',
    `interval_duration_minutes` STRING COMMENT 'Duration of the meter read interval in minutes. Typically 15 or 60 minutes for generation metering per FERC Order 2222 and state RPS requirements.',
    `irradiance_w_per_m2` DECIMAL(18,2) COMMENT 'Solar irradiance measured at the site in watts per square meter. Applicable to solar generation facilities for performance ratio calculations.',
    `lmp_energy_price` DECIMAL(18,2) COMMENT 'Energy component of the locational marginal price at the settlement point during the interval in dollars per MWh. Used for revenue calculation.',
    `market_settlement_point` STRING COMMENT 'ISO/RTO pricing node or settlement point identifier where generation is financially settled. Used for locational marginal price (LMP) matching.',
    `meter_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to raw meter register values to calculate actual generation. Accounts for current transformer and potential transformer ratios.',
    `meter_read_status` STRING COMMENT 'Lifecycle status of the meter read record indicating whether it is preliminary, final, or has been revised. Critical for settlement finalization.. Valid values are `Final|Preliminary|Revised|Disputed|Voided`',
    `nem_credit_flag` BOOLEAN COMMENT 'Indicates whether this BTM generation read qualifies for NEM bill credit under state net metering programs. Applicable only to DER assets.',
    `net_generation_kwh` DECIMAL(18,2) COMMENT 'Net energy delivered to the grid after deducting auxiliary load and station service consumption. Used for PPA settlement verification and NEM credit determination.',
    `outage_type` STRING COMMENT 'Type of outage or unavailability during the interval if availability_flag is false. Used for reliability reporting and PPA force majeure claims.. Valid values are `None|Planned|Forced|Maintenance|Curtailment`',
    `power_factor` DECIMAL(18,2) COMMENT 'Ratio of real power to apparent power during the interval. Must meet interconnection agreement requirements typically between 0.95 leading and 0.95 lagging.',
    `ppa_settlement_flag` BOOLEAN COMMENT 'Indicates whether this read is included in PPA settlement calculations. False for reads with poor data quality or outside contract delivery periods.',
    `reactive_power_kvar` DECIMAL(18,2) COMMENT 'Reactive power measured during the interval in kilovolt-amperes reactive. Required for power factor compliance and grid stability analysis.',
    `read_method` STRING COMMENT 'Method by which the meter read was obtained. Distinguishes between automated AMI reads, manual field reads, and estimated values.. Valid values are `Automatic|Manual|Estimated|Remote`',
    `read_source` STRING COMMENT 'Source system that captured or provided the meter read data. Indicates data provenance for audit and quality validation.. Valid values are `AMI|SCADA|MDM|Manual|DERMS|PI_Historian`',
    `read_timestamp` TIMESTAMP COMMENT 'Timestamp when the meter read interval was captured. Represents the end of the interval period. Critical for REC issuance and PPA settlement calculations.',
    `rec_eligible_flag` BOOLEAN COMMENT 'Indicates whether this generation interval qualifies for REC issuance based on facility certification, data quality, and state RPS program rules.',
    `rec_serial_number` STRING COMMENT 'Unique serial number of the REC certificate issued for this generation interval. Assigned by REC tracking system (e.g., WREGIS, M-RETS, PJM-GATS).',
    `rec_vintage_year` STRING COMMENT 'Calendar year assigned to RECs issued from this generation interval. Determines eligibility for state RPS compliance periods.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter read record was first inserted into the data platform. Used for data lineage and audit trails.',
    `settlement_period` STRING COMMENT 'ISO/RTO settlement period identifier (e.g., YYYYMM or trading day) to which this read is assigned for financial settlement.',
    `state_of_charge_percent` DECIMAL(18,2) COMMENT 'Battery energy storage system state of charge at interval end as percentage of total capacity. Applicable to battery storage assets.',
    `time_zone` STRING COMMENT 'Time zone of the meter read timestamp. Critical for accurate interval alignment across facilities in different time zones.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the VEE validation process was completed for this read. Used for data quality audit trails.',
    `vee_status` STRING COMMENT 'Data quality status from the VEE process indicating whether the read is actual, estimated, or edited. Critical for REC issuance eligibility and settlement accuracy.. Valid values are `Valid|Estimated|Edited|Missing|Suspect|Override`',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Average voltage at the point of interconnection during the interval in kilovolts. Used for power quality monitoring and interconnection compliance.',
    `wind_speed_mps` DECIMAL(18,2) COMMENT 'Average wind speed at hub height during the interval. Applicable to wind generation facilities for capacity factor analysis.',
    CONSTRAINT pk_generation_meter_read PRIMARY KEY(`generation_meter_read_id`)
) COMMENT 'Interval meter read records specific to renewable generation facilities and BTM generation assets within the renewable domain. Captures meter serial number, facility or DER reference, read timestamp, interval duration (15-min, hourly), gross generation (kWh), net generation after auxiliary load (kWh), reactive power (kVAR), power factor, meter read source (AMI, SCADA, manual), VEE status, and data quality flag. SSOT boundary: scoped ONLY to generation-side reads used for REC issuance calculations, PPA settlement verification, and NEM credit determination. Customer consumption meter reads, AMI infrastructure, and meter asset management are managed in the metering domain. Cross-domain SSOT adjudication pending with global architect.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` (
    `der_enrollment_id` BIGINT COMMENT 'Primary key for der_enrollment',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: DER program enrollments must track the customer account for incentive payments, bill credits, capacity payments, and compliance reporting. Essential for financial settlement and customer billing integ',
    `dr_program_id` BIGINT COMMENT 'Reference to the utility program, VPP, demand response initiative, or DERMS portfolio that the DER is enrolled in. Links to program master data containing terms, incentives, and operational parameters.',
    `incentive_program_id` BIGINT COMMENT 'FK to renewable.incentive_program.incentive_program_id — DER enrollments in incentive programs need to reference the specific incentive_program. Supports tracking which DERs are enrolled in which incentive programs.',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: DER program enrollments are tied to specific service points for VPP dispatch and settlement. VPP dispatch requires enrollment linked to service point for location-based control, feeder-level aggregati',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: DER program enrollments must comply with tariff requirements, interconnection standards, ISO/RTO market rules. Links enrollment to governing compliance obligation. Essential for program eligibility ve',
    `der_registry_id` BIGINT COMMENT 'Reference to the specific DER asset being enrolled. Links to the DER registry containing technical specifications, interconnection details, and asset metadata.',
    `meter_id` BIGINT COMMENT 'Identifier of the revenue-grade meter used for program settlement calculations, incentive payments, and NEM credit determination. Links to MDM system for interval data retrieval.',
    `vpp_configuration_id` BIGINT COMMENT 'FK to renewable.vpp_configuration.vpp_configuration_id — DER enrollments into VPP programs must reference the specific VPP configuration. Critical for dispatch eligibility and aggregation.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the enrollment automatically renews at the end of the term. True for evergreen enrollments, false for fixed-term enrollments requiring explicit renewal.',
    `baseline_methodology` STRING COMMENT 'Method used to calculate the customer baseline load (CBL) for demand response performance measurement. Customer baseline load uses historical consumption patterns, meter-before-meter-after compares pre/post installation, control group uses similar non-participating customers, day-matching uses same-day-type averages, regression uses statistical modeling.. Valid values are `customer_baseline_load|meter_before_meter_after|control_group|day_matching|regression`',
    `communication_protocol` STRING COMMENT 'Communication protocol used for telemetry, dispatch commands, and control signals between the DER and DERMS or VPP platform. IEEE 2030.5 (Smart Energy Profile 2.0) for residential, OpenADR 2.0b for commercial DR, DNP3 for utility-scale SCADA integration.. Valid values are `IEEE_2030_5|OpenADR_2_0b|DNP3|Modbus_TCP|SunSpec|proprietary`',
    `control_endpoint_url` STRING COMMENT 'Network endpoint URL for sending dispatch commands, curtailment signals, and control instructions to the DER. Separate from telemetry for security and operational isolation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `dispatch_priority` STRING COMMENT 'Numeric priority ranking for dispatch order within the VPP or DERMS portfolio. Lower numbers indicate higher priority. Used for economic dispatch optimization and curtailment sequencing.',
    `enrolled_capacity_kw` DECIMAL(18,2) COMMENT 'Nameplate capacity in kilowatts (kW) enrolled in the program. May be less than the DERs total capacity if partial enrollment is allowed. Used for dispatch calculations, incentive payments, and portfolio aggregation.',
    `enrolled_energy_capacity_kwh` DECIMAL(18,2) COMMENT 'Energy storage capacity in kilowatt-hours (kWh) enrolled for battery storage systems. Represents the usable energy that can be dispatched or charged under program control. Null for non-storage DERs.',
    `enrollment_application_date` DATE COMMENT 'Date when the customer submitted the enrollment application. Used for tracking application processing time and program participation trends.',
    `enrollment_approval_date` DATE COMMENT 'Date when the utility approved the enrollment application and authorized program participation. Used for compliance reporting and customer communications.',
    `enrollment_date` DATE COMMENT 'Date when the DER was officially enrolled in the program and participation became effective. Used for program term calculations, incentive eligibility, and compliance reporting.',
    `enrollment_effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when enrollment became active and the DER began participating in program dispatch, telemetry, or credit calculations. Critical for real-time market operations and settlement.',
    `enrollment_notes` STRING COMMENT 'Free-text field for capturing additional enrollment details, special conditions, customer preferences, or operational notes not covered by structured fields.',
    `enrollment_number` STRING COMMENT 'Business identifier for the enrollment record. Human-readable unique number used in customer communications, program reporting, and regulatory filings.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment. Pending indicates application submitted but not yet approved, active indicates full participation, suspended indicates temporary hold, terminated indicates program exit, opted_out indicates customer-initiated withdrawal, expired indicates term completion.. Valid values are `pending|active|suspended|terminated|opted_out|expired`',
    `enrollment_term_end_date` DATE COMMENT 'End date of the contractual enrollment term. Null for open-ended enrollments. Used to trigger renewal processes and calculate program participation duration.',
    `enrollment_term_start_date` DATE COMMENT 'Start date of the contractual enrollment term. May differ from enrollment_date if there is a delay between enrollment and term commencement.',
    `export_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power in kilowatts (kW) that the DER is permitted to export to the grid under the interconnection agreement. Used to enforce dispatch constraints and prevent grid violations.',
    `import_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power in kilowatts (kW) that the DER is permitted to import from the grid for charging (applicable to battery storage systems). Null for generation-only DERs.',
    `incentive_rate_per_kw` DECIMAL(18,2) COMMENT 'Capacity incentive payment rate in dollars per kilowatt of enrolled capacity. Used for calculating monthly or annual capacity payments to program participants.',
    `incentive_rate_per_kwh` DECIMAL(18,2) COMMENT 'Energy incentive payment rate in dollars per kilowatt-hour of dispatched or curtailed energy. Used for calculating performance-based incentive payments.',
    `interconnection_agreement_number` STRING COMMENT 'Reference to the interconnection agreement governing the DERs connection to the distribution grid. Links enrollment to technical interconnection requirements and export limits.',
    `last_dispatch_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent dispatch event or control signal sent to this enrolled DER. Used for monitoring program activity and asset utilization.',
    `last_opt_out_date` DATE COMMENT 'Date of the most recent opt-out event. Used for tracking opt-out patterns and customer engagement analysis.',
    `opt_out_allowed_flag` BOOLEAN COMMENT 'Indicates whether the customer is permitted to opt out of individual dispatch events or curtailment requests. True for voluntary DR programs, false for firm capacity commitments.',
    `opt_out_count` STRING COMMENT 'Number of times the customer has opted out of dispatch events during the current enrollment term. Used to enforce opt-out limits and assess program reliability.',
    `opt_out_limit` STRING COMMENT 'Maximum number of opt-outs allowed per enrollment term. Null if unlimited opt-outs are permitted. Exceeding this limit may result in enrollment suspension or termination.',
    `program_type` STRING COMMENT 'Classification of the program type. Net Energy Metering (NEM) for BTM generation credits, Virtual Power Plant (VPP) for aggregated dispatch, Demand Response (DR) for load curtailment, Renewable Portfolio Standard (RPS) for compliance tracking, storage incentive for battery programs, or feed-in tariff for fixed-rate purchase agreements.. Valid values are `NEM|VPP|DR|RPS|storage_incentive|feed_in_tariff`',
    `rec_issuance_eligible_flag` BOOLEAN COMMENT 'Indicates whether generation from this enrolled DER is eligible for REC issuance under state RPS programs. True for qualifying renewable generation, false for storage-only or non-renewable DERs.',
    `rec_tracking_system_code` STRING COMMENT 'Identifier in the regional REC tracking system (e.g., NEPOOL GIS, WREGIS, M-RETS, PJM-EIS) for this enrolled DER. Used for automated REC issuance and retirement tracking.',
    `telemetry_endpoint_url` STRING COMMENT 'Network endpoint URL for real-time telemetry data transmission from the DER to the DERMS or VPP aggregator. Used for monitoring generation, state of charge, and operational status.',
    `telemetry_frequency_seconds` STRING COMMENT 'Frequency in seconds at which the DER transmits telemetry data to the DERMS or VPP platform. Typical values range from 5 seconds for utility-scale assets to 300 seconds (5 minutes) for residential BTM systems.',
    `termination_date` DATE COMMENT 'Date when the enrollment was terminated or the customer exited the program. Null for active enrollments. Used for calculating program participation duration and churn analysis.',
    `termination_reason` STRING COMMENT 'Reason for enrollment termination. Customer request indicates voluntary withdrawal, non-compliance indicates failure to meet program requirements, equipment failure indicates technical issues, program closure indicates utility-initiated termination, term expiration indicates natural end of contract, relocation indicates customer moved.. Valid values are `customer_request|non_compliance|equipment_failure|program_closure|term_expiration|relocation`',
    `total_dispatch_count` STRING COMMENT 'Cumulative number of dispatch events or curtailment requests issued to this enrolled DER during the current enrollment term. Used for performance tracking and program evaluation.',
    `total_dispatched_energy_kwh` DECIMAL(18,2) COMMENT 'Cumulative energy in kilowatt-hours (kWh) dispatched or curtailed from this enrolled DER during the current enrollment term. Used for settlement calculations and program impact assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified. Used for change tracking and data quality monitoring.',
    `vpp_enrollment_status` STRING COMMENT 'Current enrollment status in Virtual Power Plant aggregation programs. Enrolled indicates active participation in VPP dispatch. Not enrolled indicates the resource is not participating. Pending indicates application under review. Suspended indicates temporary removal from dispatch. [Moved from der_registry: This attribute in der_registry represents the enrollment status of a DER in VPP programs, but a single DER can be enrolled in MULTIPLE VPP configurations simultaneously with different statuses. The status belongs to each specific enrollment relationship (DER + VPP combination), not to the DER itself. Moving this to der_enrollment allows tracking distinct enrollment statuses per VPP.]. Valid values are `enrolled|not_enrolled|pending|suspended`',
    CONSTRAINT pk_der_enrollment PRIMARY KEY(`der_enrollment_id`)
) COMMENT 'Enrollment record linking a specific DER to a utility program, VPP, demand response event, or DERMS-managed portfolio. Captures enrollment date, DER reference, program type (NEM, VPP, DR, RPS, storage incentive), program term, enrolled capacity (kW), communication protocol (IEEE 2030.5, OpenADR, DNP3), telemetry endpoint, enrollment status, and opt-out history. SSOT for DER program participation lifecycle within the renewable domain. Manages the many-to-many relationship between DERs and utility programs.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` (
    `incentive_program_id` BIGINT COMMENT 'Primary key for incentive_program',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Incentive programs require PUC approval and periodic reporting for cost recovery. Links program to authorizing regulatory filing. Standard practice for program authorization, budget approval, and rate',
    `administering_agency` STRING COMMENT 'Name of the government agency, utility, or third-party administrator responsible for managing the incentive program.',
    `application_window_end_date` DATE COMMENT 'Date when the program stops accepting new applications. Null if continuously open.',
    `application_window_start_date` DATE COMMENT 'Date when the program begins accepting new applications from eligible participants.',
    `budget_expended_amount` DECIMAL(18,2) COMMENT 'Total amount of program budget that has been committed or paid out to date in USD.',
    `budget_remaining_amount` DECIMAL(18,2) COMMENT 'Remaining available budget for the incentive program in USD, calculated as program_budget_amount minus budget_expended_amount.',
    `contact_email` STRING COMMENT 'Email address for program inquiries and application support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number for program inquiries and application support.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incentive program record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the incentive program expires or is scheduled to close. Null for open-ended programs.',
    `effective_start_date` DATE COMMENT 'Date when the incentive program becomes active and begins accepting applications or issuing incentives.',
    `eligibility_criteria` STRING COMMENT 'Detailed description of the eligibility requirements for participation in the incentive program, including customer class, technology specifications, interconnection requirements, and geographic restrictions.',
    `eligible_technology_types` STRING COMMENT 'Comma-separated list of renewable energy technology types eligible for this incentive program (e.g., solar_pv, wind, battery_storage, hydroelectric, biomass, geothermal).',
    `enrolled_capacity_mw` DECIMAL(18,2) COMMENT 'Total capacity in megawatts (MW) currently enrolled or committed under the incentive program.',
    `enrolled_customer_count` STRING COMMENT 'Current number of customers or participants enrolled in the incentive program.',
    `enrollment_cap_customer_count` STRING COMMENT 'Maximum number of customers or participants that can enroll in the incentive program. Null if no customer cap applies.',
    `enrollment_cap_mw` DECIMAL(18,2) COMMENT 'Maximum total capacity in megawatts (MW) that can be enrolled in the incentive program. Null if no capacity cap applies.',
    `funding_source` STRING COMMENT 'Source of funding for the incentive program: ratepayer = utility customer rates, federal_grant = federal government funding, state_grant = state government funding, utility_shareholder = utility equity, carbon_credit = carbon offset revenue, rps_acp = RPS Alternative Compliance Payment funds.. Valid values are `ratepayer|federal_grant|state_grant|utility_shareholder|carbon_credit|rps_acp`',
    `incentive_rate_structure` STRING COMMENT 'Structure or basis for calculating the incentive payment: per_kw = dollars per kilowatt of capacity, per_mwh = dollars per megawatt-hour of generation, per_rec = dollars per Renewable Energy Certificate, percentage_of_cost = percentage of project cost, fixed_amount = lump sum, tiered = multiple rate tiers based on size or technology.. Valid values are `per_kw|per_mwh|per_rec|percentage_of_cost|fixed_amount|tiered`',
    `incentive_rate_unit` STRING COMMENT 'Unit of measure for the incentive rate value (e.g., USD_per_kW, USD_per_MWh, USD_per_REC, percent, USD for fixed amounts).. Valid values are `USD_per_kW|USD_per_MWh|USD_per_REC|percent|USD`',
    `incentive_rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the incentive rate corresponding to the rate structure (e.g., 0.25 for $0.25/kW, 30.0000 for 30% of cost).',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the regulatory jurisdiction or state where the incentive program applies (e.g., CA, NY, TX).. Valid values are `^[A-Z]{2,3}$`',
    `maximum_system_size_kw` DECIMAL(18,2) COMMENT 'Maximum renewable energy system capacity in kilowatts (kW) eligible for the incentive. Null if no maximum applies.',
    `minimum_system_size_kw` DECIMAL(18,2) COMMENT 'Minimum renewable energy system capacity in kilowatts (kW) required for eligibility. Null if no minimum applies.',
    `payment_frequency` STRING COMMENT 'Frequency at which incentive payments are issued to participants: one_time = single upfront payment, monthly/quarterly/annual = recurring payments, per_mwh = payment per unit of generation.. Valid values are `one_time|monthly|quarterly|annual|per_mwh`',
    `payment_term_years` STRING COMMENT 'Number of years over which incentive payments are made for recurring payment structures. Null for one-time payments.',
    `program_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for the incentive program in USD. Used for tracking program expenditures and remaining capacity.',
    `program_code` STRING COMMENT 'Externally-known unique code or identifier for the incentive program used in regulatory filings and customer communications.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_name` STRING COMMENT 'Official name of the renewable energy incentive program as published by the administering agency or utility.',
    `program_notes` STRING COMMENT 'Additional notes, comments, or special conditions related to the incentive program administration or policy changes.',
    `program_status` STRING COMMENT 'Current lifecycle status of the incentive program indicating whether it is accepting applications and issuing incentives.. Valid values are `active|suspended|closed|pending_approval|expired`',
    `program_type` STRING COMMENT 'Classification of the incentive program. ITC = Investment Tax Credit, PTC = Production Tax Credit, SREC = Solar Renewable Energy Certificate, storage_incentive = battery/storage incentive, interconnection_rebate = grid connection rebate, green_tariff = voluntary renewable energy tariff.. Valid values are `ITC|PTC|SREC|storage_incentive|interconnection_rebate|green_tariff`',
    `program_website_url` STRING COMMENT 'Web address where customers and stakeholders can access detailed program information, application forms, and guidelines.',
    `rec_tracking_system_code` STRING COMMENT 'Identifier for the REC tracking system used to verify and retire RECs associated with this program (e.g., NEPOOL GIS, WREGIS, M-RETS, PJM GATS).',
    `requires_interconnection_approval` BOOLEAN COMMENT 'Indicates whether the participant must receive utility interconnection approval before receiving incentive payments.',
    `requires_rec_transfer` BOOLEAN COMMENT 'Indicates whether participants must transfer ownership of Renewable Energy Certificates (RECs) to the utility or program administrator as a condition of receiving incentives.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this incentive program record was last modified.',
    CONSTRAINT pk_incentive_program PRIMARY KEY(`incentive_program_id`)
) COMMENT 'Master record for renewable energy incentive programs administered by the utility or mandated by state/federal regulators. Captures program name, program type (ITC, PTC, SREC, storage incentive, interconnection rebate, green tariff), eligible technology types, incentive rate or structure ($/kW, $/MWh, $/REC), program budget ($), enrollment cap (MW or customers), application window, eligibility criteria, administering agency, and program status. SSOT for renewable incentive program definitions within this domain. Supports program management, budget tracking, and regulatory reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` (
    `incentive_application_id` BIGINT COMMENT 'Unique identifier for the renewable energy incentive application record. Primary key for the incentive application entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account of the applicant submitting the incentive application.',
    `capex_expenditure_id` BIGINT COMMENT 'Foreign key linking to finance.capex_expenditure. Business justification: Approved incentives offset project costs and reduce net capex for rate base calculation; link enables proper capitalization accounting, AFUDC treatment, and regulatory asset valuation for renewable pr',
    `employee_id` BIGINT COMMENT 'Reference to the utility staff member currently assigned to review this incentive application.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Incentive applications reference specific equipment materials for eligibility verification, rebate calculation, and compliance validation. Real business process: rebate program administration, equipme',
    `incentive_program_id` BIGINT COMMENT 'FK to renewable.incentive_program.incentive_program_id — Each incentive application is submitted against a specific incentive program. This is a master-transaction relationship essential for program budget tracking and eligibility validation.',
    `application_id` BIGINT COMMENT 'Reference to the associated grid interconnection application if the project requires utility interconnection approval.',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Incentive applications reference specific service point locations for eligibility verification and installation tracking. Incentive payment verification and post-installation inspection require applic',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Incentive applications are site-specific requiring premise linkage for interconnection coordination, site verification, feeder capacity analysis, and service territory eligibility determination. Criti',
    `primary_incentive_program_id` BIGINT COMMENT 'Reference to the renewable energy incentive program under which this application was submitted.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Large incentive applications may be subject to regulatory review or included in program compliance filings. Tracks regulatory oversight of incentive disbursements. Supports program administration tran',
    `actual_installation_completion_date` DATE COMMENT 'Actual date when the renewable energy system installation was completed and became operational.',
    `applicant_contact_email` STRING COMMENT 'Primary email address for communication regarding the incentive application status and requirements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_contact_phone` STRING COMMENT 'Primary telephone number for contacting the applicant regarding the incentive application.',
    `applicant_name` STRING COMMENT 'Full legal name of the individual or organization applying for the renewable energy incentive.',
    `application_notes` STRING COMMENT 'Free-form notes and comments regarding the incentive application, review findings, or special circumstances.',
    `application_number` STRING COMMENT 'Externally-visible unique business identifier for the incentive application, typically formatted with program prefix and sequential number.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the incentive application from initial draft through final disposition. [ENUM-REF-CANDIDATE: draft|submitted|under_review|pending_documentation|approved|denied|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `application_submission_date` DATE COMMENT 'Date when the incentive application was officially submitted to the utility for review.',
    `approval_date` DATE COMMENT 'Date when the incentive application was officially approved for payment.',
    `approved_incentive_amount` DECIMAL(18,2) COMMENT 'Final dollar amount of incentive approved for payment, which may differ from the requested amount based on review findings.',
    `compliance_conditions` STRING COMMENT 'Specific requirements and conditions the applicant must meet to maintain incentive eligibility, such as system performance thresholds or reporting obligations.',
    `compliance_verification_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing compliance verification and reporting is required for this incentive.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incentive application record was first created in the system.',
    `denial_date` DATE COMMENT 'Date when the incentive application was officially denied.',
    `denial_reason` STRING COMMENT 'Detailed explanation of why the incentive application was denied, including specific program rule violations or documentation deficiencies.',
    `documentation_status` STRING COMMENT 'Status of required supporting documentation such as site plans, equipment specifications, and contractor certifications.. Valid values are `not_submitted|incomplete|complete|under_review|approved|rejected`',
    `estimated_annual_generation_mwh` DECIMAL(18,2) COMMENT 'Projected annual energy generation from the renewable energy system in megawatt-hours.',
    `expected_installation_completion_date` DATE COMMENT 'Projected date when the renewable energy system installation will be completed and operational.',
    `first_payment_date` DATE COMMENT 'Date when the first incentive payment was or is scheduled to be disbursed.',
    `incentive_calculation_method` STRING COMMENT 'Method used to calculate the incentive amount based on program structure.. Valid values are `per_watt|per_kwh|percentage_of_cost|fixed_amount|tiered_capacity`',
    `installer_contractor_name` STRING COMMENT 'Name of the certified contractor or company performing the renewable energy system installation.',
    `installer_license_number` STRING COMMENT 'Professional license or certification number of the contractor performing the installation.',
    `payment_schedule_type` STRING COMMENT 'Structure defining how and when the approved incentive will be disbursed to the applicant.. Valid values are `lump_sum|milestone_based|performance_based|annual_installments`',
    `project_capacity_kw` DECIMAL(18,2) COMMENT 'Nameplate capacity of the proposed renewable energy system in kilowatts.',
    `project_location_address` STRING COMMENT 'Physical street address where the renewable energy system will be installed.',
    `project_location_city` STRING COMMENT 'City where the renewable energy project is located.',
    `project_location_postal_code` STRING COMMENT 'ZIP or postal code for the renewable energy project location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `project_location_state` STRING COMMENT 'Two-letter state code where the renewable energy project is located.. Valid values are `^[A-Z]{2}$`',
    `project_type` STRING COMMENT 'Type of renewable energy technology for which the incentive is being requested. [ENUM-REF-CANDIDATE: solar_pv|wind|battery_storage|hydroelectric|biomass|geothermal|fuel_cell — 7 candidates stripped; promote to reference product]',
    `rec_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the renewable energy generation from this project is eligible to generate RECs for RPS compliance.',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Dollar amount of approved incentive that has not yet been paid.',
    `requested_incentive_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of incentive requested by the applicant based on program rules and project specifications.',
    `review_stage` STRING COMMENT 'Current stage in the multi-step application review and approval workflow.. Valid values are `initial_screening|technical_review|financial_review|management_approval|final_approval`',
    `review_start_date` DATE COMMENT 'Date when the formal review process for the incentive application began.',
    `service_territory_code` STRING COMMENT 'Utility service territory identifier where the renewable energy project is located.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of incentive payments disbursed to date.',
    `total_project_cost` DECIMAL(18,2) COMMENT 'Total estimated cost of the renewable energy project including equipment, installation, and permitting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the incentive application record was last modified.',
    CONSTRAINT pk_incentive_application PRIMARY KEY(`incentive_application_id`)
) COMMENT 'Customer or project application record for a renewable energy incentive program. Captures applicant reference, program reference, application date, project type and capacity (kW), estimated annual generation (MWh), requested incentive amount ($), supporting documentation status, review stage, approval/denial date, approved incentive amount ($), payment schedule, and compliance conditions. SSOT for incentive application lifecycle from submission through disbursement within the renewable domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` (
    `green_tariff_subscription_id` BIGINT COMMENT 'Unique identifier for the green tariff subscription record. Primary key for the green tariff subscription entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account enrolled in the green tariff program. Links subscription to the customer account master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Green tariff enrollments require customer service representatives to verify eligibility, process applications, and configure billing systems for renewable energy premium charges. Tracks processor for ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Green tariff programs must comply with regulatory requirements (tariff approval, RPS eligibility, consumer protection rules). Links subscription program to governing compliance obligation. Essential f',
    `power_plant_id` BIGINT COMMENT 'Foreign key linking to generation.power_plant. Business justification: Green tariff programs allocate output from specific renewable power plants to subscribing customers for marketing authenticity and REC retirement. Customer programs teams track which facility serves e',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to finance.receivable. Business justification: Green tariff premiums create receivables separate from base rates; link enables revenue recognition, AR aging, and program-specific financial reporting for voluntary renewable energy programs and regu',
    `renewable_facility_power_plant_id` BIGINT COMMENT 'Reference to the specific renewable generation facility or portfolio of facilities supplying energy for this subscription. Links to renewable asset registry for community solar or dedicated facility programs.',
    `renewable_rec_certificate_id` BIGINT COMMENT 'FK to renewable.renewable_rec_certificate.renewable_rec_certificate_id — Green tariff subscriptions require REC retirement on behalf of the customer. The subscription must link to the RECs retired to substantiate the renewable claim.',
    `allocation_method` STRING COMMENT 'Method used to allocate renewable energy to the customer account. Pro-rata allocates based on usage proportion, fixed block allocates a set kWh amount, percentage-based allocates a percentage of total usage, full usage covers 100% of customer consumption.. Valid values are `pro_rata|fixed_block|percentage_based|full_usage`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the subscription automatically renews at the end of the contract term. True means subscription continues unless customer cancels, false means subscription expires at term end.',
    `billing_cycle_day` STRING COMMENT 'Day of month when green tariff charges are calculated and applied to customer bill. Aligns with customer account billing cycle for premium charge calculation.',
    `block_size_kwh` DECIMAL(18,2) COMMENT 'Fixed quantity of renewable energy in kilowatt-hours (kWh) allocated per billing period when using fixed block allocation method. Common block sizes are 100 kWh, 200 kWh, or 500 kWh per month.',
    `cancellation_date` DATE COMMENT 'Date when the customer cancelled or terminated the green tariff subscription. Populated only for cancelled or expired subscriptions.',
    `cancellation_reason` STRING COMMENT 'Reason provided by customer or system for subscription cancellation. Examples include cost concerns, relocation, dissatisfaction with program, account closure, or program termination.',
    `contract_term_months` STRING COMMENT 'Duration of the subscription commitment in months. Defines the minimum enrollment period before customer can cancel without penalty.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this green tariff subscription record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this subscription record. Typically USD for US utilities.. Valid values are `^[A-Z]{3}$`',
    `customer_allocated_capacity_kw` DECIMAL(18,2) COMMENT 'Generation capacity in kilowatts (kW) allocated to this specific customer subscription. Used in community solar programs where customers subscribe to a share of facility capacity.',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer enrolled in the green tariff program. Used for program marketing analysis and channel effectiveness tracking.. Valid values are `web_portal|mobile_app|call_center|in_person|mail|email`',
    `enrollment_date` DATE COMMENT 'Date when the customer submitted enrollment application for the green tariff program. May differ from subscription_start_date due to processing time or waitlist periods.',
    `generation_source_type` STRING COMMENT 'Type of renewable energy generation technology sourcing this subscription. Identifies whether energy comes from solar, wind, hydroelectric, biomass, geothermal, or a mixed renewable portfolio.. Valid values are `solar|wind|hydro|biomass|geothermal|mixed_renewable`',
    `jurisdiction_code` STRING COMMENT 'State or regulatory jurisdiction code governing this green tariff program. Two or three letter abbreviation identifying the Public Utility Commission (PUC) authority.. Valid values are `^[A-Z]{2,3}$`',
    `last_billing_date` DATE COMMENT 'Date of the most recent billing cycle where green tariff premium charges were calculated and applied to customer account.',
    `monthly_premium_amount` DECIMAL(18,2) COMMENT 'Fixed monthly subscription fee for participation in the green tariff program. Charged in addition to or instead of per-kWh premium. Expressed in dollars.',
    `nem_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether this subscription qualifies for Net Energy Metering (NEM) bill credits. True for community solar and virtual net metering programs where generation credits offset customer usage charges.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special conditions, or administrative notes related to this green tariff subscription. Used for customer service documentation and program management.',
    `number_of_blocks` STRING COMMENT 'Quantity of renewable energy blocks subscribed by the customer. Used with block_size_kwh to calculate total monthly renewable allocation.',
    `premium_rate_per_kwh` DECIMAL(18,2) COMMENT 'Additional charge per kilowatt-hour (kWh) for renewable energy above standard electricity rates. Expressed in dollars per kWh. This premium funds renewable generation and REC procurement.',
    `program_capacity_mw` DECIMAL(18,2) COMMENT 'Total generation capacity in megawatts (MW) allocated to this green tariff program. Used for community solar and dedicated facility programs to track subscription against available capacity.',
    `program_name` STRING COMMENT 'Name of the green tariff or renewable energy program the customer has enrolled in. Identifies the specific utility renewable offering.. Valid values are `Green Power|Community Solar|100% Renewable|Renewable Choice|Clean Energy Option|Solar Share`',
    `program_type` STRING COMMENT 'Classification of the renewable program structure. Distinguishes between utility green tariff, community solar subscription, renewable energy certificate (REC) purchase, or behind-the-meter (BTM) generation programs.. Valid values are `green_tariff|community_solar|renewable_choice|rec_purchase|btm_generation`',
    `rec_retirement_flag` BOOLEAN COMMENT 'Indicates whether Renewable Energy Certificates (RECs) are retired on behalf of the customer as part of this subscription. True means RECs are retired for customer environmental claims, false means utility retains RECs for RPS compliance.',
    `rec_tracking_system_code` STRING COMMENT 'Identifier for the REC tracking system registry where certificates are issued and retired. Examples include WREGIS, M-RETS, PJM-GATS, NEPOOL-GIS.',
    `rps_compliance_eligible_flag` BOOLEAN COMMENT 'Indicates whether renewable energy from this subscription counts toward utility Renewable Portfolio Standard (RPS) compliance obligations. False when RECs are retired for customer, true when utility retains RECs for compliance.',
    `subscription_end_date` DATE COMMENT 'Date when the green tariff subscription terminates or expires. Nullable for open-ended subscriptions without a fixed term.',
    `subscription_number` STRING COMMENT 'Externally visible unique identifier for the green tariff subscription. Used in customer communications and billing statements.',
    `subscription_percentage` DECIMAL(18,2) COMMENT 'Percentage of customer electricity usage sourced from renewable energy under this subscription. Ranges from 0.00 to 100.00 percent. Used when allocation method is percentage-based.',
    `subscription_rec_retirement` BIGINT COMMENT 'FK to renewable.rec_certificate.rec_certificate_id — Green tariff subscriptions trigger REC retirements on behalf of the customer. Linking subscription to retired RECs supports audit trail and program integrity.',
    `subscription_start_date` DATE COMMENT 'Date when the green tariff subscription becomes effective and renewable energy allocation begins. Used for billing cycle alignment and REC retirement tracking.',
    `subscription_status` STRING COMMENT 'Current lifecycle status of the green tariff subscription. Indicates whether the subscription is actively providing renewable energy credits to the customer.. Valid values are `active|pending|suspended|cancelled|expired|waitlisted`',
    `tariff_schedule_reference` STRING COMMENT 'Reference to the approved utility tariff schedule governing this green tariff program. Links to the official rate schedule filed with and approved by the Public Utility Commission (PUC).',
    `total_kwh_allocated_lifetime` DECIMAL(18,2) COMMENT 'Cumulative total kilowatt-hours (kWh) of renewable energy allocated to this customer subscription since enrollment. Used for customer reporting and program impact tracking.',
    `total_premium_paid_lifetime` DECIMAL(18,2) COMMENT 'Cumulative total premium amount paid by customer for this green tariff subscription since enrollment. Expressed in dollars. Used for customer value analysis and program revenue tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this green tariff subscription record was last modified. Used for audit trail and change tracking.',
    `waitlist_entry_date` DATE COMMENT 'Date when customer was placed on the program waitlist. Used to manage first-come-first-served allocation when capacity becomes available.',
    `waitlist_position` STRING COMMENT 'Customer position in the program waitlist queue when subscription status is waitlisted. Populated only when program capacity is full and customer is awaiting availability.',
    CONSTRAINT pk_green_tariff_subscription PRIMARY KEY(`green_tariff_subscription_id`)
) COMMENT 'Customer subscription record for utility green tariff, community solar, or renewable choice programs where customers elect to source a percentage or fixed volume of their electricity from renewable sources. Captures customer account reference, program name (Green Power, Community Solar, 100% Renewable), subscription percentage or block size (kWh/month), premium rate ($/kWh), subscription start/end date, REC retirement on behalf of customer flag, allocation method (pro-rata, fixed block), and subscription status. SSOT for green tariff and community solar program enrollment within the renewable domain. Supports program management, REC retirement tracking, and customer billing premium calculations.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` (
    `der_program_enrollment_id` BIGINT COMMENT 'Unique identifier for this specific enrollment relationship between a DER and a DR program. Primary key.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to the distributed energy resource enrolled in this DR program',
    `dr_program_id` BIGINT COMMENT 'Foreign key linking to the demand response program in which the DER is enrolled',
    `enrolled_capacity_kw` DECIMAL(18,2) COMMENT 'Committed load reduction or generation capacity in kilowatts that this specific DER has enrolled for this specific DR program. May differ from nameplate capacity and varies by program based on contract terms.',
    `enrollment_date` DATE COMMENT 'Date when the DER was enrolled into this specific DR program. Marks the start of the enrollment relationship.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment. Active indicates the DER is currently participating. Suspended indicates temporary pause. Terminated indicates enrollment has ended. Pending indicates enrollment is awaiting approval or activation.',
    `enrollment_term_end_date` DATE COMMENT 'End date of the current enrollment contract term for this DER in this DR program. Null for open-ended enrollments. Used for contract expiration and renewal workflows.',
    `enrollment_term_start_date` DATE COMMENT 'Start date of the current enrollment contract term for this DER in this DR program. Used for contract lifecycle management and renewal tracking.',
    `opt_out_count` STRING COMMENT 'Number of times the DER owner has opted out of dispatched DR events for this program. Used to track compliance with program rules and assess penalties if applicable.',
    `participation_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of dispatched DR events for this program that this DER successfully participated in. Calculated as (events_participated / events_dispatched) * 100. Used for performance tracking and incentive settlement.',
    `termination_date` DATE COMMENT 'Date when this enrollment was terminated. Null for active enrollments. Populated when enrollment_status transitions to Terminated.',
    `termination_reason` STRING COMMENT 'Business reason for enrollment termination. Examples: Customer Request, Non-Performance, Program Ended, DER Decommissioned, Contract Expiration. Null for active enrollments.',
    `total_incentive_payments_usd` DECIMAL(18,2) COMMENT 'Cumulative incentive payments in USD paid to the DER owner for participation in this specific DR program since enrollment. Aggregated from individual event settlements and capacity payments.',
    CONSTRAINT pk_der_program_enrollment PRIMARY KEY(`der_program_enrollment_id`)
) COMMENT 'This association product represents the enrollment contract between a distributed energy resource and a demand response program. It captures the business relationship where a single DER asset participates in multiple DR programs simultaneously (e.g., ISO capacity market, utility peak-time rebate, emergency DR, VPP aggregation), each with distinct contract terms, capacity commitments, settlement rules, and performance history. Each record links one DER to one DR program with enrollment-specific attributes including dates, capacity commitments, participation rates, incentive payments, and opt-out history that exist only in the context of this specific enrollment relationship.. Existence Justification: In energy utilities operations, a single DER asset (e.g., solar+storage system) routinely enrolls in multiple demand response programs simultaneously to optimize revenue and meet grid service obligations. For example, a battery storage system may be enrolled in an ISO capacity market program, a utility peak-time rebate program, an emergency DR program, and a VPP aggregation program at the same time. Each enrollment is a distinct business contract with its own capacity commitment, settlement rules, term dates, performance tracking, and incentive payments. The business actively manages this portfolio of enrollments per asset, tracking enrollment status, participation rates, opt-out history, and cumulative payments for each DER-program combination.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` (
    `battery_vendor_service_agreement_id` BIGINT COMMENT 'Unique identifier for this battery asset-vendor service agreement record. Primary key.',
    `battery_storage_asset_id` BIGINT COMMENT 'Foreign key linking to the battery storage asset receiving vendor services',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services to the battery asset',
    `annual_service_fee_usd` DECIMAL(18,2) COMMENT 'Annual recurring service fee charged by this vendor for this battery asset. Used for O&M cost forecasting and vendor cost comparison.',
    `contract_end_date` DATE COMMENT 'Expiration date of this vendor service contract. Critical for contract renewal planning and ensuring continuous service coverage for battery assets.',
    `contract_start_date` DATE COMMENT 'Effective start date of this vendor service contract for the battery asset. Used to track contract lifecycle and determine active service agreements.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this vendor service contract. Active contracts are monitored for SLA compliance; expired contracts trigger renewal workflows.',
    `contract_value_usd` DECIMAL(18,2) COMMENT 'Total contract value in USD for this vendor service agreement over the contract period. Used for budget tracking and vendor spend analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was created in the system.',
    `installation_contractor` STRING COMMENT 'Name of the engineering, procurement, and construction (EPC) contractor that installed the battery storage system. [Moved from battery_storage_asset: This attribute currently stores a single contractor name on the battery asset, but in reality represents a specific vendor relationship. Should be modeled as a service_contract_type=epc_contractor record in the association, allowing multiple contractors to be tracked if the asset had phased construction or multiple EPC firms involved.]',
    `last_service_date` DATE COMMENT 'Date of the most recent service performed by this vendor on this battery asset. Used to track service frequency and schedule preventive maintenance.',
    `next_scheduled_service_date` DATE COMMENT 'Date of the next scheduled preventive maintenance or inspection by this vendor for this battery asset. Used for service planning and outage coordination.',
    `performance_score` DECIMAL(18,2) COMMENT 'Vendor performance score specific to this battery asset, based on SLA compliance, response time, service quality, and asset availability impact. Used for vendor management and contract renewal decisions.',
    `primary_contact_email` STRING COMMENT 'Email address for the vendor contact responsible for this battery asset. Used for service request submission and SLA tracking.',
    `primary_contact_name` STRING COMMENT 'Name of the vendor representative responsible for servicing this specific battery asset. May differ from the vendor master contact for large vendors serving multiple sites.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the vendor contact responsible for this battery asset. Used for emergency response and service coordination.',
    `response_time_sla_hours` DECIMAL(18,2) COMMENT 'Contractually committed response time in hours for this vendor to respond to service requests for this battery asset. SLA varies by vendor type and asset criticality.',
    `service_contract_type` STRING COMMENT 'Type of service contract this vendor provides for the battery asset. Identifies the vendors role in the multi-vendor service ecosystem (battery OEM for cell warranty, inverter supplier for power conversion equipment, BMS provider for control systems, O&M contractor for ongoing operations).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was last updated.',
    `warranty_coverage_type` STRING COMMENT 'Type of warranty coverage this vendor provides for the battery asset. Battery OEMs typically provide capacity guarantees (e.g., 80% capacity after 10 years), while other vendors may provide equipment replacement or performance guarantees.',
    CONSTRAINT pk_battery_vendor_service_agreement PRIMARY KEY(`battery_vendor_service_agreement_id`)
) COMMENT 'This association product represents the service contract relationship between battery storage assets and their vendors. Each battery storage system requires multiple vendors for different service types (battery OEM, inverter supplier, BMS provider, O&M contractor), and each vendor provides services to multiple battery assets. Each record captures vendor-specific contract terms, warranty coverage, and SLA commitments that exist only in the context of this specific asset-vendor relationship.. Existence Justification: In energy utilities operations, battery storage assets require multiple specialized vendors simultaneously: the battery cell OEM provides capacity warranty, the inverter supplier maintains power conversion equipment, the BMS provider supports control systems, and O&M contractors handle daily operations. Each vendor relationship has distinct contract terms, SLA commitments, warranty coverage types, and performance metrics. This is an operational M:N relationship that asset managers actively maintain, not an analytical correlation.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` (
    `der_service_assignment_id` BIGINT COMMENT 'Primary key for the der_service_assignment association',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the field crew performing the service',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to the DER installation being serviced',
    `work_order_id` BIGINT COMMENT 'Reference to the work order authorizing this service assignment. Links to work management system for cost tracking and compliance documentation.',
    `assignment_date` DATE COMMENT 'Date when the crew was assigned to service this DER site. Corresponds to maintenance_assignment_date from detection data.',
    `compliance_inspection_flag` BOOLEAN COMMENT 'Indicates whether this service includes regulatory compliance inspection activities (IEEE 1547 testing, interconnection agreement verification, safety certification).',
    `crew_specialization_match_score` STRING COMMENT 'Calculated score (0-100) indicating how well the crews certifications and equipment match the DER technology requirements. Solar PV crews score higher for solar sites, storage-certified crews for battery systems. Used for optimal crew assignment.',
    `last_service_date` DATE COMMENT 'Date when the crew most recently completed service at this DER site. Used to calculate next service due date and track service history. Identified in detection data.',
    `maintenance_type` STRING COMMENT 'Classification of the service activity performed. Preventive maintenance includes scheduled inspections and routine servicing. Corrective maintenance addresses identified issues. Emergency repair for unplanned outages. Storm restoration for weather-related damage. Identified in detection data.',
    `next_scheduled_service_date` DATE COMMENT 'Planned date for the next service visit by this crew to this DER site. Used for maintenance schedule optimization and crew dispatch planning. Identified in detection data.',
    `service_cost_amount` DECIMAL(18,2) COMMENT 'Total cost for this service assignment including labor, equipment, materials, and travel. Used for DER maintenance cost tracking and budget management.',
    `service_duration_hours` DECIMAL(18,2) COMMENT 'Actual or estimated duration in hours for the service activity. Used for crew utilization tracking and labor cost allocation.',
    `service_frequency_days` STRING COMMENT 'Planned interval in days between service visits for this DER-crew pairing. Used for preventive maintenance scheduling optimization. Identified in detection data.',
    `service_status` STRING COMMENT 'Current status of the service assignment. Tracks lifecycle from scheduling through completion.',
    CONSTRAINT pk_der_service_assignment PRIMARY KEY(`der_service_assignment_id`)
) COMMENT 'This association product represents the service assignment relationship between distributed energy resources and field crews. It captures the operational assignment of crews to DER sites for maintenance, inspection, emergency repair, and storm restoration activities. Each record links one DER installation to one crew service event with attributes that track service history, crew specialization matching, and maintenance schedule optimization. SSOT for DER field service history and crew utilization tracking.. Existence Justification: In utility DER operations, field crews are assigned to service portfolios of distributed generation sites on rotating schedules driven by maintenance type, technology specialization, and geographic proximity. A single DER installation receives service from multiple crews over its lifecycle (preventive maintenance crews, emergency repair crews, storm restoration crews, commissioning support crews). Each crew services many DER sites across their service territory. The business actively manages these service assignments with work orders, tracks service history per DER asset for compliance, and optimizes crew-to-DER matching based on technology specialization (solar vs storage vs wind).';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` (
    `ppa_vendor_participation_id` BIGINT COMMENT 'Unique identifier for this vendor participation record in a PPA contract. Primary key for the association.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to the renewable energy PPA contract. Each participation record is associated with exactly one PPA contract.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record. Each participation record is associated with exactly one vendor playing a specific role in the PPA.',
    `contact_email_for_role` STRING COMMENT 'Email address of the role-specific contact person for this PPA contract. Used for contract-specific communications, settlement inquiries, and operational coordination for this vendors role in this PPA.',
    `contact_person_for_role` STRING COMMENT 'Name of the specific individual at the vendor organization who serves as the primary contact for this PPA contract and role. May differ from the vendors primary_contact_name in the vendor master record because large vendors assign different account managers to different contracts or roles.',
    `contact_phone_for_role` STRING COMMENT 'Phone number of the role-specific contact person for this PPA contract. Used for urgent operational issues, curtailment notifications, and real-time coordination specific to this vendors role in this PPA.',
    `contract_role` STRING COMMENT 'The specific role this vendor plays in the PPA contract. Counterparty = the IPP/generator, scheduling_coordinator = entity managing energy schedules with ISO/RTO, transmission_provider = entity providing transmission service, rec_administrator = entity managing REC tracking and transfer, credit_support_provider = entity providing letters of credit or guarantees, metering_agent = entity responsible for meter data, settlement_agent = entity calculating and processing payments. A single PPA typically involves 3-6 vendors in different roles.',
    `credit_support_amount` DECIMAL(18,2) COMMENT 'Dollar amount of credit support (letter of credit, cash collateral, parent guarantee) required from or provided to this vendor for their role in this specific PPA contract. Counterparties typically provide credit support to the utility; transmission providers may require credit support from the utility. Amount is specific to this PPA contract and vendor role combination.',
    `credit_support_requirement` STRING COMMENT 'Description of credit support mechanisms required from the counterparty, such as letters of credit, parent guarantees, or performance bonds, to mitigate counterparty credit risk. [Moved from ppa_contract: Credit support requirements vary by vendor and role within a PPA. The counterparty provides credit support to the utility, but the utility may need to provide credit support to the transmission provider. The amount and form of credit support is vendor-role-specific, not a single contract-level attribute. Should be modeled as credit_support_amount in the association.]',
    `participation_end_date` DATE COMMENT 'Date when this vendor ceased performing their role in this PPA contract. NULL if vendor is currently active in this role. Populated when vendors are replaced or when the PPA terminates. Supports historical tracking of vendor role changes.',
    `participation_start_date` DATE COMMENT 'Date when this vendor began performing their role in this PPA contract. May differ from the PPA effective_start_date if vendors are added or replaced during the contract term. Supports vendor role transition tracking and historical vendor participation analysis.',
    `participation_status` STRING COMMENT 'Current status of this vendors participation in their PPA contract role. Active = currently performing role, suspended = temporarily not performing (e.g., during dispute resolution), terminated = role ended, replaced = vendor was substituted by another vendor in the same role. Supports operational tracking of multi-party PPA administration.',
    `payment_terms` STRING COMMENT 'Vendor-specific payment terms for this PPA contract role. Defines payment schedule, invoice requirements, and settlement timing specific to this vendors role. May differ from the vendors standard payment terms in their master record because PPA contracts often have specialized payment structures (e.g., monthly energy payments to counterparty, quarterly REC transfer payments to administrator).',
    `performance_guarantee_terms` STRING COMMENT 'Vendor-specific performance guarantee obligations for this PPA contract role. Defines availability targets, response time requirements, service level agreements, and penalty/liquidated damages provisions specific to this vendors role. Counterparties have energy delivery guarantees, scheduling coordinators have scheduling accuracy requirements, REC administrators have transfer timing requirements.',
    `settlement_frequency` STRING COMMENT 'Frequency at which payments and obligations are settled with this specific vendor for their role in the PPA. Energy counterparties typically settle monthly, REC administrators quarterly, transmission providers monthly. This is contract-role-specific and may differ from standard vendor terms.',
    `vendor_specific_pricing_terms` STRING COMMENT 'Detailed pricing or fee structure for this vendors services in their PPA contract role. Scheduling coordinators charge per-MWh scheduling fees, REC administrators charge per-REC-transferred fees, transmission providers charge per-MW-month reservation fees. These are contract-specific and may differ from standard vendor pricing.',
    CONSTRAINT pk_ppa_vendor_participation PRIMARY KEY(`ppa_vendor_participation_id`)
) COMMENT 'This association product represents the contractual participation of vendors in renewable energy Power Purchase Agreement (PPA) contracts. Each record links one PPA contract to one vendor with a specific role (counterparty/IPP, scheduling coordinator, transmission provider, REC administrator, credit support provider). Captures vendor-specific contract terms including payment terms, settlement frequency, credit support obligations, and performance guarantees that vary by vendor role within the same PPA. Supports multi-party PPA administration, vendor role management, and contract-specific commercial terms tracking.. Existence Justification: In renewable energy PPA operations, a single PPA contract involves multiple vendors in distinct roles: the counterparty/IPP who generates the energy, scheduling coordinators who manage ISO/RTO schedules, transmission providers who deliver the power, REC administrators who track renewable attributes, and credit support providers. Conversely, a single vendor (especially large IPPs or specialized service providers) participates in multiple PPA contracts across different projects. The utility actively manages these multi-party relationships with contract-role-specific terms, payment schedules, and performance obligations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_rps_obligation_id` FOREIGN KEY (`rps_obligation_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`rps_obligation`(`rps_obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_original_settlement_ppa_settlement_id` FOREIGN KEY (`original_settlement_ppa_settlement_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_settlement`(`ppa_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_primary_ppa_contract_id` FOREIGN KEY (`primary_ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_primary_der_registry_id` FOREIGN KEY (`primary_der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_tertiary_der_registry_id` FOREIGN KEY (`tertiary_der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_primary_der_registry_id` FOREIGN KEY (`primary_der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_battery_der_registry_id` FOREIGN KEY (`battery_der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_generation_der_registry_id` FOREIGN KEY (`generation_der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_primary_incentive_program_id` FOREIGN KEY (`primary_incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ADD CONSTRAINT `fk_renewable_green_tariff_subscription_renewable_rec_certificate_id` FOREIGN KEY (`renewable_rec_certificate_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate`(`renewable_rec_certificate_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ADD CONSTRAINT `fk_renewable_der_program_enrollment_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ADD CONSTRAINT `fk_renewable_battery_vendor_service_agreement_battery_storage_asset_id` FOREIGN KEY (`battery_storage_asset_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`battery_storage_asset`(`battery_storage_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ADD CONSTRAINT `fk_renewable_der_service_assignment_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ADD CONSTRAINT `fk_renewable_ppa_vendor_participation_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`renewable` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `energy_utilities_ecm`.`renewable` SET TAGS ('dbx_domain' = 'renewable');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Registry ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Technician Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ems Node Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `btm_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'Behind-the-Meter (BTM) Generation Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `curtailment_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Capable Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `demand_response_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `der_name` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `der_type` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `der_type` SET TAGS ('dbx_value_regex' = 'solar_pv|battery_storage|wind|fuel_cell|combined_heat_power|microturbine');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `derms_system_code` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) System ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `export_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Limit (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `forecast_provider` SET TAGS ('dbx_business_glossary_term' = 'Forecast Provider');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `incentive_program_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost (USD)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `interconnection_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `nameplate_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `nem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'commissioned|operational|offline|decommissioned|suspended|testing');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `ownership_structure` SET TAGS ('dbx_business_glossary_term' = 'Ownership Structure');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `ownership_structure` SET TAGS ('dbx_value_regex' = 'customer_owned|third_party_owned|utility_owned|community_shared');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `poi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection (POI) Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `rec_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `rps_compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Tier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `smart_inverter_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Smart Inverter Capable Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `storage_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ALTER COLUMN `technology_class` SET TAGS ('dbx_business_glossary_term' = 'Technology Class');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` SET TAGS ('dbx_subdomain' = 'program_incentives');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `renewable_rec_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `attestation_document_id` SET TAGS ('dbx_business_glossary_term' = 'Attestation Document ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Scenario Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Aggregation ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `curtailment_mwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `eligibility_flags` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flags');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `facility_commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Commercial Operation Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `facility_county` SET TAGS ('dbx_business_glossary_term' = 'Facility County');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `facility_state` SET TAGS ('dbx_business_glossary_term' = 'Facility State');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `generation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Generation Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `generation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `grid_injection_point` SET TAGS ('dbx_business_glossary_term' = 'Grid Injection Point');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `issuing_registry` SET TAGS ('dbx_business_glossary_term' = 'Issuing Registry');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Market Value United States Dollar (USD)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'rps_compliance|voluntary_green_power|export_compliance|corporate_sustainability|carbon_offset');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `rps_obligation_period` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Obligation Period');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = 'solar_pv|wind|hydroelectric|biomass|geothermal|landfill_gas');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `trading_platform` SET TAGS ('dbx_business_glossary_term' = 'Trading Platform');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `transfer_history_count` SET TAGS ('dbx_business_glossary_term' = 'Transfer History Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `rps_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Obligation ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Scenario Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `regulatory_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `acp_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment (ACP) Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `acp_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment (ACP) Paid Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `acp_rate_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment (ACP) Rate per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_percentage_achieved` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage Achieved');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_period_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Year');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'in_progress|compliant|shortfall|surplus|filed|under_review');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|draft|submitted|accepted|rejected|amended');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `filing_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Submission Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `last_reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `obligated_retail_sales_mwh` SET TAGS ('dbx_business_glossary_term' = 'Obligated Retail Sales Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `offshore_wind_carveout_mwh` SET TAGS ('dbx_business_glossary_term' = 'Offshore Wind Carve-Out Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `offshore_wind_carveout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Offshore Wind Carve-Out Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `projected_shortfall_mwh` SET TAGS ('dbx_business_glossary_term' = 'Projected Shortfall Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `projected_surplus_mwh` SET TAGS ('dbx_business_glossary_term' = 'Projected Surplus Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `recs_inventory_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificates (RECs) Inventory Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `recs_retired_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificates (RECs) Retired Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `required_renewable_mwh` SET TAGS ('dbx_business_glossary_term' = 'Required Renewable Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `required_renewable_percentage` SET TAGS ('dbx_business_glossary_term' = 'Required Renewable Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `solar_carveout_mwh` SET TAGS ('dbx_business_glossary_term' = 'Solar Carve-Out Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `solar_carveout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Solar Carve-Out Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `storage_carveout_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Carve-Out Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `storage_carveout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Carve-Out Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `base_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Base Price per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `base_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (Percent)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Years)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_price|indexed|escalating|hybrid|tolling');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contracted_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `contracted_energy_volume_mwh_annual` SET TAGS ('dbx_business_glossary_term' = 'Contracted Energy Volume (MWh) Annual');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `curtailment_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Compensation Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `curtailment_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `curtailment_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `curtailment_provision` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Provision');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `delivery_point_poi` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point / Point of Interconnection (POI)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `ferc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Reference');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `generation_source` SET TAGS ('dbx_business_glossary_term' = 'Generation Source');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `generation_source` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|battery_storage|biomass|geothermal');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `minimum_delivery_obligation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Minimum Delivery Obligation (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `performance_guarantee_terms` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Terms');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `price_escalation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Rate (Percent)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `price_escalation_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `pricing_node_pnode` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node (PNode)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `rec_ownership` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Ownership');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `rec_ownership` SET TAGS ('dbx_value_regex' = 'utility|counterparty|shared|unbundled');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `rec_transfer_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Transfer Terms');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `renewable_attribute_transfer` SET TAGS ('dbx_business_glossary_term' = 'Renewable Attribute Transfer');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `rps_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `rps_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Jurisdiction');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Settlement Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Facility ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Market Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `original_settlement_ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Settlement ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Power Plant Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `primary_ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Analyst Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `ancillary_services_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Charge Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `ancillary_services_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Percent');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percent');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `contracted_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Contracted Price per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `contracted_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `curtailment_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Credit Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `curtailment_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `curtailment_mwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `gross_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `gross_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `imbalance_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Charge Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `imbalance_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `metered_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Metered Generation Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `rec_quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity Transferred');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `rec_transfer_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Transfer Confirmed Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `rps_compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Year');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Calculation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `transmission_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Transmission Charge Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ALTER COLUMN `transmission_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` SET TAGS ('dbx_subdomain' = 'grid_operations');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `congestion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Causing Congestion Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Causing Transmission Outage Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `contingency_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `dispatch_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `forecast_renewable_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Renewable Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Constraint ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `actual_output_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Output (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `compliance_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Required Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `congestion_zone` SET TAGS ('dbx_business_glossary_term' = 'Congestion Zone');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailed_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Curtailed Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailed_energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailed Energy (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_credit_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Credit Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_credit_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Credit Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Curtailment End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_event_number` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason Description');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_status` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_status` SET TAGS ('dbx_value_regex' = 'initiated|active|restored|cancelled|expired');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_type` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `curtailment_type` SET TAGS ('dbx_value_regex' = 'economic|reliability|transmission_constraint|regulatory|environmental|operational');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `estimated_lost_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Revenue (USD)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `estimated_lost_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `forecast_accuracy_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Variance Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `grid_constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Grid Constraint Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `grid_constraint_type` SET TAGS ('dbx_value_regex' = 'transmission_congestion|voltage_limit|frequency_deviation|thermal_overload|stability_limit|none');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `instruction_source` SET TAGS ('dbx_business_glossary_term' = 'Instruction Source');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `instruction_source` SET TAGS ('dbx_value_regex' = 'iso_rto|adms|derms|operator|market|automatic');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `instruction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instruction Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `market_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Market Price per MWh');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `market_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `notification_lead_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `post_event_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Review Completed Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `ppa_rate_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Rate per MWh');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `ppa_rate_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `rec_adjustment_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Adjustment (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `rec_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Impact Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `review_findings` SET TAGS ('dbx_business_glossary_term' = 'Review Findings');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `rps_compliance_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Impact Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Account ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Service Premise ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `annual_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Annual True-Up Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `battery_storage_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Capacity (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `btm_system_type` SET TAGS ('dbx_business_glossary_term' = 'Behind-the-Meter (BTM) System Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `btm_system_type` SET TAGS ('dbx_value_regex' = 'solar_pv|solar_battery|wind|fuel_cell|chp|hybrid');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `credit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Expiry Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `cumulative_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credit Balance');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'NEM Enrollment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `export_credit_value` SET TAGS ('dbx_business_glossary_term' = 'Export Credit Value');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `export_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Limit (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `export_rate_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Export Rate per Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `gross_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Consumption (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `gross_generation_kwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'System Installation Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `installed_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `installer_company_name` SET TAGS ('dbx_business_glossary_term' = 'Installer Company Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `installer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Installer License Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `installer_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `interconnection_application_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `interconnection_application_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `inverter_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Inverter Manufacturer');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `inverter_model` SET TAGS ('dbx_business_glossary_term' = 'Inverter Model');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `inverter_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Inverter Serial Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `inverter_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `nem_program_type` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Program Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `nem_program_type` SET TAGS ('dbx_value_regex' = 'nem_1_0|nem_2_0|nem_3_0|nema|vnem|aggregated_nem');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `net_export_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Export (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `net_import_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Import (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `permission_to_operate_date` SET TAGS ('dbx_business_glossary_term' = 'Permission to Operate (PTO) Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'NEM Program Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|inactive');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `rec_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'NEM Account Termination Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'customer_request|system_removal|non_compliance|account_closure|relocation');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `true_up_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'True-Up Adjustment Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ALTER COLUMN `vpp_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Participation Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` SET TAGS ('dbx_subdomain' = 'grid_operations');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `interconnection_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Queue Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `cpcn_application_id` SET TAGS ('dbx_business_glossary_term' = 'Cpcn Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Scenario Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Network Upgrade Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Network Upgrade Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Engineer Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `transmission_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Request Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `affected_systems_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems Coordination Required Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Email');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Phone');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `applicant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `application_received_date` SET TAGS ('dbx_business_glossary_term' = 'Application Received Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `cluster_study_group` SET TAGS ('dbx_business_glossary_term' = 'Cluster Study Group');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `commercial_readiness_deposit_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Readiness Deposit Received Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|denied');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `expected_commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Commercial Operation Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `facilities_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Completion Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `facilities_study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `feasibility_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Completion Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `feasibility_study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `ferc_oatt_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'FERC OATT (Open Access Transmission Tariff) Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `generation_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Generation Capacity (MW - Megawatt)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `interconnection_agreement_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Executed Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `interconnection_facilities_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Facilities Cost Estimate');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `interconnection_service_type` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Service Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `interconnection_service_type` SET TAGS ('dbx_value_regex' = 'energy_resource|network_resource');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `iso_rto_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'ISO/RTO (Independent System Operator / Regional Transmission Organization) Jurisdiction');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `network_upgrade_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Network Upgrade Cost Estimate');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `poi_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection (POI) Voltage (kV - Kilovolt)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `queue_status` SET TAGS ('dbx_business_glossary_term' = 'Queue Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `queue_status` SET TAGS ('dbx_value_regex' = 'active|suspended|withdrawn|approved|in_service');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `site_control_documentation_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Control Documentation Received Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `storage_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (MW - Megawatt)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `storage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Storage Duration (Hours)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `study_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Deposit Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Study Phase');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `study_phase` SET TAGS ('dbx_value_regex' = 'feasibility|system_impact|facilities|completed|withdrawn');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `system_impact_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Completion Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `system_impact_study_start_date` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Configuration ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) Program ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Meter ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `activation_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Activation Window End Time');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `activation_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Activation Window Start Time');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `aggregation_type` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `aggregation_type` SET TAGS ('dbx_value_regex' = 'demand_response|storage_dispatch|solar_curtailment|mixed_der|wind_curtailment|load_shifting');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `average_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Average Performance Score');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Baseline Calculation Method');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `baseline_calculation_method` SET TAGS ('dbx_value_regex' = 'customer_baseline_load|day_ahead_forecast|historical_average|control_group');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `capacity_payment_rate_per_mw_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Payment Rate per Megawatt (MW) per Month');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `capacity_payment_rate_per_mw_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `communication_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Communication Latency (Milliseconds)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `dispatch_protocol` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Protocol');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `dispatch_protocol` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated|api_driven');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `geographic_zone` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `incentive_rate_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `incentive_rate_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `iso_rto_market_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Market ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `iso_rto_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Registration Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `iso_rto_registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending|not_registered|expired|rejected');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `last_dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Dispatch Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `maximum_dispatch_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dispatch Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `minimum_dispatch_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Dispatch Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `minimum_performance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Performance Threshold (Percent)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `participating_der_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Distributed Energy Resource (DER) Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `penalty_rate_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `penalty_rate_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `performance_measurement_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Interval (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (MW per Minute)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `regulatory_program_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `telemetry_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Interval (Seconds)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `telemetry_reporting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Reporting Enabled');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `total_aggregated_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Aggregated Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `total_dispatch_events_count` SET TAGS ('dbx_business_glossary_term' = 'Total Dispatch Events Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (Kilovolts)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `vpp_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `vpp_name` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `vpp_status` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ALTER COLUMN `vpp_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|decommissioned|testing');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `battery_storage_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Asset ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `asset_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Risk Assessment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `battery_der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `dr_program_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ems Node Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `failure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Inspection Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Technician Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Located Generation Asset ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Warranty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `annual_om_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operations and Maintenance (O&M) Cost (USD)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `annual_om_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Asset Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^BESS-[A-Z0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `capital_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Cost (USD)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `capital_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `charge_ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Charge Ramp Rate (MW per Minute)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `co_location_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Location Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `current_soc_percent` SET TAGS ('dbx_business_glossary_term' = 'Current State of Charge (SoC) Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Cycle Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `degradation_rate_percent_per_year` SET TAGS ('dbx_business_glossary_term' = 'Degradation Rate (Percent per Year)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `derms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) Integration Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `discharge_ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Discharge Ramp Rate (MW per Minute)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `expected_end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End of Life Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `iso_rto_market_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO/RTO Market Participant Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `iso_rto_registration_code` SET TAGS ('dbx_business_glossary_term' = 'ISO/RTO Registration ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `max_soc_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum State of Charge (SoC) Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `min_soc_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum State of Charge (SoC) Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `nerc_region` SET TAGS ('dbx_business_glossary_term' = 'NERC Region');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'commissioned|in_service|standby|maintenance|degraded|decommissioned');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|third_party_owned|customer_owned|joint_venture');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `poi_substation_name` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection (POI) Substation Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `primary_use_case` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Case');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `primary_use_case` SET TAGS ('dbx_value_regex' = 'energy_arbitrage|frequency_regulation|spinning_reserve|capacity|peak_shaving|renewable_firming');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `rated_energy_capacity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Rated Energy Capacity (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `rated_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Rated Power Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `round_trip_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Round-Trip Efficiency Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_city` SET TAGS ('dbx_business_glossary_term' = 'Site City');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_state` SET TAGS ('dbx_business_glossary_term' = 'Site State');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `site_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `storage_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Technology Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `storage_technology_type` SET TAGS ('dbx_value_regex' = 'lithium_ion|flow_battery|compressed_air|sodium_sulfur|lead_acid|other');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` SET TAGS ('dbx_subdomain' = 'grid_operations');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `generation_meter_read_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Meter Read Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `generation_der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Facility ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Aggregation ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Generation Availability Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (Percent)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `charge_discharge_mode` SET TAGS ('dbx_business_glossary_term' = 'Battery Charge/Discharge Mode');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `charge_discharge_mode` SET TAGS ('dbx_value_regex' = 'Charging|Discharging|Idle|Standby');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `curtailed_energy_kwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailed Energy (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `curtailment_flag` SET TAGS ('dbx_business_glossary_term' = 'Generation Curtailment Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Good|Questionable|Bad|Not_Validated');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `data_source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Source Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `daylight_saving_flag` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving Time Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency (Hz)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `gross_generation_kwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `interconnection_queue_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Queue Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `irradiance_w_per_m2` SET TAGS ('dbx_business_glossary_term' = 'Solar Irradiance (W/m²)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `lmp_energy_price` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Energy Component');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `market_settlement_point` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Point');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `meter_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Multiplier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `meter_read_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `meter_read_status` SET TAGS ('dbx_value_regex' = 'Final|Preliminary|Revised|Disputed|Voided');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `nem_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Credit Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `net_generation_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Generation (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'None|Planned|Forced|Maintenance|Curtailment');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `ppa_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Settlement Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `reactive_power_kvar` SET TAGS ('dbx_business_glossary_term' = 'Reactive Power (kVAR)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Method');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `read_method` SET TAGS ('dbx_value_regex' = 'Automatic|Manual|Estimated|Remote');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `read_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Source System');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `read_source` SET TAGS ('dbx_value_regex' = 'AMI|SCADA|MDM|Manual|DERMS|PI_Historian');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `rec_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `rec_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Serial Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `rec_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Vintage Year');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `state_of_charge_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery State of Charge (Percent)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `vee_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `vee_status` SET TAGS ('dbx_value_regex' = 'Valid|Estimated|Edited|Missing|Suspect|Override');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ALTER COLUMN `wind_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Meters Per Second)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` SET TAGS ('dbx_subdomain' = 'program_incentives');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `der_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Der Enrollment Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `dr_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Meter ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `baseline_methodology` SET TAGS ('dbx_business_glossary_term' = 'Baseline Methodology');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `baseline_methodology` SET TAGS ('dbx_value_regex' = 'customer_baseline_load|meter_before_meter_after|control_group|day_matching|regression');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'IEEE_2030_5|OpenADR_2_0b|DNP3|Modbus_TCP|SunSpec|proprietary');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `control_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Control Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `control_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `dispatch_priority` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Priority');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrolled_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Capacity (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrolled_energy_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Energy Capacity (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_application_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Application Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approval Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|opted_out|expired');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `enrollment_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `export_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Limit (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `import_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Import Limit (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `incentive_rate_per_kw` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate per Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `incentive_rate_per_kw` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `incentive_rate_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate per Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `incentive_rate_per_kwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `interconnection_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `last_dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Dispatch Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `last_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Last Opt-Out Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `opt_out_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Allowed Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `opt_out_count` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `opt_out_limit` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Limit');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'NEM|VPP|DR|RPS|storage_incentive|feed_in_tariff');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `rec_issuance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Issuance Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `telemetry_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `telemetry_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `telemetry_frequency_seconds` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Frequency (Seconds)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'customer_request|non_compliance|equipment_failure|program_closure|term_expiration|relocation');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `total_dispatch_count` SET TAGS ('dbx_business_glossary_term' = 'Total Dispatch Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `total_dispatched_energy_kwh` SET TAGS ('dbx_business_glossary_term' = 'Total Dispatched Energy (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `vpp_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant (VPP) Enrollment Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ALTER COLUMN `vpp_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|pending|suspended');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` SET TAGS ('dbx_subdomain' = 'program_incentives');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `administering_agency` SET TAGS ('dbx_business_glossary_term' = 'Administering Agency');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `application_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Application Window End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `application_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Application Window Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `budget_expended_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Expended Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `budget_expended_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `budget_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Remaining Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `budget_remaining_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `eligible_technology_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Technology Types');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `enrolled_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `enrolled_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Customer Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `enrollment_cap_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap Customer Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `enrollment_cap_mw` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cap (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'ratepayer|federal_grant|state_grant|utility_shareholder|carbon_credit|rps_acp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `incentive_rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate Structure');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `incentive_rate_structure` SET TAGS ('dbx_value_regex' = 'per_kw|per_mwh|per_rec|percentage_of_cost|fixed_amount|tiered');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `incentive_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate Unit');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `incentive_rate_unit` SET TAGS ('dbx_value_regex' = 'USD_per_kW|USD_per_MWh|USD_per_REC|percent|USD');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `incentive_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate Value');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `maximum_system_size_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum System Size (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `minimum_system_size_kw` SET TAGS ('dbx_business_glossary_term' = 'Minimum System Size (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|annual|per_mwh');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `payment_term_years` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Years');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_approval|expired');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'ITC|PTC|SREC|storage_incentive|interconnection_rebate|green_tariff');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `requires_interconnection_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Interconnection Approval');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `requires_rec_transfer` SET TAGS ('dbx_business_glossary_term' = 'Requires Renewable Energy Certificate (REC) Transfer');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` SET TAGS ('dbx_subdomain' = 'program_incentives');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `incentive_application_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Application ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Account ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `capex_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Expenditure Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `primary_incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `actual_installation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Installation Completion Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Email');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Phone');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `application_notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `application_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `approved_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Incentive Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `compliance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Compliance Conditions');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `compliance_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Required Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'not_submitted|incomplete|complete|under_review|approved|rejected');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `estimated_annual_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Generation (MWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `expected_installation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Installation Completion Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `incentive_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Incentive Calculation Method');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `incentive_calculation_method` SET TAGS ('dbx_value_regex' = 'per_watt|per_kwh|percentage_of_cost|fixed_amount|tiered_capacity');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `installer_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Installer Contractor Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `installer_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `installer_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `installer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Installer License Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_value_regex' = 'lump_sum|milestone_based|performance_based|annual_installments');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Project Capacity (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_address` SET TAGS ('dbx_business_glossary_term' = 'Project Location Address');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_city` SET TAGS ('dbx_business_glossary_term' = 'Project Location City');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Project Location Postal Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_state` SET TAGS ('dbx_business_glossary_term' = 'Project Location State');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_location_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `rec_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligibility Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `requested_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Incentive Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `review_stage` SET TAGS ('dbx_business_glossary_term' = 'Review Stage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `review_stage` SET TAGS ('dbx_value_regex' = 'initial_screening|technical_review|financial_review|management_approval|final_approval');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `total_project_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Project Cost');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` SET TAGS ('dbx_subdomain' = 'program_incentives');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `green_tariff_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Green Tariff Subscription ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Processor Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Power Plant Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Item Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `renewable_facility_power_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Facility ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'pro_rata|fixed_block|percentage_based|full_usage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `block_size_kwh` SET TAGS ('dbx_business_glossary_term' = 'Block Size Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `customer_allocated_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocated Capacity Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|call_center|in_person|mail|email');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `generation_source_type` SET TAGS ('dbx_business_glossary_term' = 'Generation Source Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `generation_source_type` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|biomass|geothermal|mixed_renewable');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `last_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Billing Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `monthly_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Premium Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `nem_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Credit Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `number_of_blocks` SET TAGS ('dbx_business_glossary_term' = 'Number of Blocks');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `premium_rate_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Per Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `program_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Program Capacity Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `program_name` SET TAGS ('dbx_value_regex' = 'Green Power|Community Solar|100% Renewable|Renewable Choice|Clean Energy Option|Solar Share');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'green_tariff|community_solar|renewable_choice|rec_purchase|btm_generation');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `rec_retirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Retirement Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `rps_compliance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `subscription_percentage` SET TAGS ('dbx_business_glossary_term' = 'Subscription Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|cancelled|expired|waitlisted');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `tariff_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Reference');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `total_kwh_allocated_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Total Kilowatt-Hour (kWh) Allocated Lifetime');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `total_premium_paid_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Paid Lifetime');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `waitlist_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`green_tariff_subscription` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` SET TAGS ('dbx_subdomain' = 'program_incentives');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` SET TAGS ('dbx_association_edges' = 'renewable.der_registry,demand.dr_program');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `der_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'DER Program Enrollment Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Program Enrollment - Der Registry Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `dr_program_id` SET TAGS ('dbx_business_glossary_term' = 'Der Program Enrollment - Dr Program Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `enrolled_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Capacity');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `enrollment_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `enrollment_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `opt_out_count` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Count');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `participation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_program_enrollment` ALTER COLUMN `total_incentive_payments_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Incentive Payments');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` SET TAGS ('dbx_association_edges' = 'renewable.battery_storage_asset,supply.vendor');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `battery_vendor_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Vendor Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `battery_storage_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Vendor Service Agreement - Battery Storage Asset Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Vendor Service Agreement - Vendor Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `annual_service_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Service Fee USD');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Contract Value USD');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `installation_contractor` SET TAGS ('dbx_business_glossary_term' = 'Installation Contractor');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `next_scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Service Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time SLA Hours');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `service_contract_type` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_vendor_service_agreement` ALTER COLUMN `warranty_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` SET TAGS ('dbx_association_edges' = 'renewable.der_registry,workforce.crew');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `der_service_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Der Service Assignment - Der Service Assignment Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Der Service Assignment - Crew Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Service Assignment - Der Registry Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `compliance_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Flag');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `crew_specialization_match_score` SET TAGS ('dbx_business_glossary_term' = 'Crew Specialization Match Score');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `next_scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Service Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `service_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Cost Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `service_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Duration');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `service_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_service_assignment` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` SET TAGS ('dbx_association_edges' = 'renewable.ppa_contract,supply.vendor');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `ppa_vendor_participation_id` SET TAGS ('dbx_business_glossary_term' = 'PPA Vendor Participation ID');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Vendor Participation - Renewable Ppa Contract Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Vendor Participation - Vendor Id');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_email_for_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Email for Role');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_email_for_role` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_email_for_role` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_person_for_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Person for Role');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_phone_for_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone for Role');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_phone_for_role` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contact_phone_for_role` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `contract_role` SET TAGS ('dbx_business_glossary_term' = 'Contract Role');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `credit_support_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Amount');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `credit_support_requirement` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Requirement');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `performance_guarantee_terms` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Terms');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_vendor_participation` ALTER COLUMN `vendor_specific_pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Vendor Specific Pricing Terms');
