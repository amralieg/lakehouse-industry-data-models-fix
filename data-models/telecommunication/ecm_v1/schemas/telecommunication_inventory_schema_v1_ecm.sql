-- Schema for Domain: inventory | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`inventory` COMMENT 'SSOT for physical and logical resource inventory including CPE, SIM/eSIM stock, ONT/OLT hardware, fiber infrastructure, spare parts, IP address pools, MSISDN/DID number ranges, spectrum allocations, and OSP/ISP asset tracking. Managed via Oracle OSM resource inventory and Netcracker.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` (
    `cpe_asset_id` BIGINT COMMENT 'Primary key for cpe_asset',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: CPE mass deployments (e.g., fiber-to-home rollouts, 5G CPE upgrades) are part of capital projects. Linking enables project cost tracking, budget variance analysis, and ROI calculation for network expa',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: CPE devices are procured based on catalog item SKUs. Links physical inventory to product catalog for cost tracking, procurement planning, warranty management, and asset lifecycle reporting. Essential ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CPE maintenance, repair, and replacement costs are allocated to cost centers for operational budgeting, expense tracking, and variance analysis. Enables cost center managers to track CPE-related expen',
    `cpni_authorization_id` BIGINT COMMENT 'Foreign key linking to compliance.cpni_authorization. Business justification: CPNI regulations require customer authorization before accessing customer equipment data for troubleshooting or service changes. Compliance audits must verify that technician access to specific CPE de',
    `customer_address_id` BIGINT COMMENT 'Identifier of the physical address where the CPE device is currently installed. Null if device is in warehouse.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: CPE assets (ONTs, routers, set-top boxes) are physical instances of device models from product catalog. Essential for warranty tracking, firmware update management, inventory valuation, and compatibil',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Field service operations require tracking which technician installed each CPE device for warranty claims, quality audits, and performance metrics. Standard telecom practice.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: CPE devices (modems, routers, set-top boxes) deployed at customer premises are capitalized fixed assets tracked for depreciation, book value, and financial statement preparation. Essential for asset c',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: CPE installation at customer premises is performed by field technicians. Tracking installer supports customer satisfaction analysis, first-time-fix rate calculation, and technician performance evaluat',
    `location_site_id` BIGINT COMMENT 'Identifier of the warehouse or storage facility where the CPE device is currently stored. Null if device is deployed.',
    `partner_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the CPE device was procured.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber to whom this CPE device is currently assigned. Null if device is unassigned.',
    `svc_instance_id` BIGINT COMMENT 'Identifier of the service instance that this CPE device is supporting. Null if device is unassigned.',
    `asset_tag` STRING COMMENT 'Internal asset tag or barcode assigned by the company for inventory tracking and auditing.. Valid values are `^AT[0-9]{8,12}$`',
    `assigned_date` DATE COMMENT 'Date when the CPE device was assigned to the current subscriber or service.',
    `assignment_status` STRING COMMENT 'Current assignment and operational status of the CPE device in the inventory lifecycle.. Valid values are `available|assigned|in_transit|retired|defective|under_repair`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CPE asset record was first created in the inventory system.',
    `device_type` STRING COMMENT 'Category of CPE device indicating its primary function in the customer network.. Valid values are `router|modem|set_top_box|ont|wifi_gateway|residential_gateway`',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the CPE device. Critical for security patching and feature management.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `hardware_version` STRING COMMENT 'Hardware revision or version of the CPE device as specified by the manufacturer.',
    `imei` STRING COMMENT 'IMEI number for mobile CPE devices. Used for device identification and network authentication.. Valid values are `^[0-9]{15}$`',
    `installation_date` DATE COMMENT 'Date when the CPE device was physically installed at the customer premises.',
    `ip_address` STRING COMMENT 'Current IP address assigned to the CPE device on the network. May be IPv4 or IPv6 format.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `is_5g_capable` BOOLEAN COMMENT 'Indicates whether the CPE device supports 5G New Radio (NR) connectivity.',
    `is_wifi6_capable` BOOLEAN COMMENT 'Indicates whether the CPE device supports Wi-Fi 6 (802.11ax) standard.',
    `last_maintenance_date` DATE COMMENT 'Date when the CPE device last underwent maintenance, repair, or firmware update.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the CPE device. Used for network provisioning and device authentication.. Valid values are `^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$`',
    `max_bandwidth_mbps` STRING COMMENT 'Maximum bandwidth capacity of the CPE device in megabits per second.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or firmware update for the CPE device.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special handling instructions for the CPE device.',
    `ownership_type` STRING COMMENT 'Indicates whether the CPE is company-owned, leased to customer, customer-owned (BYOD - Bring Your Own Device), or on trial.. Valid values are `owned|leased|byod|trial`',
    `physical_condition` STRING COMMENT 'Assessment of the physical condition of the CPE device. Used for redeployment decisions and asset valuation.. Valid values are `new|good|fair|poor|damaged|refurbished`',
    `port_count` STRING COMMENT 'Number of physical Ethernet ports available on the CPE device.',
    `procurement_date` DATE COMMENT 'Date when the CPE device was procured or purchased by the telecommunications company.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the procurement of this CPE device.. Valid values are `^PO[0-9]{8,12}$`',
    `retirement_date` DATE COMMENT 'Date when the CPE device was retired from active inventory and marked for disposal or recycling.',
    `return_date` DATE COMMENT 'Date when the CPE device was returned by the customer to the company inventory.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the CPE device. Used for warranty tracking and device identification.. Valid values are `^[A-Z0-9]{8,20}$`',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last updated this CPE asset record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CPE asset record was last updated in the inventory system.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer warranty coverage expires for the CPE device.',
    `warranty_start_date` DATE COMMENT 'Date when the manufacturer warranty coverage begins for the CPE device.',
    `warranty_status` STRING COMMENT 'Current status of the manufacturer warranty for the CPE device.. Valid values are `active|expired|extended|void`',
    `wifi_password` STRING COMMENT 'Default or configured Wi-Fi password for CPE devices with Wi-Fi capability. Encrypted at rest.',
    `wifi_ssid` STRING COMMENT 'Default or configured SSID for CPE devices with Wi-Fi capability.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this CPE asset record.',
    CONSTRAINT pk_cpe_asset PRIMARY KEY(`cpe_asset_id`)
) COMMENT 'Master record for Customer Premises Equipment (CPE) assets including routers, modems, set-top boxes, ONTs, and Wi-Fi gateways. Tracks device serial number, MAC address, model, firmware version, ownership type (owned/leased/BYOD), procurement date, warranty expiry, current assignment status, and physical condition. SSOT for all CPE hardware managed via Oracle OSM resource inventory.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`sim_stock` (
    `sim_stock_id` BIGINT COMMENT 'Unique identifier for the SIM stock record. Primary key for physical SIM cards and eSIM profiles managed in the operators inventory system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: SIM card inventory is high-security asset requiring designated custodian for activation code protection, IMSI range allocation authority, and regulatory audit compliance.',
    `fulfillment_order_id` BIGINT COMMENT 'Unique identifier of the order that reserved or allocated this SIM stock unit. Used to track fulfillment and provisioning workflows.',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Lawful intercept orders target specific IMSI/ICCID identifiers for surveillance. LEA compliance requires linking intercept orders to physical SIM inventory for provisioning intercept capabilities, mai',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: SIM card inventory is physically stored in warehouses and distribution centers, which are tracked as pop_facility records (facility_type=WAREHOUSE). Currently warehouse_location is a STRING; replaci',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber to whom this SIM stock unit is assigned. Null if the SIM is unallocated or reserved.',
    `svc_instance_id` BIGINT COMMENT 'Unique identifier of the service instance (mobile subscription, IoT connection) associated with this SIM stock unit. Null if not yet activated.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: eSIM profiles and physical SIMs are pre-configured for specific device models (iPhone 14, Samsung Galaxy S23). Critical for activation workflows, compatibility validation, and inventory allocation in ',
    `activated_timestamp` TIMESTAMP COMMENT 'Date and time when the SIM stock unit was activated and provisioned for service. Marks the transition to in-service status.',
    `activation_code` STRING COMMENT 'Unique activation code or QR code string used by the end user to download and install the eSIM profile. Only applicable for eSIM profiles.',
    `activation_status` STRING COMMENT 'Current lifecycle status of the SIM stock unit: unallocated (in warehouse), reserved (allocated to order), activated (in service), suspended (temporarily disabled), deactivated (service terminated), or retired (end of life).. Valid values are `unallocated|reserved|activated|suspended|deactivated|retired`',
    `allocated_timestamp` TIMESTAMP COMMENT 'Date and time when the SIM stock unit was allocated or reserved for a specific order or subscriber. Marks the transition from unallocated to reserved status.',
    `batch_number` STRING COMMENT 'Manufacturing or provisioning batch identifier for grouping SIM cards or eSIM profiles. Used for quality control, recall management, and inventory tracking.',
    `bin_location` STRING COMMENT 'Specific bin, shelf, or rack location within the warehouse for physical SIM card storage. Enables precise inventory picking and cycle counting. Null for eSIM profiles.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SIM stock record was first created in the inventory system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Date and time when the SIM stock unit was deactivated and removed from service. Marks the end of the active service lifecycle.',
    `download_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was downloaded from the SM-DP+ platform to the target device. Only applicable for eSIM profiles.',
    `eid` STRING COMMENT '32-digit unique identifier for the embedded Universal Integrated Circuit Card (eUICC). Only applicable for eSIM profiles. Null for physical SIM cards.. Valid values are `^[0-9]{32}$`',
    `esim_profile_state` STRING COMMENT 'State of the eSIM profile on the SM-DP+ platform: available (ready for download), downloaded (transferred to device), installed (on eUICC), enabled (active), disabled (inactive), or deleted (removed). Only applicable for eSIM profiles.. Valid values are `available|downloaded|installed|enabled|disabled|deleted`',
    `expiry_date` DATE COMMENT 'Date when the SIM card or eSIM profile expires and should no longer be issued. Used for inventory rotation and obsolescence management.',
    `form_factor` STRING COMMENT 'Physical form factor of the SIM card: 2FF (Mini-SIM), 3FF (Micro-SIM), 4FF (Nano-SIM), MFF2 (M2M form factor), or embedded (eSIM). Null for eSIM profiles.. Valid values are `2FF|3FF|4FF|MFF2|embedded`',
    `iccid` STRING COMMENT 'Unique 19-20 digit identifier for the SIM card or eSIM profile. Globally unique identifier assigned by the card manufacturer or SM-DP+ platform.. Valid values are `^[0-9]{19,20}$`',
    `imsi_range_end` STRING COMMENT 'Ending IMSI number in the range allocated to this SIM stock batch. Defines the upper boundary of the IMSI allocation for inventory management.. Valid values are `^[0-9]{15}$`',
    `imsi_range_start` STRING COMMENT 'Starting IMSI number in the range allocated to this SIM stock batch. 15-digit identifier used for subscriber authentication in mobile networks.. Valid values are `^[0-9]{15}$`',
    `is_test_sim` BOOLEAN COMMENT 'Flag indicating whether this SIM stock unit is designated for testing, lab use, or quality assurance purposes. True for test SIMs, false for production SIMs.',
    `ki_value` DECIMAL(18,2) COMMENT '128-bit secret authentication key stored on the SIM card for network authentication. Highly sensitive cryptographic material. Encrypted at rest.',
    `manufacturer` STRING COMMENT 'Name of the SIM card manufacturer or eSIM profile provider. Examples: Gemalto, Giesecke+Devrient, IDEMIA, Oberthur Technologies.',
    `manufacturing_date` DATE COMMENT 'Date when the physical SIM card was manufactured or the eSIM profile was generated on the SM-DP+ platform.',
    `network_type` STRING COMMENT 'Mobile network generation supported by the SIM card or eSIM profile: 2G (GSM), 3G (UMTS), 4G LTE, 5G NR, or multi (supports multiple generations).. Valid values are `2g|3g|4g_lte|5g_nr|multi`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special handling instructions related to this SIM stock unit. Used for operational annotations.',
    `opc_value` DECIMAL(18,2) COMMENT '128-bit operator-specific variant of the authentication algorithm configuration. Used in conjunction with Ki for LTE/5G authentication. Encrypted at rest.',
    `pin1` STRING COMMENT '4-8 digit PIN code for SIM card access control. Required for device unlock and SIM operations. Encrypted at rest.. Valid values are `^[0-9]{4,8}$`',
    `profile_type` STRING COMMENT 'Business classification of the SIM profile: consumer (handset), M2M (machine-to-machine), IoT (Internet of Things), enterprise (corporate), test (lab/QA), or bootstrap (initial provisioning).. Valid values are `consumer|m2m|iot|enterprise|test|bootstrap`',
    `puk1` STRING COMMENT '8-digit PIN Unblocking Key used to reset PIN1 after multiple failed attempts. Critical for customer self-service. Encrypted at rest.. Valid values are `^[0-9]{8}$`',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the procurement of this SIM stock batch. Links inventory to procurement and accounts payable.',
    `quality_check_date` DATE COMMENT 'Date when the quality assurance check was completed. Used for compliance tracking and inventory release management.',
    `quality_check_status` STRING COMMENT 'Status of the quality assurance check performed on the SIM stock: pending (awaiting inspection), passed (approved for use), failed (rejected), or not_required (no QA needed).. Valid values are `pending|passed|failed|not_required`',
    `received_date` DATE COMMENT 'Date when the SIM stock was received into the warehouse or provisioned on the SM-DP+ platform. Marks the start of inventory availability.',
    `roaming_enabled` BOOLEAN COMMENT 'Flag indicating whether international roaming is enabled for this SIM stock unit. True if roaming is allowed, false if restricted to home network.',
    `sim_type` STRING COMMENT 'Type of SIM card: physical SIM card or eSIM profile. Determines the inventory management and provisioning workflow.. Valid values are `physical|esim`',
    `smdp_address` STRING COMMENT 'Fully qualified domain name (FQDN) of the Subscription Manager Data Preparation Plus (SM-DP+) server hosting the eSIM profile. Only applicable for eSIM profiles.',
    `supplier_name` STRING COMMENT 'Name of the supplier or vendor who provided the SIM stock. Used for procurement tracking and supplier performance management.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Per-unit cost of the SIM card or eSIM profile in the operators base currency. Used for inventory valuation and CAPEX tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SIM stock record was last modified in the inventory system. Audit trail for record changes.',
    CONSTRAINT pk_sim_stock PRIMARY KEY(`sim_stock_id`)
) COMMENT 'Master inventory record for all SIM stock units including physical SIM cards (2FF/3FF/4FF) and eSIM profiles managed on the operators SM-DP+ platform. Physical SIM attributes: ICCID, IMSI range, batch number, manufacturer, form factor, warehouse location, and expiry date. eSIM profile attributes: EID (eUICC Identifier), profile ICCID, SM-DP+ profile state (downloaded/enabled/disabled/deleted), activation code, download timestamp, target device model, and profile type (operational/test/bootstrap). Common attributes: profile type (consumer/M2M/IoT), activation status (unallocated/reserved/activated/deactivated), subscriber assignment, and lifecycle timestamps. SSOT for all SIM and eSIM inventory managed per GSMA SGP.22 RSP specification via Netcracker resource inventory and Comverse ONE.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`ont_asset` (
    `ont_asset_id` BIGINT COMMENT 'Unique identifier for the ONT hardware asset record. Primary key for the ONT asset inventory.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: ONT deployments are part of FTTH/GPON capital projects. Linking enables project cost tracking, budget management, and ROI analysis for fiber network expansion. Essential for capital project financial ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ONT operational costs (maintenance, power, support) are allocated to cost centers for budget management and expense control. Required for cost center performance reporting and budget variance analysis',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: ONTs (Huawei MA5671, Nokia G-010S-A) are specific device models. Essential for firmware update campaigns, compatibility management with OLTs, spare parts planning, and end-of-life migration planning i',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Fiber-to-home installations require technician accountability for ONT provisioning quality, optical power readings validation, and installation defect tracking for training and quality control.',
    `network_equipment_id` BIGINT COMMENT 'Internal equipment identifier used in OSS/BSS systems for asset tracking and service provisioning workflows.. Valid values are `^[A-Z0-9-]{8,16}$`',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: ONTs are capitalized network equipment tracked as fixed assets for depreciation schedules, book value calculation, and financial reporting. Required for GAAP/IFRS compliance and asset management.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: ONT installation at customer premises is performed by field technicians. Tracking installer supports quality control, first-time-fix metrics, warranty claims, and technician performance evaluation—sta',
    `location_address_id` BIGINT COMMENT 'Reference to the physical service address where the ONT is installed at customer premises.',
    `olt_asset_id` BIGINT COMMENT 'Reference to the parent OLT device to which this ONT is connected in the GPON/FTTH network topology.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: ONT devices are supplied by vendor partners. Business processes: warranty claim processing, RMA management, supplier performance tracking, spare parts procurement. Vendor_name denormalized; proper FK ',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber account currently using services through this ONT device.',
    `activation_date` DATE COMMENT 'Date when the ONT was activated and provisioned in the network management system for service delivery.',
    `asset_tag` STRING COMMENT 'Internal asset tracking tag or barcode identifier used for inventory management and physical asset audits.. Valid values are `^[A-Z]{2,4}[0-9]{6,10}$`',
    `configuration_profile` STRING COMMENT 'Name of the configuration profile or template applied to this ONT for service provisioning and feature enablement.. Valid values are `^[A-Z0-9_]{5,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ONT asset record was first created in the inventory management system.',
    `decommission_date` DATE COMMENT 'Date when the ONT was decommissioned and removed from active service. Null if still in service.',
    `device_type` STRING COMMENT 'Classification of ONT device type: SFU (Single Family Unit), HGU (Home Gateway Unit), MDU (Multi-Dwelling Unit), MTU (Multi-Tenant Unit).. Valid values are `SFU|HGU|MDU|MTU`',
    `distance_from_olt_meters` STRING COMMENT 'Physical fiber distance in meters between the OLT and this ONT, calculated from optical signal propagation delay.',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the ONT device. Critical for feature support and security patching.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `gpon_port_reference` STRING COMMENT 'Unique GPON identifier assigned to the ONT for authentication and provisioning in the PON network.. Valid values are `^[A-Z0-9]{8,12}$`',
    `hardware_version` STRING COMMENT 'Hardware revision version of the ONT device indicating manufacturing batch and component specifications.. Valid values are `^[A-Z0-9.]{3,10}$`',
    `installation_date` DATE COMMENT 'Date when the ONT device was physically installed at the customer premises or network location.',
    `last_firmware_update_date` DATE COMMENT 'Date when the ONT firmware was last updated or patched.',
    `last_online_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful connection and communication between the ONT and OLT.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the ONT device used for network layer identification and provisioning.. Valid values are `^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$`',
    `max_downstream_bandwidth_mbps` STRING COMMENT 'Maximum downstream bandwidth capacity in megabits per second that this ONT device supports.',
    `max_upstream_bandwidth_mbps` STRING COMMENT 'Maximum upstream bandwidth capacity in megabits per second that this ONT device supports.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this ONT asset.',
    `olt_port_number` STRING COMMENT 'Physical port identifier on the OLT device where this ONT is connected, typically in shelf/slot/port format.. Valid values are `^[0-9]{1,2}/[0-9]{1,2}/[0-9]{1,2}$`',
    `operational_status` STRING COMMENT 'Current operational state of the ONT asset in the network lifecycle.. Valid values are `active|inactive|faulty|maintenance|decommissioned|reserved`',
    `optical_power_rx_dbm` DECIMAL(18,2) COMMENT 'Received optical power level at the ONT in decibels relative to one milliwatt (dBm). Critical for signal quality monitoring.',
    `optical_power_tx_dbm` DECIMAL(18,2) COMMENT 'Transmitted optical power level from the ONT in decibels relative to one milliwatt (dBm). Used for upstream signal quality assessment.',
    `ownership_type` STRING COMMENT 'Indicates whether the ONT is owned by the service provider, leased from a vendor, or owned by the customer.. Valid values are `owned|leased|customer_owned`',
    `port_count` STRING COMMENT 'Total number of Ethernet ports available on the ONT device for customer equipment connectivity.',
    `purchase_date` DATE COMMENT 'Date when the ONT asset was purchased from the vendor.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which this ONT asset was procured from the vendor.. Valid values are `^PO[0-9]{8,12}$`',
    `reboot_count` STRING COMMENT 'Total number of times the ONT device has been rebooted since installation. Used for stability analysis.',
    `remote_management_enabled_flag` BOOLEAN COMMENT 'Indicates whether remote management and configuration capabilities are enabled on this ONT device.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the ONT device. Used for device identification and warranty tracking.. Valid values are `^[A-Z0-9]{10,20}$`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Current operating temperature of the ONT device in degrees Celsius, monitored for thermal management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ONT asset record was last modified in the inventory management system.',
    `uptime_hours` STRING COMMENT 'Total number of hours the ONT has been continuously operational since last reboot or power cycle.',
    `voip_capability_flag` BOOLEAN COMMENT 'Indicates whether the ONT device supports VoIP telephony services with integrated analog telephone adapters.',
    `warehouse_location` STRING COMMENT 'Warehouse or storage facility location code where the ONT is stored when not deployed. Null if currently deployed.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `wifi_capability_flag` BOOLEAN COMMENT 'Indicates whether the ONT device has integrated WiFi capability for wireless connectivity.',
    CONSTRAINT pk_ont_asset PRIMARY KEY(`ont_asset_id`)
) COMMENT 'Master record for Optical Network Terminal (ONT) hardware assets deployed at customer premises in FTTH/GPON networks. Captures ONT serial number, model, vendor, GPON port assignment, optical power levels, firmware version, installation date, service address, and operational state. Linked to OLT infrastructure and fiber plant records. Managed via Oracle OSM and Netcracker.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`olt_asset` (
    `olt_asset_id` BIGINT COMMENT 'Unique identifier for the OLT hardware asset. Primary key for OLT inventory tracking in GPON/FTTH infrastructure.',
    `backup_olt_asset_id` BIGINT COMMENT 'Reference to the backup or standby OLT asset configured for failover protection of this primary OLT.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: OLT installations are capital projects tracked for budget, timeline, and ROI. Linking enables project cost tracking, budget variance analysis, and capital expenditure reporting for network infrastruct',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OLT operational expenses (power consumption, maintenance, support contracts) are tracked against cost centers for budget control and operational expense management. Essential for cost center budget re',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: OLTs are network equipment with specific models (Huawei MA5800, Nokia ISAM). Links to product catalog for lifecycle management, capacity planning, firmware updates, and end-of-support tracking in acce',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: OLTs are major capital investments in GPON/fiber infrastructure, tracked as fixed assets with depreciation schedules, book values, and useful life tracking. Critical for capital expenditure reporting ',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: OLT commissioning requires specialized technicians with fiber optic and network equipment certifications. Tracking installer is critical for commissioning records, accountability, and skill validation',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: OLTs are physically installed at central office sites. Essential for field technician dispatch, site capacity planning, power/cooling management, and regulatory site audits. Standard telco asset-to-si',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: OLT equipment has vendor relationships for maintenance contracts and technical support. Business processes: maintenance contract tracking via maintenance_contract_id, vendor SLA compliance measurement',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: OLT (Optical Line Terminal) assets are located in central offices and headend facilities. Currently location_code and site_name are STRING descriptors; replacing with FK to pop_facility provides full ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Critical OLT infrastructure requires assigned network engineer for capacity planning, firmware upgrade coordination, incident escalation, and 24/7 on-call rotation management.',
    `active_pon_ports` STRING COMMENT 'Number of PON ports currently in active operational use serving subscriber ONTs.',
    `asset_tag` STRING COMMENT 'Externally-visible unique asset tag or serial number assigned to the OLT hardware for physical identification and tracking.. Valid values are `^OLT-[A-Z0-9]{8,12}$`',
    `chassis_type` STRING COMMENT 'Physical form factor classification of the OLT chassis hardware.. Valid values are `rack_mount|standalone|modular|compact`',
    `commissioning_date` DATE COMMENT 'Date when the OLT was activated and placed into operational service for subscriber connectivity.',
    `compliance_certifications` STRING COMMENT 'Regulatory and industry compliance certifications held by the OLT hardware (e.g., FCC, CE, UL, NEBS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OLT asset record was first created in the inventory management system.',
    `current_ont_count` STRING COMMENT 'Current number of ONT devices actively registered and connected to this OLT in the network.',
    `decommission_date` DATE COMMENT 'Date when the OLT was retired from active service and removed from production network operations.',
    `environmental_temperature_rating_celsius` STRING COMMENT 'Rated operating temperature range specification for the OLT hardware in Celsius degrees.',
    `firmware_version` STRING COMMENT 'Current firmware or software version running on the OLT system for operational control and management.',
    `installation_date` DATE COMMENT 'Date when the OLT hardware was physically installed and commissioned at the site location.',
    `installed_line_cards` STRING COMMENT 'Current number of PON line cards physically installed in the OLT chassis slots.',
    `last_firmware_update_date` DATE COMMENT 'Date when the OLT firmware was most recently upgraded or patched.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent scheduled or corrective maintenance activity was performed on the OLT.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this OLT asset record was most recently modified or updated in the inventory system.',
    `line_card_slots` STRING COMMENT 'Total number of physical slots available in the OLT chassis for installing PON line cards.',
    `maintenance_contract_code` STRING COMMENT 'Identifier for the active maintenance or support contract covering this OLT asset.',
    `management_ip_address` STRING COMMENT 'IP address assigned to the OLT for network management, monitoring, and configuration access via NMS/EMS systems.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `max_ont_capacity` STRING COMMENT 'Maximum theoretical number of ONT devices that can be supported by this OLT based on hardware specifications and port capacity.',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operational time between hardware failures for this OLT, used for reliability and availability planning.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the OLT to operational status following a failure event.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled preventive maintenance activity on the OLT hardware.',
    `nms_system` STRING COMMENT 'Primary network management system platform used to monitor and manage this OLT asset.. Valid values are `Nokia NetAct|Ericsson Network Manager|Netcracker|Proprietary`',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special configurations, or historical information about the OLT asset.',
    `operational_status` STRING COMMENT 'Current operational lifecycle state of the OLT asset in the network infrastructure.. Valid values are `in_service|standby|maintenance|decommissioned|faulty|testing`',
    `power_consumption_watts` DECIMAL(18,2) COMMENT 'Rated or measured electrical power consumption of the OLT hardware in watts under normal operating conditions.',
    `purchase_order_number` STRING COMMENT 'Purchase order reference number under which this OLT hardware was procured.',
    `rack_position` STRING COMMENT 'Physical rack identifier and unit position within the central office or POP where the OLT chassis is mounted.',
    `redundancy_configuration` STRING COMMENT 'High availability and redundancy architecture configured for this OLT to ensure service continuity.. Valid values are `none|active_standby|active_active|n_plus_one`',
    `snmp_community_string` STRING COMMENT 'SNMP authentication string used for secure management access to the OLT device via network management systems.',
    `total_pon_ports` STRING COMMENT 'Total number of PON ports available on the OLT chassis across all installed line cards for downstream fiber connectivity.',
    `uplink_interface_type` STRING COMMENT 'Type of network interface used for uplink connectivity from the OLT to the core aggregation or metro network.. Valid values are `10GE|40GE|100GE|MPLS|Ethernet`',
    `uplink_port_count` STRING COMMENT 'Number of uplink ports available on the OLT for connectivity to upstream network infrastructure.',
    CONSTRAINT pk_olt_asset PRIMARY KEY(`olt_asset_id`)
) COMMENT 'Master record for Optical Line Terminal (OLT) hardware assets in GPON/FTTH central office and headend locations. Tracks OLT chassis, line card slots, PON port capacity, vendor (Nokia/Huawei/Calix), firmware version, location (POP/CO), power consumption, maximum ONT capacity, current ONT count, and operational status. SSOT for OLT infrastructure inventory.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` (
    `fiber_cable_id` BIGINT COMMENT 'Unique identifier for the fiber optic cable segment. Primary key for the fiber cable inventory record.',
    `duct_route_id` BIGINT COMMENT 'Identifier for the conduit or duct infrastructure housing this fiber cable. Null for aerial or direct-buried cables. Used for duct capacity planning and fill ratio analysis.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Fiber cable infrastructure represents significant capital investment, capitalized and depreciated over useful life (typically 20-25 years). Essential for network asset valuation, depreciation expense ',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Fiber cable deployment is performed by specialized outside plant technicians. Tracking installer supports quality control, maintenance history, and accountability for cable performance issues—essentia',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Outside plant fiber infrastructure requires designated maintenance owner for right-of-way management, splice point inspection scheduling, and emergency repair coordination with field crews.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Fiber infrastructure involves construction partners, joint build agreements, IRU arrangements. Business processes: shared infrastructure billing, right-of-way partner coordination, joint ownership tra',
    `capital_project_id` BIGINT COMMENT 'Identifier for the capital project or network expansion initiative under which this cable was deployed. Used for CAPEX tracking and project portfolio management.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Fiber cable procurement tracking for project costing, vendor management, and three-way match validation. Required for accurate capital project cost tracking and vendor performance evaluation.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Telecommunications carriers must file infrastructure deployment reports (FCC Form 477, broadband availability filings) that reference specific fiber cable routes and deployment projects. Regulatory fi',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Fiber cables typically terminate at POP facilities (central offices, headends, data centers). Tracking the starting facility provides critical context for cable routing and capacity planning. The star',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Fiber cables terminate at network elements (OLT, ODF, DWDM terminal). Logical-to-physical mapping for circuit provisioning, port assignment, and fault isolation requires linking physical fiber to term',
    `asset_tag` STRING COMMENT 'Physical asset tag or barcode identifier affixed to splice enclosures or cable markers for field identification. Used for asset tracking and inventory audits.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `assigned_fiber_count` STRING COMMENT 'Number of fibers currently allocated to active services or reserved for planned deployments. Used for utilization tracking and capacity management.',
    `attenuation_db_per_km` DECIMAL(18,2) COMMENT 'Signal loss measurement in decibels per kilometer. Critical QoS metric for network planning and service quality assurance.',
    `available_fiber_count` STRING COMMENT 'Number of unused (dark) fibers available for new service provisioning. Calculated as total fiber count minus assigned fibers. Critical for capacity planning.',
    `cable_code` STRING COMMENT 'Externally-known unique identifier for the fiber cable segment used in field operations, engineering drawings, and OSP documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `cable_type` STRING COMMENT 'Classification of the fiber optic cable based on transmission mode and construction. Single-mode for long-haul, multi-mode for short-distance, ribbon for high-density, hybrid for mixed applications.. Valid values are `single_mode|multi_mode|ribbon|hybrid|armored|loose_tube`',
    `conduit_fill_ratio_percent` DECIMAL(18,2) COMMENT 'Percentage of conduit cross-sectional area occupied by cables. Industry best practice limits fill to 60-70% to allow for future expansion and cable movement. Null for non-conduit deployments.',
    `conduit_inner_diameter_mm` DECIMAL(18,2) COMMENT 'Internal diameter of the conduit in millimeters. Used for calculating fill ratio and determining additional cable placement capacity. Null for non-conduit deployments.',
    `conduit_material_type` STRING COMMENT 'Material composition of the conduit housing the fiber cable. HDPE (High-Density Polyethylene) is standard for modern installations. Null for non-conduit deployments.. Valid values are `hdpe|pvc|steel|concrete|fiberglass`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiber cable inventory record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost. Supports multi-currency asset tracking for international operations.. Valid values are `^[A-Z]{3}$`',
    `deployment_method` STRING COMMENT 'Installation technique used for the fiber cable segment. Determines maintenance procedures, access requirements, and environmental exposure.. Valid values are `buried|aerial|conduit|underwater|building_riser|microtrenching`',
    `end_location_gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the cable segment ending point in decimal degrees. Used for GIS mapping and field dispatch.',
    `end_location_gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the cable segment ending point in decimal degrees. Used for GIS mapping and field dispatch.',
    `environmental_zone` STRING COMMENT 'Classification of the deployment environment affecting cable specifications and maintenance requirements. Coastal zones require corrosion-resistant materials, mountainous terrain affects accessibility.. Valid values are `urban|suburban|rural|industrial|coastal|mountainous`',
    `fiber_count` STRING COMMENT 'Total number of individual optical fibers contained within the cable. Critical for capacity planning and strand-level inventory management.',
    `fire_rating` STRING COMMENT 'Fire safety classification of the cable sheath. OFNR (Optical Fiber Non-conductive Riser), OFNP (Plenum), OFCP (Conductive Plenum), LSZH (Low Smoke Zero Halogen). Required for building code compliance.. Valid values are `ofnr|ofnp|ofcp|lszh|standard`',
    `installation_date` DATE COMMENT 'Date when the fiber cable segment was physically installed and made operational. Used for warranty tracking, depreciation calculations, and lifecycle management.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical or optical inspection of the cable segment. Used for preventive maintenance scheduling and compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fiber cable inventory record. Used for change tracking and data quality monitoring.',
    `maintenance_responsibility` STRING COMMENT 'Entity responsible for ongoing maintenance and repair of the fiber cable segment. Determines escalation procedures and cost allocation for fault resolution.. Valid values are `internal|contractor|municipal|joint|third_party`',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers catalog or part number for the specific cable model. Used for procurement, spare parts ordering, and technical specification lookup.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on maintenance policies and regulatory requirements. Used for work order planning.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, historical incidents, or unique characteristics of the cable segment not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the fiber cable segment. In-service indicates active use, available for new provisioning, reserved for planned deployment, under construction during installation, maintenance during repair, damaged requiring attention, retired for decommissioned assets. [ENUM-REF-CANDIDATE: in_service|available|reserved|under_construction|maintenance|damaged|retired — 7 candidates stripped; promote to reference product]',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the fiber asset. IRU (Indefeasible Right of Use) represents long-term lease rights. Critical for asset management and financial reporting.. Valid values are `owned|leased|iru|municipal|joint_build`',
    `right_of_way_permit_number` STRING COMMENT 'Government or municipal permit number authorizing the cable installation in public or private right-of-way. Required for regulatory compliance and audit trails.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `route_length_meters` DECIMAL(18,2) COMMENT 'Physical length of the fiber cable segment measured in meters along the deployment route. Used for attenuation calculations and material inventory.',
    `sheath_type` STRING COMMENT 'Outer protective jacket material of the fiber cable. Determines environmental resistance, fire safety compliance, and installation method suitability.. Valid values are `polyethylene|pvc|lszh|armored|gel_filled|dry_core`',
    `splice_point_count` STRING COMMENT 'Number of splice enclosures or splice points along this cable segment. Each splice introduces potential signal loss and maintenance access points.',
    `start_location_gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the cable segment starting point in decimal degrees. Used for GIS mapping and field dispatch.',
    `start_location_gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the cable segment starting point in decimal degrees. Used for GIS mapping and field dispatch.',
    `temperature_rating_max_celsius` STRING COMMENT 'Maximum operating temperature in Celsius for the fiber cable. Critical for deployments in extreme climates to ensure signal integrity.',
    `temperature_rating_min_celsius` STRING COMMENT 'Minimum operating temperature in Celsius for the fiber cable. Critical for deployments in extreme climates to ensure signal integrity.',
    CONSTRAINT pk_fiber_cable PRIMARY KEY(`fiber_cable_id`)
) COMMENT 'Master record for fiber optic cable segments and conduit/duct infrastructure in the outside plant (OSP). Cable attributes: cable type (single-mode/multi-mode/ribbon), fiber count, sheath type, route length, attenuation measurements, splice point references, and strand-level capacity summary. Conduit/duct attributes: duct ID, material type, inner diameter, route segment, total length, fill ratio, associated cable IDs, installation date, and ownership (owned/leased/municipal). Common attributes: route geometry (GPS coordinates), installation date, deployment method (burial/aerial/conduit), ownership type (owned/leased/IRU/municipal), and route segment identification. SSOT for all physical fiber plant and duct infrastructure inventory supporting OSP capacity planning and fiber rollout project management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` (
    `fiber_splice_id` BIGINT COMMENT 'Unique identifier for the fiber splice point or splice closure record. Primary key for the fiber splice entity.',
    `geo_point_id` BIGINT COMMENT 'Foreign key linking to location.geo_point. Business justification: Fiber splices occur at precise surveyed geographic points. Essential for outside plant management, fault localization, and splice closure maintenance. Normalizes denormalized location attributes into ',
    `technician_id` BIGINT COMMENT 'Identifier of the field technician who performed the splice installation. Used for quality tracking, workforce performance analysis, and accountability.',
    `work_order_id` BIGINT COMMENT 'Work order number under which the splice installation was performed. Links splice records to field service management and project tracking systems.',
    `fiber_cable_id` BIGINT COMMENT 'Identifier of the fiber cable segment on the A-side (incoming) of the splice. Used for end-to-end fiber path tracing and fault isolation.',
    `splice_closure_id` BIGINT COMMENT 'Business identifier for the physical splice closure enclosure housing the fiber splice. Used for field operations and asset tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `a_side_fiber_number` STRING COMMENT 'Fiber strand number within the A-side cable that is spliced. Used for detailed fiber pair mapping and circuit tracing.',
    `b_side_fiber_number` STRING COMMENT 'Fiber strand number within the B-side cable that is spliced. Used for detailed fiber pair mapping and circuit tracing.',
    `closure_capacity` STRING COMMENT 'Maximum number of fiber splices that the closure enclosure can accommodate. Used for capacity planning and future expansion analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiber splice record was first created in the inventory system. Used for data lineage and audit trail.',
    `environmental_seal_status` STRING COMMENT 'Integrity status of the splice closure environmental seal. Compromised seals can allow moisture ingress and degrade splice performance.. Valid values are `sealed|compromised|open|unknown`',
    `fiber_pairs_spliced` STRING COMMENT 'Number of individual fiber pairs joined at this splice point. Critical for capacity planning and network topology documentation.',
    `insertion_loss_db` DECIMAL(18,2) COMMENT 'Measured optical power loss at the splice point in decibels (dB). Lower values indicate better splice quality. Typical fusion splice loss is 0.02-0.10 dB; mechanical splice loss is 0.10-0.50 dB.',
    `inspection_result` STRING COMMENT 'Outcome of the last inspection or quality test. Passed indicates splice meets performance standards; failed indicates remediation required; warning indicates degraded performance.. Valid values are `passed|failed|warning|not_tested`',
    `installation_date` DATE COMMENT 'Date when the fiber splice was physically installed and tested. Used for warranty tracking, maintenance scheduling, and asset lifecycle management.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical or optical inspection of the splice. Used for preventive maintenance scheduling and compliance with network quality standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiber splice record was last updated in the inventory system. Used for change tracking and data quality monitoring.',
    `location_type` STRING COMMENT 'Type of physical location where the splice closure is installed. Critical for Outside Plant (OSP) and Inside Plant (ISP) asset management and field dispatch planning.. Valid values are `manhole|pole|pedestal|building|cabinet|vault`',
    `network_segment` STRING COMMENT 'Segment of the fiber network topology where the splice is located. Feeder connects central office to distribution; distribution connects to customer drops; backbone connects major nodes.. Valid values are `feeder|distribution|drop|backbone|metro|long_haul`',
    `notes` STRING COMMENT 'Free-text field for technician observations, special conditions, or additional context about the splice installation or maintenance history.',
    `plant_type` STRING COMMENT 'Classification of the fiber plant environment. OSP (Outside Plant) refers to outdoor infrastructure; ISP (Inside Plant) refers to indoor infrastructure. Critical for maintenance planning and environmental specifications.. Valid values are `OSP|ISP`',
    `protection_scheme` STRING COMMENT 'Network redundancy or protection mechanism applied to circuits passing through this splice. 1+1 indicates active backup; ring indicates self-healing topology.. Valid values are `unprotected|1_plus_1|1_colon_1|ring|mesh`',
    `record_source_system` STRING COMMENT 'Name of the operational system that is the authoritative source for this splice record (e.g., Oracle OSM, Netcracker). Used for data lineage and system integration management.',
    `reflectance_db` DECIMAL(18,2) COMMENT 'Optical return loss or back-reflection at the splice point in decibels (dB). Higher negative values indicate better performance. Typical fusion splice reflectance is -60 dB or better.',
    `service_impact_level` STRING COMMENT 'Business criticality of the splice based on the number and type of services it supports. Critical splices affect large customer populations or high-value enterprise circuits.. Valid values are `critical|high|medium|low`',
    `splice_status` STRING COMMENT 'Current operational status of the fiber splice in the network lifecycle. Active indicates in-service; planned indicates design phase; failed indicates quality test failure.. Valid values are `active|inactive|planned|under_test|failed|retired`',
    `splice_tray_position` STRING COMMENT 'Physical tray or slot position within the splice closure where this splice is located. Used for physical inventory and maintenance procedures.',
    `splice_type` STRING COMMENT 'Type of fiber splice technique used. Fusion splices use heat to fuse fibers; mechanical splices use alignment fixtures; ribbon splices join multiple fibers simultaneously.. Valid values are `fusion|mechanical|ribbon|mass_fusion|pigtail|fanout`',
    `test_wavelength_nm` STRING COMMENT 'Optical wavelength in nanometers at which insertion loss and reflectance were measured. Common values are 1310 nm and 1550 nm for single-mode fiber.',
    CONSTRAINT pk_fiber_splice PRIMARY KEY(`fiber_splice_id`)
) COMMENT 'Master record for fiber splice points and splice closures in the OSP/ISP fiber plant. Tracks splice closure ID, location (manhole/pole/building), splice type (fusion/mechanical), fiber pairs spliced, insertion loss measurements, installation date, technician ID, and associated cable segments. Essential for fiber plant traceability and fault isolation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` (
    `ip_address_pool_id` BIGINT COMMENT 'Unique identifier for the IP address pool resource. Primary key for the pool entity.',
    `element_id` BIGINT COMMENT 'Reference to the network device managing this pool (BNG, BRAS, leaf switch, DHCP server). Links pool to physical infrastructure.',
    `parent_pool_ip_address_pool_id` BIGINT COMMENT 'Reference to parent pool if this is a sub-pool carved from a larger allocation. Enables hierarchical pool management and delegation.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: IP address pools allocated by service territory for regional routing policies, CGNAT deployment, and network planning. Enables territory-based IP resource management and supports regional network arch',
    `allocation_policy` STRING COMMENT 'Strategy for assigning resources from this pool. Sequential for ordered assignment, random for load distribution, least-used for utilization balancing.. Valid values are `sequential|random|round_robin|least_used|geographic|service_based`',
    `assigned_count` BIGINT COMMENT 'Current number of resources actively assigned from this pool. Updated in near-real-time as assignments and releases occur.',
    `assignment_scope` STRING COMMENT 'Type of entity that resources from this pool are assigned to. Subscriber for end-user accounts, CPE for customer equipment, network node for infrastructure.. Valid values are `subscriber|cpe|network_node|service_instance|iot_device|mobile_device`',
    `available_count` BIGINT COMMENT 'Current number of unassigned resources available for allocation. Calculated as total_capacity minus assigned_count minus reserved_count.',
    `cgnat_ratio` STRING COMMENT 'Number of subscribers sharing each public IP address in CGNAT pools. Typical ratios range from 16:1 to 256:1 depending on service type and usage patterns.',
    `cidr_block` STRING COMMENT 'CIDR notation for IP address pools (e.g., 10.0.0.0/16 for IPv4, 2001:db8::/32 for IPv6). Null for non-IP resource types.',
    `cost_center` STRING COMMENT 'Financial cost center code for charging pool-related expenses (IP address leasing fees, equipment costs). Used for chargeback and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pool record was first created in the system. Part of standard audit trail for resource lifecycle tracking.',
    `default_lease_duration_hours` STRING COMMENT 'Default lease duration in hours for dynamic assignments from this pool. Applies to DHCP leases and temporary allocations. Null for static pools.',
    `effective_end_date` DATE COMMENT 'Date when this pool is scheduled to be retired or decommissioned. Null for pools with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this pool becomes active and available for resource assignment. Used for planned pool activations and migrations.',
    `encapsulation_type` STRING COMMENT 'Network encapsulation protocol used for this resource pool. 802.1Q for single VLAN tagging, QinQ for double tagging, VXLAN for overlay networks, EVPN for BGP-based VPN.. Valid values are `dot1q|qinq|vxlan|evpn|mpls|gre`',
    `geographic_region` STRING COMMENT 'Geographic region or market where this pool is deployed (e.g., Northeast, California, EMEA). Used for regional resource planning and compliance.',
    `high_watermark_threshold` DECIMAL(18,2) COMMENT 'Utilization percentage threshold that triggers capacity alerts. Typically 80-90% to allow time for pool expansion before depletion.',
    `ip_version` STRING COMMENT 'IP protocol version for address pools. IPv4 for legacy networks, IPv6 for modern deployments, dual-stack for transition scenarios.. Valid values are `ipv4|ipv6|dual_stack`',
    `is_cgnat_enabled` BOOLEAN COMMENT 'Indicates whether this pool is used for CGNAT (Carrier-Grade NAT) to share public IPs across multiple subscribers. Common for IPv4 conservation.',
    `is_lawful_intercept_enabled` BOOLEAN COMMENT 'Indicates whether assignments from this pool are subject to lawful intercept logging and monitoring requirements per regulatory mandates.',
    `is_public_routable` BOOLEAN COMMENT 'Indicates whether IP addresses in this pool are publicly routable on the internet (true) or private/RFC1918 addresses (false).',
    `last_assignment_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent resource assignment from this pool. Used for activity tracking and idle pool identification.',
    `last_release_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent resource release back to this pool. Used for churn analysis and capacity reclamation tracking.',
    `low_watermark_threshold` DECIMAL(18,2) COMMENT 'Utilization percentage threshold below which the pool is considered underutilized. Used for resource optimization and consolidation decisions.',
    `modified_by` STRING COMMENT 'User ID or system identifier that last modified this pool record. Used for change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pool record was last modified. Updated whenever pool attributes, capacity, or configuration changes.',
    `network_zone` STRING COMMENT 'Network architecture layer where this pool is deployed. Core for backbone, edge for distribution, access for last-mile, data center for cloud services. [ENUM-REF-CANDIDATE: core|edge|access|aggregation|metro|data_center|customer_premises — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-form operational notes and comments about this pool. Used for documenting special configurations, migration plans, or operational considerations.',
    `pool_code` STRING COMMENT 'Unique business identifier or code for the pool, used in operational systems and external references.',
    `pool_name` STRING COMMENT 'Human-readable name or label for the IP address pool, used for identification and operational reference.',
    `pool_owner` STRING COMMENT 'Business unit, department, or team responsible for managing this pool. Used for accountability and operational ownership.',
    `pool_status` STRING COMMENT 'Current lifecycle status of the pool. Active pools are available for assignment, depleted pools have no available resources, quarantined pools are temporarily blocked.. Valid values are `active|reserved|depleted|retired|quarantined|planned`',
    `regulatory_classification` STRING COMMENT 'Regulatory designation for this pool. Lawful intercept pools require logging for law enforcement, emergency services pools have priority routing requirements.. Valid values are `public|lawful_intercept_required|emergency_services|critical_infrastructure`',
    `reserved_count` BIGINT COMMENT 'Number of resources reserved for future use or specific purposes (e.g., network infrastructure, management, emergency services).',
    `resource_type` STRING COMMENT 'Type of logical network resource managed by this pool. Distinguishes between IP address pools, VLAN segment pools, VXLAN pools, and CGNAT ranges.. Valid values are `ipv4_subnet|ipv6_subnet|vlan_range|vxlan_range|cgnat_pool|dhcp_scope`',
    `routing_domain` STRING COMMENT 'Routing domain or VRF (Virtual Routing and Forwarding) instance this pool belongs to. Enables network segmentation and multi-tenancy.',
    `service_type` STRING COMMENT 'Business service category this pool is dedicated to. Enables service-based segmentation of network resources for QoS and billing purposes. [ENUM-REF-CANDIDATE: residential|enterprise|wholesale|management|voice|iot|mobile_backhaul — 7 candidates stripped; promote to reference product]',
    `total_capacity` BIGINT COMMENT 'Maximum number of assignable resources in this pool. For IP pools, count of usable addresses; for VLAN pools, count of VLAN IDs.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Current utilization rate of the pool, calculated as (assigned_count / total_capacity) * 100. Used for capacity planning and threshold alerting.',
    `vlan_range_end` STRING COMMENT 'Ending VLAN ID for VLAN pool resources. Must be greater than or equal to vlan_range_start. Null for non-VLAN resource types.',
    `vlan_range_start` STRING COMMENT 'Starting VLAN ID for VLAN pool resources. Valid range 1-4094 per IEEE 802.1Q. Null for non-VLAN resource types.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this pool record. Used for audit trail and accountability.',
    CONSTRAINT pk_ip_address_pool PRIMARY KEY(`ip_address_pool_id`)
) COMMENT 'Master record for logical network resource pools and their individual assignments. Covers IP address pools (IPv4/IPv6 subnets, CGNAT ranges), VLAN/VXLAN segment pools, and individual resource assignment transactions. Pool-level attributes: CIDR block, VLAN range, encapsulation type (802.1Q/QinQ/VXLAN/EVPN), allocation policy, associated BNG/BRAS or leaf switch, service type segmentation (residential/enterprise/wholesale/management/voice), utilization tracking, and maximum capacity. Assignment-level attributes: assigned IP or VLAN, assignment type (static/dynamic/DHCP), assignment start/end timestamps, lease duration, assigned-to entity (subscriber/CPE/network node), and release reason. SSOT for all logical network resource inventory and assignment lifecycle supporting broadband provisioning, enterprise VPN, IMS voice, and wholesale services. Managed via Netcracker.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` (
    `msisdn_range_id` BIGINT COMMENT 'Unique identifier for the MSISDN or DID number range record. Primary key for the number range inventory.',
    `mnp_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.mnp_compliance. Business justification: Mobile Number Portability compliance tracking requires linking ported numbers to their allocated MSISDN ranges for regulatory reporting, dispute resolution, and audit trails. MNP compliance audits ver',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: MSISDN ranges allocated to MVNO partners for their subscriber base. Critical business processes: wholesale number allocation, MVNO billing, number portability coordination, regulatory compliance repor',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: MSISDN ranges allocated by service territory for local number portability, geographic number assignment policies, and regulatory reporting. Essential for number resource management and porting operati',
    `activation_date` DATE COMMENT 'Date when this number range was activated and made available for assignment to subscribers or services.',
    `allocation_authority` STRING COMMENT 'Name of the regulatory body or numbering authority that allocated this number range to the operator.',
    `allocation_date` DATE COMMENT 'Date when this number range was officially allocated to the telecommunications operator by the regulatory authority.',
    `assigned_count` BIGINT COMMENT 'Current count of numbers from this range that have been assigned to subscribers or services.',
    `available_count` BIGINT COMMENT 'Current count of numbers from this range that are available for new assignment. Excludes quarantined and reserved numbers.',
    `block_size` STRING COMMENT 'Standard block size or increment in which numbers from this range are typically allocated or reserved for operational efficiency.',
    `cost_per_number` DECIMAL(18,2) COMMENT 'Regulatory fee or cost per individual number in this range charged by the numbering authority for allocation and maintenance.',
    `country_code` STRING COMMENT 'ITU-T E.164 country calling code for the number range. Identifies the country or geographic region of the number allocation.. Valid values are `^[0-9]{1,3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this number range record was first created in the inventory management system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for cost per number and related financial attributes.. Valid values are `^[A-Z]{3}$`',
    `end_number` STRING COMMENT 'The last MSISDN or DID number in the allocated range. Must comply with ITU-T E.164 international numbering format.. Valid values are `^[0-9]{8,15}$`',
    `expiration_date` DATE COMMENT 'Date when the regulatory allocation of this number range expires and must be renewed or returned to the numbering authority.',
    `geographic_region` STRING COMMENT 'Geographic region or service area associated with this number range for routing and billing purposes.',
    `hlr_reference` STRING COMMENT 'Identifier of the Home Location Register or Home Subscriber Server (HSS) system where subscriber records for this number range are stored.',
    `last_assignment_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent number assignment transaction from this range to a subscriber or service.',
    `last_deallocation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent number deallocation or return transaction from a subscriber back to available inventory.',
    `ndc` STRING COMMENT 'National destination code or area code portion of the number range. Used for geographic or network routing within the country.. Valid values are `^[0-9]{1,5}$`',
    `network_operator_code` STRING COMMENT 'Code identifying the network operator or Mobile Virtual Network Operator (MVNO) to which this range is assigned.. Valid values are `^[A-Z0-9]{3,10}$`',
    `notes` STRING COMMENT 'Additional operational notes, comments, or administrative information about this number range for internal reference.',
    `number_format_mask` STRING COMMENT 'Display format mask or template for presenting numbers from this range to end users in customer-facing systems and billing documents.',
    `porting_eligible_flag` BOOLEAN COMMENT 'Indicates whether numbers in this range are eligible for mobile number portability per national MNP regulations.',
    `quarantine_period_days` STRING COMMENT 'Mandatory cooling-off period in days that numbers from this range must remain quarantined after deallocation before becoming available for reassignment per regulatory requirements.',
    `quarantined_count` BIGINT COMMENT 'Count of numbers in quarantine status awaiting release per regulatory cooling-off period after deallocation.',
    `range_code` STRING COMMENT 'Business identifier code for the number range allocation. Used for external reference and operational tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `range_status` STRING COMMENT 'Current lifecycle status of the number range indicating its availability and operational state.. Valid values are `allocated|active|reserved|quarantined|retired|pending_allocation`',
    `range_type` STRING COMMENT 'Classification of the number range indicating its purpose and usage category within the telecommunications network.. Valid values are `msisdn|did|toll_free|premium|short_code|emergency`',
    `regulatory_allocation_reference` STRING COMMENT 'Reference number or identifier from the national regulatory authority documenting the official allocation of this number range to the operator.',
    `reserved_count` BIGINT COMMENT 'Count of numbers reserved for specific purposes such as VIP customers, corporate accounts, or regulatory requirements.',
    `routing_prefix` STRING COMMENT 'Network routing prefix used for call routing and signaling for numbers in this range within the telecommunications infrastructure.. Valid values are `^[0-9]{1,6}$`',
    `service_type` STRING COMMENT 'Primary service type or technology platform that numbers in this range are designated to support.. Valid values are `mobile|fixed_line|voip|iot|m2m|emergency`',
    `source_system` STRING COMMENT 'Name of the operational system of record that is the authoritative source for this number range data. Typically Oracle OSM Resource Inventory or Netcracker.',
    `special_conditions` STRING COMMENT 'Free-text description of any special regulatory conditions, restrictions, or usage requirements imposed on this number range by the numbering authority.',
    `start_number` STRING COMMENT 'The first MSISDN or DID number in the allocated range. Must comply with ITU-T E.164 international numbering format.. Valid values are `^[0-9]{8,15}$`',
    `total_capacity` BIGINT COMMENT 'Total count of individual numbers available within this range from start to end number inclusive.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this number range record was last modified in the inventory management system.',
    `usage_category` STRING COMMENT 'Business classification indicating the intended customer segment or usage purpose for numbers in this range.. Valid values are `consumer|business|government|wholesale|test`',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of numbers in this range currently assigned to subscribers or services relative to total capacity. Key performance indicator for number resource management.',
    CONSTRAINT pk_msisdn_range PRIMARY KEY(`msisdn_range_id`)
) COMMENT 'Master record for MSISDN (Mobile Subscriber ISDN Number) and DID (Direct Inward Dialing) number ranges and their individual number assignment transactions. Range-level attributes: start/end number, country code, NDC, range type, regulatory allocation reference, porting eligibility, and available count. Assignment-level attributes: specific number assigned, subscriber reference, assignment date, service type, porting status (MNP port-in/port-out), quarantine release date, deallocation reason, and assignment lifecycle timestamps. SSOT for all number resource inventory, assignment lifecycle, and MNP compliance per ITU-T E.164 and national MNP regulations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` (
    `spectrum_allocation_id` BIGINT COMMENT 'Primary key for spectrum_allocation',
    `administrative_region_id` BIGINT COMMENT 'Foreign key linking to location.administrative_region. Business justification: Spectrum licenses are jurisdiction-specific by regulatory authority. Required for coverage obligation tracking, regulatory compliance reporting, and spectrum valuation by region. Fundamental to wirele',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Spectrum licenses require designated compliance officer for regulatory reporting, coverage obligation tracking, license renewal management, and interference coordination with regulatory authorities.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Spectrum licenses are intangible fixed assets capitalized at acquisition cost and amortized over license term. Critical for balance sheet valuation, amortization expense calculation, and regulatory fi',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Spectrum sharing arrangements with MVNO partners or spectrum leasing agreements. Business processes: MVNO spectrum access rights management, spectrum trading/leasing revenue tracking, regulatory repor',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Spectrum allocations represent operational use of licensed spectrum bands. Compliance audits, renewal tracking, and regulatory filings require linking operational allocations to their underlying regul',
    `acquisition_method` STRING COMMENT 'The method by which the operator acquired this spectrum allocation. Includes competitive auction, administrative assignment by regulator, secondary market purchase, lease from another operator, or acquisition through merger/acquisition.. Valid values are `auction|administrative_assignment|secondary_market|lease|merger_acquisition`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the spectrum allocation. Indicates whether the spectrum is actively in use, reserved for future deployment, expired and requiring renewal, or surrendered back to the regulator.. Valid values are `active|reserved|expired|pending_renewal|surrendered|suspended`',
    `annual_license_fee_usd` DECIMAL(18,2) COMMENT 'The recurring annual fee paid to the regulatory authority to maintain this spectrum license, measured in USD. Part of operational expenditure (OPEX) for spectrum management.',
    `assigned_ran_nodes_count` STRING COMMENT 'The number of RAN nodes (cell sites, base stations, gNodeBs, eNodeBs) currently configured to use this spectrum allocation. Indicates the deployment scale and utilization of the spectrum asset.',
    `bandwidth_mhz` DECIMAL(18,2) COMMENT 'The total bandwidth allocated in megahertz (MHz). Represents the spectrum capacity available for network deployment and service delivery.',
    `coverage_deadline_date` DATE COMMENT 'The date by which the operator must meet the regulatory coverage obligations for this spectrum allocation. Failure to meet this deadline may result in penalties or license revocation.',
    `coverage_obligation` STRING COMMENT 'Description of any regulatory coverage obligations or build-out requirements attached to this spectrum license. May specify population coverage percentages, geographic milestones, or deployment timelines mandated by the licensing authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this spectrum allocation record was first created in the system. Used for audit trail and data lineage tracking.',
    `deployment_priority` STRING COMMENT 'The strategic priority assigned to deploying network infrastructure on this spectrum allocation. Critical and high priority spectrum is targeted for immediate rollout, while low or deferred spectrum may be held for future use or strategic reserve.. Valid values are `critical|high|medium|low|deferred`',
    `duplex_mode` STRING COMMENT 'The duplexing method used for this spectrum allocation. FDD (Frequency Division Duplex) uses paired spectrum for uplink and downlink, TDD (Time Division Duplex) uses unpaired spectrum, SDL (Supplemental Downlink) is downlink-only, SUL (Supplemental Uplink) is uplink-only.. Valid values are `FDD|TDD|SDL|SUL`',
    `emission_mask_designation` STRING COMMENT 'The technical emission mask or out-of-band emission limits that apply to this spectrum allocation. Defines the allowable power spectral density outside the allocated frequency block to prevent interference.',
    `frequency_range_lower_mhz` DECIMAL(18,2) COMMENT 'The lower bound of the frequency range allocated, measured in megahertz. Defines the starting frequency of the spectrum block.',
    `frequency_range_upper_mhz` DECIMAL(18,2) COMMENT 'The upper bound of the frequency range allocated, measured in megahertz. Defines the ending frequency of the spectrum block.',
    `geographic_license_area` STRING COMMENT 'The geographic region or administrative area covered by this spectrum license. May be national, regional, or specific market areas (e.g., Major Trading Area, Economic Area, county-level).',
    `interference_coordination_zone` STRING COMMENT 'Geographic zone or identifier for interference coordination with adjacent operators or cross-border spectrum users. Used to manage interference mitigation and comply with international coordination agreements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this spectrum allocation record was last updated. Supports change tracking and audit compliance.',
    `license_expiry_date` DATE COMMENT 'The date when the spectrum license expires and must be renewed or surrendered. Critical for regulatory compliance and spectrum asset planning.',
    `license_issue_date` DATE COMMENT 'The date when the spectrum license was originally issued by the regulatory authority. Marks the beginning of the license validity period.',
    `license_renewal_status` STRING COMMENT 'Current status of any license renewal application or process. Tracks whether the operator has applied for renewal, whether the renewal has been approved or denied, or if it is under regulatory review.. Valid values are `not_applicable|pending|approved|denied|in_review`',
    `license_type` STRING COMMENT 'The type of spectrum license granted. Exclusive licenses provide sole use rights, shared licenses allow multiple operators, light-licensed spectrum has simplified authorization, and unlicensed spectrum is available for general use under technical rules.. Valid values are `exclusive|shared|unlicensed|light_licensed`',
    `maximum_eirp_dbm` DECIMAL(18,2) COMMENT 'The maximum effective isotropic radiated power permitted for transmissions on this spectrum allocation, measured in dBm. Regulatory limit to control interference and ensure spectrum coexistence.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this spectrum allocation. May include details on regulatory waivers, coordination agreements, or internal planning remarks.',
    `record_source_system` STRING COMMENT 'The name of the source system or module from which this spectrum allocation record originated. Typically Oracle OSM Resource Inventory or Netcracker Resource Catalog for spectrum asset management.',
    `regulatory_authority` STRING COMMENT 'The government or international body that issued and governs this spectrum license. Examples include FCC (Federal Communications Commission - US), Ofcom (UK), BEREC (EU), ITU (International), NTIA (US federal spectrum), ACMA (Australia), CRTC (Canada). [ENUM-REF-CANDIDATE: FCC|Ofcom|BEREC|ITU|NTIA|ACMA|CRTC|other — 8 candidates stripped; promote to reference product]',
    `spectrum_band` STRING COMMENT 'The radio frequency band allocated for use. Common bands include 700MHz, 1800MHz, 2600MHz for LTE and 3.5GHz, 26GHz, 28GHz for 5G NR deployments.. Valid values are `700MHz|800MHz|900MHz|1800MHz|2100MHz|2600MHz|3.5GHz|26GHz|28GHz|39GHz`',
    `spectrum_efficiency_target` DECIMAL(18,2) COMMENT 'The target spectral efficiency for this allocation, measured in bits per second per hertz (bps/Hz). Represents the data throughput goal per unit of spectrum bandwidth, used for network planning and performance benchmarking.',
    `spectrum_sharing_arrangement` STRING COMMENT 'Indicates if this spectrum is subject to sharing arrangements. CBRS (Citizens Broadband Radio Service) is a three-tier shared spectrum framework in the US, LSA (Licensed Shared Access) is used in Europe, DSS (Dynamic Spectrum Sharing) allows LTE and 5G coexistence, and roaming agreements enable spectrum sharing with other operators.. Valid values are `none|CBRS|LSA|DSS|roaming_agreement`',
    `spectrum_trading_allowed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this spectrum allocation is permitted to be traded, leased, or transferred to another operator under regulatory rules. True if trading is allowed, false if the license is non-transferable.',
    `technology_use` STRING COMMENT 'The radio access technology (RAT) for which this spectrum is designated or currently deployed. Includes LTE (Long-Term Evolution), 5G NR (5G New Radio), NB-IoT (Narrowband IoT), LTE-M, and DSS (Dynamic Spectrum Sharing). [ENUM-REF-CANDIDATE: LTE|5G_NR|NB_IoT|GSM|UMTS|LTE_M|mmWave|DSS — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_spectrum_allocation PRIMARY KEY(`spectrum_allocation_id`)
) COMMENT 'Master record for radio frequency spectrum allocations held by the operator. Captures spectrum band (700MHz/1800MHz/2600MHz/3.5GHz/mmWave), bandwidth (MHz), geographic license area, regulatory license number, license expiry date, technology use (LTE/5G NR/NB-IoT), assigned RAN nodes, and spectrum sharing arrangements. SSOT for spectrum asset inventory per FCC/Ofcom/ITU licensing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique identifier for the spare part record. Primary key for the spare part inventory master.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Spare parts are often cataloged items sold as accessories (replacement batteries, chargers, cases). Links inventory to product catalog for retail sales, warranty replacement cost tracking, and revenue',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spare parts inventory carrying costs and consumption are allocated to cost centers for maintenance budget tracking and inventory expense management. Enables cost center managers to control spare parts',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Spare parts inventory requires assigned custodian for cycle count accountability, stock issuance approval, reorder authorization, and audit trail compliance in regulated telecom environment.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Spare parts support specific device models (batteries for iPhone 13, power supplies for Cisco ASR routers). Critical for maintenance operations, inventory planning, warranty fulfillment, and field ser',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Tracking which technician received spare parts supports inventory accountability, usage pattern analysis, and parts consumption reporting—critical for inventory management and cost control in field op',
    `partner_id` BIGINT COMMENT 'Identifier of the primary vendor or supplier for this spare part.',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Spare parts inventory is stored at facilities (warehouses, service centers, staging areas). Currently storage_location_code is a STRING; replacing with FK to pop_facility provides full facility contex',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Spare parts inventory distributed by service territory for dispatch time optimization, regional stock planning, and technician van stock allocation. Standard field service inventory management practic',
    `abc_classification` STRING COMMENT 'ABC analysis classification based on consumption value and criticality. A-items are high-value/high-usage, C-items are low-value/low-usage.. Valid values are `A|B|C`',
    `annual_consumption_quantity` DECIMAL(18,2) COMMENT 'Total quantity consumed or issued in the last 12 months. Used for demand forecasting and inventory optimization.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity available for issue or allocation, calculated as current stock minus reserved/allocated quantities.',
    `batch_tracking_flag` BOOLEAN COMMENT 'Indicates whether this spare part is tracked by batch or lot numbers for quality control and traceability.',
    `bin_location` STRING COMMENT 'Specific bin, shelf, or rack location within the storage facility for physical inventory management (e.g., A-12-03, Rack-5-Shelf-2).',
    `compatible_equipment_models` STRING COMMENT 'Comma-separated list or description of equipment models that this spare part is compatible with (e.g., Nokia AirScale 5G RAN, Ericsson RBS 6000, Huawei OLT MA5800).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spare part record was first created in the inventory system.',
    `criticality_level` STRING COMMENT 'Business criticality classification indicating the impact of stockouts on network operations and service delivery (critical parts require higher stock levels and faster replenishment).. Valid values are `critical|high|medium|low`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_stock_quantity` DECIMAL(18,2) COMMENT 'Current on-hand quantity of this spare part across all storage locations. Updated in real-time with receipts, issues, and transfers.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the spare part is classified as hazardous material requiring special handling, storage, or disposal procedures.',
    `hazmat_class` STRING COMMENT 'Classification code for hazardous materials (e.g., UN number, DOT hazard class) if hazardous_material_flag is true.',
    `last_issue_date` DATE COMMENT 'Date when this spare part was last issued from inventory for a work order or maintenance activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this spare part record was last updated or modified.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count for this spare part.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order or receipt for this spare part.',
    `last_purchase_order_number` STRING COMMENT 'Most recent purchase order number used to procure this spare part. Used for procurement history tracking.',
    `lead_time_days` STRING COMMENT 'Average number of days from purchase order placement to receipt of the spare part. Used for inventory planning and reorder calculations.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or original equipment manufacturer (OEM) that produces this spare part.',
    `manufacturer_part_number` STRING COMMENT 'Original part number assigned by the manufacturer, which may differ from internal part_number.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum quantity threshold for inventory control. Prevents overstocking and excess capital tied up in inventory.',
    `minimum_stock_level` DECIMAL(18,2) COMMENT 'Minimum quantity threshold that triggers reorder alerts. Part of inventory optimization and replenishment planning.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or comments about this spare part.',
    `obsolescence_status` STRING COMMENT 'Lifecycle status indicating whether the part is actively used, being phased out, or obsolete. Drives inventory reduction and replacement planning.. Valid values are `active|phasing_out|obsolete|discontinued`',
    `part_category` STRING COMMENT 'High-level classification of the spare part type. Categories include RAN (Radio Access Network) components, fiber infrastructure components, power units, line cards, CPE (Customer Premises Equipment) spares, and other network equipment. [ENUM-REF-CANDIDATE: ran_component|fiber_component|power_equipment|line_card|cpe_hardware|network_equipment|optical_equipment|test_equipment|other — 9 candidates stripped; promote to reference product]',
    `part_description` STRING COMMENT 'Detailed technical description of the spare part including specifications, use case, and compatibility notes.',
    `part_name` STRING COMMENT 'Human-readable name or title of the spare part (e.g., Fiber Optic Connector LC/UPC, RAN Power Amplifier Module).',
    `part_number` STRING COMMENT 'Manufacturer-assigned unique part number or stock keeping unit (SKU) for the spare part. Used for catalog identification and procurement.. Valid values are `^[A-Z0-9]{6,20}$`',
    `part_subcategory` STRING COMMENT 'Detailed sub-classification within the part category (e.g., LC Connector, SC Connector, Power Amplifier, Antenna, ONT, OLT Module).',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a purchase requisition or order should be triggered to replenish stock before reaching minimum level.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to order when replenishing this spare part. May be based on economic order quantity (EOQ) calculations.',
    `replacement_part_number` STRING COMMENT 'Part number of the superseding or replacement spare part if this part is obsolete or discontinued.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity reserved or allocated for specific work orders, projects, or planned maintenance activities.',
    `serial_number_tracking_flag` BOOLEAN COMMENT 'Indicates whether individual units of this spare part are tracked by unique serial numbers for warranty, maintenance, and asset management.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the spare part can be stored before it expires or degrades. Null for non-perishable items.',
    `spare_part_status` STRING COMMENT 'Current operational status of the spare part in the inventory system. Blocked or restricted parts cannot be issued.. Valid values are `active|inactive|blocked|restricted`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of the spare part in the base currency. Used for inventory valuation and financial reporting.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory tracking and ordering (e.g., each for individual items, meter for fiber cable, box for bulk connectors). [ENUM-REF-CANDIDATE: each|box|meter|kilogram|liter|pair|set|roll — 8 candidates stripped; promote to reference product]',
    `vendor_part_number` STRING COMMENT 'Part number used by the vendor in their catalog, which may differ from internal and manufacturer part numbers.',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months provided by the manufacturer for this spare part.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for spare parts inventory including part catalog, stock levels, and all movement transactions. Catalog attributes: part number, manufacturer, compatible equipment models, reorder level, lead time, unit cost, hazardous material flag, shelf life. Stock attributes: current quantity per location, min/max levels, reorder status. Transaction attributes: movement type (receipt/issue/return/transfer/write-off), quantity, source/destination location (FK to pop_facility), associated work order, technician, cost, and timestamp. Covers RAN components, fiber connectors, power units, line cards, and CPE spares. SSOT for spare parts catalog, stock levels, and consumption tracking managed via SAP S/4HANA materials management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` (
    `asset_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the asset lifecycle event record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings often identify asset lifecycle control failures (missing assets, unauthorized disposals, inadequate tracking, custody violations). Remediation of audit findings requires linking to spec',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Asset movements between cost centers (transfers, relocations) trigger cost allocation entries for proper expense tracking. Required for accurate cost center reporting and inter-departmental cost alloc',
    `employee_id` BIGINT COMMENT 'Reference to the manager or authorized person who approved this lifecycle event. Nullable if approval was not required or is still pending.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Asset lifecycle events (capitalization, disposal, impairment, transfer) trigger journal entries for financial recording. Required for audit trail, financial statement accuracy, and compliance with acc',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the customer order or internal order that triggered this lifecycle event (e.g., service activation order, equipment procurement order). Nullable for non-order-driven events.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Asset lifecycle events (installation, removal, swap) at customer premises drive service fulfillment tracking and inventory reconciliation. Critical for CPE/ONT deployment reporting and premise service',
    `location_site_id` BIGINT COMMENT 'Reference to the stocking location, warehouse, or site where the asset was located before this event. Nullable if location did not change.',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: Spectrum licenses have lifecycle events (acquisition, renewal, expiration, regulatory changes) that should be tracked in asset_lifecycle_event. This FK allows tracking spectrum allocation lifecycle al',
    `technician_id` BIGINT COMMENT 'Reference to the field technician or workforce member who performed the lifecycle event (deployment, swap, repair). Nullable for automated or non-field events.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: When event_type=FAILURE or RETURN, links asset failure events to originating trouble tickets for root cause analysis, warranty claim substantiation, and vendor quality scorecards.',
    `work_order_id` BIGINT COMMENT 'Reference to the field service work order that triggered this lifecycle event (e.g., installation, repair, swap work order). Nullable for non-field-service events.',
    `actual_count` STRING COMMENT 'Actual quantity of assets found during the physical audit or cycle count. Applicable only for audit and reconciliation events.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether this lifecycle event required managerial or system approval before execution (e.g., write-off events typically require approval). True if approval was required, False otherwise.',
    `approval_status` STRING COMMENT 'Current approval status for this lifecycle event. Applicable only if approval_required is True.. Valid values are `pending|approved|rejected|not-required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event was approved. Nullable if approval was not required or is still pending. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `asset_category` STRING COMMENT 'Category or class of the asset involved in this event (e.g., CPE, ONT, OLT, fiber-cable, spare-part). Used for audit and reporting segmentation. [ENUM-REF-CANDIDATE: CPE|ONT|OLT|fiber-cable|network-equipment|spare-part|SIM|eSIM|test-equipment|tools — promote to reference product]',
    `asset_reference` BIGINT COMMENT 'Reference to the physical inventory asset (CPE, ONT, OLT, network equipment, fiber plant, spare parts) that this lifecycle event pertains to.',
    `audit_date` DATE COMMENT 'Date when a physical audit or cycle count was performed. Applicable only for event types: physical-audit, cycle-count, reconciliation. Format: yyyy-MM-dd.',
    `auditor_name` STRING COMMENT 'Name of the person or team who conducted the physical audit or cycle count. Applicable only for audit and reconciliation events.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event complies with regulatory or internal policy requirements (e.g., proper audit trail, authorized personnel, documented approval). True if compliant, False if non-compliant or flagged for review.',
    `cost_impact` DECIMAL(18,2) COMMENT 'Financial impact of this lifecycle event in the base currency (e.g., asset acquisition cost for procurement, write-off amount for decommission, repair cost). Nullable for non-financial events.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this lifecycle event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost_impact amount (e.g., USD, EUR, GBP). Nullable if cost_impact is null.. Valid values are `^[A-Z]{3}$`',
    `event_notes` STRING COMMENT 'Free-text notes or comments providing additional context about the lifecycle event (e.g., reason for swap, repair details, audit findings).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event occurred in the real world (e.g., when the asset was deployed, swapped, or decommissioned). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of lifecycle event. [ENUM-REF-CANDIDATE: procurement|deployment|swap|repair|decommission|write-off|physical-audit|cycle-count|reconciliation|relocation|upgrade|downgrade — promote to reference product]. Valid values are `procurement|deployment|swap|repair|decommission|write-off`',
    `expected_count` STRING COMMENT 'Expected quantity of assets at the audited location or category based on system records. Applicable only for audit and reconciliation events.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this lifecycle event record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `new_state` STRING COMMENT 'The asset state immediately after this lifecycle event occurred. Captures the to state in the state transition.. Valid values are `in-stock|deployed|in-transit|in-repair|decommissioned|written-off`',
    `previous_state` STRING COMMENT 'The asset state immediately before this lifecycle event occurred. Captures the from state in the state transition.. Valid values are `in-stock|deployed|in-transit|in-repair|decommissioned|written-off`',
    `reconciliation_action` STRING COMMENT 'Action taken to resolve the inventory variance (e.g., write-off for lost assets, adjustment to correct system records, investigation for unresolved discrepancies). Applicable only for reconciliation events.. Valid values are `write-off|adjustment|investigation|no-action`',
    `serial_number` STRING COMMENT 'Manufacturer serial number of the asset at the time of the event. Captured for traceability and audit purposes.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this lifecycle event record (e.g., Oracle OSM, Netcracker, SAP S/4HANA, ServiceNow). Used for data lineage and reconciliation.',
    `source_transaction_reference` STRING COMMENT 'Unique transaction or event identifier from the source system. Used for traceability and idempotency in data integration.',
    `variance_quantity` STRING COMMENT 'Difference between expected and actual count (actual_count minus expected_count). Positive indicates surplus, negative indicates shortage. Applicable only for audit and reconciliation events.',
    `variance_reason` STRING COMMENT 'Root cause or reason for the inventory variance identified during audit or reconciliation. Applicable only for audit and reconciliation events. [ENUM-REF-CANDIDATE: theft|damage|data-entry-error|unreported-deployment|unreported-return|obsolescence|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_asset_lifecycle_event PRIMARY KEY(`asset_lifecycle_event_id`)
) COMMENT 'Transactional record capturing all lifecycle state transitions, audit events, and inventory reconciliation activities for physical inventory assets (CPE, ONT, OLT, network equipment, fiber plant, spare parts). Event types: procurement, deployment, swap, repair, decommission, write-off, physical-audit, cycle-count, and reconciliation. Core attributes: event timestamp, previous/new asset state, triggering work order or order reference, technician, location change. For audit/reconciliation events: audit date, stocking location or asset category audited, auditor name, expected vs actual count, variance quantity, variance reason, and reconciliation action taken (write-off/adjustment/investigation). SSOT for full asset lifecycle audit trail and inventory accuracy reporting per TM Forum eTOM asset management process, SAP S/4HANA asset management, and regulatory compliance requirements.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`network_equipment` (
    `network_equipment_id` BIGINT COMMENT 'Unique identifier for the network equipment asset. Primary key for the network equipment master record.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Network equipment installations (core routers, switches, transmission gear) are capital projects. Linking enables project cost tracking, budget variance analysis, and ROI calculation for network infra',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Network equipment operational expenses (power, cooling, maintenance) are allocated to cost centers for budget tracking and expense control. Enables cost center managers to monitor network infrastructu',
    `device_model_id` BIGINT COMMENT 'Reference to the equipment model catalog entry defining technical specifications, manufacturer, and capabilities.',
    `exchange_id` BIGINT COMMENT 'Foreign key linking to location.exchange. Business justification: Network equipment deployed at telephone exchanges for PSTN, DSL, and broadband services. Essential for exchange capacity planning, technology migration tracking, and wholesale access reporting in tele',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Core network equipment (routers, switches, transmission gear) are capitalized assets tracked for depreciation, book value, and financial reporting. Required for accurate asset valuation and compliance',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Network equipment installation requires certified technicians. Tracking installer enables asset lifecycle accountability, warranty validation, and technician performance tracking—standard practice in ',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Equipment requires precise street address for logistics delivery, emergency response, regulatory compliance filings, and insurance. Complements site_id with address-level precision needed for legal an',
    `location_site_id` BIGINT COMMENT 'Reference to the physical site or Point of Presence (POP) facility where the equipment is installed.',
    `maintenance_contract_id` BIGINT COMMENT 'Reference to the active maintenance or support contract covering this equipment. Links to vendor SLA terms and support entitlements.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Network equipment has vendor relationships for support contracts, firmware updates, technical support. Business processes: maintenance contract management via maintenance_contract_id, vendor SLA track',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Network equipment (core, transport, access gear) is physically housed in POP facilities. Currently network_equipment has site_id → location.site (cross-domain), but pop_facility is the inventory domai',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Core and edge network equipment requires assigned engineer for configuration management, change control approval, incident response, and vendor escalation authority.',
    `site_id` BIGINT COMMENT 'FK to location.site.site_id — Network equipment assets must be locatable at their hosting site for asset management, spare parts logistics, and maintenance dispatch.',
    `administrative_status` STRING COMMENT 'Administrative control state indicating whether the equipment is permitted to provide service. UNLOCKED (allowed to operate), LOCKED (administratively disabled), SHUTTING_DOWN (graceful shutdown in progress).. Valid values are `UNLOCKED|LOCKED|SHUTTING_DOWN`',
    `asset_tag` STRING COMMENT 'Internal asset tracking identifier assigned by the organization for inventory management and physical audits. Typically a barcode or RFID tag.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `climate_control_required` BOOLEAN COMMENT 'Indicates whether the equipment requires temperature and humidity-controlled environment. True for most indoor equipment, false for outdoor-hardened units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment record was first created in the inventory system. Used for audit trail and data lineage.',
    `end_of_life_date` DATE COMMENT 'Date when the equipment is planned for decommissioning and removal from the network. Drives CAPEX planning for replacements.',
    `end_of_sale_date` DATE COMMENT 'Date announced by the vendor when the equipment model is no longer available for purchase. Triggers lifecycle planning and migration strategies.',
    `end_of_support_date` DATE COMMENT 'Date when the vendor discontinues technical support, software updates, and spare parts availability. Critical for technology refresh planning.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical equipment unit. Used for warranty tracking, maintenance history, and asset identification.. Valid values are `^[A-Z0-9]{8,20}$`',
    `equipment_subtype` STRING COMMENT 'Detailed equipment classification within the type category. Examples: eNodeB, gNodeB, BNG, BRAS, MPLS_ROUTER, SD_WAN_EDGE, IMS_CSCF, HSS, UDM, PCF, DSLAM, OLT_GPON, OLT_XGS_PON, RECTIFIER, BATTERY_BANK.',
    `equipment_type` STRING COMMENT 'High-level classification of network equipment by functional layer: RAN (Radio Access Network - eNodeB/gNodeB), CORE (IMS/HSS/UDM/PCF), TRANSPORT (MPLS routers/SD-WAN), ACCESS (BNG/BRAS/DSLAM/OLT), POWER (rectifiers/batteries), CPE (Customer Premises Equipment).. Valid values are `RAN|CORE|TRANSPORT|ACCESS|POWER|CPE`',
    `frequency_bands` STRING COMMENT 'Comma-separated list of radio frequency bands supported by RAN equipment. Examples: 700MHz, 1800MHz, 2100MHz, 2600MHz, 3500MHz, 28GHz. Null for non-radio equipment.',
    `hardware_revision` STRING COMMENT 'Hardware revision or version code assigned by the manufacturer. Used to track component changes and compatibility.. Valid values are `^[A-Z0-9.-]{1,20}$`',
    `hostname` STRING COMMENT 'Fully qualified domain name (FQDN) or hostname assigned to the equipment for network identification and DNS resolution.. Valid values are `^[a-zA-Z0-9][a-zA-Z0-9-.]{0,252}[a-zA-Z0-9]$`',
    `installation_date` DATE COMMENT 'Date when the equipment was physically installed and commissioned at the site. Used for age tracking and lifecycle management.',
    `ip_address` STRING COMMENT 'Primary management IP address (IPv4 or IPv6) assigned to the equipment for network management, monitoring, and configuration access.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance activity performed on the equipment. Used for maintenance scheduling and compliance tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this equipment record. Used for change tracking and data synchronization.',
    `max_power_draw_watts` DECIMAL(18,2) COMMENT 'Maximum power consumption in watts under peak load conditions. Critical for power supply sizing and cooling requirements.',
    `mtbf_hours` STRING COMMENT 'Manufacturer-rated Mean Time Between Failures in hours. Reliability metric used for spare parts planning and network resilience design.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to repair or replace the equipment when a failure occurs. Used for SLA planning and workforce scheduling.',
    `network_function` STRING COMMENT 'Primary network function or service role performed by the equipment. Examples: PACKET_CORE, VOICE_SWITCHING, BROADBAND_AGGREGATION, RADIO_ACCESS, TRANSPORT_ROUTING, POLICY_CONTROL.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity based on vendor recommendations or organizational policy.',
    `notes` STRING COMMENT 'Free-text field for additional information, special configurations, known issues, or operational notes about the equipment.',
    `operating_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum ambient temperature in Celsius at which the equipment can operate within specifications. Used for cooling system design.',
    `operating_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum ambient temperature in Celsius at which the equipment can operate within specifications. Critical for outdoor and remote site deployments.',
    `operational_status` STRING COMMENT 'Current operational state of the equipment: IN_SERVICE (active and carrying traffic), STANDBY (ready but not active), MAINTENANCE (undergoing planned maintenance), FAULTY (failed or degraded), DECOMMISSIONED (retired from service), RESERVED (allocated but not yet deployed).. Valid values are `IN_SERVICE|STANDBY|MAINTENANCE|FAULTY|DECOMMISSIONED|RESERVED`',
    `port_capacity_gbps` DECIMAL(18,2) COMMENT 'Aggregate throughput capacity across all ports in gigabits per second (Gbps). Used for capacity planning and traffic engineering.',
    `port_count` STRING COMMENT 'Total number of physical or logical ports available on the equipment for connectivity (e.g., Ethernet ports, fiber ports, radio carriers).',
    `power_draw_watts` DECIMAL(18,2) COMMENT 'Typical power consumption of the equipment in watts under normal operating conditions. Used for power capacity planning and OPEX calculation.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which the equipment was procured. Links to procurement and financial systems for cost tracking.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `rack_location` STRING COMMENT 'Physical rack identifier within the site where the equipment is mounted. Format varies by site convention (e.g., R01, RACK-A-12).. Valid values are `^[A-Z0-9]{1,10}$`',
    `rack_unit_height` STRING COMMENT 'Number of rack units (RU) occupied by the equipment. Standard values: 1U, 2U, 4U, etc.',
    `rack_unit_position` STRING COMMENT 'Starting rack unit position (1U = 1.75 inches) from the bottom of the rack where the equipment is mounted. Used for physical space planning and cable management.',
    `redundancy_role` STRING COMMENT 'Role of the equipment in redundancy configuration. PRIMARY (active), SECONDARY (standby backup), STANDALONE (no redundancy), N_PLUS_1 (shared backup for multiple primaries).. Valid values are `PRIMARY|SECONDARY|STANDALONE|N_PLUS_1`',
    `software_version` STRING COMMENT 'Current firmware or software version running on the equipment. Format typically follows semantic versioning (e.g., 21.4.2, 5.1.0-R2A).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?(-[A-Z0-9]+)?$`',
    `supported_standards` STRING COMMENT 'Comma-separated list of technology standards and protocols supported by the equipment. Examples: LTE, 5G_NR, GPON, XGS_PON, DOCSIS_3.1, MPLS, SD_WAN, VoLTE, IMS.',
    CONSTRAINT pk_network_equipment PRIMARY KEY(`network_equipment_id`)
) COMMENT 'Master record for core, transport, and access network equipment assets and their hardware model reference catalog. Equipment instance attributes: equipment type, vendor, model, serial number, rack/slot location (FK to rack_slot_port), POP/site (FK to pop_facility), power draw, software version, operational status, and maintenance contract reference. Covers RAN base stations (eNodeB/gNodeB), BNG/BRAS, MPLS routers, SD-WAN edge nodes, IMS/HSS/UDM/PCF nodes, and DSLAM units. Equipment model catalog attributes: model name, manufacturer, equipment category (CPE/ONT/OLT/RAN/transport/core/power), technical specifications (ports, throughput, capacity), supported standards (LTE/5G NR/GPON/XGS-PON/DOCSIS 3.1), physical dimensions, power requirements, MTBF rating, end-of-sale/support/life dates, and approved vendor status. SSOT for non-OLT/ONT network equipment inventory and hardware model catalog. Managed via Ericsson Network Manager and Nokia NetAct.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`pop_facility` (
    `pop_facility_id` BIGINT COMMENT 'Unique identifier for the physical facility location where inventory assets are housed, stored, or staged.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: POP facilities are cost centers or assigned to cost centers for expense tracking (rent, utilities, security, maintenance). Required for facility cost allocation, budget management, and operational exp',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Point-of-presence facilities require assigned manager for vendor access coordination, security compliance, lease management, and site audit responsibility. Replaces denormalized name field.',
    `parent_facility_pop_facility_id` BIGINT COMMENT 'Reference to the parent facility in a hierarchical facility structure, used for regional or organizational grouping.',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: POP facilities are serviced from a primary depot for workforce dispatch, parts logistics, and emergency response. This link supports dispatch optimization, travel time calculation, and resource alloca',
    `address_line_1` STRING COMMENT 'Primary street address line for the facility location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building details.',
    `backup_power_type` STRING COMMENT 'Type of backup power system available at the facility to ensure continuity during outages.. Valid values are `ups|generator|battery|none|hybrid|solar`',
    `city` STRING COMMENT 'City or municipality where the facility is located.',
    `climate_control_type` STRING COMMENT 'Type of environmental climate control system installed at the facility for temperature and humidity management.. Valid values are `hvac|passive|none|precision_cooling|evaporative|hybrid`',
    `commissioning_date` DATE COMMENT 'Date when the facility was officially commissioned and became operational for inventory and equipment hosting.',
    `contact_email` STRING COMMENT 'Primary email address for facility operations and logistics coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the facility operations team.',
    `cooling_capacity_tons` DECIMAL(18,2) COMMENT 'HVAC cooling capacity available at the facility measured in refrigeration tons for equipment thermal management.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the facility location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system.',
    `cycle_count_frequency_days` STRING COMMENT 'Number of days between scheduled physical inventory cycle counts at this facility.',
    `decommissioning_date` DATE COMMENT 'Date when the facility was or is scheduled to be decommissioned and removed from active operations.',
    `equipment_rack_count` STRING COMMENT 'Number of equipment racks available for hosting network infrastructure and telecommunications equipment.',
    `facility_code` STRING COMMENT 'Externally-known unique business identifier for the facility, used in operational systems and field dispatch.. Valid values are `^[A-Z0-9]{6,12}$`',
    `facility_name` STRING COMMENT 'Human-readable name of the facility location.',
    `facility_subtype` STRING COMMENT 'Secondary classification providing additional granularity for facility categorization (e.g., regional depot, field technician van, retail store, warehouse). [ENUM-REF-CANDIDATE: regional_depot|field_van|retail_store|central_warehouse|staging_area|maintenance_hub|distribution_center — promote to reference product]',
    `facility_type` STRING COMMENT 'Classification of the facility based on its primary operational purpose in the telecommunications network infrastructure.. Valid values are `pop|central_office|data_center|headend|street_cabinet|cell_tower`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed at the facility for equipment and inventory protection.. Valid values are `sprinkler|gas|foam|none|water_mist|dry_chemical`',
    `floor_space_sqm` DECIMAL(18,2) COMMENT 'Total usable floor space of the facility measured in square meters.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent physical inventory cycle count was completed at this facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was most recently updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees for GPS positioning and field dispatch routing.',
    `lease_expiration_date` DATE COMMENT 'Date when the current lease agreement for the facility expires, applicable only for leased facilities.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees for GPS positioning and field dispatch routing.',
    `max_stock_level_threshold` STRING COMMENT 'Maximum inventory quantity threshold that defines the upper limit for stock positioning at this facility.',
    `min_stock_level_threshold` STRING COMMENT 'Minimum inventory quantity threshold that triggers replenishment orders for this facility.',
    `network_connectivity_type` STRING COMMENT 'Primary telecommunications network connectivity available at the facility (e.g., fiber, microwave, satellite, copper). [ENUM-REF-CANDIDATE: fiber|microwave|satellite|copper|wireless|hybrid|mpls — promote to reference product]',
    `next_cycle_count_date` DATE COMMENT 'Scheduled date for the next physical inventory cycle count at this facility.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or facility-specific information.',
    `operates_24x7` BOOLEAN COMMENT 'Indicates whether the facility operates continuously 24 hours per day, 7 days per week.',
    `operating_hours_end` STRING COMMENT 'Daily end time for facility operations in HH:MM format (24-hour clock).. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily start time for facility operations in HH:MM format (24-hour clock).. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_status` STRING COMMENT 'Current lifecycle state of the facility indicating its availability for inventory operations and equipment hosting.. Valid values are `active|inactive|under_construction|decommissioned|maintenance|standby`',
    `ownership_status` STRING COMMENT 'Legal ownership or occupancy arrangement for the facility property.. Valid values are `owned|leased|colocation|licensed|shared`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address.',
    `power_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power capacity available at the facility measured in kilowatts.',
    `security_tier` STRING COMMENT 'Physical security classification level of the facility based on access controls, surveillance, and protection measures.. Valid values are `tier_1|tier_2|tier_3|tier_4|basic|enhanced`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the facility location.',
    `storage_capacity_cubic_m` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity available for inventory assets measured in cubic meters.',
    `supports_hazmat_storage` BOOLEAN COMMENT 'Indicates whether the facility is certified and equipped to store hazardous materials such as batteries and chemicals.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the facility location used for scheduling and operational coordination.',
    CONSTRAINT pk_pop_facility PRIMARY KEY(`pop_facility_id`)
) COMMENT 'Master record for all physical locations where inventory assets are housed, stored, or staged — including Points of Presence (POP), central offices (CO), data centers, headends, street cabinets, cell tower compounds, central warehouses, regional depots, field technician vans, and retail stores. Facility attributes: name, type, address, GPS coordinates, floor space, power/cooling capacity, security tier, lease/ownership status, equipment rack count. Stocking attributes: storage capacity, responsible manager, operating hours, climate control specifications, min/max stock levels per part category, cycle count schedule. SSOT for all facility and stocking location inventory supporting equipment hosting, spare parts positioning, field dispatch logistics, and inventory management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` (
    `fiber_strand_assignment_id` BIGINT COMMENT 'Unique identifier for the fiber strand assignment record. Primary key for this entity.',
    `rack_slot_port_id` BIGINT COMMENT 'Foreign key linking to inventory.rack_slot_port. Business justification: Fiber strand assignments terminate at specific physical ports in racks. Currently a_end_port_number is a STRING; replacing with FK to rack_slot_port provides full port hierarchy (facility → equipment ',
    `assignment_id` BIGINT COMMENT 'Reference to the backup fiber strand assignment providing redundancy for this primary strand. Null for unprotected strands or backup strands themselves.',
    `circuit_id` BIGINT COMMENT 'Unique circuit identifier for the service or wholesale transport circuit riding on this fiber strand. Used for operational tracking and trouble ticketing.',
    `fiber_cable_id` BIGINT COMMENT 'Reference to the parent fiber cable segment containing this strand.',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Lawful intercept orders for wireline/fiber services require provisioning intercept taps on specific fiber strands carrying target traffic. LEA compliance requires documenting which fiber strands were ',
    `agreement_id` BIGINT COMMENT 'Reference to the wholesale dark fiber lease agreement or Indefeasible Right of Use (IRU) contract governing this strand assignment. Null for owned infrastructure.',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization providing the leased fiber strand. Null for owned infrastructure.',
    `location_site_id` BIGINT COMMENT 'Reference to the originating termination point facility or Point of Presence (POP) for this fiber strand.',
    `network_equipment_id` BIGINT COMMENT 'Reference to the network equipment (Optical Line Terminal, router, switch, or DWDM multiplexer) at the A-end termination point.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance utilizing this fiber strand. Null for dark/spare/unassigned strands.',
    `technician_id` BIGINT COMMENT 'Reference to the technician who performed the most recent installation, testing, or maintenance work on this fiber strand.',
    `spliced_from_fiber_strand_assignment_id` BIGINT COMMENT 'Self-referencing FK on fiber_strand_assignment (spliced_from_fiber_strand_assignment_id)',
    `activation_date` DATE COMMENT 'Date when this fiber strand was lit and placed into active service. Null for dark/spare strands.',
    `assignment_date` DATE COMMENT 'Date when this fiber strand was assigned to a service, circuit, or lease arrangement. Null for dark/spare strands.',
    `assignment_status` STRING COMMENT 'Current operational status of the fiber strand. Dark indicates unlit/unassigned fiber available for lease or future use; lit indicates active service; spare indicates reserved capacity; maintenance indicates temporarily out of service; reserved indicates allocated but not yet activated; quarantined indicates isolated due to quality issues.. Valid values are `dark|lit|spare|maintenance|reserved|quarantined`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiber strand assignment record was first created in the inventory system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (lease cost and revenue).. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'Date when this fiber strand was deactivated and returned to dark/spare status. Null for currently active strands.',
    `fiber_mode` STRING COMMENT 'ISO/IEC 11801 fiber mode classification. OS1/OS2 for single-mode; OM1-OM5 for multi-mode with varying bandwidth capabilities. [ENUM-REF-CANDIDATE: OS1|OS2|OM1|OM2|OM3|OM4|OM5 — 7 candidates stripped; promote to reference product]',
    `fiber_type` STRING COMMENT 'Physical type of optical fiber. Single-mode for long-haul transmission; multi-mode for short-distance high-bandwidth; bend-insensitive for tight installation spaces.. Valid values are `single_mode|multi_mode|bend_insensitive`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fiber strand assignment record, used for change tracking and audit purposes.',
    `last_test_date` DATE COMMENT 'Date of the most recent optical performance test (OTDR or power meter test) conducted on this fiber strand.',
    `lease_end_date` DATE COMMENT 'Expiration date of the lease agreement. Null for IRU agreements (typically 20+ years) or owned infrastructure.',
    `lease_start_date` DATE COMMENT 'Effective start date of the lease or IRU agreement for this fiber strand. Null for owned infrastructure used internally.',
    `lease_type` STRING COMMENT 'Ownership or lease arrangement for this fiber strand. Owned indicates company-owned infrastructure; leased indicates rental from third party; IRU (Indefeasible Right of Use) indicates long-term lease with ownership-like rights; swap indicates fiber exchange agreement; joint_build indicates shared construction arrangement.. Valid values are `owned|leased|iru|swap|joint_build`',
    `measured_loss_db` DECIMAL(18,2) COMMENT 'Actual measured optical loss in decibels from the most recent Optical Time Domain Reflectometer (OTDR) test. Used to verify strand quality and detect degradation.',
    `monthly_lease_cost` DECIMAL(18,2) COMMENT 'Monthly recurring cost for leasing this fiber strand from a third party. Null for owned infrastructure. Used for cost allocation and profitability analysis.',
    `monthly_lease_revenue` DECIMAL(18,2) COMMENT 'Monthly recurring revenue generated from leasing this fiber strand to wholesale customers. Null for internal use. Used for revenue assurance and wholesale billing.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next mandatory optical performance test based on maintenance policy or regulatory requirements.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, known issues, or historical context about this fiber strand assignment.',
    `optical_loss_budget_db` DECIMAL(18,2) COMMENT 'Total acceptable optical power loss in decibels (dB) for this fiber strand from A-end to Z-end, including fiber attenuation, splice losses, and connector losses. Critical for service quality assurance.',
    `protection_scheme` STRING COMMENT 'Redundancy and protection mechanism for this fiber strand. Unprotected indicates no backup; 1+1 indicates dedicated backup strand; 1:1 indicates shared backup with automatic switchover; 1:N indicates one backup for multiple working strands; ring indicates self-healing ring topology.. Valid values are `unprotected|1_plus_1|1_colon_1|1_colon_n|ring`',
    `record_source_system` STRING COMMENT 'Name of the operational system that is the authoritative source for this fiber strand assignment record (Oracle OSM, Netcracker, or network management system).',
    `reflectance_db` DECIMAL(18,2) COMMENT 'Optical return loss or reflectance measurement in decibels, indicating the amount of light reflected back toward the source. Lower values indicate better quality connections.',
    `service_impact_level` STRING COMMENT 'Business criticality classification indicating the impact of an outage on this fiber strand. Critical for backbone/core transport; high for enterprise services; medium for business services; low for residential; none for dark/spare strands.. Valid values are `critical|high|medium|low|none`',
    `sla_tier` STRING COMMENT 'Service Level Agreement tier governing restoration time objectives and performance guarantees for this fiber strand. Higher tiers require faster Mean Time to Repair (MTTR).. Valid values are `platinum|gold|silver|bronze|standard`',
    `strand_color_code` STRING COMMENT 'Industry-standard color coding of the fiber strand for physical identification during splicing and maintenance operations. [ENUM-REF-CANDIDATE: blue|orange|green|brown|slate|white|red|black|yellow|violet|rose|aqua — 12 candidates stripped; promote to reference product]',
    `strand_number` STRING COMMENT 'Physical strand number within the fiber cable, typically numbered sequentially from 1 to the total fiber count in the cable.',
    `test_wavelength_nm` STRING COMMENT 'Wavelength in nanometers used during the most recent OTDR test, typically 1310nm or 1550nm for single-mode fiber.',
    `wavelength_nm` STRING COMMENT 'Specific wavelength in nanometers assigned to this strand for Dense Wavelength Division Multiplexing (DWDM) systems. Null for non-DWDM dark fiber.',
    `z_end_port_number` STRING COMMENT 'Physical port identifier on the Z-end equipment where this fiber strand terminates.',
    CONSTRAINT pk_fiber_strand_assignment PRIMARY KEY(`fiber_strand_assignment_id`)
) COMMENT 'Master record for individual fiber strand or lambda allocation within a fiber cable segment. Tracks strand number, wavelength (if DWDM), assignment status (dark/lit/spare/maintenance), assigned service or circuit reference, A-end and Z-end termination points, optical loss budget, and lease/IRU reference for wholesale dark fiber services. Essential for fiber capacity management and dark fiber leasing operations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` (
    `rack_slot_port_id` BIGINT COMMENT 'Unique identifier for the rack slot port record. Primary key for the physical mounting hierarchy within Point of Presence (POP) or Central Office (CO) facilities.',
    `fiber_cable_id` BIGINT COMMENT 'Reference identifier for the physical cable connected to this port. Used for cable management and tracing physical connectivity.',
    `network_equipment_id` BIGINT COMMENT 'Reference to the parent network equipment (chassis, switch, router, or line card) that contains this rack slot port.',
    `pop_facility_id` BIGINT COMMENT 'Reference to the POP or Central Office facility where this rack slot port is physically located.',
    `remote_equipment_id` BIGINT COMMENT 'Reference to the network equipment at the far end of the cable connection. Enables end-to-end circuit tracing.',
    `parent_rack_slot_port_id` BIGINT COMMENT 'Self-referencing FK on rack_slot_port (parent_rack_slot_port_id)',
    `administrative_status` STRING COMMENT 'Administrative configuration state of the port as set by network operations. Disabled or shutdown ports are intentionally taken out of service.. Valid values are `enabled|disabled|shutdown`',
    `bandwidth_allocation_mbps` STRING COMMENT 'Allocated bandwidth for the service or circuit on this port. May be less than the physical port speed due to Quality of Service (QoS) policies.',
    `circuit_code` STRING COMMENT 'Unique identifier for the logical circuit or service provisioned on this port. Links physical infrastructure to service layer.',
    `commissioning_date` DATE COMMENT 'Date when the port was commissioned and made available for operational use after installation and testing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rack slot port record was first created in the inventory system.',
    `decommission_date` DATE COMMENT 'Date when the port was taken out of service and decommissioned. Null for active ports.',
    `fiber_type` STRING COMMENT 'Type of fiber optic cable connected to this port. Singlemode for long-distance, multimode (OM1-OM5) for shorter distances with different bandwidth capabilities.. Valid values are `singlemode|multimode_om1|multimode_om2|multimode_om3|multimode_om4|multimode_om5`',
    `installation_date` DATE COMMENT 'Date when the rack slot port equipment was physically installed and mounted in the facility.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance activity performed on this port or its parent equipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rack slot port record was most recently updated in the inventory system.',
    `max_cable_distance_meters` STRING COMMENT 'Maximum supported cable length in meters for the port based on its speed, transceiver type, and fiber/copper specifications.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether this port is actively monitored by the Network Management System (NMS) for performance metrics, alarms, and fault detection.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity based on maintenance intervals and equipment lifecycle policies.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special configurations, known issues, or other relevant information about this rack slot port.',
    `occupancy_status` STRING COMMENT 'Indicates whether the port is currently connected to a cable or device (occupied), available for use (vacant), reserved for planned deployment, or quarantined due to issues.. Valid values are `occupied|vacant|reserved|quarantined`',
    `operational_status` STRING COMMENT 'Current operational state of the rack slot port indicating whether it is in service, out of service, under maintenance, or reserved for future use.. Valid values are `active|inactive|testing|maintenance|failed|reserved`',
    `poe_power_budget_watts` DECIMAL(18,2) COMMENT 'Maximum power in watts that can be delivered through this port via PoE. Common values are 15.4W (802.3af), 30W (802.3at), or 60-90W (802.3bt).',
    `port_duplex_mode` STRING COMMENT 'Duplex configuration of the port indicating whether it can transmit and receive simultaneously (full duplex) or must alternate (half duplex).. Valid values are `full|half|auto`',
    `port_function` STRING COMMENT 'Functional role of the port in the network architecture (e.g., access port for end devices, trunk port for inter-switch links, uplink to core network). [ENUM-REF-CANDIDATE: access|trunk|uplink|downlink|management|monitoring|backup|interconnect — 8 candidates stripped; promote to reference product]',
    `port_identifier` STRING COMMENT 'Human-readable unique identifier for the port, typically following vendor naming conventions (e.g., Gi0/0/1, Ethernet1/1/1, Port-1).',
    `port_label` STRING COMMENT 'Physical label or tag affixed to the port for visual identification during field operations and cable management activities.',
    `port_number` STRING COMMENT 'Sequential port number on the line card or equipment module. Used in combination with slot number to uniquely identify the physical port.',
    `port_speed_mbps` STRING COMMENT 'Maximum transmission speed of the port in megabits per second. Common values include 100, 1000, 10000, 25000, 40000, 100000.',
    `port_type` STRING COMMENT 'Physical interface type of the port, indicating the connector and transmission medium (electrical copper, optical fiber, or pluggable transceiver type). [ENUM-REF-CANDIDATE: electrical|optical|sfp|sfp_plus|qsfp|qsfp28|qsfp_dd|cfp|xfp|rj45|coaxial|fiber_lc|fiber_sc|fiber_mpo — 14 candidates stripped; promote to reference product]',
    `power_over_ethernet_capable` BOOLEAN COMMENT 'Indicates whether the port supports Power over Ethernet (PoE) to supply electrical power to connected devices over the data cable.',
    `protection_scheme` STRING COMMENT 'Type of redundancy or protection mechanism configured for this port (e.g., 1+1 protection, 1:1 protection, 1:N protection, ring protection).. Valid values are `none|one_plus_one|one_colon_one|one_colon_n|ring|mesh`',
    `quality_of_service_class` STRING COMMENT 'QoS classification applied to traffic on this port for prioritization and Service Level Agreement (SLA) enforcement (e.g., gold, silver, bronze, best-effort).',
    `rack_position` STRING COMMENT 'Physical rack location identifier within the facility, typically expressed as row-column-rack format (e.g., A-03-12, R1-C5-RK8).',
    `rack_unit_height` STRING COMMENT 'Height of the equipment in rack units. Standard equipment heights are 1U, 2U, 4U, etc.',
    `rack_unit_start` STRING COMMENT 'Starting rack unit position from the bottom of the rack where the equipment is mounted. Rack units are standardized 1.75-inch (44.45mm) increments.',
    `redundancy_group` STRING COMMENT 'Identifier for the redundancy or protection group this port belongs to. Used for high-availability configurations and failover planning.',
    `remote_port_identifier` STRING COMMENT 'Identifier of the port on the remote equipment that this port connects to. Used for documenting point-to-point connections.',
    `service_type` STRING COMMENT 'Type of telecommunications service carried by this port (data, voice, video, network management, signaling, or mixed services). [ENUM-REF-CANDIDATE: data|voice|video|management|signaling|synchronization|mixed — 7 candidates stripped; promote to reference product]',
    `slot_number` STRING COMMENT 'Slot number within the chassis or equipment frame where the line card or module is installed. Null if the equipment does not have modular slots.',
    `snmp_index` STRING COMMENT 'SNMP ifIndex value for this port as reported by the network element. Used for correlation with SNMP monitoring data.',
    `transceiver_serial_number` STRING COMMENT 'Manufacturer serial number of the installed optical transceiver module. Used for inventory tracking and warranty management.',
    `transceiver_type` STRING COMMENT 'Type and model of the pluggable optical transceiver installed in the port (e.g., SFP-10G-SR, QSFP28-100G-LR4). Null for fixed electrical ports.',
    `vlan_number` STRING COMMENT 'VLAN identifier assigned to this port for network segmentation. Valid range is 1-4094 per IEEE 802.1Q standard.',
    `wavelength_nm` STRING COMMENT 'Operating wavelength of the optical transceiver in nanometers. Common values are 850nm (multimode), 1310nm, and 1550nm (singlemode).',
    CONSTRAINT pk_rack_slot_port PRIMARY KEY(`rack_slot_port_id`)
) COMMENT 'Master record for the physical mounting hierarchy within POP/CO facilities — racks, slots within chassis, and ports on line cards. Tracks rack position (row/column/RU), slot number, port type (electrical/optical/SFP), port speed, occupied/vacant status, connected cable reference, and parent equipment reference. Enables physical capacity planning and cable management within facilities.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` (
    `fiber_lease_id` BIGINT COMMENT 'Unique surrogate identifier for each fiber lease agreement record. Primary key for the association.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner leasing the fiber infrastructure. References the carrier registry in the interconnect domain.',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to the fiber cable segment being leased. References the physical infrastructure asset in the inventory domain.',
    `circuit_capacity_gbps` DECIMAL(18,2) COMMENT 'Allocated transmission capacity in gigabits per second for this lease agreement. Represents the bandwidth or fiber count allocated to the carrier. Identified in detection phase as relationship-specific data.',
    `contract_reference_number` STRING COMMENT 'External contract or agreement reference number linking this lease to the legal commercial agreement between the parties.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lease agreement record was created in the system.',
    `fiber_count_allocated` STRING COMMENT 'Number of individual fiber strands allocated to the carrier under this lease agreement. Relevant for dark fiber and IRU agreements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this lease agreement record was last updated.',
    `lease_end_date` DATE COMMENT 'Date when the fiber lease agreement expires or is scheduled for renewal. Null indicates perpetual IRU agreement. Identified in detection phase as relationship-specific data.',
    `lease_start_date` DATE COMMENT 'Date when the fiber lease agreement becomes effective and the carrier gains access to the leased fiber capacity. Identified in detection phase as relationship-specific data.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease agreement. Active indicates live service, pending indicates contract signed but not yet provisioned.',
    `lease_type` STRING COMMENT 'Classification of the lease arrangement: IRU (Indefeasible Right of Use - long-term capital lease), dark fiber (unlit fiber lease), lit service (managed wavelength service), or wavelength (specific lambda lease).',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for physical maintenance, repairs, and monitoring of the leased fiber segment. Critical for operational coordination and cost allocation. Identified in detection phase as relationship-specific data.',
    `monthly_lease_cost` DECIMAL(18,2) COMMENT 'Recurring monthly cost for the fiber lease in the settlement currency. Used for financial settlement and revenue recognition. Identified in detection phase as relationship-specific data.',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for lease payments. May differ from the carriers default settlement currency for roaming.',
    `sla_tier` STRING COMMENT 'SLA classification for this lease agreement defining restoration time objectives, availability guarantees, and support response times. Identified in detection phase as relationship-specific data.',
    CONSTRAINT pk_fiber_lease PRIMARY KEY(`fiber_lease_id`)
) COMMENT 'This association product represents the commercial lease contract between fiber_cable infrastructure assets and interconnect_carrier partners. It captures IRU (Indefeasible Right of Use) agreements, dark fiber leases, and capacity allocation arrangements where telecommunications operators lease fiber infrastructure to/from carriers. Each record links one fiber_cable segment to one interconnect_carrier with lease terms, pricing, capacity allocation, SLA commitments, and maintenance responsibility assignments that exist only in the context of this commercial relationship.. Existence Justification: In telecommunications wholesale operations, fiber infrastructure lease agreements represent true many-to-many commercial relationships. A single fiber cable route can have segments leased to multiple carriers simultaneously (e.g., Carrier A leases fibers 1-12, Carrier B leases fibers 13-24 on the same cable), and each carrier leases multiple cable segments across different geographic routes to build their network footprint. These are actively managed commercial contracts with lease terms, pricing, capacity allocation, SLA commitments, and maintenance responsibilities that belong to the relationship, not to either the cable asset or the carrier entity alone.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` (
    `service_equipment_assignment_id` BIGINT COMMENT 'Unique identifier for this service equipment assignment record. Primary key.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to the managed service instance being delivered',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to the network equipment asset assigned to deliver this managed service',
    `activation_date` DATE COMMENT 'Date when this equipment was activated and began delivering traffic for this managed service instance',
    `assignment_status` STRING COMMENT 'Current operational status of this equipment assignment: ACTIVE (currently in service), INACTIVE (temporarily disabled), PENDING (provisioned but not yet activated), DECOMMISSIONED (permanently removed)',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this service equipment assignment record was created in the system',
    `deactivation_date` DATE COMMENT 'Date when this equipment was deactivated and stopped delivering traffic for this managed service. Null for currently active assignments.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this assignment record',
    `primary_backup_flag` BOOLEAN COMMENT 'Boolean indicator: TRUE if this equipment is designated as primary for the service, FALSE if backup or secondary',
    `redundancy_role` STRING COMMENT 'Redundancy configuration role for high availability: ACTIVE (currently carrying traffic), PASSIVE (standby ready for failover), ACTIVE_ACTIVE (both carrying traffic simultaneously), NONE (no redundancy)',
    `role_in_service` STRING COMMENT 'Functional role this equipment plays in delivering the managed service: PRIMARY (main active equipment), BACKUP (hot standby for failover), LOAD_BALANCED (active-active traffic sharing), STANDBY (cold spare), FAILOVER (automatic switchover target)',
    `traffic_percentage` DECIMAL(18,2) COMMENT 'Percentage of service traffic routed through this equipment in load-balanced configurations. Range 0.00-100.00. Sum across all active equipment for a service should equal 100.',
    CONSTRAINT pk_service_equipment_assignment PRIMARY KEY(`service_equipment_assignment_id`)
) COMMENT 'This association product represents the assignment relationship between network equipment and managed enterprise services. It captures which equipment instances (routers, switches, SD-WAN appliances) are allocated to deliver specific managed service instances, including redundancy roles, traffic distribution, and lifecycle dates. Each record links one network equipment asset to one managed service with attributes that exist only in the context of this service delivery assignment.. Existence Justification: In telecommunications service delivery, managed enterprise services (SD-WAN, MPLS VPN, UCaaS) routinely require multiple network equipment instances for redundancy and load balancing—primary and backup routers, active-active PE router pairs, or SD-WAN appliance clusters. Conversely, shared network infrastructure such as MPLS PE routers and metro Ethernet switches simultaneously serve multiple enterprise service instances. The business actively manages these assignments, tracking which equipment delivers which service, in what role (primary/backup), with what traffic split, and for what time period.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`colocation` (
    `colocation_id` BIGINT COMMENT 'Unique identifier for this colocation agreement record. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner organization whose equipment is housed in the facility',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to the physical facility where partner equipment is colocated',
    `access_level` STRING COMMENT 'Physical access rights granted to the partner for this facility. Determines whether partner technicians can enter unescorted, require escort, or must use remote hands service.',
    `circuit_count` STRING COMMENT 'Number of network circuits or cross-connects provisioned for the partner at this facility. Used for capacity planning and billing.',
    `colocation_status` STRING COMMENT 'Current lifecycle status of the colocation arrangement. Active indicates equipment is installed and operational.',
    `contract_end_date` DATE COMMENT 'Scheduled expiration date for the colocation agreement at this facility. Null for evergreen agreements or month-to-month arrangements.',
    `contract_start_date` DATE COMMENT 'Effective start date when the partner began colocating equipment at this facility. Marks the beginning of billing and SLA obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this colocation agreement record was created.',
    `monthly_colocation_fee` DECIMAL(18,2) COMMENT 'Recurring monthly fee charged to the partner for colocation services at this facility. Typically based on rack space, power allocation, and service tier.',
    `power_allocation_kw` DECIMAL(18,2) COMMENT 'Electrical power capacity allocated to the partner for their equipment in this facility, measured in kilowatts. Part of the colocation SLA and billing calculation.',
    `rack_space_allocated_units` DECIMAL(18,2) COMMENT 'Number of rack units (RU) allocated to the partner within this facility. Typically measured in standard 19-inch rack units where 1U = 1.75 inches.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this colocation agreement record was last modified.',
    CONSTRAINT pk_colocation PRIMARY KEY(`colocation_id`)
) COMMENT 'This association product represents the colocation contract between pop_facility and partner. It captures the physical hosting arrangement where partner equipment is housed within a telecommunications facility. Each record links one pop_facility to one partner with attributes that exist only in the context of this colocation relationship: rack space allocation, power allocation, access rights, and financial terms.. Existence Justification: In telecommunications operations, POP facilities routinely host equipment from multiple partners (tower companies, content providers, MVNO partners, interconnect carriers) through colocation agreements, and each partner typically maintains equipment presence across multiple facilities for geographic redundancy and network reach. Colocation is a recognized operational business process managed by facility operations teams who allocate rack space, power budgets, and access rights on a per-partner-per-facility basis, with distinct financial terms and SLAs for each arrangement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`splice_closure` (
    `splice_closure_id` BIGINT COMMENT 'Primary key for splice_closure',
    `upstream_splice_closure_id` BIGINT COMMENT 'Self-referencing FK on splice_closure (upstream_splice_closure_id)',
    `asset_tag` STRING COMMENT 'Internal asset tag used for inventory tracking.',
    `closure_code` STRING COMMENT 'External business code used to reference the splice closure in operational systems.',
    `closure_name` STRING COMMENT 'Human‑readable name or label for the splice closure.',
    `closure_reason` STRING COMMENT 'Business or technical reason for creating or modifying the splice closure.',
    `closure_type` STRING COMMENT 'Category of the splice closure indicating its functional purpose.',
    `contract_number` STRING COMMENT 'Contract identifier linking the splice closure to a vendor agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the splice closure record was first created in the system.',
    `decommissioned_date` DATE COMMENT 'Date the splice closure was removed or taken out of service.',
    `fiber_pair_code` STRING COMMENT 'Code of the fiber pair associated with this splice closure.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `installed_date` DATE COMMENT 'Date the splice closure was installed in the network.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the splice closure.',
    `location_code` STRING COMMENT 'Identifier of the physical location (site, rack, panel) where the splice closure resides.',
    `maintenance_window_end` TIMESTAMP COMMENT 'Planned end time for maintenance activities affecting the splice closure.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Planned start time for maintenance activities affecting the splice closure.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the splice closure component.',
    `splice_loss_db` DECIMAL(18,2) COMMENT 'Measured optical loss introduced by the splice, expressed in decibels.',
    `splice_method` STRING COMMENT 'Technique used to create the splice.',
    `splice_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the quality of the splice (higher is better).',
    `splice_closure_status` STRING COMMENT 'Current lifecycle status of the splice closure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the splice closure record.',
    `vendor_name` STRING COMMENT 'Name of the vendor that supplied the splice closure hardware.',
    `warranty_expiration_date` DATE COMMENT 'Date when the warranty for the splice closure expires.',
    CONSTRAINT pk_splice_closure PRIMARY KEY(`splice_closure_id`)
) COMMENT 'Master reference table for splice_closure. Referenced by splice_closure_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`circuit` (
    `circuit_id` BIGINT COMMENT 'Primary key for circuit',
    `enterprise_contract_id` BIGINT COMMENT 'Identifier of the contract governing the circuit.',
    `end_location_id` BIGINT COMMENT 'FK to location.location_site',
    `end_location_location_site_id` BIGINT COMMENT 'Reference to the terminating network location or POP.',
    `location_site_id` BIGINT COMMENT 'Reference to the originating network location or POP.',
    `start_location_location_site_id` BIGINT COMMENT 'FK to location.location_site',
    `activation_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the circuit became active and serviceable.',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Provisioned bandwidth capacity of the circuit in megabits per second.',
    `circuit_category` STRING COMMENT 'Logical category of the circuit within the network hierarchy.',
    `circuit_code` STRING COMMENT 'External business identifier or code used in contracts and provisioning systems.',
    `circuit_description` STRING COMMENT 'Free‑form description providing additional context about the circuit.',
    `circuit_name` STRING COMMENT 'Human‑readable name or label assigned to the circuit.',
    `circuit_owner_contact` STRING COMMENT 'Contact name or identifier of the internal owner responsible for the circuit.',
    `circuit_status_detail` STRING COMMENT 'Additional free‑text details about the circuits current status.',
    `circuit_type` STRING COMMENT 'Technology type of the circuit (e.g., Ethernet, MPLS, T1).',
    `cost_center_code` STRING COMMENT 'Financial cost center to which circuit expenses are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the circuit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Timestamp when the circuit was taken out of service (nullable if still active).',
    `ip_address_pool` STRING COMMENT 'CIDR notation of the IP address pool allocated to the circuit.',
    `is_primary` BOOLEAN COMMENT 'True if this circuit is the primary path for the associated service.',
    `is_shared` BOOLEAN COMMENT 'Indicates whether the circuit is shared among multiple services or customers.',
    `last_maintenance_date` DATE COMMENT 'Date when the circuit last underwent maintenance.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance time window (e.g., "02:00-04:00").',
    `monthly_cost` DECIMAL(18,2) COMMENT 'Recurring monthly charge for the circuit.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next maintenance activity.',
    `owning_department` STRING COMMENT 'Internal department responsible for the circuits lifecycle.',
    `physical_layer` STRING COMMENT 'Physical medium used for the circuit.',
    `provider_name` STRING COMMENT 'Name of the external carrier or service provider supplying the circuit.',
    `provisioning_date` DATE COMMENT 'Date when the circuit provisioning process was initiated.',
    `redundancy_flag` BOOLEAN COMMENT 'Indicates whether the circuit is part of a redundant design.',
    `redundancy_type` STRING COMMENT 'Type of redundancy implemented for the circuit.',
    `service_level` STRING COMMENT 'Service level agreement tier associated with the circuit.',
    `sla_availability_percent` DECIMAL(18,2) COMMENT 'Target availability percentage defined in the SLA.',
    `sla_response_time_ms` STRING COMMENT 'Maximum allowed response time for service incidents, in milliseconds.',
    `circuit_status` STRING COMMENT 'Current lifecycle status of the circuit.',
    `termination_date` DATE COMMENT 'Planned or actual date when the circuit contract ends.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the circuit record.',
    `vlan_number` STRING COMMENT 'Virtual LAN identifier associated with the circuit.',
    CONSTRAINT pk_circuit PRIMARY KEY(`circuit_id`)
) COMMENT 'Master reference table for circuit. Referenced by circuit_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` (
    `maintenance_contract_id` BIGINT COMMENT 'Primary key for maintenance_contract',
    `employee_id` BIGINT COMMENT 'Identifier of internal employee responsible for the contract.',
    `renewed_from_maintenance_contract_id` BIGINT COMMENT 'Self-referencing FK on maintenance_contract (renewed_from_maintenance_contract_id)',
    `amendment_number` STRING COMMENT 'Sequential number of the latest amendment to the contract.',
    `billing_cycle` STRING COMMENT 'Frequency of billing for the contract.',
    `confidentiality_level` STRING COMMENT 'Data confidentiality classification for the contract.',
    `contract_description` STRING COMMENT 'Free-text description of contract scope and purpose.',
    `contract_expiry_notification_sent` BOOLEAN COMMENT 'Flag indicating whether an expiry notification has been sent to the customer.',
    `contract_number` STRING COMMENT 'External contract number assigned by the customer or partner.',
    `contract_source_system` STRING COMMENT 'Source system where the contract data originates.',
    `contract_status_reason` STRING COMMENT 'Explanation for the current contract status.',
    `contract_type` STRING COMMENT 'Category of maintenance contract defining scope of services.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the maintenance contract.',
    `contract_version` STRING COMMENT 'Version identifier of the contract document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contract value. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|... — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the contract ends or expires; null for open-ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes effective.',
    `equipment_covered` STRING COMMENT 'Description of equipment and assets covered under the maintenance contract.',
    `escalation_contact_name` STRING COMMENT 'Name of the primary escalation contact for contract issues.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of escalation contact.',
    `external_reference_code` STRING COMMENT 'Identifier linking to contract record in external system (e.g., Oracle OSM).',
    `geographic_coverage` STRING COMMENT 'Geographic regions or countries where the contract services apply.',
    `is_multi_site` BOOLEAN COMMENT 'Indicates whether the contract applies to multiple sites.',
    `last_review_date` DATE COMMENT 'Date of the most recent contract review.',
    `payment_terms` STRING COMMENT 'Payment terms agreed for the contract.',
    `regulatory_compliance_required` BOOLEAN COMMENT 'Flag indicating whether the contract must comply with specific telecom regulations.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that renewal notice must be given.',
    `renewal_option` STRING COMMENT 'Renewal mechanism for the contract.',
    `service_category` STRING COMMENT 'Primary category of services covered.',
    `service_level_agreement` STRING COMMENT 'Textual description of SLA commitments.',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time in hours as defined in SLA.',
    `maintenance_contract_status` STRING COMMENT 'Current lifecycle status of the contract.',
    `termination_date` DATE COMMENT 'Actual date the contract was terminated before the scheduled end.',
    `total_sites_covered` STRING COMMENT 'Number of distinct sites covered under the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `warranty_period_months` STRING COMMENT 'Warranty period in months provided under the contract.',
    CONSTRAINT pk_maintenance_contract PRIMARY KEY(`maintenance_contract_id`)
) COMMENT 'Master reference table for maintenance_contract. Referenced by maintenance_contract_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_backup_olt_asset_id` FOREIGN KEY (`backup_olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ADD CONSTRAINT `fk_inventory_fiber_splice_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ADD CONSTRAINT `fk_inventory_fiber_splice_splice_closure_id` FOREIGN KEY (`splice_closure_id`) REFERENCES `telecommunication_ecm`.`inventory`.`splice_closure`(`splice_closure_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_parent_pool_ip_address_pool_id` FOREIGN KEY (`parent_pool_ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ADD CONSTRAINT `fk_inventory_spare_part_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_spectrum_allocation_id` FOREIGN KEY (`spectrum_allocation_id`) REFERENCES `telecommunication_ecm`.`inventory`.`spectrum_allocation`(`spectrum_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_maintenance_contract_id` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `telecommunication_ecm`.`inventory`.`maintenance_contract`(`maintenance_contract_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ADD CONSTRAINT `fk_inventory_network_equipment_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ADD CONSTRAINT `fk_inventory_pop_facility_parent_facility_pop_facility_id` FOREIGN KEY (`parent_facility_pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_rack_slot_port_id` FOREIGN KEY (`rack_slot_port_id`) REFERENCES `telecommunication_ecm`.`inventory`.`rack_slot_port`(`rack_slot_port_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `telecommunication_ecm`.`inventory`.`circuit`(`circuit_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ADD CONSTRAINT `fk_inventory_fiber_strand_assignment_spliced_from_fiber_strand_assignment_id` FOREIGN KEY (`spliced_from_fiber_strand_assignment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_strand_assignment`(`fiber_strand_assignment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ADD CONSTRAINT `fk_inventory_rack_slot_port_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ADD CONSTRAINT `fk_inventory_rack_slot_port_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ADD CONSTRAINT `fk_inventory_rack_slot_port_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ADD CONSTRAINT `fk_inventory_rack_slot_port_remote_equipment_id` FOREIGN KEY (`remote_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ADD CONSTRAINT `fk_inventory_rack_slot_port_parent_rack_slot_port_id` FOREIGN KEY (`parent_rack_slot_port_id`) REFERENCES `telecommunication_ecm`.`inventory`.`rack_slot_port`(`rack_slot_port_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ADD CONSTRAINT `fk_inventory_fiber_lease_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ADD CONSTRAINT `fk_inventory_service_equipment_assignment_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ADD CONSTRAINT `fk_inventory_colocation_pop_facility_id` FOREIGN KEY (`pop_facility_id`) REFERENCES `telecommunication_ecm`.`inventory`.`pop_facility`(`pop_facility_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`splice_closure` ADD CONSTRAINT `fk_inventory_splice_closure_upstream_splice_closure_id` FOREIGN KEY (`upstream_splice_closure_id`) REFERENCES `telecommunication_ecm`.`inventory`.`splice_closure`(`splice_closure_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ADD CONSTRAINT `fk_inventory_maintenance_contract_renewed_from_maintenance_contract_id` FOREIGN KEY (`renewed_from_maintenance_contract_id`) REFERENCES `telecommunication_ecm`.`inventory`.`maintenance_contract`(`maintenance_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `cpni_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Cpni Authorization Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Address ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installer Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^AT[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'available|assigned|in_transit|retired|defective|under_repair');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Premises Equipment (CPE) Device Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'router|modem|set_top_box|ont|wifi_gateway|residential_gateway');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `is_5g_capable` SET TAGS ('dbx_business_glossary_term' = '5G Capable Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `is_wifi6_capable` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi 6 Capable Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `max_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bandwidth in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|byod|trial');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `physical_condition` SET TAGS ('dbx_business_glossary_term' = 'Physical Condition');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `physical_condition` SET TAGS ('dbx_value_regex' = 'new|good|fair|poor|damaged|refurbished');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `port_count` SET TAGS ('dbx_business_glossary_term' = 'Port Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|extended|void');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `wifi_password` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Password');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `wifi_password` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `wifi_password` SET TAGS ('dbx_pii_password' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `wifi_ssid` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Service Set Identifier (SSID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'SIM Stock ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Target Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `activation_code` SET TAGS ('dbx_business_glossary_term' = 'Activation Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `activation_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `activation_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'unallocated|reserved|activated|suspended|deactivated|retired');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `download_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Download Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `eid` SET TAGS ('dbx_business_glossary_term' = 'eUICC Identifier (EID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `eid` SET TAGS ('dbx_value_regex' = '^[0-9]{32}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `eid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `eid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `esim_profile_state` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile State');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `esim_profile_state` SET TAGS ('dbx_value_regex' = 'available|downloaded|installed|enabled|disabled|deleted');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'SIM Form Factor');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `form_factor` SET TAGS ('dbx_value_regex' = '2FF|3FF|4FF|MFF2|embedded');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `iccid` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `iccid` SET TAGS ('dbx_value_regex' = '^[0-9]{19,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `iccid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI) Range End');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI) Range Start');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `is_test_sim` SET TAGS ('dbx_business_glossary_term' = 'Is Test SIM');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `ki_value` SET TAGS ('dbx_business_glossary_term' = 'Authentication Key (Ki)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `ki_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `ki_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = '2g|3g|4g_lte|5g_nr|multi');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `opc_value` SET TAGS ('dbx_business_glossary_term' = 'Operator Variant Algorithm Configuration (OPc)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `opc_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `opc_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `pin1` SET TAGS ('dbx_business_glossary_term' = 'Personal Identification Number 1 (PIN1)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `pin1` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `pin1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `pin1` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Profile Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'consumer|m2m|iot|enterprise|test|bootstrap');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `puk1` SET TAGS ('dbx_business_glossary_term' = 'Personal Unblocking Key 1 (PUK1)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `puk1` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `puk1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `puk1` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `quality_check_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|not_required');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `sim_type` SET TAGS ('dbx_business_glossary_term' = 'SIM Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `sim_type` SET TAGS ('dbx_value_regex' = 'physical|esim');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `smdp_address` SET TAGS ('dbx_business_glossary_term' = 'SM-DP+ Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `smdp_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `smdp_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Network Terminal (ONT) Asset ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installer Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,16}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Device ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{5,30}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'SFU|HGU|MDU|MTU');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `distance_from_olt_meters` SET TAGS ('dbx_business_glossary_term' = 'Distance from OLT in Meters');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `gpon_port_reference` SET TAGS ('dbx_business_glossary_term' = 'Gigabit Passive Optical Network (GPON) ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `gpon_port_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `hardware_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `last_firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `last_online_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Online Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `max_downstream_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Downstream Bandwidth in Mbps');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `max_upstream_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Upstream Bandwidth in Mbps');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `olt_port_number` SET TAGS ('dbx_business_glossary_term' = 'OLT Port Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `olt_port_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{1,2}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|faulty|maintenance|decommissioned|reserved');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `optical_power_rx_dbm` SET TAGS ('dbx_business_glossary_term' = 'Optical Power Receive (Rx) in dBm');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `optical_power_tx_dbm` SET TAGS ('dbx_business_glossary_term' = 'Optical Power Transmit (Tx) in dBm');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|customer_owned');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `port_count` SET TAGS ('dbx_business_glossary_term' = 'Port Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `reboot_count` SET TAGS ('dbx_business_glossary_term' = 'Reboot Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `remote_management_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Management Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'ONT Serial Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Uptime in Hours');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `voip_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over Internet Protocol (VoIP) Capability Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `wifi_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'WiFi Capability Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Asset ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `backup_olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Optical Line Terminal (OLT) Asset ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `active_pon_ports` SET TAGS ('dbx_business_glossary_term' = 'Active Passive Optical Network (PON) Ports');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^OLT-[A-Z0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `chassis_type` SET TAGS ('dbx_business_glossary_term' = 'Chassis Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `chassis_type` SET TAGS ('dbx_value_regex' = 'rack_mount|standalone|modular|compact');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `current_ont_count` SET TAGS ('dbx_business_glossary_term' = 'Current Optical Network Terminal (ONT) Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `environmental_temperature_rating_celsius` SET TAGS ('dbx_business_glossary_term' = 'Environmental Temperature Rating in Celsius');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `installed_line_cards` SET TAGS ('dbx_business_glossary_term' = 'Installed Line Cards');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `last_firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `line_card_slots` SET TAGS ('dbx_business_glossary_term' = 'Line Card Slots');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `maintenance_contract_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Management Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `max_ont_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Optical Network Terminal (ONT) Capacity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) in Hours');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) in Hours');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `nms_system` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `nms_system` SET TAGS ('dbx_value_regex' = 'Nokia NetAct|Ericsson Network Manager|Netcracker|Proprietary');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|standby|maintenance|decommissioned|faulty|testing');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `power_consumption_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption in Watts');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `rack_position` SET TAGS ('dbx_business_glossary_term' = 'Rack Position');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_value_regex' = 'none|active_standby|active_active|n_plus_one');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `snmp_community_string` SET TAGS ('dbx_business_glossary_term' = 'Simple Network Management Protocol (SNMP) Community String');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `snmp_community_string` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `snmp_community_string` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `total_pon_ports` SET TAGS ('dbx_business_glossary_term' = 'Total Passive Optical Network (PON) Ports');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `uplink_interface_type` SET TAGS ('dbx_business_glossary_term' = 'Uplink Interface Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `uplink_interface_type` SET TAGS ('dbx_value_regex' = '10GE|40GE|100GE|MPLS|Ethernet');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `uplink_port_count` SET TAGS ('dbx_business_glossary_term' = 'Uplink Port Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `duct_route_id` SET TAGS ('dbx_business_glossary_term' = 'Conduit/Duct Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `duct_route_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Start Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `assigned_fiber_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Fiber Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `attenuation_db_per_km` SET TAGS ('dbx_business_glossary_term' = 'Attenuation (dB/km)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `available_fiber_count` SET TAGS ('dbx_business_glossary_term' = 'Available Fiber Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `cable_code` SET TAGS ('dbx_business_glossary_term' = 'Cable Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `cable_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `cable_type` SET TAGS ('dbx_business_glossary_term' = 'Cable Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `cable_type` SET TAGS ('dbx_value_regex' = 'single_mode|multi_mode|ribbon|hybrid|armored|loose_tube');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `conduit_fill_ratio_percent` SET TAGS ('dbx_business_glossary_term' = 'Conduit Fill Ratio (Percent)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `conduit_inner_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Conduit Inner Diameter (Millimeters)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `conduit_material_type` SET TAGS ('dbx_business_glossary_term' = 'Conduit Material Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `conduit_material_type` SET TAGS ('dbx_value_regex' = 'hdpe|pvc|steel|concrete|fiberglass');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'buried|aerial|conduit|underwater|building_riser|microtrenching');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `end_location_gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'End Location GPS (Global Positioning System) Latitude');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `end_location_gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `end_location_gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `end_location_gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'End Location GPS (Global Positioning System) Longitude');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `end_location_gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `end_location_gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|industrial|coastal|mountainous');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `fiber_count` SET TAGS ('dbx_business_glossary_term' = 'Fiber Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `fire_rating` SET TAGS ('dbx_business_glossary_term' = 'Fire Rating');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `fire_rating` SET TAGS ('dbx_value_regex' = 'ofnr|ofnp|ofcp|lszh|standard');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'internal|contractor|municipal|joint|third_party');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|iru|municipal|joint_build');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `right_of_way_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way (ROW) Permit Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `right_of_way_permit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `route_length_meters` SET TAGS ('dbx_business_glossary_term' = 'Route Length (Meters)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `sheath_type` SET TAGS ('dbx_business_glossary_term' = 'Sheath Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `sheath_type` SET TAGS ('dbx_value_regex' = 'polyethylene|pvc|lszh|armored|gel_filled|dry_core');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `splice_point_count` SET TAGS ('dbx_business_glossary_term' = 'Splice Point Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `start_location_gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location GPS (Global Positioning System) Latitude');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `start_location_gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `start_location_gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `start_location_gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location GPS (Global Positioning System) Longitude');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `start_location_gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `start_location_gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `temperature_rating_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Rating Maximum (Celsius)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `temperature_rating_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Rating Minimum (Celsius)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `fiber_splice_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Splice Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `geo_point_id` SET TAGS ('dbx_business_glossary_term' = 'Geo Point Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Work Order Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'A-Side Cable Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_closure_id` SET TAGS ('dbx_business_glossary_term' = 'Splice Closure Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_closure_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `a_side_fiber_number` SET TAGS ('dbx_business_glossary_term' = 'A-Side Fiber Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `b_side_fiber_number` SET TAGS ('dbx_business_glossary_term' = 'B-Side Fiber Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `closure_capacity` SET TAGS ('dbx_business_glossary_term' = 'Closure Capacity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `environmental_seal_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Seal Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `environmental_seal_status` SET TAGS ('dbx_value_regex' = 'sealed|compromised|open|unknown');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `fiber_pairs_spliced` SET TAGS ('dbx_business_glossary_term' = 'Fiber Pairs Spliced Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `insertion_loss_db` SET TAGS ('dbx_business_glossary_term' = 'Insertion Loss (Decibels)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_tested');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Splice Location Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'manhole|pole|pedestal|building|cabinet|vault');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `network_segment` SET TAGS ('dbx_business_glossary_term' = 'Network Segment');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `network_segment` SET TAGS ('dbx_value_regex' = 'feeder|distribution|drop|backbone|metro|long_haul');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Splice Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type (Outside Plant / Inside Plant)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `plant_type` SET TAGS ('dbx_value_regex' = 'OSP|ISP');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'unprotected|1_plus_1|1_colon_1|ring|mesh');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `reflectance_db` SET TAGS ('dbx_business_glossary_term' = 'Reflectance (Decibels)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `service_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Service Impact Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `service_impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_status` SET TAGS ('dbx_business_glossary_term' = 'Splice Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|under_test|failed|retired');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_tray_position` SET TAGS ('dbx_business_glossary_term' = 'Splice Tray Position');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_type` SET TAGS ('dbx_business_glossary_term' = 'Splice Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `splice_type` SET TAGS ('dbx_value_regex' = 'fusion|mechanical|ribbon|mass_fusion|pigtail|fanout');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_splice` ALTER COLUMN `test_wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Test Wavelength (Nanometers)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Pool Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `parent_pool_ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Pool Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `parent_pool_ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `parent_pool_ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `allocation_policy` SET TAGS ('dbx_business_glossary_term' = 'Allocation Policy');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `allocation_policy` SET TAGS ('dbx_value_regex' = 'sequential|random|round_robin|least_used|geographic|service_based');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `assigned_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `assignment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assignment Scope');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `assignment_scope` SET TAGS ('dbx_value_regex' = 'subscriber|cpe|network_node|service_instance|iot_device|mobile_device');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `available_count` SET TAGS ('dbx_business_glossary_term' = 'Available Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `cgnat_ratio` SET TAGS ('dbx_business_glossary_term' = 'Carrier-Grade Network Address Translation (CGNAT) Ratio');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `cidr_block` SET TAGS ('dbx_business_glossary_term' = 'Classless Inter-Domain Routing (CIDR) Block');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `default_lease_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Default Lease Duration Hours');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `encapsulation_type` SET TAGS ('dbx_business_glossary_term' = 'Encapsulation Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `encapsulation_type` SET TAGS ('dbx_value_regex' = 'dot1q|qinq|vxlan|evpn|mpls|gre');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `high_watermark_threshold` SET TAGS ('dbx_business_glossary_term' = 'High Watermark Threshold');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_version` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_version` SET TAGS ('dbx_value_regex' = 'ipv4|ipv6|dual_stack');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `is_cgnat_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Carrier-Grade Network Address Translation (CGNAT) Enabled');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `is_lawful_intercept_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Lawful Intercept Enabled');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `is_public_routable` SET TAGS ('dbx_business_glossary_term' = 'Is Public Routable');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `last_assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Assignment Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `last_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Release Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `low_watermark_threshold` SET TAGS ('dbx_business_glossary_term' = 'Low Watermark Threshold');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `pool_code` SET TAGS ('dbx_business_glossary_term' = 'Pool Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `pool_name` SET TAGS ('dbx_business_glossary_term' = 'Pool Name');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `pool_owner` SET TAGS ('dbx_business_glossary_term' = 'Pool Owner');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_business_glossary_term' = 'Pool Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_value_regex' = 'active|reserved|depleted|retired|quarantined|planned');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'public|lawful_intercept_required|emergency_services|critical_infrastructure');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `reserved_count` SET TAGS ('dbx_business_glossary_term' = 'Reserved Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'ipv4_subnet|ipv6_subnet|vlan_range|vxlan_range|cgnat_pool|dhcp_scope');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `routing_domain` SET TAGS ('dbx_business_glossary_term' = 'Routing Domain');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `total_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `vlan_range_end` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) Range End');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `vlan_range_start` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) Range Start');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Subscriber Integrated Services Digital Network (MSISDN) Range Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Range Activation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `allocation_authority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Authority');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Range Allocation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `assigned_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Number Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `available_count` SET TAGS ('dbx_business_glossary_term' = 'Available Number Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `block_size` SET TAGS ('dbx_business_glossary_term' = 'Number Block Size');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `cost_per_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `cost_per_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `end_number` SET TAGS ('dbx_business_glossary_term' = 'Range End Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `end_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8,15}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Range Expiration Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `hlr_reference` SET TAGS ('dbx_business_glossary_term' = 'Home Location Register (HLR) Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `last_assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Assignment Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `last_deallocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Deallocation Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Destination Code (NDC)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{1,5}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `network_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Network Operator Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `network_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Range Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `number_format_mask` SET TAGS ('dbx_business_glossary_term' = 'Number Format Mask');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `porting_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `quarantine_period_days` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Period in Days');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `quarantined_count` SET TAGS ('dbx_business_glossary_term' = 'Quarantined Number Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `range_code` SET TAGS ('dbx_business_glossary_term' = 'Number Range Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `range_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `range_status` SET TAGS ('dbx_business_glossary_term' = 'Number Range Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `range_status` SET TAGS ('dbx_value_regex' = 'allocated|active|reserved|quarantined|retired|pending_allocation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `range_type` SET TAGS ('dbx_business_glossary_term' = 'Number Range Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `range_type` SET TAGS ('dbx_value_regex' = 'msisdn|did|toll_free|premium|short_code|emergency');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `regulatory_allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Allocation Reference Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `reserved_count` SET TAGS ('dbx_business_glossary_term' = 'Reserved Number Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `routing_prefix` SET TAGS ('dbx_business_glossary_term' = 'Routing Prefix');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `routing_prefix` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type Classification');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'mobile|fixed_line|voip|iot|m2m|emergency');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `start_number` SET TAGS ('dbx_business_glossary_term' = 'Range Start Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `start_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8,15}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `total_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Range Capacity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `usage_category` SET TAGS ('dbx_business_glossary_term' = 'Usage Category');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `usage_category` SET TAGS ('dbx_value_regex' = 'consumer|business|government|wholesale|test');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Range Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Allocation Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Acquisition Method');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'auction|administrative_assignment|secondary_market|lease|merger_acquisition');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|reserved|expired|pending_renewal|surrendered|suspended');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `annual_license_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual License Fee in United States Dollars (USD)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `annual_license_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `assigned_ran_nodes_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Radio Access Network (RAN) Nodes Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `bandwidth_mhz` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth in Megahertz (MHz)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `coverage_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Obligation Deadline Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `coverage_obligation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Coverage Obligation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `deployment_priority` SET TAGS ('dbx_business_glossary_term' = 'Deployment Priority Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `deployment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `duplex_mode` SET TAGS ('dbx_business_glossary_term' = 'Duplex Mode');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `duplex_mode` SET TAGS ('dbx_value_regex' = 'FDD|TDD|SDL|SUL');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `emission_mask_designation` SET TAGS ('dbx_business_glossary_term' = 'Emission Mask Designation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `frequency_range_lower_mhz` SET TAGS ('dbx_business_glossary_term' = 'Lower Frequency Range in Megahertz (MHz)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `frequency_range_upper_mhz` SET TAGS ('dbx_business_glossary_term' = 'Upper Frequency Range in Megahertz (MHz)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `geographic_license_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic License Coverage Area');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `interference_coordination_zone` SET TAGS ('dbx_business_glossary_term' = 'Interference Coordination Zone');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `license_renewal_status` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `license_renewal_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|denied|in_review');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'exclusive|shared|unlicensed|light_licensed');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `maximum_eirp_dbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Effective Isotropic Radiated Power (EIRP) in dBm');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_band` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Frequency Band');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_band` SET TAGS ('dbx_value_regex' = '700MHz|800MHz|900MHz|1800MHz|2100MHz|2600MHz|3.5GHz|26GHz|28GHz|39GHz');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_efficiency_target` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Efficiency Target (bps/Hz)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_sharing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Sharing Arrangement Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_sharing_arrangement` SET TAGS ('dbx_value_regex' = 'none|CBRS|LSA|DSS|roaming_agreement');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `spectrum_trading_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Trading Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spectrum_allocation` ALTER COLUMN `technology_use` SET TAGS ('dbx_business_glossary_term' = 'Technology Use Designation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Last Issued Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `annual_consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Annual Consumption Quantity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `batch_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Tracking Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `compatible_equipment_models` SET TAGS ('dbx_business_glossary_term' = 'Compatible Equipment Models');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `current_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `last_purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_value_regex' = 'active|phasing_out|obsolete|discontinued');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Part Category');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Part Name');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `part_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Part Subcategory');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `replacement_part_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Part Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `serial_number_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Tracking Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_business_glossary_term' = 'Part Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|restricted');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`spare_part` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Related Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `actual_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not-required');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'procurement|deployment|swap|repair|decommission|write-off');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `expected_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New Asset State');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `new_state` SET TAGS ('dbx_value_regex' = 'in-stock|deployed|in-transit|in-repair|decommissioned|written-off');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_business_glossary_term' = 'Previous Asset State');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_value_regex' = 'in-stock|deployed|in-transit|in-repair|decommissioned|written-off');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `reconciliation_action` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Action');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `reconciliation_action` SET TAGS ('dbx_value_regex' = 'write-off|adjustment|investigation|no-action');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `exchange_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `administrative_status` SET TAGS ('dbx_business_glossary_term' = 'Administrative Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `administrative_status` SET TAGS ('dbx_value_regex' = 'UNLOCKED|LOCKED|SHUTTING_DOWN');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `climate_control_required` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Required Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `end_of_sale_date` SET TAGS ('dbx_business_glossary_term' = 'End of Sale (EOS) Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support (EOS) Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `equipment_subtype` SET TAGS ('dbx_business_glossary_term' = 'Equipment Subtype');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Category');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'RAN|CORE|TRANSPORT|ACCESS|POWER|CPE');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `frequency_bands` SET TAGS ('dbx_business_glossary_term' = 'Frequency Bands');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `hardware_revision` SET TAGS ('dbx_business_glossary_term' = 'Hardware Revision');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `hardware_revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{1,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hostname');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `hostname` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9][a-zA-Z0-9-.]{0,252}[a-zA-Z0-9]$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Management Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `max_power_draw_watts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Power Draw (Watts)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `network_function` SET TAGS ('dbx_business_glossary_term' = 'Network Function');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `operating_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature (Celsius)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `operating_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature (Celsius)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'IN_SERVICE|STANDBY|MAINTENANCE|FAULTY|DECOMMISSIONED|RESERVED');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `port_capacity_gbps` SET TAGS ('dbx_business_glossary_term' = 'Port Capacity (Gigabits per Second)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `port_count` SET TAGS ('dbx_business_glossary_term' = 'Port Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `power_draw_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Draw (Watts)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `rack_location` SET TAGS ('dbx_business_glossary_term' = 'Rack Location Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `rack_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `rack_unit_height` SET TAGS ('dbx_business_glossary_term' = 'Rack Unit (RU) Height');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `rack_unit_position` SET TAGS ('dbx_business_glossary_term' = 'Rack Unit (RU) Position');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `redundancy_role` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Role');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `redundancy_role` SET TAGS ('dbx_value_regex' = 'PRIMARY|SECONDARY|STANDALONE|N_PLUS_1');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `software_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?(-[A-Z0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `supported_standards` SET TAGS ('dbx_business_glossary_term' = 'Supported Technology Standards');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Presence (POP) Facility ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `parent_facility_pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Facility ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_value_regex' = 'ups|generator|battery|none|hybrid|solar');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_value_regex' = 'hvac|passive|none|precision_cooling|evaporative|hybrid');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `cooling_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Cooling Capacity (Tons)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `equipment_rack_count` SET TAGS ('dbx_business_glossary_term' = 'Equipment Rack Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `facility_subtype` SET TAGS ('dbx_business_glossary_term' = 'Facility Subtype');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'pop|central_office|data_center|headend|street_cabinet|cell_tower');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_value_regex' = 'sprinkler|gas|foam|none|water_mist|dry_chemical');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `floor_space_sqm` SET TAGS ('dbx_business_glossary_term' = 'Floor Space (Square Meters)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `max_stock_level_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Threshold');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `min_stock_level_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level Threshold');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `network_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Network Connectivity Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `next_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Cycle Count Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operates_24x7` SET TAGS ('dbx_business_glossary_term' = 'Operates 24x7 Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|maintenance|standby');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'owned|leased|colocation|licensed|shared');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `power_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity (Kilowatts)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `security_tier` SET TAGS ('dbx_business_glossary_term' = 'Security Tier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `security_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|basic|enhanced');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `storage_capacity_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Meters)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `supports_hazmat_storage` SET TAGS ('dbx_business_glossary_term' = 'Supports Hazardous Materials (HAZMAT) Storage Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`pop_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `fiber_strand_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Strand Assignment ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `rack_slot_port_id` SET TAGS ('dbx_business_glossary_term' = 'A End Rack Slot Port Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Strand Assignment ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Lessor Partner ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'A-End Location ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'A-End Equipment ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `spliced_from_fiber_strand_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'dark|lit|spare|maintenance|reserved|quarantined');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `fiber_mode` SET TAGS ('dbx_business_glossary_term' = 'Fiber Mode');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `fiber_type` SET TAGS ('dbx_business_glossary_term' = 'Fiber Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `fiber_type` SET TAGS ('dbx_value_regex' = 'single_mode|multi_mode|bend_insensitive');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'owned|leased|iru|swap|joint_build');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `measured_loss_db` SET TAGS ('dbx_business_glossary_term' = 'Measured Loss (Decibels)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `monthly_lease_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Lease Cost');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `monthly_lease_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `monthly_lease_revenue` SET TAGS ('dbx_business_glossary_term' = 'Monthly Lease Revenue');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `monthly_lease_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `optical_loss_budget_db` SET TAGS ('dbx_business_glossary_term' = 'Optical Loss Budget (Decibels)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'unprotected|1_plus_1|1_colon_1|1_colon_n|ring');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `reflectance_db` SET TAGS ('dbx_business_glossary_term' = 'Reflectance (Decibels)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `service_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Service Impact Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `service_impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `strand_color_code` SET TAGS ('dbx_business_glossary_term' = 'Strand Color Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `strand_number` SET TAGS ('dbx_business_glossary_term' = 'Strand Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `test_wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Test Wavelength (Nanometers)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Wavelength (Nanometers)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_strand_assignment` ALTER COLUMN `z_end_port_number` SET TAGS ('dbx_business_glossary_term' = 'Z-End Port Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `rack_slot_port_id` SET TAGS ('dbx_business_glossary_term' = 'Rack Slot Port Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Cable Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Presence (POP) Facility Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `remote_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Equipment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `parent_rack_slot_port_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `administrative_status` SET TAGS ('dbx_business_glossary_term' = 'Administrative Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `administrative_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|shutdown');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `bandwidth_allocation_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Allocation in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `circuit_code` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `fiber_type` SET TAGS ('dbx_business_glossary_term' = 'Fiber Optic Cable Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `fiber_type` SET TAGS ('dbx_value_regex' = 'singlemode|multimode_om1|multimode_om2|multimode_om3|multimode_om4|multimode_om5');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `max_cable_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cable Distance in Meters');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Port Occupancy Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'occupied|vacant|reserved|quarantined');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|maintenance|failed|reserved');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `poe_power_budget_watts` SET TAGS ('dbx_business_glossary_term' = 'Power over Ethernet (PoE) Power Budget in Watts');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_duplex_mode` SET TAGS ('dbx_business_glossary_term' = 'Port Duplex Mode');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_duplex_mode` SET TAGS ('dbx_value_regex' = 'full|half|auto');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_function` SET TAGS ('dbx_business_glossary_term' = 'Port Network Function');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_identifier` SET TAGS ('dbx_business_glossary_term' = 'Port Identifier Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_label` SET TAGS ('dbx_business_glossary_term' = 'Port Physical Label');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_number` SET TAGS ('dbx_business_glossary_term' = 'Port Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Port Speed in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `port_type` SET TAGS ('dbx_business_glossary_term' = 'Port Physical Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `power_over_ethernet_capable` SET TAGS ('dbx_business_glossary_term' = 'Power over Ethernet (PoE) Capable Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'none|one_plus_one|one_colon_one|one_colon_n|ring|mesh');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `quality_of_service_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `rack_position` SET TAGS ('dbx_business_glossary_term' = 'Rack Position Code');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `rack_unit_height` SET TAGS ('dbx_business_glossary_term' = 'Rack Unit (RU) Height');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `rack_unit_start` SET TAGS ('dbx_business_glossary_term' = 'Rack Unit (RU) Start Position');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `redundancy_group` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Group Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `remote_port_identifier` SET TAGS ('dbx_business_glossary_term' = 'Remote Port Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `slot_number` SET TAGS ('dbx_business_glossary_term' = 'Chassis Slot Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `snmp_index` SET TAGS ('dbx_business_glossary_term' = 'Simple Network Management Protocol (SNMP) Interface Index');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `transceiver_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Transceiver Serial Number');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `transceiver_type` SET TAGS ('dbx_business_glossary_term' = 'Optical Transceiver Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`rack_slot_port` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Optical Wavelength in Nanometers (nm)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` SET TAGS ('dbx_subdomain' = 'service_agreements');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` SET TAGS ('dbx_association_edges' = 'inventory.fiber_cable,interconnect.interconnect_carrier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `fiber_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Lease Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Lease - Interconnect Carrier Id');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Lease - Fiber Cable Id');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `circuit_capacity_gbps` SET TAGS ('dbx_business_glossary_term' = 'Leased Circuit Capacity');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Reference');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lease Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `fiber_count_allocated` SET TAGS ('dbx_business_glossary_term' = 'Allocated Fiber Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lease Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Fiber Lease Type');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility Assignment');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `monthly_lease_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Lease Fee');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Lease Settlement Currency');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_lease` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Tier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` SET TAGS ('dbx_subdomain' = 'service_agreements');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` SET TAGS ('dbx_association_edges' = 'inventory.network_equipment,enterprise.managed_service');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `service_equipment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Equipment Assignment ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Equipment Assignment - Managed Service Id');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Equipment Assignment - Network Equipment Id');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Activation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `primary_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Backup Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `redundancy_role` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Role');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `role_in_service` SET TAGS ('dbx_business_glossary_term' = 'Equipment Role in Service');
ALTER TABLE `telecommunication_ecm`.`inventory`.`service_equipment_assignment` ALTER COLUMN `traffic_percentage` SET TAGS ('dbx_business_glossary_term' = 'Traffic Percentage Allocation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` SET TAGS ('dbx_subdomain' = 'service_agreements');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` SET TAGS ('dbx_association_edges' = 'inventory.pop_facility,partner.partner');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `colocation_id` SET TAGS ('dbx_business_glossary_term' = 'Colocation Agreement Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Colocation - Partner Id');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Colocation - Pop Facility Id');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Partner Access Level');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `circuit_count` SET TAGS ('dbx_business_glossary_term' = 'Circuit Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `colocation_status` SET TAGS ('dbx_business_glossary_term' = 'Colocation Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Colocation Contract End Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Colocation Contract Start Date');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `monthly_colocation_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Colocation Fee');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `monthly_colocation_fee` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `power_allocation_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Allocation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `rack_space_allocated_units` SET TAGS ('dbx_business_glossary_term' = 'Rack Space Allocation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`colocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`splice_closure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`splice_closure` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`splice_closure` ALTER COLUMN `splice_closure_id` SET TAGS ('dbx_business_glossary_term' = 'Splice Closure Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`splice_closure` ALTER COLUMN `upstream_splice_closure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`splice_closure` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` SET TAGS ('dbx_subdomain' = 'network_assets');
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ALTER COLUMN `circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ALTER COLUMN `end_location_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`circuit` ALTER COLUMN `start_location_location_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `renewed_from_maintenance_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`maintenance_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
