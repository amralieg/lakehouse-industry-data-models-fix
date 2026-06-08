-- Schema for Domain: inventory | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`inventory` COMMENT 'SSOT for physical and logical resource inventory including CPE, SIM/eSIM stock, ONT/OLT hardware, fiber infrastructure, spare parts, IP address pools, MSISDN/DID number ranges, spectrum allocations, and OSP/ISP asset tracking. Managed via Oracle OSM resource inventory and Netcracker.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` (
    `cpe_asset_id` BIGINT COMMENT 'Primary key for cpe_asset',
    `address_id` BIGINT COMMENT 'Identifier of the physical address where the CPE device is currently installed. Null if device is in warehouse.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: CPE devices are procured based on catalog item SKUs. Links physical inventory to product catalog for cost tracking, procurement planning, warranty management, and asset lifecycle reporting. Essential ',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: CPE assets (ONTs, routers, set-top boxes) are physical instances of device models from product catalog. Essential for warranty tracking, firmware update management, inventory valuation, and compatibil',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: CPE installation at customer premises is performed by field technicians. Tracking installer supports customer satisfaction analysis, first-time-fix rate calculation, and technician performance evaluat',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: CPE assets are assigned IP addresses from managed IP address pools. cpe_asset.ip_address: STRING stores the specific assigned IP (execution-specific value, retained), but the pool from which it was as',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: CPE assets are deployed as part of a specific service offering (fiber broadband, cable internet). The offering determines the CPE configuration profile, bandwidth parameters, and SLA tier applied duri',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: In FTTH/GPON deployments, CPE devices (routers, set-top boxes) connect directly behind ONT devices at the customer premises. Tracking which ONT a CPE is connected to is essential for physical topology',
    `partner_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the CPE device was procured.',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: CPE assets are staged at depots before technician pickup and installation, and returned to depots after retrieval. Depot-level CPE inventory tracking is essential for telecom field logistics, stock re',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber to whom this CPE device is currently assigned. Null if device is unassigned.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: CPE devices are procured under specific partner supply agreements governing pricing, warranty terms, and return conditions. Telecom procurement and warranty management processes require linking each C',
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
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: SIM stock is physically stored at and distributed from depots to technicians and retail channels. Depot-level SIM inventory tracking is a core telecom logistics process for stock replenishment, alloca',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Lawful intercept orders target specific IMSI/ICCID identifiers for surveillance. LEA compliance requires linking intercept orders to physical SIM inventory for provisioning intercept capabilities, mai',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: SIM cards are assigned MSISDN numbers from managed number ranges. The msisdn_range tracks blocks of numbers allocated from regulatory authorities. Linking sim_stock to msisdn_range enables tracking of',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MVNO SIM provisioning requires knowing which MVNO profile each SIM card belongs to. Telecom operators allocate SIM batches to specific MVNO profiles for IMSI/MSISDN range assignment and profile-based ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: SIM stock is provisioned and activated against a specific product offering (prepaid, postpaid, IoT plan). Telecom operators must track which offering a SIM batch is allocated to for provisioning autom',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: SIM stock is procured from and allocated to MVNO/supplier partners. Partner SIM allocation tracking and supplier reconciliation reports require this FK. supplier_name is a denormalized text representa',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber to whom this SIM stock unit is assigned. Null if the SIM is unallocated or reserved.',
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
    `unit_cost` DECIMAL(18,2) COMMENT 'Per-unit cost of the SIM card or eSIM profile in the operators base currency. Used for inventory valuation and CAPEX tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SIM stock record was last modified in the inventory system. Audit trail for record changes.',
    CONSTRAINT pk_sim_stock PRIMARY KEY(`sim_stock_id`)
) COMMENT 'Master inventory record for all SIM stock units including physical SIM cards (2FF/3FF/4FF) and eSIM profiles managed on the operators SM-DP+ platform. Physical SIM attributes: ICCID, IMSI range, batch number, manufacturer, form factor, warehouse location, and expiry date. eSIM profile attributes: EID (eUICC Identifier), profile ICCID, SM-DP+ profile state (downloaded/enabled/disabled/deleted), activation code, download timestamp, target device model, and profile type (operational/test/bootstrap). Common attributes: profile type (consumer/M2M/IoT), activation status (unallocated/reserved/activated/deactivated), subscriber assignment, and lifecycle timestamps. SSOT for all SIM and eSIM inventory managed per GSMA SGP.22 RSP specification via Netcracker resource inventory and Comverse ONE.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`ont_asset` (
    `ont_asset_id` BIGINT COMMENT 'Unique identifier for the ONT hardware asset record. Primary key for the ONT asset inventory.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: ONTs (Huawei MA5671, Nokia G-010S-A) are specific device models. Essential for firmware update campaigns, compatibility management with OLTs, spare parts planning, and end-of-life migration planning i',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: ONT installation at customer premises is performed by field technicians. Tracking installer supports quality control, first-time-fix metrics, warranty claims, and technician performance evaluation—sta',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: ONT assets require management IP addresses for remote configuration, monitoring, and firmware updates. These management IPs are assigned from specific IP address pools (typically a dedicated managemen',
    `network_equipment_id` BIGINT COMMENT 'Internal equipment identifier used in OSS/BSS systems for asset tracking and service provisioning workflows.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: ONT assets are provisioned with bandwidth profiles and QoS parameters driven by the specific fiber broadband offering subscribed. Telecom provisioning systems require this link to apply correct downst',
    `olt_asset_id` BIGINT COMMENT 'Reference to the parent OLT device to which this ONT is connected in the GPON/FTTH network topology.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: ONT devices are supplied by vendor partners. Business processes: warranty claim processing, RMA management, supplier performance tracking, spare parts procurement. Vendor_name denormalized; proper FK ',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: ONT assets are physically staged at depots before field deployment and returned post-decommission. Telecom fiber operations require depot-level ONT stock visibility for dispatch planning and inventory',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber account currently using services through this ONT device.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: ONT devices are procured from partners under supply agreements. Fiber broadband operations require linking ONT assets to their supply/maintenance agreements for warranty management, partner performanc',
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
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: OLTs are network equipment with specific models (Huawei MA5800, Nokia ISAM). Links to product catalog for lifecycle management, capacity planning, firmware updates, and end-of-support tracking in acce',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: OLT commissioning requires specialized technicians with fiber optic and network equipment certifications. Tracking installer is critical for commissioning records, accountability, and skill validation',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: OLT assets have management IP addresses (management_ip_address: STRING) used for NMS connectivity, SNMP monitoring, and remote management. These IPs are assigned from managed IP address pools. Adding ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: OLT assets have maintenance_contract_code (denormalized text) indicating a partner maintenance agreement exists. Linking to partner.agreement enables maintenance SLA enforcement, contract renewal trac',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: OLT assets are covered by vendor maintenance SLA contracts with MTTR guarantees critical for fiber network reliability. Linking olt_asset to sla_contract supports vendor SLA breach tracking, maintenan',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: OLT assets are managed and maintained from specific regional depots. Telecom network operations require knowing which depot is responsible for OLT maintenance scheduling, spare parts provisioning, and',
    `parent_olt_asset_id` BIGINT COMMENT 'Reference to the backup or standby OLT asset configured for failover protection of this primary OLT.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: OLT equipment has vendor relationships for maintenance contracts and technical support. Business processes: maintenance contract tracking via maintenance_contract_id, vendor SLA compliance measurement',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: OLT deployment in network facilities requires regulatory filings (environmental impact, facility permits, municipal approvals). Telecom operators must track which regulatory filing authorized each OLT',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Fiber cable deployments are governed by partner agreements (IRU — Indefeasible Right of Use agreements, co-deployment contracts, maintenance agreements). Telecom infrastructure teams require this link',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: Fiber cable reels and segments are stored at depots before deployment. Telecom field operations require depot-level fiber cable inventory visibility for project planning, dispatch logistics, and mater',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Fiber cable deployment is performed by specialized outside plant technicians. Tracking installer supports quality control, maintenance history, and accountability for cable performance issues—essentia',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: Fiber cable segments in GPON/FTTH networks feed into OLT assets at the central office or headend. Tracking which OLT a fiber cable segment terminates at is essential for physical plant management, cap',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Fiber infrastructure involves construction partners, joint build agreements, IRU arrangements. Business processes: shared infrastructure billing, right-of-way partner coordination, joint ownership tra',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` (
    `ip_address_pool_id` BIGINT COMMENT 'Unique identifier for the IP address pool resource. Primary key for the pool entity.',
    `element_id` BIGINT COMMENT 'Reference to the network device managing this pool (BNG, BRAS, leaf switch, DHCP server). Links pool to physical infrastructure.',
    `parent_pool_ip_address_pool_id` BIGINT COMMENT 'Reference to parent pool if this is a sub-pool carved from a larger allocation. Enables hierarchical pool management and delegation.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: IP address pools are allocated to MVNO and wholesale partners for their subscriber base. Telecom IP address management and MVNO wholesale operations require tracking which partner owns or is allocated',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: LI-enabled IP pools (is_lawful_intercept_enabled=true) and CGNAT pools are governed by specific regulatory obligations (CALEA, data retention mandates). Compliance teams must track which regulatory ob',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: MSISDN ranges are allocated to specific carriers/operators for regulatory and routing purposes. MNP operations, roaming routing, and number range audits require knowing which interconnect.carrier owns',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: msisdn_range.hlr_reference: STRING is a denormalized string reference to the HLR (Home Location Register) or HSS (Home Subscriber Server) network equipment node that routes calls/data for numbers in t',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: MSISDN ranges allocated to MVNO partners for their subscriber base. Critical business processes: wholesale number allocation, MVNO billing, number portability coordination, regulatory compliance repor',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: MSISDN number ranges are allocated by national regulatory authorities via formal filings. The existing regulatory_allocation_reference plain-text field is a denormalization of the regulatory filing re',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` (
    `asset_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the asset lifecycle event record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Asset lifecycle events (decommissioning, write-offs, major state changes) are frequently triggered by compliance audit findings. The existing audit_date and auditor_name plain attributes are denormali',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: asset_lifecycle_event tracks all lifecycle state transitions for every asset type in the inventory domain. The existing asset_reference: BIGINT is a polymorphic column with asset_category as discrimin',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: Asset lifecycle events (goods receipt, transfer, audit, decommission) occur at specific depots. Telecom warehouse operations require depot attribution on lifecycle events for audit trails, inter-depot',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Typed FK from asset_lifecycle_event to fiber_cable. Fiber cable lifecycle events (installation, inspection, splice repair, conduit damage, decommission) must link directly to the fiber cable record. P',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the customer order or internal order that triggered this lifecycle event (e.g., service activation order, equipment procurement order). Nullable for non-order-driven events.',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Typed FK from asset_lifecycle_event to ip_address_pool. IP address pools are logical inventory assets that undergo lifecycle transitions (creation, exhaustion alerts, CGNAT enablement, decommission, p',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: Typed FK from asset_lifecycle_event to msisdn_range. MSISDN/DID number ranges are logical inventory assets that undergo lifecycle transitions (allocation from regulator, activation, quarantine, expira',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Typed FK from asset_lifecycle_event to network_equipment. Network equipment lifecycle events (installation, hardware swap, end-of-life, audit) must link directly to the network equipment record. This ',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Bulk asset replacements and emergency deployments during major NOC incidents must be linked to the incident record for cost tracking, post-incident review, and regulatory reporting of infrastructure c',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: Typed FK from asset_lifecycle_event to olt_asset. OLT lifecycle events (commissioning, maintenance, firmware upgrade, decommission) must link directly to the OLT asset record. Part of the normalizatio',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Typed FK from asset_lifecycle_event to ont_asset. ONT lifecycle events (installation, firmware update, decommission, optical power audit) must link directly to the ONT asset record. Part of the normal',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Asset replacements performed during outage restoration (e.g., emergency OLT swap, fiber splice) must link to the outage record for restoration cost tracking, post-outage review, and regulatory reporti',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Asset lifecycle events (installation, maintenance, decommission) are frequently executed by or attributed to specific partners. Partner SLA performance reporting and partner-specific asset lifecycle a',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: ITIL problem management permanent fixes often involve asset changes (firmware upgrades, hardware replacement). Linking asset_lifecycle_event to problem_record supports tracking which asset changes wer',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: RAN cell commissioning, decommissioning, hardware swap, and software upgrade events are tracked as asset lifecycle events. Telecom field operations teams record RAN cell state transitions (installed, ',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Typed FK from asset_lifecycle_event to sim_stock, replacing the polymorphic asset_reference pattern. SIM stock lifecycle events (activation, deactivation, profile download, quarantine) must be traceab',
    `technician_id` BIGINT COMMENT 'Reference to the field technician or workforce member who performed the lifecycle event (deployment, swap, repair). Nullable for automated or non-field events.',
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to assurance.alarm_event. Business justification: Asset state changes (decommission, replacement, emergency swap) are often triggered by specific alarm events. Linking asset_lifecycle_event to alarm_event supports tracing asset decisions back to the ',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: When event_type=FAILURE or RETURN, links asset failure events to originating trouble tickets for root cause analysis, warranty claim substantiation, and vendor quality scorecards.',
    `work_order_id` BIGINT COMMENT 'Reference to the field service work order that triggered this lifecycle event (e.g., installation, repair, swap work order). Nullable for non-field-service events.',
    `actual_count` STRING COMMENT 'Actual quantity of assets found during the physical audit or cycle count. Applicable only for audit and reconciliation events.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether this lifecycle event required managerial or system approval before execution (e.g., write-off events typically require approval). True if approval was required, False otherwise.',
    `approval_status` STRING COMMENT 'Current approval status for this lifecycle event. Applicable only if approval_required is True.. Valid values are `pending|approved|rejected|not-required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event was approved. Nullable if approval was not required or is still pending. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `asset_category` STRING COMMENT 'Category or class of the asset involved in this event (e.g., CPE, ONT, OLT, fiber-cable, spare-part). Used for audit and reporting segmentation. [ENUM-REF-CANDIDATE: CPE|ONT|OLT|fiber-cable|network-equipment|spare-part|SIM|eSIM|test-equipment|tools — promote to reference product]',
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
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: Network equipment is staged, stored, and dispatched from specific depots. Telecom field ops and inventory audits require knowing which depot manages each piece of network equipment for logistics plann',
    `device_model_id` BIGINT COMMENT 'Reference to the equipment model catalog entry defining technical specifications, manufacturer, and capabilities.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Network equipment installation requires certified technicians. Tracking installer enables asset lifecycle accountability, warranty validation, and technician performance tracking—standard practice in ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Network equipment is covered by specific partner maintenance agreements (hardware support contracts). Telecom operations teams track which agreement governs each equipments maintenance SLA, warranty ',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Network equipment is covered by vendor maintenance SLA contracts (MTTR guarantees, spare parts availability). Linking network_equipment to sla_contract supports vendor SLA compliance monitoring, maint',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Network equipment has vendor relationships for support contracts, firmware updates, technical support. Business processes: maintenance contract management via maintenance_contract_id, vendor SLA track',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Network equipment deployment (base stations, towers, data center gear) requires regulatory filings for site permits, environmental compliance, and zoning approvals. Telecom compliance teams must link ',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Radio network equipment (base stations, RAN nodes) must operate under a valid spectrum license. Regulators require operators to demonstrate each transmitting network element is covered by an active sp',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ADD CONSTRAINT `fk_inventory_cpe_asset_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ADD CONSTRAINT `fk_inventory_sim_stock_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ADD CONSTRAINT `fk_inventory_ont_asset_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ADD CONSTRAINT `fk_inventory_olt_asset_parent_olt_asset_id` FOREIGN KEY (`parent_olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ADD CONSTRAINT `fk_inventory_fiber_cable_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ADD CONSTRAINT `fk_inventory_ip_address_pool_parent_pool_ip_address_pool_id` FOREIGN KEY (`parent_pool_ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ADD CONSTRAINT `fk_inventory_msisdn_range_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_cpe_asset_id` FOREIGN KEY (`cpe_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`cpe_asset`(`cpe_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_fiber_cable_id` FOREIGN KEY (`fiber_cable_id`) REFERENCES `telecommunication_ecm`.`inventory`.`fiber_cable`(`fiber_cable_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_ip_address_pool_id` FOREIGN KEY (`ip_address_pool_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ip_address_pool`(`ip_address_pool_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_msisdn_range_id` FOREIGN KEY (`msisdn_range_id`) REFERENCES `telecommunication_ecm`.`inventory`.`msisdn_range`(`msisdn_range_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_network_equipment_id` FOREIGN KEY (`network_equipment_id`) REFERENCES `telecommunication_ecm`.`inventory`.`network_equipment`(`network_equipment_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_olt_asset_id` FOREIGN KEY (`olt_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`olt_asset`(`olt_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_ont_asset_id` FOREIGN KEY (`ont_asset_id`) REFERENCES `telecommunication_ecm`.`inventory`.`ont_asset`(`ont_asset_id`);
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ADD CONSTRAINT `fk_inventory_asset_lifecycle_event_sim_stock_id` FOREIGN KEY (`sim_stock_id`) REFERENCES `telecommunication_ecm`.`inventory`.`sim_stock`(`sim_stock_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` SET TAGS ('dbx_subdomain' = 'customer_equipment');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Address ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`cpe_asset` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` SET TAGS ('dbx_subdomain' = 'customer_equipment');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'SIM Stock ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`sim_stock` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` SET TAGS ('dbx_subdomain' = 'customer_equipment');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Network Terminal (ONT) Asset ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Device ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ont_asset` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Asset ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Managing Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `parent_olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Optical Line Terminal (OLT) Asset ID');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`olt_asset` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`fiber_cable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Pool Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `parent_pool_ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Pool Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `parent_pool_ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `parent_pool_ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`ip_address_pool` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Subscriber Integrated Services Digital Network (MSISDN) Range Identifier');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Hlr Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`msisdn_range` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` SET TAGS ('dbx_subdomain' = 'customer_equipment');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Alarm Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Related Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `actual_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Count');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not-required');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`inventory`.`asset_lifecycle_event` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
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
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`inventory`.`network_equipment` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
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
