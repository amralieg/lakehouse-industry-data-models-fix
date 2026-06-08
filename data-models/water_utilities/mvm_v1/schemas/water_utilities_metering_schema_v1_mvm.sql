-- Schema for Domain: metering | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`metering` COMMENT 'Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`metering_meter` (
    `metering_meter_id` BIGINT COMMENT 'Primary key for meter',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMA boundary meters are a core NRW management concept — each meter must be assigned to a DMA to compute system input volume for water balance audits. ami_endpoint.dma_id covers AMI devices but not the',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Water meters are capital assets requiring fixed asset accounting for depreciation, asset retirement obligations, and GASB compliance. Meter populations represent significant utility plant investment r',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each installed meter corresponds to a material master record for procurement, inventory management, warranty tracking, and cost allocation. Procurement teams order meters by material number; warehouse',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter size and type combinations are standardized configurations defined in the meter_size_type reference table. The metering_meter table currently stores meter_size_inches and meter_type as denormali',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Meters are capital assets requiring lifecycle management, depreciation tracking, condition assessment, and regulatory compliance (GASB 34). Water utilities track meters in asset registries for replace',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: WWTP influent and effluent process meters must be traceable to their facility for NPDES permit DMR flow reporting and regulatory compliance. A process meter belongs to one WWTP; this FK enables audita',
    CONSTRAINT pk_metering_meter PRIMARY KEY(`metering_meter_id`)
) COMMENT 'Master inventory record for every physical meter device deployed across the water and wastewater service territory. Captures meter make, model, size, type (AMI/AMR/manual), serial number, manufacturer, installation date, current status, register type, pulse output factor, maximum flow rate (GPM), meter generation, and communication module type. Includes bulk/compound meters, fire service meters, and all residential/commercial/industrial meter classes. Serves as the authoritative SSOT for meter device identity and specifications within the metering domain.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`installation` (
    `installation_id` BIGINT COMMENT 'Primary key for installation',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Meter installations performed as part of CIP projects (main replacements, AMI deployments, system expansions) require project linkage for capital cost allocation, asset capitalization, project closeou',
    `connection_application_id` BIGINT COMMENT 'Foreign key linking to service.connection_application. Business justification: A meter installation is the physical fulfillment of an approved connection application. New service fulfillment tracking requires linking the installation record back to the originating connection app',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Meter installations must be tied to a physical asset location for field dispatch, GIS network analysis, and pressure zone reporting. Water utilities require installation-to-location linkage for servic',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: An installation represents the deployment of a physical meter device at a service location. The installation MUST reference which specific meter (from meter inventory) is installed. This is the core r',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Meter installations are physically executed at service points. Water utilities link installation records to service points for service activation workflows, field operations dispatch, and billing setu',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: A meter installation is physically located at a premise. Field operations dispatch, service activation, and premise history reporting all require knowing which premise an installation serves. This is ',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Meter installations are physically located at service lines. LCRR compliance requires knowing which meter installation is on which service line (lead/non-lead classification). Field crews dispatch to ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Meter installations executed under a CIP project are tracked at WBS element level for granular cost allocation and capitalization. Large AMI deployment projects require installation-level WBS assignme',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Every meter installation is executed via an asset work order. Water utilities track the originating work order on the installation record for cost accounting, labor tracking, and audit trails — standa',
    CONSTRAINT pk_installation PRIMARY KEY(`installation_id`)
) COMMENT 'Tracks the physical installation of a meter at a service location, linking a specific meter device to a service address and customer account. Records installation date, installer ID, work order reference, meter position (pit, vault, curb box), setter size, service line material, lock/seal number, initial register reading at installation, and removal date when replaced. Maintains the full history of which meter served which location over time, supporting NRW analysis and billing continuity.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI/AMR communication endpoint device. Primary key for the endpoint registry.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: AMI endpoint deployments are capital projects requiring tracking for warranty management, project performance metrics, capital cost allocation, and grant reporting. Utilities must trace each endpoint ',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area that this endpoint belongs to. Used for water loss analysis and pressure zone management.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: AMI endpoints are capitalized infrastructure assets separate from meters, with their own acquisition cost, depreciation schedule, and useful life under GASB 34. Water utilities capitalize AMI communic',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: AMI infrastructure deployments are frequently funded by USDA Rural Development, EPA, or state revolving fund grants. Water utilities must link individual AMI endpoints to the grant funding their deplo',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: AMI endpoints are procured materials with manufacturer part numbers, tracked in inventory for deployment, warranty management, and spare parts planning. Procurement orders endpoints by material number',
    `metering_meter_id` BIGINT COMMENT 'Reference to the physical water meter that this AMI endpoint is attached to. An endpoint may be replaced independently of the meter.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: AMI endpoints are deployed at specific service points. Utilities require this link for AMI network topology management, field dispatch to service point locations, and device-to-service-point reconcili',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: AMI endpoints are capital assets with acquisition cost, useful life, warranty, and cybersecurity compliance requirements. Utilities track these separately from meters for technology refresh cycles, FC',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: AMI deployment may be mandated by regulatory requirements for conservation tracking, demand management, and drought response capabilities. Real process: complying with state mandates for AMI deploymen',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: AMI endpoints are deployed within service territories. Utilities report AMI penetration rates by territory to regulators and use territory-level device counts for capital planning. A domain expert exp',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: AMI endpoint deployments under a CIP project require WBS-level cost tracking for capital asset capitalization. ami_endpoint already has cip_project_id but lacks WBS granularity needed for project cost',
    `battery_expected_life_years` DECIMAL(18,2) COMMENT 'Manufacturer-specified expected battery life in years under normal operating conditions. Typically 15-20 years for AMI endpoints.',
    `battery_install_date` DATE COMMENT 'Date when the battery was installed or last replaced in the endpoint device. Used to calculate expected battery life remaining.',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Current battery charge level as a percentage. Critical for battery-powered endpoints to schedule replacement before failure.',
    `commissioning_date` DATE COMMENT 'Date when the endpoint was successfully commissioned and began transmitting data to the AMI system. May differ from installation date.',
    `communication_frequency_minutes` STRING COMMENT 'Configured interval in minutes between endpoint transmissions. Typical values: 15, 30, 60 minutes for hourly reads; 1440 for daily reads.',
    `communication_protocol` STRING COMMENT 'Network communication protocol used by the endpoint. RF (Radio Frequency) for FlexNet, Cellular for 4G/5G, LoRaWAN for low-power wide-area, NB-IoT for narrowband cellular.. Valid values are `RF|Cellular|LoRaWAN|NB-IoT|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint record was first created in the system. Used for audit trail and data lineage.',
    `data_retention_days` STRING COMMENT 'Number of days of interval consumption data stored locally on the endpoint device before being overwritten. Typically 35-45 days.',
    `decommission_date` DATE COMMENT 'Date when the endpoint was removed from service or deactivated. Null for active endpoints.',
    `decommission_reason` STRING COMMENT 'Reason for endpoint decommissioning (e.g., meter replacement, device failure, service disconnection, upgrade to new technology).',
    `encryption_algorithm` STRING COMMENT 'Cryptographic algorithm used to secure communications between endpoint and collector. AES-128 or AES-256 for encrypted devices.. Valid values are `AES-128|AES-256|None`',
    `encryption_key_version` STRING COMMENT 'Version identifier for the encryption key currently provisioned on the endpoint. Used for secure communication and key rotation management.',
    `endpoint_serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the AMI/AMR endpoint device. Used for warranty tracking and device identification.',
    `endpoint_type` STRING COMMENT 'Type of AMI/AMR communication device. ERT (Encoder Receiver Transmitter) for drive-by reading, MXU (Meter Transmit Unit) for fixed network, iPerl for integrated smart meter, Orion for cellular endpoint, Ally for water meter module.. Valid values are `ERT|MXU|iPerl|Orion|Ally|Other`',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the endpoint device. Critical for security patches and feature updates.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the endpoint installation location in decimal degrees. Used for GIS mapping and network planning.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the endpoint installation location in decimal degrees. Used for GIS mapping and network planning.',
    `installation_date` DATE COMMENT 'Date when the AMI endpoint was installed and activated in the field. Used for warranty tracking and lifecycle management.',
    `installation_technician` STRING COMMENT 'Name or identifier of the technician who installed the endpoint device. Used for quality tracking and accountability.',
    `ip_address` STRING COMMENT 'IP address assigned to the endpoint device for cellular or IP-based communication protocols. Null for RF-only devices.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful communication received from this endpoint. Used to identify non-communicating devices.',
    `last_firmware_update_date` DATE COMMENT 'Date when the endpoint firmware was last updated. Critical for security patch tracking and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint record was last updated. Used for change tracking and audit trail.',
    `leak_alert_threshold_gpm` DECIMAL(18,2) COMMENT 'Continuous flow threshold in gallons per minute that triggers a leak alert. Typically 0.01 to 0.5 GPM for residential meters.',
    `leak_detection_enabled_flag` BOOLEAN COMMENT 'Indicates whether continuous leak detection monitoring is enabled on this endpoint. True if enabled, False if disabled.',
    `mac_address` STRING COMMENT 'Unique hardware address assigned to the endpoint network interface. Used for device authentication and network routing.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `network_node_code` STRING COMMENT 'Identifier for the network node or collector that this endpoint communicates with in the AMI network topology.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical information about the endpoint device.',
    `operational_status` STRING COMMENT 'Current operational status of the endpoint device. Active indicates normal operation, Failed indicates communication or device failure.. Valid values are `Active|Inactive|Suspended|Failed|Maintenance|Decommissioned`',
    `read_interval_seconds` STRING COMMENT 'Interval in seconds at which the endpoint records consumption data internally. Typical values: 900 (15 min), 3600 (hourly), 86400 (daily).',
    `reverse_flow_detected_flag` BOOLEAN COMMENT 'Indicates whether reverse flow has been detected by the endpoint. True if reverse flow detected, False otherwise. May indicate backflow or meter installation error.',
    `signal_quality_indicator` STRING COMMENT 'Qualitative assessment of communication signal quality. Derived from signal strength and packet success rate.. Valid values are `Excellent|Good|Fair|Poor|No Signal`',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Most recent radio signal strength measurement in dBm. Indicates communication quality between endpoint and collector. Typical range -110 to -50 dBm.',
    `tamper_detected_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent tamper event was detected by the endpoint. Null if no tamper has been detected.',
    `tamper_status` STRING COMMENT 'Current tamper detection status reported by the endpoint. Alerts to potential theft, fraud, or unauthorized access.. Valid values are `Normal|Tamper Detected|Magnetic Interference|Physical Removal|Reverse Flow`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the endpoint device expires. Used for replacement planning and cost recovery.',
    CONSTRAINT pk_ami_endpoint PRIMARY KEY(`ami_endpoint_id`)
) COMMENT 'Master record for each AMI/AMR communication endpoint device (encoder/receiver/transmitter unit) associated with a meter, and the fixed-network collector infrastructure (base stations, repeaters, mobile collectors) that enables automated reading across the service territory. Captures endpoint serial number, device type, firmware version, network node assignment, signal strength, battery level, last communication timestamp, encryption key version, tamper status, collector assignment, collector location, coverage area, and backhaul connection type. Distinct from the meter itself — one meter may have its endpoint replaced independently.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`read` (
    `read_id` BIGINT COMMENT 'Primary key for read',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: For AMI/AMR reads, the read is captured by a specific AMI endpoint device. This links the read event to the communication endpoint that transmitted the data. Manual reads would have NULL ami_endpoint_',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: A meter read is captured for a specific meter installation (a meter deployed at a location), not just an abstract meter device. Reads are tied to the installation context (location, service point). Th',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: Meter reads are collected along defined read routes (for manual, walk-by, or drive-by reading operations). Each read should reference which route it was collected on for operational tracking and route',
    CONSTRAINT pk_read PRIMARY KEY(`read_id`)
) COMMENT 'Individual meter reading record capturing the register value at a specific point in time for a given meter installation. Stores read date and time, read value (gallons or CCF), read type (AMI automated, AMR drive-by, manual field read, estimated), read source system, reader employee ID (for manual reads), read quality flag, exception code, and whether the read was used for billing. The authoritative transactional record for all meter reads feeding the Oracle CC&B billing cycle.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`interval_consumption` (
    `interval_consumption_id` BIGINT COMMENT 'Unique identifier for each interval consumption record. Primary key for the interval consumption data product.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI endpoint device that transmitted this interval data. Corresponds to the Sensus FlexNet endpoint serial number or device identifier.',
    `cycle_id` BIGINT COMMENT 'Reference to the billing cycle during which this interval occurred. Used to aggregate interval data for billing purposes and time-of-use rate calculations.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where this meter is located. Used for Non-Revenue Water (NRW) analysis, pressure zone management, and distribution network optimization.',
    `leak_detection_event_id` BIGINT COMMENT 'Foreign key linking to metering.leak_detection_event. Business justification: interval_consumption already has a leak_detection_flag (BOOLEAN) indicating that a specific interval record exhibits leak-like consumption patterns. When a leak_detection_event is formally raised, the',
    `installation_id` BIGINT COMMENT 'Reference to the specific meter installation that generated this interval reading. Links to the meter installation registry in the metering domain.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AMI interval data enables real-time revenue accrual accounting. Utilities must map interval consumption to GL accounts for unbilled revenue accrual at period-end, supporting accurate financial close p',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Interval consumption data is the direct basis for billing under a service agreement. Linking interval_consumption to service_agreement enables billing reconciliation, consumption reporting per agreeme',
    `alarm_code` STRING COMMENT 'Code indicating any alarm condition detected during this interval. Examples include leak alarm, burst alarm, backflow alarm, low battery alarm, or communication failure alarm. Empty if no alarm condition exists.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'The battery voltage of the AMI endpoint device at the time of this reading, measured in volts. Used to monitor endpoint health and predict battery replacement needs.',
    `consumption_volume_gallons` DECIMAL(18,2) COMMENT 'The total volume of water consumed during this interval, measured in gallons. This is the primary consumption metric used for billing, leak detection, and demand analysis.',
    `data_quality_indicator` STRING COMMENT 'Indicates the quality and reliability of this interval reading. Valid readings are directly measured; estimated readings are interpolated due to communication gaps; suspect readings show anomalies; missing indicates no data received; tampered indicates potential meter tampering; overflow indicates meter register overflow.. Valid values are `valid|estimated|suspect|missing|tampered|overflow`',
    `estimated_method` STRING COMMENT 'The method used to estimate this interval reading if data was missing or invalid. None indicates actual measured data. Other values indicate the estimation algorithm applied.. Valid values are `none|linear_interpolation|historical_average|same_day_prior_week|zero_fill|carry_forward`',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The average flow rate during the interval, measured in gallons per minute. Calculated as consumption volume divided by interval duration. Used for leak detection and high-flow alerting.',
    `gap_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval represents a data gap that was filled by estimation or interpolation. True indicates the reading is estimated due to missing data transmission.',
    `high_usage_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval exceeded the high-usage threshold for this meter installation. True indicates consumption significantly above normal patterns, potentially indicating irrigation, filling pools, or abnormal usage.',
    `interval_duration_minutes` STRING COMMENT 'The length of the consumption interval in minutes. Typically 15, 30, or 60 minutes for AMI systems. Used to normalize consumption rates and identify irregular interval lengths.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumption interval ended. Represents the end of the measurement period for this interval reading.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumption interval began. Represents the beginning of the measurement period for this interval reading.',
    `leak_detection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval triggered a potential leak alert based on continuous low-flow patterns. True indicates sustained consumption suggesting a possible leak.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this interval reading. Used to document anomalies, manual adjustments, or special circumstances affecting this reading.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'The water pressure at the meter location during this interval, measured in pounds per square inch. Available from advanced AMI endpoints with integrated pressure sensors. Used for distribution network monitoring and pressure zone analysis.',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was processed and loaded into the data warehouse. Used for data pipeline monitoring and audit trails.',
    `pulse_increment_gallons` DECIMAL(18,2) COMMENT 'The volume of water represented by each pulse from the meter encoder, measured in gallons. Varies by meter size and type. Used to convert pulse counts to consumption volumes.',
    `raw_pulse_count` BIGINT COMMENT 'The raw cumulative pulse count from the meter encoder at the end of this interval. Each pulse represents a fixed volume increment. Used for data validation and troubleshooting.',
    `received_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was received by the AMI head-end system. Used to calculate transmission latency and identify delayed readings.',
    `reverse_flow_flag` BOOLEAN COMMENT 'Boolean flag indicating whether reverse flow was detected during this interval. True indicates water flowing backward through the meter, which may indicate backflow, meter installation issues, or tampering.',
    `signal_strength_dbm` STRING COMMENT 'The radio signal strength of the AMI endpoint transmission, measured in dBm. Used to assess communication quality and identify endpoints with poor connectivity.',
    `source_system` STRING COMMENT 'The source system that provided this interval reading. Typically Sensus FlexNet AMI Platform or OSIsoft PI Historian. Used for data lineage and troubleshooting.',
    `tamper_event_code` STRING COMMENT 'Code indicating the type of tamper event detected during this interval, if any. Examples include magnetic interference, tilt detection, removal detection, or reverse flow. Empty if no tamper event detected.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'The ambient temperature at the meter location during this interval, measured in degrees Fahrenheit. Some AMI endpoints include temperature sensors for freeze detection and consumption correlation analysis.',
    `transmission_retry_count` STRING COMMENT 'The number of transmission attempts required to successfully deliver this interval reading to the AMI collector. Higher retry counts indicate communication challenges.',
    `validation_status` STRING COMMENT 'The current validation status of this interval reading. Pending indicates awaiting validation; validated indicates passed all quality checks; rejected indicates failed validation; under review indicates manual review required.. Valid values are `pending|validated|rejected|under_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was validated or rejected. Used for audit trails and data quality reporting.',
    `zero_consumption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether zero consumption was recorded during this interval. True indicates no water usage, which may be normal for vacant properties or may indicate meter malfunction.',
    CONSTRAINT pk_interval_consumption PRIMARY KEY(`interval_consumption_id`)
) COMMENT 'High-frequency interval consumption data collected from AMI endpoints, typically at 15-minute or hourly intervals. Stores meter installation reference, interval start and end timestamps, consumption volume (gallons), flow rate (GPM), data quality indicator, gap flag, and raw pulse count. Sourced from the AMI head-end system and time-series data historian. Enables leak detection, high-usage alerting, time-of-use analysis, and demand forecasting at sub-daily granularity.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` (
    `leak_detection_event_id` BIGINT COMMENT 'Unique identifier for the leak detection event record. Primary key.',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Unresolved leaks exceeding state water loss thresholds constitute compliance violations under EPA water loss control programs and state water audit mandates. Utilities must link leak detection events ',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Leak events require customer notification and may trigger billing adjustments. Essential for customer service outreach, high-bill investigations, assistance program eligibility, and tracking notificat',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the leak was detected. Used for geographic analysis and NRW reduction program targeting.',
    `high_usage_alert_id` BIGINT COMMENT 'Foreign key linking to metering.high_usage_alert. Business justification: In water utility operations, a high_usage_alert (consumption exceeding threshold) is frequently the precursor event that triggers a leak_detection_event investigation. The leak_detection_event should ',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation where the leak was detected. Links to the meter installation registry.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Leaks occur at premises and may indicate infrastructure issues. Required for correlating leak frequency with premise characteristics, prioritizing premise-level infrastructure upgrades, and tracking p',
    `ami_endpoint_id` BIGINT COMMENT 'Reference to the AMI device (Sensus FlexNet endpoint or similar) that generated the interval data used for leak detection. Links to AMI device registry.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the leak was detected. Links to customer service location registry.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: AMI-detected leak events occur at specific service lines — the physical asset requiring repair. LCRR compliance mandates tracking leaks on lead service lines. leak_detection_event has premise_id but n',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to investigate or repair the detected leak. Links to asset management work order system.',
    `alert_severity` STRING COMMENT 'Severity classification of the leak event based on estimated volume, duration, and potential impact. Used to prioritize response and customer outreach.. Valid values are `critical|high|medium|low|informational`',
    `billing_adjustment_eligible_flag` BOOLEAN COMMENT 'Boolean indicator whether this leak event qualifies for a customer billing adjustment under utility leak adjustment policy. True indicates eligibility for adjustment consideration.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score (0-100) indicating the likelihood that the detected anomaly represents a true leak. Higher scores indicate greater confidence in detection accuracy.',
    `continuous_flow_flag` BOOLEAN COMMENT 'Boolean indicator that the leak was detected through continuous flow analysis (flow detected 24 hours without interruption). True indicates continuous flow was the detection trigger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection event record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified about the detected leak event. Used for tracking notification timeliness and customer service metrics.',
    `customer_notified_flag` BOOLEAN COMMENT 'Boolean indicator whether the customer has been notified of the detected leak event. True indicates notification has been sent.',
    `detection_algorithm_version` STRING COMMENT 'Version identifier of the leak detection algorithm or software that identified this event. Used for algorithm performance tracking and continuous improvement.',
    `detection_method` STRING COMMENT 'Method or technique used to identify the leak event. Indicates whether detection was automated (AMI interval analysis, continuous flow flag, minimum night flow anomaly) or manual (acoustic sensor, field inspection, customer report).. Valid values are `continuous_flow_threshold|minimum_night_flow_anomaly|ami_algorithm|acoustic_sensor|manual_inspection|customer_report`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the leak was first detected by the AMI system or monitoring algorithm. Principal business event timestamp for this event.',
    `estimated_leak_volume_gallons_per_day` DECIMAL(18,2) COMMENT 'Estimated daily water loss volume attributed to the detected leak, measured in gallons per day. Calculated from interval consumption data or continuous flow analysis.',
    `estimated_total_loss_gallons` DECIMAL(18,2) COMMENT 'Total estimated water loss volume from leak start to resolution, measured in gallons. Calculated as leak volume per day multiplied by duration. Contributes to Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) metrics.',
    `flow_threshold_value` DECIMAL(18,2) COMMENT 'The flow rate threshold value (in gallons per minute or GPM) that was exceeded to trigger the leak detection alert. Used for continuous flow and threshold-based detection methods.',
    `investigation_notes` STRING COMMENT 'Free-text field for field technician or customer service representative notes regarding leak investigation, customer interaction, or resolution details.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection event record was last updated. Used for audit trail and change tracking.',
    `leak_duration_hours` DECIMAL(18,2) COMMENT 'Estimated or measured duration of the leak event from detection timestamp to resolution or current time if unresolved, measured in hours.',
    `leak_location_description` STRING COMMENT 'Textual description of the suspected or confirmed leak location (e.g., service line, toilet, irrigation system, water heater). Provides context for leak source and repair scope.',
    `leak_status` STRING COMMENT 'Current lifecycle status of the leak detection event. Tracks progression from initial detection through investigation, customer notification, and resolution.. Valid values are `detected|confirmed|under_investigation|resolved|false_positive|customer_notified`',
    `leak_type` STRING COMMENT 'Classification of the leak by type or source. Helps categorize leak patterns and target customer education programs. [ENUM-REF-CANDIDATE: service_line|meter|toilet|faucet|irrigation|water_heater|pool|unknown — 8 candidates stripped; promote to reference product]',
    `minimum_night_flow_anomaly_flag` BOOLEAN COMMENT 'Boolean indicator that the leak was detected through minimum night flow analysis showing abnormal consumption during low-usage hours (typically 2 AM - 4 AM). True indicates MNF anomaly detection.',
    `notification_method` STRING COMMENT 'Communication channel used to notify the customer about the leak event. Tracks preferred and actual notification delivery method.. Valid values are `email|sms|phone_call|postal_mail|customer_portal|mobile_app`',
    `resolution_date` DATE COMMENT 'Date when the leak event was resolved or closed. Used to calculate response time and track Non-Revenue Water (NRW) reduction program effectiveness.',
    `resolution_outcome` STRING COMMENT 'Final outcome or resolution status of the leak detection event. Indicates whether the leak was confirmed and repaired, determined to be a false positive, or remains pending.. Valid values are `customer_repaired|utility_repaired|false_positive|no_action_required|under_investigation|pending_customer_action`',
    CONSTRAINT pk_leak_detection_event PRIMARY KEY(`leak_detection_event_id`)
) COMMENT 'Records all detected consumption anomaly events including suspected leaks, high usage alerts, continuous flow conditions, backflow indicators, and threshold exceedance alerts identified through AMI interval data analysis or monitoring rules. Captures event type (leak, high usage, continuous flow, backflow, threshold exceedance), detection timestamp, meter installation reference, detection method, threshold and actual values, percentage over threshold, estimated volume impact, alert severity, alert status (open, notified, resolved, dismissed), notification history, customer contact log, and resolution outcome. Supports NRW reduction programs, customer notification workflows, proactive service management, and customer service case creation.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` (
    `high_usage_alert_id` BIGINT COMMENT 'Unique identifier for the high usage alert record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: High usage alerts notify account holders to prevent bill shock. Core customer service function requiring account contact information, notification preferences, and alert history tracking for customer ',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation that triggered this high usage alert. Links to the specific meter deployment at a service location.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: High usage alerts analyzed by premise type for pattern detection. Required for identifying systemic issues by building type, seasonal usage anomalies, and targeting conservation messaging to specific ',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: High usage alerts tied to physical locations for field investigation. Essential for dispatching field crews, correlating alerts with address characteristics, and geographic pattern analysis for leak d',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: High usage alerts are investigated at the service line level — field crews need the physical service line asset reference for inspection and repair dispatch. high_usage_alert has premise_id but not se',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: High usage alerts requiring physical meter or service line investigation generate asset work orders (distinct from the service.order already linked). Water utilities dispatch field crews via asset wor',
    `actual_consumption_unit` STRING COMMENT 'Unit of measure for the actual consumption value. Gallons, cubic feet, and cubic meters represent volume; GPM (Gallons per Minute) and MGD (Million Gallons per Day) represent flow rate.. Valid values are `gallons|cubic_feet|cubic_meters|gpm|mgd`',
    `actual_consumption_value` DECIMAL(18,2) COMMENT 'The measured consumption value during the detection period that triggered the alert. Represents the actual usage that exceeded the threshold.',
    `alert_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was generated by the Advanced Metering Infrastructure (AMI) or analytics system. Represents the moment the threshold breach was detected.',
    `alert_number` STRING COMMENT 'Business-facing unique alert number used for tracking and customer communication. Format: HUA-XXXXXXXXXX.. Valid values are `^HUA-[0-9]{10}$`',
    `alert_severity` STRING COMMENT 'Severity classification of the alert based on variance magnitude and potential impact. Low indicates minor variance; medium indicates moderate concern; high indicates significant issue requiring prompt attention; critical indicates emergency condition requiring immediate response.. Valid values are `low|medium|high|critical`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the alert. Open indicates newly generated; notified means customer has been contacted; acknowledged means customer confirmed receipt; investigating indicates active review; resolved means issue addressed; dismissed means no action required; false positive indicates erroneous alert. [ENUM-REF-CANDIDATE: open|notified|acknowledged|investigating|resolved|dismissed|false_positive — 7 candidates stripped; promote to reference product]',
    `alert_type` STRING COMMENT 'Classification of the high usage alert based on consumption pattern analysis. High consumption indicates volume exceeds baseline; continuous flow suggests uninterrupted usage; backflow suspected indicates reverse flow detection; leak detected flags potential infrastructure failure; abnormal pattern identifies irregular usage; threshold exceeded indicates absolute limit breach.. Valid values are `high_consumption|continuous_flow|backflow_suspected|leak_detected|abnormal_pattern|threshold_exceeded`',
    `baseline_consumption_value` DECIMAL(18,2) COMMENT 'Historical average or expected consumption value used as the comparison baseline for this alert. May be calculated from seasonal norms, customer history, or similar account profiles.',
    `baseline_period_days` STRING COMMENT 'Number of days used to calculate the baseline consumption value. Typical values include 30, 60, 90, or 365 days depending on seasonality and data availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the system. Used for audit trail and data lineage.',
    `customer_acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the customer acknowledged receipt and awareness of this alert. Null if customer has not acknowledged.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified about this high usage alert. True means notification sent; False means no notification sent yet.',
    `data_source` STRING COMMENT 'Source system or method that provided the consumption data used to generate this alert. AMI interval data represents 15-minute or hourly reads; AMI daily read represents once-per-day automated read; manual read represents field technician reading; estimated read represents calculated value; SCADA flow data represents distribution network monitoring; analytics engine represents derived calculation.. Valid values are `ami_interval_data|ami_daily_read|manual_read|estimated_read|scada_flow_data|analytics_engine`',
    `detection_period_end_timestamp` TIMESTAMP COMMENT 'End of the time window during which the high usage condition was detected. Used to define the consumption analysis interval.',
    `detection_period_start_timestamp` TIMESTAMP COMMENT 'Beginning of the time window during which the high usage condition was detected. Used to define the consumption analysis interval.',
    `estimated_revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the high usage condition, representing potential lost revenue or customer billing adjustment. Positive values indicate revenue at risk; negative values indicate customer credits issued. Null if not calculated.',
    `estimated_water_loss_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost or wasted due to the condition that triggered this alert, measured in gallons. Used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Null if not applicable or not calculated.',
    `first_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the first customer notification was sent for this alert. Null if customer has not been notified.',
    `investigation_started_timestamp` TIMESTAMP COMMENT 'Date and time when investigation of this alert began. Null if investigation has not started.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was most recently updated. Used for audit trail and change tracking.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that last modified this alert record. Used for audit trail and accountability.',
    `notification_count` STRING COMMENT 'Total number of notification attempts made to the customer regarding this alert. Includes all channels and retries.',
    `notification_method` STRING COMMENT 'Primary communication channel used to notify the customer about this alert. Email, SMS, and mobile app represent digital channels; phone call represents voice contact; postal mail represents physical correspondence; customer portal represents self-service access; none indicates no notification sent. [ENUM-REF-CANDIDATE: email|sms|phone_call|postal_mail|mobile_app|customer_portal|none — 7 candidates stripped; promote to reference product]',
    `resolution_category` STRING COMMENT 'Classification of the root cause or resolution outcome for this alert. Customer leak repaired indicates customer-side plumbing issue fixed; utility leak repaired indicates utility infrastructure issue fixed; meter malfunction indicates faulty meter; seasonal usage indicates expected variance; customer behavior change indicates legitimate usage increase; irrigation system and pool filling indicate specific high-volume activities; construction activity indicates temporary usage spike; false alarm indicates erroneous alert; other indicates miscellaneous resolution. [ENUM-REF-CANDIDATE: customer_leak_repaired|utility_leak_repaired|meter_malfunction|seasonal_usage|customer_behavior_change|irrigation_system|pool_filling|construction_activity|false_alarm|other — 10 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Free-text narrative describing the investigation findings, actions taken, and resolution details for this alert. Provides context for future reference and audit trail.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when this alert was resolved or closed. Null if alert remains open or under investigation.',
    `service_order_created_flag` BOOLEAN COMMENT 'Indicates whether a field service order was created in response to this alert. True means service order generated; False means no service order created.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this alert was suppressed from customer notification due to business rules (e.g., customer opted out, account in dispute, recent similar alert). True means suppressed; False means not suppressed.',
    `suppression_reason` STRING COMMENT 'Explanation of why this alert was suppressed from customer notification. Null if alert was not suppressed.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value. Gallons and cubic feet/meters represent volume; GPM (Gallons per Minute) and MGD (Million Gallons per Day) represent flow rate; percent represents variance from baseline.. Valid values are `gallons|cubic_feet|cubic_meters|gpm|mgd|percent`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The defined limit or baseline value that was exceeded to trigger this alert. May represent absolute volume, flow rate, or percentage variance depending on alert configuration.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which actual consumption exceeded the threshold value. Calculated as ((actual - threshold) / threshold) * 100. Positive values indicate over-threshold conditions.',
    CONSTRAINT pk_high_usage_alert PRIMARY KEY(`high_usage_alert_id`)
) COMMENT 'Operational alert record generated when a meters consumption exceeds a defined threshold relative to historical baseline, seasonal norms, or absolute volume limits. Stores alert generation timestamp, meter installation reference, alert type (high consumption, continuous flow, backflow suspected), threshold value, actual consumption value, percentage over threshold, alert status (open, notified, resolved, dismissed), customer contact attempt log, and resolution notes. Feeds customer service workflows in Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`accuracy_test` (
    `accuracy_test_id` BIGINT COMMENT 'Primary key for accuracy_test',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: A failed accuracy test (meter out of tolerance) directly triggers a compliance violation under state weights-and-measures and utility measurement accuracy regulations. Linking accuracy_test to complia',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Meter accuracy testing is an O&M activity whose labor and material costs are charged to specific cost centers. Water utilities track testing costs by cost center for rate case O&M expense support and ',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Accuracy tests can be performed in the field (in-situ testing) at a specific meter installation, or in a lab/bench setting. For field tests, this FK links the test to the installation location. This F',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Accuracy tests are performed on physical meter devices to assess measurement accuracy and compliance with standards. Each test record must reference which specific meter was tested. FK named metering_',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Meter accuracy testing is mandated by state regulations and AWWA standards specifying testing frequency and tolerance thresholds. Accuracy tests must reference the specific regulatory_requirement driv',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Accuracy tests are initiated in response to customer billing disputes or regulatory requirements tied to a specific service agreement. Linking accuracy_test to service_agreement supports dispute resol',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Failed meter accuracy tests trigger corrective work orders for meter replacement or recalibration. Water utility asset management requires traceability from accuracy test result to the work order that',
    CONSTRAINT pk_accuracy_test PRIMARY KEY(`accuracy_test_id`)
) COMMENT 'Records meter assessment activities including accuracy testing (bench test, in-situ, field test per AWWA M6 standards) and physical field inspections (condition assessment, seal verification, pit/vault inspection, AMI antenna check). Captures assessment date, meter installation reference, assessment type, technician ID, test results (accuracy percentages at low/intermediate/high flow rates for tests; condition ratings and observations for inspections), pass/fail determination, photographic evidence reference, and recommended action. Supports meter replacement program decisions and proactive asset management.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`replacement_program` (
    `replacement_program_id` BIGINT COMMENT 'Primary key for replacement_program',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Replacement programs target specific asset classes (e.g., residential meters aged 15+ years). Program eligibility, prioritization, and budget forecasting depend on asset class characteristics like use',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Multi-year meter replacement programs (e.g., AMI rollout, aging meter initiative) are authorized and funded as CIP projects. This link enables program-level capital budget tracking and regulatory repo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Meter replacement programs are managed under specific cost centers for capital expenditure tracking, budget control, and rate case capital program reporting. Water utilities assign each capital progra',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Meter replacement programs are capital expenditure programs with dedicated annual budgets. Water utilities budget replacement programs by asset class and track actual vs. budgeted spend for rate case ',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Meter replacement programs (especially lead service line replacements under IIJA/EPA mandates) are frequently funded by federal and state grants. Water utilities must track which replacement programs ',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter replacement programs are often targeted at specific meter sizes or types (e.g., replace all 5/8-inch meters over 15 years old or replace all non-AMI 3/4-inch meters). This FK links the progr',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Meter replacement programs are planned to support specific service offerings (e.g., replacing non-AMI meters to enable AMI-based offerings). Capital planning teams must know which offering a replaceme',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Meter replacement programs are driven by preventive maintenance schedules in asset management. Water utilities align age-based or condition-based replacement programs with PM schedules to automate wor',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Meter replacement programs execute under blanket procurement contracts governing pricing, delivery schedules, and vendor terms. Water utility supply chain and asset managers must link each replacement',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Meter replacement programs are frequently mandated by regulatory requirements (e.g., lead service line replacement rules, AMI deployment mandates, accuracy compliance programs). Utilities must demonst',
    CONSTRAINT pk_replacement_program PRIMARY KEY(`replacement_program_id`)
) COMMENT 'Defines and tracks meter replacement programs and campaigns, including age-based replacement cycles, accuracy-based replacement triggers, and AMI retrofit programs. Stores program name, program type (age-based, accuracy-based, AMI upgrade, LCRR lead service line), target meter population criteria (age threshold, meter size, meter type, geographic zone), program start and end dates, target count, completion count, budget allocation, and program status. Links to individual replacement work orders executed through IBM Maximo.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`replacement_order` (
    `replacement_order_id` BIGINT COMMENT 'Primary key for replacement_order',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: replacement_order captures old_meter_accuracy_test_result as a scalar value but lacks FK to the actual accuracy_test record that triggered the replacement. Meter replacements are often driven by faile',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Replacement orders trigger meter procurement invoices. Water utilities must match replacement orders to AP invoices for three-way matching (PO/receipt/invoice), capital expenditure capitalization, and',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Meter replacement orders are executed under CIP projects in water utilities. This link drives capital cost tracking, asset capitalization reporting, and project closeout. A water utility PM expects ev',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Bulk meter replacement orders are frequently executed by contractors under a construction contract. This link enables contract performance tracking, pay application certification, and retainage manage',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Replacement order scheduling depends on confirmed goods receipt of physical meters. Water utility replacement coordinators must verify meters have been received and inspected before dispatching field ',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: A replacement_order is executed at a specific physical installation (service location). The replacement_order already references old_metering_meter_id (the meter being replaced) and accuracy_test_id, ',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: A replacement order replaces an existing (old) meter with a new meter. This FK tracks which physical meter device was removed/replaced. This is the first of two FKs to metering_meter (old and new), re',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Meter replacement programs generate bulk purchase orders for new meter inventory. Replacement program execution triggers procurement of meters in planned quantities, linking program planning to procur',
    `replacement_program_id` BIGINT COMMENT 'Foreign key linking to metering.replacement_program. Business justification: Replacement orders are often executed as part of a structured replacement program or campaign (age-based, accuracy-based, technology upgrade). This FK links individual replacement work orders to their',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Individual replacement orders are charged to WBS elements for capital cost allocation and asset capitalization within a CIP project. Water utility project accountants require this link to roll up repl',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Each meter replacement is executed via work order that schedules crews, tracks labor/materials, manages old meter disposal, and closes out capital projects. Standard utility field service workflow lin',
    CONSTRAINT pk_replacement_order PRIMARY KEY(`replacement_order_id`)
) COMMENT 'Individual work order record for the physical replacement of a meter at a service location, executed as part of a replacement program or triggered by accuracy failure, damage, or customer request. Captures replacement program reference, scheduled date, completion date, old meter ID, new meter ID, technician ID, reason for replacement, old meter final read, new meter initial read, service interruption duration, and Maximo work order number. Bridges the metering domain with the asset and workforce domains.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`tamper_event` (
    `tamper_event_id` BIGINT COMMENT 'Primary key for tamper_event',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: Tamper events are often detected by AMI endpoints through tamper detection sensors and transmitted as alerts. This FK links the tamper event to the AMI endpoint that detected and reported the tamperin',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Tamper events trigger billing adjustments for estimated unbilled consumption during tamper period per revenue protection policies and regulatory requirements. Direct link supports tamper-to-cash workf',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Tamper events require direct customer account association for revenue protection enforcement, billing adjustment processing, and regulatory reporting on meter tampering incidents. Utilities must link ',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Tamper events (meter tampering, unauthorized bypass, interference) occur at a specific meter installation location. This FK links the tamper event to the physical installation where tampering was dete',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Tamper events trigger field investigations and potential enforcement actions dispatched via work orders. Utilities track investigation findings, customer contact, and resolution through work order sys',
    CONSTRAINT pk_tamper_event PRIMARY KEY(`tamper_event_id`)
) COMMENT 'Records detected meter tampering, unauthorized bypass, or meter interference events identified through AMI tamper flags, field inspection, or billing anomaly investigation. Captures detection date, meter installation reference, tamper type (magnetic tamper, reverse flow, physical bypass, broken seal, unauthorized removal), detection source (AMI flag, field inspection, billing review), estimated unbilled consumption volume, investigation status, enforcement action taken, and revenue recovery amount. Supports revenue protection and regulatory compliance.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`read_route` (
    `read_route_id` BIGINT COMMENT 'Primary key for read_route',
    CONSTRAINT pk_read_route PRIMARY KEY(`read_route_id`)
) COMMENT 'Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`metering`.`meter_size_type` (
    `meter_size_type_id` BIGINT COMMENT 'Unique identifier for the meter size and type combination. Primary key for the reference table.',
    `primary_replacement_meter_size_type_id` BIGINT COMMENT 'Reference to the successor meter size and type that replaces this obsolete configuration. Null if no replacement defined.',
    `accuracy_class` STRING COMMENT 'AWWA or ISO accuracy classification for meters of this size (e.g., AWWA Class I, Class II; ISO R160, R250). Defines expected measurement precision and testing requirements.',
    `accuracy_percentage_low_flow` DECIMAL(18,2) COMMENT 'Expected measurement accuracy as a percentage at the minimum detectable flow rate. Critical for NRW analysis.',
    `accuracy_percentage_normal_flow` DECIMAL(18,2) COMMENT 'Expected measurement accuracy as a percentage at normal operating flow rate.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type is currently approved for new installations in the utility service territory.',
    `ami_compatible_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type can be equipped with AMI endpoints for remote reading and interval data collection.',
    `amr_compatible_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type can be equipped with AMR endpoints for drive-by or walk-by reading.',
    `average_unit_cost_usd` DECIMAL(18,2) COMMENT 'Average procurement cost in United States Dollars (USD) for a meter of this size including hardware but excluding installation labor. Used for budgeting and capital planning.',
    `awwa_standard_code` STRING COMMENT 'Applicable AWWA standard governing this meter size and type (e.g., C700, C701, C702, C706, C708, C710, C713).. Valid values are `^C[0-9]{3}$`',
    `connection_type` STRING COMMENT 'Standard connection method for meters of this size (threaded, flanged, compression, saddle, direct bury). Determines installation requirements and compatibility.. Valid values are `threaded|flanged|compression|saddle|direct_bury`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter size and type record was first created in the system.',
    `display_name` STRING COMMENT 'Human-readable display name for the meter size (e.g., 5/8 inch, 3/4 inch, 1 inch, 2 inch). Used in user interfaces, reports, and customer communications.',
    `effective_date` DATE COMMENT 'Date when this meter size and type was approved for use in the utility service territory.',
    `effective_end_date` DATE COMMENT 'Date when this meter size type was discontinued or superseded. Null for currently active meter size types. Used for phase-out planning and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this meter size type became available for use in the utilitys meter inventory. Supports historical tracking and version control.',
    `expected_service_life_years` STRING COMMENT 'Typical operational lifespan in years before meter replacement is recommended due to accuracy degradation.',
    `flange_standard` STRING COMMENT 'Flange specification for flanged connections (e.g., ANSI Class 125, ANSI Class 250). Applicable to larger meter sizes requiring bolted connections.',
    `installation_labor_hours` DECIMAL(18,2) COMMENT 'Typical labor hours required to install or replace a meter of this size. Used for work order planning, crew scheduling, and cost estimation.',
    `installation_orientation` STRING COMMENT 'Required or recommended installation orientation for accurate measurement (horizontal, vertical, or any orientation).. Valid values are `horizontal|vertical|any`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter size and type record was last updated.',
    `lead_free_certified_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type meets lead-free certification requirements under the Safe Drinking Water Act and LCRR.',
    `length_inches` DECIMAL(18,2) COMMENT 'Overall length of the meter body in inches. Critical for vault and pit sizing during installation.',
    `max_continuous_flow_gpm` DECIMAL(18,2) COMMENT 'Maximum flow rate in gallons per minute that the meter can sustain continuously without damage or accuracy degradation.',
    `max_registered_flow_gpm` DECIMAL(18,2) COMMENT 'Peak flow rate in gallons per minute that the meter can register accurately for short durations.',
    `maximum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum continuous flow rate in gallons per minute (GPM) for meters of this size. Defines the upper capacity limit for safe and accurate operation.',
    `maximum_intermittent_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum short-duration or peak flow rate in gallons per minute (GPM) that the meter can handle without damage. Used for surge and peak demand scenarios.',
    `measurement_class` STRING COMMENT 'AWWA accuracy classification (Class I through Class IV). Higher classes indicate greater accuracy at low flow rates.. Valid values are `class_i|class_ii|class_iii|class_iv`',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches. Standard sizes include 5/8, 3/4, 1, 1.5, 2, 3, 4, 6, 8, 10, 12 inches per AWWA standards.',
    `meter_size_type_description` STRING COMMENT 'Detailed description of the meter size type including typical applications, customer classes, and usage characteristics (e.g., Standard residential meter for single-family homes).',
    `meter_size_type_status` STRING COMMENT 'Current lifecycle status of this meter size type in the reference catalog (active, inactive, obsolete, pending approval). Controls availability for new installations.. Valid values are `active|inactive|obsolete|pending_approval`',
    `meter_type` STRING COMMENT 'Technology classification of the water meter. Defines the measurement principle used to register flow.. Valid values are `positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service`',
    `min_detectable_flow_gpm` DECIMAL(18,2) COMMENT 'Lowest flow rate in gallons per minute that the meter can detect and register. Critical for leak detection and low-flow accuracy.',
    `minimum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Minimum measurable flow rate in gallons per minute (GPM) for meters of this size. Defines the lower accuracy threshold for consumption measurement.',
    `normal_operating_flow_gpm` DECIMAL(18,2) COMMENT 'Typical sustained flow rate in gallons per minute for which the meter is optimally designed. Used for meter sizing and selection.',
    `normal_operating_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Typical or recommended operating flow rate in gallons per minute (GPM) for optimal meter accuracy and longevity. Used for sizing and capacity planning.',
    `notes` STRING COMMENT 'Additional technical notes, installation guidance, or special considerations for this meter size and type.',
    `nsf_61_certified_flag` BOOLEAN COMMENT 'Indicates whether this meter is certified to NSF/ANSI Standard 61 for drinking water system components.',
    `obsolete_date` DATE COMMENT 'Date when this meter size and type was discontinued or phased out for new installations. Null if still active.',
    `pressure_loss_at_max_flow_psi` DECIMAL(18,2) COMMENT 'Expected pressure loss in pounds per square inch (PSI) across the meter at maximum continuous flow rate. Critical for hydraulic modeling and system pressure management.',
    `pressure_rating_psi` STRING COMMENT 'Maximum working pressure in pounds per square inch that the meter can withstand without failure.',
    `register_capacity_gallons` BIGINT COMMENT 'Maximum cumulative volume in gallons that the meter register can display before rolling over. Important for billing cycle planning and register overflow detection.',
    `register_type` STRING COMMENT 'Type of register used to display consumption. Mechanical for analog dials, electronic for digital displays, encoder for AMI/AMR integration.. Valid values are `mechanical|electronic|encoder`',
    `service_connection_type` STRING COMMENT 'Standard connection method for installing this meter size (threaded, flanged, or compression fitting).. Valid values are `threaded|flanged|compression`',
    `size_code` STRING COMMENT 'Short alphanumeric code representing the meter size (e.g., 5/8, 3/4, 1, 1.5, 2, 3, 4, 6, 8, 10, 12). Used as a lookup key in operational systems.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches (e.g., 0.625 for 5/8 inch, 0.75 for 3/4 inch, 1.0, 1.5, 2.0, etc.). Primary measurement for meter sizing and capacity planning.',
    `size_millimeters` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in millimeters (e.g., 15mm, 20mm, 25mm, 40mm, 50mm, etc.). Used for international standards compliance and metric system reporting.',
    `sort_order` STRING COMMENT 'Numeric value controlling the display sequence of meter sizes in user interfaces and reports (typically ordered from smallest to largest).',
    `straight_pipe_downstream_inches` STRING COMMENT 'Minimum length of straight pipe required downstream of the meter in inches to ensure accurate flow measurement.',
    `straight_pipe_upstream_inches` STRING COMMENT 'Minimum length of straight pipe required upstream of the meter in inches to ensure accurate flow measurement.',
    `temperature_rating_fahrenheit_max` STRING COMMENT 'Maximum water temperature in Fahrenheit at which the meter maintains accuracy and structural integrity.',
    `temperature_rating_fahrenheit_min` STRING COMMENT 'Minimum water temperature in Fahrenheit at which the meter maintains accuracy and structural integrity.',
    `testing_frequency_years` STRING COMMENT 'Recommended interval in years between accuracy testing and calibration per regulatory and utility standards.',
    `thread_standard` STRING COMMENT 'Thread specification for threaded connections (e.g., NPT, BSPT, AWWA). Ensures compatibility with service line fittings and meter setters.',
    `typical_application` STRING COMMENT 'Standard use case for this meter size and type (e.g., single-family residential, multi-family residential, commercial, industrial, fire service, irrigation).',
    `typical_customer_class` STRING COMMENT 'Primary customer class typically served by this meter size (residential, commercial, industrial, institutional, agricultural, municipal). Used for rate structure and billing configuration.. Valid values are `residential|commercial|industrial|institutional|agricultural|municipal`',
    `typical_service_life_years` STRING COMMENT 'Expected operational service life in years for meters of this size under normal operating conditions. Used for asset replacement planning and depreciation schedules.',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Approximate weight of the meter in pounds. Used for logistics, installation planning, and safety assessments.',
    CONSTRAINT pk_meter_size_type PRIMARY KEY(`meter_size_type_id`)
) COMMENT 'Master reference table for meter_size_type. ';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `water_utilities_ecm`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_leak_detection_event_id` FOREIGN KEY (`leak_detection_event_id`) REFERENCES `water_utilities_ecm`.`metering`.`leak_detection_event`(`leak_detection_event_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_high_usage_alert_id` FOREIGN KEY (`high_usage_alert_id`) REFERENCES `water_utilities_ecm`.`metering`.`high_usage_alert`(`high_usage_alert_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `water_utilities_ecm`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_program_id` FOREIGN KEY (`replacement_program_id`) REFERENCES `water_utilities_ecm`.`metering`.`replacement_program`(`replacement_program_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ADD CONSTRAINT `fk_metering_meter_size_type_primary_replacement_meter_size_type_id` FOREIGN KEY (`primary_replacement_meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `water_utilities_ecm`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `battery_expected_life_years` SET TAGS ('dbx_business_glossary_term' = 'Battery Expected Life in Years');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `battery_install_date` SET TAGS ('dbx_business_glossary_term' = 'Battery Installation Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percentage');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `communication_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency in Minutes');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'RF|Cellular|LoRaWAN|NB-IoT|Other');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention in Days');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'AES-128|AES-256|None');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Serial Number');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Device Type');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'ERT|MXU|iPerl|Orion|Ally|Other');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Installation Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `installation_technician` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `last_firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `leak_alert_threshold_gpm` SET TAGS ('dbx_business_glossary_term' = 'Leak Alert Threshold in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `leak_detection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Notes');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Failed|Maintenance|Decommissioned');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `read_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Read Interval in Seconds');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `reverse_flow_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Detected Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Signal Quality Indicator');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor|No Signal');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detected Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_business_glossary_term' = 'Tamper Status');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_value_regex' = 'Normal|Tamper Detected|Magnetic Interference|Physical Removal|Reverse Flow');
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`read` SET TAGS ('dbx_subdomain' = 'consumption_reading');
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`read` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` SET TAGS ('dbx_subdomain' = 'consumption_reading');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Consumption ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `leak_detection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accrual General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `consumption_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume in Gallons');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'valid|estimated|suspect|missing|tampered|overflow');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_value_regex' = 'none|linear_interpolation|historical_average|same_day_prior_week|zero_fill|carry_forward');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `high_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'High Usage Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration in Minutes');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `leak_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `pulse_increment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Pulse Increment in Gallons');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `raw_pulse_count` SET TAGS ('dbx_business_glossary_term' = 'Raw Pulse Count');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `tamper_event_code` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Code');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `transmission_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Transmission Retry Count');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ALTER COLUMN `zero_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Consumption Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` SET TAGS ('dbx_subdomain' = 'consumption_reading');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `leak_detection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Event Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Leak Alert Severity Level');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `billing_adjustment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Eligibility Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Confidence Score');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `continuous_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Flow Detection Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `detection_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Algorithm Version');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Method');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'continuous_flow_threshold|minimum_night_flow_anomaly|ami_algorithm|acoustic_sensor|manual_inspection|customer_report');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `estimated_leak_volume_gallons_per_day` SET TAGS ('dbx_business_glossary_term' = 'Estimated Leak Volume in Gallons Per Day (GPD)');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `estimated_total_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Water Loss in Gallons');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `flow_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Flow Threshold Value');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Leak Investigation Notes');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `leak_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Leak Duration in Hours');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `leak_location_description` SET TAGS ('dbx_business_glossary_term' = 'Leak Location Description');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `leak_status` SET TAGS ('dbx_business_glossary_term' = 'Leak Event Status');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `leak_status` SET TAGS ('dbx_value_regex' = 'detected|confirmed|under_investigation|resolved|false_positive|customer_notified');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `leak_type` SET TAGS ('dbx_business_glossary_term' = 'Leak Type Classification');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `minimum_night_flow_anomaly_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow (MNF) Anomaly Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone_call|postal_mail|customer_portal|mobile_app');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Resolution Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Leak Resolution Outcome');
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'customer_repaired|utility_repaired|false_positive|no_action_required|under_investigation|pending_customer_action');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` SET TAGS ('dbx_subdomain' = 'consumption_reading');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Value');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generated Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Number');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^HUA-[0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'high_consumption|continuous_flow|backflow_suspected|leak_detected|abnormal_pattern|threshold_exceeded');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `baseline_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Value');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `baseline_period_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Days');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `customer_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledged Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ami_interval_data|ami_daily_read|manual_read|estimated_read|scada_flow_data|analytics_engine');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `detection_period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Period End Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `detection_period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Period Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `estimated_revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact Amount');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `estimated_water_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Water Loss Gallons');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `first_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Notification Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `investigation_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Started Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `notification_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Count');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `service_order_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Order Created Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd|percent');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `replacement_program_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `replacement_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Metering Meter Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `replacement_program_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ALTER COLUMN `tamper_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`metering`.`read_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`read_route` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `water_utilities_ecm`.`metering`.`read_route` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Identifier');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `primary_replacement_meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Meter Size Type ID');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Accuracy Class');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_percentage_low_flow` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage at Low Flow');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_percentage_normal_flow` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage at Normal Flow');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `ami_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Compatible Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `amr_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Meter Reading (AMR) Compatible Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `average_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Cost in United States Dollars (USD)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `average_unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `awwa_standard_code` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Standard Code');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `awwa_standard_code` SET TAGS ('dbx_value_regex' = '^C[0-9]{3}$');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Connection Type');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression|saddle|direct_bury');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Display Name');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life (Years)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `flange_standard` SET TAGS ('dbx_business_glossary_term' = 'Flange Standard Specification');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `installation_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Installation Labor Hours');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_business_glossary_term' = 'Installation Orientation');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|any');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `lead_free_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead-Free Certified Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `length_inches` SET TAGS ('dbx_business_glossary_term' = 'Length (Inches)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `max_continuous_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Flow (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `max_registered_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Registered Flow (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `maximum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `maximum_intermittent_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intermittent Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_business_glossary_term' = 'Measurement Class');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|class_iv');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Description');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Status');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `min_detectable_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Flow (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `minimum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `nsf_61_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF 61 Certified Flag');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `pressure_loss_at_max_flow_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Loss at Maximum Flow in Pounds per Square Inch (PSI)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating (PSI)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `register_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Register Capacity in Gallons');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_business_glossary_term' = 'Register Type');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_value_regex' = 'mechanical|electronic|encoder');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Type');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Code');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size in Inches');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `size_millimeters` SET TAGS ('dbx_business_glossary_term' = 'Meter Size in Millimeters');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `straight_pipe_downstream_inches` SET TAGS ('dbx_business_glossary_term' = 'Straight Pipe Downstream Requirement (Inches)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `straight_pipe_upstream_inches` SET TAGS ('dbx_business_glossary_term' = 'Straight Pipe Upstream Requirement (Inches)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `temperature_rating_fahrenheit_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Rating (Fahrenheit)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `temperature_rating_fahrenheit_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Rating (Fahrenheit)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `testing_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency (Years)');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `thread_standard` SET TAGS ('dbx_business_glossary_term' = 'Thread Standard Specification');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `typical_application` SET TAGS ('dbx_business_glossary_term' = 'Typical Application');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `typical_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Typical Customer Class');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `typical_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|institutional|agricultural|municipal');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `typical_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Typical Service Life in Years');
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_size_type` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight (Pounds)');
