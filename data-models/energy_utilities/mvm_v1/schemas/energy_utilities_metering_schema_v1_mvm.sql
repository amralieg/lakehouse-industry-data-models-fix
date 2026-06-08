-- Schema for Domain: metering | Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`metering` COMMENT 'Advanced metering infrastructure including smart meters, interval data collection, AMI head-end systems, meter reading schedules, VEE (Validation, Estimation, and Editing) processes, TOU and CPP rate programs, and meter asset lifecycle. Manages meter-to-cash data flow, MDM integration via Oracle Utilities MDM, and raw/validated interval data streams feeding billing, demand response, and grid operations domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`meter` (
    `meter_id` BIGINT COMMENT 'Unique identifier for the physical metering device. Primary key for the meter entity. System-of-record: Oracle Utilities MDM meter object.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: Meters are deployed under AMI capital projects (smart meter rollout programs). Linking meter to the funding capital project supports capex tracking, project closeout reporting, RAB allocation, and FER',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.class. Business justification: Meters belong to asset classes (residential single-phase, commercial polyphase, industrial CT-metered) defined in asset.class, which carries depreciation method, useful life, maintenance strategy, and',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: NERC CIP-007 requires individual smart meters with routable protocols and IP addresses to be registered as BES Cyber Assets. Meter has ip_address, mac_address, firmware_version — all CIP-tracked attri',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Meters must comply with regulatory obligations for accuracy (ANSI C12.20), testing frequency, certification. Supports compliance tracking, audit evidence, regulatory reporting on meter accuracy progra',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Meters are physically configured per rate schedule (TOU eligibility, demand thresholds, interval length). Billing validation requires confirming meter configuration matches the governing rate schedule',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: A physical meter is a capital asset requiring registration in the asset registry for FERC account coding, depreciation scheduling, RAB inclusion, and lifecycle management. Every utility asset manageme',
    `ami_head_end_id` BIGINT COMMENT 'FK to metering.ami_head_end.ami_head_end_id — Each smart meter is assigned to an AMI head-end system for communication management. Required for data collection scheduling and network management.',
    `accuracy_class` STRING COMMENT 'ANSI accuracy classification of the meter (e.g., Class 0.2, Class 0.5, Class 1.0, Class 2.0). Lower numbers indicate higher precision. Determines acceptable measurement error tolerance and testing requirements.',
    `ami_network_segment` STRING COMMENT 'Identifier of the AMI communication network segment or cell to which this meter is assigned. Used for network planning, troubleshooting, and load balancing across AMI infrastructure.',
    `communication_module_serial` STRING COMMENT 'Unique serial number of the communication module. Tracked separately from meter serial to support independent module replacement without replacing the entire meter. Used for module-level warranty and troubleshooting.',
    `communication_module_type` STRING COMMENT 'Technology type of the embedded or attached communication module enabling remote meter reading. RF Mesh uses radio frequency mesh networks; PLC uses power line carrier; Cellular uses mobile networks; Fiber uses optical networks; None for non-communicating meters.. Valid values are `RF Mesh|PLC|Cellular|Fiber|None`',
    `communication_protocol` STRING COMMENT 'Application-layer protocol used for meter-to-head-end communication (e.g., ANSI C12.22, DLMS/COSEM, SEP 2.0, Modbus). Determines data format, security features, and interoperability with AMI systems.',
    `configuration_effective_date` DATE COMMENT 'Date when the current operational configuration (interval length, TOU program, demand reset, channels) became active. Used for configuration versioning and historical data interpretation. Critical for billing accuracy during configuration changes.',
    `configuration_expiration_date` DATE COMMENT 'Date when the current operational configuration is scheduled to expire or be replaced. Nullable for open-ended configurations. Used for planned configuration change management and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter record was first created in the MDM system. Used for data lineage, audit trails, and system integration reconciliation. Distinct from installation date.',
    `current_rating_amps` DECIMAL(18,2) COMMENT 'Maximum continuous current the meter can measure in amperes. Typical values: 100A, 200A, 320A. Used to ensure meter capacity matches service load requirements.',
    `demand_reset_interval_minutes` STRING COMMENT 'Programmed interval in minutes for resetting the demand register (e.g., 15, 30 minutes). Determines how frequently peak demand is calculated and recorded. Critical for demand billing accuracy.',
    `disconnect_switch_status` STRING COMMENT 'Current position of the remote disconnect switch for meters with disconnect capability. Connected indicates service is on; Disconnected indicates service is off; Armed indicates ready for remote command; Not Applicable for meters without disconnect.. Valid values are `Connected|Disconnected|Armed|Not Applicable`',
    `firmware_version` STRING COMMENT 'Version identifier of the embedded software running on the meter device. Critical for security patching, feature enablement, and compatibility with head-end systems. Tracked for firmware upgrade campaigns.',
    `form` STRING COMMENT 'ANSI form designation describing the physical configuration and wiring arrangement of the meter (e.g., Form 2S, Form 12S, Form 16S). Determines socket compatibility and installation requirements.',
    `installation_date` DATE COMMENT 'Date the meter was physically installed at its current service location. Used for age tracking, warranty calculations, and lifecycle management. Distinct from manufacturing date.',
    `interval_length_minutes` STRING COMMENT 'Programmed interval duration in minutes for load profile data collection (e.g., 15, 30, 60 minutes). Determines granularity of consumption data for billing, demand response, and grid analytics. Configurable parameter tracked for versioning.',
    `ip_address` STRING COMMENT 'Assigned IP address for meters using IP-based communication protocols (cellular, fiber). Used for direct meter communication, remote diagnostics, and firmware updates. Confidential to prevent unauthorized access.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in this meter record. Used for change tracking, data synchronization, and audit compliance. Updated automatically on any record modification.',
    `lifecycle_status` STRING COMMENT 'Current state of the meter in its asset lifecycle. Installed indicates active deployment; In Stock indicates warehouse inventory; In Transit indicates shipment; Retired indicates end-of-life; Failed indicates defective; Under Test indicates lab testing.. Valid values are `Installed|In Stock|In Transit|Retired|Failed|Under Test`',
    `load_profile_channels_enabled` STRING COMMENT 'Comma-separated list of load profile channels currently enabled for data collection (e.g., kWh Delivered, kWh Received, kVARh, Voltage, Current). Defines which measurement streams are actively recorded in interval data.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the communication module network interface. Used for network device identification, AMI head-end provisioning, and communication diagnostics. Confidential to prevent network security risks.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the meter device (e.g., Landis+Gyr, Itron, Sensus, Elster, Aclara). Used for vendor management, warranty tracking, and firmware compatibility.',
    `meter_type` STRING COMMENT 'Classification of meter technology and capability level. AMI Smart Meter supports two-way communication and remote operations; Interval Meter records time-series consumption; Demand Meter tracks peak demand; Electromechanical is legacy analog; Electronic is digital non-communicating; Prepaid supports prepayment programs.. Valid values are `AMI Smart Meter|Interval Meter|Demand Meter|Electromechanical|Electronic|Prepaid`',
    `model_number` STRING COMMENT 'Manufacturer model designation identifying the specific meter product line and capabilities. Used for configuration management, firmware updates, and technical specifications lookup.',
    `module_firmware_version` STRING COMMENT 'Version identifier of the firmware running on the communication module, tracked separately from meter firmware. Critical for communication security patches and protocol updates.',
    `module_status` STRING COMMENT 'Current operational status of the communication module. Active indicates normal operation; Inactive indicates disabled but functional; Failed indicates hardware failure; Replaced indicates module swap; Not Installed for non-AMI meters.. Valid values are `Active|Inactive|Failed|Replaced|Not Installed`',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next required accuracy test or calibration. Calculated based on regulatory testing intervals (typically 5-15 years depending on meter type and jurisdiction). Used for test planning and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, field observations, or historical context not captured in structured fields. Used by field technicians and operations staff.',
    `number_of_elements` STRING COMMENT 'Count of independent metering elements within the device. Single-phase meters have 1 element; polyphase meters have 2 or 3 elements. Determines measurement capability for multi-phase services.',
    `ownership_status` STRING COMMENT 'Legal ownership classification of the meter asset. Utility Owned is standard for most deployments; Customer Owned for customer-purchased meters; Leased for rental arrangements; Third Party for meters owned by service providers.. Valid values are `Utility Owned|Customer Owned|Leased|Third Party`',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which this meter was procured. Used for procurement tracking, warranty validation, and vendor management. Links to financial and supply chain systems.',
    `register_configuration` STRING COMMENT 'Description of the meter register setup including number of dials, multiplier, and measurement units (kWh, kVARh, kW demand). Defines what consumption data the meter captures and how it is displayed.',
    `remote_disconnect_capable` BOOLEAN COMMENT 'Boolean flag indicating whether the meter has remote service disconnect/reconnect capability. True enables remote service control for collections, move-in/move-out, and emergency response. False requires manual field operations.',
    `removal_date` DATE COMMENT 'Date the meter was removed from service location. Nullable for currently installed meters. Used for lifecycle tracking, inventory management, and historical service point analysis.',
    `seal_number` STRING COMMENT 'Unique identifier of the tamper-evident seal applied to the meter cover. Used to detect unauthorized meter access, tampering, and theft. Recorded during installation and verified during inspections.',
    `seal_status` STRING COMMENT 'Current condition of the meter seal. Intact indicates no tampering; Broken indicates potential unauthorized access requiring investigation; Missing indicates seal loss; Not Applicable for meters without seals.. Valid values are `Intact|Broken|Missing|Not Applicable`',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number physically stamped on the meter device. Used for asset tracking, warranty claims, and field verification. SSOT for device identity.. Valid values are `^[A-Z0-9]{8,20}$`',
    `signal_strength_baseline_dbm` DECIMAL(18,2) COMMENT 'Baseline communication signal strength measurement in dBm at time of installation or last network optimization. Used to detect communication degradation and plan network improvements. Typical range: -110 to -40 dBm.',
    `test_date` DATE COMMENT 'Date of the most recent accuracy test or calibration performed on the meter. Used to track compliance with regulatory testing intervals and identify meters due for testing.',
    `voltage_class` STRING COMMENT 'Nominal voltage rating for which the meter is designed and certified. Determines appropriate deployment location (residential 120/240V, commercial 277/480V, primary voltage for large industrial).. Valid values are `120V|240V|277V|480V|Primary Voltage`',
    CONSTRAINT pk_meter PRIMARY KEY(`meter_id`)
) COMMENT 'Master record for every physical metering device deployed or managed by the utility — smart meters (AMI), interval meters, demand meters, and legacy electromechanical units. Captures device identity (serial number, manufacturer, model), firmware version, meter form factor, voltage class, current rating, number of elements, register configuration, seal status, and AMI head-end system assignment. Includes embedded communication module attributes: module type (RF mesh/PLC/cellular), module serial number, MAC/IP address, signal strength baseline, module firmware version, communication protocol, assigned AMI network segment, and module status — supporting independent module replacement tracking without a separate entity. Also captures the active and historical programmed operational configuration: interval length setting (15/30/60 min), TOU rate program assignment, demand reset interval, load profile channels enabled, remote disconnect/reconnect capability, and configuration effective dates for versioning. SSOT for meter asset identity, communication endpoint, and device configuration within the metering domain; links to the asset domain for full lifecycle management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`meter_point` (
    `meter_point_id` BIGINT COMMENT 'Unique identifier for the meter point (service delivery point). This is the primary key representing the logical location where energy consumption is measured, persisting across meter device swaps.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Service points must be assigned to balancing authority control areas for load aggregation, interchange scheduling, ACE calculation, and NERC CPS1/CPS2 compliance reporting. Core operational requiremen',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to trading.delivery_point. Business justification: Meter points must be mapped to ISO/RTO trading delivery points (PNodes) for LMP settlement, energy scheduling, and market bid registration. Existing delivery_point.meter_id links to meter (not meter_p',
    `feeder_id` BIGINT COMMENT 'Identifier of the distribution feeder circuit serving this meter point. Critical for outage management, load balancing, and SAIDI/SAIFI reliability calculations.',
    `transformer_id` BIGINT COMMENT 'Identifier of the distribution transformer serving this meter point. Used for transformer loading analysis and secondary network modeling.',
    `ems_node_id` BIGINT COMMENT 'Foreign key linking to grid.ems_node. Business justification: EMS/power flow models require metered load at each network bus node. State estimation uses aggregated meter_point readings as pseudo-measurements at EMS nodes. Grid planners and operators expect each ',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: Demand response program enrollment, load forecasting, and TOU rate assignment require knowing which load zone a meter point belongs to. Utility load management and DR dispatch operations depend on thi',
    `meter_reading_route_id` BIGINT COMMENT 'Foreign key linking to metering.meter_reading_route. Business justification: A meter_point (service delivery point) is assigned to a specific meter reading route for scheduled reads. meter_point currently carries meter_reading_cycle (STRING) and meter_reading_frequency (STRING',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to distribution.network_segment. Business justification: Network hosting capacity studies and load flow analysis require knowing which distribution network segment each meter point (service delivery point) is located on. Utility planners and DER integration',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Service points subject to net metering obligations, interconnection standards, service quality requirements. Enables tariff compliance verification, regulatory reporting by service class, obligation t',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Transmission-connected meter points (large industrial loads, generation) are settled against a specific pricing node (pnode) for LMP-based wholesale settlement and congestion cost allocation. FERC-reg',
    `premise_id` BIGINT COMMENT 'Reference to the physical premise where this meter point is located. Links to the customer domain premise entity.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Meter point is the direct billing entity referenced by billing_service_agreement; its rate schedule governs billing determinant calculation and TOU bucket assignment. The plain rate_schedule_code colu',
    `scada_point_id` BIGINT COMMENT 'Foreign key linking to grid.scada_point. Business justification: Grid operators correlate real-time SCADA telemetry with metered service points for load monitoring, outage detection, and state estimation input validation. A domain expert expects meter_point to refe',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service points reference physical infrastructure assets (poles, pad-mount equipment, service cabinets) where metering is installed. Field operations, outage restoration, and capital planning require l',
    `service_point_id` BIGINT COMMENT 'Foreign key linking to metering.service_point. Business justification: meter_point represents the logical service delivery point (premise) at which a meter is installed, while service_point is the physical service delivery point master record. Linking meter_point to serv',
    `ami_collector_code` STRING COMMENT 'Identifier of the AMI data collector or concentrator device that aggregates meter data from this service point.. Valid values are `^[A-Z0-9]{6,20}$`',
    `ami_network_segment` STRING COMMENT 'AMI communication network segment or cell serving this meter point. Determines data collection routing and network performance monitoring.. Valid values are `^[A-Z0-9]{4,12}$`',
    `contracted_capacity_kw` DECIMAL(18,2) COMMENT 'Contracted or subscribed service capacity in kilowatts for this meter point. Applicable to large commercial and industrial customers.',
    `cpp_eligible_flag` BOOLEAN COMMENT 'Indicates whether this meter point is eligible for critical peak pricing programs. Used for demand response event targeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter point record was first created in the MDM system. Used for data lineage and audit trail.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite data quality score (0-100) reflecting completeness, accuracy, and consistency of meter point attributes. Used for data stewardship prioritization.',
    `der_capacity_kw` DECIMAL(18,2) COMMENT 'Nameplate capacity in kilowatts of distributed generation or storage interconnected at this meter point. Used for hosting capacity analysis.',
    `der_interconnection_flag` BOOLEAN COMMENT 'Indicates whether a distributed energy resource is interconnected at this meter point. Triggers special metering and grid integration requirements.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the meter point in decimal degrees. Used for GIS mapping, outage analysis, and field crew navigation.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the meter point in decimal degrees. Used for GIS mapping, outage analysis, and field crew navigation.',
    `interval_data_collection_flag` BOOLEAN COMMENT 'Indicates whether this meter point supports interval data collection (15-minute, 30-minute, or hourly). Required for TOU billing and demand response.',
    `interval_length_minutes` STRING COMMENT 'Length of each measurement interval in minutes for interval data collection (typically 15, 30, or 60). Determines data granularity for analytics.',
    `last_meter_reading_date` DATE COMMENT 'Date of the most recent successful meter reading for this service point. Used for billing cycle validation and data quality monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter point record was last updated. Used for change tracking and data synchronization.',
    `load_profile_class` STRING COMMENT 'Customer segment classification determining consumption patterns, rate structures, and demand response eligibility. Critical for load forecasting and grid planning.. Valid values are `residential|commercial|industrial|agricultural|street_lighting|municipal`',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether net energy metering is enabled for this service point due to behind-the-meter generation (solar, wind, CHP).',
    `network_topology_node` STRING COMMENT 'Logical node identifier in the electrical network topology model. Used by ADMS and DMS systems for network analysis and switching operations.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum recorded demand in kilowatts at this meter point. Used for capacity planning, rate design, and demand charge billing.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the service connection. Determines metering channel requirements and load balancing considerations.. Valid values are `single_phase|three_phase_wye|three_phase_delta|split_phase`',
    `service_activation_date` DATE COMMENT 'Date when service was first activated at this meter point. Marks the beginning of the service point lifecycle.',
    `service_deactivation_date` DATE COMMENT 'Date when service was permanently deactivated at this meter point. Null for active service points.',
    `service_point_status` STRING COMMENT 'Current lifecycle status of the meter point. Active indicates the point is in service and generating consumption data.. Valid values are `active|inactive|pending_activation|disconnected|abandoned`',
    `service_point_type` STRING COMMENT 'Classification of the commodity delivered at this meter point. Determines applicable rate schedules and measurement requirements.. Valid values are `electric|gas|water|steam|dual_fuel|multi_commodity`',
    `service_voltage_level` STRING COMMENT 'Voltage classification at which energy is delivered to this meter point. Determines metering accuracy requirements and applicable tariffs.. Valid values are `low_voltage|medium_voltage|high_voltage|extra_high_voltage`',
    `service_voltage_value` DECIMAL(18,2) COMMENT 'Nominal voltage in volts at which service is delivered (e.g., 120V, 240V, 480V, 13.8kV). Used for power quality monitoring and equipment compatibility verification.',
    `source_system_code` STRING COMMENT 'Code identifying the authoritative source system for this meter point record. Supports multi-system data integration and master data governance.. Valid values are `MDM|CIS|GIS|ADMS|SCADA`',
    `tou_enabled_flag` BOOLEAN COMMENT 'Indicates whether time-of-use rate pricing is active for this meter point. Requires interval data collection and TOU-capable metering.',
    `vee_processing_flag` BOOLEAN COMMENT 'Indicates whether meter data from this point undergoes VEE processing for data quality assurance before billing and analytics.',
    CONSTRAINT pk_meter_point PRIMARY KEY(`meter_point_id`)
) COMMENT 'Represents the physical service delivery point (premise) at which a meter is installed — the logical location where energy consumption is measured. Captures service point identifier, premise address, GPS coordinates, service voltage level, load class (residential, commercial, industrial), distribution feeder and transformer association, network topology node, and AMI network segment. Distinct from the meter device itself: a meter point persists even when meters are swapped. SSOT for the measurement location concept in the metering domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`meter_installation` (
    `meter_installation_id` BIGINT COMMENT 'Unique identifier for the meter installation record. Primary key for the meter installation entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.interconnection_agreement. Business justification: DER meter installations must be linked to the governing interconnection agreement to verify metering configuration (CT/PT ratios, bidirectional capability, accuracy class) matches agreement specificat',
    `customer_service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Meter installations are performed under specific service agreements that define rate schedules, metering requirements, and billing start dates. Supports billing determinism, regulatory compliance for ',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Meter installation establishes the billing cycle for the new service, governing meter read scheduling and invoice generation timing. This FK links the installation record to the billing cycle, require',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Physical meter installations at DER sites require bidirectional metering equipment. DER commissioning verification and permission-to-operate inspections link meter installation records to registered D',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: NEM meter installations must be tracked against the NEM account to verify program compliance, trigger permission-to-operate, and initiate NEM billing. Utilities require this link for NEM installation ',
    `planned_outage_window_id` BIGINT COMMENT 'Foreign key linking to outage.planned_outage_window. Business justification: Meter installations requiring service interruption must be coordinated with and scheduled within a planned outage window. This FK supports outage scheduling, customer advance notification compliance, ',
    `premise_id` BIGINT COMMENT 'Reference to the premise where the meter is physically installed. Provides geographic and customer context.',
    `meter_id` BIGINT COMMENT 'Reference to the physical meter device that was installed at the meter point. Links to the meter asset registry.',
    `meter_point_id` BIGINT COMMENT 'Reference to the meter point (service point) where the meter is installed. The logical location for energy measurement.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized and tracked the meter removal activity. Links to asset management and field service systems.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Meter installation configures CT ratio, PT ratio, and multiplier based on the governing rate schedule. The plain rate_schedule_code on meter_installation is a denormalization signal. This FK links the',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Large-scale AMI deployment programs require a Certificate of Public Convenience and Necessity (CPCN) from the commission. Each meter installation under an approved AMI program must reference the regul',
    `to_meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — Every installation record MUST reference the meter device being installed. This is the core association that enables meter-to-premise traceability. Without this FK, you cannot determine which meter is',
    `to_meter_point_id` BIGINT COMMENT 'FK to metering.meter_point.meter_point_id — Every installation record MUST reference the meter point (location) where the meter is installed. This completes the meter-device-to-location association that is the foundation of the metering domain.',
    `trade_id` BIGINT COMMENT 'Foreign key linking to trading.trade. Business justification: Behind-the-meter generation contracts and renewable PPAs require tracking which meter installation measures energy delivery for specific trade contracts. Critical for contract settlement, compliance v',
    `accuracy_class` STRING COMMENT 'Meter accuracy classification per ANSI C12.20 standard. Lower values indicate higher precision. Class 0.2 and 0.5 are used for revenue-grade metering.. Valid values are `0.2|0.5|1.0|2.0`',
    `ami_enabled_flag` BOOLEAN COMMENT 'Indicates whether the meter installation supports AMI (Advanced Metering Infrastructure) remote reading and two-way communication. True for smart meters with network connectivity.',
    `bidirectional_metering_flag` BOOLEAN COMMENT 'Indicates whether the meter can measure energy flow in both directions (consumption and generation). Required for NEM (Net Energy Metering) and DER (Distributed Energy Resource) customers.',
    `billing_end_date` DATE COMMENT 'Date when billing ends for this meter installation. Used for final bill calculation and account closure processing.',
    `billing_start_date` DATE COMMENT 'Date when billing begins for this meter installation. May differ from installation_date due to service agreement terms or proration rules.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the meter installation record was first created in the MDM (Meter Data Management) system. Used for audit trail and data lineage.',
    `ct_ratio` STRING COMMENT 'Current Transformer ratio in effect for this installation (e.g., 200:5, 400:5). Used for high-voltage metering where direct measurement is not feasible.',
    `end_reading` DECIMAL(18,2) COMMENT 'Meter register reading captured at the time of removal. Used to calculate final consumption and validate billing for the installation period.',
    `installation_date` DATE COMMENT 'Date when the meter was physically installed at the meter point. Marks the start of the installation period.',
    `installation_notes` STRING COMMENT 'Free-text field for technician notes captured during installation. May include site conditions, access issues, or special configuration details.',
    `installation_number` STRING COMMENT 'Business identifier for the meter installation record. Used for external reference and work order tracking.',
    `installation_reason_code` STRING COMMENT 'Business reason for the meter installation. Used for program tracking, cost allocation, and regulatory reporting.. Valid values are `new_service|meter_upgrade|meter_failure|ami_deployment|customer_request|regulatory_compliance`',
    `installation_status` STRING COMMENT 'Current lifecycle status of the meter installation. Active indicates the meter is currently in service at the meter point.. Valid values are `active|removed|pending|suspended|failed`',
    `installation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the meter installation was completed. Used for interval data alignment and VEE (Validation, Estimation, and Editing) processing.',
    `installation_type` STRING COMMENT 'Classification of the installation based on its intended duration and purpose. Permanent installations are standard service; temporary installations support construction or events.. Valid values are `permanent|temporary|test|emergency`',
    `meter_location_code` STRING COMMENT 'Physical location classification of the meter at the premise. Used for field service routing, safety planning, and AMI (Advanced Metering Infrastructure) signal strength analysis.. Valid values are `indoor|outdoor|basement|utility_room|pole_mount|pad_mount`',
    `multiplier` DECIMAL(18,2) COMMENT 'Multiplier factor applied to meter readings to calculate actual consumption. Used when Current Transformer (CT) or Potential Transformer (PT) ratios are in effect.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the service. Single-phase for residential; three-phase for commercial and industrial customers.. Valid values are `single_phase|three_phase_wye|three_phase_delta`',
    `pt_ratio` STRING COMMENT 'Potential Transformer ratio in effect for this installation (e.g., 7200:120). Used in conjunction with CT ratio for accurate high-voltage metering.',
    `reading_uom` STRING COMMENT 'Unit of measure for the meter readings. Typically kWh (Kilowatt-Hour) for electric meters, therms or ccf for gas meters. [ENUM-REF-CANDIDATE: kWh|MWh|kW|kVAh|kVArh|therms|ccf|mcf — 8 candidates stripped; promote to reference product]',
    `register_count` STRING COMMENT 'Number of registers (dials) on the meter. Multi-register meters support TOU (Time of Use) and demand metering programs.',
    `remote_disconnect_capable_flag` BOOLEAN COMMENT 'Indicates whether the meter has remote service disconnect/reconnect capability. Used for credit management and demand response programs.',
    `removal_date` DATE COMMENT 'Date when the meter was removed from the meter point. Marks the end of the installation period. Null for active installations.',
    `removal_notes` STRING COMMENT 'Free-text field for technician notes captured during removal. May include meter condition, seal integrity, or reasons for discrepancies in final readings.',
    `removal_reason_code` STRING COMMENT 'Business reason for the meter removal. Used for asset lifecycle tracking, failure analysis, and warranty claims.. Valid values are `meter_failure|service_disconnect|meter_upgrade|customer_move|testing|end_of_life`',
    `removal_timestamp` TIMESTAMP COMMENT 'Precise date and time when the meter was removed. Used for final interval data cutoff and back-billing calculations.',
    `seal_number_1` STRING COMMENT 'Primary tamper-evident seal number applied to the meter at installation. Used for security and regulatory audit purposes.',
    `seal_number_2` STRING COMMENT 'Secondary tamper-evident seal number applied to the meter at installation. Provides additional security for high-value or critical installations.',
    `service_amperage` DECIMAL(18,2) COMMENT 'Maximum service amperage rating at the meter point in amps. Determines meter sizing and load capacity.',
    `service_voltage` DECIMAL(18,2) COMMENT 'Nominal service voltage at the meter point in volts. Used for meter configuration, safety planning, and load analysis.',
    `start_reading` DECIMAL(18,2) COMMENT 'Meter register reading captured at the time of installation. Used as the baseline for consumption calculations during this installation period.',
    `test_date` DATE COMMENT 'Date when the meter was last tested for accuracy before or after installation. Used for regulatory compliance and quality assurance.',
    `test_result` STRING COMMENT 'Result of the most recent meter accuracy test. Passed indicates the meter meets accuracy standards; failed triggers meter replacement.. Valid values are `passed|failed|not_tested`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the meter installation record was last modified. Used for change tracking and data quality monitoring.',
    `vee_profile_code` STRING COMMENT 'Reference to the VEE (Validation, Estimation, and Editing) rule set applied to interval data from this installation. Determines data quality thresholds and estimation algorithms.',
    CONSTRAINT pk_meter_installation PRIMARY KEY(`meter_installation_id`)
) COMMENT 'Tracks the active and historical association between a meter device and a meter point — the physical installation record. Captures installation date, removal date, meter reading at installation (start index), meter reading at removal (end index), installation technician, seal numbers applied, multiplier/CT ratio in effect, and installation status. Enables meter-to-premise traceability for billing, VEE, and regulatory audit. Supports meter swap history and back-billing calculations.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`interval_reading` (
    `interval_reading_id` BIGINT COMMENT 'Unique identifier for the interval reading record. Primary key for raw interval energy consumption and demand data collected from AMI smart meters.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Interval consumption data feeds real-time control area load calculations for AGC signals, state estimation, and balancing authority settlement. Required for NERC compliance and operational balancing.',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: Interval readings during curtailment events must be flagged and reconciled for PPA settlement and RPS compliance. interval_reading has curtailment_flag but no FK to curtailment_event. Linking enables ',
    `cycle_id` BIGINT COMMENT 'Identifier of the billing cycle to which this interval reading contributes. Links interval data to the billing period for invoice generation and revenue recognition.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Interval data from DER meters feeds REC issuance, curtailment verification, and generation forecasting. REC certificate generation process requires validated interval readings linked to specific DER f',
    `dr_event_id` BIGINT COMMENT 'Foreign key linking to demand.dr_event. Business justification: interval_reading has demand_response_event_flag but no FK to the specific dr_event. Linking interval readings to the active DR event enables baseline comparison for settlement, VEE processing context ',
    `energy_schedule_id` BIGINT COMMENT 'Foreign key linking to trading.energy_schedule. Business justification: ISO/RTO settlement requires reconciling scheduled MWh (energy_schedule) against actual metered interval readings to calculate imbalance charges. This is a mandatory step in NERC/FERC settlement proces',
    `lmp_price_id` BIGINT COMMENT 'Foreign key linking to trading.lmp_price. Business justification: Raw interval consumption data must be priced using LMP at the meters pricing node for preliminary settlement calculations before VEE processing. Required for real-time cost allocation and interval bi',
    `meter_point_id` BIGINT COMMENT 'Identifier of the service point (delivery location) where energy consumption was measured. Represents the physical location of energy delivery.',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: NEM credit calculations and true-up processing are driven directly from interval readings for net-metered customers. interval_reading has net_metering_flag and reverse_flow_flag but no FK to nem_accou',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.event. Business justification: Interval readings with power_outage_flag=true must reference the causative outage event to support energy-not-served calculations, automated VEE estimation suppression during outages, and SAIDI/SAIFI ',
    `meter_id` BIGINT COMMENT 'Identifier of the smart meter device that generated this interval reading. Links to the physical AMI meter asset.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Interval readings are processed against rate schedules for TOU bucket assignment and billing determinant generation. The plain rate_schedule_code on interval_reading is a denormalization signal. This ',
    `to_meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — Raw interval readings must reference the meter device that produced them. This is the fundamental data provenance link for all consumption data.',
    `channel_number` STRING COMMENT 'Channel identifier on the meter device. Multi-channel meters track multiple measurement types (kWh delivered, kWh received, kW demand, voltage, power factor). Typically 1-99.. Valid values are `^[0-9]{1,3}$`',
    `collection_method` STRING COMMENT 'Method by which the interval data was collected. AMI_PUSH = meter initiated transmission, AMI_POLL = head-end system requested, MANUAL = field reading, ESTIMATED = system generated, SCADA = real-time system, IMPORT = bulk file load.. Valid values are `AMI_PUSH|AMI_POLL|MANUAL|ESTIMATED|SCADA|IMPORT`',
    `collection_run_code` BIGINT COMMENT 'Identifier of the batch collection run or polling cycle that retrieved this reading. Groups readings collected in the same operational batch for traceability and reprocessing.',
    `correction_reason_code` STRING COMMENT 'Code identifying the reason for manual correction or substitution of the original reading value. Examples: METER_ERROR, COMM_FAILURE, CUSTOMER_DISPUTE, DATA_QUALITY. Empty if no correction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interval reading record was first inserted into the MDM system. Audit field for data lineage and record creation tracking.',
    `data_completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of expected interval data received for the associated collection period. 100.00 = complete, <100.00 = partial data. Used for data quality monitoring and VEE prioritization.',
    `data_source_system` STRING COMMENT 'Name or identifier of the source system that provided this interval reading. Examples: AMI_HEAD_END, SCADA_HISTORIAN, MANUAL_ENTRY, BILLING_SYSTEM. Supports multi-source MDM environments.',
    `daylight_saving_flag` BOOLEAN COMMENT 'Indicates whether daylight saving time was in effect during this interval. True = DST active, False = standard time. Critical for accurate time-of-use rate application and demand response event timing.',
    `demand_response_event_flag` BOOLEAN COMMENT 'Indicates whether a demand response event was active during this interval. True = DR event in progress, False = normal operation. Used for curtailment measurement and settlement.',
    `estimation_method_code` STRING COMMENT 'Code identifying the estimation algorithm applied if the reading was estimated. Examples: LIKE_DAY, LINEAR_INTERPOLATION, AVERAGE_USAGE, ZERO_FILL. Empty for actual meter readings.',
    `interval_duration_minutes` STRING COMMENT 'Duration of the measurement interval in minutes. Common values: 15 (quarter-hourly), 30 (half-hourly), 60 (hourly). Supports variable interval lengths for different meter configurations.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the end of the measurement interval. Defines the close of the accumulation period for this reading.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking the beginning of the measurement interval. Represents the real-world event time when the meter began accumulating energy for this interval. Typically aligned to 15-minute or 60-minute boundaries.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this interval reading record. Tracks modifications during VEE processing, manual corrections, or reprocessing events.',
    `load_profile_segment` STRING COMMENT 'Customer load profile classification segment for this service point. Used for load forecasting, rate design, and demand response targeting. Examples: RESIDENTIAL_STANDARD, COMMERCIAL_SMALL, INDUSTRIAL_LARGE.',
    `meter_read_status` STRING COMMENT 'Status of the meter read operation that produced this interval. SUCCESS = complete read, PARTIAL = incomplete data, FAILED = read failure, TIMEOUT = communication timeout, COMM_ERROR = network error.. Valid values are `SUCCESS|PARTIAL|FAILED|TIMEOUT|COMM_ERROR`',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether this service point is enrolled in net energy metering (solar or DER generation). True = NEM active, False = standard consumption-only metering. Affects billing credit calculations.',
    `original_reading_value` DECIMAL(18,2) COMMENT 'Original raw reading value before any estimation, substitution, or manual correction. Preserved for audit trail and comparison with corrected values. Null if no correction occurred.',
    `power_outage_flag` BOOLEAN COMMENT 'Indicates whether a power outage was detected during this interval based on meter status flags or zero-consumption patterns. True = outage detected, False = normal operation.',
    `quality_code` STRING COMMENT 'Data quality indicator for the raw interval reading. RAW = actual meter reading, ESTIMATED = calculated by estimation algorithm, SUBSTITUTED = replaced due to validation failure, EDITED = manually corrected, REJECTED = failed validation, MISSING = no data received.. Valid values are `RAW|ESTIMATED|SUBSTITUTED|EDITED|REJECTED|MISSING`',
    `reading_value` DECIMAL(18,2) COMMENT 'Raw numeric value of the interval measurement as collected from the meter. Represents energy consumption (kWh) or demand (kW) depending on channel configuration. Immutable raw value before VEE processing.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when the interval reading was received by the head-end system or MDM platform. Used for latency analysis and data freshness monitoring. Distinct from the interval measurement time.',
    `reprocessing_flag` BOOLEAN COMMENT 'Indicates whether this interval reading has been reprocessed after initial load. True = reprocessed due to correction or VEE re-run, False = original processing. Supports data lineage tracking.',
    `reverse_flow_flag` BOOLEAN COMMENT 'Indicates whether energy flowed in reverse direction (customer generation exported to grid) during this interval. True = export/generation, False = import/consumption. Critical for NEM and DER settlement.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature at the service point location during the interval, if available from weather data integration. Used for weather normalization and load forecasting. Null if not available.',
    `time_zone_offset` STRING COMMENT 'UTC offset for the interval timestamps in ISO 8601 format (e.g., -05:00, +00:00). Ensures correct temporal alignment across service territories and daylight saving transitions.. Valid values are `^[+-]d{2}:d{2}$`',
    `tou_bucket` STRING COMMENT 'Time-of-use pricing period classification for this interval based on rate schedule and timestamp. Determines the applicable energy rate tier for billing calculations.. Valid values are `ON_PEAK|OFF_PEAK|SHOULDER|SUPER_OFF_PEAK|CRITICAL_PEAK`',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the reading value. kWh (kilowatt-hour) for energy consumption, kW (kilowatt) for demand, kVArh for reactive energy, kVAr for reactive demand, kVAh for apparent energy, kVA for apparent demand.. Valid values are `kWh|kW|kVArh|kVAr|kVAh|kVA`',
    `updated_by_user` STRING COMMENT 'User ID or system account that last modified this interval reading record. Supports audit trail and accountability for manual edits or system corrections.',
    `validation_exception_code` STRING COMMENT 'Code identifying the specific validation rule or exception that flagged this reading during VEE processing. Examples: HIGH_USAGE, NEGATIVE_VALUE, MISSING_INTERVAL, SPIKE_DETECTED. Empty if no exceptions.',
    `validation_status` STRING COMMENT 'Status of VEE (Validation, Estimation, and Editing) processing for this raw reading. PENDING = awaiting validation, VALIDATED = passed validation rules, FAILED = validation exceptions detected, BYPASSED = validation skipped.. Valid values are `PENDING|VALIDATED|FAILED|BYPASSED`',
    `voltage_level` STRING COMMENT 'Voltage classification of the service point where this interval was measured. LOW = residential/small commercial (<1kV), MEDIUM = commercial/industrial (1-35kV), HIGH = large industrial (35-230kV), TRANSMISSION = bulk power (>230kV).. Valid values are `LOW|MEDIUM|HIGH|TRANSMISSION`',
    CONSTRAINT pk_interval_reading PRIMARY KEY(`interval_reading_id`)
) COMMENT 'Raw interval energy consumption and demand data collected from AMI smart meters at sub-hourly or hourly granularity (typically 15-min or 60-min intervals). Stores channel identifier, interval start timestamp, interval end timestamp, raw kWh or kW value, quality code (raw/estimated/substituted), data collection method (AMI push, manual, estimated), head-end system receipt timestamp, and collection run reference. This is the foundational time-series dataset feeding Oracle Utilities MDM VEE processing, billing, demand response, and grid operations. Immutable raw record — validated versions are stored in validated_interval_reading. High-volume transactional entity; typical utility processes millions of interval records daily.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`meter_read` (
    `meter_read_id` BIGINT COMMENT 'Unique identifier for the meter read record. Primary key. Role: TRANSACTION_HEADER (scalar meter reading event with lifecycle and scheduling governance).',
    `account_id` BIGINT COMMENT 'Reference to the customer account responsible for this service point. Enables customer-level consumption reporting.',
    `ami_event_id` BIGINT COMMENT 'Unique identifier from the AMI head-end system for this read event. Used to correlate the scalar read with interval data and AMI system logs. Null for non-AMI reads.',
    `billing_service_agreement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_service_agreement. Business justification: Meter reads are processed and billed under a specific billing service agreement. This FK is required for billing run processing to apply the correct multiplier, rate schedule, and billing period from ',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Aggregated meter reads feed control area load profiles for interchange accounting and NERC reporting. Standard practice for balancing authority operations and compliance.',
    `cycle_id` BIGINT COMMENT 'Reference to the billing cycle for which this read was captured. Links the read to the billing run and invoice generation process.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Register-based reads from DER meters support NEM annual true-up calculations, monthly generation reporting, and capacity factor verification. NEM true-up process requires cumulative meter reads linked',
    `lmp_price_id` BIGINT COMMENT 'Foreign key linking to trading.lmp_price. Business justification: Retail interval customers are settled against nodal LMP prices. Linking meter_read to the prevailing lmp_price at read time is required for retail-to-wholesale settlement reconciliation and FERC EQR r',
    `meter_id` BIGINT COMMENT 'Reference to the physical meter device from which this reading was captured. Links to the meter asset registry.',
    `meter_reading_route_id` BIGINT COMMENT 'Foreign key linking to metering.meter_reading_route. Business justification: A scalar meter read is collected as part of a specific meter reading route execution. meter_read currently carries read_cycle_code (STRING) which is a denormalized reference to the route — this maps t',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: NEM billing requires meter reads to be directly associated with the NEM account for true-up calculations and export credit determination. Enables direct NEM billing reconciliation without joining thro',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: State PUC rules impose compliance obligations on meter reading frequency, estimated read limits, and read methodology. Linking meter_read to the governing obligation enables compliance reporting on es',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.event. Business justification: Meter reads flagged with power_outage_flag must be linked to the specific outage event for billing adjustment processing, VEE exception investigation, and NERC/PUC regulatory reporting of energy-not-s',
    `premise_id` BIGINT COMMENT 'Reference to the service premise where the meter is installed. Enables geographic and customer aggregation of reads.',
    `meter_point_id` BIGINT COMMENT 'Reference to the logical service point (delivery point) associated with this meter read. Used for billing and consumption analysis.',
    `rate_schedule_id` BIGINT COMMENT 'Reference to the rate schedule (tariff) in effect for this service point at the time of the read. Used to determine Time-of-Use (TOU) periods, Critical Peak Pricing (CPP) applicability, and billing determinants.',
    `register_id` BIGINT COMMENT 'Reference to the specific register on the meter (e.g., kWh delivered, kWh received, kVArh). Multi-register meters have multiple read records per read event.',
    `to_meter_point_id` BIGINT COMMENT 'FK to metering.meter_point.meter_point_id — Scalar meter reads must reference the meter point where the read was taken. Essential for billing cycle consumption calculation.',
    `vee_rule_id` BIGINT COMMENT 'Reference to the VEE (Validation, Estimation, and Editing) rule that processed this read. Links to the validation rule configuration for audit and troubleshooting.',
    `average_daily_usage` DECIMAL(18,2) COMMENT 'Consumption divided by consumption days. Expressed in kWh per day or MWh per day. Used for customer usage profiling, demand response eligibility, and anomaly detection.',
    `billed_flag` BOOLEAN COMMENT 'Indicates whether this meter read has been used in a billing run and invoice generation. True if billed; False if pending or unbilled. Used to prevent duplicate billing and support billing cycle reconciliation.',
    `consumption_days` STRING COMMENT 'Number of days between the current read date and the previous read date. Used to normalize consumption for billing and to calculate average daily usage.',
    `consumption_kwh` DECIMAL(18,2) COMMENT 'Calculated energy consumption for the period (current read value minus previous read value). Expressed in kilowatt-hours (kWh) or megawatt-hours (MWh). This is the billable quantity fed to the billing domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this meter read record was first created in the MDM (Meter Data Management) system. Used for data lineage and audit trails.',
    `demand_kw` DECIMAL(18,2) COMMENT 'Peak demand recorded during the read period, expressed in kilowatts (kW) or megawatts (MW). Captured for commercial and industrial customers on demand-based rate schedules. Null for residential meters without demand registers.',
    `demand_timestamp` TIMESTAMP COMMENT 'Date and time when the peak demand occurred during the read period. Used for Time-of-Use (TOU) and Critical Peak Pricing (CPP) rate application.',
    `estimation_method` STRING COMMENT 'Algorithm or rule used to estimate the read value when actual read was unavailable. Examples: HIST_AVG (historical average), PREV_YEAR (same period prior year), PRO_RATA (prorated from partial period), ADL (average daily load). Null for actual reads.',
    `exception_code` STRING COMMENT 'Code identifying any exception or anomaly detected during read capture or validation. Examples: HIGH_USAGE, LOW_USAGE, ZERO_CONSUMPTION, NEGATIVE_CONSUMPTION, TAMPER, COMM_FAILURE. Used to trigger investigation workflows.',
    `multiplier` DECIMAL(18,2) COMMENT 'Constant multiplier applied to the raw register reading to calculate actual consumption. Used for current transformer (CT) and potential transformer (PT) ratios on high-voltage meters. Default is 1.0 for direct-connected meters.',
    `previous_read_date` DATE COMMENT 'Date of the prior valid read for this register. Used to calculate the consumption period length (days between reads) and validate read sequence.',
    `previous_read_value` DECIMAL(18,2) COMMENT 'The register value from the prior valid read. Used to calculate consumption (current read minus previous read) and detect anomalies such as reverse flow or register rollover.',
    `read_date` DATE COMMENT 'The calendar date on which the meter reading was captured. Principal business event timestamp for billing cycle alignment and consumption period determination.',
    `read_frequency` STRING COMMENT 'The recurring interval at which reads are scheduled for this meter. Monthly: standard residential. Bi-monthly: some residential jurisdictions. Daily: large commercial/industrial or AMI. On-demand: special reads only.. Valid values are `monthly|bi-monthly|quarterly|daily|on-demand`',
    `read_method` STRING COMMENT 'Technical method used to capture the reading. Optical: infrared port. RF: radio frequency. PLC: power line carrier. Cellular: mobile network. Visual: technician reads display. Handheld: portable reader device.. Valid values are `optical|RF|PLC|cellular|visual|handheld`',
    `read_quality_code` STRING COMMENT 'Standardized code indicating the quality or exception condition of the read. Examples: OK (normal), EST (estimated), REV (reverse flow), OVF (overflow), PWR (power outage), TMR (tamper detected). Aligns with ANSI C12.19 quality flags.',
    `read_reason_code` STRING COMMENT 'Business reason for the read event. Examples: BILL (billing cycle), MOVE (move-in/move-out), DISC (disconnect), RECON (reconnect), INSP (inspection), COMP (complaint investigation). Used for operational reporting and audit.',
    `read_sequence_number` STRING COMMENT 'Business identifier for the meter read, often formatted as meter number plus read date. Used for external reference and audit trails.',
    `read_source` STRING COMMENT 'Method by which the reading was obtained. AMI: Advanced Metering Infrastructure (two-way automated). AMR: Automated Meter Reading (one-way drive-by). Manual: field technician on-site. Estimated: calculated by VEE (Validation, Estimation, and Editing) process. Customer: self-reported. Remote: handheld or mobile device.. Valid values are `AMI|AMR|manual|estimated|customer|remote`',
    `read_status` STRING COMMENT 'Current lifecycle status of the meter read. Valid: passed VEE (Validation, Estimation, and Editing) and accepted for billing. Estimated: calculated value pending actual read. Suspect: flagged for review. Failed: read attempt unsuccessful. Pending_validation: awaiting VEE processing. Corrected: replaced by subsequent correction read.. Valid values are `valid|estimated|suspect|failed|pending_validation|corrected`',
    `read_timestamp` TIMESTAMP COMMENT 'Precise date and time when the meter reading was captured, including time zone. Used for interval boundary alignment and AMI (Advanced Metering Infrastructure) event correlation.',
    `read_type` STRING COMMENT 'Classification of the read event. Scheduled: routine billing cycle read. Special: off-cycle read for move-in/move-out or investigation. Final: account closure. Initial: new service activation. Test: commissioning or validation. Correction: replacement of erroneous prior read.. Valid values are `scheduled|special|final|initial|test|correction`',
    `read_uom` STRING COMMENT 'Unit of measure for the read value. Common values: kWh (kilowatt-hour), MWh (megawatt-hour), kVArh (kilovolt-ampere reactive hour) for electric; CCF, MCF, Therms for gas; Gallons for water. [ENUM-REF-CANDIDATE: kWh|MWh|kVArh|MVArh|kW|MW|kVA|MVA|CCF|MCF|Therms|Gallons — 12 candidates stripped; promote to reference product]',
    `read_value` DECIMAL(18,2) COMMENT 'The cumulative register value captured at the read timestamp. For energy meters, typically kilowatt-hours (kWh) or megawatt-hours (MWh). This is the raw scalar reading before consumption calculation.',
    `register_digits` STRING COMMENT 'Number of digits on the meter register display. Used to detect register rollover (e.g., a 5-digit register rolls from 99999 to 00000). Typical values: 5, 6, 7.',
    `register_rollover_flag` BOOLEAN COMMENT 'Indicates whether the register rolled over during this read period (current read value is less than previous read value due to register capacity limit). True if rollover detected; False otherwise.',
    `scheduled_read_date` DATE COMMENT 'The planned date for this meter read as defined by the read schedule. Used to measure on-time read performance and identify late or early reads.',
    `tou_period` STRING COMMENT 'The TOU rate period for this register reading. On-peak: highest rate hours. Off-peak: lowest rate hours. Shoulder: mid-tier hours. Super-off-peak: ultra-low rate hours (e.g., overnight EV charging). Null for non-TOU registers.. Valid values are `on-peak|off-peak|shoulder|super-off-peak`',
    `tou_register_flag` BOOLEAN COMMENT 'Indicates whether this register captures Time-of-Use (TOU) segmented consumption (e.g., on-peak, off-peak, shoulder). True for TOU registers; False for cumulative registers. TOU meters have multiple read records per read event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this meter read record was last modified. Tracks VEE corrections, status changes, and data quality improvements.',
    CONSTRAINT pk_meter_read PRIMARY KEY(`meter_read_id`)
) COMMENT 'Scalar (register-level) meter reading record and associated read scheduling — capturing both the cumulative register value at a specific point in time and the recurring schedule governing when reads are collected. For readings: stores read date, read time, register identifier, read value, read type (scheduled/special/final/initial), read source (AMR/AMI/manual/estimated), reader employee reference, and read quality flag. For scheduling: defines read cycle (monthly/bi-monthly/daily), read method (AMI automated/manual route), scheduled read date, route assignment, billing cycle alignment, schedule code, and active status. Drives field crew routing for manual reads and AMI polling schedules for automated collection. Feeds billing domain consumption calculation. Distinct from interval_reading (which is time-series) — this is the periodic scalar snapshot and its collection governance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`vee_rule` (
    `vee_rule_id` BIGINT COMMENT 'Unique identifier for the VEE rule. Primary key for the VEE rule reference entity.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.class. Business justification: VEE validation rules apply to specific meter asset classes (e.g., different estimation methods for residential vs. industrial CT meters). asset.class is the authoritative meter classification taxonomy',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: VEE rules implement regulatory obligations for data quality, estimation limits, validation thresholds mandated by state PUC orders. Enables compliance mapping, regulatory justification for VEE algorit',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: VEE rules are scoped to specific rate schedules (TOU validation rules apply only to TOU rate schedules). The plain applicable_rate_schedules column on vee_rule is a denormalization signal. This FK ena',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: VEE rules implementing FERC Order 676 or state PUC data quality standards are established through regulatory filings. vee_rule has regulatory_basis (plain text denormalization). Replacing with regulat',
    `algorithm_type` STRING COMMENT 'The computational algorithm or method used by the rule to validate, estimate, or edit meter data (e.g., threshold-based, statistical analysis, linear regression, interpolation). [ENUM-REF-CANDIDATE: threshold|statistical|regression|interpolation|substitution|comparison|pattern_matching — 7 candidates stripped; promote to reference product]',
    `applicable_service_types` STRING COMMENT 'Type of utility service to which this VEE rule applies (electric, gas, water, steam). Ensures rules are applied to appropriate commodity data streams.. Valid values are `electric|gas|water|steam`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this VEE rule require formal approval before activation. True for rules impacting billing or regulatory compliance.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved this VEE rule for production use. Applicable when approval_required_flag is true.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE rule was formally approved for production use. Supports governance and compliance documentation.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for this rule, capturing every application of the rule and its outcomes for compliance and troubleshooting.',
    `billing_quality_flag` BOOLEAN COMMENT 'Indicates whether data passing this VEE rule is considered billing-quality and suitable for revenue calculation. True if the rule ensures billing-grade accuracy.',
    `confidence_threshold_percent` DECIMAL(18,2) COMMENT 'Minimum confidence level (as a percentage) required for estimated values to be accepted as billing-quality. Used in statistical estimation algorithms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE rule record was first created in the MDM system. Supports audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date after which the VEE rule is no longer active. Nullable for open-ended rules. Supports rule lifecycle management and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date from which the VEE rule becomes active and is applied to meter data. Supports temporal rule management and regulatory compliance.',
    `estimation_method` STRING COMMENT 'Specific estimation technique used when the rule type is estimation. Defines how missing or invalid interval data is calculated (e.g., linear interpolation, historical average, same-day-last-week). [ENUM-REF-CANDIDATE: linear_interpolation|historical_average|same_day_last_week|same_day_last_year|regression|zero_fill|prior_value — 7 candidates stripped; promote to reference product]',
    `exception_handling_action` STRING COMMENT 'Action taken when the rule detects a data quality exception: flag for review, automatically estimate, reject the data, route to manual review, or substitute with a default value.. Valid values are `flag_only|estimate|reject|manual_review|substitute`',
    `execution_frequency` STRING COMMENT 'Frequency at which the VEE rule is executed against incoming or historical meter data (real-time, hourly, daily, weekly, on-demand).. Valid values are `real_time|hourly|daily|weekly|on_demand`',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this VEE rule record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE rule record was last modified. Supports audit trail and change management.',
    `lookback_period_days` STRING COMMENT 'Number of days of historical data the rule examines for validation or estimation purposes. Used by statistical and pattern-matching algorithms.',
    `lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for validation rules. Interval data below this limit triggers a validation exception or editing action.',
    `notes` STRING COMMENT 'Free-text field for additional notes, implementation guidance, or special considerations related to this VEE rule. Supports knowledge transfer and operational documentation.',
    `owner_group` STRING COMMENT 'Business unit or team responsible for maintaining and governing this VEE rule (e.g., Metering Operations, Revenue Assurance, Data Quality Team).',
    `priority_order` STRING COMMENT 'Execution sequence priority for the rule within the VEE processing engine. Lower numbers execute first. Determines the order in which multiple rules are applied to the same interval data.',
    `rule_category` STRING COMMENT 'Functional category of the rule indicating the specific data quality issue it addresses (e.g., spike detection, zero consumption validation, missing data estimation).. Valid values are `spike_detection|zero_consumption|negative_value|missing_data|high_low_limit|consistency_check`',
    `rule_code` STRING COMMENT 'Business identifier code for the VEE rule, used for external reference and system integration. Typically a short alphanumeric code following utility naming conventions.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed description of the VEE rule including its business logic, application context, and expected outcomes when applied to interval meter data.',
    `rule_name` STRING COMMENT 'Human-readable name of the VEE rule describing its purpose and function within the meter data management process.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the VEE rule indicating whether it is actively applied to meter data processing or in a non-operational state.. Valid values are `active|inactive|draft|testing|retired|suspended`',
    `rule_type` STRING COMMENT 'Classification of the rule within the VEE process: validation (checks data quality), estimation (fills missing data), or editing (corrects erroneous data).. Valid values are `validation|estimation|editing`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value (e.g., kWh, MWh, percentage, count, standard deviations) providing context for threshold interpretation.. Valid values are `kWh|MWh|percentage|count|standard_deviation|ratio`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold parameter used by the rule algorithm to determine data quality exceptions. For example, spike tolerance percentage, maximum consumption limit, or minimum expected value.',
    `upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for validation rules. Interval data above this limit triggers a validation exception or editing action.',
    `version_number` STRING COMMENT 'Version number of the VEE rule configuration. Incremented with each modification to support change tracking and rollback capabilities.',
    `created_by` STRING COMMENT 'User identifier of the person who created this VEE rule record. Supports accountability and audit requirements.',
    CONSTRAINT pk_vee_rule PRIMARY KEY(`vee_rule_id`)
) COMMENT 'Defines the business rules applied during the VEE (Validation, Estimation, and Editing) process in Oracle Utilities MDM. Each rule specifies the rule type (validation/estimation/editing), rule algorithm, threshold parameters (e.g., spike tolerance percentage, zero-consumption threshold), applicable meter types, priority order, effective date range, and regulatory basis. Governs data quality for billing-quality interval data. Reference entity managed by the metering operations team.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`vee_exception` (
    `vee_exception_id` BIGINT COMMENT 'Unique identifier for the VEE exception record. Primary key for the VEE exception entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with the meter and service point for this VEE exception. Used for customer impact analysis and billing hold workflows.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: VEE exceptions identified as audit findings when indicating systematic data quality issues or control deficiencies. Supports audit evidence collection, corrective action tracking, regulatory reporting',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: VEE exceptions on DER interval data are frequently caused by curtailment events producing anomalous readings. Linking enables automated VEE resolution by identifying curtailment as root cause — a stan',
    `dr_event_id` BIGINT COMMENT 'Foreign key linking to demand.dr_event. Business justification: VEE exceptions during DR event windows require context to determine if anomalous readings are caused by legitimate load curtailment rather than data errors. Linking vee_exception to the active dr_even',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: VEE analysts investigate whether missing/anomalous interval readings stem from power interruptions. Regulatory VEE reports require cross-referencing exceptions with outage events to justify estimation',
    `market_settlement_id` BIGINT COMMENT 'Foreign key linking to trading.market_settlement. Business justification: VEE exceptions that correct interval data after initial settlement require settlement restatement. ISO tariffs mandate tracking which market_settlement records are affected by data quality corrections',
    `meter_id` BIGINT COMMENT 'Reference to the meter that generated the interval data which triggered this VEE exception.',
    `meter_point_id` BIGINT COMMENT 'Reference to the service point (delivery location) associated with the meter that generated the interval data for this exception. Used to link exceptions to customer accounts and premises.',
    `interval_reading_id` BIGINT COMMENT 'Reference to the specific interval data record that failed VEE validation and raised this exception.',
    `vee_rule_id` BIGINT COMMENT 'Reference to the VEE rule that was triggered and caused this exception to be raised.',
    `rate_schedule_id` BIGINT COMMENT 'Reference to the rate schedule (tariff) applicable to the service point at the time of the exception. Used to determine billing impact and priority for resolution, especially for Time-of-Use (TOU) and Critical Peak Pricing (CPP) customers.',
    `to_interval_reading_id` BIGINT COMMENT 'FK to metering.interval_reading.interval_reading_id — VEE exceptions must reference the interval reading(s) that failed validation. Without this link, operators cannot identify and resolve data quality issues.',
    `to_vee_rule_id` BIGINT COMMENT 'FK to metering.vee_rule.vee_rule_id — Each VEE exception must reference the VEE rule that triggered it. This is essential for exception resolution workflows and rule tuning.',
    `auto_resolution_attempted` BOOLEAN COMMENT 'Boolean flag indicating whether the VEE engine attempted automatic resolution of this exception through estimation algorithms. True if auto-resolution was attempted; False if exception was immediately flagged for manual review.',
    `auto_resolution_successful` BOOLEAN COMMENT 'Boolean flag indicating whether automatic resolution by the VEE engine was successful. True if the engine successfully estimated a replacement value that passed validation; False if auto-resolution failed and manual intervention is required.',
    `billing_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this VEE exception affects customer billing. True if the affected interval data is used in billing determinants and the exception must be resolved before bill calculation; False if the exception is for non-billing data (e.g., operational monitoring, grid analytics).',
    `corrected_value` DECIMAL(18,2) COMMENT 'Final corrected interval data value (in kWh or other unit of measure) after manual review and editing. This is the value that will be used for billing if the exception is resolved. Null if not yet corrected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE exception record was first created in the MDM system. Audit field for data lineage and record lifecycle tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric data quality score (0.00 to 100.00) assigned to the interval data by the VEE engine, indicating confidence in the data accuracy. Lower scores trigger exceptions. Used for trending meter health and VEE rule tuning.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated interval data value (in kWh or other unit of measure) calculated by the VEE engine to replace the invalid or missing original value. Null if estimation was not performed or failed.',
    `estimation_method` STRING COMMENT 'Method used by the VEE engine or analyst to estimate the corrected interval value. Linear interpolation: average of adjacent intervals. Historical average: average of same interval from prior days. Similar day: value from comparable day (same day-of-week, season). Regression: statistical model. Manual entry: analyst-provided value. None: no estimation performed.. Valid values are `linear_interpolation|historical_average|similar_day|regression|manual_entry|none`',
    `exception_disposition` STRING COMMENT 'Final disposition category of the VEE exception indicating how it was ultimately handled. Resolved: data corrected and validated. Escalated: sent to engineering or management for further investigation. Waived: accepted without correction per approved business rule or regulatory guidance.. Valid values are `resolved|escalated|waived`',
    `exception_number` STRING COMMENT 'Business-facing unique exception number assigned to this VEE exception for tracking and audit purposes. Format: VEE-xxxxxxxxxx.. Valid values are `^VEE-[0-9]{10}$`',
    `exception_raised_timestamp` TIMESTAMP COMMENT 'Timestamp when the VEE exception was first raised by the MDM VEE engine during interval data validation processing. Represents the business event time of exception detection.',
    `exception_severity` STRING COMMENT 'Severity level of the VEE exception indicating business impact and urgency for resolution. Critical exceptions block billing; high exceptions require immediate review; medium and low exceptions are tracked for quality metrics; informational exceptions are logged for audit only.. Valid values are `critical|high|medium|low|informational`',
    `exception_source_system` STRING COMMENT 'Source system that originated the interval data which triggered this VEE exception. Typically MDM (Meter Data Management) for AMI data, AMI head-end for direct meter reads, SCADA for grid operations data, manual entry for field reads, or billing system for estimated reads.. Valid values are `MDM|AMI_head_end|SCADA|manual_entry|billing_system`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the VEE exception. Open: newly raised and awaiting review. In Review: assigned to analyst for investigation. Resolved: corrective action taken and data corrected. Escalated: requires supervisor or engineering review. Waived: exception accepted without correction per business rule. Closed: final disposition recorded and exception archived.. Valid values are `open|in_review|resolved|escalated|waived|closed`',
    `exception_type` STRING COMMENT 'Classification of the VEE exception indicating the nature of the data quality issue: validation failure (data failed validation rule), estimation failure (unable to estimate missing interval), editing failure (manual edit rejected), missing data (no interval data received), suspect data (data flagged as questionable), or out of range (value exceeds expected bounds).. Valid values are `validation_failure|estimation_failure|editing_failure|missing_data|suspect_data|out_of_range`',
    `interval_count` STRING COMMENT 'Number of individual interval readings affected by this VEE exception. For 15-minute interval meters, a 1-hour exception would affect 4 intervals.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'End timestamp of the interval data range affected by this VEE exception. Defines the end of the time window containing suspect or invalid data.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'Start timestamp of the interval data range affected by this VEE exception. Defines the beginning of the time window containing suspect or invalid data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE exception record was last updated. Audit field for tracking changes to exception status, resolution actions, and data corrections.',
    `original_value` DECIMAL(18,2) COMMENT 'Original raw interval data value (in kWh or other unit of measure) that triggered the VEE exception before any estimation or editing was applied.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this VEE exception must be reported to regulatory authorities (e.g., state Public Utility Commission) as part of data quality and billing accuracy compliance reporting. True if reportable; False otherwise.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the VEE exception. Re-estimate: apply different estimation algorithm. Manual edit: analyst manually corrected the value. Accept original: original value accepted despite exception. Override: supervisor approved exception without correction. Escalate: sent to engineering for investigation. Waive: exception acknowledged but no correction required per business rule.. Valid values are `re_estimate|manual_edit|accept_original|override|escalate|waive`',
    `resolution_notes` STRING COMMENT 'Free-text notes entered by the analyst or system documenting the resolution action, rationale for the decision, and any additional context for audit purposes.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the VEE exception was resolved (status changed to resolved, waived, or closed). Null if exception is still open or in review. Used to calculate exception aging and VEE team performance metrics.',
    `reviewer_name` STRING COMMENT 'Full name of the analyst or system user who reviewed and resolved this VEE exception. Captured for audit trail and operational reporting.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value defined in the VEE rule that was exceeded or violated, triggering this exception. For example, maximum expected consumption in kWh, or maximum percent deviation from historical average.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the interval data values associated with this exception. Typically kWh (kilowatt-hour) for electric energy consumption, kW for demand, or gas volume units. [ENUM-REF-CANDIDATE: kWh|MWh|kW|kVAR|kVA|CCF|MCF|therms — 8 candidates stripped; promote to reference product]',
    `vee_batch_code` BIGINT COMMENT 'Reference to the VEE processing batch run that raised this exception. Used to group exceptions by processing cycle for operational dashboards and batch-level quality metrics.',
    CONSTRAINT pk_vee_exception PRIMARY KEY(`vee_exception_id`)
) COMMENT 'Operational record of a VEE processing exception raised during interval data validation or estimation — capturing intervals that failed validation rules and required manual review, automatic re-estimation, or override. Stores exception type, severity, affected interval range (start/end timestamps), VEE rule triggered, auto-resolution status, manual reviewer identifier, resolution action taken (re-estimate/edit/accept/override), resolution timestamp, and exception disposition (resolved/escalated/waived). Supports MDM data quality workflows, operational dashboards for VEE pass rates, and regulatory audit trails for billing data integrity. Key metric: exception rate by rule type drives VEE rule tuning.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` (
    `ami_head_end_id` BIGINT COMMENT 'Unique identifier for the AMI head-end system instance. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: AMI head-end systems are deployed under AMI infrastructure capital projects. Linking to asset.capital_project supports capex tracking, project closeout, and RAB inclusion for the head-end infrastructu',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: AMI head-end systems are deployed within specific control area boundaries for outage detection reporting, NERC CIP asset classification, and grid event correlation. Balancing authorities need to ident',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to asset.maintenance_plan. Business justification: AMI head-end systems require scheduled maintenance plans (software patching, hardware maintenance, NERC CIP compliance activities). ami_head_end already links to asset.registry; the maintenance_plan F',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: AMI head-end systems classified as BES Cyber Systems under NERC CIP-002, requiring cybersecurity controls. Enables CIP compliance tracking, vulnerability assessment scheduling, cyber security incident',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: AMI head-end systems are subject to data privacy obligations (state smart meter data privacy rules), data retention obligations, and cybersecurity obligations beyond NERC CIP. ami_head_end already lin',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: AMI head-end systems are capital network infrastructure assets requiring asset tagging, depreciation, maintenance plans, warranty tracking, and rate base inclusion. Utilities manage these as major IT/',
    `actual_uptime_percent` DECIMAL(18,2) COMMENT 'Actual measured network uptime availability for the head-end system over the most recent reporting period, expressed as a percentage.',
    `average_collection_success_rate_percent` DECIMAL(18,2) COMMENT 'Rolling average success rate for scheduled collection runs over a defined reporting period (e.g., 30 days), expressed as a percentage.',
    `commissioning_date` DATE COMMENT 'Date when the head-end system was officially commissioned and placed into production service.',
    `communication_protocol` STRING COMMENT 'Primary communication protocol used by the head-end system to communicate with smart meters (e.g., RF Mesh, Power Line Carrier, Cellular, Hybrid).. Valid values are `RF Mesh|PLC|Cellular|Hybrid|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this head-end system record was first created in the system.',
    `current_enrolled_device_count` STRING COMMENT 'Current number of smart meters or devices actively enrolled and communicating with this head-end system instance.',
    `data_retention_days` STRING COMMENT 'Number of days that raw interval data and collection logs are retained in the head-end system before archival or purging.',
    `firmware_update_capability_flag` BOOLEAN COMMENT 'Indicates whether the head-end system has the capability to perform over-the-air firmware updates to enrolled smart meters.',
    `installation_date` DATE COMMENT 'Date when the head-end system was installed and commissioned for operational use.',
    `last_collection_completeness_percent` DECIMAL(18,2) COMMENT 'Data completeness metric for the most recent collection run, representing the percentage of expected interval data records successfully retrieved.',
    `last_collection_duration_minutes` STRING COMMENT 'Duration in minutes required to complete the most recent scheduled meter data collection run.',
    `last_collection_success_rate_percent` DECIMAL(18,2) COMMENT 'Success rate of the most recent scheduled collection run, expressed as a percentage of meters successfully read versus total meters attempted.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or unscheduled maintenance activity performed on the head-end system.',
    `last_scheduled_collection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent scheduled meter data collection run executed by the head-end system.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this head-end system record was most recently updated or modified.',
    `maximum_device_capacity` STRING COMMENT 'Maximum number of smart meters or devices that this head-end system instance is designed to support concurrently.',
    `mdm_integration_endpoint_url` STRING COMMENT 'URL or network endpoint address used for integration and data exchange between the head-end system and the MDM system (Oracle Utilities MDM).',
    `mdm_integration_protocol` STRING COMMENT 'Communication protocol or method used for data exchange between the head-end system and the MDM system (e.g., REST API, SOAP, FTP, SFTP, Message Queue, Kafka). [ENUM-REF-CANDIDATE: REST API|SOAP|FTP|SFTP|MQ|Kafka|Other — 7 candidates stripped; promote to reference product]',
    `mdm_integration_status` STRING COMMENT 'Current operational status of the integration link between the head-end system and the MDM system.. Valid values are `Active|Inactive|Error|Pending`',
    `network_topology` STRING COMMENT 'Network architecture topology employed by the head-end system for meter communication (e.g., Mesh, Star, Point-to-Point, Hybrid).. Valid values are `Mesh|Star|Point-to-Point|Hybrid`',
    `network_uptime_sla_percent` DECIMAL(18,2) COMMENT 'Contractual or operational target for network uptime availability expressed as a percentage (e.g., 99.95%).',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance activity is planned for the head-end system.',
    `on_demand_collection_enabled_flag` BOOLEAN COMMENT 'Indicates whether the head-end system supports and has enabled on-demand (ad-hoc) meter reading requests.',
    `operational_status` STRING COMMENT 'Current operational state of the head-end system in its lifecycle (Active, Inactive, Maintenance, Decommissioned, Testing).. Valid values are `Active|Inactive|Maintenance|Decommissioned|Testing`',
    `outage_detection_enabled_flag` BOOLEAN COMMENT 'Indicates whether the head-end system has outage detection and last-gasp notification capabilities enabled for integration with Outage Management System (OMS).',
    `primary_contact_email` STRING COMMENT 'Email address of the primary technical contact or system administrator for this head-end system instance.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary technical contact or system administrator responsible for this head-end system instance.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary technical contact or system administrator for this head-end system instance.',
    `remote_disconnect_capability_flag` BOOLEAN COMMENT 'Indicates whether the head-end system supports remote service connect/disconnect commands to smart meters.',
    `scheduled_collection_frequency` STRING COMMENT 'Frequency at which the head-end system executes scheduled meter data collection runs (e.g., Hourly, Daily, Weekly, Monthly, On-Demand).. Valid values are `Hourly|Daily|Weekly|Monthly|On-Demand`',
    `software_version` STRING COMMENT 'Current software version or release number of the head-end system, used for compatibility tracking and upgrade planning.',
    `system_identifier` STRING COMMENT 'Externally-known unique code or serial number for the head-end system instance, used for vendor support and integration references.',
    `system_name` STRING COMMENT 'Business name or designation of the AMI head-end system instance (e.g., North Region AMI HES, Metro Area Head-End).',
    `system_notes` STRING COMMENT 'Free-text field for additional notes, comments, or special configuration details about the head-end system instance.',
    `vendor_name` STRING COMMENT 'Name of the vendor or manufacturer that provides the AMI head-end system platform.. Valid values are `Itron|Landis+Gyr|Sensus|Aclara|Elster|Honeywell|Trilliant|Silver Spring Networks|Other`',
    `vendor_support_contract_number` STRING COMMENT 'Contract or agreement number for vendor support and maintenance services for this head-end system instance.',
    `vendor_support_expiration_date` DATE COMMENT 'Date when the current vendor support and maintenance contract expires for this head-end system instance.',
    CONSTRAINT pk_ami_head_end PRIMARY KEY(`ami_head_end_id`)
) COMMENT 'Master record for each AMI head-end system instance managing a population of smart meters — the central communication hub for the AMI network. Captures head-end system name, vendor, software version, communication protocol (RF mesh, PLC, cellular), geographic coverage area, maximum device capacity, current enrolled device count, network uptime SLA, integration endpoint details for MDM, and data collection run statistics (scheduled/on-demand collection execution, success rates, timing, and completeness metrics). Supports multi-vendor AMI environments, head-end performance monitoring, and MDM data completeness tracking for VEE processing readiness.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`ami_event` (
    `ami_event_id` BIGINT COMMENT 'Unique identifier for the AMI event record. Primary key for the AMI event entity.',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: AMI events (reverse flow cessation, disconnect) generated during DER curtailment must be correlated with curtailment events for curtailment compliance verification and performance measurement. Utiliti',
    `account_id` BIGINT COMMENT 'Identifier of the customer account associated with the meter that generated this event. Links event to billing and customer service systems.',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: AMI tamper and reverse-flow events on DER-connected meters require DER system context for investigation, export limit compliance verification, and anti-islanding protection validation. Critical for gr',
    `ems_node_id` BIGINT COMMENT 'Foreign key linking to grid.ems_node. Business justification: AMI outage detection and voltage anomaly events must be correlated with EMS node topology status for grid situational awareness and outage management. Control room operators need to identify which EMS',
    `failure_event_id` BIGINT COMMENT 'Foreign key linking to asset.failure_event. Business justification: AMI tamper events, communication failures, and outage notifications correlate with asset failure events for NERC reliability reporting, SAIDI/SAIFI contribution tracking, and revenue protection invest',
    `feeder_id` BIGINT COMMENT 'Identifier of the distribution feeder circuit serving the meter. Used for outage correlation, load analysis, and SAIDI/SAIFI reliability calculations. Null if feeder association is not available.',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: NERC CIP-007 R4 requires logging and alerting on security events for BES Cyber Assets. AMI events (tamper detection, unauthorized access, communication anomalies) on CIP-classified meters must be link',
    `premise_id` BIGINT COMMENT 'Identifier of the service premise (physical location) where the meter is installed and the event occurred. Links event to geographic and network topology data.',
    `ami_head_end_id` BIGINT COMMENT 'Foreign key linking to metering.ami_head_end. Business justification: AMI events are received, processed, and managed by specific AMI head-end systems. While ami_event already links to meter (which links to head-end), adding a direct FK to ami_head_end is operationally ',
    `meter_id` BIGINT COMMENT 'Identifier of the smart meter that generated this event. Links to the meter asset registry.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Major AMI outage events and tamper events must be reported to regulators (SAIDI/SAIFI major event day filings, revenue protection reports). ami_event has regulatory_reporting_flag (boolean). Adding re',
    `scada_point_id` BIGINT COMMENT 'Foreign key linking to grid.scada_point. Business justification: AMI outage/tamper events correlate with SCADA breaker/recloser operations for distribution automation, outage management system integration, and coordinated restoration. Reuses existing scada_point_id',
    `to_ami_head_end_id` BIGINT COMMENT 'FK to metering.ami_head_end.ami_head_end_id — AMI events are received by a specific head-end system. This link supports multi-vendor AMI environments and event routing.',
    `to_meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — AMI events (tamper alerts, outage notifications, voltage events) must reference the meter device that generated them. Core operational link for event triage.',
    `transformer_id` BIGINT COMMENT 'Identifier of the distribution transformer serving the meter. Used for outage correlation and grid operations analysis. Null if transformer association is not available.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Outage management systems correlate transmission facility outages with AMI last-gasp/restoration events to determine root cause, calculate SAIDI/SAIFI metrics, and assess customer impact. Standard uti',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: AMI events from VPP-enrolled DERs must be traceable to the VPP configuration for dispatch performance measurement and ISO/RTO market compliance reporting. VPP dispatch generates AMI events (load chang',
    `communication_failure_reason` STRING COMMENT 'Root cause classification for communication failure events between the meter and head-end system. Applicable only to communication failure event types. Null for non-communication events.. Valid values are `SIGNAL_LOSS|NETWORK_CONGESTION|DEVICE_OFFLINE|AUTHENTICATION_FAILURE|PROTOCOL_ERROR|UNKNOWN`',
    `confirmed_theft_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the tamper event has been confirmed as theft of service following field investigation. True indicates confirmed theft; False indicates dismissed or unconfirmed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this AMI event record was first created in the MDM system. System audit field for data lineage and compliance.',
    `downstream_notification_status` STRING COMMENT 'Status of event notification to downstream systems. Tracks whether the event has been successfully propagated to Outage Management System (OMS), billing, grid operations, or other consuming systems.. Valid values are `PENDING|NOTIFIED_OMS|NOTIFIED_BILLING|NOTIFIED_GRID_OPS|NOTIFICATION_FAILED|NOT_REQUIRED`',
    `estimated_unbilled_consumption_kwh` DECIMAL(18,2) COMMENT 'Estimated kilowatt-hours of electricity consumed but not billed due to tampering or theft. Calculated using VEE algorithms and historical consumption patterns. Null for non-tamper events.',
    `event_acknowledged_by` STRING COMMENT 'User ID or system identifier that acknowledged the event. Null for unacknowledged events.',
    `event_acknowledged_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the event has been acknowledged by an operator or automated system. True indicates acknowledged; False indicates pending acknowledgment.',
    `event_acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the event was acknowledged. Null for unacknowledged events.',
    `event_sequence_number` STRING COMMENT 'Sequential number assigned by the meter to this event within its local event log. Used to detect missing events and ensure event ordering during head-end synchronization.',
    `event_severity` STRING COMMENT 'Severity classification of the AMI event indicating the urgency and business impact. Critical events require immediate investigation; informational events are logged for audit purposes.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW|INFORMATIONAL`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the event occurred at the meter location, as recorded by the meter device. This is the real-world event time, distinct from system receipt time.',
    `event_type_code` STRING COMMENT 'Classification code identifying the type of AMI event: tamper alerts, power outage notifications (last gasp), power restoration notifications (first breath), communication failures, voltage sag/swell events, reverse energy flow detections, and firmware update events. [ENUM-REF-CANDIDATE: TAMPER|OUTAGE_LAST_GASP|RESTORATION_FIRST_BREATH|COMM_FAILURE|VOLTAGE_SAG|VOLTAGE_SWELL|REVERSE_FLOW|FIRMWARE_UPDATE — 8 candidates stripped; promote to reference product]',
    `firmware_version_after` STRING COMMENT 'Meter firmware version identifier after successful firmware update. Applicable only to firmware update events. Null for non-firmware events or failed updates.',
    `firmware_version_before` STRING COMMENT 'Meter firmware version identifier prior to the firmware update event. Applicable only to firmware update events. Null for non-firmware events.',
    `head_end_receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the AMI head-end system received and logged the event from the meter. Used to calculate communication latency and event processing delays.',
    `investigation_closure_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation was closed and final disposition recorded. Null for open or in-progress investigations.',
    `investigation_notes` STRING COMMENT 'Free-text field capturing investigator observations, findings, and resolution details. Used for audit trail and knowledge management. Null for events not requiring investigation.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation of this event was initiated. Null for events not requiring investigation.',
    `investigation_status` STRING COMMENT 'Current status of the investigation workflow for this event. Tracks the lifecycle from initial detection through resolution. Applicable primarily to tamper and theft events.. Valid values are `OPEN|IN_PROGRESS|PENDING_FIELD_VISIT|CONFIRMED|DISMISSED|CLOSED`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this AMI event record was last updated. System audit field for change tracking and data governance.',
    `law_enforcement_referral_status` STRING COMMENT 'Status of referral to law enforcement authorities for criminal prosecution of theft of service. Applicable only to confirmed theft cases meeting prosecution thresholds. Null for non-theft events.. Valid values are `NOT_REFERRED|PENDING_REFERRAL|REFERRED|CASE_FILED|CASE_CLOSED`',
    `outage_duration_minutes` STRING COMMENT 'Duration of the power outage in minutes, calculated from last gasp to first breath timestamps. Applicable only to outage and restoration event pairs. Null for non-outage events.',
    `raw_event_payload` STRING COMMENT 'Complete raw data payload transmitted by the meter for this event, stored in native format (typically XML or JSON). Preserves full event detail for forensic analysis and regulatory audit.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this event must be included in regulatory compliance reports to the Public Utility Commission (PUC) or other governing bodies. True for reportable events such as confirmed theft, major outages, or safety incidents.',
    `revenue_recovery_amount` DECIMAL(18,2) COMMENT 'Monetary amount (in local currency) to be recovered from the customer for unbilled consumption due to confirmed theft. Calculated by applying applicable tariff rates to estimated unbilled consumption. Null for non-theft events.',
    `reverse_flow_kwh` DECIMAL(18,2) COMMENT 'Amount of energy flowing in reverse direction (from customer to grid) in kilowatt-hours, detected during the event period. Applicable to reverse flow events, typically associated with distributed energy resources (DER) or net metering. Null for non-reverse-flow events.',
    `tamper_detection_method` STRING COMMENT 'Source or method by which the tamper event was detected. Applicable only to tamper event types. Null for non-tamper events.. Valid values are `AMI_ALERT|FIELD_INSPECTION|VEE_ANOMALY|CUSTOMER_REPORT|ROUTINE_AUDIT`',
    `tamper_type` STRING COMMENT 'Specific classification of the tamper method detected. Applicable only to tamper event types. Describes the physical or electronic tampering technique identified.. Valid values are `COVER_REMOVAL|BYPASS|REVERSE_INSTALLATION|UNAUTHORIZED_RECONNECT|MAGNETIC_INTERFERENCE|INTERNAL_TAMPERING`',
    `to_ami_head_end` BIGINT COMMENT 'FK to metering.ami_head_end.ami_head_end_id — AMI events are received and processed by a specific head-end system. Critical for head-end performance monitoring and event routing.',
    `voltage_measurement` DECIMAL(18,2) COMMENT 'Voltage level measured at the time of the event, in volts. Applicable to voltage sag, voltage swell, and power quality events. Null for non-voltage events.',
    CONSTRAINT pk_ami_event PRIMARY KEY(`ami_event_id`)
) COMMENT 'Operational event and investigation record generated by AMI smart meters and transmitted to the head-end system — covering the full spectrum of AMI-originated events and their investigation lifecycle. Event types include: tamper alerts (with detection method, tamper type such as cover removal/bypass/reverse installation/unauthorized reconnect, investigation status, confirmed theft indicator, estimated unbilled consumption, revenue recovery amount, and law enforcement referral status), power outage notifications (last gasp), power restoration notifications (first breath), communication failures, voltage sag/swell events, reverse energy flow detections, and firmware update events. Stores event type code, event timestamp, meter identifier, event severity, raw event payload, head-end receipt timestamp, downstream notification status, and for tamper/theft events: detection source (AMI alert, field inspection, VEE anomaly), case status, and closure date. SSOT for all AMI-originated events including tamper/theft investigation within the metering domain. Feeds outage management, grid operations, and revenue protection workflows. Supports non-technical loss reporting and PUC-mandated theft-of-service regulatory filings.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` (
    `tou_rate_program_id` BIGINT COMMENT 'Unique identifier for the TOU or CPP rate program. Primary key.',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: TOU rate programs are designed around load zone peak demand characteristics for grid load shaping. Utility rate design and demand response teams use this link to associate TOU programs with target loa',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: TOU rate programs are established under specific regulatory obligations (state RPS mandates, demand response program rules, commission-ordered rate design). Linking tou_rate_program to its governing o',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: TOU rate programs implement specific rate schedule TOU components (peak/off-peak periods, CPP triggers). This FK links the program definition to the governing rate schedule, required for billing valid',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: TOU programs require commission approval via tariff filing or rate case. tou_rate_program has denormalized regulatory_approval_reference and tariff_sheet_reference text fields. Replacing these with a ',
    `meter_point_id` BIGINT COMMENT 'FK to metering.meter_point.meter_point_id — After merging tou_enrollment into tou_rate_program, the enrollment association linking programs to meter points must be maintained. Essential for billing domain to apply correct TOU periods.',
    `ami_meter_required` BOOLEAN COMMENT 'Indicates whether an AMI smart meter with interval data capability is required for enrollment in this program. True if AMI is mandatory; False if standard meters are acceptable.',
    `billing_cycle_alignment_required` BOOLEAN COMMENT 'Indicates whether enrollment effective dates must align with billing cycle boundaries. True if enrollment can only start at the beginning of a billing cycle.',
    `contact_email` STRING COMMENT 'Email address for inquiries about the rate program. Used by customer service representatives and external stakeholders.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number for inquiries about the rate program. Used by customer service representatives and external stakeholders.. Valid values are `^+?[1-9]d{1,14}$`',
    `cpp_event_trigger_criteria` STRING COMMENT 'Business rules or thresholds that trigger a CPP event (e.g., Forecasted system load >95% capacity, Day-ahead LMP >$150/MWh, Heat index >105F). Nullable for non-CPP programs.',
    `cpp_max_event_duration_hours` DECIMAL(18,2) COMMENT 'Maximum duration in hours for a single CPP event. Nullable for non-CPP programs.',
    `cpp_max_events_per_year` STRING COMMENT 'Maximum number of CPP events that can be called in a calendar year, as defined in the tariff. Nullable for non-CPP programs.',
    `cpp_notification_lead_time_hours` DECIMAL(18,2) COMMENT 'Minimum advance notice in hours that must be provided to customers before a CPP event begins. Nullable for non-CPP programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate program record was first created in the system. Audit trail for record lifecycle.',
    `customer_segment` STRING COMMENT 'Customer class or segment eligible for this rate program. Defines which customer types can enroll.. Valid values are `RESIDENTIAL|COMMERCIAL|INDUSTRIAL|AGRICULTURAL|MUNICIPAL|ALL`',
    `effective_end_date` DATE COMMENT 'Date when the rate program expires or is superseded. Nullable for open-ended programs. After this date, no new enrollments are accepted.',
    `effective_start_date` DATE COMMENT 'Date when the rate program becomes effective and available for customer enrollment. Aligns with regulatory approval effective date.',
    `enrollment_eligibility_criteria` STRING COMMENT 'Detailed criteria that customers must meet to be eligible for enrollment (e.g., Residential customers with annual usage >5000 kWh, Commercial customers with demand >50 kW).',
    `enrollment_method` STRING COMMENT 'Defines how customers are enrolled in the program. OPT_IN: customer must actively enroll; OPT_OUT: customer is enrolled by default but can opt out; DEFAULT: automatic enrollment for new customers; MANDATORY: required for customer segment.. Valid values are `OPT_IN|OPT_OUT|DEFAULT|MANDATORY`',
    `estimated_annual_cost_savings_usd` DECIMAL(18,2) COMMENT 'Estimated average annual cost savings in US dollars for a typical customer enrolled in this program. Used for program marketing and benefit analysis.',
    `estimated_annual_savings_kwh` DECIMAL(18,2) COMMENT 'Estimated average annual energy savings in kilowatt-hours (kWh) for a typical customer enrolled in this program. Used for program marketing and benefit analysis.',
    `integration_system_code` STRING COMMENT 'Code identifying the source system or integration point for this program record (e.g., MDM, CC&B, CIS). Used for data lineage and system-of-record tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate program record was last updated. Audit trail for record lifecycle and change tracking.',
    `marketing_campaign_code` STRING COMMENT 'Reference code linking this rate program to marketing campaigns and customer acquisition initiatives. Nullable if no active marketing campaign.',
    `minimum_enrollment_period_months` STRING COMMENT 'Minimum number of months a customer must remain enrolled in the program before they can opt out or switch to another rate. Nullable if no minimum commitment.',
    `minimum_interval_data_frequency_minutes` STRING COMMENT 'Minimum frequency in minutes at which interval data must be collected for this program (e.g., 15, 30, 60). Defines the granularity required for TOU period classification.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this rate program record. Audit trail for accountability and compliance.',
    `off_peak_period_definition` STRING COMMENT 'Textual or structured definition of off-peak period hours (e.g., All other hours, Weekdays 8pm-2pm, All day weekends). Defines when off-peak TOU rates apply.',
    `opt_out_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers are allowed to opt out of the program after enrollment. False for mandatory programs; True for voluntary programs.',
    `opt_out_notice_period_days` STRING COMMENT 'Number of days advance notice required for a customer to opt out of the program. Nullable if opt-out is not allowed or has no notice requirement.',
    `peak_period_definition` STRING COMMENT 'Textual or structured definition of peak period hours (e.g., Weekdays 2pm-8pm, Mon-Fri 14:00-20:00). Defines when peak TOU rates apply.',
    `program_code` STRING COMMENT 'Business identifier for the rate program, used in billing systems and customer communications. Externally-known unique code for this TOU or CPP program.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed business description of the rate program, including objectives, benefits, and customer value proposition. Used in customer communications and marketing materials.',
    `program_name` STRING COMMENT 'Human-readable name of the TOU or CPP rate program (e.g., Residential Time-of-Use Summer 2024, Commercial Critical Peak Pricing).',
    `program_owner_department` STRING COMMENT 'Business unit or department responsible for managing and administering this rate program (e.g., Metering Operations, Demand Response, Regulatory Affairs).',
    `program_status` STRING COMMENT 'Current lifecycle status of the rate program. DRAFT: under development; PENDING_APPROVAL: submitted to PUC; ACTIVE: available for enrollment; SUSPENDED: temporarily inactive; RETIRED: no longer offered; CANCELLED: terminated before activation.. Valid values are `DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|RETIRED|CANCELLED`',
    `program_type` STRING COMMENT 'Classification of the rate program structure: TOU (Time-of-Use with fixed peak/off-peak periods), CPP (Critical Peak Pricing with event-driven pricing), TOU_CPP_HYBRID (combination), DYNAMIC_PRICING, or REAL_TIME_PRICING.. Valid values are `TOU|CPP|TOU_CPP_HYBRID|DYNAMIC_PRICING|REAL_TIME_PRICING`',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory body (PUC) approved this rate program. Critical for compliance and audit trails.',
    `season_type` STRING COMMENT 'Defines whether the program applies year-round or only during specific seasons. SEASONAL_VARIABLE indicates different rate periods apply in different seasons.. Valid values are `SUMMER|WINTER|YEAR_ROUND|SEASONAL_VARIABLE`',
    `shoulder_period_definition` STRING COMMENT 'Textual or structured definition of shoulder (mid-peak) period hours, if applicable. Nullable if program has only peak/off-peak structure.',
    `summer_end_month_day` STRING COMMENT 'Month and day when summer season ends (MM-DD format, e.g., 09-30 for September 30th). Applicable when season_type includes summer periods.. Valid values are `^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$`',
    `summer_start_month_day` STRING COMMENT 'Month and day when summer season begins (MM-DD format, e.g., 06-01 for June 1st). Applicable when season_type includes summer periods.. Valid values are `^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$`',
    `vee_validation_rule_set` STRING COMMENT 'Reference to the VEE rule set applied to interval data for this program. Defines validation, estimation, and editing processes for data quality assurance.',
    CONSTRAINT pk_tou_rate_program PRIMARY KEY(`tou_rate_program_id`)
) COMMENT 'Defines Time-of-Use (TOU) and Critical Peak Pricing (CPP) rate program structures and manages meter point enrollments in those programs. For program definition: specifies program code, peak/off-peak/shoulder period definitions, seasonal schedules, CPP event trigger criteria, applicable customer segments, effective date range, rate period definitions, and regulatory approval reference. For enrollment: tracks meter point association via enrollment records with enrollment ID, enrollment effective date, program end date, enrollment channel (web/CSR/auto), opt-in/opt-out status, and program-specific meter configuration requirements triggered by enrollment. Owned by metering as the SSOT for rate period time definitions that govern interval data classification and enrollment lifecycle; pricing amounts are owned by the billing domain. Enables billing domain to apply correct TOU rate periods to validated interval data and supports demand response domain for CPP event targeting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` (
    `net_energy_metering_id` BIGINT COMMENT 'Unique identifier for the net energy metering enrollment record. Primary key for the NEM master registry.',
    `account_id` BIGINT COMMENT 'Reference to the customer account responsible for the NEM enrollment. Links to billing and customer master data.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.interconnection_agreement. Business justification: NEM metering records must reference the interconnection agreement governing export limits and metering configuration for billing reconciliation and CPUC/state regulatory compliance. The existing plain',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: NEM installations are subject to compliance audits — interconnection audits, RPS program audits, and utility commission audits of NEM program administration. net_energy_metering has inspection_date an',
    `compliance_rec_certificate_id` BIGINT COMMENT 'Foreign key linking to compliance.rec_certificate. Business justification: NEM generation produces RECs tracked for RPS compliance, ownership determination per state renewable energy programs. Enables REC accounting, compliance credit calculation, renewable energy reporting ',
    `customer_service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: NEM program administration and annual true-up billing require the NEM record to reference the governing customer service agreement that defines the NEM rate schedule, export compensation terms, and co',
    `der_interconnection_point_id` BIGINT COMMENT 'Foreign key linking to distribution.der_interconnection_point. Business justification: NEM program enrollment must link to physical DER interconnection asset for export capacity validation, permission-to-operate verification, tariff eligibility confirmation, and reconciling billing cred',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: NEM enrollment must track the specific DER system for generation credit reconciliation, true-up calculations, and system capacity verification against tariff limits. Required for billing accuracy.',
    `enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.enrollment. Business justification: NEM is a specific program enrollment type requiring lifecycle tracking (application, approval, termination). Supports regulatory reporting, program administration, and customer service where enrollmen',
    `inspection_milestone_id` BIGINT COMMENT 'Foreign key linking to interconnection.inspection_milestone. Business justification: NEM enrollment is legally triggered by the PTO inspection milestone (inspection_milestone.pto_issued_flag, nem_enrollment_triggered_flag). Linking the NEM metering record to the authorizing inspection',
    `meter_id` BIGINT COMMENT 'Reference to the bi-directional meter installed at the premise to measure both import and export energy flows. Must be AMI-capable for interval data collection.',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: NEM true-up billing and credit reconciliation requires the utility-side NEM program record (net_energy_metering) to directly reference the customers NEM account (nem_account) in the renewable domain.',
    `nem_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.nem_agreement. Business justification: NEM metering enrollment records must reference the governing NEM agreement for true-up billing, credit banking, and regulatory reporting. Utilities join these records daily for NEM true-up calculation',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: NEM program management, RPS compliance tracking, and generation technology reporting require the utility NEM record to reference the DER registry entry for the generating system. Enables NEM eligibili',
    `meter_point_id` BIGINT COMMENT 'FK to metering.meter_point.meter_point_id — NEM enrollment must reference the meter point where bi-directional metering is configured. Essential for identifying NEM premises and applying special billing treatment.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: NEM programs are governed by state-specific compliance obligations (RPS mandates, interconnection standards, export compensation rules). Each NEM enrollment must reference the applicable regulatory ob',
    `ppa_id` BIGINT COMMENT 'Foreign key linking to trading.ppa. Business justification: NEM customers with solar installations often have underlying power purchase agreements; tracking which PPA supplies the generation measured by the NEM meter is essential for compliance verification, s',
    `premise_id` BIGINT COMMENT 'Reference to the customer premise enrolled in the NEM program. Links to the physical service location with behind-the-meter generation.',
    `primary_net_meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Net Energy Metering (NEM) enrollment is tied to a specific service delivery point (meter_point) where the distributed energy resource (DER) system is physically interconnected. While net_energy_meteri',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: NEM true-up calculations, export credit rates, and banking balance computations are governed by the NEM tariff rate schedule. The plain rate_schedule_code on net_energy_metering is a denormalization s',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: NEM programs require periodic regulatory filings (annual reports on enrollment, generation, credits issued per state PUC requirements). Supports regulatory reporting obligations, rate case support, pr',
    `application_date` DATE COMMENT 'Date the customer submitted the NEM interconnection application to the utility. Used to determine applicable tariff version and grandfathering provisions.',
    `banking_balance_kwh` DECIMAL(18,2) COMMENT 'The cumulative net excess generation (kWh) banked as a credit within the current true-up period. Positive balance indicates customer has exported more than imported; negative balance indicates net import. Balance is carried forward month-to-month until true-up settlement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NEM enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `eligible_for_rec` BOOLEAN COMMENT 'Indicates whether the generation system is eligible to generate Renewable Energy Certificates (RECs) under state RPS programs. True if eligible; False if ineligible or RECs have been contractually assigned to the utility.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the NEM enrollment. Pending indicates application submitted but not yet approved; Active indicates interconnection complete and bi-directional metering operational; Suspended indicates temporary hold; Terminated indicates customer-initiated cancellation; Expired indicates end of program eligibility period.. Valid values are `pending|active|suspended|terminated|expired`',
    `export_capacity_limit_kw` DECIMAL(18,2) COMMENT 'The maximum instantaneous power (kW) the customer is authorized to export to the grid. May be less than nameplate capacity due to grid constraints or inverter settings. Enforced by inverter configuration.',
    `export_credit_rate_type` STRING COMMENT 'The methodology used to calculate the monetary credit for energy exported to the grid. Retail Rate (NEM 1.0) credits at full retail rate; Avoided Cost credits at utilitys marginal generation cost; NEM 3.0 Export Rate uses time-varying export compensation rates; Wholesale Rate credits at market energy price.. Valid values are `retail_rate|avoided_cost|nem_3_export_rate|wholesale_rate`',
    `generation_technology_type` STRING COMMENT 'The type of behind-the-meter generation technology installed at the premise. Solar PV is the most common; other eligible technologies include wind turbines, fuel cells, biogas generators, micro-hydro, combined heat and power (CHP), and battery storage systems. [ENUM-REF-CANDIDATE: solar_pv|wind|fuel_cell|biogas|micro_hydro|combined_heat_power|battery_storage — 7 candidates stripped; promote to reference product]',
    `grandfathered_expiration_date` DATE COMMENT 'The date the grandfathered tariff protection expires and the customer transitions to the current NEM tariff. Null if not grandfathered or if grandfathering is perpetual.',
    `grandfathered_tariff_flag` BOOLEAN COMMENT 'Indicates whether the customer is grandfathered under a prior NEM tariff version due to application date. True if grandfathered; False if subject to current tariff. Grandfathering typically lasts 20 years from PTO date.',
    `has_energy_storage` BOOLEAN COMMENT 'Indicates whether the NEM system includes a battery energy storage system (BESS) for behind-the-meter storage. True if storage is present; False if generation-only. Storage systems may be subject to additional tariff rules and export limitations.',
    `installer_company_name` STRING COMMENT 'The name of the contractor or company that installed the behind-the-meter generation system. Required for warranty claims and quality assurance tracking.',
    `installer_license_number` STRING COMMENT 'The state-issued contractor license number of the installer. Required to verify installer is properly licensed and bonded per state electrical code requirements.',
    `interconnection_approval_date` DATE COMMENT 'Date the utility approved the interconnection application and authorized the customer to energize the behind-the-meter generation system. Marks the start of NEM program participation.',
    `inverter_manufacturer` STRING COMMENT 'The manufacturer of the inverter that converts DC power from the generation source to AC power for grid export. Required for equipment certification and warranty tracking.',
    `inverter_model` STRING COMMENT 'The specific model number of the inverter installed. Must be on the utilitys approved equipment list and comply with IEEE 1547 anti-islanding and voltage/frequency ride-through requirements.',
    `inverter_serial_number` STRING COMMENT 'The unique serial number of the inverter unit installed at the premise. Used for warranty claims, equipment recalls, and field service tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this NEM enrollment record was last updated. Used for audit trail and change tracking.',
    `last_true_up_date` DATE COMMENT 'The date of the most recent annual NEM true-up settlement. Used to track true-up cycle and determine next true-up anniversary.',
    `nameplate_capacity_kw` DECIMAL(18,2) COMMENT 'The rated maximum output capacity of the behind-the-meter generation system in kilowatts (kW). Used to determine interconnection study requirements and export limits.',
    `nem_program_type` STRING COMMENT 'The specific NEM tariff program under which the customer is enrolled. NEM 1.0 provides full retail rate credit for exports; NEM 2.0 includes non-bypassable charges; NEM 3.0 uses export compensation rates; VNEM is Virtual Net Energy Metering for multi-tenant properties; NEM-ST is NEM with energy storage.. Valid values are `NEM 1.0|NEM 2.0|NEM 3.0|VNEM|NEM-ST`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational comments related to the NEM enrollment. May include interconnection study findings, customer requests, or billing exceptions.',
    `permission_to_operate_date` DATE COMMENT 'Date the utility issued Permission to Operate (PTO), authorizing the customer to begin exporting energy to the grid. Bi-directional metering and export credit calculations commence from this date.',
    `rec_ownership` STRING COMMENT 'Identifies who retains ownership of the RECs generated by the system. Customer retains RECs unless contractually assigned to the utility or sold to a third party. Not Applicable if system is not REC-eligible.. Valid values are `customer|utility|third_party|not_applicable`',
    `storage_capacity_kwh` DECIMAL(18,2) COMMENT 'The rated energy storage capacity of the battery system in kilowatt-hours (kWh). Null if no storage is present. Used to assess demand response and grid services potential.',
    `storage_power_rating_kw` DECIMAL(18,2) COMMENT 'The maximum charge/discharge power rating of the battery system in kilowatts (kW). Null if no storage is present. Determines instantaneous grid support capability.',
    `system_installation_date` DATE COMMENT 'The date the behind-the-meter generation system was physically installed at the premise. May precede Permission to Operate date. Used for warranty tracking and system age analysis.',
    `tariff_reference` STRING COMMENT 'The specific tariff rule or schedule reference governing this NEM enrollment. Includes tariff book section, effective date, and any rider or special condition references. Used for regulatory compliance and billing validation.',
    `termination_date` DATE COMMENT 'Date the NEM enrollment was terminated or expired. Null for active enrollments. Used to calculate final true-up and settle remaining kWh credit balance.',
    `true_up_anniversary_month` STRING COMMENT 'The calendar month (1-12) in which the annual NEM true-up settlement occurs. Determines when banked kWh credits are reconciled and any remaining balance is settled or forfeited.',
    `true_up_period_months` STRING COMMENT 'The number of months in the NEM billing cycle before a true-up settlement occurs. Typically 12 months. During the true-up period, excess generation credits are banked; at true-up, remaining credits are settled or forfeited per tariff rules.',
    CONSTRAINT pk_net_energy_metering PRIMARY KEY(`net_energy_metering_id`)
) COMMENT 'Master record for customer premises enrolled in Net Energy Metering (NEM) programs — tracking bi-directional energy flow measurement for customers with behind-the-meter generation (rooftop solar, battery storage). Captures NEM program type (NEM 1.0/2.0/3.0), interconnection approval date, export capacity (kW), generation technology type, inverter details, true-up period, banking balance (kWh credits), and regulatory tariff reference. Distinct from standard metering — NEM requires bi-directional meter configuration and special billing treatment including export credit calculations.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` (
    `remote_service_order_id` BIGINT COMMENT 'Unique identifier for the remote service order executed via Advanced Metering Infrastructure (AMI) on a smart meter.',
    `account_id` BIGINT COMMENT 'Customer account identifier associated with the remote service order, used for meter-to-cash workflows.',
    `ami_head_end_id` BIGINT COMMENT 'Foreign key linking to metering.ami_head_end. Business justification: Remote service orders (disconnect, reconnect, load limit, firmware update, on-demand read) are executed through specific AMI head-end systems. The remote_service_order table currently has ami_head_end',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: Remote service operations (mass disconnects/reconnects, load limiting) during grid modernization or construction projects require tracking against capital projects for cost allocation, project managem',
    `collections_id` BIGINT COMMENT 'Foreign key linking to billing.collections. Business justification: Collections cases manage disconnect/reconnect scheduling (disconnect_scheduled_date, reconnect_date on collections). The remote service order executes the physical AMI command. This FK links the colle',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: Remote service orders (disconnect/reconnect commands) are issued to execute curtailment instructions on DER meters. Linking to curtailment_event enables curtailment compliance audit trails showing whi',
    `customer_service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Disconnect and reconnect remote service orders are governed by CSA terms including life support flags, deposit requirements, and contract demand thresholds. Regulatory compliance for disconnection (e.',
    `customer_service_request_id` BIGINT COMMENT 'Foreign key linking to customer.service_request. Business justification: Remote disconnect/reconnect operations are often initiated by customer service requests (non-payment, move-in/out, safety concerns). Supports customer service workflows, SLA tracking, and audit trails',
    `cycle_id` BIGINT COMMENT 'Identifier of the billing cycle during which the remote service order was executed, used for meter-to-cash reconciliation and revenue assurance.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Remote disconnect/reconnect commands for DER sites during emergency curtailment events, interconnection violations, or VPP dispatch. Emergency curtailment dispatch process requires remote service orde',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: Remote commands to DER meters (export curtailment, disconnect, firmware update) must reference the DER system to enforce interconnection agreement export limits and protection settings. Grid operators',
    `dr_event_id` BIGINT COMMENT 'Identifier of the demand response event that triggered the remote service order, if the order is part of a load management or curtailment program.',
    `dunning_notice_id` BIGINT COMMENT 'Foreign key linking to billing.dunning_notice. Business justification: Disconnect remote service orders are directly triggered by dunning notices at a specific dunning level. This FK links the physical AMI disconnect command to the dunning notice that initiated it, requi',
    `ems_node_id` BIGINT COMMENT 'Foreign key linking to grid.ems_node. Business justification: Before executing remote disconnect/reconnect or load-limiting orders on large C&I customers, grid operators assess EMS node loading impact. NERC reliability standards require load impact assessment be',
    `meter_point_id` BIGINT COMMENT 'Identifier of the service point associated with the meter receiving the remote service action.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Remote disconnect/reconnect orders must comply with regulatory obligations — consumer protection rules, disconnection moratoriums, advance notice requirements, and medical baseline protections. remote',
    `meter_id` BIGINT COMMENT 'Identifier of the smart meter on which the remote service action was executed.',
    `scada_point_id` BIGINT COMMENT 'Foreign key linking to grid.scada_point. Business justification: Remote disconnect/reconnect commands coordinate with SCADA-controlled distribution switching for load management, demand response, and safety interlocks. Distribution automation integration requiremen',
    `to_meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — Remote service orders (connect/disconnect/on-demand read) must reference the target meter device. Core operational link for AMI remote operations.',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: VPP dispatch operations issue remote service orders to DER meters for load control and generation dispatch. Linking remote_service_order to vpp_configuration enables VPP dispatch audit trails and perf',
    `work_order_id` BIGINT COMMENT 'Identifier of the associated field work order if the remote service order was initiated as part of a broader field service activity (e.g., meter installation, maintenance).',
    `actual_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service order was actually executed on the meter, recorded by the AMI head-end system upon completion.',
    `ami_transaction_code` STRING COMMENT 'Unique transaction identifier assigned by the AMI head-end system for tracking the command execution at the network layer.',
    `command_payload` STRING COMMENT 'Technical payload or command string sent to the meter by the AMI head-end system, stored for audit and troubleshooting purposes.',
    `communication_protocol` STRING COMMENT 'Communication protocol used by the AMI network to transmit the remote service command to the meter (e.g., ZigBee, cellular, RF mesh, power line carrier, Wi-Fi).. Valid values are `zigbee|cellular|rf_mesh|plc|wifi`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service order reached a terminal state (success, failed, cancelled, or timeout) and was closed in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service order record was first created in the system, supporting audit trail and data lineage requirements.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether a customer notification (email, SMS, IVR call) was sent prior to or after the remote service order execution, as required by regulatory or business policy.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer notification was sent regarding the remote service order, used for regulatory compliance documentation.',
    `disconnect_reason` STRING COMMENT 'Business reason for a remote disconnect order, supporting meter-to-cash workflows and regulatory compliance reporting (e.g., non-payment, customer request, safety hazard).. Valid values are `non_payment|customer_request|safety|maintenance|meter_replacement|load_management`',
    `execution_result_code` STRING COMMENT 'Standardized code returned by the AMI head-end system indicating the outcome of the remote service order execution (e.g., SUCCESS, METER_OFFLINE, COMMAND_REJECTED, TIMEOUT).',
    `failure_reason_code` STRING COMMENT 'Detailed code explaining why the remote service order failed, populated only when order_status is failed; used for root cause analysis and retry logic.',
    `failure_reason_description` STRING COMMENT 'Human-readable description of the failure reason, providing additional context for troubleshooting and customer communication.',
    `firmware_version_after` STRING COMMENT 'Target meter firmware version to be installed by the over-the-air (OTA) update, verified upon successful completion.',
    `firmware_version_before` STRING COMMENT 'Meter firmware version installed before the over-the-air (OTA) update, used for version control and rollback tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service order record was last modified, supporting audit trail and change tracking requirements.',
    `load_limit_threshold_kw` DECIMAL(18,2) COMMENT 'Power threshold in kilowatts (kW) set for load limiting activation orders, restricting customer consumption to prevent overload or support demand response programs.',
    `max_retry_count` STRING COMMENT 'Maximum number of retry attempts allowed for this remote service order before it is marked as permanently failed.',
    `meter_reading_timestamp` TIMESTAMP COMMENT 'Date and time when the meter reading was captured at the meter during an on-demand read remote service order.',
    `meter_reading_uom` STRING COMMENT 'Unit of measure for the meter reading value captured during on-demand read (e.g., kWh for energy, kW for demand, kVAh for apparent energy).. Valid values are `kWh|MWh|kW|kVAh|kVArh`',
    `meter_reading_value` DECIMAL(18,2) COMMENT 'Meter register reading value captured during an on-demand read remote service order, used for billing validation or dispute resolution.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by users or systems regarding the remote service order, capturing additional context, special instructions, or resolution details.',
    `order_number` STRING COMMENT 'Externally visible unique business identifier for the remote service order, used for tracking and customer communication.. Valid values are `^RSO-[0-9]{10}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the remote service order: pending (queued), in progress (executing), success (completed successfully), failed (execution error), cancelled (user/system cancelled), or timeout (no response from meter).. Valid values are `pending|in_progress|success|failed|cancelled|timeout`',
    `order_type` STRING COMMENT 'Type of remote service action executed via AMI: remote connect, remote disconnect, on-demand meter read, load limiting activation/deactivation, or firmware over-the-air (OTA) update.. Valid values are `remote_connect|remote_disconnect|on_demand_read|load_limit_activation|load_limit_deactivation|firmware_ota_update`',
    `priority` STRING COMMENT 'Priority level assigned to the remote service order, determining execution sequence in the AMI command queue (critical for safety/emergency, high for revenue protection, normal for routine, low for bulk operations).. Valid values are `critical|high|normal|low`',
    `reconnect_reason` STRING COMMENT 'Business reason for a remote reconnect order, typically following payment receipt or resolution of the disconnect condition.. Valid values are `payment_received|customer_request|service_restored|meter_replacement_complete|load_management_end`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the remote service order execution complies with applicable Public Utility Commission (PUC) regulations for disconnect/reconnect procedures and customer notification requirements.',
    `requested_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service order was requested by the system or user, representing the business event initiation time.',
    `requesting_system` STRING COMMENT 'Name or identifier of the source system that initiated the remote service order (e.g., CC&B, OMS, MDM, manual CSR entry).',
    `response_payload` STRING COMMENT 'Technical response payload returned by the meter to the AMI head-end system, stored for audit and troubleshooting purposes.',
    `retry_count` STRING COMMENT 'Number of times the remote service order has been retried after initial failure, used to track execution persistence and prevent infinite retry loops.',
    `scheduled_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service order is scheduled to be executed on the meter, may differ from requested timestamp for planned actions.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Signal strength in decibels-milliwatts (dBm) measured at the time of remote service order execution, used to diagnose communication failures.',
    CONSTRAINT pk_remote_service_order PRIMARY KEY(`remote_service_order_id`)
) COMMENT 'Operational record of a remote service action executed via AMI on a smart meter — including remote connect, remote disconnect, remote meter read on demand, load limiting activation, and firmware over-the-air (OTA) update commands. Captures order type, requested timestamp, execution timestamp, requesting system or user, execution result (success/failure/pending), failure reason code, and retry count. Supports meter-to-cash workflows (disconnect for non-payment, reconnect after payment) and field operations efficiency tracking.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`meter_test` (
    `meter_test_id` BIGINT COMMENT 'Unique identifier for the meter test record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Meter accuracy test failures trigger billing adjustments that must be tracked to specific customer accounts. Supports revenue protection, regulatory compliance for meter accuracy standards, and custom',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Failed meter tests trigger billing adjustments for inaccurate metering periods (regulatory requirement). This link directly connects test results to financial corrections, supports PUC audit trails, a',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.interconnection_agreement. Business justification: Meter accuracy tests for DER/NEM meters must be traceable to the interconnection agreement specifying required accuracy class and test schedules. Regulatory compliance reporting (FERC, state PUC) requ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Meter testing programs audited for compliance with testing frequency, accuracy standards, documentation requirements. Provides audit evidence for measurement accuracy programs, regulatory inspection s',
    `customer_service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.customer_service_agreement. Business justification: Meter test results trigger retroactive billing adjustments under the governing customer service agreement. Regulatory requirements (e.g., ANSI C12, state PUC rules) mandate tracking which CSA a meter ',
    `customer_service_request_id` BIGINT COMMENT 'Reference to the customer service request that initiated the meter test, if applicable. Links to the customer service system for complaint tracking and resolution.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Accuracy testing of bidirectional meters at DER installations for regulatory compliance and revenue assurance. Annual DER meter testing program requires test records linked to DER for compliance repor',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_permit. Business justification: Meter test facilities require environmental permits for calibration equipment, hazardous waste disposal (mercury switches, electronic waste). Enables permit compliance tracking for test labs, regulato',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to asset.asset_inspection. Business justification: Meter testing is a specialized asset inspection activity. Utilities integrate meter test results (accuracy, condition ratings, defects) into asset health monitoring and condition-based maintenance pro',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to asset.maintenance_plan. Business justification: Meter accuracy tests are executed as part of scheduled maintenance plans (ANSI C12 periodic test cycles, state PUC-mandated test schedules). Linking meter_test to the triggering maintenance_plan suppo',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Meter testing is mandated by compliance obligations (ANSI C12.1, state PUC rules specifying test frequency by meter class and accuracy tolerance). Linking meter_test to the governing obligation enable',
    `meter_id` BIGINT COMMENT 'Reference to the meter that was tested. Links to the meter asset registry.',
    `register_id` BIGINT COMMENT 'Foreign key linking to metering.register. Business justification: A meter accuracy test is conducted on a specific register (measurement channel) within a meter. meter_test already links to the meter via primary_meter_id, but a meter can have multiple registers (e.g',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Annual meter test results must be submitted to the PUC in regulatory filings. meter_test has regulatory_report_submitted_flag (boolean denormalization). Adding regulatory_filing_id links each test rec',
    `to_meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — Meter test results must reference the meter device tested. Required for regulatory compliance (PUC meter testing requirements) and accuracy tracking.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized or triggered the meter test. Links to the work management system for scheduling, labor tracking, and cost allocation.',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'Measured accuracy of the meter expressed as a percentage error. Positive values indicate the meter is running fast (over-registering); negative values indicate the meter is running slow (under-registering). Calculated as ((measured - actual) / actual) * 100.',
    `as_found_reading` DECIMAL(18,2) COMMENT 'Meter register reading captured at the beginning of the test, before any adjustments or repairs. Represents the meter state as found in the field or upon receipt at the test facility. Measured in kilowatt-hours (kWh).',
    `as_left_reading` DECIMAL(18,2) COMMENT 'Meter register reading captured at the conclusion of the test, after any adjustments, calibrations, or repairs. Represents the meter state after corrective action. Measured in kilowatt-hours (kWh).',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Calculated billing adjustment amount resulting from the meter test, measured in local currency. Positive values indicate customer credit (meter was over-registering); negative values indicate back-billing (meter was under-registering). Calculated based on accuracy error, consumption history, and regulatory back-billing limits.',
    `billing_adjustment_required_flag` BOOLEAN COMMENT 'Indicates whether the test results require a billing adjustment (back-billing or credit). True if meter was found out of tolerance and billing correction is needed; false otherwise. Triggers downstream billing adjustment workflow.',
    `corrective_action_code` STRING COMMENT 'Standardized code representing the corrective action taken. None indicates meter passed without adjustment; calibrated indicates meter was adjusted to meet accuracy standards; repaired indicates component-level repair; replaced indicates meter was swapped; sealed indicates new tamper seal applied; retired indicates meter removed from service.. Valid values are `none|calibrated|repaired|replaced|sealed|retired`',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action performed on the meter following the test. May include calibration adjustments, component replacement, seal replacement, or meter replacement. Empty if no action was required (meter passed as-found).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this meter test record was first created in the system. Audit trail field for data lineage and compliance.',
    `customer_notification_date` DATE COMMENT 'Date on which the customer was notified of the test results. Required for regulatory compliance when test results trigger billing adjustments or service actions.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer was notified of the test results. True if notification was sent; false if not yet notified. Required for customer-requested tests and tests resulting in billing adjustments.',
    `failure_code` STRING COMMENT 'Standardized code categorizing the failure mode. Examples include accuracy-out-of-tolerance, display-failure, communication-failure, mechanical-damage, tampering-detected, seal-broken, internal-component-failure. Empty if meter passed. [ENUM-REF-CANDIDATE: accuracy_out_of_tolerance|display_failure|communication_failure|mechanical_damage|tampering_detected|seal_broken|internal_component_failure|environmental_damage|calibration_drift|manufacturing_defect — promote to reference product]',
    `failure_reason` STRING COMMENT 'Detailed description of why the meter failed the test, if applicable. May include root cause analysis such as component wear, environmental damage, tampering, manufacturing defect, or calibration drift. Empty if meter passed.',
    `power_factor` DECIMAL(18,2) COMMENT 'Power factor applied during the test, expressed as a decimal between 0 and 1. Represents the phase relationship between voltage and current. Unity power factor (1.0) represents purely resistive load; lagging power factor (e.g., 0.5 lag) simulates inductive loads common in industrial settings.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the test results have been included in regulatory reporting to the Public Utility Commission (PUC). True if reported; false if pending. Required for periodic meter testing compliance reports.',
    `regulatory_tolerance_percentage` DECIMAL(18,2) COMMENT 'The maximum allowable percentage error defined by the applicable regulatory standard. Meters exceeding this tolerance fail the test and require adjustment or replacement. Typical values range from ±2% to ±3% depending on meter class and jurisdiction.',
    `test_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to perform the meter test, including labor, equipment usage, and materials. Measured in local currency. Used for cost recovery and regulatory rate case support.',
    `test_current_amperes` DECIMAL(18,2) COMMENT 'Current level applied during the meter test, measured in amperes. Test standards typically specify light load, full load, and heavy load current levels to validate accuracy across the meters operating range.',
    `test_date` DATE COMMENT 'The date on which the meter test was performed. This is the principal business event timestamp for the test.',
    `test_duration_minutes` STRING COMMENT 'Total time required to complete the meter test, measured in minutes. Includes setup, test execution, and teardown. Used for labor costing and scheduling optimization.',
    `test_equipment_code` BIGINT COMMENT 'Reference to the test equipment or meter test bench used to perform the test. Links to the asset registry for calibration tracking and equipment certification.',
    `test_equipment_serial_number` STRING COMMENT 'Serial number of the test equipment used. Captured for traceability and to ensure test equipment is within its calibration period.',
    `test_facility_code` BIGINT COMMENT 'Reference to the facility or service center where the test was performed. Links to the facility registry for location tracking and certification management.',
    `test_load_kwh` DECIMAL(18,2) COMMENT 'The known reference load applied during the test, measured in kilowatt-hours. This is the standard energy quantity used to calculate meter accuracy by comparing the meters measured value against this reference.',
    `test_location` STRING COMMENT 'Physical location where the meter test was conducted. Field indicates in-situ testing at the customer premise; shop indicates utility service center; laboratory indicates independent testing facility; customer-premise indicates on-site testing; service-center indicates utility-operated test facility.. Valid values are `field|shop|laboratory|customer_premise|service_center`',
    `test_notes` STRING COMMENT 'Free-form notes captured by the test technician. May include observations about meter condition, environmental factors, customer interactions, or any anomalies encountered during testing.',
    `test_number` STRING COMMENT 'Business identifier for the meter test, typically assigned by the testing system or laboratory. Used for external reference and tracking.',
    `test_result` STRING COMMENT 'Overall pass/fail determination for the meter test based on regulatory accuracy thresholds. Pass indicates meter meets accuracy standards; fail indicates meter is out of tolerance; inconclusive means test could not produce a definitive result.. Valid values are `pass|fail|inconclusive`',
    `test_standard_applied` STRING COMMENT 'The regulatory or industry standard used to conduct and evaluate the meter test. Typically references ANSI C12.1, ANSI C12.20, or state Public Utility Commission (PUC) meter testing requirements. Defines the accuracy thresholds and test procedures applied.',
    `test_status` STRING COMMENT 'Current lifecycle status of the meter test. Scheduled indicates the test is planned; in-progress means testing is underway; completed indicates test finished successfully; cancelled means test was aborted; failed indicates test could not be completed due to technical issues; pending-review means results await validation.. Valid values are `scheduled|in_progress|completed|cancelled|failed|pending_review`',
    `test_technician_name` STRING COMMENT 'Full name of the technician who performed the meter test. Captured for audit trail and regulatory reporting purposes.',
    `test_timestamp` TIMESTAMP COMMENT 'Precise date and time when the meter test was initiated, including time zone. Provides granular event tracking for audit and scheduling purposes.',
    `test_type` STRING COMMENT 'Classification of the meter test. In-service tests are conducted in the field without removing the meter; shop tests are performed in a controlled laboratory environment; referee tests are independent third-party tests to resolve disputes; customer-requested tests are initiated by customer complaint; post-complaint tests follow service quality issues; periodic tests meet regulatory schedules; installation tests verify new meter accuracy; removal tests validate meter condition at decommissioning. [ENUM-REF-CANDIDATE: in_service|shop|referee|customer_requested|post_complaint|periodic|installation|removal — 8 candidates stripped; promote to reference product]',
    `test_voltage` DECIMAL(18,2) COMMENT 'Voltage level applied during the meter test, measured in volts. Typically matches the meters rated voltage (e.g., 120V, 240V, 480V) to simulate field operating conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this meter test record was last modified. Audit trail field for change tracking and data quality monitoring.',
    CONSTRAINT pk_meter_test PRIMARY KEY(`meter_test_id`)
) COMMENT 'Records the results of meter accuracy and performance tests conducted in the field or at a test laboratory — including periodic in-service tests, customer-requested tests, and post-complaint investigations. Captures test type (in-service/shop/referee), test date, test technician, test equipment used, accuracy result (percentage error), as-found and as-left readings, pass/fail determination, regulatory standard applied (ANSI C12.1), and any corrective action taken. Supports regulatory compliance with PUC meter testing requirements and back-billing adjustments.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` (
    `meter_reading_route_id` BIGINT COMMENT 'Primary key for meter_reading_route',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Meter reading routes are scheduled and executed per billing cycle; the billing cycle drives read frequency and billing period alignment. This FK links route scheduling to the governing billing cycle, ',
    `parent_meter_reading_route_id` BIGINT COMMENT 'Self-referencing FK on meter_reading_route (parent_meter_reading_route_id)',
    `assigned_region` STRING COMMENT 'Region code (e.g., ISO‑3166‑2) where the route operates.',
    `assigned_zone` STRING COMMENT 'Operational zone or service area within the region.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the route complies with regulatory or internal standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the route record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the route is retired or no longer used (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the route becomes valid for scheduling.',
    `estimated_duration_minutes` STRING COMMENT 'Planned time to complete the route, in minutes.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the route.',
    `max_distance_km` DECIMAL(18,2) COMMENT 'Maximum travel distance covered by the route.',
    `meter_reading_frequency_minutes` STRING COMMENT 'Target interval between successive meter reads on this route.',
    `meter_reading_route_description` STRING COMMENT 'Free‑form text describing the route, special instructions, or notes.',
    `meter_reading_route_status` STRING COMMENT 'Current operational status of the route.',
    `next_scheduled_timestamp` TIMESTAMP COMMENT 'Planned start time for the next execution of the route.',
    `number_of_meters` STRING COMMENT 'Count of meters assigned to the route.',
    `priority_level` STRING COMMENT 'Business priority of the route (1 = highest).',
    `route_code` STRING COMMENT 'External code or alphanumeric identifier assigned to the route.',
    `route_creation_method` STRING COMMENT 'How the route record was created.',
    `route_name` STRING COMMENT 'Human‑readable name of the route used by field crews.',
    `route_sequence` STRING COMMENT 'Ordinal position of the route in a larger schedule set.',
    `route_shift` STRING COMMENT 'Work shift during which the route is executed.',
    `route_type` STRING COMMENT 'Category of customers served by the route.',
    `route_vehicle_type` STRING COMMENT 'Typical vehicle used to service the route.',
    `route_version` STRING COMMENT 'Version number for change tracking of the route definition.',
    `schedule_type` STRING COMMENT 'Frequency at which the route is scheduled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the route record.',
    CONSTRAINT pk_meter_reading_route PRIMARY KEY(`meter_reading_route_id`)
) COMMENT 'Master reference table for meter_reading_route. Referenced by meter_reading_route_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`register` (
    `register_id` BIGINT COMMENT 'Primary key for register',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Register billing cycle assignment governs read scheduling and billing period alignment. The plain billing_cycle column on register is a denormalization signal. This FK links register configuration to ',
    `meter_id` BIGINT COMMENT 'Identifier of the physical meter to which this register belongs.',
    `parent_register_id` BIGINT COMMENT 'Self-referencing FK on register (parent_register_id)',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Register configuration (billable flag, TOU period assignment, tariff code) is governed by the rate schedule. The plain rate_schedule and tariff_code columns on register are denormalization signals. Th',
    `calibration_date` DATE COMMENT 'Date of the last calibration performed on the register.',
    `calibration_due_date` DATE COMMENT 'Planned date for the next calibration of the register.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the register metadata.',
    `connection_type` STRING COMMENT 'Physical connection type of the register to the meter.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the register record was first created in the system.',
    `current_rating` DECIMAL(18,2) COMMENT 'Rated current for the register (amperes).',
    `data_quality_flag` STRING COMMENT 'Overall quality assessment of the registers data.',
    `edit_flag` STRING COMMENT 'Indicates whether the registers data can be manually edited.',
    `effective_from` DATE COMMENT 'Date when the register became active for data collection.',
    `effective_until` DATE COMMENT 'Date when the register is scheduled to be retired or become inactive (null if open‑ended).',
    `estimation_method` STRING COMMENT 'Algorithm used to estimate missing or corrupted readings.',
    `is_billable` BOOLEAN COMMENT 'True if the registers readings are used for billing.',
    `is_cumulative` BOOLEAN COMMENT 'True if the register accumulates values over time (e.g., total kWh).',
    `is_virtual` BOOLEAN COMMENT 'True if the register is a calculated/virtual register, false if physical.',
    `last_reading_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reading recorded for the register.',
    `last_reading_value` DECIMAL(18,2) COMMENT 'Value of the most recent reading for the register.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window description for the register.',
    `max_capacity` DECIMAL(18,2) COMMENT 'Maximum measurable capacity of the register (in its unit).',
    `measurement_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to raw readings to obtain engineering units.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the registers readings.',
    `min_capacity` DECIMAL(18,2) COMMENT 'Minimum measurable capacity of the register (in its unit).',
    `notes` STRING COMMENT 'Free‑form notes for operational or engineering remarks.',
    `owner_department` STRING COMMENT 'Internal department responsible for the register.',
    `phase` STRING COMMENT 'Phase configuration of the register.',
    `reading_precision` STRING COMMENT 'Number of decimal places stored for each reading.',
    `register_category` STRING COMMENT 'Logical grouping of the register within the meter.',
    `register_code` STRING COMMENT 'External code or number assigned to the register by the utility.',
    `register_description` STRING COMMENT 'Free‑form description of the registers purpose and characteristics.',
    `register_name` STRING COMMENT 'Human‑readable name of the register used in reports and UI.',
    `register_status` STRING COMMENT 'Current operational status of the register.',
    `register_type` STRING COMMENT 'Category of measurement the register provides.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the register must be included in regulatory reports.',
    `settlement_type` STRING COMMENT 'Whether the register uses net or gross settlement for billing.',
    `source_system` STRING COMMENT 'Originating system that supplied the register definition (e.g., Oracle Utilities MDM).',
    `uom_conversion_factor` DECIMAL(18,2) COMMENT 'Factor to convert raw device units to the engineering unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the register record.',
    `validation_method` STRING COMMENT 'Method used to validate raw interval data for this register.',
    `voltage_rating` DECIMAL(18,2) COMMENT 'Rated voltage for the register (volts).',
    CONSTRAINT pk_register PRIMARY KEY(`register_id`)
) COMMENT 'Master reference table for register. Referenced by register_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`metering`.`service_point` (
    `service_point_id` BIGINT COMMENT 'Primary key for service_point',
    `cycle_id` BIGINT COMMENT 'Identifier of the billing cycle applied to the service point.',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Outage management, FLISR operations, and IEEE 1366 reliability reporting (SAIDI/SAIFI) require knowing which feeder serves each metering service point. Utility OMS and reliability analysts use this li',
    `parent_service_point_id` BIGINT COMMENT 'Self-referencing FK on service_point (parent_service_point_id)',
    `scada_point_id` BIGINT COMMENT 'Foreign key linking to grid.scada_point. Business justification: Service points for large C&I customers, DER interconnections, and substation connections are directly monitored via SCADA points. Grid switching order planning and outage coordination require knowing ',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: Regulatory reporting, rate schedule assignment, and franchise compliance require knowing which service territory a metering service point belongs to. Utility regulatory affairs teams use this link for',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Transmission-connected service points (large industrial customers, generation interconnections) are physically served from a specific transmission substation. Outage impact analysis, interconnection a',
    `activation_timestamp` TIMESTAMP COMMENT 'Date‑time when the service point became active.',
    `connection_type` STRING COMMENT 'Electrical connection configuration of the service point.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service point record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the quality of the interval data for this service point.',
    `data_quality_status` STRING COMMENT 'Categorical assessment of data quality.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date‑time when the service point was deactivated or retired.',
    `demand_response_eligible` BOOLEAN COMMENT 'Indicates if the service point can participate in demand‑response programs.',
    `external_code` STRING COMMENT 'Identifier used by external systems or regulatory filings.',
    `installation_date` DATE COMMENT 'Date the meter and service point were installed.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance was performed.',
    `last_read_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent validated meter reading.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the service point.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the service point.',
    `maintenance_status` STRING COMMENT 'Current status of the maintenance schedule.',
    `net_metering_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum generation capacity allowed under net‑metering.',
    `net_metering_flag` BOOLEAN COMMENT 'True if the service point is enrolled in net‑metering.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next maintenance activity.',
    `rated_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum electrical capacity the service point is authorized to deliver.',
    `reading_interval_minutes` STRING COMMENT 'Configured interval between meter reads.',
    `renewable_energy_source_flag` BOOLEAN COMMENT 'Indicates if the service point is supplied by renewable generation.',
    `service_end_date` DATE COMMENT 'Date the service point ceased delivering utility service, if applicable.',
    `service_point_name` STRING COMMENT 'Human‑readable name or label for the service point.',
    `service_point_status` STRING COMMENT 'Current operational status of the service point.',
    `service_point_type` STRING COMMENT 'Category of the service point based on customer class or usage.',
    `service_start_date` DATE COMMENT 'Date the service point began delivering utility service.',
    `tariff_code` STRING COMMENT 'Code representing the tariff applied to the service point.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service point record.',
    `voltage_level` STRING COMMENT 'Design voltage classification for the service point.',
    CONSTRAINT pk_service_point PRIMARY KEY(`service_point_id`)
) COMMENT 'Master reference table for service_point. Referenced by service_point_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_ami_head_end_id` FOREIGN KEY (`ami_head_end_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_head_end`(`ami_head_end_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_meter_reading_route_id` FOREIGN KEY (`meter_reading_route_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_reading_route`(`meter_reading_route_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_to_meter_id` FOREIGN KEY (`to_meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_to_meter_point_id` FOREIGN KEY (`to_meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_to_meter_id` FOREIGN KEY (`to_meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_ami_event_id` FOREIGN KEY (`ami_event_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_event`(`ami_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_meter_reading_route_id` FOREIGN KEY (`meter_reading_route_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_reading_route`(`meter_reading_route_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_register_id` FOREIGN KEY (`register_id`) REFERENCES `energy_utilities_ecm`.`metering`.`register`(`register_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_to_meter_point_id` FOREIGN KEY (`to_meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_vee_rule_id` FOREIGN KEY (`vee_rule_id`) REFERENCES `energy_utilities_ecm`.`metering`.`vee_rule`(`vee_rule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_interval_reading_id` FOREIGN KEY (`interval_reading_id`) REFERENCES `energy_utilities_ecm`.`metering`.`interval_reading`(`interval_reading_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_vee_rule_id` FOREIGN KEY (`vee_rule_id`) REFERENCES `energy_utilities_ecm`.`metering`.`vee_rule`(`vee_rule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_to_interval_reading_id` FOREIGN KEY (`to_interval_reading_id`) REFERENCES `energy_utilities_ecm`.`metering`.`interval_reading`(`interval_reading_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_to_vee_rule_id` FOREIGN KEY (`to_vee_rule_id`) REFERENCES `energy_utilities_ecm`.`metering`.`vee_rule`(`vee_rule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_ami_head_end_id` FOREIGN KEY (`ami_head_end_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_head_end`(`ami_head_end_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_to_ami_head_end_id` FOREIGN KEY (`to_ami_head_end_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_head_end`(`ami_head_end_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_to_meter_id` FOREIGN KEY (`to_meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ADD CONSTRAINT `fk_metering_tou_rate_program_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_primary_net_meter_point_id` FOREIGN KEY (`primary_net_meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_ami_head_end_id` FOREIGN KEY (`ami_head_end_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_head_end`(`ami_head_end_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_to_meter_id` FOREIGN KEY (`to_meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_register_id` FOREIGN KEY (`register_id`) REFERENCES `energy_utilities_ecm`.`metering`.`register`(`register_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_to_meter_id` FOREIGN KEY (`to_meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` ADD CONSTRAINT `fk_metering_meter_reading_route_parent_meter_reading_route_id` FOREIGN KEY (`parent_meter_reading_route_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_reading_route`(`meter_reading_route_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_parent_register_id` FOREIGN KEY (`parent_register_id`) REFERENCES `energy_utilities_ecm`.`metering`.`register`(`register_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ADD CONSTRAINT `fk_metering_service_point_parent_service_point_id` FOREIGN KEY (`parent_service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `energy_utilities_ecm`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Class Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Accuracy Class');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `ami_network_segment` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Network Segment');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `communication_module_serial` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Serial Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `communication_module_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `communication_module_type` SET TAGS ('dbx_value_regex' = 'RF Mesh|PLC|Cellular|Fiber|None');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `configuration_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `configuration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `current_rating_amps` SET TAGS ('dbx_business_glossary_term' = 'Current Rating in Amperes (Amps)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `demand_reset_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Demand Reset Interval in Minutes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `disconnect_switch_status` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Switch Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `disconnect_switch_status` SET TAGS ('dbx_value_regex' = 'Connected|Disconnected|Armed|Not Applicable');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Meter Firmware Version');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `form` SET TAGS ('dbx_business_glossary_term' = 'Meter Form Factor');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Length in Minutes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Lifecycle Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Installed|In Stock|In Transit|Retired|Failed|Under Test');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `load_profile_channels_enabled` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Channels Enabled');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Meter Manufacturer');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type Classification');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'AMI Smart Meter|Interval Meter|Demand Meter|Electromechanical|Electronic|Prepaid');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Model Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `module_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Firmware Version');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `module_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `module_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Failed|Replaced|Not Installed');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Meter Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `number_of_elements` SET TAGS ('dbx_business_glossary_term' = 'Number of Metering Elements');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Ownership Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'Utility Owned|Customer Owned|Leased|Third Party');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `register_configuration` SET TAGS ('dbx_business_glossary_term' = 'Register Configuration');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `remote_disconnect_capable` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capable Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Removal Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Seal Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `seal_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `seal_status` SET TAGS ('dbx_value_regex' = 'Intact|Broken|Missing|Not Applicable');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `signal_strength_baseline_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength Baseline in Decibels-Milliwatts (dBm)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class Rating');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ALTER COLUMN `voltage_class` SET TAGS ('dbx_value_regex' = '120V|240V|277V|480V|Primary Voltage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ems Node Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `meter_reading_route_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Route Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `ami_collector_code` SET TAGS ('dbx_business_glossary_term' = 'AMI (Advanced Metering Infrastructure) Collector Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `ami_collector_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `ami_network_segment` SET TAGS ('dbx_business_glossary_term' = 'AMI (Advanced Metering Infrastructure) Network Segment');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `ami_network_segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `contracted_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity (Kilowatts)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `cpp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'CPP (Critical Peak Pricing) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `der_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'DER (Distributed Energy Resource) Capacity (Kilowatts)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `der_interconnection_flag` SET TAGS ('dbx_business_glossary_term' = 'DER (Distributed Energy Resource) Interconnection Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `interval_data_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'Interval Data Collection Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Length (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `last_meter_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `load_profile_class` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Class');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `load_profile_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|street_lighting|municipal');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'NEM (Net Energy Metering) Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `network_topology_node` SET TAGS ('dbx_business_glossary_term' = 'Network Topology Node');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (Kilowatts)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase_wye|three_phase_delta|split_phase');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Service Activation Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Service Deactivation Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_business_glossary_term' = 'Service Point Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_activation|disconnected|abandoned');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_point_type` SET TAGS ('dbx_business_glossary_term' = 'Service Point Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_point_type` SET TAGS ('dbx_value_regex' = 'electric|gas|water|steam|dual_fuel|multi_commodity');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage Level');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_voltage_level` SET TAGS ('dbx_value_regex' = 'low_voltage|medium_voltage|high_voltage|extra_high_voltage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `service_voltage_value` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage Value (Volts)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MDM|CIS|GIS|ADMS|SCADA');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `tou_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'TOU (Time of Use) Enabled Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ALTER COLUMN `vee_processing_flag` SET TAGS ('dbx_business_glossary_term' = 'VEE (Validation Estimation and Editing) Processing Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `meter_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `customer_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `planned_outage_window_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Window Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Work Order ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Class');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_value_regex' = '0.2|0.5|1.0|2.0');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `ami_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `bidirectional_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Metering Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `billing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing End Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `billing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Start Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `ct_ratio` SET TAGS ('dbx_business_glossary_term' = 'Current Transformer (CT) Ratio');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `end_reading` SET TAGS ('dbx_business_glossary_term' = 'End Reading');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_notes` SET TAGS ('dbx_business_glossary_term' = 'Installation Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_number` SET TAGS ('dbx_business_glossary_term' = 'Installation Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Installation Reason Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_reason_code` SET TAGS ('dbx_value_regex' = 'new_service|meter_upgrade|meter_failure|ami_deployment|customer_request|regulatory_compliance');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_status` SET TAGS ('dbx_business_glossary_term' = 'Installation Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_status` SET TAGS ('dbx_value_regex' = 'active|removed|pending|suspended|failed');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|test|emergency');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `meter_location_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `meter_location_code` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|basement|utility_room|pole_mount|pad_mount');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Multiplier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase_wye|three_phase_delta');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `pt_ratio` SET TAGS ('dbx_business_glossary_term' = 'Potential Transformer (PT) Ratio');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `reading_uom` SET TAGS ('dbx_business_glossary_term' = 'Reading Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `register_count` SET TAGS ('dbx_business_glossary_term' = 'Register Count');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `remote_disconnect_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capable Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `removal_notes` SET TAGS ('dbx_business_glossary_term' = 'Removal Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_value_regex' = 'meter_failure|service_disconnect|meter_upgrade|customer_move|testing|end_of_life');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `removal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Removal Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `seal_number_1` SET TAGS ('dbx_business_glossary_term' = 'Seal Number 1');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `seal_number_2` SET TAGS ('dbx_business_glossary_term' = 'Seal Number 2');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `service_amperage` SET TAGS ('dbx_business_glossary_term' = 'Service Amperage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `service_voltage` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `start_reading` SET TAGS ('dbx_business_glossary_term' = 'Start Reading');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_tested');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ALTER COLUMN `vee_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Validation, Estimation, and Editing (VEE) Profile Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `interval_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Reading ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `energy_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Lmp Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `channel_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'AMI_PUSH|AMI_POLL|MANUAL|ESTIMATED|SCADA|IMPORT');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `collection_run_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Run ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `correction_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `data_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `daylight_saving_flag` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving Time (DST) Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `demand_response_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `estimation_method_code` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `load_profile_segment` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Segment');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `meter_read_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `meter_read_status` SET TAGS ('dbx_value_regex' = 'SUCCESS|PARTIAL|FAILED|TIMEOUT|COMM_ERROR');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `original_reading_value` SET TAGS ('dbx_business_glossary_term' = 'Original Reading Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `power_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Outage Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `quality_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `quality_code` SET TAGS ('dbx_value_regex' = 'RAW|ESTIMATED|SUBSTITUTED|EDITED|REJECTED|MISSING');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `reading_value` SET TAGS ('dbx_business_glossary_term' = 'Reading Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `reprocessing_flag` SET TAGS ('dbx_business_glossary_term' = 'Reprocessing Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `time_zone_offset` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Offset');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `time_zone_offset` SET TAGS ('dbx_value_regex' = '^[+-]d{2}:d{2}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `tou_bucket` SET TAGS ('dbx_business_glossary_term' = 'Time of Use (TOU) Bucket');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `tou_bucket` SET TAGS ('dbx_value_regex' = 'ON_PEAK|OFF_PEAK|SHOULDER|SUPER_OFF_PEAK|CRITICAL_PEAK');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|kW|kVArh|kVAr|kVAh|kVA');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `validation_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Exception Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'PENDING|VALIDATED|FAILED|BYPASSED');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level');
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|TRANSMISSION');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `meter_read_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Read ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `ami_event_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Event ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Lmp Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `meter_reading_route_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Route Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `vee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `average_daily_usage` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Usage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `billed_flag` SET TAGS ('dbx_business_glossary_term' = 'Billed Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `consumption_days` SET TAGS ('dbx_business_glossary_term' = 'Consumption Days');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Consumption Kilowatt-Hours (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand Kilowatts (kW)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `demand_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Demand Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Multiplier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `previous_read_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Read Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `previous_read_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Read Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_date` SET TAGS ('dbx_business_glossary_term' = 'Read Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_frequency` SET TAGS ('dbx_business_glossary_term' = 'Read Frequency');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi-monthly|quarterly|daily|on-demand');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Read Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_method` SET TAGS ('dbx_value_regex' = 'optical|RF|PLC|cellular|visual|handheld');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Read Quality Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Read Reason Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Read Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_source` SET TAGS ('dbx_business_glossary_term' = 'Read Source');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_source` SET TAGS ('dbx_value_regex' = 'AMI|AMR|manual|estimated|customer|remote');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_status` SET TAGS ('dbx_business_glossary_term' = 'Read Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_status` SET TAGS ('dbx_value_regex' = 'valid|estimated|suspect|failed|pending_validation|corrected');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_type` SET TAGS ('dbx_business_glossary_term' = 'Read Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_type` SET TAGS ('dbx_value_regex' = 'scheduled|special|final|initial|test|correction');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_uom` SET TAGS ('dbx_business_glossary_term' = 'Read Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `read_value` SET TAGS ('dbx_business_glossary_term' = 'Read Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `register_digits` SET TAGS ('dbx_business_glossary_term' = 'Register Digits');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `register_rollover_flag` SET TAGS ('dbx_business_glossary_term' = 'Register Rollover Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `scheduled_read_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Read Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `tou_period` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `tou_period` SET TAGS ('dbx_value_regex' = 'on-peak|off-peak|shoulder|super-off-peak');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `tou_register_flag` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Register Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Rule Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'VEE Algorithm Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_value_regex' = 'electric|gas|water|steam');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Approval Required Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Approved By User');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Audit Trail Enabled Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `billing_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `confidence_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Confidence Threshold Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'VEE Estimation Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `exception_handling_action` SET TAGS ('dbx_business_glossary_term' = 'VEE Exception Handling Action');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `exception_handling_action` SET TAGS ('dbx_value_regex' = 'flag_only|estimate|reject|manual_review|substitute');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Execution Frequency');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|on_demand');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Last Modified By User');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `lookback_period_days` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Lookback Period in Days');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Lower Limit');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `owner_group` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Owner Group');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Priority Order');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Category');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'spike_detection|zero_consumption|negative_value|missing_data|high_low_limit|consistency_check');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Description');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|testing|retired|suspended');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'validation|estimation|editing');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Threshold Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'kWh|MWh|percentage|count|standard_deviation|ratio');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Threshold Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Upper Limit');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Version Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Created By User');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `vee_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Exception Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `interval_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Data Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `vee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Rule Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `auto_resolution_attempted` SET TAGS ('dbx_business_glossary_term' = 'Auto-Resolution Attempted Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `auto_resolution_successful` SET TAGS ('dbx_business_glossary_term' = 'Auto-Resolution Successful Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `corrected_value` SET TAGS ('dbx_business_glossary_term' = 'Corrected Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'linear_interpolation|historical_average|similar_day|regression|manual_entry|none');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_disposition` SET TAGS ('dbx_business_glossary_term' = 'Exception Disposition');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_disposition` SET TAGS ('dbx_value_regex' = 'resolved|escalated|waived');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Exception Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^VEE-[0-9]{10}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Raised Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Exception Severity');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_source_system` SET TAGS ('dbx_business_glossary_term' = 'Exception Source System');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_source_system` SET TAGS ('dbx_value_regex' = 'MDM|AMI_head_end|SCADA|manual_entry|billing_system');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Exception Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|escalated|waived|closed');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Exception Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'validation_failure|estimation_failure|editing_failure|missing_data|suspect_data|out_of_range');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `interval_count` SET TAGS ('dbx_business_glossary_term' = 'Interval Count');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `original_value` SET TAGS ('dbx_business_glossary_term' = 'Original Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 're_estimate|manual_edit|accept_original|override|escalate|waive');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ALTER COLUMN `vee_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Batch Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `ami_head_end_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Head-End System ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Head End Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `actual_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Uptime Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `average_collection_success_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Collection Success Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'AMI Communication Protocol');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'RF Mesh|PLC|Cellular|Hybrid|Other');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `current_enrolled_device_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrolled Device Count');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Days');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `firmware_update_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Firmware Update Capability Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End Installation Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `last_collection_completeness_percent` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Completeness Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `last_collection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Duration in Minutes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `last_collection_success_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Success Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `last_scheduled_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Scheduled Collection Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `maximum_device_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Device Capacity');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `mdm_integration_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Meter Data Management (MDM) Integration Endpoint URL');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `mdm_integration_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `mdm_integration_protocol` SET TAGS ('dbx_business_glossary_term' = 'MDM Integration Protocol');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `mdm_integration_status` SET TAGS ('dbx_business_glossary_term' = 'MDM Integration Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `mdm_integration_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Error|Pending');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `network_topology` SET TAGS ('dbx_business_glossary_term' = 'AMI Network Topology');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `network_topology` SET TAGS ('dbx_value_regex' = 'Mesh|Star|Point-to-Point|Hybrid');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `network_uptime_sla_percent` SET TAGS ('dbx_business_glossary_term' = 'Network Uptime Service Level Agreement (SLA) Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `on_demand_collection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Demand Collection Enabled Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End Operational Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Maintenance|Decommissioned|Testing');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `outage_detection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Detection Enabled Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `remote_disconnect_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capability Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `scheduled_collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Collection Frequency');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `scheduled_collection_frequency` SET TAGS ('dbx_value_regex' = 'Hourly|Daily|Weekly|Monthly|On-Demand');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End Software Version');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `system_identifier` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End System Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End System Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `system_notes` SET TAGS ('dbx_business_glossary_term' = 'AMI Head-End System Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'AMI Vendor Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `vendor_name` SET TAGS ('dbx_value_regex' = 'Itron|Landis+Gyr|Sensus|Aclara|Elster|Honeywell|Trilliant|Silver Spring Networks|Other');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `vendor_support_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support Contract Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `vendor_support_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ALTER COLUMN `vendor_support_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `ami_event_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Event ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ems Node Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `failure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `ami_head_end_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Head End Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `communication_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Communication Failure Reason');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `communication_failure_reason` SET TAGS ('dbx_value_regex' = 'SIGNAL_LOSS|NETWORK_CONGESTION|DEVICE_OFFLINE|AUTHENTICATION_FAILURE|PROTOCOL_ERROR|UNKNOWN');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `confirmed_theft_indicator` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Theft Indicator');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `downstream_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Downstream Notification Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `downstream_notification_status` SET TAGS ('dbx_value_regex' = 'PENDING|NOTIFIED_OMS|NOTIFIED_BILLING|NOTIFIED_GRID_OPS|NOTIFICATION_FAILED|NOT_REQUIRED');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `estimated_unbilled_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unbilled Consumption (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_acknowledged_by` SET TAGS ('dbx_business_glossary_term' = 'Event Acknowledged By');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Event Acknowledged Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Acknowledged Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity Level');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW|INFORMATIONAL');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Event Type Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `firmware_version_after` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version After Update');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `firmware_version_before` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version Before Update');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `head_end_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Head-End System Receipt Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `investigation_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closure Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'OPEN|IN_PROGRESS|PENDING_FIELD_VISIT|CONFIRMED|DISMISSED|CLOSED');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `law_enforcement_referral_status` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `law_enforcement_referral_status` SET TAGS ('dbx_value_regex' = 'NOT_REFERRED|PENDING_REFERRAL|REFERRED|CASE_FILED|CASE_CLOSED');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `raw_event_payload` SET TAGS ('dbx_business_glossary_term' = 'Raw Event Payload');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `revenue_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recovery Amount');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `reverse_flow_kwh` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Energy (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `tamper_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detection Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `tamper_detection_method` SET TAGS ('dbx_value_regex' = 'AMI_ALERT|FIELD_INSPECTION|VEE_ANOMALY|CUSTOMER_REPORT|ROUTINE_AUDIT');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `tamper_type` SET TAGS ('dbx_business_glossary_term' = 'Tamper Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `tamper_type` SET TAGS ('dbx_value_regex' = 'COVER_REMOVAL|BYPASS|REVERSE_INSTALLATION|UNAUTHORIZED_RECONNECT|MAGNETIC_INTERFERENCE|INTERNAL_TAMPERING');
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ALTER COLUMN `voltage_measurement` SET TAGS ('dbx_business_glossary_term' = 'Voltage Measurement (Volts)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `tou_rate_program_id` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Rate Program ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `ami_meter_required` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Meter Required Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `billing_cycle_alignment_required` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Alignment Required Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `cpp_event_trigger_criteria` SET TAGS ('dbx_business_glossary_term' = 'Critical Peak Pricing (CPP) Event Trigger Criteria');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `cpp_max_event_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'CPP Maximum Event Duration (Hours)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `cpp_max_events_per_year` SET TAGS ('dbx_business_glossary_term' = 'CPP Maximum Events Per Year');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `cpp_notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'CPP Event Notification Lead Time (Hours)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'RESIDENTIAL|COMMERCIAL|INDUSTRIAL|AGRICULTURAL|MUNICIPAL|ALL');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `enrollment_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Criteria');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Enrollment Method');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'OPT_IN|OPT_OUT|DEFAULT|MANDATORY');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `estimated_annual_cost_savings_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Cost Savings (USD)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `estimated_annual_savings_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Energy Savings (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `integration_system_code` SET TAGS ('dbx_business_glossary_term' = 'Integration System Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `minimum_enrollment_period_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrollment Period (Months)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `minimum_interval_data_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Interval Data Frequency (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `off_peak_period_definition` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Period Time Definition');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `opt_out_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Opt-Out Allowed Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `opt_out_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Notice Period (Days)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `peak_period_definition` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Time Definition');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Description');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Department');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|RETIRED|CANCELLED');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'TOU|CPP|TOU_CPP_HYBRID|DYNAMIC_PRICING|REAL_TIME_PRICING');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Application Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'SUMMER|WINTER|YEAR_ROUND|SEASONAL_VARIABLE');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `shoulder_period_definition` SET TAGS ('dbx_business_glossary_term' = 'Shoulder Period Time Definition');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `summer_end_month_day` SET TAGS ('dbx_business_glossary_term' = 'Summer Season End Month-Day');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `summer_end_month_day` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `summer_start_month_day` SET TAGS ('dbx_business_glossary_term' = 'Summer Season Start Month-Day');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `summer_start_month_day` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ALTER COLUMN `vee_validation_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Rule Set');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `net_energy_metering_id` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `compliance_rec_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Rec Certificate Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `customer_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `der_interconnection_point_id` SET TAGS ('dbx_business_glossary_term' = 'Der Interconnection Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `inspection_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Milestone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `nem_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `ppa_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `primary_net_meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Application Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `banking_balance_kwh` SET TAGS ('dbx_business_glossary_term' = 'Banking Balance (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `eligible_for_rec` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Renewable Energy Certificate (REC) Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Enrollment Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|expired');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `export_capacity_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Capacity Limit (kW)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `export_credit_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Export Credit Rate Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `export_credit_rate_type` SET TAGS ('dbx_value_regex' = 'retail_rate|avoided_cost|nem_3_export_rate|wholesale_rate');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `generation_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Generation Technology Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `grandfathered_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Grandfathered Tariff Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `grandfathered_tariff_flag` SET TAGS ('dbx_business_glossary_term' = 'Grandfathered Tariff Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `has_energy_storage` SET TAGS ('dbx_business_glossary_term' = 'Has Energy Storage Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `installer_company_name` SET TAGS ('dbx_business_glossary_term' = 'Installer Company Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `installer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Installer License Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `interconnection_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Approval Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `inverter_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Inverter Manufacturer');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `inverter_model` SET TAGS ('dbx_business_glossary_term' = 'Inverter Model');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `inverter_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Inverter Serial Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `last_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last True-Up Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `nameplate_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (kW)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `nem_program_type` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Program Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `nem_program_type` SET TAGS ('dbx_value_regex' = 'NEM 1.0|NEM 2.0|NEM 3.0|VNEM|NEM-ST');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Enrollment Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `permission_to_operate_date` SET TAGS ('dbx_business_glossary_term' = 'Permission to Operate (PTO) Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `rec_ownership` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Ownership');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `rec_ownership` SET TAGS ('dbx_value_regex' = 'customer|utility|third_party|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `storage_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Capacity (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `storage_power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Power Rating (kW)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `system_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) System Installation Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `tariff_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tariff Reference');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Termination Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `true_up_anniversary_month` SET TAGS ('dbx_business_glossary_term' = 'True-Up Anniversary Month');
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ALTER COLUMN `true_up_period_months` SET TAGS ('dbx_business_glossary_term' = 'True-Up Period (Months)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` SET TAGS ('dbx_subdomain' = 'program_operations');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `remote_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Service Order ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `ami_head_end_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Head End Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `collections_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `customer_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `customer_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `dunning_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ems Node Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `actual_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `ami_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Transaction ID');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `command_payload` SET TAGS ('dbx_business_glossary_term' = 'Command Payload');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `command_payload` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'zigbee|cellular|rf_mesh|plc|wifi');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `disconnect_reason` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Reason');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `disconnect_reason` SET TAGS ('dbx_value_regex' = 'non_payment|customer_request|safety|maintenance|meter_replacement|load_management');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `execution_result_code` SET TAGS ('dbx_business_glossary_term' = 'Execution Result Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `failure_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Description');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `firmware_version_after` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version After Update');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `firmware_version_before` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version Before Update');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `load_limit_threshold_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Limit Threshold (kW)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `max_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Count');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `meter_reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `meter_reading_uom` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `meter_reading_uom` SET TAGS ('dbx_value_regex' = 'kWh|MWh|kW|kVAh|kVArh');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `meter_reading_value` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Value');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Remote Service Order Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^RSO-[0-9]{10}$');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Remote Service Order Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|success|failed|cancelled|timeout');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Remote Service Order Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'remote_connect|remote_disconnect|on_demand_read|load_limit_activation|load_limit_deactivation|firmware_ota_update');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `reconnect_reason` SET TAGS ('dbx_business_glossary_term' = 'Reconnect Reason');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `reconnect_reason` SET TAGS ('dbx_value_regex' = 'payment_received|customer_request|service_restored|meter_replacement_complete|load_management_end');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requested Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `requesting_system` SET TAGS ('dbx_business_glossary_term' = 'Requesting System');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `response_payload` SET TAGS ('dbx_business_glossary_term' = 'Response Payload');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `response_payload` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `scheduled_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Execution Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (dBm)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `meter_test_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Test Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `customer_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `customer_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Inspection Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `as_found_reading` SET TAGS ('dbx_business_glossary_term' = 'As-Found Reading');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `as_left_reading` SET TAGS ('dbx_business_glossary_term' = 'As-Left Reading');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Amount');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `billing_adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Required Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `corrective_action_code` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `corrective_action_code` SET TAGS ('dbx_value_regex' = 'none|calibrated|repaired|replaced|sealed|retired');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `regulatory_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tolerance Percentage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_cost` SET TAGS ('dbx_business_glossary_term' = 'Test Cost');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_current_amperes` SET TAGS ('dbx_business_glossary_term' = 'Test Current Amperes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Minutes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Serial Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Test Facility Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_load_kwh` SET TAGS ('dbx_business_glossary_term' = 'Test Load Kilowatt-Hours (kWh)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_location` SET TAGS ('dbx_value_regex' = 'field|shop|laboratory|customer_premise|service_center');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_standard_applied` SET TAGS ('dbx_business_glossary_term' = 'Test Standard Applied');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed|pending_review');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_technician_name` SET TAGS ('dbx_business_glossary_term' = 'Test Technician Name');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `test_voltage` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` ALTER COLUMN `meter_reading_route_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Route Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` ALTER COLUMN `parent_meter_reading_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ALTER COLUMN `parent_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `parent_service_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
