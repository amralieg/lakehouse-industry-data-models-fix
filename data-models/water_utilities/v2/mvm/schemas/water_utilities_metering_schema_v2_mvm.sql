-- Schema for Domain: metering | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-06-22 20:12:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`metering` COMMENT 'Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter` (
    `meter_id` BIGINT COMMENT 'Primary key for meter',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter size and type combinations are standardized configurations defined in the meter_size_type reference table. The metering_meter table currently stores meter_size_inches and meter_type as denormali',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Meters are capital assets requiring lifecycle management, depreciation tracking, condition assessment, and regulatory compliance (GASB 34). Water utilities track meters in asset registries for replace',
    `accuracy_class` STRING COMMENT 'AWWA accuracy class',
    `accuracy_pct` DECIMAL(18,2) COMMENT '',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost',
    `age_years` STRING COMMENT 'Age of meter in years',
    `ami_capable` BOOLEAN COMMENT 'Whether AMI capable',
    `ami_compatible` BOOLEAN COMMENT 'Whether meter is AMI compatible',
    `ami_enabled_flag` BOOLEAN COMMENT '',
    `awwa_class` STRING COMMENT 'AWWA meter class',
    `body_material` STRING COMMENT 'Meter body material (bronze, cast_iron, stainless, plastic)',
    `class` STRING COMMENT 'Meter accuracy class',
    `communication_protocol` STRING COMMENT 'Communication protocol (pulse, encoder, digital)',
    `connection_type` STRING COMMENT 'Connection type (threaded, flanged, compression)',
    `created_at` TIMESTAMP COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT '',
    `current_read_value` DECIMAL(18,2) COMMENT '',
    `current_status` STRING COMMENT 'Current status (in_service, in_stock, retired, failed, testing)',
    `data_quality_flag` BOOLEAN COMMENT 'True when record passed data validation.',
    `expected_life_years` STRING COMMENT 'Expected useful life in years',
    `firmware_version` STRING COMMENT 'Current firmware version if electronic',
    `first_install_date` DATE COMMENT '',
    `flow_direction` STRING COMMENT 'Direction of flow measurement',
    `flow_units` STRING COMMENT 'flow units for metering_meter',
    `initial_read` DECIMAL(18,2) COMMENT 'Initial register reading.',
    `initial_read_value` DECIMAL(18,2) COMMENT '',
    `install_date` DATE COMMENT '',
    `installation_count` STRING COMMENT 'Number of times meter has been installed',
    `is_active` BOOLEAN COMMENT '',
    `is_ami` BOOLEAN COMMENT 'Whether meter is AMI-enabled.',
    `is_ami_enabled` BOOLEAN COMMENT '',
    `is_compound` BOOLEAN COMMENT 'Whether this is a compound meter',
    `is_smart_meter` BOOLEAN COMMENT '',
    `last_calibration_date` DATE COMMENT 'Date of last calibration',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_read_value` DOUBLE COMMENT '',
    `last_test_accuracy_pct` DECIMAL(18,2) COMMENT 'Last test accuracy percentage',
    `last_test_date` DATE COMMENT 'Date of last accuracy test',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude of meter location',
    `lead_free_certified` BOOLEAN COMMENT 'Whether lead-free certified',
    `lid_type` STRING COMMENT 'Meter lid type',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude of meter location',
    `low_flow_insert_size` DECIMAL(18,2) COMMENT 'Low flow insert size for compound meters',
    `manufacture_date` DATE COMMENT 'Date of manufacture',
    `manufacturer` STRING COMMENT '',
    `max_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum flow rate in GPM',
    `measurement_technology` STRING COMMENT '',
    `measurement_unit` STRING COMMENT '',
    `meter_number` STRING COMMENT '',
    `meter_status` STRING COMMENT '',
    `meter_type` STRING COMMENT '',
    `min_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Minimum flow rate in GPM',
    `model` STRING COMMENT 'meter model for metering_meter',
    `model_number` STRING COMMENT '',
    `notes` STRING COMMENT 'Meter notes',
    `nsf_certified` BOOLEAN COMMENT 'Whether NSF certified',
    `number_of_dials` STRING COMMENT 'Number of dials on register',
    `operating_pressure_max_psi` DECIMAL(18,2) COMMENT 'Maximum operating pressure in PSI',
    `pit_or_vault` STRING COMMENT 'Installation location type (pit, vault, indoor, outdoor)',
    `pit_type` STRING COMMENT 'Meter pit type',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Purchase cost',
    `purchase_date` DATE COMMENT 'Date of purchase',
    `record_status` STRING COMMENT '',
    `register_count` STRING COMMENT '',
    `register_dials` STRING COMMENT '',
    `register_multiplier` DECIMAL(18,2) COMMENT 'Register multiplier',
    `register_type` STRING COMMENT 'Register type (straight, round)',
    `register_unit` STRING COMMENT 'Register unit of measure (gallons, cubic_feet, liters)',
    `register_unit_of_measure` STRING COMMENT 'Unit of measure on register',
    `register_units` STRING COMMENT 'Register units (gallons, cubic feet)',
    `removal_date` DATE COMMENT 'Date meter was removed',
    `retirement_date` DATE COMMENT '',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated salvage value',
    `serial_number` STRING COMMENT 'Manufacturer serial number.',
    `size` STRING COMMENT '',
    `size_inches` DECIMAL(18,2) COMMENT 'Meter size in inches',
    `technology` STRING COMMENT 'Meter technology',
    `temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum operating temperature in F',
    `test_due_date` DATE COMMENT 'Next test due date',
    `total_volume_through` DECIMAL(18,2) COMMENT 'Total volume through meter',
    `total_volume_through_meter` DECIMAL(18,2) COMMENT 'Total volume through meter',
    `unit_of_measure` STRING COMMENT '',
    `units_of_measure` STRING COMMENT '',
    `updated_at` TIMESTAMP COMMENT '',
    `updated_date` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `warranty_expiration_date` DATE COMMENT 'Warranty expiration date',
    CONSTRAINT pk_meter PRIMARY KEY(`meter_id`)
) COMMENT 'Master inventory record for every physical meter device deployed across the water and wastewater service territory. Captures meter make, model, size, type (AMI/AMR/manual), serial number, manufacturer, installation date, current status, register type, pulse output factor, maximum flow rate (GPM), meter generation, and communication module type. Includes bulk/compound meters, fire service meters, and all residential/commercial/industrial meter classes. Serves as the authoritative SSOT for meter device identity and specifications within the metering domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`installation` (
    `installation_id` BIGINT COMMENT 'Primary key for installation',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: An installation represents the deployment of a physical meter device at a service location. The installation MUST reference which specific meter (from meter inventory) is installed. This is the core r',
    `premise_id` BIGINT COMMENT 'Premise associated with installation',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: In water utility operations, each meter installation is assigned to a read route — the organized sequence of meters that a meter reader (manual, AMR drive-by, or walk-by) follows during a billing cycl',
    `service_address_id` BIGINT COMMENT 'Service address where meter is installed',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: A meter installation is physically performed on a specific service line. This link enables LCRR lead service line inventory reconciliation against installed meters, coordinates service line replacemen',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Meter installations are authorized and executed via work orders in utility field operations. Linking installation to the work_order that governed it enables labor cost tracking, crew scheduling tracea',
    `access_issues` STRING COMMENT 'Access issues noted',
    `access_notes` STRING COMMENT 'Notes about access issues',
    `address_line_1` STRING COMMENT 'Service address',
    `backflow_device_installed` BOOLEAN COMMENT 'Whether backflow device installed',
    `backflow_device_present` BOOLEAN COMMENT 'Whether backflow device present',
    `backflow_device_present_flag` BOOLEAN COMMENT 'Whether backflow prevention device is present',
    `backflow_device_type` STRING COMMENT 'Type of backflow prevention device',
    `city` STRING COMMENT 'City',
    `created_at` TIMESTAMP COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_quality_flag` BOOLEAN COMMENT 'True when record passed data validation.',
    `final_read_value` DECIMAL(18,2) COMMENT 'Meter reading at time of removal',
    `final_reading` DECIMAL(18,2) COMMENT 'Final reading at removal',
    `flow_direction` STRING COMMENT 'Flow direction indicator',
    `gps_accuracy_m` DECIMAL(18,2) COMMENT 'GPS accuracy in meters',
    `gps_latitude` DECIMAL(18,2) COMMENT '',
    `gps_longitude` DECIMAL(18,2) COMMENT '',
    `initial_read` STRING COMMENT 'Initial register read',
    `initial_read_value` DECIMAL(18,2) COMMENT 'Meter reading at time of installation',
    `initial_reading` DECIMAL(18,2) COMMENT 'Initial meter reading at installation',
    `install_date` DATE COMMENT 'Installation date',
    `install_location` STRING COMMENT '',
    `install_location_description` STRING COMMENT 'Location description',
    `install_read_value` DECIMAL(18,2) COMMENT '',
    `install_reading` DOUBLE COMMENT '',
    `install_type` STRING COMMENT '',
    `installation_date` DATE COMMENT '',
    `installation_number` STRING COMMENT 'Unique installation number',
    `installation_status` STRING COMMENT '',
    `installation_type` STRING COMMENT 'Type (new, replacement, relocation)',
    `installer_name` STRING COMMENT '',
    `installer_notes` STRING COMMENT 'Notes from the installer',
    `is_accessible` BOOLEAN COMMENT 'Whether meter is easily accessible',
    `is_active` BOOLEAN COMMENT 'Whether installation is active.',
    `is_inside_setting` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude of installation',
    `lid_type` STRING COMMENT 'Type of pit lid',
    `location_description` STRING COMMENT '',
    `location_type` STRING COMMENT 'Location type (pit, basement, inside, outside)',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude of installation',
    `meter_location` STRING COMMENT '',
    `meter_location_code` STRING COMMENT 'Code describing meter location (pit, indoor, outdoor, vault)',
    `meter_location_description` STRING COMMENT 'Physical location description (pit, basement, exterior wall)',
    `meter_orientation` STRING COMMENT '',
    `meter_position` STRING COMMENT '',
    `multiplier` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT 'Installation notes',
    `photo_url` STRING COMMENT 'URL to installation photo',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of connecting pipe in inches',
    `pipe_material` STRING COMMENT 'Material of connecting pipe',
    `pit_condition` STRING COMMENT 'Condition of meter pit',
    `pit_depth_inches` DECIMAL(18,2) COMMENT 'Meter pit depth in inches',
    `pit_material` STRING COMMENT 'Meter pit material',
    `pit_type` STRING COMMENT 'Type of meter pit/vault',
    `postal_code` STRING COMMENT 'Postal code',
    `pressure_regulator_present` BOOLEAN COMMENT 'Whether pressure regulator present',
    `reading_at_install` DECIMAL(18,2) COMMENT 'Register reading at time of install',
    `record_status` STRING COMMENT '',
    `remote_read_capable` BOOLEAN COMMENT 'Whether remote read capable',
    `remote_read_capable_flag` BOOLEAN COMMENT 'Whether installation supports remote reading',
    `removal_date` DATE COMMENT 'Date meter was removed if applicable',
    `removal_reason` STRING COMMENT 'Reason for meter removal',
    `service_address` STRING COMMENT 'Service address for this installation',
    `service_line_material` STRING COMMENT 'Service line material',
    `service_line_size_inches` DECIMAL(18,2) COMMENT 'Service line size in inches',
    `setter_material` STRING COMMENT 'Setter material',
    `setter_size_inches` DECIMAL(18,2) COMMENT 'Meter setter size in inches',
    `setting_size_inches` DECIMAL(18,2) COMMENT '',
    `shutoff_valve_location` STRING COMMENT 'Location of shutoff valve',
    `state_code` STRING COMMENT 'State code',
    `updated_at` TIMESTAMP COMMENT '',
    `updated_date` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `wire_run_length_ft` DECIMAL(18,2) COMMENT 'Wire run length in feet for remote read',
    CONSTRAINT pk_installation PRIMARY KEY(`installation_id`)
) COMMENT 'Tracks the physical installation of a meter at a service location, linking a specific meter device to a service address and customer account. Records installation date, installer ID, work order reference, meter position (pit, vault, curb box), setter size, service line material, lock/seal number, initial register reading at installation, and removal date when replaced. Maintains the full history of which meter served which location over time, supporting NRW analysis and billing continuity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI/AMR communication endpoint device. Primary key for the endpoint registry.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area that this endpoint belongs to. Used for water loss analysis and pressure zone management.',
    `meter_id` BIGINT COMMENT 'Reference to the physical water meter that this AMI endpoint is attached to. An endpoint may be replaced independently of the meter.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: An AMI/AMR endpoint device is physically installed at a specific meter installation site. While ami_endpoint already references metering_meter (the device), it does not directly reference the installa',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: AMI endpoints are capital assets with acquisition cost, useful life, warranty, and cybersecurity compliance requirements. Utilities track these separately from meters for technology refresh cycles, FC',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: AMI deployment may be mandated by regulatory requirements for conservation tracking, demand management, and drought response capabilities. Real process: complying with state mandates for AMI deploymen',
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
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational status of the endpoint device. Active indicates normal operation, Failed indicates communication or device failure.',
    `read_interval_seconds` STRING COMMENT 'Interval in seconds at which the endpoint records consumption data internally. Typical values: 900 (15 min), 3600 (hourly), 86400 (daily).',
    `reverse_flow_detected_flag` BOOLEAN COMMENT 'Indicates whether reverse flow has been detected by the endpoint. True if reverse flow detected, False otherwise. May indicate backflow or meter installation error.',
    `signal_quality_indicator` STRING COMMENT 'Qualitative assessment of communication signal quality. Derived from signal strength and packet success rate.. Valid values are `Excellent|Good|Fair|Poor|No Signal`',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Most recent radio signal strength measurement in dBm. Indicates communication quality between endpoint and collector. Typical range -110 to -50 dBm.',
    `tamper_detected_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent tamper event was detected by the endpoint. Null if no tamper has been detected.',
    `tamper_status` STRING COMMENT 'Current tamper detection status reported by the endpoint. Alerts to potential theft, fraud, or unauthorized access.. Valid values are `Normal|Tamper Detected|Magnetic Interference|Physical Removal|Reverse Flow`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the endpoint device expires. Used for replacement planning and cost recovery.',
    CONSTRAINT pk_ami_endpoint PRIMARY KEY(`ami_endpoint_id`)
) COMMENT 'Master record for each AMI/AMR communication endpoint device (encoder/receiver/transmitter unit) associated with a meter, and the fixed-network collector infrastructure (base stations, repeaters, mobile collectors) that enables automated reading across the service territory. Captures endpoint serial number, device type, firmware version, network node assignment, signal strength, battery level, last communication timestamp, encryption key version, tamper status, collector assignment, collector location, coverage area, and backhaul connection type. Distinct from the meter itself — one meter may have its endpoint replaced independently.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read` (
    `read_id` BIGINT COMMENT 'Primary key for read',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: For AMI/AMR reads, the read is captured by a specific AMI endpoint device. This links the read event to the communication endpoint that transmitted the data. Manual reads would have NULL ami_endpoint_',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Billing workflow: meter reads are the direct input to invoice generation. Billing systems must join reads to customer accounts to produce bills and apply billing cycle rules. read already has billing_',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: A meter read is captured for a specific meter installation (a meter deployed at a location), not just an abstract meter device. Reads are tied to the installation context (location, service point). Th',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: Meter reads are collected along defined read routes (for manual, walk-by, or drive-by reading operations). Each read should reference which route it was collected on for operational tracking and route',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Rate application in billing: reads must reference the service_agreement to apply the correct rate schedule, contracted volume thresholds, and minimum charges. service_agreement holds billing_rate_sche',
    `average_daily_consumption` DECIMAL(18,2) COMMENT 'Average daily consumption',
    `average_daily_usage` DECIMAL(18,2) COMMENT 'Average daily usage for the period',
    `battery_voltage` DECIMAL(18,2) COMMENT 'Endpoint battery voltage',
    `billed_date` DATE COMMENT 'Date read was billed',
    `billed_flag` BOOLEAN COMMENT 'Whether read has been billed',
    `billing_cycle_code` STRING COMMENT '',
    `billing_period` STRING COMMENT 'Billing period identifier',
    `billing_period_end` DATE COMMENT 'End of billing period for this read',
    `billing_period_end_date` DATE COMMENT 'End of billing period for this read',
    `billing_period_start` DATE COMMENT 'Start of billing period for this read',
    `billing_period_start_date` DATE COMMENT 'Start of billing period for this read',
    `consumption` DOUBLE COMMENT '',
    `consumption_unit` STRING COMMENT 'Unit of consumption (gallons, cubic feet, liters)',
    `consumption_units` STRING COMMENT 'Units of consumption',
    `consumption_value` DECIMAL(18,2) COMMENT 'Calculated consumption since last read',
    `consumption_variance_pct` DECIMAL(18,2) COMMENT 'Variance from historical average percent',
    `continuous_flow_days` STRING COMMENT 'Number of continuous flow days',
    `created_at` TIMESTAMP COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT '',
    `current_reading` DECIMAL(18,2) COMMENT 'Current meter reading',
    `daily_average` DECIMAL(18,2) COMMENT 'Daily average consumption',
    `daily_average_consumption` DECIMAL(18,2) COMMENT 'Average daily consumption',
    `data_quality_flag` BOOLEAN COMMENT '',
    `days_in_period` STRING COMMENT 'Days in read period',
    `days_since_last_read` STRING COMMENT 'Number of days since previous read',
    `estimated_flag` BOOLEAN COMMENT 'Whether read was estimated',
    `estimation_method` STRING COMMENT 'Method used for estimation',
    `estimation_reason` STRING COMMENT 'Reason for estimation',
    `exception_code` STRING COMMENT 'Exception code if applicable',
    `exception_description` STRING COMMENT '',
    `high_low_flag` STRING COMMENT 'Flag indicating abnormally high or low consumption',
    `ingestion_timestamp` TIMESTAMP COMMENT '',
    `is_billed` BOOLEAN COMMENT 'Whether the read has been billed.',
    `is_estimated` BOOLEAN COMMENT 'Whether the read was estimated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp',
    `latitude` DECIMAL(18,2) COMMENT 'Read location latitude',
    `leak_flag` BOOLEAN COMMENT 'Whether continuous flow indicates a possible leak',
    `longitude` DECIMAL(18,2) COMMENT 'Read location longitude',
    `method` STRING COMMENT '',
    `no_flow_days` STRING COMMENT 'Number of no-flow days',
    `notes` STRING COMMENT 'Read notes',
    `previous_read_value` DECIMAL(18,2) COMMENT 'Previous meter read value',
    `previous_reading` DECIMAL(18,2) COMMENT 'Previous register reading',
    `quality_code` STRING COMMENT '',
    `quality_flag` BOOLEAN COMMENT '',
    `read_date` DATE COMMENT '',
    `read_status` STRING COMMENT '',
    `read_timestamp` TIMESTAMP COMMENT '',
    `read_type` STRING COMMENT '',
    `reader_employee_id_manual` STRING COMMENT 'Manual reader employee identifier',
    `reader_notes` STRING COMMENT 'Reader notes',
    `record_status` STRING COMMENT '',
    `register_reading` DECIMAL(18,2) COMMENT 'Register reading value',
    `reverse_flow_flag` BOOLEAN COMMENT 'Whether reverse flow was detected',
    `rollover_flag` BOOLEAN COMMENT 'Whether register rollover occurred',
    `sequence_number` STRING COMMENT 'Sequence number within route',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'AMI signal strength in dBm',
    `source` STRING COMMENT 'read source for read',
    `tamper_flag` BOOLEAN COMMENT 'Whether tamper was detected',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `updated_at` TIMESTAMP COMMENT '',
    `updated_date` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `validated_flag` BOOLEAN COMMENT '',
    `validation_code` STRING COMMENT 'Validation code',
    `validation_status` STRING COMMENT 'Validation status',
    `validation_timestamp` TIMESTAMP COMMENT '',
    `value` DOUBLE COMMENT '',
    `zero_consumption_flag` BOOLEAN COMMENT 'Whether zero consumption',
    CONSTRAINT pk_read PRIMARY KEY(`read_id`)
) COMMENT 'Individual meter reading record capturing the register value at a specific point in time for a given meter installation. Stores read date and time, read value (gallons or CCF), read type (AMI automated, AMR drive-by, manual field read, estimated), read source system, reader employee ID (for manual reads), read quality flag, exception code, and whether the read was used for billing. The authoritative transactional record for all meter reads feeding the Oracle CC&B billing cycle.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` (
    `interval_consumption_id` BIGINT COMMENT 'Unique identifier for each interval consumption record. Primary key for the interval consumption data product.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI endpoint device that transmitted this interval data. Corresponds to the Sensus FlexNet endpoint serial number or device identifier.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where this meter is located. Used for Non-Revenue Water (NRW) analysis, pressure zone management, and distribution network optimization.',
    `installation_id` BIGINT COMMENT 'Reference to the specific meter installation that generated this interval reading. Links to the meter installation registry in the metering domain.',
    `alarm_code` STRING COMMENT 'Code indicating any alarm condition detected during this interval. Examples include leak alarm, burst alarm, backflow alarm, low battery alarm, or communication failure alarm. Empty if no alarm condition exists.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'The battery voltage of the AMI endpoint device at the time of this reading, measured in volts. Used to monitor endpoint health and predict battery replacement needs.',
    `consumption_volume_gallons` DECIMAL(18,2) COMMENT 'The total volume of water consumed during this interval, measured in gallons. This is the primary consumption metric used for billing, leak detection, and demand analysis.',
    `data_quality_indicator` STRING COMMENT 'Indicates the quality and reliability of this interval reading. Valid readings are directly measured; estimated readings are interpolated due to communication gaps; suspect readings show anomalies; missing indicates no data received; tampered indicates potential meter tampering; overflow indicates meter register overflow.. Valid values are `valid|estimated|suspect|missing|tampered|overflow`',
    `estimated_method` STRING COMMENT 'The method used to estimate this interval reading if data was missing or invalid. None indicates actual measured data. Other values indicate the estimation algorithm applied.. Valid values are `none|linear_interpolation|historical_average|same_day_prior_week|zero_fill|carry_forward`',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The average flow rate during the interval, measured in gallons per minute. Calculated as consumption volume divided by interval duration. Used for leak detection and high-flow alerting.',
    `gap_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval represents a data gap that was filled by estimation or interpolation. True indicates the reading is estimated due to missing data transmission.',
    `high_usage_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval exceeded the high-usage threshold for this meter installation. True indicates consumption significantly above normal patterns, potentially indicating irrigation, filling pools, or abnormal usage.',
    `interval_duration_minutes` DECIMAL(18,2) COMMENT 'The length of the consumption interval in minutes. Typically 15, 30, or 60 minutes for AMI systems. Used to normalize consumption rates and identify irregular interval lengths.',
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
    `tamper_event_code` STRING COMMENT 'Code indicating the type of tamper event detected during this interval, if any. Examples include magnetic interference, tilt detection, removal detection, or reverse flow. Empty if no tamper event detected.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'The ambient temperature at the meter location during this interval, measured in degrees Fahrenheit. Some AMI endpoints include temperature sensors for freeze detection and consumption correlation analysis.',
    `transmission_retry_count` STRING COMMENT 'The number of transmission attempts required to successfully deliver this interval reading to the AMI collector. Higher retry counts indicate communication challenges.',
    `validation_status` STRING COMMENT 'The current validation status of this interval reading. Pending indicates awaiting validation; validated indicates passed all quality checks; rejected indicates failed validation; under review indicates manual review required.. Valid values are `pending|validated|rejected|under_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was validated or rejected. Used for audit trails and data quality reporting.',
    `zero_consumption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether zero consumption was recorded during this interval. True indicates no water usage, which may be normal for vacant properties or may indicate meter malfunction.',
    CONSTRAINT pk_interval_consumption PRIMARY KEY(`interval_consumption_id`)
) COMMENT 'High-frequency interval consumption data collected from AMI endpoints, typically at 15-minute or hourly intervals. Stores meter installation reference, interval start and end timestamps, consumption volume (gallons), flow rate (GPM), data quality indicator, gap flag, and raw pulse count. Sourced from the AMI head-end system and time-series data historian. Enables leak detection, high-usage alerting, time-of-use analysis, and demand forecasting at sub-daily granularity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` (
    `high_usage_alert_id` BIGINT COMMENT 'Unique identifier for the high usage alert record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: High usage alerts notify account holders to prevent bill shock. Core customer service function requiring account contact information, notification preferences, and alert history tracking for customer ',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation that triggered this high usage alert. Links to the specific meter deployment at a service location.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: High usage alerts analyzed by premise type for pattern detection. Required for identifying systemic issues by building type, seasonal usage anomalies, and targeting conservation messaging to specific ',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: High usage alerts tied to physical locations for field investigation. Essential for dispatching field crews, correlating alerts with address characteristics, and geographic pattern analysis for leak d',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` (
    `accuracy_test_id` BIGINT COMMENT 'Primary key for accuracy_test',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Accuracy tests are performed on physical meter devices to assess measurement accuracy and compliance with standards. Each test record must reference which specific meter was tested. FK named metering_',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Accuracy tests can be performed in the field (in-situ testing) at a specific meter installation, or in a lab/bench setting. For field tests, this FK links the test to the installation location. This F',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Meter accuracy testing programs are mandated by specific regulatory requirements (AWWA M6, state metering regulations). Compliance reports must reference which regulation drove each test. The existing',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: AWWA-mandated meter accuracy tests are initiated via work orders in utility EAM systems. Linking accuracy_test to the triggering work_order enables regulatory compliance traceability (test-on-complain',
    `acceptance_threshold_pct` DECIMAL(18,2) COMMENT 'Accuracy threshold for pass/fail determination',
    `accuracy_high_flow_percent` DECIMAL(18,2) COMMENT '',
    `accuracy_low_flow_percent` DECIMAL(18,2) COMMENT '',
    `accuracy_mid_flow_percent` DECIMAL(18,2) COMMENT '',
    `accuracy_pct` DECIMAL(18,2) COMMENT '',
    `accuracy_percent` DECIMAL(18,2) COMMENT '',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'Measured accuracy percentage.',
    `accuracy_threshold_pct` DECIMAL(18,2) COMMENT 'Accuracy threshold for pass/fail',
    `actual_volume` DECIMAL(18,2) COMMENT 'Actual volume passed through meter',
    `adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor applied',
    `adjustment_made` BOOLEAN COMMENT 'Whether adjustment was made',
    `calibration_certificate_number` STRING COMMENT '',
    `composite_accuracy_percent` DECIMAL(18,2) COMMENT 'Weighted composite accuracy',
    `corrective_action_taken` STRING COMMENT 'Corrective action taken if meter failed',
    `created_at` TIMESTAMP COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_present` BOOLEAN COMMENT 'Whether customer was present',
    `data_quality_flag` BOOLEAN COMMENT 'True when record passed data validation.',
    `disposition` STRING COMMENT 'Meter disposition (return to service, scrap, etc.)',
    `high_flow_accuracy` DECIMAL(18,2) COMMENT 'High flow accuracy percentage.',
    `high_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy at high flow rate',
    `high_flow_accuracy_percent` DECIMAL(18,2) COMMENT 'Accuracy at high flow rate',
    `high_flow_rate_gpm` DECIMAL(18,2) COMMENT 'High flow test rate',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp',
    `low_flow_accuracy` DECIMAL(18,2) COMMENT 'Low flow accuracy percentage.',
    `low_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy at low flow rate',
    `low_flow_accuracy_percent` DECIMAL(18,2) COMMENT 'Accuracy at low flow rate',
    `low_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Low flow test rate',
    `measured_volume` DECIMAL(18,2) COMMENT 'Volume measured by the meter during test',
    `medium_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy at medium flow rate',
    `medium_flow_accuracy_percent` DECIMAL(18,2) COMMENT 'Accuracy at medium flow rate',
    `medium_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Medium flow test rate',
    `mid_flow_accuracy` DECIMAL(18,2) COMMENT 'Mid flow accuracy percentage.',
    `mid_flow_accuracy_pct` DECIMAL(18,2) COMMENT '',
    `mid_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Medium flow test rate in GPM',
    `notes` STRING COMMENT 'Test notes',
    `pass_fail_flag` BOOLEAN COMMENT '',
    `pass_fail_result` STRING COMMENT '',
    `pass_fail_status` STRING COMMENT 'Whether the meter passed or failed the test',
    `pass_flag` BOOLEAN COMMENT 'Whether meter passed',
    `pass_threshold_percent` DECIMAL(18,2) COMMENT 'Minimum accuracy to pass',
    `passed` BOOLEAN COMMENT 'Whether the meter passed.',
    `passed_flag` BOOLEAN COMMENT '',
    `post_adjustment_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy after adjustment',
    `post_repair_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy after repair',
    `post_test_read` DECIMAL(18,2) COMMENT 'Meter reading after test',
    `post_test_reading` DECIMAL(18,2) COMMENT 'Meter reading after test',
    `pre_test_read` DECIMAL(18,2) COMMENT 'Meter reading before test',
    `pre_test_reading` DECIMAL(18,2) COMMENT 'Meter reading before test',
    `record_status` STRING COMMENT '',
    `repair_description` STRING COMMENT 'Description of repair',
    `repair_performed` BOOLEAN COMMENT 'Whether repair was performed',
    `repair_required` BOOLEAN COMMENT 'Whether repair is required',
    `replacement_recommended` BOOLEAN COMMENT 'Whether replacement recommended',
    `replacement_recommended_flag` BOOLEAN COMMENT 'Whether replacement is recommended based on results',
    `technician_name` STRING COMMENT 'Name of technician',
    `technician_notes` STRING COMMENT 'Technician notes',
    `test_bench_calibration_date` DATE COMMENT 'Test bench calibration date',
    `test_bench_code` STRING COMMENT 'Identifier of the test bench used',
    `test_date` DATE COMMENT '',
    `test_equipment_code` STRING COMMENT '',
    `test_facility` STRING COMMENT '',
    `test_flow_rate` DECIMAL(18,2) COMMENT '',
    `test_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate during test in GPM',
    `test_location` STRING COMMENT 'Test location (field, shop)',
    `test_method` STRING COMMENT '',
    `test_notes` STRING COMMENT 'Notes from the accuracy test',
    `test_number` STRING COMMENT 'Unique test number',
    `test_reason` STRING COMMENT 'Reason for test (scheduled, complaint, replacement, new)',
    `test_result` STRING COMMENT '',
    `test_standard` STRING COMMENT '',
    `test_status` STRING COMMENT 'Test status',
    `test_type` STRING COMMENT 'Type of test (low flow, medium flow, high flow, full range)',
    `test_volume_gallons` DECIMAL(18,2) COMMENT 'Volume used in test',
    `tested_by` STRING COMMENT '',
    `tolerance_percent` DECIMAL(18,2) COMMENT '',
    `updated_at` TIMESTAMP COMMENT '',
    `updated_date` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `water_temperature_f` DECIMAL(18,2) COMMENT 'Water temperature during test',
    `weighted_accuracy_pct` DECIMAL(18,2) COMMENT 'AWWA weighted accuracy percentage',
    `weighted_accuracy_percent` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_accuracy_test PRIMARY KEY(`accuracy_test_id`)
) COMMENT 'Records meter assessment activities including accuracy testing (bench test, in-situ, field test per AWWA M6 standards) and physical field inspections (condition assessment, seal verification, pit/vault inspection, AMI antenna check). Captures assessment date, meter installation reference, assessment type, technician ID, test results (accuracy percentages at low/intermediate/high flow rates for tests; condition ratings and observations for inspections), pass/fail determination, photographic evidence reference, and recommended action. Supports meter replacement program decisions and proactive asset management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` (
    `replacement_order_id` BIGINT COMMENT 'Primary key for replacement_order',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: replacement_order captures old_meter_accuracy_test_result as a scalar value but lacks FK to the actual accuracy_test record that triggered the replacement. Meter replacements are often driven by faile',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: Meter replacements in utility asset management programs are triggered by condition assessments (poor condition grade, end-of-life scoring). Linking replacement_order to the condition_assessment that j',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer notification and appointment scheduling for meter replacements: replacement_order has customer_notification_date, customer_notified, customer_present fields requiring direct account linkage. ',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Meter replacements are frequently triggered by documented asset failures (meter failure, inaccuracy beyond AWWA threshold). Linking replacement_order to the failure_record that caused it supports root',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: A replacement order is executed at a specific meter installation (service location). This FK directly links the work order to the physical installation record where the old meter is removed and the ne',
    `meter_id` BIGINT COMMENT 'New meter installed',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Meter replacement orders are executed at a specific service line. LCRR compliance programs require coordinating meter replacements with lead service line replacements. Replacement order records must r',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Each meter replacement is executed via work order that schedules crews, tracks labor/materials, manages old meter disposal, and closes out capital projects. Standard utility field service workflow lin',
    `access_issue` BOOLEAN COMMENT 'Whether access issue was encountered',
    `access_issue_description` STRING COMMENT 'Description of access issue',
    `access_issues` BOOLEAN COMMENT 'Whether access issues occurred',
    `access_notes` STRING COMMENT 'Access issue notes',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual replacement cost.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT '',
    `appointment_window` STRING COMMENT 'Scheduled appointment window',
    `completed_date` DATE COMMENT 'Actual completion date',
    `completion_date` DATE COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_notification_date` DATE COMMENT 'Date customer was notified',
    `customer_notified` BOOLEAN COMMENT 'Whether customer was notified',
    `customer_present` BOOLEAN COMMENT 'Whether customer was present',
    `data_quality_flag` BOOLEAN COMMENT 'True when record passed data validation.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated replacement cost.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT '',
    `final_read` STRING COMMENT '',
    `final_read_value` DECIMAL(18,2) COMMENT 'Final read on old meter',
    `initial_read_value` DECIMAL(18,2) COMMENT 'Initial read on new meter',
    `is_complete` BOOLEAN COMMENT '',
    `is_completed` BOOLEAN COMMENT 'Whether replacement is complete.',
    `is_emergency` BOOLEAN COMMENT '',
    `labor_cost` DECIMAL(18,2) COMMENT 'Labor cost',
    `labor_hours` DECIMAL(18,2) COMMENT 'Labor hours for replacement',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp',
    `material_cost` DECIMAL(18,2) COMMENT 'Material cost',
    `meter_cost` DECIMAL(18,2) COMMENT 'Cost of new meter',
    `new_meter_initial_reading` DECIMAL(18,2) COMMENT 'Initial reading on new meter',
    `new_meter_number` STRING COMMENT 'Serial number of new meter',
    `new_meter_read` DECIMAL(18,2) COMMENT '',
    `new_meter_reading` DECIMAL(18,2) COMMENT 'Initial reading on new meter',
    `new_meter_serial_number` STRING COMMENT 'New meter serial number',
    `notes` STRING COMMENT 'Order notes',
    `old_meter_final_reading` DECIMAL(18,2) COMMENT 'Final reading on old meter',
    `old_meter_number` STRING COMMENT '',
    `old_meter_read` DECIMAL(18,2) COMMENT '',
    `old_meter_reading` DECIMAL(18,2) COMMENT 'Final reading on old meter',
    `order_date` DATE COMMENT '',
    `order_number` STRING COMMENT '',
    `order_status` STRING COMMENT '',
    `order_type` STRING COMMENT '',
    `pit_condition` STRING COMMENT 'Meter pit condition',
    `pit_condition_noted` STRING COMMENT 'Pit condition noted',
    `pit_repair_needed` BOOLEAN COMMENT 'Whether pit repair is needed',
    `pit_repairs_needed` BOOLEAN COMMENT 'Whether pit repairs needed',
    `priority` STRING COMMENT '',
    `priority_level` STRING COMMENT '',
    `reason_code` STRING COMMENT 'Replacement reason code',
    `record_status` STRING COMMENT '',
    `replacement_reason` STRING COMMENT 'Reason for replacement',
    `scheduled_date` DATE COMMENT '',
    `technician_name` STRING COMMENT 'Name of technician',
    `technician_notes` STRING COMMENT 'Technician notes',
    `total_cost` DECIMAL(18,2) COMMENT 'Total replacement cost',
    `updated_at` TIMESTAMP COMMENT '',
    `updated_date` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_replacement_order PRIMARY KEY(`replacement_order_id`)
) COMMENT 'Individual work order record for the physical replacement of a meter at a service location, executed as part of a replacement program or triggered by accuracy failure, damage, or customer request. Captures replacement program reference, scheduled date, completion date, old meter ID, new meter ID, technician ID, reason for replacement, old meter final read, new meter initial read, service interruption duration, and Maximo work order number. Bridges the metering domain with the asset and workforce domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_route` (
    `read_route_id` BIGINT COMMENT 'Primary key for read_route',
    `dma_id` BIGINT COMMENT 'FK to district metered area',
    `sewershed_basin_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewershed_basin. Business justification: Inflow/Infiltration (I/I) analysis requires correlating total metered water consumption per read route against wastewater flows per sewershed basin. Utilities and regulators use this water balance to ',
    `active_flag` BOOLEAN COMMENT 'Whether the route is currently active',
    `assigned_reader` STRING COMMENT 'Assigned meter reader name',
    `average_read_success_pct` DECIMAL(18,2) COMMENT 'Average read success rate',
    `created_at` TIMESTAMP COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT '',
    `cycle_code` STRING COMMENT '',
    `data_quality_flag` BOOLEAN COMMENT 'True when record passed data validation.',
    `ending_address` STRING COMMENT 'Route ending address',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time to complete route in hours',
    `estimated_duration_min` STRING COMMENT '',
    `estimated_duration_minutes` STRING COMMENT 'Estimated duration minutes',
    `estimated_read_hours` DECIMAL(18,2) COMMENT '',
    `estimated_read_minutes` STRING COMMENT '',
    `estimated_read_time_hours` DECIMAL(18,2) COMMENT 'Estimated time to read route',
    `geographic_area` STRING COMMENT 'Geographic area covered',
    `hazard_notes` STRING COMMENT 'Hazard notes for route',
    `hazards_noted` STRING COMMENT 'Hazards noted on route',
    `is_active` BOOLEAN COMMENT 'Whether route is active',
    `last_completion_pct` DECIMAL(18,2) COMMENT 'Completion percentage on last read',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modified timestamp',
    `last_read_date` DATE COMMENT 'Date the route was last read',
    `meter_count` STRING COMMENT '',
    `next_read_date` DATE COMMENT 'Next scheduled read date',
    `next_scheduled_read_date` DATE COMMENT 'Next scheduled read date',
    `notes` STRING COMMENT 'Route notes',
    `read_cycle` STRING COMMENT 'Billing read cycle for the route.',
    `read_cycle_days` STRING COMMENT '',
    `read_frequency` STRING COMMENT 'Frequency of reads (monthly, bi-monthly, quarterly)',
    `read_frequency_days` STRING COMMENT '',
    `read_method` STRING COMMENT '',
    `read_sequence` STRING COMMENT 'Read sequence order',
    `read_sequence_count` STRING COMMENT '',
    `read_sequence_method` STRING COMMENT '',
    `read_sequence_order` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `route_code` STRING COMMENT '',
    `route_distance_miles` DECIMAL(18,2) COMMENT 'Total route distance',
    `route_name` STRING COMMENT '',
    `route_number` STRING COMMENT 'Read route number.',
    `route_sequence` STRING COMMENT 'Route sequence number',
    `route_status` STRING COMMENT '',
    `route_type` STRING COMMENT 'Type of route (walk, drive-by, AMI)',
    `scheduled_read_day` STRING COMMENT 'Scheduled day of month for reading',
    `seasonal_end_month` STRING COMMENT 'Seasonal end month',
    `seasonal_flag` BOOLEAN COMMENT 'Whether route is seasonal',
    `seasonal_start_month` STRING COMMENT 'Seasonal start month',
    `sequence_method` STRING COMMENT 'Method for sequencing stops',
    `sequence_optimized` BOOLEAN COMMENT 'Whether route sequence is optimized',
    `sequence_order` STRING COMMENT '',
    `special_instructions` STRING COMMENT 'Special reading instructions',
    `starting_address` STRING COMMENT 'Route starting address',
    `total_route_miles` DECIMAL(18,2) COMMENT 'Total route distance in miles',
    `updated_at` TIMESTAMP COMMENT '',
    `updated_date` TIMESTAMP COMMENT 'Record last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `zip_code` STRING COMMENT 'Primary ZIP code for route',
    CONSTRAINT pk_read_route PRIMARY KEY(`read_route_id`)
) COMMENT 'Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` (
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
    `meter_size_type_description` STRING COMMENT 'Detailed description of the meter size type including typical applications, customer classes, and usage characteristics (e.g., Standard residential meter for single-family homes).',
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ADD CONSTRAINT `fk_metering_meter_size_type_primary_replacement_meter_size_type_id` FOREIGN KEY (`primary_replacement_meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `final_read_value` SET TAGS ('dbx_business_glossary_term' = 'Final Read');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `initial_read_value` SET TAGS ('dbx_business_glossary_term' = 'Initial Read');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installer_notes` SET TAGS ('dbx_business_glossary_term' = 'Installer Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_expected_life_years` SET TAGS ('dbx_business_glossary_term' = 'Battery Expected Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_install_date` SET TAGS ('dbx_business_glossary_term' = 'Battery Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'RF|Cellular|LoRaWAN|NB-IoT|Other');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention in Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'AES-128|AES-256|None');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Device Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'ERT|MXU|iPerl|Orion|Ally|Other');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_technician` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `leak_alert_threshold_gpm` SET TAGS ('dbx_business_glossary_term' = 'Leak Alert Threshold in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `leak_detection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `read_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Read Interval in Seconds');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `reverse_flow_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Signal Quality Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor|No Signal');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detected Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_business_glossary_term' = 'Tamper Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_value_regex' = 'Normal|Tamper Detected|Magnetic Interference|Physical Removal|Reverse Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `average_daily_usage` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Usage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Consumption Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `days_since_last_read` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Read');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `high_low_flag` SET TAGS ('dbx_business_glossary_term' = 'High/Low Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `leak_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `previous_read_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `reader_employee_id_manual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `reader_employee_id_manual` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `tamper_flag` SET TAGS ('dbx_business_glossary_term' = 'Tamper Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Consumption ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `consumption_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'valid|estimated|suspect|missing|tampered|overflow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_value_regex' = 'none|linear_interpolation|historical_average|same_day_prior_week|zero_fill|carry_forward');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `high_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'High Usage Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `leak_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pulse_increment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Pulse Increment in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `raw_pulse_count` SET TAGS ('dbx_business_glossary_term' = 'Raw Pulse Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `tamper_event_code` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `transmission_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Transmission Retry Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `zero_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Consumption Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^HUA-[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'high_consumption|continuous_flow|backflow_suspected|leak_detected|abnormal_pattern|threshold_exceeded');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `baseline_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `baseline_period_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledged Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ami_interval_data|ami_daily_read|manual_read|estimated_read|scada_flow_data|analytics_engine');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `detection_period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Period End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `detection_period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Period Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `estimated_revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `estimated_water_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Water Loss Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `first_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `investigation_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Started Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notification_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_order_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Order Created Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd|percent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_subdomain' = 'meter_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `acceptance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `high_flow_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'High Flow Accuracy');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `low_flow_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Low Flow Accuracy');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `measured_volume` SET TAGS ('dbx_business_glossary_term' = 'Measured Volume');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `medium_flow_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Medium Flow Accuracy');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `post_test_read` SET TAGS ('dbx_business_glossary_term' = 'Post-Test Read');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `pre_test_read` SET TAGS ('dbx_business_glossary_term' = 'Pre-Test Read');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `replacement_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Recommended');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `test_bench_code` SET TAGS ('dbx_business_glossary_term' = 'Test Bench ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `test_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `weighted_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Weighted Accuracy');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_subdomain' = 'meter_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sewershed Basin Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `ending_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `ending_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `last_read_date` SET TAGS ('dbx_business_glossary_term' = 'Last Read Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `next_scheduled_read_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Read');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_frequency` SET TAGS ('dbx_business_glossary_term' = 'Read Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `starting_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `starting_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `primary_replacement_meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Meter Size Type ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Accuracy Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_percentage_low_flow` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage at Low Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_percentage_normal_flow` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage at Normal Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `ami_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Compatible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `amr_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Meter Reading (AMR) Compatible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `average_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Cost in United States Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `average_unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `awwa_standard_code` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Standard Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `awwa_standard_code` SET TAGS ('dbx_value_regex' = '^C[0-9]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression|saddle|direct_bury');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Display Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `display_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `flange_standard` SET TAGS ('dbx_business_glossary_term' = 'Flange Standard Specification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Installation Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_business_glossary_term' = 'Installation Orientation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|any');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `lead_free_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead-Free Certified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `length_inches` SET TAGS ('dbx_business_glossary_term' = 'Length (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_continuous_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_registered_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Registered Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `maximum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `maximum_intermittent_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intermittent Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_business_glossary_term' = 'Measurement Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|class_iv');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `min_detectable_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `minimum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `nsf_61_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF 61 Certified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `pressure_loss_at_max_flow_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Loss at Maximum Flow in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Register Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_business_glossary_term' = 'Register Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_value_regex' = 'mechanical|electronic|encoder');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_millimeters` SET TAGS ('dbx_business_glossary_term' = 'Meter Size in Millimeters');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `straight_pipe_downstream_inches` SET TAGS ('dbx_business_glossary_term' = 'Straight Pipe Downstream Requirement (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `straight_pipe_upstream_inches` SET TAGS ('dbx_business_glossary_term' = 'Straight Pipe Upstream Requirement (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `temperature_rating_fahrenheit_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Rating (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `temperature_rating_fahrenheit_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Rating (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `testing_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `thread_standard` SET TAGS ('dbx_business_glossary_term' = 'Thread Standard Specification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_application` SET TAGS ('dbx_business_glossary_term' = 'Typical Application');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Typical Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|institutional|agricultural|municipal');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Typical Service Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight (Pounds)');
